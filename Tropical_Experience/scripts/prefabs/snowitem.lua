local assets =
{
	Asset("ANIM", "anim/snow_dune.zip"),
	Asset("ANIM", "anim/sand_dune.zip"),
}

local function onperish(inst)
inst:Remove()
end

local function sandfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)		

	anim:SetBuild("snow_dune")
	anim:SetBank("sand_dune")
	anim:PlayAnimation("full")
	inst.Transform:SetScale(0.5, 0.6, 0.5)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	-----------------
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	----------------------
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GENERIC"
    inst.components.edible.healthvalue = TUNING.HEALING_TINY/2
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY/4
    inst.components.edible.degrades_with_spoilage = false
    inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP
    inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_BRIEF * 1.5
	inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY/8
    inst.components.edible.foodtype = "ELEMENTAL"	
	
	
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable:SetOnPerishFn(onperish)	
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	
	return inst
end

return Prefab( "snowitem", sandfn, assets)