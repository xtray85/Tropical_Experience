assets=
{
	Asset("ANIM", "anim/dragoon_egg.zip"),
}

local ROCKS_MINE = 6
local DRAGOONEGG_HATCH_TIMER = 120
local VOLCANO_FIRERAIN_WARNING = 2
local VOLCANO_FIRERAIN_DAMAGE = 300


local prefabs = 
{
	"dragoon",
	"rocks",
	"groundpound_fx",
	"groundpoundring_fx",
	"firerainshadow",
}

local loot = 
{
	"flint",
	--"obsidian",
	--"obsidian",
	"rocks",
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


local function DropLoot(inst)
	print("dragoonegg - DropLoot")
	
	if inst.components.hatchable.toohot then
		
	else
		inst.components.lootdropper:SetLoot(loot_cold)
	end
end

local function cracksound(inst, loudness) --is this worth a stategraph?
	inst:DoTaskInTime(11*FRAMES, function(inst)
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/dragoon/meteor_shake")
	end)
	inst:DoTaskInTime(24*FRAMES, function(inst)
		inst.SoundEmitter:PlaySoundWithParams("dontstarve_DLC002/creatures/dragoon/meteor_land", {loudness=loudness})
	end)
end

local function cracksmall(inst)
	inst.AnimState:PlayAnimation("crack_small")
	inst.AnimState:PushAnimation("crack_small_idle", true)
	cracksound(inst, 0.2)
end

local function crackmed(inst)
	inst.AnimState:PlayAnimation("crack_med")
	inst.AnimState:PushAnimation("crack_med_idle", true)
	cracksound(inst, 0.5)
end

local function crackbig(inst)
	inst.AnimState:PlayAnimation("crack_big")
	inst.AnimState:PushAnimation("crack_big_idle", true)
	cracksound(inst, 0.7)
end

local function hatch(inst)
	inst.AnimState:PlayAnimation("egg_hatch")
	
	-- inst:ListenForEvent("animover", function(inst) 
	inst:DoTaskInTime(42*FRAMES, function(inst)
		local dragoon = SpawnPrefab("dragoon")
		dragoon.Transform:SetPosition(inst:GetPosition():Get())
--		dragoon.components.combat:SuggestTarget(ThePlayer)
		dragoon.sg:GoToState("taunt")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
		inst.components.lootdropper:DropLoot()
		inst:Remove()
	end)
end

local function groundfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.AnimState:SetBuild("draegg")
	inst.AnimState:SetBank("meteor")
	inst.AnimState:PlayAnimation("egg_idle")

	MakeObstaclePhysics(inst, 1.)
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot(loot)

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(ROCKS_MINE*2)
	
	inst.components.workable:SetOnFinishCallback(
		function(inst, worker)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
			inst.components.lootdropper:DropLoot()
			inst:Remove()
		end)

	inst:DoTaskInTime(0.25 * DRAGOONEGG_HATCH_TIMER, cracksmall)
	inst:DoTaskInTime(0.5 * DRAGOONEGG_HATCH_TIMER, crackmed)
	inst:DoTaskInTime(0.75 * DRAGOONEGG_HATCH_TIMER, crackbig)
	inst:DoTaskInTime(DRAGOONEGG_HATCH_TIMER, hatch)
	
	
	return inst
end

-------


local function DoStep(inst)
--	local player = ThePlayer
--	local distToPlayer = inst:GetPosition():Dist(player:GetPosition())
--	local power = Lerp(3, 1, distToPlayer/180)


		inst.components.groundpounder.numRings = 2
		inst.components.groundpounder.burner = true
		inst.components.groundpounder.onfinished = function(inst)
			if inst:IsPosSurroundedByLand(x, y, z, 2) then
				local lava = SpawnPrefab("dragoonegg")
				lava.AnimState:PlayAnimation("egg_crash")
				lava.AnimState:PushAnimation("egg_idle", false)
				lava.Transform:SetPosition(x, y, z)
			end
			inst:Remove()
		end
		inst.components.groundpounder:GroundPound()
	

--	ShakeAllCameras(CAMERASHAKE.FULL, .35, .02, 1.25, inst, 40)	
end

local function roundToNearest(numToRound, multiple)
	local half = multiple/2
	return numToRound+half - (numToRound+half) % multiple
end

local function SimulateStep(inst)
	inst:DoTaskInTime(VOLCANO_FIRERAIN_WARNING, function(inst) 
		inst:DoStep()
		inst:Remove()
	end)
end

local function StartStep(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetLocalPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
local shadow = SpawnPrefab("firerainshadow")
	shadow.Transform:SetPosition(inst:GetPosition():Get())
	shadow.Transform:SetRotation(math.random(0, 360))--(GetRotation(inst))
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/bomb_fall")
	inst:DoTaskInTime(VOLCANO_FIRERAIN_WARNING - (7*FRAMES), DoStep)
	inst:DoTaskInTime(VOLCANO_FIRERAIN_WARNING - (17*FRAMES), function(inst)
		inst:Show()

		local pt = inst:GetPosition()

			inst.AnimState:PlayAnimation("egg_crash_pre")
			inst.AnimState:PushAnimation("egg_crash")
			inst.AnimState:PushAnimation("egg_idle", false)
			
inst:DoTaskInTime(16*FRAMES, function(inst)

local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
local plataforma = false
local pos_x, pos_y, pos_z = inst.Transform:GetWorldPosition()
local entities = TheSim:FindEntities(x, 0, z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS, WALKABLE_PLATFORM_TAGS)
for i, v in ipairs(entities) do
local walkable_platform = v.components.walkableplatform 
if walkable_platform and walkable_platform.radius == nil then walkable_platform.radius = 4 end            
if walkable_platform ~= nil then  
local platform_x, platform_y, platform_z = v.Transform:GetWorldPosition()
local distance_sq = VecUtil_LengthSq(x - platform_x, z - platform_z)
if distance_sq <= walkable_platform.radius * walkable_platform.radius then plataforma = true end
end
end	




	
if not  plataforma and (ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS) then	
SpawnWavesSW(inst, 8, 360, 6)
local lavapool = SpawnPrefab("bombsplash")
lavapool.Transform:SetPosition(x, y, z)
--inst.SoundEmitter:PlaySound("dontstarve_DLC002/quacken/splash_large")
else	
SpawnPrefab("dragoonegg").Transform:SetPosition(inst.Transform:GetWorldPosition()) 
end
inst:Remove()
			end)


	
	end)
end

local function fallingfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()

	trans:SetFourFaced()

	anim:SetBank("meteor")
	anim:SetBuild("draegg")
	inst.entity:AddNetwork()
	inst:AddTag("FX")

		inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("groundpounder")
	inst.components.groundpounder.numRings = 2
	inst.components.groundpounder.ringDelay = 0.1
	inst.components.groundpounder.initialRadius = 1
	inst.components.groundpounder.radiusStepDistance = 2
	inst.components.groundpounder.pointDensity = .25
	inst.components.groundpounder.damageRings = 1
	inst.components.groundpounder.destructionRings = 1
	inst.components.groundpounder.destroyer = true
	inst.components.groundpounder.burner = true
	inst.components.groundpounder.ring_fx_scale = 0.75

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(VOLCANO_FIRERAIN_DAMAGE)

	inst.DoStep = DoStep
	inst.StartStep = StartStep

	inst:Hide()

	return inst
end


return Prefab( "dragoonegg", groundfn, assets, prefabs),
	   Prefab( "dragoonegg_falling", fallingfn, assets, prefabs)
