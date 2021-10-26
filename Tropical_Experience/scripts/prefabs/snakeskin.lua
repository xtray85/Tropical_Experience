local assets=
{
	Asset("ANIM", "anim/snakeskin.zip"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    inst.AnimState:SetBank("snakeskin")
    inst.AnimState:SetBuild("snakeskin")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("aquatic")

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    

	MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)
    ---------------------       
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
 	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    return inst
end

return Prefab( "snakeskin", fn, assets) 

