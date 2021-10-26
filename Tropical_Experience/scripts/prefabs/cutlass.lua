local assets=
{
	Asset("ANIM", "anim/cutlass.zip"),
	Asset("ANIM", "anim/swap_cutlass.zip"),
}

local wilson_attack = 34
local	    CUTLASS_DAMAGE = wilson_attack*2
local	    CUTLASS_BONUS_DAMAGE = - wilson_attack*1
local	    CUTLASS_USES = 150


local function onfinished(inst)
    inst:Remove()
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_cutlass", "swap_cutlass")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function onattack(inst, attacker, target)
    if target.prefab == "twister" then
        target.components.health:DoDelta(CUTLASS_BONUS_DAMAGE)
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)
    
    anim:SetBank("cutlass")
    anim:SetBuild("cutlass")
    anim:PlayAnimation("idle")
    
    inst:AddTag("sharp")
    inst:AddTag("cutlass")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(CUTLASS_DAMAGE)
    inst.components.weapon:SetOnAttack(onattack)
    
    -------
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(CUTLASS_USES)
    inst.components.finiteuses:SetUses(CUTLASS_USES)
    
    inst.components.finiteuses:SetOnFinished( onfinished )

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
    return inst
end

return Prefab( "common/inventory/cutlass", fn, assets) 
