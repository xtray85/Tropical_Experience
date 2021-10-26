require("stategraphs/commonstates")

CommonForgeStates = {}
CommonForgeHandlers = {}

function EnsureTable(tab, ...)
    if not tab then tab = {} end
    local keys = {...}
	for i = 1, #keys, 1 do
		if not tab[keys[i]] then
			tab[keys[i]] = {}
		end
		tab = tab[keys[i]]
	end
    return tab
end

local function CheckForAttackInterrupt(inst, data)
    if inst.sg:HasStateTag("pre_attack") and TheWorld and TheWorld.components.stat_tracker and data.attacker then
        TheWorld.components.stat_tracker:AdjustStat("attack_interrupt", data.attacker, 1)
    end
end
local function onattacked(inst, data)
    if inst.components.health:IsDead() then return end
	if inst.sg:HasState("stun") and not inst.sg:HasStateTag("nostun") then
        CheckForAttackInterrupt(inst, data)
		inst.sg:GoToState("stun", data)
	elseif inst.sg:HasStateTag("spinning") then
        CheckForAttackInterrupt(inst, data)
		inst.sg:GoToState("attack_spin_stop_forced")
	elseif inst.sg:HasStateTag("hiding") and inst.sg:HasState("hide_hit") and not inst.sg:HasStateTag("nointerrupt") then
		inst.sg:GoToState("hide_hit")
	elseif inst.sg:HasStateTag("flipped") then
        CheckForAttackInterrupt(inst, data)
        inst.sg:GoToState("flip_stop", data.attacker)
		if TheWorld and TheWorld.components.stat_tracker and data.attacker then
			TheWorld.components.stat_tracker:AdjustStat("ccbroken", data.attacker, 1)
		end
	elseif not inst.sg:HasStateTag("nointerrupt")
	or ((not inst.sg.mem.last_hit_time or inst.sg.mem.last_hit_time + (inst.hit_recovery or 0.75) < GetTime()) and not (inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("nointerrupt"))) and data.damage > 0 then
		CheckForAttackInterrupt(inst, data)
        inst.sg:GoToState("hit")
	end
end

CommonForgeHandlers.OnAttacked = function()
    return EventHandler("attacked", onattacked)
end
--------------------------------------------------------------------------
local function onknockback(inst, data)
	if not inst.components.health:IsDead() and not (inst.sg:HasStateTag("hiding") or inst.sg:HasStateTag("rolling") or inst.sg:HasStateTag("charging") or inst.sg:HasStateTag("nostun") or inst.sg:HasStateTag("nointerrupt")) and (not inst:HasTag("largecreature") or inst:HasTag("largecreature") and data.knocker and data.knocker.epicknockback or true) then 
		inst.sg:GoToState("knockback", data)
	end
end

CommonForgeHandlers.OnKnockback = function()
    return EventHandler("knockback", onknockback)
end
--------------------------------------------------------------------------
local function onentershield(inst, data) 
	if not inst.sg:HasStateTag("busy") and not inst.components.health:IsDead() then
		inst.sg:GoToState("hide_start")
	end
end

CommonForgeHandlers.OnEnterShield = function()
    return EventHandler("entershield", onentershield)
end
--------------------------------------------------------------------------
local function onexitshield(inst, data)
	if not inst.components.health:IsDead() and not (inst.sg:HasStateTag("hit") or inst.sg:HasStateTag("stunned")) and not inst.sg:HasStateTag("fossilized") then 
		inst.sg:GoToState("hide_stop")
	end
end

CommonForgeHandlers.OnExitShield = function()
    return EventHandler("exitshield", onexitshield)
end
--------------------------------------------------------------------------
function onsleep(inst, data)
	if inst.sg:HasStateTag("nosleep") then
		inst.sg.mem.sleep_duration = 3
	elseif inst.sg.currentstate.name ~= "sleep" then
		inst.sg:GoToState(inst.sg.currentstate == "sleeping" and "sleeping" or "sleep")
	end
end

CommonForgeHandlers.OnSleep = function()
	return EventHandler("gotosleep", onsleep)
end
--------------------------------------------------------------------------
local function ontalk(inst, data)
	if not inst.sg:HasStateTag("talking") then
		inst.sg:GoToState("talk_pre")
	end
end

CommonForgeHandlers.OnTalk = function()
    return EventHandler("ontalk", ontalk)
end
--------------------------------------------------------------------------
local function onvictorypose(inst, data)
    if not inst.sg:HasStateTag("busy") then
        inst.sg:GoToState("pose")
    end
end

CommonForgeHandlers.OnVictoryPose = function()
    return EventHandler("victorypose", onvictorypose)
end
--------------------------------------------------------------------------
local function idleonanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("idle")
    end
end

CommonForgeHandlers.IdleOnAnimOver = function()
    return EventHandler("animover", idleonanimover)
