local assets=
{
	Asset("ANIM", "anim/mussel.zip"),
}

local prefabs =
{
	"mussel_cooked",
	"spoiled_food",
}

local APPEASEMENT_SMALL = 8

local function raw()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("mussel")
	inst.AnimState:SetBuild("mussel")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetRayTestOnBB(true)
	
	MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("tradable")
	inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT
 --   inst.components.tradable.dubloonvalue = TUNING.DUBLOON_VALUES.SEAFOOD
    
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddTag("packimfood")
	
	
	inst.no_wet_prefix = true

	inst.components.edible.healthvalue = 0
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL

	inst:AddComponent("cookable")
	inst.components.cookable.product = "mussel_cooked"

	inst:AddComponent("bait")

	return inst
end

local function cooked()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("mussel")
	inst.AnimState:SetBuild("mussel")
	inst.AnimState:SetRayTestOnBB(true)
	
	MakeInventoryFloatable(inst)
	inst:AddTag("packimfood")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("tradable")
	inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT
--    inst.components.tradable.dubloonvalue = TUNING.DUBLOON_VALUES.SEAFOOD
    
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"


	inst.AnimState:PlayAnimation("cooked")
	inst.components.edible.foodstate = "COOKED"
	inst.components.edible.healthvalue = TUNING.HEALING_TINY
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	return inst
end

return Prefab( "common/inventory/mussel", raw, assets, prefabs),
	   Prefab("common/inventory/mussel_cooked", cooked, assets)
