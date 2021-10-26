local assets =
{
	Asset("ANIM", "anim/sprinkler.zip"),
	Asset("ANIM", "anim/sprinkler1.zip"),	
	Asset("ANIM", "anim/sprinkler_placement.zip"),
	Asset("ANIM", "anim/sprinkler_meter.zip"),
}

local MOISTURE_SPRINKLER_PERCENT_INCREASE_PER_SPRAY = 5
local SPRINKLER_MAX_FUEL_TIME = 480
local MOISTURE_MAX_WETNESS = 100

local projectile_assets =
{
	Asset("ANIM", "anim/firefighter_projectile.zip")
}

local prefabs =
{
	"water_spray",
	"water_pipe",
--	"alloy",
}

RANGE = 8

local function IsWater(tile)
	return tile == GROUND.OCEAN_COASTAL or 
		tile == GROUND.OCEAN_COASTAL_SHORE or 
		tile == GROUND.OCEAN_SWELL or
		tile == GROUND.OCEAN_ROUGH or 
		tile == GROUND.OCEAN_BRINEPOOL or 
		tile == GROUND.OCEAN_BRINEPOOL_SHORE or 
		tile == GROUND.OCEAN_WATERLOG or
		tile == GROUND.OCEAN_HAZARDOUS	
end


local function spawndrop(inst)
	local drop = SpawnPrefab("raindrop")
	local pt = Vector3(inst.Transform:GetWorldPosition())
	local angle = math.random()*2*PI
	local dist = math.random()*RANGE
	local offset = Vector3(dist * math.cos( angle ), 0, -dist * math.sin( angle ))
	drop.Transform:SetPosition(pt.x+offset.x,0,pt.z+offset.z)	
	drop.Transform:SetScale(0.5, 0.5, 0.5)
end

local function OnFuelSectionChange(old, new, inst)
local fuelAnim = 0
if inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.01 then fuelAnim = "0"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.1 then fuelAnim = "1"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.2 then fuelAnim = "2"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.3 then fuelAnim = "3" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.4 then fuelAnim = "4" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.5 then fuelAnim = "5" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.6 then fuelAnim = "6" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.7 then fuelAnim = "7" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.8 then fuelAnim = "8" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.9 then fuelAnim = "9" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 1 then fuelAnim = "10" end 
if inst then inst.AnimState:OverrideSymbol("swap_meter", "sprinkler_meter", fuelAnim) end
end

local function ontakefuelfn(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/machine_fuel")
local fuelAnim = 0
if inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.01 then fuelAnim = "0"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.1 then fuelAnim = "1"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.2 then fuelAnim = "2"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.3 then fuelAnim = "3" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.4 then fuelAnim = "4" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.5 then fuelAnim = "5" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.6 then fuelAnim = "6" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.7 then fuelAnim = "7" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.8 then fuelAnim = "8" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.9 then fuelAnim = "9" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 1 then fuelAnim = "10" end 
if inst then inst.AnimState:OverrideSymbol("swap_meter", "sprinkler_meter", fuelAnim) end
end

local function TurnOn(inst)
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
local fx = SpawnPrefab("shock_machines_fx")
if fx then local pt = inst:GetPosition() fx.Transform:SetPosition(pt.x, pt.y, pt.z) end 
if inst.SoundEmitter then inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_water") end
inst.on = false
return 
end
	inst:AddTag("shelter")
	inst.on = true
	inst.components.fueled:StartConsuming()
	if not inst.waterSpray then
		inst.waterSpray = SpawnPrefab("water_spray")
		local follower = inst.waterSpray.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, "top", 0, -100, 0)
	end
	inst.droptask = inst:DoPeriodicTask(0.4,function() spawndrop(inst) spawndrop(inst) end)

	inst.spraytask = inst:DoPeriodicTask(0.4,function()
			if inst.components.machine:IsOn() then
				inst.UpdateSpray(inst)
			end
		end)

	inst.sg:GoToState("turn_on")
end

local function TurnOff(inst)
	inst:RemoveTag("shelter")
	inst.on = false
	inst.components.fueled:StopConsuming()

	if inst.waterSpray then
		inst.waterSpray:Remove()
		inst.waterSpray = nil
	end

	if inst.droptask then
		inst.droptask:Cancel()
		inst.droptask = nil
	end

	if inst.spraytask then
		inst.spraytask:Cancel()
		inst.spraytask = nil
	end


	if inst.moisture_targets then
		for GUID, i in pairs(inst.moisture_targets)do
			i.components.moisture.moisture_sources[inst.GUID] = nil
		end
	end

	inst.sg:GoToState("turn_off")
