require("stategraphs/commonstates")

local events =
{
	EventHandler("attacked", function(inst) 
		if not inst.components.health:IsDead() 
			and not inst.sg:HasStateTag("hit")
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
}

local states=
{
	State{
		name = "idle",
		tags = {"idle", "canrotate"},
		onenter = function(inst, playanim)
		inst.voumorrer = inst.voumorrer + 1
			--inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/idle")
			inst.Physics:Stop()
			if playanim then
				inst.AnimState:PlayAnimation(playanim)
				inst.AnimState:PushAnimation("idle", true)
			else
				inst.AnimState:PlayAnimation("idle", true)
			end
			inst.sg:SetTimeout(2 * math.random() + .5)
		end,

		events =
        {
            EventHandler("animover", function(inst)
			if inst.voumorrer and inst.voumorrer > 10 then inst.sg:GoToState("death") else
			inst.sg:GoToState("idle") 
			end
            end),
        },
	},

	State{
		name = "attack",
		tags = {"attack", "busy"},

		onenter = function(inst, target)
			inst.voumorrer = inst.voumorrer + 1
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			inst.components.combat:StartAttack()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/attack1a")
			inst.AnimState:PlayAnimation("attack", false)
		end,

		timeline=
		{
			TimeEvent(7*FRAMES, function(inst) 
				inst.components.combat:DoAttack(inst.sg.statemem.target)
			end),
			TimeEvent(17*FRAMES, function(inst) 
				inst.components.combat:DoAttack(inst.sg.statemem.target)
			end),
		},

		events=
		{
			EventHandler("animover", function(inst) 
			if inst.voumorrer and inst.voumorrer > 10 then inst.sg:GoToState("death") else
			inst.sg:GoToState("idle") 
			end
			end),
		},
	},

	State{
		name = "hit",
		tags = {"busy", "hit"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("hit")
			inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_hit")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "spawn",
		tags = {"busy"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("spawn")
			inst.SoundEmitter:PlaySound("dontstarve/common/staff_star_create")
		end,

		events=
		{
			EventHandler("animover", function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/common/treefire", "ambsound")
				inst.sg:GoToState("idle") 
			end),
		},
	},

	State{
		name = "death",
		tags = {"busy"},

		onenter = function(inst)
			inst.SoundEmitter:KillSound("ambsound")
			inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_break")
			inst.AnimState:PlayAnimation("death")
			inst.Physics:Stop()
			RemovePhysicsColliders(inst)
		end,
		
		events=
		{
			EventHandler("animover", function(inst) 
				inst:Remove() 
			end),
		},		

	},
}

return StateGraph("tfwpelemental", states, events, "spawn")
