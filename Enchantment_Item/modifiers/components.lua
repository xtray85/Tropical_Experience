----------INIT FN----------
local function modifier_init(inst)--being called on equipped component and finiteuses (weapon and armor components should be hit by equipped attempt)
	if inst and inst.AnimState and inst.components.modifier == nil and inst.components.combat == nil and inst.components.stackable == nil and inst.components.heavyobstaclephysics == nil then
		inst:AddComponent("modifier")
		inst:DoTaskInTime(0, function()
			if inst.components.stackable or inst.components.combat or inst.components.heavyobstaclephysics or inst.components.teacher--[[ or not inst.components.inventoryitem]] then-- no no components
				inst:RemoveComponent("modifier")
				return
			end
			if GLOBAL.TheWorld.state.cycles == 0 and GLOBAL.TheWorld.state.time <= 0.01 and not inst.components.modifier:IsModified() and not inst:HasTag("INLIMBO") then--should trigger on world gen
				inst.components.modifier:GenerateFromTable({bad=25, good=63, rare=10, epic=2}) --on items generated by world, 
			end
		end)
	end
end

----------UTIL FNs----------
local function bound_no_equip(inst, item)
	if inst and inst.components.talker and item then
		inst.components.talker:Say("I can't equip that because my " .. item.name .. " is bound to me.")
	end
end

local function bound_no_unequip(inst, item)
	if inst and inst.components.talker and item then
		inst.components.talker:Say("I can't unequip that because it is bound to me.")
	end
end

local function lust_kill_tracker(inst, attacker, target)
	if inst and inst.modifier_kills then
		local newkill = 1
		if not target.brain and not inst.components.tool then--no brain, no gain, unless tool
			newkill = 0
		end
		if target:HasTag("smallcreature") then
			newkill = 0.5
		end
		if target:HasTag("largecreature") then
			newkill = 2
		end
		if target:HasTag("epic") then
			newkill = 3.5
		end
		inst.modifier_kills = math.min(inst.modifier_kills + newkill, 10)--capped at 10 kills, 10% repairing
		if inst.modifier_kills_task then--on new kill, reset timer
			inst.modifier_kills_task:Cancel()
			inst.modifier_kills_task = nil
		end
		inst.modifier_kills_task = inst:DoTaskInTime(15, function()--if no kills in 15, reset killcounter
			inst.modifier_kills = 0
		end)
	end
end

local function onbuilditem(builder, data)--give modifiers on craft
	if data.item.components.modifier and math.random() <= 0.4 then--40% chance of modifier
		local raritytable = { worst = 5, bad = 30, good = 60, rare = 5 }
		if builder:HasTag("lucky") and not builder:HasTag("unlucky") then--so far nothing in this mod gives these tags, but hopefully some other mods do
			raritytable = { bad = 25, good = 65, rare = 10 }
		end
		if builder:HasTag("unlucky") and not builder:HasTag("lucky") then
			raritytable = { worst = 10, bad = 60, good = 29, rare = 1}
		end
		if data.item.components.modifier_cleaner then
			raritytable = {worst = 30, bad = 40, epic = 30}
		end
		data.item.components.modifier:GenerateFromTable(raritytable)
	end
end

----------Action Modifications----------
local oldEquipfn = GLOBAL.ACTIONS.EQUIP.fn
GLOBAL.ACTIONS.EQUIP.fn = function(act)
	local slot = act.invobject and act.invobject.components.equippable and act.invobject.components.equippable.equipslot
	local currentInSlot = act.doer and act.doer.components.inventory and act.doer.components.inventory.equipslots[slot]
	return (currentInSlot == nil or not currentInSlot:HasTag("modifier_soulbound")) and oldEquipfn(act) or bound_no_equip(act.doer, currentInSlot)
end

local oldUnequipfn = GLOBAL.ACTIONS.UNEQUIP.fn
GLOBAL.ACTIONS.UNEQUIP.fn = function(act)
	local slot = act.invobject and act.invobject.components.equippable and act.invobject.components.equippable.equipslot
	local currentInSlot = act.doer and act.doer.components.inventory and act.doer.components.inventory.equipslots[slot]
	return (currentInSlot == nil or not currentInSlot:HasTag("modifier_soulbound")) and oldUnequipfn(act) or bound_no_unequip(act.doer, currentInSlot)
end

