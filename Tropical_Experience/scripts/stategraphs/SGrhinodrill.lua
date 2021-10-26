require("stategraphs/commonforgestates")

local CHARGE_MAX_ROTATION = 5

local actionhandlers =
{
	ActionHandler(ACTIONS.REVIVE_CORPSE, "reviving_bro"),
}

local events = {
	CommonForgeHandlers.OnAttacked(),
	CommonForgeHandlers.OnKnockback(),
    CommonForgeHandlers.OnVictoryPose(),
	CommonHandlers.OnAttack(),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnLocomote(true,false),
	CommonHandlers.OnFossilize(),
	EventHandler("startcheer", function(inst)
		if not inst.sg:HasStateTag("cheering") then
			if not (inst.sg:HasStateTag("attack") or inst.sg:HasStateTag("frozen") or inst.sg:HasStateTag("busy")) then
				inst.sg:GoToState("cheer_pre")
			else
				inst.sg.mem.wants_to_cheer = true
				if inst.sg:HasStateTag("sleeping") then
					inst.sg:GoToState("wake")
				end
			end
		end
	end),
	
    EventHandler("death", function(inst, data)
		inst.sg:GoToState("corpse")
    end),
	
	EventHandler("respawnfromcorpse", function(inst, reviver)
		if inst:HasTag("corpse") and reviver then
			inst.sg:GoToState("death_post", reviver)
		end
	end),
	EventHandler("chest_bump", function(inst, data)
		inst.sg:GoToState("chest_bump", data)
	end),
	
    EventHandler("doattack", function(inst)
local variador = math.random (1,2)
if variador == 1 then inst.sg:GoToState("attack") end
if variador == 2 then inst.sg:GoToState("charge") end	
end),	

    EventHandler("attacked", function(inst) 
        if not inst.components.health:IsDead() 
            and not inst.sg:HasStateTag("hit") 
            and not inst.sg:HasStateTag("attack") 
            and not inst.sg:HasStateTag("charging")
            and not inst.sg:HasStateTag("chest_bump")			
        then 
            inst.sg:GoToState("hit") 
        end 
    end),
	
}

local function ShakeIfClose(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, 0.5, .02, .3, inst, 10)
end

local function FootShake(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .2, .01, .1, inst, 8)
end

local function ChargingCondition(inst)
	return inst.sg:HasStateTag("charging")
end

local charge_aoe_offset = 0
local invulerability_time = 1

local function ChargeAOE(inst)

inst.components.combat:DoAttack()
end

local function Death(inst)
	inst.sg:GoToState("death")
end

local true_death_delay = 1.5
local bro_true_death_delay = 1
local function CheckTrueDeath(inst)
	if not inst.IsTrueDeath or inst:IsTrueDeath() then
    	inst:DoTaskInTime(true_death_delay, Death)
    	if inst.bro then
    		inst.bro:DoTaskInTime(bro_true_death_delay, Death)
    	end
    end
end

local function GetNearbyTargets(inst)
	local pos = inst:GetPosition()
	local targets = {}
	local ents = TheSim:FindEntities(pos.x, 0, pos.z, 3, { "player"}, inst:HasTag("brainwashed") and {"INLIMBO", "playerghost", "notarget", "companion", "player", "brainwashed"} or { "LA_mob", "fossil", "shadow", "playerghost", "INLIMBO" })
	for _,ent in ipairs(ents) do
		if ent ~= inst and inst.components.combat:IsValidTarget(ent) and ent.components.health and ent ~= inst.components.combat.target then
			table.insert(targets, ent)
		end
	end
	return #targets
end

local function StartCheerCooldown(inst)
	inst.cheer_ready = false
    if inst.cheer_task ~= nil then
        inst.cheer_task:Cancel()
        inst.cheer_task = nil
    end	
	inst.cheer_task = inst:DoTaskInTime(15, function(inst)
		inst.cheer_ready = true
	end)
end

local function FaceBro(inst)
	if inst.bro and not inst.bro.components.health:IsDead() then
		local pos = inst.bro:GetPosition()
		inst:ForceFacePoint(pos:Get())
	end
