local assets =
{
    Asset("ANIM", "anim/armor_weevole.zip"),
}

local prefabs =
{
	"weevole_carapace",
}

local wilson_health = 150
local ARMOR_WEEVOLE_DURABILITY = wilson_health*6
local ARMOR_WEEVOLE_ABSORPTION = .6

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_body", "armor_weevole", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()    
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("armor_weevole")
    inst.AnimState:SetBuild("armor_weevole")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("wood")
    inst:AddTag("vented")
--	inst:AddTag("aquatic")
	inst.foleysound = "dontstarve/movement/foley/logarmour"

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
    inst.components.armor:InitCondition(ARMOR_WEEVOLE_DURABILITY, ARMOR_WEEVOLE_ABSORPTION)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)
	
    return inst
end

return Prefab("armor_weevole", fn, assets)
