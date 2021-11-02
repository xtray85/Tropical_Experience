----------Effect Functions----------
local function effect_fiery(inst, weapon, target)
	if math.random() < 0.5 then return end--only 50% chance of burning
	if target.components.burnable then
        target.components.burnable:Ignite(false, inst)
    end
    if target.components.freezable then
        target.components.freezable:Unfreeze()
    end
end

local function effect_icey(inst, weapon, target, extra)
	if math.random() < 0.5 then return end--only 50% chance of freezing
	if target.components.burnable then
		target.components.burnable:Extinguish()
		target.components.burnable:StopSmoldering()
	end
	if target.components.freezable then
        target.components.freezable:AddColdness(extra or 0.75)
        target.components.freezable:SpawnShatterFX()
	end
end

local function effect_bloodlust(inst, weapon, target)
	if weapon.components.finiteuses and weapon.modifier_kills and math.random() < 0.15 then--only 15% chance of selfrepairing
		if target.brain then
			if weapon.modifier_kills > 10 and weapon.components.talker then
				weapon.components.talker:Say("Yes! More Blood!")
			end
			local newpercent = weapon.components.finiteuses:GetPercent() + (0.01 * weapon.modifier_kills)--1% * killcount
			newpercent = math.min(newpercent, 1)--cap it at 100%
			weapon.components.finiteuses:SetPercent(newpercent)
			inst:SpawnChild("buff_fx"):anim("positive", { build = "buff_fx", symbol = "repair"})
		end
	end
end

local function effect_resourcelust(inst, tool, target, action)
	if tool.components.finiteuses and tool.modifier_kills and math.random() < 0.15 then--only 15% chance of selfrepairing
		if tool.modifier_kills > 0 then
			if tool.modifier_kills == 10 and tool.components.talker and math.random() < 0.1 then
				tool.components.talker:Say("Yes! More destruction!")
			end
			local newpercent = tool.components.finiteuses:GetPercent() + (0.01 * tool.modifier_kills)--1% * killcount
			newpercent = math.min(newpercent, 1)--cap it at 100%
			tool.components.finiteuses:SetPercent(newpercent)
			inst:SpawnChild("buff_fx"):anim("positive", { build = "buff_fx", symbol = "repair"})
		end
	end
end

local function effect_lifesteal(inst, weapon, target)
	if math.random() < 0.25 then return end--only 25% chance of lifestealing
	local stealpercent = 0.03
	if not target.brain then--no brain, no gain
		stealpercent = 0
	end
	if target:HasTag("largecreature") then
		stealpercent = 0.06
	end
	if target:HasTag("epic") then
		stealpercent = 0.12
	end

	if stealpercent > 0 then
		local stolenlife = stealpercent * (inst.components.health:GetMaxWithPenalty() - inst.components.health.currenthealth)--we heal a % of missing health, not max health
		inst.components.health:DoDelta(stolenlife, nil, weapon)
		inst:SpawnChild("buff_fx")
	end
end

local function walkable_tile(tile)
	if tile == nil or tile == GROUND.IMPASSABLE or tile == GROUND.INVALID or (tile >= GROUND.OCEAN_START and tile <= GROUND.OCEAN_END ) then
		return false
	end

	return true
end


local function effect_telesick(inst, modifiedItem, nilORtarget, bypass)
	if inst == nil then return end
	if not bypass and math.random() > 0.3 then return end--70% chance of telepoofing
	local x,y,z = inst.Transform:GetWorldPosition()
	local count = 0
	local nx = x
	local nz = z
	local tileAtLoc = 1
	while(walkable_tile(tileAtLoc) == false) do--the count is used in rare cases where there is no ground to find nearby
		nx = x + math.random(-50 - count, 50 + count)--raising the random position area by 1 each iteration
		nz = z + math.random(-50 - count, 50 + count)
		tileAtLoc = GLOBAL.TheWorld.Map:GetTileAtPoint(nx,y,nz)
		count = count + 1
	end

	GLOBAL.SpawnPrefab("small_puff").Transform:SetPosition(x, y+0.1, z)
	inst.Transform:SetPosition(nx, y, nz)--fx at old and new locations
	GLOBAL.SpawnPrefab("small_puff").Transform:SetPosition(nx, y+0.1, nz)
end

local function effect_thorns(inst, item, attacker, data)--{damage, attacker.weapon, stimuli}
	if attacker and attacker.components.combat and attacker.components.health and not attacker.components.health:IsDead() then
		local extramult = 0
		if item.components.armor then
			extramult = extramult + (item.components.armor.absorb_percent/10)
		end
		local reflectdamage = data.damage * (0.1 + extramult)--10-20% of damage(better armor, higher reflect)
		attacker.components.combat:GetAttacked(attacker, reflectdamage, item)
	end
end

local function effect_thorns_fiery(inst, item, attacker, data)--{damage, attacker.weapon, stimuli}
	if attacker and attacker.components.health and not attacker.components.health:IsDead() then
		effect_fiery(inst, item, attacker)
		if math.random() > 0.75 then--also has 25% chance of burning the user
			effect_fiery(inst, item, inst)
		end
	end
end

local function effect_thorns_icey(inst, item, attacker, data)--{damage, attacker.weapon, stimuli}
	if attacker and attacker.components.health and not attacker.components.health:IsDead() then
		effect_icey(inst, item, attacker, 1.5)
		if math.random() > 0.75 then--also has 25% chance of cooling the user
			effect_icey(inst, item, inst)
		end
	end
