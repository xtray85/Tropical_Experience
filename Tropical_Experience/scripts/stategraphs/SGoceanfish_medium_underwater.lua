require("stategraphs/commonstates")

local actionhandlers = 
{
--    ActionHandler(ACTIONS.EAT, "eat"),
}

local events=
{
    CommonHandlers.OnLocomote(true,true),
--    CommonHandlers.OnSleep(),
--	CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(true),
    CommonHandlers.OnDeath(),
}

local states=
{
    State
    {
        name = "idle",
        tags = {"idle", "canrotate", "canslide"},
        
		onenter = function(inst)
            inst.AnimState:PlayAnimation("walk_loop", true)
			inst.sg:SetTimeout(math.random()*4+2)
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)			
        end,
		
		ontimeout= function(inst)
            inst.sg:GoToState("funnyidle")
        end,
    },  
	
	State
    {
        name = "funnyidle",
        tags = {"busy"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("loop")
			inst.Physics:Stop()  
        end,
		
		events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },  
    
    State{
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)                
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()            
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },
	
	State{
        name = "eat",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()            
            inst.AnimState:PlayAnimation("walk_loop")
        end,
        
        timeline=
        {
            TimeEvent(20*FRAMES, function(inst) inst:PerformBufferedAction() end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        
    },
	
	State{
        name = "attack",
        tags = {"attack", "busy"},
        
        onenter = function(inst, target)
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("walk_loop")
            inst.sg.statemem.target = target
        end,
        
        timeline=
        {
            --TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/Attack") end),
            --TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/attack_grunt") end),
            TimeEvent(10*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
	
	State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst) 
			
        end,
		
		events=
        {
            EventHandler("animover", function(inst) 
			inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
			inst:Remove() end),
        },  
    },
	
	State{
        name = "dead",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("dead", true)
			
			inst.Transform:SetFourFaced()
			local angle = inst.Transform:GetRotation()
			inst.Transform:SetRotation(angle)
			inst:Remove()
        end,
    },
}

CommonStates.AddSleepStates(states)
CommonStates.AddWalkStates(states)
CommonStates.AddRunStates(states)
    
return StateGraph("fish2", states, events, "idle", actionhandlers)