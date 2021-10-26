--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

require("stategraphs/commonstates")

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

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
			and not inst.sg:HasStateTag("hit")
		then 
			if not inst.sg:HasStateTag("flip") then
				inst.sg:GoToState("hit") 
			else
				inst.sg:GoToState("flipped_hit") 
			end
		end 
	end),
	EventHandler("death", function(inst) inst.sg:GoToState("death") end),
	EventHandler("doattack", function(inst, data) 
		if not inst.components.health:IsDead() 
			or not inst.sg:HasStateTag("busy")
		then 
			inst.sg:GoToState("attack", data.target) 
		end 
	end),
	EventHandler("entershield", function(inst) 
		if not inst.components.health:IsDead() and 
			not inst.sg:HasStateTag("slide") 
		then
			inst.sg:GoToState("shield") 
		end
	end),
	EventHandler("exitshield", function(inst)
		if not inst.components.health:IsDead() then 
			inst.sg:GoToState("shield_end") 
		end
	end),
	EventHandler("goslide", function(inst)
		if not inst.components.health:IsDead() 
			and not inst.sg:HasStateTag("shield") 
		then
			inst.sg:GoToState("slide_pre") 
		else
			inst.sg:GoToState("slide_pre", true) 
		end
	end),
	EventHandler("freeze", function(inst) inst.sg:GoToState("frozen") end),
	CommonHandlers.OnSleep(),
	CommonHandlers.OnLocomote(false, true),
	--CommonHandlers.OnFreeze(),
}