end

local function effect_solar(item, toggled_on)
	if not toggled_on then--toggled off
		if item.solartask ~= nil then
			item.solartask:Cancel()
			item.solartask = nil
		end
		item.solartask = item:DoPeriodicTask(15, function()
			if (GLOBAL.TheWorld.state.isday or GLOBAL.TheWorld.state.isfullmoon) and not item:HasTag("INLIMBO") and item.components.fueled.maxfuel > item.components.fueled.currentfuel then
				local delta = (GLOBAL.TheWorld.state.isfullmoon and 0.03 or 0.01) * item.components.fueled.maxfuel--4% a min at day, 12% a min during fullmoon
				item.components.fueled:DoDelta(delta)
				item:SpawnChild("buff_fx"):anim("positive", { build = "buff_fx", symbol = "sun"})
			end
		end)
	else--toggled on
		if item.solartask ~= nil then
			item.solartask:Cancel()
			item.solartask = nil
		end
	end
end

function GLOBAL.GetBearing(p1, p2)--target, watcher
    local dx = (p1.x or p1[1]) - (p2.x or p2[1])
    local dy = (p1.y or p1[2]) - (p2.y or p2[2])
    local dz = (p1.z or p1[3]) - (p2.z or p2[3])
    local dist = dx*dx+dy*dy+dz*dz
	
	local angle = 360 - (math.atan(dz/dx) * 180 / math.pi)
	if p1.x < p2.x then
		return angle 
	else
		return angle - 180
	end
end

local function effect_ghoststrike(inst, weapon, target)
	if target == nil or weapon == nil or inst == nil or (inst.components.health and inst.components.health:IsDead()) then return end
	local ghost = GLOBAL.SpawnPrefab(inst.prefab)
	ghost:AddTag("FX")
	ghost:AddTag("NOCLICK")
	ghost:AddTag("notarget")

	weapon:AddTag("modifier_ghoststrike_oncooldown")
	weapon:DoTaskInTime(2.5, function() 
		if weapon and weapon:IsValid() then 
			weapon:RemoveTag("modifier_ghoststrike_oncooldown") 
		end 
	end)

	GLOBAL.RemovePhysicsColliders(ghost)

	ghost.AnimState:SetMultColour(0.4, 0.4, 0.4, 0.4)--ghostly

	for k,v in pairs(inst.components.skinner and inst.components.skinner:GetClothing() or {}) do
		ghost.components.skinner:SetClothing(v)--skins
	end
	for k,v in pairs(inst.components.inventory and inst.components.inventory.equipslots or {}) do
		ghost.components.inventory:Equip(GLOBAL.SpawnPrefab(v.prefab))--equipment
	end
	local tx, ty, tz = target.Transform:GetWorldPosition()
	ghost.Transform:SetPosition(tx + math.random(-1, 1), ty, tz + math.random(-1,1))
	ghost.Transform:SetRotation(GLOBAL.GetBearing(ghost:GetPosition(), target:GetPosition()))--(inst.Transform:GetRotation() - 180)
	ghost:DoTaskInTime(0, function() 
		ghost.AnimState:PlayAnimation("atk")
		ghost:ListenForEvent("animover", function() 
			GLOBAL.SpawnPrefab("small_puff").Transform:SetPosition(ghost.Transform:GetWorldPosition())--y+0.1?
			ghost:Remove()
		end)
	end)
end


local function play_song(inst, musician, song)
	local x, y, z = musician.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, inst.components.instrument.range, song.audience, song.haters)
	for guid, listener in ipairs(ents) do
		if not song.sucks or GLOBAL.TheNet:GetPVPEnabled() or not listener:HasTag("player") then--make sure to not help enemy players in pvp
			if not song.periodic or song.periodic == 0 then
				song.fn(inst)
			else	
				if listener[song.name .. "_pt"] == nil then--if nil, start ticking the task, if not, keep ticking
					listener[song.name .. "_pt"] = listener:DoPeriodicTask(song.periodic or 1, song.fn)
				end

				if listener[song.name .. "_et"] then--if regen song end timer already exists, remove it, so we can re-set it below
					listener[song.name .. "_et"]:Cancel()
					listener[song.name .. "_et"] = nil
				end

				listener[song.name .. "_et"] = listener:DoTaskInTime(song.duration or 10, function()--set 
					listener[song.name .. "_pt"]:Cancel()
					listener[song.name .. "_pt"] = nil
					listener[song.name .. "_et"]:Cancel()
					listener[song.name .. "_et"] = nil
				end)
			end
		end
	end
end

local function effect_regensong(inst, musician)
	local song = {
		name ="regensong",
		periodic = 2.5,
		duration = 25,
		audience = { "player" },
		haters = { "INLIMBO" },
		--sucks = false --sucks should only be true for harmful songs
		fn = function(listener)
			if listener:IsValid() and listener.components.health and not listener.components.health:IsDead() then
				listener.components.health:DoDelta(2.5)--2.5hp per 2.5s for 25s aka (10ticks x 2.5hp = 25hp)
				listener:SpawnChild("buff_fx")
				--fx:anim("positive", { build = "health", symbol = "heart"}) -- these are the defaults already
			end
		end
	}
	play_song(inst, musician, song)
end

