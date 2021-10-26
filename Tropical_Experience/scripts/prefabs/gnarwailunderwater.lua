local assets =
{
    Asset("ANIM", "anim/gnarwail.zip"),
    Asset("ANIM", "anim/gnarwail_build.zip"),
    Asset("ANIM", "anim/gnarwil_den.zip"),
}

local water_shadow_assets =
{
    Asset("ANIM", "anim/gnarwail_water_shadow.zip"),
    Asset("ANIM", "anim/gnarwail_build.zip"),
}

local attack_horn_prefabs =
{
    "gnarwail_horn",
}

local prefabs =
{
    "fishmeat",
}

local gnar_brain = require "brains/gnarwailunderwaterbrain"

local gnarwail_loot_horn = {"fishmeat", "fishmeat", "fishmeat", "fishmeat", "gnarwail_horn"}
local gnarwail_loot = {"fishmeat", "fishmeat", "fishmeat", "fishmeat"}


-- We try to leverage FindSwimmableOffset to identify a resurface location that is in the ocean and not under a boat.
local function TryGnarwailResurface(gnarwail_instance, horn_position)
    local resurface_radius = TUNING.MAX_WALKABLE_PLATFORM_RADIUS + TUNING.MAX_WALKABLE_PLATFORM_RADIUS + gnarwail_instance:GetPhysicsRadius(0)
    local emerge_offset = FindSwimmableOffset(Vector3(unpack(horn_position)), math.random() * PI * 2, resurface_radius)
    if emerge_offset then
        gnarwail_instance:ReturnToScene()
        gnarwail_instance.Transform:SetPosition(horn_position[1] + emerge_offset.x, horn_position[2] + emerge_offset.y, horn_position[3] + emerge_offset.z)
        gnarwail_instance.sg:GoToState("emerge")
    else
        gnarwail_instance:DoTaskInTime(1, TryGnarwailResurface, horn_position)
    end
end

local function horn_retreat(horn_inst, horn_broken, leak_size)
if horn_broken then
horn_inst.criatura:SetHornBroken(true)
end
horn_inst:Remove()
end

local function OnHornHit(horn_inst)
    if not horn_inst.components.health:IsDead() then
        horn_inst.AnimState:PlayAnimation("pierce_hit")
    end
end

local function HornAttack_AnimOver(horn_inst)
    horn_retreat(horn_inst, false, "med_leak")
end

local function EndHornAttack(horn_inst)
    horn_inst.AnimState:PushAnimation("attack_early_retreat", false)
    horn_inst:ListenForEvent("animqueueover", HornAttack_AnimOver)
    horn_inst._horn_attack_ending = true
    horn_inst:RemoveEventCallback("attacked", OnHornHit)
end

local function HornBroken_AnimOver(horn_inst)
    horn_retreat(horn_inst, true, "small_leak")
end

local function HornBrokenWide_AnimOver(horn_inst)
    horn_retreat(horn_inst, true, "med_leak")
end

local function OnAttackHornKilled(horn_inst)
    horn_inst.components.lootdropper:DropLoot()
    if horn_inst._retreat_timer then
        horn_inst._retreat_timer:Cancel()
        horn_inst._retreat_timer = nil
    end

    horn_inst.AnimState:OverrideSymbol("gn_main_horn", "gnarwail_build", "gn_main_horn_broken")
    if not horn_inst._horn_attack_ending then
        -- If the horn attack started ending, we already hooked up an animqueueover to do the medium-sized leak.
        -- So, just don't hook anything up, because we'll do the right thing.
        horn_inst:RemoveEventCallback("attacked", OnHornHit)
        horn_inst:ListenForEvent("animqueueover", HornBroken_AnimOver)
        horn_inst.AnimState:PlayAnimation("attack_early_retreat", false)
    else
        horn_inst:RemoveEventCallback("animqueueover", HornAttack_AnimOver)
        horn_inst:ListenForEvent("animqueueover", HornBrokenWide_AnimOver)
        horn_inst.AnimState:PlayAnimation("attack_stage_2_retreat", false)
    end
end

local function OnHornSave(inst, data)
    data.gnarwail_record = inst.gnarwail_record
end

local function OnHornLoad(inst, data)
    if data and data.gnarwail_record then
        inst.gnarwail_record = data.gnarwail_record
    end
end