end

CommonForgeHandlers.IdleOnAnimQueueOver = function()
    return EventHandler("animqueueover", idleonanimover)
end
--------------------------------------------------------------------------
local function GetOverrideAnim(inst, override, default)
    return override and (type(override) == "function" and override(inst) or override) or default
end
--------------------------------------------------------------------------
CommonForgeStates.AddIdle = function(states, funny_idle_state, anim_override, timeline)
    table.insert(states, State {
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst, pushanim)           
		if inst.components.sleeper:IsAsleep() then
                inst.sg:GoToState("sleep")
            elseif inst.sg.mem.wants_to_taunt and inst.sg:HasState("taunt") then
                inst.sg:GoToState("taunt")
            elseif inst.sg.mem.sleep_duration and inst.components.sleeper then
				inst.components.sleeper:GoToSleep(inst.sg.mem.sleep_duration, inst.components.sleeper.caster)
				inst.sg.mem.sleep_duration = nil
            else
                if inst.components.locomotor then
                    inst.components.locomotor:StopMoving()
                end

                local anim = (anim_override == nil and "idle_loop") or (type(anim_override) ~= "function" and anim_override) or anim_override(inst)

                if pushanim then
                    if type(pushanim) == "string" then
                        inst.AnimState:PlayAnimation(pushanim)
                    end
                    inst.AnimState:PushAnimation(anim, true)
                elseif not inst.AnimState:IsCurrentAnimation(anim) then
                    inst.AnimState:PlayAnimation(anim, true)
                end
            end
        end,

        onexit = function(inst)
            inst.sg.mem.wants_to_taunt = nil
        end,

        timeline = timeline,

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState(math.random() < .1 and funny_idle_state or "idle")
                end
            end),
        },
    })
end

CommonForgeStates.AddStunStates = function(states, timelines, anims, sounds, fns, events)
	table.insert(states, State {
		name = "stun",
		tags = {"busy", "nofreeze"},

		onenter = function(inst, data)
			inst.Physics:Stop()
			inst.sg.statemem.stimuli = data.stimuli or nil
			if data.stimuli and data.stimuli == "electric" then
				inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.stun, "stun_loop"), true)
				inst.sg:SetTimeout(1)
			else
				inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.stun, "stun_loop"))
			end

			if fns and fns.onstun then
				fns.onstun(inst, data)
			end
		end,

		timeline = timelines and timelines.stuntimeline,

		ontimeout = function(inst)
			inst.sg:GoToState("stun_stop", inst.sg.statemem.stimuli)
		end,

		events = {
			EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("stun_stop", inst.sg.statemem.stimuli)
			end),
		},

		onexit = function(inst)
			if fns and fns.onexitstun then
				fns.onexitstun(inst)
			end
		end,
	})

	table.insert(states, State {
		name = "stun_stop",
        tags = {"busy", "nofreeze"},

        onenter = function(inst, stimuli)
            inst.Physics:Stop()
			if stimuli and stimuli == "explosive" and (not inst.last_taunt_time or (inst.last_taunt_time + 8 < GetTime())) then
				inst.last_taunt_time = GetTime()
                inst.sg.mem.wants_to_taunt = true
			end
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.stopstun, "stun_pst"))
			if fns and fns.onstopstun then
				fns.onstopstun(inst)
			end
        end,

		timeline = timelines and timelines.endtimeline,

        events = events and events.stopstun or {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    })
end

CommonForgeStates.AddTauntState = function(states, timeline, anim, events, onexit)
	table.insert(states, State {
		name = "taunt",
        tags = {"busy", "taunting", "keepmoving"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anim, "taunt"))
        end,

		timeline = timeline,

        events = events or {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },

		onexit = onexit or nil,
    })
end

CommonForgeStates.AddSpawnState = function(states, timeline, anim, events, onexit)
	table.insert(states, State {
		name = "spawn",
        tags = {},

        onenter = function(inst)
			inst.components.combat.battlecryenabled = false
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anim, "taunt"))
        end,

		timeline = timeline,

        events = events or {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },

		onexit = onexit or function(inst)
			inst.components.combat.battlecryenabled = true
		end,
    })
end