local function effect_sanitysong(inst, musician)
	local song = {
		name ="sanitysong",
		periodic = 2.5,
		duration = 25,
		audience = { "player" },
		haters = { "INLIMBO" },
		--sucks = false --sucks should only be true for debuff/negative songs
		fn = function(listener)
			if listener:IsValid() and listener.components.sanity then
				listener.components.sanity:DoDelta(2.5)--2.5sanity per 2.5s for 25s aka (10ticks x 2.5hp = 25sanity)
				listener:SpawnChild("buff_fx"):anim("positive", { build = "sanity", symbol = "brain"})
			end
		end
	}
	play_song(inst, musician, song)
end

local function effect_revivalsong(inst, musician)
	local song = {
		name ="revivalsong",
		periodic = 0,
		duration = 0,
		audience = { "playerghost" },
		fn = function(listener)
			if listener and listener.components.health then
				listener:PushEvent("respawnfromghost", { source = { name="Song of Revival", components = {} } })
			end
		end
	}
	play_song(inst, musician, song)
end

local function effect_tauntsong(inst, musician)
	local song = {
		name ="tauntsong",
		periodic = 2.5,
		duration = 10,
		audience = { "_combat" },
		haters = { "INLIMBO", "playerghost", "shadowcreature"},
		sucks = true,
		fn = function(listener)
			if listener and listener.components.health and listener.components.combat and (listener.components.follower == nil or listener.components.follower.leader ~= musician) and listener.components.combat.defaultdamage ~= 0 then
				--listener.components.combat:SuggestTarget(musician)
				listener.components.combat:GetAttacked(musician, 2.5)
			end
		end
	}
	play_song(inst, musician, song)
end

local function effect_collisionproj_throw(inst, owner, target)
	if not inst:IsValid() then return end
	if inst.mod_collision then
		effect_collisionproj_stop(inst, owner)
	end
	inst.mod_collision_targets = {}
	inst.mod_collision = inst:DoPeriodicTask(0, function() 
		local x,y,z = inst.Transform:GetWorldPosition()
		local targets = TheSim:FindEntities(x,y,z, 1, {"_combat"})
		for k,v in pairs(targets) do
			if v ~= owner and not v.components.health:IsDead() and (GLOBAL.TheNet:GetPVPEnabled() or not v:HasTag("player")) and not GLOBAL.table.contains(inst.mod_collision_targets, v.GUID) then
				table.insert(inst.mod_collision_targets, v.GUID)
				v.components.combat:GetAttacked(owner, inst.components.weapon.damage)
			end
		end
	end)	
end

local function effect_collisionproj_stop(inst, owner)
	if not inst:IsValid() then return end
	if inst.mod_collision then
		inst.mod_collision:Cancel()
		inst.mod_collision = nil
	end
	inst.mod_collision_targets = nil
end

local function effect_rushing(inst, weapon, target, extra)
	if weapon:IsValid() and weapon.components.equippable then
		weapon.components.equippable.walkspeedmult = 1.25
		if weapon.mod_rushing then
			weapon.mod_rushing:Cancel()
			weapon.mod_rushing = nil
		end
		weapon.mod_rushing = weapon:DoTaskInTime(5, function()
			weapon.components.equippable.walkspeedmult = 1
			weapon.mod_rushing = nil
		end)
	end
end

local function effect_slowing(inst, weapon, target, extra)
	if weapon:IsValid() and weapon.components.equippable then
		weapon.components.equippable.walkspeedmult = 0.75
		if weapon.mod_rushing then
			weapon.mod_rushing:Cancel()
			weapon.mod_rushing = nil
		end
		weapon.mod_rushing = weapon:DoTaskInTime(5, function()
			weapon.components.equippable.walkspeedmult = 1
			weapon.mod_rushing = nil
		end)
	end
end

local function effect_electric_thorns(inst, item, attacker, data)--{damage, attacker.weapon, stimuli}
	if inst and attacker and GLOBAL.GetTableSize(inst.orbs) > 0 then
		effect_telesick(attacker, item, nil, true)

		local atkhp = attacker.components.health.currenthealth
		GLOBAL.TheWorld:PushEvent("ms_sendlightningstrike", attacker:GetPosition() or {x=0, y=0, z=0})

		if attacker.components.burnable and math.random() < 0.3 then
			attacker.components.burnable:Ignite()
		end
		if atkhp == attacker.components.health.currenthealth then--if lightning did no dmg
			if attacker ~= inst then
				attacker.components.combat:GetAttacked(inst, 25)
			else
				inst.components.health:DoDelta(-15)
			end
		end
		
		local orbindex = GLOBAL.GetTableSize(inst.orbs)
		local orb = inst.orbs[orbindex]
		inst.orbs[orbindex] = nil
		if orb then
			orb:Remove()
		end
		if GLOBAL.GetTableSize(inst.orbs) == 0 then
			item.modifier_resist = nil
		end
	end
end

local function effect_electric_thorns_off(inst, data)
	if data and data.percent then
		if data.percent > 0 then return end
		data.owner = inst.components.inventoryitem:GetGrandOwner() or nil
	end
	local owner = data.owner
	inst.modifier_resist = nil
	for i,orb in pairs(owner and owner.orbs or {}) do
		orb:Remove()
	end
	if owner then
		if owner.mod_orbs then
			owner.mod_orbs:Cancel()
			owner.mod_orbs = nil
		end
		owner.orbs = nil
	end
end

