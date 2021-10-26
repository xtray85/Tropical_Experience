local assets=
{
	Asset("ANIM", "anim/shark_fin.zip"),
}



local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
    
--    MakeInventoryFloatable(inst, "idle_water", "idle")
    
    inst.AnimState:SetBank("shark_fin")
    inst.AnimState:SetBuild("shark_fin")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
    inst.components.edible.healthvalue = TUNING.HEALING_MED
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
    inst.components.edible.sanityvalue = -TUNING.SANITY_MED

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    return inst
end

return Prefab( "common/inventory/shark_fin", fn, assets) 
