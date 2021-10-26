local assets=
{
	Asset("ANIM", "anim/hippo_antler.zip"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
	
	inst:AddTag("antler")
    
    inst.AnimState:SetBank("hippo_antler")
    inst.AnimState:SetBuild("hippo_antler")
    inst.AnimState:PlayAnimation("idle")
    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst)
    
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("inspectable")    
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
    
    return inst
end

return Prefab( "common/inventory/hippo_antler", fn, assets) 
