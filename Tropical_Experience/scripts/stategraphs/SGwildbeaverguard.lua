require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.CHOP, "chop"),
    ActionHandler(ACTIONS.PICKUP, "pickup"),
    ActionHandler(ACTIONS.EQUIP, "pickup"),
    ActionHandler(ACTIONS.ADDFUEL, "pickup"),
    ActionHandler(ACTIONS.TAKEITEM, "pickup"),
    ActionHandler(ACTIONS.UNPIN, "pickup"),
}

local events =
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnLocomote(true, true),
    CommonHandlers.OnHop(),	
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(true),
    CommonHandlers.OnDeath(),
    EventHandler("transformnormal", function(inst)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("transformNormal")
        end
    end),
    EventHandler("doaction", function(inst, data)
        if data.action == ACTIONS.CHOP and not (inst.sg:HasStateTag("busy") or inst.components.health:IsDead()) then
            inst.sg:GoToState("chop", data.target)
        end
    end),
}

local states =
{

	State{
		name= "funnyidle",
		tags = {"idle"},
		
		onenter = function(inst)
			inst.Physics:Stop()
			inst.AnimState:PlayAnimation("idle_loop", true)
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
			inst.AnimState:PlayAnimation("frozen")
			inst.Physics:Stop()
		end,
	},
	
    State{
        name = "death",
        tags = { "busy" },

        onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/death")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(inst:GetPosition())
        end,
    },

    State{
        name = "abandon",
        tags = { "busy" },

        onenter = function(inst, leader)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("abandon")
            if leader ~= nil and leader:IsValid() then
                inst:FacePoint(leader:GetPosition())
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle_loop")
            end),
        },
    },

     State{
        name = "attack",
        tags = { "attack", "busy" },

        onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/eat_beaver")
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,

        timeline =
        {
            TimeEvent(6 * FRAMES, function(inst)
				inst.components.combat:DoAttack()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
				inst.sg:RemoveStateTag("attack")
                inst.sg:RemoveStateTag("busy")
            end),
        },
    },

    State{
        name = "chop",
        tags = { "chopping" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "eat",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat")
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "hit",
        tags = { "busy" },

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/pig/oink")
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },
}

CommonStates.AddWalkStates(states,
{
	walktimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(12*FRAMES, PlayFootstep ),
	},
},
{
	startwalk = "run_pre",
	walk = "run_loop",
	stopwalk = "run_pst",
})
CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(10*FRAMES, PlayFootstep ),
	},
})

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

CommonStates.AddIdle(states, "funnyidle")
CommonStates.AddFrozenStates(states)

CommonStates.AddSimpleActionState(states,"pickup", "pig_pickup", 10*FRAMES, {"busy"})
CommonStates.AddHopStates(states, true, { pre = "walk_pre", loop = "walk_loop", pst = "walk_pst"})
CommonStates.AddSimpleActionState(states, "gohome", "pig_pickup", 4*FRAMES, {"busy"})

	
return StateGraph("SGwildbeaverguard", states, events, "idle", actionhandlers)

