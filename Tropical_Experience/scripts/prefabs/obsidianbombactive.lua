local assets=
{
--	Asset("ANIM", "anim/obsidbombactive.zip"),
	Asset("ANIM", "anim/coconade_obsidian.zip"),
}

local prefabs =
{
    "explode_small",
}

local function ondropped(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

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

if ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then

if not plataforma then inst.AnimState:PlayAnimation("idle_water", true) else inst.AnimState:PlayAnimation("idle", true) end

else

inst.AnimState:PlayAnimation("idle", true)
end
end

local FADE_FRAMES = 5
local FADE_INTENSITY = .8
local FADE_RADIUS = 1.5
local FADE_FALLOFF = .5

function SpawnWavesSW(inst, numWaves, totalAngle, waveSpeed, wavePrefab, initialOffset, idleTime, instantActive, random_angle)
	wavePrefab = wavePrefab or "rogue_wave"
	totalAngle = math.clamp(totalAngle, 1, 360)

    local pos = inst:GetPosition()
    local startAngle = (random_angle and math.random(-180, 180)) or inst.Transform:GetRotation()
    local anglePerWave = totalAngle/(numWaves - 1)

	if totalAngle == 360 then
		anglePerWave = totalAngle/numWaves
	end

    for i = 0, numWaves - 1 do
        local wave = SpawnPrefab(wavePrefab)

        local angle = (startAngle - (totalAngle/2)) + (i * anglePerWave)
        local rad = initialOffset or (inst.Physics and inst.Physics:GetRadius()) or 0.0
        local total_rad = rad + wave.Physics:GetRadius() + 0.1
        local offset = Vector3(math.cos(angle*DEGREES),0, -math.sin(angle*DEGREES)):Normalize()
        local wavepos = pos + (offset * total_rad)

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
    end
end
 

local function OnUpdateFade(inst)
    local k
    if inst._fade:value() <= FADE_FRAMES then
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES))
        k = inst._fade:value() / FADE_FRAMES
    else
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES * 2 + 1))
        k = (FADE_FRAMES * 2 + 1 - inst._fade:value()) / FADE_FRAMES
    end

    inst.Light:SetIntensity(FADE_INTENSITY * k)
    inst.Light:SetRadius(FADE_RADIUS * k)
    inst.Light:SetFalloff(1 - (1 - FADE_FALLOFF) * k)

    if TheWorld.ismastersim then
        inst.Light:Enable(inst._fade:value() > 0 and inst._fade:value() <= FADE_FRAMES * 2)
    end

    if inst._fade:value() == FADE_FRAMES or inst._fade:value() > FADE_FRAMES * 2 then
        inst._fadetask:Cancel()
        inst._fadetask = nil
    end
end

local function OnFadeDirty(inst)
    if inst._fadetask == nil then
        inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
    end
    OnUpdateFade(inst)
end

local function FadeOut(inst)
    inst._fade:set(FADE_FRAMES + 1)
    if inst._fadetask == nil then
        inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
    end
end


local function CreateGroundFX(bomb)
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
		       inst.Transform:SetScale(1.5, 1.5, 1.5)

	inst.AnimState:SetBank("coconade_obsidian")
	inst.AnimState:SetBuild("coconade_obsidian")
	inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    inst.AnimState:SetFinalOffset(-1)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst:ListenForEvent("animover", inst.Remove)

    inst.Transform:SetPosition(bomb.Transform:GetWorldPosition())
end



local function OnIgniteFn(inst)
  inst._fx = SpawnPrefab("torchfire")
    inst._fx.entity:SetParent(inst.entity)
            inst._fx.entity:AddFollower()
            inst._fx.Follower:FollowSymbol(inst.GUID, "coconade01", 40, -105, 0)
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
end

local function OnExtinguishFn(inst)
    inst.SoundEmitter:KillSound("hiss")
end

local function OnExplodeFn(inst)
    inst.SoundEmitter:KillSound("hiss")

end



local function Explode(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))







if ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then 


	local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
	local x, y, z = inst.Transform:GetWorldPosition()
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
if not plataforma then SpawnWavesSW(inst, 8, 360, 6) end

end
 local prefab = "mushroombomb"
       local fx = SpawnPrefab(prefab)
	fx.Transform:SetPosition(x, y, z)
	   fx.AnimState:PlayAnimation("explode")
				       fx.Transform:SetScale(2.5, 2.5, 2.5)
	       fx:DoTaskInTime(fx.AnimState:GetCurrentAnimationLength(), fx.Remove)
    fx.persists = false

	  fx._explode:push()
    FadeOut(fx)
	
	    if not TheNet:IsDedicated() then
        CreateGroundFX(fx)
    end

    inst.SoundEmitter:PlaySound("dontstarve/creatures/together/toad_stool/spore_explode")
    inst.SoundEmitter:KillSound("hiss")
	  inst.components.explosive:OnBurnt()
end





	
local function fn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    
	inst.AnimState:SetBank("coconade_obsidian")
	inst.AnimState:SetBuild("coconade_obsidian")
	inst.AnimState:PlayAnimation("idle")
    inst:AddTag("explosive")
	inst:AddTag("SCARYTOPREY") 
	

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end


    inst:AddComponent("explosive")
    inst.components.explosive:SetOnExplodeFn(OnExplodeFn)
    inst.components.explosive.explosivedamage = TUNING.GUNPOWDER_DAMAGE
	inst.components.explosive.explosiverange = 5.5
	
	inst._light = nil

	inst:DoTaskInTime(0, OnIgniteFn)
	inst:DoTaskInTime(3, Explode)
	inst:DoTaskInTime(0, ondropped)	
    return inst
end

return Prefab( "common/inventory/obsidianbombactive", fn, assets) 
