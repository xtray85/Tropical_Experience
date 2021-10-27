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

_G = GLOBAL; require, rawget, getmetatable, unpack = _G.require, _G.rawget, _G.getmetatable, _G.unpack
TheNet = _G.TheNet; IsServer, IsDedicated = TheNet:GetIsServer(), TheNet:IsDedicated()
TheSim = _G.TheSim
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


-- Usados no portal the forge: lavaarena_spawner, quagmire_key, lavarenainside
modimport "scripts/tuning.lua"

AddMinimapAtlas("map_icons/hamleticon.xml")
--configurar idioma

AddModCharacter("walani", "FEMALE")
AddModCharacter("wilbur", "NEUTRAL")
AddModCharacter("woodlegs", "MALE")

RemapSoundEvent( "dontstarve/characters/walani/yawn", "sw_character/characters/walani/yawn" )
RemapSoundEvent( "dontstarve/characters/walani/carol", "sw_character/characters/walani/carol" )
RemapSoundEvent( "dontstarve/characters/walani/sleepy", "sw_character/characters/walani/sleepy" )

RemapSoundEvent( "dontstarve/characters/wilbur/yawn", "sw_character/characters/wilbur/yawn" )
RemapSoundEvent( "dontstarve/characters/wilbur/carol", "sw_character/characters/wilbur/carol" )
RemapSoundEvent( "dontstarve/characters/wilbur/sleepy", "sw_character/characters/wilbur/sleepy" )

RemapSoundEvent( "dontstarve/characters/woodlegs/yawn", "sw_character/characters/woodlegs/yawn" )
RemapSoundEvent( "dontstarve/characters/woodlegs/carol", "sw_character/characters/woodlegs/carol" )
RemapSoundEvent( "dontstarve/characters/woodlegs/sleepy", "sw_character/characters/woodlegs/sleepy" )
 
--Wilbur
GLOBAL.STRINGS.CHARACTER_TITLES.wilbur = "The Monkey King"
GLOBAL.STRINGS.CHARACTER_NAMES.wilbur = "Wilbur"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.wilbur = "*Can't talk\n*Slow as biped, but fast as quadruped\n*Is a monkey"
GLOBAL.STRINGS.CHARACTER_QUOTES.wilbur =  "\"Ooo ooa oah ah!\""
GLOBAL.STRINGS.NAMES.WILBUR = "Wilbur"
GLOBAL.STRINGS.CHARACTER_ABOUTME.wilbur = "Can't talk Slow as biped, fast as quadruped Is a monkey"
GLOBAL.STRINGS.CHARACTER_SURVIVABILITY.wilbur = "Slim"
TUNING.WILBUR_HEALTH = 125
TUNING.WILBUR_SANITY = 150
TUNING.WILBUR_HUNGER = 175
 
--Woodlegs:
GLOBAL.STRINGS.CHARACTER_TITLES.woodlegs = "The Pirate Captain"
GLOBAL.STRINGS.CHARACTER_NAMES.woodlegs = "Woodlegs"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.woodlegs = "*Has his lucky hat\n*Has his lucky cutlass\n*Pirate"
GLOBAL.STRINGS.CHARACTER_QUOTES.woodlegs =  "\"Don't ye mind th'scurvy. Yarr-harr-harr!\""
GLOBAL.STRINGS.CHARACTERS.WOODLEGS = require "speech_woodlegs"
GLOBAL.STRINGS.NAMES.WOODLEGS = "Woodlegs"
GLOBAL.STRINGS.CHARACTER_ABOUTME.woodlegs = "Don't ye mind th'scurvy. Yarr-harr-harr!"
GLOBAL.STRINGS.CHARACTER_SURVIVABILITY.woodlegs = "Grim"
TUNING.WOODLEGS_HEALTH = 150
TUNING.WOODLEGS_SANITY = 120
TUNING.WOODLEGS_HUNGER = 150
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WOODLEGS = { "luckyhat", "boatcannon", "boards", "boards", "boards", "boards", "dubloon", "dubloon", "dubloon", "dubloon" }
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["luckyhat"] = {
    atlas = "images/inventoryimages/volcanoinventory.xml",
    image = "luckyhat.tex",
}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["boatcannon"] = {
    atlas = "images/inventoryimages/volcanoinventory.xml",
    image = "boatcannon.tex",
}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["dubloon"] = {
    atlas = "images/inventoryimages/volcanoinventory.xml",
    image = "dubloon.tex",
}

