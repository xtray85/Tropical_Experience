require "prefabutil"

local internaltreasure =
{
	["TestTreasure"] =
	{
		{
			--Set piece with the treasure prefab
			treasure_set_piece = "BuriedTreasureLayout",

			--The treasure prefab itself. If treasure_set_piece is set this is the prefab
			--inside the set piece. If treasure_set_piece is not set this prefab will be spawned
			--during worldgen
			treasure_prefab = "buriedtreasure",

			--Set piece with the map prefab, only for the first stage in multi stage treasures
			map_set_piece = "TreasureHunterBoon",

			--currently unused
			map_prefab = "messagebottle",

			--Reference to the loot table for the treasure when it is dug up
			loot = "snaketrap"
		}
	},
	["PirateBank"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "10dubloons",
		}
	},

	["Supertelescope"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Supertelescope",
		}
	},

	["WoodlegsKey1"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "WoodlegsKey1",
		}
	},

	["WoodlegsKey2"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "WoodlegsKey2",
		}
	},

	["WoodlegsKey3"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "WoodlegsKey3",
		}
	},

	["PiratePeanuts"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "1dubloon",
		}
	},
	
	["minerhat"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "minerhat",
		}

	},

	["RandomGem"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "gems",
		}
	},

	
	["DubloonsGem"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "dubloonsandgem",
		}
	},


	["SeamansCarePackage"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "seamanscarepackage",
		}
	},

	["ChickenOfTheSea"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "ChickenOfTheSea",
		}
	},

		["BootyInDaBooty"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "BootyInDaBooty",
		}
	},

		["OneTrueEarring"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "OneTrueEarring",
		}
	},

		["PegLeg"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "PegLeg",
		}
	},

		["VolcanoStaff"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "VolcanoStaff",
		}
	},

		["Gladiator"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Gladiator",
		}
	},

		["FancyHandyMan"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "FancyHandyMan",
		}
	},

		["LobsterMan"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "LobsterMan",
		}
	},

		["Compass"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Compass",
		}
	},

		["Scientist"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Scientist",
		}
	},	

		["Alchemist"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Alchemist",
		}
	},	

		["Shaman"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Shaman",
		}
	},	

		["FireBrand"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "FireBrand",
		}
	},

		["SailorsDelight"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "SailorsDelight",
		}
	},		

		["WarShip"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "WarShip",
		}
	},	

		["Desperado"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Desperado",
		}
	},	

		["JewelThief"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "JewelThief",
		}
	},	

		["AntiqueWarrior"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "AntiqueWarrior",
		}
	},	

		["Yaar"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Yaar",
		}
	},	

		["GdayMate"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "GdayMate",
		}
	},

		["ToxicAvenger"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "ToxicAvenger",
		}
	},

		["MadBomber"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "MadBomber",
		}
	},

		["FancyAdventurer"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "FancyAdventurer",
		}
	},

		["ThunderBall"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "ThunderBall",
		}
	},

		["TombRaider"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "TombRaider",
		}
	},

		["SteamPunk"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "SteamPunk",
		}
	},

		["CapNCrunch"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "CapNCrunch",
		}
	},

		["AyeAyeCapn"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "AyeAyeCapn",
		}
	},

		["BreakWind"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "BreakWind",
		}
	},

		["Diviner"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "Diviner",
		}
	},

		["GoesComesAround"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "GoesComesAround",
		}
	},

		["GoldGoldGold"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "GoldGoldGold",
		}
	},

		["FirePoker"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "FirePoker",
		}
	},

		["DeadmansTreasure"] =
	{
		{
			treasure_set_piece = "RockSkull",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "DeadmansTreasure",
		}
	},

	["TestMultiStage"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "gems",
		},
	},
	
	["SeaPackageQuest"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "dubloonsandgem",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "seamanscarepackage",
		},
	},

	["TierQuest"] =
	{
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "seamanscarepackage",
		},
		{
			tier = 1,
		},
		{
			tier = 2,
		},
		{
			tier = 2,
		},
		{
			tier = 3,
		},
	}
}

-- everytime a tier chest is picked, it's removed from this list
local Tiers =
{
	[1] = {
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_blowdart",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_speargun",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_obsidian",
		},
	},
	----------------------------------------------------------------------
	[2] = {
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_blowdart",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_speargun",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_obsidian",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_dapper",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_speed",
		},
			
	},
	----------------------------------------------------------------------
	[3] = {
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "1dubloon",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_blowdart",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_speargun",
		},
		{
			treasure_set_piece = "BuriedTreasureLayout",
			treasure_prefab = "buriedtreasure",
			map_prefab = "messagebottle",
			loot = "slot_obsidian",
		},
	},
}

