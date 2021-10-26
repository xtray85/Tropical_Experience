require("stategraphs/commonstates")

local actionhandlers = 
{
}

local function ShakeIfClose(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .7, .02, 1, inst, 40)
end

local events=
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnLocomote(false,true),
    CommonHandlers.OnFreeze(),
    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() and not
     inst.sg:HasStateTag("attack") and not
      inst.sg:HasStateTag("waking") and not
       inst.sg:HasStateTag("sleeping") and 
        (not inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("frozen")) then
            inst.sg:GoToState("hit") 
      end
    end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),

    EventHandler("doattack", function(inst, data) if not inst.components.health:IsDead() and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then inst.sg:GoToState("attack", data.target) end end),
    EventHandler("gotosleep", function(inst) inst.sg:GoToState("sleeping") end),
    EventHandler("onwakeup", function(inst) inst.sg:GoToState("wake") end),

}



local states=
{

	State{
        name = "attack",
        tags = {"attack", "busy"},
        
        onenter = function(inst, target)
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("anim")
            inst.sg.statemem.target = target
        end,
        
        timeline=
        {
            TimeEvent(11*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
            TimeEvent(26*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),

			TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
			TimeEvent(5*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/attack_VO") end),
			TimeEvent(12*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/swipe") end),
			TimeEvent(22*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
			TimeEvent(23*FRAMES, function(inst) inst.AnimState:PlayAnimation("idle_loop") end),
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
            --inst.SoundEmitter:PlaySound("dontstarve/pig/grunt")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)                    
        end,
		
		
				timeline=
		{
			TimeEvent(6*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/death") end),
			TimeEvent(50*FRAMES, function(inst)
				ShakeIfClose(inst)
				inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
				inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
			end),
		},
        
    },



	State{
        name = "hit",
        tags = {"hit", "busy"},
        
        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt_pre")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/hurt_VO")
            
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        
        timeline=
        {
            TimeEvent(5*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
        },
        
    },  	
	
    State{
        name = "sleeping",
        tags = {"sleeping", "busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
			inst.AnimState:PlayAnimation("sleep_pre")
			inst.AnimState:PushAnimation("sleep_loop", true)
			inst.components.health:StartRegen(1, 3)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/transform_VO")
        end,
        events=
        {
		    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() then
			inst.components.health:StopRegen()
			inst.sg:GoToState("wake") 
			end end),
        },
        
        timeline=
        {
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
            TimeEvent(25*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
        },
        
    },	
	
		State{
        name = "wake",
        tags = {"waking", "busy"},
        
        onenter = function(inst, start_anim)
            inst.Physics:Stop()
			inst.AnimState:PushAnimation("sleep_pst")
			inst.components.health:StopRegen()
            inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/transform_VO")
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },

        timeline=
        {
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
            TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
        },
        
    },     
	
	
	    State{
        name = "panic",
        tags = {"busy"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("taunt_pre")
            inst.AnimState:PushAnimation("taunt_loop", true)
        end,
        onexit = function(inst)
        end,
        
        onupdate = function(inst)
			if inst.components.burnable and not inst.components.burnable:IsBurning() and inst.sg.timeinstate > .3 then
				inst.sg:GoToState("idle", "panic_post")
			end
        end,
    },
	
	
	
    State{
        name = "spawnin",
        tags = {"sleeping", "busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
			inst.AnimState:PlayAnimation("transform")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/transform_VO")
        end,
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        
    },		
	
	
	
	
	
	
	
	
	
	
	
	
}

CommonStates.AddWalkStates(
    states,
    {
		starttimeline =
		{
            TimeEvent(0*FRAMES, function(inst) inst.Physics:Stop() end),
            TimeEvent(11*FRAMES, function(inst) inst.components.locomotor:WalkForward() end),
            TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
            TimeEvent(17*FRAMES, function(inst) inst.Physics:Stop() end),
		},
        walktimeline = 
        { 
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/walk_vo") end),
            TimeEvent(18*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
            TimeEvent(19*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/footstep") end),
            TimeEvent(52*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
            TimeEvent(53*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/footstep") end),
        },
        endtimeline=
        {
            TimeEvent(2*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/foley") end),
        },
    })
	
CommonStates.AddIdle(states)
CommonStates.AddFrozenStates(states)
   
return StateGraph("slipstor", states, events, "idle", actionhandlers)

