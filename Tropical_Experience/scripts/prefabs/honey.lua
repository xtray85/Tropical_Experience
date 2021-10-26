local assets =
{
    Asset("ANIM", "anim/honey.zip"),
}

local prefabs =
{
    "spoiled_food",
}

local function OnPutInInventory(inst, owner)
    if owner.prefab == "antchest" then
    inst.components.perishable:StopPerishing()
	end
end

local function OnRemoved(inst, owner)
inst.components.perishable:StartPerishing()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBuild("honey")
    inst.AnimState:SetBank("honey")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("honeyed")

    MakeInventoryFloatable(inst, "med", nil, 0.8)

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
    inst.components.inventoryitem:SetOnPickupFn(OnRemoved)	

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("honey", fn, assets, prefabs)