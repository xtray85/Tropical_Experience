local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local ACTIONS = GLOBAL.ACTIONS
local require = GLOBAL.require
local TheInput = GLOBAL.TheInput
local ThePlayer = GLOBAL.ThePlayer
local IsServer = GLOBAL.TheNet:GetIsServer()
local Inv = require "widgets/inventorybar"
local containers = GLOBAL.require "containers"
local TheWorld = GLOBAL.TheWorld

GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

_G = GLOBAL;
require, rawget, getmetatable, unpack = _G.require, _G.rawget, _G.getmetatable, _G.unpack
TheNet = _G.TheNet;
IsServer, IsDedicated = TheNet:GetIsServer(), TheNet:IsDedicated()
TheSim = _G.TheSim
STRINGS = _G.STRINGS
RECIPETABS, TECH, AllRecipes, GetValidRecipe = _G.RECIPETABS, _G.TECH, _G.AllRecipes, _G.GetValidRecipe
EQUIPSLOTS, FRAMES, FOODTYPE, FUELTYPE = _G.EQUIPSLOTS, _G.FRAMES, _G.FOODTYPE, _G.FUELTYPE

State, TimeEvent, EventHandler = _G.State, _G.TimeEvent, _G.EventHandler
ACTIONS, ActionHandler = _G.ACTIONS, _G.ActionHandler
CAMERASHAKE, ShakeAllCameras = _G.CAMERASHAKE, _G.ShakeAllCameras

SpawnPrefab, ErodeAway, FindEntity = _G.SpawnPrefab, _G.ErodeAway, _G.FindEntity
KnownModIndex, Vector3, Remap = _G.KnownModIndex, _G.Vector3, _G.Remap
COMMAND_PERMISSION, BufferedAction, SendRPCToServer, RPC = _G.COMMAND_PERMISSION, _G.BufferedAction, _G.SendRPCToServer,
    _G.RPC
COLLISION = _G.COLLISION

AllPlayers = _G.AllPlayers

PrefabFiles = {
				"sparkle_fx", "fx", "Axes", "armor_obsidian", "meteor_impact", "dug_cofeecactus", "turfesvolcanobiome",
               	"snake", "snake_hole", "snakeskin", "poisonbubble", "venom_gland", "harpoon", "new_hats",
               	"parrot_pirate", "dubloon", "machetes", "tunacan", "seagull", "toucan", "lake", -- "lakeinside",
				"boatcork", "frogpoison", "mosquitopoison", "cormorant", "antidote", "chiminea", "chimineafire", "armor_seashell",
               	"ox_horn", "ox", "oxherd", "knightboat_cannonshot", "rowboat_wake", -- trail do rowboat
				"splash_water", "blubber", "fish_med", "debris", -- debris_1, debris_2, debris_3, debris_4 espalhar na praia
				"boatrepairkit", "sandbag", "cutlass", "cookpotfoodssw", "luggarechestspawn", "porto", "porto2", "buriedtreasure",
               	"windtrail", "windswirl", "ventania", "sail", "boattorch", "boatlantern", "boatcannon",
               	"woodlegs_boatcannon", "quackeringram", "quackenbeak", "quackendrill", "quackering_wave",
               	"quackering_wake", "trawlnet", "boatsurf", "boatsurfothers", "boatpirate", "turbine_blades", "buoy",
               	"armor_lifejacket", "saplingnova", "edgefog", "boatpirateamigo", "shadowwaxwell_boat", "luckyhat",
               	"telescope", "thatchpack", "parrot", "seagullwater", "seaweed_stalk", "corallarve", "nubbin", "coconade",
               	"piratepack", "ox_flute", "blubbersuit", "tarsuit", "tarlamp", "waterchest", "mussel_bed",
               	"mussel_stick", "messagebottle1", "bottlelantern", "researchlab5", "roe", "roe_fish", "fishfarm",
               	"fishfarm_sign", "mussel_farm", "sea_chiminea", "tar_extractor", "seatrap", -- "flood",
				"hail", "wave_ripple", -------------------------complemento---------------------------------
				"twister_defogo", "twister_tornadodefogo", "firetwister_spawner", "fire_twister_seal", "walani", "wilbur", "woodlegs",
               	"glass", "grass_tall", "asparagus", "deep_jungle_fern_noise", "vampirebatcave",
               	"vampirebatcave_interior", "roc_cave_entrance", "roc_cave_interior", "vampitecave_deco", "spearlauncher",
               	"spear_wathgrithr", "speargun", "jungletreeguard", "seataro_planted", "seatarospawner", "ox_wool",
               	"conch", "seacucumber", "watercress", "jungletreeguard_snake", "armor_cactus", "scorpion",
               	"cookpotfoodshamlet", "cork", "corkbat", "hats_hamlet", "sedimentpuddle", "flood_ice", "snake2",
               	"bramble", "bramble_bulb", "dungball", "dungbeetle", "dungpile", "chitin", "pinkman", "oincpile",
               	"piggolem", "turfshamlet", "krakenchest", "lavaarena_hound", "lavaarena_knight", "lavaarena_merm",
               	"lavaarena_spider", "lavaarena_bishop", "frog_poison", "spearsw", "boatmetal", "bird_swarm", "birds_ham",
               	"blunderbuss", "cloudpuff", "bishopwater", "rookwater", "solofish", "tropicalspawnblocker", "whaletrack",
               	"swfishbait", "beds", "rug", "shears", "gold_dust", "goldpan", -------
				"icebearger", "icedeerclops", "icerockcreatures", "cave_exit_vulcao", "cave_entrance_vulcao", "vidanomar",
               	"vidanomarseaworld", "ashfx", "whirlpool", "boat_raft_rot", "panda", "pandaskin", "pandatree",
               	"nectar_pod", "piggravestone", "mangrovespawner", "oxwaterspawner", "grasswaterspawner",
               	"waterreedspawner", "fishinholewaterspawner", "poisonbalm", "seasack", "magic_seal", "wind_conch",
               	"sail_stick", "armor_windbreaker", "vine", "basefan", "floodsw", "birdwhistle", "bundled_structure",
               	"lavaarena_armor", "lavarenainside", "teleportato2", "galinheiro", "invisiblepondfish",
               	"spider_mutators_new", "anthillcave", "anthill_cavelamp", "grotto_grub_nest", "grotto_grub",
               	"grotto_parsnip", "otter", "grottoqueen", "icedpad", -- "yeti",
				"artic_flower", "watertree_pillar2"
}

table.insert(PrefabFiles, "pigbanditexit")
if GetModConfigData("tropicalshards") ~= 0 then
    table.insert(PrefabFiles, "porkland_sw_entrance")
end

if GetModConfigData("kindofworld") == 10 then
    table.insert(PrefabFiles, "boatraft_old")
    table.insert(PrefabFiles, "boatlog_old")
end
table.insert(PrefabFiles, "boatraft")

table.insert(PrefabFiles, "vampirebat")
table.insert(PrefabFiles, "aporkalypse_clock")
table.insert(PrefabFiles, "hanging_vine")
table.insert(PrefabFiles, "grabbing_vine")

table.insert(PrefabFiles, "dragoonegg") -- jogo da erro de memoria se tirar
table.insert(PrefabFiles, "tigersharkpool")
table.insert(PrefabFiles, "tigersharktorch")
table.insert(PrefabFiles, "hatty_piggy_tfc")
table.insert(PrefabFiles, "boarmound")
table.insert(PrefabFiles, "roc_nest")
table.insert(PrefabFiles, "glowfly")
table.insert(PrefabFiles, "rabid_beetle")
table.insert(PrefabFiles, "obsidianstaff")
table.insert(PrefabFiles, "mermhouse_fisher")
table.insert(PrefabFiles, "mermtrader")
table.insert(PrefabFiles, "pig_scepter")

table.insert(PrefabFiles, "quagmire_mushroomstump")
table.insert(PrefabFiles, "quagmire_mushrooms")
table.insert(PrefabFiles, "quagmire_fern")
table.insert(PrefabFiles, "quagmire_pebblecrab")
table.insert(PrefabFiles, "quagmire_safe")
table.insert(PrefabFiles, "wildbeaver")
table.insert(PrefabFiles, "wildbeaver_house")
table.insert(PrefabFiles, "beaverskin")
table.insert(PrefabFiles, "quagmire_park_gate")
table.insert(PrefabFiles, "quagmire_parkspike")
table.insert(PrefabFiles, "wildbeaverguard")
table.insert(PrefabFiles, "beaver_head")
table.insert(PrefabFiles, "beavertorch")
table.insert(PrefabFiles, "quagmire_key")
table.insert(PrefabFiles, "quagmire_goatkid")

if GetModConfigData("kindofworld") == 5 or GetModConfigData("enableallprefabs") == true then
    table.insert(PrefabFiles, "roc")
    table.insert(PrefabFiles, "roc_leg")
    table.insert(PrefabFiles, "roc_head")
    table.insert(PrefabFiles, "roc_tail")
end
table.insert(PrefabFiles, "roc_robin_egg")
table.insert(PrefabFiles, "ro_bin_gizzard_stone")
table.insert(PrefabFiles, "ro_bin")
table.insert(PrefabFiles, "gnatmound")
table.insert(PrefabFiles, "gnat")

---------------lillypad biome------------------------
if GetModConfigData("lilypad") ~= 0 or GetModConfigData("enableallprefabs") == true or GetModConfigData("kindofworld") ==
    5 or GetModConfigData("hamletcaves_shipwreckedworld") == 1 then
    table.insert(PrefabFiles, "hippo_antler")
    table.insert(PrefabFiles, "hippoherd")
    table.insert(PrefabFiles, "hippoptamoose")
    table.insert(PrefabFiles, "lillypad")
    table.insert(PrefabFiles, "lotus")
    table.insert(PrefabFiles, "lotus_flower")
    table.insert(PrefabFiles, "bill")
    table.insert(PrefabFiles, "bill_quill")
    table.insert(PrefabFiles, "reeds_water")
end
---------------lavaarena volcano---------------------

table.insert(PrefabFiles, "flame_elemental_tfc")
table.insert(PrefabFiles, "tfwp_elemental")
table.insert(PrefabFiles, "tfwp_hats")
table.insert(PrefabFiles, "tfwp_armor")
-- table.insert(PrefabFiles,"tfwp_control_book")
-- table.insert(PrefabFiles,"tfwp_summon_book")
table.insert(PrefabFiles, "tfwp_lava_hammer")
table.insert(PrefabFiles, "tfwp_spear_gung")
table.insert(PrefabFiles, "tfwp_spear_lance")
table.insert(PrefabFiles, "tfwp_healing_staff")
table.insert(PrefabFiles, "tfwp_infernal_staff")
table.insert(PrefabFiles, "tfwp_dragon_dart")
table.insert(PrefabFiles, "tfwp_lava_dart")
-- table.insert(PrefabFiles,"tfwp_freeze_emitter")
table.insert(PrefabFiles, "tfwp_fire_bomb")
table.insert(PrefabFiles, "tfwp_heavy_sword")

table.insert(PrefabFiles, "tfwp_riledlucy")
table.insert(PrefabFiles, "tfwp_forge_books")
table.insert(PrefabFiles, "tfwp_forge_fireball_projectile")
table.insert(PrefabFiles, "tfwp_infernalstaff_meteor")
table.insert(PrefabFiles, "tfwp_weaponsparks_fx")
table.insert(PrefabFiles, "tfwp_forgespear_fx")
table.insert(PrefabFiles, "tfwp_healingcircle")
table.insert(PrefabFiles, "tfwp_healingcircle_regenbuff")

if GetModConfigData("forge") == 1 then

    table.insert(PrefabFiles, "teleportato_sw_parts")
    table.insert(PrefabFiles, "teleportato_sw")
    table.insert(PrefabFiles, "lavaarena_bossboar")
    table.insert(PrefabFiles, "lavaarena_rhinodrill")
    table.insert(PrefabFiles, "lavaarena_beetletaur")
    table.insert(PrefabFiles, "lavaarena_boarlord")
    table.insert(PrefabFiles, "lavaarena_spectator")
    table.insert(PrefabFiles, "lavaarena_spawner2")
    table.insert(PrefabFiles, "lavaarena_center")
    table.insert(PrefabFiles, "lavaarena_floorgrate")
    table.insert(PrefabFiles, "lavarenaescada")
    table.insert(PrefabFiles, "strange_scorpion_tfc")
    table.insert(PrefabFiles, "lizardman_tfc")
    table.insert(PrefabFiles, "spiky_turtle_tfc")
    table.insert(PrefabFiles, "spiky_monkey_tfc")
    table.insert(PrefabFiles, "lavarenawaves")

end

table.insert(PrefabFiles, "quagmire_coins")

--------------------------------------------------------
table.insert(PrefabFiles, "obsidianbomb")
table.insert(PrefabFiles, "obsidianbombactive")
table.insert(PrefabFiles, "fabric")
table.insert(PrefabFiles, "armor_snakeskin")
if GetModConfigData("Shipwrecked") ~= 5 and GetModConfigData("kindofworld") ~= 5 or GetModConfigData("enableallprefabs") ==
    true or GetModConfigData("Shipwrecked_plus") == true or GetModConfigData("kindofworld") == 20 then
    table.insert(PrefabFiles, "crate")
    table.insert(PrefabFiles, "dragoon")
    table.insert(PrefabFiles, "dragoonfire")
    table.insert(PrefabFiles, "dragoonspit")
    table.insert(PrefabFiles, "dragoonden")
    table.insert(PrefabFiles, "dragoonheart")
    table.insert(PrefabFiles, "volcano_shrub")
    table.insert(PrefabFiles, "flamegeyser")
    table.insert(PrefabFiles, "rock_obsidian")
    table.insert(PrefabFiles, "magma_rocks")
    table.insert(PrefabFiles, "obsidian")
    table.insert(PrefabFiles, "obsidian_workbench")
    table.insert(PrefabFiles, "obsidianfirepit")
    table.insert(PrefabFiles, "obsidianfirefire")
    table.insert(PrefabFiles, "elephantcactus")
    table.insert(PrefabFiles, "lavapool")
    table.insert(PrefabFiles, "firerain")
    table.insert(PrefabFiles, "coffeebush")
    table.insert(PrefabFiles, "coffeebeans")
    table.insert(PrefabFiles, "coffee")
    table.insert(PrefabFiles, "lavaerupt")
    table.insert(PrefabFiles, "volcano")
    table.insert(PrefabFiles, "woodlegs_cage")
    table.insert(PrefabFiles, "woodlegs_key1")
    table.insert(PrefabFiles, "woodlegs_key2")
    table.insert(PrefabFiles, "woodlegs_key3")
    table.insert(PrefabFiles, "woodlegs1")
    table.insert(PrefabFiles, "woodlegsghost")
    table.insert(PrefabFiles, "woodlegs_unlock")
    table.insert(PrefabFiles, "vulcano")
    table.insert(PrefabFiles, "escadadovulcao")
    -- table.insert(PrefabFiles,"mermfisher")
    table.insert(PrefabFiles, "flup")
    table.insert(PrefabFiles, "flupegg")
    table.insert(PrefabFiles, "tidalpool")
    table.insert(PrefabFiles, "poisonhole")
    table.insert(PrefabFiles, "tigershark")
    table.insert(PrefabFiles, "tigersharkshadow")
    table.insert(PrefabFiles, "volcanofog")
    table.insert(PrefabFiles, "flupspawner")
    table.insert(PrefabFiles, "jungletrees")
    table.insert(PrefabFiles, "jungletreeseed")
    table.insert(PrefabFiles, "bambootree")
    table.insert(PrefabFiles, "bamboo")
    table.insert(PrefabFiles, "wildbore")
    table.insert(PrefabFiles, "wildborehouse")
    table.insert(PrefabFiles, "doydoy")
    table.insert(PrefabFiles, "doydoy_mating_fx")
    table.insert(PrefabFiles, "doydoyegg")
    table.insert(PrefabFiles, "doydoyfeather")
    table.insert(PrefabFiles, "doydoyherd")
    table.insert(PrefabFiles, "doydoynest")
    table.insert(PrefabFiles, "livingjungletree")
    table.insert(PrefabFiles, "doydoy_spawner")
    table.insert(PrefabFiles, "berrybush2_snake")
    table.insert(PrefabFiles, "lavapondbig")
    table.insert(PrefabFiles, "bigfoot")
    table.insert(PrefabFiles, "glommerbell")
    table.insert(PrefabFiles, "sweet_potato")
    table.insert(PrefabFiles, "doydoyfan")
    table.insert(PrefabFiles, "sand_castle")
    table.insert(PrefabFiles, "sandhill")
    table.insert(PrefabFiles, "sand")
    table.insert(PrefabFiles, "seashell")
    table.insert(PrefabFiles, "seashell_beached")
    table.insert(PrefabFiles, "rock_limpet")
    table.insert(PrefabFiles, "limpets")
    table.insert(PrefabFiles, "palmleaf")
    table.insert(PrefabFiles, "palmleafhut")
    table.insert(PrefabFiles, "palmtrees")
    table.insert(PrefabFiles, "coconut")
    table.insert(PrefabFiles, "crab")
    table.insert(PrefabFiles, "crabhole")
    table.insert(PrefabFiles, "treeguard")
    table.insert(PrefabFiles, "treeguard_coconut")
    table.insert(PrefabFiles, "warningshadow")
    table.insert(PrefabFiles, "slotmachine")
    table.insert(PrefabFiles, "sharkitten")
    table.insert(PrefabFiles, "sharkittenspawner")
    table.insert(PrefabFiles, "bush_vine")
    table.insert(PrefabFiles, "primeapebarrel")
    table.insert(PrefabFiles, "monkeyball")
    table.insert(PrefabFiles, "shark_gills")
    table.insert(PrefabFiles, "primeape")
    table.insert(PrefabFiles, "icemaker")
    table.insert(PrefabFiles, "tigereye")
    table.insert(PrefabFiles, "packim")
    table.insert(PrefabFiles, "packim_fishbone")
end

-------- pprefabs gorge -----------

table.insert(PrefabFiles, "q_swampig")
table.insert(PrefabFiles, "q_swampig_house")
table.insert(PrefabFiles, "q_pond")
table.insert(PrefabFiles, "q_beefalo")
table.insert(PrefabFiles, "q_sugarwoodtree")
table.insert(PrefabFiles, "q_sap")
table.insert(PrefabFiles, "q_sugarwoodtree_sapling")
table.insert(PrefabFiles, "quagmiregoat")
table.insert(PrefabFiles, "quagmiregoatherd")
table.insert(PrefabFiles, "q_sugarwoodtree_cone")
table.insert(PrefabFiles, "q_pigeon")
table.insert(PrefabFiles, "q_spiceshrub")
table.insert(PrefabFiles, "maxwellendgame")
table.insert(PrefabFiles, "maxwelllight")
table.insert(PrefabFiles, "maxwelllight_flame")
table.insert(PrefabFiles, "maxwellminions")
table.insert(PrefabFiles, "maxwellboss")
table.insert(PrefabFiles, "maxwelllock")
table.insert(PrefabFiles, "maxwellshadowmeteor")
table.insert(PrefabFiles, "maxwellphonograph")
table.insert(PrefabFiles, "maxwellestatua")
table.insert(PrefabFiles, "maxwellshadowheart")
table.insert(PrefabFiles, "tree_forest")
table.insert(PrefabFiles, "tree_forest_deep")
table.insert(PrefabFiles, "tree_forest_rot")
table.insert(PrefabFiles, "tree_forestseed")
table.insert(PrefabFiles, "spider_monkey_tree")
table.insert(PrefabFiles, "spider_monkey")
table.insert(PrefabFiles, "spider_monkey_herd")
table.insert(PrefabFiles, "spider_ape")
table.insert(PrefabFiles, "trapslug")
table.insert(PrefabFiles, "antman2")
table.insert(PrefabFiles, "fennel")
table.insert(PrefabFiles, "pig_palace2")
table.insert(PrefabFiles, "pig_palace2_interior")
table.insert(PrefabFiles, "peagawk_prism")
table.insert(PrefabFiles, "peagawkfeather_prism")
table.insert(PrefabFiles, "city_lamp2")
table.insert(PrefabFiles, "pig_guard_tower2")
table.insert(PrefabFiles, "wall_spawn_city")
-- table.insert(PrefabFiles,"spider_ape_tree")
table.insert(PrefabFiles, "slipstor")
table.insert(PrefabFiles, "slip")
table.insert(PrefabFiles, "slipstor_spawner")

if GetModConfigData("Shipwrecked_plus") == true or GetModConfigData("enableallprefabs") == true or
    GetModConfigData("Shipwreckedworld_plus") == true then
    table.insert(PrefabFiles, "goldbishop")
    table.insert(PrefabFiles, "goldentomb")
    table.insert(PrefabFiles, "goldmonkey")
    table.insert(PrefabFiles, "goldbishop")
    table.insert(PrefabFiles, "goldobi")

    table.insert(PrefabFiles, "tikihead")
    table.insert(PrefabFiles, "teepee")
    table.insert(PrefabFiles, "tikimask")
    table.insert(PrefabFiles, "tikifire")
    table.insert(PrefabFiles, "wanawanatiki")
    table.insert(PrefabFiles, "tikistick")

    table.insert(PrefabFiles, "summerwalrus")
    table.insert(PrefabFiles, "summerigloo")

    table.insert(PrefabFiles, "octoatt")
    table.insert(PrefabFiles, "octopus")
    table.insert(PrefabFiles, "octohouse")
end

----- prefabs marinhos---------------
table.insert(PrefabFiles, "coralreef")
table.insert(PrefabFiles, "coral")
table.insert(PrefabFiles, "seaweed_planted")
table.insert(PrefabFiles, "seaweed")
table.insert(PrefabFiles, "mangrovetrees")
table.insert(PrefabFiles, "mangrovetreesbee")
table.insert(PrefabFiles, "spidercoralhole")
table.insert(PrefabFiles, "tentacleunderwater")
table.insert(PrefabFiles, "grass_water")
table.insert(PrefabFiles, "rocksunderwater")
table.insert(PrefabFiles, "wreck")

table.insert(PrefabFiles, "fishinhole")
table.insert(PrefabFiles, "octopusking")
table.insert(PrefabFiles, "kraken_tentacle")
table.insert(PrefabFiles, "kraken_projectile")
table.insert(PrefabFiles, "kraken")
table.insert(PrefabFiles, "kraken_jellyfish")
table.insert(PrefabFiles, "kraken_spawner")
table.insert(PrefabFiles, "solofish")
table.insert(PrefabFiles, "swordfish")

table.insert(PrefabFiles, "sharx")
table.insert(PrefabFiles, "stungray")
table.insert(PrefabFiles, "pirateghost")
table.insert(PrefabFiles, "redbarrel")
table.insert(PrefabFiles, "lobsterhole")
table.insert(PrefabFiles, "mussel")
table.insert(PrefabFiles, "waterygrave")
table.insert(PrefabFiles, "bioluminescence")
table.insert(PrefabFiles, "boatrowarmored")
table.insert(PrefabFiles, "boatrowcargo")
table.insert(PrefabFiles, "rawling")
table.insert(PrefabFiles, "coral_brain_rock")
table.insert(PrefabFiles, "coral_brain")
table.insert(PrefabFiles, "limestone")
table.insert(PrefabFiles, "shark_fin")

table.insert(PrefabFiles, "rainbowjellyfish")
table.insert(PrefabFiles, "rainbowjellyfish_planted")
table.insert(PrefabFiles, "sea_yard")
table.insert(PrefabFiles, "sea_yard_arms_fx")
table.insert(PrefabFiles, "tar")
table.insert(PrefabFiles, "tar_pool")
table.insert(PrefabFiles, "bioluminescence_spawner")
table.insert(PrefabFiles, "boatrow")
table.insert(PrefabFiles, "flotsam_debris_sw")
table.insert(PrefabFiles, "boatrowencrusted")
table.insert(PrefabFiles, "ballphin")
table.insert(PrefabFiles, "ballphinhouse")

table.insert(PrefabFiles, "dorsalfin")
table.insert(PrefabFiles, "ballphinpod")
table.insert(PrefabFiles, "jellyfish")
table.insert(PrefabFiles, "jellyfish_planted")
table.insert(PrefabFiles, "crocodog_spawner")
table.insert(PrefabFiles, "crocodog")
table.insert(PrefabFiles, "whale")
table.insert(PrefabFiles, "whale_carcass")
table.insert(PrefabFiles, "knightboat")
table.insert(PrefabFiles, "poisonmistparticle")

GLOBAL.TUNING.tropical = {
    wind = GetModConfigData("wind"),
    hail = GetModConfigData("hail"),
    hamworld = GetModConfigData("kindofworld"),
    bramble = GetModConfigData("bramble"),
    roc = GetModConfigData("roc"),
    megarandomCompatibilityWater = GetModConfigData("megarandomCompatibilityWater"),
    disableWater = GetModConfigData("Disable_Water"),
    springflood = GetModConfigData("flood"),
    sealnado = GetModConfigData("sealnado"),
    waves = GetModConfigData("Waves"),
    hamlet = GetModConfigData("Hamlet"),
    shipwrecked = GetModConfigData("Shipwrecked"),
    tropicalshards = GetModConfigData("tropicalshards"),
    removedark = GetModConfigData("removedark"),
    aporkalypse = GetModConfigData("aporkalypse"),
    multiplayerportal = GetModConfigData("startlocation"),
    greenmod = GLOBAL.KnownModIndex:IsModEnabled("workshop-1418878027"),
    kindofworld = GetModConfigData("kindofworld"),
    volcaniceruption = GetModConfigData("volcaniceruption"),
    hamletclouds = GetModConfigData("hamletclouds"),
    forge = GetModConfigData("forge"),
    fog = GetModConfigData("fog"),
    hayfever = GetModConfigData("hayfever")
}

table.insert(PrefabFiles, "deco_util")
table.insert(PrefabFiles, "deco_util2")
table.insert(PrefabFiles, "deco_swinging_light")
table.insert(PrefabFiles, "deco_lightglow")
table.insert(PrefabFiles, "pig_shop_spears")

if GetModConfigData("pigcity1") ~= 5 or GetModConfigData("pigcity2") ~= 5 or GetModConfigData("kindofworld") == 5 or
    GetModConfigData("frost_island") ~= 5 or GetModConfigData("enableallprefabs") == true or
    GetModConfigData("hamletcaves_shipwreckedworld") == 1 then
    table.insert(PrefabFiles, "topiary")
    table.insert(PrefabFiles, "lawnornaments")
    table.insert(PrefabFiles, "hedge")
    table.insert(PrefabFiles, "clippings")
    table.insert(PrefabFiles, "city_lamp")
    table.insert(PrefabFiles, "hamlet_cones")
    table.insert(PrefabFiles, "securitycontract")
    table.insert(PrefabFiles, "city_hammer")
    table.insert(PrefabFiles, "magnifying_glass")
    table.insert(PrefabFiles, "pigbandit")
    table.insert(PrefabFiles, "banditmap")
    table.insert(PrefabFiles, "pig_shop")
    table.insert(PrefabFiles, "pig_shop_produce_interior")
    table.insert(PrefabFiles, "pig_shop_hoofspa_interior")
    table.insert(PrefabFiles, "pig_shop_general_interior")
    table.insert(PrefabFiles, "pig_shop_florist_interior")
    table.insert(PrefabFiles, "pig_shop_deli_interior")
    table.insert(PrefabFiles, "pig_shop_academy_interior")

    table.insert(PrefabFiles, "pig_shop_cityhall_interior")
    table.insert(PrefabFiles, "pig_shop_cityhall_player_interior")

    table.insert(PrefabFiles, "pig_shop_hatshop_interior")
    table.insert(PrefabFiles, "pig_shop_weapons_interior")
    table.insert(PrefabFiles, "pig_shop_bank_interior")
    table.insert(PrefabFiles, "pig_shop_arcane_interior")
    table.insert(PrefabFiles, "pig_shop_antiquities_interior")
    table.insert(PrefabFiles, "pig_shop_tinker_interior")
    table.insert(PrefabFiles, "pig_palace_interior")
    table.insert(PrefabFiles, "pig_palace")

    table.insert(PrefabFiles, "pigman_shopkeeper_desk")
    table.insert(PrefabFiles, "shop_pedestals")
    table.insert(PrefabFiles, "deed")
    table.insert(PrefabFiles, "playerhouse_city_interior")
    table.insert(PrefabFiles, "playerhouse_city_interior2")
    table.insert(PrefabFiles, "shelf")
    table.insert(PrefabFiles, "shelf_slot")
    table.insert(PrefabFiles, "trinkets_giftshop")
    table.insert(PrefabFiles, "key_to_city")
    table.insert(PrefabFiles, "wallpaper")
    table.insert(PrefabFiles, "player_house_kits")
    table.insert(PrefabFiles, "player_house")

    table.insert(PrefabFiles, "pigman_city")
    table.insert(PrefabFiles, "pighouse_city")
    table.insert(PrefabFiles, "pig_guard_tower")
    table.insert(PrefabFiles, "armor_metal")
    table.insert(PrefabFiles, "reconstruction_project")
    table.insert(PrefabFiles, "water_spray")
    table.insert(PrefabFiles, "water_pipe")
    table.insert(PrefabFiles, "sprinkler1")
    table.insert(PrefabFiles, "alloy")
    table.insert(PrefabFiles, "smelter")
    table.insert(PrefabFiles, "halberd")
    table.insert(PrefabFiles, "oinc")
    table.insert(PrefabFiles, "oinc10")
    table.insert(PrefabFiles, "oinc100")
end

if GetModConfigData("startlocation") == 15 or GetModConfigData("kindofworld") == 5 or
    GetModConfigData("enableallprefabs") == true then
    table.insert(PrefabFiles, "porklandintro")
end

if TUNING.tropical.sealnado or GetModConfigData("enableallprefabs") == true then
    table.insert(PrefabFiles, "twister")
    table.insert(PrefabFiles, "twister_spawner")
    table.insert(PrefabFiles, "twister_seal")
    table.insert(PrefabFiles, "twister_tornado")
end

if GetModConfigData("frost_island") ~= 5 and GetModConfigData("kindofworld") ~= 5 or
    GetModConfigData("enableallprefabs") == true then
    table.insert(PrefabFiles, "billsnow")
    table.insert(PrefabFiles, "giantsnow")
    table.insert(PrefabFiles, "snowman")
    table.insert(PrefabFiles, "bear")
    table.insert(PrefabFiles, "ice_deer")
    table.insert(PrefabFiles, "mammoth")
    table.insert(PrefabFiles, "bearden")
    table.insert(PrefabFiles, "snowitem")
    table.insert(PrefabFiles, "snow_dune")
    table.insert(PrefabFiles, "snow_castle")
    table.insert(PrefabFiles, "cratesnow")
    table.insert(PrefabFiles, "snowpile1")
    table.insert(PrefabFiles, "snowbigball")
    table.insert(PrefabFiles, "snowbeetle")
    table.insert(PrefabFiles, "snowspider_spike")
    table.insert(PrefabFiles, "snowspiderden")
    table.insert(PrefabFiles, "snowberrybush")
    table.insert(PrefabFiles, "snowspider")
    table.insert(PrefabFiles, "snowspider2")
    table.insert(PrefabFiles, "snowspider_spike2")
    table.insert(PrefabFiles, "snowspiderden2")
    table.insert(PrefabFiles, "rock_ice_frost")
    table.insert(PrefabFiles, "icepillar")
    table.insert(PrefabFiles, "snowgoat")
    table.insert(PrefabFiles, "snowgoatherd")
    table.insert(PrefabFiles, "snowwarg")
    table.insert(PrefabFiles, "snowperd")
    table.insert(PrefabFiles, "snowdeciduoustrees")
    table.insert(PrefabFiles, "rock_ice_frost_spawner")
    table.insert(PrefabFiles, "snowwarg_spawner")
end
--[[
if (GetModConfigData("frost_island") == 15 or GetModConfigData("frost_island") == 25) and GetModConfigData("kindofworld") ~= 5 then
table.insert(PrefabFiles,"lavarenainside")
table.insert(PrefabFiles,"teleportato2")
table.insert(PrefabFiles,"telebase")


table.insert(PrefabFiles,"quest")
table.insert(PrefabFiles,"maxwellinside")	
table.insert(PrefabFiles,"maxwellportal")
table.insert(PrefabFiles,"maxwellthrone")

end
]]

table.insert(PrefabFiles, "chicken")
table.insert(PrefabFiles, "peekhen")
table.insert(PrefabFiles, "peekhenspawner")
table.insert(PrefabFiles, "snapdragon")
table.insert(PrefabFiles, "snapdragonherd")
table.insert(PrefabFiles, "crabapple_tree")
table.insert(PrefabFiles, "zeb")
table.insert(PrefabFiles, "wildboreking")
table.insert(PrefabFiles, "wildbore_minion")
table.insert(PrefabFiles, "wildborekingstaff")
table.insert(PrefabFiles, "wildboreking_spawner")

if GetModConfigData("Hamlet") ~= 5 or GetModConfigData("startlocation") == 15 or GetModConfigData("kindofworld") == 5 or
    GetModConfigData("enableallprefabs") == true or GetModConfigData("hamletcaves_shipwreckedworld") == 1 then -- GetModConfigData("Plains_Hamlet")

    table.insert(PrefabFiles, "rainforesttrees")
    table.insert(PrefabFiles, "rainforesttree_sapling")
    table.insert(PrefabFiles, "meteor_impact")
    table.insert(PrefabFiles, "tuber")
    table.insert(PrefabFiles, "tubertrees")
    table.insert(PrefabFiles, "pangolden")
    table.insert(PrefabFiles, "thunderbird")
    table.insert(PrefabFiles, "thunderbirdnest")
    table.insert(PrefabFiles, "ancient_robots")
    table.insert(PrefabFiles, "ancient_hulk")
    table.insert(PrefabFiles, "ancient_herald")
    table.insert(PrefabFiles, "armor_vortex_cloak")
    table.insert(PrefabFiles, "living_artifact")
    table.insert(PrefabFiles, "rock_basalt")
    table.insert(PrefabFiles, "ancient_robots_assembly")
    table.insert(PrefabFiles, "laser_ring")
    table.insert(PrefabFiles, "laser")
    table.insert(PrefabFiles, "iron")

    table.insert(PrefabFiles, "pheromonestone")

    if GetModConfigData("luajit") then
        table.insert(PrefabFiles, "pig_ruins_maze_old")
    else
        if GetModConfigData("compactruins") then
            table.insert(PrefabFiles, "pig_ruins_mazecompact")
        else
            table.insert(PrefabFiles, "pig_ruins_maze")
        end
    end

    table.insert(PrefabFiles, "anthill_interior")
    table.insert(PrefabFiles, "anthill_lamp")
    table.insert(PrefabFiles, "anthill_stalactite")
    table.insert(PrefabFiles, "antchest")
    table.insert(PrefabFiles, "antcombhome")
    table.insert(PrefabFiles, "antcombhomecave")
    table.insert(PrefabFiles, "giantgrub")
    table.insert(PrefabFiles, "antqueen")
    table.insert(PrefabFiles, "rocksham")
    table.insert(PrefabFiles, "deco_ruins_fountain")

    table.insert(PrefabFiles, "pig_ruins_entrance_interior")
    table.insert(PrefabFiles, "pig_ruins_entrance")
    table.insert(PrefabFiles, "pig_ruins_dart_statue")
    table.insert(PrefabFiles, "pig_ruins_dart")
    table.insert(PrefabFiles, "pig_ruins_creeping_vines")
    table.insert(PrefabFiles, "pig_ruins_pressure_plate")
    table.insert(PrefabFiles, "pig_ruins_spear_trap")
    table.insert(PrefabFiles, "smashingpot")
    table.insert(PrefabFiles, "pig_ruins_light_beam")
    table.insert(PrefabFiles, "littlehammer")
    table.insert(PrefabFiles, "relics")
    table.insert(PrefabFiles, "gascloud")
    table.insert(PrefabFiles, "bugrepellent")

    table.insert(PrefabFiles, "teatree_nut")
    table.insert(PrefabFiles, "teatrees")
    table.insert(PrefabFiles, "piko")
    table.insert(PrefabFiles, "clawpalmtrees")
    table.insert(PrefabFiles, "clawpalmtree_sapling")
    table.insert(PrefabFiles, "bugfood")
    table.insert(PrefabFiles, "rock_flippable")
    table.insert(PrefabFiles, "peagawkfeather")
    table.insert(PrefabFiles, "peagawk")
    table.insert(PrefabFiles, "aloe")
    table.insert(PrefabFiles, "pog")
    table.insert(PrefabFiles, "weevole")
    table.insert(PrefabFiles, "weevole_carapace")
    table.insert(PrefabFiles, "armor_weevole")
    table.insert(PrefabFiles, "pugalisk")
    table.insert(PrefabFiles, "pugalisk_trap_door")
    table.insert(PrefabFiles, "pugalisk_ruins_pillar")
    table.insert(PrefabFiles, "pugalisk_fountain")
    table.insert(PrefabFiles, "waterdrop")
    table.insert(PrefabFiles, "floweroflife")
    table.insert(PrefabFiles, "gaze_beam")
    table.insert(PrefabFiles, "snake_bone")
    table.insert(PrefabFiles, "mandrakehouse")
    table.insert(PrefabFiles, "mandrakeman")

    table.insert(PrefabFiles, "jungle_border_vine")
    table.insert(PrefabFiles, "light_rays_ham")
    table.insert(PrefabFiles, "nettle")
    table.insert(PrefabFiles, "nettle_plant")
    table.insert(PrefabFiles, "rainforesttrees")
    table.insert(PrefabFiles, "rainforesttree_sapling")
    table.insert(PrefabFiles, "tree_pillar")
    table.insert(PrefabFiles, "flower_rainforest")
    table.insert(PrefabFiles, "pig_ruins_torch")
    table.insert(PrefabFiles, "mean_flytrap")
    table.insert(PrefabFiles, "radish")
    table.insert(PrefabFiles, "adult_flytrap")
    table.insert(PrefabFiles, "antman_warrior_egg")
    table.insert(PrefabFiles, "antman_warrior")
    table.insert(PrefabFiles, "antman")
    table.insert(PrefabFiles, "antlarva")
    table.insert(PrefabFiles, "anthill")
    table.insert(PrefabFiles, "antsuit")
    table.insert(PrefabFiles, "venus_stalk")
    table.insert(PrefabFiles, "walkingstick")
    table.insert(PrefabFiles, "cloudpuff")
