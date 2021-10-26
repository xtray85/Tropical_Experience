local assets=
{
	Asset("ANIM", "anim/doydoy_nest_2.zip"),
}

local prefabs = 
{
--	"doydoyegg_cracked",
	"doydoyegg_cooked",
	"spoiled_food",
}

local function defaultfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	
	
	inst.AnimState:SetBuild("doydoy_nest_2")
	inst.AnimState:SetBank("doydoy_nest_2")
	inst.AnimState:PlayAnimation("idle_egg")

	inst:AddTag("doydoyegg")
	inst:AddTag("cattoy")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"

	inst:AddComponent("perishable")
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("tradable")

	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"

	inst.components.edible.healthvalue = TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_MED

	inst:AddComponent("cookable")
	inst.components.cookable.product = "doydoyegg_cooked"

	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	inst.components.perishable:StartPerishing()

	return inst
end

local function cookedfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	
	
	inst.AnimState:SetBuild("doydoy_nest_2")
	inst.AnimState:SetBank("doydoy_nest_2")
	inst.AnimState:PlayAnimation("cooked")

	inst:AddTag("cattoy")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"

	inst:AddComponent("perishable")
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("tradable")
	
	inst:AddComponent("stackable")

	inst.components.edible.foodstate = "COOKED"
	inst.components.edible.healthvalue = 0
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE

	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	
	return inst
end

-- doydoyegg_cracked is really just here so old saves don't blow up
return Prefab( "common/inventory/doydoyegg", defaultfn, assets, prefabs),
--		Prefab( "common/inventory/doydoyegg_cracked", defaultfn, assets, prefabs),
		Prefab( "common/inventory/doydoyegg_cooked", cookedfn, assets, prefabs) 
