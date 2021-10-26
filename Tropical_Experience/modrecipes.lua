
-- Globals
local Recipe = GLOBAL.Recipe
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH



	-- Light Tab
AddRecipe("flare",
		{Ingredient("iron_ore",1, "images/inventoryimages/iron_ore.xml"), Ingredient("twigs",2)},
		RECIPETABS.LIGHT,
		TECH.SCIENCE_ONE,
		nil,
		nil,
		false,
		1,
		nil,
"images/inventoryimages/flare.xml")


AddRecipe("jelly_lantern", 
		{Ingredient("twigs", 3), Ingredient("rope", 2),Ingredient("jelly_cap", 1, "images/inventoryimages/jelly_cap.xml")}, 
		RECIPETABS.LIGHT, 
		TECH.SCIENCE_TWO,
		nil,
		nil,
		false,
		1,
		nil,
"images/inventoryimages/jelly_lantern.xml")

	-- Survival tab

AddRecipe("snorkel", 
		{Ingredient("tentaclespots", 2),Ingredient("silk", 2), Ingredient("mosquitosack", 4)}, 
		RECIPETABS.SURVIVAL, 
		TECH.SCIENCE_ONE,	
		nil,
		nil,
		false,
		1,
		nil,
"images/inventoryimages/snorkel.xml")

AddRecipe("hat_submarine", 
		{Ingredient("tentaclespots", 5),Ingredient("iron_ore",4, "images/inventoryimages/iron_ore.xml"), Ingredient("mosquitosack", 4)}, 
		RECIPETABS.SURVIVAL, 
		TECH.SCIENCE_TWO,	
		nil,
		nil,
		false,
		1,
		nil,
"images/inventoryimages/creepindedeepinventory.xml")

	-- Magic tab
AddRecipe("pearl_amulet", 
		{Ingredient("pearl", 3, "images/inventoryimages/pearl.xml"),Ingredient("coral_cluster", 3, "images/inventoryimages/coral_cluster.xml")}, 
		RECIPETABS.MAGIC, 
		TECH.MAGIC_TWO,	
		nil,
		nil,
		nil,
		nil,
		nil,
"images/inventoryimages/pearl_amulet.xml")

	-- Dress tab
AddRecipe("diving_suit_summer", 
		{Ingredient("trunk_summer", 1),Ingredient("silk", 8),Ingredient("sponge_piece", 4, "images/inventoryimages/sponge_piece.xml")}, 
		RECIPETABS.DRESS, 
		TECH.SCIENCE_ONE,	
		nil,
		nil,
		nil,
		nil,
		nil,
"images/inventoryimages/diving_suit_summer.xml")

AddRecipe("diving_suit_winter", 
		{Ingredient("trunk_winter", 1),Ingredient("silk", 8),Ingredient("sponge_piece", 4, "images/inventoryimages/sponge_piece.xml")},
		RECIPETABS.DRESS, 
		TECH.SCIENCE_TWO,	
		nil,
		nil,
		nil,
		nil,
		nil,
"images/inventoryimages/diving_suit_winter.xml")

AddRecipe("coral_cluster", 
		{Ingredient("cut_orange_coral", 3, "images/inventoryimages/cut_orange_coral.xml"),Ingredient("cut_blue_coral", 3, "images/inventoryimages/cut_blue_coral.xml"),Ingredient("cut_green_coral", 3, "images/inventoryimages/cut_green_coral.xml")},
		RECIPETABS.REFINE, 
		TECH.SCIENCE_ONE,	
		nil,
		nil,
		nil,
		nil,
		nil,
"images/inventoryimages/coral_cluster.xml")
