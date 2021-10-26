local WALK_SPEED = 4
local RUN_SPEED = 7
local	    JELLYFISH_DAMAGE = 5

require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.GOHOME, "action"),
}

local events=
{
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    EventHandler("locomote", 
        function(inst) 
            if not inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("moving") then return end
            
            if not inst.components.locomotor:WantsToMoveForward() then
                if not inst.sg:HasStateTag("idle") then
                        inst.sg:GoToState("idle")
                end
                if inst.sg:HasStateTag("idle") then
                        inst.sg:GoToState("shock")
                end				
            else
                if not inst.sg:HasStateTag("moving") then
                    inst.sg:GoToState("swimming")
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
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
            else
                inst.AnimState:PlayAnimation("idle")
            end
        end,

        events=
        {
            EventHandler("animqueueover", function(inst)
                if math.random() <= 0.25 then
                    inst.sg:GoToState("shock")
                else
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "shock",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_shock")		
        end,

		timeline=
        {
            TimeEvent(2*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_water") end),
            TimeEvent(5*FRAMES, function(inst) 
			local pclose = GetClosestInstWithTag("player", inst, 2)
			if pclose and pclose.components.health then
			pclose.components.health:DoDelta(-JELLYFISH_DAMAGE)
			pclose.sg:GoToState("electrocute")
			end	end),
        },
		
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "swimming",
        tags = {"moving", "canrotate"},
        
       
        onenter = function(inst, skippre) 
            if skippre then 
                inst.AnimState:PlayAnimation("run")
            else
                inst.AnimState:PlayAnimation("run_pre")
                inst.AnimState:PushAnimation("run")
            end 
            inst.components.locomotor:WalkForward()
            --inst.sg:SetTimeout(2*math.random()+.5)
            if math.random() < 0.5 then
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/bubble_short")
            else
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/bubble_long")
            end
        end,
        
        onupdate= function(inst)
            if not inst.components.locomotor:WantsToMoveForward() then
                inst.sg:GoToState("idle", "run_pst")
            end
        end,  

         events=
        {
             EventHandler("animover", function(inst)                   
               inst.sg:GoToState("shock", true)
            end), 

             EventHandler("animqueueover", function(inst)                   
               inst.sg:GoToState("shock", true)
            end)
        },   
      
        
    },

     State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/death_murder")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)         			
        end,
        events=
        {
            EventHandler("animover", function(inst) inst:Remove() end),
        },		

    }, 
	
	
     State{
        name = "some",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/death_murder")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()        			
        end,
        events=
        {
            EventHandler("animover", function(inst) inst:Remove()  end),
        },		

    }, 
      
    State{
        name = "hit",
        tags = {"busy", "hit"},

        onenter = function(inst, cb)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("hit")
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
}

CommonStates.AddSleepStates(states)
CommonStates.AddFrozenStates(states)
  
return StateGraph("jellyfishkraken", states, events, "idle", actionhandlers)

