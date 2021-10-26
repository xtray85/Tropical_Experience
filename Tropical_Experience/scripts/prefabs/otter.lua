local assets =
{
    Asset("ANIM", "anim/otter_basic.zip"),
    Asset("ANIM", "anim/otter_basic_water.zip"),
    Asset("ANIM", "anim/otter_build.zip"),
    Asset("SOUND", "sound/hound.fsb"),
}

local prefabs =
{
    "monstermeat",
}

local brain = require("brains/otterbrain")

local sounds =
{
    pant = "dontstarve_DLC003/creatures/boss/roc/attack_3",
    attack = "dontstarve_DLC003/creatures/boss/roc/attack_3",
    bite = "dontstarve_DLC003/creatures/boss/roc/attack_3",
    bark = "dontstarve_DLC003/creatures/boss/roc/attack_3",
    death = "dontstarve_DLC003/creatures/boss/roc/attack_3",
    sleep = "dontstarve_DLC003/creatures/boss/roc/attack_3",
    growl = "dontstarve/creatures/hound/pant",
    howl = "dontstarve/creatures/hound/pant",
    hurt = "dontstarve_DLC003/creatures/boss/roc/attack_3",	
}

SetSharedLootTable('otter',
{
    {'monstermeat', 1.000},
})


local WAKE_TO_FOLLOW_DISTANCE = 8
local SLEEP_NEAR_HOME_DISTANCE = 10
local SHARE_TARGET_DIST = 30
local HOME_TELEPORT_DIST = 30

local NO_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO" }
local FREEZABLE_TAGS = { "freezable" }

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or (inst.components.follower and inst.components.follower.leader and not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE))
end

local function ShouldSleep(inst)
    return inst:HasTag("pet_otter")
        and not TheWorld.state.isday
        and not (inst.components.combat and inst.components.combat.target)
        and not (inst.components.burnable and inst.components.burnable:IsBurning())
        and (not inst.components.homeseeker or inst:IsNear(inst.components.homeseeker.home, SLEEP_NEAR_HOME_DISTANCE))
end

local function OnNewTarget(inst, data)
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function retargetfn(inst)

    return nil
end

local function KeepTarget(inst, target)
    return inst:IsNear(target, TUNING.SQUID_TARGET_KEEP)
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST,
        function(dude)
            return not (dude.components.health ~= nil and dude.components.health:IsDead())
                and (dude:HasTag("otter"))
                and data.attacker ~= (dude.components.follower ~= nil and dude.components.follower.leader or nil)
        end, 5)
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST,
        function(dude)
            return not (dude.components.health ~= nil and dude.components.health:IsDead())
                and (dude:HasTag("otter"))
                and data.target ~= (dude.components.follower ~= nil and dude.components.follower.leader or nil)
        end, 5)
end

local function GetReturnPos(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local rad = 2
    local angle = math.random() * 2 * PI
    return x + rad * math.cos(angle), y, z - rad * math.sin(angle)
end

local function DoReturn(inst)
    --print("DoReturn", inst)
    if inst.components.homeseeker ~= nil and inst.components.homeseeker:HasHome() then
        if inst:HasTag("pet_otter") then
            if inst.components.homeseeker.home:IsAsleep() and not inst:IsNear(inst.components.homeseeker.home, HOME_TELEPORT_DIST) then
                inst.Physics:Teleport(GetReturnPos(inst.components.homeseeker.home))
            end
        elseif inst.components.homeseeker.home.components.childspawner ~= nil then
            inst.components.homeseeker.home.components.childspawner:GoHome(inst)
        end
    end
end

local function OnEntitySleep(inst)
    --print("OnEntitySleep", inst)
    if not TheWorld.state.isday then
        DoReturn(inst)
    end
end

local function OnStopDay(inst)
    --print("OnStopDay", inst)
    if inst:IsAsleep() then
        DoReturn(inst)
    end
end

local function OnSpawnedFromHaunt(inst)
    if inst.components.hauntable ~= nil then
        inst.components.hauntable:Panic()
    end
end

local function OnSave(inst, data)
    data.ispet = inst:HasTag("pet_otter") or nil
    --print("OnSave", inst, data.ispet)
end

local function OnLoad(inst, data)
    --print("OnLoad", inst, data.ispet)
    if data ~= nil and data.ispet then
        inst:AddTag("pet_otter")
        if inst.sg ~= nil then
            inst.sg:GoToState("idle")
        end
    end
end

local function GetStatus(inst)
    return (inst.sg:HasStateTag("statue") and "STATUE")
        or nil
end

local function OnStartFollowing(inst, data)
    if inst.leadertask ~= nil then
        inst.leadertask:Cancel()
        inst.leadertask = nil
    end
    if data == nil or data.leader == nil then
        inst.components.follower.maxfollowtime = nil
    elseif data.leader:HasTag("player") then
        inst.components.follower.maxfollowtime = TUNING.HOUNDWHISTLE_EFFECTIVE_TIME * 1.5
    else
        inst.components.follower.maxfollowtime = nil
        if inst.components.entitytracker:GetEntity("leader") == nil then
            inst.components.entitytracker:TrackEntity("leader", data.leader)
        end
    end
end

local function RestoreLeader(inst)
    inst.leadertask = nil
    local leader = inst.components.entitytracker:GetEntity("leader")
    if leader ~= nil and not leader.components.health:IsDead() then
        inst.components.follower:SetLeader(leader)
        leader:PushEvent("restoredfollower", { follower = inst })
    end
end

local function OnStopFollowing(inst)
    inst.leader_offset = nil
    if not inst.components.health:IsDead() then
        local leader = inst.components.entitytracker:GetEntity("leader")
        if leader ~= nil and not leader.components.health:IsDead() then
            inst.leadertask = inst:DoTaskInTime(.2, RestoreLeader)
        end
    end
end

local function CanMutateFromCorpse(inst)
    if not TUNING.SPAWN_MUTATED_HOUNDS then return false end
	if (inst.components.amphibiouscreature == nil or not inst.components.amphibiouscreature.in_water)
		and math.random() <= TUNING.MUTATEDHOUND_SPAWN_CHANCE then

		local x, y, z = inst.Transform:GetWorldPosition()
		return TheWorld.Map:IsInLunacyArea(x, y, z)
	end
	return false
end

local function OnReelingIn(inst, doer)
    if inst:HasTag("partiallyhooked") then
        -- now fully hooked!
        inst:RemoveTag("partiallyhooked")
        inst.components.oceanfishable.queue_struggling = true
        inst.components.oceanfishable.struggling = true
    end
end

local function geteatchance(inst,target)
    return 0.3
end

local function fncommon(bank, build, morphlist, custombrain, tag, data)
	data = data or {}

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .5)

    inst.DynamicShadow:SetSize(2.5, 1.5)
