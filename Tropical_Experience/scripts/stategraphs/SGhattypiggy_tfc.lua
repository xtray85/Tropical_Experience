--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

require("stategraphs/commonstates")

local actionhandlers =
{
	ActionHandler(ACTIONS.EAT, "eat"),
	ActionHandler(ACTIONS.GOHOME, "gohome"),
}

local events =
{
	EventHandler("attacked", function(inst) 
		if not inst.components.health:IsDead() 
			and not inst.sg:HasStateTag("attack") 
		then 
			inst.sg:GoToState("hit") 
		end 
	end),
	EventHandler("death", function(inst) inst.sg:GoToState("death") end),
	EventHandler("doattack", function(inst, data) 
		if not inst.components.health:IsDead() 
			and (inst.sg:HasStateTag("hit") 
			or not inst.sg:HasStateTag("busy")) 
		then 
			inst.sg:GoToState("attack", data.target) 
		end 
	end),
	EventHandler("docharge", function(inst, target) 
		if not inst.components.health:IsDead() 
			and (inst.sg:HasStateTag("hit") 
			or not inst.sg:HasStateTag("busy")) 
		then 
			inst.sg:GoToState("charge", target) 
		end 
	end),
	EventHandler("freeze", function(inst) inst.sg:GoToState("frozen") end),
	CommonHandlers.OnSleep(),
	CommonHandlers.OnLocomote(true, false),
    CommonHandlers.OnHop(),		
	--CommonHandlers.OnFreeze(),
}

local states=
{

	State{
		name = "gohome",
		tags = {"busy"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("attack_1")
		end,

		events=
		{
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle") 
				inst:PerformBufferedAction()
			end),
		},
	},

	State{
		name = "idle",
		tags = {"idle", "canrotate"},
		onenter = function(inst, playanim)
			--inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/idle")
			inst.Physics:Stop()
			if playanim then
				inst.AnimState:PlayAnimation(playanim)
				inst.AnimState:PushAnimation("idle_loop", true)
			else
				inst.AnimState:PlayAnimation("idle_loop", true)
			end
			inst.sg:SetTimeout(2*math.random()+.5)
		end,

		events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
	},

	State{
		name = "attack",
		tags = {"attack", "busy"},

		onenter = function(inst, target)
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			inst.components.combat:StartAttack()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boaron/attack_1")
			inst.AnimState:PlayAnimation("attack1")
		end,

		timeline=
		{
			TimeEvent(12 * FRAMES, function(inst) --20 frames total
				inst.components.combat:DoAttack(inst.sg.statemem.target) 	
            end), 
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "charge", --11-26
		tags = {"busy", "attack"},

		onenter = function(inst, target)
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			if target ~= nil and target:IsValid() then
				--local xt, yt, zt = target.Transform:GetWorldPosition()
				inst:ForceFacePoint(target.Transform:GetWorldPosition())
			end
			inst.AnimState:PlayAnimation("attack2", false)
			inst.components.combat:StartAttack()
			inst.sg.statemem.chargeSpeed = 0
		end,

		timeline =  --33 frames total
		{
			TimeEvent(18 * FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boaron/attack_2")
				inst.sg.statemem.chargeSpeed = 50
			end), 
			
			TimeEvent(26 * FRAMES, function(inst)
				inst.Physics:Stop()
				inst.sg.statemem.chargeSpeed = 0 
				inst.chargeLastTime = GetTime()
				inst.components.combat:DoAttack(inst.sg.statemem.target) 
            end), 
		},

		onupdate = function(inst)
			if inst.sg.statemem.chargeSpeed ~= 0 then 
				inst.sg.statemem.chargeSpeed = inst.sg.statemem.chargeSpeed - 3
				inst.Physics:SetMotorVel(inst.sg.statemem.chargeSpeed, 0, 0)
			end
		end, 

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "eat",
		tags = {"busy"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("attack1")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boaron/stun")
		end,

		timeline=
		{
			--TimeEvent(14*FRAMES, function(inst) end), --inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/attack") end),
			TimeEvent(2*FRAMES, function(inst) 
				inst:PerformBufferedAction()
			end),
		},

		events=
		{
			EventHandler("animover", function(inst)  inst.sg:GoToState("idle")  end),
		},
	},

	State{
		name = "hit",
		tags = {"busy", "hit"},

		onenter = function(inst, cb)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("hit")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boaron/hit")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "taunt",
		tags = {"busy"},

		onenter = function(inst, cb)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("taunt")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boaron/taunt")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},
	},

	State{
		name = "death",
		tags = {"busy"},

		onenter = function(inst)
			inst.brain:Stop()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boaron/death")
			inst.AnimState:PlayAnimation("death")
			inst.Physics:Stop()
			RemovePhysicsColliders(inst)            
			inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
		end,

	},

	State{
        name = "frozen",
        tags = {"busy",  "frozen"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("fossilized") 
        end,

        events=
        {
			EventHandler("animover", function(inst) inst.AnimState:SetPercent("fossilized", 0.99)  end ),
			EventHandler("frozen", function(inst) inst.sg:GoToState("frozen")  end ),
			EventHandler("onthaw", function(inst) inst.sg:GoToState("thaw")  end ),
			EventHandler("unfreeze", function(inst) inst.sg:GoToState("hit")  end ),
        },
	},
	
	State{
        name = "thaw",
        tags = {"busy",  "thawing"},

		onenter = function(inst)
			inst.AnimState:PlayAnimation("fossilized_shake", true) 
			inst.SoundEmitter:PlaySound("dontstarve/common/freezethaw", "thawing")
		end,

		onexit = function(inst) 
			inst.SoundEmitter:KillSound("thawing")
		end,
		
		events=
        {
            EventHandler("unfreeze", function(inst) inst.sg:GoToState("hit")  end ),
		},
    },
}

CommonStates.AddSleepStates(states,
{
	sleeptimeline = {
		TimeEvent(0, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boaron/sleep")
		end),
	},
})

CommonStates.AddRunStates(states,
{
	starttimeline = 
    {
	    TimeEvent(0*FRAMES, function(inst) inst.Physics:Stop() end ),
    },
	runtimeline = {
		    TimeEvent(0*FRAMES, function(inst) inst.Physics:Stop() end ),
            TimeEvent(2*FRAMES, function(inst) 
                inst.components.locomotor:RunForward()
            end ),
            TimeEvent(10*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/step")
                inst.Physics:Stop()
            end ),
	},
})

CommonStates.AddHopStates(states, true, { pre = "run_pre", loop = "run_loop", pst = "run_pst"})

return StateGraph("hattypiggy_tfc", states, events, "taunt", actionhandlers)
