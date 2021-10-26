local FISH_DATA = require("prefabs/oceanfishdef1")

local SWIMMING_COLLISION_MASK   = COLLISION.GROUND
								+ COLLISION.LAND_OCEAN_LIMITS
								+ COLLISION.OBSTACLES
								+ COLLISION.SMALLOBSTACLES
local PROJECTILE_COLLISION_MASK = COLLISION.GROUND

local function CalcNewSize()
	return math.random()
end

local brain = require "brains/oceanfishbrain"

local function flopsoundcheck(inst)
	if inst.AnimState:IsCurrentAnimation("flop_loop") then 
		inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishland") 
	end
end

local function Flop(inst)
if inst.oceanbuild ~= nil then
	local num = math.random(3)
	inst.Transform:SetTwoFaced()
    inst.AnimState:SetBank(inst.build)
    inst.AnimState:SetBuild(inst.build)	
	inst.AnimState:PushAnimation("idle", false)
	for i = 1, num do
	inst.Transform:SetTwoFaced()
    inst.AnimState:SetBank(inst.build)
    inst.AnimState:SetBuild(inst.build)	
	inst.AnimState:PushAnimation("idle", false)
	end
	inst.flop_task = inst:DoTaskInTime(math.random() + 2 + 0.5*num, Flop)
else	
	if inst.flopsnd1 then inst.flopsnd1:Cancel() inst.flopsnd1 = nil end
	if inst.flopsnd2 then inst.flopsnd2:Cancel() inst.flopsnd2 = nil end
	if inst.flopsnd3 then inst.flopsnd3:Cancel() inst.flopsnd3 = nil end
	if inst.flopsnd4 then inst.flopsnd4:Cancel() inst.flopsnd4 = nil end
	
	inst.AnimState:PushAnimation("flop_pre", false)
	local num = math.random(3)
	inst.AnimState:PushAnimation("flop_loop", false)
	for i = 1, num do
		inst.AnimState:PushAnimation("flop_loop", false)
	end
	inst.AnimState:PushAnimation("flop_pst", false)
	
	inst.flopsnd1 = inst:DoTaskInTime((5+9)*FRAMES, function() flopsoundcheck(inst) end)
	inst.flopsnd2 = inst:DoTaskInTime((5+9+13)*FRAMES, function() flopsoundcheck(inst) end)
	inst.flopsnd3 = inst:DoTaskInTime((5+9+26)*FRAMES, function() flopsoundcheck(inst) end)
	inst.flopsnd4 = inst:DoTaskInTime((5+9+39)*FRAMES, function() flopsoundcheck(inst) end)	

	inst.flop_task = inst:DoTaskInTime(math.random() + 2 + 0.5*num, Flop)
end
end

local function OnInventoryLanded(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	if TheWorld.Map:IsPassableAtPoint(x, y, z) then
		if inst.flop_task ~= nil then
			inst.flop_task:Cancel()
		end
		inst.flop_task = inst:DoTaskInTime(math.random() + 2 + 0.5*math.random(3), Flop)
	else
		local fish = SpawnPrefab(inst.fish_def.prefab)
		fish.Transform:SetPosition(x, y, z)
		fish.Transform:SetRotation(inst.Transform:GetRotation())
		fish.leaving = true
		fish.persists = false

		SpawnPrefab("splash").Transform:SetPosition(x, y, z)

		inst:Remove()
	end
end

local function onpickup(inst)
	if inst.flop_task ~= nil then
		inst.flop_task:Cancel()
		inst.flop_task = nil
	end
end

local function OnProjectileLand(inst)
	local x, y, z = inst.Transform:GetWorldPosition()

	local land_in_water = not TheWorld.Map:IsPassableAtPoint(x, y, z)
	if land_in_water then
	    inst:RemoveComponent("complexprojectile")
		inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
		inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
		inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)
		if inst.Light ~= nil then
			inst.Light:Enable(false)
		end
		if inst.components.weighable ~= nil then
			inst.components.weighable:SetPlayerAsOwner(nil)
		end
		inst.leaving = true
		inst.persists = false
		inst.sg:GoToState("idle")
		inst:RestartBrain()
	    SpawnPrefab("splash").Transform:SetPosition(x, y, z)
	else
		local fish = SpawnPrefab(inst.fish_def.prefab.."_inv")
		fish.Transform:SetPosition(x, y, z)
		fish.Transform:SetRotation(inst.Transform:GetRotation())
		fish.components.inventoryitem:SetLanded(true, false)
		if fish.flop_task then
			fish.flop_task:Cancel()
		end
		Flop(fish)
		if inst.components.oceanfishable ~= nil and fish.components.weighable ~= nil then
			fish.components.weighable:CopyWeighable(inst.components.weighable)
			inst.components.weighable:SetPlayerAsOwner(nil)
		end

	    inst:Remove()
	end