local function effect_electric_thorns_on(inst, data)
	local owner = data.owner
	if owner.mod_orbs then
		effect_electric_thorns_off(inst, data)
	end
	owner.orbs = {}
	owner.mod_orbs = owner:DoPeriodicTask(12, function()
		local orbcount = GLOBAL.GetTableSize(owner.orbs)
		if orbcount < 7 then
			inst.modifier_resist = 0.99
			table.insert(owner.orbs, owner:SpawnChild("orbfx"))
		else
			inst.modifier_resist = nil
			effect_electric_thorns(owner, inst, owner)
			owner:DoTaskInTime(0.5, function()
				for i,o in pairs(owner.orbs) do
					o:Remove()
				end
				owner.orbs = {}
			end)
		end
	end)
end

local function effect_unwithering(inst)
	inst:DoTaskInTime(1, function()
		if inst.decay_task ~= nil then
			inst.decay_task:Cancel()
			inst.decay_task = nil
		end
		inst.decayed = false
	end)
end

----------UTIL Functions----------
local function insertfn(inst, tbl, fn)
	if inst == nil or tbl == nil or fn == nil then print(inst, tbl, fn, "error?") return end
	if inst[tbl] == nil then
		inst[tbl] = {}
	end
	table.insert(inst[tbl], fn)
end

local function removefn(inst, tbl, fn)
	if inst == nil or tbl == nil or fn == nil or inst[tbl] == nil then print(inst, tbl, inst and tbl and inst[tbl] or nil, fn, "error?") return end
	GLOBAL.table.removearrayvalue(inst[tbl], fn)
	if GLOBAL.GetTableSize(inst[tbl]) == 0 then
		inst[tbl] = nil
	end
end

----------Modifier Effects Data----------
if not table.contains(GLOBALVARS, "modifier_effects") then
	GLOBAL.modifier_effects = {}
end
--[[{
		checkfn = function(inst)
			
		end,
		fn = function(inst)

		end,
		unfn = function(inst)

		end,
		prefix = "",
		rarity = "",
		desc = ""
	}]]


local resourceactions = {GLOBAL.ACTIONS.CHOP, GLOBAL.ACTIONS.MINE, GLOBAL.ACTIONS.DIG, GLOBAL.ACTIONS.HAMMER}

GLOBAL.modifier_effects.finiteuses = {
	sturdy_1 = {
		fn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = 0.75--25% less use
			end
		end,
		unfn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = nil
			end
		end,
		rarity = "good",
	},
	sturdy_2 = {
		fn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = 0.5--50% less use
			end
		end,
		unfn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = nil
			end
		end,
		rarity = "rare",
	},
	sturdy_x = {
		checkfn = function(inst)
			return not inst.components.fertilizer and not inst.components.sewing and not string.find(inst.prefab, "rifle")--bucket o' poop because super op with this otherwise
		end,
		fn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = 0--100% less use
			end
		end,
		unfn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = nil
			end
		end,
		rarity = "mythic",
	},	
	fragile_1 = {
		fn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = 1.25--25% more use
			end
		end,
		unfn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = nil
			end
		end,
		rarity = "bad",
	},
	fragile_2 = {
		fn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = 1.5--50% more use
			end
		end,
		unfn = function(inst)
			if inst and (inst.components.finiteuses or inst.components.armor) then
				inst.modifier_use = nil
			end
		end,
		rarity = "worst",
	},
	bloodlust = {
		checkfn = function(inst)
			return inst.components.weapon ~= nil and (inst.modifier_use == nil or inst.modifier_use ~= 0) and inst.components.tool == nil and inst.components.fishingrod == nil--effect also requires item to be weapon, and not infinite durability
		end,
		fn = function(inst)
			inst.modifier_kills = 0
			insertfn(inst, "modifier_wep_fns", effect_bloodlust)
		end,
		unfn = function(inst)
			inst.modifier_kills = nil
			removefn(inst, "modifier_wep_fns", effect_bloodlust)
		end,
		rarity = "epic",
	},
	resourcelust = {
		checkfn = function(inst)
			local cangather = false
			if inst.components.tool and inst.components.tool.actions then
				for action,power in pairs(inst.components.tool.actions) do
					if GLOBAL.table.contains(resourceactions, action) then
						cangather = true
						break
					end
				end
			end
			if inst.components.fishingrod then
				cangather = true
			end
			return cangather and (inst.modifier_use == nil or inst.modifier_use ~= 0)--effect also requires item to be tool, and not infinite durability
		end,
		fn = function(inst)
			inst.modifier_kills = 0
			insertfn(inst, "modifier_tool_fns", effect_resourcelust)
		end,
		unfn = function(inst)
			inst.modifier_kills = nil
			removefn(inst, "modifier_tool_fns", effect_resourcelust)
		end,
		rarity = "legendary",--not epic like bloodlust, because its easier to farm resources than kills
	},
}

local solarfueltypes = { GLOBAL.FUELTYPE.BURNABLE, GLOBAL.FUELTYPE.WORMLIGHT, GLOBAL.FUELTYPE.CAVE, GLOBAL.FUELTYPE.MAGIC }

