local assets =
{
    Asset("ANIM", "anim/grotto_mowlth_basic.zip"),
}

local prefabs =
{
    "beeguard",
    "honey_trail",
    "splash_sink",
    "royal_jelly",
    "honeycomb",
    "honey",
    "stinger",
    "hivehat",
    "bundlewrap_blueprint",
	"chesspiece_beequeen_sketch",
}

SetSharedLootTable('grottoqueen',
{
    {'royal_jelly',      1.00},
    {'royal_jelly',      1.00},
    {'royal_jelly',      1.00},
    {'royal_jelly',      1.00},
    {'royal_jelly',      1.00},
    {'royal_jelly',      1.00},
    {'royal_jelly',      0.50},
    {'honeycomb',        1.00},
    {'honeycomb',        0.50},
    {'honey',            1.00},
    {'honey',            1.00},
    {'honey',            1.00},
    {'honey',            0.50},
    {'stinger',          1.00},
    {'hivehat',          1.00},
    {'bundlewrap_blueprint', 1.00},
	{'chesspiece_beequeen_sketch', 1.00},
})

local brain = require("brains/grottoqueenbrain")

local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        local target = inst.components.combat.target
--        if not (target ~= nil and
--                target:HasTag("player") and
--                target:IsNear(inst, inst.focustarget_cd > 0 and TUNING.BEEQUEEN_ATTACK_RANGE + target:GetPhysicsRadius(0) or TUNING.BEEQUEEN_AGGRO_DIST)) then
--            inst.components.combat:SetTarget(data.attacker)
--        end
--        inst.components.commander:ShareTargetToAllSoldiers(data.attacker)
    end
end

--------------------------------------------------------------------------

local function ShouldSleep(inst)
    return false
end

local function ShouldWake(inst)
    return true
end

--------------------------------------------------------------------------

local function PushMusic(inst)
    if ThePlayer == nil or inst:HasTag("flight") then
        inst._playingmusic = false
    elseif ThePlayer:IsNear(inst, inst._playingmusic and 40 or 20) then
        inst._playingmusic = true
        ThePlayer:PushEvent("triggeredevent", { name = "beequeen" })
    elseif inst._playingmusic and not ThePlayer:IsNear(inst, 50) then
        inst._playingmusic = false
    end
end

--------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddDynamicShadow()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(1.4, 1.4, 1.4)

    inst.DynamicShadow:SetSize(4, 2)

    MakeFlyingGiantCharacterPhysics(inst, 500, 1.4)

    inst.AnimState:SetBank("mowlth")
    inst.AnimState:SetBuild("grotto_mowlth_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst:AddTag("epic")
    inst:AddTag("noepicmusic")
    inst:AddTag("insect")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")
    inst:AddTag("flying")
    inst:AddTag("ignorewalkableplatformdrowning")

    inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bee_queen/wings_LP", "flying")

    inst.entity:SetPristine()

    --Dedicated server does not need to trigger music
    if not TheNet:IsDedicated() then
        inst._playingmusic = false
        inst:DoPeriodicTask(1, PushMusic, 0)
    end

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('grottoqueen')

--    inst:AddComponent("sleeper")
--    inst.components.sleeper:SetResistance(4)
--    inst.components.sleeper:SetSleepTest(ShouldSleep)
--    inst.components.sleeper:SetWakeTest(ShouldWake)
--    inst.components.sleeper.diminishingreturns = true


    inst:AddComponent("locomotor")
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorewalls = true, allowocean = true }
    inst.components.locomotor.walkspeed = TUNING.BEEQUEEN_SPEED

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.BEEQUEEN_HEALTH)
    inst.components.health.nofadeout = true

--    inst:AddComponent("healthtrigger")
--    inst.components.healthtrigger:AddTrigger(PHASE2_HEALTH, EnterPhase2Trigger)
--    inst.components.healthtrigger:AddTrigger(PHASE3_HEALTH, EnterPhase3Trigger)
--    inst.components.healthtrigger:AddTrigger(PHASE4_HEALTH, EnterPhase4Trigger)

    inst:AddComponent("combat")
--    inst.components.combat:SetDefaultDamage(TUNING.BEEQUEEN_DAMAGE)
--    inst.components.combat:SetAttackPeriod(TUNING.BEEQUEEN_ATTACK_PERIOD)
--    inst.components.combat.playerdamagepercent = .5
--   inst.components.combat:SetRange(TUNING.BEEQUEEN_ATTACK_RANGE, TUNING.BEEQUEEN_HIT_RANGE)
--    inst.components.combat:SetRetargetFunction(3, RetargetFn)
--    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
--    inst.components.combat.battlecryenabled = false
--    inst.components.combat.hiteffectsymbol = "hive_body"
--    inst.components.combat.bonusdamagefn = bonus_damage_via_allergy

    inst:AddComponent("sanityaura")

    inst:AddComponent("knownlocations")

    MakeLargeBurnableCharacter(inst, "swap_fire")
    MakeHugeFreezableCharacter(inst, "hive_body")
    inst.components.freezable.diminishingreturns = true

    inst:SetStateGraph("SGgrottoqueen")
    inst:SetBrain(brain)

    inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

return Prefab("grottoqueen", fn, assets, prefabs)
