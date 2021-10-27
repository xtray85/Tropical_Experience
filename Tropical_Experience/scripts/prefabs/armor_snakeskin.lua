require "prefabutil"
local assets=
{
	Asset("ANIM", "anim/armor_snakeskin.zip"),
}

local function onperish(inst)
	inst:Remove()
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_snakeskin", "swap_body")
    inst.components.fueled:StartConsuming()
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst.components.fueled:StopConsuming()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("armor_snakeskin")
    inst.AnimState:SetBuild("armor_snakeskin")
    inst.AnimState:PlayAnimation("anim")
	
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "armor_snakeskin"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
 
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
	inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.insulated = true	
    
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.components.fueled:InitializeFuelLevel(480*8)
    inst.components.fueled:SetDepletedFn(onperish)

    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_LARGE)
	
	inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)
    
	return inst
end

return Prefab("armor_snakeskin", fn, assets)