--    inst.Transform:SetFourFaced()
	inst.Transform:SetSixFaced()
	inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)

    inst:AddTag("scarytoprey")
    inst:AddTag("scarytooceanprey")
    inst:AddTag("otter")
 	inst:AddTag("walrus")
	inst:AddTag("houndfriend")	
    inst:AddTag("canbestartled")

    if tag ~= nil then
        inst:AddTag(tag)
    end

    inst.AnimState:SetBank(bank)
    inst.AnimState:SetBuild(build)
    inst.AnimState:PlayAnimation("idle")

    inst:AddComponent("spawnfader")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst._CanMutateFromCorpse = data.canmutatefn

    inst.sounds = sounds

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.HOUND_SWIM_SPEED + 1

    inst:SetStateGraph("SGotter")

    if data.amphibious then
		inst:AddComponent("embarker")
--		inst.components.embarker.embark_speed = inst.components.locomotor.runspeed
--        inst.components.embarker.antic = true

	    inst.components.locomotor:SetAllowPlatformHopping(true)

		inst:AddComponent("amphibiouscreature")
		inst.components.amphibiouscreature:SetBanks(bank, bank.."_water")
        inst.components.amphibiouscreature:SetEnterWaterFn(
            function(inst)
                inst.landspeed = inst.components.locomotor.runspeed
                inst.components.locomotor.runspeed = TUNING.HOUND_SPEED - 1
                inst.hop_distance = inst.components.locomotor.hop_distance
                inst.components.locomotor.hop_distance = 4
            end)
        inst.components.amphibiouscreature:SetExitWaterFn(
            function(inst)
                if inst.landspeed then
                    inst.components.locomotor.runspeed = inst.landspeed
                end
                if inst.hop_distance then
                    inst.components.locomotor.hop_distance = inst.hop_distance
                end
            end)

		inst.components.locomotor.pathcaps = { allowocean = true }
	end



    inst:SetBrain(brain)

    inst:AddComponent("follower")
    inst:AddComponent("entitytracker")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.HOUND_HEALTH)

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.HOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.HOUND_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetHurtSound(inst.sounds.hurt)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('otter')

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("knownlocations")
    inst:AddComponent("timer")

        inst:AddComponent("eater")
        inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
        inst.components.eater:SetCanEatHorrible()
        inst.components.eater:SetStrongStomach(true) -- can eat monster meat!

        inst:AddComponent("sleeper")
        inst.components.sleeper:SetResistance(3)
        inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
        inst.components.sleeper:SetSleepTest(ShouldSleep)
        inst.components.sleeper:SetWakeTest(ShouldWakeUp)
        inst:ListenForEvent("newcombattarget", OnNewTarget)

            MakeHauntablePanic(inst)

    inst:AddComponent("oceanfishable")
    inst.components.oceanfishable.onreelinginfn = OnReelingIn
    inst.components.oceanfishable.max_run_speed = TUNING.SQUID_RUNSPEED
    inst.components.oceanfishable:StrugglingSetup(nil, TUNING.SQUID_RUNSPEED, TUNING.SQUID_FISHABLE_STAMINA)
	inst.components.oceanfishable.catch_distance = -1


    inst:WatchWorldState("stopday", OnStopDay)
    inst.OnEntitySleep = OnEntitySleep
	
    inst.geteatchance = geteatchance	

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
    inst:ListenForEvent("stopfollowing", OnStopFollowing)

    return inst
end

local function fndefault()
    local inst = fncommon("otter_basics", "otter_build", nil, nil, nil, {amphibious = true})

    if not TheWorld.ismastersim then
        return inst
    end

    MakeMediumFreezableCharacter(inst, "hound_body")
    MakeMediumBurnableCharacter(inst, "hound_body")

    return inst
end

return Prefab("otter", fndefault, assets, prefabs)
