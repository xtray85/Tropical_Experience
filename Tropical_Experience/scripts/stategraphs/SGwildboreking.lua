require("stategraphs/commonstates")

local function OnEndHappy(inst)
    inst.sg.mem.endhappytask = nil
    inst.happy = false
end

local function SpawnElite(inst, prefab, xoffs, zoffs, strid)
    local x, y, z = inst.Transform:GetWorldPosition()
    local elite = SpawnPrefab(prefab)
    elite.Transform:SetPosition(x, 0, z)
    x = x + xoffs
    z = z + zoffs
    elite.sg:GoToState("flipout", { dest = Vector3(x, 0, z), strtbl = "PIG_ELITE_INTRO", strid = strid })
    if elite.components.entitytracker ~= nil then
        elite.components.entitytracker:TrackEntity("king", inst)
    end
    if elite.components.knownlocations ~= nil then
        elite.components.knownlocations:RememberLocation("home", Point(x, 0, z))
    end
    if elite.components.minigame_participator ~= nil then
        elite.components.minigame_participator:SetMinigame(inst)
    end
    elite.persists = false

    inst._minigame_elites[elite] = true
    inst:ListenForEvent("onremove", inst._onremoveelite, elite)

    return elite
end

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

        if inst.sg.currentstate.name == "death" or inst:IsMinigameActive() then
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
			
            if inst.sg.mem.sleeping then
                inst.sg:GoToState("sleep")
            else
                inst.AnimState:PlayAnimation("lying")
            end			

            inst.components.health:SetCurrentHealth(inst.components.health.maxhealth)
            inst:DespawnMinions()
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
        tags = { "sleeping", "mindless", "busy"},
        onenter = function(inst)
            inst.components.trader:Disable()
            inst.AnimState:PlayAnimation("sleep_pre")
            inst.AnimState:PushAnimation("sleep_loop", true)
        end,

        onexit = function(inst)
            inst.components.trader:Enable()
        end,
    },	

    State{
        name = "wake",
        tags = { "busy", "mindless", "busy"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("sleep_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("lying")
                end
            end),
        },
    },	

    State{
        name = "intro3",
        tags = { "intro", "mindless" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("cointoss")
            inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingThrowGold")
            inst:EnableCameraFocus(true)
        end,

        timeline =
        {
            TimeEvent(25 * FRAMES, function(inst)
                if inst:IsMinigameActive() then
                    SpawnElite(inst, "pigelite1", -3.5, -3.5, 1)
                    SpawnElite(inst, "pigelite2", 3.5, -3.5, 2)
                    SpawnElite(inst, "pigelite3", -3.5, 3.5, 2)
                    SpawnElite(inst, "pigelite4", 3.5, 3.5, 1)
                end
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst:IsMinigameActive() then
                        inst.sg.statemem.continueintro = true
                        inst.sg:GoToState("intro4")
                    else
                        inst.sg:GoToState("lying")
                    end
                end
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem.continueintro then
                inst:EnableCameraFocus(false)
            end
        end,
    },

    State{
        name = "intro4",
        tags = { "intro", "mindless" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("happy")
            inst:EnableCameraFocus(true)
        end,

        timeline =
        {
            TimeEvent(6 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingHappy") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("lying")
                end
            end),
        },

        onexit = function(inst)
            for k, v in pairs(inst._minigame_elites) do
                k:PushEvent("introover")
            end
            inst:EnableCameraFocus(false)
        end,
    },
	
    State{
        name = "standup",
        tags = { "standup", "mindless", "busy" },

        onenter = function(inst, pushanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("standup")
            --inst.components.talker.offset = Vector3(0, -800, 0)
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
            --inst.components.talker.offset = Vector3(0, -600, 0)
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
        onenter = function(inst)
            inst.AnimState:PlayAnimation("happy")
        end,

        timeline =
        {
            TimeEvent(6 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingHappy") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("lying")
                end
            end),
        },
    },	
	
    State{
        name = "cointoss",
        tags = { "cointoss", "mindless"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("cointoss")
            inst.happy = true
            if inst.sg.mem.endhappytask ~= nil then
                inst.sg.mem.endhappytask:Cancel()
            end
            inst.sg.mem.endhappytask = inst:DoTaskInTime(5, OnEndHappy)
        end,

        timeline =
        {
            TimeEvent(17 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingThrowGold") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("happy")
                end
            end),
        },
    },

    State{
        name = "unimpressed",
        tags = { "unimpressed", "mindless", "busy" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("unimpressed")
            inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingReject")
            inst.happy = false
            if inst.sg.mem.endhappytask ~= nil then
                inst.sg.mem.endhappytask:Cancel()
                inst.sg.mem.endhappytask = nil
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("lying")
                end
            end),
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
            inst.components.lootdropper:DropLoot(inst:GetPosition())            
            print("Removing Pig King body")
	    inst:DoTaskInTime(2, ErodeAway)
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, RemovePhysicsColliders),

            TimeEvent(20*FRAMES, function(inst)
                ShakeIfClose(inst)
                inst.components.groundpounder:GroundPound()                
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/groundpound")
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

        --TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/step_stomp") end),
        --TimeEvent(7*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/bearger/step_stomp") end),

        --TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/footstep") end),
        --TimeEvent(7*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/footstep") end),
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


return StateGraph("wildboreking", states, events, "lying")
