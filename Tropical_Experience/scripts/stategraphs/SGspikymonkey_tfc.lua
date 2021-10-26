--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

require("stategraphs/commonstates")

local slamRecharge = TUNING.SPIKY_MONKEY_TFC.SLAM_RECHARGE

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
			and not inst.sg:HasStateTag("shield") 
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
	EventHandler("entershield", function(inst) 
		if not inst.components.health:IsDead() then
			inst.sg:GoToState("shield") 
		end
	end),
	EventHandler("exitshield", function(inst)
		if not inst.components.health:IsDead() then 
			inst.sg:GoToState("shield_end") 
		end
	end),
	EventHandler("freeze", function(inst) inst.sg:GoToState("frozen") end),
	CommonHandlers.OnSleep(),
	CommonHandlers.OnLocomote(true, false),
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
			if GetTime() - inst.lastTimeSlam > slamRecharge then
				inst.AnimState:PlayAnimation("attack1")
				inst.sg.statemem.slam = true
			else
				inst.AnimState:PlayAnimation("attack2")
			end
		end,

		timeline =
		{
			TimeEvent(21 * FRAMES, function(inst)
				if inst.sg.statemem.slam then
					inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/attack1")
					inst:SlamAttack() 
				end	
            end), 
			TimeEvent(12 * FRAMES, function(inst)
				if not inst.sg.statemem.slam then
					inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/attack2")
					inst.components.combat:DoAttack(inst.sg.statemem.target) 	
				end
            end), 
		},

		events =
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "eat",
		tags = {"busy"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("attack2")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/grunt")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hit")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/taunt")
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
			inst.AnimState:PlayAnimation("death")
			inst.Physics:Stop()
			RemovePhysicsColliders(inst)            
			inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
		end,

		timeline =
		{
			TimeEvent(14 * FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/bodyfall")
            end), 
		},
	},

	State{
        name = "shield",
        tags = {"busy", "shield"},

        onenter = function(inst)
			inst.components.health:SetAbsorptionAmount(TUNING.SPIKY_MONKEY_TFC.SHIELDED_DAMAGE_REDUCTION)
			inst.Physics:Stop()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_pre")
            inst.AnimState:PlayAnimation("hide_pre")
            inst.AnimState:PushAnimation("hide_loop")
        end,

        onexit = function(inst)
			inst.components.health:SetAbsorptionAmount(0)
		end,
		
		events=
		{
			EventHandler("attacked", function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/hide_hit")
				inst.AnimState:PlayAnimation("hide_hit") 
				inst.AnimState:PushAnimation("hide_loop")
			end),
		},
    },

    State{
        name = "shield_end",
        tags = {"busy", "shield", "exitshield"},

		onenter = function(inst)
            inst.AnimState:PlayAnimation("hide_pst", false)
        end,

        events=
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end ),
        },
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/sleep_in")
		end),
		TimeEvent(10, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/sleep_out")
		end),
	},
})

CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/step") end),
		TimeEvent(4, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/trails/step") end),
	},
})

return StateGraph("hattypiggy_tfc", states, events, "taunt", actionhandlers)
