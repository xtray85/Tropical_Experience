local assets =
{
    Asset("ANIM", "anim/quagmire_flour.zip"),
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
	MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("quagmire_flour")
    inst.AnimState:SetBuild("quagmire_flour")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("quagmire_stewable")
    inst:AddTag("flour")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

	inst:AddComponent("tradable")

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")	

	MakeHauntableLaunchAndPerish(inst)
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    return inst
end

return Prefab("quagmire_flour", fn, assets, prefabs)