--Walani
GLOBAL.STRINGS.CHARACTER_TITLES.walani = "The Unperturbable"
GLOBAL.STRINGS.CHARACTER_NAMES.walani = "Walani"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.walani = "*Loves surfing\n*Dries off quickly\n*Is a pretty chill gal"
GLOBAL.STRINGS.CHARACTER_QUOTES.walani =  "\"Forgive me if I don't get up. I don't want to.\""
GLOBAL.STRINGS.CHARACTERS.WALANI = require "speech_walani"
GLOBAL.STRINGS.NAMES.WALANI = "Walani"
GLOBAL.STRINGS.CHARACTER_ABOUTME.walani = "Forgive me if I don't get up. I don't want to."
GLOBAL.STRINGS.CHARACTER_SURVIVABILITY.walani = "Slim"
TUNING.WALANI_HEALTH = 120
TUNING.WALANI_SANITY = 200
TUNING.WALANI_HUNGER = 200

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WALANI = { "surfboarditem" }
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["surfboarditem"] = {
    atlas = "images/inventoryimages/volcanoinventory.xml",
    image = "surfboarditem.tex",
}

AddIngredientValues({"butterfly_tropical_wings"}, {veggie=0.5}, true, false)

AddModRPCHandler("volcanomod", "quest1", function(inst)
local portalinvoca1 = GLOBAL.SpawnPrefab("log")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+4, b, c-4)

GLOBAL.TheFrontEnd:PopScreen()
GLOBAL.SetPause(false)
--inst:Remove()
end)
AddModRPCHandler("volcanomod", "quest2", function(inst)
GLOBAL.TheFrontEnd:PopScreen()
GLOBAL.SetPause(false)
--inst:Remove()
end)

GLOBAL.CHERRY = false
if GLOBAL.KnownModIndex:IsModEnabled("workshop-1289779251") then GLOBAL.CHERRY = true end

--------------store---------

modimport("functions/MagicStore.lua")
modimport("functions/DataProvider.lua")
--------------------------------------
------------------------------------------------forge weapons inicio---------------------------------------------------------
local defaultAtlas = "images/inventoryimages.xml"
local customAtlas = "images/tfwp_inventoryimgs.xml"

