require "tuning"

local COMMON = 3
local UNCOMMON = 1
local RARE = .5

ROE_FISH = 
{

	fish2 = { -- purple grouper
		seedweight =        COMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_2",		

		anim = 				"fish2",
		build = 			"fish2",
		state = 			"idle",			

		cooked_anim = 		"fish2",
		cooked_build = 		"fish2",
		cooked_state = 		"cooked",

		boost_surf = 		true,
	},	
	

	fish3 = { -- purple grouper
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_3",		

		anim = 				"fish3",
		build = 			"fish3",
		state = 			"idle",			

		cooked_anim = 		"fish3",
		cooked_build = 		"fish3",
		cooked_state = 		"cooked",

		boost_surf = 		true,
	},

	fish4 = { -- Pierrot fish
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_4",

		anim = 				"fish4",
		build = 			"fish4",	
		state = 			"idle",		

		cooked_anim = 		"fish4",
		cooked_build = 		"fish4",
		cooked_state = 		"cooked",

		boost_dry = 		true,

	},
	
	fish5 = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_5",

		anim = 				"fish5",
		build = 			"fish5",		
		state = 			"idle",			

		cooked_anim = 		"fish5",
		cooked_build = 		"fish5",
		cooked_state = 		"cooked",

		boost_cool = 		true,
	},
	
	fish6 = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_5",

		anim = 				"fish6",
		build = 			"fish6",		
		state = 			"idle",			

		cooked_anim = 		"fish6",
		cooked_build = 		"fish6",
		cooked_state = 		"cooked",

		boost_cool = 		true,
	},

	fish7 = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_5",

		anim = 				"fish7",
		build = 			"fish7",		
		state = 			"idle",			

		cooked_anim = 		"fish7",
		cooked_build = 		"fish7",
		cooked_state = 		"cooked",

		boost_cool = 		true,
	},	
	
	coi = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_5",

		anim = 				"coi",
		build = 			"coi",		
		state = 			"idle",			

		cooked_anim = 		"coi",
		cooked_build = 		"coi",
		cooked_state = 		"cooked",

		boost_cool = 		true,
	},

	salmon = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		true,
		sign = 				"buoy_sign_5",

		anim = 				"salmon",
		build = 			"salmon",		
		state = 			"idle",			

		cooked_anim = 		"salmon",
		cooked_build = 		"salmon",
		cooked_state = 		"cooked",

		boost_cool = 		true,
	},
	
	ballphinocean = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"ballphinocean",
		build = 			"ballphinocean",		
		state = 			"idle",			

		cooked_anim = 		"ballphinocean",
		cooked_build = 		"ballphinocean",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},	
	
	mecfish = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"mecfish",
		build = 			"mecfish",		
		state = 			"idle",			

		cooked_anim = 		"mecfish",
		cooked_build = 		"mecfish",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},	
	
	goldfish = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"goldfish",
		build = 			"goldfish",		
		state = 			"idle",			

		cooked_anim = 		"goldfish",
		cooked_build = 		"goldfish",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},		
	
	whaleblueocean = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"whaleblueocean",
		build = 			"whaleblueocean",		
		state = 			"idle",			

		cooked_anim = 		"whaleblueocean",
		cooked_build = 		"whaleblueocean",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},	

	dogfishocean = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"dogfishocean",
		build = 			"dogfishocean",		
		state = 			"idle",			

		cooked_anim = 		"dogfishocean",
		cooked_build = 		"dogfishocean",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},

	swordfishjocean = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"swordfishjocean",
		build = 			"swordfishjocean",		
		state = 			"idle",			

		cooked_anim = 		"swordfishjocean",
		cooked_build = 		"swordfishjocean",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},
	
	swordfishjocean2 = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"swordfishjocean2",
		build = 			"swordfishjocean2",		
		state = 			"idle",			

		cooked_anim = 		"swordfishjocean2",
		cooked_build = 		"swordfishjocean2",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},	
	
	sharxocean = { -- Neon Quattro
		seedweight =        UNCOMMON,
		health =        	TUNING.HEALING_TINY,
		cooked_health = 	TUNING.HEALING_SMALL,
		hunger =        	TUNING.CALORIES_SMALL,
		cooked_hunger = 	TUNING.CALORIES_SMALL,
		perishtime =       	TUNING.PERISH_MED,
		cooked_perishtime = TUNING.PERISH_FAST,
		sanity =            0,
		cooked_sanity =     0,
		createPrefab =		false,
		sign = 				"buoy_sign_5",

		anim = 				"sharxocean",
		build = 			"sharxocean",		
		state = 			"idle",			

		cooked_anim = 		"sharxocean",
		cooked_build = 		"sharxocean",
		cooked_state = 		"cooked",

		boost_cool = 		false,
	},		
	
}


