local grassassets=
{
	Asset("ANIM", "anim/grass_tall.zip"),
	Asset("SOUND", "sound/common.fsb"),
	Asset("MINIMAP_IMAGE", "grass"),
}

local waterassets=
{
	Asset("ANIM", "anim/grass_inwater.zip"),
	Asset("ANIM", "anim/grassgreen_build.zip"),
	Asset("SOUND", "sound/common.fsb"),
}

local grassprefabs =
{
	"weevole",
    "cutgrass",
    "dug_grass",
   	"hacking_tall_grass_fx",
}

local waterprefabs =
{
    "cutgrass"
}

local VINE_REGROW_TIME = 480*4
local WEEVOLEDEN_MAX_WEEVOLES = 3
local respawndays = 4  --tempo para renascer em dias

local function startspawning(inst)
	if inst.components.childspawner and inst.components.workable and inst.components.workable.workable == true then
		local frozen = (inst.components.freezable and inst.components.freezable:IsFrozen())
		if not frozen and not TheWorld.state.isday then
			inst.components.childspawner:StartSpawning()
		end
	end
end

local function stopspawning(inst)
	if inst.components.childspawner then
		inst.components.childspawner:StopSpawning()
	end
end

local function removeweevoleden(inst)
	inst:RemoveTag("weevole_infested")
	inst:StopWatchingWorldState("isday", stopspawning)
	inst:StopWatchingWorldState("isdusk", startspawning)
end

local function makeweevoleden(inst)
	inst:AddTag("weevole_infested")
	inst:WatchWorldState("isday", stopspawning)
	inst:WatchWorldState("isdusk", startspawning)
end

local function onsave(inst, data)
	data.weevoleinfested = inst:HasTag("weevole_infested")
	
if not inst:HasTag("machetecut") then
    data.tag = 1
end	
end

local function onload(inst, data)
    if data and data.tag == 1 then
				inst.AnimState:PlayAnimation("picked")				
				inst:RemoveTag("machetecut")
				inst.components.workable:SetWorkAction(ACTIONS.DIG)
				inst.components.workable:SetWorkLeft(1)
    end	

    if data and data.weevoleinfested then
	    makeweevoleden(inst)
	end
end

local function onspawnweevole(inst)
	if inst:IsValid() then	
		if inst.components.workable and inst.components.workable.workable == true then	
			inst.AnimState:PlayAnimation("rustle", false)
			inst.AnimState:PushAnimation("idle", true)
		end
	end
end

