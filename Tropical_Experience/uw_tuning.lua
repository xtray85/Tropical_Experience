
-- Definitions
GLOBAL.UW_TUNING = {}
local UW_TUNING = GLOBAL.UW_TUNING
local day_length = 30*16

-- Config options
-- UW_TUNING.DEBUG_MODE = GetModConfigData("debug_mode")
-- UW_TUNING.OXYGENMETER_COMPACT = GetModConfigData("oxygenmetermode")
UW_TUNING.DEBUG_MODE = false
UW_TUNING.OXYGENMETER_COMPACT = true
UW_TUNING.CITD_BGCOLOURS = {50/255, 100/255, 220/255}

-- Oxygen
UW_TUNING.OXYGEN_LOSS_RATE = -100/60 -- 100 a minute
UW_TUNING.OXYGEN_EFFECT_RANGE = 8
UW_TUNING.OXYGEN_AIRINESS = 1
UW_TUNING.BUBBLE_OXYGEN_AMOUNT = 10
UW_TUNING.BUBBLE_FLOAT_TIME = 5
UW_TUNING.OXYGEN_THRESH = 0.2

UW_TUNING.PLAYER_OXYGEN = {
	WILSON = 100, -- Default is 100
	WILLOW = 80,
	WOLFGANG = 150,
	WENDY = 80,
	WICKERBOTTOM = 100,
	WOODIE = 150,
	WES = 55,
	WAXWELL = 120,
	WIGFRID = 150,
	WEBBER = 85,
}

-- World
UW_TUNING.MAX_UNDERWATER_ENTRANCES = 2

UW_TUNING.TIDAL_EFFECT_RANGE = 16

UW_TUNING.GEOTHERMAL_VENT_HEAT = 180
UW_TUNING.GEOTHERMAL_VENT_AIR = 30


-- Items
UW_TUNING.HAT_DIVING_PERISHTIME = 10*day_length
UW_TUNING.HAT_DIVING_PERCENTAGE = 0.8

UW_TUNING.HAT_SNORKEL_PERISHTIME = 8*day_length
UW_TUNING.HAT_SNORKEL_PERCENTAGE = 0.5

UW_TUNING.PEARL_AMULET_FUEL = 2*day_length
UW_TUNING.PEARL_AMULET_RATE = 8

-- Monsters
UW_TUNING.SEATENTACLE_THIEF_CHANCE = 0.33

UW_TUNING.JELLYFISH_SPAWN_DELAY = 0.5*day_length
UW_TUNING.JELLYFISH_SPAWN_VAR = 0.5*day_length

UW_TUNING.SHRIMP_SPAWN_DELAY = 0.5*day_length
UW_TUNING.SHRIMP_SPAWN_VAR = 0.5*day_length

UW_TUNING.CRAB_GROW_TIME = {base = 3*day_length, random = 2*day_length}
--UW_TUNING.CRAB_GROW_TIME = {base = 15, random = 5}
UW_TUNING.CRAB_RESPAWN_TIME = 10
UW_TUNING.CRAB_TARGET_DIST = 10

UW_TUNING.TINYCRAB_WALK_SPEED = 10
UW_TUNING.TINYCRAB_DAMAGE = 1
UW_TUNING.TINYCRAB_HEALTH = 25

UW_TUNING.SMALLCRAB_WALK_SPEED = 6
UW_TUNING.SMALLCRAB_DAMAGE = 10
UW_TUNING.SMALLCRAB_HEALTH = 100

UW_TUNING.MEDIUMCRAB_WALK_SPEED = 4
UW_TUNING.MEDIUMCRAB_DAMAGE = 20
UW_TUNING.MEDIUMCRAB_HEALTH = 300

UW_TUNING.LARGECRAB_WALK_SPEED = 2
UW_TUNING.LARGECRAB_DAMAGE = 30
UW_TUNING.LARGECRAB_HEALTH = 700

UW_TUNING.SEA_EEL_WALK_SPEED = 6
UW_TUNING.SEA_EEL_DAMAGE = 35
UW_TUNING.SEA_EEL_ATTACK_PERIOD = 0.5
UW_TUNING.SEA_EEL_HEALTH = 100

UW_TUNING.CLAM_HEALTH = 250
UW_TUNING.CLAM_SPAWN_DELAY = 0.5*day_length
UW_TUNING.CLAM_SPAWN_VAR = 0.5*day_length
