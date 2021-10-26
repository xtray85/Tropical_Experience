local assets=
{
	Asset("ANIM", "anim/snake_cannon.zip"),
}

local prefabs = 
{
    "groundpound_fx",
    "groundpoundring_fx",
}

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
			
			local other = SpawnPrefab("snake")
			other.Transform:SetPosition(pt:Get())			

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

	inst.AnimState:SetBank("snake_cannon")
	inst.AnimState:SetBuild("snake_cannon")
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

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(3)	
	
    inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	
	
	inst.OnRemoveEntity = onremove

	return inst
end

local function fall(inst, thrower, pt, time_to_target)
    inst.Physics:SetFriction(.2)
	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("throw", true)

	inst.TrackHeight = inst:DoPeriodicTask(FRAMES, function()
		local pos = inst:GetPosition()
		if pos.y <= 0.3 then	
		local px, py, pz = inst.Transform:GetWorldPosition()
		local other = SpawnPrefab("snake_amphibious")
		other.Transform:SetPosition(px, py, pz)			
			inst:Remove()
			end				
	end)
end

local function fn2()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("snake_cannon")
	inst.AnimState:SetBuild("snake_cannon")
	inst.AnimState:PlayAnimation("throw", true)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
       	return inst
   	end
	
	inst.OnRemoveEntity = onremove	
	
	inst:DoTaskInTime(0, fall)

    inst:AddComponent("inspectable")	

	return inst
end

return Prefab("common/inventory/jungletreeguard_snake", fn, assets, prefabs),
	   Prefab("common/inventory/snakefall", fn2, assets, prefabs)