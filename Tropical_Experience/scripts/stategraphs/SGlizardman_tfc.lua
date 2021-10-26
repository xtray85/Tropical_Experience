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
	EventHandler("attacked", function(inst) if not inst.components.health:IsDead() and (inst.sg:HasStateTag("attack") or math.random() <= 0.2) then inst.sg:GoToState("hit") end end),
	EventHandler("death", function(inst) inst.sg:GoToState("death") end),
	EventHandler("doattack", function(inst, data) 
		if not inst.components.health:IsDead() 
			and (inst.sg:HasStateTag("hit") 
			or not inst.sg:HasStateTag("busy")) 
		then 
			if inst:IsNear(data.target, TUNING.LIZARDMAN_TFC.ATTACK_RANGE) then
				inst.sg:GoToState("attack", data.target) 
			else
				inst.sg:GoToState("spit_attack", data.target) 
			end
		end 
	end),
	EventHandler("placebanner", function(inst, data) 
		if not inst.components.health:IsDead() 
			and (inst.sg:HasStateTag("hit") 
			or not inst.sg:HasStateTag("busy")) 
		then 
			inst.sg:GoToState("placebanner") 
		end 
	end),
	EventHandler("freeze", function(inst) inst.sg:GoToState("frozen") end),

	CommonHandlers.OnSleep(),
	CommonHandlers.OnLocomote(true, false),
}

local states=
{

	State{
		name = "gohome",
		tags = {"busy"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("run_pst")
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

	},

	State{
		name = "attack",
		tags = {"attack", "busy"},

		onenter = function(inst, target)
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			inst.components.combat:StartAttack()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/attack")
			inst.AnimState:PlayAnimation("attack", false)
		end,

		timeline=
		{
			TimeEvent(8*FRAMES, function(inst) 
				if inst.components.combat.target then
					inst:ForceFacePoint(inst.components.combat.target:GetPosition()) 
				end 
			end),
			TimeEvent(15*FRAMES, function(inst) 
				if inst.components.combat.target then
					inst:ForceFacePoint(inst.components.combat.target:GetPosition())  
					inst.components.combat:DoAttack(inst.sg.statemem.target)
				end
			end),
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "spit_attack",
		tags = {"attack", "busy"},

		onenter = function(inst, target)
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			if inst.weapon and inst.components.inventory then
                inst.components.inventory:Equip(inst.weapon)
			end
			inst.components.combat:StartAttack()
			inst.AnimState:PlayAnimation("spit", false)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/spit")  
		end,

		onexit = function(inst)
            if inst.components.inventory then
                inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
            end
        end,

		timeline=
		{
			TimeEvent(10*FRAMES, function(inst)
				if inst.components.combat.target then
					inst:ForceFacePoint(inst.components.combat.target:GetPosition())
					inst.components.combat:DoAttack(inst.sg.statemem.target)
				end
			end),
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "placebanner",
		tags = {"busy", "banner"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("banner_summon")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/taunt") 
		end,

		timeline=
		{
			--TimeEvent(14*FRAMES, function(inst) end), --inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/attack") end),
			TimeEvent(20*FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/impacts/lava_arena/fossilized_hit") 
				inst:PlaceBanner()
				inst.bannerLastTime = GetTime()
			end),
		},

		events=
		{
			EventHandler("animover", function(inst)  inst.sg:GoToState("idle")  end),
		},
	},

	State{
		name = "eat",
		tags = {"busy"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("attack")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/attack") 
		end,

		timeline=
		{
			--TimeEvent(14*FRAMES, function(inst) end), --inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/attack") end),
			TimeEvent(15*FRAMES, function(inst) 
				if inst:PerformBufferedAction() then
					inst.components.combat:SetTarget(nil) 
					inst.starvationLevel = 0
				end 
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/hit")
			--inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/hurt")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/taunt") 
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/death") 
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
		TimeEvent(30*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/snapper/sleep") 
		end),
	},
})


CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(0, function(inst) end), -- inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/move") end),
		TimeEvent(4, function(inst) end), --inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/move") end),
	},
})

return StateGraph("lizardman_tfc", states, events, "taunt", actionhandlers)
