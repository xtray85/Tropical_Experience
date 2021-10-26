require "prefabutil"
require "stategraphs/SGpackim"

local assets =
{
    Asset("ANIM", "anim/ui_chester_shadow_3x4.zip"),
    Asset("ANIM", "anim/ui_chest_3x3.zip"),

	Asset("ANIM", "anim/packim.zip"),
	Asset("ANIM", "anim/packim_build.zip"),
	Asset("ANIM", "anim/packim_fat_build.zip"),
	Asset("ANIM", "anim/packim_fire_build.zip"),

    Asset("MINIMAP_IMAGE", "chester"),
    Asset("MINIMAP_IMAGE", "chestershadow"),
    Asset("MINIMAP_IMAGE", "chestersnow"),
}

local prefabs =
{
    "chester_eyebone",
    "chesterlight",
    "chester_transform_fx",
    "globalmapiconunderfog",
}

local brain = require "brains/packimbrain"



local sounds =
{
	close = "dontstarve_DLC002/creatures/packim/close",
	death = "dontstarve_DLC002/creatures/packim/death",
	hurt = "dontstarve_DLC002/creatures/packim/hurt",
	land = "dontstarve_DLC002/creatures/packim/land",
	open = "dontstarve_DLC002/creatures/packim/open",
	swallow = "dontstarve_DLC002/creatures/packim/swallow",
	transform = "dontstarve_DLC002/creatures/packim/transform",
	trasnform_stretch = "dontstarve_DLC002/creatures/packim/trasnform_stretch",
	transform_pop = "dontstarve_DLC002/creatures/packim/trasformation_pop",
	fly = "dontstarve_DLC002/creatures/packim/fly",
	fly_sleep = "dontstarve_DLC002/creatures/packim/fly_sleep",
	sleep = "dontstarve_DLC002/creatures/packim/sleep",
	bounce = "dontstarve_DLC002/creatures/packim/fly_bounce",
}

local WAKE_TO_FOLLOW_DISTANCE = 14
local SLEEP_NEAR_LEADER_DISTANCE = 7

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    --print(inst, "ShouldSleep", DefaultSleepTest(inst), not inst.sg:HasStateTag("open"), inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE))
    return DefaultSleepTest(inst) and not inst.sg:HasStateTag("open") and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) and not TheWorld.state.isfullmoon
end

local function ShouldKeepTarget()
    return false -- chester can't attack, and won't sleep if he has a target
end

local function OnOpen(inst)
    if not inst.components.health:IsDead() then
        inst.sg:GoToState("open")
    end
end

local function OnClose(inst)
    if not inst.components.health:IsDead() and inst.sg.currentstate.name ~= "transition" then
        inst.sg:GoToState("close")
    end
end

-- eye bone was killed/destroyed
local function OnStopFollowing(inst)
    --print("chester - OnStopFollowing")
    inst:RemoveTag("companion")
end

local function OnStartFollowing(inst)
    --print("chester - OnStartFollowing")
    inst:AddTag("companion")
end

local function WeaponDropped(inst)
    inst:Remove()
end

local function CanMorph(inst)
    local container = inst.components.container
    if container:IsOpen() then
        return false, false
    end

    local canSnow = true

    for i = 1, container:GetNumSlots() do
        local item = container:GetItemInSlot(i)
        if item == nil then
            return false, false
        end

        canSnow = canSnow and item.prefab == "obsidian"

        if not (canSnow) then
            return false, false
        end
    end

    return canSnow
end

local function CheckForMorph(inst)
    local canSnow = CanMorph(inst)
    if canSnow then
        inst.sg:GoToState("transition")
    end
end

local function MorphShadowChester(inst)
--    inst.AnimState:SetBuild("packim_fat_build")
    inst.MiniMapEntity:SetIcon("packim_fat.png")
    inst.components.maprevealable:SetIcon("packim_fat.png")

    inst.components.container:WidgetSetup("shadowchester")

    inst.ChesterState = "FAT"
    inst._isshadowchester:set(true)
		
    inst:RemoveTag("fireimmune")
--	inst.sounds = fatsounds
	
	
	
end

local function MorphSnowChester(inst)
    inst:RemoveEventCallback("onclose", CheckForMorph)
--    inst.AnimState:SetBuild("packim_fire_build")
    inst:AddTag("fireimmune")
    inst.MiniMapEntity:SetIcon("packim_fire.png")
    inst.components.maprevealable:SetIcon("packim_fire.png")
	
	inst.components.container:DropEverything()
	inst:RemoveComponent("container")	
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("chester")	
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose	

    inst.ChesterState = "FIRE"
    inst._isshadowchester:set(false)

--	local weapon = SpawnPrefab("firestaff")
--	inst.components.inventory:Equip(weapon)
--	weapon:RemoveComponent("finiteuses")
--    weapon.persists = false
--    weapon.components.inventoryitem:SetOnDroppedFn(WeaponDropped)

