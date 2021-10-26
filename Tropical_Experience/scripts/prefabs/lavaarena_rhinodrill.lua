local assets =
{
    Asset("ANIM", "anim/lavaarena_rhinodrill_basic.zip"),
    Asset("ANIM", "anim/lavaarena_rhinodrill_damaged.zip"),
    Asset("ANIM", "anim/lavaarena_battlestandard.zip"),
    Asset("ANIM", "anim/wilson_fx.zip"),
    Asset("ANIM", "anim/fossilized.zip"),
}

local assets_alt =
{
    Asset("ANIM", "anim/lavaarena_rhinodrill_basic.zip"),
    Asset("ANIM", "anim/lavaarena_rhinodrill_clothed_b_build.zip"),
    Asset("ANIM", "anim/lavaarena_rhinodrill_damaged.zip"),
    Asset("ANIM", "anim/lavaarena_battlestandard.zip"),
    Asset("ANIM", "anim/wilson_fx.zip"),
    Asset("ANIM", "anim/fossilized.zip"),
}

local prefabs =
{
    "fossilizing_fx",
    "rhinodrill_fossilized_break_fx_right",
    "rhinodrill_fossilized_break_fx_left",
    "rhinodrill_fossilized_break_fx",
    "rhinobuff",
    "rhinobumpfx",
    "lavaarena_creature_teleport_small_fx",
}

--------------------------------------------------------------------------

local function DoPulse(inst)
    inst.task = nil
    if inst.level > 0 then
        inst:Show()
        inst.AnimState:PlayAnimation("attack_fx3")
    else
        inst:Remove()
    end
end

local function OnPulseAnimOver(inst)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    if inst.level >= 7 then
        inst.AnimState:PlayAnimation("attack_fx3")
    elseif inst.level > 0 then
        inst.task = inst:DoTaskInTime(3.5 - inst.level * .5, DoPulse)
        inst:Hide()
    else
        inst:Remove()
    end
end

local function CreatePulse()
    local inst = CreateEntity()
    inst:AddTag("DECOR") --"FX" will catch mouseover
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("lavaarena_battlestandard")
    inst.AnimState:SetBuild("lavaarena_battlestandard")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst:Hide()
    inst.level = 0
    inst.task = inst:DoTaskInTime(1, DoPulse)
    inst:ListenForEvent("animover", OnPulseAnimOver)

    return inst
end

local function OnBuffLevelDirty(inst)
    --Dedicated server does not need to spawn the local fx
    if not TheNet:IsDedicated() then
        if inst.buff_fx ~= nil then
            inst.buff_fx.level = 0
            inst.buff_fx = nil
        end
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end		
        if inst._bufflevel:value() > 0 then
            inst.buff_fx = CreatePulse()
            inst.buff_fx.entity:SetParent(inst.entity)
            inst.buff_fx.level = inst._bufflevel:value()
        end
        local fx = SpawnPrefab("rhinocebro_buff_fx")
        fx.entity:SetParent(inst.entity)
        fx.entity:AddFollower()
        fx.Follower:FollowSymbol(inst.GUID, "head", 0, 0, 0)
        fx.Transform:SetPosition(0, 0, 0)		
    end
end

local function SetBuffLevel(inst, level)
print(inst.bro_stacks)
    level = math.clamp(level, 0, 7)
    inst.bro_stacks = level
    if inst._bufflevel:value() ~= level then
	inst.components.combat:SetDefaultDamage(75 + 25 * inst.bro_stacks)	
    inst._bufflevel:set(level)
    OnBuffLevelDirty(inst)
    end
end

--------------------------------------------------------------------------
local function KnockbackOnHit(inst, target, radius, attack_knockback, strength_mult, force_land)
    if target.sg and target.sg.sg.states.knockback then
        target:PushEvent("knockback", {knocker = inst, radius = radius, strengthmult = strength_mult, forcelanded = force_land})
    else
        Knockback(inst, target, radius, attack_knockback)
    end
end

local function OnHitOther(inst, target)
    if inst.sg:HasStateTag("charging") then
        KnockbackOnHit(inst, target, 2, 2)
    end
end

local function DamagedTrigger(inst)
    inst.components.healthtrigger:RemoveTrigger(0.2)
    inst.AnimState:AddOverrideBuild("lavaarena_rhinodrill_damaged" .. inst.damagedtype)
end

local function IsTrueDeath(inst)
	if inst.bro and inst.bro.components.health and inst.bro.components.health:IsDead() then
		return true, {inst.bro}
	else
		return nil, nil
	end
end

local function CanBeRevivedBy(inst, reviver)
    return not reviver:HasTag("player") and reviver:HasTag("LA_mob")
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

