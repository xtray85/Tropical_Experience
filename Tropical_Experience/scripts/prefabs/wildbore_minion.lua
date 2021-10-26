local assets =
{
    Asset("ANIM", "anim/ds_pig_basic.zip"),
    Asset("ANIM", "anim/ds_pig_actions.zip"),
    Asset("ANIM", "anim/ds_pig_attacks.zip"),
    Asset("ANIM", "anim/ds_pig_elite.zip"),
    Asset("ANIM", "anim/ds_pig_elite_intro.zip"),
    Asset("ANIM", "anim/wildbore_elite_build.zip"),	
    Asset("ANIM", "anim/pig_build.zip"),
    Asset("ANIM", "anim/pigspotted_build.zip"),
    Asset("ANIM", "anim/pig_guard_build.zip"),
    Asset("ANIM", "anim/werepig_build.zip"),
    Asset("ANIM", "anim/werepig_basic.zip"),
    Asset("ANIM", "anim/werepig_actions.zip"),
    Asset("ANIM", "anim/slide_puff.zip"),	
    Asset("SOUND", "sound/pig.fsb"),
    Asset("ANIM", "anim/wildbore_build.zip"),	
}

local prefabs =
{
    --"meat",
    "monstermeat",
    "poop",
    "tophat",
    "strawhat",
    "pigskin",
}


local normalbrain = require "brains/wildboreguardbrain"

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local function ontalk(inst, script)
    inst.SoundEmitter:PlaySound("dontstarve/pig/grunt")
end

local function GuardShouldSleep(inst)
    return false
end

local function GuardShouldWake(inst)
    return true
end


local function CalcSanityAura(inst, observer)
    return -TUNING.SANITYAURA_LARGE / 10
end

local function ShouldAcceptItem(inst, item)
    return false
end

local function OnGetItemFromPlayer(inst, giver, item)
end

local function OnRefuseItem(inst, item)
end

local function OnEat(inst, food)
end

local function IsSquadAlreadyTargeting(inst, target, rangesq, checkfn)
    local x, y, z = target.Transform:GetWorldPosition()
    for k, v in pairs(inst.components.squadmember:GetOtherMembers()) do
        if checkfn(k, target) and k:GetDistanceSqToPoint(x, y, z) < rangesq and
            not (k.sg:HasStateTag("knockback") or
                k.components.health.takingfiredamage or
                k.components.hauntable.panic or
                k.components.sleeper:IsAsleep() or
                k.components.freezable:IsFrozen()) then
            return true
        end
    end
    return false
end

local function OnAttackedByDecidRoot(inst, attacker)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, SpringCombatMod(SHARE_TARGET_DIST) * .5, { "_combat", "_health", "pig" }, { "werepig", "guard", "INLIMBO" })
    local num_helpers = 0
    for i, v in ipairs(ents) do
        if v ~= inst and not v.components.health:IsDead() then
            v:PushEvent("suggest_tree_target", { tree = attacker })
            num_helpers = num_helpers + 1
            if num_helpers >= MAX_TARGET_SHARES then
                break
            end
        end
    end
end

local function IsPig(dude)
    return dude:HasTag("pig")
end

local function IsWerePig(dude)
    return dude:HasTag("werepig")
end

local function IsNonWerePig(dude)
    return dude:HasTag("pig") and not dude:HasTag("werepig")
end

local function IsGuardPig(dude)
    return dude:HasTag("guard") and dude:HasTag("pig")
end

local function OnAttacked(inst, data)
    --print(inst, "OnAttacked")
    local attacker = data.attacker

    if attacker.prefab == "pigking" then
        return
    end

    inst:ClearBufferedAction()

    if attacker.prefab == "deciduous_root" and attacker.owner ~= nil then 
        OnAttackedByDecidRoot(inst, attacker.owner)
    elseif attacker.prefab ~= "deciduous_root" then
        inst.components.combat:SetTarget(attacker)

        if inst:HasTag("werepig") then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, IsWerePig, MAX_TARGET_SHARES)
        elseif inst:HasTag("guard") then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, attacker:HasTag("pig") and IsGuardPig or IsPig, MAX_TARGET_SHARES)
        elseif not (attacker:HasTag("pig") and attacker:HasTag("guard")) then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, IsNonWerePig, MAX_TARGET_SHARES)
        end
    end
