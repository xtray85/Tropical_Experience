require("stategraphs/commonforgestates")

local function ShakeIfClose(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .25, .015, .25, inst, 10)
end

local function ShakePound(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, 0.5, .03, .5, inst, 30)
end

local function ShakeRoar(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, 0.8, .03, .5, inst, 30)
end

local function DoPunchAOE(inst)
inst.components.combat:DoAttack()
end

local function LaunchItems(inst, radius, speed)
	local pos = inst:GetPosition()
	local ents = TheSim:FindEntities(pos.x, 0, pos.z, radius or 3, { "_inventoryitem" }, { "locomotor", "INLIMBO" })
	if #ents > 0 then
		for i, v in ipairs(ents) do
			if not v.components.inventoryitem.nobounce and v.Physics ~= nil and v.Physics:IsActive() then
				Launch(v, inst, speed or 0.2)
			end
		end
	end
end

local function DoGroundPoundAOE(inst)
	inst.components.combat:DoAttack()
	LaunchItems(inst, 7)
end

local function GroundPound(inst)
	ShakePound(inst)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2")
	inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/bodyfall")
    inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/chain_hit")
    DoGroundPoundAOE(inst)
end

local function JumpToPosition(inst, target_pos, total_frames)
    ToggleOffCharacterCollisions(inst)
    inst.sg:AddStateTag("nointerrupt")
    if target_pos then
        local starting_pos = inst:GetPosition()
        inst:ForceFacePoint(target_pos:Get())
        inst.Physics:SetMotorVel(math.sqrt(distsq(starting_pos.x, starting_pos.z, target_pos.x, target_pos.z)) / (total_frames * FRAMES), 0, 0)
    end
end

local function FindDouble(inst, tags)
	local pos = inst:GetPosition()
	local ents = TheSim:FindEntities(pos.x, 0, pos.z, 255, tags)
	local doubles = {}
	if ents and #ents > 0 then
		for i, v in ipairs(ents) do
			if v:IsValid() and v.components.health and not v.components.health:IsDead() and v ~= inst then
				table.insert(doubles, v)
			end
		end
	end
	return #doubles
end

local function GetHealAuras(inst, range)
    local pos = inst:GetPosition()
    local range = range or 8
    local heal_auras = TheSim:FindEntities(pos.x, 0, pos.z, range, {"healingcircle"})
    if heal_auras then
        table.sort(heal_auras, function(a,b)
            local a_distance_sq = distsq(a:GetPosition(), pos)
            local b_distance_sq = distsq(b:GetPosition(), pos)
            return a_distance_sq <= b_distance_sq
        end)
    end
    return heal_auras
end

local function IsTargetInRange(inst, target, range, distance_override)
    local range = (range or 1) + inst:GetPhysicsRadius(0)
    if not target then
        target = inst.components.combat.target
    end
    return target and (distance_override or distsq(target:GetPosition(), inst:GetPosition())) <= range * range
end

local function IsTargetInMeleeRange(inst, target)
    return IsTargetInRange(inst, target, 3)
end

local function IsTargetInBodySlamRange(inst, target)
    local target = target or inst.components.combat.target
    local target_pos = target and target:GetPosition() or inst:GetPosition()
    local distance_to_target = distsq(target_pos, inst:GetPosition())
    local min_range = 3
    return distance_to_target > min_range*min_range and IsTargetInRange(inst, target, 8, distance_to_target)
end

local function ShouldGuard(inst)
    return inst.sg.mem.wants_to_guard or not (inst.modes.attack or inst.is_guarding)
end

local function ShouldBreakGuard(inst)
    return inst.is_guarding and not inst.guard_timer and inst.modes.attack
end

local function ShouldBodySlam(inst)
    local target = inst.components.combat.target
    return not ShouldGuard(inst) and inst.sg.mem.wants_to_slam and inst.attacks.body_slam and inst.attack_body_slam_ready and (IsTargetInBodySlamRange(inst, target) or IsTargetInMeleeRange(inst, target))
end

local function DoBattleCryBuff(inst)
    if inst.modes.attack then
        inst._bufftype:set(2)
        inst.components.combat.battlecryenabled = false -- Taunts are no longer available, instead only Forced Taunts occur which triggers Tantrum
    end
end