local function MakeRhinoDrill(name, alt)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddDynamicShadow()
        inst.entity:AddNetwork()

		inst:SetPhysicsRadiusOverride(1)
		MakeCharacterPhysics(inst, 400, inst.physicsradiusoverride)
		inst.DynamicShadow:SetSize(2.75, 1.25)
		inst.Transform:SetSixFaced()
		inst.Transform:SetScale(1.15, 1.15, 1.15)		

        inst.AnimState:SetBank("rhinodrill")
        inst.AnimState:SetBuild("lavaarena_rhinodrill_basic")
        inst.AnimState:OverrideSymbol("fx_wipe", "wilson_fx", "fx_wipe")
        if alt then
            inst.AnimState:AddOverrideBuild("lavaarena_rhinodrill_clothed_b_build")
        end
        inst.AnimState:PlayAnimation("idle_loop", true)

        inst.AnimState:AddOverrideBuild("fossilized")

        inst:AddTag("LA_mob")
        inst:AddTag("Arena")
        inst:AddTag("monster")
        inst:AddTag("hostile")
        inst:AddTag("nostun")
        inst:AddTag("largecreature")
        inst:AddTag("fossilizable")		

        inst._bufflevel = net_tinybyte(inst.GUID, "rhinodrill._bufflevel", "buffleveldirty")
        inst._camerafocus = net_bool(inst.GUID, "rhinodrill._camerafocus", "camerafocusdirty")

	inst:AddComponent("revivablecorpse")
    inst.components.revivablecorpse:SetCanBeRevivedByFn(CanBeRevivedBy)
	inst.components.revivablecorpse:SetReviveHealthPercent(0.2)
	inst.components.revivablecorpse:SetReviveSpeedMult(0.5)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            inst:ListenForEvent("buffleveldirty", OnBuffLevelDirty)
            return inst
        end
	
	inst:AddComponent("healthtrigger")
	inst.components.healthtrigger:AddTrigger(0.2, DamagedTrigger)
	inst:AddComponent("bloomer")
	
	inst:AddComponent("knownlocations")
	
	inst:AddComponent("locomotor")
	inst.components.locomotor.runspeed = 7

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(12750)
	inst.components.health.nofadeout = true
	
	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(150)
	inst.components.combat:SetAttackPeriod(3)
	inst.components.combat:SetRetargetFunction(5, ReTarget)
	inst.components.combat:SetRange(4.5)
	
    inst:AddComponent("sanityaura")
    inst:AddComponent("sleeper")

    ------------------------------------------

    inst:AddComponent("inspectable")


	inst.attack_charge_ready = true
    inst.cheer_ready = false
	inst.bro_stacks = 0
	inst.damagedtype = ""
    inst.SetBuffLevel = SetBuffLevel
	------------------------------------------
	inst:DoTaskInTime(0, function(inst)
		if inst.bro then
			inst.IsTrueDeath = IsTrueDeath
		end
	end)
	------------------------------------------
	inst:DoTaskInTime(15, function(inst)
        inst.cheer_ready = true
    end)
	------------------------------------------
	inst.components.combat.onhitotherfn = OnHitOther
	------------------------------------------
    MakeHauntablePanic(inst)
	MakeMediumBurnableCharacter(inst, "body")

	local sg = require "stategraphs/SGrhinodrill"
    inst:SetStateGraph("SGrhinodrill")	

	local brain = require "brains/rhinodrillbrain"
	inst:SetBrain(brain)

        return inst
    end

    return Prefab(name, fn, alt and assets_alt or assets, prefabs)
end

local function MakeFossilizedBreakFX(side)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst:AddTag("FX")

        inst.Transform:SetSixFaced()
        inst.AnimState:SetBuild("fossilized")
        inst.AnimState:PlayAnimation("fossilized_break_fx")

        if side:len() > 0 then
            inst.AnimState:Hide(side == "right" and "fx_lavarock_L" or "fx_lavarock_R")
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false
        inst:ListenForEvent("animover", ErodeAway)

        return inst
    end

    return Prefab(side:len() > 0 and ("rhinodrill_fossilized_break_fx_"..side) or "rhinodrill_fossilized_break_fx", fn, assets)
end

local function bros_fn(sim)
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
    ------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end
    ------------------------------------------
    inst:DoTaskInTime(0, function(inst)
        local pos = inst:GetPosition()
        local bro_1 = SpawnPrefab("rhinodrill")
        bro_1.Transform:SetPosition(pos:Get())
        local bro_2 = SpawnPrefab("rhinodrill2")
        bro_2.Transform:SetPosition(pos:Get())
        bro_1.bro = bro_2
        bro_2.bro = bro_1
        inst:Remove()
    end)
    ------------------------------------------
    return inst
end

local function fx_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("lavaarena_rhino_buff_effect")
    inst.AnimState:SetBuild("lavaarena_rhino_buff_effect")
    inst.AnimState:PlayAnimation("in")
    inst.AnimState:PushAnimation("idle", false)
    inst.AnimState:PushAnimation("out", false)
    inst.Transform:SetSixFaced()
	------------------------------------------
    inst:AddTag("DECOR") --"FX" will catch mouseover
    inst:AddTag("NOCLICK")
	------------------------------------------
    inst.entity:SetPristine()
	------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end
	------------------------------------------
	inst.persists = false
	------------------------------------------
	inst:ListenForEvent("animqueueover", inst.Remove)
	------------------------------------------
    return inst
end

return MakeRhinoDrill("rhinodrill"),
    MakeRhinoDrill("rhinodrill2", true),
	Prefab("rhinodrillbros", bros_fn, assets, prefabs),
	Prefab("rhinocebro_buff_fx", fx_fn)