local function weevolenesttest(inst)
	local pt = Vector3(inst.Transform:GetWorldPosition())
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 12, {"grass_tall"})
	local weevoleents = TheSim:FindEntities(pt.x,pt.y,pt.z, 12, {"weevole_infested"})

	if #weevoleents < 1 and math.random() < #ents/100 then
		local ent = ents[math.random(#ents)]
		makeweevoleden(ent)		
	end
end

local function onregenfn(inst, data)
    if data and data.name == "spawndelay" then
    inst.AnimState:PlayAnimation("grow")
	inst.AnimState:PushAnimation("idle",true)
	inst:AddTag("machetecut")
	inst.components.workable.workleft = inst.components.workable.maxwork
	inst.components.workable:SetWorkAction(ACTIONS.HACK)
    end
	weevolenesttest(inst)
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("picked",true)	
	inst.components.workable.workleft = 0
	inst.components.childspawner:StopSpawning()  
end

local function makebarrenfn(inst)
	inst.AnimState:PlayAnimation("picked",true)
	inst.components.workable.workleft = 0
	inst.components.childspawner:StopSpawning()  
end

local function spawnweevole(inst, target)

	local weevole = inst.components.childspawner:SpawnChild()
	if weevole then
		local spawnpos = Vector3(inst.Transform:GetWorldPosition())
		spawnpos = spawnpos + TheCamera:GetDownVec()
		weevole.Transform:SetPosition(spawnpos:Get())
		if weevole and target and weevole.components.combat then
			weevole.components.combat:SetTarget(target)
		end
	end
end

local function dig_up(inst, worker)

if inst:HasTag("machetecut") then
inst:RemoveTag("machetecut")
inst.components.workable:SetWorkAction(ACTIONS.DIG)
inst.components.workable:SetWorkLeft(1)
inst.components.lootdropper:SpawnLootPrefab("cutgrass")
inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)

if inst:HasTag("weevole_infested")then	
	removeweevoleden(inst)
end

return 
end


	if not inst:HasTag("machetecut") then
		if inst.components.lootdropper ~= nil then
			inst.components.lootdropper:SpawnLootPrefab("dug_grass")
		end
		inst:Remove()
	end

end

local function onhackedfn(inst, target, hacksleft, from_shears)
if not inst:HasTag("machetecut") then return end
	local fx = SpawnPrefab("hacking_tall_grass_fx")
	local x, y, z= inst.Transform:GetWorldPosition()
    fx.Transform:SetPosition(x,y + math.random()*2,z)

	if inst:HasTag("weevole_infested")then
		spawnweevole(inst, target)
	end
	
	if(hacksleft <= 0) then
		inst.AnimState:PlayAnimation("fall")
		inst.AnimState:PushAnimation("picked",true)		
		inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/grabbing_vine/drop")			
	else

--		inst.AnimState:PlayAnimation("chop")
		inst.AnimState:PushAnimation("idle")
		inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/grabbing_vine/drop")				
	end
		
end

local function makegrass(inst)
	inst.MiniMapEntity:SetIcon("grass.png")
	inst.AnimState:SetBank("grass_tall")	
	inst.AnimState:SetBuild("grass_tall")
end

local function onnear(inst)
	if not inst.playernear then
		if inst.components.workable and inst.components.workable.workleft > 1 then		                                								
			inst.AnimState:PlayAnimation("rustle") 
			inst.AnimState:PushAnimation("idle",true)		
		end		
	end
	inst.playernear = true
end


local function onfar(inst)
	inst.playernear = false
end

local function makefn(stage, artfn, product, dig_product, burnable, pick_sound, patch)
	local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    local sound = inst.entity:AddSoundEmitter()
		local minimap = inst.entity:AddMiniMapEntity()
	    inst.entity:AddNetwork()

		artfn(inst)

	    anim:PlayAnimation("idle",true)
	    anim:SetTime(math.random()*2)
	    local color = 0.75 + math.random() * 0.25
	    anim:SetMultColour(color, color, color, 1)

	    inst:AddTag("gustable")
	    inst:AddTag("grass_tall")
	    inst:AddTag("canbeshearable")
		inst:AddTag("machetecut")
--		inst:AddTag("plant")
		inst:AddTag("grasstall")	
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

--		inst:AddComponent("hackable")
--		inst.components.hackable:SetUp("cutgrass", VINE_REGROW_TIME )  
--		inst.components.hackable.onregenfn = onregenfn
--		inst.components.hackable.onhackedfn = onhackedfn
--		inst.components.hackable.makeemptyfn = makeemptyfn
--		inst.components.hackable.makebarrenfn = makebarrenfn
--		inst.components.hackable.max_cycles = 20
--		inst.components.hackable.cycles_left = 20
--		inst.components.hackable.hacksleft = 1
--		inst.components.hackable.maxhacks = 1
        inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HACK)		
        inst.components.workable:SetOnFinishCallback(dig_up)
        inst.components.workable.onwork = onhackedfn
        inst.components.workable.workleft = 3
        inst.components.workable.maxwork = 3		
		
		inst:AddComponent("timer")
		inst:ListenForEvent("timerdone", onregenfn)		

		inst:AddComponent("shearable")
		inst.components.shearable:SetProduct("cutgrass", 2)

	    inst:AddComponent("creatureprox")
	    inst.components.creatureprox:SetOnPlayerNear(onnear)
	    inst.components.creatureprox:SetOnPlayerFar(onfar)
	    inst.components.creatureprox:SetDist(0.75,1)

		inst:AddComponent("lootdropper")
	    inst:AddComponent("inspectable")    

	    
	    ---------------------

	    if burnable then
		    MakeMediumBurnable(inst)
		    MakeSmallPropagator(inst)
