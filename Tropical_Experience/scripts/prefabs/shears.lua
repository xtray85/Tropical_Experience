local assets=
{
    Asset("ANIM", "anim/shears.zip"),
    Asset("ANIM", "anim/swap_shears.zip"),
    Asset("INV_IMAGE", "shears"),
}

local SHEARS_DAMAGE = 34 * .5
local SHEARS_USES = 20

local function onfinished(inst)
    inst:Remove()
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_shears", "swap_shears")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)
    
    anim:SetBank("shears")
    anim:SetBuild("shears")
    anim:PlayAnimation("idle")
	
    inst:AddTag("shears")	

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(SHEARS_DAMAGE)
    ---------------------------------------------------------------
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HACK, 3)
    ---------------------------------------------------------------
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(SHEARS_USES)
    inst.components.finiteuses:SetUses(SHEARS_USES)
    
    inst.components.finiteuses:SetOnFinished( onfinished )
    inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1)
    ---------------------------------------------------------------
    inst:AddComponent("equippable")
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    return inst
end


return Prefab( "common/inventory/shears", fn, assets) 