local function UnguardedDamageTracker(inst, data)
    if inst.modes.guard then
        inst.total_unguarded_damage = (inst.total_unguarded_damage or 0) + data.damageresolved
        if inst.total_unguarded_damage >= 3000 then
            inst.sg.mem.wants_to_guard = true
        end
    end
end

local function EnterGuardMode(inst)
    inst._bufftype:set(1)
    inst.is_guarding = true
    inst.hit_recovery = 0
--    inst.components.combat:RemoveDamageBuff("beetletaur_battlecry_buff")
--    inst.components.combat:AddDamageBuff("beetletaur_guard_mode_buff", 0.25, true)
    inst.components.combat.ignorehitrange = false
    inst.components.combat:SetAttackPeriod(1.3)
    inst.components.combat:SetHurtSound("dontstarve/creatures/lava_arena/boarrior/bonehit2")
    inst.components.combat.battlecryenabled = false -- Taunts are not available in Guard Mode
    inst.sg.mem.wants_to_slam = nil

	if inst.modes.attack then 
		inst.guard_timer = inst:DoTaskInTime(12, function(inst)
            inst.guard_timer = nil
        end)
	end
    inst:RemoveEventCallback("attacked", UnguardedDamageTracker)
end

local function BreakGuard(inst)
    if inst.guard_timer ~= nil then
        inst.guard_timer:Cancel()
        inst.guard_timer = nil
    end		
    inst._bufftype:set(0)
    inst.is_guarding = false
    inst.hit_recovery = nil
--    inst.components.combat:RemoveDamageBuff("beetletaur_guard_mode_buff", true)
    inst.components.combat.ignorehitrange = true
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetHurtSound(nil)
    inst.components.combat.battlecryenabled = false--true -- no longer in Guard Mode so taunts are available
    inst.total_unguarded_damage = 0
    inst:ListenForEvent("attacked", UnguardedDamageTracker)
end

-- Returns true if the current combo should end.
local function EndCombo(inst, uppercut)
    local current_combo = inst.sg.statemem.current_combo
    local melee_range = IsTargetInMeleeRange(inst)
    -- Reset Body Slam if target ended a combo by running out of range.
    inst.sg.statemem.wants_to_slam = inst.sg.mem.wants_to_slam and melee_range
    -- End combo if completed or if target is dead or target is out of attack range.
    if current_combo >= inst.attacks.combo and not uppercut or not inst.components.combat:IsValidTarget(inst.sg.statemem.target) or not melee_range then
        inst.AnimState:PushAnimation("attack1_pst", false) 
        return true
    end
    return false
end
-----------------------------------------------------
local events = {
    CommonForgeHandlers.OnAttacked(),
    CommonForgeHandlers.OnKnockback(),
    CommonForgeHandlers.OnVictoryPose(),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnFossilize(),
    CommonHandlers.OnFreeze(),
    EventHandler("doattack", function(inst, data)
		if not inst.components.health:IsDead() and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then
            if data.target:HasTag("_isinheals") and inst.attacks.body_slam and inst.attack_body_slam_ready then
                inst.sg:GoToState("body_slam", data)
			elseif inst.is_guarding then
				inst.sg:GoToState("jab")
			else
                local current_time = GetTime()
                if inst.modes.guard and (current_time - inst.components.combat.laststartattacktime) > 5 and not ((current_time - (inst.last_taunt_time or 0)) < 5) then 
                    --inst.sg.mem.wants_to_guard = true
                    inst.sg:GoToState("block_pre")
				elseif (inst.attacks.body_slam and inst.attack_body_slam_ready or inst.sg.mem.wants_to_slam) and IsTargetInBodySlamRange(inst, data.target) then
					inst.sg:GoToState("body_slam", data)
				elseif IsTargetInMeleeRange(inst, data.target) then
					inst.sg:GoToState("attack", data)
				end
			end
		end
	end),
   EventHandler("gotosleep", function(inst)
        if not (inst.sg:HasStateTag("taunting") or inst:HasTag("fossilized") or inst.sg:HasStateTag("hiding") or (inst.components.health and inst.components.health:IsDead())) then
            -- Queue a Body Slam to occur after current attack.
            if inst.sg:HasStateTag("attack") then 
                inst.sg.mem.wants_to_slam = true 
                --inst.components.sleeper.isasleep = false
            elseif not (inst.sg:HasStateTag("nofreeze") or inst.sg:HasStateTag("nointerrupt") or inst:HasTag("fire" or inst.sg.currentstate.name == "sleep")) then 
                inst.sg:GoToState(inst.sg.currentstate.name == "sleeping" and "sleeping" or not inst.sg:HasStateTag("sleeping") and inst.attacks.body_slam and inst.attack_body_slam_ready and "body_slam" or "sleep") 
            end
        end
   end),
	EventHandler("locomote", function(inst, data)
        local is_moving = inst.sg:HasStateTag("moving")
        local is_running = inst.sg:HasStateTag("running")
        local is_idling = inst.sg:HasStateTag("idle")

        local should_move = inst.components.locomotor:WantsToMoveForward()
        local should_run = inst.is_guarding

        if is_moving and not should_move then
            inst.sg:GoToState(is_running and "run_stop" or "walk_stop")
        elseif is_idling and should_move then
            inst.sg:GoToState(should_run and "run_start" or "walk_start")
        end
    end),
	
    EventHandler("attacked", function(inst) 
        if not inst.components.health:IsDead() 
            and not inst.sg:HasStateTag("hit") 
            and not inst.sg:HasStateTag("attack") 
            and not inst.sg:HasStateTag("casting") 
        then 
            inst.sg:GoToState("hit") 
        end 
    end),
	
}

