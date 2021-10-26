local assets=
{
    Asset("ANIM", "anim/quackenbeak.zip")
}

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
	inst:AddTag("aquatic")
	
	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

    inst.AnimState:SetBuild("quackenbeak")
    inst.AnimState:SetBank("quackenbeak")
    inst.AnimState:PlayAnimation("idle")

    inst:AddComponent("inspectable")
    inst:AddComponent("waterproofer")
	
    return inst
end

return Prefab( "common/inventory/quackenbeak", fn, assets)
