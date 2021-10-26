local assets =
{
    Asset("ANIM", "anim/beefalo_basic.zip"),
    Asset("ANIM", "anim/beefalo_actions.zip"),
    Asset("ANIM", "anim/beefalo_shaved_build.zip"),
    Asset("ANIM", "anim/quagmire_beefalo_override_build.zip"),
}

local prefabs =
{
    "meat",
    "poop",
    "beefalowool",
}

local old = {"meat","meat","meat","meat","beefalowool"}

local sounds =
{
    walk = "dontstarve/beefalo/walk",
    grunt = "dontstarve/beefalo/grunt",
    yell = "dontstarve/beefalo/yell",
    swish = "dontstarve/beefalo/tail_swish",
    curious = "dontstarve/beefalo/curious",
    angry = "dontstarve/beefalo/angry",
    sleep = "dontstarve/beefalo/sleep",
}

local brain = require "brains/babybeefalobrain"
--local brain = require("brains/beefalobrain")

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, function(dude)
        return dude:HasTag("beefalo") and not dude:HasTag("player") and not dude.components.health:IsDead()
    end, 5)
end

local function FollowGrownBeefalo(inst)
    local nearest = FindEntity(inst, 30, function(guy)
        return guy.components.leader
            and guy.components.leader:CountFollowers() < 1
    end,
    {"beefalo", "herdmember"}, -- only follow herd beefalo (i.e. nondomesticated)
    {"baby"}
    )
    if nearest and nearest.components.leader then
        nearest.components.leader:AddFollower(inst)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.Transform:SetSixFaced()

    inst.DynamicShadow:SetSize(6, 2)

    inst.AnimState:SetBank("beefalo")
    inst.AnimState:SetBuild("beefalo_shaved_build")
    inst.AnimState:AddOverrideBuild("quagmire_beefalo_override_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("HEAT")	
	
	inst.AnimState:OverrideSymbol("swap_saddle", "quagmire_beefalo_override_build", "")	
	   
    inst:AddTag("beefalo")
    inst:AddTag("old")
    inst:AddTag("animal")

    --herdmember (from herdmember component) added to pristine state for optimization
    inst:AddTag("herdmember")
    inst:AddTag("canbeslaughtered")

    MakeCharacterPhysics(inst, 100, .75)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.sounds = sounds

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.BABYBEEFALO_HEALTH)

    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot(old)

    inst:AddComponent("inspectable")
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)

    inst:AddComponent("knownlocations")
    inst:AddComponent("herdmember")
    inst:AddComponent("follower")
    inst.components.follower.canaccepttarget = true

    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("poop")
    inst.components.periodicspawner:SetRandomTimes(80, 110)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()

    MakeMediumBurnableCharacter(inst, "beefalo_body")

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 2
    inst.components.locomotor.runspeed = 6
	
	

    MakeHauntablePanic(inst)

    inst:DoTaskInTime(1, FollowGrownBeefalo)

    inst:SetBrain(brain)

    inst:SetStateGraph("SGqBeefalo")

    inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

return Prefab("quagmire_beefalo", fn, assets, prefabs)
