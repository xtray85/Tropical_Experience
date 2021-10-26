require("stategraphs/commonstates")

local actionhandlers=
{

}

local events=
{

}

local states=
{
	State{
		name = "idle",
		tags = {"idle"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("idle_dormant", true)
		end,

	},

	State{
		name = "active_pre",
		tags = {"active_pre"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("active_pre")
		end,
		events=
		{
			EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("active_loop")
			end),
		},
		
		timeline =
		{
			TimeEvent(20 * FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/flamegeyser_open")
			end),
		},		
		
		
		
		
	},

	State{
		name = "active_loop",
		tags = {"active_loop"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("active_loop")	
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/flamegeyser_lp","loop")			
		end,

		events=
		{
			EventHandler("animqueueover", function(inst)
				inst.SoundEmitter:KillSound("loop")				
				inst.sg:GoToState("active_loop")
			end),
		},
		
--		timeline =
--		{
--			TimeEvent(20 * FRAMES, function(inst)
--			inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/flamegeyser_open", "open")
--			end),
--		},
	},
	
	
	State{
		name = "flamegeyser_out_pre",
		tags = {"active_loop"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("active_loop")	
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/flamegeyser_lp","loop")			
		end,

		events=
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("flamegeyser_out")
			end),
		},
		
		timeline =
		{
			TimeEvent(10 * FRAMES, function(inst) inst.Light:SetRadius(3.5)	end),
			TimeEvent(20 * FRAMES, function(inst) inst.Light:SetRadius(3.0)	end),
			TimeEvent(30 * FRAMES, function(inst) inst.Light:SetRadius(2.5)	end),
			TimeEvent(40 * FRAMES, function(inst) inst.Light:SetRadius(2.0)	end),
			TimeEvent(50 * FRAMES, function(inst) inst.Light:SetRadius(1.5)	end),
			TimeEvent(60 * FRAMES, function(inst) inst.Light:SetRadius(1.0)	end),
			TimeEvent(70 * FRAMES, function(inst) inst.Light:Enable(false)	end),			
		},
	},	
		
	State{
		name = "flamegeyser_out",
		tags = {"flamegeyser_out"},
		onenter = function(inst)
			inst.AnimState:PlayAnimation("active_pst")	
		end,

		events=
		{
			EventHandler("animover", function(inst)
				inst.sg:GoToState("idle")
			end),
		},
		
		timeline =
		{
			TimeEvent(10 * FRAMES, function(inst)
		inst.SoundEmitter:KillSound("loop")
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/flamegeyser_out")
			end),
		},
	},
}

return StateGraph("SGflamegeyser", states, events, "idle", actionhandlers)

