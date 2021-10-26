local assets =
{
    Asset("ANIM", "anim/quagmire_sapbucket.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	

    inst.AnimState:SetBank("quagmire_sapbucket")
    inst.AnimState:SetBuild("quagmire_sapbucket")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "quagmire_sapbucket"
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("sapbucket")

    return inst
end

return Prefab("quagmire_sapbucket", fn, assets, prefabs)