--  inst.sounds = normalsounds		
end

local function MorphNormalChester(inst)
--    inst.AnimState:SetBuild("packim_build")
    inst:RemoveTag("fireimmune")
    inst.MiniMapEntity:SetIcon("packim.png")
    inst.components.maprevealable:SetIcon("chester.png")
	
	inst.components.container:DropEverything()
	inst:RemoveComponent("container")	
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("chester")	
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose

    inst.ChesterState = "NORMAL"
    inst._isshadowchester:set(false)
		
	inst.components.hunger.current = 0
--	inst.sounds = normalsounds	

end

local function DoMorph(inst, fn)
    inst.MorphChester = nil
    fn(inst)
end

local function MorphChester(inst)
    local canSnow = CanMorph(inst)
    if not canSnow then
        return
    end

    local container = inst.components.container
    for i = 1, container:GetNumSlots() do
        container:RemoveItem(container:GetItemInSlot(i)):Remove()
    end

    DoMorph(inst, MorphShadowChester or MorphSnowChester)
end

local function OnSave(inst, data)
    data.ChesterState = inst.ChesterState
end

local function OnPreLoad(inst, data)
    if data == nil then
        return
    elseif data.ChesterState == "FAT" then
		inst.AnimState:SetBuild("packim_fat_build")
        DoMorph(inst, MorphShadowChester)
    elseif data.ChesterState == "FIRE" then
		inst.AnimState:SetBuild("packim_fire_build")
        DoMorph(inst, MorphSnowChester)
    end
end

local function OnIsShadowChesterDirty(inst)
    if inst._isshadowchester:value() ~= inst._clientshadowmorphed then
        inst._clientshadowmorphed = inst._isshadowchester:value()
        inst.replica.container:WidgetSetup(inst._clientshadowmorphed and "shadowchester" or nil)
    end
end

local function OnHaunt(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
        inst.components.hauntable.panic = true
        inst.components.hauntable.panictimer = TUNING.HAUNT_PANIC_TIME_SMALL
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function checkfiretransform(inst)
if inst.ChesterState ~= "FIRE" then
	local container = inst.components.container
	local cantransform = true 
	for i = 1, container:GetNumSlots() do
        local item = container:GetItemInSlot(i)
        
        if not item then
            cantransform = false 
            break
        end

        if item.prefab ~= "obsidian"  then
            cantransform = false
        end
    end
    if cantransform then 
    	container:ConsumeByName("obsidian", container:GetNumSlots())
   	 	MorphSnowChester(inst)
   	end 
    return cantransform
end	
end 

local function tryeatcontents(inst)

	local dideat = false
	local dideatfire = false
	local container = inst.components.container

	if inst.ChesterState == "FIRE" then
		for i = 1, container:GetNumSlots() do
	        local item = container:GetItemInSlot(i)
	     	if item then 
				inst.sg:GoToState("cooking")
	     		local replacement = nil 
		     	if item.components.cookable then 
		     		replacement = item.components.cookable.product
		     	elseif item.components.burnable then 
		     		replacement = "ash"
		     	end  
		     	if replacement then 
	     			local stacksize = 1 
	     			if item.components.stackable then 
	     				stacksize = item.components.stackable:StackSize()
	     			end 
	     			local newprefab = SpawnPrefab(replacement)
	     			if newprefab.components.stackable then 
	     				newprefab.components.stackable:SetStackSize(stacksize)
	     			end 
	     			container:RemoveItemBySlot(i)
	     			item:Remove()
	     			container:GiveItem(newprefab, i)					
	     		end 
		     end 
		end 
		return false 
	end 

	local loot = {}
	for i = 1, container:GetNumSlots() do
		local item = container:GetItemInSlot(i)
		if item then
			if item:HasTag("packimfood") or item:HasTag("fish") then
				dideat = true
				item = container:RemoveItemBySlot(i)
				if item.components.edible then
					local cals = item.components.edible:GetHunger()
					if item.components.stackable then
						cals = cals * item.components.stackable:StackSize()
					end
					inst.components.hunger:DoDelta(cals)
					
				end
				item:Remove()
			elseif item:HasTag("spoiledbypackim") then
				dideat = true
				item = container:RemoveItemBySlot(i)
				if item.components.perishable and item.components.perishable.onperishreplacement then
					local stack = 1 
					if item.components.stackable then 
	     				stack = item.components.stackable:StackSize()
	     			end  
	     			for i = 1, stack do 
						table.insert(loot, item.components.perishable.onperishreplacement)
					end 
				end
				if item.components.edible then
					local cals = item.components.edible:GetHunger()
					if item.components.stackable then
						cals = cals * item.components.stackable:StackSize()
					end
					inst.components.hunger:DoDelta(cals)
				end
				item:Remove()
			end
		end
	end
	if #loot > 0 then
		inst.components.lootdropper:SetLoot(loot)

		inst:DoTaskInTime(60 * FRAMES, function(inst)
			inst.components.lootdropper:DropLoot()
			inst.components.lootdropper:SetLoot({})
		end)
	end

	if dideat and inst.ChesterState == "NORMAL" then
		if inst.components.hunger.current and inst.components.hunger.current > 120 then
			MorphShadowChester(inst)
		end
	end

	return dideat
end

local function OnStarve(inst)
	if inst.ChesterState == "FAT" then
		MorphNormalChester(inst)
		inst.sg:GoToState("transform")
	end
end

local function RetargetFn(inst)	
if inst.ChesterState ~= "FIRE" then return end
	local notags = {"FX", "NOCLICK","INLIMBO", "abigail", "player"}
	local yestags = {"monster"}    
	    return FindEntity(inst, TUNING.PIG_TARGET_DIST,
	        function(guy)
	            if not guy.LightWatcher or guy.LightWatcher:IsInLight() then
	                return guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) 
	            end
	        end, yestags, notags)
