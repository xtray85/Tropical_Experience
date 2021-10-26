local prefabs =
{
    "shadow_despawn",
    "statue_transition_2",
    "nightmarefuel",
}

local brain = require "brains/shadow_knightbrain"

local function OnAttacked(inst, data)
if data.attacker ~= nil then
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, function(dude)
        return dude:HasTag("shadowminion2")
            and not dude.components.health:IsDead()
            and dude.components.follower ~= nil
            and dude.components.follower.leader == inst.components.follower.leader
    end, 10)
end
end

local function retargetfn(inst)
local player = GetClosestInstWithTag("player", inst, 70)
if player then return inst.components.combat:SetTarget(player) end
end

local function spearfn(inst)
    inst.components.health:SetMaxHealth(TUNING.SHADOWWAXWELL_LIFE)
    inst.components.health:StartRegen(TUNING.SHADOWWAXWELL_HEALTH_REGEN, TUNING.SHADOWWAXWELL_HEALTH_REGEN_PERIOD)

    inst.components.combat:SetDefaultDamage(TUNING.SHADOWWAXWELL_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.SHADOWWAXWELL_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(2, retargetfn) --Look for leader's target.
--    inst.components.combat:SetKeepTargetFunction(keeptargetfn) --Keep attacking while leader is near.

    return inst
end

local function nodebrisdmg(inst, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
    return afflicter ~= nil and afflicter:HasTag("quakedebris")
end

local armas = 
{
"swap_spear",
"swap_spike",
"swap_nightmaresword_shadow",
"swap_hammer",
"swap_shovel",
"swap_axe",
"swap_pickaxe",
"swap_machete",
"swap_ham_bat",

}

local capa =
{
"hat_straw",
"hat_top",
"hat_beefalo",
"hat_feather",
"hat_bee",
"hat_miner",
"hat_spider",
"hat_football",
"hat_earmuffs",
"hat_winter",
"hat_bush",
"hat_flower",
"hat_walrus",
"hat_slurtle",
"hat_ruins",
"hat_mole",
"hat_wathgrithr",
"hat_ice",
"hat_rain",
"hat_catcoon",
"hat_watermelon",
"hat_eyebrella",
"hat_red_mushroom",
"hat_green_mushroom",
"hat_blue_mushroom",
"hat_hive",
"hat_dragonhead",
"hat_dragonbody",
"hat_dragontail",
"hat_desert",
"hat_goggles",
"hat_skeleton",
}

local function MakeMinion(prefab, tool, hat, master_postinit)
local assets =
    {
        Asset("ANIM", "anim/waxwell_shadow_mod.zip"),
        Asset("SOUND", "sound/maxwell.fsb"),
    }
	
    local function fn()
        local inst = CreateEntity()
	
		
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeGhostPhysics(inst, 1, 0.5)

        inst.Transform:SetFourFaced(inst)
		local valoraleatorio = math.random(8,15)/10
		inst.Transform:SetScale(valoraleatorio, valoraleatorio, valoraleatorio)

        inst.AnimState:SetBank("wilson")
        inst.AnimState:SetBuild("waxwell_shadow_mod")
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:SetMultColour(0, 0, 0, .5)

local tool = armas[math.random(8)]
local hat = capa[math.random(32)]		
		
        if tool ~= nil then
            inst.AnimState:OverrideSymbol("swap_object", tool, tool)
            inst.AnimState:Hide("ARM_normal")
        else
            inst.AnimState:Hide("ARM_carry")
        end

        if hat ~= nil then
            inst.AnimState:OverrideSymbol("swap_hat", hat, "swap_hat")
            inst.AnimState:Hide("HAIR_NOHAT")
            inst.AnimState:Hide("HAIR")
        else
            inst.AnimState:Hide("HAT")
            inst.AnimState:Hide("HAIR_HAT")
        end

        inst:AddTag("scarytoprey")
        inst:AddTag("shadowminion2")
        inst:AddTag("NOBLOCK")

        inst:SetPrefabNameOverride("shadowwaxwell")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("locomotor")
        inst.components.locomotor.runspeed = TUNING.SHADOWWAXWELL_SPEED
        inst.components.locomotor.pathcaps = { ignorecreep = true }
        inst.components.locomotor:SetSlowMultiplier(.6)

        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(1)
        inst.components.health.nofadeout = true
        inst.components.health.redirect = nodebrisdmg

        inst:AddComponent("combat")
        inst.components.combat.hiteffectsymbol = "torso"
        inst.components.combat:SetRange(2)
		inst.components.health:SetMaxHealth(TUNING.SHADOWWAXWELL_LIFE)
		inst.components.health:StartRegen(TUNING.SHADOWWAXWELL_HEALTH_REGEN, TUNING.SHADOWWAXWELL_HEALTH_REGEN_PERIOD)
		inst.components.combat:SetDefaultDamage(TUNING.SHADOWWAXWELL_DAMAGE)
		inst.components.combat:SetAttackPeriod(TUNING.SHADOWWAXWELL_ATTACK_PERIOD)
		inst.components.combat:SetRetargetFunction(2, retargetfn) --Look for leader's target.
	
	
        inst:AddComponent("follower")
        inst.components.follower:KeepLeaderOnAttacked()
        inst.components.follower.keepdeadleader = true

        inst:SetBrain(brain)
        inst:SetStateGraph("SGshadowwaxwell")

        inst:ListenForEvent("attacked", OnAttacked)

        if master_postinit ~= nil then
            master_postinit(inst)
        end

        return inst
    end

    return Prefab(prefab, fn, assets, prefabs)
end

--------------------------------------------------------------------------

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function onbuilt(inst, builder)
    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local radius = math.random(3, 6)
    local offset = FindWalkableOffset(pt, theta, radius, 12, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
    builder.components.petleash:SpawnPetAt(pt.x, 0, pt.z, inst.pettype)
    inst:Remove()
end

local function MakeBuilder(prefab)
    --These shadows are summoned this way because petleash needs to
    --be the component that summons the pets, not the builder.
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()

        inst:AddTag("CLASSIFIED")

        --[[Non-networked entity]]
        inst.persists = false

        --Auto-remove if not spawned by builder
        inst:DoTaskInTime(0, inst.Remove)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.pettype = prefab
        inst.OnBuiltFn = onbuilt

        return inst
    end

    return Prefab(prefab.."_builder", fn, nil, { prefab })
end

--------------------------------------------------------------------------


return MakeMinion("shadowtroop")