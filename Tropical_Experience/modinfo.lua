name = " Tropical Experience Return of Them"
description = "Attention: We added a complement to this mod. In it will have several changes to improve the experience of the game. Visit only the main mod page and download. Tropical Experience| Complement"
author = "Vagner da Rocha Santos."
version = "2.67"
forumthread = ""
api_version = 10
priority = -20

dst_compatible = true
dont_starve_compatible = false
all_clients_require_mod = true
client_only_mod = false
reign_of_giants_compatible = false
server_filter_tags = {"shipwrecked", "tropical experience", "Hamlet", "Economy", "itens", "biome", "world", "gen", "money", "coins", "house", "home", "boats", "light", "hats", "boss", "companion", "endless", "ruins", "gun", "hard", "trade", "vagner"}

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{

    {
        name = "set_idioma",
        label = "Language/Idioma/选择语言",
		hover = "Change mod language...",
        options = 
        {
			{description = "English", data = "stringsEU"},
			{description = "Português", data = "stringsPT"},
			{description = "。中國", data = "stringsCh"},
			{description = "Italian", data = "stringsIT"},
			{description = "Russian", data = "stringsRU"},
			{description = "Spanish", data = "stringsSP"},
			{description = "한국어", data = "stringsKO"},
			{description = "Magyar", data = "stringsHUN"},
			{description = "Français", data = "stringsFR"},			
        }, 
        default = "stringsEU",
    },

	{
		name = "",
		label = "KIND OF WORLD",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},
	
	{
		name = "kindofworld",  
		label = "What is your kind of world?", 
		hover = "",
		default = 15,
		options =	{
						{description = "hamlet",         	data = 5, hover = "will generate a world based on hamlet DLC, use settings for hamlet."},
						{description = "shipwrecked",       data = 10, hover = "will generate a world based on shipwreck DLC, use settings for shipwrecked."},					
						{description = "custom",        	data = 15, hover = "will generate a customized world, use settings for custom world."},
						{description = "Sea World",        	data = 20, hover = "will generate a world without terain, time to survine in ocean."},					},
    },
	
	{
		name = "",
		label = "for hamlet world",
		hover = "Generate a full hamlet only world Includeing all ruins, ponds, BFB+Nest)",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	
	
	{
		name    = "hamletcaves_hamletworld",
		label   = "Hamlet Caves",
		hover   = "Will generate a new cave zone, do not forget to enable caves to work",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},

	{
		name    = "togethercaves_hamletworld",
		label   = "Together Caves",
		hover   = "Will generate defalt cave zone, do not forget to enable caves to work",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},		
	
	{
	name    = "hamletclouds",
	label   = "Hamlet Clouds",
		hover = "Replace the black zone for a cloud texture ",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = false,
	},
	
	
	{
		name    = "continentsize",
		label   = "Continent Size",
		hover   = "To change the continent size",
		options =
		{
						{description = "Compact",         	data = 1, hover = "Will generate the continent more compact can reduce lag in the game"},
						{description = "Defalt",        	data = 2, hover = "Will generate the continent in defal size"},											
						{description = "Bigger",        	data = 3, hover = "Will generate the continent bigger can increase lag in the game"},
		},
		default = 2,
	},		
	
	{
		name    = "fillingthebiomes",
		label   = "Filling the Biomes",
		hover   = "To change the filling the biomes, the smaller the less lag will happen in the game",
		options =
		{
		
						{description = "0%",         		data = 0, hover = "The content of the biome will be reduced to a minimum"},	
						{description = "25%",         		data = 1, hover = "The biome will have 25% of the normal content"},						
						{description = "50%",         		data = 2, hover = "The biome will have 50% of the normal content"},
						{description = "75%",        		data = 3, hover = "The biome will have 75% of the normal content"},			
						{description = "100%",        		data = 4, hover = "The Biome will have defalt content"},							
		},
		default = 4,
	},		


	{
	name    = "compactruins",
	label   = "Compact Pig Ruins",
		hover = "will generate pig ruins with fewer rooms",
		options =
		{
			{description = "YES", data = true, hover = "Less rooms on pig ruins"},
			{description = "NO", data = false, hover = "Standard Quantity"},
		},
		default = false,
	},
	
	{
		name = "",
		label = "for shipwrecked world",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	
	
	{
		name = "howmanyislands",  
		label = "How Many Islands",
        hover   = "You can increase or decrease the number of islands in the game, but more islands will take more time to generate a world", 		
		default = 22,
		options =	{
						{description = "20",         	data = 12, hover = "increase in 12 islands"},
						{description = "30",        	data = 22, hover = "increase in 20 islands"},											
						{description = "40",        	data = 32, hover = "increase in 30 islands"},
						{description = "50",        	data = 42, hover = "increase in 40 islands"},	
						{description = "60",       		data = 52, hover = "increase in 50 islands"},						
						{description = "70",       		data = 62, hover = "increase in 60 islands"},	
						{description = "80",       		data = 72, hover = "increase in 70 islands"},	
						{description = "86",       		data = 78, hover = "increase in 78 islands"},							
					},
	},		

	{
		name = "Shipwreckedworld_plus",  
		label = "Shipwrecked Plus", 
		hover   = "Generate a extra Shipwrecked island based on the Shipwrecked Plus mod",
		options =	{
			{description = "NO", data = false, hover = "Eldorado civilization will not be generated"},
			{description = "YES", data = true, hover = "Eldorado civilization will be generated"},
					},
		default = true,			
	},	
	{
		name = "frost_islandworld",
		label = "Frost Land", 
		hover   = "It creates a snowy island in the ocean where it is winter all the time, it also creates the frozen cave.",
		default = 10,
		options =	{
						{description = "NO",         			data = 5, hover = "Disable Generation"},
						{description = "YES",        			data = 10, hover = "Generate on Caves & World"},					
					},
	},	

	{
		name = "Moonshipwrecked",  
		label = "Moon Biome", 
		hover   = "Generate the Moon continent from together",
		options =	{
			{description = "NO", data = 0, hover = "Moon continent will not be generated"},
			{description = "YES", data = 1, hover = "Moon continent will be generated"},
					},
		default = 0,			
	},	

	{
		name    = "hamletcaves_shipwreckedworld",
		label   = "Hamlet Caves",
		hover   = "Will generate a new cave zone, do not forget to enable caves to work",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},

	{
		name    = "togethercaves_shipwreckedworld",
		label   = "Together Caves",
		hover   = "Will generate defalt cave zone, do not forget to enable caves to work",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},		

    {
		name = "",
		label = "for custom world",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	

	{
		name = "startlocation",  
		label = "Player Portal", 
		hover   = "This is the start point, It represents the biome around the initial portal.",
        default = 5,
		options =	{
						{description = "Together",         	data = 5, hover = "Reign of Giants Biomes"},	
						{description = "Shipwrecked",       data = 10, hover = "Shipwrecked Biomes"},	
						{description = "Hamlet",        	data = 15, hover = "Hamlet Biomes"},					
					},
	},		
		
	{
		name = "Together",  
		label = "Reign of Giants Biomes",
        hover   = "Reign of Giants Biomes", 		
		default = 20,
		options =	{
						{description = "Disabled",         	data = 5, hover = "Disables this biome"},
						{description = "Main land",        	data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},					
						{description = "Continent",        	data = 10, hover = "This biome will be generated on another continent."},
						{description = "Islands",        	data = 15, hover = "This biome will be generated on several separate islands in the ocean"},			
					},
	},	

	{
		name = "Moon",  
		label = "Lunar Biomes",
        hover   = "Lunar Biomes", 		
		default = 10,
		options =	{
						{description = "Disabled",         	data = 5, hover = "Disables this biome"},
						{description = "Main land",        	data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},											
						{description = "Continent",        	data = 10, hover = "This biome will be generated on another continent."},
						{description = "Islands",        	data = 15, hover = "This biome will be generated on several separate islands in the ocean"},	
				
					},
	},		
	
	{
		name = "Shipwrecked",  
		label = "Shipwrecked Biomes",
        hover   = "Shipwrecked Biomes", 		
		default = 25,
		options =	{
						{description = "Disabled",         	data = 5, hover = "Disables this biome"},
						{description = "Main land",        	data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},											
						{description = "Continent",        	data = 10, hover = "This biome will be generated on another continent."},
						{description = "Islands",        	data = 15, hover = "This biome will be generated on several separate islands in the ocean"},	
						{description = "Arquipelago",       data = 25, hover = "This biome will be generated as an compact Islands cluster"},						
					
					},
	},		
	
	{
		name = "Shipwrecked_plus",  
		label = "Shipwrecked Plus", 
		hover   = "Generate a extra Shipwrecked island based on the Shipwrecked Plus mod",
		options =	{
			{description = "NO", data = false, hover = "Eldorado civilization will not be generated"},
			{description = "YES", data = true, hover = "Eldorado civilization will be generated"},
					},
		default = true,			
	},

	{
		name    = "Hamlet",
		label   = "Hamlet Biomes",
		hover   = "Hamlet Biomes", 
		options =
		{
		
		
		{description = "Disabled",         data = 5, hover = "Disables this biome"},
		{description = "Main land",        data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},			
		{description = "Continent",        data = 10, hover = "This biome will be generated on another continent."},
		{description = "Islands",          data = 15, hover = "This biome will be generated on several separate islands in the ocean"},			
		},
		default = 10,
	},
	
	{
		name    = "pigcity1",
		label   = "Swinesbury",
		hover   = "Generate City 1",
		options =
		{
		{description = "Disabled",         data = 5, hover = "This pig city will not be generated"},
		{description = "Main land",        data = 10, hover = "This pig city will be generated in the main land, where the player starts the game"},	
		{description = "Continent",        data = 15, hover = "This pig city will be generated on another continent."},
		{description = "Island",           data = 20, hover = "This pig city will be generated in a islands in ocean"},	
		},
		default = 15,
	},		
	
	{
		name    = "pigcity2",
		label   = "The Royal Palace",
		hover   = "Generate City 2",
		options =
		{
		{description = "Disabled",         data = 5, hover = "This pig city will not be generated"},
		{description = "Main land",        data = 10, hover = "This pig city will be generated in the main land, where the player starts the game"},	
		{description = "Continent",        data = 15, hover = "This pig city will be generated on another continent."},		
		{description = "Island",           data = 20, hover = "This pig city will be generated on a islands in ocean"},		
		},
		default = 20,
	},		
	
	{
		name    = "pinacle",
		label   = "Pinacle",
		hover   = "Generate Roc Nest Island",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a small island in the ocean with a roc nest"},	
		},
		default = 1,
	},	
	
	{
		name    = "anthill",
		label   = "Ant Hill",
		hover   = "Generate Ant Hill containing: The Den entrance & Queen Womant",
		options =
		{
		{description = "Disabled",         data = 0, hover = "The Anthill will not be generated"},
		{description = "Enabled",          data = 1, hover = "The Anthill will be generated"},
		},
		default = 1,
	},	

	{
		name    = "pigruins",
		label   = "Ancient pig ruins",
		hover   = "Generate Ancient pig Ruins containing the Aporkalypse Calendar",
		options =
		{
		{description = "Disabled",         data = 0, hover = "The Pig Ruin will not be generated"},
		{description = "Enabled",          data = 1, hover = "The Pig Ruin will be generated"},
		},
		default = 1,
	},
	
	{
		name    = "gorgeisland",
		label   = "Peat Forest Island",
		hover   = "Generate a Gorge Forest",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a small island in the ocean with this biome "},	
		},
		default = 1,
	},	

	{
		name    = "gorgecity",
		label   = "Gorge City",
		hover   = "Generate a Gorge City in Ocean",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a small island in the ocean with this biome "},	
		},
		default = 1,
	},
	
	{
		name = "frost_island",
		label = "Frost Land", 
		hover   = "It creates a snowy island in the ocean where it is winter all the time, it also creates the frozen cave.",
		default = 10,
		options =	{
						{description = "NO",         			data = 5, hover = "Disable Generation"},
						{description = "YES",        			data = 10, hover = "Allow Generate on Caves & World"},					
					},
	},	
	
	{
		name    = "hamlet_caves",
		label   = "Hamlet Caves",
		hover   = "It will generate a new zone in the caves that is very different from the traditional one and with new biomes, accessible in hamlet biome",
		options =
		{
		{description = "Disabled",         data = 0, hover = "This biome will not be generated"},
		{description = "Enabled",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},	
	
	
	{
		name = "",
		label = "for all worlds",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	
		
	{
		name = "Volcano",  
		label = "Volcano", 
		hover   = "Generates the volcano in the world, if your world has a cave enabled, select the option caves. (will only affects custom and shipwrecked world)",
		options =	{
			{description = "Complete", data = true, hover = "Will Generate a complete volcano in terms of content, need caves enabled"},
			{description = "Compact", data = false, hover = "Will Generate a compact volcano not need caves enabled"},
					},
		default = true,			
	},			


	{
		name = "forge",  
		label = "Forge Arena", 
		hover   = "It will generate the forge arena inside volcano. (will only affects custom and shipwrecked world)",
		options =	{
			{description = "Enabled", data = 1, hover = "Will generate the forge arena"},
			{description = "Disabled", data = 0, hover = "Will not generate the forge arena"},
					},
		default = 1,			
	},		

	{
		name = "underwater",  
		label = "Underwater", 
		hover   = "It will generate entrances on the surface that lead to the bottom of the ocean. (will only affects custom, hamlet and shipwrecked world)",
		options =	{
			{description = "Enabled", data = true, hover = "Generate the Underwater Biome, The caves need be enabled to work"},
			{description = "Disabled", data = false, hover = "The Underwater Biome will not spawn"},
					},
		default = true,			
	},	

	{
		name = "",
		label = "OCEAN SETTINGS",
			hover = "will only affects custom and shipwrecked world",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},				
	
	{
		name    = "Waves",
		label   = "Waves",
		hover   = "The sea generate Waves *wind make them stronger and faster*",
		options =
		{
			{description = "NO", data = false, hover = ""},
			{description = "YES", data = true, hover = ""},
		},
		default = true,
	},
	
	{
		name    = "aquaticcreatures",
		label   = "Aquatic Creatures",
		hover   = "the sea will randomly generate creatures",
		options =
		{
			{description = "NO", data = false, hover = ""},
			{description = "YES", data = true, hover = ""},
		},
		default = true,
	},	

    {
		name = "kraken",  
		label = "Kraken",
        hover = "Shipwrecked Boss *The Quacken*",		
		default = 1,
		options =	{
						{description = "NO",         	data = 0, hover = ""},
						{description = "YES",        	data = 1, hover = ""},					
					},
	},	
	
	{
		name = "octopusking",  
		label = "Octopus King",
        hover = "Shipwrecked Dubloon Trader",		
		default = 1,
		options =	{
						{description = "NO",         	data = 0, hover = ""},
						{description = "YES",        	data = 1, hover = ""},					
					},
	},	
	
	{
		name = "mangrove",  
		label = "Mangrove Biome",
        hover = "Will generate the mangrove biome on ocean, including the Water Beefalo", 		
		default = 1,
		options =	{
						{description = "NO",         	data = 0, hover = ""},
						{description = "YES",        	data = 1, hover = ""},							
					},
	},	

	{
		name = "lilypad",  
		label = "Lilypad Biome",
        hover = "Will generate the lylypad biome on the water, including the Hippopotamoose", 		
		default = 1,
		options =	{
						{description = "NO",         	data = 0, hover = ""},
						{description = "YES",        	data = 1, hover = ""},								
					},
	},
	
	{
		name = "shipgraveyard",  
		label = "Ship Graveyard Biome",
        hover = "Will generate the Ship graveyard Biome", 		
		default = 1,
		options =	{
						{description = "NO",         	data = 0, hover = ""},
						{description = "YES",        	data = 1, hover = ""},								
					},
	},			

	{
		name = "coralbiome",  
		label = "Coral Biome",
        hover = "Will generate the Coral Biome", 		
		default = 1,
		options =	{
						{description = "NO",         	data = 0, hover = ""},
						{description = "YES",        	data = 1, hover = ""},								
					},
	},	

	{
		name = "",
		label = "GAMEPLAY SETTINGS",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},
	
	{
		name    = "aporkalypse",
		label   = "Aporkalypse",
		hover   = "Aporkalypse appear every 60 days, if u don't reset the calendar inside the ruins *Active Time: 20 days*",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = true,
	},	
	
	{
		name    = "sealnado",
		label   = "Sealnado",
		hover   = "Will spawn in spring on Shipwrecked Biomes *Sealnado/Twister* ",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = true,
	},	
	
			
	{
		name = "",
		label = "WEATHER SETTINGS",
			hover = "can affects all worlds",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},

	{
		name    = "flood",
		label   = "Flood",
		hover   = "In Spring puddles will spawn and attract Mosquitos from the water",
		options =
		{	
			{description = "Disabled", 	data = 5,  hover = "Disabled"},
			{description = "Tropical Zone", 	data = 10, hover = "Will appear only in Tropical Zones"},
			{description = "All world", 	data = 20, hover = "Will appear in all world"},				
		},
		default = 10,	
	},	
	
	{
		name    = "wind",
		label   = "Wind",
		hover   = "affects speed, make trees & plant fall down and the sea create more and powerfull waves",
		options =
		{
			{description = "Disabled", 			data = 5,  hover = "Disabled"},
			{description = "Tropical-Hamlet", 	data = 10, hover = "Will appear only in Tropical and Hamlet Zones"},
			{description = "All world", 		data = 20, hover = "Will appear in all world"},				
		},
		default = 10,
	},	

	{
		name    = "hail",
		label   = "Hail",
		hover   = "enables to rain hail ice fall from the sky",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = true,
	},	
	
	{
		name    = "volcaniceruption",
		label   = "Volcanic Eruption",
		hover   = "Enables the Volcanic Eruption",
		options =
		{
			{description = "Disabled", 	data = 5,  hover = "Disabled"},
			{description = "Tropical Zone", 	data = 10, hover = "Will appear only in Tropical Zones"},
			{description = "All world", 	data = 20, hover = "Will appear in all world"},	
		},
		default = 10,
	},	
	
	{
		name    = "fog",
		label   = "Winter Fog",
		hover   = "Enables the fog on Winter",
		options =
		{
			{description = "Disabled", 			data = 5,  hover = "Disabled"},
			{description = "Hamlet Zone", 		data = 10, hover = "Will appear only in Hamlet Zones"},
			{description = "All world", 		data = 20, hover = "Will appear in all world"},	
		},
		default = 10,
	},		

	{
		name    = "hayfever",
		label   = "Hay Fever",
		hover   = "Enables the Hay Fever on Summer",
		options =
		{
			{description = "Disabled", 			data = 5,  hover = "Disabled"},
			{description = "Hamlet Zone", 		data = 10, hover = "Will appear only in Hamlet Zones"},
			{description = "All world", 		data = 20, hover = "Will appear in all world"},	
		},
		default = 10,
	},	

	{
		name = "",
		label = "HUD AJUSTMENT",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},

		{
		name    = "disable_snow_effectst",
		label   = "Disable Snow effectst",
		hover = "Disables the Ground Snow effect on turf",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = false,
	},

	{
		name    = "removedark",
		label   = "remove dark",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = false,
	},		

	{
		name    = "home_tab",
		label   = "Home TAB",
		hover = "Stand in the middle of your home to make the TAB appear",
		options =
		{
			{description = "Normal", 	data = 0, hover = "Own Extra TAB"},
			{description = "Agrouped", 	data = 1, hover = "Cluster TAB: Home-City-Volcano Tab *3in1*"},
			{description = "Disabled", 	data = 2, hover = "Disable Tab"},	
		},
		default = 1,
	},	

	{
		name    = "city_tab",
		label   = "City TAB",
		hover = "Put City key on the ground to make the TAB appear",
		options =
		{
			{description = "Normal", 	data = 0, hover = "Own Extra TAB"},
			{description = "Agrouped", 	data = 1, hover = "Cluster TAB: Home-City-Volcano Tab*3in1*"},
			{description = "Disabled", 	data = 2, hover = "Disable Tab"},	
		},
		default = 1,
	},	

	
	{
		name    = "obsidian_tab",
		label   = "Obsidian TAB",
		hover = "can be found in the volcano stand near it to make the TAB appear",
		options =
		{
			{description = "Normal", 	data = 0, hover = "Own Extra TAB"},
			{description = "Agrouped", 	data = 1, hover = "Cluster TAB: Home-City-Volcano Tab*3in1*"},
			{description = "Disabled", 	data = 2, hover = "Disable Tab"}	
		},
		default = 1,
	},
	
	{
		name    = "nautical_tab",
		label   = "Nautical TAB",
		hover = "enable boats Crafting TAB, the 2 Rafts needs a peddle/oar *the Higher tier Shipwrecked boats act default*",
		options =
		{
			{description = "NO", data = false, hover = "Disable Tab"},
			{description = "YES", data = true, hover = "Own Extra TAB"},
		},
		default = true,
	},
	
	{
		name    = "seafaring_tab",
		label   = "Nautical in Seafaring",
		hover = "All itens from Nautical Tab will be transfered to Seafaring_tab",
		options =
		{
			{description = "NO", data = false, hover = "Disable Tab"},
			{description = "YES", data = true, hover = "Own Extra TAB"},
		},
		default = false,
	},	
	
	{
		name = "boatlefthud",  label = "Boat HUD(Vertical Adjustment)", default = 0,
	    hover   = "Here u can adjust the height of the boat HUD *Health meter", 
		options =	{
						{description = "-100",         data = -100},
						{description = "-75",         data = -75},		
						{description = "-50",         data = -50},
						{description = "-25",        data = -25},
						{description = "0",        data = 0},
						{description = "+25",        data = 25},
						{description = "+50",        data = 50},
						{description = "+75",        data = 75},
						{description = "+100",       data = 100},
				},
	},	

	{
		name = "housewallajust",  
		label = "house wall ajust", 
		default = 0,
	    hover   = "Can ajust the wall position if it is not in the center", 
		options =	{
						{description = "-7",         data = -7},
						{description = "-6",         data = -6},		
						{description = "-5",         data = -5},		
						{description = "-4",         data = -4},
						{description = "-3",         data = -3},		
						{description = "-2",         data = -2},
						{description = "-1",        data = -1},
						{description = "0",        data = 0},
						{description = "+1",        data = 1},
						{description = "+2",        data = 2},
						{description = "+3",        data = 3},
						{description = "+4",       data = 4},
						{description = "+5",        data = 5},
						{description = "+6",        data = 6},
						{description = "+7",       data = 7},						
				},
	},


	{
		name = "",
		label = "SHARD-DEDICATED",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},		
	
	{
		name    = "enableallprefabs",
		label   = "Enable all prefabs",
        hover = "Used for server shards & Testing, If not active, spawned items can crash in a non mixworld",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = false,
	},			

    {
        name = "tropicalshards",
        label = "Tropical shards",
        hover = "Presets how world&portals connect using the shard Id,s, *ID 1 = Always Master*",
        --the table is an array of world ID (whose type is string)
        options = {
            {description = "Disabled", data = 0, hover = "enable only for dedicated server"},	
            {description = "2 + 1 + 1", data = 5, hover = "ID=1-2-3-> 2=ROG+Shipwrecked - 1=Caves - 1=Hamlet"},			
            {description = "1 + 1 + 2", data = 10, hover = "ID=1-2-3-> 1=ROG - 1=Caves - 2=Shipwrecked+Hamlet"},
            {description = "1 + 1 + 1 + 1",   data = 20, hover = "ID=1-2-3-4-> 1=ROG - 1=Caves - 1=Shipwrecked - 1=Hamlet"},
            {description = "Lobby Only",   data = 30, hover = "ID=1-2-3-4-5-> Lobby=ID 1 & 1+1+1+1 setup *ROG=ID 5 in this setup*"},
        },
        default = 0
    },		
	
	{
		name    = "lobbyexit",
		label   = "Lobby exit",
		hover   = "Spawn an Lobby return portal in ROG -> lobby=ID 1",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = false,
	},
	
	{
		name = "",
		label = "OTHER MODS",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},		
	
    {
        name = "cherryforest",
        label = "Cherry Forest",
        hover = "only works if the mod below is enabled",
        options = {
{description = "Mainland", 		data = 10, hover = "Place the Cherry Forest on the main continent so it's easier to find it. 󰀅u󰀅"}, 
{description = "Island", 		data = 20, hover = "Generate a large island to discover in the ocean, or start on it with Wirlywings."}, 
{description = "Grove", 		data = 30, hover = "Also an Island, smaller than the original but with more interesting shapes."}, 
{description = "Archipelago", 	data = 40, hover = "An Island in shards divided by rivers, it's harder but fun for base-building!"}, 
{description = "Moon Morphis", 	data = 50, hover = "The Cherry Forest will be merged within the Lunar Island!"},
        },
        default = 20
    },		
	
	
	{
		name = "",
		label = "LUAJIT",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},		
	
    {
        name = "luajit",
        label = "luajit",
        hover = "luajit will works but Will disable minimaps on pig ruins entrance.",
        options = {
			{description = "YES", data = true, hover = "Enable"},
			{description = "NO", data = false, hover = "Disable"},        },
        default = false
    },		
------------ninguem pode ver isso------------------------	
{
name = "megarandomCompatibilityWater",

default = false,
},

}


--swampyvenice
--pinacle
--gorgeisland
--gorgecity
--mactuskonice
--pandabiome
--Shipwrecked_plus