end

local function OnMakeProjectile(inst)
    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetOnHit(OnProjectileLand)

	inst:StopBrain()
	inst.sg:GoToState("launched_out_of_water")

	inst.Physics:SetCollisionMask(PROJECTILE_COLLISION_MASK)

    inst.AnimState:SetSortOrder(0)
    inst.AnimState:SetLayer(LAYER_WORLD)
	if inst.Light ~= nil then
		inst.Light:Enable(true)
	end

    SpawnPrefab("splash").Transform:SetPosition(inst.Transform:GetWorldPosition())

	return inst
end

local function OnTimerDone(inst, data)
	if data ~= nil and data.name == "lifespan" then
		if inst.components.oceanfishable:GetRod() == nil then
			inst:RemoveComponent("oceanfishable")
			inst.sg:GoToState("leave")
		else
			inst.components.timer:StartTimer("lifespan", 30)
		end
	end
end

local function OnReelingIn(inst, doer)
	if inst:HasTag("partiallyhooked") then
		-- now fully hooked!
		inst:RemoveTag("partiallyhooked")
		inst.components.oceanfishable:ResetStruggling()
        if inst.components.homeseeker ~= nil
                and inst.components.homeseeker.home ~= nil
                and inst.components.homeseeker.home:IsValid()
                and inst.components.homeseeker.home.prefab == "oceanfish_shoalspawner" then
            TheWorld:PushEvent("ms_shoalfishhooked", inst.components.homeseeker.home)
        end
	end
end

local function OnSetRod(inst, rod)
	if rod ~= nil then
		inst:AddTag("partiallyhooked")
		inst:AddTag("scarytooceanprey")
	else
		inst:RemoveTag("partiallyhooked")
		inst:RemoveTag("scarytooceanprey")
	end
end

local function ondroppedasloot(inst, data)
	if data ~= nil and data.dropper ~= nil then
		inst.components.weighable.prefab_override_owner = data.dropper.prefab
	end
end

local function HandleEntitySleep(inst)
	local home = inst.components.homeseeker and inst.components.homeseeker.home or nil
	if home ~= nil and home:IsValid() and not inst.leaving and inst.persists then
		home.components.childspawner:GoHome(inst)
	else
		inst:Remove()
	end
	inst.remove_task = nil
end

local function topocket(inst)
	if inst.components.propagator ~= nil then
	    inst.components.propagator:StopSpreading()
	end
end

local function toground(inst)
	if inst.components.propagator ~= nil then
	    inst.components.propagator:StartSpreading()
	end
end

local function OnEntityWake(inst)
	if inst.remove_task ~= nil then
		inst.remove_task:Cancel()
		inst.remove_task = nil
	end
end

local function OnEntitySleep(inst)
	if not POPULATING then
		inst.remove_task = inst:DoTaskInTime(.1, HandleEntitySleep)
	end
end

local function OnSave(inst, data)
	if inst.components.herdmember.herdprefab then
    	data.herdprefab = inst.components.herdmember.herdprefab
    end
    if inst.heavy then
    	data.heavy = true
    end	
end

