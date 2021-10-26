require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.PICKUP, "pickup"),
    ActionHandler(ACTIONS.EQUIP, "pickup"),
    ActionHandler(ACTIONS.TAKEITEM, "pickup"),
	ActionHandler(ACTIONS.MINE, "mine"),	
}


local events=
{
	CommonHandlers.OnSleep(),
	CommonHandlers.OnLocomote(false,true),
	CommonHandlers.OnAttacked(true),
	CommonHandlers.OnAttack(),
	CommonHandlers.OnFreeze(),
	CommonHandlers.OnDeath(),
}

local states=
{

	State{

		name = "idle",
		tags = {"idle", "canrotate"},
		onenter = function(inst, playanim)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("idle", true)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/idle_swim")
            inst.sg:SetTimeout(4 + math.random()*3)
		end,

		ontimeout = function(inst)
			inst.sg:GoToState("flip")
		end,
	},

	State{

		name = "flip",
		tags = {"busy", "canrotate"},
		onenter = function(inst, playanim)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("jump")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/emerge")
		end,

		timeline=
		{
			TimeEvent(7*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seacreature_movement/water_emerge_sml") end),
		},

		events=
		{
			EventHandler("animover", function(inst) 
				inst.sg:GoToState("idle")
			end),
		},
	},

	State{
		name = "walk_start",
		tags = {"moving", "canrotate"},

		onenter = function(inst)
			inst.AnimState:PlayAnimation("walk_pre")
		end,

		events =
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
		},
	},

	State{
		name = "walk",
		tags = {"moving", "canrotate"},

		onenter = function(inst)
			inst.components.locomotor:WalkForward()
			if math.random() < 0.8 then
				inst.AnimState:PlayAnimation("walk_loop")
			else
				inst.AnimState:PlayAnimation("leap")
			end
		end,
		timeline=
		{
			TimeEvent(21*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seacreature_movement/water_swimbreach_sml") end),
			TimeEvent(48*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seacreature_movement/water_swimbreach_sml") end),
		},
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),
		},
	},

	State{
		name = "leap",
		tags = {},
		onenter = function(inst)

		end,
	},

	State{
		name = "walk_stop",
		tags = {"canrotate"},

		onenter = function(inst)
			inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("walk_pst")
		end,

		timeline=
		{
			TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seacreature_movement/water_swimbreach_sml") end),
			TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/emerge") end),
		},

		events=
		{   
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
		},
	},

	State{
		name = "death",
		tags = {"busy"},

		onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/death")
			inst.AnimState:PlayAnimation("death")
			inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
		end,

	},

	State{
		name = "hit",
		tags = {"busy", "hit"},

		onenter = function(inst, cb)
			inst.AnimState:SetOrientation(ANIM_ORIENTATION.Default )
			inst.AnimState:PlayAnimation("hit")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/hit")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "attack",
		tags = {"attack", "busy"},

		onenter = function(inst, target)
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			inst.components.combat:StartAttack()
			inst.AnimState:PlayAnimation("atk", false)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/attack")
		end,

		onexit = function(inst)
		end,

		timeline=
		{
			TimeEvent(16*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
		},

		events=
		{
			EventHandler("animqueueover",  function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "taunt",
		tags = {"busy"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("taunt")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/taunt")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},
}

CommonStates.AddSleepStates(states, 
{
	sleeptimeline = 
	{
		TimeEvent(1, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/sleep") end)
	},
})

CommonStates.AddFrozenStates(states)
CommonStates.AddSimpleActionState(states, "gohome", "idle", 4 * FRAMES, { "busy" })
  
return StateGraph("ballphin", states, events, "idle", actionhandlers)