GLOBAL.modifier_effects.fueled = {
	efficiency_1 = {
		fn = function(inst)
			inst.modifier_use = 0.9--10% less use
		end,
		unfn = function(inst)
			inst.modifier_use = nil
		end,
		rarity = "good",
	},
	efficiency_2 = {
		fn = function(inst)
			inst.modifier_use = 0.75--25% less use
		end,
		unfn = function(inst)
			inst.modifier_use = nil
		end,
		rarity = "rare",
	},
	inefficiency_1 = {
		fn = function(inst)
			inst.modifier_use = 1.1--10% more use
		end,
		unfn = function(inst)
			inst.modifier_use = nil
		end,
		rarity = "bad",
	},
	inefficiency_2 = {
		fn = function(inst)
			inst.modifier_use = 1.25--25% more use
		end,
		unfn = function(inst)
			inst.modifier_use = nil
		end,
		rarity = "worst",
	},
	solar = {
		checkfn = function(inst)
			return inst.components.fueled.accepting and GLOBAL.table.contains(solarfueltypes, inst.components.fueled.fueltype)
		end,
		fn = function(inst)
			insertfn(inst, "modifier_consuming_fns", effect_solar)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_consuming_fns", effect_solar)
		end,
		rarity = "epic",
	}
}

GLOBAL.modifier_effects.armor = { --ideas: selfrepairing, selfdegrading, player regen, fire protection, ice protection
	toughness_1 = {
		fn = GLOBAL.modifier_effects.finiteuses.sturdy_1.fn,
		unfn = GLOBAL.modifier_effects.finiteuses.sturdy_1.unfn,
		rarity = "good",
	},
	toughness_2 = {
		fn = GLOBAL.modifier_effects.finiteuses.sturdy_2.fn,
		unfn = GLOBAL.modifier_effects.finiteuses.sturdy_2.unfn,
		rarity = "rare",
	},
	toughness_x = {
		fn = GLOBAL.modifier_effects.finiteuses.sturdy_x.fn,
		unfn = GLOBAL.modifier_effects.finiteuses.sturdy_x.unfn,
		rarity = "mythic",
	},	
	weakness_1 = {
		fn = GLOBAL.modifier_effects.finiteuses.fragile_1.fn,
		unfn = GLOBAL.modifier_effects.finiteuses.fragile_1.unfn,
		rarity = "bad",
	},
	weakness_2 = {
		fn = GLOBAL.modifier_effects.finiteuses.fragile_2.fn,
		unfn = GLOBAL.modifier_effects.finiteuses.fragile_2.unfn,
		rarity = "worst",
	},
	resistance_1 = {
		fn = function(inst)
			inst.modifier_resist = 0.1--10% dmg reduction
		end,
		unfn = function(inst)
			inst.modifier_resist = nil
		end,
		rarity = "good",
	},
	resistance_2 = {
		fn = function(inst)
			inst.modifier_resist = 0.25--25% dmg reduction
		end,
		unfn = function(inst)
			inst.modifier_resist = nil
		end,
		rarity = "rare",
	},
	resistance_x = {
		fn = function(inst)
			inst.modifier_resist = 1--100% dmg reduction
		end,
		unfn = function(inst)
			inst.modifier_resist = nil
		end,
		rarity = "mythic",
	},
	thorns = {
		fn = function(inst)
			insertfn(inst, "modifier_reflect_fns", effect_thorns)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_reflect_fns", effect_thorns)
		end,
		rarity = "rare",
	},
	fiery_thorns = {
		fn = function(inst)
			insertfn(inst, "modifier_reflect_fns", effect_thorns_fiery)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_reflect_fns", effect_thorns_fiery)
		end,
		rarity = "legendary",
	},
	icey_thorns = {
		fn = function(inst)
			insertfn(inst, "modifier_reflect_fns", effect_thorns_icey)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_reflect_fns", effect_thorns_icey)
		end,
		rarity = "legendary",
	},
	lightweight = {
		checkfn = function(inst)
			return inst.components.equippable and (inst.components.equippable.walkspeedmult == nil or inst.components.equippable.walkspeedmult == 1)
		end,
		fn = function(inst)
			inst.components.equippable.walkspeedmult = 1.25
		end,
		unfn = function(inst)
			inst.components.equippable.walkspeedmult = 1
		end,
		rarity = "good"
	},
	heavyweight = {
		checkfn = function(inst)
			return inst.components.equippable and (inst.components.equippable.walkspeedmult == nil or inst.components.equippable.walkspeedmult == 1)
		end,
		fn = function(inst)
			inst.components.equippable.walkspeedmult = 0.75
		end,
		unfn = function(inst)
			inst.components.equippable.walkspeedmult = 1
		end,
		rarity = "bad"
	},
	electric_thorns = {
		checkfn = function(inst)
			return true
		end,
		fn = function(inst)
			inst:ListenForEvent("equipped", effect_electric_thorns_on)
			inst:ListenForEvent("unequipped", effect_electric_thorns_off)
			inst:ListenForEvent("percentusedchange", effect_electric_thorns_off)
			insertfn(inst, "modifier_reflect_fns", effect_electric_thorns)
		end,
		unfn = function(inst)
			effect_electric_thorns_off(inst, {owner = inst.components.inventoryitem:GetGrandOwner()})
			inst:RemoveEventCallback("equipped", effect_electric_thorns_on)
			inst:RemoveEventCallback("unequipped", effect_electric_thorns_off)
			inst:RemoveEventCallback("percentusedchange", effect_electric_thorns_off)
			removefn(inst, "modifier_reflect_fns", effect_electric_thorns)
		end,
		rarity = "legendary"
	}
}

local function defaultdmgcheck(inst)
	return inst.components.weapon.damage ~= 0 or inst.components.zupalexsrangedweapons
end

