require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.EAT, "eat"),
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
		    inst.AnimState:PlayAnimation("cheer_pre")
            inst.AnimState:PushAnimation("cheer_loop")
            inst.AnimState:PushAnimation("cheer_pst")
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
            inst.AnimState:PlayAnimation("cheer_loop")
            inst.Physics:Stop()            
        end,

        timeline=
        {
			TimeEvent(15*FRAMES, function(inst) inst.sg:GoToState("idle") end ),
        },		
		
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },	

    State{
        name = "cheer",
		tags = {"cheer", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("cheer")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },		

    State{
        name = "cheer_left",
		tags = {"cheer", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("cheer3")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },			

    State{
        name = "cheer_right",
		tags = {"cheer", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("cheer2")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },	
	
    State{
        name = "eat_right",
		tags = {"eat", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("eat_r")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

    State{
        name = "eat_left",
		tags = {"eat", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("eat_l")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },		

    State{
        name = "chat"
		tags = {"chat", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("chat")
            inst.Physics:Stop()            
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },
	
    State{
        name = "boo"
		tags = {"chat", "busy"},
        onenter = function(inst)
		    inst.AnimState:PlayAnimation("chat")
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
CommonStates.AddSimpleActionState(states, "pickup", "pig_pickup", 10 * FRAMES, { "busy" })
CommonStates.AddSimpleActionState(states, "gohome", "pig_pickup", 4*FRAMES, {"busy"})
--CommonStates.AddSimpleActionState(states, "eat", "eat", 10*FRAMES, {"busy"})
--CommonStates.AddSimpleState(states,"hit", "cheer_loop", {"hit", "busy"})
CommonStates.AddFrozenStates(states)

CommonStates.AddWalkStates(states,
{
	walktimeline = 
	{
	TimeEvent(0*FRAMES, PlayFootstep ),
	TimeEvent(12*FRAMES, PlayFootstep ),
	},
})

--[[CommonStates.AddRunStates(states,"run","walk"
{
	runtimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(10*FRAMES, PlayFootstep ),
	},
})
]]

local function runonanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("run")
    end
end

local function runontimeout(inst)
    inst.sg:GoToState("run")
end

local function idleonanimover(inst)
    if inst.AnimState:AnimDone() then
        inst.sg:GoToState("idle")
    end
end

CommonStates.AddRunStates = function(states, timelines, anims, softstop)
    table.insert(states, State
    {
        name = "run_start",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:RunForward()
			inst.AnimState:PlayAnimation(get_loco_anim(inst, anims ~= nil and anims.startrun or nil, "walk_pre"))
        end,

        timeline = timelines ~= nil and timelines.starttimeline or nil,

        events =
        {
            EventHandler("animover", runonanimover),
        },
    })

    table.insert(states, State
    {
        name = "run",
        tags = { "moving", "running", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            local anim_to_play = get_loco_anim(inst, anims ~= nil and anims.run or nil, "walk_loop")
			inst.AnimState:PlayAnimation(anim_to_play, true)
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline = timelines ~= nil and timelines.runtimeline or nil,

        ontimeout = runontimeout,
    })

    table.insert(states, State
    {
        name = "run_stop",
        tags = { "idle" },

        onenter = function(inst) 
            inst.components.locomotor:StopMoving()
            if softstop == true or (type(softstop) == "function" and softstop(inst)) then
			inst.AnimState:PushAnimation(get_loco_anim(inst, anims ~= nil and anims.stoprun or nil, "walk_pst"), false)
            else
			inst.AnimState:PlayAnimation(get_loco_anim(inst, anims ~= nil and anims.stoprun or nil, "walk_pst"))
            end
        end,

        timeline = timelines ~= nil and timelines.endtimeline or nil,

        events =
        {
            EventHandler("animqueueover", idleonanimover),
        },
    })
end
    
return StateGraph("goat", states, events, "idle", actionhandlers)

