local assets =
{
	Asset("ANIM", "anim/shark_gills.zip"),
}


local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	
	
	inst.AnimState:SetBank("shark_gills")
	inst.AnimState:SetBuild("shark_gills")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("cattoy")
	inst:AddTag("aquatic")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inventoryitem")
	inst:AddComponent("inspectable")
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("tradable")
	
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
	return inst
end

return Prefab("shark_gills", fn, assets) 