end

local function OnNewTarget(inst, data)
    if inst:HasTag("werepig") then
        inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, IsWerePig, MAX_TARGET_SHARES)
    end
end

local builds = {"wildbore_build"}
local guardbuilds = { "wildbore_build" }

local function NormalRetargetFn(inst)
    return FindEntity(
        inst,
        TUNING.PIG_TARGET_DIST,
        function(guy)
            return 
                inst.components.combat:CanTarget(guy)
                and guy.prefab ~="pigking"
        end,
        { "player", "epic", "_combat" }, -- see entityreplica.lua
        { "playerghost", "INLIMBO" }
    )
end

local function NormalKeepTargetFn(inst, target)
    --give up on dead guys, or guys in the dark, or werepigs
    return inst.components.combat:CanTarget(target)
        and not (target.sg ~= nil and target.sg:HasStateTag("transform"))
end

local function NormalShouldSleep(inst)
    return false
end


local function SetNormalPig(inst)
    inst:RemoveTag("werepig")
    inst:RemoveTag("guard")
    inst:SetBrain(normalbrain)
    inst.AnimState:SetBuild("wildbore_build")

	inst.variation = inst.variation
	if inst.variation == nil then inst.variation = math.random(1,4) end
    inst:SetStateGraph("SGpigminion")		
	inst.sg.mem.variation = inst.variation	
	
	if inst.variation == 1 then
	inst.AnimState:OverrideSymbol("pig_arm", "wildbore_elite_build", "pig_arm_3")	
--	inst.AnimState:OverrideSymbol("pig_ear", "wildbore_elite_build", "pig_ear_1")
--	inst.AnimState:OverrideSymbol("pig_head", "wildbore_elite_build", "pig_head_1")
	inst.AnimState:OverrideSymbol("pig_skirt", "wildbore_elite_build", "pig_skirt_1")
	inst.AnimState:OverrideSymbol("pig_torso", "wildbore_elite_build", "pig_torso_1")
	inst.AnimState:OverrideSymbol("spin_bod", "wildbore_elite_build", "spin_bod_1")
	end
	
	if inst.variation == 2 then
	inst.AnimState:OverrideSymbol("pig_arm", "wildbore_elite_build", "pig_arm_2")	
--	inst.AnimState:OverrideSymbol("pig_ear", "wildbore_elite_build", "pig_ear_2")
--	inst.AnimState:OverrideSymbol("pig_head", "wildbore_elite_build", "pig_head_2")
	inst.AnimState:OverrideSymbol("pig_skirt", "wildbore_elite_build", "pig_skirt_2")
	inst.AnimState:OverrideSymbol("pig_torso", "wildbore_elite_build", "pig_torso_2")
	inst.AnimState:OverrideSymbol("spin_bod", "wildbore_elite_build", "spin_bod_2")
	end

	if inst.variation == 3 then

