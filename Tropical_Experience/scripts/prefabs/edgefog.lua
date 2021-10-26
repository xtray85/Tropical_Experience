local TEXTURE = "levels/textures/ds_fog1.tex"
local SHADER = "shaders/vfx_particle.ksh"
local COLOUR_ENVELOPE_NAME = "edgefogcolourenvelope"
local SCALE_ENVELOPE_NAME = "edgefogscaleenvelope"

local assets =
{
    Asset("IMAGE", TEXTURE),
    Asset("SHADER", SHADER),
}

local function InitEnvelopes()
    EnvelopeManager:AddColourEnvelope(
        COLOUR_ENVELOPE_NAME,
        {
            { 0,    { 1, 1, 1, 0 } },
            { .1,  { 1, 1, 1, 1 } },
            { .75, { 1, 1, 1, 1 } },
            { 1,    { 1, 1, 1, 0 } },
        }
    )

    local max_scale = 10
    EnvelopeManager:AddVector2Envelope(
        SCALE_ENVELOPE_NAME,
        {
            { 0,    { 6, 6 } },
            { 1,    { max_scale, max_scale } },
        }
    )

    InitEnvelopes = nil
end

local MAPWRAPPER_EDGEFOG_RANGE = 12
local MAX_NUM_PARTICLES = 1000
local MAX_LIFETIME = 5
local GROUND_HEIGHT = .4
local EMITTER_RADIUS = 25
local DESIRED_PARTICLES_PER_SECOND = 20

local function fn()
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    --inst.entity:SetCanSleep(false)
    if TheNet:GetIsClient() then
        inst.entity:AddClientSleepable()
    end
    inst.persists = false

    inst.entity:AddTransform()
	
	function inst:AddTarget(target)
		self.target = target
		self.entity:SetParent(target.entity)
	end
    -----------------------------------------------------
	if TheNet:IsDedicated() then
		return inst
	end
	
	if InitEnvelopes ~= nil then
        InitEnvelopes()
    end

    local config =
    {
        texture = TEXTURE,
        shader = SHADER,
        max_num_particles = MAX_NUM_PARTICLES,
        max_lifetime = MAX_LIFETIME,
        SV =
        {
            { x = -1, y = 0, z = 1 },
            { x = 1, y = 0, z = 1 },
        },
        sort_order = 3,
        colour_envelope_name = COLOUR_ENVELOPE_NAME,
        scale_envelope_name = SCALE_ENVELOPE_NAME
    }

    local effect = inst.entity:AddVFXEffect()
    effect:InitEmitters(1)
    effect:SetRenderResources(0, config.texture, config.shader)
    effect:SetMaxNumParticles(0, config.max_num_particles)
    effect:SetMaxLifetime(0, config.max_lifetime)
    effect:SetSpawnVectors(0,
        config.SV[1].x, config.SV[1].y, config.SV[1].z,
        config.SV[2].x, config.SV[2].y, config.SV[2].z
    )
    effect:SetSortOrder(0, config.sort_order)
    effect:SetColourEnvelope(0, config.colour_envelope_name)
    effect:SetScaleEnvelope(0, config.scale_envelope_name)
    effect:SetRadius(0, EMITTER_RADIUS)

    -----------------------------------------------------
	
	local function area_emitter()
		if inst.target then
			local px, py, pz = inst.target.Transform:GetWorldPosition()
			local map = TheWorld.Map
			local w, h = map:GetSize()
			local halfw, halfh = 0.5 * w * TILE_SCALE, 0.5 * h * TILE_SCALE
			local distx = math.min(halfw + px, halfw - px)
			local distz = math.min(halfh + pz, halfh - pz)
			local cloud_range = MAPWRAPPER_EDGEFOG_RANGE * TILE_SCALE
			local min_range = cloud_range + 100
			local range = 10 * TILE_SCALE

			local getx = function(distx)
				local x, z = 0, math.random(-range, range)
				if px < 0 then
					x = -halfw + math.random(0, cloud_range) - px
				else
					x = halfw - math.random(0, cloud_range) - px
				end
				return x, z
			end

			local getz = function(distz)
				local x, z = math.random(-range, range), 0
				if pz < 0 then
					z = -halfh + math.random(0, cloud_range) - pz
				else
					z = halfh - math.random(0, cloud_range) - pz
				end
				return x, z
			end

			local x, z = 0, 0
			if distx <= min_range and distz <= min_range then
				if math.random() < 0.5 then
					x, z = getx(distx)
				else
					x, z = getz(distz)
				end
			elseif distx <= min_range then
				x, z = getx(distx)
			else
				x, z = getz(distz)
			end

			return x, z
		end
	end

    inst:AddComponent("emitter")
    inst.components.emitter.config = config
    inst.components.emitter.max_lifetime = MAX_LIFETIME
    inst.components.emitter.ground_height = GROUND_HEIGHT
	local tick_time = TheSim:GetTickTime()
    inst.components.emitter.particles_per_tick = DESIRED_PARTICLES_PER_SECOND * tick_time
	inst.components.emitter.area_emitter = area_emitter
	inst.components.emitter:Emit()
	

    return inst
end

return Prefab("edgefog", fn, assets)
