local assets =
{
    Asset("ANIM", "anim/lavaarena_beetletaur.zip"),
    Asset("ANIM", "anim/lavaarena_beetletaur_basic.zip"),
    Asset("ANIM", "anim/lavaarena_beetletaur_actions.zip"),
    Asset("ANIM", "anim/lavaarena_beetletaur_block.zip"),
    Asset("ANIM", "anim/lavaarena_beetletaur_fx.zip"),
    Asset("ANIM", "anim/lavaarena_beetletaur_break.zip"),
    Asset("ANIM", "anim/healing_flower.zip"),
    Asset("ANIM", "anim/fossilized.zip"),
}

local prefabs =
{
    "fossilizing_fx",
    "beetletaur_fossilized_break_fx_right",
    "beetletaur_fossilized_break_fx_left",
    "beetletaur_fossilized_break_fx_left_alt",
    "beetletaur_fossilized_break_fx_alt",
    "lavaarena_creature_teleport_medium_fx",
}

--------------------------------------------------------------------------
local function KnockbackOnHit(inst, target, radius, attack_knockback, strength_mult, force_land)
    if target.sg and target.sg.sg.states.knockback then
        target:PushEvent("knockback", {knocker = inst, radius = radius, strengthmult = strength_mult, forcelanded = force_land})
    else
        Knockback(inst, target, radius, attack_knockback)
    end
end

local function OnHitOther(inst, target)
    if inst.sg:HasStateTag("slamming") or inst.sg:HasStateTag("knockback") then
        KnockbackOnHit(inst, target, 5, 2)
    end
end

local function CanDestroyObject(inst, object)
    return object and object:IsValid() and object.components.workable and object.components.workable:CanBeWorked() and object.components.workable.action ~= ACTIONS.DIG and object.components.workable.action ~= ACTIONS.NET and not inst.recentlycharged[object]
end

local function ClearRecentlyCharged(inst, object)
    inst.recentlycharged[object] = nil
end

local function OnDestroyObject(inst, object)
    if CanDestroyObject(inst, object) then
        SpawnPrefab("collapse_small").Transform:SetPosition(object.Transform:GetWorldPosition())
        object.components.workable:Destroy(inst)
        inst.recentlycharged[object] = true
        inst:DoTaskInTime(3, ClearRecentlyCharged, object)
    end
end

local DESTROY_OBJECT_DELAY = 2*FRAMES
local function OnCollideDestroyObject(inst, object)
    if CanDestroyObject(inst, object) then
        inst:DoTaskInTime(DESTROY_OBJECT_DELAY, OnDestroyObject, object)
    end
end
--------------------------------------------------------------------------
local function CreateBreakFX()
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    inst.AnimState:SetBank("beetletaur_break")
    inst.AnimState:SetBuild("lavaarena_beetletaur_break")
    inst.AnimState:PlayAnimation("anim")
    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local function KillPulseFX(inst)
    if inst.task ~= nil then
        inst:Remove()
    else
        inst.killed = true
    end
end

local function OnPulseDelay(inst, anim)
    inst.task = nil
    inst.AnimState:PlayAnimation(anim or (inst.bufftype == 1 and "defend_fx" or "attack_fx3"))
end

local function OnPulseAnimOver(inst)
    if inst.killed then
        inst:Remove()
    else
        if inst.task ~= nil then
            inst.task:Cancel()
        end
        inst.task = inst:DoTaskInTime(1, OnPulseDelay)
    end
end

local function CreatePulse(bufftype)
    local inst = CreateEntity()
    ------------------------------------------
    inst:AddTag("DECOR") --"FX" will catch mouseover
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false
    ------------------------------------------
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("lavaarena_beetletaur_fx")
    inst.AnimState:SetBuild("lavaarena_beetletaur_fx")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    ------------------------------------------
    inst.task = nil
    inst.bufftype = bufftype
    inst.KillFX = KillPulseFX
    ------------------------------------------
    inst:ListenForEvent("animover", OnPulseAnimOver)
    if bufftype == 1 then
        inst.task = inst:DoTaskInTime(4*FRAMES, OnPulseDelay, "defend_fx_pre")
    else
        inst.AnimState:PlayAnimation("attack_fx3_pre")
    end
    ------------------------------------------
    return inst
end

