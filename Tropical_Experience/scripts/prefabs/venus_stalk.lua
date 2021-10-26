local assets=
{
    Asset("ANIM", "anim/venus_stalk.zip")
}

local plantmeatprefabs =
{
    "walkingstick",
    "spoiled_food",
}

local function flytrapstalk(inst)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("stalk")
    inst.AnimState:SetBuild("venus_stalk")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryFloatable(inst)	
    
    inst:AddTag("meat")

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
	
    inst:AddComponent("edible")
    inst.components.edible.ismeat = true    
    inst.components.edible.foodtype = "MEAT"
    inst.components.edible.foodstate = "RAW"
    
    inst:AddComponent("stackable")
    inst:AddComponent("bait")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
     inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL

    inst:AddComponent("dryable")
    inst.components.dryable:SetProduct("walkingstick")
    inst.components.dryable:SetDryTime(TUNING.DRY_FAST)

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)    

    return inst
end

return  Prefab("common/inventory/venus_stalk", flytrapstalk, assets, plantmeatprefabs)