local states = {
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
			inst.components.health:SetInvincible(false)
            inst.Physics:Stop()
            if inst.sg.mem.wants_to_taunt and inst.modes.attack then 
                if not inst.attacks.buff then 
                    inst.sg:GoToState("tantrum")
                else
                    inst.sg:GoToState("taunt")
                end
			elseif ShouldBodySlam(inst) then 
                inst.sg:GoToState("body_slam", {target = inst.components.combat.target})
            elseif inst.sg.mem.sleep_duration then 
                local isasleep = inst.components.sleeper:IsAsleep()
                inst.components.sleeper:GoToSleep(inst.sg.mem.sleep_duration) 
                if isasleep then
                    inst.sg:GoToState("sleep")
                end
            elseif ShouldGuard(inst) then 
                inst.sg:GoToState("block_pre")
            elseif ShouldBreakGuard(inst) then
                inst.sg:GoToState("block_pst")
            else
                if inst.is_guarding then
                    inst.AnimState:PlayAnimation("block_loop", true)
                else
                    inst.AnimState:PlayAnimation("idle_loop", true)
                end
            end
        end,

        onexit = function(inst) 
            inst.sg.mem.wants_to_guard = nil 
            inst.sg.mem.wants_to_taunt = nil
        end,

        events = {
            EventHandler("animover", function(inst)
                -- End Guard
                if ShouldBreakGuard(inst) then
                    inst.sg:GoToState("block_pst")
                end
            end)
        },
    },

	State{
        name = "jab",
        tags = {"attack", "busy"},

		onenter = function(inst)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
    		inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/swipe")
            inst.AnimState:PlayAnimation("block_counter")
    	end,

        timeline = {
            TimeEvent(6*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/attack")
				DoPunchAOE(inst)
			end),
        },

        events = {
			EventHandler("onhitother", function(inst)
				 inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/attack")
			end),
            CommonForgeHandlers.IdleOnAnimOver(),
        },
    },

    State{
        name = "attack", -- initial punch (left hook)
        tags = {"attack", "busy"},

		onenter = function(inst, data)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
    		inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/swipe")
            inst.sg.statemem.current_combo = (data and data.current_combo or 0) + 1
            inst.sg.statemem.target = data and data.target or inst.components.combat.target
            inst.AnimState:PlayAnimation("attack1", false)
    	end,

        onexit = function(inst)
            inst.sg.mem.wants_to_slam = nil 
        end,

        timeline = {
            TimeEvent(6*FRAMES, DoPunchAOE),
        },

        events = {
			EventHandler("onmissother", function(inst) 
				inst.AnimState:PushAnimation("attack1_pst", false)
			end),
            EventHandler("animover", function(inst)
                if inst.sg.statemem.end_combo then
                    -- using statemem check just in case the regular wants_to_slam gets reset during the ending animation.
                    inst.sg:GoToState(inst.sg.statemem.wants_to_slam and "body_slam" or "idle")
                elseif not EndCombo(inst) then
                    inst.sg:GoToState("attack_combo_right_hook", {current_combo = inst.sg.statemem.current_combo, target = inst.sg.statemem.target})
                else
                    inst.sg.statemem.end_combo = true
                end
			end),
        },
    },

	State{
        name = "attack_combo_right_hook",
        tags = {"attack", "busy"},

		onenter = function(inst, data)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
    		inst.sg.statemem.current_combo = (data and data.current_combo or 0) + 1
            inst.sg.statemem.target = data and data.target or inst.components.combat.target
    		inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/swipe")
            inst.AnimState:PlayAnimation("attack2", false)
    	end,

        onexit = function(inst)
            inst.sg.mem.wants_to_slam = nil -- Remove any queued Body Slams because Body Slam is forced at the end of the combo if the right conditions are met. If they are not met Swine should not Body Slam from queue.
        end,

        timeline = {
            TimeEvent(7*FRAMES, DoPunchAOE),
        },

        events = {
			EventHandler("animover", function(inst)
                if inst.sg.statemem.end_combo then
                    inst.sg:GoToState(inst.sg.statemem.wants_to_slam and "body_slam" or "idle")
                elseif not EndCombo(inst, inst.attacks.uppercut) then
                    inst.sg:GoToState(inst.sg.statemem.current_combo >= inst.attacks.combo and inst.attacks.uppercut and "uppercut" or inst.sg.statemem.current_combo < inst.attacks.combo and "attack_combo_left_hook", {current_combo = inst.sg.statemem.current_combo, target = inst.sg.statemem.target})
                else
                    inst.sg.statemem.end_combo = true
                end
			end),
        },
    },

	State{
        name = "attack_combo_left_hook",
        tags = {"attack", "busy"},

		onenter = function(inst, data)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
    		inst.sg.statemem.current_combo = (data and data.current_combo or 0) + 1
            inst.sg.statemem.target = data and data.target or inst.components.combat.target
    		inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/swipe")
            inst.AnimState:PlayAnimation("attack1b", false)
    	end,

        onexit = function(inst)
            inst.sg.mem.wants_to_slam = nil -- Remove any queued Body Slams because Body Slam is forced at the end of the combo if the right conditions are met. If they are not met Swine should not Body Slam from queue.
        end,

        timeline = {
            TimeEvent(7*FRAMES, DoPunchAOE),
        },

        events = {
			EventHandler("animover", function(inst)
                if inst.sg.statemem.end_combo then
                    inst.sg:GoToState(inst.sg.statemem.wants_to_slam and "body_slam" or "idle")
                elseif not EndCombo(inst) then
                    inst.sg:GoToState("attack_combo_right_hook", {current_combo = inst.sg.statemem.current_combo, target = inst.sg.statemem.target})
                else
                    inst.sg.statemem.end_combo = true
                end
			end),
        },
    },

    State{
        name = "uppercut",
        tags = {"attack", "busy", "knockback"}, 

        onenter = function(inst, data)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/swipe")
            inst.AnimState:PlayAnimation("attack3", false)
        end,

        onexit = function(inst)
            inst.sg.mem.wants_to_slam = nil -- Prevent Body Slams right after Uppercuts
        end,

        timeline = {
            TimeEvent(3*FRAMES, DoPunchAOE), -- this does knockback
        },

        events = {
            CommonForgeHandlers.IdleOnAnimOver(),
        },
    },

	State{
        name = "body_slam",
        tags = {"busy", "slamming", "nofreeze", "keepmoving"},

		onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst.components.combat:StartAttack()
    		inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/jump")
			inst.AnimState:PlayAnimation(inst.is_guarding and "bellyflop_block_pre" or "bellyflop_pre", false)
            inst.AnimState:PushAnimation("bellyflop", false)
            local target = data and data.target or inst.components.combat.target
            if inst:HasTag("_isinheals") or target and target:IsValid() and target:HasTag("_isinheals") then
                local heal_auras = GetHealAuras(inst)
                if heal_auras and heal_auras[1] then
                    inst.sg.statemem.override_pos = heal_auras and heal_auras[1] and heal_auras[1]:GetPosition()
                end
            elseif target and target:IsValid() then
                inst:FacePoint(target:GetPosition())
                inst.sg.statemem.target = target
            end
    	end,

    	onexit = function(inst)
    		ToggleOnCharacterCollisions(inst)
        end,

        timeline = {
    		TimeEvent(6*FRAMES, function(inst)
                JumpToPosition(inst, inst.sg.statemem.override_pos or inst.sg.statemem.target and inst.sg.statemem.target:GetPosition(), 25)
				inst.sg:AddStateTag("nostun") --should not be stunned by meteors, etc.	
    if inst.attack_body_slam_cooldown_timer ~= nil then
        inst.attack_body_slam_cooldown_timer:Cancel()
        inst.attack_body_slam_cooldown_timer = nil
    end					
				inst.attack_body_slam_ready = false
				inst.attack_body_slam_cooldown_timer = inst:DoTaskInTime(3, function(inst)
					inst.attack_body_slam_ready = true
					inst.attack_body_slam_cooldown_timer = nil
				end)
				inst.sg.mem.wants_to_slam = nil
			end),
    		TimeEvent(23*FRAMES, function(inst)
    			inst.components.locomotor:Stop()
    			GroundPound(inst)
    			ToggleOnCharacterCollisions(inst)
    			BreakGuard(inst)
    		end),
        },

        events = {
            CommonForgeHandlers.IdleOnAnimOver(),
        },
    },

	State{
        name = "tantrum",
        tags = {"busy"},

        onenter = function(inst, force)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt2")
        end,

        timeline = {
            TimeEvent(8*FRAMES, GroundPound),
            TimeEvent(11*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/chain_hit")
            end),
            TimeEvent(14*FRAMES, GroundPound),
            TimeEvent(24*FRAMES, GroundPound),
        },

        events = {
            CommonForgeHandlers.IdleOnAnimOver(),
        },
    },

    State{
		name = "hit", 
        tags = {"busy", "hit"},

        onenter = function(inst)
            inst.Physics:Stop()
            local anim = "hit"
            local sound = "dontstarve/forge2/beetletaur/hit"
            if 1 == 1 then
                anim = "block_hit"
                sound = "dontstarve/forge2/beetletaur/chain_hit"
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2")
            end
            inst.AnimState:PlayAnimation(anim)
			inst.sg.mem.last_hit_time = GetTime()
			inst.SoundEmitter:PlaySound(sound)
        end,

		timeline = {
            TimeEvent(8*FRAMES, function(inst)
                if not inst.is_guarding then
                    inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
                end
            end),
        },

        events = {
            CommonForgeHandlers.IdleOnAnimOver(),
        },
    },

	State{
		name = "block_pre",
        tags = {"busy"},

        onenter = function(inst, force)
			inst.Physics:Stop()
			EnterGuardMode(inst)
			inst.AnimState:PlayAnimation("block_pre")
        end,

		timeline = {
			TimeEvent(0*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/chain_hit")
            end),
        },

        events = {
            CommonForgeHandlers.IdleOnAnimOver(),
        },
    },

    State {
        name = "block_pst",
        tags = {"busy"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("block_pst")
            BreakGuard(inst)
        end,

        timeline = {},

        events = {
            CommonForgeHandlers.IdleOnAnimOver(),
        },
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            inst._bufftype:set(0)
			if FindDouble(inst, {"epic", "LA_mob"}) < 1 then
				inst:EnableCameraFocus(true)
			end
			inst:AddTag("NOCLICK")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            ChangeToObstaclePhysics(inst)
			inst.Physics:ClearCollidesWith(COLLISION.ITEMS)
        end,

		timeline = {
			TimeEvent(0, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death")
                ShakePound(inst)
            end),
			TimeEvent(13*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/slurtle/shatter")
            end),
			TimeEvent(43*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2")
				ShakePound(inst)
			end),
			TimeEvent(62*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/chain_hit")
				ShakePound(inst)
			end),
        },
    },

	State{
		name = "pose",
        tags = {"busy", "posing" , "idle"},

        onenter = function(inst)
			inst.Physics:Stop()
			if FindDouble(inst, {"epic", "LA_mob"}) < 1 then
				inst:EnableCameraFocus(true)
			end
			inst.AnimState:PlayAnimation("end_pose_pre", false)
			inst.AnimState:PushAnimation("end_pose_loop", true)
        end,

		timeline = {
			TimeEvent(11*FRAMES, function(inst)
				if not TheNet:IsDedicated() then
					inst:PushEvent("beetletaur._spawnflower")
				end
			end),
        },
    },
}

