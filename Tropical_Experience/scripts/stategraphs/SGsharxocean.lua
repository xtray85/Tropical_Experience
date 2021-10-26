require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "action"),
    ActionHandler(ACTIONS.EAT, 
		function(inst, action)
			return action.target.components.oceanfishable ~= nil and "bitehook_pre" or "eat"
		end),
}

local events=
{
    CommonHandlers.OnLocomote(true, true),
    EventHandler("dobreach", function(inst, data) 
		if not inst.sg:HasStateTag("jumping") then
            inst.sg:GoToState("breach") 
        end 
    end),  
    EventHandler("doleave", function(inst, data) 
        if not inst.sg:HasStateTag("busy") and not inst.sg:HasStateTag("jumping") then 
            inst.sg:GoToState("leave") 
        end 
    end),
    EventHandler("oceanfishing_stoppedfishing", function(inst, data)
		if not inst.leaving and not inst.sg:HasStateTag("jumping") then
            inst.sg:GoToState("breach") 
		end
		inst.leaving = true
    end),
}

local function SpawnSplashFx(inst)
	if inst.fish_def.breach_fx ~= nil and not inst.sg.statemem.underboat then
		SpawnPrefab(inst.fish_def.breach_fx[math.random(#inst.fish_def.breach_fx)]).Transform:SetPosition(inst.Transform:GetWorldPosition())
	end
end

local function IsUnderBoat(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
	inst.sg.statemem.underboat = TheWorld.Map:GetPlatformAtPoint(x, y, z, inst:GetPhysicsRadius(0)) ~= nil
	return inst.sg.statemem.underboat
end

local function SetBreaching(inst, is_in_air)
	if is_in_air then
--		inst.Transform:SetTwoFaced()
--		inst.AnimState:SetSortOrder(0)
--        inst.AnimState:SetLayer(LAYER_WORLD)
	else
--		inst.Transform:SetSixFaced()
--		inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
--        inst.AnimState:SetLayer(LAYER_BELOW_GROUND)
	end
end

local states=
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("run_loop_water", true)
            if inst.timetoleave then 
                inst.sg:GoToState("leave")
            end
        end,
    },
    
    State{
        name = "arrive",
        tags = {"busy", "canrotate"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk")
            inst.AnimState:PushAnimation("atk_pst")	
        end,

        events =
        {
	        EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
		},
    },
    
    State{
        name = "leave",
        tags = {"busy"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("submerge", true)
        end,

        events =
        {
	        EventHandler("animover", function(inst) 
			local x, y, z = inst.Transform:GetWorldPosition()
			local part = SpawnPrefab("sharx")
			if part ~= nil then
			part.Transform:SetPosition(x, y, z)
			if part.components.health ~= nil then
			part.components.health:SetPercent(1)
			end
			end				
			
			inst:Remove("idle") 
			
			end),
		},
    },

    State{
        name = "eat",
        tags = {"busy", "jumping"},
        
        onenter = function(inst)
			if IsUnderBoat(inst) then
				inst:PerformBufferedAction()
				inst.sg:GoToState("idle")
				return
			end

            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("taunt")				
			SetBreaching(inst, true)
			SpawnSplashFx(inst)

			inst:PerformBufferedAction()
        end,
        
        timeline =
        {
            TimeEvent(16*FRAMES, function(inst)
				SpawnSplashFx(inst)
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
			SetBreaching(inst, false)
		end,
    },

    State{
        name = "bitehook_pre",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.components.locomotor:Stop()
			inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_baitsplash")
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk")
            inst.AnimState:PushAnimation("atk_pst")				
			inst:PerformBufferedAction()
        end,
        
        events =
		{
	        EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
					if inst.components.oceanfishable ~= nil and inst.components.oceanfishable:GetRod() ~= nil then
						inst.sg:GoToState("bitehook_loop")
					else
						inst.sg:GoToState("bitehook_escape")
					end
				end
			end),
		},
    },    

    State{
        name = "bitehook_loop",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("run_loop", true)
            inst.sg:SetTimeout(inst.fish_def.set_hook_time.base + math.random() * inst.fish_def.set_hook_time.var)
        end,
        
		onupdate = function(inst)
			if inst.components.oceanfishable ~= nil and inst.components.oceanfishable:GetRod() ~= nil then
				if not inst:HasTag("partiallyhooked") then
					inst.sg:GoToState("idle")
				end
			else 
				inst.sg:GoToState("bitehook_escape")
				inst.leaving = true
				inst.components.oceanfishable:SetRod(nil)
			end
		end,

        ontimeout = function(inst)
			if inst:HasTag("partiallyhooked") then
				inst.sg:GoToState("bitehook_escape")
				if inst.components.oceanfishable ~= nil and inst.components.oceanfishable:GetRod() ~= nil then
					inst.leaving = true
					inst.components.oceanfishable:GetRod().components.oceanfishingrod:StopFishing("linetooloose")
				else
					inst.leaving = true
					inst.components.oceanfishable:SetRod(nil)
				end
			end
        end,
    },    

    State{
        name = "bitehook_escape",
        tags = {"busy", "jumping"},
        
        onenter = function(inst)
            inst.components.locomotor:Stop()
			inst.sg.statemem.underboat = IsUnderBoat(inst)
			if inst.sg.statemem.underboat then
            inst.AnimState:PlayAnimation("run_water_loop", true)
			else
			inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("hit")
			end
        end,
        
        timeline =
        {
            TimeEvent(2*FRAMES, function(inst) 
				SpawnSplashFx(inst) 
				SetBreaching(inst, true)
			end),
            TimeEvent(3*FRAMES, function(inst) 
				if not inst.sg.statemem.underboat then 
					inst.Physics:SetMotorVelOverride(-1, 0, 0)
				end
			end),
            TimeEvent(21*FRAMES, function(inst)
				SpawnSplashFx(inst)
				inst.Physics:ClearMotorVelOverride()
				inst.components.locomotor:Stop()
            end),
        },
		
		events =
		{
	        EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
					SpawnSplashFx(inst)
					inst.sg:GoToState("idle")
				end
			end),
		},

		onexit = function(inst)
			SetBreaching(inst, false)
			inst.Physics:ClearMotorVelOverride()
			if inst:HasTag("partiallyhooked") and inst.components.oceanfishable ~= nil then
				inst.components.oceanfishable:SetRod(nil)
			end
		end,
    },    

    State{
        name = "breach",
        tags = {"busy", "jumping"},
        
        onenter = function(inst)
			if IsUnderBoat(inst) then
				inst.sg:GoToState("idle")
				return
			end
        inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("taunt")
        end,

		timeline =
		{
            TimeEvent(2*FRAMES, function(inst) 
				SpawnSplashFx(inst)
				SetBreaching(inst, true)
			end),
            TimeEvent(4*FRAMES, function(inst) 
				inst.Physics:SetMotorVelOverride(1.5, 0, 0)
			end),
            TimeEvent(6*FRAMES, function(inst)
				SpawnSplashFx(inst)
                inst.Physics:ClearMotorVelOverride()
                inst.components.locomotor:Stop()
            end),
			
            TimeEvent(8*FRAMES, function(inst)
				inst.Physics:ClearMotorVelOverride()
                inst.sg:GoToState("idle")
            end),				
		},

        events =
        {
            EventHandler("animqueueover", function(inst)
				inst.Physics:ClearMotorVelOverride()
                inst.sg:GoToState("idle")
            end),
        },

		onexit = function(inst)
			SetBreaching(inst, false)
		end,

    },  

    State{
        name = "launched_out_of_water",
        tags = {"busy", "jumping"},
        
        onenter = function(inst)
			SpawnSplashFx(inst)
            inst.components.locomotor:Stop()
			inst.AnimState:OverrideSymbol("1", "sharx_build", "")
			inst.AnimState:OverrideSymbol("2", "sharx_build", "")
			inst.AnimState:OverrideSymbol("droplet", "sharx_build", "")
			inst.AnimState:OverrideSymbol("ripple_end", "sharx_build", "")
			inst.AnimState:OverrideSymbol("ripple_still", "sharx_build", "")	
			inst.AnimState:OverrideSymbol("ripple2", "sharx_build", "")
			inst.AnimState:OverrideSymbol("ripple3", "sharx_build", "")	
			inst.AnimState:OverrideSymbol("ripple4", "sharx_build", "")			
			inst.AnimState:OverrideSymbol("ripple55", "sharx_build", "")	
			inst.AnimState:OverrideSymbol("ripple88", "sharx_build", "")	
			inst.AnimState:OverrideSymbol("splash	", "sharx_build", "")
			inst.AnimState:OverrideSymbol("water_shadow", "sharx_build", "")
			
		    inst.AnimState:PlayAnimation("idle", true)
        end,
    },  
	
    State{
        name = "walk_start",
        tags = {"moving", "canrotate", "swimming"},
        
       
        onenter = function(inst) 
            inst.AnimState:PlayAnimation("run_water_loop", true)
                inst.components.locomotor:WalkForward()
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
        },
    },

    State{
        name = "walk",
        tags = {"moving", "canrotate", "swimming"},
        
       
        onenter = function(inst)
            inst.AnimState:PlayAnimation("run_water_loop", true)
                inst.components.locomotor:WalkForward()
        end,     

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
        },
    },
	
    State{
        name = "walk_stop",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst) 
            inst.AnimState:PlayAnimation("run_water_loop", true)
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
            inst.AnimState:PlayAnimation("run_water_loop", true)
                inst.components.locomotor:RunForward()
        end,
            
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
    },

    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst)
                inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run_water_loop", true)
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),
        },
    },

    State{
        name = "run_stop",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst) 	
            inst.AnimState:PlayAnimation("run_water_loop", true)
        end,
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
    },

}

--CommonStates.AddWalkStates(states)
--CommonStates.AddRunStates(states)

return StateGraph("sgballphinocean", states, events, "idle", actionhandlers)
