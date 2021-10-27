local assets=
{
	Asset("ANIM", "anim/armor_metalplate.zip"),
    --Asset("INV_IMAGE", "metalplatehat"),
}

local ARMORMETAL = 150*8
local ARMORMETAL_ABSORPTION = .8
local ARMORMETAL_SLOW = 0.80

local function OnBlocked(owner) 
	if owner.SoundEmitter ~= nil then
        owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
    end 
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_metalplate", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function fn(Sim)
	local inst = CreateEntity()  
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("armor_metalplate")
    inst.AnimState:SetBuild("armor_metalplate")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddTag("metal")

	MakeInventoryFloatable(inst)
  
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(ARMORMETAL, ARMORMETAL_ABSORPTION)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = ARMORMETAL_SLOW
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    return inst
end

return Prefab( "common/inventory/armor_metalplate", fn, assets) 
