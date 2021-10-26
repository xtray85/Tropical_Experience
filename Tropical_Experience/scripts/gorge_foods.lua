local listadepratos =
{
	"gorge_meatballs",
	"meat_skewers",
	"stone_soup",
	"croquette",
	"roasted_veggies",
	"meatloaf",
	"carrot_soup",
	"fish_pie",
	"fish_and_chips",
	"meat_pie",
	"chips",
	"slider",
	"gorge_jam",
	"jelly_roll",
	"carrot_cake",
	"mashed_potatoes",
	"garlic_bread",
	"tomato_soup",
	"sausage",
	"candied_fish",
	"stuffed_mushroom",
	"veggie_soup",
	"gorge_ratatouille",
	"bruschetta",
	"meat_stew",
	"hamburger",
	"fish_burger",
	"mushroom_burger",
	"fish_steak",
	"curry",
	"spaghetti_and_meatballs",
	"lasagna",
	"jelly_sandwich",
	"poached_fish",
	"shepherds_pie",
	"candy",
	"pudding",
	"waffles",
	"berry_tart",
	"mac_n_cheese",
	"bagel_n_fish",
	"grilled_cheese",
	"cream_of_mushroom",
	"fish_stew",
	"pierogies",
	"manicotti",
	"cheeseburger",
	"fettuccine",
	"onion_soup",
	"breaded_cutlet",
	"creamy_fish",
	"pizza",
	"pot_roast",
	"crab_cake",
	"turnip_cake",
	"steak_frites",
	"shooter_sandwich",
	"bacon_wrapped_meat",
	"crab_roll",
	"meat_wellington",
	"crab_ravioli",
	"caramel_cube",
	"scone",
	"trifle",
	"cheesecake",
	"potato_pancakes",
	"potato_soup",
	"fishball_skewers",
}

local BERRY_PREFABS =
{
	"berries",
	"berries_cooked",
	"berries_juicy",
	"berries_juicy_cooked",
}

local FISH_PREFABS =
{
	"fish",
	"salmon",
	"crabmeat",
}

local FRUIT_PREFABS =
{
	"watermelon",
}

local function CountIngredient(data, ingredient)
	return data[ingredient] or 0
end

local function CountPrefabs(names, prefabs)
	local count = 0
	for i,v in ipairs(prefabs) do
		local inc = names[v] or 0
		count = count + inc
	end
	return count
end

local function CountPrefabsContaining(names, subs)
	local count = 0
	for k,v in pairs(names) do
		if string.find(k, subs) then
			count = count + v
		end
	end
	return count
end

local function CountMushroom(names)
	return CountPrefabsContaining(names, "mushroom")
end


local function CountCookedVeggie(names, tags)
	local count = 0
	for k,v in pairs(names) do
		if string.find(k, "_cooked") then
			count = count + v
		end
	end
	return math.min(count, tags.veggie or 0)
end

local function CountBerries(names)
	return CountPrefabs(names, BERRY_PREFABS)
end

local function CountFish(names)
	return CountPrefabs(names, FISH_PREFABS)
end

local function CountFruit(names)
	return CountPrefabs(names, FRUIT_PREFABS)
end

local function IsExclusiveTag(tags, tag)
	if not tags[tag] then
		return false
	end
	for k,v in pairs(tags) do
		if k ~= tag then
			return false
		end
	end
	return true
end

local function TotalCount(tags)
	local count = 0
	for _,v in pairs(tags) do
		count = count + v
	end
	return count
end

