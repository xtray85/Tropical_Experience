local JUMP_SPEED = 50
local JUMP_LAND_OFFSET = 3
local TIGERSHARK_SPLASH_RADIUS = 5

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

local function onattackfn(inst)
    if inst.components.health and not inst.components.health:IsDead()
    and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then


local variador = math.random (1,4)	
if variador == 2 then inst.sg:GoToState("taunt") else

	
        if inst.sg:HasStateTag("running") then
            inst.sg:GoToState("attack")
        else
            inst.sg:GoToState("attack_pre")
        end
    end end
end


local function onattackedfn(inst)
    if not inst.components.health:IsDead() and not
    inst.sg:HasStateTag("attack") and not
    inst.sg:HasStateTag("specialattack") then
        inst.sg:GoToState("hit")
    end
end

local actionhandlers =
{
    ActionHandler(ACTIONS.EAT, "eat"),
}

local events =
{
    CommonHandlers.OnLocomote(true, true),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnFreeze(),
    EventHandler("doattack", onattackfn),
    EventHandler("attacked", onattackedfn),
	EventHandler("gotosleep", function(inst) inst.sg:GoToState("sleeping") end),
}

local function GetIsOnWater(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then return true
else return false end
end

local states =
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("water_idle")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end)
        },
    },

    State{
        name = "eat",
        tags = {"busy", "canrotate"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.components.rowboatwakespawner:StopSpawning()
            inst.AnimState:PlayAnimation("water_eat_pre")
            inst.AnimState:PushAnimation("water_eat_pst", false)
        end,

        timeline =
        {

            TimeEvent(0*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg")
            end),

            TimeEvent(14*FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/eat")
            end),

            TimeEvent(31*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_submerge_lrg")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("idle")
            end)
        },
    },

    -- dive > jumpwarn > jump > fallwarn > fall > fallpost

    State{
        name = "dive",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
            inst.AnimState:PlayAnimation("submerge")
            inst.Physics:Stop()
            inst.components.health:SetInvincible(true)
        end,

        events =
        {
            EventHandler("animover", function(inst) inst:Hide() end),
        },

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_submerge_lrg") end),
            TimeEvent(30*FRAMES, function(inst) inst.sg:GoToState("jumpwarn") end),
        },
    },

    State{
        name = "jumpwarn",
        tags = {"busy", "specialattack"},

        onenter = function(inst)

local alvo = inst.components.combat.target
if alvo and alvo:HasTag("player") and not alvo:HasTag("aquatic") then	
--    inst:ClearStateGraph()
--    inst:SetStateGraph("SGtigershark_ground")
--    inst.AnimState:SetBuild("tigershark_ground_build")
--    inst:RemoveTag("aquatic")
--    inst.DynamicShadow:Enable(true)		
--	return inst.sg:GoToState("jump2")
return	inst.sg:GoToState("jump")
end	
		
--            local tar = inst:GetTarget()		
--            if tar then
--                inst.Transform:SetPosition(tar:Get())
--            end		
		
		
		
		
		
            inst.Physics:Stop()

--    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
--    inst.Physics:ClearCollisionMask()
--    inst.Physics:CollidesWith(COLLISION.WORLD)


            local old_pt = inst:GetPosition()

--            local tar = inst:GetTarget()
--            if tar then
--                inst.Transform:SetPosition(tar:Get())
--            end

            local shadow = SpawnPrefab("tigersharkshadow")
            shadow:Water_Jump()
            shadow.Transform:SetPosition(inst:GetPosition():Get())
        end,

        onexit = function(inst)
            inst:Show()
        end,

        timeline=
        {
            TimeEvent(90*FRAMES, function(inst) 
                inst.sg:GoToState("jump") 
            end),
        },
    },

    State{
        name = "jump3",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.components.locomotor.disable = true

            local splash = SpawnPrefab("splash_water")
            local pos = inst:GetPosition()
            splash.Transform:SetPosition(pos.x, pos.y, pos.z)
            
            inst:Show()

            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/jump_attack")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/roar")

            inst.AnimState:PlayAnimation("launch_up_pre")
            inst.AnimState:PushAnimation("launch_up_loop", true)
            inst.components.combat:DoAreaAttack(inst, TIGERSHARK_SPLASH_RADIUS)

			SpawnWavesSW(inst, 9, 360, 12, nil, nil, 3, true, true)
        end,

        timeline =
        {
            TimeEvent(3*FRAMES, function(inst)
                inst.Physics:SetMotorVelOverride(0,JUMP_SPEED,0)
            end),

            TimeEvent(15*FRAMES, function(inst)
                local tar = inst:GetTarget()

                if tar then
				
				
    inst:ClearStateGraph()
    inst:SetStateGraph("SGtigershark_ground")
    inst.AnimState:SetBuild("tigershark_ground_build")
    inst:RemoveTag("aquatic")
    inst.DynamicShadow:Enable(true)
                end

                inst.sg:GoToState("fallwarn")
            end)
        },
    },

	
    State{
        name = "jump",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.Physics:Stop()
            local splash = SpawnPrefab("splash_water")
            local pos = inst:GetPosition()
            splash.Transform:SetPosition(pos.x, pos.y, pos.z)
            
            inst:Show()

            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/jump_attack")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/roar")

            inst.AnimState:PlayAnimation("launch_up_pre")
            inst.components.combat:DoAreaAttack(inst, TIGERSHARK_SPLASH_RADIUS)
			SpawnWavesSW(inst, 9, 360, 12, nil, nil, 3, true, true)
        end,
		
		        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("jump2")
            end)
        },
		
    },

    State{
        name = "jump2",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
		    inst.AnimState:PushAnimation("launch_up_loop", true)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/jump_attack")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/roar")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/launch_land")
            inst.Physics:Stop()
            inst.Physics:SetMotorVelOverride(0,JUMP_SPEED,0)
        end,

        onupdate = function(inst)
            inst.Physics:SetMotorVelOverride(0,JUMP_SPEED,0)
            local pt = Point(inst.Transform:GetWorldPosition())
            if pt.y > 35 then