local MUST_RETARGET_TAGS = {"_combat", "monster"}
local MUST_NOT_RETARGET_TAGS = {"epic", "playermonster"}
local function RetargetFunction(inst)
    if inst:IsInLimbo() then
        return nil
    end
    return FindEntity(inst, TUNING.GNARWAIL.TARGET_DISTANCE + 0.5, nil, MUST_RETARGET_TAGS, MUST_NOT_RETARGET_TAGS)
end

local function GetStatus(inst)
    local has_leader = inst.components.follower.leader ~= nil
    local broken_horn = inst:HornIsBroken()
    return (has_leader and broken_horn and "BROKENHORN_FOLLOWER") or
            (has_leader and "FOLLOWER") or
            (broken_horn and "BROKENHORN") or
            nil
end

local function ShouldAcceptItem(inst, item)
    return inst.components.eater:CanEat(item) and
        (
            inst.components.follower:GetLeader() == nil or
            inst.components.follower:GetLoyaltyPercent() <= TUNING.GNARWAIL.FULL_LOYALTY_PERCENT
        )
end

local function OnGetItemFromPlayer(inst, giver, item)
    if inst.components.combat:TargetIs(giver) then
        inst.components.combat:SetTarget(nil)
    elseif giver.components.leader ~= nil then
        giver:PushEvent("makefriend")
        giver.components.leader:AddFollower(inst)

        inst.components.follower:AddLoyaltyTime(item.components.edible:GetHunger(inst) * TUNING.GNARWAIL.LOYALTY_PER_HUNGER)
    end

    inst.components.eater:Eat(item, giver)
    inst:PushEvent("onfedbyplayer", {food = item, feeder = giver})
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
end

local function OnTimerFinished(inst, data)
    if data.name == "resettoss" then
        inst.ready_to_toss = true
    end
end

local function OnSave(inst, data)
    data.horn_broken = inst._horn_broken

    if inst.ready_to_toss == false then
        data.ready_to_toss = false
    end

    if inst._formation_angle ~= nil then
        data.formation_angle = inst._formation_angle
    end
end

local function OnLoad(inst, data)
    if data then
        if data.horn_broken ~= nil then
            inst:SetHornBroken(data.horn_broken)
        end

        if data.ready_to_toss == false then
            -- Our reset timer should have been saved via the timer component,
            -- so just set ourselves back to false.
            inst.ready_to_toss = false
        end

        if data.formation_angle ~= nil then
            inst._formation_angle = data.formation_angle
        end
    end
end

local function WantsToTossItem(inst, item)
    -- NOTE: We assume that everything we're asked about CAN be tossed; we're just checking whether we want to.
    local leader = inst.components.follower:GetLeader()
    if leader then
        return item.components.health == nil
    else
        -- Without a leader, we only toss fish that we want to eat.
        return item:HasTag("ediblefish_meat")
    end
end

local function TossItem(inst, item, target_to_toss_to)
    if item:HasTag("oceanfish") then
        local item_loots = (item.fish_def and item.fish_def.loot) or nil
        if item_loots ~= nil then
            local ix, iy, iz = item.Transform:GetWorldPosition()
            local owner = item
            for _, loot_prefab in pairs(item_loots) do
                local loot = SpawnPrefab(loot_prefab)
                loot.Transform:SetPosition(ix, iy, iz)
                item = loot
            end
            owner:Remove()
        end
    end

    if target_to_toss_to and target_to_toss_to:IsValid() then
        LaunchAt(item, inst, target_to_toss_to, 5, 2, nil, 0)
    else
        Launch2(item, inst, 2, 0, 2, 0)
    end

    if item.components.inventoryitem then
        item.components.inventoryitem:SetLanded(false, true)
    end

    inst.ready_to_toss = false
    inst.components.timer:StartTimer("resettoss", TUNING.GNARWAIL.TOSS_DELAY)
end