--		    inst.components.burnable:MakeDragonflyBait(1)
		end

--		MakeNoGrowInWinter(inst)		

		
	    ---------------------
		inst:AddComponent("childspawner")
		inst.components.childspawner.childname = "weevole"
		inst.components.childspawner:SetRegenPeriod(TUNING.SPIDERDEN_REGEN_TIME)
		inst.components.childspawner:SetSpawnPeriod(TUNING.SPIDERDEN_RELEASE_TIME)
		inst.components.childspawner:SetSpawnedFn(onspawnweevole)
		inst.components.childspawner:SetMaxChildren(WEEVOLEDEN_MAX_WEEVOLES)	 

	    if patch then
	    --	inst:DoTaskInTime(0,function() spawngrass(inst) end) 
	    	inst:SetPrefabName("grass_tall") 
			makeweevoleden(inst)
	    end

	    --------SaveLoad
	    inst.OnSave = onsave 
	    inst.OnLoad = onload 

	    return inst
	end

    return fn
end


local function makefn2(stage, artfn, product, dig_product, burnable, pick_sound, patch)
	local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    local sound = inst.entity:AddSoundEmitter()
		local minimap = inst.entity:AddMiniMapEntity()
	    inst.entity:AddNetwork()

		artfn(inst)

	    anim:PlayAnimation("idle",true)
	    anim:SetTime(math.random()*2)
	    local color = 0.75 + math.random() * 0.25
	    anim:SetMultColour(color, color, color, 1)

	    inst:AddTag("gustable")
	    inst:AddTag("grass_tall")
	    inst:AddTag("canbeshearable")
		inst:AddTag("machetecut")
--		inst:AddTag("plant")
		inst:AddTag("grasstall")	
		
		inst:SetPhysicsRadiusOverride(1.8)
		MakeWaterObstaclePhysics(inst, 0.35, 2, 1.25)
		inst:AddTag("ignorewalkableplatforms")
		inst:SetPrefabNameOverride("grass_tall")	
	
		MakeInventoryFloatable(inst, "med", 0, {1.1, 0.9, 1.1})
		inst.components.floater.bob_percent = 0

		local land_time = (POPULATING and math.random()*5*FRAMES) or 0
		inst:DoTaskInTime(land_time, function(inst)
			inst.components.floater:OnLandedServer()
		end)	


	
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

--		inst:AddComponent("hackable")
--		inst.components.hackable:SetUp("cutgrass", VINE_REGROW_TIME )  
--		inst.components.hackable.onregenfn = onregenfn
--		inst.components.hackable.onhackedfn = onhackedfn
--		inst.components.hackable.makeemptyfn = makeemptyfn
--		inst.components.hackable.makebarrenfn = makebarrenfn
--		inst.components.hackable.max_cycles = 20
--		inst.components.hackable.cycles_left = 20
--		inst.components.hackable.hacksleft = 1
--		inst.components.hackable.maxhacks = 1
        inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HACK)		
        inst.components.workable:SetOnFinishCallback(dig_up)
        inst.components.workable.onwork = onhackedfn
        inst.components.workable.workleft = 3
        inst.components.workable.maxwork = 3		
		
		inst:AddComponent("timer")
		inst:ListenForEvent("timerdone", onregenfn)		

		inst:AddComponent("shearable")
		inst.components.shearable:SetProduct("cutgrass", 2)

	    inst:AddComponent("creatureprox")
	    inst.components.creatureprox:SetOnPlayerNear(onnear)
	    inst.components.creatureprox:SetOnPlayerFar(onfar)
	    inst.components.creatureprox:SetDist(0.75,1)

		inst:AddComponent("lootdropper")
	    inst:AddComponent("inspectable")    

	    
	    ---------------------

	    if burnable then
		    MakeMediumBurnable(inst)
		    MakeSmallPropagator(inst)
