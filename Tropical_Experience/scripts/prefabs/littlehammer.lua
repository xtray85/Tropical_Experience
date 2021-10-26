local assets=
{
	Asset("ANIM", "anim/ballpein_hammer.zip"),
	Asset("ANIM", "anim/swap_ballpein_hammer.zip"),
    Asset("INV_IMAGE", "ballpein_hammer"),
}

local function onfinished(inst)
    inst:Remove()
end

local LITTLE_HAMMER_DAMAGE = 34*0.3
local LITTLE_HAMMER_USES = 10

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_ballpein_hammer", "swap_ballpein_hammer")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    anim:SetBank("ballpein_hammer")
    anim:SetBuild("ballpein_hammer")
    anim:PlayAnimation("idle")

	inst:AddTag("ballpein_hammer")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(LITTLE_HAMMER_DAMAGE)
    -----
    --inst:AddComponent("tool")
    --inst.components.tool:SetAction(ACTIONS.DISLODGE)
    -------
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses( LITTLE_HAMMER_USES)
    inst.components.finiteuses:SetUses( LITTLE_HAMMER_USES)
    inst.components.finiteuses:SetOnFinished( onfinished )	
	
    inst:AddComponent("dislodger")

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    
    return inst
end

return Prefab( "common/inventory/ballpein_hammer", fn, assets)	   

