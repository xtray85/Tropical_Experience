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
	EventHandler("dospit", function(inst, target) 
		if not inst.components.health:IsDead() 
			and (inst.sg:HasStateTag("hit") 
			or not inst.sg:HasStateTag("busy")) 
		then 
			inst.sg:GoToState("spit", target) 
		end 
	end),
	EventHandler("freeze", function(inst) inst.sg:GoToState("frozen") end),
	EventHandler("spreadpoison", function(inst) inst.sg:GoToState("spread") end),
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
			inst.AnimState:PlayAnimation("spit")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/grunt")
			inst.AnimState:PlayAnimation("attack_pre")
			inst.AnimState:PushAnimation("attack", false)
		end,

		timeline=
		{
			TimeEvent(12 * FRAMES, function(inst) --20 frames total
				inst.components.combat:DoAttack(inst.sg.statemem.target) 
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/attack")
            end), 
		},

		events=
		{
			EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "spit",
		tags = {"busy", "attack"},

		onenter = function(inst, target)
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("spit", false)
			if inst.weapon ~= nil and inst.components.inventory ~= nil then
                inst.components.inventory:Equip(inst.weapon)
			end
			inst.components.combat:StartAttack()
		end,

		onexit = function(inst)
            if inst.components.inventory then
                inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
            end
		end,
		
		timeline=
		{
			TimeEvent(12 * FRAMES, function(inst) --20 frames total
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/spit")
				inst.components.combat.lastrangeattacktime = GetTime()
				inst.components.combat:DoAttack(inst.sg.statemem.target) 
            end), 
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "spread",
		tags = {"busy", "attack"},

		onenter = function(inst)
			inst.Physics:Stop()
			if inst._sctask ~= nil then
				inst._sctask:Cancel()
			end
			inst.spitCharge = 0
			inst._sctask = inst:DoPeriodicTask(5, inst.SpitChargeFN)
			inst.AnimState:PlayAnimation("taunt", false)
			if inst.massweapon ~= nil and inst.components.inventory ~= nil then
                inst.components.inventory:Equip(inst.massweapon)
			end
			--inst.components.combat:StartAttack()
		end,

		onexit = function(inst)
            if inst.components.inventory then
                inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
            end
		end,
		
		timeline=
		{
			TimeEvent(12 * FRAMES, function(inst) --20 frames total
				inst:DoSpread()
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/spit")
            end), 
		},

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
			inst.AnimState:PlayAnimation("attack")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/grunt")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/hit")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/taunt")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/death")
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
		TimeEvent(1*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/sleep_in")
		end),
		TimeEvent(20*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/sleep_out")
		end),
	},
})

CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/step") end), 
		TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/step") end), 
		TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/step") end), 
		TimeEvent(22*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/step") end), 
		TimeEvent(28*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/step") end), 
		TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/peghook/step") end), 	
	},
})

return StateGraph("strangescorpion_tfc", states, events, "taunt", actionhandlers)