end

Assets = { -- Asset("SOUNDPACKAGE", "sound/volcano.fev"),
-- Asset("SOUND", "sound/volcano.fsb"),
-- Asset("SOUND", "sound/boats.fsb"),
-- Asset("SOUND", "sound/creatures.fsb"),
-- Asset("SOUND", "sound/slot_machine.fsb"),
-- Asset("SOUND", "sound/waves.fsb"),
-- LOD SOUND FILE
Asset("SOUNDPACKAGE", "sound/dontstarve_DLC002.fev"), 
Asset("SOUNDPACKAGE", "sound/sw_character.fev"),
Asset("SOUND", "sound/dontstarve_shipwreckedSFX.fsb"), 
Asset("SOUND", "sound/sw_character.fsb"),
Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"), 
Asset("SOUND", "sound/DLC003_sfx.fsb"),
-- Asset("SOUND", "sound/amb_stream_SW.fsb"),
-- NEW SOUND FILE
-- Asset("SOUNDPACKAGE", "sound/volcano_new.fev"),
-- Asset("SOUND", "sound/volcano_new.fsb"),
-- Asset("SOUNDPACKAGE", "sound/tropical.fev"),
-- Asset("SOUND", "sound/tropical.fsb"),

Asset("IMAGE", "images/barco.tex"), Asset("ATLAS", "images/barco.xml"),

Asset("ATLAS", "images/inventoryimages/volcanoinventory.xml"),
Asset("IMAGE", "images/inventoryimages/volcanoinventory.tex"), 
Asset("ATLAS", "images/inventoryimages/novositens.xml"),
Asset("IMAGE", "images/inventoryimages/novositens.tex"), 
Asset("ANIM", "anim/player_actions_paddle.zip"),
Asset("ANIM", "anim/player_actions_speargun.zip"), 
Asset("ANIM", "anim/player_actions_tap.zip"),
Asset("ANIM", "anim/player_actions_panning.zip"), 
Asset("ANIM", "anim/player_actions_hand_lens.zip"),
Asset("ANIM", "anim/walani_paddle.zip"), 
Asset("ANIM", "anim/player_boat_death.zip"),
Asset("ANIM", "anim/player_sneeze.zip"), 
Asset("ANIM", "anim/des_sail.zip"),
Asset("ANIM", "anim/player_actions_trawl.zip"), 
Asset("ANIM", "anim/player_actions_machete.zip"),
Asset("ANIM", "anim/player_actions_shear.zip"), 
Asset("ANIM", "anim/player_actions_cropdust.zip"),
Asset("ANIM", "anim/ripple_build.zip"), 
Asset("ATLAS", "images/fx4te.xml"), 
Asset("IMAGE", "images/fx4te.tex"),
Asset("ANIM", "anim/boat_health.zip"), 
Asset("ANIM", "anim/player_actions_telescope.zip"),
Asset("ANIM", "anim/pig_house_old.zip"), 
Asset("ANIM", "anim/parrot_pirate_intro.zip"),
Asset("ANIM", "anim/parrot_pirate.zip"), 
Asset("ANIM", "anim/pig_house_sale.zip"), Asset("ANIM", "anim/fish2.zip"),
Asset("ANIM", "anim/fish3.zip"), Asset("ANIM", "anim/fish4.zip"), Asset("ANIM", "anim/fish5.zip"),
Asset("ANIM", "anim/fish6.zip"), Asset("ANIM", "anim/fish7.zip"), Asset("ANIM", "anim/coi.zip"),
Asset("ANIM", "anim/ballphinocean.zip"), Asset("ANIM", "anim/dogfishocean.zip"), Asset("ANIM", "anim/goldfish.zip"),
Asset("ANIM", "anim/salmon.zip"), Asset("ANIM", "anim/sharxocean.zip"), Asset("ANIM", "anim/swordfishjocean.zip"),
Asset("ANIM", "anim/swordfishjocean2.zip"), Asset("ANIM", "anim/mecfish.zip"), Asset("ANIM", "anim/whaleblueocean.zip"),
Asset("ANIM", "anim/kingfisher_build.zip"), Asset("ANIM", "anim/parrot_blue_build.zip"),
Asset("ANIM", "anim/toucan_hamlet_build.zip"), Asset("ANIM", "anim/toucan_build.zip"),
Asset("ANIM", "anim/parrot_build.zip"), Asset("ANIM", "anim/parrot_pirate_build.zip"),
Asset("ANIM", "anim/cormorant_build.zip"), Asset("ANIM", "anim/seagull_build.zip"),
Asset("ANIM", "anim/quagmire_pigeon_build.zip"), Asset("ANIM", "anim/skeletons.zip"), Asset("ANIM", "anim/fish2.zip"),
Asset("ANIM", "anim/oceanfish_small.zip"), Asset("ANIM", "anim/oceanfish_small_1.zip"),
Asset("ANIM", "anim/oceanfish_small_2.zip"), Asset("ANIM", "anim/oceanfish_small_3.zip"),
Asset("ANIM", "anim/oceanfish_small_4.zip"), Asset("ANIM", "anim/oceanfish_small_5.zip"),
Asset("ANIM", "anim/oceanfish_small_6.zip"), Asset("ANIM", "anim/oceanfish_small_7.zip"),
Asset("ANIM", "anim/oceanfish_small_8.zip"), Asset("ANIM", "anim/oceanfish_medium.zip"),
Asset("ANIM", "anim/oceanfish_medium_1.zip"), Asset("ANIM", "anim/oceanfish_medium_2.zip"),
Asset("ANIM", "anim/oceanfish_medium_3.zip"), Asset("ANIM", "anim/oceanfish_medium_4.zip"),
Asset("ANIM", "anim/oceanfish_medium_5.zip"), Asset("ANIM", "anim/oceanfish_medium_6.zip"),
Asset("ANIM", "anim/oceanfish_medium_7.zip"), Asset("ANIM", "anim/oceanfish_medium_8.zip"),
Asset("IMAGE", "levels/textures/outro.tex"), Asset("IMAGE", "images/inventoryimages/hamletinventory.tex"),
Asset("ATLAS", "images/inventoryimages/hamletinventory.xml"), Asset("ATLAS", "map_icons/hamleticon.xml"),
Asset("IMAGE", "map_icons/hamleticon.tex"), Asset("ATLAS", "map_icons/creepindedeepicon.xml"),
Asset("IMAGE", "map_icons/creepindedeepicon.tex"), Asset("ANIM", "anim/butterflymuffin.zip"),
Asset("IMAGE", "images/tfwp_inventoryimgs.tex"), Asset("ATLAS", "images/tfwp_inventoryimgs.xml"),
-- Asset("SOUNDPACKAGE", "sound/Hamlet.fev"),
-- Asset("SOUND", "sound/Hamlet.fsb"),

Asset("IMAGE", "images/names_wilbur.tex"), Asset("ATLAS", "images/names_wilbur.xml"),
Asset("IMAGE", "images/names_woodlegs.tex"), Asset("ATLAS", "images/names_woodlegs.xml"),
Asset("IMAGE", "images/names_walani.tex"), Asset("ATLAS", "images/names_walani.xml"), Asset("ATLAS", "images/tabs.xml"),
Asset("IMAGE", "images/tabs.tex"), Asset("IMAGE", "images/turfs/turf01-9.tex"),
Asset("ATLAS", "images/turfs/turf01-9.xml"), Asset("IMAGE", "images/turfs/turf01-10.tex"),
Asset("ATLAS", "images/turfs/turf01-10.xml"), Asset("IMAGE", "images/turfs/turf01-11.tex"),
Asset("ATLAS", "images/turfs/turf01-11.xml"), Asset("IMAGE", "images/turfs/turf01-12.tex"),
Asset("ATLAS", "images/turfs/turf01-12.xml"), Asset("IMAGE", "images/turfs/turf01-13.tex"),
Asset("ATLAS", "images/turfs/turf01-13.xml"), Asset("IMAGE", "images/turfs/turf01-14.tex"),
Asset("ATLAS", "images/turfs/turf01-14.xml"), Asset("ANIM", "anim/vagner_over.zip"),
Asset("ANIM", "anim/leaves_canopy2.zip"), Asset("ANIM", "anim/mushroom_tree_yelow.zip")}

AddMinimapAtlas("map_icons/creepindedeepicon.xml")

if GetModConfigData("gorgecity") and GetModConfigData("kindofworld") == 15 or GetModConfigData("enableallprefabs") ==
    true then
    table.insert(PrefabFiles, "quagmire_mealingstone")
    table.insert(PrefabFiles, "quagmire_flour")
    table.insert(PrefabFiles, "quagmire_foods")
    table.insert(PrefabFiles, "quagmire_goatmilk")
    table.insert(PrefabFiles, "quagmire_sap")
    table.insert(PrefabFiles, "quagmire_syrup")

    table.insert(PrefabFiles, "quagmire_casseroledish")
    table.insert(PrefabFiles, "quagmire_crates")
    table.insert(PrefabFiles, "quagmire_grill")
    table.insert(PrefabFiles, "quagmire_oven")
    table.insert(PrefabFiles, "quagmire_plates")
    table.insert(PrefabFiles, "quagmire_pot")
    table.insert(PrefabFiles, "quagmire_pot_hanger")
    table.insert(PrefabFiles, "quagmire_salt_rack")
    table.insert(PrefabFiles, "quagmire_sapbucket")
    table.insert(PrefabFiles, "quagmire_slaughtertool")
    table.insert(PrefabFiles, "quagmire_altar")
    table.insert(PrefabFiles, "quagmire_seedpackets")

    table.insert(PrefabFiles, "quagmire_sugarwoodtree")
    table.insert(PrefabFiles, "quagmire_sugarwood_sapling")

    table.insert(PrefabFiles, "quagmire_goatmum")
    table.insert(PrefabFiles, "quagmire_swampigelder")

    table.insert(PrefabFiles, "quagmire_oldstructures")
    table.insert(PrefabFiles, "quagmire_lamp_post")
    table.insert(PrefabFiles, "quagmire_altar_statue")
    table.insert(PrefabFiles, "quagmire_portal")

    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/quagmirefoods.xml"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/quagmirefoods.tex"))
end

if GetModConfigData("underwater") then
    -- creeps
    table.insert(Assets, Asset("ANIM", "anim/oxygen_meter_player.zip"))
    table.insert(Assets, Asset("ANIM", "anim/hunger_ghost.zip"))
    table.insert(Assets, Asset("ANIM", "anim/squidunderwater.zip"))
    table.insert(Assets, Asset("ANIM", "anim/jellyfish.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sandstone_boulder.zip"))
    table.insert(Assets, Asset("ANIM", "anim/vent.zip"))
    table.insert(Assets, Asset("ANIM", "anim/fish_fillet.zip"))
    table.insert(Assets, Asset("ANIM", "anim/commonfish.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sand.zip"))
    table.insert(Assets, Asset("ANIM", "anim/pearl.zip"))
    table.insert(Assets, Asset("ANIM", "anim/iron_ore.zip"))
    table.insert(Assets, Asset("ANIM", "anim/lavastone.zip"))
    table.insert(Assets, Asset("ANIM", "anim/clam.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sea_eel.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sunken_chest.zip"))
    table.insert(Assets, Asset("ANIM", "anim/kelp.zip"))
    table.insert(Assets, Asset("ANIM", "anim/wormplant.zip"))
    table.insert(Assets, Asset("ANIM", "anim/decorative_shell.zip"))
    table.insert(Assets, Asset("ANIM", "anim/coral_orange.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sponge.zip"))
    table.insert(Assets, Asset("ANIM", "anim/fish_n_chips.zip"))
    table.insert(Assets, Asset("ANIM", "anim/fish_gazpacho.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sponge_cake.zip"))
    table.insert(Assets, Asset("ANIM", "anim/tuna_muffin.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sea_cucumber.zip"))
    table.insert(Assets, Asset("ANIM", "anim/jelly_cap.zip"))
    table.insert(Assets, Asset("ANIM", "anim/shrimp.zip"))
    table.insert(Assets, Asset("ANIM", "anim/diving_suit_summer.zip"))
    table.insert(Assets, Asset("ANIM", "anim/diving_suit_winter.zip"))
    table.insert(Assets, Asset("ANIM", "anim/tentacle_sushi.zip"))
    table.insert(Assets, Asset("ANIM", "anim/flower_sushi.zip"))
    table.insert(Assets, Asset("ANIM", "anim/fish_sushi.zip"))
    table.insert(Assets, Asset("ANIM", "anim/shrimp_tail.zip"))
    table.insert(Assets, Asset("ANIM", "anim/jelly_lantern.zip"))
    table.insert(Assets, Asset("ANIM", "anim/seagrass_chunk.zip"))
    table.insert(Assets, Asset("ANIM", "anim/underwater_entrance.zip"))
    table.insert(Assets, Asset("ANIM", "anim/underwater_exit.zip"))
    table.insert(Assets, Asset("ANIM", "anim/coral_orange_ground.zip"))
    table.insert(Assets, Asset("ANIM", "anim/coral_blue_ground.zip"))
    table.insert(Assets, Asset("ANIM", "anim/coral_green_ground.zip"))
    table.insert(Assets, Asset("ANIM", "anim/snorkel.zip"))
    table.insert(Assets, Asset("ANIM", "anim/seajelly.zip"))
    table.insert(Assets, Asset("ANIM", "anim/coral_cluster.zip"))
    table.insert(Assets, Asset("ANIM", "anim/uw_flowers.zip"))
    table.insert(Assets, Asset("ANIM", "anim/sea_petals.zip"))
    ---

    -- Inventory images

    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/creepindedeepinventory.xml"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/creepindedeepinventory.tex"))

    -- Minimap Icons
    table.insert(Assets, Asset("IMAGE", "images/minimap/iron_boulder.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/iron_boulder.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/seagrass.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/seagrass.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/kelp.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/kelp.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/vent.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/vent.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/entrance_open.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/entrance_open.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/entrance_closed.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/entrance_closed.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/orange_coral.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/orange_coral.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/clam.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/clam.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/sponge.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/sponge.xml"))
    table.insert(Assets, Asset("IMAGE", "images/minimap/wormplant.tex"))
    table.insert(Assets, Asset("ATLAS", "images/minimap/wormplant.xml"))

    -- Sounds
    table.insert(Assets, Asset("SOUNDPACKAGE", "sound/citd.fev"))
    table.insert(Assets, Asset("SOUND", "sound/citd.fsb"))

    -- Inventory image assets
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/placeholder.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/diving_suit_summer.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/diving_suit_winter.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/snorkel.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/sponge_piece.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/fish_fillet.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/fish_fillet_cooked.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/bubble_item.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/sand.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/pearl.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/iron_ore.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/lavastone.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/fish_n_chips.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/sponge_cake.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/fish_gazpacho.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/tuna_muffin.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/sea_cucumber.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/jelly_cap.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/tentacle_sushi.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/fish_sushi.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/flower_sushi.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/shrimp_tail.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/jelly_lantern.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/seagrass_chunk.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/cut_orange_coral.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/cut_blue_coral.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/cut_green_coral.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/food/seajelly.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/coral_cluster.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/pearl_amulet.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/flare.xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/sea_petals.xml"))

    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/placeholder.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/diving_suit_summer.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/diving_suit_winter.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/snorkel.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/sponge_piece.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/fish_fillet.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/fish_fillet_cooked.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/bubble_item.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/sand.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/pearl.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/iron_ore.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/lavastone.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/fish_n_chips.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/sponge_cake.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/fish_gazpacho.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/tuna_muffin.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/sea_cucumber.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/jelly_cap.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/tentacle_sushi.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/fish_sushi.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/flower_sushi.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/shrimp_tail.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/jelly_lantern.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/seagrass_chunk.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/cut_orange_coral.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/cut_blue_coral.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/cut_green_coral.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/food/seajelly.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/coral_cluster.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/pearl_amulet.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/flare.tex"))
    table.insert(Assets, Asset("IMAGE", "images/inventoryimages/sea_petals.tex"))
end

RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "limpets_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "limpets.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "coconut_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "coconut_halved.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "coffeebeans.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "coffeebeans_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "sweet_potato.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "sweet_potatos_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish_med.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "dead_swordfish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish_raw.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish_med_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "quagmire_crabmeat.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "quagmire_crabmeat_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "lobster_land.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "lobster_dead.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "lobster_dead_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish_dogfish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "mussel_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "mussel.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "shark_fin.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "crab.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed_dried.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "doydoyegg.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "dorsalfin.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "jellyfish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "jellyfish_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "jellyfish_dead.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "jellyjerky.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish2.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish2_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish3.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish3_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish4.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish4_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish5.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish5_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish6.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish6_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish7.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "fish7_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "salmon.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "salmon_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "coi.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "coi_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "snowitem.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "roe.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "roe_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seataro.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seataro_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "blueberries.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "blueberries_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seacucumber.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seacucumber_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "gooseberry.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "gooseberry_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "quagmire_mushrooms.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "quagmire_mushrooms_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "oceanfish_small_61_inv.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "oceanfish_small_61_inv_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "oceanfish_small_71_inv.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "oceanfish_small_71_inv_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "oceanfish_small_81_inv.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "oceanfish_small_81_inv_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "butterfly_tropical_wings.tex")

RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "jellybug.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "jellybug_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "slugbug.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "slugbug_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "cutnettle.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "radish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "radish_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "asparagus.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "asparagus_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "aloe.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "aloe_cooked.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "weevole_carapace.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "piko_orange.tex")
RegisterInventoryItemAtlas("images/inventoryimages/hamletinventory.xml", "snake_bone.tex")

modimport("scripts/stringscomplement.lua")
modimport("scripts/stringscreeps.lua")
modimport("scripts/wurt_quotes.lua")
-- configurar idioma
if GetModConfigData("set_idioma") ~= nil then
    if GetModConfigData("set_idioma") == "strings" then
        modimport("scripts/stringsEU.lua")
    else
        modimport("scripts/" .. GetModConfigData("set_idioma") .. ".lua")
    end
end

modimport("scripts/actions.lua")
modimport "tileadder.lua"
modimport("scripts/ham_fx.lua")

------------------------------------------------
-- Start of Tile Adder. Copy this code to your modworldgenmain.lua for use.
-- See tiledescription.lua and tileadder.lua for more details.
AddMinimap()
-- End if Tile Adder.
------------------volcano-------------------
modimport("scripts/tools/waffles1")
--[[
AddPrefabPostInit("world", function(inst)
    local Map = getmetatable(inst.Map).__index

    Waffles1.SequenceFn(Map, "IsPassableAtPoint", function(passable, x, y, z)
        if passable then
            return true
        end
		
local ground = GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(x, y, z))
	if (ground == GROUND.OCEAN_COASTAL or ground == GROUND.OCEAN_COASTAL_SHORE or ground == GROUND.OCEAN_SWELL or ground == GROUND.OCEAN_ROUGH or ground == GROUND.OCEAN_BRINEPOOL or ground == GROUND.OCEAN_BRINEPOOL_SHORE or ground == GROUND.OCEAN_HAZARDOUS) then		
	return true
	end
        return #TheSim:FindEntities(x, y, z, 22, { "alt_tile" }) > 0
    end)

    Waffles1.SequenceFn(Map, "GetTileCenterPoint", function(pos)
        if pos ~= nil then
            return unpack(pos)
        end
        return 0, 0, 0
    end)
end)
]]
Waffles1.GetPath(_G, "STRINGS/ACTIONS/JUMPIN").USE = Waffles1.ReturnChild(STRINGS, "ACTIONS/USEITEM") or "Use"

Waffles1.GetPath(_G, "ACTIONS/JUMPIN").strfn = function(act)
    return act.doer ~= nil and act.doer:HasTag("playerghost") and "HAUNT" or act.target ~= nil and
               act.target:HasTag("stairs") and "USE" or nil
end

---------------dodoy
GLOBAL.doydoy_mate_time = 2
GLOBAL.doydoy_total_limit = 20
GLOBAL.seabeach_amount = {
    doydoy = 0
}
---------------------------- new recipe tab for obsidian tools ---------------------
local _G = GLOBAL
local require = _G.require
local TechTree = require("techtree")
table.insert(TechTree.AVAILABLE_TECH, "OBSIDIAN")
table.insert(TechTree.AVAILABLE_TECH, "CITY")
table.insert(TechTree.AVAILABLE_TECH, "HOME")

TechTree.Create = function(t)
    t = t or {}
    for i, v in ipairs(TechTree.AVAILABLE_TECH) do
        t[v] = t[v] or 0
    end
    return t
end

_G.TECH.NONE.OBSIDIAN = 0
_G.TECH.OBSIDIAN_ONE = {
    OBSIDIAN = 1
}
_G.TECH.OBSIDIAN_TWO = {
    OBSIDIAN = 2
}

_G.TECH.NONE.CITY = 0
_G.TECH.CITY_ONE = {
    CITY = 1
}
_G.TECH.CITY_TWO = {
    CITY = 2
}

_G.TECH.NONE.HOME = 0
_G.TECH.HOME_ONE = {
    HOME = 1
}
_G.TECH.HOME_TWO = {
    HOME = 2
}

--------------------------------------------------------------------------
--[[ 解锁等级中加入自己的部分 ]]
--------------------------------------------------------------------------

for k, v in pairs(TUNING.PROTOTYPER_TREES) do
    v.OBSIDIAN = 0
    v.CITY = 0
    v.HOME = 0
end

TUNING.PROTOTYPER_TREES.OBSIDIAN_ONE = TechTree.Create({
    OBSIDIAN = 1
})
TUNING.PROTOTYPER_TREES.OBSIDIAN_TWO = TechTree.Create({
    OBSIDIAN = 2
})

TUNING.PROTOTYPER_TREES.CITY_ONE = TechTree.Create({
    CITY = 1
})
TUNING.PROTOTYPER_TREES.CITY_TWO = TechTree.Create({
    CITY = 2
})

TUNING.PROTOTYPER_TREES.HOME_ONE = TechTree.Create({
    HOME = 1
})
TUNING.PROTOTYPER_TREES.HOME_TWO = TechTree.Create({
    HOME = 2
})

for i, v in pairs(_G.AllRecipes) do
    if v.level.OBSIDIAN == nil then
        v.level.OBSIDIAN = 0
    end
    if v.level.CITY == nil then
        v.level.CITY = 0
    end
    if v.level.HOME == nil then
        v.level.HOME = 0
    end
end
--[[
modimport "custom_tech_tree.lua"
AddNewTechTree("OBSIDIAN",2)
AddNewTechTree("OBSIDIAN_ONE")
AddNewTechTree("OBSIDIAN_TWO")

AddNewTechTree("CITY",2)
AddNewTechTree("CITY_ONE")
AddNewTechTree("CITY_TWO")

AddNewTechTree("HOME",2)
AddNewTechTree("HOME_ONE")
AddNewTechTree("HOME_TWO")
]]
if GetModConfigData("nautical_tab") == true and GetModConfigData("seafaring_tab") == false and
    GetModConfigData("kindofworld") ~= 20 then
    GLOBAL.RECIPETABS['NAUTICALTAB'] = {
        str = "NAUTICALTAB",
        sort = 1.1,
        icon = "nauticaltab.png",
        icon_atlas = "images/tabs.xml"
    }
end

if GetModConfigData("obsidian_tab") == 1 then
    GLOBAL.RECIPETABS['OBSIDIANTAB'] = {
        str = "OBSIDIANTAB",
        sort = 90,
        icon = "tab_volcano.tex",
        icon_atlas = "images/tabs.xml",
        crafting_station = true
    }
end
if GetModConfigData("obsidian_tab") == 0 then
    GLOBAL.RECIPETABS['OBSIDIANTAB'] = {
        str = "OBSIDIANTAB",
        sort = 1259,
        icon = "tab_volcano.tex",
        icon_atlas = "images/tabs.xml",
        crafting_station = false
    }
end

if GetModConfigData("city_tab") == 1 then
    GLOBAL.RECIPETABS['CITY'] = {
        str = "CITY",
        sort = 91,
        icon = "tab_city.tex",
        icon_atlas = "images/tabs.xml",
        crafting_station = true
    }
end
if GetModConfigData("city_tab") == 0 then
    GLOBAL.RECIPETABS['CITY'] = {
        str = "CITY",
        sort = 1245,
        icon = "tab_city.tex",
        icon_atlas = "images/tabs.xml",
        crafting_station = false
    }
end

if GetModConfigData("home_tab") == 1 then
    GLOBAL.RECIPETABS['HOME'] = {
        str = "HOME",
        sort = 92,
        icon = "tab_home_decor.tex",
        icon_atlas = "images/tabs.xml",
        crafting_station = true
    }
end
if GetModConfigData("home_tab") == 0 then
    GLOBAL.RECIPETABS['HOME'] = {
        str = "HOME",
        sort = 1249,
        icon = "tab_home_decor.tex",
        icon_atlas = "images/tabs.xml",
        crafting_station = false
    }
end