--	inst.AnimState:OverrideSymbol("pig_ear", "wildbore_elite_build", "pig_ear_3")
--	inst.AnimState:OverrideSymbol("pig_head", "wildbore_elite_build", "pig_head_3")
	inst.AnimState:OverrideSymbol("pig_skirt", "wildbore_elite_build", "pig_skirt_3")
	inst.AnimState:OverrideSymbol("pig_torso", "wildbore_elite_build", "pig_torso_3")
	inst.AnimState:OverrideSymbol("spin_bod", "wildbore_elite_build", "spin_bod_3")
	end

	if inst.variation == 4 then
	inst.AnimState:OverrideSymbol("pig_head", "wildbore_elite_build", "pig_head_4")
	inst.AnimState:OverrideSymbol("pig_skirt", "wildbore_elite_build", "pig_skirt_4")
	inst.AnimState:OverrideSymbol("pig_torso", "wildbore_elite_build", "pig_torso_4")
	inst.AnimState:OverrideSymbol("spin_bod", "wildbore_elite_build", "spin_bod_4")
	end	
	
    inst.components.werebeast:SetOnNormalFn(SetNormalPig)
    inst.components.sleeper:SetResistance(2)

    inst.components.combat:SetDefaultDamage(TUNING.PIG_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.PIG_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)
    inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED
    inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED

    inst.components.sleeper:SetSleepTest(GuardShouldSleep)
    inst.components.sleeper:SetWakeTest(GuardShouldWake)

    inst.components.health:SetMaxHealth(TUNING.PIG_HEALTH)
    inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)
    inst.components.combat:SetTarget(nil)

    inst.components.trader:Enable()
    inst.components.talker:StopIgnoringAll("becamewerepig")
end

local function SetGuardPig(inst)
    inst:RemoveTag("werepig")
    inst:AddTag("guard")
    inst:SetBrain(normalbrain)
    inst:SetStateGraph("SGpig")
    inst.AnimState:SetBuild(inst.build)

    inst.components.werebeast:SetOnNormalFn(SetGuardPig)
    inst.components.sleeper:SetResistance(3)

    inst.components.health:SetMaxHealth(TUNING.PIG_GUARD_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.PIG_GUARD_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.PIG_GUARD_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)
    inst.components.combat:SetRetargetFunction(1, NormalRetargetFn)
    inst.components.combat:SetTarget(nil)
    inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED
    inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED

    inst.components.sleeper:SetSleepTest(GuardShouldSleep)
    inst.components.sleeper:SetWakeTest(GuardShouldWake)

    inst.components.trader:Enable()
    inst.components.talker:StopIgnoringAll("becamewerepig")
    inst.components.follower:SetLeader(nil)
end

local function IsNearMoonBase(inst, dist)
    local moonbase = inst.components.entitytracker:GetEntity("moonbase")
    return moonbase == nil or inst:IsNear(moonbase, dist)
end

local function WerepigSleepTest(inst)
    return false
end

local function WerepigWakeTest(inst)
    return true
end


local function SetWerePig(inst)
    inst:AddTag("werepig")
    inst:RemoveTag("guard")
    inst:SetBrain(normalbrain)
    inst:SetStateGraph("SGwerepig")
    inst.AnimState:SetBuild("werepig_build")
    inst.AnimState:ClearOverrideSymbol("pig_arm")	
    inst.AnimState:ClearOverrideSymbol("pig_ear")	
    inst.AnimState:ClearOverrideSymbol("pig_head")	
    inst.AnimState:ClearOverrideSymbol("pig_skirt")	
    inst.AnimState:ClearOverrideSymbol("pig_torso")	
    inst.AnimState:ClearOverrideSymbol("spin_bod")	
	
    inst.components.sleeper:SetResistance(3)

    inst.components.combat:SetDefaultDamage(TUNING.WEREPIG_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.WEREPIG_ATTACK_PERIOD)
    inst.components.locomotor.runspeed = TUNING.WEREPIG_RUN_SPEED 
    inst.components.locomotor.walkspeed = TUNING.WEREPIG_WALK_SPEED 

    inst.components.sleeper:SetSleepTest(GuardShouldSleep)
    inst.components.sleeper:SetWakeTest(GuardShouldWake)

    inst.components.health:SetMaxHealth(TUNING.WEREPIG_HEALTH)
    inst.components.combat:SetTarget(nil)
    inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)

    inst.components.trader:Disable()
    inst.components.follower:SetLeader(nil)
    inst.components.talker:IgnoreAll("becamewerepig")
end

local function GetStatus(inst)
    return (inst:HasTag("werepig") and "WEREPIG")
        or (inst:HasTag("guard") and "GUARD")
        or (inst.components.follower.leader ~= nil and "FOLLOWER")
        or nil