GLOBAL.modifier_effects.weapon = {
	sharpness_1 = {
		checkfn = defaultdmgcheck,
		fn = function(inst)
			inst.modifier_dmg = 0.1--10% buff
		end,
		unfn = function(inst)
			inst.modifier_dmg = nil
		end,
		rarity = "good",
	},
	sharpness_2 = {
		checkfn = defaultdmgcheck,
		fn = function(inst)
			inst.modifier_dmg = 0.25--25% buff
		end,
		unfn = function(inst)
			inst.modifier_dmg = nil
		end,
		rarity = "rare",
	},
	sharpness_3 = {
		checkfn = defaultdmgcheck,
		fn = function(inst)
			inst.modifier_dmg = 0.75--75% buff
		end,
		unfn = function(inst)
			inst.modifier_dmg = nil
		end,
		rarity = "epic",
	},
	dulness_1 = {
		checkfn = defaultdmgcheck,
		fn = function(inst)
			inst.modifier_dmg = -0.1--10% debuff
		end,
		unfn = function(inst)
			inst.modifier_dmg = nil
		end,
		rarity = "bad",
	},
	dulness_2 = {
		checkfn = defaultdmgcheck,
		fn = function(inst)
			inst.modifier_dmg = -0.25--25% debuff
		end,
		unfn = function(inst)
			inst.modifier_dmg = nil
		end,
		rarity = "worst",
	},
	fiery = {
		checkfn = function(inst)
			return not inst:HasTag("lighter") and not inst:HasTag("rangedlighter") and not inst:HasTag("extinguisher")--no existing fire/ice effect weapon should get this
		end,
		fn = function(inst)
			insertfn(inst, "modifier_wep_fns", effect_fiery)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_wep_fns", effect_fiery)
		end,
		rarity = "epic",
	},
	icey = {
		checkfn = function(inst)
			return not inst:HasTag("extinguisher") and not inst:HasTag("lighter") and not inst:HasTag("rangedlighter")--no existing fire/ice effect weapon should get this
		end,
		fn = function(inst)
			insertfn(inst, "modifier_wep_fns", effect_icey)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_wep_fns", effect_icey)
		end,
		rarity = "epic",
	},
	lifesteal = {
		fn = function(inst)
			insertfn(inst, "modifier_wep_fns", effect_lifesteal)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_wep_fns", effect_lifesteal)
		end,
		rarity = "legendary",
	},
	telecoward = {
		fn = function(inst)
			insertfn(inst, "modifier_wep_fns", effect_telesick)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_wep_fns", effect_telesick)
		end,
		rarity = "rare",
	},
	ghoststrike = {
		checkfn = function(inst)
			return not inst:HasTag("rangedweapon") and not inst.components.weapon.projectile and not inst.components.projectile and not inst.components.complexprojectile and not inst.components.fueled and (inst.components.inventoryitem.owner == nil or inst.components.inventoryitem:GetGrandOwner().prefab ~= "yorha2b_dst_td1madao")
		end,
		fn = function(inst)
			inst.modifier_use = inst.modifier_use == 0 and 0 or 3--uses 3x durability
			inst.modifier_oldrange = inst.components.weapon.attackrange or 0
			inst.components.weapon:SetRange(inst.modifier_oldrange + 10)
			insertfn(inst, "modifier_wep_fns", effect_ghoststrike)
		end,
		unfn = function(inst)
			inst.modifier_use = nil
			inst.components.weapon:SetRange(inst.modifier_oldrange)
			inst.modifier_oldrange = nil
			removefn(inst, "modifier_wep_fns", effect_ghoststrike)
		end,
		rarity = "mythic",
	},
	rushing = {
		checkfn = function(inst)
			return inst.components.equippable and (inst.components.equippable.walkspeedmult == nil or inst.components.equippable.walkspeedmult == 1)
		end,
		fn = function(inst)
			insertfn(inst, "modifier_wep_fns", effect_rushing)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_wep_fns", effect_rushing)
		end,
		rarity = "rare",
	},
	slowing = {
		checkfn = function(inst)
			return inst.components.equippable and (inst.components.equippable.walkspeedmult == nil or inst.components.equippable.walkspeedmult == 1)
		end,
		fn = function(inst)
			insertfn(inst, "modifier_wep_fns", effect_slowing)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_wep_fns", effect_slowing)
		end,
		rarity = "worst",
	}
}

GLOBAL.modifier_effects.instrument = {
	regensong = {
		fn = function(inst)
			insertfn(inst, "modifier_instrument_fns", effect_regensong)			
		end,
		unfn = function(inst)
			removefn(inst, "modifier_instrument_fns", effect_regensong)	
		end,
		rarity = "legendary",
	},
	sanitysong = {
		fn = function(inst)
			insertfn(inst, "modifier_instrument_fns", effect_sanitysong)			
		end,
		unfn = function(inst)
			removefn(inst, "modifier_instrument_fns", effect_sanitysong)	
		end,
		rarity = "legendary",
	},
	revivalsong = {
		fn = function(inst)
			insertfn(inst, "modifier_instrument_fns", effect_revivalsong)			
		end,
		unfn = function(inst)
			removefn(inst, "modifier_instrument_fns", effect_revivalsong)	
		end,
		rarity = "mythic",
	},
	tauntsong = {
		checkfn = function(inst)
			return inst.preafb ~= "panflute"--panflute makes enemies sleep, can't really have taunt+sleep
		end,
		fn = function(inst)
			insertfn(inst, "modifier_instrument_fns", effect_tauntsong)			
		end,
		unfn = function(inst)
			removefn(inst, "modifier_instrument_fns", effect_tauntsong)	
		end,
		rarity = "epic",
	},
}

