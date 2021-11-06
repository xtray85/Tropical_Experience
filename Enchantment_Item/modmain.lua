Assets = {
	Asset("ANIM", "anim/modifier_border.zip"),
	Asset( "ATLAS", "images/magic_duct_tape.xml"),
}

PrefabFiles = {
	"modifierfx",
	"bufffx",
	"cleaner",
	"orbfx",
}

local GLOBALVARS = {}
for k,v in pairs(GLOBAL) do
	table.insert(GLOBALVARS, k)
end

if GLOBAL.KnownModIndex:IsModEnabled("workshop-488009136") then--make bows use our custom damage multiplier
	local oldBowCalcFinalDamage = GLOBAL.ARCHERYFUNCS.CalcFinalDamage
	function GLOBAL.ARCHERYFUNCS.CalcFinalDamage(inst, attacker, target, applydodelta)
		local dmg = oldBowCalcFinalDamage(inst, attacker, target, applydodelta)
		local bow
		if attacker then
			bow = attacker.components.inventory.equipslots.hands
		end
		return dmg * (1 + (bow and bow.modifier_dmg or 0))
	end
end

modimport("modifiers/languagefix.lua")

modimport("modifiers/effects.lua")
modimport("modifiers/strings.lua")

AddReplicableComponent("modifier")
modimport("modifiers/components.lua")

modimport("modifiers/widgets.lua")

AddRecipe("mod_cleaner", 
        { Ingredient("houndstooth", 10), Ingredient("glommerfuel", 1) }, 
        GLOBAL.RECIPETABS.MAGIC, 
        GLOBAL.TECH.MAGIC_TWO,
        nil,nil,nil,nil,nil,
        "images/magic_duct_tape.xml", 
        "magic_duct_tape.tex"
    )

local actClean = AddAction("MOD_CLEAN", GLOBAL.STRINGS.ACTIONS.MOD_CLEAN, function(act)
	if act.invobject:HasTag("mod_disenchanter") and act.target:HasTag("modified") then
		act.invobject.components.modifier_cleaner:Clean(act.target, act.doer)

		if (not act.invobject:HasTag("modifier_repairer") and act.doer.prefab ~= "winona") and math.random() < 0.05 then
			act.target:Remove()--5% chance of actually losing your item
		end
	end
	return true
end)
actClean.mount_valid = true

AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions, right)
	if right and inst and inst:HasTag("mod_disenchanter") and target and target:HasTag("modified") then
		table.insert(actions, actClean)
	end
end)

local actDisassemble = AddAction("MOD_DISASSEMBLE", GLOBAL.STRINGS.ACTIONS.MOD_DISASSEMBLE, function(act)
	if not act or not act.doer or not act.invobject then
		return false
	end
	local recipe = GLOBAL.AllRecipes[act.invobject.prefab]
	if act.doer and act.doer:HasTag("player") and not act.doer:HasTag("playerghost") and recipe then
		local disassembler = act.doer.components.inventory.equipslots.head
		if not disassembler then
			return false
		end
		if disassembler:HasTag("modifier_mindtranscender") and act.invobject.components.modifier then
			local mod_item_rarity = act.invobject.components.modifier:GetRarity()
			if mod_item_rarity then
				local mod_drop = GLOBAL.SpawnPrefab("modifierfx")
				if mod_item_rarity == "bad" or mod_item_rarity == "worst" then
					mod_item_rarity = math.random() < 0.3 and "rare" or "good"
				end
				mod_drop.Transform:SetPosition(act.doer.Transform:GetWorldPosition())
				mod_drop:OnSpawn(act.doer, mod_item_rarity)
			end
		end
		if act.invobject.components.container then
			act.invobject.components.container:DropEverything()
		end
		local comp = act.invobject.components.finiteuses or act.invobject.components.armor or act.invobject.components.fueled or act.invobject.components.perishable or nil
		if comp then
			comp:SetPercent(0)
		end
		if act.invobject and act.invobject:IsValid() then
			act.invobject:Remove()
		end
		for e, ing in pairs(recipe.ingredients) do
			for amount = 1, ing.amount do
				act.doer.components.inventory:GiveItem(GLOBAL.SpawnPrefab(ing.type))
			end
		end
		local disassemblercomp = disassembler.components.finiteuses or disassembler.components.armor or disassembler.components.fueled or disassembler.components.perishable or nil
		if disassemblercomp then
			disassemblercomp:SetPercent(math.max(0, disassemblercomp:GetPercent() - (disassembler:HasTag("modifier_mindtranscender") and 0.1 or 0.25)))
		end

		return true
	end
end)
actDisassemble.mount_valid = true
actDisassemble.priority = 24

AddComponentAction("INVENTORY", "inventoryitem", function(inst, doer, actions)
	if inst and GLOBAL.AllRecipes[inst.prefab] and (not inst.replica.equippable or not inst.replica.equippable:IsEquipped()) and doer and doer.replica.inventory and (doer.replica.inventory:EquipHasTag("modifier_mindascender") or doer.replica.inventory:EquipHasTag("modifier_mindtranscender")) then
		table.insert(actions, actDisassemble)
	end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(actClean, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(actClean, "dolongaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(actDisassemble, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(actDisassemble, "dolongaction"))

if GLOBAL.GetTableSize(GLOBAL.LanguageTranslator.languages) >= 1 then
	for lang, data in pairs(GLOBAL.LanguageTranslator.languages) do
		if GLOBAL.softresolvefilepath(lang .. "_translation.po") then
			LoadPOFile(lang .. "_translation.po", lang)
		end
	end
end

local oldGetDescription = GLOBAL.GetDescription
function GLOBAL.GetDescription(inst, item, modifier)
	local desc = oldGetDescription(inst, item, modifier)
	if desc ~= nil and desc ~= "" and item:HasTag("modified") then
		desc = desc .. "\n" .. GLOBAL.STRINGS.MODIFIER_RARITIES[string.upper(item.replica.modifier:GetRarity() or "test")] ..": " .. GLOBAL.STRINGS.MODIFIERS[string.upper(item.replica.modifier:GetModifier() or "generic")].DESC
	end	
	return desc
end