local function MakeFish(name, has_seeds)

	local assets=
	{
		Asset("ANIM", "anim/"..name..".zip"),
	}
	local assets_cooked=
	{
		Asset("ANIM", "anim/"..name..".zip"),
	}
	
	local assets_seeds =
	{
		Asset("ANIM", "anim/roe.zip"),
	}

	local prefabs =
	{
		name.."_cooked",
		"spoiled_food",
	}    
	
	
	if has_seeds then
		table.insert(prefabs, name.."_seeds")
	end

	local function fn_seeds()
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()    
		MakeInventoryPhysics(inst)
		inst.AnimState:SetBank("seeds")
		inst.AnimState:SetBuild("seeds")
		inst.AnimState:SetRayTestOnBB(true)
		MakeInventoryFloatable(inst)
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		
		inst:AddComponent("edible")
		inst.components.edible.foodtype = "SEEDS"

		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

		
		inst:AddComponent("tradable")
		inst:AddComponent("inspectable")
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"
		
		inst.AnimState:PlayAnimation("idle")
		inst.components.edible.healthvalue = TUNING.HEALING_TINY/2
		inst.components.edible.hungervalue = TUNING.CALORIES_TINY

		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"
		
	    
		inst:AddComponent("cookable")
		inst.components.cookable.product = "seeds_cooked"
	    
		inst:AddComponent("bait")
		inst:AddComponent("plantable")
		inst.components.plantable.growtime = TUNING.SEEDS_GROW_TIME
		inst.components.plantable.product = name
	    
		return inst
	end



	local function fn(Sim)
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		MakeInventoryPhysics(inst)
		inst.entity:AddNetwork()		
		inst.AnimState:SetBank(name)
		inst.AnimState:SetBuild(name)
		inst.AnimState:PlayAnimation("dead")

	   -- inst.build = rodbuild --This is used within SGwilson, sent from an event in fishingrod.lua
        
        inst:AddTag("meat")
		inst:AddTag("fishmeat")
		inst:AddTag("fish")		
        inst:AddTag("catfood")
        inst:AddTag("packimfood")   
		MakeInventoryFloatable(inst)
		inst:AddTag("cru")
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

--		MakeInventoryFloatable(inst, "idle_water", "idle")	    

		inst:AddComponent("edible")
		inst.components.edible.healthvalue = ROE_FISH[name].health
		inst.components.edible.hungervalue = ROE_FISH[name].hunger
		inst.components.edible.sanityvalue = ROE_FISH[name].sanity or 0	
		inst.components.edible.ismeat = true	
		inst.components.edible.foodtype = "MEAT"

		if ROE_FISH[name].boost_surf then
			inst.components.edible.surferdelta = TUNING.HYDRO_FOOD_BONUS_SURF
			inst.components.edible.surferduration = TUNING.FOOD_SPEED_AVERAGE
		end

		if ROE_FISH[name].boost_dry then
			inst.components.edible.autodrydelta = TUNING.HYDRO_FOOD_BONUS_DRY
			inst.components.edible.autodryduration = TUNING.FOOD_SPEED_AVERAGE
		end
		
		if ROE_FISH[name].boost_cool then
			inst.components.edible.autocooldelta = TUNING.HYDRO_FOOD_BONUS_COOL_RATE
		end		

		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(ROE_FISH[name].perishtime)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"
		
		inst:AddComponent("stackable")

		inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

		inst:AddComponent("inspectable")
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"
		
		---------------------        

		inst:AddComponent("bait")
	    
		------------------------------------------------
		inst:AddComponent("tradable")
	    
		------------------------------------------------  
	    
		inst:AddComponent("cookable")
		inst.components.cookable.product = name.."_cooked"

		return inst
	end
	
	local function fn_cooked(Sim)
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		MakeInventoryPhysics(inst)
		inst.entity:AddNetwork()		
		inst.AnimState:SetBank(ROE_FISH[name].cooked_anim)
		inst.AnimState:SetBuild(ROE_FISH[name].cooked_build)
		inst.AnimState:PlayAnimation(ROE_FISH[name].cooked_state)

