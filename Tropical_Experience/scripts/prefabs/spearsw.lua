local assets =
{
	Asset("ANIM", "anim/spear.zip"),
	Asset("ANIM", "anim/swap_spear.zip"),
	Asset("ANIM", "anim/spear_poison.zip"),
	Asset("ANIM", "anim/swap_spear_poison.zip"),
	Asset("ANIM", "anim/spear_obsidian.zip"),
	Asset("ANIM", "anim/swap_spear_obsidian.zip"),
	Asset("ANIM", "anim/swap_cactus_spike.zip"),
	Asset("ANIM", "anim/cactus_spike.zip"),
	Asset("ANIM", "anim/swap_peg_leg.zip"),
	Asset("ANIM", "anim/peg_leg.zip"),
}

local PEG_LEG_DAMAGE = 34
local PEG_LEG_USES = 50
local NEEDLESPEAR_DAMAGE = 34/2
local NEEDLESPEAR_USES = 5
local OBSIDIAN_WEAPON_MAXCHARGES = 30
local wilson_attack = 34
local OBSIDIANTOOLFACTOR = 2.5
local OBSIDIAN_SPEAR_DAMAGE = wilson_attack * 1.5

local function onfinished(inst)
	inst:Remove()
end

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_spear", "swap_spear")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end

local function poisonattack(inst, attacker, target, projectile)
if target and target.components.poisonable == nil then
target:AddComponent("poisonable")
end

if	target and target:HasTag("player") then
local corpo = target.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
local cabeca = target.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
if corpo and corpo.prefab == "armor_seashell" then return end
if cabeca and cabeca.prefab == "oxhat" then return end
end	
	

target.components.poisonable:SetPoison(-4, 5, 120)

	if target.components.combat then
		target.components.combat:SuggestTarget(attacker)
	end
	-- this was commented out as the attack with the spear will do an attacked event. The poison itself doesn't need a second one pushed
	--target:PushEvent("attacked", {attacker = attacker, damage = 0, projectile = projectile})
end


local function basicfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
--	MakeInventoryFloatable(inst, "idle_water", "idle")

	inst.AnimState:SetBuild("spear")
	inst.AnimState:SetBank("spear")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("spear")	
	inst:AddTag("sharp")
    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.SPEAR_DAMAGE)

	inst:AddComponent("tradable")

	-------

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
	inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)

	inst.components.finiteuses:SetOnFinished( onfinished )

	inst:AddComponent("inspectable")

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )

	inst:AddComponent("inventoryitem")

	inst.speartype = "spear"

	return inst
end

local function onequippoison(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_spear_poison", "swap_spear")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function poisonfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
--	MakeInventoryFloatable(inst, "idle_water", "idle")

	inst.AnimState:SetBuild("spear_poison")
	inst.AnimState:SetBank("spear_poison")
	inst.AnimState:PlayAnimation("idle")	
	
	inst:AddTag("sharp")
	inst:AddTag("spear")
    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end	
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.SPEAR_DAMAGE)

	inst:AddComponent("tradable")

	-------

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
	inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)

	inst.components.finiteuses:SetOnFinished( onfinished )

	inst:AddComponent("inspectable")

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

	inst.components.weapon:SetOnAttack(poisonattack)
	inst.components.equippable:SetOnEquip(onequippoison)

	inst.speartype = "poison"

	return inst
end

local function onequipobsidian(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_spear_obsidian", "swap_spear")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onequipobsidian(inst, owner)
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

local function onunequipobsidian(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
 end  


local function obsidianfn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

	inst.AnimState:SetBuild("spear_obsidian")
	inst.AnimState:SetBank("spear_obsidian")
	inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("pointy")
    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(OBSIDIAN_SPEAR_DAMAGE)
	inst.components.weapon.attackwear = 1 / OBSIDIANTOOLFACTOR

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
    inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)

    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequipobsidian)
    inst.components.equippable:SetOnUnequip(onunequipobsidian)

    MakeHauntableLaunch(inst)

	return inst
end

local function onequipneedle(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_cactus_spike", "swap_cactus_spike")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function needlefn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
--	MakeInventoryFloatable(inst, "idle_water", "idle")

	inst.AnimState:SetBuild("cactus_spike")
	inst.AnimState:SetBank("cactus_spike")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("sharp")
    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.SPEAR_DAMAGE)

	inst:AddComponent("tradable")

	-------

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
	inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)

	inst.components.finiteuses:SetOnFinished( onfinished )

	inst:AddComponent("inspectable")

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
	inst.components.weapon:SetDamage(NEEDLESPEAR_DAMAGE)
	inst.components.finiteuses:SetMaxUses(NEEDLESPEAR_USES)
	inst.components.finiteuses:SetUses(NEEDLESPEAR_USES)

	inst.components.inventoryitem.imagename = "needlespear"

	inst.components.equippable:SetOnEquip( onequipneedle )

	return inst
end

local function onequippegleg(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_peg_leg", "swap_object")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function peglegfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
--	MakeInventoryFloatable(inst, "idle_water", "idle")	
	inst.AnimState:SetBuild("peg_leg")
	inst.AnimState:SetBank("peg_leg")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("sharp")
	inst:AddTag("pegleg")
    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end	
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.SPEAR_DAMAGE)

	inst:AddComponent("tradable")

	-------

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
	inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)

	inst.components.finiteuses:SetOnFinished( onfinished )

	inst:AddComponent("inspectable")

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )

	

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
	inst.components.equippable:SetOnEquip(onequippegleg)

	inst.components.weapon:SetDamage(PEG_LEG_DAMAGE)
	inst.components.finiteuses:SetMaxUses(PEG_LEG_USES)
	inst.components.finiteuses:SetUses(PEG_LEG_USES)

	return inst
end

return Prefab( "common/inventory/spear_poison", poisonfn, assets),
	   Prefab( "common/inventory/spear_obsidian", obsidianfn, assets),
	   Prefab( "common/inventory/needlespear", needlefn, assets),
	   Prefab( "common/inventory/peg_leg", peglegfn, assets)