if GetModConfigData("frost_island") ~= 5 then
    AddRecipe("wildbeaver_house",
        {Ingredient("beaverskin", 4, "images/inventoryimages/volcanoinventory.xml"), Ingredient("boards", 4),
         Ingredient("cutstone", 3)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "wildbeaver_house_placer", nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
end

if GetModConfigData("Shipwrecked_plus") == true or GetModConfigData("Shipwreckedworld_plus") == true then
    AddRecipe("pandahouse",
        {Ingredient("pandaskin", 4, "images/inventoryimages/volcanoinventory.xml"), Ingredient("boards", 4),
         Ingredient("cutstone", 3)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "pandahouse_placer", nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
end

if GetModConfigData("gorgeisland") == true or GetModConfigData("Shipwreckedworld_plus") == true then
    AddRecipe("galinheiro", {Ingredient("seeds", 6), Ingredient("boards", 4),
                             Ingredient("feather_chicken", 2, "map_icons/creepindedeepicon.xml")}, RECIPETABS.TOWN,
        TECH.SCIENCE_TWO, "galinheiro_placer", nil, nil, nil, nil, "map_icons/creepindedeepicon.xml")
end

---------------------corrigindo bug estranho-------------
local campfire = AddRecipe("campfire", {Ingredient("cutgrass", 3), Ingredient("log", 2)}, RECIPETABS.LIGHT, TECH.NONE,
    "campfire_placer", 1, nil, nil, nil)
campfire.sortkey = 0

---------------------------- new recipes for obsidian workbench ---------------------
-- AddRecipe("book_gardening", {Ingredient("papyrus", 2), Ingredient("seeds", 5), Ingredient("poop", 5)}, GLOBAL.CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_ONE, nil, nil, true, nil, "bookbuilder")

AddRecipe("mutator_tropical", {Ingredient("monstermeat", 2), Ingredient("silk", 1),
                               Ingredient("venomgland", 1, "images/inventoryimages/volcanoinventory.xml")},
    CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer",
    "map_icons/creepindedeepicon.xml")
AddRecipe("mutator_frost", {Ingredient("monstermeat", 2), Ingredient("silk", 3), Ingredient("ice", 4)},
    CUSTOM_RECIPETABS.SPIDERCRAFT, TECH.SPIDERCRAFT_ONE, nil, nil, nil, nil, "spiderwhisperer",
    "map_icons/creepindedeepicon.xml")

local seasack = AddRecipe("seasack", {Ingredient("seaweed", 5, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("vine", 2, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("shark_gills", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")

local obsidianfirepit = AddRecipe("obsidianfirepit", {Ingredient("log", 3),
                                                      Ingredient("obsidian", 8,
    "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.LIGHT, TECH.SCIENCE_TWO, "obsidianfirepit_placer", nil,
    nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local dragoonden = AddRecipe("dragoonden",
    {Ingredient("dragoonheart", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rocks", 5),
     Ingredient("obsidian", 4, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
    "dragoonden_placer", nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("axeobsidian",
    {Ingredient("axe", 1), Ingredient("obsidian", 2, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("dragoonheart", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.OBSIDIANTAB,
    TECH.OBSIDIAN_TWO, nil, nil, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("obsidianmachete", {Ingredient("machete", 1, "images/inventoryimages/volcanoinventory.xml"),
                              Ingredient("obsidian", 3, "images/inventoryimages/volcanoinventory.xml"),
                              Ingredient("dragoonheart", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.OBSIDIANTAB, TECH.OBSIDIAN_TWO, nil, nil, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("spear_obsidian",
    {Ingredient("spear", 1), Ingredient("obsidian", 3, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("dragoonheart", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.OBSIDIANTAB,
    TECH.OBSIDIAN_TWO, nil, nil, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("volcanostaff",
    {Ingredient("firestaff", 1), Ingredient("obsidian", 4, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("dragoonheart", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.OBSIDIANTAB,
    TECH.OBSIDIAN_TWO, nil, nil, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("armorobsidian",
    {Ingredient("armorwood", 1), Ingredient("obsidian", 5, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("dragoonheart", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.OBSIDIANTAB,
    TECH.OBSIDIAN_TWO, nil, nil, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("obsidianbomb",
    {Ingredient("gunpowder", 3), Ingredient("obsidian", 3, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("dragoonheart", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.OBSIDIANTAB,
    TECH.OBSIDIAN_TWO, nil, nil, true, 3, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("book_meteor1",
    {Ingredient("papyrus", 2), Ingredient("obsidian", 2, "images/inventoryimages/volcanoinventory.xml")},
    GLOBAL.CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_TWO, nil, nil, true, nil, "bookbuilder",
    "images/inventoryimages/volcanoinventory.xml")
AddRecipe("wind_conch",
    {Ingredient("obsidian", 4, "images/inventoryimages/volcanoinventory.xml"), Ingredient("purplegem", 1),
     Ingredient("magic_seal", 1, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.OBSIDIANTAB,
    TECH.OBSIDIAN_TWO, nil, nil, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("sail_stick",
    {Ingredient("obsidian", 2, "images/inventoryimages/volcanoinventory.xml"), Ingredient("nightmarefuel", 3),
     Ingredient("magic_seal", 1, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.OBSIDIANTAB,
    TECH.OBSIDIAN_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
local wildborehouse = AddRecipe("wildborehouse",
    {Ingredient("pigskin", 4), Ingredient("palmleaf", 5, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("bamboo", 8, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
    "wildborehouse_placer", nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local mermhouse_tropical = AddRecipe("mermfishhouse", {Ingredient("boards", 5), Ingredient("cutreeds", 3),
                                                       Ingredient("fish2", 2,
    "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, "mermfishhouse_placer", nil,
    nil, nil, "merm_builder", "map_icons/hamleticon.xml", "mermhouse_tropical.png", function(pt, rot)
        local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
        return ground_tile and (ground_tile == GROUND.MARSH or ground_tile == GROUND.TIDALMARSH)
    end)
local mermhouse_crafted = AddRecipe("mermhouse_crafted",
    {Ingredient("boards", 4), Ingredient("cutreeds", 3), Ingredient("pondfish", 2)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE,
    "mermhouse_crafted_placer", nil, nil, nil, "merm_builder", nil, nil, function(pt, rot)
        local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
        return ground_tile and (ground_tile == GROUND.MARSH or ground_tile == GROUND.TIDALMARSH)
    end)
local mermthrone_construction = AddRecipe("mermthrone_construction", {Ingredient("boards", 5), Ingredient("rope", 5)},
    RECIPETABS.TOWN, TECH.SCIENCE_ONE, "mermthrone_construction_placer", nil, nil, nil, "merm_builder", nil, nil,
    function(pt, rot)
        local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
        return ground_tile and (ground_tile == GROUND.MARSH or ground_tile == GROUND.TIDALMARSH)
    end)
local mermwatchtower = AddRecipe("mermwatchtower",
    {Ingredient("boards", 5), Ingredient("tentaclespots", 1), Ingredient("spear", 2)}, RECIPETABS.TOWN,
    TECH.SCIENCE_TWO, "mermwatchtower_placer", nil, nil, nil, "merm_builder", nil, nil, function(pt, rot)
        local ground_tile = GLOBAL.TheWorld.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
        return ground_tile and (ground_tile == GROUND.MARSH or ground_tile == GROUND.TIDALMARSH)
    end)
local doydoyfan = AddRecipe("doydoyfan", {Ingredient("cutreeds", 2), Ingredient("rope", 2),
                                          Ingredient("doydoyfeather", 5, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local fabric = AddRecipe("fabric", {Ingredient("bamboo", 3, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.REFINE, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local snakeskinhat = AddRecipe("snakeskinhat",
    {Ingredient("boneshard", 1), Ingredient("snakeskin", 1, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("strawhat", 1)}, RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local armor_snakeskin = AddRecipe("armor_snakeskin",
    {Ingredient("boneshard", 2), Ingredient("snakeskin", 2, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("vine", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local turf_snakeskinfloor = AddRecipe("turf_snakeskinfloor",
    {Ingredient("snakeskin", 2, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("fabric", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local sand_castle = AddRecipe("sand_castle", {Ingredient("sand", 4, "images/inventoryimages/volcanoinventory.xml"),
                                              Ingredient("palmleaf", 2, "images/inventoryimages/volcanoinventory.xml"),
                                              Ingredient("seashell", 3, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.TOWN, TECH.NONE, "sand_castle_placer", nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local palmleaf_hut = AddRecipe("palmleaf_hut",
    {Ingredient("palmleaf", 4, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 3)},
    RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO, "palmleaf_hut_placer", nil, nil, nil, nil,
    "images/inventoryimages/hamletinventory.xml")
local palmleaf_umbrella = AddRecipe("palmleaf_umbrella", {Ingredient("twigs", 4), Ingredient("petals", 6),
                                                          Ingredient("palmleaf", 3,
    "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, nil,
    "images/inventoryimages/hamletinventory.xml")
local machete = AddRecipe("machete", {Ingredient("flint", 3), Ingredient("twigs", 1)}, RECIPETABS.TOOLS, TECH.NONE, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local goldenmachete = AddRecipe("goldenmachete", {Ingredient("twigs", 4), Ingredient("goldnugget", 2)},
    RECIPETABS.TOOLS, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local antidote = AddRecipe("antidote", {Ingredient("venomgland", 1, "images/inventoryimages/volcanoinventory.xml"),
                                        Ingredient("coral", 2, "images/inventoryimages/volcanoinventory.xml"),
                                        Ingredient("seaweed", 2, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local oxhat = AddRecipe("oxhat",
    {Ingredient("rope", 1), Ingredient("seashell", 4, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("ox_horn", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local armor_seashell = AddRecipe("armor_seashell",
    {Ingredient("seashell", 10, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 1),
     Ingredient("seaweed", 2, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.WAR, TECH.SCIENCE_TWO, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local chiminea = AddRecipe("chiminea",
    {Ingredient("log", 2), Ingredient("limestone", 3, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("sand", 2, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.LIGHT, TECH.NONE,
    "chiminea_placer", nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local bottlelantern = AddRecipe("bottlelantern",
    {Ingredient("messagebottleempty1", 1, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("bioluminescence", 2, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.LIGHT,
    TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local boat_lantern = AddRecipe("boat_lantern",
    {Ingredient("messagebottleempty1", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("twigs", 2),
     Ingredient("bioluminescence", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.LIGHT,
    TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local boat_torch = AddRecipe("boat_torch", {Ingredient("torch", 1), Ingredient("twigs", 2)}, RECIPETABS.LIGHT, TECH.ONE,
    nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local messagebottleempty1 = AddRecipe("messagebottleempty1",
    {Ingredient("sand", 3, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local cutlass = AddRecipe("cutlass", {Ingredient("goldnugget", 2), Ingredient("twigs", 1),
                                      Ingredient("dead_swordfish", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.WAR, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local sandbag_item = AddRecipe("sandbag_item", {Ingredient("fabric", 2, "images/inventoryimages/volcanoinventory.xml"),
                                                Ingredient("sand", 3, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, 4, nil, "images/inventoryimages/volcanoinventory.xml")
local limestone = AddRecipe("limestone", {Ingredient("coral", 3, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.REFINE, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local double_umbrellahat = AddRecipe("double_umbrellahat",
    {Ingredient("umbrella", 1), Ingredient("shark_gills", 2, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("strawhat", 2)}, RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
AddRecipe("aerodynamichat", {Ingredient("coconut", 1, "images/inventoryimages/volcanoinventory.xml"),
                             Ingredient("shark_fin", 1, "images/inventoryimages/volcanoinventory.xml"),
                             Ingredient("vine", 2, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.DRESS,
    TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local monkeyball = AddRecipe("monkeyball",
    {Ingredient("cave_banana", 1), Ingredient("snakeskin", 2, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("rope", 2)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local spear_poison = AddRecipe("spear_poison", {Ingredient("spear", 1),
                                                Ingredient("venomgland", 1,
    "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local turf_road = AddRecipe("turf_road", {Ingredient("turf_rocky", 1), Ingredient("boards", 1)}, RECIPETABS.TOWN,
    TECH.SCIENCE_TWO)
if GetModConfigData("kindofworld") == 10 then
    local turf_road = AddRecipe("turf_road", {Ingredient("boards", 1),
                                              Ingredient("turf_magmafield", 1,
        "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil)
end
local mussel_stick = AddRecipe("mussel_stick", {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"),
                                                Ingredient("vine", 1, "images/inventoryimages/volcanoinventory.xml"),
                                                Ingredient("seaweed", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.FARM, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local thatchpack = AddRecipe("thatchpack", {Ingredient("palmleaf", 6, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local icemaker = AddRecipe("icemaker",
    {Ingredient("heatrock", 1), Ingredient("bamboo", 5, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("transistor", 2)}, RECIPETABS.SCIENCE, TECH.SCIENCE_TWO, "icemaker_placer", nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local primeapebarrel = AddRecipe("primeapebarrel",
    {Ingredient("twigs", 10), Ingredient("cave_banana", 3), Ingredient("poop", 4)}, RECIPETABS.TOWN, TECH.SCIENCE_TWO,
    "primeapebarrel_placer", nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local ballphinhouse = AddRecipe("porto_ballphinhouse",
    {Ingredient("limestone", 4, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("seaweed", 4, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("dorsalfin", 2, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml", "ballphinhouse.tex")
local nubbin = AddRecipe("nubbin", {Ingredient("limestone", 4, "images/inventoryimages/volcanoinventory.xml"),
                                    Ingredient("corallarve", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.REFINE, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local coconade = AddRecipe("coconade",
    {Ingredient("coconut", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("gunpowder", 1),
     Ingredient("rope", 1)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local quackendrill = AddRecipe("quackendrill",
    {Ingredient("quackenbeak", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("gears", 1),
     Ingredient("transistor", 1)}, RECIPETABS.SCIENCE, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local sea_chiminea = AddRecipe("porto_sea_chiminea",
    {Ingredient("sand", 4, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("tar", 6, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("limestone", 6, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.LIGHT, TECH.SCIENCE_ONE,
    nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml", "sea_chiminea.tex")
AddRecipe("blowdart_poison",
    {Ingredient("cutreeds", 2), Ingredient("venomgland", 1, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("feather_crow", 1)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local ox_flute = AddRecipe("ox_flute",
    {Ingredient("ox_horn", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("nightmarefuel", 2),
     Ingredient("rope", 1)}, RECIPETABS.MAGIC, TECH.MAGIC_TWO, nil, nil, nil, nil, nil,
    "images/inventoryimages/volcanoinventory.xml")
local researchlab5 = AddRecipe("porto_researchlab5",
    {Ingredient("limestone", 4, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("sand", 2, "images/inventoryimages/volcanoinventory.xml"), Ingredient("transistor", 2)},
    RECIPETABS.SCIENCE, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml",
    "researchlab5.tex")
local tarsuit = AddRecipe("tarsuit", {Ingredient("tar", 4, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("fabric", 2, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("palmleaf", 2, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.DRESS, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local tarlamp = AddRecipe("tarlamp", {Ingredient("seashell", 1, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("tar", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.LIGHT, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local blubbersuit = AddRecipe("blubbersuit", {Ingredient("blubber", 4, "images/inventoryimages/volcanoinventory.xml"),
                                              Ingredient("fabric", 2, "images/inventoryimages/volcanoinventory.xml"),
                                              Ingredient("palmleaf", 2, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local waterchest = AddRecipe("porto_waterchest1", {Ingredient("boards", 4),
                                                   Ingredient("tar", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.TOWN, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml",
    "waterchest1.tex")
local mussel_bed = AddRecipe("mussel_bed", {Ingredient("mussel", 1, "images/inventoryimages/volcanoinventory.xml"),
                                            Ingredient("coral", 1, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.FARM, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local fish_farm = AddRecipe("porto_fish_farm", {Ingredient("silk", 2), Ingredient("rope", 2),
                                                Ingredient("coconut", 4, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.FARM, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml",
    "fish_farm.tex")
local ice = AddRecipe("ice", {Ingredient("hail_ice", 4, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil)
local goldnugget = AddRecipe("goldnugget", {Ingredient("dubloon", 3, "images/inventoryimages/volcanoinventory.xml")},
    RECIPETABS.REFINE, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil)

local shadowmower_builder = AddRecipe("shadowmower_builder",
    {Ingredient("nightmarefuel", 2), Ingredient("machete", 1, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient(GLOBAL.CHARACTER_INGREDIENT.SANITY, 60)}, GLOBAL.CUSTOM_RECIPETABS.SHADOW, TECH.SHADOW_TWO, nil, nil,
    true, nil, "shadowmagic", "images/inventoryimages/volcanoinventory.xml")
AddRecipe("armorcactus",
    {Ingredient("needlespear", 3, "images/inventoryimages/volcanoinventory.xml"), Ingredient("armorwood", 1)},
    RECIPETABS.WAR, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local brainjellyhat = AddRecipe("brainjellyhat",
    {Ingredient("coral_brain", 1, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("jellyfish", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 2)},
    RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
local spear_launcher = AddRecipe("spear_launcher",
    {Ingredient("bamboo", 3, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("jellyfish", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.WAR, TECH.SCIENCE_TWO, nil,
    nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")

local wall_limestone_item = AddRecipe("wall_limestone_item",
    {Ingredient("limestone", 2, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_TWO, nil,
    nil, nil, 4, nil, "images/inventoryimages/volcanoinventory.xml")
local wall_enforcedlimestone_item = AddRecipe("wall_enforcedlimestone_item",
    {Ingredient("limestone", 2, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("seaweed", 4, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TOWN, TECH.SCIENCE_ONE, nil,
    nil, nil, 4, nil, "images/inventoryimages/volcanoinventory.xml")
local armor_windbreaker = AddRecipe("armor_windbreaker",
    {Ingredient("blubber", 2, "images/inventoryimages/volcanoinventory.xml"),
     Ingredient("fabric", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 1)}, RECIPETABS.DRESS,
    TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml") -- CHECK  THIS
local gashat = AddRecipe("gasmaskhat", {Ingredient("peagawkfeather", 4, "images/inventoryimages/hamletinventory.xml"),
                                        Ingredient("fabric", 1, "images/inventoryimages/hamletinventory.xml"),
                                        Ingredient("pigskin", 1)}, RECIPETABS.DRESS, TECH.SCIENCE_ONE, nil, nil, nil,
    nil, nil, "images/inventoryimages/hamletinventory.xml")
local gashatsw = AddRecipe("gashat", {Ingredient("coral", 2, "images/inventoryimages/hamletinventory.xml"),
                                      Ingredient("messagebottleempty1", 2, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("jellyfish", 1, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")

-------------------------------Sort keys----------------------------------------------------
------------------------------Code was written by Baku--------------------------------------
local AllRecipes = GLOBAL.AllRecipes
------------------------------[TOOLS]----------------------------------------------
machete.sortkey = AllRecipes["goldenaxe"]["sortkey"] + 0.1
goldenmachete.sortkey = AllRecipes["machete"]["sortkey"] + 0.1
------------------------------[LIGHT]----------------------------------------------
chiminea.sortkey = AllRecipes["firepit"]["sortkey"] + 0.1
obsidianfirepit.sortkey = AllRecipes["coldfirepit"]["sortkey"] + 0.1
tarlamp.sortkey = AllRecipes["torch"]["sortkey"] + 0.1
bottlelantern.sortkey = AllRecipes["minerhat"]["sortkey"] + 0.1
boat_torch.sortkey = AllRecipes["bottlelantern"]["sortkey"] + 0.1
boat_lantern.sortkey = AllRecipes["boat_torch"]["sortkey"] + 0.1
sea_chiminea.sortkey = AllRecipes["boat_lantern"]["sortkey"] + 0.1
------------------------------[SURVIVAL]-------------------------------------------
monkeyball.sortkey = AllRecipes["fishingrod"]["sortkey"] + 0.1
palmleaf_umbrella.sortkey = AllRecipes["umbrella"]["sortkey"] - 0.1
antidote.sortkey = AllRecipes["healingsalve"]["sortkey"] + 0.1
thatchpack.sortkey = AllRecipes["backpack"]["sortkey"] + 0.1
palmleaf_hut.sortkey = AllRecipes["siestahut"]["sortkey"] + 0.1
doydoyfan.sortkey = AllRecipes["featherfan"]["sortkey"] + 0.1
seasack.sortkey = AllRecipes["icepack"]["sortkey"] + 0.1
-- doydoynest.sortkey = AllRecipes["seasack"]["sortkey"] + 0.1
------------------------------[FARM]-----------------------------------------------
mussel_stick.sortkey = 0
fish_farm.sortkey = AllRecipes["icebox"]["sortkey"] + 0.1
mussel_bed.sortkey = AllRecipes["porto_fish_farm"]["sortkey"] + 0.1
------------------------------[SCIENCE]--------------------------------------------
researchlab5.sortkey = AllRecipes["researchlab2"]["sortkey"] + 0.1 -- SEA LAB
icemaker.sortkey = AllRecipes["firesuppressor"]["sortkey"] + 0.1
quackendrill.sortkey = AllRecipes["icemaker"]["sortkey"] + 0.1
------------------------------[WAR]------------------------------------------------
spear_poison.sortkey = AllRecipes["spear"]["sortkey"] + 0.1
armor_seashell.sortkey = AllRecipes["armorwood"]["sortkey"] + 0.1
-- armorlimestone.sortkey = AllRecipes["armormarble"]["sortkey"] + 0.1
-- armorcactus.sortkey = AllRecipes["footballhat"]["sortkey"] - 0.1
oxhat.sortkey = AllRecipes["footballhat"]["sortkey"] + 0.1
coconade.sortkey = AllRecipes["trap_teeth"]["sortkey"] + 0.1
spear_launcher.sortkey = AllRecipes["coconade"]["sortkey"] + 0.1
cutlass.sortkey = AllRecipes["armordragonfly"]["sortkey"] - 0.1
------------------------------[STRUCTURES]-----------------------------------------
waterchest.sortkey = AllRecipes["treasurechest"]["sortkey"] + 0.1
wall_limestone_item.sortkey = AllRecipes["wall_stone_item"]["sortkey"] + 0.1
wall_enforcedlimestone_item.sortkey = AllRecipes["wall_limestone_item"]["sortkey"] + 0.1
wildborehouse.sortkey = AllRecipes["pighouse"]["sortkey"] + 0.1
ballphinhouse.sortkey = AllRecipes["wildborehouse"]["sortkey"] + 0.1
primeapebarrel.sortkey = AllRecipes["porto_ballphinhouse"]["sortkey"] + 0.1
dragoonden.sortkey = AllRecipes["wildborehouse"]["sortkey"] + 0.1 -- or primeapebarrel if you add this
turf_road.sortkey = AllRecipes["turf_woodfloor"]["sortkey"] - 0.1
turf_snakeskinfloor.sortkey = AllRecipes["turf_woodfloor"]["sortkey"] + 0.1
sand_castle.sortkey = AllRecipes["dragonflychest"]["sortkey"] - 0.1
sandbag_item.sortkey = AllRecipes["sand_castle"]["sortkey"] - 0.1
------------------------------[REFINE]----------------------------------------------
fabric.sortkey = AllRecipes["papyrus"]["sortkey"] + 0.1
limestone.sortkey = AllRecipes["fabric"]["sortkey"] + 0.1
nubbin.sortkey = AllRecipes["limestone"]["sortkey"] + 0.1
goldnugget.sortkey = AllRecipes["nubbin"]["sortkey"] + 0.1
ice.sortkey = AllRecipes["messagebottleempty1"]["sortkey"] - 0.1
messagebottleempty1.sortkey = AllRecipes["nightmarefuel"]["sortkey"] - 0.1
------------------------------[MAGIC]-----------------------------------------------
-- piratihatitator.sortkey = 0
ox_flute.sortkey = AllRecipes["panflute"]["sortkey"] + 0.1
------------------------------[DRESSUP]---------------------------------------------
brainjellyhat.sortkey = AllRecipes["catcoonhat"]["sortkey"] + 0.1
-- shark_teethhat.sortkey = AllRecipes["watermelonhat"]["sortkey"] + 0.1
snakeskinhat.sortkey = AllRecipes["bushhat"]["sortkey"] + 0.1
armor_snakeskin.sortkey = AllRecipes["raincoat"]["sortkey"] + 0.1
blubbersuit.sortkey = AllRecipes["armor_snakeskin"]["sortkey"] + 0.1
tarsuit.sortkey = AllRecipes["blubbersuit"]["sortkey"] + 0.1
double_umbrellahat.sortkey = AllRecipes["eyebrellahat"]["sortkey"] + 0.1
armor_windbreaker.sortkey = AllRecipes["double_umbrellahat"]["sortkey"] + 0.1
gashat.sortkey = AllRecipes["armor_windbreaker"]["sortkey"] + 0.1
gashatsw.sortkey = AllRecipes["armor_windbreaker"]["sortkey"] + 0.1

mermhouse_crafted.sortkey = 0
mermthrone_construction.sortkey = AllRecipes["mermhouse_crafted"]["sortkey"] + 0.1
mermwatchtower.sortkey = AllRecipes["mermthrone_construction"]["sortkey"] + 0.1
mermhouse_tropical.sortkey = AllRecipes["mermwatchtower"]["sortkey"] + 0.1
------------------------------[SHADOW MAXWELL BOOK]-----------------------------------------
-- shadowname_builder.sortkey = AllRecipes["shadowlumber_builder"]["sortkey"] + 0.1   ----This sortkey for Machete shadow puppet
------------------------------Code was written by Baku--------------------------------------
--------------------------------------------------------------------------------------------
------------------------------[NAUTICAL TAB]------------------------------------------------
if GetModConfigData("nautical_tab") == true and GetModConfigData("kindofworld") ~= 20 then
    if GetModConfigData("seafaring_tab") == true then
        local oar = AddRecipe("oar", {Ingredient("log", 1)}, RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, nil,
            nil)
        oar.sortkey = 0.1
    else
        local oar = AddRecipe("oar", {Ingredient("log", 1)}, RECIPETABS.NAUTICALTAB, TECH.NONE, nil, nil, nil, nil, nil,
            nil)
        oar.sortkey = 0.1
    end
end

if GetModConfigData("kindofworld") == 10 then
    if GetModConfigData("seafaring_tab") == true then
        AddRecipe("porto_lograft_old", {Ingredient("log", 6), Ingredient("cutgrass", 4)}, RECIPETABS.SEAFARING,
            TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
        AddRecipe("porto_raft_old", {Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                     Ingredient("vine", 3, "images/inventoryimages/volcanoinventory.xml")},
            RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    else
        AddRecipe("porto_lograft_old", {Ingredient("log", 6), Ingredient("cutgrass", 4)}, RECIPETABS.NAUTICALTAB,
            TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
        AddRecipe("porto_raft_old", {Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                     Ingredient("vine", 3, "images/inventoryimages/volcanoinventory.xml")},
            RECIPETABS.NAUTICALTAB, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    end
else
    if GetModConfigData("seafaring_tab") == true then
        AddRecipe("porto_lograft", {Ingredient("log", 6), Ingredient("cutgrass", 4)}, RECIPETABS.SEAFARING, TECH.NONE,
            nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
        AddRecipe("porto_raft", {Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                 Ingredient("vine", 3, "images/inventoryimages/volcanoinventory.xml")},
            RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    else
        AddRecipe("porto_lograft", {Ingredient("log", 6), Ingredient("cutgrass", 4)}, RECIPETABS.NAUTICALTAB, TECH.NONE,
            nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
        AddRecipe("porto_raft", {Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                 Ingredient("vine", 3, "images/inventoryimages/volcanoinventory.xml")},
            RECIPETABS.NAUTICALTAB, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    end
end

if GetModConfigData("nautical_tab") == false then
    AddRecipe("porto_lograft", {Ingredient("log", 6), Ingredient("cutgrass", 4)}, RECIPETABS.SEAFARING, TECH.NONE, nil,
        nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_raft", {Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                             Ingredient("vine", 3, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
end

if GetModConfigData("seafaring_tab") == true then
    AddRecipe("surfboarditem",
        {Ingredient("boards", 1), Ingredient("seashell", 1, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, "walani", "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("corkboatitem",
        {Ingredient("rope", 1), Ingredient("cork", 4, "images/inventoryimages/hamletinventory.xml")},
        RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    AddRecipe("porto_woodlegsboat",
        {Ingredient("boards", 4), Ingredient("dubloon", 4, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("boatcannon", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.SEAFARING, TECH.NONE,
        nil, nil, nil, nil, "woodlegs", "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("luckyhat",
        {Ingredient("boneshard", 4), Ingredient("fabric", 3, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("dubloon", 10, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.SEAFARING, TECH.NONE,
        nil, nil, nil, nil, "woodlegs", "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_sea_yard", {Ingredient("limestone", 6, "images/inventoryimages/volcanoinventory.xml"),
                                 Ingredient("tar", 6, "images/inventoryimages/volcanoinventory.xml"),
                                 Ingredient("log", 4)}, RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml", "sea_yard.tex")
    AddRecipe("porto_tar_extractor", {Ingredient("coconut", 2, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("limestone", 4, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml",
        "tar_extractor.tex")

    AddRecipe("porto_rowboat",
        {Ingredient("boards", 3), Ingredient("vine", 4, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("boatrepairkit", {Ingredient("boards", 2), Ingredient("stinger", 2), Ingredient("rope", 2)},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_cargoboat", {Ingredient("boards", 6), Ingredient("rope", 3)}, RECIPETABS.SEAFARING,
        TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_armouredboat", {Ingredient("boards", 6), Ingredient("rope", 3),
                                     Ingredient("seashell", 10, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_encrustedboat",
        {Ingredient("boards", 6), Ingredient("limestone", 4, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("rope", 3)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")

    AddRecipe("sail", {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"),
                       Ingredient("vine", 2, "images/inventoryimages/volcanoinventory.xml"),
                       Ingredient("palmleaf", 4, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.SEAFARING,
        TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("feathersail",
        {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 4),
         Ingredient("doydoyfeather", 4, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.SEAFARING,
        TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("clothsail", {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"),
                            Ingredient("fabric", 2, "images/inventoryimages/volcanoinventory.xml"),
                            Ingredient("rope", 2)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("snakeskinsail", {Ingredient("log", 4), Ingredient("rope", 2),
                                Ingredient("snakeskin", 2, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("ironwind",
        {Ingredient("turbine_blades", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("transistor", 1),
         Ingredient("goldnugget", 2)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("malbatrossail",
        {Ingredient("driftwood_log", 4), Ingredient("rope", 2), Ingredient("malbatross_feather", 4)},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")

    AddRecipe("boatcannon",
        {Ingredient("coconut", 6, "images/inventoryimages/volcanoinventory.xml"), Ingredient("log", 5),
         Ingredient("gunpowder", 4)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("woodlegs_boatcannon",
        {Ingredient("obsidian", 6, "images/inventoryimages/volcanoinventory.xml"), Ingredient("log", 5),
         Ingredient("gunpowder", 4)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("quackeringram", {Ingredient("quackenbeak", 1, "images/inventoryimages/volcanoinventory.xml"),
                                Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                Ingredient("rope", 4)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil,
        nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("trawlnet",
        {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 3)},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("armor_lifejacket", {Ingredient("fabric", 2, "images/inventoryimages/volcanoinventory.xml"),
                                   Ingredient("vine", 2, "images/inventoryimages/volcanoinventory.xml"),
                                   Ingredient("messagebottleempty1", 2, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_buoy", {Ingredient("messagebottleempty1", 1, "images/inventoryimages/volcanoinventory.xml"),
                             Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                             Ingredient("bioluminescence", 2, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml", "buoy.tex")
    AddRecipe("seatrap", {Ingredient("palmleaf", 4, "images/inventoryimages/volcanoinventory.xml"),
                          Ingredient("messagebottleempty1", 2, "images/inventoryimages/volcanoinventory.xml"),
                          Ingredient("jellyfish", 1, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")

    AddRecipe("piratehat", {Ingredient("boneshard", 2), Ingredient("rope", 1), Ingredient("silk", 2)},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("captainhat",
        {Ingredient("boneshard", 1), Ingredient("seaweed", 1, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("strawhat", 1)}, RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("telescope", {Ingredient("goldnugget", 1), Ingredient("pigskin", 1),
                            Ingredient("messagebottleempty1", 1, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("supertelescope",
        {Ingredient("telescope", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("goldnugget", 1),
         Ingredient("tigereye", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.SEAFARING,
        TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
else
    AddRecipe("porto_rowboat",
        {Ingredient("boards", 3), Ingredient("vine", 4, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("boatrepairkit", {Ingredient("boards", 2), Ingredient("stinger", 2), Ingredient("rope", 2)},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_cargoboat", {Ingredient("boards", 6), Ingredient("rope", 3)}, RECIPETABS.NAUTICALTAB,
        TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_armouredboat", {Ingredient("boards", 6), Ingredient("rope", 3),
                                     Ingredient("seashell", 10, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_encrustedboat",
        {Ingredient("boards", 6), Ingredient("limestone", 4, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("rope", 3)}, RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    -- AddRecipe("porto_surfboard", {Ingredient("boards", 1), Ingredient("seashell", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.NAUTICALTAB, TECH.NONE, "porto_surfboard_placer", nil, nil, nil, "walani","images/inventoryimages/volcanoinventory.xml")
    AddRecipe("surfboarditem",
        {Ingredient("boards", 1), Ingredient("seashell", 1, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.NONE, nil, nil, nil, nil, "walani", "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("corkboatitem",
        {Ingredient("rope", 1), Ingredient("cork", 4, "images/inventoryimages/hamletinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    AddRecipe("porto_woodlegsboat",
        {Ingredient("boards", 4), Ingredient("dubloon", 4, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("boatcannon", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.NAUTICALTAB, TECH.NONE,
        nil, nil, nil, nil, "woodlegs", "images/inventoryimages/volcanoinventory.xml")

    AddRecipe("sail", {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"),
                       Ingredient("vine", 2, "images/inventoryimages/volcanoinventory.xml"),
                       Ingredient("palmleaf", 4, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("feathersail",
        {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 4),
         Ingredient("doydoyfeather", 4, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.NAUTICALTAB,
        TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("clothsail", {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"),
                            Ingredient("fabric", 2, "images/inventoryimages/volcanoinventory.xml"),
                            Ingredient("rope", 2)}, RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("snakeskinsail", {Ingredient("log", 4), Ingredient("rope", 2),
                                Ingredient("snakeskin", 2, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("ironwind",
        {Ingredient("turbine_blades", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("transistor", 1),
         Ingredient("goldnugget", 2)}, RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("malbatrossail",
        {Ingredient("driftwood_log", 4), Ingredient("rope", 2), Ingredient("malbatross_feather", 4)},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")

    AddRecipe("boatcannon",
        {Ingredient("coconut", 6, "images/inventoryimages/volcanoinventory.xml"), Ingredient("log", 5),
         Ingredient("gunpowder", 4)}, RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("woodlegs_boatcannon",
        {Ingredient("obsidian", 6, "images/inventoryimages/volcanoinventory.xml"), Ingredient("log", 5),
         Ingredient("gunpowder", 4)}, RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("quackeringram", {Ingredient("quackenbeak", 1, "images/inventoryimages/volcanoinventory.xml"),
                                Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                Ingredient("rope", 4)}, RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil,
        nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("trawlnet",
        {Ingredient("bamboo", 2, "images/inventoryimages/volcanoinventory.xml"), Ingredient("rope", 3)},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("armor_lifejacket", {Ingredient("fabric", 2, "images/inventoryimages/volcanoinventory.xml"),
                                   Ingredient("vine", 2, "images/inventoryimages/volcanoinventory.xml"),
                                   Ingredient("messagebottleempty1", 2, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_buoy", {Ingredient("messagebottleempty1", 1, "images/inventoryimages/volcanoinventory.xml"),
                             Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                             Ingredient("bioluminescence", 2, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml", "buoy.tex")
    AddRecipe("seatrap", {Ingredient("palmleaf", 4, "images/inventoryimages/volcanoinventory.xml"),
                          Ingredient("messagebottleempty1", 2, "images/inventoryimages/volcanoinventory.xml"),
                          Ingredient("jellyfish", 1, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")

    AddRecipe("luckyhat",
        {Ingredient("boneshard", 4), Ingredient("fabric", 3, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("dubloon", 10, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.NAUTICALTAB, TECH.NONE,
        nil, nil, nil, nil, "woodlegs", "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("piratehat", {Ingredient("boneshard", 2), Ingredient("rope", 1), Ingredient("silk", 2)},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("captainhat",
        {Ingredient("boneshard", 1), Ingredient("seaweed", 1, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("strawhat", 1)}, RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("porto_tar_extractor", {Ingredient("coconut", 2, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("bamboo", 4, "images/inventoryimages/volcanoinventory.xml"),
                                      Ingredient("limestone", 4, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml",
        "tar_extractor.tex")
    AddRecipe("porto_sea_yard", {Ingredient("limestone", 6, "images/inventoryimages/volcanoinventory.xml"),
                                 Ingredient("tar", 6, "images/inventoryimages/volcanoinventory.xml"),
                                 Ingredient("log", 4)}, RECIPETABS.NAUTICALTAB, TECH.NONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml", "sea_yard.tex")
    AddRecipe("telescope", {Ingredient("goldnugget", 1), Ingredient("pigskin", 1),
                            Ingredient("messagebottleempty1", 1, "images/inventoryimages/volcanoinventory.xml")},
        RECIPETABS.NAUTICALTAB, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("supertelescope",
        {Ingredient("telescope", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("goldnugget", 1),
         Ingredient("tigereye", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.NAUTICALTAB,
        TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
end

local boatmetal = AddRecipe("boatmetal_item", {Ingredient("alloy", 4, "images/inventoryimages/hamletinventory.xml"),
                                               Ingredient("iron", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.SEAFARING, TECH.SEAFARING_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
boatmetal.sortkey = 0.2
AddRecipe("poisonbalm",
    {Ingredient("livinglog", 1), Ingredient("venomgland", 1, "images/inventoryimages/volcanoinventory.xml")},
    GLOBAL.CUSTOM_RECIPETABS.NATURE, TECH.NONE, nil, nil, nil, nil, "plantkin",
    "images/inventoryimages/hamletinventory.xml")

if GetModConfigData("Hamlet") ~= 5 or GetModConfigData("startlocation") == 15 or GetModConfigData("kindofworld") == 5 then -- GetModConfigData("painted_sands")
    AddRecipe("glass_shards", {Ingredient("sand", 3, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.REFINE,
        TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("shard_sword",
        {Ingredient("glass_shards", 3, "images/inventoryimages/volcanoinventory.xml"), Ingredient("nightmarefuel", 2),
         Ingredient("twigs", 2)}, RECIPETABS.MAGIC, TECH.MAGIC_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    AddRecipe("shard_beak",
        {Ingredient("glass_shards", 3, "images/inventoryimages/volcanoinventory.xml"), Ingredient("crow", 1),
         Ingredient("twigs", 2)}, RECIPETABS.MAGIC, TECH.MAGIC_TWO, nil, nil, nil, nil, nil,
        "images/inventoryimages/volcanoinventory.xml")
    local armor_weevole = AddRecipe("armor_weevole",
        {Ingredient("weevole_carapace", 4, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("chitin", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.WAR, TECH.SCIENCE_TWO, nil,
        nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local cork_bat = AddRecipe("cork_bat", {Ingredient("cork", 3, "images/inventoryimages/hamletinventory.xml"),
                                            Ingredient("boards", 1)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil,
        nil, nil, "images/inventoryimages/hamletinventory.xml")
    local antsuit = AddRecipe("antsuit", {Ingredient("chitin", 5, "images/inventoryimages/hamletinventory.xml"),
                                          Ingredient("armorwood", 1)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil,
        nil, nil, "images/inventoryimages/hamletinventory.xml")
    local antmaskhat = AddRecipe("antmaskhat", {Ingredient("chitin", 5, "images/inventoryimages/hamletinventory.xml"),
                                                Ingredient("footballhat", 1)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil,
        nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local bugrepellent = AddRecipe("bugrepellent",
        {Ingredient("tuber_crop", 6, "images/inventoryimages/volcanoinventory.xml"),
         Ingredient("venus_stalk", 1, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.SURVIVAL,
        TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local goldpan = AddRecipe("goldpan", {Ingredient("iron", 2, "images/inventoryimages/hamletinventory.xml"),
                                          Ingredient("hammer", 1)}, RECIPETABS.TOOLS, TECH.SCIENCE_ONE, nil, nil, nil,
        nil, nil, "images/inventoryimages/hamletinventory.xml")
    local shears = AddRecipe("shears", {Ingredient("twigs", 2),
                                        Ingredient("iron", 2, "images/inventoryimages/hamletinventory.xml")},
        RECIPETABS.TOOLS, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    -- local goldnugget = AddRecipe("goldnugget", {Ingredient("gold_dust", 6, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.REFINE,  TECH.SCIENCE_ONE,nil,nil,nil,nil,nil,nil)
    local corkchest = AddRecipe("corkchest", {Ingredient("cork", 2, "images/inventoryimages/hamletinventory.xml"),
                                              Ingredient("rope", 1)}, RECIPETABS.TOWN, TECH.SCIENCE_ONE,
        "corkchest_placer", 1, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local roottrunk_child = AddRecipe("roottrunk_child",
        {Ingredient("bramble_bulb", 1, "images/inventoryimages/hamletinventory.xml"),
         Ingredient("venus_stalk", 2, "images/inventoryimages/volcanoinventory.xml"), Ingredient("boards", 2)},
        RECIPETABS.TOWN, TECH.SCIENCE_ONE, "roottrunk_child_placer", 1, nil, nil, nil,
        "images/inventoryimages/hamletinventory.xml")
    local candlehat = AddRecipe("candlehat", {Ingredient("cork", 4, "images/inventoryimages/hamletinventory.xml"),
                                              Ingredient("iron", 2, "images/inventoryimages/hamletinventory.xml")},
        RECIPETABS.LIGHT, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local basefan = AddRecipe("basefan",
        {Ingredient("alloy", 2, "images/inventoryimages/hamletinventory.xml"), Ingredient("transistor", 2),
         Ingredient("gears", 1)}, RECIPETABS.SCIENCE, TECH.SCIENCE_TWO, "basefan_placer", nil, nil, nil, nil,
        "images/inventoryimages/hamletinventory.xml")

    local disguisehat = AddRecipe("disguisehat",
        {Ingredient("twigs", 2), Ingredient("pigskin", 1), Ingredient("beardhair", 1)}, RECIPETABS.DRESS,
        TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local blunderbuss = AddRecipe("blunderbuss",
        {Ingredient("oinc10", 1, "images/inventoryimages/hamletinventory.xml"), Ingredient("boards", 2),
         Ingredient("gears", 1)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/hamletinventory.xml")
    AddRecipe("sprinkler1", {Ingredient("alloy", 2, "images/inventoryimages/hamletinventory.xml"),
                             Ingredient("bluegem", 1), Ingredient("ice", 6)}, RECIPETABS.FARM, TECH.SCIENCE_TWO,
        "sprinkler1_placer", nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local smelter = AddRecipe("smelter", {Ingredient("cutstone", 6), Ingredient("boards", 4), Ingredient("redgem", 1)},
        RECIPETABS.SCIENCE, TECH.SCIENCE_TWO, "smetler_placer", nil, nil, nil, nil,
        "images/inventoryimages/hamletinventory.xml")

    local halberd = AddRecipe("halberd", {Ingredient("alloy", 1, "images/inventoryimages/hamletinventory.xml"),
                                          Ingredient("twigs", 2)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil, nil, nil, nil,
        nil, "images/inventoryimages/hamletinventory.xml")
    local metalplatehat = AddRecipe("metalplatehat",
        {Ingredient("alloy", 3, "images/inventoryimages/hamletinventory.xml"),
         Ingredient("cork", 3, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil,
        nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local armor_metalplate = AddRecipe("armor_metalplate", {Ingredient("alloy", 3,
        "images/inventoryimages/hamletinventory.xml"), Ingredient("hammer", 1)}, RECIPETABS.WAR, TECH.SCIENCE_ONE, nil,
        nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    AddRecipe("ballpein_hammer",
        {Ingredient("iron", 2, "images/inventoryimages/hamletinventory.xml"), Ingredient("twigs", 1)}, RECIPETABS.TOOLS,
        TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    AddRecipe("magnifying_glass", {Ingredient("iron", 1, "images/inventoryimages/hamletinventory.xml"),
                                   Ingredient("twigs", 1), Ingredient("bluegem", 1)}, RECIPETABS.TOOLS,
        TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local bathat = AddRecipe("bathat", {Ingredient("pigskin", 2), Ingredient("batwing", 1), Ingredient("compass", 1)},
        RECIPETABS.LIGHT, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
    local pithat = AddRecipe("pithhat", {Ingredient("fabric", 1, "images/inventoryimages/volcanoinventory.xml"),
                                         Ingredient("vine", 3, "images/inventoryimages/volcanoinventory.xml"),
                                         Ingredient("cork", 6, "images/inventoryimages/hamletinventory.xml")},
        RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")

end

if GetModConfigData("kindofworld") == 5 then
    AddRecipe("antler", {Ingredient("hippo_antler", 1, "images/inventoryimages/hamletinventory.xml"),
                         Ingredient("bill_quill", 3, "images/inventoryimages/hamletinventory.xml"),
                         Ingredient("flint", 1)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,
        "images/inventoryimages/hamletinventory.xml")
    local researchlab4 = AddRecipe("researchlab4", {Ingredient("pigskin", 4), Ingredient("boards", 4),
                                                    Ingredient("feather_robin_winter", 4)}, RECIPETABS.MAGIC,
        TECH.SCIENCE_ONE, "researchlab4_placer")
    researchlab4.sortkey = 0.1
end

AddRecipe("city_lamp",
    {Ingredient("alloy", 1, "images/inventoryimages/hamletinventory.xml"), Ingredient("transistor", 1),
     Ingredient("lantern", 1)}, RECIPETABS.CITY, TECH.CITY_TWO, "city_lamp_placer", nil, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "city_lamp.tex")
AddRecipe("pighouse_city", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pighouse_city_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "pighouse_city.tex")
AddRecipe("pig_shop_deli_entrance", {Ingredient("boards", 4), Ingredient("honeyham", 1), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_deli_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_deli.png")
AddRecipe("pig_shop_general_entrance", {Ingredient("boards", 4), Ingredient("axe", 3), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_general_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_general.png")
AddRecipe("pig_shop_hoofspa_entrance", {Ingredient("boards", 4), Ingredient("bandage", 3), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_hoofspa_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_hoofspa.png")
AddRecipe("pig_shop_produce_entrance", {Ingredient("boards", 4), Ingredient("eggplant", 3), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_produce_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_produce.png")
AddRecipe("pig_shop_florist_entrance", {Ingredient("boards", 4), Ingredient("petals", 12), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_florist_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_florist.png")
AddRecipe("pig_antiquities_entrance",
    {Ingredient("boards", 4), Ingredient("ballpein_hammer", 3, "images/inventoryimages/hamletinventory.xml"),
     Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_antiquities_placer", 1, true, nil, nil,
    "map_icons/hamleticon.xml", "pig_shop_antiquities.png")
AddRecipe("pig_shop_arcane_entrance",
    {Ingredient("boards", 4), Ingredient("nightmarefuel", 1), Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY_TWO,
    "pig_shop_arcane_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "pig_shop_arcane.png")
AddRecipe("pig_shop_weapons_entrance", {Ingredient("boards", 4), Ingredient("spear", 3), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_weapons_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_weapons.png")
AddRecipe("pig_academy_entrance", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_academy_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_academy.png")
AddRecipe("hatshop_entrance", {Ingredient("boards", 4), Ingredient("tophat", 2), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_hatshop_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_hatshop.png")
AddRecipe("pig_shop_bank_entrance", {Ingredient("cutstone", 4), Ingredient("goldnugget", 2), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_bank_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_bank.png")
AddRecipe("pig_shop_tinker_entrance",
    {Ingredient("magnifying_glass", 2, "images/inventoryimages/hamletinventory.xml"), Ingredient("pigskin", 4)},
    RECIPETABS.CITY, TECH.CITY_TWO, "pig_shop_tinker_placer", 1, true, nil, nil, "map_icons/hamleticon.xml",
    "pig_shop_tinker.png")
AddRecipe("pig_shop_cityhall_player_entrance",
    {Ingredient("boards", 4), Ingredient("goldnugget", 4), Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY_TWO,
    "pig_shop_cityhall_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "pig_shop_cityhall.png")
AddRecipe("pig_guard_tower",
    {Ingredient("cutstone", 3), Ingredient("halberd", 1, "images/inventoryimages/hamletinventory.xml"),
     Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY_TWO, "pig_guard_tower_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml")
AddRecipe("securitycontract", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("playerhouse_city_entrance", {Ingredient("boards", 4), Ingredient("cutstone", 3),
                                        Ingredient("oinc", 30, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.CITY, TECH.CITY_TWO, "deed_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "pig_house_sale.png")

AddRecipe("hedge_block",
    {Ingredient("clippings", 3, "images/inventoryimages/hamletinventory.xml"), Ingredient("nitre", 1)}, RECIPETABS.CITY,
    TECH.CITY_TWO, "hedge_block_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("hedge_cone",
    {Ingredient("clippings", 3, "images/inventoryimages/hamletinventory.xml"), Ingredient("nitre", 1)}, RECIPETABS.CITY,
    TECH.CITY_TWO, "hedge_cone_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")
AddRecipe("hedge_layered",
    {Ingredient("clippings", 3, "images/inventoryimages/hamletinventory.xml"), Ingredient("nitre", 1)}, RECIPETABS.CITY,
    TECH.CITY_TWO, "hedge_layered_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml")

AddRecipe("pig_guard_tower_palace",
    {Ingredient("cutstone", 5), Ingredient("halberd", 1, "images/inventoryimages/hamletinventory.xml"),
     Ingredient("pigskin", 4)}, RECIPETABS.CITY, TECH.CITY_TWO, "pig_guard_tower_palace_placer", 1, true, nil, nil,
    "map_icons/hamleticon.xml", "pig_royal_tower.png")
AddRecipe("lawnornament_1",
    {Ingredient("cutstone", 2), Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, "lawnornament_1_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "lawnornament_1.png")
AddRecipe("lawnornament_2",
    {Ingredient("cutstone", 2), Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, "lawnornament_2_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "lawnornament_2.png")
AddRecipe("lawnornament_3",
    {Ingredient("cutstone", 2), Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, "lawnornament_3_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "lawnornament_3.png")
AddRecipe("lawnornament_4",
    {Ingredient("cutstone", 2), Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, "lawnornament_4_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "lawnornament_4.png")
AddRecipe("lawnornament_5",
    {Ingredient("cutstone", 2), Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, "lawnornament_5_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "lawnornament_5.png")
AddRecipe("lawnornament_6",
    {Ingredient("cutstone", 2), Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, "lawnornament_6_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "lawnornament_6.png")
AddRecipe("lawnornament_7",
    {Ingredient("cutstone", 2), Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.CITY,
    TECH.CITY_TWO, "lawnornament_7_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "lawnornament_7.png")
AddRecipe("topiary_1", {Ingredient("cutstone", 2), Ingredient("oinc", 9, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.CITY, TECH.CITY_TWO, "topiary_1_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "topiary_1.png")
AddRecipe("topiary_2", {Ingredient("cutstone", 2), Ingredient("oinc", 9, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.CITY, TECH.CITY_TWO, "topiary_2_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "topiary_2.png")
AddRecipe("topiary_3", {Ingredient("cutstone", 2), Ingredient("oinc", 9, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.CITY, TECH.CITY_TWO, "topiary_3_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "topiary_3.png")
AddRecipe("topiary_4", {Ingredient("cutstone", 2), Ingredient("oinc", 9, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.CITY, TECH.CITY_TWO, "topiary_4_placer", 1, true, nil, nil, "map_icons/hamleticon.xml", "topiary_4.png")
AddRecipe("city_hammer", {Ingredient("iron", 2, "images/inventoryimages/hamletinventory.xml"), Ingredient("twigs", 1)},
    RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("turf_foundation", {Ingredient("cutstone", 1)}, RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
    "images/inventoryimages/volcanoinventory.xml", "turf_foundation.tex")
AddRecipe("turf_cobbleroad", {Ingredient("cutstone", 2), Ingredient("boards", 1)}, RECIPETABS.CITY, TECH.CITY_TWO, nil,
    nil, true, 4, nil, "images/inventoryimages/volcanoinventory.xml", "turf_cobbleroad.tex")
AddRecipe("turf_checkeredlawn", {Ingredient("cutgrass", 2), Ingredient("nitre", 1)}, RECIPETABS.CITY, TECH.CITY_TWO,
    nil, nil, true, 4, nil, "images/inventoryimages/volcanoinventory.xml", "turf_checkeredlawn.tex")

AddRecipe("turf_magmafield", {Ingredient("rocks", 2), Ingredient("ash", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/volcanoinventory.xml", "turf_magmafield.tex")
AddRecipe("turf_ash", {Ingredient("ash", 3)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil,
    "images/inventoryimages/volcanoinventory.xml", "turf_ash.tex")
AddRecipe("turf_jungle",
    {Ingredient("bamboo", 1, "images/inventoryimages/volcanoinventory.xml"), Ingredient("cutgrass", 1)},
    RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil,
    "images/inventoryimages/volcanoinventory.xml", "turf_jungle.tex")
AddRecipe("turf_volcano", {Ingredient("nitre", 2), Ingredient("ash", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/volcanoinventory.xml", "turf_volcano.tex")
AddRecipe("turf_tidalmarsh", {Ingredient("cutgrass", 2), Ingredient("nitre", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/volcanoinventory.xml", "turf_tidalmarsh.tex")
AddRecipe("turf_meadow", {Ingredient("cutgrass", 2)}, RECIPETABS.TURFCRAFTING, TECH.TURFCRAFTING_ONE, nil, nil, true, 1,
    nil, "images/inventoryimages/volcanoinventory.xml", "turf_meadow.tex")
AddRecipe("turf_beach", {Ingredient("sand", 2, "images/inventoryimages/volcanoinventory.xml")}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/volcanoinventory.xml", "turf_beach.tex")
AddRecipe("turf_quagmire_gateway", {Ingredient("cutgrass", 2), Ingredient("nitre", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/novositens.xml", "turf_quagmire_gateway.tex")
AddRecipe("turf_quagmire_citystone", {Ingredient("cutgrass", 2), Ingredient("nitre", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/novositens.xml",
    "turf_quagmire_citystone.tex")
AddRecipe("turf_quagmire_parkfield", {Ingredient("cutgrass", 2), Ingredient("nitre", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/novositens.xml",
    "turf_quagmire_parkfield.tex")
AddRecipe("turf_quagmire_parkstone", {Ingredient("cutgrass", 2), Ingredient("nitre", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/novositens.xml",
    "turf_quagmire_parkstone.tex")
AddRecipe("turf_quagmire_peatforest", {Ingredient("cutgrass", 2), Ingredient("nitre", 1)}, RECIPETABS.TURFCRAFTING,
    TECH.TURFCRAFTING_ONE, nil, nil, true, 1, nil, "images/inventoryimages/novositens.xml",
    "turf_quagmire_peatforest.tex")

--[[

AddRecipe("turf_fields", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/inventoryimages/volcanoinventory.xml", "turf_fields.tex")

AddRecipe("turf_suburb", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/inventoryimages/volcanoinventory.xml", "turf_moss.tex")


AddRecipe("turf_gasjungle", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/inventoryimages/volcanoinventory.xml", "turf_gasjungle.tex")

AddRecipe("turf_checkeredlawn", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/inventoryimages/volcanoinventory.xml", "turf_checkeredlawn.tex")

AddRecipe("turf_deeprainforest", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/inventoryimages/volcanoinventory.xml", "turf_deeprainforest.tex")

AddRecipe("turf_rainforest", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/inventoryimages/volcanoinventory.xml", "turf_rainforest.tex")

AddRecipe("turf_pigruins", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/inventoryimages/volcanoinventory.xml", "turf_pigruins.tex")

AddRecipe("turf_antfloor", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/turfs/turf01-13.xml", "turf_antfloor.tex")

AddRecipe("turf_batfloor", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/turfs/turf01-12.xml", "turf_batfloor.tex")

AddRecipe("turf_battleground", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/turfs/turf01-11.xml", "turf_battleground.tex")

AddRecipe("turf_painted", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/turfs/turf01-9.xml", "turf_painted.tex")

AddRecipe("turf_plains", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/turfs/turf01-10.xml", "turf_plains.tex")

AddRecipe("turf_beardrug", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
RECIPETABS.CITY, TECH.CITY_TWO, nil, nil, true, 4, nil,
"images/turfs/turf01-14.xml", "turf_beardrug.tex")

]]

-- end

if GetModConfigData("Hamlet") ~= 5 or GetModConfigData("startlocation") == 15 or GetModConfigData("kindofworld") == 5 then
    local thunderhat = AddRecipe("thunderhat",
        {Ingredient("feather_thunder", 1, "images/inventoryimages/hamletinventory.xml"), Ingredient("goldnugget", 2),
         Ingredient("cork", 3, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.DRESS, TECH.SCIENCE_TWO, nil,
        nil, nil, nil, nil, "images/inventoryimages/hamletinventory.xml")
end

---------------------

AddRecipe("interior_floor_wood", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_check", {Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_plaid_tile", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_sheet_metal", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_transitional", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_woodpanels", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_herringbone", {Ingredient("oinc", 12, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_hexagon", {Ingredient("oinc", 12, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_hoof_curvy", {Ingredient("oinc", 12, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_floor_octagon", {Ingredient("oinc", 12, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("interior_wall_checkered_metal", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_circles", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_marble", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_sunflower", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_wood", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_mayorsoffice", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_harlequin", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_fullwall_moulding", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_floral", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("interior_wall_upholstered", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("reno_wallornament_photo", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_embroidery_hoop", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_mosaic", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_wreath", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_axe", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_hunt", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_periodic_table", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_gears_art", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_cape", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_no_smoking", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_wallornament_black_cat", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_antiquities_wallfish", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_antiquities_beefalo", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("reno_window_small_peaked_curtain", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_window_round_burlap", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_window_small_peaked", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_window_large_square", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_window_tall", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_window_large_square_curtain", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_window_tall_curtain", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
-- AddRecipe("reno_window_greenhouse", 			{Ingredient("oinc",8, "images/inventoryimages/hamletinventory.xml")}, 	RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true,nil,nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("reno_light_basic_bulb", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_basic_metal", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_chandalier_candles", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_rope_1", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_rope_2", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_floral_bulb", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_pendant_cherries", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_floral_scallop", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_floral_bloomer", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_tophat", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_light_derby", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("reno_cornerbeam_wood", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_cornerbeam_millinery", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_cornerbeam_round", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_cornerbeam_marble", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("deco_lamp_fringe", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_fringe_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_fringe.tex")
AddRecipe("deco_lamp_stainglass", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_lamp_stainglass_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_lamp_stainglass.tex")
AddRecipe("deco_lamp_downbridge", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_lamp_downbridge_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_lamp_downbridge.tex")
AddRecipe("deco_lamp_2embroidered", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_lamp_2embroidered_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_lamp_2embroidered.tex")
AddRecipe("deco_lamp_ceramic", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_ceramic_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_ceramic.tex")
AddRecipe("deco_lamp_glass", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_glass_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_glass.tex")
AddRecipe("deco_lamp_2fringes", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_2fringes_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_2fringes.tex")
AddRecipe("deco_lamp_candelabra", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_lamp_candelabra_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_lamp_candelabra.tex")
AddRecipe("deco_lamp_elizabethan", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_lamp_elizabethan_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_lamp_elizabethan.tex")
AddRecipe("deco_lamp_gothic", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_gothic_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_gothic.tex")
AddRecipe("deco_lamp_orb", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_orb_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_orb.tex")
AddRecipe("deco_lamp_bellshade", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_bellshade_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_bellshade.tex")
AddRecipe("deco_lamp_crystals", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_crystals_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_crystals.tex")
AddRecipe("deco_lamp_upturn", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_upturn_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_upturn.tex")
AddRecipe("deco_lamp_2upturns", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_2upturns_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_2upturns.tex")
AddRecipe("deco_lamp_spool", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_spool_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_spool.tex")
AddRecipe("deco_lamp_edison", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_edison_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_edison.tex")
AddRecipe("deco_lamp_adjustable", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_lamp_adjustable_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_lamp_adjustable.tex")
AddRecipe("deco_lamp_rightangles", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_lamp_rightangles_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_lamp_rightangles.tex")
AddRecipe("deco_lamp_hoofspa", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_lamp_hoofspa_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_lamp_hoofspa.tex")

AddRecipe("deco_table_round", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_table_round_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_table_round.tex")
AddRecipe("deco_table_banker", {Ingredient("oinc", 4, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_table_banker_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_table_banker.tex")
AddRecipe("deco_table_diy", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_table_diy_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_table_diy.tex")
AddRecipe("deco_table_raw", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_table_raw_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_table_raw.tex")
AddRecipe("deco_table_crate", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_table_crate_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_table_crate.tex")
AddRecipe("deco_table_chess", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_table_chess_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_table_chess.tex")

AddRecipe("deco_plantholder_basic", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_basic_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_basic.tex")
AddRecipe("deco_plantholder_wip", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_wip_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_wip.tex")
AddRecipe("deco_plantholder_fancy", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_fancy_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_fancy.tex")
AddRecipe("deco_plantholder_bonsai", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_bonsai_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_bonsai.tex")
AddRecipe("deco_plantholder_dishgarden", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_dishgarden_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_dishgarden.tex")
AddRecipe("deco_plantholder_philodendron", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_philodendron_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_philodendron.tex")
AddRecipe("deco_plantholder_orchid", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_orchid_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_orchid.tex")
AddRecipe("deco_plantholder_draceana", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_draceana_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_draceana.tex")
AddRecipe("deco_plantholder_xerographica", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_xerographica_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_xerographica.tex")
AddRecipe("deco_plantholder_birdcage", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_birdcage_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_birdcage.tex")
AddRecipe("deco_plantholder_palm", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_palm_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_palm.tex")
AddRecipe("deco_plantholder_zz", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "deco_plantholder_zz_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_plantholder_zz.tex")
AddRecipe("deco_plantholder_fernstand", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_fernstand_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_fernstand.tex")
AddRecipe("deco_plantholder_fern", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_fern_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_fern.tex")
AddRecipe("deco_plantholder_terrarium", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_terrarium_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_terrarium.tex")
AddRecipe("deco_plantholder_plantpet", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_plantpet_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_plantpet.tex")
AddRecipe("deco_plantholder_traps", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_traps_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_traps.tex")
AddRecipe("deco_plantholder_pitchers", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, "deco_plantholder_pitchers_placer", 1, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "reno_plantholder_pitchers.tex")

AddRecipe("deco_chair_classic", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_classic_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_classic.tex")
AddRecipe("deco_chair_corner", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_corner_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_corner.tex")
AddRecipe("deco_chair_bench", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_bench_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_bench.tex")
AddRecipe("deco_chair_horned", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_horned_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_horned.tex")
AddRecipe("deco_chair_footrest", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_footrest_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_footrest.tex")
AddRecipe("deco_chair_lounge", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_lounge_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_lounge.tex")
AddRecipe("deco_chair_massager", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_massager_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_massager.tex")
AddRecipe("deco_chair_stuffed", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_stuffed_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_stuffed.tex")
AddRecipe("deco_chair_rocking", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "chair_rocking_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_chair_rocking.tex")

AddRecipe("stone_door", {Ingredient("oinc", 20, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml", "stone_door.tex")
AddRecipe("plate_door", {Ingredient("oinc", 25, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml", "plate_door.tex")
AddRecipe("organic_door", {Ingredient("oinc", 25, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml", "organic_door.tex")
AddRecipe("round_door", {Ingredient("oinc", 25, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml", "round_door.tex")

AddRecipe("rug_round", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_round_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_round.tex")
AddRecipe("rug_square", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_square_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_square.tex")
AddRecipe("rug_oval", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_oval_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_oval.tex")
AddRecipe("rug_rectangle", {Ingredient("oinc", 3, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_rectangle_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_rectangle.tex")
AddRecipe("rug_fur", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_fur_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml", "reno_rug_fur.tex")
AddRecipe("rug_hedgehog", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_hedgehog_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_hedgehog.tex")
AddRecipe("rug_porcupuss", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_porcupuss_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_porcupuss.tex")
AddRecipe("rug_hoofprint", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_hoofprint_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_hoofprint.tex")
AddRecipe("rug_octagon", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_octagon_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_octagon.tex")
AddRecipe("rug_swirl", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_swirl_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_swirl.tex")
AddRecipe("rug_catcoon", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_catcoon_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_catcoon.tex")
AddRecipe("rug_rubbermat", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_rubbermat_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_rubbermat.tex")
AddRecipe("rug_web", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_web_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml", "reno_rug_web.tex")
AddRecipe("rug_metal", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_metal_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_metal.tex")
AddRecipe("rug_wormhole", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_wormhole_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_wormhole.tex")
AddRecipe("rug_braid", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_braid_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_braid.tex")
AddRecipe("rug_beard", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_beard_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_beard.tex")
AddRecipe("rug_nailbed", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_nailbed_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_nailbed.tex")
AddRecipe("rug_crime", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_crime_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_crime.tex")
AddRecipe("rug_tiles", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "rug_tiles_placer", 1, true, nil, nil, "images/inventoryimages/hamletinventory.xml",
    "reno_rug_tiles.tex")

AddRecipe("reno_shelves_wood", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_basic", {Ingredient("oinc", 2, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_cinderblocks", {Ingredient("oinc", 1, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_marble", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_glass", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_ladder", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_hutch", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_industrial", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_adjustable", {Ingredient("oinc", 8, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_midcentury", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_wallmount", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_aframe", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_crates", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_fridge", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_floating", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_pipe", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_hattree", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")},
    RECIPETABS.HOME, TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")
AddRecipe("reno_shelves_pallet", {Ingredient("oinc", 6, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, nil, nil, true, nil, nil, "images/inventoryimages/hamletinventory.xml")

AddRecipe("bed0", {Ingredient("oinc", 5, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME, TECH.HOME_TWO,
    "bed0_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed0.tex")
AddRecipe("bed1", {Ingredient("oinc", 7, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME, TECH.HOME_TWO,
    "bed1_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed1.tex")
AddRecipe("bed2", {Ingredient("oinc", 10, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "bed2_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed2.tex")
AddRecipe("bed3", {Ingredient("oinc", 12, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "bed3_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed3.tex")
AddRecipe("bed4", {Ingredient("oinc", 14, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "bed4_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed4.tex")
AddRecipe("bed5", {Ingredient("oinc", 16, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "bed5_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed5.tex")
AddRecipe("bed6", {Ingredient("oinc", 18, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "bed6_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed6.tex")
AddRecipe("bed7", {Ingredient("oinc", 20, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "bed7_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed7.tex")
AddRecipe("bed8", {Ingredient("oinc", 22, "images/inventoryimages/hamletinventory.xml")}, RECIPETABS.HOME,
    TECH.HOME_TWO, "bed8_placer", 1, true, nil, nil, "images/inventoryimages/volcanoinventory.xml", "bed8.tex")

----------------------------
AddIngredientValues({"limpets_cooked"}, {
    fish = 0.5
}, true, false)
AddIngredientValues({"limpets"}, {
    fish = 0.5
}, true, false)
AddIngredientValues({"coconut_cooked", "coconut_halved"}, {
    fruit = 1,
    fat = 1
}, true, false)
AddIngredientValues({"coffeebeans"}, {
    fruit = .5
}, true, false)
AddIngredientValues({"coffeebeans_cooked"}, {
    fruit = 1
}, true, false)
AddIngredientValues({"sweet_potato"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"sweet_potatos_cooked"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"fish_med"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"dead_swordfish"}, {
    fish = 1.5
}, true, false)
AddIngredientValues({"fish_raw"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish_med_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"quagmire_crabmeat"}, {
    fish = 0.5,
    crab = 1
}, true, false)
AddIngredientValues({"quagmire_crabmeat_cooked"}, {
    fish = 0.5,
    crab = 1
}, true, false)
AddIngredientValues({"lobster_land"}, {
    meat = 1.0,
    fish = 1.0
}, true, false)
AddIngredientValues({"lobster_dead"}, {
    meat = 1.0,
    fish = 1.0
}, true, false)
AddIngredientValues({"lobster_dead_cooked"}, {
    meat = 1.0,
    fish = 1.0
}, true, false)
AddIngredientValues({"fish_dogfish"}, {
    fish = 1
}, true, false)
AddIngredientValues({"mussel_cooked"}, {
    fish = 0.5
}, true, false)
AddIngredientValues({"mussel"}, {
    fish = 0.5
}, true, false)
AddIngredientValues({"shark_fin"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"crab"}, {
    fish = 0.5
}, true, false)
AddIngredientValues({"seaweed"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"seaweed_cooked"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"seaweed_dried"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"doydoyegg"}, {
    egg = 1
}, true, false)
AddIngredientValues({"dorsalfin"}, {
    inedible = 1
}, true, false)
AddIngredientValues({"jellyfish"}, {
    fish = 1,
    jellyfish = 1,
    monster = 1
}, true, false)
AddIngredientValues({"jellyfish_cooked"}, {
    fish = 1,
    jellyfish = 1,
    monster = 1
}, true, false)
AddIngredientValues({"jellyfish_dead"}, {
    fish = 1,
    jellyfish = 1,
    monster = 1
}, true, false)
AddIngredientValues({"jellyjerky"}, {
    fish = 1,
    jellyfish = 1,
    monster = 1
}, true, false)

AddIngredientValues({"fish2"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish2_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish3"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish3_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish4"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish4_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish5"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish5_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish6"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish6_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish7"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"fish7_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"salmon"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"salmon_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"coi"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"coi_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"snowitem"}, {
    meat = 0.5,
    frozen = 1
}, true, false)

AddIngredientValues({"roe"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"roe_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"quagmire_spotspice_sprig"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"quagmire_sap"}, {
    sweetener = 1
}, true, false)

AddIngredientValues({"seataro"}, {
    veggie = 1,
    frozen = 1
}, true, false)
AddIngredientValues({"seataro_cooked"}, {
    veggie = 1,
    frozen = 1
}, true, false)

AddIngredientValues({"blueberries"}, {
    fruit = 0.5,
    frozen = 0.25
}, true, false)
AddIngredientValues({"blueberries_cooked"}, {
    fruit = 0.75
}, true, false)

AddIngredientValues({"seacucumber"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"seacucumber_cooked"}, {
    veggie = 1
}, true, false)

AddIngredientValues({"gooseberry"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"gooseberry_cooked"}, {
    veggie = 1
}, true, false)

AddIngredientValues({"quagmire_mushrooms"}, {
    mushroom = 1,
    veggie = 0.5
}, true, false)
AddIngredientValues({"quagmire_mushrooms_cooked"}, {
    mushroom = 1,
    veggie = 0.5
}, true, false)

AddIngredientValues({"oceanfish_small_61_inv"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"oceanfish_small_61_inv_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)

AddIngredientValues({"oceanfish_small_71_inv"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"oceanfish_small_71_inv_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)

AddIngredientValues({"oceanfish_small_81_inv"}, {
    meat = 0.5,
    fish = 1
}, true, false)
AddIngredientValues({"oceanfish_small_81_inv_cooked"}, {
    meat = 0.5,
    fish = 1
}, true, false)

AddIngredientValues({"foliage"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"jellybug"}, {
    bug = 1
}, true, false)
AddIngredientValues({"jellybug_cooked"}, {
    bug = 1
}, true, false)
AddIngredientValues({"slugbug"}, {
    bug = 1
}, true, false)
AddIngredientValues({"slugbug_cooked"}, {
    bug = 1
}, true, false)
AddIngredientValues({"cutnettle"}, {
    antihistamine = 1
}, true, false)
AddIngredientValues({"radish"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"radish_cooked"}, {
    veggie = 1
}, true, false)

AddIngredientValues({"turnip"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"turnip_cooked"}, {
    veggie = 1
}, true, false)

AddIngredientValues({"asparagus"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"asparagus_cooked"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"aloe"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"aloe_cooked"}, {
    veggie = 1
}, true, false)
AddIngredientValues({"weevole_carapace"}, {
    inedible = 1
}, true, false)
AddIngredientValues({"piko_orange"}, {
    filter = 1
}, true, false)
AddIngredientValues({"snake_bone"}, {
    bone = 1
}, true, false)
AddIngredientValues({"yelow_cap"}, {
    veggie = 0.5
}, true, false)
AddIngredientValues({"yelow_cooked"}, {
    veggie = 0.5
}, true, false)

local fruityjuice = {
    name = "fruityjuice",
    test = function(cooker, names, tags)
        return names.blueberries_cooked and names.blueberries_cooked == 2 and names.foliage and tags.frozen or
                   names.blueberries and names.blueberries == 2 and names.foliage and tags.frozen
    end,
    priority = 1,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_LARGE,
    sanity = TUNING.SANITY_TINY,
    cooktime = 2,
    floater = {"small", 0.05, 0.7},
    tags = {},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}

AddCookerRecipe("cookpot", fruityjuice)
AddCookerRecipe("portablecookpot", fruityjuice)
AddCookerRecipe("xiuyuan_cookpot", fruityjuice)

local butterflymuffin = {
    name = "butterflymuffin",
    test = function(cooker, names, tags)
        return
            (names.butterflywings or names.butterfly_tropical_wings or names.moonbutterflywings) and not tags.meat and
                tags.veggie
    end,
    priority = 1,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_LARGE,
    sanity = TUNING.SANITY_TINY,
    cooktime = 2,
    floater = {"small", 0.05, 0.7},
    tags = {},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}

AddCookerRecipe("cookpot", butterflymuffin)
AddCookerRecipe("portablecookpot", butterflymuffin)
AddCookerRecipe("xiuyuan_cookpot", butterflymuffin)

local coffee = {
    name = "coffee",
    test = function(cooker, names, tags)
        return names.coffeebeans_cooked and
                   (names.coffeebeans_cooked == 4 or (names.coffeebeans_cooked == 3 and (tags.dairy or tags.sweetener)))
    end,
    priority = 30,
    weight = 1,
    foodtype = "VEGGIE",
    health = 3,
    hunger = 75 / 8,
    sanity = -5,
    cooktime = .5,
    tags = {},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml",
    oneat_desc = "Speeds the body"
}
AddCookerRecipe("cookpot", coffee)
AddCookerRecipe("portablecookpot", coffee)
AddCookerRecipe("xiuyuan_cookpot", coffee)
--[[
local surfnturf =
{
    name = "surfnturf",
		test = function(cooker, names, tags) return tags.meat and tags.meat >= 2.5 and tags.fish and tags.fish >= 1.5 and not tags.frozen end,
		priority = 30,
		weight = 1,
		foodtype = "MEAT",
		health = 60,
		hunger = 75/2,
		perishtime = 10*480,
		sanity = 33,
		cooktime = 1,
}
AddCookerRecipe("cookpot",surfnturf)
AddCookerRecipe("portablecookpot",surfnturf)

local seafoodgumbo =
{
    name = "seafoodgumbo",
		test = function(cooker, names, tags) return tags.fish and tags.fish > 2 end,
		priority = 10,
		weight = 1,
		foodtype = "MEAT",
		health = 40,
		hunger = 75/2,
		perishtime = 10*480,
		sanity = 20,
		cooktime = 1,
}
AddCookerRecipe("cookpot",seafoodgumbo)
AddCookerRecipe("portablecookpot",seafoodgumbo)

local ceviche =
{
    name = "ceviche",
		test = function(cooker, names, tags) return tags.fish and tags.fish >= 2 and tags.frozen end,
		priority = 20,
		weight = 1,
		foodtype = "MEAT",
		health = 20,
		hunger = 75/3,
		perishtime = 10*480,
		sanity = 5,
		temperature = -40,
		temperatureduration = 10,
		cooktime = 0.5,
}
AddCookerRecipe("cookpot",ceviche)
AddCookerRecipe("portablecookpot",ceviche)

local freshfruitcrepes =
{
    name = "freshfruitcrepes",
	test = function(cooker, names, tags) return tags.fruit and tags.fruit >= 1.5 and names.butter and names.honey end,
	priority = 30,
	weight = 1,
	foodtype = "VEGGIE",
	health = TUNING.HEALING_HUGE,
	hunger = TUNING.CALORIES_SUPERHUGE,
	perishtime = TUNING.PERISH_MED,
	sanity = TUNING.SANITY_MED,
	cooktime = 2,	
}
AddCookerRecipe("portablecookpot",freshfruitcrepes)




local monstertartare =
	{
	name = "monstertartare",
	test = function(cooker, names, tags) return tags.monster and tags.monster >= 2 and tags.egg and tags.veggie end,
	priority = 30,
	   weight = 1,
	foodtype = "MEAT",
	health = TUNING.HEALING_SMALL,
	hunger = TUNING.CALORIES_LARGE,
	perishtime = TUNING.PERISH_MED,
	sanity = TUNING.SANITY_TINY,
	cooktime = 2,
}
AddCookerRecipe("portablecookpot",monstertartare)



]]
local musselbouillabaise = {
    name = "musselbouillabaise",
    test = function(cooker, names, tags)
        return names.mussel and names.mussel == 2 and tags.veggie and tags.veggie >= 2
    end,
    priority = 30,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_LARGE,
    perishtime = TUNING.PERISH_MED,
    sanity = TUNING.SANITY_MED,
    cooktime = 2,
    tags = {"masterfood"},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("portablecookpot", musselbouillabaise)

local sweetpotatosouffle = {
    name = "sweetpotatosouffle",
    test = function(cooker, names, tags)
        return names.sweet_potato and names.sweet_potato == 2 and tags.egg and tags.egg >= 2
    end,
    priority = 30,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_LARGE,
    perishtime = TUNING.PERISH_MED,
    sanity = TUNING.SANITY_MED,
    cooktime = 2,
    tags = {"masterfood"},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("portablecookpot", sweetpotatosouffle)

local sharkfinsoup = {
    name = "sharkfinsoup",
    test = function(cooker, names, tags)
        return names.shark_fin
    end,
    priority = 20,
    weight = 1,
    foodtype = "MEAT",
    health = 40,
    hunger = 75 / 6,
    perishtime = 10 * 480,
    sanity = -10,
    naughtiness = 10,
    cooktime = 1,
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", sharkfinsoup)
AddCookerRecipe("portablecookpot", sharkfinsoup)
AddCookerRecipe("xiuyuan_cookpot", sharkfinsoup)

local lobsterdinner = {
    name = "lobsterdinner",
    test = function(cooker, names, tags)
        return (names.lobster_dead or names.wobster_sheller_land or names.lobster_dead_cooked or names.lobster_land) and
                   names.butter and (tags.meat == 1.0) and (tags.fish == 1.0) and not tags.frozen
    end,
    priority = 25,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_HUGE,
    hunger = TUNING.CALORIES_LARGE,
    perishtime = TUNING.PERISH_SLOW,
    sanity = TUNING.SANITY_HUGE,
    cooktime = 1,
    overridebuild = "cook_pot_food3",
    potlevel = "high",
    floater = {"med", 0.05, {0.65, 0.6, 0.65}},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", lobsterdinner)
AddCookerRecipe("portablecookpot", lobsterdinner)
AddCookerRecipe("xiuyuan_cookpot", lobsterdinner)

local lobsterbisque = {
    name = "lobsterbisque",
    test = function(cooker, names, tags)
        return (names.lobster_dead or names.lobster_dead_cooked or names.lobster_land or names.wobster_sheller_land) and
                   tags.frozen
    end,
    priority = 30,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_HUGE,
    hunger = TUNING.CALORIES_MED,
    perishtime = TUNING.PERISH_MED,
    sanity = TUNING.SANITY_SMALL,
    cooktime = 0.5,
    overridebuild = "cook_pot_food3",
    potlevel = "high",
    floater = {"med", 0.05, {0.65, 0.6, 0.65}},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", lobsterbisque)
AddCookerRecipe("portablecookpot", lobsterbisque)
AddCookerRecipe("xiuyuan_cookpot", lobsterdinner)

local jellyopop = {
    name = "jellyopop",
    test = function(cooker, names, tags)
        return tags.jellyfish and tags.frozen and tags.inedible
    end,
    priority = 20,
    weight = 1,
    foodtype = "MEAT",
    health = 20,
    hunger = 75 / 6,
    perishtime = 3 * 480,
    sanity = 0,
    temperature = -40,
    temperatureduration = 10,
    cooktime = 0.5,
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", jellyopop)
AddCookerRecipe("portablecookpot", jellyopop)
AddCookerRecipe("xiuyuan_cookpot", jellyopop)

local californiaroll = {
    name = "californiaroll",
    test = function(cooker, names, tags)
        return ((names.kelp or 0) + (names.kelp_cooked or 0) + (names.kelp_dried or 0) + (names.seaweed or 0) +
                   (names.kelp_dried or 0)) == 2 and (tags.fish and tags.fish >= 1)
    end,
    priority = 20,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_LARGE,
    perishtime = TUNING.PERISH_MED,
    sanity = TUNING.SANITY_SMALL,
    cooktime = .5,
    overridebuild = "cook_pot_food2",
    potlevel = "high",
    floater = {"med", 0.05, {0.65, 0.6, 0.65}},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", californiaroll)
AddCookerRecipe("portablecookpot", californiaroll)
AddCookerRecipe("xiuyuan_cookpot", californiaroll)

local bisque = {
    name = "bisque",
    test = function(cooker, names, tags)
        return names.limpets and names.limpets == 3 and tags.frozen
    end,
    priority = 30,
    weight = 1,
    foodtype = "MEAT",
    health = 60,
    hunger = 75 / 4,
    perishtime = 10 * 480,
    sanity = 5,
    cooktime = 1,
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", bisque)
AddCookerRecipe("portablecookpot", bisque)
AddCookerRecipe("xiuyuan_cookpot", bisque)

local bananapop = {
    name = "bananapop",
    test = function(cooker, names, tags)
        return (names.cave_banana or names.cave_banana_cooked) and tags.frozen and (tags.inedible or names.twigs) and
                   not tags.meat and not tags.fish and (tags.inedible and tags.inedible <= 2)
    end,
    priority = 20,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_SMALL,
    perishtime = TUNING.PERISH_SUPERFAST,
    sanity = TUNING.SANITY_LARGE,
    temperature = TUNING.COLD_FOOD_BONUS_TEMP,
    temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
    cooktime = 0.5,
    potlevel = "low",
    floater = {nil, 0.05, 0.95},
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", bananapop)
AddCookerRecipe("portablecookpot", bananapop)
AddCookerRecipe("xiuyuan_cookpot", bananapop)

local caviar = {
    name = "caviar",
    test = function(cooker, names, tags)
        return (names.roe or names.roe_cooked == 3) and tags.veggie
    end,
    priority = 20,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_SMAL,
    hunger = TUNING.CALORIES_SMALL,
    perishtime = TUNING.PERISH_MED,
    sanity = TUNING.SANITY_LARGE,
    cooktime = 2,
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", caviar)
AddCookerRecipe("portablecookpot", caviar)
AddCookerRecipe("xiuyuan_cookpot", caviar)

local tropicalbouillabaisse = {
    name = "tropicalbouillabaisse",
    test = function(cooker, names, tags)
        return (names.fish3 or names.fish3_cooked) and (names.fish4 or names.fish4_cooked) and
                   (names.fish5 or names.fish5_cooked) and tags.veggie
    end,
    priority = 35,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_LARGE,
    perishtime = TUNING.PERISH_MED,
    sanity = TUNING.SANITY_MED,
    cooktime = 2,
    cookbook_atlas = "images/inventoryimages/volcanoinventory.xml"
}
AddCookerRecipe("cookpot", tropicalbouillabaisse)
AddCookerRecipe("portablecookpot", tropicalbouillabaisse)
AddCookerRecipe("xiuyuan_cookpot", tropicalbouillabaisse)

local spicyvegstinger = {
    name = "spicyvegstinger",
    test = function(cooker, names, tags)
        return (names.asparagus or names.asparagus_cooked or names.radish or names.radish_cooked) and tags.veggie and
                   tags.veggie > 2 and tags.frozen and not tags.meat
    end,
    priority = 15,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_SMALL,
    hunger = TUNING.CALORIES_MED,
    perishtime = TUNING.PERISH_SLOW,
    sanity = TUNING.SANITY_LARGE,
    cooktime = 0.5
}
AddCookerRecipe("cookpot", spicyvegstinger)
AddCookerRecipe("portablecookpot", spicyvegstinger)
AddCookerRecipe("xiuyuan_cookpot", spicyvegstinger)

local feijoada = {
    name = "feijoada",
    test = function(cooker, names, tags)
        return tags.meat and (names.jellybug == 3) or (names.jellybug_cooked == 3) or
                   (names.jellybug and names.jellybug_cooked and names.jellybug + names.jellybug_cooked == 3)
    end,
    priority = 30,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_HUGE,
    perishtime = TUNING.PERISH_FASTISH,
    sanity = TUNING.SANITY_MED,
    cooktime = 3.5,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", feijoada)
AddCookerRecipe("portablecookpot", feijoada)
AddCookerRecipe("xiuyuan_cookpot", feijoada)

local steamedhamsandwich = {
    name = "steamedhamsandwich",
    test = function(cooker, names, tags)
        return (names.meat or names.meat_cooked) and (tags.veggie and tags.veggie >= 2) and names.foliage
    end,
    priority = 5,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_LARGE,
    hunger = TUNING.CALORIES_LARGE,
    perishtime = TUNING.PERISH_FAST,
    sanity = TUNING.SANITY_MED,
    cooktime = 2,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", steamedhamsandwich)
AddCookerRecipe("portablecookpot", steamedhamsandwich)
AddCookerRecipe("xiuyuan_cookpot", steamedhamsandwich)

local hardshell_tacos = {
    name = "hardshell_tacos",
    test = function(cooker, names, tags)
        return (names.weevole_carapace == 2) and tags.veggie
    end,
    priority = 1,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_LARGE,
    perishtime = TUNING.PERISH_SLOW,
    sanity = TUNING.SANITY_TINY,
    cooktime = 1,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", hardshell_tacos)
AddCookerRecipe("portablecookpot", hardshell_tacos)
AddCookerRecipe("xiuyuan_cookpot", hardshell_tacos)

local gummy_cake = {
    name = "gummy_cake",
    test = function(cooker, names, tags)
        return (names.slugbug or names.slugbug_cooked) and tags.sweetener
    end,
    priority = 1,
    weight = 1,
    foodtype = "MEAT",
    health = -TUNING.HEALING_SMALL,
    hunger = TUNING.CALORIES_SUPERHUGE,
    perishtime = TUNING.PERISH_PRESERVED,
    sanity = -TUNING.SANITY_TINY,
    cooktime = 2,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", gummy_cake)
AddCookerRecipe("portablecookpot", gummy_cake)
AddCookerRecipe("xiuyuan_cookpot", gummy_cake)

local tea = {
    name = "tea",
    test = function(cooker, names, tags)
        return tags.filter and tags.filter >= 2 and tags.sweetener and not tags.meat and not tags.veggie and
                   not tags.inedible
    end,
    priority = 25,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_SMALL,
    hunger = TUNING.CALORIES_SMALL,
    perishtime = TUNING.PERISH_ONE_DAY,
    sanity = TUNING.SANITY_LARGE,
    cooktime = 0.5,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", tea)
AddCookerRecipe("portablecookpot", tea)
AddCookerRecipe("xiuyuan_cookpot", tea)

local icedtea = {
    name = "icedtea",
    test = function(cooker, names, tags)
        return tags.filter and tags.filter >= 2 and tags.sweetener and tags.frozen
    end,
    priority = 30,
    weight = 1,
    foodtype = "VEGGIE",
    health = TUNING.HEALING_SMALL,
    hunger = TUNING.CALORIES_SMALL,
    perishtime = TUNING.PERISH_FAST,
    sanity = TUNING.SANITY_LARGE,
    cooktime = 0.5,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", icedtea)
AddCookerRecipe("portablecookpot", icedtea)
AddCookerRecipe("xiuyuan_cookpot", icedtea)

local snakebonesoup = {
    name = "snakebonesoup",
    test = function(cooker, names, tags)
        return tags.bone and tags.bone >= 2 and tags.meat and tags.meat >= 2
    end,
    priority = 20,
    weight = 1,
    foodtype = "MEAT",
    health = TUNING.HEALING_LARGE,
    hunger = TUNING.CALORIES_MED,
    perishtime = TUNING.PERISH_MED,
    sanity = TUNING.SANITY_SMALL,
    cooktime = 1,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", snakebonesoup)
AddCookerRecipe("portablecookpot", snakebonesoup)
AddCookerRecipe("xiuyuan_cookpot", snakebonesoup)

local nettlelosange = {
    name = "nettlelosange",
    test = function(cooker, names, tags)
        return tags.antihistamine and tags.antihistamine >= 3
    end,
    priority = 0,
    weight = 1,
    health = TUNING.HEALING_MED,
    hunger = TUNING.CALORIES_MED,
    perishtime = TUNING.PERISH_FAST,
    sanity = TUNING.SANITY_TINY,
    antihistamine = 720,
    cooktime = .5,
    cookbook_atlas = "images/inventoryimages/hamletinventory.xml"
}
AddCookerRecipe("cookpot", nettlelosange)
AddCookerRecipe("portablecookpot", nettlelosange)
AddCookerRecipe("xiuyuan_cookpot", nettlelosange)

----------------------posonables---------------------
modimport("scripts/postinit_poisonables")

local function AddBigFooter(inst)
    if inst.ismastersim then
        if not inst.components.bigfooter then
            inst:AddComponent("bigfooter")
        end

        if bell_statue then
            local statueglommer_fn = GLOBAL.Prefabs["statueglommer"].fn
            local OnInit, OnInit_index = DX_GetUpvalue(statueglommer_fn, "OnInit")
            local OnWorked, OnWorked_index = DX_GetUpvalue(statueglommer_fn, "OnWorked")
            local OnLoadWorked, OnLoadWorked_index = DX_GetUpvalue(statueglommer_fn, "OnLoadWorked")
            local OnIsFullmoon, OnIsFullmoon_index = DX_GetUpvalue(OnInit, "OnIsFullmoon")

            local function PlayerLearnsBell(worker)
                worker.sg:GoToState("learn_bell")
            end
            local function TeachBellToWorker(inst, data)
                local worker = data and data.worker
                local worker_builder = worker and worker.components.builder
                if worker_builder and not table.contains(worker_builder.recipes, "bell") then
                    worker:DoTaskInTime(1 + 2 * math.random(), PlayerLearnsBell)
                end
            end

            local old_OnIsFullmoon = OnIsFullmoon
            local new_OnIsFullmoon = function(inst, isfullmoon)
                if isfullmoon and inst.components.workable == nil and inst.components.lootdropper == nil then
                    inst.SoundEmitter:PlaySound("dontstarve/sanity/shadowrock_down")
                    inst.AnimState:PlayAnimation("full")
                    inst:AddComponent("workable")
                    inst.components.workable:SetWorkAction(ACTIONS.MINE)
                    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
                    inst.components.workable:SetOnWorkCallback(OnWorked)
                    inst.components.workable.savestate = true
                    inst.components.workable:SetOnLoadFn(OnLoadWorked)
                    inst:AddComponent("lootdropper")
                    inst.components.lootdropper:SetChanceLootTable("statueglommer")

                    local px, py, pz = inst.Transform:GetWorldPosition()
                    local fx1 = SpawnPrefab("sanity_lower")
                    local fx2 = SpawnPrefab("collapse_big")
                    fx1.Transform:SetPosition(px, py, pz)
                    fx2.Transform:SetPosition(px, py, pz)
                end
                if inst.components.workable and not inst.bell_learning_enabled then
                    inst.bell_learning_enabled = true
                    inst:ListenForEvent("workfinished", TeachBellToWorker)
                end
                return old_OnIsFullmoon(inst, isfullmoon)
            end

            DX_SetUpvalue(OnInit, OnIsFullmoon_index, new_OnIsFullmoon)
        end
    end
end

AddPrefabPostInit("world", AddBigFooter)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddPrefabPostInit("forest", function(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("parrotspawner")
        inst:AddComponent("economy")
        inst:AddComponent("shadowmanager")
        inst:AddComponent("contador")

        if TUNING.tropical.sealnado then
            inst:AddComponent("twisterspawner")
        end

        if GetModConfigData("kindofworld") == 5 and TUNING.tropical.hamletclouds then
            inst:AddComponent("cloudpuffmanager")
        end

        if GetModConfigData("kindofworld") == 5 or GetModConfigData("Hamlet") ~= 5 then
            inst:AddComponent("roottrunkinventory")
        end

        if GetModConfigData("kindofworld") ~= 10 and
            (GetModConfigData("kindofworld") == 5 or GetModConfigData("Hamlet") ~= 5 and GetModConfigData("pigruins") ~=
                0 and GetModConfigData("aporkalypse") == true) then
            inst:AddComponent("aporkalypse")
        end

        if GetModConfigData("kindofworld") ~= 10 and GetModConfigData("Hamlet") ~= 5 then
            inst:AddComponent("tropicalgroundspawner")
        end
        if GetModConfigData("kindofworld") == 15 or GetModConfigData("kindofworld") == 10 or
            GetModConfigData("kindofworld") == 20 then
            if GetModConfigData("aquaticcreatures") then
                inst:AddComponent("tropicalspawner")
                inst:AddComponent("whalehunter")
                inst:AddComponent("rainbowjellymigration")
            end
        end
        if GetModConfigData("kindofworld") == 5 then
            inst:AddComponent("shadowmanager")
            inst:AddComponent("rocmanager")
        end

        if GetModConfigData("kindofworld") ~= 10 then
            inst:AddComponent("quaker_interior")
        end

        -- if TUNING.tropical.springflood or TUNING.tropical.kindofworld == 10 then	inst:AddComponent("floodspawner") end				

    end
end)

AddPrefabPostInit("world", AddBigFooter)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddPrefabPostInit("cave", function(inst)
    if GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("roottrunkinventory")
        inst:AddComponent("quaker_interior")
        inst:AddComponent("economy")
        inst:AddComponent("contador")
    end
end)

-----------------------------------------------------------------------especiais para agua--------------------------------

----------------------------------------------------Thanks EvenMr for this code------------SLOT EXTRA PARA BARCO-----------------------------------------------------------------------------------------------------------------------------

GLOBAL.EQUIPSLOTS.BARCO = "barco"
GLOBAL.FUELTYPE.TAR = "TAR"
GLOBAL.FUELTYPE.REPARODEBARCO = "REPARODEBARCO"
GLOBAL.FUELTYPE.LIVINGARTIFACT = "LIVINGARTIFACT"
GLOBAL.MATERIALS.SANDBAG = "sandbag"

GLOBAL.TOOLACTIONS["HACK"] = true
GLOBAL.TOOLACTIONS["SHEAR"] = true
GLOBAL.TOOLACTIONS["PAN"] = true
GLOBAL.TOOLACTIONS["INVESTIGATEGLASS"] = true
GLOBAL.FUELTYPE.CORK = "CORK"

GLOBAL.MATERIALS.LIMESTONE = "limestone"
GLOBAL.MATERIALS.ENFORCEDLIMESTONE = "enforcedlimestone"

--[[
AddClassPostConstruct("widgets/inventorybar", function(self)
    
	local OldRefresh = self.Refresh
    local OldRebuild = self.Rebuild

    function self:ScaleInv()
		slot_num = #self.equipslotinfo
		if not (TheInput:ControllerAttached() or GLOBAL.GetGameModeProperty("no_avatar_popup")) then
			slot_num = slot_num + 1 
		end
		local inv_scale = 0.98 + 0.06 * slot_num
		self.bg:SetScale(inv_scale,1,1)
		self.bgcover:SetScale(inv_scale,1,1)
    end

    function self:Refresh()
        self:ScaleInv()
        OldRefresh(self)
    end

    function self:Rebuild()
        self:ScaleInv()
        OldRebuild(self)
    end
	
end)
]]

AddClassPostConstruct("widgets/crafttabs", function(self)

    local numtabs = 0

    for i, v in ipairs(self.tabs.tabs) do
        if not v.collapsed then
            numtabs = numtabs + 1
        end
    end

    if numtabs > 11 then

        self.tabs.spacing = 67

        local scalar = self.tabs.spacing * (1 - numtabs) * .5
        local offset = self.tabs.offset * scalar

        for i, v in ipairs(self.tabs.tabs) do
            if i > 1 and not v.collapsed then
                offset = offset + self.tabs.offset * self.tabs.spacing
            end
            v:SetPosition(offset)
            self.tabs.base_pos[v] = Vector3(offset:Get())
        end

        local scale = 67 * numtabs / 750.0
        self.bg:SetScale(1, scale, 1)
        self.bg_cover:SetScale(1, scale, 1)

    end

end)
-----------------------------Thanks EvenMr for this code --------TEXTURA IMPASSABLE------------------------------------------

local function getval(fn, path)
    local val = fn
    for entry in path:gmatch("[^%.]+") do
        local i = 1
        while true do
            local name, value = GLOBAL.debug.getupvalue(val, i)
            if name == entry then
                val = value
                break
            elseif name == nil then
                return
            end
            i = i + 1
        end
    end
    return val
end

local function setval(fn, path, new)
    local val = fn
    local prev = nil
    local i
    for entry in path:gmatch("[^%.]+") do
        i = 1
        prev = val
        while true do
            local name, value = GLOBAL.debug.getupvalue(val, i)
            if name == entry then
                val = value
                break
            elseif name == nil then
                return
            end
            i = i + 1
        end
    end
    GLOBAL.debug.setupvalue(prev, i, new)
end

local GROUND_OCEAN_COLOR = -- Color for the main island ground tiles 
{
    primary_color = {0, 0, 0, 25},
    secondary_color = {0, 20, 33, 0},
    secondary_color_dusk = {0, 20, 33, 80},
    minimap_color = {46, 32, 18, 64}
}

local COASTAL_OCEAN_COLOR = {
    primary_color = {220, 255, 255, 28},
    secondary_color = {25, 123, 167, 100},
    secondary_color_dusk = {10, 120, 125, 120},
    minimap_color = {23, 51, 62, 102}
}

local COASTAL_OCEAN_COLOR2 = {
    primary_color = {220, 255, 255, 255},
    secondary_color = {25, 123, 167, 100},
    secondary_color_dusk = {10, 120, 125, 120},
    minimap_color = {23, 51, 62, 102}
}

local hackpath = "OnFilesLoaded.OnUpdatePurchaseStateComplete.DoResetAction.DoGenerateWorld.DoInitGame"
local OldLoad = GLOBAL.Profile.Load
function GLOBAL.Profile:Load(fn)
    local initfn = getval(fn, hackpath)
    setval(fn, hackpath, function(savedata, profile)
        GLOBAL.global("currentworld")
        GLOBAL.currentworld = savedata.map.prefab
        if savedata.map.prefab == "forest" then
            local tbl = getval(initfn, "GroundTiles")
            ---------------BEGIN----------------
            --[[modify here to get what you want]]
            -- GROUND_PROPERTIES -> tbl.ground
            -- WALL_PROPERTIES -> tbl.wall
            -- TURF_PROPERTIES -> tbl.turf
            -- GROUND_CREEP_PROPERTIES -> tbl.creep
            -- underground_layers -> tbl.underground
            -- Remember to load the assets in modmain.lua

            GLOBAL.table.insert(tbl.ground, 20, {GROUND.QUAGMIRE_GATEWAY, {
                name = "grass3",
                noise_texture = "levels/textures/quagmire_gateway_noise.tex",
                runsound = "dontstarve/movement/run_woods",
                walksound = "dontstarve/movement/walk_woods",
                snowsound = "dontstarve/movement/run_snow",
                mudsound = "dontstarve/movement/run_mud",
                flashpoint_modifier = 0,
                colors = GROUND_OCEAN_COLOR
            }})

            GLOBAL.table.insert(tbl.ground, 28, {GROUND.QUAGMIRE_CITYSTONE, {
                name = "cave",
                noise_texture = "levels/textures/quagmire_citystone_noise.tex",
                runsound = "dontstarve/movement/run_dirt",
                walksound = "dontstarve/movement/walk_dirt",
                snowsound = "dontstarve/movement/run_ice",
                mudsound = "dontstarve/movement/run_mud",
                flashpoint_modifier = 0,
                colors = GROUND_OCEAN_COLOR
            }})

            GLOBAL.table.insert(tbl.ground, 30, {GROUND.QUAGMIRE_PARKFIELD, {
                name = "deciduous",
                noise_texture = "levels/textures/quagmire_parkfield_noise.tex",
                runsound = "dontstarve/movement/run_carpet",
                walksound = "dontstarve/movement/walk_carpet",
                snowsound = "dontstarve/movement/run_snow",
                mudsound = "dontstarve/movement/run_mud",
                flashpoint_modifier = 0,
                colors = GROUND_OCEAN_COLOR
            }})

            GLOBAL.table.insert(tbl.ground, 28, {GROUND.QUAGMIRE_PARKSTONE, {
                name = "cave",
                noise_texture = "levels/textures/quagmire_parkstone_noise.tex",
                runsound = "dontstarve/movement/run_dirt",
                walksound = "dontstarve/movement/walk_dirt",
                snowsound = "dontstarve/movement/run_ice",
                mudsound = "dontstarve/movement/run_mud",
                flashpoint_modifier = 0,
                colors = GROUND_OCEAN_COLOR
            }})

            GLOBAL.table.insert(tbl.ground, 30, {GROUND.QUAGMIRE_SOIL, {
                name = "carpet",
                noise_texture = "levels/textures/quagmire_soil_noise.tex",
                runsound = "dontstarve/movement/run_mud",
                walksound = "dontstarve/movement/walk_mud",
                snowsound = "dontstarve/movement/run_snow",
                mudsound = "dontstarve/movement/run_mud",
                flashpoint_modifier = 0,
                colors = GROUND_OCEAN_COLOR
            }})

            GLOBAL.table.insert(tbl.ground, 25, {GROUND.QUAGMIRE_PEATFOREST, {
                name = "grass2",
                noise_texture = "levels/textures/quagmire_peatforest_noise.tex",
                runsound = "dontstarve/movement/run_marsh",
                walksound = "dontstarve/movement/walk_marsh",
                snowsound = "dontstarve/movement/run_ice",
                mudsound = "dontstarve/movement/run_mud",
                flashpoint_modifier = 0,
                colors = GROUND_OCEAN_COLOR
            }})

            --[[	
			GLOBAL.table.insert(tbl.ground, 10, {GROUND.OCEAN_COASTAL,   { 
			name = "water_mangrove",     
			noise_texture = "levels/textures/noise_water_mangrove.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			ocean_depth = "SHALLOW",
			colors=COASTAL_OCEAN_COLOR2,
			wavetint = {0.8,   0.9,    1},	
			}})		
	
			GLOBAL.table.insert(tbl.ground, 10, {GROUND.OCEAN_COASTAL_SHORE,   { 
			name = "water_mangrove",     
			noise_texture = "levels/textures/noise_water_mangrove.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			ocean_depth = "SHALLOW",
			colors=COASTAL_OCEAN_COLOR,
			wavetint = {0.8,   0.9,    1},	
			}})					
			
			GLOBAL.table.insert(tbl.ground, 10, {GROUND.OCEAN_SWELL,   { 
			name = "water_mangrove",     
			noise_texture = "levels/textures/noise_water_mangrove.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			ocean_depth = "BASIC",
			colors=COASTAL_OCEAN_COLOR,
			wavetint = {0.65,  0.84,   0.94},	
			}})	

			GLOBAL.table.insert(tbl.ground, 10, {GROUND.OCEAN_BRINEPOOL,   { 
			name = "water_mangrove",     
			noise_texture = "levels/textures/noise_water_mangrove.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			ocean_depth = "SHALLOW",
			colors=COASTAL_OCEAN_COLOR,
			wavetint = {0.65,  0.92,   0.94},	
			}})	
				
			GLOBAL.table.insert(tbl.ground, 10, {GROUND.OCEAN_BRINEPOOL_SHORE,   { 
			name = "water_mangrove",     
			noise_texture = "levels/textures/noise_water_mangrove.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			ocean_depth = "SHALLOW",
			colors=COASTAL_OCEAN_COLOR,
			wavetint = {0.65,  0.92,   0.94},	
			}})	


			GLOBAL.table.insert(tbl.ground, 10, {GROUND.OCEAN_ROUGH	,   { 
			name = "water_mangrove",     
			noise_texture = "levels/textures/noise_water_mangrove.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			ocean_depth = "DEEP",
			colors=COASTAL_OCEAN_COLOR,
			wavetint = {0.65,  0.84,   0.94},	
			}})		


			GLOBAL.table.insert(tbl.ground, 10, {GROUND.OCEAN_HAZARDOUS	,   { 
			name = "water_mangrove",     
			noise_texture = "levels/textures/noise_water_mangrove.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			ocean_depth = "VERY_DEEP",
			colors=COASTAL_OCEAN_COLOR,
			wavetint = {0.40,  0.50,   0.62},	
			}})				
]]
            --[[			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.MAGMAFIELD,   { 
			name = "magmafield",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})			
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.JUNGLE,   { 
			name = "jungle",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.ASH,   { 
			name = "ash",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})					
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.VOLCANO,   { 
			name = "volcano",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				
			
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.TIDALMARSH,   { 
			name = "tidalmarsh",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.MEADOW,   { 
			name = "meadow",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				
			

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.SNAKESKINFLOOR,   { 
			name = "snakeskinfloor",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.PLAINS,   { 
			name = "plains",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.DEEPRAINFOREST,   { 
			name = "deeprainforest",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				
	
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.RAINFOREST,   { 
			name = "rainforest",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.PAINTED,   { 
			name = "painted",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.GASJUNGLE,   { 
			name = "gasjungle",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.FIELDS,   { 
			name = "fields",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.CHECKEREDLAWN,   { 
			name = "checkeredlawn",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})		

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.SUBURB,   { 
			name = "suburb",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.BEARDRUG,   { 
			name = "beardrug",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				
			
			GLOBAL.table.insert(tbl.ground, 25, {GROUND.FOUNDATION,   { 
			name = "foundation",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.COBBLEROAD,   { 
			name = "cobbleroad",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.ANTFLOOR,   { 
			name = "antfloor",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})	

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.BATFLOOR,   { 
			name = "batfloor",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})				

			GLOBAL.table.insert(tbl.ground, 25, {GROUND.PIGRUINS,   { 
			name = "pigruins",     
			noise_texture = "levels/textures/quagmire_peatforest_noise.tex",        
			runsound="dontstarve/movement/run_marsh",       
			walksound="dontstarve/movement/walk_marsh",     
			snowsound="dontstarve/movement/run_ice",    
			mudsound = "dontstarve/movement/run_mud", 
			flashpoint_modifier = 0,
			colors=GROUND_OCEAN_COLOR
			}})					
]]

            if TUNING.tropical.hamletclouds then
                if GetModConfigData("kindofworld") == 5 then
                    GLOBAL.table.insert(tbl.ground, 10, {GROUND.IMPASSABLE, {
                        name = "water_mangrove",
                        noise_texture = "levels/textures/outro.tex",
                        runsound = "dontstarve/movement/run_marsh",
                        walksound = "dontstarve/movement/walk_marsh",
                        snowsound = "dontstarve/movement/run_ice",
                        mudsound = "dontstarve/movement/run_mud",
                        flashpoint_modifier = 0,
                        ocean_depth = "SHALLOW",
                        colors = COASTAL_OCEAN_COLOR2,
                        wavetint = {0.8, 0.9, 1}
                    }})
                end
            end

            --			for k,v in ipairs(tbl.ground) do
            --			if v[1] == GROUND.IMPASSABLE then
            --			v[2].name = "water_mangrove"
            --			end	
            --			end
            --			if v[1] == GROUND.WATER_MEDIUM then
            --			v[2].name = "water_medium"
            --			end	
            --			end						

            -----------------END----------------
            setval(initfn, "GroundTiles", tbl)
        end
        return initfn(savedata, profile)
    end)
    return OldLoad(self, fn)
end

--[[
---------------------------------color cube by EvenMr  --------------------------------------------------------------
local resolvefilepath=GLOBAL.resolvefilepath
if 1 == 2 then --GetModConfigData("colourcube") then
	table.insert( Assets, Asset("IMAGE","images/colour_cubes/pork_cold_bloodmoon_cc.tex") )

	AddComponentPostInit("colourcube", function(self)
		if GLOBAL.currentworld == "forest" then
			for _,v in pairs(GLOBAL.TheWorld.event_listeners["playerdeactivated"][GLOBAL.TheWorld]) do
				if getval(v,"OnOverrideCCTable") then
				print("color")
					setval(v, "OnOverrideCCTable.UpdateAmbientCCTable.SEASON_COLOURCUBES",{
						autumn =
						{
							day = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							dusk = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							night = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							full_moon = "images/colour_cubes/pork_cold_bloodmoon_cc.tex"
						},
						winter =
						{
							day = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							dusk = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							night = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							full_moon = "images/colour_cubes/pork_cold_bloodmoon_cc.tex"
						},
						spring =
						{
							day = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							dusk = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							night = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							full_moon = "images/colour_cubes/pork_cold_bloodmoon_cc.tex"
						},
						summer =
						{
							day = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							dusk = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							night = resolvefilepath("images/colour_cubes/pork_cold_bloodmoon_cc.tex"),
							full_moon = "images/colour_cubes/pork_cold_bloodmoon_cc.tex"
						},
					})
					break
				end
			end
		end
	end)
end
]]
---------------------------------indicador de veneno by EvenMr---------------------------------------------------
AddClassPostConstruct("widgets/healthbadge", function(inst)
    function inst:OnUpdate(dt)
        local down = (self.owner.IsFreezing ~= nil and self.owner:IsFreezing()) or
                         (self.owner.IsOverheating ~= nil and self.owner:IsOverheating()) or
                         (self.owner.replica.hunger ~= nil and self.owner.replica.hunger:IsStarving()) or
                         (self.owner.replica.health ~= nil and self.owner.replica.health:IsTakingFireDamage()) or
                         (self.owner.IsBeaverStarving ~= nil and self.owner:IsBeaverStarving()) or
                         GLOBAL.next(self.corrosives) ~= nil

        local small_down = self.owner.components.poisonable and self.owner.components.poisonable.dmg < 0

        -- Show the up-arrow when we're sleeping (but not in a straw roll: that doesn't heal us)
        local up = not down and
                       ((self.owner.player_classified ~= nil and self.owner.player_classified.issleephealing:value()) or
                           GLOBAL.next(self.hots) ~= nil or
                           (self.owner.replica.inventory ~= nil and self.owner.replica.inventory:EquipHasTag("regen"))) and
                       self.owner.replica.health ~= nil and self.owner.replica.health:IsHurt()

        local anim = (down and "arrow_loop_decrease_most") or ((not up and small_down) and "arrow_loop_decrease") or
                         (not up and "neutral") or (GLOBAL.next(self.hots) ~= nil and "arrow_loop_increase_most") or
                         "arrow_loop_increase"

        if self.arrowdir ~= anim then
            self.arrowdir = anim
            self.sanityarrow:GetAnimState():PlayAnimation(anim, true)
        end
    end
end)

----------------------------Barco Slot Tweak by EvenMr-------------------------------
AddGlobalClassPostConstruct("entityscript", "EntityScript", function(self)
    local tbl = getval(self.CollectActions, "COMPONENT_ACTIONS")
    if not getval(tbl.INVENTORY.equippable, "oldfn") then
        local oldfn = tbl.INVENTORY.equippable
        tbl.INVENTORY.equippable = function(inst, ...)
            if not inst:HasTag("boat") then
                oldfn(inst, ...)
            end
        end
    end
end)

local function preventpick(cmp)
    local oldfn = cmp.TakeActiveItemFromEquipSlot
    function cmp:TakeActiveItemFromEquipSlot(eslot)
        local item = self:GetEquippedItem(eslot)
        if item and item:HasTag("boat") then
            return
        end
        oldfn(self, eslot)
    end
end

AddComponentPostInit("inventory", preventpick)
AddPrefabPostInit("inventory_classified", preventpick)

------------------------------------------------------------
AddComponentPostInit("armor", function(self)

    function self:SetCondition(amount)
        if self.indestructible then
            return
        end

        self.condition = math.min(amount, self.maxcondition)
        self.inst:PushEvent("percentusedchange", {
            percent = self:GetPercent()
        })

        if self.condition <= 0 then
            self.condition = 0
            GLOBAL.ProfileStatsSet("armor_broke_" .. self.inst.prefab, true)
            GLOBAL.ProfileStatsSet("armor", self.inst.prefab)

            if self.onfinished ~= nil then
                self.onfinished()
            end

            if not self.dontremove then
                self.inst:Remove()
            end

        end
    end

end)

-----------------------------Treasure Reveal by EvenMr----------------------------
local function OnRevealTreasureDirty(inst)
    local m = math
    if inst._parent ~= nil and inst._parent.HUD and GLOBAL.TheCamera then
        inst._parent.HUD.controls:ShowMap()
        local map = GLOBAL.TheWorld.minimap.MiniMap
        local ang = GLOBAL.TheCamera:GetHeading()
        local zoom = map:GetZoom()
        local posx, _, posy = inst._parent.Transform:GetWorldPosition()
        posx = m.modf(inst.revealtreasure:value() / 65536) - 16384 - posx
        posy = inst.revealtreasure:value() % 65536 - 16384 - posy
        local x = posx * m.cos(m.rad(90 - ang)) - posy * m.sin(m.rad(90 - ang))
        local y = posx * m.sin(m.rad(90 - ang)) + posy * m.cos(m.rad(90 - ang))
        map:ResetOffset()
        map:Offset(x / zoom, y / zoom)
    end
end

AddPrefabPostInit("player_classified", function(inst)
    inst.revealtreasure = GLOBAL.net_uint(inst.GUID, "messagebottle1.reveal", "revealtreasuredirty")
    inst:ListenForEvent("revealtreasuredirty", OnRevealTreasureDirty)
end)

if GetModConfigData("kindofworld") == 20 then
    AddPrefabPostInit("rocks", function(inst)
        GLOBAL.MakeInventoryFloatable(inst, "small", 0.15)
        if GLOBAL.TheWorld.ismastersim then
            if inst.components.inventoryitem ~= nil then
                inst.components.inventoryitem:SetSinks(false)
            end
        end
    end)
    AddPrefabPostInit("nitre", function(inst)
        GLOBAL.MakeInventoryFloatable(inst, "small", 0.15)
        if GLOBAL.TheWorld.ismastersim then
            if inst.components.inventoryitem ~= nil then
                inst.components.inventoryitem:SetSinks(false)
            end
        end
    end)
    AddPrefabPostInit("flint", function(inst)
        GLOBAL.MakeInventoryFloatable(inst, "small", 0.15)
        if GLOBAL.TheWorld.ismastersim then
            if inst.components.inventoryitem ~= nil then
                inst.components.inventoryitem:SetSinks(false)
            end
        end
    end)
    AddPrefabPostInit("goldnugget", function(inst)
        GLOBAL.MakeInventoryFloatable(inst, "small", 0.15)
        if GLOBAL.TheWorld.ismastersim then
            if inst.components.inventoryitem ~= nil then
                inst.components.inventoryitem:SetSinks(false)
            end
        end
    end)

    AddPrefabPostInit("moonrocknugget", function(inst)
        GLOBAL.MakeInventoryFloatable(inst, "small", 0.15)
        if GLOBAL.TheWorld.ismastersim then
            if inst.components.inventoryitem ~= nil then
                inst.components.inventoryitem:SetSinks(false)
            end
        end
    end)

    AddPrefabPostInit("moonglass", function(inst)
        GLOBAL.MakeInventoryFloatable(inst, "small", 0.15)
        if GLOBAL.TheWorld.ismastersim then
            if inst.components.inventoryitem ~= nil then
                inst.components.inventoryitem:SetSinks(false)
            end
        end
    end)

    AddPrefabPostInit("moonrockseed", function(inst)
        GLOBAL.MakeInventoryFloatable(inst, "small", 0.15)
        if GLOBAL.TheWorld.ismastersim then
            if inst.components.inventoryitem ~= nil then
                inst.components.inventoryitem:SetSinks(false)
            end
        end
    end)

end

-------------------------------Boat Speed by EvenMr----------------------------
local speed_bonus = {
    raft_old = 5 / 6,
    lograft_old = 4 / 6,
    rowboat = 6 / 6,
    armouredboat = 6 / 6,
    cargoboat = 5 / 6,
    encrustedboat = 4 / 6,
    surfboard = 6.5 / 6,
    woodlegsboat = 6 / 6,
    corkboat = 4 / 6
    -- more entries here
}

local sail_bonus = {
    sail = 1.2,
    clothsail = 1.3,
    snakeskinsail = 1.25,
    feathersail = 1.4,
    ironwind = 1.5,
    woodlegssail = 1.01,
    trawlnet = 0.8,
    malbatrossail = 2
    -- more entries here
}

local heavybonus = 0.35
local driftspeed = 2
--[[
local function getspeedbonus(inst)
local namao = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
local remo = false
local sailbonus
if namao and namao.prefab == "oar_driftwood" or namao and namao.prefab == "oar" then
remo = true
end

    local val = 1
    if inst.replica.inventory then
        local item = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
        if item then
		    local bonus = speed_bonus[item.prefab] or 1
            if item.replica.container then
                local sail = item.replica.container:GetItemInSlot(1)
                sailbonus = sail and sail_bonus[sail.prefab] or 1
                val = bonus * sailbonus
            else
                val = bonus		
            end
        end
		
		print(sailbonus)
		print(remo)
		
		if sailbonus <= 1 and remo == false and item.prefab ~= "surfboard" then
		val = 0.1
		end		
		
		
        if inst.replica.inventory:IsHeavyLifting() then
            local item = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
            if item.replica.container and item.replica.container:GetItemInSlot(1) and
                item.replica.container:GetItemInSlot(1):HasTag("sail") then
                return val * 0.2
            else
                return 0
            end
        end
    end
    return val
end
]]
local function getspeedbonus(inst)
    local equipamentos = 1

    if 1 == 1 then
        local body = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        local head = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        local hands = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if head and head.prefab == "aerodynamichat" then
            equipamentos = equipamentos + 0.25
        end
        if head and head.prefab == "icehat" then
            equipamentos = equipamentos - 0.10
        end
        if head and head.prefab == "metalplatehat" then
            equipamentos = equipamentos - 0.20
        end
        if hands and hands.prefab == "cane" then
            equipamentos = equipamentos + 0.25
        end
        if hands and hands.prefab == "ruins_bat" then
            equipamentos = equipamentos + 0.10
        end
        if hands and hands.prefab == "walkingstick" then
            equipamentos = equipamentos + 0.30
        end
        if body and body.prefab == "piggyback" then
            equipamentos = equipamentos - 0.20
        end
        if body and body.prefab == "armorlimestone" then
            equipamentos = equipamentos - 0.10
        end
        if body and body.prefab == "yellowamulet" then
            equipamentos = equipamentos + 0.20
        end
        if body and body.prefab == "armor_metalplate" then
            equipamentos = equipamentos - 0.20
        end
    end

    local wind_speed = 1
    local vento = GLOBAL.GetClosestInstWithTag("vento", inst, 10)
    if vento then
        local wind = vento.Transform:GetRotation() + 180
        local windangle = inst.Transform:GetRotation() - wind
        local windproofness = 1.0
        local velocidadedovento = 1.5

        if inst.replica.inventory then
            local corpo = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            local cabeca = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
            if cabeca and cabeca.prefab == "aerodynamichat" then
                windproofness = 0.5
            end
            if corpo and corpo.prefab == "armor_windbreaker" then
                windproofness = 0
            end
        end
        local windfactor = 0.4 * windproofness * velocidadedovento * math.cos(windangle * GLOBAL.DEGREES) + 1.0
        wind_speed = math.max(0.1, windfactor)
    end

    local val = 1 * wind_speed * equipamentos
    if inst.replica.inventory then
        local item = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
        if item then
            local bonus = speed_bonus[item.prefab] or 1
            if item.replica.container then
                local sail = item.replica.container:GetItemInSlot(1)
                local sailbonus = sail and sail_bonus[sail.prefab] or 1
                val = bonus * sailbonus * wind_speed * equipamentos
            else
                val = bonus * wind_speed * equipamentos
            end
        end
        if inst.replica.inventory:IsHeavyLifting() then
            local item = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
            if item.replica.container and item.replica.container:GetItemInSlot(1) and
                item.replica.container:GetItemInSlot(1):HasTag("sail") then
                return val * 0.2
            else
                return 0
            end
        end
    end
    return val
end

AddComponentPostInit("locomotor", function(self)
    local OldGetSpeedMultiplier = self.GetSpeedMultiplier
    function self:GetSpeedMultiplier()
        return (self.inst:HasTag("aquatic") and self.inst:HasTag("player")) and getspeedbonus(self.inst) or
                   OldGetSpeedMultiplier(self)
    end
    local OldUpdate = self.OnUpdate
    function self:OnUpdate(dt)
        OldUpdate(self, dt)
        local math = GLOBAL.math

        if self.inst:HasTag("aquatic") and self.inst:HasTag("player") and self.inst.replica.inventory and
            self.inst.replica.inventory:IsHeavyLifting() and not self.driftangle then
            local item = self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
            if item.replica.container and item.replica.container:GetItemInSlot(1) and
                item.replica.container:GetItemInSlot(1):HasTag("sail") then
                if self.inst.Physics:GetMotorSpeed() > 0 then
                    local desired_speed = self.isrunning and self:RunSpeed() or self.walkspeed
                    local speed_mult = self:GetSpeedMultiplier()
                    if self.dest and self.dest:IsValid() then
                        local destpos_x, destpos_y, destpos_z = self.dest:GetPoint()
                        local mypos_x, mypos_y, mypos_z = self.inst.Transform:GetWorldPosition()
                        local dsq = GLOBAL.distsq(destpos_x, destpos_z, mypos_x, mypos_z)
                        if dsq <= .25 then
                            speed_mult = math.max(.33, math.sqrt(dsq))
                        end
                    end

                    self.inst.Physics:SetMotorVel(desired_speed * speed_mult * heavybonus, 0, 0)
                end
            else
                self.inst.Physics:SetMotorVel(0, 0, 0)
                self:Stop()
            end
        elseif self.driftangle and self.inst:HasTag("player") and self.inst:HasTag("aquatic") then
            local speed_mult = self:GetSpeedMultiplier()
            local desired_speed = self.isrunning and self:RunSpeed() or self.walkspeed
            if self.dest and self.dest:IsValid() then
                local destpos_x, destpos_y, destpos_z = self.dest:GetPoint()
                local mypos_x, mypos_y, mypos_z = self.inst.Transform:GetWorldPosition()
                local dsq = GLOBAL.distsq(destpos_x, destpos_z, mypos_x, mypos_z)
                if dsq <= .25 then
                    speed_mult = math.max(.33, math.sqrt(dsq))
                end
            end
            if not self.dest then
                desired_speed = 0
            end
            local angle = self.inst.Transform:GetRotation()
            local driftx = math.cos(math.rad(-self.driftangle + angle + 180)) * 1.5
            local drifty = math.sin(math.rad(-self.driftangle + angle + 180)) * 1.5

            local extramult = 1

            if self.inst.replica.inventory and self.inst.replica.inventory:IsHeavyLifting() then
                extramult = heavybonus
            end

            self.inst.Physics:SetMotorVel((desired_speed * speed_mult + driftx) * extramult, 0, drifty * extramult)
            if GLOBAL.StopUpdatingComponents[self] == self.inst then
                self:StartUpdatingInternal()
            end
        end
    end

    local OldStop = self.Stop
    function self:Stop(sgparam)
        OldStop(self, sgparam)
        if self.driftangle and self.inst:HasTag("aquatic") and self.inst:HasTag("player") and
            GLOBAL.StopUpdatingComponents[self] == self.inst then
            self:StartUpdatingInternal()
        end
    end
end)
------------------------------------------configura os slots imagem------------------------------------------------------------
local boat_health = {
    cargoboat = 300,
    encrustedboat = 800,
    rowboat = 250,
    armouredboat = 500,
    raft_old = 150,
    lograft_old = 150,
    woodlegsboat = 500,
    surfboard = 100
}

AddClassPostConstruct("widgets/containerwidget", function(self)
    local BoatBadge = require("widgets/boatbadge")
    self.boatbadge = self:AddChild(BoatBadge(self.owner))
    self.boatbadge:SetPosition(0, 45, 0)
    self.boatbadge:Hide()

    local function BoatState(inst, data)
        self.boatbadge:SetPercent(data.percent, boat_health[inst.prefab] or 150)

        if self.boathealth then
            if data.percent > self.boathealth then
                self.boatbadge:PulseGreen()
            elseif data.percent < self.boathealth - 0.015 then
                self.boatbadge:PulseRed()
            end
        end

        self.boathealth = data.percent

        if data.percent <= .25 then
            self.boatbadge:StartWarning()
        else
            self.boatbadge:StopWarning()
        end
    end

    local OldOpen = self.Open
    function self:Open(container, doer)
        OldOpen(self, container, doer)
        local widget = container.replica.container:GetWidget()
        if widget and widget.slotbg and type(widget.slotbg) == "table" and widget.isboat then
            for i, v in ipairs(widget.slotbg) do
                if self.inv[i] then
                    self.inv[i].bgimage:SetTexture(v.atlas, v.texture)
                end
            end
        end
        if widget and widget.isboat then
            self.isboat = true
            self.boatbadge:Show()
            self.inst:ListenForEvent("percentusedchange", BoatState, container)
            if GLOBAL.TheWorld.ismastersim then
                container:PushEvent("percentusedchange", {
                    percent = container.replica.inventoryitem.classified.percentused:value() / 100
                })
            else
                container.replica.inventoryitem:DeserializeUsage()
            end
        end
    end

    local OldClose = self.Close
    function self:Close()
        OldClose(self)
        if self.isboat then
            self.inst:RemoveEventCallback("percentusedchange", BoatState, self.contanier)
        end
    end
end)
---------------------------------------configura os slots--------------------------------------------------------------------
-- local params = getval(containers.widgetsetup, "params")

local function deepval(fn, name, member, depth)
    depth = depth or 20
    local i = 1
    while true do
        local n, v = GLOBAL.debug.getupvalue(fn, i)
        if v == nil then
            return
        elseif n == name and (not member or v[member]) then
            return v
        elseif type(v) == "function" and depth > 0 then
            local temp = deepval(v, name, member, depth - 1)
            if temp then
                return temp
            end
        end
        i = i + 1
    end
end

local params
if containers.smartercrockpot_old_widgetsetup then
    params = deepval(containers.smartercrockpot_old_widgetsetup, "params", "icepack")
else
    params = deepval(containers.widgetsetup, "params", "icepack")
end

local smelter = {
    widget = {
        slotpos = {Vector3(0, -135, 0), Vector3(0, -60, 0), Vector3(0, 15, 0), Vector3(0, 90, 0)},

        animbank = "ui_cookpot_1x4",
        animbuild = "ui_cookpot_1x4",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(80, 80, 0)
        --	isboat = true,
    },
    issidewidget = false,
    type = "cookpot"
}

local corkchest = {
    widget = {
        slotpos = {Vector3(0, -135, 0), Vector3(0, -60, 0), Vector3(0, 15, 0), Vector3(0, 90, 0)},

        animbank = "ui_cookpot_1x4",
        animbuild = "ui_cookpot_1x4",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(80, 80, 0)
        --	isboat = true,
    },
    issidewidget = false,
    type = "cookpot"
}

local thatchpack = {
    widget = {
        slotpos = {Vector3(0, -135, 0), Vector3(0, -60, 0), Vector3(0, 15, 0), Vector3(0, 90, 0)},

        animbank = "ui_cookpot_1x4",
        animbuild = "ui_cookpot_1x4",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(-60, -60, 0)
        --	isboat = true,
    },
    issidewidget = true,
    type = "cookpot"
}

local cargoboatslot = {
    widget = {
        slotpos = {Vector3(-80, 45, 0), Vector3(-155, 45, 0), Vector3(-250, 45, 0), Vector3(-330, 45, 0),
                   Vector3(-410, 45, 0), Vector3(-490, 45, 0), Vector3(-570, 45, 0), Vector3(-650, 45, 0)},

        slotbg = { -- for 1st slot
        {
            atlas = "images/barco.xml",
            texture = "barco.tex"
        }, -- for 2nd
        {
            atlas = "images/barco.xml",
            texture = "luz.tex"
        } -- and so on
        },

        animbank = "boat_hud_cargo",
        animbuild = "boat_hud_cargo",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(440, 80 + GetModConfigData("boatlefthud"), 0),
        isboat = true
    },
    issidewidget = false,
    type = "chest"
}

local rowboatslot = {
    widget = {
        slotpos = {Vector3(-80, 45, 0), Vector3(-155, 45, 0) --    Vector3(65, 45, 0),
        },

        slotbg = { -- for 1st slot
        {
            atlas = "images/barco.xml",
            texture = "barco.tex"
        }, -- for 2nd
        {
            atlas = "images/barco.xml",
            texture = "barco.tex"
        }, {
            atlas = "images/barco.xml",
            texture = "luz.tex"
        } -- and so on
        },

        animbank = "boat_hud_row",
        animbuild = "boat_hud_row",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(440, 80 + GetModConfigData("boatlefthud"), 0),
        isboat = true
    },
    issidewidget = false,
    type = "chest"
}

local pirateslot = {
    widget = {
        slotpos = {Vector3(-80, 45, 0), Vector3(-155, 45, 0), Vector3(-300, 45, 0)},

        slotbg = { -- for 1st slot
        {
            atlas = "images/barco.xml",
            texture = "barco.tex"
        }, -- for 2nd
        {
            atlas = "images/barco.xml",
            texture = "luz.tex"
        } -- and so on
        },

        animbank = "boat_hud_encrusted",
        animbuild = "boat_hud_encrusted",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(440, 80 + GetModConfigData("boatlefthud"), 0),
        isboat = true
    },
    issidewidget = false,
    type = "chest"
}

local encrustedslot = {
    widget = {
        slotpos = {Vector3(-80, 45, 0), Vector3(-155, 45, 0), Vector3(-250, 45, 0), Vector3(-330, 45, 0)},

        slotbg = { -- for 1st slot
        {
            atlas = "images/barco.xml",
            texture = "barco.tex"
        }, -- for 2nd
        {
            atlas = "images/barco.xml",
            texture = "luz.tex"
        } -- and so on
        },

        animbank = "boat_hud_encrusted",
        animbuild = "boat_hud_encrusted",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(440, 80 + GetModConfigData("boatlefthud"), 0),
        isboat = true
    },
    issidewidget = false,
    type = "chest"
}

local raftslot = {
    widget = {
        slotpos = {
            --    Vector3(-80, 45, 0),

        },

        animbank = "boat_hud_raft",
        animbuild = "boat_hud_raft",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(440, 80 + GetModConfigData("boatlefthud"), 0),
        isboat = true
    },
    issidewidget = false,
    type = "chest"
}

local trawlnetdroppedslot = {
    widget = {
        slotpos = {Vector3(0, -75, 0), Vector3(-75, -75, 0), Vector3(75, -75, 0), Vector3(0, 75, 0),
                   Vector3(-75, 75, 0), Vector3(75, 75, 0), Vector3(0, 0, 0), Vector3(-75, 0, 0), Vector3(75, 0, 0)},

        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        bgimage = nil,
        bgatlas = nil,
        pos = Vector3(0, 200, 0)
    },
    issidewidget = false,
    type = "chest"
}

params["cargoboat"] = cargoboatslot
params["encrustedboat"] = encrustedslot
params["rowboat"] = rowboatslot
params["armouredboat"] = rowboatslot
params["raft_old"] = raftslot
params["lograft_old"] = raftslot
params["woodlegsboat"] = pirateslot
params["surfboard"] = raftslot
params["trawlnetdropped"] = trawlnetdroppedslot
params["corkboat"] = rowboatslot
params["smelter"] = smelter
params["corkchest"] = corkchest
params["thatchpack"] = thatchpack

function params.thatchpack.itemtestfn(container, item, slot)
    if slot == 1 then
        return true
    elseif slot == 2 then
        return true
    elseif slot == 3 then
        return true
    elseif slot == 4 then
        return true
    else
        return false
    end
end

function params.corkchest.itemtestfn(container, item, slot)
    if slot == 1 then
        return true
    elseif slot == 2 then
        return true
    elseif slot == 3 then
        return true
    elseif slot == 4 then
        return true
    else
        return false
    end
end

function params.smelter.itemtestfn(container, item, slot)
    if slot == 1 and
        (item:HasTag("iron") or item.prefab == "iron" or item.prefab == "goldnugget" or item.prefab == "gold_dust" or
            item.prefab == "flint" or item.prefab == "nitre" or item.prefab == "dubloon" or item.prefab == "obsidian") then
        return true
    elseif slot == 2 and
        (item:HasTag("iron") or item.prefab == "iron" or item.prefab == "goldnugget" or item.prefab == "gold_dust" or
            item.prefab == "flint" or item.prefab == "nitre" or item.prefab == "dubloon" or item.prefab == "obsidian") then
        return true
    elseif slot == 3 and
        (item:HasTag("iron") or item.prefab == "iron" or item.prefab == "goldnugget" or item.prefab == "gold_dust" or
            item.prefab == "flint" or item.prefab == "nitre" or item.prefab == "dubloon" or item.prefab == "obsidian") then
        return true
    elseif slot == 4 and
        (item:HasTag("iron") or item.prefab == "iron" or item.prefab == "goldnugget" or item.prefab == "gold_dust" or
            item.prefab == "flint" or item.prefab == "nitre" or item.prefab == "dubloon" or item.prefab == "obsidian") then
        return true
    else
        return false
    end
end

function params.cargoboat.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    elseif slot == 3 then
        return true
    elseif slot == 4 then
        return true
    elseif slot == 5 then
        return true
    elseif slot == 6 then
        return true
    elseif slot == 7 then
        return true
    elseif slot == 8 then
        return true
    else
        return false
    end
end

function params.encrustedboat.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    elseif slot == 3 then
        return true
    elseif slot == 4 then
        return true
    else
        return false
    end
end

function params.rowboat.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    else
        return false
    end
end

function params.armouredboat.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    else
        return false
    end
end

function params.raft_old.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    else
        return false
    end
end

function params.raft_old.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    else
        return false
    end
end

function params.lograft_old.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    else
        return false
    end
end

function params.woodlegsboat.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    elseif slot == 3 then
        return true
    else
        return false
    end
end

function params.surfboard.itemtestfn(container, item, slot)
    if slot == 1 and (item:HasTag("sail") or item.prefab == "trawlnet") then
        return true
    elseif slot == 2 and
        (item.prefab == "tarlamp" or item.prefab == "boat_lantern" or item.prefab == "boat_torch" or item.prefab ==
            "quackeringram" or item.prefab == "boatcannon" or item.prefab == "woodlegs_boatcannon") then
        return true
    else
        return false
    end
end

function params.trawlnetdropped.itemtestfn(container, item, slot)
    return true
end
---------------------------------------------------------------------tira a neve----------------------------------------------------------------------------------------
if GetModConfigData("disable_snow_effects") == true then
    AddComponentPostInit("weather", function(self, inst)
        inst:ListenForEvent("weathertick", function(inst, data)
            if data and data.snowlevel then
                local newlevel = data.snowlevel <= 0 and data.snowlevel or 0
                GLOBAL.TheWorld.Map:SetOverlayLerp(newlevel)
            end
        end, GLOBAL.TheWorld)
    end)
end
-------------------------------------------------------------------------
-- AddPlayerPostInit(function(inst)
--	inst.AnimState:AddOverrideBuild("player_portal_shipwrecked")
-- end)
-------------------------lock for woodlegs boat by EvenMr-------------------------
local container_handler = {"PutOneOfActiveItemInSlot", "PutAllOfActiveItemInSlot", "TakeActiveItemFromHalfOfSlot",
                           "TakeActiveItemFromAllOfSlot", "AddOneOfActiveItemToSlot", "AddAllOfActiveItemToSlot",
                           "SwapActiveItemWithSlot", "MoveItemFromAllOfSlot", "MoveItemFromHalfOfSlot"}

local function containerhack(inst)
    local function lock(self, fname)
        local oldfn = self[fname]
        self[fname] = function(self, slot, ...)
            if (self._parent or self.inst).prefab == "woodlegsboat" and slot == 1 then
                return
            else
                oldfn(self, slot, ...)
            end
        end
    end
    for _, v in ipairs(container_handler) do
        lock(inst, v)
    end
end
AddComponentPostInit("container", containerhack)
AddPrefabPostInit("container_classified", containerhack)

-------------------------boat container sizing tweak by EvenMr-------------------------
AddClassPostConstruct("widgets/controls", function(self)
    local Widget = require("widgets/widget")
    self.containerroot_bottom = self:AddChild(Widget(""))
    self.containerroot_bottom:SetHAnchor(GLOBAL.ANCHOR_MIDDLE)
    self.containerroot_bottom:SetVAnchor(GLOBAL.ANCHOR_BOTTOM)
    self.containerroot_bottom:SetScaleMode(GLOBAL.SCALEMODE_PROPORTIONAL)
    self.containerroot_bottom:SetMaxPropUpscale(GLOBAL.MAX_HUD_SCALE)
    self.containerroot_bottom:MoveToBack()
    self.containerroot_bottom = self.containerroot_bottom:AddChild(Widget("contaierroot_bottom"))
    local scale = GLOBAL.TheFrontEnd:GetHUDScale()
    self.containerroot_bottom:SetScale(scale, scale, scale)
    self.containerroot_bottom:Hide()

    local OldSetHUDSize = self.SetHUDSize
    function self:SetHUDSize()
        OldSetHUDSize(self)
        local scale = GLOBAL.TheFrontEnd:GetHUDScale()
        self.containerroot_bottom:SetScale(scale, scale, scale)
    end

    local OldShowCraftingAndInventory = self.ShowCraftingAndInventory
    function self:ShowCraftingAndInventory()
        OldShowCraftingAndInventory(self)
        self.containerroot_bottom:Show()
    end

    local OldHideCraftingAndInventory = self.HideCraftingAndInventory
    function self:HideCraftingAndInventory()
        OldHideCraftingAndInventory(self)
        self.containerroot_bottom:Hide()
    end
end)

AddClassPostConstruct("screens/playerhud", function(self)
    local ContainerWidget = require("widgets/containerwidget")
    local oldopen = self.OpenContainer
    function self:OpenContainer(container, side)
        if container.replica.container and container.replica.container:GetWidget() and
            container.replica.container:GetWidget().isboat then
            local containerwidget = ContainerWidget(self.owner)
            self.controls.containerroot_bottom:AddChild(containerwidget)
            containerwidget:Open(container, self.owner)
            self.controls.containers[container] = containerwidget
        else
            oldopen(self, container, side)
        end
    end
end)

--------------------mapwrapper by EvenMr--------------------------
if GetModConfigData("kindofworld") == 10 then
    AddPlayerPostInit(function(inst)
        inst:AddComponent("mapwrapper")
    end)
end
-----------------------by EvenMr----------------------------------------------------------
--[[
AddComponentPostInit("frograin",function(self)
local function GetSpawnPoint(pt)
local function TestSpawnPoint(offset)
local spawnpoint = pt + offset
return GLOBAL.TheWorld.Map:IsPassableAtPoint(spawnpoint:Get())
and GLOBAL.TheWorld.Map:IsAboveGroundAtPoint(spawnpoint:Get())
end

local theta = GLOBAL.math.random() * 2 * GLOBAL.PI
local radius = GLOBAL.math.random() * TUNING.FROG_RAIN_SPAWN_RADIUS
local resultoffset = GLOBAL.FindValidPositionByFan(theta, radius, 12, TestSpawnPoint)

if resultoffset ~= nil then
return pt + resultoffset
end
end
setval(self.SetSpawnTimes,"ToggleUpdate.ScheduleSpawn.SpawnFrogForPlayer.GetSpawnPoint", GetSpawnPoint)
end)
]]
---------------------by EvenMr----------------------------------------------------------------

AddClassPostConstruct("screens/playerhud", function(inst)
    local PoisonOver = require("widgets/poisonover")
    local fn = inst.CreateOverlays
    function inst:CreateOverlays(owner)
        fn(self, owner)
        self.poisonover = self.overlayroot:AddChild(PoisonOver(owner))
    end
end)

local function OnPoisonOverDirty(inst)
    if inst._parent and inst._parent.HUD then
        if inst.poisonover:value() then
            inst._parent.HUD.poisonover:Flash()
        end
    end
end

AddPrefabPostInit("player_classified", function(inst)
    inst.poisonover = GLOBAL.net_bool(inst.GUID, "poison.poisonover", "poisonoverdirty")
    inst:ListenForEvent("poisonoverdirty", OnPoisonOverDirty)
end)
--[[
local function CraftMonkeyString()
    local function NumInRange(num, min, max)
        return (num <= max) and (num > min)
    end

    local STRING_STATE = "START"

    local string_start = function()
        local str = "O"
        if STRING_STATE == "START" then
            str = string.upper(str)
        end
        local l = math.random(2, 4)
        for i = 2, l do
            local nextletter = (math.random() > 0.3 and "o") or "a"
            str = str..nextletter
        end
        return str
    end

    local endings =
    {
        "",
        "e",
        "h",
    }

    local string_end = function()
        return endings[math.random(#endings)]
    end

    local string_space = function()
        local c = math.random()
        local str =
        (NumInRange(c, 0.4, 1) and " ") or
        (NumInRange(c, 0.3, 0.4) and ", ") or
        (NumInRange(c, 0.2, 0.3) and "? ") or
        (NumInRange(c, 0.1, 0.2) and ". ") or
        (NumInRange(c, 0, 0.1) and "! ")
        if c <= 0.3 then
            STRING_STATE = "START"
        else
            STRING_STATE = "MID"
        end
        return str
    end

    local length = math.random(6)
    local str = ""
    for i = 1, length do
        str = str..string_start()..string_end()
        if i ~= length then
            str = str..string_space()
        end
    end

    local punc = {".", "?", "!"}

    str = str..punc[math.random(#punc)]

    return str
end

local CraftOooh = getval(GLOBAL.GetSpecialCharacterString, "CraftOooh")
local wilton_sayings = getval(GLOBAL.GetSpecialCharacterString, "wilton_sayings")
GLOBAL.GetSpecialCharacterString = function(character)
    if character == nil then
        return nil
    end

    character = character:lower()

    return (character == "mime" and "")
        or (character == "ghost" and CraftOooh())
        or (character == "wilton" and wilton_sayings[math.random(#wilton_sayings)])
        or (character == "wilbur" and CraftMonkeyString())
        or nil
end

]]
AddPrefabPostInitAny(function(inst)
    if inst.prefab == "skeleton" or inst.prefab == "skeleton_player" then
        local function ondropped(inst)
            local map = GLOBAL.TheWorld.Map
            local x, y, z = inst.Transform:GetWorldPosition()
            if x and y and z then
                local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

                if (ground == GROUND.OCEAN_COASTAL or ground == GROUND.OCEAN_COASTAL_SHORE or ground ==
                    GROUND.OCEAN_SWELL or ground == GROUND.OCEAN_ROUGH or ground == GROUND.OCEAN_BRINEPOOL or ground ==
                    GROUND.OCEAN_BRINEPOOL_SHORE or ground == GROUND.OCEAN_HAZARDOUS or ground == GROUND.OCEAN_WATERLOG) then

                    inst:DoTaskInTime(0.5, function(inst)
                        local bolha = SpawnPrefab("frogsplash")
                        if bolha then
                            bolha.Transform:SetPosition(x, y, z)
                        end
                        inst:Remove()
                    end)
                end
            end
        end
        -- inst.components.inventoryitem:SetOnDroppedFn(ondropped)
        inst:DoTaskInTime(0, ondropped)
    end

    if inst.prefab == "ash" then
        if GLOBAL.TheWorld.ismastersim then
            inst:AddComponent("fertilizecoffee")
        end
    end
    ------------------------
    if inst.prefab == "anchor" then
        inst:AddTag("ancora")
    end
    ------------------------
    if inst.prefab == "gogglesnormalhat" or inst.prefab == "gogglesheathat" or inst.prefab == "gogglesarmorhat" or
        inst.prefab == "gogglesshoothat" or inst.prefab == "bathat" or inst.prefab == "pithhat" or inst.prefab ==
        "armor_weevole" then
        inst:AddTag("velocidadenormal")
    end
    ------------------------para a onda quebrar--------------
    if inst.prefab == "cave_entrance_open" or inst.prefab == "cave_entrance_vulcao" then
        inst:AddTag("teleportapracaverna")
    end

    if inst.prefab == "cave_exit" or inst.prefab == "cave_exit_vulcao" then
        inst:AddTag("teleportaprafloresta")
    end

    if inst.prefab == "seastack" or inst.prefab == "coralreef" or inst.prefab == "wreck" or inst.prefab == "waterygrave" or
        inst.prefab == "octopusking" or inst.prefab == "kraken" or inst.prefab == "ballphinhouse" or inst.prefab ==
        "coral_brain_rock" or inst.prefab == "saltstackthen" or inst.prefab == "wall_enforcedlimestone" or inst.prefab ==
        "kraken_tentacle" or inst.prefab == "sea_chiminea" or inst.prefab == "sea_yard" or inst.prefab == "buoy" then
        inst:AddTag("quebraonda")
    end

    if inst.prefab == "window_round_light" or inst.prefab == "window_round_light_backwall" then
        inst:AddTag("FX")
        inst:AddTag("NOCLICK")
        inst:AddTag("DECOR")
    end

    if inst.prefab == "saplingnova" or inst.prefab == "sapling" then
        inst.entity:AddSoundEmitter()
        inst:AddTag("saplingsw")
    end

    if inst.prefab == "sewing_tape" then
        inst:AddTag("boatrepairkit")
        if GLOBAL.TheWorld.ismastersim then
            inst:AddComponent("interactions")
        end
    end

    if inst.prefab == "wurt" then

    end

    if inst.prefab == "spider_warrior" then
        inst:DoTaskInTime(0.5, function(inst)
            local map = GLOBAL.TheWorld.Map
            local x, y, z = inst.Transform:GetWorldPosition()
            if x and y and z then
                local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
                if ground == GROUND.MAGMAFIELD or ground == GROUND.JUNGLE or ground == GROUND.ASH or ground ==
                    GROUND.VOLCANO or ground == GROUND.TIDALMARSH or ground == GROUND.MEADOW or ground == GROUND.BEAH then
                    local bolha = SpawnPrefab("spider_tropical")
                    if bolha then
                        bolha.Transform:SetPosition(x, y, z)
                    end
                    inst:Remove()
                end
            end
        end)

    end

    -----mostra neve--------------
    if inst:HasTag("SnowCovered") then
        local function mostraneve(inst)
            local map = GLOBAL.TheWorld.Map
            local x, y, z = inst.Transform:GetWorldPosition()
            if x and y and z then
                local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
                if ground == GROUND.WATER_MANGROVE or ground == GROUND.ANTFLOOR then
                    inst:AddTag("mostraneve")
                end
            end
        end
        inst:DoTaskInTime(0.5, mostraneve)
    end

    --------------negocia com porcos------------------
    if inst.prefab == "houndstooth" or inst.prefab == "gunpowder" or inst.prefab == "boards" or inst.prefab ==
        "mosquitosack" or inst.prefab == "nightmarefuel" or inst.prefab == "stinger" then
        if GLOBAL.TheWorld.ismastersim then
            inst:AddComponent("tradable")
        end
    end

    --------------mod rangers------------------
    if inst.prefab == "levelx_vest" then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("krampus_sack")
        end
    end
    ------------------------koalefant_summer se transforma no chao de neve-----------------
    if inst.prefab == "koalefant_summer" then
        local function ondropped(inst)
            local map = GLOBAL.TheWorld.Map
            local x, y, z = inst.Transform:GetWorldPosition()
            if x and y and z then
                local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

                if (ground == GROUND.WATER_MANGROVE) or (ground == GROUND.ANTFLOOR) then
                    inst:DoTaskInTime(0.5, function(inst)
                        local bolha = SpawnPrefab("koalefant_winter")
                        if bolha then
                            bolha.Transform:SetPosition(x, y, z)
                        end
                        inst:Remove()
                    end)
                end
            end
        end

        inst:DoTaskInTime(0, ondropped)
    end

    ------------------------hound se transforma no chao de neve-----------------
    --[[
if inst.prefab == "firehound" or inst.prefab == "hound" or inst.prefab == "icehound" then
local function ondropped(inst)
if GLOBAL.TheWorld.components.aporkalypse and GLOBAL.TheWorld.components.aporkalypse.aporkalypse_active == true then
inst:DoTaskInTime(0.5, function(inst)
inst:SetPrefabName("mutatedhound")
--inst:Remove()
--inst.AnimState:SetBank("hound")
--inst.AnimState:SetBuild("hound_mutated")
end)
else
local map = GLOBAL.TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
for i, node in ipairs(GLOBAL.TheWorld.topology.nodes) do
if TheSim:WorldPointInPoly(x, z, node.poly) then


if node.tags ~= nil and table.contains(node.tags, "hamlet") then
local bolha = SpawnPrefab("vampirebat")
if bolha then
bolha.Transform:SetPosition(x, y, z)
local atacado = GLOBAL.GetClosestInstWithTag("player", bolha, 40)
if atacado then
bolha.components.combat:SuggestTarget(atacado)
end
end
inst:Remove()
end


if node.tags ~= nil and table.contains(node.tags, "frost") and inst.prefab ~= "icehound" then
local bolha = SpawnPrefab("icehound")
if bolha then
bolha.Transform:SetPosition(x, y, z)
local atacado = GLOBAL.GetClosestInstWithTag("player", bolha, 40)
if atacado then
bolha.components.combat:SuggestTarget(atacado)
end
end
inst:Remove()
end

if node.tags ~= nil and table.contains(node.tags, "tropical") then


if inst.prefab == "hound" then
local bolha = SpawnPrefab("icehound")
if bolha then
bolha.Transform:SetPosition(x, y, z)
local atacado = GLOBAL.GetClosestInstWithTag("player", bolha, 40)
if atacado then
bolha.components.combat:SuggestTarget(atacado)
end
end
inst:Remove()
end

if inst.prefab == "firehound" then
local bolha = SpawnPrefab("poisoncrocodog")
if bolha then
bolha.Transform:SetPosition(x, y, z)
local atacado = GLOBAL.GetClosestInstWithTag("player", bolha, 40)
if atacado then
bolha.components.combat:SuggestTarget(atacado)
end
end
inst:Remove()
end


if inst.prefab == "icehound" then
local bolha = SpawnPrefab("watercrocodog")
if bolha then
bolha.Transform:SetPosition(x, y, z)
local atacado = GLOBAL.GetClosestInstWithTag("player", bolha, 40)
if atacado then
bolha.components.combat:SuggestTarget(atacado)
end
end
inst:Remove()
end
end
end
end
end
end

inst:DoTaskInTime(0, ondropped)
end
]]
    ------------------------------------------------------
    if inst.prefab == "mole" or inst.prefab == "rabbit" then
        local function ondropped(inst)
            local map = GLOBAL.TheWorld.Map
            local x, y, z = inst.Transform:GetWorldPosition()
            if x and y and z then
                local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

                if (ground == GROUND.UNDERWATER_ROCKY) or (ground == GROUND.UNDERWATER_SANDY) or
                    (ground == GROUND.PAINTED and GLOBAL.TheWorld:HasTag("cave")) or
                    (ground == GROUND.MAGMAFIELD and GLOBAL.TheWorld:HasTag("cave")) or
                    (ground == GROUND.BEACH and GLOBAL.TheWorld:HasTag("cave")) then
                    inst:DoTaskInTime(0.1, function(inst)
                        inst:Remove()
                    end)
                end
            end
        end

        inst:DoTaskInTime(0.1, ondropped)
    end

    if inst.prefab == "worm" then
        local function ondropped(inst)
            local map = GLOBAL.TheWorld.Map
            local x, y, z = inst.Transform:GetWorldPosition()
            if x and y and z then
                local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

                if (ground == GROUND.UNDERWATER_ROCKY) or (ground == GROUND.UNDERWATER_SANDY) or
                    (ground == GROUND.PAINTED and GLOBAL.TheWorld:HasTag("cave")) or
                    (ground == GROUND.MAGMAFIELD and GLOBAL.TheWorld:HasTag("cave")) or
                    (ground == GROUND.BEACH and GLOBAL.TheWorld:HasTag("cave")) then
                    inst:DoTaskInTime(0.1, function(inst)
                        local bolha = SpawnPrefab("seatentacle")
                        if bolha then
                            bolha.Transform:SetPosition(x, y, z)
                        end
                        inst:Remove()
                    end)
                end
            end
        end

        inst:DoTaskInTime(0.1, ondropped)
    end
    --------------------------apaga depois de um tempo----------------------

    if inst.prefab == "snake_amphibious" or inst.prefab == "bat" or inst.prefab == "scorpion" or inst.prefab == "ghost" or
        inst.prefab == "antman_warrior" or inst.prefab == "antman" or inst.prefab == "hanging_vine" or inst.prefab ==
        "grabbing_vine" or inst.prefab == "hanging_vine_patch" or inst.prefab == "mean_flytrap" or inst.prefab ==
        "adult_flytrap" or inst.prefab == "lightrays_jungle" or inst.prefab == "pog" or inst.prefab == "zeb" or
        inst.prefab == "lightrays" then

        local function OnTimerDone(inst, data)
            if data.name == "vaiembora" then
                local invader = GLOBAL.GetClosestInstWithTag("player", inst, 25)
                if not invader then
                    inst:Remove()
                else
                    inst.components.timer:StartTimer("vaiembora", 10)
                end
            end
        end

        inst:AddTag("tropicalspawner")

        if GLOBAL.TheWorld.ismastersim then
            inst:AddComponent("timer")
            inst:ListenForEvent("timerdone", OnTimerDone)
            inst.components.timer:StartTimer("vaiembora", 80 + math.random() * 80)
        end
    end

end)

AddPrefabPostInitAny(function(inst)

    if inst:HasTag("player") then

        if inst.components.shopper == nil then
            inst:AddComponent("shopper")
        end

        if inst.components.infestable == nil then
            inst:AddComponent("infestable")
        end

        if inst.components.drownable == nil then
            inst:AddComponent("drownable")
        end

    end
end)

--------------------------------- camera------------------------------

local function OnDirtyEventCameraStuff(inst) -- this is called on client, if the server does inst.mynetvarCameraMode:set(...)
    local val = inst.mynetvarCameraMode:value()
    local fasedodia = "night"
    if GLOBAL.TheWorld.state.isday then
        fasedodia = "day"
    end
    if GLOBAL.TheWorld.state.isdusk then
        fasedodia = "dusk"
    end
    if GLOBAL.TheWorld.state.isnight then
        fasedodia = "night"
    end
    if val == 1 then -- for jumping(OnActive) function 
        GLOBAL.TheCamera.controllable = false
        GLOBAL.TheCamera.cutscene = true
        GLOBAL.TheCamera.headingtarget = 0
        GLOBAL.TheCamera.distancetarget = 20 + GetModConfigData("housewallajust")
        GLOBAL.TheCamera.targetoffset = Vector3(-2.3, 1.7, 0)
    elseif val == 2 then
        GLOBAL.TheCamera:SetDistance(12)
    elseif val == 3 then
        GLOBAL.TheCamera:SetDefault()
        GLOBAL.TheCamera:SetTarget(GLOBAL.TheFocalPoint)
    elseif val == 4 then -- for player prox 
        GLOBAL.TheCamera.controllable = false
        GLOBAL.TheCamera.cutscene = true
        GLOBAL.TheCamera.headingtarget = 0
        GLOBAL.TheCamera.distancetarget = 21.5 + GetModConfigData("housewallajust")
        GLOBAL.TheCamera:SetTarget(GLOBAL.GetClosestInstWithTag("shopinterior", inst, 30))
        GLOBAL.TheCamera.targetoffset = Vector3(2, 1.5, 0)
        GLOBAL.TheWorld:PushEvent("underwatercave", "night")
    elseif val == 5 then -- for player prox 
        GLOBAL.TheCamera.controllable = false
        GLOBAL.TheCamera.cutscene = true
        GLOBAL.TheCamera.headingtarget = 0
        local alvodacamera = GLOBAL.GetClosestInstWithTag("caveinterior", inst, 30)
        if alvodacamera then
            GLOBAL.TheCamera:SetTarget(alvodacamera)
        end
        if alvodacamera and alvodacamera:HasTag("pisodaruina") then
            GLOBAL.TheCamera.distancetarget = 25 + GetModConfigData("housewallajust")
            GLOBAL.TheCamera.targetoffset = Vector3(6, 1.5, 0)
            GLOBAL.TheWorld:PushEvent("underwatercave", "night")
        elseif alvodacamera and alvodacamera:HasTag("pisogalleryinteriorpalace") then
            GLOBAL.TheCamera.distancetarget = 21.5 + GetModConfigData("housewallajust")
            GLOBAL.TheCamera.targetoffset = Vector3(3, 1.5, 0)
        elseif alvodacamera and alvodacamera:HasTag("pisoanthill") then
            GLOBAL.TheCamera.distancetarget = 27 + GetModConfigData("housewallajust")
            GLOBAL.TheCamera.targetoffset = Vector3(5, 1.5, 0)
            GLOBAL.TheWorld:PushEvent("underwatercave", "night")
        else
            GLOBAL.TheCamera.distancetarget = 27 + GetModConfigData("housewallajust")
            GLOBAL.TheCamera.targetoffset = Vector3(5, 1.5, 0)
            GLOBAL.TheWorld:PushEvent("underwatercave", "night")
        end

    elseif val == 6 then -- for player prox 
        GLOBAL.TheCamera:SetDefault()
        GLOBAL.TheCamera:SetTarget(GLOBAL.TheFocalPoint)

        local fasedodia = "night"
        if GLOBAL.TheWorld.state.isday then
            fasedodia = "day"
        end
        if GLOBAL.TheWorld.state.isdusk then
            fasedodia = "dusk"
        end
        if GLOBAL.TheWorld.state.isnight then
            fasedodia = "night"
        end
        GLOBAL.TheWorld:PushEvent("underwatercaveexit", fasedodia)
        GLOBAL.TheFocalPoint.SoundEmitter:KillSound("storemusic")

    elseif val == 7 then -- for player prox 
        GLOBAL.TheCamera.controllable = false
        GLOBAL.TheCamera.cutscene = true
        GLOBAL.TheCamera.headingtarget = 0
        GLOBAL.TheCamera.distancetarget = 28 + GetModConfigData("housewallajust")
        GLOBAL.TheCamera:SetTarget(GLOBAL.GetClosestInstWithTag("pisointeriorpalace", inst, 30))
        GLOBAL.TheCamera.targetoffset = Vector3(5, 1.5, 0)
    elseif val == 8 then -- for player prox 
        GLOBAL.TheCamera.controllable = false
        GLOBAL.TheCamera.cutscene = true
        GLOBAL.TheCamera.headingtarget = 0
        GLOBAL.TheCamera.distancetarget = 25 + GetModConfigData("housewallajust")
        GLOBAL.TheCamera:SetTarget(GLOBAL.GetClosestInstWithTag("pisointerioruins", inst, 30)) -- inst = GLOBAL.ThePlayer
        GLOBAL.TheCamera.targetoffset = Vector3(6, 1.5, 0)
    end
    -- Use val and do client related stuff
end

-- TheWorld:PushEvent("underwatercave", "night")
-- TheWorld:PushEvent("underwatercaveexit", "night")

local function RegisterListenersCameraStuff(inst)
    -- check that the entity is the playing player
    if inst.HUD ~= nil then
        inst:ListenForEvent("DirtyEventCameraStuff", OnDirtyEventCameraStuff)
    end
end

local function OnPlayerSpawn(inst)
    inst.mynetvarCameraMode = GLOBAL.net_tinybyte(inst.GUID, "BakuStuffNetStuff", "DirtyEventCameraStuff")
    inst.mynetvarCameraMode:set(0)
    inst:DoTaskInTime(0, RegisterListenersCameraStuff)

    inst:DoTaskInTime(0.5, function(inst)

        if GLOBAL.GetClosestInstWithTag("shopinterior", inst, 30) then
            inst.mynetvarCameraMode:set(4)
        elseif GLOBAL.GetClosestInstWithTag("caveinterior", inst, 30) then
            inst.mynetvarCameraMode:set(5)
        elseif GLOBAL.GetClosestInstWithTag("pisointeriorpalace", inst, 30) then
            inst.mynetvarCameraMode:set(7)
        else
            inst.mynetvarCameraMode:set(6)
        end

    end)
end

AddPlayerPostInit(OnPlayerSpawn)

AddClassPostConstruct("cameras/followcamera", function(Camera)
    -- Camera.old = Camera.SetDefault
    function Camera:PushScreenHOffset(ref, xoffset)
        if not self.controllable then
        else
            self:PopScreenHOffset(ref)
            table.insert(self.screenoffsetstack, 1, {
                ref = ref,
                xoffset = xoffset
            })

        end
    end

end)
--[[
AddComponentPostInit("focalpoint",function(self)
    local old_CameraUpdate = self.CameraUpdate
    local function new_CameraUpdate(self,dt,...)
   local parent = self.inst.entity:GetParent()
    if parent ~= nil and GLOBAL.next(self.targets) ~= nil then
        local toremove2 = {}
        for source, sourcetbl in pairs(self.targets) do
            if not source:IsNear(self.inst, 50) and source:HasTag("blows_air")  then--if not source:IsNear(self.inst, 50) and source:HasTag("interiorcamera")  then--and not source:HasTag("centerroomglow") then
                table.insert(toremove2, source)
            end
        end
         for i, v in ipairs(toremove2) do
            self:StopFocusSource(GLOBAL.unpack(toremove2))
        end
        
    end
        if old_CameraUpdate~=nil then
            return old_CameraUpdate(self,dt,...)
        end
    end
    self.CameraUpdate = new_CameraUpdate
end)
]]
----umidade interior------

local Sheltered = GLOBAL.require("components/sheltered")
local SHELTERED_MUST_TAGS = {"shelter"}
local SHELTERED_CANT_TAGS = {"FX", "NOCLICK", "DECOR", "INLIMBO", "stump", "burnt"}
local SHADECANOPY_MUST_TAGS = {"shadecanopy"}
local SHADECANOPY_SMALL_MUST_TAGS = {"shadecanopysmall"}
function Sheltered:OnUpdate(dt)
    local sheltered = false
    local level = 1
    self.waterproofness = TUNING.WATERPROOFNESS_SMALLMED -- adicionado
    self.announcecooldown = math.max(0, self.announcecooldown - dt)
    local x, y, z = self.inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 2, SHELTERED_MUST_TAGS, SHELTERED_CANT_TAGS)
    local blowsent = TheSim:FindEntities(x, y, z, 40, {"blows_air"})

    if #blowsent > 0 then
        self:SetSheltered(#blowsent > 0)
        for _, v in ipairs(blowsent) do
            -- if v:HasTag("dryshelter") then
            self.waterproofness = TUNING.WATERPROOFNESS_ABSOLUTE
            break
            -- end
        end
    else
        if #ents > 0 then
            sheltered = true
        end

        local canopy = TheSim:FindEntities(x, y, z, TUNING.SHADE_CANOPY_RANGE, SHADECANOPY_MUST_TAGS)
        local canopy_small = TheSim:FindEntities(x, y, z, TUNING.SHADE_CANOPY_RANGE_SMALL, SHADECANOPY_SMALL_MUST_TAGS)
        if #canopy > 0 or #canopy_small > 0 then
            sheltered = true
            level = 2
        end

        self:SetSheltered(sheltered, level)
    end
end

------rain effect---------------
AddSimPostInit(function()
    GLOBAL.EmitterManager.old_updatefuncs = {
        snow = nil,
        rain = nil,
        pollen = nil
    }
    local old_PostUpdate = GLOBAL.EmitterManager.PostUpdate
    local function new_PostUpdate(self, ...)
        for inst, data in pairs(self.awakeEmitters.infiniteLifetimes) do
            if inst.prefab == "pollen" or inst.prefab == "snow" or inst.prefab == "rain" then
                if self.old_updatefuncs[inst.prefab] == nil then
                    self.old_updatefuncs[inst.prefab] = data.updateFunc
                end
                local pt = inst:GetPosition()
                local ents = GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 40, {"blows_air"})
                if #ents > 0 then
                    data.updateFunc = function()
                    end -- empty function
                else
                    data.updateFunc = self.old_updatefuncs[inst.prefab] ~= nil and self.old_updatefuncs[inst.prefab] or
                                          function()
                        end -- the original one
                end
            end
        end
        if old_PostUpdate ~= nil then
            return old_PostUpdate(self, ...)
        end
    end
    GLOBAL.EmitterManager.PostUpdate = new_PostUpdate

end)

---------------------
GLOBAL.STRINGS.ACTIONS.JUMPIN = {
    HAMLET = "Enter",
    GENERIC = "Jump In"
}

local Oldstrfnjumpin = ACTIONS.JUMPIN.strfn
GLOBAL.ACTIONS.JUMPIN.strfn = function(act)
    if act.target ~= nil and act.target:HasTag("hamletteleport") then
        return "HAMLET"
    end
    return Oldstrfnjumpin(act)
end

------darkness---------------
AddPlayerPostInit(function(inst)
    if GLOBAL.TheNet:GetIsServer() then
        inst.findpigruinstask = inst:DoPeriodicTask(2, function()
            local pt = inst:GetPosition()
            local interior = GLOBAL.TheSim:FindEntities(pt.x, pt.y, pt.z, 40, {"pisodaruina"})
            if #interior > 0 and inst.LightWatcher ~= nil then
                local thresh = GLOBAL.TheSim:GetLightAtPoint(10000, 10000, 10000)
                inst.LightWatcher:SetLightThresh(0.075 + thresh)
                inst.LightWatcher:SetDarkThresh(0.05 + thresh)
            else
                inst.LightWatcher:SetLightThresh(0.075)
                inst.LightWatcher:SetDarkThresh(0.05)
            end
        end)
    end
end)
------------------------------------bloodmoon ----------------------------------------------

if GetModConfigData("aporkalypse") == true then
    local function bloodmoon(self)
        local luavermelha = GLOBAL.require "widgets/bloodmoon"
        self.luadesangue = self:AddChild(luavermelha(self.owner))
        --	local badge_brain = self.brain:GetPosition()
        local AlwaysOnStatus = false
        for k, v in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
            local Mod = GLOBAL.KnownModIndex:GetModInfo(v).name
            if Mod == "Combined Status" then
                AlwaysOnStatus = true
            end
        end
        if AlwaysOnStatus then
            self.luadesangue:SetPosition(0, 0, 0)
        else
            self.luadesangue:SetPosition(0, 0, 0)
        end
    end

    AddClassPostConstruct("widgets/uiclock", bloodmoon)
end
---------------------------------------------------------------------------------------Raft and logboat---------------------------------------------------
STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
DEPLOYSPACING = GLOBAL.DEPLOYSPACING
DEPLOYSPACING_RADIUS = GLOBAL.DEPLOYSPACING_RADIUS
TheSim = GLOBAL.TheSim

AddComponentPostInit("boatphysics", function(self, inst)
    self.sizespeedmultiplier = 1
    local oaf = self.ApplyForce
    function self:ApplyForce(dir_x, dir_z, force)
        local force = (force and force or 0) * self.sizespeedmultiplier
        oaf(self, dir_x, dir_z, force)
    end
    local oam = self.AddMast
    function self:AddMast(mast)
        mast.sail_force = mast.sail_force * self.sizespeedmultiplier
        oam(self, mast)
    end
end)

AddSimPostInit(function()
    local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
    GLOBAL.Map.GetPlatformAtPoint = function(self, pos_x, pos_y, pos_z)
        if pos_z == nil then
            pos_z = pos_y
            pos_y = 0
        end
        local entities = TheSim:FindEntities(pos_x, pos_y, pos_z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS * 10,
            WALKABLE_PLATFORM_TAGS)
        for i, v in ipairs(entities) do
            if v.components.walkableplatform ~= nil and v.components.walkableplatform.radius == nil then
                v.components.walkableplatform.radius = 4
            end
            if v.components.walkableplatform ~= nil and math.sqrt(v:GetDistanceSqToPoint(pos_x, 0, pos_z)) <=
                v.components.walkableplatform.radius then
                return v
            end
        end
        return nil
    end
    GLOBAL.Map.IsPassableAtPointWithPlatformRadiusBias = function(self, x, y, z, allow_water, exclude_boats,
        platform_radius_bias, ignore_land_overhang)
        local valid_tile = self:IsAboveGroundAtPoint(x, y, z, allow_water) or
                               ((not ignore_land_overhang) and self:IsVisualGroundAtPoint(x, y, z) or false)
        if not allow_water and not valid_tile then
            if not exclude_boats then
                local entities = TheSim:FindEntities(x, 0, z,
                    TUNING.MAX_WALKABLE_PLATFORM_RADIUS * 10 + platform_radius_bias, WALKABLE_PLATFORM_TAGS)
                for i, v in ipairs(entities) do
                    local walkable_platform = v.components.walkableplatform
                    if v.components.walkableplatform ~= nil and v.components.walkableplatform.radius == nil then
                        v.components.walkableplatform.radius = 4
                    end
                    if walkable_platform ~= nil and math.sqrt(v:GetDistanceSqToPoint(x, 0, z)) <=
                        (walkable_platform.radius + platform_radius_bias) then
                        local platform_x, platform_y, platform_z = v.Transform:GetWorldPosition()
                        local distance_sq = GLOBAL.VecUtil_LengthSq(x - platform_x, z - platform_z)
                        return distance_sq <= walkable_platform.radius * walkable_platform.radius
                    end
                end
            end
            return false
        end
        return valid_tile
    end
    GLOBAL.Map.CanDeployAtPointInWater = function(self, pt, inst, mouseover, data)
        local tile = self:GetTileAtPoint(pt.x, pt.y, pt.z)
        if tile == GROUND.IMPASSABLE or tile == GROUND.INVALID then
            return false
        end

        -- check if there's a boat in the way
        local min_distance_from_boat = (data and data.boat) or 0
        local radius = (data and data.radius) or 0
        local entities = TheSim:FindEntities(pt.x, 0, pt.z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS * 10 + radius +
            min_distance_from_boat, WALKABLE_PLATFORM_TAGS)
        for i, v in ipairs(entities) do
            if v.components.walkableplatform ~= nil and math.sqrt(v:GetDistanceSqToPoint(pt.x, 0, pt.z)) <=
                (v.components.walkableplatform.radius + radius + min_distance_from_boat) then
                return false
            end
        end

        local min_distance_from_land = (data and data.land) or 0

        return (mouseover == nil or mouseover:HasTag("player")) and
                   self:IsDeployPointClear(pt, nil, min_distance_from_boat + radius) and
                   self:IsSurroundedByWater(pt.x, pt.y, pt.z, min_distance_from_land + radius)
    end
end)

local lastfree = 0
for k, v in pairs(DEPLOYSPACING) do
    if v + 1 > lastfree then
        lastfree = v + 1
    end
end

if lastfree <= 7 then
    DEPLOYSPACING.LARGEBOATS = lastfree
    DEPLOYSPACING_RADIUS[DEPLOYSPACING.LARGEBOATS] = 8
else
    for k, v in pairs(DEPLOYSPACING) do
        if DEPLOYSPACING_RADIUS[v] > 7 and DEPLOYSPACING_RADIUS[v] < 10 then
            DEPLOYSPACING.LARGEBOATS = v
            break
        end
    end
end

---------------------------------------------modded farms-------------------------------
local function MakeGrowTimes(germination_min, germination_max, full_grow_min, full_grow_max)
    local grow_time = {}

    -- germination time
    grow_time.seed = {germination_min, germination_max}

    -- grow time
    grow_time.sprout = {full_grow_min * 0.5, full_grow_max * 0.5}
    grow_time.small = {full_grow_min * 0.3, full_grow_max * 0.3}
    grow_time.med = {full_grow_min * 0.2, full_grow_max * 0.2}

    -- harvestable perish time
    grow_time.full = 4 * TUNING.TOTAL_DAY_TIME
    grow_time.oversized = 6 * TUNING.TOTAL_DAY_TIME
    grow_time.regrow = {4 * TUNING.TOTAL_DAY_TIME, 5 * TUNING.TOTAL_DAY_TIME} -- min, max	

    return grow_time
end

local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

local drink_low = TUNING.FARM_PLANT_DRINK_LOW
local drink_med = TUNING.FARM_PLANT_DRINK_MED
local drink_high = TUNING.FARM_PLANT_DRINK_HIGH

local S = TUNING.FARM_PLANT_CONSUME_NUTRIENT_LOW
local M = TUNING.FARM_PLANT_CONSUME_NUTRIENT_MED
local L = TUNING.FARM_PLANT_CONSUME_NUTRIENT_HIGH

PLANT_DEFS.aloe = {
    build = "farm_plant_aloeplant",
    bank = "farm_plant_asparagus"
}
PLANT_DEFS.radish = {
    build = "farm_plant_radish",
    bank = "farm_plant_carrot"
}
PLANT_DEFS.sweet_potato = {
    build = "farm_plant_sweett",
    bank = "farm_plant_carrot"
}
PLANT_DEFS.wheat = {
    build = "farm_plant_wheataaaa",
    bank = "farm_plant_asparagus"
}
PLANT_DEFS.turnip = {
    build = "farm_plant_turnip",
    bank = "farm_plant_carrot"
}

PLANT_DEFS.sweet_potato.grow_time = MakeGrowTimes(12 * TUNING.SEG_TIME, 16 * TUNING.SEG_TIME, 4 * TUNING.TOTAL_DAY_TIME,
    7 * TUNING.TOTAL_DAY_TIME)
PLANT_DEFS.aloe.grow_time = MakeGrowTimes(12 * TUNING.SEG_TIME, 16 * TUNING.SEG_TIME, 4 * TUNING.TOTAL_DAY_TIME,
    7 * TUNING.TOTAL_DAY_TIME)
PLANT_DEFS.radish.grow_time = MakeGrowTimes(12 * TUNING.SEG_TIME, 16 * TUNING.SEG_TIME, 4 * TUNING.TOTAL_DAY_TIME,
    7 * TUNING.TOTAL_DAY_TIME)
PLANT_DEFS.wheat.grow_time = MakeGrowTimes(12 * TUNING.SEG_TIME, 16 * TUNING.SEG_TIME, 4 * TUNING.TOTAL_DAY_TIME,
    7 * TUNING.TOTAL_DAY_TIME)
PLANT_DEFS.turnip.grow_time = MakeGrowTimes(12 * TUNING.SEG_TIME, 16 * TUNING.SEG_TIME, 4 * TUNING.TOTAL_DAY_TIME,
    7 * TUNING.TOTAL_DAY_TIME)

PLANT_DEFS.sweet_potato.moisture = {
    drink_rate = drink_low,
    min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE
}
PLANT_DEFS.aloe.moisture = {
    drink_rate = drink_low,
    min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE
}
PLANT_DEFS.radish.moisture = {
    drink_rate = drink_low,
    min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE
}
PLANT_DEFS.wheat.moisture = {
    drink_rate = drink_low,
    min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE
}
PLANT_DEFS.turnip.moisture = {
    drink_rate = drink_low,
    min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE
}

PLANT_DEFS.sweet_potato.good_seasons = {
    autumn = true,
    winter = true,
    spring = true
}
PLANT_DEFS.aloe.good_seasons = {
    autumn = true,
    winter = true,
    spring = true
}
PLANT_DEFS.radish.good_seasons = {
    autumn = true,
    winter = true,
    spring = true
}
PLANT_DEFS.wheat.good_seasons = {
    autumn = true,
    winter = true,
    spring = true
}
PLANT_DEFS.turnip.good_seasons = {
    autumn = true,
    winter = true,
    spring = true
}

PLANT_DEFS.sweet_potato.nutrient_consumption = {M, 0, 0}
PLANT_DEFS.aloe.nutrient_consumption = {M, 0, 0}
PLANT_DEFS.radish.nutrient_consumption = {M, 0, 0}
PLANT_DEFS.wheat.nutrient_consumption = {M, 0, 0}
PLANT_DEFS.turnip.nutrient_consumption = {M, 0, 0}

PLANT_DEFS.sweet_potato.max_killjoys_tolerance = TUNING.FARM_PLANT_KILLJOY_TOLERANCE
PLANT_DEFS.aloe.max_killjoys_tolerance = TUNING.FARM_PLANT_KILLJOY_TOLERANCE
PLANT_DEFS.radish.max_killjoys_tolerance = TUNING.FARM_PLANT_KILLJOY_TOLERANCE
PLANT_DEFS.wheat.max_killjoys_tolerance = TUNING.FARM_PLANT_KILLJOY_TOLERANCE
PLANT_DEFS.turnip.max_killjoys_tolerance = TUNING.FARM_PLANT_KILLJOY_TOLERANCE

PLANT_DEFS.sweet_potato.weight_data = {361.51, 506.04, .28}
PLANT_DEFS.aloe.weight_data = {361.51, 506.04, .28}
PLANT_DEFS.radish.weight_data = {361.51, 506.04, .28}
PLANT_DEFS.wheat.weight_data = {361.51, 506.04, .28}
PLANT_DEFS.turnip.weight_data = {361.51, 506.04, .28}

PLANT_DEFS.sweet_potato.pictureframeanim = {
    anim = "emote_happycheer",
    time = 12 * GLOBAL.FRAMES
}
PLANT_DEFS.aloe.pictureframeanim = {
    anim = "emote_happycheer",
    time = 12 * GLOBAL.FRAMES
}
PLANT_DEFS.radish.pictureframeanim = {
    anim = "emote_happycheer",
    time = 12 * GLOBAL.FRAMES
}
PLANT_DEFS.wheat.pictureframeanim = {
    anim = "emote_happycheer",
    time = 12 * GLOBAL.FRAMES
}
PLANT_DEFS.turnip.pictureframeanim = {
    anim = "emote_happycheer",
    time = 12 * GLOBAL.FRAMES
}

PLANT_DEFS.sweet_potato.prefab = "farm_plant_sweet_potato"
PLANT_DEFS.aloe.prefab = "farm_plant_aloe"
PLANT_DEFS.radish.prefab = "farm_plant_radish"
PLANT_DEFS.wheat.prefab = "farm_plant_wheat"
PLANT_DEFS.turnip.prefab = "farm_plant_turnip"

PLANT_DEFS.sweet_potato.product = "sweet_potato"
PLANT_DEFS.aloe.product = "aloe"
PLANT_DEFS.radish.product = "radish"
PLANT_DEFS.wheat.product = "wheat"
PLANT_DEFS.turnip.product = "turnip"

PLANT_DEFS.sweet_potato.product_oversized = "sweet_potato_oversized"
PLANT_DEFS.aloe.product_oversized = "aloe_oversized"
PLANT_DEFS.radish.product_oversized = "radish_oversized"
PLANT_DEFS.wheat.product_oversized = "wheat_oversized"
PLANT_DEFS.turnip.product_oversized = "turnip_oversized"

PLANT_DEFS.sweet_potato.seed = "sweet_potato_seeds"
PLANT_DEFS.aloe.seed = "aloe_seeds"
PLANT_DEFS.radish.seed = "radish_seeds"
PLANT_DEFS.wheat.seed = "wheat_seeds"
PLANT_DEFS.turnip.seed = "turnip_seeds"

PLANT_DEFS.sweet_potato.plant_type_tag = "farm_plant_sweet_potato"
PLANT_DEFS.aloe.plant_type_tag = "farm_plant_aloe"
PLANT_DEFS.radish.plant_type_tag = "farm_plant_radish"
PLANT_DEFS.wheat.plant_type_tag = "farm_plant_wheat"
PLANT_DEFS.turnip.plant_type_tag = "farm_plant_turnip"

PLANT_DEFS.sweet_potato.loot_oversized_rot = {"spoiled_food", "spoiled_food", "spoiled_food", "sweet_potato_seeds",
                                              "fruitfly", "fruitfly"}
PLANT_DEFS.aloe.loot_oversized_rot = {"spoiled_food", "spoiled_food", "spoiled_food", "aloe_seeds", "fruitfly",
                                      "fruitfly"}
PLANT_DEFS.radish.loot_oversized_rot = {"spoiled_food", "spoiled_food", "spoiled_food", "radish_seeds", "fruitfly",
                                        "fruitfly"}
PLANT_DEFS.wheat.loot_oversized_rot = {"spoiled_food", "spoiled_food", "spoiled_food", "wheat_seeds", "fruitfly",
                                       "fruitfly"}
PLANT_DEFS.turnip.loot_oversized_rot = {"spoiled_food", "spoiled_food", "spoiled_food", "turnip_seeds", "fruitfly",
                                        "fruitfly"}

PLANT_DEFS.sweet_potato.family_min_count = TUNING.FARM_PLANT_SAME_FAMILY_MIN
PLANT_DEFS.aloe.family_min_count = TUNING.FARM_PLANT_SAME_FAMILY_MIN
PLANT_DEFS.radish.family_min_count = TUNING.FARM_PLANT_SAME_FAMILY_MIN
PLANT_DEFS.wheat.family_min_count = TUNING.FARM_PLANT_SAME_FAMILY_MIN
PLANT_DEFS.turnip.family_min_count = TUNING.FARM_PLANT_SAME_FAMILY_MIN

PLANT_DEFS.sweet_potato.family_check_dist = TUNING.FARM_PLANT_SAME_FAMILY_RADIUS
PLANT_DEFS.aloe.family_check_dist = TUNING.FARM_PLANT_SAME_FAMILY_RADIUS
PLANT_DEFS.radish.family_check_dist = TUNING.FARM_PLANT_SAME_FAMILY_RADIUS
PLANT_DEFS.wheat.family_check_dist = TUNING.FARM_PLANT_SAME_FAMILY_RADIUS
PLANT_DEFS.turnip.family_check_dist = TUNING.FARM_PLANT_SAME_FAMILY_RADIUS

PLANT_DEFS.sweet_potato.stage_netvar = net_tinybyte
PLANT_DEFS.aloe.stage_netvar = net_tinybyte
PLANT_DEFS.radish.stage_netvar = net_tinybyte
PLANT_DEFS.wheat.stage_netvar = net_tinybyte
PLANT_DEFS.turnip.stage_netvar = net_tinybyte

PLANT_DEFS.sweet_potato.sounds = PLANT_DEFS.pumpkin.sounds
PLANT_DEFS.aloe.sounds = PLANT_DEFS.pumpkin.sounds
PLANT_DEFS.radish.sounds = PLANT_DEFS.pumpkin.sounds
PLANT_DEFS.wheat.sounds = PLANT_DEFS.pumpkin.sounds
PLANT_DEFS.turnip.sounds = PLANT_DEFS.pumpkin.sounds

PLANT_DEFS.sweet_potato.plantregistryinfo = {{
    text = "seed",
    anim = "crop_seed",
    grow_anim = "grow_seed",
    learnseed = true,
    growing = true
}, {
    text = "sprout",
    anim = "crop_sprout",
    grow_anim = "grow_sprout",
    growing = true
}, {
    text = "small",
    anim = "crop_small",
    grow_anim = "grow_small",
    growing = true
}, {
    text = "medium",
    anim = "crop_med",
    grow_anim = "grow_med",
    growing = true
}, {
    text = "grown",
    anim = "crop_full",
    grow_anim = "grow_full",
    revealplantname = true,
    fullgrown = true
}, {
    text = "oversized",
    anim = "crop_oversized",
    grow_anim = "grow_oversized",
    revealplantname = true,
    fullgrown = true
}, {
    text = "rotting",
    anim = "crop_rot",
    grow_anim = "grow_rot",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}, {
    text = "oversized_rotting",
    anim = "crop_rot_oversized",
    grow_anim = "grow_rot_oversized",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}}
PLANT_DEFS.sweet_potato.plantregistrywidget = "widgets/redux/farmplantpage"
PLANT_DEFS.sweet_potato.plantregistrysummarywidget = "widgets/redux/farmplantsummarywidget"
PLANT_DEFS.sweet_potato.pictureframeanim = {
    anim = "emoteXL_happycheer",
    time = 0.5
}

PLANT_DEFS.aloe.plantregistryinfo = {{
    text = "seed",
    anim = "crop_seed",
    grow_anim = "grow_seed",
    learnseed = true,
    growing = true
}, {
    text = "sprout",
    anim = "crop_sprout",
    grow_anim = "grow_sprout",
    growing = true
}, {
    text = "small",
    anim = "crop_small",
    grow_anim = "grow_small",
    growing = true
}, {
    text = "medium",
    anim = "crop_med",
    grow_anim = "grow_med",
    growing = true
}, {
    text = "grown",
    anim = "crop_full",
    grow_anim = "grow_full",
    revealplantname = true,
    fullgrown = true
}, {
    text = "oversized",
    anim = "crop_oversized",
    grow_anim = "grow_oversized",
    revealplantname = true,
    fullgrown = true
}, {
    text = "rotting",
    anim = "crop_rot",
    grow_anim = "grow_rot",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}, {
    text = "oversized_rotting",
    anim = "crop_rot_oversized",
    grow_anim = "grow_rot_oversized",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}}
PLANT_DEFS.aloe.plantregistrywidget = "widgets/redux/farmplantpage"
PLANT_DEFS.aloe.plantregistrysummarywidget = "widgets/redux/farmplantsummarywidget"
PLANT_DEFS.aloe.pictureframeanim = {
    anim = "emoteXL_happycheer",
    time = 0.5
}

PLANT_DEFS.radish.plantregistryinfo = {{
    text = "seed",
    anim = "crop_seed",
    grow_anim = "grow_seed",
    learnseed = true,
    growing = true
}, {
    text = "sprout",
    anim = "crop_sprout",
    grow_anim = "grow_sprout",
    growing = true
}, {
    text = "small",
    anim = "crop_small",
    grow_anim = "grow_small",
    growing = true
}, {
    text = "medium",
    anim = "crop_med",
    grow_anim = "grow_med",
    growing = true
}, {
    text = "grown",
    anim = "crop_full",
    grow_anim = "grow_full",
    revealplantname = true,
    fullgrown = true
}, {
    text = "oversized",
    anim = "crop_oversized",
    grow_anim = "grow_oversized",
    revealplantname = true,
    fullgrown = true
}, {
    text = "rotting",
    anim = "crop_rot",
    grow_anim = "grow_rot",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}, {
    text = "oversized_rotting",
    anim = "crop_rot_oversized",
    grow_anim = "grow_rot_oversized",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}}
PLANT_DEFS.radish.plantregistrywidget = "widgets/redux/farmplantpage"
PLANT_DEFS.radish.plantregistrysummarywidget = "widgets/redux/farmplantsummarywidget"
PLANT_DEFS.radish.pictureframeanim = {
    anim = "emoteXL_happycheer",
    time = 0.5
}

PLANT_DEFS.turnip.plantregistryinfo = {{
    text = "seed",
    anim = "crop_seed",
    grow_anim = "grow_seed",
    learnseed = true,
    growing = true
}, {
    text = "sprout",
    anim = "crop_sprout",
    grow_anim = "grow_sprout",
    growing = true
}, {
    text = "small",
    anim = "crop_small",
    grow_anim = "grow_small",
    growing = true
}, {
    text = "medium",
    anim = "crop_med",
    grow_anim = "grow_med",
    growing = true
}, {
    text = "grown",
    anim = "crop_full",
    grow_anim = "grow_full",
    revealplantname = true,
    fullgrown = true
}, {
    text = "oversized",
    anim = "crop_oversized",
    grow_anim = "grow_oversized",
    revealplantname = true,
    fullgrown = true
}, {
    text = "rotting",
    anim = "crop_rot",
    grow_anim = "grow_rot",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}, {
    text = "oversized_rotting",
    anim = "crop_rot_oversized",
    grow_anim = "grow_rot_oversized",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}}
PLANT_DEFS.turnip.plantregistrywidget = "widgets/redux/farmplantpage"
PLANT_DEFS.turnip.plantregistrysummarywidget = "widgets/redux/farmplantsummarywidget"
PLANT_DEFS.turnip.pictureframeanim = {
    anim = "emoteXL_happycheer",
    time = 0.5
}

PLANT_DEFS.wheat.plantregistryinfo = {{
    text = "seed",
    anim = "crop_seed",
    grow_anim = "grow_seed",
    learnseed = true,
    growing = true
}, {
    text = "sprout",
    anim = "crop_sprout",
    grow_anim = "grow_sprout",
    growing = true
}, {
    text = "small",
    anim = "crop_small",
    grow_anim = "grow_small",
    growing = true
}, {
    text = "medium",
    anim = "crop_med",
    grow_anim = "grow_med",
    growing = true
}, {
    text = "grown",
    anim = "crop_full",
    grow_anim = "grow_full",
    revealplantname = true,
    fullgrown = true
}, {
    text = "oversized",
    anim = "crop_oversized",
    grow_anim = "grow_oversized",
    revealplantname = true,
    fullgrown = true
}, {
    text = "rotting",
    anim = "crop_rot",
    grow_anim = "grow_rot",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}, {
    text = "oversized_rotting",
    anim = "crop_rot_oversized",
    grow_anim = "grow_rot_oversized",
    stagepriority = -100,
    is_rotten = true,
    hidden = true
}}
PLANT_DEFS.wheat.plantregistrywidget = "widgets/redux/farmplantpage"
PLANT_DEFS.wheat.plantregistrysummarywidget = "widgets/redux/farmplantsummarywidget"
PLANT_DEFS.wheat.pictureframeanim = {
    anim = "emoteXL_happycheer",
    time = 0.5
}
-----------------------------------------------------------------------------------
-- Adds the ability to remove health triggers for the healthtrigger component
AddComponentPostInit("healthtrigger", function(self)
    self.AddTrigger = function(self, amount, fn, override)
        if self.triggers[amount] and not override then
            local _oldTriggerFN = self.triggers[amount]
            self.triggers[amount] = function(inst)
                _oldTriggerFN(inst)
                fn(inst)
            end
        else
            self.triggers[amount] = fn
        end
    end
    self.RemoveTrigger = function(self, amount)
        self.triggers[amount] = nil
    end
end)

modimport("scripts/complementos.lua")

----------------------creeps------------------------
-----------------------------------------------creeps----------------------------------------
if GetModConfigData("underwater") then
    table.insert(PrefabFiles, "geothermal_vent")
    table.insert(PrefabFiles, "pearl_amulet")
    table.insert(PrefabFiles, "flare")
    table.insert(PrefabFiles, "squidunderwater")
    table.insert(PrefabFiles, "jelly_cap")
    table.insert(PrefabFiles, "reef_jellyfish")
    table.insert(PrefabFiles, "jellyfishschool")
    table.insert(PrefabFiles, "underwater_entrance")
    table.insert(PrefabFiles, "underwater_exit")
    table.insert(PrefabFiles, "diving_suits")
    table.insert(PrefabFiles, "seatentacle")
    table.insert(PrefabFiles, "seaquaketentacle")
    table.insert(PrefabFiles, "uw_coral")
    table.insert(PrefabFiles, "pearl")
    table.insert(PrefabFiles, "seagrass")
    table.insert(PrefabFiles, "rotting_trunk")
    table.insert(PrefabFiles, "hat_snorkel")
    table.insert(PrefabFiles, "bubble_vent")

    table.insert(PrefabFiles, "flower_sea")
    table.insert(PrefabFiles, "iron_boulder")
    table.insert(PrefabFiles, "iron_ore")
    table.insert(PrefabFiles, "sandstone_boulder")
    table.insert(PrefabFiles, "sandstone")
    table.insert(PrefabFiles, "tidal_node")
    table.insert(PrefabFiles, "sponges")
    table.insert(PrefabFiles, "sponge_piece")

    table.insert(PrefabFiles, "fish_fillet")
    table.insert(PrefabFiles, "fish_fillet_cooked")

    table.insert(PrefabFiles, "bubbles")

    table.insert(PrefabFiles, "commonfish")
    table.insert(PrefabFiles, "lavastone")
    table.insert(PrefabFiles, "clam")
    table.insert(PrefabFiles, "sea_eel")
    table.insert(PrefabFiles, "kelp")
    table.insert(PrefabFiles, "wormplant")
    table.insert(PrefabFiles, "decorative_shell")
    table.insert(PrefabFiles, "citd_preparedfoods")
    table.insert(PrefabFiles, "sea_cucumber")
    table.insert(PrefabFiles, "commonfishschool")
    table.insert(PrefabFiles, "shrimp")
    table.insert(PrefabFiles, "shrimp_tail")
    table.insert(PrefabFiles, "jelly_lantern")
    table.insert(PrefabFiles, "seagrass_chunk")
    table.insert(PrefabFiles, "cut_orange_coral")
    table.insert(PrefabFiles, "cut_blue_coral")
    table.insert(PrefabFiles, "cut_green_coral")
    table.insert(PrefabFiles, "uw_flowers")
    table.insert(PrefabFiles, "sea_petals")
    table.insert(PrefabFiles, "reeflight_small")
    table.insert(PrefabFiles, "coral_cluster")
    table.insert(PrefabFiles, "coral_fish")
    table.insert(PrefabFiles, "fishesunderwater")
    table.insert(PrefabFiles, "dogfish_under")
    table.insert(PrefabFiles, "fish_coi")
    table.insert(PrefabFiles, "lobsterunderwater")
    table.insert(PrefabFiles, "stungrayunderwater")
    table.insert(PrefabFiles, "wreckunderwater")
    table.insert(PrefabFiles, "krakenunderwater_tentacle")
    table.insert(PrefabFiles, "krakenunderwater")
    table.insert(PrefabFiles, "krakenunderwater_spawner")
    table.insert(PrefabFiles, "gaze_beamunderwater")
    table.insert(PrefabFiles, "rock_cave")
    table.insert(PrefabFiles, "coralreefunderwater")
    table.insert(PrefabFiles, "coral_brain_rockunderwater")
    table.insert(PrefabFiles, "hat_submarine")
    table.insert(PrefabFiles, "secretcaveentrance")
    table.insert(PrefabFiles, "jellyfish_underwater")
    table.insert(PrefabFiles, "rainbowjellyfish_underwater")
    table.insert(PrefabFiles, "fishesunderwaternew")
    table.insert(PrefabFiles, "kelpy")
    table.insert(PrefabFiles, "merm_statue")
    table.insert(PrefabFiles, "woodlegs_cage_underwater")
    table.insert(PrefabFiles, "squidundewater2")
    table.insert(PrefabFiles, "swordfishunderwater")
    table.insert(PrefabFiles, "sharxunderwater")
    table.insert(PrefabFiles, "mermkingunderwater")
    table.insert(PrefabFiles, "mermthroneunderwater")
    table.insert(PrefabFiles, "mermwatchtowerunderwater")
    table.insert(PrefabFiles, "mermsunderwater")
    table.insert(PrefabFiles, "roe_fish")
    table.insert(PrefabFiles, "fish_med")
    table.insert(PrefabFiles, "bioluminescence")
    table.insert(PrefabFiles, "kraken_projectile_underwater")
    table.insert(PrefabFiles, "tropicalspawnblocker")
    table.insert(PrefabFiles, "rainbowjellyfish")
    table.insert(PrefabFiles, "jellyfish")
    table.insert(PrefabFiles, "magma_rocks")
    table.insert(PrefabFiles, "limpets")
    table.insert(PrefabFiles, "rock_limpet")
    table.insert(PrefabFiles, "crate")
    table.insert(PrefabFiles, "crabhole")
    table.insert(PrefabFiles, "crab")
    table.insert(PrefabFiles, "coral")
    table.insert(PrefabFiles, "coral_brain")
    table.insert(PrefabFiles, "pig_ruins_pressure_plate")
    table.insert(PrefabFiles, "pig_ruins_spear_trap")
    table.insert(PrefabFiles, "smashingpot")
    table.insert(PrefabFiles, "gnarwailunderwater")
    table.insert(PrefabFiles, "seaweedunderwater")

    -- Add minimap atlas
    AddMinimapAtlas("images/minimap/iron_boulder.xml")
    AddMinimapAtlas("images/minimap/seagrass.xml")
    AddMinimapAtlas("images/minimap/kelp.xml")
    AddMinimapAtlas("images/minimap/vent.xml")
    AddMinimapAtlas("images/minimap/entrance_open.xml")
    AddMinimapAtlas("images/minimap/entrance_closed.xml")
    AddMinimapAtlas("images/minimap/orange_coral.xml")
    AddMinimapAtlas("images/minimap/clam.xml")
    AddMinimapAtlas("images/minimap/sponge.xml")
    AddMinimapAtlas("images/minimap/wormplant.xml")

    modimport "uw_tuning"

    -- RemapSoundEvent("dontstarve/music/music_FE", "dontstarve/music/gramaphone_drstyle") --Again, it's just a placeholder until we have a proper theme

    RegisterInventoryItemAtlas("images/inventoryimages/sponge_piece.xml", "sponge_piece.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/fish_fillet.xml", "fish_fillet.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/fish_fillet_cooked.xml", "fish_fillet_cooked.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/fish_n_chips.xml", "fish_n_chips.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/sponge_cake.xml", "sponge_cake.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/fish_gazpacho.xml", "fish_gazpacho.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/tuna_muffin.xml", "tuna_muffin.tex")
    RegisterInventoryItemAtlas("ATLAS", "images/inventoryimages/sea_cucumber.xml", "sea_cucumber.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/tentacle_sushi.xml", "tentacle_sushi.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/fish_sushi.xml", "fish_sushi.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/flower_sushi.xml", "flower_sushi.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/shrimp_tail.xml", "shrimp_tail.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/sea_petals.xml", "sea_petals.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/seagrass_chunk.xml", "seagrass_chunk.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/sea_petals.xml", "sea_petals.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/jelly_cap.xml", "jelly_cap.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed_cooked.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed_dried")

    -- Mod recipes
    modimport "modrecipes"

    -- Mod cooking recipes and ingredients
    AddIngredientValues({"fish_fillet"}, {
        fish = 1,
        meat = 0.5
    }, true, false)
    AddIngredientValues({"sponge_piece"}, {
        sponge = 1
    }, false, false)
    AddIngredientValues({"seagrass_chunk"}, {
        sea_veggie = 1,
        veggie = 0.5
    }, false, false)
    AddIngredientValues({"trinket_12"}, {
        tentacle = 1,
        meat = 0.5
    }, false, false)
    AddIngredientValues({"petals"}, {
        flower = 1
    }, false, false)
    AddIngredientValues({"sea_petals"}, {
        flower = 1
    }, false, false)
    AddIngredientValues({"jelly_cap"}, {
        sea_jelly = 1
    }, false, false)
    AddIngredientValues({"saltrock"}, {
        saltrock = 1
    }, false, false)

    local sponge_cake = {
        name = "sponge_cake",
        test = function(cooker, names, tags)
            return tags.dairy and tags.sweetener and tags.sponge and tags.sponge and not tags.meat
        end,
        priority = 0,
        weight = 1,
        health = 0,
        hunger = 25,
        sanity = 50,
        perishtime = TUNING.PERISH_SUPERFAST,
        cooktime = .5,
        floater = {"small", 0.05, 0.7},
        tags = {}
    }

    AddCookerRecipe("cookpot", sponge_cake)
    AddCookerRecipe("portablecookpot", sponge_cake)
    AddCookerRecipe("xiuyuan_cookpot", sponge_cake)

    local fish_n_chips = {
        name = "fish_n_chips",
        test = function(cooker, names, tags)
            return tags.fish and tags.fish >= 2 and tags.veggie and tags.veggie >= 2
        end,
        priority = 10,
        weight = 1,
        health = 25,
        hunger = 42.5,
        sanity = 10,
        perishtime = TUNING.PERISH_FAST,
        cooktime = 1,
        floater = {"small", 0.05, 0.7},
        tags = {}
    }

    AddCookerRecipe("cookpot", fish_n_chips)
    AddCookerRecipe("portablecookpot", fish_n_chips)
    AddCookerRecipe("xiuyuan_cookpot", fish_n_chips)

    local tuna_muffin = {
        name = "tuna_muffin",
        test = function(cooker, names, tags)
            return tags.fish and tags.fish >= 1 and tags.sponge and tags.sponge >= 1 and not tags.twigs
        end,
        priority = 5,
        weight = 1,
        health = 0,
        hunger = 32.5,
        sanity = 10,
        perishtime = TUNING.PERISH_MED,
        cooktime = 2,
        floater = {"small", 0.05, 0.7},
        tags = {}
    }

    AddCookerRecipe("cookpot", tuna_muffin)
    AddCookerRecipe("portablecookpot", tuna_muffin)
    AddCookerRecipe("xiuyuan_cookpot", tuna_muffin)

    local tentacle_sushi = {
        name = "tentacle_sushi",
        test = function(cooker, names, tags)
            return tags.tentacle and tags.tentacle and tags.sea_veggie and tags.fish >= 0.5 and not tags.twigs
        end,
        priority = 0,
        weight = 1,
        health = 35,
        hunger = 5,
        sanity = 5,
        perishtime = TUNING.PERISH_MED,
        cooktime = 2,
        floater = {"small", 0.05, 0.7},
        tags = {}
    }

    AddCookerRecipe("cookpot", tentacle_sushi)
    AddCookerRecipe("portablecookpot", tentacle_sushi)
    AddCookerRecipe("xiuyuan_cookpot", tentacle_sushi)

    local flower_sushi = {
        name = "flower_sushi",
        test = function(cooker, names, tags)
            return tags.flower and tags.sea_veggie and tags.fish and tags.fish >= 1 and not tags.twigs
        end,
        priority = 0,
        weight = 1,
        health = 10,
        hunger = 5,
        sanity = 30,
        perishtime = TUNING.PERISH_MED,
        cooktime = 2,
        floater = {"small", 0.05, 0.7},
        tags = {}
    }

    AddCookerRecipe("cookpot", flower_sushi)
    AddCookerRecipe("portablecookpot", flower_sushi)
    AddCookerRecipe("xiuyuan_cookpot", flower_sushi)

    local fish_sushi = {
        name = "fish_sushi",
        test = function(cooker, names, tags)
            return tags.tentacle and tags.veggie >= 1 and tags.fish and tags.fish >= 1 and not tags.twigs
        end,
        priority = 0,
        weight = 1,
        health = 5,
        hunger = 50,
        sanity = 0,
        perishtime = TUNING.PERISH_MED,
        cooktime = 2,
        floater = {"small", 0.05, 0.7},
        tags = {}
    }

    AddCookerRecipe("cookpot", fish_sushi)
    AddCookerRecipe("portablecookpot", fish_sushi)
    AddCookerRecipe("xiuyuan_cookpot", fish_sushi)

    local seajelly = {
        name = "seajelly",
        test = function(cooker, names, tags)
            return tags.sea_jelly and tags.sea_jelly > 1 and names.saltrock and names.saltrock > 1 and not tags.meat
        end,
        priority = 0,
        weight = 1,
        health = 20,
        hunger = 40,
        sanity = 3,
        perishtime = TUNING.PERISH_SLOW,
        cooktime = 2,
        floater = {"small", 0.05, 0.7},
        tags = {}
    }

    AddCookerRecipe("cookpot", seajelly)
    AddCookerRecipe("portablecookpot", seajelly)
    AddCookerRecipe("xiuyuan_cookpot", seajelly)

    RegisterInventoryItemAtlas("images/inventoryimages/sponge_piece.xml", "sponge_piece.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/fish_fillet.xml", "fish_fillet.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/fish_fillet_cooked.xml", "fish_fillet_cooked.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/fish_n_chips.xml", "fish_n_chips.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/sponge_cake.xml", "sponge_cake.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/fish_gazpacho.xml", "fish_gazpacho.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/tuna_muffin.xml", "tuna_muffin.tex")
    RegisterInventoryItemAtlas("ATLAS", "images/inventoryimages/sea_cucumber.xml", "sea_cucumber.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/tentacle_sushi.xml", "tentacle_sushi.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/fish_sushi.xml", "fish_sushi.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/food/flower_sushi.xml", "flower_sushi.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/shrimp_tail.xml", "shrimp_tail.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/sea_petals.xml", "sea_petals.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/seagrass_chunk.xml", "seagrass_chunk.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/sea_petals.xml", "sea_petals.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/jelly_cap.xml", "jelly_cap.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed_cooked.tex")
    RegisterInventoryItemAtlas("images/inventoryimages/volcanoinventory.xml", "seaweed_dried")

    -- TheSim:RemapSoundEvent("dontstarve/music/music_dawn_stinger", "citd/music/music_dawn_stinger")
    -- TheSim:RemapSoundEvent("dontstarve/music/music_dusk_stinger", "citd/music/music_dusk_stinger")

    AddPrefabPostInitAny(function(inst)
        if inst.prefab == "trinket_12" then
            inst:AddTag("edible")
        end
        -------- Add bubbles on destruction
        if inst.components and (inst.components.workable or inst.components.health) then
            inst:AddComponent("deathbubbles")
        end

        if inst:HasTag("player") then
            inst:AddComponent("bubbleblower") ------- Blow bubble underwater to players
            inst:AddComponent("oxygen")
            ---------- Custom Oxygen Levels
            if inst.prefab == "willow" then
                inst.components.oxygen.max = 80
            end
            if inst.prefab == "wilson" then
                inst.components.oxygen.max = 100
            end
            if inst.prefab == "wolfgang" then
                inst.components.oxygen.max = 150
            end
            if inst.prefab == "waxwell" then
                inst.components.oxygen.max = 120
            end
            if inst.prefab == "woodie" then
                inst.components.oxygen.max = 150
            end
            if inst.prefab == "wendy" then
                inst.components.oxygen.max = 80
            end
            if inst.prefab == "wickerbottom" then
                inst.components.oxygen.max = 100
            end
            if inst.prefab == "wes" then
                inst.components.oxygen.max = 55
            end
            if inst.prefab == "wigfrid" then
                inst.components.oxygen.max = 150
            end
            if inst.prefab == "webber" then
                inst.components.oxygen.max = 85
            end
            if inst.prefab == "wurt" then
                inst.components.oxygen.max = 5000
                inst.components.oxygen.current = 5000
            end

            inst:ListenForEvent("runningoutofoxygen", function(inst, data)
                inst.components.talker:Say("Low Oxygen") -- GetString(inst.prefab, "ANNOUNCE_OUT_OF_OXYGEN"))
            end)

            inst:ListenForEvent("startdrowning", function(inst, data)
                if inst.HUD then
                    inst.HUD.bloodover:UpdateState()
                end
            end, inst)

            inst:ListenForEvent("stopdrowning", function(inst, data)
                if inst.HUD then
                    inst.HUD.bloodover:UpdateState()
                end
            end, inst)

            -- WX78 is a robot!
            if inst.prefab == "wx78" then
                inst:AddTag("robot")
            end

        end

    end)

    AddPrefabPostInit("cave", function(inst)
        if GLOBAL.TheWorld.ismastersim then
            inst:AddComponent("underwaterspawner")
        end

    end)

    AddComponentPostInit("fueled", function(self)
        ------------------------
        function self:Ignite(immediate, source, doer)
            local map = GLOBAL.TheWorld.Map
            local x, y, z = self.inst.Transform:GetWorldPosition()
            local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
            if ground == GROUND.UNDERWATER_SANDY or ground == GROUND.UNDERWATER_ROCKY or
                (ground == GROUND.BEACH and GLOBAL.TheWorld:HasTag("cave")) or
                (ground == GROUND.BATTLEGROUND and GLOBAL.TheWorld:HasTag("cave")) or
                (ground == GROUND.PEBBLEBEACH and GLOBAL.TheWorld:HasTag("cave")) or
                (ground == GROUND.MAGMAFIELD and GLOBAL.TheWorld:HasTag("cave")) or
                (ground == GROUND.PAINTED and GLOBAL.TheWorld:HasTag("cave")) then
                return false
            end
            ------------------------
            if not (self.burning or self.inst:HasTag("fireimmune")) then
                self:StopSmoldering()

                self.burning = true
                self.inst:ListenForEvent("death", OnKilled)
                self:SpawnFX(immediate)

                self.inst:PushEvent("onignite", {
                    doer = doer
                })
                if self.onignite ~= nil then
                    self.onignite(self.inst)
                end

                if self.inst.components.fueled ~= nil then
                    self.inst.components.fueled:StartConsuming()
                end

                if self.inst.components.propagator ~= nil then
                    self.inst.components.propagator:StartSpreading(source)
                end

                self:ExtendBurning()
            end
        end
    end)
    ------------------------------------
    modimport("scripts/widgets/oxygendisplay.lua")

end
-------------------fim  creeps--------------

------------inicio builder----------------
function RoundBiasedUp(num, idp)
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

AddComponentPostInit("builder", function(self)

    self.brainjelly = false

    function self:GetMoney(inventory)
        local money = 0

        local hasoincs, oincamount = inventory:Has("oinc", 0)
        local hasoinc10s, oinc10amount = inventory:Has("oinc10", 0)
        local hasoinc100s, oinc100amount = inventory:Has("oinc100", 0)

        money = oincamount + (oinc10amount * 10) + (oinc100amount * 100)
        return money
    end

    function self:PayMoney(inventory, cost)
        local hasoincs, oincamount = inventory:Has("oinc", 0)
        local hasoinc10s, oinc10amount = inventory:Has("oinc10", 0)
        local hasoinc100s, oinc100amount = inventory:Has("oinc100", 0)
        local debt = cost

        local oincused = 0
        local oinc10used = 0
        local oinc100used = 0
        local oincgained = 0
        local oinc10gained = 0
        while debt > 0 do
            while debt > 0 and oincamount > 0 do
                oincamount = oincamount - 1
                debt = debt - 1
                oincused = oincused + 1
            end
            if debt > 0 then
                if oinc10amount > 0 then
                    oinc10amount = oinc10amount - 1
                    oinc10used = oinc10used + 1
                    for i = 1, 10 do
                        oincamount = oincamount + 1
                        oincgained = oincgained + 1
                    end
                elseif oinc100amount > 0 then
                    oinc100amount = oinc100amount - 1
                    oinc100used = oinc100used + 1
                    for i = 1, 10 do
                        oinc10amount = oinc10amount + 1
                        oinc10gained = oinc10gained + 1
                    end
                end
            end
        end
        local oincresult = oincgained - oincused
        if oincresult > 0 then
            for i = 1, oincresult do
                local coin = SpawnPrefab("oinc")
                inventory:GiveItem(coin)
            end
        end
        if oincresult < 0 then
            for i = 1, math.abs(oincresult) do
                inventory:ConsumeByName("oinc", 1)
            end
        end
        local oinc10result = oinc10gained - oinc10used
        if oinc10result > 0 then
            for i = 1, oinc10result do
                local coin = SpawnPrefab("oinc10")
                inventory:GiveItem(coin)
            end
        end
        if oinc10result < 0 then
            for i = 1, math.abs(oinc10result) do
                inventory:ConsumeByName("oinc10", 1)
            end
        end
        local oinc100result = 0 - oinc100used
        if oinc100result < 0 then
            for i = 1, math.abs(oinc100result) do
                inventory:ConsumeByName("oinc100", 1)
            end
        end
    end

    function self:RemoveIngredients(ingredients, recname)
        local recipe = GetValidRecipe(recname)
        if recipe == nil then
            return false
        end

        for i, v in ipairs(recipe.ingredients) do
            if v.type == "oinc" and not self.freebuildmode then
                self:PayMoney(self.inst.components.inventory, v.amount)
            end
        end

        for item, ents in pairs(ingredients) do
            for k, v in pairs(ents) do
                for i = 1, v do
                    if item ~= "oinc" then
                        local item = self.inst.components.inventory:RemoveItem(k, false)

                        -- If the item we're crafting with is a container,
                        -- drop the contained items onto the ground.
                        if item.components.container ~= nil then
                            item.components.container:DropEverything(self.inst:GetPosition())
                        end

                        item:Remove()
                    end
                end
            end
        end

        local recipe = AllRecipes[recname]
        if recipe then
            for k, v in pairs(recipe.character_ingredients) do
                if v.type == CHARACTER_INGREDIENT.HEALTH then
                    -- Don't die from crafting!
                    local delta = math.min(math.max(0, self.inst.components.health.currenthealth - 1), v.amount)
                    self.inst:PushEvent("consumehealthcost")
                    self.inst.components.health:DoDelta(-delta, false, "builder", true, nil, true)
                elseif v.type == CHARACTER_INGREDIENT.MAX_HEALTH then
                    self.inst:PushEvent("consumehealthcost")
                    self.inst.components.health:DeltaPenalty(v.amount)
                elseif v.type == CHARACTER_INGREDIENT.SANITY then
                    self.inst.components.sanity:DoDelta(-v.amount)
                elseif v.type == CHARACTER_INGREDIENT.MAX_SANITY then
                    --[[
                    Because we don't have any maxsanity restoring items we want to be more careful
                    with how we remove max sanity. Because of that, this is not handled here.
                    Removal of sanity is actually managed by the entity that is created.
                    See maxwell's pet leash on spawn and pet on death functions for examples.
                --]]
                end
            end
        end
        self.inst:PushEvent("consumeingredients")
    end

    local function GiveOrDropItem(self, recipe, item, pt)
        if recipe.dropitem then
            local angle = (self.inst.Transform:GetRotation() + GetRandomMinMax(-65, 65)) * DEGREES
            local r = item:GetPhysicsRadius(0.5) + self.inst:GetPhysicsRadius(0.5) + 0.1
            item.Transform:SetPosition(pt.x + r * math.cos(angle), pt.y, pt.z - r * math.sin(angle))
            item.components.inventoryitem:OnDropped()
        else
            self.inst.components.inventory:GiveItem(item, nil, pt)
        end
    end

    function self:DoBuild(recname, pt, rotation, skin)
        local recipe = GetValidRecipe(recname)
        if recipe ~= nil and (self:IsBuildBuffered(recname) or self:CanBuild(recname)) then
            if recipe.placer ~= nil and self.inst.components.rider ~= nil and self.inst.components.rider:IsRiding() then
                return false, "MOUNTED"
            elseif recipe.level.ORPHANAGE > 0 and
                (self.inst.components.petleash == nil or self.inst.components.petleash:IsFull() or
                    self.inst.components.petleash:HasPetWithTag("critter")) then
                return false, "HASPET"
            elseif recipe.tab.manufacturing_station and
                (self.current_prototyper == nil or not self.current_prototyper:IsValid() or
                    self.current_prototyper.components.prototyper == nil or
                    not CanPrototypeRecipe(recipe.level, self.current_prototyper.components.prototyper.trees)) then
                -- manufacturing stations requires the current active protyper in order to work
                return false
            end

            local is_buffered_build = self.buffered_builds[recname] ~= nil
            if is_buffered_build then
                self.buffered_builds[recname] = nil
                self.inst.replica.builder:SetIsBuildBuffered(recname, false)
            end

            if self.inst:HasTag("hungrybuilder") and not self.inst.sg:HasStateTag("slowaction") then
                local t = GetTime()
                if self.last_hungry_build == nil or t > self.last_hungry_build + TUNING.HUNGRY_BUILDER_RESET_TIME then
                    self.inst.components.hunger:DoDelta(TUNING.HUNGRY_BUILDER_DELTA)
                    self.inst:PushEvent("hungrybuild")
                end
                self.last_hungry_build = t
            end

            self.inst:PushEvent("refreshcrafting")

            if recipe.tab.manufacturing_station then
                local materials = self:GetIngredients(recname)
                self:RemoveIngredients(materials, recname)
                -- its up to the prototyper to implement onactivate and handle spawning the prefab
                return true
            end

            if self.inst and self.inst.components.inventory and
                self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) and
                self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD):HasTag("brainjelly") then
                if self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD).components.finiteuses then
                    self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD).components.finiteuses:Use(1)
                end
            end
            local prod = SpawnPrefab(recipe.product, recipe.chooseskin or skin, nil, self.inst.userid) or nil
            if prod ~= nil then
                pt = pt or self.inst:GetPosition()

                if prod.components.inventoryitem ~= nil then
                    if self.inst.components.inventory ~= nil then
                        local materials = self:GetIngredients(recname)

                        local wetlevel = self:GetIngredientWetness(materials)
                        if wetlevel > 0 and prod.components.inventoryitem ~= nil then
                            prod.components.inventoryitem:InheritMoisture(wetlevel, self.inst:GetIsWet())
                        end

                        if prod.onPreBuilt ~= nil then
                            prod:onPreBuilt(self.inst, materials, recipe)
                        end

                        self:RemoveIngredients(materials, recname)

                        -- self.inst.components.inventory:GiveItem(prod)
                        self.inst:PushEvent("builditem", {
                            item = prod,
                            recipe = recipe,
                            skin = skin,
                            prototyper = self.current_prototyper
                        })
                        if self.current_prototyper ~= nil and self.current_prototyper:IsValid() then
                            self.current_prototyper:PushEvent("builditem", {
                                item = prod,
                                recipe = recipe,
                                skin = skin
                            }) -- added this back for the gorge.
                        end
                        ProfileStatsAdd("build_" .. prod.prefab)

                        if prod.components.equippable ~= nil and not recipe.dropitem and
                            self.inst.components.inventory:GetEquippedItem(prod.components.equippable.equipslot) == nil and
                            not prod.components.equippable:IsRestricted(self.inst) then
                            if recipe.numtogive <= 1 then
                                -- The item is equippable. Equip it.
                                self.inst.components.inventory:Equip(prod)
                            elseif prod.components.stackable ~= nil then
                                -- The item is stackable. Just increase the stack size of the original item.
                                prod.components.stackable:SetStackSize(recipe.numtogive)
                                self.inst.components.inventory:Equip(prod)
                            else
                                -- We still need to equip the original product that was spawned, so do that.
                                self.inst.components.inventory:Equip(prod)
                                -- Now spawn in the rest of the items and give them to the player.
                                for i = 2, recipe.numtogive do
                                    local addt_prod = SpawnPrefab(recipe.product)
                                    self.inst.components.inventory:GiveItem(addt_prod, nil, pt)
                                end
                            end
                        elseif recipe.numtogive <= 1 then
                            -- Only the original item is being received.
                            GiveOrDropItem(self, recipe, prod, pt)
                        elseif prod.components.stackable ~= nil then
                            -- The item is stackable. Just increase the stack size of the original item.
                            prod.components.stackable:SetStackSize(recipe.numtogive)
                            GiveOrDropItem(self, recipe, prod, pt)
                        else
                            -- We still need to give the player the original product that was spawned, so do that.
                            GiveOrDropItem(self, recipe, prod, pt)
                            -- Now spawn in the rest of the items and give them to the player.
                            for i = 2, recipe.numtogive do
                                local addt_prod = SpawnPrefab(recipe.product)
                                GiveOrDropItem(self, recipe, addt_prod, pt)
                            end
                        end

                        NotifyPlayerProgress("TotalItemsCrafted", 1, self.inst)

                        if self.onBuild ~= nil then
                            self.onBuild(self.inst, prod)
                        end
                        prod:OnBuilt(self.inst)

                        return true
                    else
                        prod:Remove()
                        prod = nil
                    end
                else
                    if not is_buffered_build then -- items that have intermediate build items (like statues)
                        local materials = self:GetIngredients(recname)
                        self:RemoveIngredients(materials, recname)
                    end

                    local spawn_pos = pt

                    -- If a non-inventoryitem recipe specifies dropitem, position the created object
                    -- away from the builder so that they don't overlap.
                    if recipe.dropitem then
                        local angle = (self.inst.Transform:GetRotation() + GetRandomMinMax(-65, 65)) * DEGREES
                        local r = prod:GetPhysicsRadius(0.5) + self.inst:GetPhysicsRadius(0.5) + 0.1
                        spawn_pos = Vector3(spawn_pos.x + r * math.cos(angle), spawn_pos.y,
                            spawn_pos.z - r * math.sin(angle))
                    end

                    prod.Transform:SetPosition(spawn_pos:Get())
                    -- V2C: or 0 check added for backward compatibility with mods that
                    --     have not been updated to support placement rotation yet
                    prod.Transform:SetRotation(rotation or 0)
                    self.inst:PushEvent("buildstructure", {
                        item = prod,
                        recipe = recipe,
                        skin = skin
                    })
                    prod:PushEvent("onbuilt", {
                        builder = self.inst,
                        pos = pt
                    })
                    ProfileStatsAdd("build_" .. prod.prefab)
                    NotifyPlayerProgress("TotalItemsCrafted", 1, self.inst)

                    if self.onBuild ~= nil then
                        self.onBuild(self.inst, prod)
                    end

                    prod:OnBuilt(self.inst)

                    return true
                end
            end
        end
    end

    function self:CanBuild(recname)
        if self:IsBuildBuffered(recname) then
            return true
        end
        local recipe = GetValidRecipe(recname)
        if recipe == nil then
            return false
            ---------------		
        elseif self.brainjelly then
            for i, v in ipairs(recipe.ingredients) do
                if not self.inst.components.inventory:Has(v.type,
                    math.max(1, RoundBiasedUp(v.amount * self.ingredientmod))) then
                    return false
                end
            end
            ---------------				

        elseif not self.freebuildmode then
            for i, v in ipairs(recipe.ingredients) do

                if v.type == "oinc" then
                    if self:GetMoney(self.inst.components.inventory) >= v.amount then
                        return true
                    end
                end
                if not self.inst.components.inventory:Has(v.type,
                    math.max(1, RoundBiasedUp(v.amount * self.ingredientmod))) then
                    return false
                end
            end
        end
        for i, v in ipairs(recipe.character_ingredients) do
            if not self:HasCharacterIngredient(v) then
                return false
            end
        end
        for i, v in ipairs(recipe.tech_ingredients) do
            if not self:HasTechIngredient(v) then
                return false
            end
        end
        return true
    end

    function self:MakeRecipeAtPoint(recipe, pt, rot, skin)
        ----------------------------------------------------------
        if recipe.product == "sprinkler1" and
            (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.FARMING_SOIL) then
            return self:MakeRecipe(recipe, pt, rot, skin)
        end
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.UNDERWATER_SANDY) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.UNDERWATER_ROCKY) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.BEACH and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.MAGMAFIELD and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.PAINTED and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.BATTLEGROUND and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.PEBBLEBEACH and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if recipe.placer ~= nil and --        self:KnowsRecipe(recipe.name) and
        self:IsBuildBuffered(recipe.name) and GLOBAL.TheWorld.Map:CanDeployRecipeAtPoint(pt, recipe, rot) then
            self:MakeRecipe(recipe, pt, rot, skin)
        end
    end

end)

AddClassPostConstruct("components/builder_replica", function(self)
    function self:GetMoney(inventory)
        local money = 0

        local hasoincs, oincamount = inventory:Has("oinc", 0)
        local hasoinc10s, oinc10amount = inventory:Has("oinc10", 0)
        local hasoinc100s, oinc100amount = inventory:Has("oinc100", 0)

        money = oincamount + (oinc10amount * 10) + (oinc100amount * 100)
        return money
    end

    function self:CanBuild(recipename)
        if self:IsBuildBuffered(recipename) then
            return true
        end
        if self.inst.components.builder ~= nil then
            return self.inst.components.builder:CanBuild(recipename)
        elseif self.classified ~= nil then
            local recipe = GetValidRecipe(recipename)
            if recipe == nil then
                return false
            elseif not self.classified.isfreebuildmode:value() then
                for i, v in ipairs(recipe.ingredients) do
                    if v.type == "oinc" then
                        if self:GetMoney(self.inst.replica.inventory) >= v.amount then
                            return true
                        end
                    end
                    if not self.inst.replica.inventory:Has(v.type,
                        math.max(1, RoundBiasedUp(v.amount * self:IngredientMod()))) then
                        return false
                    end
                end
            end
            for i, v in ipairs(recipe.character_ingredients) do
                if not self:HasCharacterIngredient(v) then
                    return false
                end
            end
            for i, v in ipairs(recipe.tech_ingredients) do
                if not self:HasTechIngredient(v) then
                    return false
                end
            end
            return true
        else
            return false
        end
    end

    function self:CanBuildAtPoint(pt, recipe, rot)
        if recipe.product == "sprinkler1" and
            (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.FARMING_SOIL) then
            return true
        end

        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.UNDERWATER_SANDY) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.UNDERWATER_ROCKY) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.BEACH and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.MAGMAFIELD and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.PAINTED and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.BATTLEGROUND and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        if (GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.PEBBLEBEACH and
            GLOBAL.TheWorld:HasTag("cave")) then
            return false
        end -- adicionado por vagner
        return GLOBAL.TheWorld.Map:CanDeployRecipeAtPoint(pt, recipe, rot)
    end

end)