----------Component Modifications---------- You might ask, why not use existing features like weapon.attackwear, combat.reflect, etc? Well since these upgrade are dynamic, I don't want to possibly override item features

local function findLink(inst, picker)
	local slot = inst.components.equippable and inst.components.equippable.equipslot or nil
	inst:DoTaskInTime(0, function()
		if inst:HasTag("modifier_soulbound") then
			if inst.boundguy == nil or not inst.boundguy:IsValid() then
				inst.boundguy = picker
			end
			local foreigner = picker ~= inst.boundguy
			picker = inst.boundguy
			if foreigner then
				GLOBAL.SpawnPrefab("small_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
				picker.components.inventory:GiveItem(inst)
				GLOBAL.SpawnPrefab("small_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
			elseif picker.components.inventory and slot and (picker.components.inventory.equipslots[slot] == nil or not picker.components.inventory.equipslots[slot]:HasTag("modifier_soulbound")) and not inst.components.equippable:IsEquipped() then
				picker.components.inventory:Equip(inst)
			end
		end
	end)
end

AddComponentPostInit("equippable", function(self)
	modifier_init(self.inst)
	local oldEquip = self.Equip
	function self:Equip(owner)
		oldEquip(self, owner)
		if self.inst:HasTag("modifier_soulbound") then
			findLink(self.inst, owner)
		end
	end

	local oldUnequip = self.Unequip
	function self:Unequip(owner)
		oldUnequip(self, owner)
		if self.inst:HasTag("modifier_soulbound") then
			self.inst:DoTaskInTime(0.5, function()
				if owner and owner.components.inventory and owner.components.inventory.itemslots and not GLOBAL.table.contains(owner.components.inventory.itemslots, self.inst) then--and not GLOBAL.table.contains(owner.components.inventory.equipslots, self.inst)
					for each, item in pairs(owner.components.inventory.itemslots) do--if loyal item is unequipped(such as it breaking), search for other loyal items to latch onto you
						if item ~= self.inst and item:HasTag("modifier_soulbound") and (item.components.equippable and item.components.equippable.equipslot or nil) == (self.inst.components.equippable and self.inst.components.equippable.equipslot or nil) then
							owner.components.inventory:Equip(item)
							return
						end
					end
				end
			end)
		end
	end
end)

AddComponentPostInit("inventoryitem", function(self)
	local oldOnPickup = self.OnPickup
	function self:OnPickup(pickupguy, pickuppos)
		oldOnPickup(self, pickupguy, pickuppos)
		if self.inst:HasTag("modifier_soulbound") then
			findLink(self.inst, pickupguy)
		end
	end

	local oldOnDrop = self.OnDropped
	function self:OnDropped(randomdir, speedmult)
		oldOnDrop(self, randomdir, speedmult)
		if self.inst:HasTag("modifier_soulbound") and self.inst.boundguy and self.inst.components.equippable then
			if not self.inst.boundguy:IsValid() then self.inst.boundguy = nil return end
			self.inst:DoTaskInTime(1, function()
				if self.inst.boundguy:IsValid() and self.inst.boundguy.components.inventory then
					if not GLOBAL.table.contains(self.inst.boundguy.components.inventory.itemslots, self.inst) then
						GLOBAL.SpawnPrefab("small_puff").Transform:SetPosition(self.inst.Transform:GetWorldPosition())
						self.inst.boundguy.components.inventory:GiveItem(self.inst)
						GLOBAL.SpawnPrefab("small_puff").Transform:SetPosition(self.inst.Transform:GetWorldPosition())
					end
				else
					self.inst.boundguy = nil--we should only be able to get here if our buddy has disappeared in the last second
				end		
			end)		
		end
	end

	function self.inst.replica.inventoryitem:SetWalkSpeedMult(walkspeedmult)
		local x = 100
		if walkspeedmult ~= nil then
			x = tostring(x * walkspeedmult)
			x = GLOBAL.tonumber(x:sub(x:find("^%-?%d+")))
		end
		GLOBAL.assert(x >= -255 and x <= 255, "Walk speed multiplier out of range: "..tostring(walkspeedmult))
		GLOBAL.assert(walkspeedmult == nil or math.abs(walkspeedmult * 100 - x) < .01 , "Walk speed multiplier can only have up to .01 precision: "..tostring(walkspeedmult))
		self.inst.replica.inventoryitem.classified.walkspeedmult:set(x)
	end
end)

AddComponentPostInit("inventory", function(self)
	local oldTakeActiveItemFromEquipSlot = self.TakeActiveItemFromEquipSlot
	function self:TakeActiveItemFromEquipSlot(eslot)
		local item = self:GetEquippedItem(eslot)
		if not item or not item:HasTag("modifier_soulbound") then
			oldTakeActiveItemFromEquipSlot(self, eslot)
		else
			bound_no_unequip(self.owner, item)
		end
	end

	
	local oldSwapEquipWithActiveItem = self.SwapEquipWithActiveItem
	function self:SwapEquipWithActiveItem()
		local active_item = self:GetActiveItem()
		if active_item then
			local active_item_slot = active_item.components.equippable and active_item.components.equippable.equipslot
			local current_item_in_slot = self:GetEquippedItem(active_item_slot)
			if not current_item_in_slot:HasTag("modifier_soulbound") or active_item:HasTag("modifier_soulbound") then--we can swap with other loyals only
				oldSwapEquipWithActiveItem(self)
			else
				bound_no_unequip(self.owner, current_item_in_slot)
			end
		end
	end
end)

AddComponentPostInit("finiteuses", function(self)
	modifier_init(self.inst)
	local oldUse = self.Use
	function self:Use(num)
		num = num or 1--some items use nil which defaults to 1
		local newnum = (self.inst.components.modifier and self.inst.modifier_use) and self.inst.modifier_use * num or num
		oldUse(self, newnum)
	end
end)

AddComponentPostInit("armor", function(self) 
	local oldTakeDamage = self.TakeDamage
	function self:TakeDamage(damage_amount)
		damage_amount = damage_amount or 0--just incase
		if self.inst and self.inst.components.modifier and self.inst.modifier_armor_fns and type(self.inst.modifier_armor_fns) == "table" then
			for _each, mod_fn in pairs(self.inst.modifier_armor_fns) do
				mod_fn(self.inst.components.inventoryitem.owner or nil, self.inst)
			end
		end
		local newdamage_amount = (self.inst.components.modifier and self.inst.modifier_use) and self.inst.modifier_use * damage_amount or damage_amount
		oldTakeDamage(self, newdamage_amount)
	end
end)

AddComponentPostInit("lootdropper", function(self)
	local oldSpawnLoot = self.SpawnLootPrefab
	function self:SpawnLootPrefab(lootprefab, pt)
		local loot = oldSpawnLoot(self, lootprefab, pt)
		if loot and loot.components.modifier and not self.inst:HasTag("modifier_boss") and math.random() < 0.25 then--25% of getting a modifier (check if we didnt drop a modifierprefab)
			if self.inst:HasTag("epic") then
				loot.components.modifier:GenerateFromTable({good = 80, rare = 12, epic = 5, legendary = 3})
			else
				loot.components.modifier:GenerateFromTable({good = 65, bad = 30, rare = 5})
			end
		end
		return loot
	end
end)

AddComponentPostInit("combat", function(self)
	local oldDoAttack = self.DoAttack
	function self:DoAttack(target_override, weapon, projectile, stimuli, instancemult)
		local targ = target_override or self.target
		local wep = weapon or self:GetWeapon()
		if wep and wep:HasTag("modifier_ghoststrike_oncooldown") then return end--if on cooldown, stop

		if wep and wep.components.modifier and wep.modifier_dmg then
			instancemult = (instancemult or 1) + wep.modifier_dmg			
		end
		oldDoAttack(self, target_override, weapon, projectile, stimuli, instancemult)
		if targ and wep and wep.components.modifier and wep.modifier_wep_fns and type(wep.modifier_wep_fns) == "table" then
			for _each, mod_fn in pairs(wep.modifier_wep_fns) do
				mod_fn(self.inst, wep, targ)
			end
		end
		if targ and targ.components.health and targ.components.health:IsDead() and self.inst.components.inventory and wep and wep:HasTag("modifier_bloodlust") then
			lust_kill_tracker(wep, self.inst, targ)
		end
	end

	local oldGetAttacked = self.GetAttacked
	function self:GetAttacked(attacker, damage, weapon, stimuli)
		if self.inst.components.inventory and self.inst.components.inventory.equipslots and damage and damage > 0 then --no inventory = no effects, stop here
			local totalresist = 0
			for each, equipped in pairs(self.inst.components.inventory.equipslots) do
				if equipped and equipped.components.modifier and equipped.components.modifier.mod_name and equipped.modifier_resist then
					totalresist = totalresist + equipped.modifier_resist
				end
			end
			local olddamage = damage
			damage = math.max(damage * (1-totalresist), 0)--min capped at 0, to make sure we dont manage to heal from attacks instead
			if totalresist > 0 then--hack to still damage armor by the damage mitigated
				self.inst.components.inventory:ApplyDamage(olddamage - damage, attacker, weapon)
			end
		end
		local result = oldGetAttacked(self, attacker, damage, weapon, stimuli)
		if result and self.inst.components.inventory and self.inst.components.inventory.equipslots and attacker then --no inventory = no effects, stop here
			for each, equipped in pairs(self.inst.components.inventory.equipslots) do
				if equipped and equipped.modifier_reflect_fns and type(equipped.modifier_reflect_fns) == "table" then
					for _each, mod_fn in pairs(equipped.modifier_reflect_fns) do
						mod_fn(self.inst, equipped, attacker, {damage = damage, weapon = weapon, stimuli = stimuli})
					end
				end
			end
		end
		return result
	end
	--[[local oldGetAttackRange = self.GetAttackRange
	function self:GetAttackRange()
		local weapon = self:GetWeapon()
		print("component:GetAttackRange", weapon, weapon and weapon:HasTag("modifier_ghoststrike") or nil)
		print(oldGetAttackRange(self), (oldGetAttackRange(self) or 0) + ((weapon and weapon:HasTag("modifier_ghoststrike")) and 10 or 0))
		return (oldGetAttackRange(self) or 0) + ((weapon and weapon:HasTag("modifier_ghoststrike")) and 10 or 0)
	end

	self.inst.replica.combat.oldGetAttackRangeWithWeapon = self.inst.replica.combat.GetAttackRangeWithWeapon
	function self.inst.replica.combat:GetAttackRangeWithWeapon()
		local weapon = self:GetWeapon()
		print("replica:GetAttackRangeWithWeapon", weapon, weapon and weapon:HasTag("modifier_ghoststrike") or nil)
		print(self.inst.replica.combat:oldGetAttackRangeWithWeapon() or 0, (self.inst.replica.combat:oldGetAttackRangeWithWeapon() or 0) + (((self.inst.components == nil or self.inst.components.combat == nil) and weapon and weapon:HasTag("modifier_ghoststrike")) and 10 or 0))
		return (self.inst.replica.combat:oldGetAttackRangeWithWeapon() or 0) + (((self.inst.components == nil or self.inst.components.combat == nil) and weapon and weapon:HasTag("modifier_ghoststrike")) and 10 or 0)
	end]]
end)

AddComponentPostInit("playeractionpicker", function(self)
	local oldDoGetMouseActions = self.DoGetMouseActions
	function self:DoGetMouseActions(position, target)--when using mouse to attack
		local lmb, rmb = oldDoGetMouseActions(self, position, target)
		target = target or GLOBAL.TheInput:GetWorldEntityUnderMouse()
		local wep = self.inst.replica.combat and self.inst.replica.combat:GetWeapon()
		if lmb and lmb.action.id == "ATTACK" and target and wep and wep:HasTag("modifier_ghoststrike_oncooldown") then
			lmb = rmb
			rmb = nil
		end
		return lmb, rmb
	end
end)

AddComponentPostInit("playercontroller", function(self)
	local oldGetAttackTarget = self.GetAttackTarget
	function self:GetAttackTarget(force_attack, force_target, isretarget)--when using F to attack
		local target = oldGetAttackTarget(self, force_attack, force_target, isretarget)
		if target then
			local wep = self.inst.replica.combat and self.inst.replica.combat:GetWeapon()
			if wep and target and wep:HasTag("modifier_ghoststrike_oncooldown") then
				return nil
			end
		end
		return target
	end
end)

AddComponentPostInit("workable", function(self)
	local oldWorkedBy = self.WorkedBy
	function self:WorkedBy(worker, numworks)
		local tool = nil
		if worker and not worker.components.worker and worker.components.inventory and worker.components.inventory.equipslots.hands and self.action then
			local hands = worker.components.inventory.equipslots.hands
			if hands.components.tool and hands.components.tool.actions[self.action] ~= nil and hands:HasTag("modified") then
				tool = hands
			end
		end
		oldWorkedBy(self, worker, numworks)
		if tool and tool:HasTag("modifier_resourcelust") then
			if tool.modifier_tool_fns and type(tool.modifier_tool_fns) == "table" then
				for _each, mod_fn in pairs(tool.modifier_tool_fns) do
					mod_fn(worker, tool, self.inst, self.action)
				end
			end
			if self.workleft == 0 then
				lust_kill_tracker(tool, worker, self.inst)
			end
		end
	end
end)

local function onConsumeChange(inst, toggle)
	if inst.modifier_consuming_fns and type(inst.modifier_consuming_fns) == "table" then
		for _each, mod_fn in pairs(inst.modifier_consuming_fns) do
			mod_fn(inst, toggle)
		end
	end
end

AddComponentPostInit("fueled", function(self)
	modifier_init(self.inst)
	local oldStartConsume = self.StartConsuming
	function self:StartConsuming()
		oldStartConsume(self)
		onConsumeChange(self.inst, true)
	end

	local oldStopConsume = self.StopConsuming
	function self:StopConsuming()
		oldStopConsume(self)
		onConsumeChange(self.inst, false)
	end

	local oldDoDelta = self.DoDelta
	function self:DoDelta(amount)
		if self.inst:HasTag("modified") and self.inst.modifier_use and amount < 0 then
			amount = -(-amount * self.inst.modifier_use)
		end
		oldDoDelta(self, amount)
	end
end)

AddComponentPostInit("instrument", function(self)
	local oldPlay = self.Play
	function self:Play(musician)
		if self.inst.modifier_instrument_fns and type(self.inst.modifier_instrument_fns) == "table" then
			for _each, mod_fn in pairs(self.inst.modifier_instrument_fns) do
				mod_fn(self.inst, musician)
			end
		end
		return oldPlay(self, musician)
	end
end)

AddComponentPostInit("projectile", function(self)
	local oldThrow = self.Throw
	function self:Throw(owner, target, attacker)
		if self.inst.modifier_throw_fns and type(self.inst.modifier_throw_fns) == "table" then
			for _each, mod_fn in pairs(self.inst.modifier_throw_fns) do
				mod_fn(self.inst, owner, target)
			end
		end
		return oldThrow(self, owner, target, attacker)
	end

	local oldStop = self.Stop
	function self:Stop()
		if self.inst.modifier_catch_fns and type(self.inst.modifier_catch_fns) == "table" then
			for _each, mod_fn in pairs(self.inst.modifier_catch_fns) do
				mod_fn(self.inst, self.owner)
			end
		end
		return oldStop(self)
	end
end)


function GLOBAL.TitleCase(str)
    if str == nil then return "" end
    local first = string.upper(string.sub(str, 1, 1))
    local rest = string.sub(str, 2)
    return first .. rest
end

local test_rarities = { "worst", "bad", "good", "rare", "epic", "legendary", "mythic", "test" }

local function debug_reroll(inst, slot, mod_data)
	local item = nil
	if type(slot) == "string" then
		if slot == "all" then
			for k,v in pairs(inst.components.inventory.itemslots) do
				if v.components.modifier then
					debug_reroll(inst, k, mod_data)
				end
			end
			for k,v in pairs(inst.components.inventory.equipslots) do
				if v.components.modifier then
					debug_reroll(inst, k, mod_data)
				end
			end
			return
		end
		item = inst.components.inventory.equipslots[slot]
	end
	if type(slot) == "number" then
		item = inst.components.inventory.itemslots[slot]
	end

	if item == nil then return end

	if mod_data then
		if GLOBAL.table.contains(test_rarities, mod_data) then
			item.components.modifier:GenerateType(mod_data)
			return
		else
			item.components.modifier:GenerateSpecific(mod_data)
			return
		end
	end

	item.components.modifier:Generate()
end

local function onBossDeath(inst)
	if inst and inst:HasTag("modifier_boss") and inst.rarity and inst.components.combat then
		local lootreceiver = nil
		local x,y,z = inst.Transform:GetWorldPosition()

		if inst.components.combat.target then
			if inst.components.combat.target:HasTag("player") or inst.components.combat.target:HasTag("playerghost") then
				lootreceiver = inst.components.combat.target
			elseif inst.components.combat.target.components.follower then
				local leader = inst.components.combat.target.components.follower:GetLeader()
				if leader and (leader:HasTag("player") or leader:HasTag("playerghost")) then
					lootreceiver = leader
				end
			end
		else
			lootreceiver = GLOBAL.FindClosestPlayerInRange(x, y, z, 12, nil)
		end

		local players = {}

		if inst.rarity == "mythic" then--mythics can drop for anyone nearby
			players = TheSim:FindEntities(x, y, z, 12, {"player"})
		end

		if lootreceiver and not GLOBAL.table.contains(players, lootreceiver) then
			table.insert(players, lootreceiver)
		end

		for e,player in pairs(players) do
			if (lootreceiver and player == lootreceiver) or math.random() < 0.3 then--killer gets guaranteed drop, others get 30% chance
				local mod_drop = GLOBAL.SpawnPrefab("modifierfx")
				mod_drop.Transform:SetPosition(x,y,z)
				mod_drop:OnSpawn(player, inst.rarity)
			end
		end
	end
end

function GLOBAL.SpawnBoss(inst, rarity)
	if rarity == nil then return end
	inst:AddTag("modifier_boss")
	inst.rarity = rarity
	if not inst.components.named then
		inst:AddComponent("named")
	end
	inst.components.named:SetName("Boss " .. inst.name)
	print("generated boss of rarity ".. rarity, inst)
	inst:ListenForEvent("death", function() 
		inst.announced = true 
		local challenger = inst.components.combat.target and " by " .. inst.components.combat.target.name or ""
		GLOBAL.TheNet:Announce("A " .. inst.name .. " has been defeated".. challenger .. "!")
	end)
	inst:ListenForEvent("onremove", function()
		if not inst.announced then 
			GLOBAL.TheNet:Announce("A " .. inst.name .. " has despawned!")
		end
	end)
	local scale = inst.prefab == "deerclops" and 2 or 1.6
	inst.Transform:SetScale(scale, scale, scale)
	if inst.prefab == "beefalo" then
		inst:ListenForEvent("saddlechanged", function()
			inst.Transform:SetScale(scale, scale, scale)
		end)
		inst:ListenForEvent("riderchanged", function(beef, data)
			if data.newrider then
				data.newrider.Transform:SetScale(scale, scale, scale)
				if data.newrider.prefab == "wolfgang" then
					if data.newrider.oldscale == nil then
						data.newrider.oldscale = data.newrider.Transform:GetScale()
					end
					beef.components.rideable:Buck()--wolfgang has scale changing feature with hunger, which messes with the beefalo's scale, so buck off wolfgang
					data.newrider.components.talker:Say("Beefalo too Mighty for Mighty Wolfgang!")
					return
				end
			else
				if data.oldrider then
					local prevscale = data.oldrider.oldscale or 1
					data.oldrider.Transform:SetScale(prevscale, prevscale, prevscale)
					data.oldrider.oldscale = nil
				end
			end
		end)
	end
	inst.components.combat:SetDefaultDamage(inst.components.combat.defaultdamage)--100% more damage
	inst.components.health:SetMaxHealth(inst.components.health.maxhealth * 1.5)--50% more health
	inst.components.combat:SetRange(inst.components.combat.attackrange, inst.components.combat.hitrange)
	inst:ListenForEvent("death", onBossDeath)
	if not inst:HasTag("epic") then
		inst.components.combat:SetAttackPeriod(inst.components.combat.min_attack_period)
		inst:DoPeriodicTask(10, function() 
			if inst.components.combat.target and inst.components.combat.target.components.locomotor then
				if inst.components.combat.target.unslowtask then
					inst.components.combat.target.unslowtask:Cancel()
					inst.components.combat.target.unslowtask = nil
				end
				--inst.components.combat.target:SpawnChild("buff_fx"):anim("negative", { build = "buff_fx", symbol = "speed"})
				--TODO убрать дебаф
				--if inst.components.combat.target.components.locomotor:GetExternalSpeedMultiplier(inst, "bossdebuff") == 1 then
				--	inst.components.combat.target.components.locomotor:SetExternalSpeedMultiplier(inst, "bossdebuff", 0.5)
				--end
				
				--inst.components.combat.target.unslowtask = inst.components.combat.target:DoTaskInTime(12, function(target) 
				--	target.components.locomotor:RemoveExternalSpeedMultiplier(inst, "bossdebuff")
				--end)
			end
		end)
	end
end

local function PickBossType(inst, msg)
	local bosstype = {}
	if inst:HasTag("smallcreature") or inst:HasTag("flying") then
		bosstype["good"] = 0.1
	end
	if (inst:HasTag("monster") or inst:HasTag("hostile")) and not inst:HasTag("flying") and not inst:HasTag("smallcreature") then
		bosstype["rare"] = 0.1
	end
	if (inst:HasTag("cavedweller") or inst:HasTag("largecreature")) and not inst:HasTag("flying") and not inst:HasTag("smallcreature") then
		bosstype["epic"] = 0.2
	end
	if inst:HasTag("largecreature") then
		bosstype["legendary"] = 0.35
	end
	if inst:HasTag("epic") and not inst:HasTag("tree") then
		bosstype["mythic"] = 0.5
	end
	local sortedrarities = {"mythic", "legendary", "epic", "rare", "good"}
	for k,v in pairs(sortedrarities) do
		if bosstype[v] and math.random() < bosstype[v] then
			GLOBAL.SpawnBoss(inst, v)
			GLOBAL.TheNet:Announce("A " .. inst.name .. " has " .. msg .. " (" .. v ..") !")
			return true
		end
	end
	return false
end

local function TrySpawnBoss(inst, extra)--this gets triggered on new phase, new cycle and new season. So x1 on phase, x2 on new day, x4 on new season day
	if not inst.ismastersim then
		return
	end
	local chance = 0.01
	local bosses = 1
	if extra == "winter" or extra == "summer" or extra == "spring" or extra == "autumn" then
		chance = 0.025
		bosses = 2
	end

	local eligbleEnts = {}
	for e, ent in pairs(GLOBAL.Ents) do
		if ent and ent:IsValid() and ent.components.combat and ent.components.combat.defaultdamage ~= 0 and not ent:HasTag("modifier_boss") and not ent:HasTag("player") and not ent:HasTag("INLIMBO") and ent.components.locomotor then
			eligbleEnts[e] = ent
		end
	end

	if GLOBAL.GetTableSize(GLOBAL.AllPlayers) > 2 then
		chance = chance * math.min(GLOBAL.GetTableSize(GLOBAL.AllPlayers)/2, 10)
	end
	for x = 1, bosses do
		if GLOBAL.GetTableSize(eligbleEnts) > 0 and math.random() < chance then--1% chance
			local attempts = 1
			while(attempts < 10) do
				local chosenEnt = GLOBAL.GetRandomItem(eligbleEnts)
				if chosenEnt and chosenEnt:IsValid() and chosenEnt.components.health and not chosenEnt.components.health:IsDead() then
					if PickBossType(chosenEnt, "emerged") then
						break
					end
				end
				attempts = attempts + 1
			end
		end
	end
end

AddPrefabPostInit("world", function(inst)
	if not inst.ismastersim then
		return inst
	end
	inst:WatchWorldState("phase", TrySpawnBoss)
	inst:WatchWorldState("cycles", TrySpawnBoss)
	inst:WatchWorldState("season", TrySpawnBoss)
	return inst
end)

AddPrefabPostInitAny(function(inst)
	if not GLOBAL.TheWorld.ismastersim then 
		return inst 
	end

	if inst:HasTag("player") then
		inst:ListenForEvent("builditem", onbuilditem)
		if inst.prefab == "winona" then
			inst:AddTag("lucky")
		end
		inst:DoTaskInTime(1, function()
			inst.reroll = debug_reroll--debug tool
		end)

		return inst
	end

	if inst.sg and inst.components.combat and inst.components.combat.defaultdamage ~= 0 and inst.components.health then
		if ((GLOBAL.TheWorld.state.cycles == 0 and GLOBAL.TheWorld.state.time < 0.01) or GLOBAL.TheWorld:GetTimeAlive() > 5) and math.random() <= 0.075 or (inst:HasTag("epic") and math.random() <= 0.1) then--0.75% chance/ epic 10% chance
			PickBossType(inst, "spawned")
		end
		inst.oldOnSave = inst.OnSave
		inst.oldOnLoad = inst.OnLoad
		inst.OnSave = function(inst, data)
			if inst.rarity then 
				data.bossrarity = inst.rarity 
			end
			if inst.oldOnSave then
				inst:oldOnSave(data) 
			end
		end
		inst.OnLoad = function(inst, data) 
			inst:DoTaskInTime(0, function()
				GLOBAL.SpawnBoss(inst, data and data.bossrarity or nil) 
			end)
			if inst.oldOnLoad then
				inst:oldOnLoad(data) 
			end
		end
	end
	return inst
end)