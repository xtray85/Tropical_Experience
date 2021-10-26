local assets =
{
    Asset("ANIM", "anim/quagmire_mushrooms.zip"),
}

local prefabs =
{

}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("quagmire_mushrooms")
    inst.AnimState:SetBuild("quagmire_mushrooms")
    inst.AnimState:PlayAnimation("raw")

    inst:AddTag("cookable")
    inst:AddTag("quagmire_stewable")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.VEGGIE
	inst.components.edible.healthvalue = -5
	inst.components.edible.sanityvalue = -5
    inst.components.edible.hungervalue = 5

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

	inst:AddComponent("tradable")

	inst:AddComponent("inspectable")
	
	inst:AddComponent("cookable")
	inst.components.cookable.product = "quagmire_mushrooms_cooked"

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("inventoryitem")

	MakeHauntableLaunchAndPerish(inst)
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    return inst
end

local function cookedfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("quagmire_mushrooms")
    inst.AnimState:SetBuild("quagmire_mushrooms")
    inst.AnimState:PlayAnimation("cooked")
	
    inst:AddTag("quagmire_stewable")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.VEGGIE
	inst.components.edible.healthvalue = 1
	inst.components.edible.sanityvalue = 0
    inst.components.edible.hungervalue = 15

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

	inst:AddComponent("tradable")

	inst:AddComponent("inspectable")

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FASTISH)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("inventoryitem")

	MakeHauntableLaunchAndPerish(inst)
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
	
    return inst
end

return Prefab("quagmire_mushrooms", fn, assets, prefabs),
    Prefab("quagmire_mushrooms_cooked", cookedfn, assets, prefabs)
