local assets =
{
	Asset("ANIM", "anim/cut_hedge.zip"),
    Asset("INV_IMAGE", "cut_hedge"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("cut_hedge")
    inst.AnimState:SetBuild("cut_hedge")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("cattoy")	
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "VEGGIE"
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY/2

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
        
    inst:AddComponent("inventoryitem")
 --   inst.components.inventoryitem:ChangeImageName("cut_hedge")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    return inst
end

return Prefab( "common/inventory/clippings", fn, assets)