end

local function OnFuelEmpty(inst)
	inst.components.machine:TurnOff()
end

local function OnFuelSectionChange(old, new, inst)
local fuelAnim = 0
if inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.01 then fuelAnim = "0"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.1 then fuelAnim = "1"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.2 then fuelAnim = "2"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.3 then fuelAnim = "3" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.4 then fuelAnim = "4" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.5 then fuelAnim = "5" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.6 then fuelAnim = "6" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.7 then fuelAnim = "7" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.8 then fuelAnim = "8" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.9 then fuelAnim = "9" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 1 then fuelAnim = "10" end 
if inst then inst.AnimState:OverrideSymbol("swap_meter", "sprinkler_meter", fuelAnim) end
end

local function ontakefuelfn(inst)
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
local fx = SpawnPrefab("shock_machines_fx")
if fx then local pt = inst:GetPosition() fx.Transform:SetPosition(pt.x, pt.y, pt.z) end 
if inst.SoundEmitter then inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_water") end
inst.on = false
TurnOff(inst)
return 
end
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/machine_fuel")
local fuelAnim = 0
if inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.01 then fuelAnim = "0"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.1 then fuelAnim = "1"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.2 then fuelAnim = "2"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.3 then fuelAnim = "3" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.4 then fuelAnim = "4" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.5 then fuelAnim = "5" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.6 then fuelAnim = "6" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.7 then fuelAnim = "7" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.8 then fuelAnim = "8" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.9 then fuelAnim = "9" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 1 then fuelAnim = "10" end 
if inst then inst.AnimState:OverrideSymbol("swap_meter", "sprinkler_meter", fuelAnim) end
end

local function CanInteract(inst)
	return true
end

local function GetStatus(inst, viewer)
	if inst.on then
		return "ON"
	else
		return "OFF"
	end
end

local function OnEntitySleep(inst)
    inst.SoundEmitter:KillSound("firesuppressor_idle")
end

local function OnSave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end

    data.on = inst.on

end

local function OnLoad(inst, data)
	if data and data.burnt and inst.components.burnable and inst.components.burnable.onburnt then
        inst.components.burnable.onburnt(inst)
    end

    inst.on = data.on and data.on or false
end

local function OnLoadPostPass(inst, newents, data)

end

local function OnBuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle_off")
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/crafted/sprinkler/place")
end

