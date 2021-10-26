local assets=
{
	Asset("ANIM", "anim/armor_lifejacket.zip"),
    Asset("INV_IMAGE", "armor_lifeJacket"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_lifejacket", "swap_body")
	owner:AddTag("stronggrip")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
	owner:RemoveTag("stronggrip")
end

local function fn(Sim)
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
--    MakeInventoryFloatable(inst, "idle_water", "anim")
    
    inst.AnimState:SetBank("armor_lifejacket")
    inst.AnimState:SetBuild("armor_lifejacket")
    inst.AnimState:PlayAnimation("anim")
    inst.foleysound = "dontstarve_DLC002/common/foley/life_jacket"
	MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("inspectable")
    inst:AddComponent("flotationdevice")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    inst.components.inventoryitem.keepondeath = true

    --inst:AddComponent("fuel")
   -- inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    --inst:AddComponent("armor")
    --inst.components.armor:InitCondition(TUNING.ARMORWOOD, TUNING.ARMORWOOD_ABSORPTION)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    return inst
end

return Prefab( "common/inventory/armor_lifejacket", fn, assets) 
