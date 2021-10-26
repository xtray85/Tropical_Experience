require("stategraphs/commonstates")

local actionhandlers =
{
}

local events =
{
}

local states =
{
    State
    {
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst, playanim)
            inst:Show()
            inst.AnimState:PlayAnimation("idle", true)
        end,
    },

    State
    {
        name = "hidden",
        tags = {"idle", "canrotate"},

        onenter = function(inst, playanim)
            inst:Hide()
        end,
    },

    State
    {
        name = "extend",
        tags = {"canrotate"},

        onenter = function(inst)
            inst:Show()
            inst.AnimState:PlayAnimation("place", false)

--            local intensity = math.min(GetWorld()[inst.pipesound],10) / 10

            inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/crafted/sprinkler/pipe_on","pipesound_on")
--            inst.SoundEmitter:SetParameter("pipesound_on", "intensity", intensity) 
--            GetWorld()[inst.pipesound] =  GetWorld()[inst.pipesound] +1
        end,

        events =
        {
            EventHandler("animover",
                function(inst)
                    if inst.nextPipe then
                        inst.nextPipe.sg:GoToState("extend")
                    end

                    inst.sg:GoToState("idle")
                end),
        }
    },

	State
	{
		name = "retract",
		tags = {"canrotate"},

		onenter = function(inst)
			inst.AnimState:PlayAnimation("retract", false)
--            local intensity = math.min(TheWorld[inst.pipesound],10) / 10
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/crafted/sprinkler/pipe_off","pipesound_off")
--            inst.SoundEmitter:SetParameter("pipesound_off", "intensity", intensity) 
--            GetWorld()[inst.pipesound] =  GetWorld()[inst.pipesound] +1
		end,

        events =
        {
            EventHandler("animover",
                function(inst)
                    if inst.prevPipe then
                        inst.prevPipe.sg:GoToState("retract")
                    end

                    inst:Remove()
                end),
        }
	},
}

return StateGraph("water_pipe", states, events, "hidden", actionhandlers)