local function OnLoad(inst, data)
    if data ~= nil and data.herdprefab ~= nil then
        inst.components.herdmember.herdprefab = data.herdprefab
    end
    if data ~= nil and data.heavy then
    	inst.heavy = data.heavy
    end	
end

local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end

local function water_common(data)
   local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	if data.light ~= nil then
		inst.entity:AddLight()
		inst.Light:SetRadius(data.light.r)
		inst.Light:SetFalloff(data.light.f)
		inst.Light:SetIntensity(data.light.i)
		inst.Light:SetColour(unpack(data.light.c))
		inst.Light:Enable(false)
	end
	
	inst.entity:AddPhysics()
	
	inst.Transform:SetSixFaced()

    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
	inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
    inst.Physics:SetCapsule(0.5, 1)

    inst:AddTag("ignorewalkableplatforms")
	inst:AddTag("notarget")
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")
	inst:AddTag("oceanfishable")
	inst:AddTag("oceanfishinghookable")
	inst:AddTag("oceanfish")
	inst:AddTag("swimming")
	inst:AddTag("herd_"..data.prefab)
    inst:AddTag("ediblefish_"..data.fishtype)

	if data.oceanbuild then
	inst.build = data.build
	inst.oceanbank = "oceanfish_small"
	inst.oceanbuild = data.oceanbuild
	
	inst.AnimState:SetBank(inst.oceanbank)
	inst.AnimState:SetBuild(inst.oceanbuild)
    inst.AnimState:PlayAnimation("idle_loop")		
	else
	
    inst.AnimState:SetBank(data.bank)
    inst.AnimState:SetBuild(data.build)
    inst.AnimState:PlayAnimation("idle_loop")
	
	end

    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
    inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.fish_def = data

	--inst.leaving = nil

    inst:AddComponent("locomotor")
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.walkspeed = data and data.walkspeed or TUNING.OCEANFISH.WALKSPEED
    inst.components.locomotor.runspeed = data and data.runspeed or TUNING.OCEANFISH.RUNSPEED
	inst.components.locomotor.pathcaps = { allowocean = true, ignoreLand = true }

	inst:AddComponent("oceanfishable")
	inst.components.oceanfishable.makeprojectilefn = OnMakeProjectile
	inst.components.oceanfishable.onreelinginfn = OnReelingIn
	inst.components.oceanfishable.onsetrodfn = OnSetRod
	inst.components.oceanfishable:StrugglingSetup(inst.components.locomotor.walkspeed, inst.components.locomotor.runspeed, data.stamina or TUNING.OCEANFISH.FISHABLE_STAMINA)
	inst.components.oceanfishable.catch_distance = TUNING.OCEAN_FISHING.FISHING_CATCH_DIST
	
    inst:AddComponent("eater")
	if data and data.diet then
		inst.components.eater:SetDiet(data.diet.caneat or FOODGROUP.BERRIES_AND_SEEDS, data.diet.preferseating)
	else
		inst.components.eater:SetDiet(FOODGROUP.BERRIES_AND_SEEDS, FOODGROUP.BERRIES_AND_SEEDS)
	end

	inst:AddComponent("knownlocations")

	inst:AddComponent("timer")
	inst:ListenForEvent("timerdone", OnTimerDone)
	--inst.components.timer:StartTimer("lifespan", 30)

    inst:AddComponent("herdmember")
    inst.components.herdmember:Enable(false)
	
	inst:AddComponent("weighable")
	--inst.components.weighable.type = TROPHYSCALE_TYPES.FISH -- No need to set a weighable type, this is just here for data and will be copied over to the inventory item	
	inst.components.weighable:Initialize(inst.fish_def.weight_min, inst.fish_def.weight_max)
	inst.components.weighable:SetWeight(Lerp(inst.fish_def.weight_min, inst.fish_def.weight_max, CalcNewSize()))
	
	if data.oceanbuild then	
	require "stategraphs/SGoceanfishsw"
	inst:SetStateGraph("SGoceanfishsw")
	else
    inst:SetStateGraph("SGoceanfish")	
	end
	
	if data.golfinho then
	inst.AnimState:SetBank("ballphin")
	inst.AnimState:SetBuild("ballphin") 
	inst.Transform:SetFourFaced()	
	inst.AnimState:PlayAnimation("idle")
	require "stategraphs/SGballphinocean"
    inst:SetStateGraph("SGballphinocean")
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 30)		
	end
	
	if data.peixeespada then
	inst.AnimState:SetBank("swordfish")
	inst.AnimState:SetBuild("fish_swordfish") 
	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("fishmed", true)
	require "stategraphs/SGswordfishocean"
    inst:SetStateGraph("SGswordfishocean")
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 30)		
	end	
	
	if data.dogfish then
	inst.AnimState:SetBank("dogfish")
    inst.AnimState:SetBuild("fish_dogfish")
	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("fishmed", true)
	require "stategraphs/SGdogfishocean"
    inst:SetStateGraph("SGdogfishocean")
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 30)		
	end	
	
	if data.sharx then
	inst.AnimState:SetBank("sharx")
    inst.AnimState:SetBuild("sharx_build")
	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("run_water_loop", true)
	require "stategraphs/SGsharxocean"
    inst:SetStateGraph("SGsharxocean")
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 30)		
	end		
	
    inst:SetBrain(brain)

	inst.OnEntityWake = OnEntityWake
    inst.OnEntitySleep = OnEntitySleep

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end