end

local states = {
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop", true)
			if inst.sg.mem.wants_to_cheer then
				if inst.bro and inst.bro.sg:HasStateTag("cheering") then
					inst.sg:GoToState("cheer_pre")
				else
					inst.sg.mem.wants_to_cheer = nil
					StartCheerCooldown(inst)
				end
            end
        end,
    },

    State{
        name = "attack",
        tags = {"attack", "busy", "pre_attack"},

		onenter = function(inst, target)
			inst.components.combat:StartAttack()
			inst.components.locomotor:Stop()
			inst.SoundEmitter:PlaySound("dontstarve/forge2/rhino_drill/attack_2")
			inst.AnimState:PlayAnimation("attack")
		end,

		timeline = {
			TimeEvent(13*FRAMES, function(inst)
				inst.components.combat:DoAttack()
                inst.sg:RemoveStateTag("pre_attack")
			end),
		},
		
        events = {
            EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    },

	State{
        name = "run_start",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
			if inst.attack_charge_ready and 
			inst.components.combat.target and not 
			(inst.bro and inst.bro:HasTag("corpse")) 
			and not inst.cheer_ready 
			and inst.components.combat:IsValidTarget(inst.components.combat.target) then
				inst.sg:GoToState("charge", inst.components.combat.target)
			else
				inst.components.locomotor:RunForward()
				inst.AnimState:PlayAnimation("run_pre")
			end
        end,

        events = {
            EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("run")
			end),
        },
    },

	State{
        name = "run",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
			inst.Transform:SetEightFaced()
			if inst.attack_charge_ready and inst.components.combat.target 
			and not (inst.bro and inst.bro:HasTag("corpse")) 
			and not inst.cheer_ready and 
			inst.components.combat:IsValidTarget(inst.components.combat.target) then
				inst.sg:GoToState("charge", inst.components.combat.target)
			else
				inst.components.locomotor:RunForward()
				inst.AnimState:PlayAnimation("run_loop")
			end
        end,

		timeline = {
			TimeEvent(9*FRAMES, PlayFootstep),
			TimeEvent(9*FRAMES, FootShake),
			TimeEvent(18*FRAMES, PlayFootstep),
			TimeEvent(18*FRAMES, FootShake),
		},

        events = {
			EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("run")
			end),
		},

		onexit = function(inst)
			inst.Transform:SetSixFaced()
        end,
    },

	State{
        name = "run_stop",
        tags = { "idle" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("run_pst")
        end,

		timeline = {
			TimeEvent(16*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/forge2/rhino_drill/grunt")
			end),
		},

        events = {
            EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    },

	State{
        name = "charge",
        tags = {"busy", "charging", "keepmoving", "delaysleep"},

		onenter = function(inst, target)
			inst._hashittarget = nil
			inst.components.combat:StartAttack()
			inst.components.locomotor:Stop()

			if inst.components.combat.target and not inst._hashittarget then
				if inst.components.combat.target:IsValid() then
					inst:ForceFacePoint(inst.components.combat.target:GetPosition())
					inst.sg.statemem.target = inst.components.combat.target
				end
			end

			inst.Transform:SetEightFaced()
			ToggleOffCharacterCollisions(inst)
			inst.attack_charge_ready = false

			inst.SoundEmitter:PlaySound("dontstarve/forge2/rhino_drill/attack")
			inst.AnimState:PlayAnimation("attack2_pre")
			inst.Physics:SetMotorVelOverride(inst.components.locomotor.runspeed * 1.15, 0, 0)
		end,

		onexit = function(inst)
			inst:DoTaskInTime(15, function(inst)
				inst.attack_charge_ready = true
			end)
			inst.Transform:SetSixFaced()
			ToggleOnCharacterCollisions(inst)
		end,

		timeline = {
			TimeEvent(9*FRAMES, PlayFootstep),
			TimeEvent(9*FRAMES, FootShake),
			TimeEvent(15*FRAMES, function(inst)	inst.components.combat:DoAttack() end),
			TimeEvent(18*FRAMES, PlayFootstep),
			TimeEvent(18*FRAMES, FootShake),
		},

        events = {
            EventHandler("animover", function(inst)
				if not inst.sg.statemem.target_hit and 
				inst.sg.statemem.target and 
				inst.components.combat:IsValidTarget(inst.sg.statemem.target) and not 
				inst.sg.mem.sleep_duration then
					inst.sg:GoToState("charge_loop", inst.sg.statemem.target)
				else
					inst.sg:GoToState("charge_pst", inst.sg.statemem.target)
				end
			end),
			EventHandler("onattackother", function(inst, data)
				if data.target == inst.sg.statemem.target then
					inst.sg.statemem.target_hit = true
				end
			end),
        },
    },

	State{
        name = "charge_loop",
        tags = {"attack", "busy", "charging", "keepmoving", "delaysleep"},

		onenter = function(inst, target)
			if target and not inst._hashittarget then
				if inst.components.combat:IsValidTarget(target) then
					inst.sg.statemem.target = target
				end
			end

			inst.Transform:SetEightFaced()
			ToggleOffCharacterCollisions(inst)

			inst.Physics:SetMotorVelOverride(inst.components.locomotor.runspeed*1.15, 0, 0)
			inst.AnimState:PlayAnimation("attack2_loop")
		end,

		onupdate = function(inst)
			if not inst.sg.statemem.target_hit and inst.sg.statemem.target and inst.components.combat:IsValidTarget(inst.sg.statemem.target) then
				local current_rotation = inst.Transform:GetRotation()
				local angle_to_target = inst:GetAngleToPoint(inst.sg.statemem.target:GetPosition())
				local angle = (current_rotation - angle_to_target + 180) % 360 - 180
				local next_rotation = math.abs(angle) <= CHARGE_MAX_ROTATION and angle or CHARGE_MAX_ROTATION * (angle < 0 and -1 or 1)
				inst.Transform:SetRotation(current_rotation - next_rotation)
			end
		end,

		onexit = function(inst)
			inst.Transform:SetSixFaced()
			ToggleOnCharacterCollisions(inst)
		end,

		timeline = {
			TimeEvent(9*FRAMES, PlayFootstep),
			TimeEvent(9*FRAMES, FootShake),
			TimeEvent(15*FRAMES, function(inst)	inst.components.combat:DoAttack() end),
			TimeEvent(18*FRAMES, PlayFootstep),
			TimeEvent(18*FRAMES, FootShake),
		},

        events = {
            EventHandler("animover", function(inst)
				if not inst.sg.statemem.target_hit and 
				inst.sg.statemem.target and 
				inst.components.combat:IsValidTarget(inst.sg.statemem.target) and not 
				inst.sg.mem.sleep_duration and (not inst.bro or not inst.bro.components.health:IsDead())then
					inst.sg:GoToState("charge_loop", inst.sg.statemem.target)
				else
					inst.sg:GoToState("charge_pst", inst.sg.statemem.target)
				end
			end),
			EventHandler("onattackother", function(inst, data)
				if data.target == inst.sg.statemem.target then
					inst.sg.statemem.target_hit = true
				end
			end),
        },
    },

	State{
        name = "charge_pst",
        tags = {"busy"},

		onenter = function(inst, target)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("attack2_pst")
		end,

        events = {
            EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    },

	State{
		name = "cheer_pre",
        tags = {"busy", "cheering", "nosleep"},

        onenter = function(inst, data)
			if inst.bro and inst.bro.components.health and not inst.bro.components.health:IsDead() and not inst.bro.sg:HasStateTag("cheering") then
				FaceBro(inst)
				inst.bro:PushEvent("startcheer")
			end
            inst.Physics:Stop()
			inst.AnimState:PlayAnimation("cheer_pre")
        end,

		timeline = {},

		onexit = function(inst)
			inst.sg.mem.wants_to_cheer = nil
			StartCheerCooldown(inst)
		end,

        events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("cheer_loop")
			end),
        },
    },

	State{
		name = "cheer_loop",
        tags = {"busy", "cheering", "nosleep"},

        onenter = function(inst, data)
			inst.AnimState:PlayAnimation("cheer_loop")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/cheer")

			inst.sg.statemem.buff_ready = data and data.buff_ready
            inst.sg.statemem.buffed = data and data.buffed
			inst.sg.statemem.end_cheer = data and data.end_cheer

            if not (inst.bro and inst.bro.sg:HasStateTag("cheering") or inst.sg.statemem.buffed) then
                inst.sg:SetTimeout(data and data.timeout or 5)
            end
        end,

		timeline = {
			TimeEvent(9*FRAMES, function(inst)
				if inst.sg.statemem.end_cheer then
					inst.sg:GoToState("cheer_pst")
				end
			end)
		},

        ontimeout = function(inst)
            if not inst.bro.sg:HasStateTag("cheering") then
                inst.sg:RemoveStateTag("cheering")
                inst.sg.statemem.end_cheer = true
            end
        end,

		onexit = function(inst)
			StartCheerCooldown(inst) 
		end,

        events = {
			EventHandler("animover", function(inst)
				if inst.sg.statemem.end_cheer then
					inst.sg:GoToState("cheer_pst")
				else
					local bro_is_cheering = inst.bro and inst.bro.sg.currentstate.name == "cheer_loop"
					local buff_ready = inst.sg.statemem.buff_ready
					local buffed = inst.sg.statemem.buffed
					local end_cheer = buffed or not (bro_is_cheering or inst.bro.sg.mem.wants_to_cheer)

					if buff_ready and bro_is_cheering then 
					inst:SetBuffLevel(inst.bro_stacks + 1)
						buffed = true
						end_cheer = false
					end
                    inst.sg:GoToState("cheer_loop", {buffed = buffed, buff_ready = not (buff_ready or buffed) and bro_is_cheering, end_cheer = end_cheer, timeout = inst.sg.timeout})
				end
			end),
        },
    },

	State{
		name = "cheer_pst",
        tags = {"busy", "nosleep"},

        onenter = function(inst, data)
			inst.AnimState:PlayAnimation("cheer_post")
        end,

        events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    },

	State{
		name = "pose",
        tags = {"busy", "posing" , "idle"},

        onenter = function(inst)
			inst.Physics:Stop()
			if inst.bro and inst.bro.components.health and not inst.bro.components.health:IsDead() then
				FaceBro(inst)
				local rotation = inst.Transform:GetRotation()
				inst.Transform:SetRotation(rotation - 180)
			end
			inst.AnimState:PlayAnimation("pose_pre", false)
			inst.AnimState:PushAnimation("pose_loop", true)
        end,

		timeline = {
			TimeEvent(15*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/cheer")
			end),
        },
    },

	State{
        name = "corpse",
        tags = {"busy", "nointerrupt"},

        onenter = function(inst, data)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death")
            inst.AnimState:PlayAnimation("death")
			CheckTrueDeath(inst)
            inst.Physics:Stop()
			inst:AddTag("NOCLICK")
        end,

		timeline = {
			TimeEvent(14*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
				ShakeIfClose(inst)
			end),
        },

        events = {
            EventHandler("animover", function(inst)
                inst.components.revivablecorpse:SetCorpse(true)
            end),
            EventHandler("attacked", function(inst)
            	if inst:HasTag("corpse") then
					inst.AnimState:PlayAnimation("death_hit", false)
				end
            end),
        },
    },

	State{
		name = "reviving_bro",
        tags = {"doing", "busy", "reviving"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("revive_pre", false)
			inst.AnimState:PushAnimation("revive_loop", false)
			inst.AnimState:PushAnimation("revive_loop", false)
			inst.AnimState:PushAnimation("revive_pst", false)

			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/reviveLP", "reviveLP")

            inst.sg.statemem.action = inst:GetBufferedAction()
        end,

		onexit = function(inst)
			inst.SoundEmitter:KillSound("reviveLP")
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
		end,

		timeline = {
			TimeEvent(14*FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events = {
			EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    },

	State{
        name = "death_post",
        tags = { "busy", "nointerrupt"},

        onenter = function(inst)
			inst:RemoveTag("NOCLICK")
			inst.AnimState:PlayAnimation("death_post")
			inst.components.health:SetPercent(0.20)
            inst.components.health:SetInvincible(true)
            inst.components.revivablecorpse:SetCorpse(false)
        end,

		timeline = {},

        events = {
            EventHandler("animqueueover", function(inst)
				if inst.bro and inst.bro.sg:HasStateTag("idle") then
					inst:PushEvent("chest_bump", {initiator = true})
					inst.bro:PushEvent("chest_bump")
				else
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
			ChangeToCharacterPhysics(inst)
        end,
    },

	State{
        name = "chest_bump",
        tags = { "busy", "nointerrupt", "chest_bump" },

        onenter = function(inst, data)
			inst.sg.statemem.initiator = data and data.initiator
			inst.Transform:SetEightFaced()
            inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("chest_bump")
			FaceBro(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/grunt")
        end,

		timeline = {
			TimeEvent(16*FRAMES, function(inst)
				inst.components.combat:DoAttack()
			end),
		},

		onexit = function(inst)
			inst.Transform:SetSixFaced()
		end,

        events = {
            EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
			inst.AnimState:PlayAnimation("death_finalfinal")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death_final_final")
            inst.Physics:Stop()
			ChangeToObstaclePhysics(inst)
			inst.Physics:ClearCollidesWith(COLLISION.ITEMS)
        end,

		timeline = {
			TimeEvent(21*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
				ShakeIfClose(inst)
			end),
        },

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
	inst:AddTag("NOCLICK")
	inst.persists = false
	inst.components.health.nofadeout = false	
    inst:DoTaskInTime(5, ErodeAway)				
                end
            end),
        },
    },
}

CommonForgeStates.AddSleepStates(states, {
	starttimeline = {
		TimeEvent(38*FRAMES, function(inst)
			ShakeIfClose(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/bodyfall")
		end),
	},
	sleeptimeline = {
		TimeEvent(0, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/sleep_in")
		end),
		TimeEvent(24*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/sleep_out")
		end),
	},
},{
	onsleep = function(inst)
		inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/sleep_pre")
		ToggleOnCharacterCollisions(inst)
	end,
})
CommonStates.AddHitState(states, {
	TimeEvent(0, function(inst)
		inst.sg.mem.last_hit_time = GetTime()
	end),
})
CommonForgeStates.AddTauntState(states, {
	TimeEvent(10*FRAMES, function(inst)
		inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/taunt")
	end),
})
CommonForgeStates.AddSpawnState(states, {
	TimeEvent(10*FRAMES, function(inst)
		inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/taunt")
	end),
})
CommonForgeStates.AddKnockbackState(states)
CommonForgeStates.AddActionState(states)
CommonStates.AddFossilizedStates(states, { 
	fossilizedtimeline = {
		TimeEvent(0, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fossilized_pre_2")
		end),
		TimeEvent(8*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/sleep_out")
		end),
		TimeEvent(39*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/sleep_out")
		end),
		TimeEvent(71*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/sleep_out")
		end),
	},
	unfossilizingtimeline = {
		TimeEvent(0, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fossilized_shake_LP", "shakeloop")
		end),
	},
	unfossilizedtimeline = {
		TimeEvent(0, function(inst)
			inst.AnimState:PlayAnimation("fossilized_pst_r")
			inst.AnimState:PushAnimation("fossilized_pst_l")
			inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_break")
		end),
		TimeEvent(10*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_break")
		end),
	},
},{
	unfossilizing_onexit = function(inst)
		inst.SoundEmitter:KillSound("shakeloop")
		inst.components.fossilizable:SpawnUnfossilizeFx()
	end,
})

return StateGraph("rhinodrill", states, events, "spawn", actionhandlers)
