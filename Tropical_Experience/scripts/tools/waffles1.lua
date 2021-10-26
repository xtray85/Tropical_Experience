--==<[[ СЕРДЦЕ МОДА ]]>==--

_G = GLOBAL; require, rawget, getmetatable, unpack = _G.require, _G.rawget, _G.getmetatable, _G.unpack


-- Ссылки и сокращения --

TheNet = _G.TheNet; IsServer, IsDedicated = TheNet:GetIsServer(), TheNet:IsDedicated()
TheSim = _G.TheSim

AddPrefabPostInit("world", function(inst)
	TheWorld = inst
end)

STRINGS = _G.STRINGS
RECIPETABS, TECH, AllRecipes, GetValidRecipe = _G.RECIPETABS, _G.TECH, _G.AllRecipes, _G.GetValidRecipe
EQUIPSLOTS, FRAMES, FOODTYPE, FUELTYPE = _G.EQUIPSLOTS, _G.FRAMES, _G.FOODTYPE, _G.FUELTYPE

State, TimeEvent, EventHandler = _G.State, _G.TimeEvent, _G.EventHandler
ACTIONS, ActionHandler = _G.ACTIONS, _G.ActionHandler
CAMERASHAKE, ShakeAllCameras = _G.CAMERASHAKE, _G.ShakeAllCameras

SpawnPrefab, ErodeAway, FindEntity = _G.SpawnPrefab, _G.ErodeAway, _G.FindEntity
KnownModIndex, Vector3, Remap = _G.KnownModIndex, _G.Vector3, _G.Remap
COMMAND_PERMISSION, BufferedAction, SendRPCToServer, RPC = _G.COMMAND_PERMISSION, _G.BufferedAction, _G.SendRPCToServer, _G.RPC
COLLISION = _G.COLLISION

AllPlayers = _G.AllPlayers

FULL_CHARACTERLIST = {}
for _,t in pairs({ _G.DST_CHARACTERLIST, _G.MODCHARACTERLIST }) do
	for _,v in pairs(t) do table.insert(FULL_CHARACTERLIST, v) end
end

scheduler = _G.scheduler

--TheConfiguration = {}
--local config, temp_options = KnownModIndex:GetModConfigurationOptions_Internal(modname)
--if config and type(config) == "table" then
--	if temp_options then
--		TheConfiguration = config
--	else
--		for i,v in pairs(config) do
--			local value = v.default
--			if v.saved ~= nil then
--				value = v.saved
--			end
--			TheConfiguration[v.name] = value
--		end
--	end
--end
--_G.TheConfiguration = TheConfiguration

--==[ ПРИВАТНЫЕ ФУНКЦИИ ]==--

--< ОСНОВНОЕ >--

local function cutpath(path_string)
	local path = {}
	for sub in path_string:gmatch("([%w_]+)") do
		table.insert(path, sub)
	end
	return path
end
local dummyfn = function() end

