local rock_ice_assets =
{
    Asset("ANIM", "anim/ice_boulder.zip"),
    Asset("MINIMAP_IMAGE", "iceboulder"),
}

local prefabs =
{
    "ice",
}

local function SetLoot(inst, size)
    inst.components.lootdropper:SetLoot(nil)
    inst.components.lootdropper:SetChanceLootTable(
        (size == "short" and "rock_ice_short") or
        (size == "medium" and "rock_ice_medium") or
        "rock_ice_tall"
    )
end

local STAGES = {
    {
        name = "dryup",
        animation = "dryup",
        showrock = false,
        work = -1,
        isdriedup = true,
    },
    {
        name = "empty",
        animation = "melted",
        showrock = false,
        work = -1,
    },
    {
        name = "short",
        animation = "low",
        showrock = true,
        work = -1,
        icecount = 2,
    },
    {
        name = "medium",
        animation = "med",
        showrock = true,
        work = TUNING.ICE_MINE*0.67,
        icecount = 4,
    },
    {
        name = "tall",
        animation = "full",
        showrock = true,
        work = TUNING.ICE_MINE,
        icecount = 5,
    },
}

local STAGE_INDICES = {}
for i, v in ipairs(STAGES) do
    STAGE_INDICES[v.name] = i
end

local function DeserializeStage(inst)
    return inst._stage:value() + 1 -- back to 1-based index
end

local function OnStageDirty(inst)
    local ismelt = inst._ismelt:value()
    local stagedata = STAGES[DeserializeStage(inst)]
    if stagedata ~= nil then
        if stagedata.showrock then
            inst.name = STRINGS.NAMES.ROCK_ICE
            inst.no_wet_prefix = false
        else
            inst.name = STRINGS.NAMES.ROCK_ICE_MELTED
            inst.no_wet_prefix = true
        end
    end
end

local function SerializeStage(inst, stageindex, source)
    inst._ismelt:set(source == "melt")
    inst._stage:set(stageindex - 1) -- convert to 0-based index
    OnStageDirty(inst)
end

local DRYUP_CANT_FLAGS = {"locomotor", "FX"}
local function SetStage(inst, stage, source, snap_to_stage)
    if stage == inst.stage then
        return
    end

    local currentstage = STAGE_INDICES[inst.stage]
    local targetstage = STAGE_INDICES[stage]
    if (source == "melt" or source == "work") then
        if currentstage and currentstage > targetstage then
			if not snap_to_stage then
				targetstage = currentstage - 1
			end
        else
            return
        end
    elseif source == "grow" then
        if currentstage and currentstage < targetstage then
			if not snap_to_stage then
	            targetstage = currentstage + 1
	        end
        else
            return
        end
        
		if inst.stage == "dryup" then
			local x, y, z = inst.Transform:GetWorldPosition()
			if #(TheSim:FindEntities(x, y, z, 1.1, nil, DRYUP_CANT_FLAGS)) > 0 then
				return
			end
		end        
    end

    -- otherwise just set the stage to the target!
    inst.stage = STAGES[targetstage].name
    SerializeStage(inst, targetstage, source)

	if STAGES[targetstage].isdriedup then
		if inst.remove_on_dryup then
			inst.presists = false
			if inst:IsAsleep() then
				inst:Remove()
			else
				inst:DoTaskInTime(2, inst.Remove)
			end
		end

		inst:AddTag("CLASSIFIED")
	elseif currentstage ~= nil and STAGES[currentstage].isdriedup then
		inst:RemoveTag("CLASSIFIED")
	end

    if STAGES[targetstage].showrock then
        inst.AnimState:PlayAnimation(STAGES[targetstage].animation)

        inst.AnimState:Show("rock")
        if TheWorld.state.snowlevel >= SNOW_THRESH then
            inst.AnimState:Show("snow")
        end
        inst.MiniMapEntity:SetEnabled(true)
    else
        inst.AnimState:Hide("rock")
        inst.AnimState:Hide("snow")
        inst.MiniMapEntity:SetEnabled(false)
    end

    if inst.components.workable ~= nil then
        if source == "work" then
			for i = currentstage, targetstage+1, -1 do
				local pt = inst:GetPosition()
				for i = 1, math.random(STAGES[i].icecount) do
					inst.components.lootdropper:SpawnLootPrefab("ice", pt)
				end
			end
        end
        if STAGES[targetstage].work < 0 then
            inst.components.workable:SetWorkable(false)
        else
            inst.components.workable:SetWorkLeft(STAGES[targetstage].work)
        end
    end