--		    inst.components.burnable:MakeDragonflyBait(1)
		end

--		MakeNoGrowInWinter(inst)		

		
	    ---------------------
		inst:AddComponent("childspawner")
		inst.components.childspawner.childname = "weevole"
		inst.components.childspawner:SetRegenPeriod(TUNING.SPIDERDEN_REGEN_TIME)
		inst.components.childspawner:SetSpawnPeriod(TUNING.SPIDERDEN_RELEASE_TIME)
		inst.components.childspawner:SetSpawnedFn(onspawnweevole)
		inst.components.childspawner:SetMaxChildren(WEEVOLEDEN_MAX_WEEVOLES)	 

	    if patch then
	    --	inst:DoTaskInTime(0,function() spawngrass(inst) end) 
	    	inst:SetPrefabName("grass_tall") 
			makeweevoleden(inst)
	    end

	    --------SaveLoad
	    inst.OnSave = onsave 
	    inst.OnLoad = onload 

	    return inst
	end

    return fn
end

local StaticLayout = require("map/static_layout")
local bunch = {}
local entities = {} 
local WIDTH = 0
local HEIGHT = 0

local BUNCH_BLOCKERS = {
    "porkland_intro_basket",
    "porkland_intro_balloon",
    "porkland_intro_trunk",
    "porkland_intro_suitcase",
    "porkland_intro_flags",
    "porkland_intro_sandbag",
    "porkland_intro_scrape",
}

local function checkIfValidGround(x,z, valid_tile_types, water)
local map = TheWorld.Map
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, 0, z))
if ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_HAZARDOUS or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.IMPASSABLE or
ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_COASTAL_SHORE then	
return false
else
return true
end
end

local function AddTempEnts(data,x,z,prefab)
local plant = SpawnPrefab(prefab)
if plant ~= nil then
plant.Transform:SetPosition(x,0,z)	
end
end

local function findEntsInRange(x,z,range) 
    local ents = {}

    local dist = range*range 

    for k, item in ipairs(bunch) do
        local xdif = math.abs(x - item.x)
        local zdif = math.abs(z - item.z)
        if (xdif*xdif) + (zdif*zdif) < dist then
            table.insert(ents,item)
        end
    end

    return ents
end

local function checkforblockingitems(x,z,range)
    local spawnOK = true

--    for i, prefab in ipairs(BUNCH_BLOCKERS) do        
--        local dist = 4*4
--        if entities[prefab] then
--            for t, ent in ipairs( entities[prefab] ) do
--                local xdif = math.abs(x - ent.x)
--                local zdif = math.abs(z - ent.z)
--                if (xdif*xdif) + (zdif*zdif) < dist then
--                    spawnOK = false
--                end
--            end
--        else
--            print(">>> BUNCH SPAWN ERROR?",prefab)
--        end
--    end
    return spawnOK 
end

local function round(x)
  x = x *10
  local num = x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
  return num/10
end

