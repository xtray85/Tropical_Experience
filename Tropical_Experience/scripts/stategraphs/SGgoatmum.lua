require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
}

local events=
{
    CommonHandlers.OnLocomote(true,true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
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
                inst.AnimState:PushAnimation("idle_loop", true)
            else
                inst.AnimState:PlayAnimation("idle_loop", true)
            end
        end,

    },
	
--[[    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/death")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
        end,
    },	
]]	


	
    State{
        name = "hit",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("start_pst")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },
	
    State{
        name = "idle_happy",
		tags = {"idle_happy", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("idle_happy")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },	

    State{
        name = "goodbye",
		tags = {"busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("goodbye")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("goodbye_loop") end ),
        },
    },

    State{
        name = "goodbye_loop",
		tags = {"busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("goodbye_loop")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },	
	
    State{
        name = "give_item",
		tags = {"busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("give_item")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "coin",
		tags = {"busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("coin")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "look1",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("look1")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "look2",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("look2")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "start",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("start_pre")
            inst.AnimState:PushAnimation("start_loop")
            inst.AnimState:PushAnimation("start_pst")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "talk1",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("talk1")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "talk2",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("talk2")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "talk3",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("talk3")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "talk4",
		tags = {"hit", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("talk4")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },	
	
}

CommonStates.AddSleepStates(states,
{
	sleeptimeline = 
	{
		TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/sleep") end ),
	},
})

CommonStates.AddIdle(states)
CommonStates.AddSimpleActionState(states, "pickup", "walk_loop", 10 * FRAMES, { "busy" })
CommonStates.AddSimpleActionState(states, "gohome", "walk_loop", 4*FRAMES, {"busy"})
CommonStates.AddFrozenStates(states)

CommonStates.AddWalkStates(states,
{
	walktimeline = 
	{
	TimeEvent(0*FRAMES, PlayFootstep ),
	TimeEvent(12*FRAMES, PlayFootstep ),
	},
})
CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(10*FRAMES, PlayFootstep ),
	},
})

    
return StateGraph("goatmum", states, events, "idle", actionhandlers)