end

local function OnWorked(inst, worker, workleft)
local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
local xjp, yjp, zjp = worker.Transform:GetWorldPosition()
local entities = TheSim:FindEntities(xjp, yjp, zjp, 5, WALKABLE_PLATFORM_TAGS)
for i, v in ipairs(entities) do
local walkable_platform = v.components.walkableplatform            
if not v:HasTag("swboat") and walkable_platform ~= nil then
if math.random() < 0.17 then
local penguin = SpawnPrefab("penguin")
local bolha = SpawnPrefab("splash")
if bolha then bolha.Transform:SetPosition(inst.Transform:GetWorldPosition()) end



if penguin then
penguin.Transform:SetPosition(inst.Transform:GetWorldPosition()) 
penguin.sg:GoToState("jumper_attack",v)
end
end 

end
end

    if workleft <= 0 then
		local snap_to_stage = not worker:HasTag("character")
        SetStage(inst, "empty", "work", snap_to_stage)
        if inst.stage == "empty" then
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/iceboulder_smash")
        end
    end
end

local function RescheduleTimer(inst)
    if not inst.components.timer:TimerExists("rock_ice_change") then
        inst.components.timer:StartTimer("rock_ice_change", 30)
    end
end

local function TryStageChange(inst)
    if inst.components.workable ~= nil and
        inst.components.workable.lastworktime ~= nil and
        GetTime() - inst.components.workable.lastworktime < 10 then
        inst:DoTaskInTime(0, RescheduleTimer)
        return
    end

    local pct = TheWorld.state.seasonprogress
	local map = TheWorld.Map
	local x, y, z = inst.Transform:GetWorldPosition()
	local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))	
    if TheWorld.state.isspring then
        SetStage(
            inst,
            (pct < inst.threshold1 and "tall") or
            (pct < inst.threshold2 and "medium") or
            (pct < inst.threshold3 and "short") or
            "empty",
            "melt"
        )
    elseif TheWorld.state.issummer then
		SetStage(inst, "dryup", "melt")
    elseif TheWorld.state.isautumn then
        SetStage(
            inst,
            (pct < inst.threshold1 and "empty") or
            (pct < inst.threshold2 and "short") or
            (pct < inst.threshold3 and "medium") or
            "tall",
            "grow"
        )
	elseif TheWorld.state.iswinter or ground == GROUND.WATER_MANGROVE or ground == GROUND.ANTFLOOR or ground == GROUND.OCEAN_COASTAL_SHORE or ground == GROUND.OCEAN_COASTAL or ground == GROUND.OCEAN_WATERLOG  then	
		SetStage(inst, "tall", "grow")
	end
end

local function DayEnd(inst)
    if not inst.components.timer:TimerExists("rock_ice_change") then
        inst.components.timer:StartTimer("rock_ice_change", math.random(TUNING.TOTAL_DAY_TIME, TUNING.TOTAL_DAY_TIME * 3))
    end
end

local function _OnFireMelt(inst)
    inst.firemelttask = nil
    SetStage(inst, "dryup", "melt")
end

local function StartFireMelt(inst)
    if inst.firemelttask == nil then
        inst.firemelttask = inst:DoTaskInTime(4, _OnFireMelt)
    end
end

local function StopFireMelt(inst)
    if inst.firemelttask ~= nil then 
        inst.firemelttask:Cancel()
        inst.firemelttask = nil
    end
end

local function onsave(inst, data)
    data.stage = inst.stage
    data.remove_on_dryup = inst.remove_on_dryup
end

