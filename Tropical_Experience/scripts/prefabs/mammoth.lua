local brain = require "brains/mammothbrain"

local assets =
{
    Asset("ANIM", "anim/koalefant_basic.zip"),
    Asset("ANIM", "anim/koalefant_actions.zip"),
    Asset("ANIM", "anim/koalefant_mamoth_build.zip"),
    Asset("ANIM", "anim/koalefant_winter_build.zip"),
    Asset("SOUND", "sound/koalefant.fsb"),
}

local prefabs =
{
    "meat",
    "poop",
}

local loot_summer = {"meat","meat","meat","meat","meat","beefalowool","beefalowool","beefalowool"}
local loot_winter = {"meat","meat","meat","meat","meat","beefalowool","beefalowool","beefalowool"}
local loot_fire = {"meat","meat","meat","meat","meat","beefalowool","beefalowool","beefalowool"}

local WAKE_TO_RUN_DISTANCE = 10
local SLEEP_NEAR_ENEMY_DISTANCE = 14

local function ShouldWakeUp(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    return DefaultWakeTest(inst) or IsAnyPlayerInRange(x, y, z, WAKE_TO_RUN_DISTANCE)
end

local function ShouldSleep(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    return DefaultSleepTest(inst) and not IsAnyPlayerInRange(x, y, z, SLEEP_NEAR_ENEMY_DISTANCE)
end

local function KeepTarget(inst, target)
    return inst:IsNear(target, TUNING.KOALEFANT_CHASE_DIST)
end

local function ShareTargetFn(dude)
    return dude:HasTag("mammoth") and not dude:HasTag("player") and not dude.components.health:IsDead()
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, ShareTargetFn, 5)
end

local function lootsetfn(lootdropper)
    if lootdropper.inst.components.burnable ~= nil and lootdropper.inst.components.burnable:IsBurning() or lootdropper.inst:HasTag("burnt") then
        lootdropper:SetLoot(loot_fire)
    end
end

local function create_base(build)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .75)

    inst.DynamicShadow:SetSize(4.5, 2)
    inst.Transform:SetSixFaced()

    inst:AddTag("mammoth")
    inst:AddTag("animal")
    inst:AddTag("largecreature")
    inst:AddTag("houndfriend")
 	inst:AddTag("walrus")		

    inst.AnimState:SetBank("koalefant")
    inst.AnimState:SetBuild("koalefant_mamoth_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
	
--	inst.AnimState:OverrideSymbol("beefalo_eye", "koalefant_mamoth_build", "beefalo_eye")
--	inst.AnimState:OverrideSymbol("beefalo_headbase", "koalefant_mamoth_build", "beefalo_headbase")
--	inst.AnimState:OverrideSymbol("beefalo_body", "koalefant_mamoth_build", "beefalo_body")
--	inst.AnimState:OverrideSymbol("beefalo_facebase", "koalefant_mamoth_build", "beefalo_facebase")		
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"
    inst.components.combat:SetDefaultDamage(TUNING.KOALEFANT_DAMAGE)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst:ListenForEvent("attacked", OnAttacked)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.KOALEFANT_HEALTH)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLootSetupFn(lootsetfn)

    inst:AddComponent("inspectable")

    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("poop")
    inst.components.periodicspawner:SetRandomTimes(40, 60)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()

    MakeLargeBurnableCharacter(inst, "beefalo_body")
    MakeLargeFreezableCharacter(inst, "beefalo_body")

    MakeHauntablePanic(inst)

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 1.5
    inst.components.locomotor.runspeed = 7

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

    inst:SetBrain(brain)
    inst:SetStateGraph("SGkoalefant")
    return inst
end

local function create_summer()
    local inst = create_base("koalefant_mamoth_build")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.lootdropper:SetLoot(loot_summer)

    return inst
end

return Prefab("mammoth", create_summer, assets, prefabs)