local tmpTable = 
{
    tfwp_control_book = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 6),
            Ingredient("papyrus", 5),
            Ingredient("bluegem", 5),
        },
        atlas = customAtlas,
        texture = "tfwp_control_book.tex",
        spell = "tfwp_control_book",
    },
    tfwp_summon_book = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 6),
            Ingredient("papyrus", 5),
            Ingredient("redgem", 5),
        },
        atlas = defaultAtlas,
        texture = "book_elemental.tex",
        spell = "tfwp_summon_book",
    },
    tfwp_lava_hammer = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 6),
            Ingredient("hammer", 1),
            Ingredient("livinglog", 2),
        }, 
        atlas = customAtlas,
        texture = "tfwp_lava_hammer.tex",
        spell = "tfwp_lava_hammer",
    },
    tfwp_spear_gung = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 6),
            Ingredient("spear", 1),
            Ingredient("livinglog", 2),
        }, 
        atlas = customAtlas,
        texture = "tfwp_spear_gung.tex",
        spell = "tfwp_spear_gung",
    },
    tfwp_spear_lance = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 4),
            Ingredient("spear", 1),
            Ingredient("purplegem", 5),
        }, 
        atlas = customAtlas,
        texture = "tfwp_spear_lance.tex",
        spell = "tfwp_spear_lance",
    },
    tfwp_healing_staff = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 4),
            Ingredient("livinglog", 1),
            Ingredient("purplegem", 3),
        }, 
        atlas = defaultAtlas,
        texture = "healingstaff.tex",
        spell = "tfwp_healing_staff",
    },
    tfwp_infernal_staff = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 4),
            Ingredient("livinglog", 1),
            Ingredient("purplegem", 3),
        }, 
        atlas = customAtlas,
        texture = "tfwp_infernal_staff.tex",
        spell = "tfwp_infernal_staff",
    },
    tfwp_dragon_dart = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 4),
            Ingredient("cutreeds", 5),
            Ingredient("purplegem", 2),
        }, 
        atlas = defaultAtlas,
        texture = "blowdart_lava2.tex",
        spell = "tfwp_dragon_dart",
    },
    tfwp_lava_dart = 
    {
        recipe = 
        {
            Ingredient("nightmarefuel", 4),
            Ingredient("cutreeds", 5),
            Ingredient("purplegem", 2),
        }, 
        atlas = defaultAtlas,
        texture = "blowdart_lava.tex",
        spell = "tfwp_lava_dart",
    },
    tfwp_fire_bomb = 
    {
        recipe = 
        {
            Ingredient("nitre", 6),
            Ingredient("rope", 4),
            Ingredient("nightmarefuel", 4),
        }, 
        atlas = defaultAtlas,
        texture = "lavaarena_firebomb.tex",
        spell = "tfwp_fire_bomb",
        count = 5,
    },
    tfwp_heavy_sword = 
    {
        recipe = 
        {
            Ingredient("rocks", 15),
            Ingredient("moonrocknugget", 8),
            Ingredient("nightmarefuel", 4),
        }, 
        atlas = customAtlas,
        texture = "tfwp_heavy_sword.tex",
        spell = "tfwp_parry",
    },
    --armor
    tfwp_steel_wool_armor = 
    {
        recipe = 
        {
            Ingredient("steelwool", 1),
            Ingredient("goldnugget", 2),
            Ingredient("boneshard", 5),
        }, 
        atlas = customAtlas,
        texture = "tfwp_steel_wool_armor.tex",
    },
    tfwp_moon_heavy_armor = 
    {
        recipe = 
        {
            Ingredient("moonrocknugget", 8),
            Ingredient("armorgrass", 1),
        }, 
        atlas = customAtlas,
        texture = "tfwp_moon_heavy_armor.tex",
    },
    tfwp_golden_chain_armor = 
    {
        recipe = 
        {
            Ingredient("goldnugget", 8),
            Ingredient("rope", 4),
        }, 
        atlas = customAtlas,
        texture = "tfwp_golden_chain_armor.tex",
    },
    tfwp_leather_light_armor = 
    {
        recipe = 
        {
            Ingredient("pigskin", 4),
            Ingredient("rope", 4),
            Ingredient("boneshard", 2),
        }, 
        atlas = customAtlas,
        texture = "tfwp_leather_light_armor.tex",
    },
    tfwp_grass_tunic_armor = 
    {
        recipe = 
        {
            Ingredient("feather_robin", 2),
            Ingredient("armorgrass", 1),
            Ingredient("houndstooth", 1),
        }, 
        atlas = customAtlas,
        texture = "tfwp_grass_tunic_armor.tex",
    },
    tfwp_worm_suit_armor = 
    {
        recipe = 
        {
            Ingredient("tentaclespots", 2),
            Ingredient("armorgrass", 1),
            Ingredient("nightmarefuel", 4),
        }, 
        atlas = customAtlas,
        texture = "tfwp_worm_suit_armor.tex",
    },
    tfwp_hypno_coat_armor = 
    {
        recipe = 
        {
            Ingredient("purplegem", 2),
            Ingredient("armorgrass", 1),
            Ingredient("nightmarefuel", 8),
        }, 
        atlas = customAtlas,
        texture = "tfwp_hypno_coat_armor.tex",
    },
    tfwp_tusk_vest_armor = 
    {
        recipe = 
        {
            Ingredient("houndstooth", 4),
            Ingredient("beefalowool", 6),
            Ingredient("nightmarefuel", 4),
        }, 
        atlas = customAtlas,
        texture = "tfwp_tusk_vest_armor.tex",
    },
    --hats
    tfwp_barbed_helm_hat = 
    {
        recipe = 
        {
            Ingredient("boneshard", 2),
            Ingredient("cutstone", 3),
            Ingredient("goldnugget", 3),
        }, 
        atlas = customAtlas,
        texture = "tfwp_barbed_helm_hat.tex",
    },
    tfwp_nox_helm_hat = 
    {
        recipe = 
        {
            Ingredient("horn", 2),
            Ingredient("moonrocknugget", 2),
            Ingredient("tfwp_barbed_helm_hat", 1, customAtlas),
        }, 
        atlas = defaultAtlas,
        texture = "lavaarena_strongdamagerhat.tex",
    },
    tfwp_luxury_nox_helm_hat = 
    {
        recipe = 
        {
            Ingredient("tfwp_nox_helm_hat", 1, customAtlas),
            Ingredient("horn", 1),
            Ingredient("goldnugget", 4),
        }, 
        atlas = defaultAtlas,
        texture = "lavaarena_crowndamagerhat.tex",
    },
    tfwp_crystal_crown_hat = 
    {
        recipe = 
        {
            Ingredient("redgem", 2),
            Ingredient("bluegem", 2),
            Ingredient("moonrocknugget", 4),
        }, 
        atlas = defaultAtlas,
        texture = "lavaarena_rechargerhat.tex",
    },
    tfwp_wizard_crown_hat = 
    {
        recipe = 
        {
            Ingredient("purplegem", 3),
            Ingredient("boneshard", 2),
            Ingredient("nightmarefuel", 4),
        }, 
        atlas = defaultAtlas,
        texture = "lavaarena_eyecirclethat.tex",
    },
    tfwp_flower_headband_hat = 
    {
        recipe = 
        {
            Ingredient("petals", 10),
            Ingredient("rope", 1),
        }, 
        atlas = defaultAtlas,
        texture = "lavaarena_healingflowerhat.tex",
    },
    tfwp_woven_garland_hat = 
    {
        recipe = 
        {
            Ingredient("twigs", 5),
            Ingredient("petals", 2),
            Ingredient("nightmarefuel", 1),
        }, 
        atlas = defaultAtlas,
        texture = "lavaarena_tiaraflowerpetalshat.tex",
    },
    tfwp_feather_garland_hat = 
    {
        recipe = 
        {
            Ingredient("feather_robin_winter", 4),
            Ingredient("rope", 2),
            Ingredient("foliage", 6),
        }, 
        atlas = customAtlas,
        texture = "tfwp_feather_garland_hat.tex",
    },
    tfwp_blossom_garland_hat = 
    {
        recipe = 
        {
            Ingredient("petals", 12),
            Ingredient("rope", 2),
            Ingredient("nightmarefuel", 4),
        }, 
        atlas = customAtlas,
        texture = "tfwp_blossom_garland_hat.tex",
    },
}