local function onload(inst, data)
    inst.remove_on_dryup = data ~= nil and data.remove_on_dryup or nil

    if data ~= nil and data.stage ~= nil then
        while inst.stage ~= data.stage do
            SetStage(inst, data.stage)
        end
    end
end

local function ontimerdone(inst, data)
    if data.name == "rock_ice_change" then
        TryStageChange(inst)
    end
end

local function GetStatus(inst)
    return inst.stage == "empty" and "MELTED" or nil
end

local function rock_ice_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("ice_boulder")
    inst.AnimState:SetBuild("ice_boulder")

    MakeWaterObstaclePhysics(inst, 0.80, 2, 1.25)
	
	inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)    
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)  
	inst.Physics:CollidesWith(COLLISION.ITEMS)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
	
	inst.Physics:SetDontRemoveOnSleep(true)

	inst:SetPhysicsRadiusOverride(2.35)
	
	MakeInventoryFloatable(inst, "large", 0.1, {0.8, 0.8, 0.8})
    inst.components.floater.bob_percent = 0

    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("frozen")
    inst:AddTag("rock_ice_frost")	
    MakeSnowCoveredPristine(inst)

    inst.name = STRINGS.NAMES.ROCK_ICE
    inst.no_wet_prefix = false

    inst._ismelt = net_bool(inst.GUID, "rock_ice.ismelt", "stagedirty")
    inst._stage = net_tinybyte(inst.GUID, "rock_ice.stage", "stagedirty")
    inst._stage:set(STAGE_INDICES["tall"])

    inst.entity:SetPristine()

    if not TheNet:IsDedicated() then
        if not TheWorld.ismastersim then
            inst:ListenForEvent("stagedirty", OnStageDirty)
        end
    end

    OnStageDirty(inst)
	
	inst:SetPrefabNameOverride("rock_ice")

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus
	
    inst:AddComponent("lootdropper")
    SetLoot(inst, "tall")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ICE_MINE)

    inst.components.workable:SetOnWorkCallback(OnWorked)

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", ontimerdone)

    -- Make sure we start at a good height for starting in a season when it shouldn't start as full
    inst:DoTaskInTime(0, function()
	local map = TheWorld.Map
	local x, y, z = inst.Transform:GetWorldPosition()
	local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))	
        if inst.stage then
            SetStage(inst, inst.stage)
		elseif TheWorld.state.isspring or TheWorld.state.iswinter or ground == GROUND.WATER_MANGROVE or ground == GROUND.ANTFLOOR or ground == GROUND.OCEAN_COASTAL_SHORE or ground == GROUND.OCEAN_COASTAL or ground == GROUND.OCEAN_WATERLOG then		
            SetStage(inst, "tall")
        elseif TheWorld.state.issummer then
            SetStage(inst, "short")
        else
            SetStage(inst, "short")
        end
    end)

    -- Bias to changing towards end of seasons, these suckers have a lot of thermal momentum!
    inst.threshold1 = Lerp(.4,.6,math.random())
    inst.threshold2 = Lerp(.65,.85,math.random())
    inst.threshold3 = Lerp(.9,1.1,math.random())

	inst.remove_on_dryup = nil

    inst:ListenForEvent("firemelt", StartFireMelt)
    inst:ListenForEvent("stopfiremelt", StopFireMelt)

    inst:WatchWorldState("cycles", DayEnd)

    inst.OnSave = onsave
    inst.OnLoad = onload

    MakeSnowCovered(inst)

    MakeHauntableWork(inst)
	
	inst:DoTaskInTime(0, function()
		inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
		inst.Physics:ClearCollisionMask()
		inst.Physics:CollidesWith(COLLISION.WORLD)    
		inst.Physics:CollidesWith(COLLISION.OBSTACLES)  
		inst.Physics:CollidesWith(COLLISION.ITEMS)
		inst.Physics:CollidesWith(COLLISION.CHARACTERS)
		inst.Physics:CollidesWith(COLLISION.GIANTS)
		inst.Physics:CollidesWith(COLLISION.OBSTACLES)
	end)

    return inst
end


return Prefab("rock_ice_frost", rock_ice_fn, rock_ice_assets, prefabs)
