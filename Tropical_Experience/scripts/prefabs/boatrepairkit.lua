local assets=
{
	Asset("ANIM", "anim/boat_repair_kit.zip"),
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

    inst.AnimState:SetBank("boat_repair_kit")
    inst.AnimState:SetBuild("boat_repair_kit")
    inst.AnimState:PlayAnimation("idle")

	MakeInventoryFloatable(inst)
	inst:AddTag("boatrepairkit")
    inst:AddTag("allow_action_on_impassable")
    inst:AddTag("boat_patch")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(BOAT_REPAIR_KIT_USES)
    inst.components.finiteuses:SetUses(BOAT_REPAIR_KIT_USES)
    inst.components.finiteuses:SetOnFinished( onfinished )
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
    
    inst:AddComponent("inspectable")
	inst:AddComponent("interactions")
	
    inst:AddComponent("repairer")
    inst.components.repairer.repairmaterial = MATERIALS.WOOD
    inst.components.repairer.healthrepairvalue = TUNING.REPAIR_BOARDS_HEALTH * 3.5	
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    return inst
end

return Prefab( "common/inventory/boatrepairkit", fn, assets) 