local critical = _G.State{
    name = "tfwp_critical",
    tags = { "doing", "busy", "nointerrupt", "nopredict" }, --ноинтеррапт защищает от прерывания при получении урона
 
    onenter = function(inst, data)
        inst.components.locomotor:Stop()
   
        --inst.AnimState:PlayAnimation("atk_leap_pre")
        inst.AnimState:PlayAnimation("atk_leap", false)
       
        inst.sg.statemem.weapon = data.weapon
        inst.sg.statemem.target = data.target
    end,
 
    events =
    {
        _G.EventHandler("animover", function(inst)
            inst.sg:GoToState("idle")
        end),
        _G.EventHandler("unequip", function(inst)
            inst.sg:GoToState("idle")
        end)
    },
 
    timeline =
    {
        _G.TimeEvent(15 * _G.FRAMES, function(inst)
            local weapon = inst.components.inventory:GetEquippedItem(_G.EQUIPSLOTS.HANDS)
            if weapon and weapon == inst.sg.statemem.weapon then
                weapon:DoCriticalHit(inst, inst.sg.statemem.target)
            end
        end),
        _G.TimeEvent(21 * _G.FRAMES, function(inst)
            inst.sg:RemoveStateTag("busy")
        end)
    }
}
 
AddStategraphEvent("wilson", _G.EventHandler("tfwp_critical", function(inst, data)
    if not inst.components.health:IsDead() 
        and data.weapon ~= nil
        and data.weapon:IsValid()
        and data.target ~= nil
        and data.target:IsValid()
        and data.weapon == inst.components.inventory:GetEquippedItem(_G.EQUIPSLOTS.HANDS)
    then
        inst.sg:GoToState("tfwp_critical", data)
    end
end))
 
AddStategraphState("wilson", critical)
------------------------------------------------forge weapons fim---------------------------------------------------------