local function OnBuffTypeDirty(inst)
    --Dedicated server does not need to spawn the local fx
    if not TheNet:IsDedicated() and (inst.buff_fx and inst.buff_fx.bufftype or 0) ~= inst._bufftype:value() then
        -- Remove old FX
        if inst.buff_fx then
            -- Break Guard FX
            if inst.buff_fx.bufftype == 1 then
                local fx = CreateBreakFX()
                fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                fx.SoundEmitter:PlaySound("dontstarve/creatures/slurtle/shatter")
            end
            inst.buff_fx:KillFX()
            inst.buff_fx = nil
        end
        -- Create new FX
        if inst._bufftype:value() == 1 or inst._bufftype:value() == 2 then
            inst.buff_fx = CreatePulse(inst._bufftype:value())
            inst.buff_fx.entity:SetParent(inst.entity)
        end
    end
end
--------------------------------------------------------------------------
local function OnCameraFocusDirty(inst)
    if inst._camerafocus:value() then
        if inst:HasTag("NOCLICK") then
            --death
            TheFocalPoint.components.focalpoint:StartFocusSource(inst, nil, nil, 6, 22, 3)
        else
            --pose
            TheFocalPoint.components.focalpoint:StartFocusSource(inst, nil, nil, 60, 60, 3)
            TheCamera:SetDistance(30)
            TheCamera:SetControllable(false)
        end
    else
        TheFocalPoint.components.focalpoint:StopFocusSource(inst)
        TheCamera:SetControllable(true)
    end
end

local function EnableCameraFocus(inst, enable)
    if enable ~= inst._camerafocus:value() then
        inst._camerafocus:set(enable)
        if not TheNet:IsDedicated() then
            OnCameraFocusDirty(inst)
        end
    end
end
--------------------------------------------------------------------------
local function CreateFlower()
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("healing_flower")
    inst.AnimState:SetBuild("healing_flower")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("shadow")

    return inst
end

local function OnFlowerHitGround(flower)
    flower.AnimState:Show("shadow")
    flower.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt", nil, .35)
end

local function CheckPose(flower, inst)
    if not (inst:IsValid() and inst.AnimState:IsCurrentAnimation("end_pose_loop")) then
        ErodeAway(flower, 1)
    end
end

local function OnSpawnFlower(inst)
    local flower = CreateFlower()
    local x, y, z = inst.Transform:GetWorldPosition()
    local vec = TheCamera:GetRightVec()
    flower.Physics:Teleport(x, 7, z)
    flower.Physics:SetVel(vec.x * 5, 20, vec.z * 5)
    flower:DoTaskInTime(1.23, OnFlowerHitGround)
    flower:DoPeriodicTask(.5, CheckPose, nil, inst)
end
--------------------------------------------------------------------------
local function AttackModeTrigger(inst)
    inst.components.healthtrigger:RemoveTrigger(0.9)
    inst.modes.guard = false
    inst.modes.attack = true 
    inst.attacks.combo = 2
    inst.attacks.tantrum = true
    inst.guard_timer = inst:DoTaskInTime(12, function(inst)
        inst.guard_timer = nil
    end)
end

local function AttackAndGuardModeTrigger(inst)
    inst.components.healthtrigger:RemoveTrigger(0.8)
    inst.modes.guard = true
    inst.attacks.uppercut = true
    inst.attacks.buff = true
    inst.sg.mem.wants_to_taunt = true
end

local function Combo2Trigger(inst)
    inst.components.healthtrigger:RemoveTrigger(0.5)
    inst.attacks.combo = 4
end

local function InfiniteComboTrigger(inst)
    inst.components.healthtrigger:RemoveTrigger(0.25)
    inst.attacks.combo = 999
end

local function ReTarget(inst)
    local newtarget = FindEntity(inst, 50, 
		function(guy)
			return inst.components.combat:CanTarget(guy)
        end,
        { "player" },
        { "smallcreature", "playerghost", "shadow", "INLIMBO", "FX", "NOCLICK" }
    )

    if newtarget then
		return newtarget
	end
end

