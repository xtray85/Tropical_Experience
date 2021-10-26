require("stategraphs/commonstates")

local actionhandlers = 
{
	ActionHandler(ACTIONS.GOHOME, "gohome"),
	ActionHandler(ACTIONS.EAT, "eat"),
	ActionHandler(ACTIONS.CHOP, "chop"),
	ActionHandler(ACTIONS.DIG, "chop"),
	ActionHandler(ACTIONS.PICKUP, "eat"),
	ActionHandler(ACTIONS.TAKEITEM, "eat"),
	ActionHandler(ACTIONS.EQUIP, "invisibleaction"),
	ActionHandler(ACTIONS.ADDFUEL, "invisibleaction"),
	ActionHandler(ACTIONS.UNPIN, "mindcontrol"),
	ActionHandler(ACTIONS.DEPLOY_AI, "invisibleaction"),
}


local events=
{
	CommonHandlers.OnStep(),
	CommonHandlers.OnLocomote(true,true),
	CommonHandlers.OnHop(),
	CommonHandlers.OnSleep(),
	CommonHandlers.OnFreeze(),
	CommonHandlers.OnAttack(),
	CommonHandlers.OnAttacked(true),
	CommonHandlers.OnDeath(),
	EventHandler("doaction", 
		function(inst, data) 
			if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
				if data.action == ACTIONS.CHOP then
					inst.sg:GoToState("chop", data.target)
				end
			end
		end),
	
}

local states=
{

	State{
		name = "idle",
		tags = {"idle", "canrotate"},
		onenter = function(inst, playanim)
			inst.Physics:Stop()
			if TheWorld.state.isdusk then
				inst.AnimState:PushAnimation("idle_groggy", true)
			else
				inst.AnimState:PlayAnimation("idle_loop", true)
			end
			inst.sg:SetTimeout(2*math.random()+.5)
		end,
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		}, 		

	},
	
    State{
        name = "run_start",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst)
			inst.components.locomotor:RunForward()
			if TheWorld.state.isdusk then 
			inst.AnimState:PlayAnimation("idle_walk_pre") 	
			else 
			inst.AnimState:PlayAnimation("run_pre") 		
			end
            inst.sg.mem.foosteps = 0
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
        
        timeline=
        {        
            TimeEvent(4*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
            end),
        },        
        
    },

    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst) 
            inst.components.locomotor:RunForward()
			if TheWorld.state.isdusk then inst.AnimState:PlayAnimation("idle_walk") 
			if inst.prefab == "bear" then
			inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED -  4
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED - 4				
			else			
			inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED -  2
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED - 2	
			end
			else 
			if inst.prefab == "bear" then
			inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED -  2
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED - 2				
			else
			inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED			
			end
			inst.AnimState:PlayAnimation("run_loop") 			
			end
            
        end,
        
        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        timeline=
        {
            TimeEvent(7*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
            end),
            TimeEvent(15*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
            end),
        },
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
    },
    
    State{
    
        name = "run_stop",
        tags = {"canrotate", "idle"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
		if TheWorld.state.isdusk then 
		inst.AnimState:PlayAnimation("idle_walk_pst") 			
		else inst.AnimState:PlayAnimation("run_pst") 	
		end
        end,
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
        
    },	
	

    State{
        name = "walk_start",
        tags = {"moving", "canrotate"},
        
        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            if TheWorld.state.isdusk then 
			inst.AnimState:PlayAnimation("idle_walk_pre") 				
			else inst.AnimState:PlayAnimation("run_pre") 	
			end
        end,

		timeline =	nil,
		
        events=
        {   
            EventHandler("animover", function(inst)     if inst.AnimState:AnimDone() then inst.sg:GoToState("walk") end end ),        
        },	   
        
    },
	
    State{
        name = "walk",
        tags = {"moving", "canrotate"},
		
        onenter = function(inst)
            inst.components.locomotor:WalkForward()
			if TheWorld.state.isdusk then 
			inst.AnimState:PlayAnimation("idle_walk") 
			if inst.prefab == "bear" then
			inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED -  4
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED - 4				
			else
			inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED -  2
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED - 2
			end
			else 
			if inst.prefab == "bear" then
			inst.components.locomotor.runspeed = - 2
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED	- 2			
			else
			inst.components.locomotor.runspeed = TUNING.PIG_RUN_SPEED
			inst.components.locomotor.walkspeed = TUNING.PIG_WALK_SPEED		
			end
			inst.AnimState:PlayAnimation("run_loop")
			end
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline = nil,

        events=
        {   
            EventHandler("animover", function(inst)     if inst.AnimState:AnimDone() then inst.sg:GoToState("walk") end end ),        
        },		
		
    },
		
    
    State{
    
        name = "walk_stop",
        tags = {"canrotate"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
			if TheWorld.state.isdusk then inst.AnimState:PlayAnimation("idle_walk_pst") else inst.AnimState:PlayAnimation("run_pst") end
        end,
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
        
    },
	
	
	State{
		name= "invisibleaction",	-- Placeholder for when we learn how to work with Spriter
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("idle_loop")
		end,

		timeline=
		{
			
			TimeEvent(7*FRAMES, function(inst) inst:PerformBufferedAction() end ),
		},
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},        
	},
	State {
		name = "frozen",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("frozen_loop_pst")
			inst.Physics:Stop()
		end,
	},

	State{
		name = "death",
		tags = {"busy"},

		onenter = function(inst)
			--inst.SoundEmitter:PlaySound("dontstarve/pig/grunt")
			inst.AnimState:PlayAnimation("death")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/death")
			inst.Physics:Stop()
			RemovePhysicsColliders(inst)
			inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
		end,
		
	},

	State{
		name = "abandon",
		tags = {"busy"},

		onenter = function(inst, leader)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("idle_loop")
			inst:FacePoint(Vector3(leader.Transform:GetWorldPosition()))
		end,

		events =
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},
	},

	State{
		name = "attack",
		tags = {"attack", "busy"},
		
		onenter = function(inst)
			inst.AnimState:PlayAnimation("atk_pre")
		end,
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("attack1") end),
		},
	},
	
	
		State{
		name = "attack1",
		tags = {"attack", "busy"},
		
		onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/eat_beaver")
			inst.components.combat:StartAttack()
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("atk")
		end,
		
		timeline=
		{
			TimeEvent(6*FRAMES, function(inst)
				inst.components.combat:DoAttack()
				--inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/attack")
--				inst.sg:RemoveStateTag("attack")
--				inst.sg:RemoveStateTag("busy")
			end),
		},
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "chop",
		tags = {"chopping"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("atk_pre")
		end,
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("chop1") end),
		},
	},
	

		State{
		name = "chop1",
		tags = {"chopping"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PushAnimation("atk")
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
		end,
		
		timeline=
		{
			
			TimeEvent(1*FRAMES, function(inst) inst:PerformBufferedAction() end ),
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
				inst.AnimState:PlayAnimation("eat_pre")
	end,
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("eat1") end ),
		},        
	},
	
	
	
			State{
		name = "eat1",
		tags = {"busy"},
		
		onenter = function(inst)

			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("eat", false)
		end,
		
		timeline=
		{
			TimeEvent(1*FRAMES, function(inst) inst:PerformBufferedAction() end ),		
			TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/eat_beaver") end),
		},
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},        
	},
	
	
	State{
		name = "hit",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hurt")
			inst.AnimState:PlayAnimation("hit")
			inst.Physics:Stop()            
		end,
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},        
	},   


		State{
		name = "shock",
		tags = {"busy"},
		
		onenter = function(inst)
--			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hurt")
			inst.AnimState:PlayAnimation("shock")
			inst.Physics:Stop()            
		end,
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},        
	},   
	
	
		State{
		name = "jump",
		tags = {"busy"},
		
		onenter = function(inst)
--			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/hurt")
			inst.AnimState:PlayAnimation("transform_pst")
			inst.Physics:Stop()            
		end,
		
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},        
	},  
	
	State{
		name= "mindcontrol",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
local valor = math.random()
            if valor < 0.50 then
			inst.AnimState:PlayAnimation("mindcontrol_pre")
			inst.AnimState:PushAnimation("mindcontrol_loop", true)			
--			elseif
--			valor < 0.75 then
--			inst.AnimState:PlayAnimation("emoteXL_pre_dance0")
--			inst.AnimState:PushAnimation("emoteXL_loop_dance0", true)		
			else
			inst.AnimState:PlayAnimation("yawn")		
			end
			
		end,
		

		timeline=
		{
			TimeEvent(69*FRAMES, function(inst) inst:PerformBufferedAction() end ),		
			TimeEvent(70*FRAMES, function(inst) inst.sg:GoToState("idle") end),
		},		      
	},
	
	State{
		name= "transform",
		tags = {"busy"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("transform_pst")
		end,
		

		timeline=
		{
			TimeEvent(70*FRAMES, function(inst) inst.sg:GoToState("idle") end),
		},		      
	},	

}