local UP_VECTOR = Vector3(0, 1, 0)
local SEPARATION_AMOUNT = 25.0
local SEPARATION_MUST_NOT_TAGS = {"flying", "FX", "DECOR", "INLIMBO"}
local SEPARATION_MUST_ONE_TAGS = {"blocker", "gnarwail"}
local MAX_STEER_FORCE = 2.0
local MAX_STEER_FORCE_SQ = MAX_STEER_FORCE*MAX_STEER_FORCE
local DESIRED_BOAT_DISTANCE = TUNING.MAX_WALKABLE_PLATFORM_RADIUS + 4
local function GetFormationOffsetNormal(inst, leader, leader_platform, leader_velocity)
    if leader == nil or leader_platform == nil or leader.components.leader == nil then
        return Vector3(1, 0, 0)
    end

    local my_location = inst:GetPosition()

    -- calculate desired position
    local leader_p_position = leader_platform:GetPosition()
    local mtlp_normal, mtlp_length = (leader_p_position - my_location):GetNormalizedAndLength()

    local leader_direction, leader_speed = leader_velocity:GetNormalizedAndLength()
    local my_locomotor = inst.components.locomotor
    local inst_move_speed = (my_locomotor.isrunning and my_locomotor:GetRunSpeed()) or my_locomotor:GetWalkSpeed()
    local speed = math.min(leader_speed, inst_move_speed)

    -- separation steering --
    local separation_steering = Vector3(0, 0, 0)
    local mx, my, mz = inst.Transform:GetWorldPosition()
    local separation_entities = TheSim:FindEntities(mx, my, mz, SEPARATION_AMOUNT, nil, SEPARATION_MUST_NOT_TAGS, SEPARATION_MUST_ONE_TAGS)
    local separation_affecting_ents_count = 0
    for _, se in ipairs(separation_entities) do
        if se ~= inst then
            -- Generate a vector pointing directly away from this entity, length inversely proportional to its distance away
            local se_to_me_normal, se_to_me_length = (my_location - se:GetPosition()):GetNormalizedAndLength()
            separation_steering = separation_steering + (se_to_me_normal * speed / se_to_me_length)
            separation_affecting_ents_count = separation_affecting_ents_count + 1
        end
    end
    if separation_affecting_ents_count > 0 then
        separation_steering = separation_steering / separation_affecting_ents_count
    end
    if separation_steering:LengthSq() > 0 then
        local recalculated_separation_steering = (separation_steering:Normalize() * speed) - (mtlp_normal * speed)
        if recalculated_separation_steering:LengthSq() > MAX_STEER_FORCE_SQ then
            recalculated_separation_steering = recalculated_separation_steering:GetNormalized() * MAX_STEER_FORCE
        end
        separation_steering = recalculated_separation_steering
    end
    -- separation steering --
    
    local desired_position_offset = mtlp_normal * (mtlp_length - DESIRED_BOAT_DISTANCE)
    return desired_position_offset + separation_steering
end

local function HornIsBroken(inst)
    return inst._horn_broken
end

local function SetHornBroken(inst, horn_is_broken)
    if horn_is_broken and not inst._horn_broken then
        inst.AnimState:OverrideSymbol("gn_main_horn", "gnarwail_build", "gn_main_horn_broken")
        inst.components.lootdropper:SetLoot(gnarwail_loot)
        inst._horn_broken = true
    elseif not horn_is_broken and (inst._horn_broken == nil or inst._horn_broken) then
        inst.AnimState:ClearOverrideSymbol("gn_main_horn")
        inst.components.lootdropper:SetLoot(gnarwail_loot_horn)
        inst._horn_broken = false
    end
end

local DESIRED_BOAT_DISTANCESQ = DESIRED_BOAT_DISTANCE * DESIRED_BOAT_DISTANCE
local function OnUpdateSpeed(inst)
    if inst.sg:HasStateTag("diving") then
        return
    end

    local leader = inst.components.follower.leader
    if leader and leader:IsValid() then
        local leader_platform = leader:GetCurrentPlatform()
        if leader_platform then
            local plat_physics = leader_platform.components.boatphysics
            if plat_physics then
                local desired_velocity = plat_physics:GetVelocity()
                if inst:GetDistanceSqToInst(leader_platform) > DESIRED_BOAT_DISTANCESQ + 1 then
                    desired_velocity = desired_velocity + 0.1
                end

                -- Match our leader's boat's speed, clamped between our run speed and walk speed
                inst.components.locomotor.runspeed = math.min(
                    TUNING.GNARWAIL.RUN_SPEED,
                    math.max(
                        desired_velocity,
                        TUNING.GNARWAIL.WALK_SPEED
                    )
                )
            end
        end
    end
end

local UPDATE_RATE = 1
local function OnStartFollowingLeader(inst, data)
    if inst._speed_update_task == nil then
        inst._speed_update_task = inst:DoPeriodicTask(UPDATE_RATE, OnUpdateSpeed)
    end
end

local function OnStopFollowingLeader(inst, data)
    if inst._speed_update_task ~= nil then
        inst._speed_update_task:Cancel()
        inst._speed_update_task = nil
    end

    inst.components.locomotor.runspeed = TUNING.GNARWAIL.RUN_SPEED
end

local function PlayAnimation(inst, anim_name, loop)
    inst.AnimState:PlayAnimation(anim_name, loop or false)
