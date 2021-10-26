local clockwork_common = require "prefabs/clockwork_common"
local RuinsRespawner = require "prefabs/ruinsrespawner"

local assets =
{
    Asset("ANIM", "anim/rook.zip"),
    Asset("ANIM", "anim/rook_build.zip"),
    Asset("ANIM", "anim/rook_nightmare.zip"),
    Asset("SOUND", "sound/chess.fsb"),
    Asset("SCRIPT", "scripts/prefabs/clockwork_common.lua"),
    Asset("SCRIPT", "scripts/prefabs/ruinsrespawner.lua"),
	
	Asset("ANIM", "anim/rookboat.zip"),
    Asset("ANIM", "anim/rookboat_build.zip"),
    Asset("ANIM", "anim/rookboat_death.zip"),	
}

local prefabs =
{
    "gears",
    "collapse_small",
}

local prefabs_nightmare =
{
    "gears",
    "thulecite_pieces",
    "nightmarefuel",
    "collapse_small",
    "rook_nightmare_ruinsrespawner_inst",
}

local brain = require "brains/rookbrain"

SetSharedLootTable('rookwater',
{
    {'gears',  1.0},
    {'gears',  1.0},
})

local function ShouldSleep(inst)
    return clockwork_common.ShouldSleep(inst)
end

local function ShouldWake(inst)
    return clockwork_common.ShouldWake(inst)
end

local function Retarget(inst)
    return clockwork_common.Retarget(inst, TUNING.ROOK_TARGET_DIST)
end

local function KeepTarget(inst, target)
    return (inst.sg ~= nil and inst.sg:HasStateTag("running"))
        or clockwork_common.KeepTarget(inst, target)
end

local function OnAttacked(inst, data)
    clockwork_common.OnAttacked(inst, data)
end

local function ClearRecentlyCharged(inst, other)
    inst.recentlycharged[other] = nil
end

local function onothercollide(inst, other)
    if not other:IsValid() or inst.recentlycharged[other] then
        return
    elseif other:HasTag("smashable") and other.components.health ~= nil then
        --other.Physics:SetCollides(false)
        other.components.health:Kill()
    elseif other.components.workable ~= nil
        and other.components.workable:CanBeWorked()
        and other.components.workable.action ~= ACTIONS.NET then
        SpawnPrefab("collapse_small").Transform:SetPosition(other.Transform:GetWorldPosition())
        other.components.workable:Destroy(inst)
        if other:IsValid() and other.components.workable ~= nil and other.components.workable:CanBeWorked() then
            inst.recentlycharged[other] = true
            inst:DoTaskInTime(3, ClearRecentlyCharged, other)
        end
    elseif other.components.health ~= nil and not other.components.health:IsDead() then
        inst.recentlycharged[other] = true
        inst:DoTaskInTime(3, ClearRecentlyCharged, other)
        inst.SoundEmitter:PlaySound("dontstarve/creatures/rook/explo")
        inst.components.combat:DoAttack(other, inst.weapon)
    end
end

local function oncollide(inst, other)
    if not (other ~= nil and other:IsValid() and inst:IsValid())
        or inst.recentlycharged[other]
        or other:HasTag("player")
        or Vector3(inst.Physics:GetVelocity()):LengthSq() < 42 then
        return
    end
    ShakeAllCameras(CAMERASHAKE.SIDE, .5, .05, .1, inst, 40)
    inst:DoTaskInTime(2 * FRAMES, onothercollide, other)
end

local function CreateWeapon(inst)
    local weapon = CreateEntity()
    --[[Non-networked entity]]
    weapon.entity:AddTransform()
    weapon:AddComponent("weapon")
    weapon.components.weapon:SetDamage(200)
    weapon.components.weapon:SetRange(0)
    weapon:AddComponent("inventoryitem")
    weapon.persists = false
    weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
    weapon:AddComponent("equippable")
    inst.components.inventory:GiveItem(weapon)
    inst.weapon = weapon
end

