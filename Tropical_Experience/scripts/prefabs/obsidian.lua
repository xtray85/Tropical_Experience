local assets=
{
    Asset("ANIM", "anim/obsidian.zip"),
}


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)


    inst.AnimState:SetRayTestOnBB(true);
    inst.AnimState:SetBank("obsidian")
    inst.AnimState:SetBuild("obsidian")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("molebait")	
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
    inst.components.edible.hungervalue = 3

    inst:AddComponent("stackable")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	


    inst:AddComponent("bait")

    return inst
end

return Prefab( "obsidian", fn, assets)