CommonStates.AddRunStates(states, {
    runtimeline = {
        TimeEvent(5*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
            ShakeIfClose(inst)
        end),
        TimeEvent(15*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
            ShakeIfClose(inst)
        end),
    },
    endtimeline = {
        TimeEvent(2*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
            ShakeIfClose(inst)
        end),
        TimeEvent(4*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
            ShakeIfClose(inst)
        end),
    },
})
CommonStates.AddWalkStates(states, {
    walktimeline = {
        TimeEvent(0, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
        end),
        TimeEvent(15*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
            ShakeIfClose(inst)
        end),
    },
    endtimeline = {
        TimeEvent(7*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
            ShakeIfClose(inst)
        end),
    },
})
CommonForgeStates.AddSleepStates(states, {
    starttimeline = {
        TimeEvent(8*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
        end),
        TimeEvent(30*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
        end),
    },
    sleeptimeline = {
        TimeEvent(0, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/sleep_in")
        end),
        TimeEvent(30*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/sleep_out")
        end),
    },
    waketimeline = {
        TimeEvent(23*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/step")
            ShakeIfClose(inst)
        end),
    },
},{
    onsleep = function(inst, data)
        inst.sg.mem.wants_to_slam = true
        if inst.is_guarding then
            BreakGuard(inst)
        end
		ToggleOnCharacterCollisions(inst)
    end,
})

