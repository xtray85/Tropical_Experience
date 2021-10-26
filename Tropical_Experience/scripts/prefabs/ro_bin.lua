require "prefabutil"
local brain = require "brains/chesterbrain"
require "stategraphs/SGRo_Bin"

local WAKE_TO_FOLLOW_DISTANCE = 14
local SLEEP_NEAR_LEADER_DISTANCE = 7

local assets =
{
    Asset("ANIM", "anim/ro_bin.zip"),
    Asset("ANIM", "anim/ro_bin_water.zip"),
    Asset("ANIM", "anim/ro_bin_build.zip"),

    Asset("SOUND", "sound/chester.fsb"),
    Asset("INV_IMAGE", "chester_eyebone"),
    Asset("INV_IMAGE", "chester_eyebone_closed"),
}

local prefabs =
{
    "ro_bin_gizzard_stone",
    "die_fx",
    "chesterlight",
    "sparklefx",
}

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    --print(inst, "ShouldSleep", DefaultSleepTest(inst), not inst.sg:HasStateTag("open"), inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE))
    return DefaultSleepTest(inst) and not inst.sg:HasStateTag("open") 
    and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) 
    and TheWorld.state.moonphase ~= "full"
end


local function ShouldKeepTarget(ifnst, target)
    return false -- chester can't attack, dand won't sleep if he has a target
end


local function OnOpen(inst)
    if not inst.components.health:IsDead() then
        inst.sg:GoToState("open")
    end
end 

local function OnClose(inst) 
    if not inst.components.health:IsDead() then
        inst.sg:GoToState("close")
    end
end 

-- eye bone was killed/destroyed
local function OnStopFollowing(inst) 
    inst:RemoveTag("companion") 
end

local function OnStartFollowing(inst) 
    inst:AddTag("companion") 
end

local function OnSave(inst, data)
    data.ChesterState = inst.ChesterState
end

local function OnPreLoad(inst, data)
    if not data then return end
end

local function OnWaterChange ( inst, onwater )
    if onwater then
        inst.onwater = true
        inst.altstep = nil    
        inst.sg:GoToState("takeoff")
        print("ROBIN ON WATER")
    else        
        inst.onwater = false    
        inst.sg:GoToState("land")
        print("ROBIN ON LAND")        
    end 
end

local function OnEntityWake(inst)   
    if inst.components.tiletracker then
        inst.components.tiletracker:Start()
    end
end

local function OnEntitySleep(inst)
    if inst.components.tiletracker then
        inst.components.tiletracker:Stop()
    end
end

local function create_ro_bin()
    local inst = CreateEntity()
    inst.entity:AddNetwork()       
    inst:AddTag("companion")
    inst:AddTag("character")
    inst:AddTag("scarytoprey")
--    inst:AddTag("chester")
    inst:AddTag("ro_bin")
    inst:AddTag("notraptrigger")
    inst:AddTag("cattoy")

    inst.entity:AddTransform()

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "ro_bin.png" )

    inst.entity:AddAnimState()
    inst.AnimState:SetBank("ro_bin")
    inst.AnimState:SetBuild("ro_bin_build")

    inst.entity:AddSoundEmitter()

    inst.entity:AddDynamicShadow()
    inst.DynamicShadow:SetSize( 2, 1.5 )

--    MakePoisonableCharacter(inst)
    
    MakeCharacterPhysics(inst, 75, .5)
    
    inst.Transform:SetFourFaced()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
		return inst
	end

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "chester_body"
    inst.components.combat:SetKeepTargetFunction(ShouldKeepTarget)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.CHESTER_HEALTH)
    inst.components.health:StartRegen(TUNING.CHESTER_HEALTH_REGEN_AMOUNT, TUNING.CHESTER_HEALTH_REGEN_PERIOD)
    inst:AddTag("noauradamage")


    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 5
    inst.components.locomotor.runspeed = 10 * 0.7

    inst:AddComponent("follower")
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("startfollowing", OnStartFollowing)

    inst:AddComponent("knownlocations")

    MakeMediumBurnableCharacter(inst, "hound_body")
    
    inst:AddComponent("container")
	inst.components.container:WidgetSetup("chester")  
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

    inst:SetStateGraph("SGRo_Bin")
    inst.sg:GoToState("idle")

    inst:SetBrain(brain)
    inst.ChesterState = "NORMAL"

    inst.OnSave = OnSave
    inst.OnPreLoad = OnPreLoad

    inst:DoTaskInTime(1.5, function(inst)
        -- We somehow got a ro bin without a gizzard stone. Kill it! Kill it with fire!
        if not TheSim:FindFirstEntityWithTag("ro_bin_gizzard_stone") then
            inst:Remove()
        end
    end)

    inst.OnEntityWake = OnEntityWake
    inst.OnEntitySleep = OnEntitySleep

    inst:AddTag("amphibious")
--    MakeAmphibiousCharacterPhysics(inst, 1, .5)

    inst:AddComponent("tiletracker")
    inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)

    return inst
end

return Prefab( "common/ro_bin", create_ro_bin, assets, prefabs) 