GLOBAL.modifier_effects.projectile = {
	fast_projectile = {
		fn = function(inst)
			inst.oldspeed = inst.components.projectile.speed
			inst.components.projectile:SetSpeed(inst.oldspeed * 1.5)		
		end,
		unfn = function(inst)
			inst.components.projectile:SetSpeed(inst.oldspeed)
			inst.oldspeed = nil
		end,
		rarity = "rare",
	},
	slow_projectile = {
		fn = function(inst)
			inst.oldspeed = inst.components.projectile.speed
			inst.components.projectile:SetSpeed(inst.oldspeed * 0.75)		
		end,
		unfn = function(inst)
			inst.components.projectile:SetSpeed(inst.oldspeed)
			inst.oldspeed = nil
		end,
		rarity = "bad",
	},
	collision_projectile = {
		checkfn = function(inst)
			return inst.components.weapon and inst.components.weapon.damage ~= 0
		end,
		fn = function(inst)
			insertfn(inst, "modifier_throw_fns", effect_collisionproj_throw)	
			insertfn(inst, "modifier_catch_fns", effect_collisionproj_stop)	
		end,
		unfn = function(inst)
			removefn(inst, "modifier_throw_fns", effect_collisionproj_throw)	
			removefn(inst, "modifier_catch_fns", effect_collisionproj_stop)	
		end,
		rarity = "legendary",
	},
}

GLOBAL.modifier_effects.container = {
	freezer = {
		checkfn = function(inst)
			return inst.prefab ~= "icepack"--CHECK FOR CONTAINERS THAT DONT STORE FOOD
		end,
		fn = function(inst)
			inst:AddTag("fridge")
		end,
		unfn = function(inst)
			inst:RemoveTag("fridge")
		end,
		rarity = "legendary",
	},
	fireproof = {
		checkfn = function(inst)
			return inst.components.burnable or inst.modifier_fireproof_bu
		end,
		fn = function(inst)
			inst.modifier_fireproof_bu = {
				onignite = inst.components.burnable.onignite,
				onburnt = inst.components.burnable.onburnt,
				onextinguish = inst.components.burnable.onextinguish
			}
			inst:RemoveComponent("propagator")
			inst:RemoveComponent("burnable")
		end,
		unfn = function(inst)
			GLOBAL.MakeSmallBurnable(inst)
			if inst.modifier_fireproof_bu then
				for name,fn in pairs(inst.modifier_fireproof_bu) do
					inst.components.burnable[name] = fn or inst.components.burnable[name]
				end
			end
			GLOBAL.MakeSmallPropagator(inst)
		end,
		rarity = "epic",
	},
	unwithering = {
		checkfn = function(inst)
			return inst.skin_build_name or inst.skinname or inst.skin_id
		end,
		fn = function(inst)
			inst:ListenForEvent("ondropped", effect_unwithering)
			effect_unwithering(inst)
		end,
		unfn = function(inst)
			inst:RemoveEventCallback("ondropped", effect_unwithering)
			inst:OnLoad({decayed = true, remaining_decay_time = 1})
		end,
		rarity = "rare"
	}
}