local internalloot =
{
	--[[
	["sample"] =
	{
		--[Optional] container that spawns with the loot in it see prefabs/treasurechest.lua
		--any prefab with a container component should work
		chest = "treasurechest",

		--All items in loot is given when a treasure is dug up	
		loot =
		{
			dubloon = 2,
			redgem = 4
		},

		--'num_random_loot' items are given from random_loot (a weighted table)
		num_random_loot = 1,
		random_loot =
		{
			purplegem = 1,
			orangegem = 1,
			yellowgem = 1,
			greengem = 1,
			redgem = 5,
			bluegem = 5,
		},

		--Every item in chance_loot has a custom chance of being given
		--Possible for nothing or everything to be given
		chance_loot =
		{
			dubloon = 0.25,
			goldnugget = 0.25,
			bluegem = 0.1
		},

		--A custom function used to give items
		custom_lootfn = function(lootlist) end
	},
	--]]
	["snaketrap"] =
	{
		loot =
		{
			snake = 3,
			dubloon = 3,
		},
		random_loot =
		{
			purplegem = 1,
			orangegem = 1,
			yellowgem = 1,
			greengem = 1,
			redgem = 5,
			bluegem = 5,
		},
	},

	["1dubloon"] =
	{
		loot =
		{
			dubloon = 1
		}
	},
	
	["3dubloons"] =
	{
		loot =
		{
			dubloon = 3
		}
	},
	
	["10dubloons"] =
	{
		loot =
		{
			dubloon = 10
		}
	},

	["Supertelescope"] =
	{
		loot =
		{
			supertelescope = 1,
			dubloon = 5,
			spear_poison = 1,
			boat_lantern = 1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

	},

	--Took the actual keys out of these now that they're granted in other ways. 
	--Don't want to remove the loot tables incase people have saved worlds with these loots set.

	["WoodlegsKey1"] =
	{
		loot =
		{
			dubloon = 10,
		}
	},

	["WoodlegsKey2"] =
	{
		loot =
		{
			dubloon = 10,
		}
	},

	["WoodlegsKey3"] =
	{
		loot =
		{
			dubloon = 10,
		}
	},

	["minerhat"] =
	{
		loot =
		{
			minerhat = 1,
			dubloon = 5,
			axeobsidian =1,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

	},

	["seamanscarepackage"] =
	{
		chest = "pandoraschest",
		loot =
		{
			dubloon = 5,
			telescope = 1,
			armor_lifejacket = 1,
			captainhat = 1
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

	},

	["gems"] =
	{
		chest = "treasurechest",
		loot =
		{
			goldnugget = 3,
		},

		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

			chance_loot =
		{
			purplegem = .5,
			orangegem = .25,
			yellowgem = .25,
			greengem = .25
		},
	},

	["dubloonsandgem"] =
	{
		loot =
		{
			dubloon = 5
		},
		random_loot =
		{
			purplegem = 1,
			redgem = 5,
			bluegem = 5,
		}
	},


	["ChickenOfTheSea"] =
	{

		loot =
		{
			dubloon = 5,
			tunacan = 5,
		},
	
		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

    },
-------------------------------------------------------DAN ADDED FROM HERE
["BootyInDaBooty"] =
	{
		loot =
		{
			dubloon = 5,
			piratepack = 1,
		},
	
		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["OneTrueEarring"] =
	{
		loot =
		{
			bluegem = 1,
		},
	
		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},
		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["PegLeg"] =
	{
		loot =
		{
			dubloon = 2,
			peg_leg = 1,
		},
	
		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["VolcanoStaff"] =
	{
		loot =
		{
			dubloon = 6,
			volcanostaff = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["Gladiator"] =
	{
		loot =
		{
			dubloon = 2,
			footballhat = 1,
			spear = 1,
			armor_seashell= 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["FancyHandyMan"] =
	{
		loot =
		{
			dubloon = 1,
			goldenaxe = 1,
			goldenshovel = 1,
			goldenpickaxe= 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["LobsterMan"] =
	{
		loot =
		{
			dubloon = 4,
			boat_lantern = 1,
			--seatrap = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["Compass"] =
	{
		loot =
		{
			dubloon = 3,
			compass = 1,
			boneshard = 2,
			messagebottleempty = 1,
			sand = 1,
		},
	
		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		}

	},

["Scientist"] =
	{
		loot =
		{
			dubloon = 3,
			transistor =1,
			gunpowder =3,
			heatrock = 1,
		},
	
		random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["Alchemist"] =
	{
		loot =
		{
			dubloon = 2,
			antidote = 1,
			healingsalve =3,
			blowdart_sleep = 2,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["Shaman"] =
	{
		loot =
		{
			dubloon = 1,
			nightsword =1,
			amulet =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["FireBrand"] =
	{
		loot =
		{
			dubloon = 2,
			axeobsidian =1,
			gunpowder =2,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["SailorsDelight"] =
	{
		loot =
		{
			dubloon = 4,
			clothsail =1,
			boatrepairkit =1,
			boat_lantern =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["WarShip"] =
	{
		loot =
		{
			dubloon = 3,
			coconade =3,
			boatcannon =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

["Desperado"] =
	{
		loot =
		{
			dubloon = 1,
			snakeskinhat =1,
			armor_snakeskin =1,
			--spear_launcher = 2,
			spear = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["JewelThief"] =
	{
		loot =
		{
			dubloon = 5,
			goldnugget =6,
			purplegem =2,
			redgem = 4,
			bluegem = 3,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		}

	},

	["AntiqueWarrior"] =
	{
		loot =
		{
			dubloon = 5,
			ruins_bat =1,
			ruinshat =1,
			armorruins = 1,
			bluegem = 2,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		}


	},

	["Yaar"] =
	{
		loot =
		{
			dubloon = 1,
			telescope =1,
			piratehat =1,
			boatcannon = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["GdayMate"] =
	{
		loot =
		{
			dubloon = 3,
			boomerang =1,
			snakeskin =3,
			strawhat = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},
	["ToxicAvenger"] =
	{
		loot =
		{
			dubloon = 1,
			--gashat =1,
			venomgland =3,
			spear_poison = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["MadBomber"] =
	{
		loot =
		{
			dubloon = 2,
			coconade =2,
			obsidianbomb =1,
			gunpowder = 2,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["FancyAdventurer"] =
	{
		loot =
		{
			dubloon = 4,
			goldenmachete =1,
			tophat =1,
			rope = 3,
			telescope = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		}



	},

	["ThunderBall"] =
	{
		loot =
		{
			dubloon = 6,
			--spear_launcher = 2,
			spear = 1,
			--blubbersuit =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["TombRaider"] =
	{
		loot =
		{
			dubloon = 4,
			boneshard =3,
			nightmarefuel =4,
			purplegem = 2,
			goldnugget = 3,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		}


	},

	["SteamPunk"] =
	{
		loot =
		{
			dubloon = 1,
			gears =4,
			transistor =2,
			telescope= 1,
			goldnugget = 2,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		}


	},

	["CapNCrunch"] =
	{
		loot =
		{
			dubloon = 4,
			piratehat =1,
			boatcannon =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

	["AyeAyeCapn"] =
	{
		loot =
		{
			dubloon = 1,
			captainhat =1,
			armor_lifejacket =1,
			tunacan =1,
			trawlnet =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		}



	},

	["BreakWind"] =
	{
		loot =
		{
			dubloon = 4,
			--armor_windbreaker = 1,
			obsidianmachete =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

		["Diviner"] =
	{
		loot =
		{
			dubloon = 4,
			--diviningrod =1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

		["GoesComesAround"] =
	{
		loot =
		{
			dubloon = 3,
			boomerang =1,
			trap_teeth =2,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

		["GoldGoldGold"] =
	{
		loot =
		{
			dubloon = 6,
			goldnugget = 5,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

		["FirePoker"] =
	{
		loot =
		{
			dubloon = 2,
			spear_obsidian = 1,
			armorobsidian = 1,
		},
	
	random_loot =
		{
			redgem = 1,
			bluegem = 1,
			papyrus = 1,
			tunacan = 1,
			blueprint = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			purplegem = .1,
			redgem = .25,
			bluegem = .25,
		}

	},

		["DeadmansTreasure"] =
	{
		loot =
		{
			dubloon = 4,
			boatrepairkit = 1,
			goldenmachete = 1,
			obsidianbomb = 3, --obsidiancoconade = 3,
		},
	
	random_loot =
		{
			fabric = 1,
			papyrus = 1,
			tunacan = 1,
			goldnugget = 1,
			gears = 1,
			purplegem = 1,
			redgem =1,
			bluegem =1,
			rope =1,

		},

		chance_loot =
		{
			harpoon = .1,
			boatcannon = .01,
			rope = .25,
		}

	},

-------------------------------GOOD LIST

	["staydry"] = 
	{
		loot = 
		{
			--palmleaf_umbrella = 1,
			armor_snakeskin = 1,
			snakeskinhat = 1,
		},
	},

	["gears"] = 
	{
		loot = 
		{
			gears = 5,
			
		},
	},

	["cooloff"] = 
	{
		loot = 
		{
			ice = 3,
			hawaiianshirt = 1,
			umbrella = 1,
		},
	},

	["birders"] = 
	{
		loot = 
		{
			birdtrap = 1,
			featherhat = 1,
			seeds = 4,
		},
	},

	["slot_anotherspin"] = 
	{
		loot = 
		{
			dubloon = 1,
		},
	},

	["slot_goldy"] = 
	{
		loot = 
		{
			goldnugget = 5,
		},
	},
	
	["slot_honeypot"] = 
	{
		loot = 
		{
			beehat = 1,
			bandage = 1,
			honey = 5,
		},
	},

	["slot_warrior1"] = 
	{
		loot = 
		{
			footballhat = 1,
			armorwood = 1,
			spear = 1,
		},
	},

	["slot_warrior2"] = 
	{
		loot = 
		{
			armormarble = 1,
			hambat = 1,
			blowdart_pipe = 1,
		},
	},

	["slot_warrior3"] = 
	{
		loot = 
		{
			trap_teeth = 1,
			armorgrass = 1,
			boomerang = 1,
		},
	},

	["slot_warrior4"] = 
	{
		loot = 
		{
			--spear_launcher = 1,
			spear_poison = 1,
			armor_seashell = 1,
			coconade= 1,
		},
	},

	["slot_scientist"] = 
	{
		loot = 
		{
			transistor = 3,
			heatrock = 1,
			gunpowder= 3,
		},
	},

	["slot_walker"] = 
	{
		loot = 
		{
			cane = 1,
			goldnugget= 3,
		},
	},

	["slot_gemmy"] = 
	{
		loot = 
		{
			redgem = 3,
			bluegem= 3,
		},
	},

	["slot_bestgem"] = 
	{
		loot = 
		{
			purplegem = 3,
		},
	},

	["slot_lifegiver"] = 
	{
		loot = 
		{
			amulet = 1,
			goldnugget = 3,
		},
	},

	["slot_chilledamulet"] = 
	{
		loot = 
		{
			blueamulet = 1,
			goldnugget = 3,
		},
	},

	["slot_icestaff"] = 
	{
		loot = 
		{
			icestaff = 1,
			goldnugget = 3,
		},
	},

	["slot_firestaff"] = 
	{
		loot = 
		{
			firestaff = 1,
			goldnugget = 3,
		},
	},

	["slot_coolasice"] = 
	{
		loot = 
		{
			icehat = 1,
			doydoyfan = 1,
		--	palmleaf_umbrella = 1,
		},
	},

	["slot_gunpowder"] = 
	{
		loot = 
		{
			gunpowder = 5,
		},
	},

	["slot_darty"] = 
	{
		loot = 
		{
			blowdart_pipe = 1,
			blowdart_sleep = 1,
			blowdart_fire = 1,
		},
	},

	["slot_firedart"] = 
	{
		loot = 
		{
			blowdart_fire = 3,
			goldnugget = 3,
		},
	},

	["slot_sleepdart"] = 
	{
		loot = 
		{
			blowdart_sleep = 3,
			goldnugget = 3,
		},
	},

	["slot_blowdart"] = 
	{
		loot = 
		{
			blowdart_pipe = 3,
			goldnugget = 3,
		},
	},

	["slot_speargun"] = 
	{
		loot = 
		{
			--spear_launcher = 1,
			spear = 1,
			goldnugget = 3,
		},
	},


	["slot_dapper"] = 
	{
		loot = 
		{
			cane = 1,
			goldnugget = 3,
			tophat = 1,
		},
	},

	["slot_speed"] = 
	{
		loot = 
		{
			yellowamulet = 1,
			nightmarefuel = 3,
			goldnugget = 3,
		},
	},

	["slot_coconades"] = 
	{
		loot = 
		{
			coconade= 3,
			goldnugget = 3,
		},
	},

	["slot_obsidian"] = 
	{
		loot = 
		{
			obsidian= 5,
		},
	},

	["slot_thuleciteclub"] = 
	{
		loot = 
		{
			ruins_bat= 1,
			goldnugget = 3,
		},
	},

	["slot_thulecitesuit"] = 
	{
		loot = 
		{
			armorruins= 1,
			goldnugget = 3,
		},
	},

	["slot_ultimatewarrior"] = 
	{
		loot = 
		{
			armorruins= 1,
			ruins_bat= 1,
			ruinshat= 1,
		},
	},

	["slot_goldenaxe"] =
	{
		loot =
		{
			goldenaxe = 1,
			goldnugget = 3,
		},
	},

	["slot_monkeyball"] =
	{
		loot = 
		{
			monkeyball = 1,
			cave_banana = 2,
		},
	},


---------------------------------------OK LIST

	["firestarter"] = 
	{
		loot = 
		{
			log = 2,
		    twigs = 1,
			cutgrass = 3,
		},
	},

	["geologist"] = 
	{
		loot = 
		{
			rocks = 1,
			goldnugget = 1,
			obsidian = 1,
		},
	},

	["3cutgrass"] =
	{
		loot =
		{
			cutgrass = 5,
		},
	},	

	["3logs"] =
	{
		loot =
		{
			log = 3,
		},
	},

	["3twigs"] =
	{
		loot =
		{
			twigs = 3,
		},
	},

	["slot_torched"] =
	{
		loot =
		{
			torch = 1,
			charcoal = 2,
			ash = 2,
		},
	},

	["slot_jelly"] =
	{
		loot =
		{
			jellyfish_dead = 3,
		},
	},

	["slot_handyman"] =
	{
		loot =
		{
			axe = 1,
			hammer = 1,
			shovel = 1,
		},
	},

	["slot_poop"] =
	{
		loot =
		{
			poop = 5,
		},
	},

	["slot_berry"] =
	{
		loot =
		{
			berries = 5,
		},
	},

	["slot_limpets"] =
	{
		loot =
		{
			limpets = 5,
		},
	},

	["slot_seafoodsurprise"] =
	{
		loot =
		{
			limpets = 2,
			jellyfish_dead = 1,
			fish2 = 2,
			fish_med = 1,
		},
	},

	["slot_bushy"] =
	{
		loot =
		{
			berries = 3,
			dug_berrybush2 = 1, --cut down from 3
		},
	},


	["slot_bamboozled"] =
	{
		loot =
		{
			dug_bambootree = 1,
			bamboo = 3,
		},
	},

	["slot_grassy"] =
	{
		loot =
		{
			trap = 1,
			cutgrass = 3,
			strawhat = 1,
		},
	},

	["slot_prettyflowers"] =
	{
		loot =
		{
			petals = 5,
			flowerhat = 1,
		},
	},

	["slot_witchcraft"] =
	{
		loot =
		{
			flower_evil = 5,
			red_cap= 1,
			green_cap = 1,
			blue_cap = 1,
		},
	},

	["slot_bugexpert"] =
	{
		loot =
		{
			bugnet = 1,
			fireflies = 3,
			butterfly = 3,
		},
	},

	["slot_flinty"] =
	{
		loot =
		{
			flint = 5,
		},
	},

	["slot_fibre"] =
	{
		loot =
		{
			cave_banana = 1,
			dragonfruit = 1,
			watermelon = 1,
		},
	},

	["slot_drumstick"] =
	{
		loot =
		{
			drumstick = 3,
		},
	},

	["slot_fisherman"] =
	{
		loot =
		{
			fishingrod = 1,
			fish_med = 3,
			fish2 = 3,
		},
	},

    ["slot_bonesharded"] =
	{
		loot =
		{
			hammer = 1,
			skeleton = 3,
		},
	},

    ["slot_jerky"] =
	{
		loot =
		{
			coconut = 3,
		},
	},

    ["slot_coconutty"] =
	{
		loot =
		{
			coconut = 5,
		},
	},

	["slot_camper"] =
	{
		loot =
		{
			heatrock = 1,
			bedroll_straw = 1,
			meat_dried = 1,
		},
	},

    ["slot_ropey"] =
	{
		loot =
		{
			rope = 5,
		},
	},

  	["slot_tailor"] =
	{
		loot =
		{
			sewing_kit = 1,
			fabric= 3,
			tophat = 1,
		},
	},

	["slot_spiderboon"] =
	{
		loot =
		{
			spidergland = 2,
			silk = 5,
			monstermeat = 3,
		},
	},



--------------------------------------BAD LIST
	["slot_spiderattack"] =
	{
		loot =
		{
			spider = 3,
		},
	},

  	["slot_mosquitoattack"] =
	{
		loot =
		{
			mosquito_poison= 5,
		},
	},

  	["slot_snakeattack"] =
	{
		loot =
		{
			snake = 3,
		},
	},

	  	["slot_monkeysurprise"] =
	{
		loot =
		{
			primeape = 2,
		},
	},

		["slot_poisonsnakes"] =
	{
		loot =
		{
			snake_poison = 2,
		},
	},

		["slot_hounds"] =
	{
		loot = 
		{
			hound = 2,
		},
	},

}

local TreasureList = {}
local TreasureLootList = {}

function AddTreasure(name, data)
	TreasureList[name] = data
end

function AddTreasureLoot(name, data)
	TreasureLootList[name] = data
end

for name, data in pairs(internaltreasure) do
	AddTreasure(name, data)
end

for name, data in pairs(internalloot) do
	AddTreasureLoot(name, data)
end

local function GetTierLootTable(tier)
	-- TODO: yank it out!
	print("GetTierLootTable", tier, #Tiers[tier])
	return table.remove(Tiers[tier], math.random(1, #Tiers[tier]))
end

function GetTreasureDefinitionTable()
	return TreasureList
end

function GetTreasureDefinition(name)
	return TreasureList[name]
end

function GetTreasureLootDefinitionTable()
	return TreasureLootList
end

function GetTreasureLootDefinition(name)
	return TreasureLootList[name]
end

function ApplyModsToTreasure()
	for name, data in pairs(TreasureList) do
		local modfns = ModManager:GetPostInitFns("TreasurePreInit", name)
		for i,modfn in ipairs(modfns) do
			print("Applying mod to treasure ", name)
			modfn(data)
		end
	end
end

function ApplyModsToTreasureLoot()
	for name, data in pairs(TreasureLootList) do
		local modfns = ModManager:GetPostInitFns("TreasureLootPreInit", name)
		for i,modfn in ipairs(modfns) do
			print("Applying mod to treasure loot ", name)
			modfn(data)
		end
	end
end

local function GetTreasureLoot(loots)
	local lootlist = {}
	if loots then
		if loots.loot then
			for prefab, n in pairs(loots.loot) do
				if lootlist[prefab] == nil then
					lootlist[prefab] = 0
				end
				lootlist[prefab] = lootlist[prefab] + n
			end
		end
		if loots.random_loot then
			for i = 1, (loots.num_random_loot or 1), 1 do
				local prefab = weighted_random_choice(loots.random_loot)
				if prefab then
					if lootlist[prefab] == nil then
						lootlist[prefab] = 0
					end
					lootlist[prefab] = lootlist[prefab] + 1
				end
			end
		end
		if loots.chance_loot then
			for prefab, chance in pairs(loots.chance_loot) do
				if math.random() < chance then
					if lootlist[prefab] == nil then
						lootlist[prefab] = 0
					end
					lootlist[prefab] = lootlist[prefab] + 1
				end
			end
		end
		if loots.custom_lootfn then
			loots.custom_lootfn(lootlist)
		end
	end
	return lootlist
end

function GetTreasureLootList(name)
	return GetTreasureLoot(GetTreasureLootDefinition(name))
end

function SpawnTreasureLoot(name, lootdropper, pt, nexttreasure)
	if name and lootdropper ~= nil then
		if not pt then
			pt = Point(lootdropper.inst.Transform:GetWorldPosition())
		end

		if nexttreasure and nexttreasure ~= nil then
			--Spawn a bottle to the next treasure
			local bottle = inst.components.lootdropper:SpawnLootPrefab("messagebottle")
			bottle.treasure = nexttreasure
			--bottle:OnDrop() Handled by lootdropper/inventoryitem  now 
		end

		local player = GetPlayer()
		local loots = GetTreasureLootDefinition(name)
		local lootprefabs = GetTreasureLoot(loots)
		for p, n in pairs(lootprefabs) do
			for i = 1, n, 1 do
				local loot = lootdropper:SpawnLootPrefab(p, pt)
				assert(loot, "can't spawn "..tostring(p))
				if not loot.components.inventoryitem then
					-- attacker?
					if loot.components.combat then
						loot.components.combat:SuggestTarget(player)
					end
				end
			end
		end
	end
end

function SpawnTreasureChest(name, lootdropper, pt, nexttreasure)
	local loots = GetTreasureLootDefinition(name)
	if loots then
		local chest = SpawnPrefab(loots.chest or "treasurechest")
		if chest then
			if not pt then
				pt = Point(lootdropper.inst.Transform:GetWorldPosition())
			end

			chest.Transform:SetPosition(pt.x, pt.y, pt.z)
			SpawnPrefab("collapse_small").Transform:SetPosition(pt.x, pt.y, pt.z)

			if chest.components.container then
				if nexttreasure and nexttreasure ~= nil then
					--Spawn a bottle to the next treasure
					local bottle = SpawnPrefab("messagebottle")
					bottle.treasure = nexttreasure
					chest.components.container:GiveItem(bottle, nil, nil, true, false)
				end

				local player = GetPlayer()
				local lootprefabs = GetTreasureLoot(loots)
				for p, n in pairs(lootprefabs) do
					for i = 1, n, 1 do
						local loot = SpawnPrefab(p)
						if loot.components.inventoryitem and not loot.components.container then
							chest.components.container:GiveItem(loot, nil, nil, true, false)
						else
							local pos = Vector3(pt.x, pt.y, pt.z)
							local start_angle = math.random()*PI*2
							local rad = 1
							if chest.Physics then
								rad = rad + chest.Physics:GetRadius()
							end
							local offset = FindWalkableOffset(pos, start_angle, rad, 8, false)
							if offset == nil then
								return
							end

							pos = pos + offset

							loot.Transform:SetPosition(pos.x, pos.y, pos.z)
							-- attacker?
							if loot.components.combat then
								loot.components.combat:SuggestTarget(player)
							end
						end
					end
				end
			else
				SpawnTreasureLoot(name, lootdropper, pt)
			end
		end
	end
end

local function GetTreasureLoot(loots)
	local lootlist = {}
	if loots then
		if loots.loot then
			for prefab, n in pairs(loots.loot) do
				if lootlist[prefab] == nil then
					lootlist[prefab] = 0
				end
				lootlist[prefab] = lootlist[prefab] + n
			end
		end
		if loots.random_loot then
			for i = 1, (loots.num_random_loot or 1), 1 do
				local prefab = weighted_random_choice(loots.random_loot)
				if prefab then
					if lootlist[prefab] == nil then
						lootlist[prefab] = 0
					end
					lootlist[prefab] = lootlist[prefab] + 1
				end
			end
		end
		if loots.chance_loot then
			for prefab, chance in pairs(loots.chance_loot) do
				if math.random() < chance then
					if lootlist[prefab] == nil then
						lootlist[prefab] = 0
					end
					lootlist[prefab] = lootlist[prefab] + 1
				end
			end
		end
		if loots.custom_lootfn then
			loots.custom_lootfn(lootlist)
		end
	end
	return lootlist
end

local prefabs =
{
	"armormarble",
	"armor_sanity",
	"armorsnurtleshell",
	"resurrectionstatue",
	"icestaff",
	"firestaff",
	"telestaff",
	"thulecite",
	"orangestaff",
	"greenstaff",
	"yellowstaff",
	"amulet",
	"blueamulet",
	"purpleamulet",
	"orangeamulet",
	"greenamulet",
	"yellowamulet",
	"redgem",
	"bluegem",
	"orangegem",
	"greengem",
	"purplegem",
	"stafflight",
	"gears",
	"collapse_small",
}


-- A weighted average list of prizes, the bigger the number, the more likely it is.
-- It's based off altar_prototyper.lua
local goodspawns = 
{
--	log = 50,
--	twigs =50,
--	cutgrass = 50,
--	berries = 50,
--	limpets = 50,
--	meat = 50,
--	monstermeat = 50,
--	fish = 50,
--	meat_dried = 30,
--	seaweed = 50,
--	jellyfish = 20,
--	dubloon = 50, 
--	redgem = 10,
--	bluegem = 10,
--	purplegem = 10,
--	goldnugget = 50,
--	snakeskin = 20,
--	spidergland = 20,
--	torch = 50,
--	coconut = 50,

	-- Best Slot Loot List
	slot_goldy = 1,
	slot_10dubloons = 1,
	slot_honeypot = 1,
	slot_warrior1 = 1,
	slot_warrior2 = 1,
	slot_warrior3 = 1,
	slot_warrior4 = 1,
	slot_scientist = 1,
	slot_walker = 1,
	slot_gemmy = 1,
	slot_bestgem = 1,
	slot_lifegiver = 1,
	slot_chilledamulet = 1,
	slot_icestaff = 1,
	slot_firestaff = 1,
	slot_coolasice = 1,
	slot_gunpowder = 1,
	slot_firedart = 1,
	slot_sleepdart = 1,
	slot_blowdart = 1,
	slot_speargun = 1,
	slot_coconades = 1,
	slot_obsidian = 1,
	slot_thuleciteclub = 1,
	slot_ultimatewarrior = 1,
	slot_goldenaxe = 1,
	staydry = 1,
	cooloff = 1,
	birders = 1,
	gears =1,
	slot_seafoodsurprise = 1,
	slot_fisherman = 1,
	slot_camper = 1,
	slot_spiderboon = 1,
	slot_dapper = 1,
	slot_speed = 1,
	slot_tailor = 5,
}

local okspawns =
{
	-- OK slot List - Food and Resrouces 
	slot_anotherspin = 5,
	firestarter = 5,
	--geologist = 5,
	--cutgrassbunch = 5,
	--logbunch = 5,
	twigsbunch = 5,
--	torch = 5,
	slot_torched = 5,
	slot_jelly = 5,
	slot_handyman = 5,
	slot_poop = 5,
	slot_berry = 5,
	slot_limpets = 5,
	slot_bushy = 5,
	slot_bamboozled = 5,
	slot_grassy = 5,
	slot_prettyflowers = 5,
	slot_witchcraft = 5,
	slot_bugexpert = 5,
	slot_flinty = 5,
	slot_fibre = 5,
	slot_drumstick = 5,
	slot_ropey = 5,
	slot_jerky = 5,
	slot_coconutty = 5,
	slot_bonesharded = 5,
	



}

local badspawns =
{
	-- Bad prizes
--	snake = 1,
--	spider_hider = 1,
	slot_spiderattack = 1,
	slot_mosquitoattack = 1,
	slot_snakeattack = 1,
	slot_monkeysurprise = 1,
	slot_poisonsnakes = 1,
	slot_hounds = 1,


	-- Old
	--nothing = 100,
	--trinket = 100,
}

-- weighted_random_choice for bad, ok, good prize lists 
local prizevalues =
{
	bad = 2,
	ok = 3,
	good = 1,
}

-- actions to perform for the spawns
local actions =
{
	-- if there's a cnt, then it'll spawn that many
	--trinket = { cnt = 2, },
--	spider_hider = { cnt = 3, },
--	snake = { cnt = 3, },

	-- Prizes based of TreasureLoot table in map/treasurehunt.lua
	-- treasure = <the name in the TreasureLoot table>
	-- overrides all other things


	firestarter = { treasure = "firestarter", },
	geologist = { treasure = "geologist", },
	cutgrassbunch = { treasure = "3cutgrass", },
	logbunch = { treasure = "3logs", },
	twigsbunch = { treasure = "3twigs", },
	slot_torched = { treasure = "slot_torched", },
	slot_jelly = { treasure = "slot_jelly", },
	slot_handyman = { treasure = "slot_handyman", },
	slot_poop = { treasure = "slot_poop", },
	slot_berry = { treasure = "slot_berry", },
	slot_limpets = { treasure = "slot_limpets", },
	slot_seafoodsurprise = { treasure = "slot_seafoodsurprise", },
	slot_bushy = { treasure = "slot_bushy", },
	slot_bamboozled = { treasure = "slot_bamboozled", },
	slot_grassy = { treasure = "slot_grassy", },
	slot_prettyflowers = { treasure = "slot_prettyflowers", },
	slot_witchcraft = { treasure = "slot_witchcraft", },
	slot_bugexpert = { treasure = "slot_bugexpert", },
	slot_flinty = { treasure = "slot_flinty", },
	slot_fibre = { treasure = "slot_fibre", },
	slot_drumstick = { treasure = "slot_drumstick", },
	slot_fisherman = { treasure = "slot_fisherman", },
	slot_dapper = { treasure = "slot_dapper", },
	slot_speed = { treasure = "slot_speed", },




	slot_anotherspin = { treasure = "slot_anotherspin", },
	slot_goldy = { treasure = "slot_goldy", },
	slot_honeypot = { treasure = "slot_honeypot", },
	slot_warrior1 = { treasure = "slot_warrior1", },
	slot_warrior2 = { treasure = "slot_warrior2", },
	slot_warrior3 = { treasure = "slot_warrior3", },
	slot_warrior4 = { treasure = "slot_warrior4", },
	slot_scientist = { treasure = "slot_scientist", },
	slot_walker = { treasure = "slot_walker", },
	slot_gemmy = { treasure = "slot_gemmy", },
	slot_bestgem = { treasure = "slot_bestgem", },
	slot_lifegiver = { treasure = "slot_lifegiver", },
	slot_chilledamulet = { treasure = "slot_chilledamulet", },
	slot_icestaff = { treasure = "slot_icestaff", },
	slot_firestaff = { treasure = "slot_firestaff", },
	slot_coolasice = { treasure = "slot_coolasice", },
	slot_gunpowder = { treasure = "slot_gunpowder", },
	slot_firedart = { treasure = "slot_firedart", },
	slot_sleepdart = { treasure = "slot_sleepdart", },
	slot_blowdart = { treasure = "slot_blowdart", },
	slot_speargun = { treasure = "slot_speargun", },
	slot_coconades = { treasure = "slot_coconades", },
	slot_obsidian = { treasure = "slot_obsidian", },
	slot_thuleciteclub = { treasure = "slot_thuleciteclub", },
	slot_ultimatewarrior = { treasure = "slot_ultimatewarrior", },
	slot_goldenaxe = { treasure = "slot_goldenaxe", },
	staydry = { treasure = "staydry", },
	cooloff = { treasure = "cooloff", },
	birders = { treasure = "birders", },
	slot_monkeyball = { treasure = "slot_monkeyball", },


	slot_bonesharded = { treasure = "slot_bonesharded", },
	slot_jerky = { treasure = "slot_jerky", },
	slot_coconutty = { treasure = "slot_coconutty", },
	slot_camper = { treasure = "slot_camper", },
	slot_ropey = { treasure = "slot_ropey", },
	slot_tailor = { treasure = "slot_tailor", },
	slot_spiderboon = { treasure = "slot_spiderboon", },
	slot_3dubloons = { treasure = "3dubloons", },
	slot_10dubloons = { treasure = "10dubloons", },
	

	slot_spiderattack = { treasure = "slot_spiderattack", },
	slot_mosquitoattack = { treasure = "slot_mosquitoattack", },
	slot_snakeattack = { treasure = "slot_snakeattack", },
	slot_monkeysurprise = { treasure = "slot_monkeysurprise", },
	slot_poisonsnakes = { treasure = "slot_poisonsnakes", },
	slot_hounds = { treasure = "slot_hounds", },


				slot_snakeattack = { treasure = "slot_snakeattack", },
					slot_snakeattack = { treasure = "slot_snakeattack", },
						slot_snakeattack = { treasure = "slot_snakeattack", },

}

local sounds = 
{
	ok = "dontstarve_DLC002/common/slotmachine_mediumresult",
	good = "dontstarve_DLC002/common/slotmachine_goodresult",
	bad = "dontstarve_DLC002/common/slotmachine_badresult",
}

local function SpawnCritter(inst, critter, lootdropper, pt, delay)
	delay = delay or GetRandomWithVariance(1,0.8)
	inst:DoTaskInTime(delay, function() 
		SpawnPrefab("collapse_small").Transform:SetPosition(pt:Get())
		local spawn = lootdropper:SpawnLootPrefab(critter, pt)
		if spawn and spawn.components.combat then
			spawn.components.combat:SetTarget(GetPlayer())
		end
	end)
end

local function SpawnReward(inst, reward, lootdropper, pt, delay)
	delay = delay or GetRandomWithVariance(1,0.8)

	local loots = GetTreasureLootList(reward)
	for k, v in pairs(loots) do
		for i = 1, v, 1 do

			inst:DoTaskInTime(delay, function(inst) 
				local down = TheCamera:GetDownVec()
				local spawnangle = math.atan2(down.z, down.x)
				local angle = math.atan2(down.z, down.x) + (math.random()*90-45)*DEGREES
				local sp = math.random()*3+2
				
				local item = SpawnPrefab(k)

				if item.components.inventoryitem and not item.components.health then
					local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(2*math.cos(spawnangle), 3, 2*math.sin(spawnangle))
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/slotmachine_reward")
					item.Transform:SetPosition(pt:Get())
					item.Physics:SetVel(sp*math.cos(angle), math.random()*2+9, sp*math.sin(angle))
				--	item.components.inventoryitem:OnStartFalling()
				else
					local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(2*math.cos(spawnangle), 0, 2*math.sin(spawnangle))
					pt = pt + Vector3(sp*math.cos(angle), 0, sp*math.sin(angle))
					item.Transform:SetPosition(pt:Get())
					SpawnPrefab("collapse_small").Transform:SetPosition(pt:Get())
				end
				
			end)
			delay = delay + 0.25
		end
	end
end



local function PickPrize(inst)

	inst.busy = true
	local prizevalue = weighted_random_choice(prizevalues)
	-- print("slotmachine prizevalue", prizevalue)
	if prizevalue == "ok" then
		inst.prize = weighted_random_choice(okspawns)
	elseif prizevalue == "good" then
		inst.prize = weighted_random_choice(goodspawns)
	elseif prizevalue == "bad" then
		inst.prize = weighted_random_choice(badspawns)
	else
		-- impossible!
		-- print("impossible slot machine prizevalue!", prizevalue)
	end

	inst.prizevalue = prizevalue
end

local function DoneSpinning(inst)

	local pos = inst:GetPosition()
	local item = inst.prize
	local doaction = actions[item]

	local cnt = (doaction and doaction.cnt) or 1
	local func = (doaction and doaction.callback) or nil
	local radius = (doaction and doaction.radius) or 4
	local treasure = (doaction and doaction.treasure) or nil

	if doaction and doaction.var then
		cnt = GetRandomWithVariance(cnt,doaction.var)
		if cnt < 0 then cnt = 0 end
	end

	if cnt == 0 and func then
		func(inst,item,doaction)
	end

	for i=1,cnt do
		local offset, check_angle, deflected = FindWalkableOffset(pos, math.random()*2*PI, radius , 8, true, false) -- try to avoid walls
		if offset then
			if treasure then
				-- print("Slot machine treasure "..tostring(treasure))
				-- SpawnTreasureLoot(treasure, inst.components.lootdropper, pos+offset)
				-- SpawnPrefab("collapse_small").Transform:SetPosition((pos+offset):Get())
				SpawnReward(inst, treasure)
			elseif func then
				func(inst,item,doaction)
			elseif item == "trinket" then
				SpawnCritter(inst, "trinket_"..tostring(math.random(NUM_TRINKETS)), inst.components.lootdropper, pos+offset)
			elseif item == "nothing" then
				-- do nothing
				-- print("Slot machine says you lose.")
			else
				-- print("Slot machine item "..tostring(item))
				SpawnCritter(inst, item, inst.components.lootdropper, pos+offset)
			end
		end
	end

	-- the slot machine collected more coins
	inst.coins = inst.coins + 1

	--inst.AnimState:PlayAnimation("idle")
	inst.busy = false
	inst.prize = nil
	inst.prizevalue = nil
	
	print("Slot machine has "..tostring(inst.coins).." dubloons.")
	inst.sg:GoToState("fake_idle")
end

local function StartSpinning(inst)

	inst.sg:GoToState("spinning")
end

local function ShouldAcceptItem(inst, item)
	
	if not inst.busy and item.prefab == "dubloon" then
		return true
	elseif not inst.busy and item.prefab == "oinc" then
		return true
	else	
		return false
	end
end

local function OnGetItemFromPlayer(inst, giver, item)
	-- print("Slot machine takes your dubloon.")
	giver.components.sanity:DoDelta(-TUNING.SANITY_TINY)

	PickPrize(inst)
	StartSpinning(inst)
end

local function OnRefuseItem(inst, item)
	-- print("Slot machine refuses "..tostring(item.prefab))
end

local function OnLoad(inst,data)
	if not data then
		return
	end
	
	inst.coins = data.coins or 0
	inst.prize = data.prize
	inst.prizevalue = data.prizevalue

	if inst.prize ~= nil then
		StartSpinning(inst)
	end
end

local function OnSave(inst,data)
	data.coins = inst.coins
	data.prize = inst.prize
	data.prizevalue = inst.prizevalue
end

--local function OnFloodedStart(inst)
	--inst.components.payable:Disable()
--end

--local function OnFloodedEnd(inst)
	--inst.components.payable:Enable()
--end

local function CalcSanityAura(inst, observer)
	return -(TUNING.SANITYAURA_MED*(1+(inst.coins/100)))
end

local function CreateSlotMachine(name)
	
	local assets = 
	{
		Asset("ANIM", "anim/slot_machine.zip"),
		--Asset("MINIMAP_IMAGE", "slot_machine"),
	}


	local function InitFn(Sim)
		local inst = CreateEntity()
		inst.OnSave = OnSave
		inst.OnLoad = OnLoad

		inst.DoneSpinning = DoneSpinning
		inst.busy = false
		inst.sounds = sounds

		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
			inst.entity:AddNetwork()
		
		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetPriority( 5 )
		minimap:SetIcon( "slot_machine.png" )
				
		MakeObstaclePhysics(inst, 0.8, 1.2)
		

		anim:SetBank("slot_machine")
		anim:SetBuild("slot_machine")
		anim:PlayAnimation("idle")
		
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

		-- keeps track of how many dubloons have been added
		inst.coins = 0
		
		inst:AddComponent("inspectable")
		inst.components.inspectable.getstatus = function(inst)
			return "WORKING"
		end

		inst:AddComponent("lootdropper")
		inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem		

	--inst:AddComponent("payable")
	--	inst.components.payable:SetAcceptTest(ShouldAcceptItem)
		--inst.components.payable.onaccept = OnGetItemFromPlayer
		--inst.components.payable.onrefuse = OnRefuseItem

		inst:AddComponent("sanityaura")
    	inst.components.sanityaura.aurafn = CalcSanityAura

		--inst:AddComponent("floodable")
		--inst.components.floodable.onStartFlooded = --OnFloodedStart
		--inst.components.floodable.onStopFlooded = --OnFloodedEnd
		--inst.components.floodable.floodEffect = --"shock_machines_fx"
		--inst.components.floodable.floodSound = --"dontstarve_DLC002/creatures/jellyfish/electric_land"

		inst:SetStateGraph("SGslotmachine")

		return inst
	end

	return Prefab( "common/objects/slotmachine", InitFn, assets, prefabs)

end

return CreateSlotMachine()

