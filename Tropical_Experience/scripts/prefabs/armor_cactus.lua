local assets =
{
	Asset("ANIM", "anim/armor_cactus.zip"),
}

local ARMORCACTUS = 34*3
local ARMORCACTUS_ABSORPTION = .8
local ARMORCACTUS_DMG = 34/2

local function OnBlocked(owner, data) 
	
	if (data.weapon == nil or (not data.weapon:HasTag("projectile") and data.weapon.projectile == nil))
		and data.attacker and data.attacker.components.combat and data.stimuli ~= "thorns" and not data.attacker:HasTag("thorny")
		and (data.attacker.components.combat == nil or (data.attacker.components.combat.defaultdamage > 0)) then
		
		data.attacker.components.combat:GetAttacked(owner, ARMORCACTUS_DMG, nil, "thorns")
		if owner.SoundEmitter ~= nil then
            owner.SoundEmitter:PlaySound("dontstarve_DLC002/common/armour/cactus")
        end
	end
end

local function onequip(inst, owner) 
	owner:AddTag("armaduradecacto")
	owner.AnimState:OverrideSymbol("swap_body", "armor_cactus", "swap_body")
	owner:AddTag("armorcactus")

    inst:ListenForEvent("blocked", inst._onblocked, owner)
    inst:ListenForEvent("attacked", inst._onblocked, owner)
end

local function onunequip(inst, owner) 
	owner:RemoveTag("armaduradecacto")
	owner.AnimState:ClearOverrideSymbol("swap_body")
	owner:RemoveTag("armorcactus")

    inst:RemoveEventCallback("blocked", inst._onblocked, owner)
    inst:RemoveEventCallback("attacked", inst._onblocked, owner)
end

local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	
	inst.entity:AddTransform()
	inst.entity:AddSoundEmitter()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
--	MakeInventoryFloatable(inst, "idle_water", "anim")

	inst.AnimState:SetBank("armor_cactus")
	inst.AnimState:SetBuild("armor_cactus")
	inst.AnimState:PlayAnimation("anim")
	
	inst.foleysound = "dontstarve_DLC002/common/foley/cactus_armour"

	MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
		
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(ARMORCACTUS, ARMORCACTUS_ABSORPTION)
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	-- inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED
	
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	
	MakeHauntableLaunch(inst)
	
	inst._onblocked = function(owner, data) OnBlocked(owner, data) end

	
	return inst
end

return Prefab( "common/inventory/armorcactus", fn, assets) 
