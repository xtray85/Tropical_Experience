local assets=
{
    Asset("ANIM", "anim/armor_tarsuit.zip"),
}
	
local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_body", "armor_tarsuit", "swap_body")
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
    MakeInventoryFloatable(inst)
	
    inst.AnimState:SetBank("armor_tarsuit")
    inst.AnimState:SetBuild("armor_tarsuit")
    inst.AnimState:PlayAnimation("anim")

    --waterproofer (from waterproofer component) added to pristine state for optimization
    inst:AddTag("waterproofer")
	inst:AddTag("aquatic")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.foleysound = "dontstarve_DLC002/common/foley/blubber_suit"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.insulated = true
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("waterproofer")
	inst.components.waterproofer.effectiveness = 1

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(480)
    inst.components.fueled:SetDepletedFn(inst.Remove)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab( "tarsuit", fn, assets)
