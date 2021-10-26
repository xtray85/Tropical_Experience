local assets=
{
	Asset("ANIM", "anim/chitin.zip"),
}

local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	
    
    inst.AnimState:SetBank("chitin")
    inst.AnimState:SetBuild("chitin")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("aquatic")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
    
    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml" 
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

	return inst
end

return Prefab("objects/chitin", fn, assets)
