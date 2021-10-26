local SCHOOL_SIZE = {
	TINY = 		{min=1,max=3},
	SMALL = 	{min=2,max=5},
	MEDIUM = 	{min=4,max=6},
	LARGE = 	{min=6,max=10},	
}

local SCHOOL_AREA = {
	TINY = 		2,
	SMALL = 	2,
	MEDIUM = 	2,
	LARGE = 	2,	
}

local seg_time = 30
local total_day_time = seg_time*16
local SCHOOL_SPAWN_DELAY = {min=0.5*seg_time, max=2*seg_time}
local SCHOOL_SPAWNER_FISH_CHECK_RADIUS = 30
local SCHOOL_SPAWNER_MAX_FISH = 10
local SCHOOL_SPAWNER_BLOCKER_MOD = 1/3
local SCHOOL_SPAWNER_BLOCKER_LIFETIME = total_day_time/2 --dividi

local CRIATURAS = 
{

	bioluminescence = { 
	  	prefab = "bioluminescence", 
	  	schoolmin = 1,
	  	schoolmax = 2,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},
			
	bubble_fx = { 
	  	prefab = "bubble_fx", 
	  	schoolmin = 1,
	  	schoolmax = 2,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},
			
	seatentacle = { 
	  	prefab = "seatentacle", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_small_underwater_1 = { 
	  	prefab = "oceanfish_small_underwater_1", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},
	
	
	oceanfish_small_underwater_2 = { 
	  	prefab = "oceanfish_small_underwater_2", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_small_underwater_3 = { 
	  	prefab = "oceanfish_small_underwater_3", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_small_underwater_4 = { 
	  	prefab = "oceanfish_small_underwater_4", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},
	
	oceanfish_small_underwater_5 = { 
	  	prefab = "oceanfish_small_underwater_5", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	oceanfish_small_underwater_6 = { 
	  	prefab = "oceanfish_small_underwater_6", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_small_underwater_7 = { 
	  	prefab = "oceanfish_small_underwater_7", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_small_underwater_8 = { 
	  	prefab = "oceanfish_small_underwater_8", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	oceanfish_medium_underwater_1 = { 
	  	prefab = "oceanfish_medium_underwater_1", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	
	
	oceanfish_medium_underwater_2 = { 
	  	prefab = "oceanfish_medium_underwater_2", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_medium_underwater_3 = { 
	  	prefab = "oceanfish_medium_underwater_3", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_medium_underwater_4 = { 
	  	prefab = "oceanfish_medium_underwater_1", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_medium_underwater_5 = { 
	  	prefab = "oceanfish_medium_underwater_5", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_medium_underwater_6 = { 
	  	prefab = "oceanfish_medium_underwater_6", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},

	oceanfish_medium_underwater_7 = { 
	  	prefab = "oceanfish_medium_underwater_7", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},
	
	oceanfish_medium_underwater_8 = { 
	  	prefab = "oceanfish_medium_underwater_8", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	
	
	fish2_alive = { 
	  	prefab = "fish2_alive", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	
	
	fish3_alive = { 
	  	prefab = "fish3_alive", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	fish4_alive = { 
	  	prefab = "fish4_alive", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	fish5_alive = { 
	  	prefab = "fish5_alive", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		
	
	goldfish_alive = { 
	  	prefab = "goldfish_alive", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	mecfish_alive = { 
	  	prefab = "mecfish_alive", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		
	
	shrimp = { 
	  	prefab = "shrimp", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	quagmire_salmom_alive = { 
	  	prefab = "quagmire_salmom_alive", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	commonfish = { 
	  	prefab = "commonfish", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	fish_coi = { 
	  	prefab = "fish_coi", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	rainbowjellyfish_underwater = { 
	  	prefab = "rainbowjellyfish_underwater", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		

	jellyfish_underwater = { 
	  	prefab = "jellyfish_underwater", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	
	
	dogfish_under = { 
	  	prefab = "dogfish_under", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	stungrayunderwater = { 
	  	prefab = "stungrayunderwater", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},	

	squidunderwater = { 
	  	prefab = "squidunderwater", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		
	
	squidunderwater2 = { 
	  	prefab = "squidunderwater2", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		
	
	lobsterunderwater = { 
	  	prefab = "lobsterunderwater", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		
	
	sea_eel = { 
	  	prefab = "sea_eel", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		
	
	swordfishunderwater = { 
	  	prefab = "swordfishunderwater", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.LARGE,
	},		
	
}

local SCHOOL_VERY_COMMON		= 4
local SCHOOL_COMMON				= 2
local SCHOOL_UNCOMMON			= 1
local SCHOOL_RARE				= 0.25

local PESODOGRUPO = {
	[SEASONS.AUTUMN] = {
	

--	        reef_jellyfish =			2,			
-- clam	
	
	    [GROUND.UNDERWATER_SANDY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },
		
	    [GROUND.UNDERWATER_ROCKY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,	
	    },
		
	    [GROUND.BEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,				
	    },
		
	    [GROUND.MAGMAFIELD] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },

	    [GROUND.PAINTED] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },	
		
	    [GROUND.BATTLEGROUND] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },	

	    [GROUND.PEBBLEBEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },					
		
    },
	
	[SEASONS.WINTER] = {
	
	    [GROUND.UNDERWATER_SANDY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },
		
	    [GROUND.UNDERWATER_ROCKY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,				
	    },
		
	    [GROUND.BEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,				
	    },
		
	    [GROUND.MAGMAFIELD] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },

	    [GROUND.PAINTED] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },	
		
	    [GROUND.BATTLEGROUND] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },	
		
	    [GROUND.PEBBLEBEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },			
		
    },

	[SEASONS.SPRING] = {
	
	    [GROUND.UNDERWATER_SANDY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },
		
	    [GROUND.UNDERWATER_ROCKY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },
		
	    [GROUND.BEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },
		
	    [GROUND.MAGMAFIELD] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },

	    [GROUND.PAINTED] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },	
		
	    [GROUND.BATTLEGROUND] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },	

	    [GROUND.PEBBLEBEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },					
		
    },

	[SEASONS.SUMMER] = {
	
	    [GROUND.UNDERWATER_SANDY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },
		
	    [GROUND.UNDERWATER_ROCKY] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },
		
	    [GROUND.BEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,		
	    },
		
	    [GROUND.MAGMAFIELD] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,	
	    },

	    [GROUND.PAINTED] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,		
	    },	
		
	    [GROUND.BATTLEGROUND] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,	
	    },	

	    [GROUND.PEBBLEBEACH] = 
		{
	        bioluminescence =				0.5,
	        bubble_fx = 					2,
	        seatentacle = 					1,
			oceanfish_small_underwater_1 =	1,			
			oceanfish_small_underwater_2 =	1,			
			oceanfish_small_underwater_3 =	1,			
			oceanfish_small_underwater_4 =	1,			
			oceanfish_small_underwater_5 =	1,
			oceanfish_small_underwater_6 =	1,
			oceanfish_small_underwater_7 =	1,
			oceanfish_small_underwater_8 =	1,			
			oceanfish_medium_underwater_1 = 1,
			oceanfish_medium_underwater_2 = 1, 
			oceanfish_medium_underwater_3 = 1,  
			oceanfish_medium_underwater_4 = 1,
			oceanfish_medium_underwater_5 = 1, 
			oceanfish_medium_underwater_6 = 1,  
			oceanfish_medium_underwater_7 = 1,
			oceanfish_medium_underwater_8 = 1,			
	        fish2_alive =					1,
	        fish3_alive = 					1,
	        fish4_alive = 					1,
	        fish5_alive =					1,
	        shrimp  =						1,	
	        quagmire_salmom_alive = 		1,	
			commonfish = 					1,			
			fish_coi = 						1,
			rainbowjellyfish_underwater = 	1,	
	        jellyfish_underwater = 			1,
			dogfish_under =					1,	
	        stungrayunderwater = 			1,
	        squidunderwater = 				1,	
	        squidunderwater2 = 				1,	
	        lobsterunderwater =				1,		
	        sea_eel = 						1,	
			swordfishunderwater	= 			1,	
			sharxunderwater	= 				1,
			mecfish_alive	= 				1,
			goldfish_alive	= 				1,			
	    },			
		
    },	
}


return Class(function(self, inst)

assert(TheWorld.ismastersim, "SchoolSpawner should not exist on client")

--------------------------------------------------------------------------
--[[ Constants ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ Member variables ]]
--------------------------------------------------------------------------

--Public
self.inst = inst

--Private
local _scheduledtasks = {}

--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------
local TEMPOMINIMO = 5
local TEMPOMAXIMO = 10
local GNARWAIL_TEST_RADIUS = 100
local GNARWAIL_SPAWN_CHANCE = 0.05
local GNARWAIL_SPAWN_RADIUS = 10
local GNARWAIL_TIMING = {8, 10} -- min 8, max 10
local function testforgnarwail(comp, spawnpoint)
    local ents = TheSim:FindEntities(spawnpoint.x, spawnpoint.y, spawnpoint.z, GNARWAIL_TEST_RADIUS, { "eel" })
    if #ents < 2 and math.random() < GNARWAIL_SPAWN_CHANCE then
        local offset = FindWalkableOffset(spawnpoint, math.random()*2*PI, GNARWAIL_SPAWN_RADIUS)
        if offset then
            comp.inst:DoTaskInTime(GetRandomMinMax(GNARWAIL_TIMING[1], GNARWAIL_TIMING[2]), function()
                local gnarwail = SpawnPrefab("sea_eel")
                gnarwail.Transform:SetPosition(spawnpoint.x + offset.x, 0, spawnpoint.z + offset.z)
--                gnarwail.sg:GoToState("emerge")			
            end)
        end
    end
end

local function SpawnSchoolForPlayer(player, reschedule)
    if self:ShouldSpawnANewSchoolForPlayer(player) then
        local spawnpoint = self:GetSpawnPoint(player:GetPosition())
        if spawnpoint ~= nil then
            self:SpawnSchool(spawnpoint, player)
        end
    end

    _scheduledtasks[player] = nil
    reschedule(player)
end

local function ScheduleSpawn(player)
    if _scheduledtasks[player] == nil then
        _scheduledtasks[player] = player:DoTaskInTime(5, SpawnSchoolForPlayer, ScheduleSpawn)
    end
end

local function CancelSpawn(player)
    if _scheduledtasks[player] ~= nil then
        _scheduledtasks[player]:Cancel()
        _scheduledtasks[player] = nil
    end
end

local function PickSchool(spawnpoint)
	if PESODOGRUPO[TheWorld.state.season] ~= nil then
		local school_choices = PESODOGRUPO[TheWorld.state.season][TheWorld.Map:GetTileAtPoint(spawnpoint.x,spawnpoint.y,spawnpoint.z)]
		local schooltype = school_choices and weighted_random_choice(school_choices) or nil
		return schooltype ~= nil and CRIATURAS[schooltype] or nil
	end
end

--------------------------------------------------------------------------
--[[ Private event handlers ]]
--------------------------------------------------------------------------

local function OnPlayerJoined(src, player)
	ScheduleSpawn(player)
end

local function OnPlayerLeft(src, player)
    CancelSpawn(player)
end

--------------------------------------------------------------------------
--[[ Initialization ]]
--------------------------------------------------------------------------

--Initialize variables
for i, v in ipairs(AllPlayers) do
    ScheduleSpawn(player)
end

--Register events
inst:ListenForEvent("ms_playerjoined", OnPlayerJoined, TheWorld)
inst:ListenForEvent("ms_playerleft", OnPlayerLeft, TheWorld)

--------------------------------------------------------------------------
--[[ Public member functions ]]
--------------------------------------------------------------------------

function self:ShouldSpawnANewSchoolForPlayer(player, percent_ground)
	local pt = player:GetPosition()
	local num_fish = #TheSim:FindEntities(pt.x, pt.y, pt.z, SCHOOL_SPAWNER_FISH_CHECK_RADIUS, {"tropicalspawner"})
	if num_fish <= SCHOOL_SPAWNER_MAX_FISH then return true 
	else
	return false
	end
end

function self:GetSpawnPoint(pt)
    local function TestSpawnPoint(offset)
        return PickSchool(pt + offset) and not TheWorld.Map:IsOceanAtPoint((pt + offset):Get())
    end
	local SPAWN_DIST = 23
    local theta = math.random() * 2 * PI
	local resultoffset = FindValidPositionByFan(theta, SPAWN_DIST, 12, TestSpawnPoint)
						or FindValidPositionByFan(theta, SPAWN_DIST, 12, TestSpawnPoint)
						or FindValidPositionByFan(theta, SPAWN_DIST, 12, TestSpawnPoint)
						or nil

    if resultoffset ~= nil then
        return pt + resultoffset
    end
end

local function DoSpawnFish(prefab, pos, rot, herd)
local map = TheWorld.Map
local x, y, z = pos:Get()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
--if ground == GROUND.UNDERWATER_ROCKY or
--ground == GROUND.UNDERWATER_SANDY then
local fish = SpawnPrefab(prefab)
fish.Transform:SetPosition(pos:Get())
--    fish.sg:GoToState("arrive")
--end
end

function self:SpawnSchool(spawnpoint, target)
    local schooldata = PickSchool(spawnpoint)
    if schooldata == nil then
        return
    end
	
	local herd

    local schoolsize = math.random(schooldata.schoolmin, schooldata.schoolmax)
    local rotation = math.random()*360

    local school_rand_angle = math.random()*360
	local school_spawnpoint = spawnpoint 
	--[[+ (FindWalkableOffset(spawnpoint, school_rand_angle, 20, 12, nil, nil, nil, true)
											or FindWalkableOffset(spawnpoint, school_rand_angle, 13, 12, nil, nil, nil, true)
											or FindWalkableOffset(spawnpoint, school_rand_angle, 7, 12, nil, nil, nil, true)
											or Vector3(0,0,0))
]]
    local count = 0
    for i = 1, schoolsize do
        local radius = math.sqrt(math.random())*schooldata.schoolrange
        local angle = math.random()*360

        local offset = FindWalkableOffset(school_spawnpoint, angle, radius, 12, true, nil, nil, true)
        if offset then
			if count == 0 then
				DoSpawnFish(schooldata.prefab, school_spawnpoint + offset, rotation, herd) 
--				print(offset)
			else
	            self.inst:DoTaskInTime(0.1+math.random()*1,function() DoSpawnFish(schooldata.prefab, school_spawnpoint + offset, rotation, herd) end)
			end
            count = count + 1
        end
    end

	--print("[schools - SpawnSchool] Spawned " .. tostring(count) .. "x " .. tostring(schooldata.prefab) .. " for " .. tostring(target))

    if count > 0 then
		SpawnPrefab("tropicalspawnblocker").Transform:SetPosition(spawnpoint:Get())

--        self.inst:PushEvent("schoolspawned", {spawnpoint = spawnpoint})

        local tile_at_spawnpoint = TheWorld.Map:GetTileAtPoint(spawnpoint:Get())
--        if tile_at_spawnpoint == GROUND.OCEAN_SWELL or tile_at_spawnpoint == GROUND.OCEAN_ROUGH then
--            testforgnarwail(self, spawnpoint)
--        end
	else
--		herd:Remove()
--		herd = nil
    end
end

--------------------------------------------------------------------------
--[[ Save/Load ]]
--------------------------------------------------------------------------

function self:OnSave()
    return
    {
    }
end

function self:OnLoad(data)
end

--------------------------------------------------------------------------
--[[ Debug ]]
--------------------------------------------------------------------------

function self:GetDebugString()
    local str = nil
	for k, t in pairs(_scheduledtasks) do

		local pt = k:GetPosition()
		local percent_ocean = 1 TheWorld.Map:CalcPercentOceanTilesAtPoint(pt.x, pt.y, pt.z, 25)
		str = (str == nil and "" or "\n")..tostring(k).." in "..string.format("%.2f", GetTaskRemaining(t)).." ocean = "..string.format("%.2f", percent_ocean).."%"
	end
	return str or "no scheduled tasks"
end

--------------------------------------------------------------------------
--[[ End ]]
--------------------------------------------------------------------------

end)
