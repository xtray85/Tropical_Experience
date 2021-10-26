
local assets =
{
	Asset("ANIM", "anim/dragoon_egg.zip"),
	Asset("ANIM", "anim/meteorshadow.zip"),
}

local	 	VOLCANO_FIRERAIN_WARNING = 2
local	 	VOLCANO_FIRERAIN_RADIUS = 20
local	 	VOLCANO_FIRERAIN_DAMAGE = 300
local	 	VOLCANO_FIRERAIN_LAVA_CHANCE = 0.5
local	 	VOLCANO_DRAGOONEGG_CHANCE = 0.25

local prefabs =
{
	"lavapool",
    "groundpound_fx",
    "groundpoundring_fx",
    "firerainshadow",
    "meteor_impact"
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
	        	wave.SoundEmitter:PlaySound("dontstarve_DLC002/common/rogue_waves/"..wave.soundtidal)
	        end
--        else
--        	wave:Remove()
--        end
    end
end

local function DoStep(inst)
local x, y, z = inst.Transform:GetLocalPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x, y, z))
			
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

if math.random() < VOLCANO_FIRERAIN_LAVA_CHANCE and not plataforma then
local lavapool = SpawnPrefab("lavapool")
lavapool.Transform:SetPosition(x, y, z)
if (ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS) then	lavapool:Remove() 
local lavapool = SpawnPrefab("bombsplash")
lavapool.Transform:SetPosition(x, y, z)
inst.SoundEmitter:PlaySound("dontstarve_DLC002/quacken/splash_large")
SpawnWavesSW(inst, 8, 360, 6)
end
				
				
				
else

if (ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS) and not plataforma then
local lavapool = SpawnPrefab("bombsplash")
lavapool.Transform:SetPosition(x, y, z)
inst.SoundEmitter:PlaySound("dontstarve_DLC002/quacken/splash_large")
SpawnWavesSW(inst, 8, 360, 6)
else
if not plataforma then
local impact = SpawnPrefab("meteor_impact")
impact.components.timer:StartTimer("remove", TUNING.TOTAL_DAY_TIME * 2)
impact.Transform:SetPosition(x, y, z)
end
end

				
end

inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/volcano/volcano_rock_smash")
inst.components.groundpounder.numRings = 2
inst.components.groundpounder.burner = true
inst.components.groundpounder:GroundPound()
ShakeAllCameras(CAMERASHAKE.FULL, .35, .02, 1.25, inst, 40)	
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
	local shadow = SpawnPrefab("firerainshadow")
	shadow.Transform:SetPosition(inst:GetPosition():Get())
	shadow.Transform:SetRotation(math.random(0, 360))--(GetRotation(inst))
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/bomb_fall")
	inst:Hide()
	inst:DoTaskInTime(VOLCANO_FIRERAIN_WARNING - (5*FRAMES), function(inst) inst:DoStep() end)
	inst:DoTaskInTime(VOLCANO_FIRERAIN_WARNING - (14*FRAMES), function(inst)
		inst:Show()
		inst.AnimState:PlayAnimation("idle")
		inst:ListenForEvent("animover", function(inst) inst:Remove() end)
	end)
end

local function firerainfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	trans:SetFourFaced()

	anim:SetBank("meteor")
	anim:SetBuild("draegg")
	anim:PlayAnimation("idle")

	inst:AddTag("FX")
	
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

local easing = require("easing")
local function LerpIn(inst)

inst:DoTaskInTime(64*FRAMES, function(inst) inst:Remove() end)

	local s = easing.inExpo(inst:GetTimeAlive(), 1, 1 - inst.StartingScale, inst.TimeToImpact)

	inst.Transform:SetScale(s,s,s)
	if s >= inst.StartingScale then
		inst.sizeTask:Cancel()
		inst.sizeTask = nil
	end
end

local function OnRemove(inst)
	
if inst.sizeTask then
		inst.sizeTask:Cancel()
		inst.sizeTask = nil
	end
end

local function Impact(inst)
	inst:Remove()
end

local function shadowfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

	anim:SetBank("meteor_shadow")
	anim:SetBuild("meteorshadow1")
	anim:PlayAnimation("idle")
	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
	anim:SetLayer( LAYER_BACKGROUND )
	anim:SetSortOrder( 3 )
	inst.entity:AddNetwork()

	inst:AddTag("FX")

	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.persists = false
	
	local s = 2
	inst.StartingScale = s
	inst.Transform:SetScale(s,s,s)
	inst.TimeToImpact = VOLCANO_FIRERAIN_WARNING

--	inst:AddComponent("colourtweener")
--	inst.AnimState:SetMultColour(0,0,0,0)
--	inst.components.colourtweener:StartTween({0,0,0,1}, inst.TimeToImpact, Impact)

	inst.OnRemoveEntity = OnRemove

	inst.sizeTask = inst:DoPeriodicTask(FRAMES, LerpIn)

	return inst
end

return Prefab("common/shipwrecked/firerain", firerainfn, assets, prefabs),
		Prefab("common/shipwrecked/firerainshadow", shadowfn, assets, prefabs)
