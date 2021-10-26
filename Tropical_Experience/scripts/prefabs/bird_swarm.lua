require "prefabutil"

local prefabs = 
{
    "quagmire_pigeon" 
}

local assets =
{
}

local function onsave(inst, data)

end

local function onload(inst, data)

end

local function spawn_pigeon(inst)
    local DIST = 8

	if inst.prefab == "pigeon_swarm" then
		
    local pigeon = SpawnPrefab("quagmire_pigeon")                
    local x,y,z = inst.Transform:GetWorldPosition()
    x = x + (math.random()*DIST) - DIST/2
    z = z + (math.random()*DIST) - DIST/2
    pigeon.Transform:SetPosition(x,15,z)
    if math.random() < .5 then
       pigeon.Transform:SetRotation(180)
    end
	end
	
	if inst.prefab == "kingfisher_swarm" then
    local pigeon = SpawnPrefab("kingfisher")                
    local x,y,z = inst.Transform:GetWorldPosition()
    x = x + (math.random()*DIST) - DIST/2
    z = z + (math.random()*DIST) - DIST/2
    pigeon.Transform:SetPosition(x,15,z)
    if math.random() < .5 then
       pigeon.Transform:SetRotation(180)
    end
	end	
	
	if inst.prefab == "toucan_hamlet_swarm" then
    local pigeon = SpawnPrefab("toucan_hamlet")                
    local x,y,z = inst.Transform:GetWorldPosition()
    x = x + (math.random()*DIST) - DIST/2
    z = z + (math.random()*DIST) - DIST/2
    pigeon.Transform:SetPosition(x,15,z)
    if math.random() < .5 then
       pigeon.Transform:SetRotation(180)
    end
	end		
		
	if inst.prefab == "parrot_blue_swarm" then
    local pigeon = SpawnPrefab("parrot_blue")                
    local x,y,z = inst.Transform:GetWorldPosition()
    x = x + (math.random()*DIST) - DIST/2
    z = z + (math.random()*DIST) - DIST/2
    pigeon.Transform:SetPosition(x,15,z)
    if math.random() < .5 then
       pigeon.Transform:SetRotation(180)
    end
	end		
end

local function set_spawn(inst)
    inst.pigeons = inst.pigeons - 1
    spawn_pigeon(inst)
    if inst.pigeons > 0 then
        inst:DoTaskInTime(math.random()*0.7,function()                
            set_spawn(inst)               
        end)    
    else
        inst:Remove()
    end
end

local function StopTrackingInSpawner(inst)
	local ground = TheWorld
	if ground and ground.components.birdspawner then
		ground.components.birdspawner:StopTracking(inst)
	end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
    inst.entity:AddPhysics()

    inst.pigeons = math.random(3,7)

    inst.entity:SetPristine()		

    if not TheWorld.ismastersim then
        return inst
    end

    set_spawn(inst)

	inst:ListenForEvent("onremove", StopTrackingInSpawner)
    return inst
end

return  Prefab("common/objects/pigeon_swarm", fn, assets, prefabs),
		Prefab("common/objects/kingfisher_swarm", fn, assets, prefabs),
		Prefab("common/objects/toucan_hamlet_swarm", fn, assets, prefabs),
		Prefab("common/objects/parrot_blue_swarm", fn, assets, prefabs)			

