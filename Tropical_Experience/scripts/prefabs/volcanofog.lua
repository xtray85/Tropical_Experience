local texture = "levels/textures/ds_fog1.tex"
local shader = "shaders/particle.ksh"
local scale_envelope_name = "oceanfogscaleenvelope"

local assets =
{
	Asset( "IMAGE", texture ),
	Asset( "SHADER", shader ),
}

local max_scale = 10

local init = false
local function InitEnvelopes()
	if EnvelopeManager and not init then
		init = true

		EnvelopeManager:AddColourEnvelope(
			"volcanofogcolourenvelope",
			{	{ 0,	{ 1, 1, 1, 0 } },
				{ 0.1,	{ 1, 1, 1, 0.12 } },
				{ 0.75,	{ 1, 1, 1, 0.12 } },
				{ 1,	{ 1, 1, 1, 0 } },
			} )

		EnvelopeManager:AddVector2Envelope(
			scale_envelope_name,
			{	{ 0,	{ 6, 6 } },
				{ 1,	{ max_scale, max_scale } },
			} )
	end
end

local max_lifetime = 15
local max_num_particles = 1 * max_lifetime
local ground_height = 0.4
local emitter_radius = 50
local emitter_wradius = 10

--local function area_emitter()
--	return emitter_radius * UnitRand(), emitter_radius * UnitRand()
--end

local function emit_fn(emitter, radius)
	--print("emit....")
	local vx, vy, vz = 0.01 * UnitRand(), 0, 0.01 * UnitRand()
	local lifetime = max_lifetime * ( 0.9 + UnitRand() * 0.1 )
	local px, pz

	local py = ground_height
	
	px, pz = radius * UnitRand(), radius * UnitRand() --area_emitter()
	--print("px", px, "py", py, "pz", pz, "lifetime", lifetime)
	emitter:AddParticle(
		lifetime,			-- lifetime
		px, py, pz,			-- position
		vx, vy, vz			-- velocity
	)
	--print("emit.... complete")
end

local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end

local function volcanofn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddNetwork()
	
	inst:AddTag("FX")
	inst:AddTag("NOCLICK")

	inst.entity:SetPristine()
		
    if not TheWorld.ismastersim then
        return inst
    end	
	
	InitEnvelopes()

	local emitter = inst.entity:AddParticleEmitter()
	emitter:SetRenderResources( texture, shader )
	emitter:SetMaxNumParticles( max_num_particles)
	emitter:SetMaxLifetime( max_lifetime )
	emitter:SetSpawnVectors( -1, 0, 1, 1, 0, 1 ) --( config.SV[1].x, config.SV[1].y, config.SV[1].z, config.SV[2].x, config.SV[2].y, config.SV[2].z)
	emitter:SetSortOrder( 3 )
	emitter:SetScaleEnvelope( scale_envelope_name );
	emitter:SetRadius(emitter_radius)

	inst.num_particles_to_emit = 0
	inst.ParticleEmitter:SetColourEnvelope("volcanofogcolourenvelope")
	inst.particles_per_tick = 1 * TheSim:GetTickTime()

	local function updateFunc()
		--print("emit updateFunc....", inst.num_particles_to_emit)
	while inst.num_particles_to_emit > 1 do
			emit_fn( inst.ParticleEmitter, emitter_radius )
			inst.num_particles_to_emit = inst.num_particles_to_emit - 1
	end

		inst.num_particles_to_emit = inst.num_particles_to_emit + inst.particles_per_tick
		--print("emit updateFunc.... complete")
	end
	
	EmitterManager:AddEmitter( inst, nil, updateFunc )

	return inst
end

local function oceanfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddNetwork()
	
	inst:AddTag("FX")
	inst:AddTag("NOCLICK")

	inst.entity:SetPristine()
		
    if not TheWorld.ismastersim then
        return inst
    end	
	
	InitEnvelopes()

	local emitter = inst.entity:AddParticleEmitter()
	emitter:SetRenderResources( texture, shader )
	emitter:SetMaxNumParticles( max_num_particles)
	emitter:SetMaxLifetime( max_lifetime )
	emitter:SetSpawnVectors( -1, 0, 1, 1, 0, 1 ) --( config.SV[1].x, config.SV[1].y, config.SV[1].z, config.SV[2].x, config.SV[2].y, config.SV[2].z)
	emitter:SetSortOrder( 3 )
	emitter:SetScaleEnvelope( scale_envelope_name );
	emitter:SetRadius(emitter_radius)

	inst.num_particles_to_emit = 0
	inst.ParticleEmitter:SetColourEnvelope("volcanofogcolourenvelope")
	inst.particles_per_tick = 1 * TheSim:GetTickTime()

	local function updateFunc()
		--print("emit updateFunc....", inst.num_particles_to_emit)
	while inst.num_particles_to_emit > 1 do
			emit_fn( inst.ParticleEmitter, emitter_radius )
			inst.num_particles_to_emit = inst.num_particles_to_emit - 1
	end

		inst.num_particles_to_emit = inst.num_particles_to_emit + inst.particles_per_tick
		--print("emit updateFunc.... complete")
	end
	
	EmitterManager:AddEmitter( inst, nil, updateFunc )
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 80 + math.random()*80)		

	return inst
end


local function volcanowall(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddNetwork()
	
	inst:AddTag("FX")
	inst:AddTag("NOCLICK")
	inst:AddTag("blocker")
	inst:AddTag("walldovulcao")
	local phys = inst.entity:AddPhysics()
	phys:SetMass(0)
	phys:SetCollisionGroup(COLLISION.WORLD)
	phys:ClearCollisionMask()
	phys:CollidesWith(COLLISION.ITEMS)
	phys:CollidesWith(COLLISION.CHARACTERS)
	phys:CollidesWith(COLLISION.GIANTS)
	phys:CollidesWith(COLLISION.FLYERS)
	phys:SetCapsule(0.5, 50)

	InitEnvelopes()

	local emitter = inst.entity:AddParticleEmitter()
	emitter:SetRenderResources( texture, shader )
	emitter:SetMaxNumParticles( max_num_particles)
	emitter:SetMaxLifetime( max_lifetime )
	emitter:SetSpawnVectors( -1, 0, 1, 1, 0, 1 ) --( config.SV[1].x, config.SV[1].y, config.SV[1].z, config.SV[2].x, config.SV[2].y, config.SV[2].z)
	emitter:SetSortOrder( 3 )
	emitter:SetScaleEnvelope( scale_envelope_name );
	emitter:SetRadius(emitter_wradius)

	inst.num_particles_to_emit = 0
	inst.ParticleEmitter:SetColourEnvelope("volcanofogcolourenvelope")
	inst.particles_per_tick = 1 * TheSim:GetTickTime()

	local function updateFunc()
		--print("emit updateFunc....", inst.num_particles_to_emit)
	while inst.num_particles_to_emit > 1 do
			emit_fn( inst.ParticleEmitter, emitter_wradius )
			inst.num_particles_to_emit = inst.num_particles_to_emit - 1
	end

		inst.num_particles_to_emit = inst.num_particles_to_emit + inst.particles_per_tick
		--print("emit updateFunc.... complete")
	end
	
	EmitterManager:AddEmitter( inst, nil, updateFunc )

	return inst
end

return 
Prefab( "common/fx/volcanofog", volcanofn, assets),
Prefab( "common/fx/oceanfog", oceanfn, assets),
Prefab( "common/fx/wallfog", volcanowall, assets)
 
