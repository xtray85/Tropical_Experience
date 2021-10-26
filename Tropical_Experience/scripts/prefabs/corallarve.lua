local assets=
{
	Asset("ANIM", "anim/corallarve.zip"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
   -- MakeInventoryFloatable(inst, "idle_water", "idle")
 --   MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.HEAVY, TUNING.WINDBLOWN_SCALE_MAX.HEAVY)
    
    inst.AnimState:SetBank("corallarve")
    inst.AnimState:SetBuild("corallarve")
    inst.AnimState:PlayAnimation("idle")
	
	MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM    
    inst:AddComponent("inspectable")
	
    

	--inst:AddComponent("plantable")

	inst:AddComponent("waterproofer")
    inst:AddComponent("bait")
    inst:AddTag("molebait")

	inst:AddComponent("repairer")
	inst.components.repairer.repairmaterial = "stone"
	inst.components.repairer.healthrepairvalue = TUNING.REPAIR_CUTSTONE_HEALTH
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
    
	return inst
end

return Prefab( "common/inventory/corallarve", fn, assets) 
