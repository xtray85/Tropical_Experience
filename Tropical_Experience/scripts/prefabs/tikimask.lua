local assets=
{
    Asset("ANIM", "anim/hat_bee.zip"),
    Asset("ANIM", "anim/tiki_mask.zip"),
    Asset("ATLAS", "images/inventoryimages/tikimask.xml")
}

local function generic_perish(inst)
	inst:Remove()
end
local function shadyglasses_onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_hat", "tiki_mask", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
	
	owner.AnimState:Show("HEAD")
	owner.AnimState:Hide("HEAD_HAIR")
		
	owner:AddTag("tiki")
end
local function shadyglasses_onunequip(inst, owner)
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
		
	owner:RemoveTag("tiki")
end
--[[
     local function beefalo_equip(inst, owner)
        onequip(inst, owner)
        owner:AddTag("beefalo")
    end
    local function beefalo_unequip(inst, owner)
        onunequip(inst, owner)
        owner:RemoveTag("beefalo")
    end
]]
local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	

    anim:SetBank("beehat")
    anim:SetBuild("tiki_mask")
    anim:PlayAnimation("anim")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/tikimask.xml"
    inst:AddComponent("tradable")

	inst:AddComponent("armor")		
	inst.components.armor:InitCondition(100, .25)
     
    inst.components.equippable:SetOnEquip( shadyglasses_onequip )
    inst.components.equippable:SetOnUnequip( shadyglasses_onunequip )

    return inst
end
 
return Prefab( "common/inventory/tikimask", fn or simple, assets, prefabs)