--    if inst._water_shadow ~= nil then
--        inst._water_shadow.AnimState:PlayAnimation(anim_name, loop or false)
--    end
end

local function PushAnimation(inst, anim_name, loop)
    inst.AnimState:PushAnimation(anim_name, loop or false)
--    if inst._water_shadow ~= nil then
--        inst._water_shadow.AnimState:PushAnimation(anim_name, loop or false)
--    end
end

local function RemoveShadowOnDeath(inst, data)
--    if inst._water_shadow and inst._water_shadow:IsValid() then
--        inst._water_shadow:DoTaskInTime(inst.components.health.destroytime or 2, ErodeAway)
--    end
end

local function UpdateShadowRotation(inst)
--    if inst._water_shadow then
--        inst._water_shadow.Transform:SetRotation(inst.Transform:GetRotation())
--    end
end

local function gnarwail()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

 --   local phys = MakeGiantCharacterPhysics(inst, 100000, 1.25)
	MakeObstaclePhysics(inst, 1.25)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
--    inst.Physics:CollidesWith(COLLISION.ITEMS)
	
    inst.Physics:TEMPHACK_DisableSleepDeactivation() -- TODO @stevenm we need a better solution for the issue of gnarwails popping onto boats.

    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("gnarwail")
    inst.AnimState:SetBuild("gnarwail_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
	
	inst.AnimState:OverrideSymbol("cave_water", "gnarwail_build", "")
	inst.AnimState:OverrideSymbol("leak_part", "gnarwail_build", "")
	inst.AnimState:OverrideSymbol("ripple_test", "gnarwail_build", "")
	inst.AnimState:OverrideSymbol("shadow_ripple", "gnarwail_build", "")
	inst.AnimState:OverrideSymbol("splash", "gnarwail_build", "")
	inst.AnimState:OverrideSymbol("water_line", "gnarwail_build", "")	

--    AddDefaultRippleSymbols(inst, true, false)

    inst:AddTag("animal")
    inst:AddTag("gnarwail")
    inst:AddTag("hostile")
--    inst:AddTag("scarytoprey")
    inst:AddTag("scarytocookiecutters")

    inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

    ------------------------------------------

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.GNARWAIL.HEALTH)

    ------------------------------------------

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.GNARWAIL.DAMAGE)
--    inst.components.combat:SetRange(TUNING.GNARWAIL.TARGET_DISTANCE, TUNING.GNARWAIL.DAMAGE_RADIUS)
--    inst.components.combat:SetAreaDamage(TUNING.GNARWAIL.DAMAGE_RADIUS)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRetargetFunction(2, RetargetFunction)

    ------------------------------------------

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 0 --TUNING.GNARWAIL.WALK_SPEED
    inst.components.locomotor.runspeed = 0 --TUNING.GNARWAIL.RUN_SPEED
--    inst.components.locomotor.pathcaps = { allowocean = true, ignoreLand = true }

    ------------------------------------------

    inst:AddComponent("lootdropper")

    ------------------------------------------

    inst:AddComponent("sleeper")

    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    ------------------------------------------

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false

    ------------------------------------------

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater.strongstomach = true

    ------------------------------------------

    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.GNARWAIL.MAX_LOYALTY_TIME

    ------------------------------------------

    inst:AddComponent("timer")

    ------------------------------------------
	
 --   inst:AddComponent("playerprox")
--    inst.components.playerprox:SetDist(8, 10 )
--    inst.components.playerprox:SetOnPlayerNear(function(inst) inst.sg:GoToState("emerge") end)
--    inst.components.playerprox:SetOnPlayerFar(function(inst) if not inst.sg:HasStateTag("hide") then inst.sg:GoToState("hide_pre") end end)
	

    MakeHauntablePanic(inst)
    MakeLargeFreezableCharacter(inst)

    inst.PlayAnimation = PlayAnimation
    inst.PushAnimation = PushAnimation

    inst:SetStateGraph("SGgnarwailunderwater")

    inst:SetBrain(gnar_brain)

    inst:ListenForEvent("attacked", OnAttacked)
--    inst:ListenForEvent("timerdone", OnTimerFinished)
--    inst:ListenForEvent("startfollowing", OnStartFollowingLeader)
--    inst:ListenForEvent("stopfollowing", OnStopFollowingLeader)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst.ready_to_toss = true
    inst.WantsToToss = WantsToTossItem
    inst.TossItem = TossItem

    inst.GetFormationOffsetNormal = GetFormationOffsetNormal

    inst.HornIsBroken = HornIsBroken
    inst.SetHornBroken = SetHornBroken
    if not POPULATING then
        inst:SetHornBroken(false)
    end
	
	inst.buraco2 = SpawnPrefab("gnarwailholefundo")
	inst.buraco2.entity:SetParent(inst.entity)
	inst.buraco2.Transform:SetPosition(0, -0.1, 0)	