end

local function KeepTargetFn(inst, target)
if inst.ChesterState ~= "FIRE" then return end
	    return inst.components.combat:CanTarget(target)
	           and (not target.LightWatcher or target.LightWatcher:IsInLight())
	           and not (target.sg and target.sg:HasStateTag("transform") )

end

local function OnAttacked(inst, data)
if inst.ChesterState ~= "FIRE" then return end
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, function(dude)
        return dude:HasTag("player")
            and not dude.components.health:IsDead()
            and dude.components.follower ~= nil
            and dude.components.follower.leader == inst.components.follower.leader
    end, 10)
end

local function create_chester()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    inst.entity:AddLightWatcher()

	MakeFlyingCharacterPhysics(inst, 75, .5)	

    inst:AddTag("companion")
    inst:AddTag("character")
    inst:AddTag("scarytoprey")
    inst:AddTag("packim")
	inst:AddTag("flying")	
    inst:AddTag("notraptrigger")
    inst:AddTag("noauradamage")

    inst.MiniMapEntity:SetIcon("packim.png")
    inst.MiniMapEntity:SetCanUseCache(false)

    inst.AnimState:SetBank("packim")
    inst.AnimState:SetBuild("packim_build")	

    inst.DynamicShadow:SetSize(2, 1.5)

    inst.Transform:SetSixFaced()

    inst._isshadowchester = net_bool(inst.GUID, "_isshadowchester", "onisshadowchesterdirty")

	inst.contador = 0
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst._clientshadowmorphed = false
        inst:ListenForEvent("onisshadowchesterdirty", OnIsShadowChesterDirty)
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end		
        return inst
    end


    ------------------------------------------
    inst:AddComponent("maprevealable")
    inst.components.maprevealable:SetIconPrefab("globalmapiconunderfog")

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "chester_body"
	inst.components.combat:SetDefaultDamage(TUNING.PIG_DAMAGE)
	inst.components.combat:SetAttackPeriod(TUNING.PIG_ATTACK_PERIOD)
	inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
	inst.components.combat:SetRetargetFunction(3, RetargetFn)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.CHESTER_HEALTH)
    inst.components.health:StartRegen(TUNING.CHESTER_HEALTH_REGEN_AMOUNT, TUNING.CHESTER_HEALTH_REGEN_PERIOD)

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 7
    inst.components.locomotor.runspeed = 10
    inst.components.locomotor:SetAllowPlatformHopping(true)

    inst:AddComponent("embarker")

    inst:AddComponent("follower")
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("startfollowing", OnStartFollowing)

    inst:AddComponent("knownlocations")

    MakeSmallBurnableCharacter(inst, "chester_body")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("chester")
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

	inst:AddComponent("lootdropper")
	
--	inst:AddComponent("inventory")
--	inst.components.inventory.maxslots = 0
--	inst.components.inventory.nosteal = true
--	inst.components.inventory.acceptitems = false	
	
	inst:AddComponent("hunger")
	inst.components.hunger:SetMax(150)
	inst.components.hunger:SetKillRate(0)
	inst.components.hunger.current = 0
	inst.components.hunger:SetRate(0.1)
    inst.components.hunger:SetOverrideStarveFn(OnStarve)	

    MakeHauntableDropFirstItem(inst)
    AddHauntableCustomReaction(inst, OnHaunt, false, false, true)

    inst.sounds = sounds

    inst:SetStateGraph("SGpackim")
    inst.sg:GoToState("idle")
	
	inst.tryeat = tryeatcontents

    inst:SetBrain(brain)

    inst.ChesterState = "NORMAL"
    inst.MorphChester = MorphChester
    inst:ListenForEvent("onclose", CheckForMorph)
	inst:ListenForEvent("attacked", OnAttacked)	
	
	inst.checkfiretransform = checkfiretransform

    inst.OnSave = OnSave
    inst.OnPreLoad = OnPreLoad

    return inst
end

return Prefab("packim", create_chester, assets, prefabs)
