local assets=
{
	Asset("ANIM", "anim/seal_of_approval.zip"),
}

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    inst.AnimState:SetBank("seal_of_approval")
    inst.AnimState:SetBuild("seal_of_approval")
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

return Prefab("magic_seal", fn, assets)