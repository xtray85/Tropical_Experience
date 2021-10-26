local assets =
{
	Asset("ANIM", "anim/nectar_pod.zip"),
}

local prefabs =
{
	"spoiled_food",
}

local function TransformToHoney(inst, antchest)
    antchest.components.container:RemoveItem(inst)
    local numNectarPods = 1

    if inst.components.stackable and inst.components.stackable:IsStack() and inst.components.stackable:StackSize() > 1 then
        numNectarPods = inst.components.stackable:StackSize() + 1
    end

    inst:Remove()

    print("NUM NECTAR PODS = "..numNectarPods)
    for index = 1, numNectarPods, 1 do
        local honey = SpawnPrefab("honey")
        local position = Vector3(antchest.Transform:GetWorldPosition())
        honey.Transform:SetPosition(position.x, position.y, position.z)
        antchest.components.container:GiveItem(honey, nil, Vector3(inst.Transform:GetWorldPosition()))
    end
end

local function OnPutInInventory(inst, owner)
    if owner.prefab == "antchest" then
    inst:DoTaskInTime(1, function() TransformToHoney(inst, owner) end)
        inst.components.perishable:StopPerishing()
    else
        inst.components.perishable:StartPerishing()	
	end
end

local function OnRemoved(inst, owner)
inst.components.perishable:StartPerishing()
end


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
    
    inst.AnimState:SetBuild("nectar_pod")
    inst.AnimState:SetBank("nectar_pod")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("nectar")
	inst:AddTag("aquatic")
  
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
  
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
    
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
    
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
    inst.components.inventoryitem:OnPickup(OnRemoved)
    
    return inst
end

return Prefab( "common/inventory/nectar_pod", fn, assets, prefabs) 
