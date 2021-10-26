require("stategraphs/commonstates")

local actionhandlers =
{
	ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.HARVEST, "eat"),
}

local events=
{
    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") then inst.sg:GoToState("hit") end end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    EventHandler("doattack", function(inst, data) if not inst.components.health:IsDead() and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then inst.sg:GoToState("attack", data.target) end end),
    
    EventHandler("locomote", function(inst)
        local is_moving = inst.sg:HasStateTag("moving")
        local is_running = inst.sg:HasStateTag("running")
        
        local is_idling = inst.sg:HasStateTag("idle")
        local can_run = true 
        local can_walk = true 
        
        local should_move = inst.components.locomotor:WantsToMoveForward()
        local should_run = inst.components.locomotor:WantsToRun()
        if is_moving and not should_move then
            if is_running then
                inst.sg:GoToState("idle")
            else
                inst.sg:GoToState("idle")
            end
        elseif (is_idling and should_move) or (is_moving and should_move and is_running ~= should_run and can_run and can_walk) then
            if can_run and (should_run or not can_walk) then
                inst.sg:GoToState("run")
            elseif can_walk then
                inst.sg:GoToState("walk")
            end
        end
    end),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
}

local states=
{

    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            --inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/idle")
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle", true)
            else
                inst.AnimState:PlayAnimation("idle", true)
            end
 
            if inst:HasTag("enable_shake") then 
            if math.random() < .05 and inst:HasTag("enable_shake") then
 --               if GetWorld().components.flooding and GetWorld().components.flooding.mode == "flood"  then
                    inst.sg:GoToState("shake")
                end
            end
        end,

        timeline=
        {
            TimeEvent(13*FRAMES, 
			function(inst) 
				if inst.components.tiletracker.onwater == false then
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/idle") 
				else
				inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seacreature_movement/thrust")
				end
			end),
        },

    },

    State{
        name = "shake",
        tags = {"busy"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("shake")

			local x,y,z = inst.Transform:GetWorldPosition()
--			local currentLevel = GetWorld().Flooding:GetTargetDepth()
--			if currentLevel < 1 then
--				GetWorld().Flooding:SetTargetDepth(1)	
--			end

--			GetWorld().Flooding:SetPositionPuddleSource(x,0,z)

        end,

		timeline=
        {
			TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/shake") end),
        },

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
            inst.AnimState:PlayAnimation("atk_pre")
			inst.AnimState:PushAnimation("atk", false)
        end,

        timeline=
        {
			TimeEvent(5*FRAMES, function(inst) 
				if inst.components.tiletracker.onwater == false then
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/bark")
				end
			end),
			TimeEvent(18*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/bite") end),
            TimeEvent(20*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
        },

        events=
        {
            EventHandler("animqueueover", function(inst) if math.random() < .1 then inst.components.combat:SetTarget(nil) inst.sg:GoToState("taunt") else inst.sg:GoToState("idle", "atk_pst") end end),
        },
    },

	State{
        name = "eat",
        tags = {"busy"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk", false)
        end,

		timeline=
        {
			TimeEvent(14*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/bite") end),
        },

        events=
        {
			EventHandler("animqueueover", function(inst) if inst:PerformBufferedAction() then inst.components.combat:SetTarget(nil) inst.sg:GoToState("taunt") else inst.sg:GoToState("idle", "atk_pst") end end),
        },
    },

	State{
		name = "hit",
        tags = {"busy", "hit"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("hit")
        end,

		timeline=
        {
            TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/hit") end),
        },

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
	        inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/taunt")

        end,

        timeline=
        {
            TimeEvent(5*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/taunt") end),
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
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/death")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)            
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))     
			
--			local sm = GetSeasonManager()
--			if inst:HasTag("enable_shake") and sm:IsGreenSeason() and sm:GetPercentSeason() > 0.25 then
--				local x,y,z = inst.Transform:GetWorldPosition()
--				local currentLevel = GetWorld().Flooding:GetTargetDepth()
--				if currentLevel < 1 then
--					GetWorld().Flooding:SetTargetDepth(1)	
--				end
--
--				GetWorld().Flooding:SetPositionPuddleSource(x,0,z)
--			end       
        end,

    },

    State{
            
        name = "run",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst) 
        
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run_loop")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/run")

        end,
        
		timeline=
        {
            TimeEvent(0, function(inst) PlayFootstep(inst) end),
            TimeEvent(3*FRAMES, function(inst) PlayFootstep(inst) end),
            TimeEvent(5*FRAMES, function(inst) PlayFootstep(inst) end),
            TimeEvent(7*FRAMES, function(inst) PlayFootstep(inst) end),
        },

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
          
    }, 

     State{
            
        name = "walk",
        tags = {"moving", "canrotate"},
        
        onenter = function(inst) 
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("run_loop")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/bark")
        end,
        
		timeline=
        {
            TimeEvent(0, function(inst) PlayFootstep(inst) end),
            TimeEvent(3*FRAMES, function(inst) PlayFootstep(inst) end),
            TimeEvent(5*FRAMES, function(inst) PlayFootstep(inst) end),
            TimeEvent(7*FRAMES, function(inst) PlayFootstep(inst) end),
        },

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
        },
    },
	
    State{
        name = "hop_pre",
        tags = { "doing", "busy", "jumping", "canrotate" },

        onenter = function(inst)
			inst.sg.statemem.swimming = inst:HasTag("swimming")
            inst.AnimState:PlayAnimation("taunt")
			if not inst.sg.statemem.swimming then		      
				inst.Physics:ClearCollidesWith(COLLISION.LIMITS)
			end
			if inst.components.embarker:HasDestination() then
	            inst.sg:SetTimeout(18 * FRAMES)
                inst.components.embarker:StartMoving()
			else
	            inst.sg:SetTimeout(18 * FRAMES)
                if inst.landspeed then
                    inst.components.locomotor.runspeed = inst.landspeed 
                end                
                inst.components.locomotor:RunForward()
			end
        end,

	    onupdate = function(inst,dt)                
			if inst.components.embarker:HasDestination() then
				if inst.sg.statemem.embarked then
					inst.components.embarker:Embark()
					inst.components.locomotor:FinishHopping()
					inst.sg:GoToState("hop_pst", false)                    
				elseif inst.sg.statemem.timeout then
					inst.components.embarker:Cancel()
					inst.components.locomotor:FinishHopping()

					local x, y, z = inst.Transform:GetWorldPosition()
					inst.sg:GoToState("hop_pst", not TheWorld.Map:IsVisualGroundAtPoint(x, y, z) and TheWorld.Map:GetPlatformAtPoint(x, z) == nil)
				end
            elseif inst.sg.statemem.timeout or  
                   (inst.sg.statemem.tryexit and inst.sg.statemem.swimming == TheWorld.Map:IsVisualGroundAtPoint(inst.Transform:GetWorldPosition())) or 
                   (not inst.components.locomotor.dest and not inst.components.locomotor.wantstomoveforward) then 
				inst.components.embarker:Cancel()
				inst.components.locomotor:FinishHopping()
				local x, y, z = inst.Transform:GetWorldPosition()
				inst.sg:GoToState("hop_pst", not TheWorld.Map:IsVisualGroundAtPoint(x, y, z) and TheWorld.Map:GetPlatformAtPoint(x, z) == nil)
			end
		end,

        timeline =
        {	
        TimeEvent(0, function(inst) 
			if inst:HasTag("swimming") then 
				SpawnPrefab("splash_green").Transform:SetPosition(inst.Transform:GetWorldPosition()) 
			end
		end),
		},			

		ontimeout = function(inst)
			inst.sg.statemem.timeout = true          
		end,

        events =
        {
            EventHandler("done_embark_movement", function(inst)
				if not inst.AnimState:IsCurrentAnimation("taunt") then
					inst.AnimState:PlayAnimation("taunt", false)
				end
				inst.sg.statemem.embarked = true
            end),     
            EventHandler("animover", function(inst)       
				if not inst.AnimState:IsCurrentAnimation("taunt") then
					if inst.AnimState:AnimDone() then                    
						if not inst.components.embarker:HasDestination() then                                                               
							inst.sg.statemem.tryexit = true
						end                    
					end 
					inst.AnimState:PlayAnimation("taunt", false)
				end
            end),
        },

		onexit = function(inst)
            inst.Physics:CollidesWith(COLLISION.LIMITS) 
			if inst.components.embarker:HasDestination() then
				inst.components.embarker:Cancel()
				inst.components.locomotor:FinishHopping()
			end

		end,
    },

    State{
        name = "hop_pst",
        tags = { "busy", "jumping" },

        onenter = function(inst, land_in_water)
			if land_in_water then
				inst.components.amphibiouscreature:OnEnterOcean()	            
			else
				inst.components.amphibiouscreature:OnExitOcean()	            
			end

            inst.AnimState:PlayAnimation("taunt")
        end,

        timeline =
        {		
		TimeEvent(4 * FRAMES, function(inst) 
			if inst:HasTag("swimming") then 
				inst.components.locomotor:Stop()
				SpawnPrefab("splash_green").Transform:SetPosition(inst.Transform:GetWorldPosition()) 
			end
		end),
		TimeEvent(6 * FRAMES, function(inst) 
			if not inst:HasTag("swimming") then 
                inst.components.locomotor:StopMoving()
			end
		end),
		},

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
			if onexits ~= nil and onexits.hop_pst ~= nil then
				onexits.hop_pst(inst)
			end
		end,
    },

	
    State{
        name = "hop_antic",
        tags = { "doing", "busy", "jumping", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.sg.statemem.swimming = inst:HasTag("swimming")

            inst.AnimState:PlayAnimation("taunt")    

            inst.sg:SetTimeout(30 * FRAMES)
        end,

        timeline =
        {	
		},
		

        ontimeout = function(inst)
            inst.sg:GoToState("hop_pre")
        end,
        onexit = function(inst)
        end,        
    }		
}

CommonStates.AddFrozenStates(states)
CommonStates.AddSleepStates(states,
	{
		sleeptimeline = {
	        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/sleep") end),
			TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/sleep") end),
		},
	})

return StateGraph("crocodog", states, events, "idle", actionhandlers)