--	inst.buraco2.AnimState:PlayAnimation("eyes_loop", true)
	
	inst.buraco1 = SpawnPrefab("gnarwailholefrente")
	inst.buraco1.entity:SetParent(inst.entity)
	inst.buraco1.Transform:SetPosition(0, 0.1, 0)		

    return inst
end

local function fn1()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    anim:SetBank("gnarwil_den")
    anim:SetBuild("gnarwil_den")
    anim:PlayAnimation("frente", true)
	inst.Transform:SetScale(0.8, 0.8, 0.8)
	
	inst:AddTag("FX")

	return inst
end

local function fn2()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    anim:SetBank("gnarwil_den")
    anim:SetBuild("gnarwil_den")
    anim:PlayAnimation("fundo", true)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(25)		
	inst.Transform:SetScale(0.8, 0.8, 0.8)
	
	inst:AddTag("FX")

	return inst
end

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
    local criatura = SpawnPrefab("gnarwailunderwater")
    criatura.Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst:Remove()
    end
end

local respawndays = 8

local function fn3()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    anim:SetBank("gnarwil_den")
    anim:SetBuild("gnarwil_den")
    anim:PlayAnimation("fundo", true)
	inst.Transform:SetScale(0.8, 0.8, 0.8)
	MakeObstaclePhysics(inst, 1.25)	
	
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)	
	return inst
end

local function gnarwail_attack_horn()
    local horn_inst = CreateEntity()

    horn_inst.entity:AddTransform()
    horn_inst.entity:AddAnimState()
    horn_inst.entity:AddSoundEmitter()
    horn_inst.entity:AddNetwork()

    horn_inst.AnimState:SetBank("gnarwail")
    horn_inst.AnimState:SetBuild("gnarwail_build")
    horn_inst.AnimState:OverrideSymbol("cave_water", "gnarwail_build", "")
    horn_inst.AnimState:OverrideSymbol("leak_part", "gnarwail_build", "")
    horn_inst.AnimState:OverrideSymbol("ripple_test", "gnarwail_build", "")
    horn_inst.AnimState:OverrideSymbol("shadow_ripple", "gnarwail_build", "")
    horn_inst.AnimState:OverrideSymbol("splash", "gnarwail_build", "")
    horn_inst.AnimState:OverrideSymbol("water_line", "gnarwail_build", "")	
    horn_inst.AnimState:PlayAnimation("attack", false)
    horn_inst.AnimState:PushAnimation("attack_idle", true)

--    horn_inst:SetPrefabNameOverride("GNARWAIL")

    horn_inst:AddTag("gnarwail")
    horn_inst:AddTag("hostile")
    horn_inst:AddTag("soulless")

    horn_inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return horn_inst
    end

    horn_inst:AddComponent("combat")
    horn_inst:AddComponent("health")
    horn_inst.components.health:SetMaxHealth(TUNING.GNARWAIL.HORN_HEALTH)
    horn_inst.components.health.nofadeout = true

    horn_inst:ListenForEvent("death", OnAttackHornKilled)
    horn_inst:ListenForEvent("attacked", OnHornHit)

    horn_inst:AddComponent("lootdropper")
    horn_inst.components.lootdropper:SetLoot({"gnarwail_horn"})

    horn_inst:AddComponent("inspectable")
    horn_inst.components.inspectable.nameoverride = "gnarwail"

    horn_inst:AddComponent("hauntable")
    horn_inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)

    horn_inst._retreat_timer = horn_inst:DoTaskInTime(TUNING.GNARWAIL.HORN_RETREAT_TIME/2, EndHornAttack)

    horn_inst.OnSave = OnHornSave
    horn_inst.OnLoad = OnHornLoad

    horn_inst._horn_attack_ending = false

    return horn_inst
end

return Prefab("gnarwailunderwater", gnarwail, assets, prefabs),
	   Prefab("gnarwailholefrente", fn1, assets, prefabs), 
	   Prefab("gnarwailholefundo", fn2, assets, prefabs),
	   Prefab("gnarwailholefundofinal", fn3, assets, prefabs),	   
       Prefab("gnarwail_attack_hornunderwater", gnarwail_attack_horn, assets, attack_horn_prefabs)

