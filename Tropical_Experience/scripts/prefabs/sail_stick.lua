local assets = 
{
    Asset("ANIM", "anim/windstaff.zip"),
    Asset("ANIM", "anim/swap_windbr.zip"), 
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_windbr", "windstaff")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    inst.components.fueled:StartConsuming()
   inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_stick")
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    inst.components.fueled:StopConsuming()
end

local function onfinished(inst)
    inst:Remove()
end

local function staff_fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("windstaff")
    inst.AnimState:SetBuild("windstaff")
    inst.AnimState:PlayAnimation("windstaff")

    inst:AddTag("nopunch")
    inst:AddTag("sail_stick")	

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "USAGE"
    inst.components.fueled:InitializeFuelLevel(4800)
    inst.components.fueled:SetDepletedFn(onfinished)

    return inst
end

return Prefab("sail_stick", staff_fn, assets)