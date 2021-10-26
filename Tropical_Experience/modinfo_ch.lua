name = " 他们的回归"
description = "注意：我们添加了一个对这个mod的补充。在它将有几个变化，以提高游戏的体验。只访问主mod页面并下载。热带体验|补充"
author = "Vagner da Rocha Santos."
version = "2.53"
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
        label = "选择语言",
		hover = "请变更你的语言...",
        options = 
        {
			{description = "English", data = "stringsEU"},
			{description = "Português", data = "stringsPT"},
			{description = "。中文", data = "stringsCh"},
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
		label = "一种世界",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},
	
	{
		name = "kindofworld",  
		label = "设置世界?", 
		hover = "",
		default = 15,
		options =	{
						{description = "哈姆雷特",         	data = 5, hover = "将基于哈姆雷特DLC生成一个世界，请使用哈姆雷特的设置."},
						{description = "海难世界",       data = 10, hover = "将生成一个基于海难数据DLC的世界，使用海难数据DLC的设置."},					
						{description = "默认",        	data = 15, hover = "将生成自定义世界，使用自定义世界的设置."},
						{description = "海洋世界",        	data = 20, hover = "将生成没有陆地的世界."},					},
    },
	
	{
		name = "",
		label = "哈姆雷特世界",
		hover = "生成一个完整的村庄世界，包括所有废墟、池塘、BFB+巢穴)",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	
	
	{
		name    = "hamletcaves_hamletworld",
		label   = "哈姆雷特洞穴",
		hover   = "将生成一个新的洞穴区域，不要忘记使洞穴工作",
		options =
		{
		{description = "禁用",         data = 0, hover = "This biome will not be generated"},
		{description = "启用",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},

	{
		name    = "togethercaves_hamletworld",
		label   = "共同洞穴",
		hover   = "将生成默认洞穴区域，不要忘记启用洞穴工作",
		options =
		{
		{description = "禁用",         data = 0, hover = "This biome will not be generated"},
		{description = "开启",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},		
	
	{
	name    = "hamletclouds",
	label   = "哈姆雷特 云",
		hover = "替换云纹理的黑色区域 ",
		options =
		{
			{description = "开启", data = true, hover = ""},
			{description = "禁用", data = false, hover = ""},
		},
		default = false,
	},
	
	
	{
		name    = "continentsize",
		label   = "大陆大小",
		hover   = "改变大陆的大小",
		options =
		{
						{description = "紧凑",         	data = 1, hover = "Will generate the continent more compact can reduce lag in the game"},
						{description = "默认",        	data = 2, hover = "Will generate the continent in defal size"},											
						{description = "大型",        	data = 3, hover = "Will generate the continent bigger can increase lag in the game"},
		},
		default = 2,
	},		
	
	{
		name    = "fillingthebiomes",
		label   = "填充生物群落",
		hover   = "改变生物群落的填充，游戏中的延迟就会越小",
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
	label   = "小型猪遗址",
		hover = "将生成房间更少的猪废墟",
		options =
		{
			{description = "开启", data = true, hover = "Less rooms on pig ruins"},
			{description = "禁用", data = false, hover = "Standard Quantity"},
		},
		default = false,
	},
	
	{
		name = "",
		label = "为海难世界",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	
	
	{
		name = "howmanyislands",  
		label = "有多少岛屿",
        hover   = "你可以增加或减少游戏中岛屿的数量，但是更多的岛屿需要更多的时间来生成一个世界", 		
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
		label = "海难：奇遇 扩展包", 
		hover   = "基于海滩DLC并且额外生成一些内容",
		options =	{
			{description = "否", data = false, hover = "黄金国度/文明不会被额外生成"},
			{description = "是", data = true, hover = "黄金国度/文明会被额外生成"},
					},
		default = true,			
	},	
	{
		name = "冰霜岛屿",
		label = "冰霜岛屿", 
		hover   = "它在海洋中创造了一个终年冬天的雪岛，也创造了冰冻的洞穴.",
		default = 10,
		options =	{
						{description = "否",         			data = 5, hover = "禁用生成"},
						{description = "是",        			data = 10, hover = "洞穴与世界的生成"},					
					},
	},	

	{
		name = "Moonshipwrecked",  
		label = "月球生物群落", 
		hover   = "一起生成月球大陆",
		options =	{
			{description = "否", data = 0, hover = "月球大陆不会生成"},
			{description = "是", data = 1, hover = "月球大陆将生成"},
					},
		default = 0,			
	},	

	{
		name    = "海难世界",
		label   = "哈姆雷特洞穴",
		hover   = "将生成一个新的洞穴区域，不要忘记使洞穴工作",
		options =
		{
		{description = "关闭",         data = 0, hover = "这种生物群落不会产生"},
		{description = "开启",          data = 1, hover = "将生成一个新的洞穴区域"},	
		},
		default = 1,
	},

	{
		name    = "一起沉船世界",
		label   = "Together Caves",
		hover   = "将生成defalt洞穴区域，不要忘记启用洞穴工作",
		options =
		{
		{description = "关闭",         data = 0, hover = "这种生物群落不会产生"},
		{description = "开启",          data = 1, hover = "将生成一个新的洞穴区域"},	
		},
		default = 1,
	},		

    {
		name = "",
		label = "习俗世界",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	

	{
		name = "startlocation",  
		label = "玩家入口", 
		hover   = "这是起点，它代表了初始入口周围的生物群落.",
        default = 5,
		options =	{
						{description = "在一起",         	data = 5, hover = "Reign of Giants Biomes"},	
						{description = "海难",       data = 10, hover = "Shipwrecked Biomes"},	
						{description = "哈姆雷特",        	data = 15, hover = "Hamlet Biomes"},					
					},
	},		
		
	{
		name = "Together",  
		label = "巨人生物群落的统治",
        hover   = "Reign of Giants Biomes", 		
		default = 20,
		options =	{
						{description = "禁用",         	data = 5, hover = "Disables this biome"},
						{description = "主要土地",        	data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},					
						{description = "大陆",        	data = 10, hover = "This biome will be generated on another continent."},
						{description = "岛屿",        	data = 15, hover = "This biome will be generated on several separate islands in the ocean"},			
					},
	},	

	{
		name = "Moon",  
		label = "月球生物群落",
        hover   = "月球生物群落", 		
		default = 10,
		options =	{
						{description = "禁用",         	data = 5, hover = "Disables this biome"},
						{description = "主要土地",        	data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},											
						{description = "大陆",        	data = 10, hover = "This biome will be generated on another continent."},
						{description = "岛屿",        	data = 15, hover = "This biome will be generated on several separate islands in the ocean"},	
				
					},
	},		
	
	{
		name = "Shipwrecked",  
		label = "海难生物群落",
        hover   = "海难生物群落", 		
		default = 25,
		options =	{
						{description = "禁用",         	data = 5, hover = "Disables this biome"},
						{description = "主要土地",        	data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},											
						{description = "大陆",        	data = 10, hover = "This biome will be generated on another continent."},
						{description = "岛屿",        	data = 15, hover = "This biome will be generated on several separate islands in the ocean"},	
						{description = "群岛",       data = 25, hover = "This biome will be generated as an compact Islands cluster"},						
					
					},
	},		
	
	{
		name = "Shipwrecked_plus",  
		label = "海难 Plus", 
		hover   = "根据海难加mod生成额外的海难岛",
		options =	{
			{description = "否", data = false, hover = "Eldorado civilization will not be generated"},
			{description = "是", data = true, hover = "Eldorado civilization will be generated"},
					},		
	},

	{
		name    = "Hamlet",
		label   = "哈姆雷特生物群落",
		hover   = "哈姆雷特生物群落", 
		options =
		{
		
		
		{description = "禁用",         data = 5, hover = "Disables this biome"},
		{description = "主要土地",        data = 20, hover = "This biome will be generated in the main land, where the player starts the game"},			
		{description = "陆地",        data = 10, hover = "这个生物群落将在另一个大陆上产生."},
		{description = "岛屿",          data = 15, hover = "This biome will be generated on several separate islands in the ocean"},			
		},
		default = 10,
	},
	
	{
		name    = "pigcity1",
		label   = "猪伯利矿石交易所",
		hover   = "猪城市 1",
		options =
		{
		{description = "禁用",         data = 5, hover = "This pig city will not be generated"},
		{description = "主要土地",        data = 10, hover = "This pig city will be generated in the main land, where the player starts the game"},	
		{description = "陆地",        data = 15, hover = "这个猪城将在另一个大陆上诞生."},
		{description = "岛屿",           data = 20, hover = "This pig city will be generated in a islands in ocean"},	
		},
		default = 15,
	},		
	
	{
		name    = "pigcity2",
		label   = "皇宫",
		hover   = "猪城市2",
		options =
		{
		{description = "禁用",         data = 5, hover = "This pig city will not be generated"},
		{description = "主要土地",        data = 10, hover = "This pig city will be generated in the main land, where the player starts the game"},	
		{description = "陆地",        data = 15, hover = "This pig city will be generated on another continent."},		
		{description = "岛屿",           data = 20, hover = "This pig city will be generated on a islands in ocean"},		
		},
		default = 20,
	},		
	
	{
		name    = "pinacle",
		label   = "峰顶",
		hover   = "生成大鹏鸟巢岛",
		options =
		{
		{description = "禁用",         data = 0, hover = "This biome will not be generated"},
		{description = "启用",          data = 1, hover = "Will generate a small island in the ocean with a roc nest"},	
		},
		default = 1,
	},	
	
	{
		name    = "anthill",
		label   = "蚁丘",
		hover   = "生成蚂蚁山，包括：巢穴入口和皇后区",
		options =
		{
		{description = "禁用",         data = 0, hover = "The Anthill will not be generated"},
		{description = "启用",          data = 1, hover = "The Anthill will be generated"},
		},
		default = 1,
	},	

	{
		name    = "pigruins",
		label   = "古代猪人遗迹",
		hover   = "生成包含毁灭季日历的古猪遗址",
		options =
		{
		{description = "禁用",         data = 0, hover = "The Pig Ruin will not be generated"},
		{description = "启用",          data = 1, hover = "The Pig Ruin will be generated"},
		},
		default = 1,
	},
	
	{
		name    = "gorgeisland",
		label   = "暴食岛",
		hover   = "生成暴食岛",
		options =
		{
		{description = "禁用",         data = 0, hover = "它不会被生成"},
		{description = "启用",          data = 1, hover = "它将会被生成 "},	
		},
		default = 1,
	},	

	{
		name    = "gorgecity",
		label   = "泥潭森林岛/暴食城镇",
		hover   = "在海洋中生成一个暴食城镇",
		options =
		{
		{description = "禁用",         data = 0, hover = "它不会被生成"},
		{description = "启用",          data = 1, hover = "它将会被生成 "},	
		},
		default = 1,
	},
	
	{
		name = "frost_island",
		label = "冰霜岛屿", 
		hover   = "它在海洋中创造了一个终年冬天的雪岛，也创造了冰冻的洞穴.",
		default = 10,
		options =	{
						{description = "否",         			data = 5, hover = "禁用生成"},
						{description = "是",        			data = 10, hover = "允许在洞穴和世界上生成"},					
					},
	},	
	
	{
		name    = "hamlet_caves",
		label   = "哈姆雷特洞穴",
		hover   = "它将在洞穴中形成一个与传统洞穴截然不同的新区域，并在哈姆雷特生物群落中形成新的生物群落",
		options =
		{
		{description = "禁用",         data = 0, hover = "This biome will not be generated"},
		{description = "启用",          data = 1, hover = "Will generate a new cave zone"},	
		},
		default = 1,
	},	
	
	
	{
		name = "",
		label = "全世界",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},	
		
	{
		name = "Volcano",  
		label = "火山", 
		hover   = "生成世界中的火山，如果您的世界已启用洞穴，请选择“洞穴”选项(只会影响习俗和沉船世界）",
		options =	{
			{description = "完整", data = true, hover = "将在内容方面生成一个完整的火山，需要启用"},
			{description = "紧凑", data = false, hover = "将生成不需要启用洞穴的紧凑火山"},
					},
		default = true,			
	},			


	{
		name = "forge",  
		label = "锻造竞技场", 
		hover   = "它将在火山内部生成锻造竞技场(只会影响习俗和失事世界）",
		options =	{
			{description = "启用", data = 1, hover = "将生成锻造竞技场"},
			{description = "禁用", data = 0, hover = "不会生成锻造竞技场"},
					},
		default = 1,			
	},		

	{
		name = "underwater",  
		label = "水下的", 
		hover   = "它将在表面形成通向海底的入口(只会影响风俗、小村庄和沉船世界）",
		options =	{
			{description = "开启", data = true, hover = "形成水下生物群落，洞穴需要能够工作"},
			{description = "禁用", data = false, hover = "水下生物群落不会繁殖"},
					},
		default = true,			
	},	

	{
		name = "",
		label = "海洋设置",
			hover = "只会影响习俗和沉船世界",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},				
	
	{
		name    = "Waves",
		label   = "海洋-海浪",
		hover   = "大海会产生海浪，海风会使它们变得更危险",
		options =
		{
			{description = "否", data = false, hover = ""},
			{description = "是", data = true, hover = ""},
		},
		default = true,
	},

    	{
		name = "kraken",  
		label = "海洋-克拉肯",
        hover = "海难BOSS-克拉肯",		
		default = 1,
		options =	{
						{description = "禁用",         	data = 0, hover = ""},
						{description = "开启",        	data = 1, hover = ""},					
					},
	},	
	
	{
		name = "octopusking",  
		label = "海洋-章鱼王",
        hover = "Shipwrecked Dubloon Trader",		
		default = 1,
		options =	{
						{description = "禁用",         	data = 0, hover = ""},
						{description = "开启",        	data = 1, hover = ""},					
					},
	},	
	
	{
		name = "mangrove",  
		label = "海洋-红树林",
        hover = "将在海洋上形成红树林生物群落", 		
		default = 1,
		options =	{
						{description = "禁用",         	data = 0, hover = ""},
						{description = "开启",        	data = 1, hover = ""},							
					},
	},	

	{
		name = "lilypad",  
		label = "海洋-睡莲生态群落",
        hover = "将在海上生成睡莲生态群落，包括河马", 		
		default = 1,
		options =	{
						{description = "禁用",         	data = 0, hover = ""},
						{description = "开启",        	data = 1, hover = ""},								
					},
	},
	
	{
		name = "shipgraveyard",  
		label = "船舶墓地生物群落",
        hover = "将生成船舶墓地生物群落", 		
		default = 1,
		options =	{
						{description = "禁用",         	data = 0, hover = ""},
						{description = "开启",        	data = 1, hover = ""},								
					},
	},			

	{
		name = "coralbiome",  
		label = "珊瑚生物群落",
        hover = "将产生珊瑚生物群落", 		
		default = 1,
		options =	{
						{description = "禁用",         	data = 0, hover = ""},
						{description = "开启",        	data = 1, hover = ""},								
					},
	},	

	{
		name = "",
		label = "游戏设置",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},
	
	{
		name    = "aporkalypse",
		label   = "毁灭季",
		hover   = "如果不在废墟中重置日历，则每60天出现一次日历*活动时间：20天*",
		options =
		{
			{description = "开启", data = true, hover = ""},
			{description = "禁用", data = false, hover = ""},
		},
		default = true,
	},	
	
	{
		name    = "sealnado",
		label   = "豹卷风",
		hover   = "春天将在海难生物群落产卵*豹卷风/旋风*",
		options =
		{
			{description = "开启", data = true, hover = ""},
			{description = "禁用", data = false, hover = ""},
		},
		default = true,
	},	
	
			
	{
		name = "",
		label = "天气设置",
			hover = "可以影响所有的世界",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},

	{
		name    = "flood",
		label   = "雨季：洪水",
		hover   = "春天，水坑会产卵并吸引水中的蚊子",
		options =
		{	
			{description = "禁用", 	data = 5,  hover = "关闭"},
			{description = "热带", 	data = 10, hover = "只会出现在热带地区"},
			{description = "全世界", 	data = 20, hover = "将出现在全世界"},				
		},
		default = 10,	
	},	
	
	{
		name    = "wind",
		label   = "飓风",
		hover   = "影响速度，使树木和植物倒下，海洋产生更多强大的波浪",
		options =
		{
			{description = "禁用", 			data = 5,  hover = "禁用"},
			{description = "热带：哈姆雷特", 	data = 10, hover = "将只出现在热带和哈姆雷特区域"},
			{description = "全世界", 		data = 20, hover = "将出现在全世界"},				
		},
		default = 10,
	},	

	{
		name    = "hail",
		label   = "冰雹雨",
		hover   = "可以从天空降下冰雹和冰",
		options =
		{
			{description = "启用", data = true, hover = ""},
			{description = "禁用", data = false, hover = ""},
		},
		default = true,
	},	
	
	{
		name    = "volcaniceruption",
		label   = "火山喷发",
		hover   = "使火山喷发成为可能",
		options =
		{
			{description = "禁用", 	data = 5,  hover = "禁用"},
			{description = "热带", 	data = 10, hover = "只会出现在热带地区"},
			{description = "全世界", 	data = 20, hover = "将影响全世界"},	
		},
		default = 10,
	},	
	
	{
		name    = "fog",
		label   = "冬雾",
		hover   = "启用冬季的雾",
		options =
		{
			{description = "禁用", 			data = 5,  hover = "禁用"},
			{description = "哈姆雷特地带", 		data = 10, hover = "将仅在哈姆雷特区域中显示"},
			{description = "全世界", 		data = 20, hover = "影响全世界"},	
		},
		default = 10,
	},		

	{
		name    = "hayfever",
		label   = "花粉热",
		hover   = "在夏天可以预防花粉热",
		options =
		{
			{description = "禁用", 			data = 5,  hover = "禁用"},
			{description = "哈姆雷特地带", 		data = 10, hover = "将仅在哈姆雷特区域中显示"},
			{description = "全世界", 		data = 20, hover = "影响全世界"},	
		},
		default = 10,
	},	

	{
		name = "",
		label = "HUD 调整",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},
	
	{
		name    = "disable_snow_effectst",
		label   = "禁用雪特效",
		hover = "禁用雪特效禁用草地上的地面雪特效",
		options =
		{
			{description = "启用", data = true, hover = ""},
			{description = "禁用", data = false, hover = ""},
		},
		default = false,
	},

	{
		name    = "removedark",
		label   = "移除黑暗",
		options =
		{
			{description = "启用", data = true, hover = ""},
			{description = "禁用", data = false, hover = ""},
		},
		default = false,
	},		

	{
		name    = "home_tab",
		label   = "家的面板",
		hover = "站在你家的中间，让标签出现",
		options =
		{
			{description = "正常", 	data = 0, hover = "Own Extra TAB"},
			{description = "Agrouped", 	data = 1, hover = "Cluster TAB: Home-City-Volcano Tab *3in1*"},
			{description = "禁用", 	data = 2, hover = "Disable Tab"},	
		},
		default = 1,
	},	

	{
		name    = "city_tab",
		label   = "城市面板",
		hover = "Put City key on the ground to make the TAB appear",
		options =
		{
			{description = "正常", 	data = 0, hover = "Own Extra TAB"},
			{description = "Agrouped", 	data = 1, hover = "Cluster TAB: Home-City-Volcano Tab*3in1*"},
			{description = "禁用", 	data = 2, hover = "Disable Tab"},	
		},
		default = 1,
	},	

	
	{
		name    = "obsidian_tab",
		label   = "黑曜石标签",
		hover = "可以在它附近的火山台中找到，以显示标签",
		options =
		{
			{description = "正常", 	data = 0, hover = "Own Extra TAB"},
			{description = "Agrouped", 	data = 1, hover = "Cluster TAB: Home-City-Volcano Tab*3in1*"},
			{description = "禁用", 	data = 2, hover = "Disable Tab"}	
		},
		default = 1,
	},
	
	{
		name    = "nautical_tab",
		label   = "航海标签",
		hover = "启用船只制作选项卡，2个木筏需要一个小贩/桨*更高级别的失事船只行为默认值*",
		options =
		{
			{description = "禁用", data = false, hover = "Disable Tab"},
			{description = "禁用", data = true, hover = "Own Extra TAB"},
		},
		default = true,
	},
	
	{
		name    = "seafaring_tab",
		label   = "航海",
		hover = "航海标签上的所有物品将转移到航海tab键",
		options =
		{
			{description = "禁用", data = false, hover = "Disable Tab"},
			{description = "开启", data = true, hover = "Own Extra TAB"},
		},
		default = false,
	},	
	
	{
		name = "boatlefthud",  label = "Boat HUD(Vertical Adjustment)", default = 0,
	    hover   = "在这里，您可以调整船HUD*表的高度", 
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
		label = "房子的墙", 
		default = 0,
	    hover   = "如果墙不在中心，可以调整墙的位置", 
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
		label = "碎片专用",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},		
	
	{
		name    = "enableallprefabs",
		label   = "启用所有预设",
        hover = "用于服务器碎片和测试，如果不活动，生成的项目可能在非混合世界中崩溃",
		options =
		{
			{description = "YES", data = true, hover = ""},
			{description = "NO", data = false, hover = ""},
		},
		default = false,
	},			

    {
        name = "tropicalshards",
        label = "热带碎片",
        hover = "预设世界和门户如何使用碎片Id，s，*Id 1=始终主节点进行连接*",
        --the table is an array of world ID (whose type is string)
        options = {
            {description = "禁用", data = 0, hover = "仅对专用服务器启用"},	
            {description = "2 + 1 + 1", data = 5, hover = "ID=1-2-3-> 2=ROG+Shipwrecked - 1=Caves - 1=Hamlet"},			
            {description = "1 + 1 + 2", data = 10, hover = "ID=1-2-3-> 1=ROG - 1=Caves - 2=Shipwrecked+Hamlet"},
            {description = "1 + 1 + 1 + 1",   data = 20, hover = "ID=1-2-3-4-> 1=ROG - 1=Caves - 1=Shipwrecked - 1=Hamlet"},
            {description = "仅大厅",   data = 30, hover = "ID=1-2-3-4-5-> Lobby=ID 1 & 1+1+1+1 setup *ROG=ID 5 in this setup*"},
        },
        default = 0
    },		
	
	{
		name    = "lobbyexit",
		label   = "大厅出口",
		hover   = "在ROG->Lobby=ID 1中生成大厅返回出口",
		options =
		{
			{description = "开启", data = true, hover = ""},
			{description = "禁用", data = false, hover = ""},
		},
		default = false,
	},
	
	{
		name = "",
		label = "其他mod",
			hover = "",
		options =	{
						{description = "", data = 0},
					},
		default = 0,
	},		
	
    {
        name = "cherryforest",
        label = "樱花森林",
        hover = "仅在启用下面的mod时有效",
        options = {
{description = "大陆", 		data = 10, hover = "把樱桃林放在主大陆上，这样更容易找到它"}, 
{description = "孤岛", 		data = 20, hover = "生成一个大岛，在海洋中发现"}, 
{description = "树林", 		data = 30, hover = "也是一个小岛，比原来的小岛小，但形状更有趣."}, 
{description = "群岛", 	data = 40, hover = "一个被河流分割成碎片的岛屿，对于基地建设来说，这虽然困难，但很有趣！"}, 
{description = "月岛", 	data = 50, hover = "樱花林将并入月球岛！"},
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
        label = "luajit引擎",
        hover = "luajit将工作，但将禁用猪遗址入口的最小地图.",
        options = {
			{description = "开启", data = true, hover = "Enable"},
			{description = "禁用", data = false, hover = "Disable"},        },
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