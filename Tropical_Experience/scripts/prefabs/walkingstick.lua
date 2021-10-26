local assets=
{
	Asset("ANIM", "anim/walking_stick.zip"),
	Asset("ANIM", "anim/swap_walking_stick.zip"),
    --Asset("INV_IMAGE", "cane"),
}

local function onfinished(inst)
    inst:Remove()
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_walking_stick", "swap_object")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	
    if inst.components.fueled ~= nil then
        inst.components.fueled:StartConsuming()
    end	
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
	
    if inst.components.fueled ~= nil then
        inst.components.fueled:StopConsuming()
    end	
end

local function onwornout(inst)
    inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()        
    MakeInventoryPhysics(inst)
    
    anim:SetBank("walking_stick")
    anim:SetBuild("walking_stick")
    anim:PlayAnimation("idle")
    
    MakeInventoryFloatable(inst)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(20.4)
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
    
    inst:AddComponent("equippable")
    
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    inst.components.equippable.walkspeedmult = 1.3

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.components.fueled:InitializeFuelLevel(480*3)
    inst.components.fueled:SetDepletedFn(onwornout)
    
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    return inst
end


return Prefab( "common/inventory/walkingstick", fn, assets) 

