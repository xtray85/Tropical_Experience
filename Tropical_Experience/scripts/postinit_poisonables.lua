--[[
	Lootdropper Postinit

	Allows one to add and remove named functions that are called when a 
	loot item is spawned.
--]]
AddComponentPostInit("lootdropper", function(self, inst)
	self.loot_postinits = {}

	self.SetLootPostInit = function(_self, name, fn)
		if type(fn) == "function" then
			_self.loot_postinits[name] = fn
		end
	end

	self.RemoveLootPostInit = function(_self, name)
		_self.loot_postinits[name] = nil
	end

	self.old_SpawnLootPrefabVB = self.SpawnLootPrefab
	self.SpawnLootPrefab = function(_self, lootprefab, pt)
		local loot = _self.old_SpawnLootPrefabVB(_self, lootprefab, pt)
		if loot and _self.loot_postinits then
			for i,loot_postinit in ipairs(_self.loot_postinits) do
				loot = loot_postinit(_self, loot)
			end
		end
		return loot
		
		
		
		
		
		
	end
end)


HookInitPoisonable = function(player)
    if player.components.poisonable == nil then
		player:AddComponent("poisonable")
	end
end

AddPrefabPostInitAny(function(inst)
	-- Only fightable mobs can be poisonable
	if inst.components.combat and inst.components.poisonable == nil then
		inst:AddComponent("poisonable")
	end
end)