CommonForgeStates.AddKnockbackState = function(states, timeline, anim, fns, ignoremass)
	table.insert(states, State {
        name = "knockback",
        tags = {"busy", "nopredict", "nomorph", "nodangle", "keepmoving", "knockback"},

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

			if fns and fns.anim then
				fns.anim(inst)
			else
				inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anim, "stun_loop"), false)
				inst.AnimState:PushAnimation(GetOverrideAnim(inst, anim, "stun_loop"), false)
			end

            if data and data.radius and data.knocker and data.knocker:IsValid() then
                local x, y, z = data.knocker.Transform:GetWorldPosition()
                local distsq = inst:GetDistanceSqToPoint(x, y, z)
                local rangesq = data.radius * data.radius
                local rot = inst.Transform:GetRotation()
                local rot1 = distsq > 0 and inst:GetAngleToPoint(x, y, z) or data.knocker.Transform:GetRotation() + 180
                local drot = math.abs(rot - rot1)
                while drot > 180 do
                    drot = math.abs(drot - 360)
                end
                local k = distsq < rangesq and .3 * distsq / rangesq - 1 or -.7
                inst.sg.statemem.speed = (data.strengthmult or 1) * 12 * k / ((ignoremass and 50 or inst.Physics:GetMass()) / 50)
                inst.sg.statemem.dspeed = 0
                if drot > 90 then
                    inst.sg.statemem.reverse = true
                    inst.Transform:SetRotation(rot1 + 180)
                    inst.Physics:SetMotorVel(-inst.sg.statemem.speed, 0, 0)
                else
                    inst.Transform:SetRotation(rot1)
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
                end
            end
        end,

        onupdate = function(inst)
            if inst.sg.statemem.speed then
                inst.sg.statemem.speed = inst.sg.statemem.speed + inst.sg.statemem.dspeed
                if inst.sg.statemem.speed < 0 then
                    inst.sg.statemem.dspeed = inst.sg.statemem.dspeed + .075
                    inst.Physics:SetMotorVel(inst.sg.statemem.reverse and -inst.sg.statemem.speed or inst.sg.statemem.speed, 0, 0)
                else
					if not (fns and fns.anim) then
						inst.AnimState:PlayAnimation("stun_pst")
					end
                    inst.sg.statemem.speed = nil
                    inst.sg.statemem.dspeed = nil
                    inst.Physics:Stop()
                end
            end
        end,

        timeline = timeline,

        events = {
            EventHandler("animover", function(inst)
				if inst.AnimState:AnimDone() then
					if fns and fns.animover then
						fns.animover(inst)
					else
						inst.sg:GoToState("idle")
					end
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.speed then
                inst.Physics:Stop()
            end
			if fns and fns.onexit then
				fns.onexit(inst)
			end
        end,
    })
end

CommonForgeStates.AddActionState = function(states, timeline, anim)
	table.insert(states, State {
		name = "action",
        tags = {"busy"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
			inst:PerformBufferedAction()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anim, "run_pst"))
        end,

		timeline = timeline,

        events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    })
end

local function EnsureSleep(inst)
    local sleeper = inst.components.sleeper
    if not sleeper.isasleep then
        sleeper.isasleep = true
        sleeper:GoToSleep(inst.sg.mem.sleep_duration or 3, sleeper.caster)
    end
end
CommonForgeStates.AddSleepStates = function(states, timelines, fns)
    local fns = fns or {}
    local _oldOnSleep = fns.onsleep
    fns.onsleep = function(inst)
        local sleeper = inst.components.sleeper
        sleeper.sleep_start = GetTime()

        if sleeper.caster and TheWorld and TheWorld.components.stat_tracker then
            TheWorld.components.stat_tracker:AdjustStat("numcc", sleeper.caster, 1)
        end
        EnsureSleep(inst)
        if _oldOnSleep then
            _oldOnSleep(inst)
        end
    end

    table.insert(EnsureTable(timelines, "sleeptimeline"), TimeEvent(0, function(inst)
        EnsureSleep(inst)
    end))
    CommonStates.AddSleepStates(states, timelines, fns)
end

CommonForgeStates.AddFossilizedStates = function(states)
	CommonStates.AddFossilizedStates(states, {
		fossilizedtimeline = {
			TimeEvent(0, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fossilized_pre_1")
			end)
		},
		unfossilizingtimeline = {
			TimeEvent(0, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fossilized_shake_LP", "shakeloop")
			end),
		},
		unfossilizedtimeline = {
			TimeEvent(0, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_break")
			end)
		},
	},{
		unfossilizing_onexit = function(inst)
            inst.SoundEmitter:KillSound("shakeloop")
            inst.components.fossilizable:SpawnUnfossilizeFx()
		end
	})
end

