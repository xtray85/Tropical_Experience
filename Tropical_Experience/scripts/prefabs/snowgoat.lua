local assets =
{
    Asset("ANIM", "anim/frostland_goat_build.zip"),
    Asset("ANIM", "anim/lightning_goat_basic.zip"),
    Asset("ANIM", "anim/lightning_goat_actions.zip"),
    Asset("ANIM", "anim/frostland_goat_horn.zip"),
    Asset("SOUND", "sound/lightninggoat.fsb"),
}

local prefabs =
{
    "meat",
    "lightninggoathorn",
    "goatmilk",
    "lightninggoatherd",
}

local brain = require("brains/lightninggoatbrain")

SetSharedLootTable( 'snowgoat',
{
    {'meat',              1.00},
    {'goatmilk',          1.00},	
})

local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "snowgoat", "wall" }
local RETARGET_WALL_MUST_TAGS = { "_combat", "wall" }
local RETARGET_WALL_CANT_TAGS = { "snowgoat" }
local function RetargetFn(inst)
    if inst.charged then
        local function CheckTarget(guy)
            return inst.components.combat:CanTarget(guy)
        end
        return
            -- Look for non-wall targets first
            FindEntity(
                inst,
                TUNING.LIGHTNING_GOAT_TARGET_DIST,
                CheckTarget,
                RETARGET_MUST_TAGS,
                RETARGET_CANT_TAGS)
            or
            -- If none, look for walls
            FindEntity(
                inst,
                TUNING.LIGHTNING_GOAT_TARGET_DIST,
                CheckTarget,
                RETARGET_WALL_MUST_TAGS,
                RETARGET_WALL_CANT_TAGS)
            or
            nil
    end
end

local function KeepTargetFn(inst, target)
    if target:HasTag("wall") then
        --Don't keep wall target if a non-wall target is available
        return
            FindEntity(
                inst,
                TUNING.LIGHTNING_GOAT_TARGET_DIST,
                function(guy)
                    return inst.components.combat:CanTarget(guy)
                end,
                RETARGET_MUST_TAGS,
                RETARGET_CANT_TAGS) == nil
    end
    --Don't keep target if we chased too far from our herd
    local herd = inst.components.herdmember ~= nil and inst.components.herdmember:GetHerd() or nil
    return herd == nil or inst:IsNear(herd, TUNING.LIGHTNING_GOAT_CHASE_DIST)
end

local function discharge(inst)
    inst:RemoveTag("charged")
    inst.components.lootdropper:SetChanceLootTable('snowgoat') 
    inst.sg:GoToState("discharge")
    inst.AnimState:ClearBloomEffectHandle()
    inst.charged = false
    inst.Light:Enable(false)
    inst.chargeleft = nil
end

local function ReduceCharges(inst)
    if inst.chargeleft then
        inst.chargeleft = inst.chargeleft - 1
        if inst.chargeleft <= 0 then
            discharge(inst)
        end
    end
end

local function IsChargedGoat(dude)
    return dude:HasTag("snowgoat") and dude:HasTag("charged")
end

local function OnAttacked(inst, data)
    if data ~= nil and data.attacker ~= nil then
        if inst.charged then
            if data.attacker.components.health ~= nil and not data.attacker.components.health:IsDead() and
                (data.weapon == nil or ((data.weapon.components.weapon == nil or data.weapon.components.weapon.projectile == nil) and data.weapon.components.projectile == nil)) and
                not (data.attacker.components.inventory ~= nil and data.attacker.components.inventory:IsInsulated()) then

                data.attacker.components.health:DoDelta(-TUNING.LIGHTNING_GOAT_DAMAGE, nil, inst.prefab, nil, inst)
                if data.attacker:HasTag("player") then
                    data.attacker.sg:GoToState("electrocute")
                end
            end
        end

        inst.components.combat:SetTarget(data.attacker)
        inst.components.combat:ShareTarget(data.attacker, 20, IsChargedGoat, 3)
    end
end

local function onspawnedforhunt(inst)
	TheWorld:PushEvent("ms_sendlightningstrike", inst:GetPosition())
end

local function getstatus(inst)
    return inst.charged and "CHARGED" or nil
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(1.75, .75)

    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 100, .5)

    inst.AnimState:SetBank("lightning_goat")
    inst.AnimState:SetBuild("frostland_goat_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
	inst.AnimState:OverrideSymbol("lightning_goat_horn", "frostland_goat_horn", "lightning_goat_horn")
    inst.AnimState:Hide("fx")

    ------------------------------------------

    inst:AddTag("snowgoat")
    inst:AddTag("animal")
--    inst:AddTag("lightningrod")
 	inst:AddTag("walrus")
	inst:AddTag("houndfriend")	

    --herdmember (from herdmember component) added to pristine state for optimization
    inst:AddTag("herdmember")

    --saltlicker (from saltlicker component) added to pristine state for optimization
    inst:AddTag("saltlicker")

    inst.Light:Enable(false)
    inst.Light:SetRadius(.85)
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(255 / 255, 255 / 255, 236 / 255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    ------------------------------------------

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.LIGHTNING_GOAT_HEALTH)

    ------------------

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.LIGHTNING_GOAT_DAMAGE)
    inst.components.combat:SetRange(TUNING.LIGHTNING_GOAT_ATTACK_RANGE)
    inst.components.combat.hiteffectsymbol = "lightning_goat_body"
    inst.components.combat:SetAttackPeriod(TUNING.LIGHTNING_GOAT_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(1, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetHurtSound("dontstarve_DLC001/creatures/lightninggoat/hurt")
    ------------------------------------------

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(4)

    ------------------------------------------

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('snowgoat') 

    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    ------------------------------------------

    inst:AddComponent("knownlocations")
    inst:AddComponent("herdmember")
    inst.components.herdmember:SetHerdPrefab("snowgoatherd")

    ------------------------------------------

    inst:ListenForEvent("attacked", OnAttacked)

    ------------------------------------------

    inst:AddComponent("timer")
    inst:AddComponent("saltlicker")
    inst.components.saltlicker:SetUp(TUNING.SALTLICK_LIGHTNINGGOAT_USES)

    ------------------------------------------

    MakeMediumBurnableCharacter(inst, "lightning_goat_body")
    MakeMediumFreezableCharacter(inst, "lightning_goat_body")

	inst:ListenForEvent("spawnedforhunt", onspawnedforhunt)

    ------------------------------------------

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.LIGHTNING_GOAT_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.LIGHTNING_GOAT_RUN_SPEED

    MakeHauntablePanic(inst)

    inst:SetStateGraph("SGlightninggoat")
    inst:SetBrain(brain)

    return inst
end

return Prefab("snowgoat", fn, assets, prefabs)