---------------------------complemento 2-------------------------
modimport("scripts/widgets/seasonsdisplay.lua")
--------------------------
env._G=GLOBAL;
env.require=_G.require;
env.STRINGS=_G.STRINGS;
env.ACTIONS=_G.ACTIONS;
env.FUELTYPE=_G.FUELTYPE;
require("modweap")

local dm = 1.5

_G.TUNING.FORGE_ITEM_PACK={
GOLEM={HEALTH=1,RUNSPEED=0,DAMAGE=25,HIT_RANGE=9,ATTACK_PERIOD=2,LIFE_TIME=50},
TFWP_LAVA_DART={DAMAGE=20*dm,COOLDOWN=18,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},DISABLE_RECIPE=false},
TFWP_LAVA_HAMMER={DAMAGE=20*dm,ALT_DAMAGE=30*dm/TUNING.ELECTRIC_DAMAGE_MULT,ALT_RADIUS=4.1,COOLDOWN=18,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},WORKABLE_DMG=4,DISABLE_RECIPE=false},
RILEDLUCY={DAMAGE=20*dm,ALT_DAMAGE=30*dm,WORKABLE_DMG=4,DISABLE_RECIPE=false},
TFWP_SPEAR_GUNG={DAMAGE=25*dm,ALT_DAMAGE=25*dm,ALT_DIST=6.5,ALT_WIDTH=3.25,COOLDOWN=12,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},WORKABLE_DMG=4,DISABLE_RECIPE=false},
TFWP_HEALING_STAFF={DAMAGE=10*dm,COOLDOWN=24,DURATION=10,HEAL_RATE=6,RANGE=4.1,SCALE_RNG={30,40},DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},DISABLE_RECIPE=false},
TFWP_DRAGON_DART={DAMAGE=25*dm,ALT_DAMAGE=50*dm,COOLDOWN=18,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},DISABLE_RECIPE=false},
TFWP_INFERNAL_STAFF={DAMAGE=25*dm,ALT_DAMAGE={base=200*dm,center_mult=0.25},ALT_RADIUS=4.1,COOLDOWN=24,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},WORKABLE_DMG=8,DISABLE_RECIPE=false},
TFWP_SPEAR_LANCE={DAMAGE=30*dm,ALT_DAMAGE=75*dm,ALT_RANGE=16,ALT_RADIUS=2.05,COOLDOWN=12,DURABILITY={AMOUNT=0,CONSUMPTION_SPECIAL=0.5},WORKABLE_DMG=6,DISABLE_RECIPE=false},
TFWP_CONTROL_BOOK={DAMAGE=15*dm,COOLDOWN=18,DURATION=10,ALT_RADIUS=4.1,DURABILITY={AMOUNT=0,CONSUMPTION_SPECIAL=0.5},DISABLE_RECIPE=false},
TFWP_SUMMON_BOOK={DAMAGE=15*dm,COOLDOWN=18,DURATION=10,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},DISABLE_RECIPE=false},
TFWP_FIRE_BOMB={DAMAGE=15*dm,ALT_DAMAGE=75*dm,PROC_DAMAGE=100*dm,COOLDOWN=6,ALT_RANGE=8,HORIZONTAL_SPEED=20,GRAVITY=-30,CHARGE_HITS_1=7,CHARGE_HITS_2=10,MAXIMUM_CHARGE_HITS=13,CHARGE_DECAY_TIME=5,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},WORKABLE_DMG=4,DISABLE_RECIPE=false},
TFWP_HEAVY_SWORD={DAMAGE=30*dm,HELMSPLIT_DAMAGE=100*dm,PARRY_DURATION=5,COOLDOWN=12,DURABILITY={AMOUNT=0,CONSUMPTION_NORMAL=1,CONSUMPTION_SPECIAL=0.5},DISABLE_RECIPE=false},

RET_DATA={
fossil={"aoecctarget",2},
elemental={"aoesummontarget",1},
hammer={"aoehostiletarget",0.9},
tfwp_healing_staff={"aoefriendlytarget",0.9},
tfwp_infernal_staff={"aoehostiletarget",0.7},
tfwp_spear_lance={"aoesmallhostiletarget",1},
tfwp_fire_bomb={"aoesmallhostiletarget",1},
tfwp_heavy_sword={"aoehostiletarget",0.9}}
}