local function ondropped(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground == GROUND.UNDERWATER_SANDY or ground == GROUND.UNDERWATER_ROCKY or (ground == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground == GROUND.PAINTED and TheWorld:HasTag("cave")) or (ground == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) then 

if inst.prefab == "oceanfish_medium_1_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_1")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_medium_2_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_2")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_medium_3_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_3")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_medium_4_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_4")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_medium_5_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_5")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_medium_6_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_6")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_medium_7_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_7")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_medium_8_inv" then
local novopeixe = SpawnPrefab("oceanfish_medium_underwater_8")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_1_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_1")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_2_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_2")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_3_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_3")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_4_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_4")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_5_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_5")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_6_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_6")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_7_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_7")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_8_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_8")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_9_inv" then
local novopeixe = SpawnPrefab("oceanfish_small_underwater_9")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_61_inv" then
local novopeixe = SpawnPrefab("fish2_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_71_inv" then
local novopeixe = SpawnPrefab("fish3_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_81_inv" then
local novopeixe = SpawnPrefab("fish4_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_91_inv" then
local novopeixe = SpawnPrefab("fish5_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_18_inv" then
local novopeixe = SpawnPrefab("fish6_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_17_inv" then
local novopeixe = SpawnPrefab("fish7_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_14_inv" then
local novopeixe = SpawnPrefab("goldfish_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_13_inv" then
local novopeixe = SpawnPrefab("mecfish_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

if inst.prefab == "oceanfish_small_11_inv" then
local novopeixe = SpawnPrefab("quagmire_salmom_alive")
if novopeixe then novopeixe.Transform:SetPosition(x, y, z) inst:Remove() end
end

end





if not TheWorld.Map:IsPassableAtPoint(x, y, z) then
local fish = SpawnPrefab(inst.fish_def.prefab)
if fish then
fish.Transform:SetPosition(x, y, z)
fish.Transform:SetRotation(inst.Transform:GetRotation())
fish.leaving = true
fish.persists = false
end

SpawnPrefab("splash").Transform:SetPosition(x, y, z)

inst:Remove()
end
end

local function inv_common(fish_def)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	
	if fish_def.light ~= nil then
		inst.entity:AddLight()
		inst.Light:SetRadius(fish_def.light.r)
		inst.Light:SetFalloff(fish_def.light.f)
		inst.Light:SetIntensity(fish_def.light.i)
		inst.Light:SetColour(unpack(fish_def.light.c))
	end
	
	if fish_def.dynamic_shadow then
	    inst.entity:AddDynamicShadow()
	end	
	
    inst.entity:AddNetwork()    
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)

	inst.Transform:SetTwoFaced()
	
	if fish_def.oceanbuild then
	inst.build = fish_def.build
	inst.oceanbank = "oceanfish_small"
	inst.oceanbuild = fish_def.oceanbuild	
	
	inst.Transform:SetTwoFaced()
    inst.AnimState:SetBank(inst.build)
    inst.AnimState:SetBuild(inst.build)
    inst.AnimState:PlayAnimation("idle")		
	else	
    inst.AnimState:SetBank(fish_def.bank)
    inst.AnimState:SetBuild(fish_def.build)
    inst.AnimState:PlayAnimation("flop_pst")
	end	

	if fish_def.tamanho then
	inst.Transform:SetScale(fish_def.tamanho, fish_def.tamanho, fish_def.tamanho)
	end
	
	if fish_def.dynamic_shadow then
	    inst.DynamicShadow:SetSize(fish_def.dynamic_shadow[1], fish_def.dynamic_shadow[2])
	end	
	
	inst:SetPrefabNameOverride(fish_def.prefab)

    --weighable_fish (from weighable component) added to pristine state for optimization
	inst:AddTag("weighable_fish")

	inst:AddTag("fish")
	inst:AddTag("oceanfish")
	inst:AddTag("catfood")
	inst:AddTag("smallcreature")
	inst:AddTag("smalloceancreature")	
	
	if fish_def.heater ~= nil then
		inst:AddTag("HASHEATER") --(from heater component) added to pristine state for optimization
	end	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst.fish_def = fish_def

	inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem:SetOnPutInInventoryFn(onpickup)
	inst.components.inventoryitem:SetOnDroppedFn(ondropped)	
	
	if fish_def.oceanbuild then	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	end
	   
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_ONE_DAY)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = fish_def.perish_product
	inst.components.perishable.ignorewentness = true
	
	inst:AddComponent("murderable")

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot(fish_def.loot)

    inst:AddComponent("edible")
	if fish_def.edible_values ~= nil then
		inst.components.edible.healthvalue = fish_def.edible_values.health or TUNING.HEALING_TINY
		inst.components.edible.hungervalue = fish_def.edible_values.hunger or TUNING.CALORIES_SMALL
		inst.components.edible.sanityvalue = fish_def.edible_values.sanity or 0
		inst.components.edible.foodtype = fish_def.edible_values.foodtype or FOODTYPE.MEAT
	else
		inst.components.edible.healthvalue = 0
		inst.components.edible.hungervalue = 0
		inst.components.edible.sanityvalue = 0
		inst.components.edible.foodtype = FOODTYPE.MEAT
	end
	if inst.components.edible.foodtype == FOODTYPE.MEAT then
		--edible.ismeat doesn't appear to actually be used anywhere, might not be necessary.
		inst.components.edible.ismeat = true
	end

	inst:AddComponent("weighable")
	inst.components.weighable.type = TROPHYSCALE_TYPES.FISH
	inst.components.weighable:Initialize(fish_def.weight_min, fish_def.weight_max)
	inst.components.weighable:SetWeight(Lerp(fish_def.weight_min, fish_def.weight_max, CalcNewSize()))
	
	inst:AddComponent("cookable")
	inst.components.cookable.product = fish_def.cooking_product

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT

	inst.flop_task = inst:DoTaskInTime(math.random() * 2 + 1, Flop)

	if fish_def.heater ~= nil then
		inst:AddComponent("heater")
		inst.components.heater.heat = fish_def.heater.heat
		inst.components.heater.heatfn = fish_def.heater.heatfn
		inst.components.heater.carriedheat = fish_def.heater.carriedheat
		inst.components.heater.carriedheatfn = fish_def.heater.carriedheatfn
	    inst.components.heater.carriedheatmultiplier = fish_def.heater.carriedheatmultiplier or 1

		if fish_def.heater.endothermic then
	        inst.components.heater:SetThermics(false, true)
		end
	end

	if fish_def.propagator ~= nil then
		inst:AddComponent("propagator")
		inst.components.propagator.propagaterange = fish_def.propagator.propagaterange
		inst.components.propagator.heatoutput = fish_def.propagator.heatoutput
		inst.components.propagator:StartSpreading()

		inst:ListenForEvent("onputininventory", topocket)
		inst:ListenForEvent("ondropped", toground)
	end

	MakeHauntableLaunchAndPerish(inst)

	inst:ListenForEvent("on_landed", OnInventoryLanded)
	inst:ListenForEvent("animover", function() 
		if inst.AnimState:IsCurrentAnimation("flop_loop") then 
			inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishland")
		end
	end)
	inst:ListenForEvent("on_loot_dropped", ondroppedasloot)

    return inst
end

local fish_prefabs = {}

local function MakeFish(data)
	local assets = { 
	
	Asset("ANIM", "anim/fish2.zip"),	
	Asset("ANIM", "anim/fish3.zip"),	
	Asset("ANIM", "anim/fish4.zip"),	
	Asset("ANIM", "anim/fish5.zip"),	
	Asset("ANIM", "anim/coi.zip"),		
	Asset("ANIM", "anim/salmon.zip"),			
	Asset("ANIM", "anim/ballphinocean.zip"),			
	Asset("ANIM", "anim/mecfish.zip"),	
	Asset("ANIM", "anim/goldfish.zip"),	
	Asset("ANIM", "anim/whaleblueocean.zip"),		
	Asset("ANIM", "anim/dogfishocean.zip"),	
	Asset("ANIM", "anim/fish7.zip"),		
	Asset("ANIM", "anim/fish6.zip"),		
	Asset("ANIM", "anim/swordfishjocean.zip"),	
	Asset("ANIM", "anim/swordfishjocean2.zip"),	
	Asset("ANIM", "anim/sharxocean.zip"),		
	Asset("ANIM", "anim/"..data.bank..".zip"), 
	
	Asset("ANIM", "anim/oceanfish_small.zip"),	
	Asset("ANIM", "anim/oceanfish_small_1.zip"),
	Asset("ANIM", "anim/oceanfish_small_2.zip"),
	Asset("ANIM", "anim/oceanfish_small_3.zip"),
	Asset("ANIM", "anim/oceanfish_small_4.zip"),
	Asset("ANIM", "anim/oceanfish_small_5.zip"),	
	Asset("ANIM", "anim/oceanfish_small_6.zip"),
	Asset("ANIM", "anim/oceanfish_small_7.zip"),
	Asset("ANIM", "anim/oceanfish_small_8.zip"),
	Asset("ANIM", "anim/oceanfish_small_9.zip"),	
	Asset("ANIM", "anim/oceanfish_medium.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_1.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_2.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_3.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_4.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_5.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_6.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_7.zip"),		
	Asset("ANIM", "anim/oceanfish_medium_8.zip"),		
	Asset("ANIM", "anim/fish_swordfish.zip"),	
	Asset("ANIM", "anim/fish_dogfish.zip"),
    Asset("ANIM", "anim/sharx.zip"),
	Asset("ANIM", "anim/sharx_build.zip"),
	Asset("ANIM", "anim/ballphin.zip"),	
	Asset("SCRIPT", "scripts/prefabs/oceanfishdef.lua"), 
	}


	if data.bank ~= data.build then 
		table.insert(assets, Asset("ANIM", "anim/"..data.build..".zip"))	
	end

	local prefabs = {
		data.prefab.."_inv", 
		"schoolherd_"..data.prefab,
		"spoiled_fish", 
		data.cooking_product,
	}
	ConcatArrays(prefabs, data.loot)
	ConcatArrays(prefabs, data.loot)

	table.insert(fish_prefabs, Prefab(data.prefab, function() return water_common(data) end, assets, prefabs))
	table.insert(fish_prefabs, Prefab(data.prefab.."_inv", function() return inv_common(data) end))
end

for _, fish_def in pairs(FISH_DATA.fish) do
	MakeFish(fish_def)
end

return unpack(fish_prefabs)