local obsidian_assets =
{
	Asset("ANIM", "anim/spear_obsidian.zip"),
	Asset("ANIM", "anim/swap_spear_obsidian.zip"),
}

local OBSIDIAN_WEAPON_MAXCHARGES = 30
local wilson_attack = 34
local OBSIDIANTOOLFACTOR = 2.5
local OBSIDIAN_SPEAR_DAMAGE = wilson_attack * 1.5

local function onequip(inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_spear_obsidian", inst.GUID, "swap_spear")
    else
        owner.AnimState:OverrideSymbol("swap_object", "swap_spear_obsidian", "swap_spear")
    end
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	

	inst.AnimState:SetBuild("spear_obsidian")
	inst.AnimState:SetBank("spear_obsidian")
	inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(OBSIDIAN_SPEAR_DAMAGE)
	inst.components.weapon.attackwear = 1 / OBSIDIANTOOLFACTOR
	
--	MakeObsidianTool(inst, "spear")
--	inst.components.obsidiantool.maxcharge = OBSIDIAN_WEAPON_MAXCHARGES
--    inst.components.obsidiantool.cooldowntime = 480 / OBSIDIAN_WEAPON_MAXCHARGES

    -------

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
    inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)

    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab( "spear_obsidian", fn, obsidian_assets)