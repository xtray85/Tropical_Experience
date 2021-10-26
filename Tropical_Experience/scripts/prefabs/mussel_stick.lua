local assets=
{
	Asset("ANIM", "anim/musselfarm_stick.zip"),
}

local function onfinished(inst)
	inst:Remove()
end


local 	 		BOAT_REPAIR_KIT_HEALING = 100
local			BOAT_REPAIR_KIT_USES = 3

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

	inst.AnimState:SetBuild("musselFarm_stick")
	inst.AnimState:SetBank("musselFarm_stick")
	inst.AnimState:PlayAnimation("idle")

	MakeInventoryFloatable(inst)
	inst:AddTag("mussel_stick")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("tradable")	
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )
	
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    return inst
end

return Prefab( "common/inventory/mussel_stick", fn, assets) 