--------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(4.5, 2.25)
    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(1.05, 1.05, 1.05)

    inst:SetPhysicsRadiusOverride(1.75)
    MakeCharacterPhysics(inst, 500, inst.physicsradiusoverride)

    inst.AnimState:SetBank("beetletaur")
    inst.AnimState:SetBuild("lavaarena_beetletaur")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst.AnimState:AddOverrideBuild("fossilized")

    inst:AddTag("LA_mob")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("largecreature")
    inst:AddTag("epic")

    inst:AddTag("fossilizable")

    inst._bufftype = net_tinybyte(inst.GUID, "beetletaur._bufftype", "bufftypedirty")
    inst._camerafocus = net_bool(inst.GUID, "beetletaur._camerafocus", "camerafocusdirty")

    inst._spawnflower = net_event(inst.GUID, "beetletaur._spawnflower")
    inst:ListenForEvent("beetletaur._spawnflower", OnSpawnFlower)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("bufftypedirty", OnBuffTypeDirty)
        inst:ListenForEvent("camerafocusdirty", OnCameraFocusDirty)

        return inst
    end

    inst.EnableCameraFocus = EnableCameraFocus

	inst:AddComponent("locomotor")
	inst.components.locomotor.runspeed = 10
	inst.components.locomotor.walkspeed = 4
	
	inst:AddComponent("knownlocations")	

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(42500)
	
	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(200)
	inst.components.combat:SetAttackPeriod(2)
	inst.components.combat:SetRetargetFunction(5, ReTarget)
	inst.components.combat:SetRange(3)
	
    inst:AddComponent("sanityaura")
    inst:AddComponent("sleeper")
	
   inst:AddComponent("inspectable")	
   
 	inst.attacks = {body_slam = true, combo = 0, uppercut = false, tantrum = false, buff = false}
    inst.modes = {attack = false, guard = true}
    inst.attack_body_slam_ready = true
    inst.is_guarding = false
    inst.avoid_heal_auras = true
	------------------------------------------
	inst:AddComponent("healthtrigger")
    inst.components.healthtrigger:AddTrigger(0.9, AttackModeTrigger)
    inst.components.healthtrigger:AddTrigger(0.8, AttackAndGuardModeTrigger)
    inst.components.healthtrigger:AddTrigger(0.5, Combo2Trigger)
    inst.components.healthtrigger:AddTrigger(0.25, InfiniteComboTrigger)
	------------------------------------------
	inst.recentlycharged = {}
    inst.Physics:SetCollisionCallback(OnCollideDestroyObject)
	------------------------------------------
	inst.components.combat.battlecryenabled = false 
	inst.components.combat.onhitotherfn = OnHitOther
	------------------------------------------
    MakeHauntablePanic(inst)
	MakeMediumBurnableCharacter(inst, "body")  
	
	local sg = require "stategraphs/SGbeetletaur"
    inst:SetStateGraph("SGbeetletaur")	
	

	local brain = require "brains/beetletaurbrain"
	inst:SetBrain(brain)	

    return inst
end

--------------------------------------------------------------------------

local function MakeFossilizedBreakFX(anim, side, interrupted)
    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst:AddTag("FX")
        inst.Transform:SetFourFaced()
        ------------------------------------------
        --Leave this out of pristine state to force animstate to be dirty later
        --inst.AnimState:SetBank("beetletaur")
        inst.AnimState:SetBuild("fossilized")
        inst.AnimState:PlayAnimation(anim)
        ------------------------------------------
        if not interrupted then
            inst.AnimState:OverrideSymbol("rock", "lavaarena_beetletaur", "rock")
            inst.AnimState:OverrideSymbol("rock2", "lavaarena_beetletaur", "rock2")
        end
        ------------------------------------------
        if side:len() > 0 then
            inst.AnimState:Hide(side == "right" and "fx_lavarock_L" or "fx_lavarock_R")
        end
        ------------------------------------------
        inst.entity:SetPristine()
        ------------------------------------------
        if not TheWorld.ismastersim then
            return inst
        end
        ------------------------------------------
        inst.persists = false
        inst:ListenForEvent("animover", ErodeAway)
        ------------------------------------------
        return inst
    end

    return Prefab("beetletaur_"..anim..(side:len() > 0 and ("_"..side) or "")..(interrupted and "_alt" or ""), fn, assets)
end

return Prefab("beetletaur", fn, assets, prefabs),
    MakeFossilizedBreakFX("fossilized_break_fx", "right", false),
    MakeFossilizedBreakFX("fossilized_break_fx", "left", false),
    MakeFossilizedBreakFX("fossilized_break_fx", "left", true),
    MakeFossilizedBreakFX("fossilized_break_fx", "", true)
