local assets=
{
	Asset("ANIM", "anim/armor_seashell.zip"),
}

local wilson_health = 150
local ARMORSEASHELL = wilson_health * 5
local ARMORSEASHELL_ABSORPTION = 0.75

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve_DLC002/common/armour/shell")
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_seashell", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
    inst:ListenForEvent("attacked", OnBlocked, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
    inst:RemoveEventCallback("attacked", OnBlocked, owner)
end

local function fn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("armor_seashell")
    inst.AnimState:SetBuild("armor_seashell")
    inst.AnimState:PlayAnimation("anim")

    inst.foleysound = "dontstarve_DLC002/common/foley/seashell_suit"
	
	MakeInventoryFloatable(inst)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    --inst:AddTag("wood")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

    --inst:AddComponent("fuel")
    --inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(ARMORSEASHELL, ARMORSEASHELL_ABSORPTION)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	
    MakeHauntableLaunch(inst)	
    
    return inst
end

return Prefab( "armor_seashell", fn, assets) 