local function idleonanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("idle")
    end
end

local function sleeponanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("sleeping")
    end
end

local function onwakeup(inst)
    inst.sg:GoToState("wake")
end

local function onentersleeping(inst)
    inst.AnimState:PlayAnimation("sleep_loop")
end

table.insert(states, State
    {
        name = "sleep",
        tags = { "busy", "sleeping" },

        onenter = function(inst)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("dozy")
            -- if fns ~= nil and fns.onsleep ~= nil then
            --     fns.onsleep(inst)
            -- end
        end,

        timeline = nil,

        events =
        {
            EventHandler("animover", sleeponanimover),
            EventHandler("onwakeup", onwakeup),
        },
    })

    table.insert(states, State
    {
        name = "sleeping",
        tags = { "busy", "sleeping" },

        onenter = onentersleeping,

        timeline = nil,

        events =
        {
            EventHandler("animover", sleeponanimover),
            EventHandler("onwakeup", onwakeup),
        },
    })

    table.insert(states, State
    {
        name = "wake",
        tags = { "busy", "waking" },

        onenter = function(inst)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("wakeup")
            if inst.components.sleeper ~= nil and inst.components.sleeper:IsAsleep() then
                inst.components.sleeper:WakeUp()
            end
            -- if fns ~= nil and fns.onwake ~= nil then
            --     fns.onwake(inst)
            -- end
        end,

        timeline = nil,

        events =
        {
            EventHandler("animover", idleonanimover),
        },
    })

--CommonStates.AddIdle(states, "funnyidle")
CommonStates.AddFrozenStates(states)

CommonStates.AddSimpleActionState(states,"pickup", "pig_pickup", 10*FRAMES, {"busy"})
CommonStates.AddHopStates(states, true, { pre = "run_pre", loop = "run_loop", pst = "run_pst"})
CommonStates.AddSimpleActionState(states, "gohome", "pig_pickup", 4*FRAMES, {"busy"})

	
return StateGraph("SGwildbeaver", states, events, "idle", actionhandlers)