--                if goingBack(inst) then
--                    local pos = inst:GetPosition()
--                    pos.y = 0
--                    inst.Transform:SetPosition(pos:Get())
--
--                    inst.sg:GoToState("despawn")
--                else
                    inst.sg:GoToState("fallwarn")
--                end
            end
        end,
    },	
	
	
	
	
    State{
        name = "fallwarn",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.Physics:Stop()
			
			local alvo = inst.components.combat.target
			if alvo then
			local x, y, z = alvo.Transform:GetWorldPosition()
            inst.Transform:SetPosition(x, 45, z)
			end			
			
            local shadow = SpawnPrefab("tigersharkshadow")
            shadow:Water_Fall()
            local heading = TheCamera:GetHeading()
            local rotation = 180 - heading
            if inst.AnimState:GetCurrentFacing() == FACING_LEFT then
                rotation = rotation + 180
            end
            if rotation < 0 then
                rotation = rotation + 360
            end
            shadow.Transform:SetRotation(rotation)
            local x,y,z = inst:GetPosition():Get()
            shadow.Transform:SetPosition(x,0,z)

            inst.sg:SetTimeout(25*FRAMES)
        end,

        ontimeout = function(inst)
            inst:Show()
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then
	
    inst:ClearStateGraph()
    inst:SetStateGraph("SGtigershark_ground")
    inst.AnimState:SetBuild("tigershark_ground_build")
    inst:RemoveTag("aquatic")
    inst.DynamicShadow:Enable(true)			
			
                local pos = inst:GetPosition()
                pos.y = 45
                inst.Transform:SetPosition(pos:Get())
            end

            inst.sg:GoToState("fall")
        end,
    },

    State{
        name = "fall",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.components.locomotor.disable = true
            inst.Physics:SetMotorVel(0,-JUMP_SPEED,0)
            inst.AnimState:PlayAnimation("launch_down_loop", true)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/breach_attack")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/dive_attack")
            inst.sg:SetTimeout(JUMP_SPEED/45 + 0.2)
        end,

        timeline =
        {
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/roar") end)
        },

        ontimeout = function(inst)
            local pt = Point(inst.Transform:GetWorldPosition())
            pt.y = 0
            inst.Physics:Stop()
            inst.Physics:Teleport(pt.x,pt.y,pt.z)
            inst.CanFly = false
            inst.Physics:SetCollides(true)
            inst.sg:GoToState("fallpost")
        end,

        onupdate= function(inst)
            inst.Physics:SetMotorVel(0,-JUMP_SPEED,0)
            local pt = Point(inst.Transform:GetWorldPosition())
            if pt.y <= 1 then
                pt.y = 0
                inst.Physics:Stop()
                inst.Physics:Teleport(pt.x,pt.y,pt.z)
                inst.CanFly = false
                inst.Physics:SetCollides(true)
                inst.sg:GoToState("fallpost")
            end
        end,
    },

    State{
        name = "fallpost",
        tags = {"busy", "specialattack"},

        onenter = function(inst)

            --print("Enter fall post (water)", GetTime())

            inst.Physics:Stop()
            inst.components.locomotor.disable = false
            inst.AnimState:PlayAnimation("launch_down_pst")
            inst.components.combat:DoAreaAttack(inst, TIGERSHARK_SPLASH_RADIUS)
            SpawnWavesSW(inst, 9, 360, 12, nil, nil, 3, true, true)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/splash_large")
--            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/splash_explode")
        end,

         onexit = function(inst)
           -- print("Exit fall post (water)", GetTime())

            local splash = SpawnPrefab("splash_water")
            local pos = inst:GetPosition()
            splash.Transform:SetPosition(pos.x, pos.y, pos.z)
            inst.components.health:SetInvincible(false)
            inst:Show()
            ChangeToCharacterPhysics(inst)
        end,

        events=
        {
            EventHandler("animover", function(inst) inst:Hide() end),
        },

        timeline=
        {
            TimeEvent(60*FRAMES, function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "attack_pre",
        tags = {"attack", "busy", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.CanRun = false

            inst.components.rowboatwakespawner:StopSpawning()
            inst.AnimState:PlayAnimation("water_atk_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("attack") end),
        },
    },

    State{
        name = "attack",
        tags = {"busy", "attack"},

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("water_atk")
            inst.AnimState:PushAnimation("water_atk_pst", false)
            inst.CanRun = false
            inst.components.rowboatwakespawner:StopSpawning()
            if not inst.components.timer:TimerExists("Run") then
                inst.components.timer:StartTimer("Run", 10)
            end
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/roar")
        end,

        timeline =
        {
            TimeEvent(15*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_attack")
                inst.components.combat:DoAttack()
                SpawnWavesSW(inst, 5, 110, 12, nil, nil, 3, true, true)
            end),

            TimeEvent(27*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/dogfish/water_submerge_med")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.AttackCounter = inst.AttackCounter + 1
                if inst.AttackCounter >= 2 then
                    inst.AttackCounter = 0
                    inst.CanFly = true
                    inst.sg:GoToState("dive")
                else
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "hit",
        tags = {"busy", "hit"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("water_hit")
            inst.components.rowboatwakespawner:StopSpawning()
        end,

        timeline =
        {
            TimeEvent(1*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/hit")
            end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("water_death")
            inst.components.rowboatwakespawner:StopSpawning()
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
        end,

        timeline =
        {
            TimeEvent(1*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg")
            end),
            TimeEvent(11*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/death_sea")
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seacreature_movement/splash_large")
            end),
        },

    },

    State{
        name = "taunt",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("water_taunt")
            inst.components.rowboatwakespawner:StopSpawning()
        end,

        timeline =
        {
            TimeEvent(6*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg")
            end),
            TimeEvent(0*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/taunt_sea")
            end),
            TimeEvent(33*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/taunt_sea")
            end),
            TimeEvent(60*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_submerge_lrg")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end)
        },
    },

    State{
        name = "walk_start",
        tags = {"moving", "canrotate"},

        onenter = function(inst) 
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("water_run")
        end,

        events =
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
        },

        timeline =
        {
            TimeEvent(0, function(inst)
                inst.components.rowboatwakespawner:StopSpawning()
                local target = inst:GetTarget()
--                if target then
--                    inst.sg:GoToState("dive")
--                end
            end),
            TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/run_down") end),
        },
    },
        
    State{
            
        name = "walk",
        tags = {"moving", "canrotate"},
        
        onenter = function(inst) 
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("water_run")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/dogfish/water_swimemerged_med_LP", "walk_loop")
        end,

        onexit = function(inst)
            inst.SoundEmitter:KillSound("walk_loop")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end),
        },

        timeline = 
        {
            TimeEvent(0, function(inst)
                local target = inst:GetTarget()
--                if target then
--                    inst.sg:GoToState("dive")
--                end
            end),
        },
    },      
    
    State{
        name = "walk_stop",
        tags = {"canrotate"},
        
        onenter = function(inst) 
            inst.components.locomotor:StopMoving()
            inst.sg:GoToState("idle")
        end,

        timeline =
        {
            TimeEvent(0, function(inst)
                inst.components.rowboatwakespawner:StopSpawning()
                local target = inst:GetTarget()
--                if target then
--                    inst.sg:GoToState("dive")
--                end
            end),
        },
    },

	
    State{
        name = "sleeping",
        tags = {"sleeping", "busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
			inst.AnimState:PlayAnimation("water_sleep_pre")
			inst.AnimState:PushAnimation("water_sleep_loop", true)
			inst.components.health:StartRegen(1, 3)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/transform_VO")
        end,
        events=
        {
		    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() then 
			inst.components.health:StopRegen()
			inst.sg:GoToState("wake") 
			end end),
        },
        
        timeline=
        {
		TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg") end),
		TimeEvent(1*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/sleep") end),
        },
        
    },	
	
		State{
        name = "wake",
        tags = {"waking", "busy"},
        
        onenter = function(inst, start_anim)
            inst.Physics:Stop()
			inst.AnimState:PushAnimation("water_sleep_pst")
			inst.components.health:StopRegen()
        end,
        
        events=
        {
            EventHandler("animover", function(inst)
			inst.sg:GoToState("idle") 
			end),
        },

        timeline=
        {
            TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg") end),
        },
        
    },		
}

CommonStates.AddFrozenStates(states, nil, {frozen = "water_frozen", frozen_pst = "water_frozen_loop_pst"})
--CommonStates.AddSleepStates(states,
--{
--    starttimeline = {TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_emerge_lrg") end)},
--    sleeptimeline = {TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/sleep") end)},
--    waketimeline = {TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/water_submerge_lrg") end)},
--}, nil, {sleep_pre = "water_sleep_pre", sleep_loop = "water_sleep_loop", sleep_pst = "water_sleep_pst"})

CommonStates.AddRunStates(states,
{
    starttimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
            local target = inst:GetTarget()
--            if target then
--                inst.sg:GoToState("dive")
--            end
        end),
        TimeEvent(0, function(inst) SpawnWavesSW(inst, 2, 160, 12, nil, nil, 3, true, true) end),
        TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/run_down") end),
    },
    runtimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
            local target = inst:GetTarget()
            if target and inst.CanFly then
                inst.sg:GoToState("dive")
            end
        end),
        TimeEvent(0, function(inst) SpawnWavesSW(inst, 2, 160, 12, nil, nil, 3, true, true) end),
        TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/run_down") end),
    },
    endtimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
            local target = inst:GetTarget()
--            if target then
--                inst.sg:GoToState("dive")
--            end
        end),
    },
},
{
    startrun = "water_charge_pre",
    run = "water_charge",
    stoprun = "water_charge_pst",
})

return StateGraph("tigershark_water", states, events, "idle", actionhandlers)