local function placeitemoffgrids(x1,z1, range, prefab, valid_tile_types, water, inst)

    local offgrid = false
    local inc = 1
    local x,z = nil,nil
    while offgrid == false do       

        local radiusMax = range        
        local rad = math.random()*radiusMax
        local xdiff = math.random()*rad
        local zdiff = math.sqrt( (rad*rad) - (xdiff*xdiff))

        if math.random() > 0.5 then
            xdiff= -xdiff
        end

        if math.random() > 0.5 then
            zdiff= -zdiff
        end
        x = x1+ xdiff
        z = z1+ zdiff

        local ents = findEntsInRange(x,z,range) 
        local test = true
        for i,ent in ipairs(ents) do
          
            if round(x) == round(ent.x) or round(z) == round(ent.z) or ( math.abs(round(ent.x-x)) == math.abs(round(ent.z-z)) )  then
                test = false
                break
            end           
        end
        
        offgrid = test
        inc = inc +1       
    end
    if x and z and checkIfValidGround(x,z, valid_tile_types, water) and checkforblockingitems(x,z) then
        AddTempEnts(bunch,x,z,prefab)
    end      
	inst:Remove()
end

local function patchfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function()
	local x, y, z = inst.Transform:GetWorldPosition()	
	
    for i=1,math.random(5,10) do --    for i=1,math.random(50,200) do
        placeitemoffgrids(x,z, 12, "grass_tall", {GROUND.PLAINS,GROUND.DEEPRAINFOREST,GROUND.RAINFOREST}, nil, inst)
    end
	end)
	return inst
end

local function patchfngrasssimple()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function()
	local x, y, z = inst.Transform:GetWorldPosition()	
	
    for i=1,math.random(15,25) do --    for i=1,math.random(50,200) do
        placeitemoffgrids(x,z, 6, "grass", {GROUND.SAVANNA}, nil, inst)
    end
	end)
	return inst
end

local function patchfnfern()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function()
	local x, y, z = inst.Transform:GetWorldPosition()	
	
    for i=1,math.random(1,5) do --i=1,math.random(5,15) do
        placeitemoffgrids(x,z, 12, "deep_jungle_fern_noise_plant", {GROUND.DEEPRAINFOREST}, nil, inst)
    end
		
	
	end)
	return inst
end

local function patchteatree_piko()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function()
	local x, y, z = inst.Transform:GetWorldPosition()	
	
    for i=1,math.random(4,8) do
        placeitemoffgrids(x,z, 18, "teatree_piko_nest", nil, nil, inst)
    end
		
	
	end)
	return inst
end

local function patchasparagus()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function()
	local x, y, z = inst.Transform:GetWorldPosition()	
	
    for i=1,math.random(2,6) do
        placeitemoffgrids(x,z, 2, "asparagus_planted", {GROUND.PLAINS,GROUND.DEEPRAINFOREST,GROUND.RAINFOREST}, nil, inst)
    end
		
	
	end)
	return inst
end

local function vampirebatcave()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function()
if math.random() < 0.2 then	
	local x, y, z = inst.Transform:GetWorldPosition()
	local plant = SpawnPrefab("vampirebatcave_entrance")
	if plant ~= nil then
	plant.Transform:SetPosition(x, y, z)
	end
end
	inst:Remove()
	end)
	return inst
end

return Prefab("forest/objects/grass_tall", makefn(0, makegrass, "cutgrass", "dug_grass", true, "dontstarve/wilson/pickup_reeds"), grassassets, grassprefabs),
	   Prefab("forest/objects/grass_tallwater", makefn2(0, makegrass, "cutgrass", "dug_grass", true, "dontstarve/wilson/pickup_reeds"), grassassets, grassprefabs),
	   Prefab("forest/objects/grass_tall_infested", makefn(0, makegrass, "cutgrass", "dug_grass", true, "dontstarve/wilson/pickup_reeds", true), grassassets, grassprefabs),
	   Prefab("forest/objects/grass_tall_patch",  patchfn),
	   Prefab("forest/objects/deep_jungle_fern_noise",  patchfnfern),
	   Prefab("forest/objects/teatree_piko_nest_patch",  patchteatree_piko),
	   Prefab("forest/objects/asparagus_patch",  patchasparagus),
	   Prefab("forest/objects/vampirebatcave_potential",  vampirebatcave),
	   Prefab("forest/objects/grass_patch",  patchfngrasssimple)	   