local preparedFoods = {
	bread = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 3 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 4 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"snack", "bread"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	gorge_meatballs = {
		oldname = "meatballs",
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.foliage and names.foliage >= 2 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 2 and tags.smallmeat and tags.smallmeat >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 3 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"meat", "snack"},
		tags = {"salty"},
		hunger = 62.5,
		sanity = 5.0,
		health = 3.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	meat_skewers = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 2 and names.twigs and names.twigs >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 3 and names.twigs and names.twigs >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and names.garlic and names.garlic >= 1 and names.twigs and names.twigs >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and names.onion and names.onion >= 1 and names.twigs and names.twigs >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and tags.mushroom and tags.mushroom >= 1 and names.twigs and names.twigs >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"snack", "meat"},
		tags = {"salty"},
		hunger = 40.0,
		sanity = 3.0,
		health = 15.0,
		perishtime = 4800.0,
		cooktime = 0.6666666666666666,
	},
	stone_soup = {
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 1 and names.foliage and names.foliage >= 1 and names.rocks and names.rocks >= 1 and TotalCount(names) == 3) or
			(names.foliage and names.foliage >= 1 and names.potato and names.potato >= 1 and names.rocks and names.rocks >= 1 and TotalCount(names) == 3) or
			(tags.mushroom and tags.mushroom >= 1 and names.potato and names.potato >= 1 and names.rocks and names.rocks >= 1 and TotalCount(names) == 3) or
			(CountBerries(names) >= 1 and names.potato and names.potato >= 1 and names.rocks and names.rocks >= 1 and TotalCount(names) == 3) or
			(names.foliage and names.foliage >= 1 and tags.mushroom and tags.mushroom >= 1 and names.rocks and names.rocks >= 1 and TotalCount(names) == 3)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"snack", "soup"},
		tags = {"salty"},
		hunger = 15.0,
		sanity = -10.0,
		health = -2.0,
		perishtime = 4800,
		cooktime = 0.6666666666666666,
	},
	croquette = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and tags.flour and tags.flour >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and names.potato and names.potato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and names.onion and names.onion >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"snack", "veggie"},
		tags = {"salty"},
		hunger = 30.0,
		sanity = 5.0,
		health = 10.0,
		perishtime = 7200.0,
		cooktime = 1.3333333333333333,
	},
	roasted_veggies = {
		test = function(cooker, names, tags)
			return (tags.mushroom and tags.mushroom >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(tags.mushroom and tags.mushroom >= 2 and names.potato and names.potato >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and names.potato and names.potato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(names.onion and names.onion >= 1 and names.potato and names.potato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven", "grill"},
		cravings = {"veggie"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = 10.0,
		health = 3.0,
		perishtime = 2400.0,
		cooktime = 0.6666666666666666,
	},
	meatloaf = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 2 and tags.smallmeat and tags.smallmeat >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.foliage and names.foliage >= 2 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 3 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 45.0,
		sanity = 5.0,
		health = 3.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	carrot_soup = {
		test = function(cooker, names, tags)
			return (names.carrot and names.carrot >= 3 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 2 and names.garlic and names.garlic >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 4 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 3 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"veggie", "snack", "soup"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 3.0,
		health = 15.0,
		perishtime = 2400.0,
		cooktime = 1.3333333333333333,
	},
	fish_pie = {
		test = function(cooker, names, tags)
			return (names.carrot and names.carrot >= 1 and tags.flour and tags.flour >= 1 and tags.fish and tags.fish >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and tags.fish and tags.fish >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and tags.fish and tags.fish >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and names.onion and names.onion >= 1 and tags.fish and tags.fish >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and tags.fish and tags.fish >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"fish"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 5.0,
		health = 10.0,
		perishtime = 2400.0,
		cooktime = 2.0,
	},
	fish_and_chips = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and names.potato and names.potato >= 1 and tags.fish and tags.fish >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and names.potato and names.potato >= 1 and tags.fish and tags.fish >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and names.potato and names.potato >= 1 and tags.fish and tags.fish >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and names.potato and names.potato >= 2 and tags.fish and tags.fish >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 12, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 2, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 3, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"fish"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = -3.0,
		health = 0.0,
		perishtime = 9600.0,
		cooktime = 0.6666666666666666,
	},
	meat_pie = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.onion and names.onion >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 12, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 2, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 3, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 55.0,
		sanity = 3.0,
		health = 10.0,
		perishtime = 7200.0,
		cooktime = 2.0,
	},
	chips = {
		test = function(cooker, names, tags)
			return (names.potato and names.potato >= 3 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 3 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"veggie", "snack"},
		tags = {"salty"},
		hunger = 20.0,
		sanity = 2.0,
		health = 1.0,
		perishtime = 9600.0,
		cooktime = 0.6666666666666666,
	},
	slider = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 2 and tags.flour and tags.flour >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 2 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 12, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 2, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 3, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"bread", "snack", "meat"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	gorge_jam = {
		oldname = "jam",
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 3 and TotalCount(names) == 3) or
			(CountBerries(names) >= 4 and TotalCount(names) == 4) or
			(CountBerries(names) >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 3) or
			(CountBerries(names) >= 3 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4) or
			(CountBerries(names) >= 2 and names.syrup and names.syrup >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 0, coin2 = 1, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"sweet", "snack"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	jelly_roll = {
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 2 and tags.flour and tags.flour >= 1 and TotalCount(names) == 3) or
			(CountBerries(names) >= 2 and tags.flour and tags.flour >= 2 and TotalCount(names) == 4) or
			(CountBerries(names) >= 3 and tags.flour and tags.flour >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 2, coin2 = 1, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = 5.0,
		health = 3.0,
		perishtime = 2400.0,
		cooktime = 0.9333333333333333,
	},
	carrot_cake = {
		test = function(cooker, names, tags)
			return (names.carrot and names.carrot >= 1 and tags.flour and tags.flour >= 2 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 2 and tags.flour and tags.flour >= 2 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 1 and tags.flour and tags.flour >= 2 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 1 and tags.flour and tags.flour >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 1, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 2, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 3, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 30.0,
		sanity = 10.0,
		health = 8.0,
		perishtime = 3840.0,
		cooktime = 1.2,
	},
	mashed_potatoes = {
		test = function(cooker, names, tags)
			return (names.garlic and names.garlic >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(names.garlic and names.garlic >= 1 and names.potato and names.potato >= 3 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 1, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 5, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"snack", "veggie"},
		tags = {"salty"},
		hunger = 45.0,
		sanity = 0.0,
		health = 0.0,
		perishtime = 3360.0,
		cooktime = 0.9333333333333333,
	},
	garlic_bread = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 2 and names.garlic and names.garlic >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 2 and names.garlic and names.garlic >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 3 and names.garlic and names.garlic >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 1, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 5, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"snack", "bread"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = -5.0,
		health = 20.0,
		perishtime = 8160.0,
		cooktime = 1.0666666666666667,
	},
	tomato_soup = {
		test = function(cooker, names, tags)
			return (names.tomato and names.tomato >= 3 and TotalCount(names) == 3) or
			(names.garlic and names.garlic >= 1 and names.tomato and names.tomato >= 2 and TotalCount(names) == 3) or
			(tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 2 and TotalCount(names) == 3) or
			(names.tomato and names.tomato >= 4 and TotalCount(names) == 4) or
			(tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 3 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 1, coin3 = 0, coin4 = 0}, silver = {coin1 = 6, coin2 = 5, coin3 = 0, coin4 = 0}, gold = {coin1 = 8, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"veggie", "soup", "snack"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 5.0,
		health = 15.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	sausage = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.foliage and names.foliage >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and tags.smallmeat and tags.smallmeat >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 1, coin3 = 0, coin4 = 0}, silver = {coin1 = 6, coin2 = 5, coin3 = 0, coin4 = 0}, gold = {coin1 = 8, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"snack", "meat"},
		tags = {"salty"},
		hunger = 48.0,
		sanity = 3.0,
		health = 5.0,
		perishtime = 4800.0,
		cooktime = 1.7333333333333334,
	},
	candied_fish = {
		test = function(cooker, names, tags)
			return (tags.fish and tags.fish >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 3) or
			(tags.fish and tags.fish >= 1 and names.syrup and names.syrup >= 2 and TotalCount(names) == 3) or
			(tags.fish and tags.fish >= 2 and names.syrup and names.syrup >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 4, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"snack", "fish"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = 25.0,
		health = -4.0,
		perishtime = 12000.0,
		cooktime = 1.3333333333333333,
	},
	stuffed_mushroom = {
		test = function(cooker, names, tags)
			return (names.garlic and names.garlic >= 1 and tags.mushroom and tags.mushroom >= 1 and names.onion and names.onion >= 1 and TotalCount(names) == 3) or
			(names.garlic and names.garlic >= 1 and tags.mushroom and tags.mushroom >= 2 and names.onion and names.onion >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 4, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"snack", "veggie"},
		tags = {"salty"},
		hunger = 30.0,
		sanity = -2.0,
		health = -2.0,
		perishtime = 2400.0,
		cooktime = 0.4,
	},
	veggie_soup = {
		test = function(cooker, names, tags)
			return (tags.mushroom and tags.mushroom >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(tags.mushroom and tags.mushroom >= 2 and names.potato and names.potato >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and names.potato and names.potato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 2 and names.turnip and names.turnip >= 1 and TotalCount(names) == 3)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"veggie", "snack", "soup"},
		tags = {"salty"},
		hunger = 1.0,
		sanity = 5.0,
		health = 10.0,
		perishtime = 2400.0,
		cooktime = 2.0,
	},
	gorge_ratatouille = {
		oldname = "ratatouille",
		test = function(cooker, names, tags)
			return (names.carrot and names.carrot >= 1 and names.potato and names.potato >= 1 and names.tomato and names.tomato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 1 and names.onion and names.onion >= 1 and names.potato and names.potato >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(names.onion and names.onion >= 1 and names.potato and names.potato >= 1 and names.tomato and names.tomato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4) or
			(tags.mushroom and tags.mushroom >= 1 and names.onion and names.onion >= 1 and names.potato and names.potato >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 1 and names.onion and names.onion >= 1 and names.tomato and names.tomato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 4, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"veggie"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	bruschetta = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and names.tomato and names.tomato >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and names.tomato and names.tomato >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and tags.dairy and tags.dairy >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and tags.dairy and tags.dairy >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"veggie", "bread", "snack"},
		tags = {"salty"},
		hunger = 20.0,
		sanity = 2.0,
		health = 0.0,
		perishtime = 2400.0,
		cooktime = 0.5333333333333333,
	},
	meat_stew = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 4 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and names.onion and names.onion >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and names.potato and names.potato >= 2 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 2 and tags.smallmeat and tags.smallmeat >= 2 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 1 and tags.smallmeat and tags.smallmeat >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"meat", "soup"},
		tags = {"salty"},
		hunger = 55.0,
		sanity = 3.0,
		health = 10.0,
		perishtime = 7200.0,
		cooktime = 2.0,
	},
	hamburger = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 2 and names.foliage and names.foliage >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 3 and tags.flour and tags.flour >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and tags.flour and tags.flour >= 2 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"bread", "meat"},
		tags = {"salty"},
		hunger = 120.0,
		sanity = -4.0,
		health = -2.0,
		perishtime = 7200.0,
		cooktime = 1.6,
	},
	fish_burger = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 2 and tags.fish and tags.fish >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.fish and tags.fish >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and tags.fish and tags.fish >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"fish", "bread"},
		tags = {"salty"},
		hunger = 100.0,
		sanity = -2.0,
		health = 0.0,
		perishtime = 7200.0,
		cooktime = 1.6,
	},
	mushroom_burger = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and tags.mushroom and tags.mushroom >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and tags.mushroom and tags.mushroom >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and names.garlic and names.garlic >= 1 and tags.mushroom and tags.mushroom >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 3 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"veggie", "bread"},
		tags = {"salty"},
		hunger = 80.0,
		sanity = -6.0,
		health = 0.0,
		perishtime = 7200.0,
		cooktime = 1.6,
	},
	fish_steak = {
		test = function(cooker, names, tags)
			return (names.carrot and names.carrot >= 1 and names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and names.potato and names.potato >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and names.onion and names.onion >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"fish"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 5.0,
		health = 10.0,
		perishtime = 2400.0,
		cooktime = 2.0,
	},
	curry = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and names.garlic and names.garlic >= 1 and tags.spice and tags.spice >= 2 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 2 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.spice and tags.spice >= 2 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.onion and names.onion >= 1 and tags.spice and tags.spice >= 2 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.spice and tags.spice >= 2 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"soup", "meat"},
		tags = {"salty"},
		hunger = 15.0,
		sanity = 0.0,
		health = 30.0,
		perishtime = 2400.0,
		cooktime = 1.0666666666666667,
	},
	spaghetti_and_meatballs = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.onion and names.onion >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"meat", "pasta"},
		tags = {"salty"},
		hunger = 150.0,
		sanity = 3.0,
		health = 3.0,
		perishtime = 3360.0,
		cooktime = 2.2666666666666666,
	},
	lasagna = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.onion and names.onion >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"pasta", "meat"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	jelly_sandwich = {
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 2 and tags.flour and tags.flour >= 1 and TotalCount(names) == 3) or
			(CountBerries(names) >= 1 and tags.flour and tags.flour >= 1 and names.syrup and names.syrup >= 1 and TotalCount(names) == 3) or
			(CountBerries(names) >= 2 and tags.flour and tags.flour >= 2 and TotalCount(names) == 4) or
			(CountBerries(names) >= 3 and tags.flour and tags.flour >= 1 and TotalCount(names) == 4) or
			(CountBerries(names) >= 1 and tags.flour and tags.flour >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"snack", "bread"},
		tags = {"salty"},
		hunger = 20.0,
		sanity = 0.0,
		health = 2.0,
		perishtime = 2400.0,
		cooktime = 0.6666666666666666,
	},
	poached_fish = {
		test = function(cooker, names, tags)
			return (names.carrot and names.carrot >= 1 and names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and names.potato and names.potato >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and tags.mushroom and tags.mushroom >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(names.foliage and names.foliage >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"fish"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 10.0,
		health = 5.0,
		perishtime = 5760.0,
		cooktime = 0.8,
	},
	shepherds_pie = {
		test = function(cooker, names, tags)
			return (names.carrot and names.carrot >= 1 and tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.onion and names.onion >= 1 and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.garlic and names.garlic >= 1 and names.onion and names.onion >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and names.garlic and names.garlic >= 1 and names.potato and names.potato >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 2, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 50.0,
		sanity = 2.0,
		health = 2.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	candy = {
		test = function(cooker, names, tags)
			return (names.syrup and names.syrup >= 3 and TotalCount(names) == 3) or
			(names.syrup and names.syrup >= 4 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 2, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 6, coin2 = 5, coin3 = 0, coin4 = 0}, gold = {coin1 = 8, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 15.0,
		sanity = 0.0,
		health = 30.0,
		perishtime = 2400.0,
		cooktime = 1.0666666666666667,
	},
	pudding = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 3) or
			(CountBerries(names) >= 1 and tags.flour and tags.flour >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 3 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and names.syrup and names.syrup >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and tags.spice and tags.spice >= 1 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 4, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = 20.0,
		health = -5.0,
		perishtime = 1920.0,
		cooktime = 3.3333333333333335,
	},
	waffles = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 3 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 2 and names.syrup and names.syrup >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 4, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	berry_tart = {
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 1 and tags.flour and tags.flour >= 1 and names.syrup and names.syrup >= 1 and TotalCount(names) == 3) or
			(CountBerries(names) >= 2 and tags.flour and tags.flour >= 1 and names.syrup and names.syrup >= 1 and TotalCount(names) == 4) or
			(CountBerries(names) >= 1 and tags.flour and tags.flour >= 1 and names.syrup and names.syrup >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 6, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 15.0,
		sanity = 5.0,
		health = -1.0,
		perishtime = 1920.0,
		cooktime = 0.6666666666666666,
	},
	mac_n_cheese = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 2 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 2 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 2 and tags.dairy and tags.dairy >= 2 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 10, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"pasta", "cheese"},
		tags = {"salty"},
		hunger = 30.0,
		sanity = -5.0,
		health = 0.0,
		perishtime = 3840.0,
		cooktime = 1.0666666666666667,
	},
	bagel_n_fish = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.onion and names.onion >= 1 and tags.fish and tags.fish >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 10, coin3 = 0, coin4 = 1}, gold = {coin1 = 9, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"snack", "fish", "bread"},
		tags = {"salty"},
		hunger = 38.0,
		sanity = -2.0,
		health = 2.0,
		perishtime = 4800.0,
		cooktime = 1.8666666666666667,
	},
	grilled_cheese = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 2 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 2 and TotalCount(names) == 3) or
			(tags.flour and tags.flour >= 2 and tags.dairy and tags.dairy >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 10, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"snack", "bread", "cheese"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = 0.0,
		health = -8.0,
		perishtime = 4320.0,
		cooktime = 0.4,
	},
	cream_of_mushroom = {
		test = function(cooker, names, tags)
			return (tags.dairy and tags.dairy >= 1 and tags.mushroom and tags.mushroom >= 2 and TotalCount(names) == 3) or
			(tags.dairy and tags.dairy >= 2 and tags.mushroom and tags.mushroom >= 1 and TotalCount(names) == 3) or
			(tags.dairy and tags.dairy >= 2 and tags.mushroom and tags.mushroom >= 2 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 5, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 10, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"veggie", "snack", "soup", "cheese"},
		tags = {"salty"},
		hunger = 20.0,
		sanity = -7.0,
		health = 7.0,
		perishtime = 2400.0,
		cooktime = 0.9333333333333333,
	},
	fish_stew = {
		test = function(cooker, names, tags)
			return (tags.fish and tags.fish >= 3 and TotalCount(names) == 3) or
			(names.foliage and names.foliage >= 2 and tags.fish and tags.fish >= 1 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 2 and tags.fish and tags.fish >= 1 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 1 and tags.fish and tags.fish >= 2 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 2 and tags.fish and tags.fish >= 1 and TotalCount(names) == 3)
		end,
		platetype = "bowl",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"soup", "fish"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 5.0,
		health = 10.0,
		perishtime = 2400.0,
		cooktime = 2.0,
	},
	pierogies = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 3) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 2 and names.potato and names.potato >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 4, coin2 = 6, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 11, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"veggie", "cheese"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	manicotti = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and tags.dairy and tags.dairy >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and tags.dairy and tags.dairy >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 2 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 6, coin3 = 0, coin4 = 0}, silver = {coin1 = 6, coin2 = 11, coin3 = 0, coin4 = 0}, gold = {coin1 = 8, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"cheese", "pasta"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 10.0,
		health = 10.0,
		perishtime = 3360.0,
		cooktime = 0.9333333333333333,
	},
	cheeseburger = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.onion and names.onion >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.smallmeat and tags.smallmeat >= 2 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 6, coin2 = 6, coin3 = 0, coin4 = 0}, silver = {coin1 = 6, coin2 = 11, coin3 = 0, coin4 = 0}, gold = {coin1 = 8, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"meat", "cheese", "bread"},
		tags = {"salty"},
		hunger = 60.0,
		sanity = -2.0,
		health = -8.0,
		perishtime = 4800.0,
		cooktime = 1.3333333333333333,
	},
	fettuccine = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and tags.dairy and tags.dairy >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 6, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"pasta"},
		tags = {"salty"},
		hunger = 45.0,
		sanity = 5.0,
		health = 10.0,
		perishtime = 3840.0,
		cooktime = 2.0,
	},
	onion_soup = {
		test = function(cooker, names, tags)
			return (tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.onion and names.onion >= 2 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 6, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"soup", "veggie", "snack"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = -5.0,
		health = 5.0,
		perishtime = 2880.0,
		cooktime = 0.9333333333333333,
	},
	breaded_cutlet = {
		test = function(cooker, names, tags)
			return (tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 6, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 55.0,
		sanity = 0.0,
		health = 0.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	creamy_fish = {
		test = function(cooker, names, tags)
			return (names.garlic and names.garlic >= 1 and tags.dairy and tags.dairy >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.dairy and tags.dairy >= 2 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.dairy and tags.dairy >= 1 and names.onion and names.onion >= 1 and tags.fish and tags.fish >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 6, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"fish"},
		tags = {"salty"},
		hunger = 50.0,
		sanity = 2.0,
		health = 0.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	pizza = {
		test = function(cooker, names, tags)
			return (tags.smallmeat and tags.smallmeat >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 4, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"cheese", "meat"},
		tags = {"salty"},
		hunger = 140.0,
		sanity = 2.0,
		health = -10.0,
		perishtime = 3840.0,
		cooktime = 2.6666666666666665,
	},
	pot_roast = {
		test = function(cooker, names, tags)
			return (tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and tags.mushroom and tags.mushroom >= 1 and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and names.carrot and names.carrot >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.spice and tags.spice >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and names.garlic and names.garlic >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and names.carrot and names.carrot >= 1 and tags.spice and tags.spice >= 1 and names.turnip and names.turnip >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 4, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 150.0,
		sanity = 0.0,
		health = -6.0,
		perishtime = 7200.0,
		cooktime = 2.6666666666666665,
	},
	crab_cake = {
		test = function(cooker, names, tags)
			return (tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and names.onion and names.onion >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 2 and tags.flour and tags.flour >= 1 and names.potato and names.potato >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 2 and tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 13,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 4, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 5, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 7, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"snack"},
		tags = {"salty"},
		hunger = 30.0,
		sanity = 30.0,
		health = 5.0,
		perishtime = 2400.0,
		cooktime = 0.9333333333333333,
	},
	turnip_cake = {
		test = function(cooker, names, tags)
			return (names.turnip and names.turnip >= 3 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and names.turnip and names.turnip >= 2 and TotalCount(names) == 3) or
			(names.onion and names.onion >= 1 and names.turnip and names.turnip >= 2 and TotalCount(names) == 3) or
			(names.turnip and names.turnip >= 4 and TotalCount(names) == 4) or
			(names.carrot and names.carrot >= 1 and names.turnip and names.turnip >= 3 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"snack", "veggie"},
		tags = {"salty"},
		hunger = 30.0,
		sanity = 3.0,
		health = 20.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	steak_frites = {
		test = function(cooker, names, tags)
			return (tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and names.potato and names.potato >= 2 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and names.potato and names.potato >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and names.potato and names.potato >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 6, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 16, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 22, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 150.0,
		sanity = 0.0,
		health = 0.0,
		perishtime = 6240.0,
		cooktime = 2.0,
	},
	shooter_sandwich = {
		test = function(cooker, names, tags)
			return (tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 2, coin2 = 16, coin3 = 0, coin4 = 0}, gold = {coin1 = 4, coin2 = 22, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"meat", "bread"},
		tags = {"salty"},
		hunger = 70.0,
		sanity = 0.0,
		health = 5.0,
		perishtime = 9600.0,
		cooktime = 0.8,
	},
	bacon_wrapped_meat = {
		test = function(cooker, names, tags)
			return (tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.smallmeat and tags.smallmeat >= 2 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.smallmeat and tags.smallmeat >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and tags.smallmeat and tags.smallmeat >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 8, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 16, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 22, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 160.0,
		sanity = -5.0,
		health = -10.0,
		perishtime = 8160.0,
		cooktime = 2.0,
	},
	crab_roll = {
		test = function(cooker, names, tags)
			return (tags.crab and tags.crab >= 2 and tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and names.foliage and names.foliage >= 1 and names.onion and names.onion >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 2 and tags.flour and tags.flour >= 1 and names.tomato and names.tomato >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 2 and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 13,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 4, coin2 = 11, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 16, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 22, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"bread"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	meat_wellington = {
		test = function(cooker, names, tags)
			return (tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 2 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and tags.mushroom and tags.mushroom >= 1 and TotalCount(names) == 4) or
			(tags.bigmeat and tags.bigmeat >= 1 and (not tags.monster or tags.monster <= 1) and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 4, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 16, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 22, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"meat"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	crab_ravioli = {
		test = function(cooker, names, tags)
			return (tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and tags.mushroom and tags.mushroom >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and names.garlic and names.garlic >= 1 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and names.onion and names.onion >= 1 and TotalCount(names) == 4) or
			(tags.crab and tags.crab >= 2 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 13,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 6, coin2 = 11, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"cheese", "pasta"},
		tags = {"salty"},
		hunger = 60.0,
		sanity = 15.0,
		health = 6.0,
		perishtime = 3360.0,
		cooktime = 1.8666666666666667,
	},
	caramel_cube = {
		test = function(cooker, names, tags)
			return (tags.dairy and tags.dairy >= 2 and names.syrup and names.syrup >= 1 and TotalCount(names) == 3) or
			(tags.dairy and tags.dairy >= 1 and names.syrup and names.syrup >= 2 and TotalCount(names) == 3) or
			(tags.dairy and tags.dairy >= 2 and names.syrup and names.syrup >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 2, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 10, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 10, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = 30.0,
		health = -5.0,
		perishtime = 2880.0,
		cooktime = 0.8,
	},
	scone = {
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 1 and tags.flour and tags.flour >= 2 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 4, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 11, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"sweet", "bread"},
		tags = {"salty"},
		hunger = 20,
		sanity = 5,
		health = 5,
		perishtime = 4800,
		cooktime = 2.5,
	},
	trifle = {
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 1 and tags.flour and tags.flour >= 2 and tags.dairy and tags.dairy >= 1 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 6, coin2 = 10, coin3 = 0, coin4 = 0}, silver = {coin1 = 6, coin2 = 11, coin3 = 0, coin4 = 0}, gold = {coin1 = 8, coin2 = 12, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"sweet"},
		tags = {"salty"},
		hunger = 20.0,
		sanity = 35.0,
		health = -6.0,
		perishtime = 1920.0,
		cooktime = 0.5333333333333333,
	},
	cheesecake = {
		test = function(cooker, names, tags)
			return (CountBerries(names) >= 1 and tags.flour and tags.flour >= 1 and tags.dairy and tags.dairy >= 2 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 2, coin2 = 11, coin3 = 0, coin4 = 0}, silver = {coin1 = 3, coin2 = 15, coin3 = 0, coin4 = 0}, gold = {coin1 = 5, coin2 = 20, coin3 = 0, coin4 = 0}},
		cookers = {"oven"},
		cravings = {"cheese", "sweet"},
		tags = {"salty"},
		hunger = 25.0,
		sanity = 35.0,
		health = -8.0,
		perishtime = 1440.0,
		cooktime = 0.4,
	},
	potato_pancakes = {
		test = function(cooker, names, tags)
			return (names.potato and names.potato >= 3 and TotalCount(names) == 3) or
			(names.onion and names.onion >= 1 and names.potato and names.potato >= 2 and TotalCount(names) == 3) or
			(names.onion and names.onion >= 1 and names.potato and names.potato >= 3 and TotalCount(names) == 4)
		end,
		platetype = "plate",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 8, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 4, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 6, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"snack", "veggie"},
		tags = {"salty"},
		hunger = 50.0,
		sanity = 10.0,
		health = 50.0,
		perishtime = 4800.0,
		cooktime = 2.6666666666666665,
	},
	potato_soup = {
		test = function(cooker, names, tags)
			return (names.potato and names.potato >= 3 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 4 and TotalCount(names) == 4) or
			(names.potato and names.potato >= 2 and tags.spice and tags.spice >= 1 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 3 and tags.spice and tags.spice >= 1 and TotalCount(names) == 4)
		end,
		platetype = "bowl",
		priority = 11,
		foodtype = FOODTYPE.VEGGIE,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"pot"},
		cravings = {"veggie", "snack", "soup"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 5.0,
		health = 15.0,
		perishtime = 4800.0,
		cooktime = 2.0,
	},
	fishball_skewers = {
		test = function(cooker, names, tags)
			return (tags.fish and tags.fish >= 2 and names.twigs and names.twigs >= 1 and TotalCount(names) == 3) or
			(names.potato and names.potato >= 1 and tags.fish and tags.fish >= 1 and names.twigs and names.twigs >= 1 and TotalCount(names) == 3) or
			(names.carrot and names.carrot >= 1 and tags.fish and tags.fish >= 1 and names.twigs and names.twigs >= 1 and TotalCount(names) == 3) or
			(names.onion and names.onion >= 1 and tags.fish and tags.fish >= 1 and names.twigs and names.twigs >= 1 and TotalCount(names) == 3) or
			(tags.fish and tags.fish >= 1 and names.turnip and names.turnip >= 1 and names.twigs and names.twigs >= 1 and TotalCount(names) == 3)
		end,
		platetype = "plate",
		priority = 12,
		foodtype = FOODTYPE.MEAT,
		reward = {generic = {coin1 = 10, coin2 = 0, coin3 = 0, coin4 = 0}, silver = {coin1 = 7, coin2 = 1, coin3 = 0, coin4 = 0}, gold = {coin1 = 9, coin2 = 2, coin3 = 0, coin4 = 0}},
		cookers = {"grill"},
		cravings = {"fish", "snack"},
		tags = {"salty"},
		hunger = 35.0,
		sanity = 3.0,
		health = 25.0,
		perishtime = 4800.0,
		cooktime = 0.6666666666666666,
	},
}

for k,v in pairs(preparedFoods) do
	v.name = k
	v.weight = v.weight or 1
	v.priority = v.priority or 0
end

return preparedFoods