end

local function displaynamefn(inst)
    return inst.name
end

local function OnSave(inst, data)
    data.build = inst.build
	data.variation = inst.variation
end

local function OnLoad(inst, data)
    if data ~= nil then
		inst.variation = data.variation
        inst.build = data.build or builds[1]
		
if inst.build == "pig_guard_build" then
SetNormalPig(inst)
end	
		
		
        if not inst.components.werebeast:IsInWereState() then
            inst.AnimState:SetBuild(inst.build)
        end
    end
end

local function CustomOnHaunt(inst)
    if not inst:HasTag("werepig") and math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
        local remainingtime = TUNING.TOTAL_DAY_TIME * (1 - TheWorld.state.time)
        local mintime = TUNING.SEG_TIME
        inst.components.werebeast:SetWere(math.max(mintime, remainingtime) + math.random() * TUNING.SEG_TIME)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
    end
end

local function common(moonbeast)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddLightWatcher()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 50, .5)

    inst.DynamicShadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()

    inst:AddTag("character")
    inst:AddTag("pig")
    inst:AddTag("pigminion")
    inst:AddTag("scarytoprey")
    inst.AnimState:SetBank("pigman")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("hat")

    --Sneak these into pristine state for optimization
    inst:AddTag("_named")
	inst.IsSquadAlreadyTargeting = IsSquadAlreadyTargeting

    inst:AddTag("trader")

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    --inst.components.talker.colour = Vector3(133/255, 140/255, 167/255)
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --Remove these tags so that they can be added properly when replicating components below
    inst:RemoveTag("_named")

    if not moonbeast then
        inst.components.talker.ontalk = ontalk
    end

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED --5
    inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED --3

    inst:AddComponent("bloomer")

    ------------------------------------------
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetCanEatRaw()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    inst.components.eater:SetOnEatFn(OnEat)
    ------------------------------------------
    inst:AddComponent("health")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"

    MakeMediumBurnableCharacter(inst, "pig_torso")

    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.PIGNAMES
    inst.components.named:PickNewName()

    ------------------------------------------
    MakeHauntablePanic(inst)

    if not moonbeast then
        inst:AddComponent("werebeast")
        inst.components.werebeast:SetOnWereFn(SetWerePig)
        inst.components.werebeast:SetTriggerLimit(4)

        AddHauntableCustomReaction(inst, CustomOnHaunt, true, nil, true)
    end

    ------------------------------------------
    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.PIG_LOYALTY_MAXTIME
    ------------------------------------------

    inst:AddComponent("inventory")

    ------------------------------------------

    inst:AddComponent("lootdropper")

    ------------------------------------------

    inst:AddComponent("knownlocations")

    ------------------------------------------

    if not moonbeast then
        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        inst.components.trader.onaccept = OnGetItemFromPlayer
        inst.components.trader.onrefuse = OnRefuseItem
        inst.components.trader.deleteitemonaccept = false
    end
    
    ------------------------------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    ------------------------------------------

    inst:AddComponent("sleeper")
	inst:AddComponent("entitytracker")
	inst:AddComponent("squadmember")
	inst.components.squadmember:JoinSquad("pigkingelite4")

    ------------------------------------------
    MakeMediumFreezableCharacter(inst, "pig_torso")

    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus
    ------------------------------------------

    if not moonbeast then
        inst.OnSave = OnSave
        inst.OnLoad = OnLoad
    end

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("newcombattarget", OnNewTarget)

    return inst
end

local function normal()
    local inst = common(false)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.build = builds[1]
    inst.AnimState:SetBuild(inst.build)	
    SetNormalPig(inst)
    return inst
end

local function guard()
    local inst = common(false)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.build = guardbuilds[math.random(#guardbuilds)]
    inst.AnimState:SetBuild(inst.build)
    SetGuardPig(inst)
    return inst
end

return Prefab("pigman_minion", normal, assets, prefabs),
    Prefab("pigguard_minion", guard, assets, prefabs)