local Tools =
{
	-- 1. Система --
	
	GetPath = function(root, path)		
		local t = root
		for _,v in pairs(cutpath(path)) do
			if t[v] == nil then
				t[v] = {}
			end
			t = t[v]
		end
		return t
	end,
				
	-- 2. Игровой процесс --
	
	Valid = function(inst)
		return inst ~= nil and inst:IsValid()
	end,
	
	ReturnChild = function(root, path)
		local t = root
		for _,v in pairs(cutpath(path)) do
			if type(t) ~= "table" then
				return
			end
			t = t[v]
			if t == nil then
				return
			end
		end
		return t
	end,
	
	AddChild = function(inst, child)
		inst:AddChild(child)
		child.entity:SetParent(nil)
		return child
	end,
		
	DoHauntFlick = function(inst, time)
		inst.AnimState:SetHaunted(true)
		inst:DoTaskInTime(time or 1, function()
			inst.AnimState:SetHaunted(false)
		end)
	end,
		
--	PushFakeShadow = function(inst, time, ...)
--		local function ReturnToNormal()
--			if inst.DynamicShadowFake ~= nil then
--				inst.DynamicShadowFake:Remove()
--				inst.DynamicShadowFake = nil
--			end
--			inst.DynamicShadow:Enable(true)
--		end
--					
--		local shadow = SpawnPrefab("dynamicshadow")
--		shadow:Hook(inst, ...)
--			
--		ReturnToNormal()
--		inst.DynamicShadow:Enable(false)
--		inst.DynamicShadowFake = shadow
--		
--		inst:DoTaskInTime(time or 1, ReturnToNormal)
--	end,
		
	SpawnBundle = function(prefab, data)
		local bundle = SpawnPrefab(prefab)
		bundle.components.unwrappable:WrapItems(data)
		
		for _,v in pairs(data) do
			v:Remove()
		end
		
		return bundle
	end,
		
	PlayCharacterSound = function(inst, name)
		inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/"..name)
	end,
		
	-- 3. Утилиты --
	
	ReplicateDummyFn = function(root, fn, rep, ...)
		local save = nil
		if root ~= nil then
			save = root[fn]
			root[fn] = dummyfn
		end
			
		rep(...)
				
		if save ~= nil then
			root[fn] = save
		end
	end,
		
	SequenceFn = function(root, fn, exp)
		local old = root[fn]
		root[fn] = function(self, ...)
			local data = { old(self, ...) }
			return exp(#data > 1 and data or data[1], ...)
		end
	end,
	
	ReplaceFn = function(root, fn, replace)
		if replace ~= nil then
			root["__"..fn] = root[fn]
			root[fn] = replace
		elseif root["__"..fn] ~= nil then
			root[fn] = root["__"..fn]
			root["__"..fn] = nil
		end
	end,
}

if TECH.WAFFLES1 ~= nil then
	for name, fn in pairs(Tools) do
		TECH.WAFFLES1[name] = fn
	end
else
	TECH.WAFFLES1 = Tools
end

_G.Waffles1 = TECH.WAFFLES1; Waffles1 = _G.Waffles1

--< ДОПОЛНЕНИЯ >--

-- 1. Общее --

Waffles1.AddCharacterQuotes = function(path, key, quotes)
	local t = Waffles1.GetPath(_G, "STRINGS/CHARACTERS")
	for character, quote in pairs(quotes) do
		if key then
			Waffles1.GetPath(t, string.format("%s/%s", character, path))[key] = quote
		else
			Waffles1.GetPath(t, character)[path] = quote
		end
	end
end

--Waffles1.AddPrefabStrings = function(prefab, name, recipe_desc)
--	local t = Waffles1.GetPath(_G, "STRINGS")
--	Waffles1.GetPath(t, "NAMES")[prefab:upper()] = name
--	if recipe_desc ~= nil then
--		Waffles1.GetPath(t, "RECIPE_DESC")[prefab:upper()] = recipe_desc
--	end
--end

-- 2. Игровой процесс --

--Waffles1.DespawnRecipe = function(inst, isbuilder)
--	local staff = SpawnPrefab("greenstaff")
--	staff.persists = false
--		
--	if staff.components.spellcaster ~= nil then
--		local x, y, z = inst.Transform:GetWorldPosition()
--		local not_ingredients = table.invert(TheSim:FindEntities(x, y, z, 3, { "_inventoryitem" }))
--		if isbuilder then
--			inst.prefab = inst.prefab.."_builder"
--		end
--		staff.components.spellcaster.spell(staff, inst)
--
--		local ingredients = {}
--		for _,v in pairs(TheSim:FindEntities(x, y, z, 3, { "_inventoryitem" })) do
--			if not_ingredients[v] == nil then
--				table.insert(ingredients, v)
--			end
--		end
--
--		if #ingredients > 0 then
--			Waffles1.SpawnBundle("gift", ingredients).Transform:SetPosition(x, y, z)
--		end
--	end
--	
--	if staff:IsValid() then
--		staff:Remove()
--	end
--	if inst:IsValid() then
--		inst:Remove()
--	end
--end

-- Префабы --

--for _,v in pairs({ "dynamicshadow" }) do
--	table.insert(PrefabFiles, v)
--end