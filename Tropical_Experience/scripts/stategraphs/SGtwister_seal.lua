require("stategraphs/commonstates")

local events = {
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
}

local states =
{
    State{
        name = "dizzy",
        tags = {"idle"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("seal_idle", true)
            inst.sg:SetTimeout(5)
        end,

        timeline = 
        {
            TimeEvent(1*FRAMES, function(inst)
                if not inst.AnimState:IsCurrentAnimation("seal_idle") then
                    inst.AnimState:PlayAnimation("seal_idle", true)
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("dizzy_pst")
        end,
    },

    State{
        name = "dizzy_pst",
        tags = {"idle"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("seal_idle_pst")
        end,

        timeline =
        {
            TimeEvent(13*FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_fly")
            end)
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("cower")
            end)
        }
    },

    State{
        name = "cower",
        tags = {"idle", "canrotate"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("seal_cower")
        end,

        timeline = 
        {
            TimeEvent(1*FRAMES, function(inst)
                if not inst.AnimState:IsCurrentAnimation("seal_cower") then
                    inst.AnimState:PlayAnimation("seal_cower", true)
                end
            end),

            TimeEvent(4*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_cower")
            end),
            TimeEvent(27*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_cower")
            end),
            TimeEvent(32*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_cower")
            end),
            TimeEvent(67*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_cower")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("cower") end)
        },

    },

    State{
        name = "hit",
        tags = {"hit", "busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("seal_hit")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_hit")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("cower")
            end)
        },
    },

    State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("seal_death")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_death")
    		inst.components.lootdropper:DropLoot()
--			SpawnPrefab("woodlegs_key1").Transform:SetPosition(inst.Transform:GetWorldPosition())
        end,

     --    events =
     --    {
     --        EventHandler("animover", function(inst)
     --    	end),
    	-- },
    },
}

return StateGraph('twister_seal', states, events, 'cower')