local function RememberKnownLocation(inst)
    inst.components.knownlocations:RememberLocation("home", inst:GetPosition())
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

local function common_fn(build, tag)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 50, 1.5)

    inst.DynamicShadow:SetSize(3, 1.25)
    inst.Transform:SetFourFaced()
 --   inst.Transform:SetScale(0.66, 0.66, 0.66)

	inst.AnimState:SetBank("rookboat")
    inst.AnimState:SetBuild("rookboat_build")

    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("chess")
    inst:AddTag("rook")
	inst:AddTag("tropicalspawner")	

    if tag ~= nil then
        inst:AddTag(tag)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.recentlycharged = {}
    inst.Physics:SetCollisionCallback(oncollide)

    inst:AddComponent("lootdropper")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.ROOK_WALK_SPEED
    inst.components.locomotor.runspeed =  TUNING.ROOK_RUN_SPEED

    inst:SetStateGraph("SGrookwater")
    inst:SetBrain(brain)

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetWakeTest(ShouldWake)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetResistance(3)

    inst:AddComponent("health")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "spring"
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRetargetFunction(3, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)

    inst.components.health:SetMaxHealth(TUNING.ROOK_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.ROOK_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.ROOK_ATTACK_PERIOD)
    --inst.components.combat.playerdamagepercent = 2

    inst:AddComponent("follower")

    inst:AddComponent("inventory")

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")

    MakeHauntablePanic(inst)

    inst:DoTaskInTime(0, RememberKnownLocation)

    MakeMediumBurnableCharacter(inst, "swap_fire")
    MakeMediumFreezableCharacter(inst, "innerds")

    inst:ListenForEvent("attacked", OnAttacked)

    CreateWeapon(inst)

    inst.components.lootdropper:SetChanceLootTable('rookwater')

    inst.kind = ""
    inst.soundpath = "dontstarve/creatures/rook/"
    inst.effortsound = "dontstarve/creatures/rook/steam"
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 480 + math.random()*240)		

    return inst
end

local function common_fn2(build, tag)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 50, 1.5)

    inst.DynamicShadow:SetSize(3, 1.25)
    inst.Transform:SetFourFaced()
 --   inst.Transform:SetScale(0.66, 0.66, 0.66)

	inst.AnimState:SetBank("rookboat")
    inst.AnimState:SetBuild("rookboat_build")

    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("chess")
    inst:AddTag("rook")
	inst:AddTag("tropicalspawner")	

    if tag ~= nil then
        inst:AddTag(tag)
    end
	
	inst:SetPrefabNameOverride("rookwater")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.recentlycharged = {}
    inst.Physics:SetCollisionCallback(oncollide)

    inst:AddComponent("lootdropper")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.ROOK_WALK_SPEED
    inst.components.locomotor.runspeed =  TUNING.ROOK_RUN_SPEED

    inst:SetStateGraph("SGrookwater")
    inst:SetBrain(brain)

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetWakeTest(ShouldWake)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetResistance(3)

    inst:AddComponent("health")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "spring"
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRetargetFunction(3, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)

    inst.components.health:SetMaxHealth(TUNING.ROOK_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.ROOK_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.ROOK_ATTACK_PERIOD)
    --inst.components.combat.playerdamagepercent = 2

    inst:AddComponent("follower")

    inst:AddComponent("inventory")

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")

    MakeHauntablePanic(inst)

    inst:DoTaskInTime(0, RememberKnownLocation)

    MakeMediumBurnableCharacter(inst, "swap_fire")
    MakeMediumFreezableCharacter(inst, "innerds")

    inst:ListenForEvent("attacked", OnAttacked)

    CreateWeapon(inst)

    inst.components.lootdropper:SetChanceLootTable('rookwater')

    inst.kind = ""
    inst.soundpath = "dontstarve/creatures/rook/"
    inst.effortsound = "dontstarve/creatures/rook/steam"		

    return inst
end

return Prefab("rookwater", common_fn, assets, prefabs),
	   Prefab("rookwaterfixo", common_fn2, assets, prefabs)
