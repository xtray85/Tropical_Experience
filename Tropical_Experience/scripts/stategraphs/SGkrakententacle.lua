require("stategraphs/commonstates")

local events = 
{
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    EventHandler("despawn", function(inst) inst.sg:GoToState("despawn") end),
}

local actionhandlers = {}

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

	        end
--        else
--        	wave:Remove()
--        end
    end
end



local states = 
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_slow")
        end,

        events =
        {
            EventHandler("animover", function(inst) 
                if math.random() < 0.75 then
                    inst.sg:GoToState("waves")
                else
                    inst.sg:GoToState("idle")
                end
            end)
        },
    },

    State{
        name = "waves",
        tags = {"busy"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("shake")
            inst.AnimState:PushAnimation("idle", false)
--			SpawnWavesSW(inst, math.random(1,2), 360, math.random(6,7), nil, nil, 2, true, true)
        end,

        timeline = 
        {
            TimeEvent(5*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/shake") end),
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/shake") end),
            TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/shake") end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "spawn",
        tags = {"busy"},

        onenter = function(inst, playanim)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/tentacle_emerge")
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("enter")
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "despawn",
        tags = {"busy"},

        onenter = function(inst, playanim)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/tentacle_submerge")
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("exit")
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst:Remove() end),
        },
    },

	State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("exit")
            if inst.components.lootdropper then
                inst.components.lootdropper:DropLoot()
            end
        end,
    },

    State{
        name = "hit",
        tags = {"busy", "hit"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/hit")
        end,
        
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
    	name = "attack",
    	tags = {"busy", "attack", "canrotate"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("attack")
            inst.components.combat:StartAttack()
        end,

        timeline =
        {
			TimeEvent(17*FRAMES, function(inst) 
                inst.components.combat:DoAttack() 
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/attack")
            end),
            TimeEvent(20*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
	},
}

return StateGraph("krakententacle", states, events, "idle", actionhandlers)