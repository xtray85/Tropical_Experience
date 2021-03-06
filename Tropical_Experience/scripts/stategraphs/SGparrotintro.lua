local events =
{
}

local states =
{
    State{
        name = "idle",
        tags = {"idle"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle") -- inst.AnimState:PlayAnimation("idle_loop")
            --inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_jacob")
            if not inst.sg.mem.idle_sound_playing then
                --inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_idle_LP", "portalidle")
                inst.sg.mem.idle_sound_playing = true
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState(math.random() < .7 and "idle" or "funnyidle")
            end),
        },

        timeline =
        {
            --TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_blink") end),
            --TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/vines") end),
            --TimeEvent(18*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/vines") end),
            --TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_jacob") end),
        },
    },

    State{
        name = "funnyidle",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle_peck")--inst.AnimState:PlayAnimation("idle_eyescratch")
            -- inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_blink")
            inst:DoTaskInTime(6*FRAMES, function()
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/birds/peck")
            end)
            inst:DoTaskInTime(11*FRAMES, function()
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/birds/peck")
            end)

        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },

        timeline =
        {
            --TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_blink") end),
            --TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_idle") end),
            --TimeEvent(18*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_idle") end),
            --TimeEvent(13*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_scratch") end),
            --TimeEvent(27*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_scratch") end),
            --TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_jacob") end),
            --TimeEvent(41*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_scratch") end),
            --TimeEvent(59*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_blink") end),
        },
    },

    State{
        name = "spawn_pre",
        tags = {"idle", "open"},
        onenter = function(inst)	
			inst.components.talker:Say(STRINGS.WALLY2)	
            inst.AnimState:PlayAnimation("idle")--inst.AnimState:PlayAnimation("pre_fx")
            if inst.sg.mem.idle_sound_playing then
                inst.SoundEmitter:KillSound("portalidle")
                inst.sg.mem.idle_sound_playing = false
            end

        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg.statemem.keepactivatesound = true
                inst.sg:GoToState("spawn_loop")
            end),
        },


        onexit = function(inst)
            if not inst.sg.statemem.keepactivatesound then
                inst.SoundEmitter:KillSound("portalactivate")
            end
        end,
    },

    State{
        name = "spawn_loop",
        tags = {"busy", "open"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle")--inst.AnimState:PlayAnimation("fx")
            if not inst.sg.mem.idle_sound_playing then
                --inst.SoundEmitter:PlaySound("dontstarve/common/together/spawn_vines/spawnportal_idle_LP", "portalidle")
                inst.sg.mem.idle_sound_playing = true
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                
            end),
        },

        timeline =
        {
            TimeEvent(22*FRAMES, function(inst)
            inst.AnimState:PlayAnimation("idle_peck")
            inst:DoTaskInTime(6*FRAMES, function()
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/birds/peck")
            end)
            inst:DoTaskInTime(11*FRAMES, function()
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/birds/peck")
            end)
            end),

            TimeEvent(55*FRAMES, function(inst) 
			inst.components.talker:Say(STRINGS.WALLY1)
            end),



            TimeEvent(70*FRAMES, function(inst) 
            inst.sg:GoToState("idle") end),

        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("portalactivate")
        end,
    },

    State{
        name = "spawn_pst",
        tags = {"busy"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle")--inst.AnimState:PlayAnimation("pst_fx")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },

        timeline =
        {
            
        },
    },
}

return StateGraph("parrotintro", states, events, "idle")
