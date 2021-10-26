local assets=
{
	Asset("ANIM", "anim/coconut_cannon.zip"),
}

local prefabs = 
{
    "groundpound_fx",
    "groundpoundring_fx",
}

local function onhacked(nut)
       nut.components.lootdropper:SpawnLootPrefab("coconut_halved")
       nut.components.lootdropper:SpawnLootPrefab("coconut_halved")
    nut:Remove()

end 

local function onthrown(inst, thrower, pt, time_to_target)
    inst.Physics:SetFriction(.2)
	inst.Transform:SetFourFaced()
	inst:FacePoint(pt:Get())
    inst.AnimState:PlayAnimation("throw", true)

    local shadow = SpawnPrefab("warningshadow")
    shadow.Transform:SetPosition(pt:Get())
    shadow:shrink(time_to_target, 1.75, 0.5)

	inst.TrackHeight = inst:DoPeriodicTask(FRAMES, function()
		local pos = inst:GetPosition()

		if pos.y <= 0.3 then

		    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 1.5)

		    for k,v in pairs(ents) do
	            if v.components.combat and v ~= inst and v.prefab ~= "treeguard" then
	                v.components.combat:GetAttacked(thrower, 50)
	            end
		    end
			
			
			
			
--				local smoke = SpawnPrefab("small_puff_light")
				local other = nil
				if math.random() < 0.01 then
				other = SpawnPrefab("coconut")
				else
--				other = SpawnPrefab("coconut_chunks")
--				other = SpawnPrefab("explode_small")
				end
--				smoke.Transform:SetPosition(pt:Get())
--				other.Transform:SetPosition(pt:Get())			


		inst.components.groundpounder:GroundPound()





				
			inst:Remove()
			end				
	end)
end

local function onremove(inst)
	if inst.TrackHeight then
		inst.TrackHeight:Cancel()
		inst.TrackHeight = nil
	end
end


local function OnSave(inst, data)
inst:Remove()
end

local function OnLoad(inst, data)
inst:Remove()
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("coconut_cannon")
	inst.AnimState:SetBuild("coconut_cannon")
	inst.AnimState:PlayAnimation("throw", true)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
       	return inst
   	end

	inst:AddTag("thrown")
	inst:AddTag("projectile")

	inst:AddComponent("throwable")
	inst.components.throwable.onthrown = onthrown
	inst.components.throwable.random_angle = 0
	inst.components.throwable.max_y = 50
	inst.components.throwable.yOffset = 1

	
	
	
	inst:AddComponent("groundpounder")
	inst.components.groundpounder.numRings = 2
	inst.components.groundpounder.ringDelay = 0.1
	inst.components.groundpounder.initialRadius = 1
	inst.components.groundpounder.radiusStepDistance = 2
	inst.components.groundpounder.pointDensity = .25
	inst.components.groundpounder.damageRings = 1
	inst.components.groundpounder.destructionRings = 1
	inst.components.groundpounder.destroyer = false
	inst.components.groundpounder.burner = false
	inst.components.groundpounder.ring_fx_scale = 0.15
	inst.components.groundpounder.groundpoundfx = "explode_small"
    inst.components.groundpounder.groundpoundringfx = "explode_small"

	
	
	

	
	
	
	
	
	

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(30)	
	
    inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	
	
	inst.OnRemoveEntity = onremove

	return inst
end

return Prefab("common/inventory/treeguard_coconut", fn, assets, prefabs)