GLOBAL.modifier_effects.modifier_cleaner = {
	repairer = {
		rarity = "epic"
	},
	infinite = {
		rarity = "legendary"
	},
	preserver = {
		rarity = "epic"
	}
}
GLOBAL.modifier_effects.equippable = {--ideas: sanity/hunger/temperature effects
	--[[godlike = {
		fn = function(inst)
			if inst and inst.components.finiteuses then
				GLOBAL.modifier_effects.finiteuses.sturdy_x.fn(inst)
				GLOBAL.modifier_effects.finiteuses.bloodlust.fn(inst)
			end
			if inst and inst.components.weapon then
				GLOBAL.modifier_effects.weapon.sharpness_3.fn(inst)
				GLOBAL.modifier_effects.weapon.fiery.fn(inst)
				GLOBAL.modifier_effects.weapon.lifesteal.fn(inst)
				GLOBAL.modifier_effects.weapon.ghoststrike.fn(inst)
			end
			if inst and inst.components.armor then
				GLOBAL.modifier_effects.armor.toughness_x.fn(inst)
				GLOBAL.modifier_effects.armor.resistance_x.fn(inst)
				GLOBAL.modifier_effects.armor.thorns.fn(inst)
			end
			if inst and inst.components.fueled then
				GLOBAL.modifier_effects.fueled.solar.fn(inst)
			end
			if inst and inst.components.instrument then
				GLOBAL.modifier_effects.instrument.regensong.fn(inst)
				GLOBAL.modifier_effects.instrument.sanitysong.fn(inst)
				GLOBAL.modifier_effects.instrument.revivalsong.fn(inst)
				GLOBAL.modifier_effects.instrument.tauntsong.fn(inst)
			end
			if inst and inst.components.container then
				GLOBAL.modifier_effects.container.freezer.fn(inst)
			end
			if inst and inst.components.modifier_cleaner then
				GLOBAL.modifier_effects.modifier_cleaner.repairer.fn(inst)
				GLOBAL.modifier_effects.modifier_cleaner.infinite.fn(inst)
			end
			if inst and inst.components.projectile then
				GLOBAL.modifier_effects.projectile.slow_projectile.fn(inst)
				GLOBAL.modifier_effects.projectile.collision_projectile.fn(inst)	
			end
			inst.components.inventoryitem.keepondeath = true
		end,
		unfn = function(inst)
			if inst and inst.components.finiteuses then
				GLOBAL.modifier_effects.finiteuses.sturdy_x.unfn(inst)
				GLOBAL.modifier_effects.finiteuses.bloodlust.unfn(inst)
			end
			if inst and inst.components.weapon then
				GLOBAL.modifier_effects.weapon.sharpness_3.unfn(inst)
				GLOBAL.modifier_effects.weapon.fiery.unfn(inst)
				GLOBAL.modifier_effects.weapon.lifesteal.unfn(inst)
				GLOBAL.modifier_effects.weapon.ghoststrike.unfn(inst)
			end
			if inst and inst.components.armor then
				GLOBAL.modifier_effects.armor.toughness_x.unfn(inst)
				GLOBAL.modifier_effects.armor.resistance_x.unfn(inst)
				GLOBAL.modifier_effects.armor.thorns.unfn(inst)
			end
			if inst and inst.components.fueled then
				GLOBAL.modifier_effects.fueled.solar.unfn(inst)
			end
			if inst and inst.components.instrument then
				GLOBAL.modifier_effects.instrument.regensong.unfn(inst)
				GLOBAL.modifier_effects.instrument.sanitysong.unfn(inst)
				GLOBAL.modifier_effects.instrument.revivalsong.unfn(inst)
				GLOBAL.modifier_effects.instrument.tauntsong.unfn(inst)
			end
			if inst and inst.components.container then
				GLOBAL.modifier_effects.container.freezer.unfn(inst)
			end
			if inst and inst.components.modifier_cleaner then
				GLOBAL.modifier_effects.modifier_cleaner.repairer.unfn(inst)
				GLOBAL.modifier_effects.modifier_cleaner.infinite.unfn(inst)
			end
			if inst and inst.components.projectile then
				GLOBAL.modifier_effects.projectile.slow_projectile.unfn(inst)
				GLOBAL.modifier_effects.projectile.collision_projectile.unfn(inst)	
			end
			inst.components.inventoryitem.keepondeath = false
		end,
		rarity = "test",
	},]]
	soulbound = {
		checkfn = function(inst)--require finiteuses else it will stuck on the player forever
			return ((inst.components.armor and not inst.components.armor.indestructible) or (inst.components.finiteuses and inst.components.finiteuses.onfinished)) and not inst.components.trap and inst.prefab ~= "amulet" and not inst.components.fueled and not inst.components.useableitem and not inst.components.perishable and not inst.components.projectile and not inst.MakeProjectile--this item requires to be haunted, if u pick it up automatically, it would be hard to haunt
		end,
		fn = function(inst)
			inst.components.inventoryitem.keepondeath = true
			inst:DoTaskInTime(0, function()--delay it so owner is actually assigned if this is ran on start up
				print(inst.components.inventoryitem.owner)
				if inst.components.inventoryitem.owner then
					local slot = inst.components.equippable.equipslot
					local owner = inst.components.inventoryitem:GetGrandOwner()
					inst.boundguy = owner
					if slot and owner.components.inventory.equipslots[slot] == nil or not owner.components.inventory.equipslots[slot]:HasTag("modifier_soulbound") then
						owner.components.inventory:Equip(inst)
					end
				end
			end)
		end,
		unfn = function(inst)--does the inventory item tile update to be clickable again? | we shouldn't be able to unfn while equipped so we shouldn't care
			inst.components.inventoryitem.keepondeath = false
		end,
		rarity = "epic",
	},
	telesensitive = {
		checkfn = function(inst)
			return inst.components.equippable.equipslot ~= GLOBAL.EQUIPSLOTS.HANDS and inst.components.container == nil
		end,
		fn = function(inst)
			insertfn(inst, "modifier_armor_fns", effect_telesick)
		end,
		unfn = function(inst)
			removefn(inst, "modifier_armor_fns", effect_telesick)
		end,
		rarity = "epic",
	},
	mindfizzler = {
		checkfn = function(inst)
			return inst.components.equippable.equipslot == GLOBAL.EQUIPSLOTS.HEAD and (inst.components.equippable.walkspeedmult == nil or inst.components.equippable.walkspeedmult == 1)
		end,
		fn = function(inst)
			inst.components.equippable.walkspeedmult = 0
		end,
		unfn = function(inst)
			inst.components.equippable.walkspeedmult = 1
		end,
		rarity = "worst",
	},
	mindascender = {
		checkfn = function(inst)
			return inst.components.equippable.equipslot == GLOBAL.EQUIPSLOTS.HEAD and (inst.components.finiteuses or inst.components.armor or inst.components.perishable or inst.components.fueled)
		end,
		rarity = "legendary"
	},
	mindtranscender = {
		checkfn = function(inst)
			return inst.components.equippable.equipslot == GLOBAL.EQUIPSLOTS.HEAD and (inst.components.finiteuses or inst.components.armor or inst.components.perishable or inst.components.fueled)
		end,
		rarity = "mythic"
	}
}

local modcount = 0
for comp,sub in pairs(GLOBAL.modifier_effects) do
	modcount = modcount + GLOBAL.GetTableSize(sub)
	print(GLOBAL.GetTableSize(sub) .. " " .. comp ..  " modifiers loaded.")
end
print("Total modifier count: " .. modcount)