_G.TUNING.FORGE_ITEM_PACK.GOLEM.DAMAGE=25*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.COOLDOWN=18
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_DART.DAMAGE= 20*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.COOLDOWN=18
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.DAMAGE=20*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_LAVA_HAMMER.ALT_DAMAGE=30*dm/TUNING.ELECTRIC_DAMAGE_MULT;
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.COOLDOWN=12
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.DAMAGE=25*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_GUNG.ALT_DAMAGE=25*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.COOLDOWN=24
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.DURATION=10
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.HEAL_RATE=6
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEALING_STAFF.DAMAGE=10*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.COOLDOWN=18
_G.TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.DAMAGE=25*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_DRAGON_DART.ALT_DAMAGE=50*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.COOLDOWN=24
_G.TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.DAMAGE=25*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_INFERNAL_STAFF.ALT_DAMAGE.base=200*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.COOLDOWN=12
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.DAMAGE=30*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_SPEAR_LANCE.ALT_DAMAGE=75*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.COOLDOWN=18
_G.TUNING.FORGE_ITEM_PACK.TFWP_CONTROL_BOOK.DAMAGE=15*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_SUMMON_BOOK.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_SUMMON_BOOK.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_SUMMON_BOOK.COOLDOWN=18
_G.TUNING.FORGE_ITEM_PACK.TFWP_SUMMON_BOOK.DAMAGE=15*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.COOLDOWN=5
_G.TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.DAMAGE=15*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.ALT_DAMAGE=75*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_FIRE_BOMB.PROC_DAMAGE=100*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.DURABILITY.AMOUNT=800
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.DURABILITY.CONSUMPTION_NORMAL=1
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.DURABILITY.CONSUMPTION_SPECIAL=0.5
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.COOLDOWN=12
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.DAMAGE=30*dm
_G.TUNING.FORGE_ITEM_PACK.TFWP_HEAVY_SWORD.HELMSPLIT_DAMAGE=100*dm

local function d(b)
local c=b.prefab:upper()
if _G.TUNING.FORGE_ITEM_PACK[c]and _G.TUNING.FORGE_ITEM_PACK[c].DURABILITY and _G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.AMOUNT then 
if _G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.AMOUNT>0 then 
b:AddComponent("finiteuses")
b.components.finiteuses:SetMaxUses(_G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.AMOUNT)
b.components.finiteuses:SetUses(_G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.AMOUNT)
b.components.finiteuses:SetOnFinished(b.Remove)
if _G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.CONSUMPTION_NORMAL then 
b.components.finiteuses:SetConsumption(ACTIONS.ATTACK,_G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.CONSUMPTION_NORMAL)
end;

if _G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.CONSUMPTION_SPECIAL then b.components.finiteuses:SetConsumption(ACTIONS.CASTAOE,_G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.AMOUNT*_G.TUNING.FORGE_ITEM_PACK[c].DURABILITY.CONSUMPTION_SPECIAL/100)end end else print("Cannot find tunning for "..c)end end;
local function e(b)local c=b.prefab:upper()if _G.TUNING.FORGE_ITEM_PACK[c]and _G.TUNING.FORGE_ITEM_PACK[c].DURABILITY then if _G.TUNING.FORGE_ITEM_PACK[c].DURABILITY>0 then b:AddComponent("fueled")b.components.fueled.fueltype=FUELTYPE.USAGE;
b.components.fueled:InitializeFuelLevel(_G.TUNING.FORGE_ITEM_PACK[c].DURABILITY*_G.TUNING.TOTAL_DAY_TIME)b.components.fueled:SetDepletedFn(b.Remove)end else print("Cannot find tunning for "..c)end end;
local f={"tfwp_lava_dart","tfwp_lava_hammer","tfwp_spear_gung","tfwp_healing_staff","tfwp_dragon_dart","tfwp_infernal_staff","tfwp_spear_lance","tfwp_fire_bomb","tfwp_heavy_sword","tfwp_control_book","tfwp_summon_book"}
for i,j in ipairs(f)do AddPrefabPostInit(j,d)end;
modimport("scripts/modweab.lua")
_G.ACTIONS.CASTAOE.strfn=function(k)return k.invobject~=nil and string.upper(k.invobject.nameoverride~=nil and k.invobject.nameoverride or k.invobject.prefab)or nil end;

