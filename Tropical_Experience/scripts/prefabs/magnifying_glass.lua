local assets=
{
	Asset("ANIM", "anim/hand_lens.zip"),
	Asset("ANIM", "anim/swap_hand_lens.zip"),
}

local prefabs =
{
}

local MAGNIFYING_GLASS_USES = 50
local MAGNIFYING_GLASS_DAMAGE = 34 *.125

local function onequip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_object", "swap_hand_lens", "swap_hand_lens")
	owner.AnimState:Show("ARM_carry") 
	owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal") 
end

local function onfinished(inst)
    inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("hand_lens")
	inst.AnimState:SetBuild("hand_lens")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("magnifying_glass")	

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("finiteuses")

	local uses = MAGNIFYING_GLASS_USES

	inst.components.finiteuses:SetMaxUses(uses)
	inst.components.finiteuses:SetUses(uses)
	inst.components.finiteuses:SetConsumption(ACTIONS.INVESTIGATEGLASS, 1)
	inst.components.finiteuses:SetOnFinished(onfinished)
	-------
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(MAGNIFYING_GLASS_DAMAGE)

	inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.INVESTIGATEGLASS)
	-------
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	
	inst:AddComponent("lighter")

	return inst
end

return Prefab( "common/inventory/magnifying_glass", fn, assets, prefabs)