--		MakeInventoryFloatable(inst, "cooked_water", "cooked")	    

		inst:AddTag("meat")
		inst:AddTag("fishmeat")
		inst:AddTag("catfood")
		inst:AddTag("packimfood")
		MakeInventoryFloatable(inst)
		inst:AddTag("cosido")
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("edible")
		inst.components.edible.ismeat = true
		inst.components.edible.foodtype = "MEAT"
		inst.components.edible.foodstate = "COOKED"		
		inst.components.edible.healthvalue = ROE_FISH[name].cooked_health
		inst.components.edible.hungervalue = ROE_FISH[name].cooked_hunger
		inst.components.edible.sanityvalue = ROE_FISH[name].cooked_sanity or 0
		
		if ROE_FISH[name].boost_surf then
			inst.components.edible.surferdelta = TUNING.HYDRO_FOOD_BONUS_SURF
			inst.components.edible.surferduration = TUNING.FOOD_SPEED_AVERAGE
		end

		if ROE_FISH[name].boost_dry then
			inst.components.edible.autodrydelta = TUNING.HYDRO_FOOD_BONUS_DRY
			inst.components.edible.autodryduration = TUNING.FOOD_SPEED_AVERAGE
		end
		
		if ROE_FISH[name].boost_cool then
			inst.components.edible.autocooldelta = TUNING.HYDRO_FOOD_BONUS_COOL_RATE
		end	

		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(ROE_FISH[name].cooked_perishtime)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"
	    		
		inst:AddComponent("inspectable")
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
		--inst.components.inventoryitem:ChangeImageName("fishtropical_cooked")
		
		inst:AddComponent("tradable")
		inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT
--    	inst.components.tradable.dubloonvalue = TUNING.DUBLOON_VALUES.SEAFOOD		---------------------        

		inst:AddComponent("bait")
	    
		return inst
	end
	local base = Prefab( "common/inventory/"..name, fn, assets, prefabs)
	
	local cooked = Prefab( "common/inventory/"..name.."_cooked", fn_cooked, assets_cooked)
	local seeds = has_seeds and Prefab( "common/inventory/"..name.."_seeds", fn_seeds, assets_seeds) or nil
	return base, cooked, seeds  
end


local prefs = {}
for fishname,fishdata in pairs(ROE_FISH) do 
	if fishdata.createPrefab == true then 	
		local fish, cooked, seeds = MakeFish(fishname, fishname ~= "fish2" and fishname ~= "fish3" and fishname ~= "fish4" and fishname ~= "fish5" and fishname ~= "fish6" and fishname ~= "fish7" and fishname ~= "coi" and fishname ~= "salmon" and fishname ~= "ballphinocean" and fishname ~= "mecfish" and fishname ~= "goldfish" and fishname ~= "whaleblueocean" and fishname ~= "dogfishocean"  and fishname ~= "swordfishjocean" and fishname ~= "swordfishjocean2" and fishname ~= "sharxocean")
		table.insert(prefs, fish)
		table.insert(prefs, cooked)
		if seeds then
		--	table.insert(prefs, seeds)
		end
	end
	
	if fishdata.createPrefab == false then 	
		local fish, cooked, seeds = MakeFish(fishname, fishname ~= "fish2" and fishname ~= "fish3" and fishname ~= "fish4" and fishname ~= "fish5" and fishname ~= "fish6" and fishname ~= "fish7" and fishname ~= "coi" and fishname ~= "salmon" and fishname ~= "ballphinocean" and fishname ~= "mecfish" and fishname ~= "goldfish" and fishname ~= "whaleblueocean" and fishname ~= "dogfishocean"  and fishname ~= "swordfishjocean" and fishname ~= "swordfishjocean2" and fishname ~= "sharxocean" )
		table.insert(prefs, fish)
	end	
end

return unpack(prefs) 
