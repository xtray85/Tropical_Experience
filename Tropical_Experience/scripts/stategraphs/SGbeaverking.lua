require("stategraphs/commonstates")

local function ShakeIfClose(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .7, .02, .3, inst, 40)
end

local function ShakeIfClose_Footstep(inst)
    ShakeAllCameras(CAMERASHAKE.FULL, .35, .02, 1.25, inst, 40)
end

local function DoFootstep(inst) 
    --inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/step_soft")  
    inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/step_stomp")
    ShakeIfClose_Footstep(inst) 
end



local events =
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnLocomote(false, true),
    EventHandler("attacked", function(inst, data)

        if inst.sg.currentstate.name == "death" then
            return
        end

        if inst.sg.currentstate.name == "lying" or
            inst.sg.currentstate.name == "sleep" then
            inst.sg:GoToState("standup")            
            inst:MakePigsAttack()
            inst:RemoveTag("wall")
        elseif 
            inst.sg.currentstate.name ~= "standup" and
            inst.sg.currentstate.name ~= "pound" and
            inst.components.health and 
            not inst.components.health:IsDead() then

            inst.sg:GoToState("hit")
            --inst.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/hit")
            inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingReject")
            inst.JanIke = data.attacker
            inst:MakePigsAttack()
            inst:RemoveTag("wall")
        end
    end),

    EventHandler("locomote",
        function(inst)
            if not inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("moving") then return end

            local is_moving = inst.sg:HasStateTag("moving")
            local is_running = inst.sg:HasStateTag("running")
            local is_idling = inst.sg:HasStateTag("idle")

            local should_move = inst.components.locomotor:WantsToMoveForward()
            local should_run = inst.components.locomotor:WantsToRun()

            if not should_move then
                if not inst.sg:HasStateTag("idle") then
                    if not inst.sg:HasStateTag("running") then
                        inst.sg:GoToState("idle")
                    elseif is_moving then
                        inst.sg:GoToState(is_running and "run_stop" or "walk_stop")
                    else 
                        inst.sg:GoToState("idle")
                    end
                end
            elseif should_run then
                if not inst.sg:HasStateTag("running") then
                    inst.sg:GoToState("run")
                end
            else
                if not inst.sg:HasStateTag("moving") then
                    inst.sg:GoToState("walk_start")
                end
            end
        end),
		
		EventHandler("death", function(inst) inst.sg:GoToState("death") end),
}

local states =
{


    State{
        name = "idle",
        tags = { "idle", "canrotate" },

        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle")
        end,

        timeline = {},
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },


    State{
        name = "lying",
        tags = {"lying", "mindless"},

        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("lying")
            inst.components.health:SetCurrentHealth(inst.components.health.maxhealth)
            inst:AddTag("wall")
        end,

        timeline = {},
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("lying") end),
        },
    },


    State{
        name = "sleep",
        tags = { "busy", "mindless", "busy"},
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("sleep_pre")
            inst.AnimState:PushAnimation("sleep_loop", true)
        end,
        timeline = {},
        events = {},
    },


    State{
        name = "wakeup",
        tags = { "busy", "mindless", "busy"},
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("sleep_pst")
        end,
        timeline = {},
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("lying") end),
        },

    },


    State{
        name = "standup",
        tags = { "standup", "mindless", "busy" },

        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("standup")
            inst:RemoveComponent("store")
        end,

        timeline=
        {
            TimeEvent(5*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh") end),
            TimeEvent(10*FRAMES, function(inst)
                ShakeIfClose(inst)
                inst.components.groundpounder:GroundPound()
                inst.cangroundpound = false
                if not inst.components.timer:TimerExists("GroundPound") then
                    inst.components.timer:StartTimer("GroundPound", TUNING.BEARGER_NORMAL_GROUNDPOUND_COOLDOWN)
                end
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
            end),
        },


        events =
        {            
            EventHandler("animover", function(inst) 
                --inst:SetBrain(inst._brain)
                inst.sg:GoToState("idle") 
            end),
        },
    },


    State{
        name = "sitdown",
        tags = { "sitdown", "mindless", "busy"},
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("sitdown")
			
if not inst.components.store then
		inst:AddComponent("store")
end

        end,
        timeline = {},
        events =
        {            
            EventHandler("animover", function(inst) 
                --inst:SetBrain(nil)
                inst.sg:GoToState("lying") 
            end),
        },
    },


    State{
        name = "happy",
        tags = { "happy", "mindless" },
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("happy")
        end,
        timeline = {},
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("lying") end),
        },
    },


    State{
        name = "cointoss",
        tags = { "cointoss", "mindless"},
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("cointoss")        

        end,
        timeline = {},
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("happy") end),
        },
    },


    State{
        name = "unimpressed",
        tags = { "unimpressed", "mindless", "busy" },
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("unimpressed")
        end,
        timeline = {},
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("lying") end),
        },
    },


    State{
        name = "cast",
        tags = { "cast", "busy" },
        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("cast")
        end,
        
        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_gemstaff")
            end),
            TimeEvent(53 * FRAMES, function(inst)
                --V2C: NOTE! if we're teleporting ourself, we may be forced to exit state here!
                inst:DoUseStaff()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },




    State{
        name = "jump",
        tags = { "jump" , "canrotate", "busy"},

        onenter = function(inst)
            --inst.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/hit")
            inst.AnimState:PlayAnimation("jump")
            inst.Physics:Stop()
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },

    },

    State{
        name = "hit",
        tags = { "busy" , "canrotate"},

        onenter = function(inst)
            --inst.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/hit")
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),
        },

    },


    State{
        name = "pound",
        tags = {"attack", "busy", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("jump")
        end,

        timeline=
        {
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/swhoosh") end),
            TimeEvent(30*FRAMES, function(inst)
                ShakeIfClose(inst)
                inst.components.groundpounder:GroundPound()
                inst.cangroundpound = false
                if not inst.components.timer:TimerExists("GroundPound") then
                    inst.components.timer:StartTimer("GroundPound", TUNING.BEARGER_NORMAL_GROUNDPOUND_COOLDOWN)
                end
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
            end),
        },

        events=
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("walk")
            end),
        },
    },

    State{
        name = "death",
        tags = { "busy" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("death")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/death")		

        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, RemovePhysicsColliders),

            TimeEvent(35*FRAMES, function(inst)
                ShakeIfClose(inst)         
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
            end),
			
			
            TimeEvent(65*FRAMES, function(inst)			
local x, y, z = inst.Transform:GetLocalPosition()
inst.components.lootdropper:DropLoot(inst.Transform:SetPosition(x, y, z))
if inst.entrada == nil then 
local fx = SpawnPrefab("woodlegs_key3")
if fx then fx.Transform:SetPosition(x, y, z) end
inst.entrada = 1
end
 
 if inst.components.knownlocations and inst.components.knownlocations:GetLocation("spawnpoint") then
        local spawner = SpawnPrefab("beaverking_spawner")
        if spawner then
           spawner.Transform:SetPosition(inst.components.knownlocations:GetLocation("spawnpoint"):Get())
        end
end							
            end),						

        },
    },



}

CommonStates.AddWalkStates(states,
{
    walktimeline =
    {
        
        TimeEvent(3*FRAMES, DoFootstep),
        TimeEvent(7*FRAMES, DoFootstep),        

    }
})


CommonStates.AddRunStates(states,
{
    runtimeline =
    {
        TimeEvent(3*FRAMES, DoFootstep),
        TimeEvent(7*FRAMES, DoFootstep),
    }
})


return StateGraph("beaverking", states, events, "lying")