CommonForgeStates.AddFlipStates = function(states, flipduration, timelines, anims, fns, exit)
	table.insert(states, State {
		name = "flip_start",
        tags = {"busy", "nosleep"},

        onenter = function(inst, cb)
			if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.startflip, "flip_pre"))
			if fns and fns.onflipstart then
				fns.onflipstart(inst, cb)
			end
        end,

		onexit = exit and exit.flipstart or function(inst)
				inst:DoTaskInTime(flipduration or 10, function(inst)
				if inst.sg:HasStateTag("flipped") then
					inst.sg:GoToState("flip_stop")
				end
			end)
		end,

		timeline = timelines and timelines.starttimeline,

        events = {
			EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("flip")
			end),
        },
    })

	table.insert(states, State{
		name = "flip",
        tags = {"busy", "flipped"},

        onenter = function(inst, cb)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.fliploop, "flip_loop"))
        end,

		timeline = timelines and timelines.fliptimeline,

        events = {
			EventHandler("animover", function(inst)
                inst.sg:GoToState("flip")
            end),
        },

		onexit = exit and exit.flip or nil,
    })

	table.insert(states, State{
		name = "flip_stop",
        tags = {"busy", "nosleep"},

        onenter = function(inst, attacker)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.stopflip, "flip_pst"))
			if fns and fns.onflipstop then
				fns.onflipstop(inst, attacker)
			end
        end,

		timeline = timelines and timelines.endtimeline,

        events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },

		onexit = exit and exit.flipstop or nil,

    })

	table.insert(states, State{
		name = "flip_hit",
        tags = {"busy", "nosleep"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.fliphit, "flip_hit"))
        end,

		timeline = timelines and timelines.hittimeline,

        events = {
			EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    })
end

CommonForgeStates.AddHideStates = function(states, timelines, anims, fns)
	table.insert(states, State {
		name = "hide_start",
        tags = {"busy", "nosleep", "hide_pre"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.starthiding, "hide_pre"))
        end,

		timeline = timelines and timelines.starttimeline,

		onexit = function(inst)
			inst.components.health:SetAbsorptionAmount(0)
			inst.components.sleeper:SetResistance(1)
		end,

        events = {
			EventHandler("animover", function(inst)
                inst.sg:GoToState("hiding")
            end),
        },
    })

	table.insert(states, State {
		name = "hiding",
        tags = {"busy", "hiding"},

        onenter = function(inst, cb)
			inst.components.debuffable:RemoveDebuff("shield_buff", "shield_buff")
			inst.components.sleeper:SetResistance(9999)
            inst.components.health:SetAbsorptionAmount(1)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.hideloop, "hide_loop"))

        end,

		timeline = timelines and timelines.hidetimeline,

		onexit = function(inst)
			inst.components.health:SetAbsorptionAmount(0)
			inst.components.sleeper:SetResistance(1)
		end,

        events = {
			EventHandler("animover", function(inst)
                inst.sg:GoToState("hiding")
            end),
        },
    })

	table.insert(states, State {
		name = "hide_stop",
        tags = {"busy", "nobuff", "nosleep"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.stophiding, "hide_pst"))
        end,

		timeline = timelines and timelines.endtimeline,

		onexit = function(inst)
			if fns and fns.onhidestopexit then
				fns.onhidestopexit(inst)
			end
        end,

        events = {
			EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    })

	table.insert(states, State {
		name = "hide_hit",
        tags = {"busy", "hiding"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation(GetOverrideAnim(inst, anims and anims.hidehit, "hide_hit"))
            inst.components.sleeper:SetResistance(9999)
            inst.components.health:SetAbsorptionAmount(1)
        end,

        onexit = function(inst)
            inst.components.health:SetAbsorptionAmount(0)
            inst.components.sleeper:SetResistance(1)
        end,

        events = {
			EventHandler("animover", function(inst)
                inst.sg:GoToState("hiding")
            end),
        },
    })
end

CommonForgeStates.AddTalkStates = function(states, timelines, anims, sounds)
	table.insert(states, State {
		name = "talk_pre",
        tags = {"idle"},

        onenter = function(inst)
			if inst.SoundEmitter:PlayingSound("talk") then
				inst.SoundEmitter:KillSound("talk")
			end
            inst.AnimState:PlayAnimation(anims and anims.starttalking or "yell_pre")
        end,

		timeline = timelines and timelines.starttimeline,

        events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("talk_loop")
			end),
        },
    })

	table.insert(states, State {
		name = "talk_loop",
        tags = {"talking"},

        onenter = function(inst)
			if inst.SoundEmitter:PlayingSound("talk") then 
				inst.SoundEmitter:KillSound("talk")
			end
            inst.AnimState:PlayAnimation(anims and anims.starttalking or "yell_loop", true)
        end,

		onexit = function(inst)
			if inst.SoundEmitter:PlayingSound("talk") then
				inst.SoundEmitter:KillSound("talk")
			end
		end,

		timeline = timelines and timelines.talktimeline,

        events = {
			EventHandler("donetalking", function(inst)
				inst.sg:GoToState("talk_pst")
			end),
        },
    })

	table.insert(states, State {
		name = "talk_pst",
        tags = {"idle"},

        onenter = function(inst)
			if inst.SoundEmitter:PlayingSound("talk") then
				inst.SoundEmitter:KillSound("talk")
			end
            inst.AnimState:PlayAnimation(anims and anims.stoptalking or "yell_pst")
        end,

		timeline = timelines and timelines.stoptimeline,

        events = {
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
        },
    })
end