local function UpdateSpray(inst)
OnFuelSectionChange(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
--    local ents = TheSim:FindEntities(x, y, z, RANGE)
	local GARDENING_CANT_TAGS = { "pickable", "stump", "withered", "barren", "INLIMBO" }
	local ents = TheSim:FindEntities(x, y, z, RANGE, nil, GARDENING_CANT_TAGS)

	if not inst.moisture_targets then
		inst.moisture_targets = {}
	end
	inst.moisture_targets_old = {}
	for GUID,v in pairs(inst.moisture_targets) do
    	inst.moisture_targets_old[GUID] = v
	end
    inst.moisture_targets = {} 

    for k,v in pairs(ents) do
		if v.components.moisture then
		local equipamentos = v.components.inventory:GetWaterproofness()
		local coberturas = v.components.moisture.inherentWaterproofness	
		local variante = equipamentos + coberturas
		if variante > 1 then variante = 1 end
		local quantidadefinal = 1 - variante

		
		v.components.moisture:DoDelta(0.05*quantidadefinal)		
		end
		
		if v.components.burnable and not (v.components.inventoryitem and v.components.inventoryitem.owner) then
			v.components.burnable:Extinguish()
		end		
		
		if v.components.crop and v.components.crop.task then
--		print(v)
			v.components.crop.growthpercent = v.components.crop.growthpercent + (0.001)
		end		
		
		



--    if v.components.pickable ~= nil then
--        if v.components.pickable:CanBePicked() and v.components.pickable.caninteractwith then
--            return false
--        end
--        if v.components.pickable:FinishGrowing() then
--			v.components.pickable:ConsumeCycles(1) -- magic grow is hard on plants
--			return true
--		end
--    end

--    if v.components.crop ~= nil and (v.components.crop.rate or 0) > 0 then
--        if v.components.crop:DoGrow(1 / v.components.crop.rate, true) then
--			return true
--		end
--    end

    if v.components.growable ~= nil then
        -- If we're a tree and not a stump, or we've explicitly allowed magic growth, do the growth.
		v.components.growable:ExtendGrowTime(-0.2)
--		if v.components.growable.targettime and v.components.growable.targettime > 1 then
--        v.components.growable.targettime = v.components.growable.targettime - 0.4
--		end
    end

--    if v.components.harvestable ~= nil and v.components.harvestable:CanBeHarvested() and v:HasTag("mushroom_farm") then
--        if v.components.harvestable:Grow() then
--			return true
--		end
--    end
	if v then
	local a, b, c = v.Transform:GetWorldPosition()
	if inst.components.wateryprotection then
	inst.components.wateryprotection:SpreadProtectionAtPoint(a, b, c, 1)
	end
	end	
		
		
		
		if v.components.witherable and v.components.witherable:IsWithered() then
			v.components.witherable:ForceRejuvenate()
		end	
		
		end

end

local function IsValidSprinklerTile(tile)
	return not IsWater(tile) and (tile ~= GROUND.INVALID)
end

local function GetValidWaterPointNearby(pt)
	local range = 20

	local cx, cy = TheWorld.Map:GetTileCoordsAtPoint(pt.x, 0, pt.z)
	local center_tile = TheWorld.Map:GetTile(cx, cy)

	local min_sq_dist = 999999999999
	local best_point = nil

	for x = pt.x - range, pt.x + range, 1 do
		for z = pt.z - range, pt.z + range, 1 do
			local tx, ty = TheWorld.Map:GetTileCoordsAtPoint(x, 0, z)
			local tile = TheWorld.Map:GetTile(tx, ty)

			if IsValidSprinklerTile(center_tile) and IsWater(tile) then
				local cur_point = Vector3(x, 0, z)
				local cur_sq_dist = cur_point:DistSq(pt)

				if cur_sq_dist < min_sq_dist then
					min_sq_dist = cur_sq_dist
					best_point = cur_point
				end
			end
		end
	end

	return best_point
end

local function PlaceTestFn(inst, pt)
	return GetValidWaterPointNearby(pt) ~= nil
end

local function RotateToTarget(inst, dest)
    local px, py, pz = inst.Transform:GetWorldPosition()
    local dz = pz - dest.z
    local dx = dest.x - px
    local angle = math.atan2(dz, dx) / DEGREES

    -- Offset angle to account for pipe orientation in file.sa
    local OFFSET_ANGLE = 90
	inst.Transform:SetRotation(angle - OFFSET_ANGLE)
end

local function CreatePipes(inst)
	local P0 = Vector3(inst.Transform:GetWorldPosition())
	local P1 = GetValidWaterPointNearby(P0)
	
	local totalDist = P1:Dist(P0)
	local pipeLength = 2
	local metricPipeLength = pipeLength / totalDist

	inst.pipes = {}

	for t = 0.0, 1.0, metricPipeLength do
		local Pt = (P1 - P0)*t + P0
		local pipe = SpawnPrefab("water_pipe")
		pipe.pipesound = tostring(inst.GUID).."pipesound"
		pipe.Transform:SetPosition(Pt.x, 0.0, Pt.z)
		RotateToTarget(pipe, P1)

		table.insert(inst.pipes, pipe)
	end
end

local function DestroyPipes(inst)
	for i, pipe in ipairs(inst.pipes) do
		pipe:Remove()
	end
end

local function ConnectPipes(inst)
	local numPipes = #inst.pipes

	if numPipes > 2 then
		for i = 2, numPipes, 1 do
			inst.pipes[i - 1].nextPipe = inst.pipes[i]
			inst.pipes[i].prevPipe = inst.pipes[i - 1]
		end
	end
end

local function ExtendPipes(inst)
	TheWorld[tostring(inst.GUID).."pipesound"] = 1
	if inst.loadedPipesFromFile then
		for i, pipe in ipairs(inst.pipes) do
			pipe.sg:GoToState("idle")
		end
	else
		inst.pipes[1].sg:GoToState("extend")
	end
end

local function RetractPipes(inst)	
--	TheWorld[tostring(inst.GUID).."pipesound"] = 1
	if inst.pipes and inst.pipes[#inst.pipes] then
	inst.pipes[#inst.pipes].sg:GoToState("retract")
	end
end

local function OnHit(inst, worker)
	if not inst:HasTag("burnt") then
		if not inst.sg:HasStateTag("busy") then
			inst.sg:GoToState("hit")
		end
	end
end

local function OnHammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end

	inst.SoundEmitter:KillSound("idleloop")
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	TurnOff(inst, true)
	RetractPipes(inst)
	inst:Remove()
end

local function OnDeplete(inst)

end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()	
	minimap:SetPriority(5)
	minimap:SetIcon("sprinkler.png")

	MakeObstaclePhysics(inst, 1)

	anim:SetBank("sprinkler")
	anim:SetBuild("sprinkler")
	anim:PlayAnimation("idle_off")
	inst.AnimState:OverrideSymbol("sidepipe", "sprinkler1", "sidepipe")	
--    inst.AnimState:OverrideSymbol("tank", "sprinkler1", "")
--	inst.AnimState:OverrideSymbol("shdw", "sprinkler1", "")
--	inst.AnimState:OverrideSymbol("sidecrank", "sprinkler1", "")
--	inst.AnimState:OverrideSymbol("sidepipe", "sprinkler1", "")
--	inst.Transform:SetScale(0.6, 0.6, 0.6)	
	inst.on = false

	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = GetStatus

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("machine")
	inst.components.machine.turnonfn = TurnOn
	inst.components.machine.turnofffn = TurnOff
	inst.components.machine.caninteractfn = CanInteract
	inst.components.machine.cooldowntime = 0.5

	inst:AddComponent("fueled")
	inst.components.fueled:SetDepletedFn(OnFuelEmpty)
	inst.components.fueled.accepting = true
	inst.components.fueled:SetSections(10)
	inst.components.fueled.ontakefuelfn = ontakefuelfn
	inst.components.fueled:SetSectionCallback(OnFuelSectionChange)
	inst.components.fueled:InitializeFuelLevel(SPRINKLER_MAX_FUEL_TIME)
	inst.components.fueled.bonusmult = 5
	inst.components.fueled.secondaryfueltype = "CHEMICAL"

--	inst.AnimState:OverrideSymbol("swap_meter", "sprinkler_meter", 10)

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(OnHammered)
	inst.components.workable:SetOnWorkCallback(OnHit)
	
--    inst:AddComponent("wateringcan")
--    inst.components.wateringcan.water_amount = 0.01
--    inst.components.wateringcan.ondepletefn = OnDeplete	
	
	inst:AddComponent("wateryprotection")
	inst.components.wateryprotection.extinguishheatpercent = TUNING.WATERINGCAN_EXTINGUISH_HEAT_PERCENT
	inst.components.wateryprotection.temperaturereduction = TUNING.WATERINGCAN_TEMP_REDUCTION
	inst.components.wateryprotection.witherprotectiontime = TUNING.WATERINGCAN_PROTECTION_TIME
	inst.components.wateryprotection.addwetness = 0.01
	inst.components.wateryprotection.protection_dist = TUNING.WATERINGCAN_PROTECTION_DIST
	inst.components.wateryprotection:AddIgnoreTag("player")
	inst.components.wateryprotection.onspreadprotectionfn = OnDeplete	
	
	inst:SetStateGraph("SGsprinkler")

	inst.moisturizing = 2
	inst.UpdateSpray = UpdateSpray

	inst.OnSave = OnSave 
    inst.OnLoad = OnLoad
    inst.OnLoadPostPass = OnLoadPostPass
    inst.OnEntitySleep = OnEntitySleep

	inst:ListenForEvent("onbuilt", OnBuilt)

	MakeSnowCovered(inst, .01)


--[[
	inst:DoTaskInTime(0.1,
		function()
		local P0 = Vector3(inst.Transform:GetWorldPosition())
		local P1 = GetValidWaterPointNearby(P0)
		if P1 == nil then return end
			if not inst.pipes or (#inst.pipes < 1) then
				CreatePipes(inst)
			end

			ConnectPipes(inst)
			ExtendPipes(inst)
		end)
]]
	inst.waterSpray = nil

	return inst
end

local function OnHit(inst, dist)
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/firesupressor_impact")
	SpawnPrefab("splash_snow_fx").Transform:SetPosition(inst:GetPosition():Get())	
	inst:Remove()
end

require "prefabutil"

return Prefab("sprinkler1", fn, assets, prefabs),
MakePlacer("common/sprinkler1_placer", "sprinkler_placement", "sprinkler_placement", "idle", true, nil, nil, 1.4, nil, nil, nil, nil, nil, nil)
--MakePlacer("common/sprinkler1_placer", "sprinkler_placement", "sprinkler_placement", "idle", true, nil, nil, 1.4, nil, nil, nil, nil, nil, PlaceTestFn)