local function PlayChestPoundSounds(inst)
    inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2")
    inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/chain_hit")
end

local taunt_timeline = {
    TimeEvent(0, function(inst)
        inst.last_taunt_time = GetTime()
    end),
    TimeEvent(5*FRAMES, function(inst) 
        DoBattleCryBuff(inst)
    end),
    TimeEvent(10*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/taunt")
        ShakeRoar(inst)
    end),
    TimeEvent(24*FRAMES, PlayChestPoundSounds),
    TimeEvent(28*FRAMES, PlayChestPoundSounds),
    TimeEvent(32*FRAMES, PlayChestPoundSounds),
    TimeEvent(36*FRAMES, PlayChestPoundSounds),
}
CommonForgeStates.AddSpawnState(states, taunt_timeline)
CommonForgeStates.AddTauntState(states, taunt_timeline, nil, nil, function(inst)
    inst.components.combat.battlecryenabled = false
end)
CommonForgeStates.AddKnockbackState(states)
CommonForgeStates.AddKnockbackState(states)
CommonForgeStates.AddStunStates(states, {
	stuntimeline = {
		TimeEvent(5*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
		TimeEvent(10*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
		TimeEvent(15*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
		TimeEvent(20*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
		TimeEvent(25*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
		TimeEvent(30*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
		TimeEvent(35*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
		TimeEvent(40*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/forge2/beetletaur/stun")
		end),
	},
}, nil, nil, {
	onstun = function(inst)
		BreakGuard(inst)
	end,
})
CommonStates.AddFossilizedStates(states, {
    fossilizedtimeline = {
        TimeEvent(0, function(inst)
            inst.AnimState:PushAnimation("fossilized_shake", true)
        end),
    },
    unfossilizingtimeline = {
        TimeEvent(0, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fossilized_shake_LP", "shakeloop")
        end),
    },
    unfossilizedtimeline = {
        TimeEvent(0, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_break")
        end),
        TimeEvent(9*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_break")
        end),
    },
},{
    unfossilizing_onexit = function(inst)
        inst.SoundEmitter:KillSound("shakeloop")
    end,
    unfossilized_onenter = function(inst)
        inst.AnimState:PlayAnimation("fossilized_pst_r", false)
        inst.AnimState:PushAnimation("fossilized_pst_l", false)
        
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), function(inst)
            inst.components.fossilizable:SpawnUnfossilizeFx()
        end)
    end
})

return StateGraph("beetletaur", states, events, "spawn")
