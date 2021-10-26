require("stategraphs/commonstates")

local events=
{
	CommonHandlers.OnStep(),
	CommonHandlers.OnLocomote(false,true),
	CommonHandlers.OnSleep(),
	CommonHandlers.OnFreeze(),

	EventHandler("doattack", function(inst) if not inst.components.health:IsDead() then inst.sg:GoToState("attack") end end),
	EventHandler("death", function(inst) inst.sg:GoToState("death") end),
	EventHandler("attacked", function(inst) if inst.components.health:GetPercent() > 0 and not inst.sg:HasStateTag("attack") then inst.sg:GoToState("hit") end end),
}

function SpawnWavesSW(inst, numWaves, totalAngle, waveSpeed, wavePrefab, initialOffset, idleTime, instantActive, random_angle)
	wavePrefab = wavePrefab or "rogue_wave"
	totalAngle = math.clamp(totalAngle, 1, 360)

    local pos = inst:GetPosition()
    local startAngle = (random_angle and math.random(-180, 180)) or inst.Transform:GetRotation()
    local anglePerWave = totalAngle/(numWaves - 1)

	if totalAngle == 360 then
		anglePerWave = totalAngle/numWaves
	end

    --[[
    local debug_offset = Vector3(2 * math.cos(startAngle*DEGREES), 0, -2 * math.sin(startAngle*DEGREES)):Normalize()
    inst.components.debugger:SetOrigin("debugy", pos.x, pos.z)
    local debugpos = pos + (debug_offset * 2)
    inst.components.debugger:SetTarget("debugy", debugpos.x, debugpos.z)
    inst.components.debugger:SetColour("debugy", 1, 0, 0, 1)
	--]]

    for i = 0, numWaves - 1 do
        local wave = SpawnPrefab(wavePrefab)

        local angle = (startAngle - (totalAngle/2)) + (i * anglePerWave)
        local rad = initialOffset or (inst.Physics and inst.Physics:GetRadius()) or 0.0
        local total_rad = rad + wave.Physics:GetRadius() + 0.1
        local offset = Vector3(math.cos(angle*DEGREES),0, -math.sin(angle*DEGREES)):Normalize()
        local wavepos = pos + (offset * total_rad)

--        if inst:GetIsOnWater(wavepos:Get()) then
	        wave.Transform:SetPosition(wavepos:Get())

	        local speed = waveSpeed or 6
	        wave.Transform:SetRotation(angle)
	        wave.Physics:SetMotorVel(speed, 0, 0)
	        wave.idle_time = idleTime or 5

	        if instantActive then
	        	wave.sg:GoToState("idle")
	        end

	        if wave.soundtidal then
--	        	wave.SoundEmitter:PlaySound("dontstarve_DLC002/common/rogue_waves/"..wave.soundtidal)
	        end
--        else
--        	wave:Remove()
--        end
    end
end

local states=
{
	State{
		name = "idle",
		tags = {"idle", "canrotate"},

		onenter = function(inst, pushanim)
			inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("idle", true)
			inst.sg:SetTimeout(2 + 2*math.random())
		end,

		events=
		{
			EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle_loop") end),
		},
	},

	State{
		name = "idle_loop",
		tags = {"idle", "canrotate"},

		onenter = function(inst)
			
		end,


		timeline=
		{
			TimeEvent( 0*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.idle) end),
			TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.idle) end),
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle_loop") end),
		},
	},

	State{
		name = "attack",
		tags = {"busy", "attack", "canrotate"},

		onenter = function(inst)
			inst.components.combat:StartAttack()
			inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("atk_pre")
			inst.AnimState:PushAnimation("atk", false)
		end,


		timeline=
		{
			TimeEvent(11*FRAMES, function(inst)
				if inst.components.combat.target then 
					inst:ForceFacePoint(inst.components.combat.target:GetPosition()) 
				end
				inst.SoundEmitter:PlaySound(inst.sounds.mouth_open)
			end),
			TimeEvent(25*FRAMES, function(inst)
				if inst.components.combat.target then 
					inst:ForceFacePoint(inst.components.combat.target:GetPosition()) 
				end
				SpawnWavesSW(inst, 2, 20, nil, nil, nil, nil, true)
				inst.components.combat:DoAttack()
				inst.SoundEmitter:PlaySound(inst.sounds.bite_chomp)
				inst.SoundEmitter:PlaySound(inst.sounds.bite)
			end),
		},

		events=
		{
			EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
		},
	},

	State{
		name = "death",
		tags = {"busy"},

		onenter = function(inst)
			inst.SoundEmitter:PlaySound(inst.sounds.death)
			inst.AnimState:PlayAnimation("death")
			inst.components.locomotor:StopMoving()
	
			
		end,

		events=
		{
			EventHandler("animqueueover", function(inst)
				local carcass = SpawnPrefab(inst.carcass)
				carcass.Transform:SetPosition(inst.Transform:GetWorldPosition())
			end),
		},
	},

	State{
		name = "walk_start",
		tags = {"moving", "canrotate"},

		onenter = function(inst)
			inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("walk_pre")
		end,

		timeline =
		{

			TimeEvent(12*FRAMES, function(inst)	inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/splash_large") end),
			-- TimeEvent(21*FRAMES, function(inst)	inst.components.locomotor:RunForward() end),
		},

		events =
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),
		},
	},

	State{
		name = "walk",
		tags = {"moving", "canrotate"},

		onenter = function(inst)
			inst.components.locomotor:RunForward()
			inst.AnimState:PlayAnimation("walk_loop")
		end,
		timeline =
		{
			TimeEvent(15*FRAMES, function(inst)
				inst.components.locomotor:WalkForward()
				inst.SoundEmitter:PlaySound(inst.sounds.breach_swim)
				inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/white_whale/water_swimbreach_lrg")
			end ),
		},
		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),
		},
	},

	State{
		name = "walk_stop",
		tags = {"canrotate"},

		onenter = function(inst)
			inst.components.locomotor:StopMoving()
		end,

		timeline =
		{
			TimeEvent(15*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound(inst.sounds.breach_swim)
				inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/white_whale/water_swimbreach_lrg")
			end ),
		},

		events=
		{
			EventHandler("animqueueover", function(inst) inst.sg:GoToState("walk_stop_emerge") end ),
		},
	},

	State{
		name = "walk_stop_emerge",
		tags = {"canrotate"},

		onenter = function(inst)
			inst.components.locomotor:StopMoving()
			inst.AnimState:PlayAnimation("walk_pst", false)
		end,

		timeline=
		{
			TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/dogfish/water_emerge_med") end),
			TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/splash_large") end),
		},

		events=
		{
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
		},
	},
}

CommonStates.AddSimpleState(states,"hit", "hit")

CommonStates.AddSleepStates(states,
{
	sleeptimeline =
	{
		TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.sleep) end)
	},
})
CommonStates.AddFrozenStates(states)

return StateGraph("whale", states, events, "idle")