local states=
{

	State{
		name = "gohome",
		tags = {"busy"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("attack2_pre")
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
			--inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/grunt")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/attack1a")
			inst.AnimState:PlayAnimation("attack1", false)
		end,

		timeline=
		{
			TimeEvent(12*FRAMES, function(inst) 
				--turtle doesn't deal damage to the target
				--instead, it damages all enemies around
				--attacks look pretty good
				local dist = TUNING.SPIKY_TURTLE_TFC.RANGE + 1
				local notags = { "turtle", "shadow", "playerghost", "INLIMBO", "NOCLICK", "FX" }
				local x, y, z = inst.Transform:GetWorldPosition()
				local damage = TUNING.SPIKY_TURTLE_TFC.DAMAGE
				for _, v in pairs(TheSim:FindEntities(x, y, z, dist, {"_combat"}, notags)) do
					if v ~= inst 
						and v:IsValid() 
						and v.entity:IsVisible() 
						and v.components.combat ~= nil 
					then
						v.components.combat:GetAttacked(inst, damage)
					end
				end
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/grunt")
				inst.components.combat.laststartattacktime = GetTime()
			end),
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "slide_pre",
		tags = {"busy", "attack", "slide"},

		onenter = function(inst, noanim)
			inst.canSlide = false
			inst.Physics:Stop()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/shell_impact")
			inst.slides = 0
			if not noanim then
				inst.AnimState:PlayAnimation("attack2_pre", false)
			else
				inst.sg:GoToState("slide")
			end
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("slide") end),
		},
	},

	State{
		name = "slide",
		tags = {"busy", "attack", "slide"},

		onenter = function(inst)
			inst.components.health:SetAbsorptionAmount(0.95)
			--inst.brain:Stop()
			ToggleOffPhysics(inst)
			local notags = {"smallcreature", "FX", "NOCLICK", "INLIMBO", "wall", "turtle", "structure"}
			local target = FindEntity(inst, 30, function(guy)
				return inst.components.combat:CanTarget(guy)
			end, nil, notags)

			if target == nil then
				inst.sg:GoToState("slide_pst")
			else
				inst.AnimState:PlayAnimation("attack2_loop", true)
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/attack2_LP", "_slide")
				local xi, yi, zi = inst.Transform:GetWorldPosition()
				local xt, yt, zt = target.Transform:GetWorldPosition()
				inst:ForceFacePoint(xt, yt, zt)
				--inst.Physics:SetMotorVel(math.sqrt(distsq(xi, zi, xt, zt)) / (10 * FRAMES), 0 ,0)
				inst.Physics:SetMotorVel(1, 0, 0)
				inst.sg:SetTimeout(2)
				inst.slides = inst.slides + 1
				inst.sg.statemem.starttime = GetTime()
				inst._stask = inst:DoPeriodicTask(0.1, function(inst) inst:SlideTask() end)
			end
		end,

		onupdate = function(inst)
			local dtime = GetTime() - inst.sg.statemem.starttime
			local speed 
			if dtime < 1 then
				speed = 25 * dtime
			else
				speed = 25 * (2 - dtime) 
			end
			inst.Physics:SetMotorVel(speed, 0, 0)
		end,

		ontimeout = function(inst)
			--print("slides", inst.slides)
			if inst.slides >= TUNING.SPIKY_TURTLE_TFC.SLIDES_ALLOWED then
				inst.sg:GoToState("slide_pst")
			else
				inst.sg:GoToState("slide")
			end
		end,

		onexit = function(inst)
			ToggleOnPhysics(inst)
			inst.slidehitted = {}
			if inst._stask ~= nil then
				inst._stask:Cancel()
				inst._stask = nil
			end
			--inst.brain:Start()
			inst.components.health:SetAbsorptionAmount(0)
			inst.SoundEmitter:KillSound("_slide")
		end,
	},

	State{
		name = "slide_pst",
		tags = {"busy"},

		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("attack2_pst", false)
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
			inst.AnimState:PlayAnimation("taunt")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/grunt")
		end,

		timeline=
		{
			--TimeEvent(14*FRAMES, function(inst) end), --inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/snake/attack") end),
			TimeEvent(15*FRAMES, function(inst) 
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/hit2")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "flipped",
		tags = {"busy", "flip"},

		onenter = function(inst, time)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("flip_pre")
			inst.AnimState:PushAnimation("flip_loop")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/hit2")

			inst.sg:SetTimeout(time or 5)
		end,

		ontimeout = function(inst)
			inst.sg:GoToState("flipped_pst")
		end,

		timeline=
		{
			TimeEvent(10 * FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/shell_impact")
			end),
		},
		
	},

	State{
		name = "flipped_pst",
		tags = {"busy", "flip"},

		onenter = function(inst)
			inst.AnimState:PlayAnimation("flip_pst")
			--inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/hit2")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},

		timeline=
		{
			TimeEvent(47 * FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/step")
			end),
		},
	},

	State{
		name = "flipped_hit",
		tags = {"busy"},

		onenter = function(inst)
			inst.AnimState:PlayAnimation("flip_hit")
			--inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/hit2")
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
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/taunt")
		end,

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},
	},

	State{
        name = "shield",
        tags = {"busy", "shield"},

        onenter = function(inst)
			inst.components.health:SetAbsorptionAmount(TUNING.SPIKY_TURTLE_TFC.SHIELDED_DAMAGE_REDUCTION)
			inst.components.timer:PauseTimer("slide")
			inst.Physics:Stop()
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/hide_pre")
            inst.AnimState:PlayAnimation("hide_pre")
            inst.AnimState:PushAnimation("hide_idle")
        end,

        onexit = function(inst)
			inst.components.health:SetAbsorptionAmount(0)
			inst.components.timer:ResumeTimer("slide")
		end,
		
		events=
		{
			EventHandler("attacked", function(inst) 
				if inst.components.timer:TimerExists("slide") then
					inst.components.timer:SetTimeLeft("slide", inst.components.timer:GetTimeLeft("slide") - 1)
					if inst.components.timer:GetTimeLeft("slide") == 0 then
						inst.components.timer:ResumeTimer("slide")
					end
				end
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/hit")
				inst.AnimState:PlayAnimation("hide_hit") 
				inst.AnimState:PushAnimation("hide_idle")
			end),
		},
    },

    State{
        name = "shield_end",
        tags = {"busy", "shield", "exitshield"},

		onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/hide_pst")
            inst.AnimState:PlayAnimation("hide_pst", false)
        end,

        events=
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

	State{
		name = "death",
		tags = {"busy"},

		onenter = function(inst)
if inst.brain then inst.brain:Stop() end
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/death")
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
			EventHandler("unfreeze", function(inst) inst.sg:GoToState("idle")  end ),
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
            EventHandler("unfreeze", function(inst) inst.sg:GoToState("idle")  end ),
		},
    },
}

CommonStates.AddSleepStates(states,
{
	sleeptimeline = {
		TimeEvent(15*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/sleep")
		end),
	},
})


CommonStates.AddWalkStates(states,
{
	walktimeline = {
		TimeEvent(2*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/step")
		end),
		TimeEvent(14*FRAMES, function(inst) 
			if math.random() > 0.8 then 
				inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/shell_walk")
			end
			inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/step")
		end), 
	},
})

return StateGraph("spikyturtle_tfc", states, events, "taunt", actionhandlers)