STRINGS.NAMES.TFWP_LAVA_DART=STRINGS.NAMES.BLOWDART_LAVA;
STRINGS.NAMES.TFWP_DRAGON_DART=STRINGS.NAMES.BLOWDART_LAVA2;
STRINGS.NAMES.TFWP_INFERNAL_STAFF=STRINGS.NAMES.FIREBALLSTAFF;
STRINGS.NAMES.TFWP_HEALING_STAFF=STRINGS.NAMES.HEALINGSTAFF;
STRINGS.NAMES.TFWP_LAVA_HAMMER=STRINGS.NAMES.HAMMER_MJOLNIR;
STRINGS.NAMES.TFWP_SPEAR_GUNG=STRINGS.NAMES.SPEAR_GUNGNIR;
STRINGS.NAMES.TFWP_SPEAR_LANCE=STRINGS.NAMES.SPEAR_LANCE;
STRINGS.NAMES.RILEDLUCY=STRINGS.NAMES.LAVAARENA_LUCY;
STRINGS.NAMES.TFWP_CONTROL_BOOK=STRINGS.NAMES.BOOK_FOSSIL;
STRINGS.NAMES.TFWP_SUMMON_BOOK=STRINGS.NAMES.BOOK_ELEMENTAL;
STRINGS.NAMES.LUCY="Lucy the axe"
STRINGS.NAMES.TFWP_FIRE_BOMB=STRINGS.NAMES.LAVAARENA_FIREBOMB;
STRINGS.NAMES.TFWP_HEAVY_SWORD=STRINGS.NAMES.LAVAARENA_HEAVYBLADE;
---------
local env = env
GLOBAL.setfenv(1, GLOBAL)

local memoizedFilePaths = {}

-- look in package loaders to find the file from the root directories
-- this will look first in the mods and then in the data directory
local function softresolvefilepath_internal(filepath, force_path_search, search_first_path)
    force_path_search = force_path_search or false

    if IsConsole() and not force_path_search then
        return filepath -- it's already absolute, so just send it back
    end

    --on PC platforms, search all the possible paths

    --mod folders don't have "data" in them, so we strip that off if necessary. It will
    --be added back on as one of the search paths.
    filepath = string.gsub(filepath, "^/", "")

    --sometimes from context we can know the most likely path for an asset, this can result in less time spent searching the tons of mod search paths.
    if search_first_path then
        local filename = search_first_path..filepath
        if not kleifileexists or kleifileexists(filename) then
            return filename
        end
    end

    local is_mod_path = string.sub(filepath, 1, MODS_ROOT:len()) == MODS_ROOT

    --if it is a mod path, try it first, as its most likely already correct.
    if is_mod_path and (not kleifileexists or kleifileexists(filepath)) then
        return filepath
    end

    local searchpaths = package.path
    for path in string.gmatch(searchpaths, "([^;]+)") do
        local filename = string.gsub(string.gsub(path, "scripts\\%?%.lua", filepath), "\\", "/")
        if not kleifileexists or kleifileexists(filename) then
            return filename
        end
    end

    --as a last resort see if the file is an already correct path (incase this asset has already been processed)
    if not is_mod_path and (not kleifileexists or kleifileexists(filepath)) then
        return filepath
    end

    return nil
end

local function resolvefilepath_internal(filepath, force_path_search, search_first_path)
    local resolved = softresolvefilepath_internal(filepath, force_path_search, search_first_path)
    memoizedFilePaths[filepath] = resolved
    return resolved
end

--like resolvefilepath, but without the crash if it fails.
function resolvefilepath_soft(filepath, force_path_search, search_first_path)
    if memoizedFilePaths[filepath] then
        return memoizedFilePaths[filepath]
    end
    return resolvefilepath_internal(filepath, force_path_search, search_first_path)
end

function resolvefilepath(filepath, force_path_search, search_first_path)
    if memoizedFilePaths[filepath] then
        return memoizedFilePaths[filepath]
    end
    local resolved = resolvefilepath_internal(filepath, force_path_search, search_first_path)
    assert(resolved ~= nil, "Could not find an asset matching "..filepath.." in any of the search paths.")
    return resolved
end

function softresolvefilepath(filepath, force_path_search, search_first_path)
    if memoizedFilePaths[filepath] then
        return memoizedFilePaths[filepath]
    end
    return softresolvefilepath_internal(filepath, force_path_search, search_first_path)
end