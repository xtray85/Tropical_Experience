local assets=
{
	Asset("ANIM", "anim/armor_windbreaker.zip"),
}

local function onperish(inst)
	inst:Remove()
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_windbreaker", "swap_body")
    inst.components.fueled:StartConsuming()
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst.components.fueled:StopConsuming()
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddNetwork()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("armor_windbreaker")
    inst.AnimState:SetBuild("armor_windbreaker")
    
	inst.foleysound = "dontstarve_DLC002/common/foley/windbreaker"
    
	MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
    
    inst.AnimState:PlayAnimation("anim")
    
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.components.fueled:InitializeFuelLevel(4800)
    inst.components.fueled:SetDepletedFn(onperish)

    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)

--    inst:AddComponent("windproofer")
--    inst.components.windproofer:SetEffectiveness(1) 100%
    
	return inst
end

return Prefab( "common/inventory/armor_windbreaker", fn, assets)
