require("stategraphs/commonstates")

local function onattack(inst, data)
    if inst.components.health:GetPercent() > 0 and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then
        local dist = inst:GetDistanceSqToInst(data.target)
        if dist > 25 then
            inst.sg:GoToState("throw", data.target)
        end
    end
end

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

local events = 
{
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    EventHandler("doattack", onattack),
    EventHandler("move", function(inst, data)
        if not inst.sg:HasStateTag("move") then
            inst.sg:GoToState("move", data.pos)
        end
    end),
}

local actionhandlers = {}

local states = 
{
    State{
        name = "throw",
        tags = {"attack", "busy"},

        onenter = function(inst)
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("spit")
        end,

        timeline=
        {

            TimeEvent(13*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/spit_puke")
            end),                
            TimeEvent(56*FRAMES, function(inst) 
                inst.components.combat:DoAttack() 
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/spit")
            end),
            TimeEvent(57*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
            TimeEvent(5*FRAMES, function(inst) inst.components.minionspawner2:SpawnAll() end),			
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("taunt") end),
        },
    },

    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle_loop", true)
        end,
    },

    State{
        name = "hit",
        tags = {"busy", "hit"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/hit")
        end,
        
        events=
        {
            EventHandler("animover", 
			function(inst) inst.sg:GoToState("newattack") 
			end),
        },
    },

    State{
        name = "move",
        tags = {"busy", "move"},

        onenter = function(inst, pos)
            inst.components.health:SetInvincible(true)
            inst.AnimState:PlayAnimation("taunt")
            inst.AnimState:PushAnimation("exit", false)
            inst.sg.statemem.pos = pos
            inst.components.minionspawner2:DespawnAll()
            inst.components.minionspawner2.minionpositions = nil
            inst.sg:SetTimeout(4)
        end,

        timeline =
        {
            TimeEvent(20*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/taunt")
            end),
            
            TimeEvent(62*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/exit")
            end),

            TimeEvent(83*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken_submerge")
                inst.SoundEmitter:KillSound("quacken_lp_1")
                inst.SoundEmitter:KillSound("quacken_lp_2")
            end),
        },

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
            inst.Transform:SetPosition(inst.sg.statemem.pos:Get())
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("spawn")
        end,
    },
	
    State{
        name = "newattack",
        tags = {"busy", "move"},

        onenter = function(inst, pos)
            inst.components.health:SetInvincible(true)
--            inst.AnimState:PlayAnimation("taunt")
            inst.AnimState:PlayAnimation("exit", false)
            inst.sg.statemem.pos = pos
            inst.sg:SetTimeout(4)
        end,

        timeline =
        {
            TimeEvent(20*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/taunt")
            end),
            
            TimeEvent(62*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/exit")
            end),

            TimeEvent(83*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken_submerge")
                inst.SoundEmitter:KillSound("quacken_lp_1")
                inst.SoundEmitter:KillSound("quacken_lp_2")
            end),
        },

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("newattackfinish")
        end,
    },
	
    State{
        name = "newattackfinish",
        tags = {"busy"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/enter")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/quacken_emerge")
            
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/head_drone_rnd_LP", "quacken_lp_1")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/head_drone_LP", "quacken_lp_2")

            inst.AnimState:PlayAnimation("enter")
        end,

        timeline =
        {
            TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/enter") end),
            TimeEvent(70*FRAMES, function(inst) SpawnWavesSW(inst, 9, 360, 5, nil, nil, 3, true, true) end),
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end)
        },
    },	

    State{
        name = "spawn",
        tags = {"busy"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/enter")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/quacken_emerge")
            
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/head_drone_rnd_LP", "quacken_lp_1")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/head_drone_LP", "quacken_lp_2")

            inst.AnimState:PlayAnimation("enter")
        end,

        timeline =
        {
            TimeEvent(5*FRAMES, function(inst) inst.components.minionspawner2:SpawnAll() end),
            TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/enter") end)
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end)
        },
    },



    State{
        name = "death",  
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("death")
            inst.components.minionspawner2:DespawnAll()
            inst.components.minionspawner2.minionpositions = nil
        end,

        timeline =
        {
            TimeEvent(2*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/death")
            end),

            TimeEvent(38*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/quacken_submerge")
                inst.SoundEmitter:KillSound("quacken_lp_1")
                inst.SoundEmitter:KillSound("quacken_lp_2")
            end),

            TimeEvent(90*FRAMES, function(inst)
                inst.components.lootdropper:DropLoot()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst) inst:Remove() end),
        },
    },

    State{
        name = "taunt",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("taunt")
        end,
        
        timeline = 
        {
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/taunt") end)
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
}

return StateGraph("kraken", states, events, "idle", actionhandlers)