local assets =
{
    Asset("ANIM", "anim/wildbeaverguard_build.zip"),
    Asset("ANIM", "anim/werebeaver_dance.zip"),
    Asset("ANIM", "anim/werepig_basic.zip"),
    Asset("ANIM", "anim/werebeaver_groggy.zip"),
    Asset("ANIM", "anim/werepig_actions.zip"),
    Asset("SOUND", "sound/pig.fsb"),
}

local prefabs =
{
    "meat",
    "monstermeat",
    "poop",
    "tophat",
    "strawhat",
    "pigskin",
}

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local function ontalk(inst, script)
    inst.SoundEmitter:PlaySound("dontstarve/pig/grunt")
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnEat(inst, food)
    if food.components.edible ~= nil then
        if food.components.edible.foodtype == FOODTYPE.VEGGIE then
            SpawnPrefab("poop").Transform:SetPosition(inst.Transform:GetWorldPosition())
        elseif food.components.edible.foodtype == FOODTYPE.MEAT and
            inst.components.werebeast ~= nil and
            not inst.components.werebeast:IsInWereState() and
            food.components.edible:GetHealth(inst) < 0 then
            inst.components.werebeast:TriggerDelta(1)
        end
    end
end

local function OnAttackedByDecidRoot(inst, attacker)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, SpringCombatMod(SHARE_TARGET_DIST) * .5, { "_combat", "_health", "pig" }, { "werepig", "wildbeaverguard", "INLIMBO" })
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
    return dude:HasTag("wildbeaver")
end

local function IsWerePig(dude)
    return dude:HasTag("werepig")
end

local function IsNonWerePig(dude)
    return dude:HasTag("wildbeaver") and not dude:HasTag("werepig")
end

local function IsGuardPig(dude)
    return dude:HasTag("wildbeaver")
end

local function OnAttacked(inst, data)
    --print(inst, "OnAttacked")
    local attacker = data.attacker
    inst:ClearBufferedAction()

    if attacker.prefab == "deciduous_root" and attacker.owner ~= nil then 
        OnAttackedByDecidRoot(inst, attacker.owner)
    elseif attacker.prefab ~= "deciduous_root" then
        inst.components.combat:SetTarget(attacker)

        if inst:HasTag("werepig") then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, IsWerePig, MAX_TARGET_SHARES)
        elseif inst:HasTag("wildbeaverguard") then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, attacker:HasTag("wildbeaver") and IsGuardPig or IsPig, MAX_TARGET_SHARES)
        elseif not (attacker:HasTag("wildbeaver") and attacker:HasTag("wildbeaverguard")) then
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, IsNonWerePig, MAX_TARGET_SHARES)
        end
    end
end

local function SuggestTreeTarget(inst, data)
    if data ~= nil and data.tree ~= nil and inst:GetBufferedAction() ~= ACTIONS.CHOP then
        inst.tree_target = data.tree
    end
end

local function GuardRetargetFn(inst)
    --defend the king, then the torch, then myself
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    local defendDist = SpringCombatMod(TUNING.PIG_GUARD_DEFEND_DIST)
    local defenseTarget =
        FindEntity(inst, defendDist, nil, { "beaverking" }) or
        (home ~= nil and inst:IsNear(home, defendDist) and home) or
        inst
	local defenseTarget1 = FindEntity(inst, defendDist*2, nil, { "beaverking" })

    if not defenseTarget.happy then
        local invader = FindEntity(defenseTarget, SpringCombatMod(TUNING.PIG_GUARD_TARGET_DIST), nil, { "character" }, { "wildbeaverguard", "INLIMBO" })
        if invader ~= nil and not defenseTarget1 and
            not (defenseTarget.components.trader ~= nil and defenseTarget.components.trader:IsTryingToTradeWithMe(invader)) and
            not (inst.components.trader ~= nil and inst.components.trader:IsTryingToTradeWithMe(invader)) then
            return invader
        end

        if not TheWorld.state.isday and home ~= nil and home.components.burnable ~= nil and home.components.burnable:IsBurning() then
            local lightThief = FindEntity(
                home,
                home.components.burnable:GetLargestLightRadius(),
                function(guy)
                    return guy.LightWatcher:IsInLight()
                        and not (defenseTarget.components.trader ~= nil and defenseTarget.components.trader:IsTryingToTradeWithMe(guy))
                        and not (inst.components.trader ~= nil and inst.components.trader:IsTryingToTradeWithMe(guy))
                end,
                { "player" }
            )
            if lightThief ~= nil then
                return lightThief
            end
        end
    end
    return FindEntity(defenseTarget, defendDist, nil, { "monster" }, { "INLIMBO" })
end

local function GuardKeepTargetFn(inst, target)
    if not inst.components.combat:CanTarget(target) or
        (target.sg ~= nil and target.sg:HasStateTag("transform")) or
        (target:HasTag("wildbeaverguard") and target:HasTag("wildbeaver")) then
        return false
    end

    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    if home == nil then
        return true
    end

    local defendDist = not TheWorld.state.isday
                    and home.components.burnable ~= nil
                    and home.components.burnable:IsBurning()
                    and home.components.burnable:GetLargestLightRadius()
                    or SpringCombatMod(TUNING.PIG_GUARD_DEFEND_DIST)
    return target:IsNear(home, defendDist) and inst:IsNear(home, defendDist)
end

local guardbrain = require "brains/wildbeaverguardbrain"

local function common()
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
	

    inst.AnimState:SetBuild("werebeaver_build")
	inst.AnimState:SetBank("werebeaver")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("hat")

    inst:AddTag("character")
    inst:AddTag("scarytoprey")
    inst:AddTag("wildbeaverguard")
	inst:AddTag("wildbeaver")
	
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter()
	inst.components.talker.ontalk = ontalk
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
   
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED
    inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED
    ------------------------------------------
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetCanEatRaw()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    inst.components.eater:SetOnEatFn(OnEat)
    ------------------------------------------
    inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.PIG_GUARD_HEALTH)
	
    inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.PIG_GUARD_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.PIG_GUARD_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(GuardKeepTargetFn)
    inst.components.combat:SetRetargetFunction(1, GuardRetargetFn)
    inst.components.combat:SetTarget(nil)
    inst.components.combat.hiteffectsymbol = "pig_torso"
    MakeMediumBurnableCharacter(inst, "pig_torso")

    ------------------------------------------
    MakeHauntablePanic(inst)

    ------------------------------------------
    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.PIG_LOYALTY_MAXTIME
	inst.components.follower:SetLeader(nil)
    ------------------------------------------
	
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")		

    inst:AddComponent("inventory")

    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({})
    inst.components.lootdropper:AddRandomLoot("meat", 3)
    inst.components.lootdropper:AddRandomLoot("beaverskin", 1)
    inst.components.lootdropper.numrandomloot = 1

    inst:AddComponent("knownlocations")
    MakeMediumFreezableCharacter(inst, "pig_torso")

    inst:AddComponent("inspectable")
    ------------------------------------------

    inst:ListenForEvent("attacked", OnAttacked)
	
	inst:SetBrain(guardbrain)
    inst:SetStateGraph("SGwildbeaver")

    return inst
end

return Prefab("wildbeaverguard", common, assets, prefabs)

