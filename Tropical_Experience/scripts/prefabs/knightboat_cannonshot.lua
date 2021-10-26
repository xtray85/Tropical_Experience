local assets=
{
	Asset("ANIM", "anim/coconut_cannon.zip"),
	Asset("ANIM", "anim/coconade_obsidian.zip"),	
}

local prefabs = 
{
	"impact",
	"explode_small",
	"bombsplash",
}

local		KNIGHTBOAT_RADIUS = 1.5
local		KNIGHTBOAT_DAMAGE = 50
local		CANNONBOAT_RADIUS = 4
local		CANNONBOAT_DAMAGE = 50


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




local function onthrown(inst, thrower, pt, time_to_target)
local pt = inst:GetPosition()
    inst.Physics:SetFriction(.2)
	inst.Transform:SetFourFaced()
	inst:FacePoint(pt:Get())
    inst.AnimState:PlayAnimation("throw", true)

    local smoke =  SpawnPrefab("collapse_small")
    local x, y, z = inst.Transform:GetWorldPosition()
    y = y + 1

	inst.UpdateTask = inst:DoPeriodicTask(FRAMES, function()
		local pos = inst:GetPosition()
		if pos.y <= 0.3 then
		    local ents = TheSim:FindEntities(pos.x, 0, pos.z, KNIGHTBOAT_RADIUS, nil, {"FX", "DECOR", "INLIMBO"})

	  inst.components.explosive:OnBurnt()
			local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos.x, pos.y, pos.z))

local x, y, z = inst.Transform:GetWorldPosition()			
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
			
			
if plataforma or 
ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then
				inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")
				local explode = SpawnPrefab("explode_small")
				explode.Transform:SetPosition(pos.x, pos.y, pos.z)

			else

				local splash = SpawnPrefab("bombsplash")
				splash.Transform:SetPosition(pos.x, pos.y, pos.z)
				inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/splash_large")
			end

			inst:Remove()
		end
	end)
end





local function Explode(inst)
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










local function onremove(inst)
	if inst.UpdateTask then
		inst.UpdateTask:Cancel()
	end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()


	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("coconut_cannon")
	inst.AnimState:SetBuild("coconut_cannon")
	inst.AnimState:PlayAnimation("throw", true)

	inst:AddTag("thrown")
	inst:AddTag("projectile")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

    inst:AddComponent("explosive")
    inst.components.explosive.explosivedamage = KNIGHTBOAT_DAMAGE
	inst.components.explosive.explosiverange = KNIGHTBOAT_RADIUS
	inst.components.explosive.skip_camera_flash = true
	
    inst:AddComponent("complexprojectile")
	inst.components.complexprojectile:SetHorizontalSpeed(35)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 3, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrown)
--    inst.components.complexprojectile:SetOnHit(onhitground)
	
	

	inst.persists = false

    inst.OnRemoveEntity = onremove

	return inst
end

local function onthrowncannon(inst, attacker, target)
    inst.Physics:SetMass(1)
    inst.Physics:SetCapsule(0.2, 0.2)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.ITEMS)

	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("throw", true)

    local smoke =  SpawnPrefab("collapse_small")
    local x, y, z = inst.Transform:GetWorldPosition()
    y = y + 1

	inst.UpdateTask = inst:DoPeriodicTask(FRAMES, function()
		local pos = inst:GetPosition()
		if pos.y <= 0.3 then
		    local ents = TheSim:FindEntities(pos.x, 0, pos.z, KNIGHTBOAT_RADIUS, nil, {"FX", "DECOR", "INLIMBO"})
	  inst.components.explosive:OnBurnt()
			local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos.x, pos.y, pos.z))
			

local x, y, z = inst.Transform:GetWorldPosition()			
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
			
			
if plataforma or 
ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then
				inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")
				local explode = SpawnPrefab("explode_small")
				explode.Transform:SetPosition(pos.x, pos.y, pos.z)

			else
				local splash = SpawnPrefab("bombsplash")
				SpawnWavesSW(inst, 4, 360, 6, nil, nil, 2, true, true)
				splash.Transform:SetPosition(pos.x, pos.y, pos.z)
				inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/splash_large")	
			end

			inst:Remove()
		end
	end)
end


local function fncannon(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()


	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("coconut_cannon")
	inst.AnimState:SetBuild("coconut_cannon")
	inst.AnimState:PlayAnimation("throw", true)

	inst:AddTag("thrown")
	inst:AddTag("projectile")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

    inst:AddComponent("explosive")
    inst.components.explosive.explosivedamage = CANNONBOAT_DAMAGE
	inst.components.explosive.explosiverange = CANNONBOAT_RADIUS	
	inst.components.explosive.skip_camera_flash = true
	

    inst:AddComponent("complexprojectile")
	inst.components.complexprojectile:SetHorizontalSpeed(25)
    inst.components.complexprojectile:SetGravity(-25)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 3, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrowncannon)

	inst.persists = false

    inst.OnRemoveEntity = onremove

	return inst
end

local function onthrowncannonobsidian(inst, thrower, pt, time_to_target)
  inst._fx = SpawnPrefab("torchfire")
    inst._fx.entity:SetParent(inst.entity)
            inst._fx.entity:AddFollower()
            inst._fx.Follower:FollowSymbol(inst.GUID, "icebomb", 0, 0, 0)
    inst.AnimState:PlayAnimation("throw")
    inst:AddTag("NOCLICK")
    inst.persists = false

  inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
    inst.Physics:SetMass(1)
    inst.Physics:SetCapsule(0.2, 0.2)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.ITEMS)
end

local function OnHitWater(inst, attacker, target)
inst.SoundEmitter:KillSound("hiss")
SpawnPrefab("obsidianbombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())
inst.SoundEmitter:PlaySound("dontstarve/common/dropwood")
inst:Remove()
end

local function fnobsidian(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()


	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("coconade_obsidian")
	inst.AnimState:SetBuild("coconade_obsidian")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("thrown")
	inst:AddTag("projectile")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	


    inst:AddComponent("complexprojectile")
	inst.components.complexprojectile:SetHorizontalSpeed(25)
    inst.components.complexprojectile:SetGravity(-25)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 3, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrowncannonobsidian)
	inst.components.complexprojectile:SetOnHit(OnHitWater)

	inst.persists = false

    inst.OnRemoveEntity = onremove

	return inst
end

return Prefab( "knightboat_cannonshot", fn, assets, prefabs), Prefab( "cannonshot", fncannon, assets, prefabs), Prefab( "cannonshotobsidian", fnobsidian, assets, prefabs)