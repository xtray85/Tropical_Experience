-- level.overrides.has_ocean = false
local SIZE_VARIATION = 3
-- boarmound
local require = GLOBAL.require
require("map/lockandkey")
require("map/tasks")
require("map/rooms")
require("map/terrain")
require("map/level")
require("map/room_functions")
local blockersets = require("map/blockersets")
local LOCKS = GLOBAL.LOCKS
local KEYS = GLOBAL.KEYS
local GROUND = GLOBAL.GROUND
local LEVELTYPE = GLOBAL.LEVELTYPE
local LOCKS_KEYS = GLOBAL.LOCKS_KEYS

modimport 'tileadder.lua'
AddTiles()

modimport "scripts/init_static_layouts.lua"

local MapTags = {"frost", "hamlet", "tropical", "underwater", "folha"}

AddGlobalClassPostConstruct("map/storygen", "Story", function(self)
    for k, v in pairs(MapTags) do
        self.map_tags.Tag[v] = function(tagdata)
            return "TAG", v
        end
    end
end)

------------hamlet--------------------------
-- adding new keys and locks
local locks = 1
for _, v in pairs(LOCKS) do
    if v >= locks then
        locks = v + 1
    end
end

local keys = 1
for _, v in pairs(KEYS) do
    if v >= keys then
        keys = v + 1
    end
end

LOCKS.JUNGLE_DEPTH_1 = locks
KEYS.JUNGLE_DEPTH_1 = keys
LOCKS_KEYS[LOCKS.JUNGLE_DEPTH_1] = {KEYS.JUNGLE_DEPTH_1}

LOCKS.JUNGLE_DEPTH_2 = locks + 1
KEYS.JUNGLE_DEPTH_2 = keys + 1
LOCKS_KEYS[LOCKS.JUNGLE_DEPTH_2] = {KEYS.JUNGLE_DEPTH_2}

LOCKS.JUNGLE_DEPTH_3 = locks + 2
KEYS.JUNGLE_DEPTH_3 = keys + 2
LOCKS_KEYS[LOCKS.JUNGLE_DEPTH_3] = {KEYS.JUNGLE_DEPTH_3}

LOCKS.CIVILIZATION_1 = locks + 3
KEYS.CIVILIZATION_1 = keys + 3
LOCKS_KEYS[LOCKS.CIVILIZATION_1] = {KEYS.CIVILIZATION_1}

LOCKS.LAND_DIVIDE_1 = locks + 4
KEYS.LAND_DIVIDE_1 = keys + 4
LOCKS_KEYS[LOCKS.LAND_DIVIDE_1] = {KEYS.LAND_DIVIDE_1}

LOCKS.LAND_DIVIDE_2 = locks + 5
KEYS.LAND_DIVIDE_2 = keys + 5
LOCKS_KEYS[LOCKS.LAND_DIVIDE_2] = {KEYS.LAND_DIVIDE_2}

LOCKS.LAND_DIVIDE_3 = locks + 6
KEYS.LAND_DIVIDE_3 = keys + 6
LOCKS_KEYS[LOCKS.LAND_DIVIDE_3] = {KEYS.LAND_DIVIDE_3}

LOCKS.OTHER_JUNGLE_DEPTH_1 = locks + 7
KEYS.OTHER_JUNGLE_DEPTH_1 = keys + 7
LOCKS_KEYS[LOCKS.OTHER_JUNGLE_DEPTH_1] = {KEYS.OTHER_JUNGLE_DEPTH_1}

LOCKS.OTHER_JUNGLE_DEPTH_2 = locks + 8
KEYS.OTHER_JUNGLE_DEPTH_2 = keys + 8
LOCKS_KEYS[LOCKS.OTHER_JUNGLE_DEPTH_2] = {KEYS.OTHER_JUNGLE_DEPTH_2}

LOCKS.LOST_JUNGLE_DEPTH_2 = locks + 9
KEYS.LOST_JUNGLE_DEPTH_2 = keys + 9
LOCKS_KEYS[LOCKS.LOST_JUNGLE_DEPTH_2] = {KEYS.LOST_JUNGLE_DEPTH_2}

LOCKS.ISLAND_1 = locks + 10
KEYS.ISLAND_1 = keys + 10
LOCKS_KEYS[LOCKS.ISLAND_1] = {KEYS.ISLAND_1}

LOCKS.ISLAND_2 = locks + 11
KEYS.ISLAND_2 = keys + 11
LOCKS_KEYS[LOCKS.ISLAND_2] = {KEYS.ISLAND_2}

LOCKS.ISLAND_3 = locks + 12
KEYS.ISLAND_3 = keys + 12
LOCKS_KEYS[LOCKS.ISLAND_3] = {KEYS.ISLAND_3}

LOCKS.ISLAND_4 = locks + 13
KEYS.ISLAND_4 = keys + 13
LOCKS_KEYS[LOCKS.ISLAND_4] = {KEYS.ISLAND_4}

LOCKS.PINACLE = locks + 14
KEYS.PINACLE = keys + 14
LOCKS_KEYS[LOCKS.PINACLE] = {KEYS.PINACLE}

LOCKS.CIVILIZATION_2 = locks + 15
KEYS.CIVILIZATION_2 = keys + 15
LOCKS_KEYS[LOCKS.CIVILIZATION_2] = {KEYS.CIVILIZATION_2}

LOCKS.LAND_DIVIDE_4 = locks + 16
KEYS.LAND_DIVIDE_4 = keys + 16
LOCKS_KEYS[LOCKS.LAND_DIVIDE_4] = {KEYS.LAND_DIVIDE_4}

LOCKS.OTHER_CIVILIZATION_1 = locks + 17
KEYS.OTHER_CIVILIZATION_1 = keys + 17
LOCKS_KEYS[LOCKS.OTHER_CIVILIZATION_1] = {KEYS.OTHER_CIVILIZATION_1}

LOCKS.OTHER_CIVILIZATION_2 = locks + 18
KEYS.OTHER_CIVILIZATION_2 = keys + 18
LOCKS_KEYS[LOCKS.OTHER_CIVILIZATION_2] = {KEYS.OTHER_CIVILIZATION_2}

LOCKS.WILD_JUNGLE_DEPTH_1 = locks + 19
KEYS.WILD_JUNGLE_DEPTH_1 = keys + 19
LOCKS_KEYS[LOCKS.WILD_JUNGLE_DEPTH_1] = {KEYS.WILD_JUNGLE_DEPTH_1}

LOCKS.WILD_JUNGLE_DEPTH_2 = locks + 20
KEYS.WILD_JUNGLE_DEPTH_2 = keys + 20
LOCKS_KEYS[LOCKS.WILD_JUNGLE_DEPTH_2] = {KEYS.WILD_JUNGLE_DEPTH_2}

LOCKS.ISLAND_5 = locks + 21
KEYS.ISLAND_5 = keys + 21
LOCKS_KEYS[LOCKS.ISLAND_5] = {KEYS.ISLAND_5}

LOCKS.LAND_DIVIDE_5 = locks + 22
KEYS.LAND_DIVIDE_5 = keys + 22
LOCKS_KEYS[LOCKS.LAND_DIVIDE_5] = {KEYS.LAND_DIVIDE_5}
----------------------
LOCKS.ISLAND1 = locks + 23
KEYS.ISLAND1 = keys + 23
LOCKS_KEYS[LOCKS.ISLAND1] = {KEYS.ISLAND1}

LOCKS.ISLAND2 = locks + 24
KEYS.ISLAND2 = keys + 24
LOCKS_KEYS[LOCKS.ISLAND2] = {KEYS.ISLAND2}

LOCKS.ISLAND3 = locks + 25
KEYS.ISLAND3 = keys + 25
LOCKS_KEYS[LOCKS.ISLAND3] = {KEYS.ISLAND3}

LOCKS.ISLAND4 = locks + 26
KEYS.ISLAND4 = keys + 26
LOCKS_KEYS[LOCKS.ISLAND4] = {KEYS.ISLAND4}

LOCKS.ISLAND5 = locks + 27
KEYS.ISLAND5 = keys + 27
LOCKS_KEYS[LOCKS.ISLAND5] = {KEYS.ISLAND5}

LOCKS.ISLAND6 = locks + 28
KEYS.ISLAND6 = keys + 28
LOCKS_KEYS[LOCKS.ISLAND6] = {KEYS.ISLAND6}

LOCKS.ISLAND7 = locks + 29
KEYS.ISLAND7 = keys + 29
LOCKS_KEYS[LOCKS.ISLAND7] = {KEYS.ISLAND7}

local meadow_fairy_rings = {
    ["MushroomRingLarge"] = function()
        if math.random(1, 1000) > 985 then
            return 1
        end
        return 0
    end,
    ["MushroomRingMedium"] = function()
        if math.random(1, 1000) > 985 then
            return 1
        end
        return 0
    end,
    ["MushroomRingSmall"] = function()
        if math.random(1, 1000) > 985 then
            return 1
        end
        return 0
    end
}

local LIVINGJUNGLETREE_CHANCE = 0.9

-- vai ate 6077
if GetModConfigData("kindofworld") == 5 then
    -------------------------------------------------------Hamlet task exclusivas ilha inicial---------------------------------	

    local tamanho = GetModConfigData("continentsize")

    AddTask("Edge_of_the_unknown", {
        locks = LOCKS.NONE,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        room_choices = {
            ["BG_plains_base"] = 1 + tamanho
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("painted_sands", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        room_choices = {
            ["BG_painted_base"] = 1 + tamanho,
            ["BG_battleground_base"] = math.random(0, 1),
            ["battleground_ribs"] = 1,
            ["battleground_claw"] = 1,
            ["battleground_leg"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_painted_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    AddTask("plains", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        room_choices = {
            ["plains_tallgrass"] = 1 + tamanho,
            ["plains_pogs_ruin"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    AddTask("rainforests", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        room_choices = {
            ["BG_rainforest_base"] = 1 + tamanho
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_rainforest_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    AddTask("rainforest_ruins", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        room_choices = {
            ["rainforest_ruins"] = 1 + tamanho,
            ["rainforest_ruins_entrance"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_rainforest_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    AddTask("plains_ruins", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        room_choices = {
            ["plains_ruins"] = 1 + tamanho,
            ["plains_ruins_set"] = 1,
            ["plains_pogs"] = math.random(0, 1)
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Edge_of_civilization", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.CIVILIZATION_1,
        room_choices = {
            ["cultivated_base_1"] = 2 + tamanho,
            ["piko_land"] = 1 + tamanho
        },
        room_bg = GROUND.FIELDS,
        background_room = "BG_cultivated_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Deep_rainforest", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = {KEYS.JUNGLE_DEPTH_2, KEYS.JUNGLE_DEPTH_3},
        room_choices = {
            ["BG_rainforest_base"] = 1 + tamanho,
            ["BG_deeprainforest_base"] = 1,
            ["deeprainforest_spider_monkey_nest"] = 1 + tamanho,
            ["deeprainforest_fireflygrove"] = math.random(1, 1),
            ["deeprainforest_flytrap_grove"] = 1 + tamanho,
            ["deeprainforest_anthill_exit2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Pigtopia", {
        locks = LOCKS.CIVILIZATION_1,
        keys_given = KEYS.CIVILIZATION_2,
        room_choices = {
            ["suburb_base_1"] = 1 + tamanho
        },
        room_bg = GROUND.SUBURB,
        background_room = "suburb_base_1",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Pigtopia_capital", {
        locks = LOCKS.CIVILIZATION_2,
        keys_given = KEYS.ISLAND_2,
        room_choices = {
            ["city_base_1_set"] = 1,
            ["city_base_1_set2"] = 1,
            ["city_base_1"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "suburb_base_1",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Deep_lost_ruins_gas", {
        locks = LOCKS.JUNGLE_DEPTH_3,
        keys_given = KEYS.JUNGLE_DEPTH_3,
        room_choices = {
            ["deeprainforest_gas"] = 1 + tamanho,
            ["deeprainforest_gas_set"] = 1,
            ["deeprainforest_gas_flytrap_grove"] = 1,
            ["deeprainforest_gas_flytrap_grove_set"] = 1
        },
        room_bg = GROUND.GASJUNGLE,
        background_room = "deeprainforest_gas",
        colour = {
            r = 0.8,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Edge_of_the_unknown_2", {
        locks = LOCKS.CIVILIZATION_1,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        room_choices = {
            ["BG_rainforest_base"] = 1 + tamanho,
            ["plains_tallgrass"] = 1 + tamanho,
            ["plains_pogs_ruin"] = 1,
            ["rainforest_ruins"] = 1 + tamanho,
            ["BG_painted_base"] = 1 + tamanho,
            ["battleground_head"] = 1,
            ["battleground_claw"] = 1,
            ["battleground_leg"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Lilypond_land", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.JUNGLE_DEPTH_2,
        room_choices = {
            ["BG_rainforest_base"] = 1
        },
        entrance_room = "rainforest_lillypond",
        room_bg = GROUND.RAINFOREST,
        background_room = "BG_rainforest_base",
        colour = {
            r = 1,
            g = 0.3,
            b = 0.3,
            a = 0.3
        }
    })

    AddTask("Lilypond_land_2", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = KEYS.JUNGLE_DEPTH_2,
        room_choices = {
            ["BG_rainforest_base"] = 1
        },
        entrance_room = "rainforest_lillypond",
        room_bg = GROUND.RAINFOREST,
        background_room = "BG_rainforest_base",
        colour = {
            r = 1,
            g = 0.3,
            b = 0.3,
            a = 0.3
        }
    })

    AddTask("this_is_how_you_get_ants", {
        locks = LOCKS.JUNGLE_DEPTH_2,
        keys_given = {KEYS.JUNGLE_DEPTH_2, KEYS.JUNGLE_DEPTH_3},
        room_choices = {
            ["deeprainforest_anthill"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0,
            g = 0,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Deep_rainforest_2", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = {KEYS.JUNGLE_DEPTH_2, KEYS.JUNGLE_DEPTH_3},
        room_choices = {
            ["BG_deeprainforest_base"] = 1 + tamanho,
            ["deeprainforest_spider_monkey_nest"] = 1 + tamanho,
            ["deeprainforest_fireflygrove"] = 1 + tamanho,
            ["deeprainforest_flytrap_grove"] = 1 + tamanho,
            ["deeprainforest_anthill_exit"] = 1,
            ["deeprainforest_ruins_entrance2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Lost_Ruins_1", {
        locks = LOCKS.JUNGLE_DEPTH_3,
        keys_given = KEYS.NONE,
        room_choices = {
            ["deeprainforest_ruins_entrance"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Land_Divide_1", {
        locks = {LOCKS.ISLAND_2},
        keys_given = KEYS.LAND_DIVIDE_1,
        level_set_piece_blocker = true,
        room_choices = {
            ["ForceDisconnectedRoom"] = 10
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    -- THE OTHER PIG CITY
    AddTask("Deep_rainforest_3", {
        locks = LOCKS.LAND_DIVIDE_1,
        keys_given = {KEYS.OTHER_JUNGLE_DEPTH_2},
        room_choices = {
            ["BG_deeprainforest_base"] = 1 + tamanho,
            ["deeprainforest_fireflygrove"] = 0 + tamanho,
            ["deeprainforest_flytrap_grove"] = 1 + tamanho,
            ["deeprainforest_ruins_exit"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Deep_rainforest_mandrake", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_2,
        keys_given = {KEYS.NONE},
        room_choices = {
            ["deeprainforest_mandrakeman"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Path_to_the_others", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_2,
        keys_given = KEYS.OTHER_JUNGLE_DEPTH_1,
        room_choices = {
            ["BG_plains_base"] = 1 + tamanho,
            ["plains_tallgrass"] = 1 + tamanho,
            ["plains_pogs"] = 1 + tamanho
        },
        room_bg = GROUND.RAINFOREST,
        background_room = "BG_rainforest_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Other_edge_of_civilization", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_1,
        keys_given = KEYS.OTHER_CIVILIZATION_1,
        room_choices = {
            ["cultivated_base_2"] = 1 + tamanho
        },
        room_bg = GROUND.FIELDS,
        background_room = "BG_cultivated_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Other_pigtopia", {
        locks = LOCKS.OTHER_CIVILIZATION_1,
        keys_given = KEYS.OTHER_CIVILIZATION_2,
        room_choices = {
            ["suburb_base_2"] = 1 + tamanho
        },
        room_bg = GROUND.SUBURB,
        background_room = "suburb_base_2",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Other_pigtopia_capital", {
        locks = LOCKS.OTHER_CIVILIZATION_2,
        keys_given = KEYS.ISLAND_3,
        room_choices = {
            ["city_base_2_set"] = 1,
            ["city_base_2_set2"] = 1,
            ["city_base_2"] = 1
        },
        room_bg = GROUND.FOUNDATION,
        background_room = "suburb_base_2",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Land_Divide_2", {
        locks = LOCKS.ISLAND_3,
        keys_given = KEYS.LAND_DIVIDE_2,
        level_set_piece_blocker = true,
        room_choices = {
            ["ForceDisconnectedRoom"] = 10 -- 20, 
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    -- Other Jungle 
    AddTask("Deep_lost_ruins4", {
        locks = LOCKS.LAND_DIVIDE_2,
        keys_given = {KEYS.LOST_JUNGLE_DEPTH_2},
        room_choices = {
            ["BG_deeprainforest_base"] = 1 + tamanho,
            ["deeprainforest_flytrap_grove"] = 1 + tamanho,
            ["deeprainforest_ruins_exit2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("lost_rainforest", {
        locks = LOCKS.LOST_JUNGLE_DEPTH_2,
        keys_given = {KEYS.ISLAND_4},
        room_choices = {
            ["BG_plains_base_nocanopy"] = math.random(1),
            ["BG_plains_base_nocanopy1"] = 1,
            ["BG_plains_base_nocanopy2"] = math.random(0, 1),
            ["BG_plains_base_nocanopy3"] = math.random(0, 1)
        },

        entrance_room = "rainforest_lillypond",
        room_bg = GROUND.RAINFOREST,
        background_room = "BG_rainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Land_Divide_3", {
        locks = LOCKS.ISLAND_4,
        keys_given = KEYS.LAND_DIVIDE_3,
        level_set_piece_blocker = true,
        room_choices = {
            ["ForceDisconnectedRoom"] = 10
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("pincale", {
        locks = LOCKS.LAND_DIVIDE_3,
        keys_given = KEYS.PINACLE,
        room_choices = {
            ["BG_pinacle_base_set"] = 1
        },
        room_bg = GROUND.ROCKY,
        background_room = "BG_pinacle_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Land_Divide_4", {
        locks = LOCKS.PINACLE,
        keys_given = KEYS.LAND_DIVIDE_4,
        level_set_piece_blocker = true,
        room_choices = {
            ["ForceDisconnectedRoom"] = 10
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    -- Other Jungle 
    AddTask("Deep_wild_ruins4", {
        locks = LOCKS.LAND_DIVIDE_4,
        keys_given = {KEYS.WILD_JUNGLE_DEPTH_1},
        room_choices = {
            ["deeprainforest_base_nobatcave"] = 1 + tamanho,
            ["deeprainforest_flytrap_grove"] = 1 + tamanho,
            ["deeprainforest_base_nobatcave_PigRuinsExit4"] = 1
        },

        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "deeprainforest_base_nobatcave",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("wild_rainforest", {
        locks = LOCKS.WILD_JUNGLE_DEPTH_1,
        keys_given = {KEYS.WILD_JUNGLE_DEPTH_2},
        room_choices = {
            ["plains_base_nobatcave"] = 2 + tamanho,
            ["painted_base_nobatcave"] = 2 + tamanho,
            ["rainforest_base_nobatcave"] = 2 + tamanho
        },
        entrance_room = "rainforest_lillypond",
        room_bg = GROUND.RAINFOREST,
        background_room = "rainforest_base_nobatcave",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })
    AddTask("wild_ancient_ruins", {
        locks = LOCKS.WILD_JUNGLE_DEPTH_2,
        keys_given = {KEYS.ISLAND_5},
        room_choices = {
            ["deeprainforest_flytrap_grove"] = 2 + tamanho,
            ["deeprainforest_flytrap_grove_PigRuinsEntrance5"] = 1
        },

        room_bg = GROUND.RAINFOREST,
        background_room = "rainforest_base_nobatcave",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Land_Divide_5", {
        locks = LOCKS.ISLAND_5,
        keys_given = KEYS.LAND_DIVIDE_5,
        level_set_piece_blocker = true,
        room_choices = {
            ["ForceDisconnectedRoom"] = 20
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("interior_space", {
        locks = LOCKS.LAND_DIVIDE_5,
        keys_given = {KEYS.NONE},
        crosslink_factor = 1,
        make_loop = true,
        room_choices = {
            ["BG_interior_base"] = 20
        },

        room_bg = GROUND.RAINFOREST,
        background_room = "BG_interior_base",
        colour = {
            r = 0.01,
            g = 0.01,
            b = 0.01,
            a = 0.3
        }
    })

    ----------------------------------------------------------- ROOM PORKLAND--------------------------------------------------------------------------------------------------
    ----------------------------------------------------------- battlegrounds room--------------------------------------------------------------------------------------------------

    local preenchimento = GetModConfigData("fillingthebiomes") * 0.5

    AddRoom("BG_battleground_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .11 * preenchimento, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("battleground_ribs", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .11 * preenchimento, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_ribs = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    AddRoom("battleground_claw", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .11 * preenchimento, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_claw = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    AddRoom("battleground_leg", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .11 * preenchimento, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_leg = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    AddRoom("battleground_head", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .11 * preenchimento, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_head = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    ----------------------------------------------------------- deeprainforest room--------------------------------------------------------------------------------------------------
    AddRoom("BG_deeprainforest_base", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {

            countstaticlayouts = {
                ["pig_ruins_head"] = math.max(0, 2 - math.random(0, 15)),
                ["pig_ruins_artichoke"] = math.max(0, 2 - math.random(0, 15))
            },

            distributepercent = 0.25 * preenchimento,
            distributeprefabs = {
                rainforesttree = 2, -- 4,
                tree_pillar = 0.5, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                --										hanging_vine_patch = 0.1,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                --		pig_ruins_artichoke = 0.01,
                --		pig_ruins_head = 0.01,
                --										mean_flytrap = 0.05,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                vampirebatcave_potential = 1
            }

        }
    })

    AddRoom("deeprainforest_spider_monkey_nest", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {

            countstaticlayouts = {
                ["pig_ruins_head"] = math.max(0, 2 - math.random(0, 20)),
                ["pig_ruins_artichoke"] = math.max(0, 2 - math.random(0, 20))
            },
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 3, -- 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                --		pig_ruins_artichoke = 0.01,
                --		pig_ruins_head = 0.01,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                spider_monkey = math.random(1, 2)
                --					                	hanging_vine_patch = math.random(0,2)
            }
        }
    })
    AddRoom("deeprainforest_flytrap_grove", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_head"] = math.max(0, 2 - math.random(0, 20)),
                ["pig_ruins_artichoke"] = math.max(0, 2 - math.random(0, 20)),
                ["nettlegrove"] = function()
                    if math.random(1, 10) > 7 then
                        return 1
                    end
                    return 0
                end
            },

            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                --			pig_ruins_artichoke = 0.01,
                --			pig_ruins_head = 0.01,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
                --					                	hanging_vine_patch = math.random(0,2)
            }
        }
    })

    AddRoom("deeprainforest_flytrap_grove_PigRuinsEntrance5", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_head"] = math.max(0, 2 - math.random(0, 20)),
                ["pig_ruins_artichoke"] = math.max(0, 2 - math.random(0, 20)),
                ["pig_ruins_entrance_5"] = 1
            },

            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                --			pig_ruins_artichoke = 0.01,
                --			pig_ruins_head = 0.01,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
                --					                	hanging_vine_patch = math.random(0,2)
            }
        }
    })

    AddRoom("deeprainforest_fireflygrove", {
        colour = {
            r = 1,
            g = 1,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {

            countstaticlayouts = {
                ["pig_ruins_head"] = math.max(0, 2 - math.random(0, 20)),
                ["pig_ruins_artichoke"] = math.max(0, 2 - math.random(0, 20))
            },
            distributepercent = 0.125 * preenchimento, -- 0.25, --.3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 5,
                --										hanging_vine_patch = 0.1,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                --		pig_ruins_artichoke = 0.01,
                --		pig_ruins_head = 0.01,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                fireflies = math.random(5, 10)
            }
        }
    })

    AddRoom("deeprainforest_gas", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.225 * preenchimento, -- .45
            distributeprefabs = {
                rainforesttree_rot = 4,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                poisonmist = 8,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            }
        }
    })

    AddRoom("deeprainforest_gas_set", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_entrance_4"] = 1
            },
            distributepercent = 0.225 * preenchimento, -- .45
            distributeprefabs = {
                rainforesttree_rot = 4,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                poisonmist = 8,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            }
        }
    })

    AddRoom("deeprainforest_gas_flytrap_grove", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_head"] = 1,
                ["pig_ruins_artichoke"] = 1
            },
            distributepercent = 0.25 * preenchimento, -- .45
            distributeprefabs = {
                rainforesttree_rot = 2,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                -- mistarea = 6,	
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
            }
        }
    })

    AddRoom("deeprainforest_gas_flytrap_grove_set", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_entrance_3"] = 1
            },
            distributepercent = 0.25 * preenchimento, -- .45
            distributeprefabs = {
                rainforesttree_rot = 2,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                -- mistarea = 6,	
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
            }
        }
    })

    AddRoom("deeprainforest_ruins_entrance", {
        colour = {
            r = 1,
            g = 0.1,
            b = 0.2,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_entrance_1"] = 1
            },
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                -- 	pig_ruins_torch = 3,
                -- 	pig_ruins_entrance = 1,
                -- 	pig_ruins_artichoke = 1,
            }

        }
    })

    AddRoom("deeprainforest_ruins_entrance2", {
        colour = {
            r = 1,
            g = 0.1,
            b = 0.2,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_entrance_2"] = 1
            },
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                -- 	pig_ruins_torch = 3,
                -- 	pig_ruins_entrance = 1,
                -- 	pig_ruins_artichoke = 1,
            }

        }
    })

    AddRoom("deeprainforest_ruins_exit", {
        colour = {
            r = 0.2,
            g = 0.1,
            b = 1,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_exit_1"] = 1
            },
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                -- 	pig_ruins_torch = 3,
                -- 	pig_ruins_exit = 1,
                -- 	pig_ruins_head = 1,					                	
            }

        }
    })

    AddRoom("deeprainforest_ruins_exit2", {
        colour = {
            r = 0.2,
            g = 0.1,
            b = 1,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_exit_2"] = 1,
                ["nettlegrove"] = 1
            },
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                -- 	pig_ruins_torch = 3,
                -- 	pig_ruins_exit = 1,
                -- 	pig_ruins_head = 1,					                	
            }

        }
    })

    AddRoom("deeprainforest_anthill", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02
            },

            countprefabs = {
                maze_anthill = 1,
                pighead = 4
            }

        }
    })
    AddRoom("deeprainforest_mandrakeman", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["mandraketown"] = 1
            },
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02
            },

            countprefabs = {
                mandrakehouse = 2
            }

        }
    })
    AddRoom("deeprainforest_anthill_exit", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "hamlet", "folha"},
        contents = {
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02
            },

            countprefabs = {
                anthill_exit_1 = 1
            }

        }
    })

    AddRoom("deeprainforest_anthill_exit2", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "hamlet", "folha"},
        contents = {
            distributepercent = 0.125 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02
            },

            countprefabs = {
                anthill_exit_2 = 1
            }

        }
    })
    ----------------------------------------------------------- painted room--------------------------------------------------------------------------------------------------
    AddRoom("BG_painted_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PAINTED,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .075 * preenchimento, -- .26
            distributeprefabs = {
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.2,
                thunderbirdnest = 0.1,
                sedimentpuddle = 0.1,
                pangolden = 0.005
            },
            countprefabs = {
                pangolden = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    ----------------------------------------------------------- rainflorest room--------------------------------------------------------------------------------------------------
    AddRoom("BG_rainforest_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = .19 * preenchimento, -- .5
            distributeprefabs = {
                rainforesttree = 0.6, -- 1.4,
                grass_tall = .5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                dungpile = 0.03,
                fireflies = 0.05,
                peagawk = 0.01,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("rainforest_ruins", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.175 * preenchimento, -- .5
            distributeprefabs = {
                rainforesttree = .5, -- .7,
                grass_tall = 0.5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("rainforest_ruins_entrance", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = .175 * preenchimento, -- .5
            distributeprefabs = {
                rainforesttree = .5, -- .7,
                grass_tall = 0.5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                maze_pig_ruins_entrance6 = 1,
                vampirebatcave_entrance_roc = 1
            }
        }
    })

    AddRoom("rainforest_lillypond", {
        colour = {
            r = 1.0,
            g = 0.3,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["lilypad"] = 1 -- math.random(4,8),										
            },

            distributepercent = .25 * preenchimento, -- .3				

            distributeprefabs = {
                reeds_water = 3,
                lotus = 2,
                hippopotamoose = 0.08,
                relic_1 = 0.04,
                relic_2 = 0.04,
                relic_3 = 0.04
            },
            countprefabs = {
                hippopotamoose = 1
            }
        }
    })

    AddRoom("rainforest_pugalisk", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = .075 * preenchimento, -- .3
            distributeprefabs = {
                rainforesttree = .7,
                grass_tall = 0.5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                pugalisk = 1
            }
        }
    })
    ----------------------------------------------------------- pinacle room--------------------------------------------------------------------------------------------------
    AddRoom("BG_pinacle_base_set", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.ROCKY,
        tags = {"hamlet"},
        contents = {
            countstaticlayouts = {
                ["roc_nest"] = 1,
                ["roc_cave"] = 1
            },
            distributepercent = .05 * preenchimento, -- .26
            distributeprefabs = {
                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1

            },
            countprefabs = {
                flint = 2,
                twigs = 2,
                pig_scepter = 1
                --										hermithouse_construction1 = 1,
                --										crabking_spawner = 1,
                --										waterplant = 1,
            }
        }
    })

    AddRoom("BG_pinacle_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.ROCKY,
        tags = {"hamlet"},
        contents = {
            distributepercent = .05 * preenchimento, -- .26
            distributeprefabs = {
                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1

            },
            countprefabs = {
                flint = 2,
                twigs = 2
            }
        }
    })
    ----------------------------------------------------------- plain room--------------------------------------------------------------------------------------------------
    AddRoom("BG_plains_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .125 * preenchimento, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy"] = 1,
                ["pig_ruins_nocanopy_2"] = 1
            },
            distributepercent = .125 * preenchimento, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy_2"] = 1,
                ["pig_ruins_nocanopy_3"] = 1,
                ["pugalisk_fountain"] = 1
            },
            distributepercent = .125 * preenchimento, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                vampirebatcave_potential = 1,
                underwater_entrance2 = 1,
                vidanomar = 1,
                gravestone = 2,
                sculpture_rook = 1
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy2", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy_3"] = 1,
                ["pig_ruins_nocanopy_4"] = 1
            },
            distributepercent = .125 * preenchimento, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy3", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy_4"] = 1,
                ["pig_ruins_nocanopy"] = 1
            },
            distributepercent = .125 * preenchimento, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("plains_tallgrass", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .075 * preenchimento, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("plains_ruins", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .125 * preenchimento, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("plains_ruins_set", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .125 * preenchimento, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                maze_pig_ruins_entrance_small = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("plains_pogs", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .125 * preenchimento, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            },
            countprefabs = {
                pog = 2,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("plains_pogs_ruin", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .125 * preenchimento, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            },
            countprefabs = {
                pog = 2,
                maze_pig_ruins_entrance_small = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    -------------------------------------------------------------city room------------------------------------------------------------------------------------
    AddRoom("BG_city_base", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("city_base_1", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("city_base_1_set", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["cidade1"] = 1
            },
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("city_base_1_set2", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("city_base_2", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.FOUNDATION,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("city_base_2_set", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.FOUNDATION,
        tags = {"ExitPiece", "hamlet"},
        contents = {

            countstaticlayouts = {
                ["cidade2"] = 1
            },

            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("city_base_2_set2", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.FOUNDATION,
        tags = {"ExitPiece", "hamlet"},
        contents = {

            --        countstaticlayouts={
            --        ["pig_mainstreet"]= 1,
            --		   },				

            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })
    --------------------------------------------------cultivated room--------------------------------------------------------------------------------------------------------------------
    fazendas = {
        [1] = "farm_1",
        [2] = "farm_2",
        [3] = "farm_3",
        [4] = "farm_4",
        [5] = "farm_5"
    }

    AddRoom("BG_cultivated_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.03 * preenchimento, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            }
            --[[        countstaticlayouts={
        ["farm_1"]=function() 
        		return math.random(1,2)			
		   end,
		["farm_2"]=function() 
        		return math.random(0,2)			
		   end,
		["farm_3"]=function() 
        		return math.random(0,1)			
		   end
		   },
		]]
        }
    })

    AddRoom("cultivated_base_1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.03 * preenchimento, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                [fazendas[math.random(1, 5)]] = 1
            }
        }
    })

    AddRoom("cultivated_base_2", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.03 * preenchimento, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                [fazendas[math.random(1, 5)]] = 1
            }

        }
    })

    AddRoom("piko_land", {
        colour = {
            r = 1.0,
            g = 0.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.03 * preenchimento, -- 0.1
            distributeprefabs = {
                --	grass = 0.05,
                --	flower = 0.3,
                rock1 = 0.01,
                teatree = 2.0
            },
            countprefabs = {
                teatree_piko_nest_patch = 1
            }
        }

    })

    -----------------------------------------------------suburb room-----------------------------------------
    AddRoom("BG_suburb_base", {
        colour = {
            r = .3,
            g = 0.3,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("suburb_base_1", {
        colour = {
            r = .3,
            g = 0.3,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    AddRoom("suburb_base_2", {
        colour = {
            r = .3,
            g = 0.3,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.05 * preenchimento,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    --------------------------interior-----------------------------------		
    AddRoom("BG_interior_base", {
        colour = {
            r = .01,
            g = 0.01,
            b = 0.01,
            a = 0.3
        },
        value = GROUND.INTERIOR,
        tags = {"hamlet"},
        contents = {
            distributepercent = 0.0,
            distributeprefabs = {}
        }

    })

    ---------------------------------island 5--------------------------------------
    AddRoom("deeprainforest_base_nobatcave", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "hamlet", "folha"},
        contents = {

            distributepercent = 0.25 * preenchimento,
            distributeprefabs = {
                rainforesttree = 2, -- 4,
                tree_pillar = 0.5, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                --										hanging_vine_patch = 0.1,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                --		pig_ruins_artichoke = 0.01,
                --		pig_ruins_head = 0.01,
                --										mean_flytrap = 0.05,
                rock_flippable = 0.1,
                radish_planted = 0.5
            }
        }
    })

    AddRoom("deeprainforest_base_nobatcave_PigRuinsExit4", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_exit_4"] = 1
            },
            distributepercent = 0.25 * preenchimento,
            distributeprefabs = {
                rainforesttree = 2, -- 4,
                tree_pillar = 0.5, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                --										hanging_vine_patch = 0.1,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                --		pig_ruins_artichoke = 0.01,
                --		pig_ruins_head = 0.01,
                --										mean_flytrap = 0.05,
                rock_flippable = 0.1,
                radish_planted = 0.5
            }
        }
    })

    AddRoom("rainforest_base_nobatcave", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "hamlet", "folha"},
        contents = {
            distributepercent = .19 * preenchimento, -- .5
            distributeprefabs = {
                rainforesttree = 0.6, -- 1.4,
                grass_tall = .5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                dungpile = 0.03,
                fireflies = 0.05,
                peagawk = 0.01,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            }
        }
    })

    AddRoom("painted_base_nobatcave", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PAINTED,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = .075 * preenchimento, -- .26
            distributeprefabs = {
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.2,
                thunderbirdnest = 0.1,
                sedimentpuddle = 0.1,
                pangolden = 0.005
            },
            countprefabs = {
                pangolden = 1
            }
        }
    })

    AddRoom("plains_base_nobatcave", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = .125 * preenchimento, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2
            }
        }
    })
    ---------------------------------------------------------------------------Start Room -------------------------------------------------------------------------------------------------------------------------------------	
    AddRoom("PorklandPortalRoom", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PLAINS,
        tags = {"RoadPoison", "hamlet", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05

            },
            countprefabs = {
                spawnpoint_multiplayer = 1
                -- lake = 1,
            }

        }
    })

    AddTask("inicio", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = {KEYS.JUNGLE_DEPTH_1},
        room_choices = {
            ["PorklandPortalRoom"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })
    --------------------------------------------------
    AddTask("separavulcao", {
        locks = {LOCKS.RUINS},
        keys_given = KEYS.LAND_DIVIDE_3,
        room_choices = {
            ["ForceDisconnectedRoom"] = 10
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.VOLCANO,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("separahamcave", {
        locks = {LOCKS.SACRED},
        keys_given = KEYS.LAND_DIVIDE_5,
        room_choices = {
            ["ForceDisconnectedRoom"] = 10
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.VOLCANO,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("HamMudWorld", {
        locks = {LOCKS.LAND_DIVIDE_5},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND2},
        room_choices = {
            ["HamLightPlantField"] = 1,
            ["HamLightPlantFieldexit"] = 1,
            ["HamWormPlantField"] = 1,
            ["HamFernGully"] = 1,
            ["HamSlurtlePlains"] = 1,
            ["HamMudWithRabbit"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGMud",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("HamMudCave", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND2},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND3},
        room_choices = {
            ["HamWormPlantField"] = 1,
            ["HamSlurtlePlains"] = 1,
            ["HamMudWithRabbit"] = 1,
            ["HamMudWithRabbitexit"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGBatCaveRoom",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("HamMudLights", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND2},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND3},
        room_choices = {
            ["HamLightPlantField"] = 3,
            ["HamWormPlantField"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamWormPlantField",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("HamMudPit", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND2},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND3},
        room_choices = {
            ["SlurtlePlains"] = 1,
            ["PitRoom"] = 2
        },
        background_room = "HamFernGully",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    ------------------------------------------------------------
    -- Main Caves Branches
    ------------------------------------------------------------
    -- Big Bat Cave
    AddTask("HamBigBatCave", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamBatCave"] = 3,
            ["HamBattyCave"] = 1,
            ["HamFernyBatCave"] = 1,
            ["HamFernyBatCaveexit"] = 1,
            ["PitRoom"] = 2
        },
        background_room = "HamBGBatCaveRoom",
        room_bg = GROUND.CAVE,
        colour = {
            r = 0.8,
            g = 0.8,
            b = 0.8,
            a = 0.9
        }
    })

    -- Rocky Land
    AddTask("HamRockyLand", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4, KEYS.ISLAND7},
        room_choices = {
            ["HamSlurtleCanyon"] = 1,
            ["HamBatsAndSlurtles"] = 1,
            ["HamRockyPlains"] = 1,
            ["HamRockyPlainsexit"] = 1,
            ["HamRockyHatchingGrounds"] = 1,
            ["HamBatsAndRocky"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGRockyCaveRoom",
        room_bg = GROUND.CAVE,
        colour = {
            r = 0.5,
            g = 0.5,
            b = 0.5,
            a = 0.9
        }
    })

    ----------------------------------

    -- Red Forest
    AddTask("HamRedForest", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamRedMushForest"] = 2,
            ["HamRedSpiderForest"] = 1,
            ["HamRedSpiderForestexit"] = 1,
            ["HamRedMushPillars"] = 1,
            ["HamStalagmiteForest"] = 1,
            ["HamSpillagmiteMeadow"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGRedMush",
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        colour = {
            r = 1.0,
            g = 0.5,
            b = 0.5,
            a = 0.9
        }
    })

    AddRoom("caveruinexitroom", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.SINKHOLE,
        contents = {
            countstaticlayouts = {
                ["ruins_exit"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight = 0.05,
                cavelight_small = 0.05,
                cavelight_tiny = 0.05,
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.05,
                cave_fern = 0.5,
                fireflies = 0.01,

                red_mushroom = 0.1,
                green_mushroom = 0.1,
                blue_mushroom = 0.1
            }
        }
    })

    AddRoom("caveruinexitroom2", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.SINKHOLE,
        contents = {
            countstaticlayouts = {
                ["ruins_exit2"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight = 0.05,
                cavelight_small = 0.05,
                cavelight_tiny = 0.05,
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.05,
                cave_fern = 0.5,
                fireflies = 0.01,

                red_mushroom = 0.1,
                green_mushroom = 0.1,
                blue_mushroom = 0.1
            }
        }
    })

    AddTask("caveruinsexit", {
        locks = {LOCKS.ENTRANCE_INNER},
        keys_given = {},
        room_choices = {
            ["caveruinexitroom"] = 1
        },
        background_room = "BGSinkhole",
        room_bg = GROUND.SINKHOLE,
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("caveruinsexit2", {
        locks = {LOCKS.ENTRANCE_OUTER},
        keys_given = {},
        room_choices = {
            ["caveruinexitroom2"] = 1
        },
        background_room = "BGSinkhole",
        room_bg = GROUND.SINKHOLE,
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 1
        }
    })

    -- Green Forest
    AddTask("HamGreenForest", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamGreenMushForest"] = 2,
            ["HamGreenMushPonds"] = 1,
            ["HamGreenMushSinkhole"] = 1,
            ["HamGreenMushMeadow"] = 1,
            ["HamGreenMushRabbits"] = 1,
            ["HamGreenMushNoise"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGGreenMush",
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        colour = {
            r = 0.5,
            g = 1.0,
            b = 0.5,
            a = 0.9
        }
    })

    -- Blue Forest
    AddTask("HamBlueForest", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4, KEYS.ISLAND5},
        room_choices = {
            ["HamBlueMushForest"] = 3,
            ["HamBlueMushMeadow"] = 2,
            ["HamBlueSpiderForest"] = 1,
            ["HamDropperDesolation"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGBlueMush",
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        colour = {
            r = 0.5,
            g = 0.5,
            b = 1.0,
            a = 0.9
        }
    })

    --------------------ham pigmaze--------------------------

    AddTask("HamMoonCaveForest", {
        locks = {LOCKS.ISLAND5},
        keys_given = {KEYS.ISLAND6},
        room_tags = {"nocavein"},
        room_choices = {
            ["HamCaveGraveyard"] = 1,
            ["HamCaveGraveyardentrance"] = 1
        },
        background_room = "HamCaveGraveyard",
        room_bg = GROUND.FUNGUSMOON,
        colour = {
            r = 0.3,
            g = 0.3,
            b = 0.3,
            a = 0.9
        }
    })

    AddTask("HamArchiveMaze", {
        locks = {LOCKS.ISLAND6},
        keys_given = {},
        room_tags = {"nocavein"},
        entrance_room = "HamArchiveMazeEntrance",
        room_choices = {
            ["ArchiveMazeRooms"] = 4
        },
        room_bg = GROUND.ARCHIVE,
        --    maze_tiles = {rooms = {"archive_hallway"}, bosses = {"archive_hallway"}, keyroom = {"archive_keyroom"}, archive = {start={"archive_start"}, finish={"archive_end"}}, bridge_ground=GROUND.FAKE_GROUND},
        maze_tiles = {
            rooms = {"hamlet_hallway", "hamlet_hallway_two"},
            bosses = {"hamlet_hallway"},
            archive = {
                keyroom = {"hamlet_keyroom"}
            },
            special = {
                finish = {"hamlet_end"},
                start = {"hamlet_start"}
            },
            bridge_ground = GROUND.FAKE_GROUND
        },
        background_room = "ArchiveMazeRooms",
        cove_room_chance = 0,
        cove_room_max_edges = 0,
        make_loop = true,
        colour = {
            r = 1,
            g = 0,
            b = 0.0,
            a = 1
        }
    })

    AddRoom("HamArchiveMazeEntrance", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.CAVE_NOISE,
        tags = {"MazeEntrance", "RoadPoison"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                tree_forest_rot = 0.05,
                lightflier_flower = 0.01,
                cavelightmoon = 0.01,
                cavelightmoon_small = 0.01,
                cavelightmoon_tiny = 0.01,

                stalagmite_tall = 0.03,
                stalagmite_tall_med = 0.03,
                stalagmite_tall_low = 0.03,
                batcave = 0.01
            }
        }
    })

    AddRoom("HamCaveGraveyardentrance", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MARSH,
        tags = {"RoadPoison", "Mist"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                tree_forest_rot = 0.05,

                lightflier_flower = 0.01,

                cavelightmoon = 0.01,
                cavelightmoon_small = 0.01,
                cavelightmoon_tiny = 0.01,

                pigghostspawner = 0.005,
                piggravestone1 = 0.02,
                piggravestone2 = 0.02
            }
        }
    })

    AddRoom("HamCaveGraveyard", {
        colour = {
            r = .010,
            g = .010,
            b = .10,
            a = .50
        },
        value = GROUND.MARSH,
        tags = {"Mist"},
        contents = {
            countprefabs = {
                tree_forest_rot = 20,
                pigghostspawner = 10,
                goldnugget = function()
                    return math.random(10)
                end,
                piggravestone1 = function()
                    return 10 + math.random(4)
                end,
                piggravestone2 = function()
                    return 10 + math.random(4)
                end
            }
        }
    })
    ----------------------------------------------

    AddTask("HamSpillagmiteCaverns", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamSpidersAndBats"] = 1,
            ["HamThuleciteDebris"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGSpillagmite",
        room_bg = GROUND.UNDERROCK,
        colour = {
            r = 0.3,
            g = 0.3,
            b = 0.3,
            a = 0.9
        }
    })

    AddTask("HamSpillagmiteCaverns1", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamSpillagmiteForest"] = 1,
            ["HamDropperCanyon"] = 1,
            ["HamStalagmitesAndLights"] = 1
        },
        background_room = "HamSpillagmiteForest",
        room_bg = GROUND.FUNGUS,
        colour = {
            r = 0.3,
            g = 0.3,
            b = 0.3,
            a = 0.9
        }
    })
    ----------------------------------------------Ham caves---------------------------------------------------------------------------
    -- plainscave
    AddRoom("HamLightPlantField", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .4,
            distributeprefabs = {
                flower_cave = 1.0,
                flower_cave_double = 0.5,
                flower_cave_triple = 0.5,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,

                pig_ruins_head = 0.02,
                flower_rainforest = 2,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 1,
                deep_jungle_fern_noise_plant2 = 1,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            }
        }
    })

    -- plainscave 2
    AddRoom("HamLightPlantFieldexit", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .4,
            distributeprefabs = {
                flower_cave = 1.0,
                flower_cave_double = 0.5,
                flower_cave_triple = 0.5,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,

                pig_ruins_head = 0.02,
                flower_rainforest = 2,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                cave_exit_ham1 = 1
            }
        }
    })

    -- plainscave 3
    AddRoom("HamWormPlantField", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,

                pillar_cave_flintless = 0.02,

                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05,

                wormlight_plant = 0.2

            }
        }
    })

    -- plainscave 4 fern
    AddRoom("HamFernGully", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .5,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- plainscave
    AddRoom("HamSlurtlePlains", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .4,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- plainscave
    AddRoom("HamMudWithRabbit", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- plainscave
    AddRoom("HamMudWithRabbitexit", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05

            },
            countprefabs = {
                cave_exit_ham2 = 1
            }
        }
    })

    -- plainscave
    AddRoom("HamBGMud", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- cave iron
    AddRoom("HamBatCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            }
        }
    })

    -- cave iron
    AddRoom("HamBattyCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.1,
                slurtlehole = 0.5
            }
        }
    })
    -- cave iron
    AddRoom("HamFernyBatCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            }
        }
    })

    -- cave iron
    AddRoom("HamFernyBatCaveexit", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                cave_fern = 0.5,
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            },
            countprefabs = {
                cave_exit_ham3 = 1
            }
        }
    })

    -- caveiron
    AddRoom("HamBGBatCaveRoom", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .13,
            distributeprefabs = {
                cave_fern = 0.5,
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            }
        }
    })

    ---------------inicia aqui-----------------------	

    -- fip
    AddRoom("HamSlurtleCanyon", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                anthill_cavelamp = 0.1,
                grotto_pillar_bug = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                rock_flintless = 1.0,
                rock_flintless_med = 1.0,
                rock_flintless_low = 1.0,
                pillar_cave_flintless = 0.2,

                stalagmite_tall = 0.5,
                stalagmite_tall_med = 0.2,
                stalagmite_tall_low = 0.2,
                fissure = 0.01,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antcombhomecave = 2,
                ant_cave_lantern = 2,
                anthillcave = 4,
                grotto_parsnip_planted = 3,
                grotto_parsnip_giant = 1

            }
        }
    })

    -- fip
    AddRoom("HamBatsAndSlurtles", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                anthill_cavelamp = 0.1,
                grotto_pillar_bug = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                rock_flintless = 1.0,
                rock_flintless_med = 1.0,
                rock_flintless_low = 1.0,
                pillar_cave_flintless = 0.2,
                stalagmite_tall = 0.5,
                stalagmite_tall_med = 0.2,
                deco_hive_debris = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antcombhomecave = 2,
                ant_cave_lantern = 2,
                anthillcave = 4,
                grotto_parsnip_planted = 3,
                grotto_parsnip_giant = 1,
                antchest = 1
            }
        }
    })

    -- fip
    AddRoom("HamRockyPlains", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                anthill_cavelamp = 0.1,
                grotto_pillar_bug = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                antcombhomecave = 0.15,
                sapling = 0.2,
                guano = 0.27,
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                fissure = 0.05,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2,
                anthillcave = 4,
                grotto_grub_nest = 1,
                grotto_parsnip_planted = 3,
                grotto_parsnip_giant = 1,
                pond_cave = 2
            }
        }
    })

    -- fip
    AddRoom("HamRockyPlainsexit", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                anthill_cavelamp = 0.1,
                grotto_pillar_bug = 0.08,
                ant_cave_lantern = 0.1,
                rock_flippable = 0.7,
                rock_antcave = 0.3,
                sapling = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2,
                grotto_grub_nest = 5,
                grotto_parsnip_planted = 3,
                grotto_parsnip_giant = 1
            }
        }
    })

    -- fip
    AddRoom("HamRockyHatchingGrounds", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .30,
            distributeprefabs = {
                anthill_cavelamp = 0.1,
                grotto_pillar_bug = 0.08,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2,
                grotto_grub_nest = 5,
                grotto_parsnip_planted = 3,
                grotto_parsnip_giant = 1
            }
        }
    })

    -- fip
    AddRoom("HamBatsAndRocky", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        contents = {
            countstaticlayouts = {
                ["antqueencave"] = 1
            },
            distributepercent = .35,
            distributeprefabs = {
                anthill_cavelamp = 0.1,
                grotto_pillar_bug = 0.08,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antchest = 1,
            }
        }
    })

    -- fip
    AddRoom("HamBGRockyCaveRoom", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},	
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                grotto_pillar_bug = 0.08,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antcombhomecave = 2,
                giantgrubspawner = 1,
                --		ant_cave_lantern = 2,
                anthillcave = 2,
                anthill_cavelamp = 2,
                grotto_grub_nest = 1,
                grotto_parsnip_planted = 3,
                grotto_parsnip_giant = 1,
                grotto_pillar_bug = 2
            }
        }
    })

    ---------

    -- Gass MIX MUSH
    AddRoom("HamRedMushForest", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,
                stalagmite = 0.5,
                spiderhole = 0.05,
                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamRedSpiderForest", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,

                stalagmite = 1.5,
                spiderhole = 0.4,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamRedSpiderForestexit", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,

                pillar_cave = 0.2,
                spiderhole = 0.4,
                stalagmite = 0.2,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamRedMushPillars", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                mushtree_yelow = 6.0,
                yelow_mushroom = 0.9,

                stalagmite = 0.5,
                spiderhole = 0.01,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamStalagmiteForest", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,

                stalagmite = 3.5,
                spiderhole = 0.15,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamSpillagmiteMeadow", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,

                stalagmite = 1.5,
                spiderhole = 0.45,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            },
            countprefabs = {
                maze_pig_ruins_entrance2 = 1
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamBGRedMush", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Green mush forest
    AddRoom("HamGreenMushForest", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- green
    AddRoom("HamGreenMushPonds", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                pond = 1,

                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- Greenmush Sinkhole
    AddRoom("HamGreenMushSinkhole", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            countstaticlayouts = {
                ["EvergreenSinkhole"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight_small = 0.05,

                grass = 0.1,
                sapling = 0.1,
                twiggytree = 0.04,

                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- green
    AddRoom("HamGreenMushMeadow", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                cavelight_small = 0.05,

                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            },
            countprefabs = {
                maze_pig_ruins_entrance = 1
            }
        }
    })

    -- green
    AddRoom("HamGreenMushRabbits", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            countstaticlayouts = {
                ["farm_3"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                grass = 0.1,
                sapling = 0.1,
                twiggytree = 0.04,

                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            },
            countprefabs = {
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    -- Green Mush and Sinkhole Noise
    AddRoom("HamGreenMushNoise", {
        colour = {
            r = .36,
            g = .32,
            b = .38,
            a = .50
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- Green
    AddRoom("HamBGGreenMush", {
        colour = {
            r = .36,
            g = .32,
            b = .38,
            a = .50
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBlueMushForest", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .5,
            distributeprefabs = {
                mushtree_tall = 4.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBlueMushMeadow", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_tall = 1.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBlueSpiderForest", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            countstaticlayouts = {
                ["mandraketown"] = 1
            },

            distributepercent = .3,
            distributeprefabs = {
                mushtree_tall = 3.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            },
            countprefabs = {
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamDropperDesolation", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                mushtree_tall = 1.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBGBlueMush", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .5,
            distributeprefabs = {
                mushtree_tall = 5.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- vampire
    AddRoom("HamSpillagmiteForest", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.FUNGUS,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                deco_cave_ceiling_trim = 0.3,
                deco_cave_beam_room = 0.3,
                stalagmite = 0.3,
                stalagmite_tall = 0.3,
                deco_cave_stalactite = 0.3,
                rocks = 0.3,
                twigs = 1,
                cave_fern = 0.8,
                deco_cave_bat_burrow = 0.2,
                mushtree_medium = 1.0,
                spiderhole = 0.1
            }
        }
    })

    -- vampire
    AddRoom("HamDropperCanyon", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.FUNGUS,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                deco_cave_ceiling_trim = 0.3,
                deco_cave_beam_room = 0.3,
                stalagmite = 0.3,
                stalagmite_tall = 0.3,
                deco_cave_stalactite = 0.3,
                rocks = 0.3,
                twigs = 1,
                cave_fern = 0.8,
                deco_cave_bat_burrow = 0.2,
                mushtree_medium = 1.0,
                spiderhole = 0.1
            }
        }
    })

    -- vampire
    AddRoom("HamStalagmitesAndLights", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.FUNGUS,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                deco_cave_ceiling_trim = 0.3,
                deco_cave_beam_room = 0.3,
                stalagmite = 0.3,
                stalagmite_tall = 0.3,
                deco_cave_stalactite = 0.3,
                rocks = 0.3,
                twigs = 1,
                cave_fern = 0.8,
                deco_cave_bat_burrow = 0.2,
                mushtree_medium = 1.0,
                spiderhole = 0.1
            }
        }
    })

    -- red
    AddRoom("HamSpidersAndBats", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                dropperweb = 0.2,
                mushtree_medium = 2.0
            }
        }
    })

    -- red
    AddRoom("HamThuleciteDebris", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                dropperweb = 0.2,
                mushtree_medium = 2.0
            }
        }
    })

    -- red
    AddRoom("HamBGSpillagmite", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                --		   dropperweb= 0.2,
                mushtree_medium = 2.0
            }
        }
    })

    -- red não usado
    AddRoom("HamCaveExitRoom", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        contents = {
            countstaticlayouts = {
                ["CaveExit"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                --		   tallbirdnest= 0.2,
                mushtree_medium = 2.0
            }
        }
    })
    ---------------
    ---------------------------------------------------------creep in the deeps------------------------------------
    AddTask("underwaterdivide", {
        locks = {LOCKS.LAND_DIVIDE_3},
        keys_given = {KEYS.LAND_DIVIDE_4},
        room_choices = {
            ["ForceDisconnectedRoom"] = 20
        },
        level_set_piece_blocker = true,
        entrance_room = "VolcanoObsidian",
        room_bg = GROUND.IMPASSABLE,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddRoom("VolcanoObsidian", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison", "tropical"},
        contents = {
            --									countstaticlayouts={["beaverking"]=1}, --adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .3,
                rock_charcoal = .3,
                volcano_shrub = .2,
                charcoal = 0.04,
                skeleton = 0.1,
                dragoonden = .05,
                elephantcactus = 0.1
                -- coffeebush = 1,
            },

            countprefabs = {
                volcanofog = math.random(1, 2)
            }
        }
    })

    AddTask("UnderwaterStart", {
        locks = LOCKS.LAND_DIVIDE_4,
        keys_given = {KEYS.JUNGLE_DEPTH_1, KEYS.JUNGLE_DEPTH_2, KEYS.JUNGLE_DEPTH_3},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomCoralPatch"] = (math.random() > 0.5 and 1) or 0,
            ["startPatch"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("SandyBiome", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = {KEYS.OTHER_JUNGLE_DEPTH_1},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomTreasureTrove"] = (math.random() > 0.5 and 1) or 0,
            ["SandyBottomCoralPatch"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("ReefBiome", {
        locks = LOCKS.JUNGLE_DEPTH_2,
        keys_given = {KEYS.OTHER_JUNGLE_DEPTH_2},

        room_choices = {
            ["CoralReef"] = math.random(2),
            ["CoralReefLight"] = (math.random() > 0.5 and 1) or 0,
            ["CoralReefJunked"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_CoralReef",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("KelpBiome", {
        locks = LOCKS.JUNGLE_DEPTH_3,
        keys_given = {KEYS.LOST_JUNGLE_DEPTH_2},

        room_choices = {
            ["KelpForest"] = math.random(2),
            ["KelpForestInfested"] = (math.random() > 0.5 and 1) or 0,
            ["KelpForestLight"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_KelpForest",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("RockyBiome", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_1,
        keys_given = {KEYS.PINACLE},

        room_choices = {
            ["RockyBottom"] = math.random(2),
            ["RockyBottomBroken"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "bg_RockyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("MoonBiome", {
        locks = LOCKS.PINACLE,
        keys_given = {KEYS.WILD_JUNGLE_DEPTH_2},

        room_choices = {
            ["LunnarBottom"] = 2,
            ["LunnarBottomBroken"] = 1,
            ["Lunnarrocks"] = 1,
            ["Lunnarrocksgnar"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.PEBBLEBEACH,
        background_room = "bg_LunnarBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("OpenWaterBiome", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_1,
        keys_given = {KEYS.PINACLE},

        entrance_room = "TidalZoneEntrance",
        room_choices = {
            ["TidalZone"] = math.random(2)
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_TidalZone",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("UnderwaterExit1", {
        locks = LOCKS.WILD_JUNGLE_DEPTH_2,
        keys_given = {KEYS.WILD_JUNGLE_DEPTH_2},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomCoralPatch"] = (math.random() > 0.5 and 1) or 0,
            ["exitPatch1"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })
    -----------------------

    AddTask("EntranceToReef", {
        locks = {LOCKS.SPIDERS_DEFEATED},
        keys_given = {KEYS.SPIDERS},

        room_choices = {
            ["UnderwaterEntrance"] = 1
        },
        room_bg = GROUND.FOREST,
        background_room = "BGGrass",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    -------------new tasks-------------------------------------------------------
    AddTask("task_underground_beach", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_1},
        room_choices = {
            ["beach1"] = 1,
            ["beach2"] = 1,
            ["beach_crab"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "beach_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwatermagmafield", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_1},
        room_choices = {
            ["underwatermagmafield1"] = 2,
            ["underwatermagmafield"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "underwatermagmafield",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwater_kraken_zone", {
        locks = LOCKS.CIVILIZATION_1,
        keys_given = {KEYS.OTHER_CIVILIZATION_1},
        room_choices = {
            ["kraken_zone"] = 1,
            ["kraken_zone_basic"] = 2
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.IMPASSABLE,
        background_room = "kraken_zone_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("secretcavedivisor", {
        locks = LOCKS.OTHER_CIVILIZATION_1,
        keys_given = KEYS.WILD_JUNGLE_DEPTH_1,
        room_choices = {
            ["ForceDisconnectedRoom"] = 6
        },
        level_set_piece_blocker = true,
        entrance_room = "cave_underwater1_entrance",
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("task_secretcave1", {
        locks = LOCKS.WILD_JUNGLE_DEPTH_1,
        keys_given = KEYS.WILD_JUNGLE_DEPTH_1,
        room_choices = {
            ["cave_underwater1_part1"] = 1
            --			["cave_underwater1_part2"] =  1, 			
        },
        level_set_piece_blocker = true,
        --		entrance_room = "ForceDisconnectedRoom",		
        room_bg = GROUND.IMPASSABLE,
        background_room = "cave_underwater_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("atlantidaExitRoom", {
        locks = {LOCKS.ENTRANCE_INNER, LOCKS.ENTRANCE_OUTER},
        keys_given = {},
        room_choices = {
            ["atlantidaExitRoom"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "BGSinkhole",
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("task_underwaterlavarock", {
        locks = LOCKS.LOST_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_2},
        room_choices = {
            ["underwaterlavarock"] = 3
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "underwaterlavarock",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwaterothers", {
        locks = LOCKS.LOST_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_2},
        room_choices = {
            ["underwaterothers_lobster"] = 1,
            ["underwaterothers_basic"] = 2
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "underwaterothers_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwaterwatercoral", {
        locks = LOCKS.CIVILIZATION_2,
        keys_given = {KEYS.OTHER_CIVILIZATION_2},
        room_choices = {
            ["underwaterwatercoral_octopus"] = 1,
            ["underwaterwatercoral"] = 2

        },
        level_set_piece_blocker = true,
        room_bg = GROUND.PAINTED,
        background_room = "underwaterwatercoral_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("UnderwaterExit2", {
        locks = LOCKS.OTHER_CIVILIZATION_2,
        keys_given = {KEYS.OTHER_CIVILIZATION_2},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomCoralPatch"] = (math.random() > 0.5 and 1) or 0,
            ["exitPatch2"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    ---------------------new creeps rooms-------------------------------
    AddRoom("beach1", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                sandhill = .3,
                seashell_beached = .5,
                rock_limpet = 0.08,
                crate = 0.1,
                jellyfish_underwater = 0.1,
                fish2_alive = 0.1,
                fish3_alive = 0.05,
                shrimp = 0.1,
                bubble_vent = 0.03,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("beach2", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                sandhill = 0.5,
                seashell_beached = 0.5,
                rock_limpet = 1,
                crate = 0.1,
                stungrayunderwater = 1,
                jellyfish_underwater = 0.1,
                fish2_alive = 0.1,
                --										shrimp = 0.1,										
                fish3_alive = 0.05,
                bubble_vent = 0.03,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("beach_crab", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                sandhill = 0.5,
                seashell_beached = 1,
                rock_limpet = 0.5,
                crate = 0.1,
                crabhole = 1,
                fish2_alive = 0.05,
                fish3_alive = 0.05,
                --										shrimp = 0.1,										
                bubble_vent = 0.03,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("beach_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                sandhill = 1,
                seashell_beached = 0.5,
                rock_limpet = 0.5,
                crate = 0.1,
                fish2_alive = 0.1,
                fish3_alive = 0.05,
                squidunderwater = 0.002,
                bubble_vent = 0.03,
                --										shrimp = 0.1,
                bioluminescence = 0.03,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterothers_lobster", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										shrimp = 0.1,
                dogfish_under = 0.5,
                fish_coi = 0.5,
                lobsterunderwater = 1,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterothers_basic", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										shrimp = 0.1,
                dogfish_under = 0.5,
                fish_coi = 0.5,
                tidal_node = 0.5,
                lobsterunderwater = 1,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterothers_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										shrimp = 0.1,
                dogfish_under = 0.5,
                fish_coi = 0.5,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("kraken_zone_basic", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                wreckunderwater = 0.5,
                --										shrimp = 0.1,
                quagmire_salmom_alive = 0.1,
                crate = 0.1,
                redbarrelunderwater = 0.2,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                tidal_node = 0.1
            }

        }
    })

    AddRoom("kraken_zone", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                krakenunderwater = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --                                      mussel_bed = .2,
                commonfish = 0.05,
                shrimp = 0.1,
                quagmire_salmom_alive = 0.1,
                redbarrelunderwater = 0.1,
                wreckunderwater = 0.5,
                crate = 0.5,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("kraken_zone_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										mussel_bed =.2,
                commonfish = 0.05,
                shrimp = 0.1,
                quagmire_salmom_alive = 0.1,
                wreckunderwater = 0.5,
                crate = 0.1,
                redbarrelunderwater = 0.2,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                tidal_node = 0.1
            }

        }
    })

    AddRoom("cave_underwater1_entrance", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                secretcaveentrance = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                stalagmite = 0.15,
                stalagmite_med = 0.15,
                stalagmite_low = 0.15,
                pillar_cave = 0.08,
                uw_flowers = 0.05,
                dogfish_under = 0.1,
                commonfish = 0.1
            }

        }
    })

    AddRoom("cave_underwater1_part1", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["atlantida"] = 1
            },
            distributepercent = .175,
            distributeprefabs = {
                stalagmite = .025,
                stalagmite_med = .025,
                stalagmite_low = .025,
                bioluminescence = 0.01,
                fissure = 0.002,
                lichen = .25,
                cave_fern = 1,
                pillar_algae = .05
            }
        }
    })

    AddRoom("atlantidaExitRoom", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.SINKHOLE,
        contents = {
            countprefabs = {
                underwater_entrance3 = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight = 0.05,
                cavelight_small = 0.05,
                cavelight_tiny = 0.05,
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.05,
                cave_fern = 0.5,
                fireflies = 0.01,

                red_mushroom = 0.1,
                green_mushroom = 0.1,
                blue_mushroom = 0.1
            }
        }
    })

    AddRoom("cave_underwater1_part2", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                stalagmite = 0.15,
                stalagmite_med = 0.15,
                stalagmite_low = 0.15,
                pillar_cave = 0.08,
                fissure = 0.05
            }
        }
    })

    AddRoom("cave_underwater_base", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0.9
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            --									countstaticlayouts={
            --										["CaveBase"]=1,
            --									},
            distributepercent = .15,
            distributeprefabs = {
                bioluminescence = 0.3,
                quagmire_salmom_alive = 0.15,
                stalagmite_tall_low = 1,
                stalagmite_tall_med = 0.6,
                stalagmite_tall = 0.2,
                pillar_cave = .05,
                pillar_stalactite = .05
            }

        }
    })

    AddRoom("underwaterlavarock", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                commonfish = 0.05,
                --										shrimp = 0.1,
                dogfish_under = 0.1,
                fish_coi = 0.1,
                redbarrelunderwater = 0.2,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwatermagmafield", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.2,
                iron_boulder = 0.6,
                rock_cave = 0.5,
                quagmire_salmom_alive = 0.05,
                dogfish_under = 0.1,
                rock_charcoal = 0.5,
                --									squid = 0.002,
                bubble_vent = 0.01,
                --									shrimp = 0.1,
                --									bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwatermagmafield1", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.2,
                iron_ore = 0.03,
                iron_boulder = 0.8,
                rock_cave = 0.5,
                quagmire_salmom_alive = 0.05,
                dogfish_under = 0.1,
                rock_charcoal = 0.5,
                --									squid = 0.002,
                bubble_vent = 0.01,
                shrimp = 0.1,
                --									bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterwatercoral", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PAINTED,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                coral_brain_rockunderwater = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                coralreefunderwater = 1,
                bubble_vent = 0.03,
                uw_flowers = .1,
                shrimp = 0.1,
                fish4_alive = 0.1,
                fish5_alive = 0.1,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterwatercoral_octopus", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PAINTED,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                coral_brain_rockunderwater = 1,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
                --									octopuskingunderwater = 1,
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                coralreefunderwater = 1,
                bubble_vent = 0.03,
                uw_flowers = .1,
                shrimp = 0.1,
                fish4_alive = 0.1,
                fish5_alive = 0.1,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterwatercoral_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PAINTED,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                coral_brain_rockunderwater = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                coralreefunderwater = 0.2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                fish4_alive = 0.05,
                fish5_alive = 0.05,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })
    ------------------------------------------------------------------------------------------
    -- Sandy rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("SandyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("startPatch", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_exit = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("exitPatch1", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_exit1 = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("exitPatch2", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_exit2 = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                rainbowjellyfish_underwater = 0.01,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("SandyBottomTreasureTrove", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                uw_coral = 0.4,
                uw_coral_blue = 0.3,
                uw_coral_green = 0.3,
                --			seatentacle = 0.01,
                rotting_trunk = 0.2,
                bubble_vent = 0.03,
                kelpunderwater = 0.5,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.2,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("SandyBottomCoralPatch", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.01,
                sandstone_boulder = 0.1,
                uw_coral = 0.25,
                uw_coral_blue = 0.25,
                uw_coral_green = 0.25,
                reef_jellyfish = 0.1,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.2,
                wormplant = 0.1,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.3,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Reef rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("CoralReef", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.6,
            distributeprefabs = {
                sandstone_boulder = 0.01,
                uw_coral = 1.5,
                uw_coral_blue = 1.5,
                uw_coral_green = 1,
                reef_jellyfish = 0.4,
                --			seatentacle = 0.5,
                bubble_vent = 0.03,
                squidunderwater = 0.001,
                decorative_shell = 0.2,
                sea_eel = 0.2,
                sponge = 0.15,
                rainbowjellyfish_underwater = 0.01,
                commonfish = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("CoralReefJunked", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                sandstone_boulder = 0.01,
                uw_coral = 1.3,
                uw_coral_blue = 1.3,
                uw_coral_green = 1.3,
                reef_jellyfish = 0.4,
                --			seatentacle = 0.5,
                bubble_vent = 0.03,
                squidunderwater = 0.01,
                cut_orange_coral = 1,
                decorative_shell = 0.05,
                sea_eel = 0.2,
                sponge = 0.15,
                commonfish = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("CoralReefLight", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                gnarwailunderwater = 1
            },

            distributepercent = 0.3,
            distributeprefabs = {
                sandstone_boulder = 0.05,
                uw_coral = 1,
                uw_coral_blue = 1,
                uw_coral_green = 1,
                iron_boulder = 0.5,
                bubble_vent = 0.03,
                rotting_trunk = 0.1,
                reef_jellyfish = 0.4,
                squidunderwater = 0.01,
                decorative_shell = 0.1,
                wormplant = 0.1,
                sponge = 0.15,
                commonfish = 0.2,
                rainbowjellyfish_underwater = 0.01,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Kelp rooms
    ------------------------------------------------------------------------------------------

    AddRoom("KelpForest", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                kelpunderwater = 2.5,
                rotting_trunk = 0.01,
                seagrass = 0.005,
                sandstone_boulder = 0.0008,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                sea_eel = 0.001,
                bubble_vent = 0.03,
                commonfish = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("KelpForestLight", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = 0.6,
            distributeprefabs = {
                kelpunderwater = 0.5,
                rotting_trunk = 0.05,
                seagrass = 0.005,
                sandstone_boulder = 0.0008,
                --			mermworkerhouse = 0.02,
                squidunderwater = 0.0001,
                --			seatentacle = 0.0001,
                flower_sea = 0.1,
                sea_eel = 0.002,
                bubble_vent = 0.03,
                commonfish = 0.05,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("KelpForestInfested", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                kelpunderwater = 2.5,
                rotting_trunk = 0.01,
                seagrass = 0.005,
                sandstone_boulder = 0.008,
                reef_jellyfish = 0.2,
                squidunderwater = 0.005,
                flower_sea = 0.1,
                sea_eel = 0.001,
                rainbowjellyfish_underwater = 0.01,
                bubble_vent = 0.03,
                commonfish = 0.15,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Rocky rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("RockyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.225,
            distributeprefabs = {
                rock1 = 0.1,
                rock2 = 0.05,
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("RockyBottomBroken", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.15,
            distributeprefabs = {
                rocks = 0.1,
                rock1 = 0.1,
                rock2 = 0.05,
                iron_ore = 0.03,
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Lunnar rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("LunnarBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                seaweedunderwater = 2
            }
        }
    })

    AddRoom("LunnarBottomBroken", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = 1,
                gnarwailunderwater = 1,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                singingshell_octave3 = 0.1,
                singingshell_octave4 = 0.1,
                singingshell_octave5 = 0.1,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                seaweedunderwater = 0.1
            }
        }
    })

    AddRoom("Lunnarrocks", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                saltstack = 1,
                seastack = 1
            }
        }
    })

    AddRoom("Lunnarrocksgnar", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = 1,
                gnarwailunderwater = 1
            },

            distributepercent = 0.3,
            distributeprefabs = {
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                saltstack = 1,
                seastack = 1
            }
        }
    })

    AddRoom("bg_LunnarBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.20,
            distributeprefabs = {
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.4,
                pond_algae = 0.5,
                seaweedunderwater = 0.2,
                seastack = 0.3,
                uw_coral = 0.2,
                uw_coral_blue = 0.2,
                uw_coral_green = 0.2
            }
        }
    })
    ------------------------------------------------------------------------------------------
    -- Open water rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("TidalZoneEntrance", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.7,
            distributeprefabs = {
                seagrass = 0.05,
                sandstone = 0.35,
                uw_coral = 0.01,
                uw_coral_blue = 0.01,
                uw_coral_green = 0.01,
                cut_orange_coral = 0.1,
                tidal_node = 5,
                sponge = 0.01,
                bubble_vent = 0.03,
                commonfish = 0.05,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("TidalZone", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.7,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.04,
                uw_coral_blue = 0.04,
                uw_coral_green = 0.04,
                cut_orange_coral = 0.3,
                tidal_node = 5,
                squidunderwater = 0.008,
                sponge = 0.03,
                bubble_vent = 0.03,
                commonfish = 0.05,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Background rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("bg_SandyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.25,
            distributeprefabs = {
                seagrass = 0.15,
                uw_coral = 0.02,
                uw_coral_blue = 0.03,
                uw_coral_green = 0.03,
                kelpunderwater = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("bg_CoralReef", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.8,
            distributeprefabs = {
                sandstone_boulder = 0.01,
                uw_coral = 2,
                uw_coral_blue = 2.5,
                uw_coral_green = 2,
                reef_jellyfish = 0.3,
                kelpunderwater = 1,
                bubble_vent = 0.1,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("bg_KelpForest", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.8,
            distributeprefabs = {
                kelpunderwater = 2.5,
                rotting_trunk = 0.01,
                seagrass = 0.005,
                sandstone_boulder = 0.0008,
                flower_sea = 0.1,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("bg_RockyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.15,
            distributeprefabs = {
                rock1 = 0.1,
                rock2 = 0.05,
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("bg_TidalZone", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.9,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                cut_orange_coral = 0.3,
                tidal_node = 5,
                commonfish = 0.05,
                rainbowjellyfish_underwater = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Underwater Entrance
    ------------------------------------------------------------------------------------------

    AddRoom("UnderwaterEntrance", {
        colour = {
            r = 1,
            g = 0,
            b = 0,
            a = 0.3
        },
        value = GROUND.FOREST,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_entrance = 1
            },
            distributepercent = 0.25,
            distributeprefabs = {
                grass = 2,
                sapling = 2,
                green_mushroom = 3,
                blue_mushroom = 3,
                flower = 1,
                houndbone = 1
                -- reeds = 1,
                -- evergreen_sparse = .5,
            }
        }
    })
    --------------------------------cherry----------------------------
    if GLOBAL.KnownModIndex:IsModEnabled("workshop-1289779251") then
        AddTask("cherry_mainland", {
            locks = LOCKS.JUNGLE_DEPTH_1,
            keys_given = {KEYS.JUNGLE_DEPTH_1},
            room_tags = {"cherryarea"},
            room_choices = {
                ["CherryForest"] = 5,
                ["CherryBugs"] = 2,

                ["CherrySpawn"] = 1,
                ["CherryTrees"] = 1,
                ["CherryDeepForest"] = 1,

                ["CherryVillage"] = 1
            },
            room_bg = GROUND.CHERRY,
            background_room = "BGCherry",
            colour = {
                r = .5,
                g = 0.6,
                b = .080,
                a = .10
            }
        })
    end
    -----------------------------------------------------
    local function LevelPreInit(level)

        if level.location == "cave" and GetModConfigData("togethercaves_hamletworld") == 0 then
            if not GetModConfigData("underwater") then
                level.tasks = {}
                level.numoptionaltasks = 0
                level.set_pieces = {}
            end
        end

        -----------------------------underwater----------------------------------------
        if GetModConfigData("underwater") then
            if level.location == "cave" then
                level.overrides.keep_disconnected_tiles = true
                table.insert(level.tasks, "separavulcao")
                table.insert(level.tasks, "underwaterdivide")
                table.insert(level.tasks, "UnderwaterStart")
                table.insert(level.tasks, "SandyBiome")
                table.insert(level.tasks, "ReefBiome")
                table.insert(level.tasks, "KelpBiome")
                table.insert(level.tasks, "RockyBiome")
                table.insert(level.tasks, "MoonBiome")
                table.insert(level.tasks, "OpenWaterBiome")
                table.insert(level.tasks, "task_underground_beach")
                table.insert(level.tasks, "task_underwaterothers")
                table.insert(level.tasks, "task_underwater_kraken_zone")
                table.insert(level.tasks, "secretcavedivisor")
                table.insert(level.tasks, "task_secretcave1")
                table.insert(level.tasks, "atlantidaExitRoom")
                table.insert(level.tasks, "task_underwaterlavarock")
                table.insert(level.tasks, "task_underwatermagmafield")
                table.insert(level.tasks, "task_underwaterwatercoral")
                table.insert(level.tasks, "UnderwaterExit2")
            end
        end
        ---------------------------------------------------------------------

        -----------------------------hamlet caves----------------------------------------
        if GetModConfigData("hamletcaves_hamletworld") == 1 then
            if level.location == "cave" then
                level.overrides.keep_disconnected_tiles = true
                table.insert(level.tasks, "separavulcao")

                table.insert(level.tasks, "separahamcave")
                table.insert(level.tasks, "HamMudWorld")
                table.insert(level.tasks, "HamMudCave")
                table.insert(level.tasks, "HamMudLights")
                table.insert(level.tasks, "HamMudPit")

                table.insert(level.tasks, "HamBigBatCave")
                table.insert(level.tasks, "HamRockyLand")
                table.insert(level.tasks, "HamRedForest")
                table.insert(level.tasks, "HamGreenForest")
                table.insert(level.tasks, "HamBlueForest")
                table.insert(level.tasks, "HamSpillagmiteCaverns")
                table.insert(level.tasks, "HamSpillagmiteCaverns1")
                table.insert(level.tasks, "caveruinsexit")
                table.insert(level.tasks, "caveruinsexit2")

                table.insert(level.tasks, "HamMoonCaveForest")
                table.insert(level.tasks, "HamArchiveMaze")

            end
        end
        -------------------------------------------------------------------------------------------------------
        if level.location == "forest" then
            level.overrides.start_location = "porkland_start"
            level.random_set_pieces = {}
            level.numrandom_set_pieces = 0
            level.ordered_story_setpieces = {}
            --    level.islands = "always"
            level.overrides.has_ocean = false
            level.overrides.keep_disconnected_tiles = true
            level.location = "forest"
        end
    end

    AddLevelPreInitAny(LevelPreInit)

    local function TasksetPreInit(taskset)
        if taskset.location ~= "forest" then
            return
        end
        taskset.tasks = {"inicio", "Pigtopia", "Pigtopia_capital", "Edge_of_civilization", "Edge_of_the_unknown",
                         "Edge_of_the_unknown_2", "Lilypond_land", "Lilypond_land_2", "Deep_rainforest",
                         "Deep_rainforest_2", "Deep_lost_ruins_gas", "Lost_Ruins_1", "Deep_rainforest_3",
                         "Deep_rainforest_mandrake", "Path_to_the_others", "Other_pigtopia_capital", "Other_pigtopia",
                         "Other_edge_of_civilization", "this_is_how_you_get_ants", "Deep_lost_ruins4",
                         "lost_rainforest", --			"interior_space",
        "Land_Divide_1", "Land_Divide_2", "Land_Divide_3", "Land_Divide_4", "painted_sands", "plains", "rainforests",
                         "rainforest_ruins", "plains_ruins", "pincale", "Deep_wild_ruins4", "wild_rainforest",
                         "wild_ancient_ruins" --            "Land_Divide_5",			
        }

        taskset.numoptionaltasks = 0
        taskset.optionaltasks = {}

        taskset.ocean_prefill_setpieces = {}

        taskset.ocean_population = {}

        taskset.valid_start_tasks = {"inicio"}

        taskset.set_pieces = {}

        if GLOBAL.KnownModIndex:IsModEnabled("workshop-2039181790") then
            table.insert(taskset.tasks, "GiantTrees")
        end
        -----------------------------cherry forest-----------------------------------------------------
        if GLOBAL.KnownModIndex:IsModEnabled("workshop-1289779251") then
            table.insert(taskset.tasks, "cherry_mainland")
        end

        if GetModConfigData("togethercaves_hamletworld") == 1 then
            taskset.set_pieces["CaveEntrance"] = {
                count = 10,
                tasks = {"plains", "plains_ruins", "Deep_rainforest", "Deep_rainforest_2", "painted_sands",
                         "Edge_of_civilization", "Deep_rainforest_mandrake", "rainforest_ruins", "Pigtopia"}
            }
        end

        if GetModConfigData("hamletcaves_hamletworld") == 1 then
            taskset.set_pieces["cave_entranceham1"] = {
                count = 1,
                tasks = {"plains", "plains_ruins"}
            }
            taskset.set_pieces["cave_entranceham2"] = {
                count = 1,
                tasks = {"Deep_rainforest", "Deep_rainforest_2", "painted_sands"}
            }
            taskset.set_pieces["cave_entranceham3"] = {
                count = 1,
                tasks = {"Edge_of_civilization", "Deep_rainforest_mandrake", "rainforest_ruins"}
            }
        end
        taskset.location = "forest"

        if GetModConfigData("tropicalshards") ~= 0 then
            taskset.set_pieces["hamlet_exit"] = {
                count = 1,
                tasks = {"plains", "plains_ruins", "Deep_rainforest", "Deep_rainforest_2", "painted_sands",
                         "Edge_of_civilization", "Deep_rainforest_mandrake", "rainforest_ruins"}
            }
        end

    end

    AddTaskSetPreInitAny(TasksetPreInit)

    AddStartLocation("porkland_start", {
        name = "Porkland",
        location = "forest",
        start_setpeice = "porkland_start",
        start_node = "PorklandPortalRoom"
    })
    ---------------------------a partir daqui o mod volcano biome normal------------------------------------
elseif GetModConfigData("kindofworld") == 20 then

    AddStartLocation("OceanWorld", {
        name = "OceanWorld",
        location = "forest",
        start_setpeice = "oceanworldstart",
        start_node = "Blank"
    })

    AddTask("OceanWorldstart", {
        locks = {},
        keys_given = {},
        room_choices = {
            ["Blank"] = 1
        },
        room_bg = GROUND.GRASS,
        background_room = "Blank",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddRoom("OceanCoastalShore_SEA", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_COASTAL_SHORE,
        contents = {
            distributepercent = 0.005,
            distributeprefabs = {
                wobster_den_spawner_shore = 1
            }
        }
    })

    AddRoom("OceanCoastal_SEA", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_COASTAL,
        contents = {

            countprefabs = {
                seaweed_planted = 200,
                mussel_farm = 300,
                messagebottle1 = 20,
                mermboat = 4
            },

            distributepercent = 0.01,
            distributeprefabs = {
                driftwood_log = 1,
                bullkelp_plant = 2,
                messagebottle = 0.08
            }

        }
    })

    AddRoom("OceanSwell_SEA", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_SWELL,
        required_prefabs = {"crabking_spawner"},
        contents = {

            countprefabs = {},
            distributepercent = 0.005,
            distributeprefabs = {
                seastack = 1,
                seastack_spawner_swell = 0.1,
                undersearock1 = 0.5,
                undersearock2 = 0.25,
                undersearock_flintless = 0.1,
                undersearock_moon = 0.1,
                oceanfish_shoalspawner = 0.07
            },
            countstaticlayouts = {
                ["CrabKing"] = 1,
                ["BullkelpFarmSmall"] = 6,
                ["BullkelpFarmMedium"] = 3,
                ["lilypadnovo"] = 2 * GetModConfigData("lilypad"),
                ["lilypadnovograss"] = GetModConfigData("lilypad"),
                ["icebergs"] = 8,
                ["oceangrotolunar"] = 1,
                ["oceanrocks"] = 4
            }

        }
    })

    -- "moonglass_wobster_den"	"lobsterhole"	"wobster_den"
    AddRoom("OceanRough_SEA", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_ROUGH,
        required_prefabs = {"hermithouse_construction1", "waterplant"},
        contents = {
            countprefabs = {
                messagebottle1 = 20,
                waterplant = 1
            },

            distributepercent = 0.01,
            distributeprefabs = {
                seastack = 1,
                seastack_spawner_rough = 0.09,
                undersearock1 = 0.5,
                undersearock2 = 0.25,
                undersearock_flintless = 0.1,
                undersearock_moon = 0.1,
                waterplant_spawner_rough = 0.04
            },
            countstaticlayouts = {
                ["HermitcrabIsland"] = 1,
                ["BullkelpFarmSmall"] = 6,
                ["BullkelpFarmMedium"] = 3,
                ["oceanforest"] = 5,
                ["oceanbamboforest"] = 5
            }
        }
    })

    -- coral					
    AddRoom("OceanReef_SEA", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_BRINEPOOL,
        contents = {
            countprefabs = {},

            distributepercent = 0,
            distributeprefabs = {}

        }
    })

    -- ship gravery
    AddRoom("OceanHazardous_SEA", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_HAZARDOUS,
        contents = {
            countprefabs = {},
            distributepercent = 0.15,
            distributeprefabs = {
                boatfragment03 = 1,
                boatfragment04 = 1,
                boatfragment05 = 1,
                seastack = 1
            }
        }
    })

    AddLevelPreInitAny(function(level)
        if level.location ~= "forest" then
            return
        end
        level.tasks = {"OceanWorldstart"}
        level.numoptionaltasks = 0
        level.optionaltasks = {}
        level.valid_start_tasks = nil
        level.set_pieces = {}

        if level.ocean_population == nil then
            level.ocean_population = {}
        end

        level.ocean_population = {"OceanCoastalShore_SEA", "OceanCoastal_SEA", "OceanSwell_SEA", "OceanRough_SEA",
                                  "OceanReef_SEA", "OceanHazardous_SEA"}

        level.random_set_pieces = {}
        level.ordered_story_setpieces = {}
        level.numrandom_set_pieces = 0

        level.overrides.start_location = "OceanWorld"
        level.overrides.keep_disconnected_tiles = true
        level.overrides.roads = "never"

        level.ocean_prefill_setpieces["coralpool1"] = {
            count = 3 * GetModConfigData("coralbiome")
        }
        level.ocean_prefill_setpieces["coralpool2"] = {
            count = 3 * GetModConfigData("coralbiome")
        }
        level.ocean_prefill_setpieces["coralpool3"] = {
            count = 2 * GetModConfigData("coralbiome")
        }
        level.ocean_prefill_setpieces["octopuskinghome"] = {
            count = GetModConfigData("octopusking")
        }
        level.ocean_prefill_setpieces["mangrove1"] = {
            count = 2 * GetModConfigData("mangrove")
        }
        level.ocean_prefill_setpieces["mangrove2"] = {
            count = GetModConfigData("mangrove")
        }
        level.ocean_prefill_setpieces["wreck"] = {
            count = GetModConfigData("shipgraveyard")
        }
        level.ocean_prefill_setpieces["wreck2"] = {
            count = GetModConfigData("shipgraveyard")
        }
        level.ocean_prefill_setpieces["kraken"] = {
            count = GetModConfigData("kraken")
        }

        level.required_prefabs = {}
    end)

else

    salasvolcano = {
        [1] = "VolcanoRock",
        [2] = "VolcanoAsh",
        [3] = "VolcanoObsidian",
        [4] = "VolcanoRock",
        [5] = "VolcanoRock"
    }

    salasmagma = {
        [1] = "Magma",
        [2] = "MagmaHome",
        [3] = "MagmaHomeBoon",
        [4] = "GenericMagmaNoThreat",
        [5] = "MagmaGold",
        [6] = "MagmaGoldBoon",
        [7] = "MagmaTallBird",
        [8] = "MagmaVolcano"
    }

    salasbeach = {
        [1] = "BeachSkull",
        [2] = "BeachShells",
        [3] = "BeachShells1",
        [4] = "BeachNoCrabbits",
        [5] = "BeachNoLimpets",
        [6] = "BeachFlowers",
        [7] = "BeachNoFlowers",
        [8] = "BeachSpider",
        [9] = "BeachLimpety",
        [10] = "BeachRocky",
        [11] = "BeachSappy",
        [12] = "BeachGrassy",
        [13] = "BeachDunes",
        [14] = "BeachCrabTown",
        [15] = "BeesBeach",
        [16] = "BeachPiggy",
        [17] = "BeachPalmForest",
        [18] = "BeachWaspy",
        [19] = "DoydoyBeach",
        [20] = "BeachSinglePalmTreeHome",
        [21] = "BeachGravel",
        [22] = "BeachUnkeptDubloon",
        [23] = "BeachUnkept",
        [24] = "BeachSand"
    }

    salasjungle = {
        [1] = "JungleEyeplant",
        [2] = "JungleFrogSanctuary",
        [3] = "JungleBees",
        [4] = "JungleDenseVery",
        [5] = "JungleClearing",
        [6] = "Jungle",
        [7] = "JungleSparse",
        [8] = "JungleSparseHome",
        [9] = "JungleDense",
        [10] = "JungleDenseHome",
        [11] = "JungleDenseMed",
        [12] = "JungleDenseBerries",
        [13] = "JungleDenseMedHome",
        [14] = "JunglePigGuards",
        [15] = "JungleFlower",
        [16] = "JungleSpidersDense",
        [17] = "JungleSpiderCity",
        [18] = "JungleBamboozled",
        [19] = "JungleMonkeyHell",
        [20] = "JungleCritterCrunch",
        [21] = "JungleDenseCritterCrunch",
        [22] = "JungleShroomin",
        [23] = "JungleRockyDrop",
        [24] = "JungleGrassy",
        [25] = "JungleSappy",
        [26] = "JungleEvilFlowers",
        [27] = "JungleParrotSanctuary",
        [28] = "JungleNoBerry",
        [29] = "JungleNoRock",
        [30] = "JungleNoMushroom",
        [31] = "JungleNoFlowers",
        [32] = "JungleMorePalms",
        [33] = "JungleSkeleton"
    }

    salastidal = {
        [1] = "TidalMarsh",
        [2] = "TidalMarsh1",
        [3] = "TidalMermMarsh",
        [4] = "ToxicTidalMarsh"
    }

    salasmeadow = {
        [1] = "NoOxMeadow",
        [2] = "MeadowOxBoon",
        [3] = "MeadowFlowery",
        [4] = "MeadowBees",
        [5] = "MeadowCarroty",
        [6] = "MeadowSappy",
        [7] = "MeadowSpider",
        [8] = "MeadowRocky",
        [9] = "MeadowMandrake"
    }

    --------------------------------------------
    salasvolcano1 = {
        [1] = "MAINVolcanoRock",
        [2] = "MAINVolcanoAsh",
        [3] = "MAINVolcanoObsidian",
        [4] = "MAINVolcanoRock",
        [5] = "MAINVolcanoRock"
    }

    salasmagma1 = {
        [1] = "MAINMagma",
        [2] = "MAINMagmaHome",
        [3] = "MAINMagmaHomeBoon",
        [4] = "MAINGenericMagmaNoThreat",
        [5] = "MAINMagmaGold",
        [6] = "MAINMagmaGoldBoon",
        [7] = "MAINMagmaTallBird",
        [8] = "MAINMagmaVolcano"
    }

    salasbeach1 = {
        [1] = "MAINBeachSkull",
        [2] = "MAINBeachShells",
        [3] = "MAINBeachShells1",
        [4] = "MAINBeachNoCrabbits",
        [5] = "MAINBeachNoLimpets",
        [6] = "MAINBeachFlowers",
        [7] = "MAINBeachNoFlowers",
        [8] = "MAINBeachSpider",
        [9] = "MAINBeachLimpety",
        [10] = "MAINBeachRocky",
        [11] = "MAINBeachSappy",
        [12] = "MAINBeachGrassy",
        [13] = "MAINBeachDunes",
        [14] = "MAINBeachCrabTown",
        [15] = "MAINBeesBeach",
        [16] = "MAINBeachPiggy",
        [17] = "MAINBeachPalmForest",
        [18] = "MAINBeachWaspy",
        [19] = "MAINDoydoyBeach",
        [20] = "MAINBeachSinglePalmTreeHome",
        [21] = "MAINBeachGravel",
        [22] = "MAINBeachUnkeptDubloon",
        [23] = "MAINBeachUnkept",
        [24] = "MAINBeachSand"
    }

    salasjungle1 = {
        [1] = "MAINJungleEyeplant",
        [2] = "MAINJungleFrogSanctuary",
        [3] = "MAINJungleBees",
        [4] = "MAINJungleDenseVery",
        [5] = "MAINJungleClearing",
        [6] = "MAINJungle",
        [7] = "MAINJungleSparse",
        [8] = "MAINJungleSparseHome",
        [9] = "MAINJungleDense",
        [10] = "MAINJungleDenseHome",
        [11] = "MAINJungleDenseMed",
        [12] = "MAINJungleDenseBerries",
        [13] = "MAINJungleDenseMedHome",
        [14] = "MAINJunglePigGuards",
        [15] = "MAINJungleFlower",
        [16] = "MAINJungleSpidersDense",
        [17] = "MAINJungleSpiderCity",
        [18] = "MAINJungleBamboozled",
        [19] = "MAINJungleMonkeyHell",
        [20] = "MAINJungleCritterCrunch",
        [21] = "MAINJungleDenseCritterCrunch",
        [22] = "MAINJungleShroomin",
        [23] = "MAINJungleRockyDrop",
        [24] = "MAINJungleGrassy",
        [25] = "MAINJungleSappy",
        [26] = "MAINJungleEvilFlowers",
        [27] = "MAINJungleParrotSanctuary",
        [28] = "MAINJungleNoBerry",
        [29] = "MAINJungleNoRock",
        [30] = "MAINJungleNoMushroom",
        [31] = "MAINJungleNoFlowers",
        [32] = "MAINJungleMorePalms",
        [33] = "MAINJungleSkeleton"
    }

    salastidal1 = {
        [1] = "MAINTidalMarsh",
        [2] = "MAINTidalMarsh1",
        [3] = "MAINTidalMermMarsh",
        [4] = "MAINToxicTidalMarsh"
    }

    salasmeadow1 = {
        [1] = "MAINNoOxMeadow",
        [2] = "MAINMeadowOxBoon",
        [3] = "MAINMeadowFlowery",
        [4] = "MAINMeadowBees",
        [5] = "MAINMeadowCarroty",
        [6] = "MAINMeadowSappy",
        [7] = "MAINMeadowSpider",
        [8] = "MAINMeadowRocky",
        [9] = "MAINMeadowMandrake"
    }

    --[[ROOMS]]
    ---------------------------novo oceano --------------------------------------

    AddRoom("OceanCoastal_TE", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_COASTAL,
        contents = {
            countprefabs = {
                mermboat = 4
            },
            distributepercent = 0.01,
            distributeprefabs = {
                driftwood_log = 1,
                bullkelp_plant = 2,
                messagebottle = 0.1,
                messagebottle1 = 0.1
            },

            countstaticlayouts = {
                ["BullkelpFarmSmall"] = 6,
                ["BullkelpFarmMedium"] = 3,
                ["lilypadnovo"] = 2,
                ["lilypadnovograss"] = 1
            }
        }
    })

    ---------------------------SW oceano --------------------------------------

    AddRoom("OceanCoastalShore_SW", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_COASTAL_SHORE,
        contents = {
            distributepercent = 0.005,
            distributeprefabs = {
                wobster_den_spawner_shore = 1
            }
        }
    })

    AddRoom("OceanCoastal_SW", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_COASTAL,
        contents = {

            countprefabs = {
                seaweed_planted = 200,
                mussel_farm = 300,
                messagebottle1 = 20
            },

            distributepercent = 0.01,
            distributeprefabs = {}

        }
    })

    -- medium	seagull
    AddRoom("OceanSwell_SW", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_SWELL,
        contents = {

            countprefabs = {},
            distributepercent = 0.005,
            distributeprefabs = {},
            countstaticlayouts = {
                ["CrabKing"] = GetModConfigData("Moonshipwrecked")
            }

        }
    })

    -- deep   seagull
    AddRoom("OceanRough_SW", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_ROUGH,
        contents = {
            countprefabs = {
                rawling = 1,
                tar_pool = 8,
                messagebottle1 = 20
            },

            distributepercent = 0.01,
            distributeprefabs = {},

            countstaticlayouts = {
                ["HermitcrabIsland"] = GetModConfigData("Moonshipwrecked")
            }
        }
    })

    -- coral					
    AddRoom("OceanReef_SW", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_BRINEPOOL,
        contents = {
            countprefabs = {},
            countstaticlayouts = {},
            distributepercent = 0,
            distributeprefabs = {}

        }
    })

    -- ship gravery
    AddRoom("OceanHazardous_SW", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.OCEAN_HAZARDOUS,
        contents = {
            countprefabs = {},
            distributepercent = 0.15,
            distributeprefabs = {
                boatfragment03 = 1,
                boatfragment04 = 1,
                boatfragment05 = 1,
                seastack = 1
            }
        }
    })

    ------------------------------------------------frost_land-----------------------------------------------------

    local Bunches = require("map/bunches").Bunches
    Bunches.wobster_den_spawner_shore = {
        prefab = function(world, spawnerx, spawnerz)
            for _z = 1, -1, -1 do
                for _x = -1, 1 do
                    local x = spawnerx + (_x * 4)
                    local z = spawnerz + (_z * 4)
                    local tile = world:GetTile(x, z)

                    -- We reject INVALID and IMPASSABLE out of hand.
                    -- ROCKY can appear on the mainland or moon island, so we have to look for something else.
                    if tile ~= GROUND.INVALID and tile ~= GROUND.IMPASSABLE and tile ~= GROUND.ROCKY then
                        if tile == GROUND.WATER_MANGROVE or tile == GROUND.ANTFLOOR then
                            return "rock_ice_frost"
                        elseif tile == GROUND.PEBBLEBEACH or tile == GROUND.METEOR or tile == GROUND.SHELLBEACH then
                            return "moonglass_wobster_den"
                        elseif tile == GROUND.BEACH or tile == GROUND.MEADOW or tile == GROUND.ASH or tile ==
                            GROUND.JUNGLE or tile == GROUND.VOLCANO or tile == GROUND.TIDALMARSH then
                            return "lobsterhole"
                        elseif not GLOBAL.IsOceanTile(tile) then
                            return "wobster_den"
                        end
                    end
                end
            end

            return nil
        end,
        range = 12,
        min = 4,
        max = 5,
        min_spacing = 3,
        valid_tile_types = {GROUND.OCEAN_COASTAL}
    }
    -- end

    AddRoom("FrostIsland_Beach", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        contents = {
            countprefabs = {
                snowspiderden2 = 1,
                snowpile1 = 1,
                giantsnowspawner = 1,
                billsnowspawner = 1
            },
            distributepercent = 0.18,
            distributeprefabs = {
                dead_sea_bones = 0.35,
                driftwood_small1 = 0.2,
                driftwood_small2 = 0.2,
                driftwood_tall = 0.25,
                rock_ice = 0.05,
                pond = 0.1,
                rocks = 0.5,
                flint = 0.5,
                rock1 = 0.5,
                twigs = 0.25
            }
        }
    })

    AddRoom("FrostIsland_deciduoustree", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        contents = {
            countstaticlayouts = {},
            countprefabs = {
                billsnowspawner = 1,
                snow_castle = 1,
                cratesnow = 1,
                snowgoat = 3
            },
            distributepercent = 0.22,
            distributeprefabs = {
                snowdeciduoustree = 0.5,
                --			sapling_moon = 0.3,
                ground_twigs = 0.1,
                rabbithole = 0.1,
                rock_ice = 0.05,
                pond = 0.1,
                snow_dune = 0.1,
                arctic_flowers = 0.4
            }
        }
    })

    AddRoom("FrostIsland_Mine", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        contents = {
            countprefabs = {
                giantsnowspawner = 1,
                cratesnow = 1,
                snowpile1 = 1
            },
            distributepercent = 0.12,
            distributeprefabs = {
                rock2 = 0.2,
                rock_moon = 0.2,
                rock_ice = 0.2,
                moonrocknugget = 0.1,
                rocks = 0.1,
                flint = 0.1,
                pond = 0.2,
                snow_dune = 0.2
            }
        }
    })

    AddRoom("FrostIsland_Mineboss", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        contents = {
            countprefabs = {
                snowwarg = 1,
                cratesnow = 1,
                snowpile1 = 1
                --			houndmound = 2,
            },
            distributepercent = 0.12,
            distributeprefabs = {
                rock1 = 0.4,
                rock2 = 0.8,
                rock_moon = 0.2,
                rock_ice = 0.2,
                moonrocknugget = 0.1,
                rocks = 0.1,
                flint = 0.1,
                pond = 0.2,
                snow_dune = 0.2,
                skeleton = 0.2
            }
        }
    })

    AddRoom("FrostIsland_Mammoth", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        random_node_entrance_weight = 0,
        contents = {
            countprefabs = {
                snow_castle = 1,
                cratesnow = 1,
                mammoth = 5
            },
            distributepercent = 0.3,
            distributeprefabs = {
                marsh_bush = 0.5,
                sapling = 0.5,
                rock_ice = 0.3,
                pond = 0.2,
                snow_dune = 0.2,
                perma_grass = 0.8,
                rabbithole = 0.4,
                arctic_flowers = 0.2
            }
        }
    })

    AddRoom("FrostIsland_Meadows", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        random_node_exit_weight = 0,
        contents = {
            countprefabs = {
                snow_castle = 1,
                snowpile1 = 1,
                bearden = 1,
                snowspiderden2 = 1
            },
            distributepercent = 0.25,
            distributeprefabs = {
                pond = 0.2,
                snow_dune = 0.2,
                rock_ice = 0.2,
                rock1 = 0.05,
                perma_grass = 0.7,
                rabbithole = 0.25,
                green_mushroom = .005,
                marsh_bush = 0.4,
                arctic_flowers = 0.2
            }
        }
    })

    AddRoom("FrostIsland_Meadowscave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        random_node_exit_weight = 0,
        contents = {
            countprefabs = {
                billsnowspawner = 1,
                snow_castle = 1,
                snowpile1 = 1,
                bearden = 1
            },
            distributepercent = 0.12,
            distributeprefabs = {
                pond = 0.2,
                snow_dune = 0.2,
                --			sapling_moon = 1,
                ground_twigs = 1,
                snowberrybush = 1,
                evergreen = 0.5,
                rock_ice = 0.5,
                twigs = 0.5,
                arctic_flowers = 0.2
            }
        }
    })

    AddRoom("strange_island_maxwell", {
        colour = {
            r = 0.5,
            g = .18,
            b = .35,
            a = .50
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        contents = {
            countstaticlayouts = {
                ["mactuskgrass"] = 1
            },
            distributepercent = .1,
            distributeprefabs = {
                evergreen = 0.75,
                marsh_bush = 1.5,
                snowpile1 = 1,
                arctic_flowers = 0.2
            }
        }
    })

    AddRoom("strange_island_maxwell_set", {
        colour = {
            r = 0.5,
            g = .18,
            b = .35,
            a = .50
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        contents = {
            countstaticlayouts = {
                ["strangerlord"] = 1,
                --					["CaveEntrance"]=1,		
                ["mactuskgrass"] = 1
            },
            distributepercent = .1,
            distributeprefabs = {
                marsh_tree = 0.5,
                evergreen = 1,
                arctic_flowers = 0.2
                --					                    marsh_bush= 1.5,	
            },

            countprefabs = {
                maxwellstatuebracod = 1,
                gravestone = 2,
                cave_entrance_frost = 1,
                cratesnow = 1
            }
        }
    })

    AddRoom("strange_island_canada", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        --					type = GLOBAL.NODE_TYPE.SeparatedRoom,		
        contents = {
            --					countstaticlayouts={["strangerlavaarena"]=1},	
            countstaticlayouts = {
                ["LivingTree"] = 1
            },
            distributepercent = .8,
            distributeprefabs = {
                fireflies = 0.1,
                grass = .05,
                sapling = .5,
                twiggytree = 0.5,
                ground_twigs = 0.3,
                snowberrybush = .021,
                blue_mushroom = 0.02,
                arctic_flowers = 0.2,
                trees = {
                    weight = 6,
                    prefabs = {"evergreen", "evergreen_sparse"}
                }
            },

            countprefabs = {
                wildbeaver_house = 3,
                --									boarmound = 2,
                maxwellstatuecorpo = 1,
                gravestone = 2,
                snowpile1 = 1
            }
        }
    })

    AddRoom("strange_island_canada2", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        --					type = GLOBAL.NODE_TYPE.SeparatedRoom,	
        contents = {
            distributepercent = .38, -- .5
            distributeprefabs = {
                fireflies = 0.2,
                rock1 = 0.05,
                grass = .05,
                sapling = .8,
                twiggytree = 0.8,
                roc_nest_debris1 = 0.05,
                roc_nest_debris2 = 0.05,
                roc_nest_debris3 = 0.05,
                roc_nest_debris4 = 0.05,
                -- rabbithole=.05,
                snowberrybush = .045,
                red_mushroom = .03,
                green_mushroom = .02,
                arctic_flowers = 0.2,
                trees = {
                    weight = 6,
                    prefabs = {"evergreen", "evergreen_sparse"}
                }
            },
            countprefabs = {
                cratesnow = 1,
                wildbeaver_house = 3
            }
        }
    })

    AddRoom("strange_island_canada3", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            distributepercent = 0.17,
            distributeprefabs = {
                fireflies = 0.1,
                evergreen_sparse = 6,
                spiderden = 0.01,
                grass = .05,
                sapling = .5,
                twiggytree = 0.16,
                roc_nest_debris1 = 0.05,
                roc_nest_debris2 = 0.05,
                roc_nest_debris3 = 0.05,
                roc_nest_debris4 = 0.05,
                snowberrybush = .021,
                blue_mushroom = 0.02,
                pond = 0.2,
                snow_dune = 0.2,
                rock_ice = 0.3,
                arctic_flowers = 0.2
            },
            countprefabs = {
                wildbeaver_house = 1
            }
        }
    })

    AddRoom("frost_island_palace", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        contents = {
            --					countstaticlayouts={["strangerpigs"]=1},					
            distributepercent = .2,
            distributeprefabs = {
                --					                    cottontree = 0.5, --nitre
                --					                    quagmire_pond_salt = .1,
                evergreen_sparse = 0.5,
                pond = .1,
                arctic_flowers = 0.112,
                carrot_planted = 0.05,
                flint = 0.05,
                --										quagmire_spotspice_shrub= 0.3,
                sapling = 0.2,
                blue_mushroom = .01,
                green_mushroom = .006,
                red_mushroom = .008
            },

            countprefabs = {
                --					                	quagmire_beefalo = 3,
                --										beefalo = 1,
                --										quagmire_swampig_house_rubble = 3,
                maxwellstatuecabeca = 1,
                cratesnow = 1,
                snowpile1 = 1
            }

        }
    })

    AddRoom("frost_island_palace_set", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                evergreen_sparse = 0.5,
                pond = .1,
                arctic_flowers = 0.112,
                carrot_planted = 0.05,
                flint = 0.05,
                --										quagmire_spotspice_shrub= 0.3,
                sapling = 0.5,
                blue_mushroom = .01,
                green_mushroom = .006,
                red_mushroom = .008
            },

            countprefabs = {
                --					                	quagmire_beefalo = 3,
                --										beefalo = 1,
                --										quagmire_swampig_house_rubble = 3,
                maxwellstatuebracoe = 1
            }

        }
    })

    AddRoom("frost_island_palace_city", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"RoadPoison", "frost"},
        contents = {
            countstaticlayouts = {
                ["city"] = 1
            },
            distributepercent = .5,
            distributeprefabs = {
                evergreen_sparse = 0.5,
                arctic_flowers = 0.112,
                carrot_planted = 0.05,
                flint = 0.05,
                --										quagmire_spotspice_shrub= 0.3,
                sapling = 0.2,
                blue_mushroom = .01,
                green_mushroom = .006,
                red_mushroom = .008
            },

            countprefabs = {
                snowman = 3,
                snowberrybush = 3
            }

        }
    })

    AddRoom("FrostIsland_icelake_beager", {
        colour = {
            r = 0.5,
            g = .18,
            b = .35,
            a = .50
        },
        value = GROUND.ANTFLOOR,
        tags = {"RoadPoison", "frost", "sandstorm"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                rock_ice = 0.5,
                pond = 0.05,
                icerockspider = 0.5,
                icerockpigman = 0.1,
                icerockcrow = 0.5,
                cristaled_tree_short = 0.5,
                cristaled_tree_tall = 0.5,
                icerockcarrat = 0.3
            },
            countprefabs = {
                icerockbearger = 1,
                ice_deer = 3
            }
        }
    })

    AddRoom("FrostIsland_deeclop", {
        colour = {
            r = 0.5,
            g = .18,
            b = .35,
            a = .50
        },
        value = GROUND.ANTFLOOR,
        tags = {"RoadPoison", "frost", "sandstorm"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                rock_ice = 0.5,
                pond = 0.05,
                icerockspider = 0.5,
                icerockpigman = 0.1,
                icerockcrow = 0.5,
                cristaled_tree_short = 0.5,
                cristaled_tree_tall = 0.5,
                icerockcarrat = 0.3
            },
            countprefabs = {
                icerockdeerclops = 1,
                ice_deer = 4
            }
        }
    })

    AddRoom("FrostIsland_icelake_cave", {
        colour = {
            r = 0.5,
            g = .18,
            b = .35,
            a = .50
        },
        value = GROUND.ANTFLOOR,
        tags = {"RoadPoison", "frost", "sandstorm"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                rock_ice = 0.3,
                pond = 0.05,
                icerockspider = 0.5,
                icerockpigman = 0.1,
                icerockcrow = 0.5,
                cristaled_tree_short = 0.5,
                cristaled_tree_tall = 0.5,
                icerockcarrat = 0.3
            },
            countprefabs = {
                icerockleif = 1,
                icerockleif2 = 1
            }

        }
    })

    AddRoom("FrostIsland_icelake", {
        colour = {
            r = 0.5,
            g = .18,
            b = .35,
            a = .50
        },
        value = GROUND.ANTFLOOR,
        tags = {"RoadPoison", "frost", "sandstorm"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                rock_ice = 0.3,
                pond = 0.05,
                icerockspider = 0.5,
                icerockpigman = 0.1,
                icerockcrow = 0.5,
                cristaled_tree_short = 0.5,
                cristaled_tree_tall = 0.5,
                icerockcarrat = 0.3
            }
        }
    })

    AddRoom("rock_ice_frost_lake", {
        colour = {
            r = .6,
            g = .2,
            b = .8,
            a = .50
        },
        value = GROUND.OCEAN_ROUGH,
        tags = {"RoadPoison", "ForceConnected"}, -- "ForceDisconnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            distributepercent = 0.5,
            distributeprefabs = {
                rock_ice_frost_spawner = 1
            }
        }
    })

    ----------------------------------------------frost island tasks-------------------------------------------------------	
    -----------------------------------------------------
    AddTask("FrostIsland_icelake", {
        locks = {},
        keys_given = {KEYS.ISLAND_TIER2},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        room_choices = {
            ["FrostIsland_icelake"] = 2,
            ["FrostIsland_deeclop"] = 1,
            ["FrostIsland_icelake_cave"] = 1,
            ["FrostIsland_icelake_beager"] = 1,
            ["rock_ice_frost_lake"] = 1
        },
        room_bg = GROUND.ANTFLOOR,
        background_room = "FrostIsland_icelake",
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("FrostIsland_Wildbeaver", {
        locks = {},
        keys_given = {KEYS.ISLAND_TIER2},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        room_choices = {
            ["strange_island_canada2"] = 2,
            ["strange_island_canada"] = 2,
            ["strange_island_canada3"] = 1,
            ["Empty_Cove"] = 2,
            ["rock_ice_frost_lake"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "Empty_Cove",
        cove_room_name = "Blank",
        make_loop = true,
        crosslink_factor = 2,
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("FrostIsland_Beach", {
        locks = {LOCKS.ISLAND_TIER2},
        keys_given = {KEYS.ISLAND_TIER3},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        --    entrance_room = "FrostIsland_Blank",
        room_choices = {
            ["FrostIsland_Beach"] = 2,
            ["rock_ice_frost_lake"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        make_loop = true,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("FrostIsland_palace", {
        locks = {LOCKS.ISLAND_TIER2},
        keys_given = {KEYS.ISLAND_TIER3},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        entrance_room = "FrostIsland_Beach",
        room_choices = {
            ["frost_island_palace_set"] = 1,
            ["frost_island_palace_city"] = 1,
            ["frost_island_palace"] = 1,
            ["rock_ice_frost_lake"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        make_loop = true,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("FrostIsland_deciduoustree", {
        locks = {LOCKS.ISLAND_TIER4},
        keys_given = {},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        room_choices = {
            ["FrostIsland_deciduoustree"] = 3,
            ["rock_ice_frost_lake"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        crosslink_factor = 1,
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("FrostIsland_maxwell", {
        locks = {LOCKS.ISLAND_TIER4},
        keys_given = {},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        room_choices = {
            ["strange_island_maxwell"] = 1,
            ["strange_island_maxwell_set"] = 1,
            ["rock_ice_frost_lake"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        crosslink_factor = 1,
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("FrostIsland_Mine", {
        locks = {LOCKS.ISLAND_TIER4},
        keys_given = {},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        room_choices = {
            ["FrostIsland_Mine"] = 2,
            ["FrostIsland_Mineboss"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = .05,
            g = .5,
            b = .05,
            a = 1
        }
    })

    AddTask("FrostIsland_Mammoth", {
        locks = {LOCKS.ISLAND_TIER3},
        keys_given = {KEYS.ISLAND_TIER4},
        region_id = "frostisland",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "not_mainland", "frost"},
        room_choices = {
            ["FrostIsland_Mammoth"] = 2,
            ["FrostIsland_Meadows"] = 2,
            ["rock_ice_frost_lake"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "FrostIsland_Meadows",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })
    ------------------------------------------------------------------panda roons------------------------------------------------
    AddTask("pandatask", {
        locks = {},
        keys_given = {},
        region_id = "eldorado1",
        room_choices = {
            ["pandajungle1"] = 1,
            ["pandajungle2"] = 1,
            ["pandajungle3"] = 1,
            ["pandajungle4"] = 1,
            ["pandajungle5"] = 1,
            ["pandajungle6"] = 1
        },
        --	entrance_room = "seatarolake",
        room_bg = GROUND.MEADOW,
        background_room = "BGpandajungle",
        colour = {1, .5, .5, .2}
    })

    AddTask("pandataskjunto", {
        locks = {LOCKS.CAVE},
        keys_given = {KEYS.CAVE},
        region_id = "junto",
        room_choices = {
            ["pandajungle1"] = 1,
            ["pandajungle2"] = 1,
            ["pandajungle3"] = 1,
            ["pandajungle4"] = 1,
            ["pandajungle5"] = 1,
            ["pandajungle6"] = 1
        },
        --	entrance_room = "seatarolake",
        room_bg = GROUND.MEADOW,
        background_room = "BGpandajungle",
        colour = {1, .5, .5, .2}
    })

    AddRoom("pandajungle", {
        colour = {
            r = .6,
            g = .2,
            b = .8,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"}, -- "ForceDisconnected"
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                sapling = 0.2,
                tree_forest_deep = 0.5,
                bambootree = 1,
                bambootreebig = 1,
                bush_vine = 0.05,
                cave_banana_tree = 0.05,
                snake_hole = 0.05,
                pandatree = 0.01
            },

            countprefabs = {
                pandatree = function()
                    return 10 + math.random(1, 2)
                end,
                pandahouse = function()
                    return 2 + math.random(0, 1)
                end,
                red_mushroom = function()
                    return math.random(1, 2)
                end

            }
        }
    })
    AddRoom("pandajungle1", {
        colour = {
            r = .6,
            g = .2,
            b = .8,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"}, -- "ForceDisconnected"
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                sapling = 0.2,
                tree_forest_deep = 0.5,
                bambootree = 1,
                bambootreebig = 1,
                bush_vine = 0.05,
                cave_banana_tree = 0.05,
                snake_hole = 0.05
            },

            countprefabs = {
                pandatree = function()
                    return 4 + math.random(1, 2)
                end,
                pandahouse = function()
                    return 2 + math.random(0, 1)
                end,
                red_mushroom = function()
                    return math.random(1, 2)
                end

            }
        }
    })
    AddRoom("pandajungle2", {
        colour = {
            r = .6,
            g = .2,
            b = .8,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"}, -- "ForceDisconnected"
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                sapling = 0.2,
                -- tree_forest_deep = 0.5,
                bambootree = 1,
                bambootreebig = 1,
                cave_banana_tree = 0.5,
                snake_hole = 0.015
            },

            countprefabs = {
                pandatree = function()
                    return 4 + math.random(1, 2)
                end,
                red_mushroom = function()
                    return math.random(0, 1)
                end,
                pandahouse = function()
                    return 2 + math.random(0, 1)
                end

            }
        }
    })
    AddRoom("pandajungle3", {
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"}, -- "ForceDisconnected"
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                houndbone = 0.25,
                bambootree = 1,
                bambootreebig = 1,
                -- pandatree = 0.006,
                flower = 0.2
            },
            countprefabs = {
                pandatree = function()
                    return 4 + math.random(0, 1)
                end,
                pandahouse = function()
                    return 1 + math.random(0, 1)
                end,
                red_mushroom = function()
                    return math.random(0, 1)
                end
            }
        }
    })
    AddRoom("pandajungle4", {
        colour = {
            r = .6,
            g = .2,
            b = .8,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"}, -- "ForceDisconnected"
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                sapling = 0.2,
                tree_forest_deep = 0.5,
                bambootree = 1,
                bambootreebig = 1,
                bush_vine = 0.02,
                cave_banana_tree = 0.05,
                snake_hole = 0.2
            },

            countprefabs = {
                pandatree = function()
                    return 4 + math.random(1, 2)
                end,
                pandahouse = function()
                    return 1 + math.random(0, 1)
                end,
                red_mushroom = function()
                    return math.random(0, 1)
                end
            }
        }
    })

    AddRoom("pandajungle5", {
        colour = {
            r = .8,
            g = 0.5,
            b = .6,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countprefabs = {
                pandatree = function()
                    return 4 + math.random(0, 1)
                end,
                pandahouse = function()
                    return 1 + math.random(0, 1)
                end
            },

            distributepercent = .4,
            distributeprefabs = {
                sapling = 0.2,
                tree_forest_deep = 0.4,
                bambootree = 1,
                bambootreebig = 1,
                bush_vine = 0.001
            }
        }
    })
    AddRoom("pandajungle6", {
        colour = {
            r = .8,
            g = 0.5,
            b = .6,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countprefabs = {
                pandatree = function()
                    return 4 + math.random(0, 1)
                end,
                pandahouse = function()
                    return 1 + math.random(0, 1)
                end
            },

            distributepercent = .4,
            distributeprefabs = {
                sapling = 0.2,
                tree_forest_deep = 0.4,
                bambootree = 1,
                bambootreebig = 1,
                bush_vine = 0.001
            }
        }
    })

    AddRoom("BGpandajungle", {
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "tropical"}, -- "ForceDisconnected"
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                sapling = 0.2,
                tree_forest_deep = 0.5,
                bambootree = 1,
                bambootreebig = 1,
                bush_vine = 0.035,
                cave_banana_tree = 0.05,
                pandatree = 0.005
            },
            countprefabs = {

                pandatree = function()
                    return 1 + math.random(0, 1)
                end,
                pandahouse = function()
                    return 1 + math.random(0, 1)
                end,
                red_mushroom = function()
                    return math.random(0, 1)
                end

            }
        }
    })

    AddRoom("seatarolake", {
        colour = {
            r = .6,
            g = .2,
            b = .8,
            a = .50
        },
        value = GROUND.OCEAN_ROUGH,
        tags = {"RoadPoison", "ForceConnected"}, -- "ForceDisconnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            distributepercent = 0.5,
            distributeprefabs = {
                seatarospawner = 1
            }
        }
    })

    -----------------------------------------pantano------------------------------------------------------------------
    AddTask("pantano", {
        locks = {},
        keys_given = {},
        level_set_range = 0.5,
        region_id = "eldorado2",
        room_choices = {
            ["poolox1"] = 1,
            ["Marshpool"] = 1,
            ["poolox"] = 1,
            ["swambpool2"] = 1,
            ["poolox2"] = 1,
            ["poolox3"] = 1,
            ["MermySwamp1"] = 1
        },
        entrance_room = "swambpool1",
        room_bg = GROUND.MARSH,
        GROUND.OCEAN_COASTAL_SHORE,
        background_room = "Marshpool",
        colour = {
            r = .05,
            g = .05,
            b = .05,
            a = 1
        }
    })

    AddTask("pantanojunto", {
        locks = {},
        keys_given = {},
        level_set_range = 0.5,
        region_id = "junto",
        room_choices = {
            ["poolox1"] = 1,
            ["Marshpool"] = 1,
            ["poolox"] = 1,
            ["swambpool2"] = 1,
            ["poolox2"] = 1,
            ["poolox3"] = 1,
            ["MermySwamp1"] = 1
        },
        entrance_room = "swambpool1",
        room_bg = GROUND.MARSH,
        GROUND.OCEAN_COASTAL_SHORE,
        background_room = "Marshpool",
        colour = {
            r = .05,
            g = .05,
            b = .05,
            a = 1
        }
    })

    AddRoom("Marshpool", {
        colour = {
            r = 0.5,
            g = .16,
            b = .35,
            a = .50
        },
        value = GROUND.MARSH,
        tags = {"RoadPoison"}, ----"ForceConnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            countstaticlayouts = {
                ["MushroomRingMedium"] = function()
                    if math.random(0, 10) > 5 then
                        return 1
                    end
                    return 0
                end
            },
            distributepercent = .7,
            distributeprefabs = {
                tentacle = 0.40,
                flupspawner = 0.30,
                pighead = 0.01,
                reeds = 0.20,
                blue_mushroom = 0.20,
                green_mushroom = 0.15,
                mangrovespawner = 0.2,
                Grasswaterspawner = 0.4,
                poisonmist = 0.3
            },
            countprefabs = {
                sedimentpuddle = 1,
                mermhouse = 1,
                mermfishhouse = 1,
                poisonhole = 1.5,
                fishinholewaterspawner = 1.5
            }
        }
    })
    -- OX,en Biome
    -- merm city
    AddRoom("MermySwamp1", {
        value = GROUND.MARSH,
        tags = {"RoadPoison"}, ----"ForceConnected"
        contents = {
            distributepercent = .8,
            distributeprefabs = {
                pighead = 0.01,
                bush_vine = 0.2,
                snakeden = 0.2,
                flower_evil = 0.4,
                mangrovespawner = 0.5,
                Grasswaterspawner = 0.4,
                blue_mushroom = 0.01,
                green_mushroom = 2.02,
                poisonmist = 0.3,
                poisonhole = 0.1,
                reeds = 0.1
            },
            countprefabs = {
                mermhouse = 3,
                mermfishhouse = 2,
                sedimentpuddle = 1,
                mangrovespawner = 10,
                Grasswaterspawner = 15,
                farm_plow = 3
            }
        }
    })
    AddRoom("swambpool1", {
        colour = {
            r = 0.5,
            g = .16,
            b = .35,
            a = .50
        },
        value = GROUND.MARSH,
        tags = {"RoadPoison"}, ----"ForceConnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            distributepercent = 0.8,
            distributeprefabs = {
                mangrovespawner = 0.5,
                Grasswaterspawner = 0.7,
                bush_vine = 0.3,
                snakeden = 0.2,
                reeds = 0.1,
                poisonmist = 0.2,
                tentacle = 0.40,
                flupspawner = 0.30
            },
            countprefabs = {
                sedimentpuddle = 1,
                poisonhole = 1,
                farm_plow = 2
            }
        }
    })
    AddRoom("swambpool2", {
        colour = {
            r = 0.5,
            g = .16,
            b = .35,
            a = .50
        },
        value = GROUND.MARSH,
        tags = {"RoadPoison"}, ----"ForceConnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            distributepercent = 0.8,
            distributeprefabs = {
                mangrovespawner = 0.5,
                Grasswaterspawner = 0.7,
                bush_vine = 0.3,
                snakeden = 0.2,
                reeds = 0.35,
                tentacle = 0.40,
                flupspawner = 0.30,
                poisonmist = 0.2
            },
            countprefabs = {
                sedimentpuddle = 2,
                poisonhole = 3
            }
        }
    })

    AddRoom("poolox", {
        colour = {
            r = 0.5,
            g = .16,
            b = .35,
            a = .50
        },
        value = GROUND.OCEAN_COASTAL_SHORE,
        level_set_piece_blocker = true,
        tags = {"RoadPoison"}, ----"ForceConnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            countstaticlayouts = {
                ["pantano"] = 1
            },
            distributepercent = 1,
            distributeprefabs = {}
        }
    })
    AddRoom("poolox1", {
        colour = {
            r = 0.5,
            g = .16,
            b = .35,
            a = .50
        },
        value = GROUND.OCEAN_COASTAL_SHORE,
        level_set_piece_blocker = true,
        tags = {"RoadPoison"}, ----"ForceConnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            countstaticlayouts = {
                ["pantano"] = 1
            },
            distributepercent = 1,
            distributeprefabs = {}
        }
    })
    AddRoom("poolox2", {
        colour = {
            r = 0.5,
            g = .16,
            b = .35,
            a = .50
        },
        value = GROUND.OCEAN_COASTAL_SHORE,
        level_set_piece_blocker = true,
        tags = {"RoadPoison"}, ----"ForceConnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            countstaticlayouts = {
                ["pantano"] = 1
            },
            distributepercent = 1,
            distributeprefabs = {}
        }
    })
    AddRoom("poolox3", {
        colour = {
            r = 0.5,
            g = .16,
            b = .35,
            a = .50
        },
        value = GROUND.OCEAN_COASTAL_SHORE,
        level_set_piece_blocker = true,
        tags = {"RoadPoison"}, ----"ForceConnected"
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        contents = {
            countstaticlayouts = {
                ["pantano"] = 1
            },
            distributepercent = 1,
            distributeprefabs = {}
        }
    })
    ----------------------------------------------------------------strange island rooms--------------------------------------
    AddTask("gorgeisland", {
        locks = {},
        keys_given = {},
        region_id = "gorgeisland",
        room_choices = {
            ["quagmire"] = 1,
            ["quagmire1"] = 1,
            ["quagmire2"] = 2,
            ["quagmire3"] = 1,
            ["quagmire4"] = 2,
            ["quagmire5"] = 1,
            ["quagmire6"] = 1
        },
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        background_room = "quagmire5",
        "quagmire",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("gorgeislandjunto", {
        locks = {},
        keys_given = {},
        region_id = "junto",
        room_choices = {
            ["quagmire"] = 1,
            ["quagmire1"] = 1,
            ["quagmire2"] = 2,
            ["quagmire3"] = 1,
            ["quagmire4"] = 2,
            ["quagmire5"] = 1,
            ["quagmire6"] = 1
        },
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        background_room = "quagmire5",
        "quagmire",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddRoom("gorge_main", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.IMPASSABLE,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["quagmire_kitchen"] = 1 -- adds 1 per room											
            },
            distributepercent = .25,
            distributeprefabs = {
                rocks = .1
            }

        }
    })

    AddRoom("quagmire", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_GATEWAY,

        contents = {
            distributepercent = .2,
            distributeprefabs = {
                cottontree = 0.5, -- nitre
                --					                    quagmire_pond_salt = .1,
                flower = 0.112,
                carrot_planted = 0.05,
                flint = 0.05,
                quagmire_spotspice_shrub = 0.3,
                sapling = 0.2,
                blue_mushroom = .005,
                green_mushroom = .003,
                red_mushroom = .004,
                rabbithole = 0.01
            },

            countprefabs = {
                --					                	quagmire_swampig_house_rubble = 3,
            }
        }
    })

    AddRoom("quagmire1", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_GATEWAY,

        contents = {
            --									countstaticlayouts=
            --									{
            --										[esculturas[math.random(1, 4)]] = 1,	
            --									},								
            distributepercent = .2,
            distributeprefabs = {
                cottontree = 0.5, -- nitre
                --					                    quagmire_pond_salt = .1,
                quagmire_spotspice_shrub = 0.1
            },

            countprefabs = {
                quagmire_swampig_house = 3,
                quagmiregoat = 4
            }
        }
    })

    AddRoom("quagmire2", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_CITYSTONE,

        contents = {
            distributepercent = .2,
            distributeprefabs = {
                -- cottontree = 0.5, --nitre
                quagmire_pond_salt = .15,
                quagmire_spotspice_shrub = 0.1,
                rock1 = 0.3,
                rock2 = 0.3,
                rock_moon = 0.1,
                rock_flintless = 0.2,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.1
            },

            countprefabs = {
                --					                	quagmire_swampig_house_rubble = 2,
                pebblecrabspawner = 2
            }
        }
    })

    AddRoom("quagmire3", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_PEATFOREST,
        contents = {
            distributepercent = .6,
            distributeprefabs = {
                gravestone = 0.01,
                blue_mushroom = 0.0025,
                sapling = 0.15,
                rock1 = 0.008,
                rock2 = 0.008,
                evergreen_sparse = 1.5,
                flower = 0.05,
                green_mushroom = .025,
                red_mushroom = .025
            },
            countprefabs = {
                --										quagmire_goatkid = 1,
                quagmire_swampig_house = 4
            }
        }
    })

    AddRoom("quagmire4", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.SAVANNA,

        contents = {
            distributepercent = .2,
            distributeprefabs = {
                rock_flippable = 0.10,
                grass = 0.4,
                twiggytree = 0.2,
                carrot_planted = 0.05,
                radish_planted = 0.05
            },

            countprefabs = {
                quagmire_beefalo = 3,
                beefalo = 1,
                galinheiro = 2,
                grass_patch = 2
            }
        }
    })

    AddRoom("quagmire5", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        contents = {
            distributepercent = .6,
            distributeprefabs = {
                cottontree = 0.5, -- nitre
                flower = 0.112,
                carrot_planted = 0.05,
                flint = 0.05,
                quagmire_spotspice_shrub = 0.3,
                blue_mushroom = .005,
                green_mushroom = .003,
                red_mushroom = .004,
                rabbithole = 0.01,
                gravestone = 0.01,
                sapling = 0.15,
                rock1 = 0.008,
                rock2 = 0.008
            },
            countprefabs = {
                quagmire_swampig_house_rubble = 4
            }
        }
    })

    AddRoom("quagmire6", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        contents = {
            distributepercent = .6,
            distributeprefabs = {
                cottontree = 0.5, -- nitre
                flower = 0.112,
                carrot_planted = 0.05,
                flint = 0.05,
                quagmire_spotspice_shrub = 0.3,
                sapling = 0.2,
                blue_mushroom = .005,
                green_mushroom = .003,
                red_mushroom = .004,
                rabbithole = 0.01
            },
            countprefabs = {
                quagmire_swampig_house_rubble = 4
            }
        }
    })

    ----------------------------------------------------------------------
    AddRoom("city_base_1_set", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.FOUNDATION,
        tags = {"RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["cidade1"] = 1
            },
            distributepercent = 0.8,
            distributeprefabs = {
                rocks = 0.2,
                grass = 0.2,
                spoiled_food = 0.2,
                twigs = 0.2
            }
        }
    })

    AddRoom("city_base_2_set", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["cidade2"] = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                rocks = 0.2,
                grass = 0.2,
                spoiled_food = 0.2,
                twigs = 0.2
            }
        }
    })

    AddRoom("city_base", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"RoadPoison", "hamlet"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                rocks = 0.2,
                grass = 0.2,
                spoiled_food = 0.2,
                twigs = 0.2
            }
        }
    })

    AddRoom("BG_suburb_base", {
        colour = {
            r = .3,
            g = 0.3,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"RoadPoison", "hamlet"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })

    ----------------------------------main-------------
    AddRoom("MAINcity_base_1_set", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["cidade1"] = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                rocks = 0.2,
                grass = 0.2,
                spoiled_food = 0.2,
                twigs = 0.2
            }
        }
    })

    AddRoom("MAINcity_base_2_set", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["cidade2"] = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                rocks = 0.2,
                grass = 0.2,
                spoiled_food = 0.2,
                twigs = 0.2
            }
        }
    })

    AddRoom("MAINcity_base", {
        colour = {
            r = .1,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                rocks = 0.2,
                grass = 0.2,
                spoiled_food = 0.2,
                twigs = 0.2
            }
        }
    })

    AddRoom("MAINBG_suburb_base", {
        colour = {
            r = .3,
            g = 0.3,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.SUBURB,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                rocks = 1,
                grass = 1,
                spoiled_food = 1,
                twigs = 1
            }
        }
    })
    -------------------------------pinacle----------------------------------
    AddRoom("BG_pinacle_base_set", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.ROCKY,
        tags = {"hamlet"},
        contents = {
            countstaticlayouts = {
                ["roc_nest"] = 1,
                ["roc_cave"] = 1
            },
            distributepercent = .15, -- .26
            distributeprefabs = {
                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                tallbirdnest = 0.2
            },
            countprefabs = {
                flint = 2,
                twigs = 2,
                pig_scepter = 1,
                tumbleweedspawner = 2
            }
        }
    })

    AddRoom("BG_pinacle_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.ROCKY,
        tags = {"hamlet"},
        contents = {
            distributepercent = .15, -- .26
            distributeprefabs = {
                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                tallbirdnest = 0.2

            },
            countprefabs = {
                flint = 2,
                twigs = 2
            }
        }
    })

    -------------------------------------------------------Hamlet tasks-------------------------------	
    AddTask("Edge_of_the_unknown", {
        locks = {},
        keys_given = {},
        region_id = "hamletpugalisk",
        room_choices = {
            ["BG_plains_base"] = 2,
            ["BG_plains_base_nocanopy1"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("plains", {
        locks = {},
        keys_given = {},
        region_id = "hamlet2",
        room_choices = {
            ["plains_tallgrass"] = math.random(2, 3),
            ["plains_pogs_ruin"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("plains_ruins", {
        locks = {},
        keys_given = {},
        region_id = "hamlet3",
        room_choices = {
            ["plains_ruins"] = 1,
            ["plains_ruins_set"] = 1,
            ["plains_pogs"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    ---------------------	
    AddTask("painted_sands", {
        locks = {},
        keys_given = {},
        region_id = "hamlet4",
        room_choices = {
            ["BG_battleground_base"] = 1,
            ["battleground_ribs"] = 1,
            ["battleground_claw"] = 1,
            ["battleground_leg"] = 1,
            ["battleground_claw1"] = 1,
            ["battleground_leg1"] = 1,
            ["battleground_head"] = 1,
            ["BG_painted_base"] = 4
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_painted_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    -----------------------------------------
    AddTask("Deep_rainforest", {
        locks = {},
        keys_given = {},
        region_id = "hamlet5",
        room_choices = {
            ["BG_rainforest_base"] = math.random(2, 3),
            ["BG_deeprainforest_base"] = 1,
            ["deeprainforest_spider_monkey_nest"] = 1,
            ["deeprainforest_fireflygrove"] = math.random(1, 1),
            ["deeprainforest_flytrap_grove"] = math.random(1, 2),
            ["deeprainforest_anthill_exit2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Deep_rainforest_2", {
        locks = {},
        keys_given = {},
        region_id = "hamlet6",
        room_choices = {
            ["BG_rainforest_base"] = 1,
            ["deeprainforest_spider_monkey_nest"] = 1,
            ["deeprainforest_fireflygrove"] = 1,
            ["deeprainforest_flytrap_grove"] = 1,
            ["deeprainforest_anthill_exit"] = 1,
            ["deeprainforest_ruins_entrance2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Deep_rainforest_mandrake", {
        locks = {},
        keys_given = {},
        region_id = "hamlet7",
        --	entrance_room = "ForceDisconnectedRoom",   --  THIS IS HOW THEY ARE ON SEPARATE ISLANDS
        room_choices = {
            ["deeprainforest_mandrakeman"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("rainforest_ruins", {
        locks = {},
        keys_given = {},
        region_id = "hamlet8",
        room_choices = {
            ["rainforest_ruins"] = 3,
            ["rainforest_ruins_entrance"] = 1
        },
        room_bg = GROUND.RAINFOREST,
        background_room = "BG_rainforest_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    -------------------------
    AddTask("Edge_of_civilization", {
        locks = {},
        keys_given = {},
        region_id = "hamlet9",
        room_choices = {
            ["cultivated_base_1"] = 1,
            ["cultivated_base_2"] = 1,
            --			["cultivated_base_3"] = 1,
            ["cultivated_base_4"] = 1,
            ["cultivated_base_5"] = 1,
            ["piko_land"] = 1
        },
        room_bg = GROUND.FIELDS,
        background_room = "BG_cultivated_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Pigcity", {
        locks = {},
        keys_given = {},
        region_id = "hamlet10",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1,
            ["city_base_1_set"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Deep_rainforest_4", {
        locks = {},
        keys_given = {},
        region_id = "hamlet10",
        --	entrance_room = "ForceDisconnectedRoom",   --  THIS IS HOW THEY ARE ON SEPARATE ISLANDS
        room_choices = {
            ["BG_deeprainforest_base"] = 2,
            ["deeprainforest_fireflygrove"] = 1,
            ["deeprainforest_flytrap_grove"] = 1,
            ["deeprainforest_ruins_exit"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Pigcity2", {
        locks = {},
        keys_given = {},
        region_id = "hamlet12",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1,
            ["city_base_2_set"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Deep_rainforest_3", {
        locks = {},
        keys_given = {},
        region_id = "hamlet12",
        --	entrance_room = "ForceDisconnectedRoom",   --  THIS IS HOW THEY ARE ON SEPARATE ISLANDS
        room_choices = {
            ["BG_deeprainforest_base"] = 2,
            ["deeprainforest_fireflygrove"] = 1,
            ["deeprainforest_flytrap_grove"] = 1,
            ["deeprainforest_ruins_exit"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Edge_of_the_unknown_2", {
        locks = {},
        keys_given = {},
        region_id = "hamlet13",
        room_choices = {
            ["BG_rainforest_base"] = math.random(2, 3),
            ["plains_tallgrass"] = math.random(1, 2),
            ["plains_pogs"] = math.random(0, 2),
            ["rainforest_ruins"] = math.random(2, 3),
            ["BG_painted_base"] = math.random(1, 2)
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Deep_lost_ruins_gas", {
        locks = {},
        keys_given = {},
        region_id = "hamlet14",
        room_choices = {
            ["deeprainforest_gas"] = math.random(3, 4),
            ["deeprainforest_gas_flytrap_grove"] = math.random(2),
            ["deeprainforest_gas_entrance6"] = 1
        },
        room_bg = GROUND.GASJUNGLE,
        background_room = "deeprainforest_gas",
        colour = {
            r = 0.8,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("pincale", {
        locks = {},
        keys_given = {},
        region_id = "hamlet15",
        room_choices = {
            ["BG_pinacle_base_set"] = 1,
            ["BG_pinacle_base"] = 2
        },
        room_bg = GROUND.ROCKY,
        background_room = "BG_pinacle_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("pincalejunto", {
        locks = {},
        keys_given = {},
        region_id = "junto",
        room_choices = {
            ["BG_pinacle_base_set"] = 1,
            ["BG_pinacle_base"] = 2
        },
        room_bg = GROUND.ROCKY,
        background_room = "BG_pinacle_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    ------------------------------------------------------------------------HAMLET continental tasks----------------------------------------------------------------------	
    AddTask("MEdge_of_the_unknown", {
        locks = {},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["BG_plains_base"] = 2,
            ["BG_plains_base_nocanopy1"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Mplains", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["plains_tallgrass"] = math.random(2, 3),
            ["plains_pogs_ruin"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Mplains_ruins", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["plains_ruins"] = 1,
            ["plains_ruins_set"] = 1,
            ["plains_pogs"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    ---------------------	
    AddTask("Mpainted_sands", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["BG_battleground_base"] = 1,
            ["battleground_ribs"] = 1,
            ["battleground_claw"] = 1,
            ["battleground_leg"] = 1,
            ["battleground_claw1"] = 1,
            ["battleground_leg1"] = 1,
            ["battleground_head"] = 1,
            ["BG_painted_base"] = 4
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_painted_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    -----------------------------------------

    AddTask("MDeep_rainforest", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["BG_rainforest_base"] = math.random(2, 3),
            ["BG_deeprainforest_base"] = 1,
            ["deeprainforest_spider_monkey_nest"] = 1,
            ["deeprainforest_fireflygrove"] = math.random(1, 1),
            ["deeprainforest_flytrap_grove"] = math.random(1, 2),
            ["deeprainforest_anthill_exit2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MDeep_rainforest_2", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["BG_deeprainforest_base"] = 1,
            ["deeprainforest_spider_monkey_nest"] = 1,
            ["deeprainforest_fireflygrove"] = 1,
            ["deeprainforest_flytrap_grove"] = 1,
            ["deeprainforest_anthill_exit"] = 1,
            ["deeprainforest_ruins_entrance2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MDeep_rainforest_mandrake", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["deeprainforest_mandrakeman"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    -------------------------
    AddTask("MEdge_of_civilization", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_2},
        region_id = "island3",
        room_choices = {
            ["cultivated_base_1"] = 1,
            ["cultivated_base_2"] = 1,
            --			["cultivated_base_3"] = 1,
            ["cultivated_base_4"] = 1,
            ["cultivated_base_5"] = 1,
            ["piko_land"] = 1
        },
        room_bg = GROUND.FIELDS,
        background_room = "BG_cultivated_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("MPigcity", {
        locks = {LOCKS.JUNGLE_DEPTH_1},
        keys_given = {KEYS.JUNGLE_DEPTH_3},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base_1_set"] = 1,
            ["city_base"] = 1
        },
        room_bg = GROUND.SUBURB,
        entrance_room = "city_base",
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcityside1", {
        locks = {LOCKS.JUNGLE_DEPTH_3},
        keys_given = {KEYS.NONE},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1
        },
        entrance_room = "city_base",
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcityside2", {
        locks = {LOCKS.JUNGLE_DEPTH_2},
        keys_given = {KEYS.JUNGLE_DEPTH_1},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1

        },
        entrance_room = "city_base",
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcityside3", {
        locks = {LOCKS.JUNGLE_DEPTH_3},
        keys_given = {KEYS.NONE},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1

        },
        entrance_room = "city_base",
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcityside4", {
        locks = {LOCKS.JUNGLE_DEPTH_3},
        keys_given = {KEYS.NONE},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1

        },
        entrance_room = "city_base",
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MDeep_rainforest_3", {
        locks = {},
        keys_given = {KEYS.CIVILIZATION_2},
        region_id = "island3",
        room_choices = {
            ["BG_deeprainforest_base"] = 2,
            ["deeprainforest_fireflygrove"] = 1,
            ["deeprainforest_flytrap_grove"] = 1,
            ["deeprainforest_ruins_exit"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "BG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcity2", {
        locks = {LOCKS.CIVILIZATION_1},
        keys_given = {KEYS.CIVILIZATION_3},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base_2_set"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcity2side1", {
        locks = {LOCKS.CIVILIZATION_3},
        keys_given = {KEYS.CIVILIZATION_2},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcity2side2", {
        locks = {LOCKS.CIVILIZATION_2},
        keys_given = {KEYS.CIVILIZATION_1},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcity2side3", {
        locks = {LOCKS.CIVILIZATION_3},
        keys_given = {KEYS.NONE},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MPigcity2side4", {
        locks = {LOCKS.CIVILIZATION_3},
        keys_given = {KEYS.NONE},
        region_id = "island3",
        room_tags = {"RoadPoison", "hamlet"},
        room_choices = {
            ["city_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "BG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Mrainforest_ruins", {
        locks = {LOCKS.CIVILIZATION_3},
        keys_given = {KEYS.NONE},
        region_id = "island3",
        room_choices = {
            ["rainforest_ruins"] = 3,
            ["rainforest_ruins_entrance"] = 1
        },
        room_bg = GROUND.RAINFOREST,
        background_room = "BG_rainforest_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("MEdge_of_the_unknown_2", {
        locks = LOCKS.CIVILIZATION_1,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        region_id = "island3",
        room_choices = {
            ["BG_rainforest_base"] = math.random(2, 3),
            ["plains_tallgrass"] = math.random(1, 2),
            ["plains_pogs"] = math.random(0, 2),
            ["rainforest_ruins"] = math.random(2, 3),
            ["BG_painted_base"] = math.random(1, 2)
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("MDeep_lost_ruins_gas", {
        locks = LOCKS.JUNGLE_DEPTH_3,
        keys_given = KEYS.JUNGLE_DEPTH_3,
        region_id = "island3",
        room_choices = {
            ["deeprainforest_gas"] = math.random(3, 4),
            ["deeprainforest_gas_flytrap_grove"] = math.random(2),
            ["deeprainforest_gas_entrance6"] = 1
        },
        room_bg = GROUND.GASJUNGLE,
        background_room = "deeprainforest_gas",
        colour = {
            r = 0.8,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })
    --------------------------------------------------------------------------------Hamlet Merged----------------------------------------------------------------------------
    AddTask("XEdge_of_the_unknown", {
        locks = LOCKS.NONE,
        keys_given = KEYS.JUNGLE_DEPTH_1,
        --		locks=LOCKS.NONE,
        --		keys_given={KEYS.PICKAXE,KEYS.AXE,KEYS.GRASS,KEYS.WOOD,KEYS.TIER1},
        room_choices = {
            ["MAINBG_plains_base"] = 2,
            ["MAINBG_plains_base_nocanopy1"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "MAINBG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Xplains", {
        locks = {LOCKS.ROCKS},
        keys_given = {KEYS.TRINKETS, KEYS.STONE, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["MAINplains_tallgrass"] = math.random(2, 3),
            ["MAINplains_pogs_ruin"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "MAINBG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Xplains_ruins", {
        locks = {LOCKS.ROCKS, LOCKS.BASIC_COMBAT, LOCKS.TIER1},
        keys_given = {KEYS.MEAT, KEYS.POOP, KEYS.WOOL, KEYS.GRASS, KEYS.TIER2},
        room_choices = {
            ["MAINplains_ruins"] = 1,
            ["MAINplains_ruins_set"] = 1,
            ["MAINplains_pogs"] = 1
        },
        room_bg = GROUND.PLAINS,
        background_room = "MAINBG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    ---------------------	
    AddTask("Xpainted_sands", {
        locks = {LOCKS.SPIDERDENS, LOCKS.TIER2},
        keys_given = {KEYS.MEAT, KEYS.SILK, KEYS.SPIDERS, KEYS.TIER3},
        room_choices = {
            ["MAINBG_battleground_base"] = 1,
            ["MAINbattleground_ribs"] = 1,
            ["MAINbattleground_claw"] = 1,
            ["MAINbattleground_leg"] = 1,
            ["MAINbattleground_claw1"] = 1,
            ["MAINbattleground_leg1"] = 1,
            ["MAINbattleground_head"] = 1,
            ["MAINBG_painted_base"] = 4
        },
        room_bg = GROUND.PLAINS,
        background_room = "MAINBG_painted_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })
    -----------------------------------------
    AddTask("XDeep_rainforest", {
        locks = {LOCKS.BEEHIVE, LOCKS.TIER1},
        keys_given = {KEYS.HONEY, KEYS.TIER2},
        room_choices = {
            ["MAINBG_rainforest_base"] = math.random(2, 3),
            ["MAINBG_deeprainforest_base"] = 1,
            ["MAINdeeprainforest_spider_monkey_nest"] = 1,
            ["MAINdeeprainforest_fireflygrove"] = math.random(1, 1),
            ["MAINdeeprainforest_flytrap_grove"] = math.random(1, 2),
            ["MAINdeeprainforest_anthill_exit2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "MAINBG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XDeep_rainforest_2", {
        locks = {LOCKS.PIGKING, LOCKS.TIER2},
        keys_given = {KEYS.PIGS, KEYS.GOLD, KEYS.TIER3},
        room_choices = {
            ["MAINBG_deeprainforest_base"] = 2,
            ["MAINdeeprainforest_spider_monkey_nest"] = 1,
            ["MAINdeeprainforest_fireflygrove"] = 1,
            ["MAINdeeprainforest_flytrap_grove"] = 1,
            ["MAINdeeprainforest_anthill_exit"] = 1,
            ["MAINdeeprainforest_ruins_entrance2"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "MAINBG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XDeep_rainforest_mandrake", {
        locks = {LOCKS.ADVANCED_COMBAT, LOCKS.MONSTERS_DEFEATED, LOCKS.TIER3},
        keys_given = {KEYS.WALRUS, KEYS.TIER4},
        room_choices = {
            ["MAINdeeprainforest_mandrakeman"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "MAINBG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XDeep_rainforest_3", {
        locks = {LOCKS.ADVANCED_COMBAT, LOCKS.MONSTERS_DEFEATED, LOCKS.TIER4},
        keys_given = {KEYS.HOUNDS, KEYS.TIER5, KEYS.ROCKS},
        room_choices = {
            ["MAINBG_deeprainforest_base"] = 2,
            ["MAINdeeprainforest_fireflygrove"] = 1,
            ["MAINdeeprainforest_flytrap_grove"] = 1,
            ["MAINdeeprainforest_ruins_exit"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "MAINBG_deeprainforest_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    -------------------------
    AddTask("XEdge_of_civilization", {
        locks = {LOCKS.BASIC_COMBAT, LOCKS.TIER2},
        keys_given = {KEYS.POOP, KEYS.WOOL, KEYS.WOOD, KEYS.GRASS, KEYS.TIER2},
        room_choices = {
            ["MAINcultivated_base_1"] = 1,
            ["MAINcultivated_base_2"] = 1,
            --			["MAINcultivated_base_3"] = 1,
            ["MAINcultivated_base_4"] = 1,
            ["MAINcultivated_base_5"] = 1,
            ["MAINpiko_land"] = 1
        },
        room_bg = GROUND.FIELDS,
        background_room = "MAINBG_cultivated_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("XPigcity", {
        locks = {LOCKS.TIER1},
        keys_given = {KEYS.TIER1},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base_1_set"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcityside1", {
        locks = {LOCKS.TIER1},
        keys_given = {KEYS.TIER1},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcityside2", {
        locks = {LOCKS.TIER1},
        keys_given = {KEYS.TIER1},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcityside3", {
        locks = {LOCKS.TIER1},
        keys_given = {KEYS.TIER1},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcityside4", {
        locks = {LOCKS.TIER1},
        keys_given = {KEYS.TIER1},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcity2", {
        locks = {LOCKS.TIER4},
        keys_given = {KEYS.TIER4},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base_2_set"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcity2side1", {
        locks = {LOCKS.TIER4},
        keys_given = {KEYS.TIER4},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1
        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcity2side2", {
        locks = {LOCKS.TIER4},
        keys_given = {KEYS.TIER4},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcity2side3", {
        locks = {LOCKS.TIER4},
        keys_given = {KEYS.TIER4},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("XPigcity2side4", {
        locks = {LOCKS.TIER4},
        keys_given = {KEYS.TIER4},
        room_tags = {"RoadPoison"},
        room_choices = {
            ["MAINcity_base"] = 1

        },
        room_bg = GROUND.SUBURB,
        background_room = "MAINBG_suburb_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("Xrainforest_ruins", {
        locks = {LOCKS.TIER1},
        keys_given = {KEYS.ROCKS, KEYS.GOLD, KEYS.TIER2},
        room_choices = {
            ["MAINrainforest_ruins"] = 3,
            ["MAINrainforest_ruins_entrance"] = 1
        },
        room_bg = GROUND.RAINFOREST,
        background_room = "MAINBG_rainforest_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("XEdge_of_the_unknown_2", {
        locks = {LOCKS.TIER1},
        keys_given = {KEYS.ROCKS, KEYS.GOLD, KEYS.TIER2},
        room_choices = {
            ["MAINBG_rainforest_base"] = math.random(2, 3),
            ["MAINplains_tallgrass"] = math.random(1, 2),
            ["MAINplains_pogs"] = math.random(0, 2),
            ["MAINrainforest_ruins"] = math.random(2, 3),
            ["MAINBG_painted_base"] = math.random(1, 2)
        },
        room_bg = GROUND.PLAINS,
        background_room = "BG_plains_base",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("XDeep_lost_ruins_gas", {
        locks = {LOCKS.TIER4},
        keys_given = {KEYS.TIER4},
        room_choices = {
            ["MAINdeeprainforest_gas"] = math.random(3, 4),
            ["MAINdeeprainforest_gas_flytrap_grove"] = math.random(2),
            ["MAINdeeprainforest_gas_entrance6"] = 1
        },
        room_bg = GROUND.GASJUNGLE,
        background_room = "MAINdeeprainforest_gas",
        colour = {
            r = 0.8,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })
    ------------------------------------------------------------------------------SW continental task---------------------------------------------------	
    if GetModConfigData("Shipwrecked") == 10 then
        AddTask("MISTO6", {
            locks = {},
            keys_given = {KEYS.CAVE},
            region_id = "island2",
            room_choices = {
                ["MagmaGold"] = 2,
                ["MagmaGoldBoon"] = 1
            },
            room_bg = GROUND.MAGMAFIELD,
            background_room = "Magma",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO7", {
            locks = {LOCKS.CAVE},
            keys_given = {KEYS.CAVE},
            region_id = "island2",
            room_choices = {
                ["PigVillagesw"] = 1,
                ["JungleDenseBerries"] = 1,
                ["BeachShark"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO8", {
            locks = {LOCKS.CAVE},
            keys_given = {KEYS.INNERTIER},
            region_id = "island2",
            room_choices = {
                ["MagmaTallBird"] = 1,
                ["MagmaGoldBoon"] = 1
            },
            room_bg = GROUND.MAGMAFIELD,
            background_room = "BeachDunes",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO9", {
            locks = {LOCKS.INNERTIER},
            keys_given = {KEYS.INNERTIER},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["JungleRockSkull"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = salasjungle[math.random(1, 24)],
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO11", {
            locks = {LOCKS.INNERTIER},
            keys_given = {KEYS.INNERTIER},
            region_id = "island2",
            room_choices = {
                ["MagmaForest"] = 1, -- MR went from 1-3
                ["JungleDense"] = 1,
                ["JunglePigs"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDense",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO14", {
            locks = {LOCKS.INNERTIER},
            keys_given = {KEYS.OUTERTIER},
            region_id = "island2",
            room_choices = {
                [salasvolcano[math.random(1, 5)]] = 1,
                ["VolcanoAsh"] = 1,
                ["Volcano"] = 1,
                ["VolcanoObsidian"] = 1
            },
            room_bg = GROUND.VOLCANO,
            background_room = "VolcanoNoise",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO15", {
            locks = {LOCKS.OUTERTIER},
            keys_given = {KEYS.OUTERTIER},
            region_id = "island2",
            room_choices = {
                ["TidalMermMarsh"] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                ["BeachSappy"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "BeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO16", {
            locks = {LOCKS.OUTERTIER},
            keys_given = {KEYS.OUTERTIER},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1

            },
            room_bg = GROUND.JUNGLE,
            background_room = "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO17", {
            locks = {LOCKS.OUTERTIER},
            keys_given = {KEYS.LIGHT},
            region_id = "island2",
            room_choices = {
                ["JungleDenseMed"] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "BeachSand",
            "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO20", {
            locks = {LOCKS.LIGHT},
            keys_given = {KEYS.LIGHT},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 33)]] = 1,
                --        [salasjungle[math.random(1, 33)]] = 1,
                ["JungleMonkeyHell"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = "TidalMarsh",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO26", {
            locks = {LOCKS.LIGHT},
            keys_given = {KEYS.LIGHT},
            region_id = "island2",
            room_choices = {
                [salasbeach[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                [salastidal[math.random(1, 4)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO27", {
            locks = {LOCKS.LIGHT},
            keys_given = {KEYS.LIGHT},
            region_id = "island2",
            room_choices = {
                ["Magma"] = 1, -- MR went from 1-3
                ["MagmaGold"] = 1,
                ["MagmaGoldmoon"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "MagmaGold",
            "MagmaHomeBoon",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO28", {
            locks = {LOCKS.LIGHT},
            keys_given = {KEYS.FUNGUS},
            region_id = "island2",
            room_choices = {
                ["JungleNoBerry"] = 1,
                ["TidalSharkHome"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleRockyDrop",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO38", {
            locks = {LOCKS.FUNGUS},
            keys_given = {KEYS.FUNGUS},
            region_id = "island2",
            room_choices = {
                ["Beaverkinghome"] = 1,
                ["Beaverkingcity"] = 1,
                [salasmeadow[math.random(1, 9)]] = 1
            },
            room_bg = GROUND.MEADOW,
            background_room = "MeadowFlowery",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO39", {
            locks = {LOCKS.FUNGUS},
            keys_given = {KEYS.FUNGUS},
            region_id = "island2",
            room_choices = {
                ["BeachPalmCasino"] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = salasbeach[math.random(1, 24)],
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO43", {
            locks = {LOCKS.FUNGUS},
            keys_given = {KEYS.FUNGUS},
            region_id = "island2",
            room_choices = {
                [salasbeach[math.random(1, 24)]] = 1,
                --        [salasbeach[math.random(1, 24)]] = 1,		 --CM was 5 + 
                ["BeachShark"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO45", {
            locks = {LOCKS.FUNGUS},
            keys_given = {KEYS.LABYRINTH},
            region_id = "island2",
            room_choices = {
                ["BeachSand"] = 1,
                ["BeachPiggy"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO50", {
            locks = {LOCKS.LABYRINTH},
            keys_given = {KEYS.LABYRINTH},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["DoyDoyM"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "Jungle",
            colour = {1, .5, .5, .2}
        })

        AddTask("MISTO51", {
            locks = {LOCKS.LABYRINTH},
            keys_given = {KEYS.CAVE},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["DoyDoyF"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "Jungle",
            colour = {1, .5, .5, .2}
        })

    end

    AddTask("MISTO_eldorado", {
        locks = {LOCKS.LABYRINTH},
        keys_given = {KEYS.CAVE},
        region_id = "eldorado",
        level_set_piece_blocker = true,
        room_choices = {
            ["strange_island_eldorado"] = 1,
            ["strange_island_tikitribe"] = 1
        },
        room_bg = GROUND.JUNGLE,
        background_room = "JungleDense_plus",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MISTO_tikitribe", {
        locks = {LOCKS.LABYRINTH},
        keys_given = {KEYS.CAVE},
        region_id = "eldorado",
        level_set_piece_blocker = true,
        crosslink_factor = math.random(0, 1),
        make_loop = math.random(0, 100) < 50,
        room_choices = {
            ["strange_island_tikitribe"] = 1,
            ["JungleDense_plus"] = 3,
            ["BeachSand"] = 2
        },
        room_bg = GROUND.JUNGLE,
        background_room = "JungleDense_plus",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("MISTO_walrusvacation", {
        locks = {LOCKS.LABYRINTH},
        keys_given = {KEYS.CAVE},
        region_id = "eldorado",
        level_set_piece_blocker = true,
        crosslink_factor = math.random(0, 1),
        make_loop = math.random(0, 100) < 50,
        room_choices = {
            ["strange_island_walrusvacation"] = 1
        },
        room_bg = GROUND.JUNGLE,
        background_room = "BeachSand",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("eldoradojunto", {
        locks = {LOCKS.LABYRINTH},
        keys_given = {KEYS.CAVE},
        region_id = "junto",
        level_set_piece_blocker = true,
        room_choices = {
            ["strange_island_eldorado"] = 1,
            ["snapdragonforest"] = 1
        },
        room_bg = GROUND.JUNGLE,
        background_room = "snapdragonforestback",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("tikitribejunto", {
        locks = {LOCKS.LABYRINTH},
        keys_given = {KEYS.CAVE},
        region_id = "junto",
        level_set_piece_blocker = true,
        crosslink_factor = math.random(0, 1),
        make_loop = math.random(0, 100) < 50,
        room_choices = {
            ["strange_island_tikitribe"] = 1,
            ["strange_island_tikitribe2"] = 1,
            ["JungleDense_plus"] = 3
            --			["BeachSand"] = 2,
        },
        room_bg = GROUND.JUNGLE,
        background_room = "JungleDense_plus",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("walrusvacationjunto", {
        locks = {LOCKS.LABYRINTH},
        keys_given = {KEYS.CAVE},
        region_id = "junto",
        level_set_piece_blocker = true,
        crosslink_factor = math.random(0, 1),
        make_loop = math.random(0, 100) < 50,
        room_choices = {
            ["strange_island_walrusvacation"] = 1
        },
        room_bg = GROUND.JUNGLE,
        background_room = "BeachSand",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })
    ------------------------------------------------------------SW islands tasks----------------------------------------------------------------------
    if GetModConfigData("Shipwrecked") == 15 or GetModConfigData("kindofworld") == 10 then

        AddTask("TROPICAL6", {
            locks = {},
            keys_given = {},
            region_id = "tropical1",
            room_choices = {
                ["MagmaGold"] = 2, -- MR went from 1-3
                ["MagmaGoldBoon"] = 1 -- MR went from 1-4
            },
            room_bg = GROUND.MAGMAFIELD,
            background_room = "Magma",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL7", {
            locks = {},
            keys_given = {},
            region_id = "tropical2",

            room_choices = {
                ["PigVillagesw"] = 1,
                ["JungleDenseBerries"] = 1,
                ["BeachShark"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL8", {
            locks = {},
            keys_given = {},
            region_id = "tropical3",
            room_choices = {
                ["MagmaTallBird"] = 1,
                ["MagmaGoldBoon"] = 1
            },
            room_bg = GROUND.MAGMAFIELD,
            background_room = "BeachDunes",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL9", {
            locks = {},
            keys_given = {},
            region_id = "tropical4",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["JungleRockSkull"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.VOLCANO,
            background_room = "VolcanoNoise",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("TROPICAL11", {
            locks = {},
            keys_given = {},
            region_id = "tropical5",
            room_choices = {
                ["MagmaForest"] = 1, -- MR went from 1-3
                ["JungleDense"] = 1,
                ["JunglePigs"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDense",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL14", {
            locks = {},
            keys_given = {},
            region_id = "tropical6",
            room_choices = {
                [salasvolcano[math.random(1, 5)]] = 1,
                ["VolcanoAsh"] = 1,
                ["Volcano"] = 1,
                ["VolcanoObsidian"] = 1
            },
            room_bg = GROUND.VOLCANO,
            background_room = "VolcanoNoise",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL15", {
            locks = {},
            keys_given = {},
            region_id = "tropical7",
            room_choices = {
                ["TidalMermMarsh"] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                ["BeachSappy"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "BeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL16", {
            locks = {},
            keys_given = {},
            region_id = "tropical8",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL17", {
            locks = {},
            keys_given = {},
            region_id = "tropical9",
            room_choices = {
                ["JungleDenseMed"] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "BeachSand",
            "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL20", {
            locks = {},
            keys_given = {},
            region_id = "tropical10",
            room_choices = {
                [salasjungle[math.random(1, 33)]] = 1,
                --        [salasjungle[math.random(1, 33)]] = 1,
                ["JungleMonkeyHell"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = "TidalMarsh",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL26", {
            locks = {},
            keys_given = {},
            region_id = "tropical26",
            room_choices = {
                [salasbeach[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                [salastidal[math.random(1, 4)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL27", {
            locks = {},
            keys_given = {},
            region_id = "tropical11",
            room_choices = {
                ["Magma"] = 1, -- MR went from 1-3
                ["MagmaGold"] = 1,
                ["MagmaGoldmoon"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "MagmaGold",
            "MagmaHomeBoon",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL28", {
            locks = {},
            keys_given = {},
            region_id = "tropical12",
            room_choices = {
                ["JungleNoBerry"] = 1,
                ["TidalSharkHome"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleRockyDrop",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL38", {
            locks = {},
            keys_given = {},
            region_id = "tropical13",
            room_choices = {
                ["Beaverkinghome"] = 1,
                ["Beaverkingcity"] = 1,
                [salasmeadow[math.random(1, 9)]] = 1
            },
            room_bg = GROUND.DIRT_NOISE,
            background_room = "MeadowFlowery",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL39", {
            locks = {},
            keys_given = {},
            region_id = "tropical14",
            room_choices = {
                ["BeachPalmCasino"] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = salasbeach[math.random(1, 24)],
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL43", {
            locks = {},
            keys_given = {},
            region_id = "tropical15",
            room_choices = {
                [salasbeach[math.random(1, 24)]] = 1,
                --        [salasbeach[math.random(1, 24)]] = 1,	
                ["BeachShark"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL45", {
            locks = {},
            keys_given = {},
            region_id = "tropical16",
            room_choices = {
                ["BeachSand"] = 1,
                ["BeachPiggy"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL50", {
            locks = {},
            keys_given = {},
            region_id = "tropical18",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["DoyDoyM"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "Jungle",
            colour = {1, .5, .5, .2}
        })

        AddTask("TROPICAL51", {
            locks = {},
            keys_given = {},
            region_id = "tropical19",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["DoyDoyF"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "Jungle",
            colour = {1, .5, .5, .2}
        })

    end

    if GetModConfigData("kindofworld") == 10 then

        AddTask("HomeIslandVerySmall", {
            locks = {},
            keys_given = {},
            region_id = "ship1",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleDenseMedHome"] = 1, -- + math.random(0, 2), --was 5+(0-2) --changed from JungleDense to remove monkeys
                ["BeachSandHome"] = 2 -- was 5
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSandHome"}, -- removed BeachUnkept, added unkept above
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("HomeIslandSmall", {
            locks = {},
            keys_given = {},
            region_id = "ship2",
            room_choices = {
                ["JungleDenseMedHome"] = 2, -- + math.random(0, 2), --was 5+(0-2) --changed from JungleDense to remove monkeys
                ["BeachUnkept"] = 1 -- was 3
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSandHome"}, -- removed BeachUnkept, added unkept above
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("HomeIslandSmallBoon", {
            locks = {},
            keys_given = {},
            region_id = "ship3",
            room_choices = {
                ["JungleDenseHome"] = 2, -- + math.random(0, 2), --was 5+(0-2)
                ["JungleDenseMedHome"] = 1, -- + math.random(0, 2), --was 5+(0-2) --changed from JungleDense to remove monkeys
                ["BeachSandHome"] = 1, -- was 5
                ["BeachUnkept"] = 1 -- was 3
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSandHome"}, -- removed BeachUnkept, added unkept above
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("HomeIslandMed", {
            locks = {},
            keys_given = {},
            region_id = "ship4",
            room_choices = {
                ["JungleDenseMedHome"] = 3,
                ["BeachUnkept"] = 1 -- was 3	
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSandHome"}, -- removed beach unkept, added unkept above
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("HomeIslandLarge", {
            locks = {},
            keys_given = {},
            region_id = "ship5",
            room_choices = {
                ["JungleDenseMedHome"] = 3,
                ["BeachUnkept"] = 2 -- was 3
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSandHome"}, -- removed BeachUnkept, added unkept above
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("HomeIslandLargeBoon", {
            locks = {},
            keys_given = {},
            region_id = "ship6",
            room_choices = {
                ["JungleDenseMedHome"] = 3,
                ["BeachUnkept"] = 2 -- was 3
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSandHome"}, -- removed BeachUnkept, added unkept above
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("DesertIsland", {
            locks = {},
            keys_given = {},
            region_id = "ship7",
            room_choices = {
                ["BeachSand"] = 2
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("VolcanoIsland", {
            locks = {},
            keys_given = {},
            region_id = "ship8",
            room_choices = {
                ["VolcanoRock"] = 1,
                ["MagmaVolcano"] = 1,
                ["VolcanoObsidian"] = 1,
                ["VolcanoObsidianBench"] = 1,
                ["VolcanoAltar"] = 1,
                ["VolcanoLava"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"VolcanoRock"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleMarsh", {
            locks = {},
            keys_given = {},
            region_id = "ship9",
            room_choices = {
                ["TidalMarsh"] = 2, -- was 3
                ["JungleDense"] = 6, -- was 8
                ["JungleDenseBerries"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDense"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("BeachJingleS", {
            locks = {},
            keys_given = {},
            region_id = "ship10",
            room_choices = {
                ["JungleDenseMed"] = 3, -- MR went from 1-3
                ["BeachUnkept"] = 1 -- MR went from 1-3
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("BeachBothJungles", {
            locks = {},
            keys_given = {},
            region_id = "ship11",
            room_choices = {
                ["JungleDenseMed"] = 1, -- MR went from 1-3
                ["JungleDense"] = 2, -- MR went from 1-2
                ["BeachSand"] = 3 -- MR went from 1-4
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("BeachJungleD", {
            locks = {},
            keys_given = {},
            region_id = "ship12",
            room_choices = {
                ["JungleDense"] = 2, -- MR went from 1-2
                ["BeachSand"] = 1 -- CM was 3
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("BeachSavanna", {
            locks = {},
            keys_given = {},
            region_id = "ship13",
            room_choices = {
                ["BeachSand"] = 2, -- MR went from 2-4
                ["NoOxMeadow"] = 2 -- MR went from 2-4 
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("GreentipA", {
            locks = {},
            keys_given = {},
            region_id = "ship14",
            room_choices = {
                ["BeachSand"] = 2, -- MR went from 1-5
                ["MeadowCarroty"] = 1, -- MR went from 1-3 Plain
                ["JungleDenseMed"] = 3, -- MR went from 1-3
                ["BeachUnkept"] = 1 -- newly added to the mix
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("GreentipB", {
            locks = {},
            keys_given = {},
            region_id = "ship15",
            room_choices = {
                ["BeachSand"] = 1, -- MR went from 1-3
                ["JungleDense"] = 3 -- MR went from 1-3
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("HalfGreen", {
            locks = {},
            keys_given = {},
            region_id = "ship16",
            room_choices = {
                ["BeachSand"] = 3, -- MR went from 1-3
                ["JungleDenseMed"] = 1, -- MR went from 1-2
                ["NoOxMeadow"] = 1 -- MR went from 1-2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("BeachRockyland", {
            locks = {},
            keys_given = {},
            region_id = "ship17",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSand"] = 1, -- CM was 3 -- MR went from 1-5
                ["Magma"] = 1 -- cm was 3 -- MR went from 1-3
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand", "BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("LotsaGrass", {
            locks = {},
            keys_given = {},
            region_id = "ship18",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleDenseMed"] = 2,
                ["NoOxMeadow"] = 2 -- was 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand", "JungleSparse"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("AllBeige", {
            locks = {},
            keys_given = {},
            region_id = "ship19",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSand"] = 1,
                ["Magma"] = 2
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand", "BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("BeachMarsh", {
            locks = {},
            keys_given = {},
            region_id = "ship20",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSand"] = 1,
                ["TidalMarsh"] = 2 -- was 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand", "BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("Verdant", {
            locks = {},
            keys_given = {},
            region_id = "ship21",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSand"] = 1,
                ["BeachPiggy"] = 1,
                ["JungleDenseMed"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand", "BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("VerdantMost", {
            locks = {},
            keys_given = {},
            region_id = "ship22",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSand"] = 1,
                ["BeachSappy"] = 1,
                ["JungleDenseMed"] = 1,
                ["JungleDenseBerries"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand", "BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("Vert", {
            locks = {},
            keys_given = {},
            region_id = "ship23",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSand"] = 1,
                ["MeadowCarroty"] = 1,
                ["JungleDense"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand", "BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("Florida Timeshare", {
            locks = {},
            keys_given = {},
            region_id = "ship24",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["TidalMarsh"] = 1,
                ["JungleDenseMed"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleSRockyland", {
            locks = {},
            keys_given = {},
            region_id = "ship25",
            room_choices = {
                ["JungleDenseMed"] = 2, -- CM was 3 --was 1
                ["Magma"] = 6 -- CM was 8 --was 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleSparse",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleSSavanna", {
            locks = {},
            keys_given = {},
            region_id = "ship26",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleDenseMed"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseMed"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleBeige", {
            locks = {},
            keys_given = {},
            region_id = "ship27",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["Magma"] = 2,
                ["JungleDenseMed"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleSparse"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("FullofBees", {
            locks = {},
            keys_given = {},
            region_id = "ship28",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeesBeach"] = 2,
                ["JungleDense"] = 1 -- was JungleSparse
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleBees", "SavannaBees"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleDense", { ------THIS IS A GOOD EXAMPLE OF THEMED ISLAND
            locks = {},
            keys_given = {},
            region_id = "ship29",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["TidalMarsh"] = 1,
                ["JungleFlower"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDense",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleDMarsh", {
            locks = {},
            keys_given = {},
            region_id = "ship30",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["TidalMarsh"] = 1,
                ["JungleDense"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseMed", "TidalMermMarsh"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleDRockyland", {
            locks = {},
            keys_given = {},
            region_id = "ship31",
            room_choices = {
                ["JungleDense"] = 2, -- CM was 3
                ["Magma"] = 4 -- CM was 4 --+ math.random(0,1),
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDense", "Magma"}, -- added Magma here instead ((CM - this makes it so that maybe we won't end up with any rock areas on this island))
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleDRockyMarsh", {
            locks = {},
            keys_given = {},
            region_id = "ship32",
            room_choices = { -- included 1: Swamp, Magma, JungleDense
                ["TidalMarsh"] = 2, -- CM was 3
                ["JungleDense"] = 4, -- CM was 8
                ["Magma"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDense", "BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleDSavanna", {
            locks = {},
            keys_given = {},
            region_id = "ship33",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleDense"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDense"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("JungleDSavRock", {
            locks = {},
            keys_given = {},
            region_id = "ship34",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["Magma"] = 1,
                ["JungleDense"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDense"}, -- "NoOxMangrove",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("HotNSticky", {
            locks = {},
            keys_given = {},
            region_id = "ship35",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["TidalMarsh"] = 2,
                ["JungleDenseMed"] = 1,
                ["JungleDense"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDense", "TidalMarsh"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("Marshy", { -- not being called
            locks = {},
            keys_given = {},
            region_id = "ship36",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["TidalMarsh"] = 1,
                ["TidalMermMarsh"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "TidalMarsh",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("NoGreen A", {
            locks = {},
            keys_given = {},
            region_id = "ship37",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["TidalMarsh"] = 1,
                ["Magma"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"Magma", "TidalMarsh"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("NoGreen B", {
            locks = {},
            keys_given = {},
            region_id = "ship38",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["ToxicTidalMarsh"] = 3,
                ["Magma"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "ToxicTidalMarsh",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("Savanna", {
            locks = {},
            keys_given = {},
            region_id = "ship39",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachUnkept"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = "BeachNoCrabbits",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("Rockyland", {
            locks = {},
            keys_given = {},
            region_id = "ship40",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["Magma"] = 2, -- was 1
                ["ToxicTidalMarsh"] = math.random(0, 1)
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachUnkept"}, -- was BeachGravel
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("PalmTreeIsland", {
            locks = {},
            keys_given = {},
            region_id = "ship41",
            crosslink_factor = 1,
            make_loop = true,
            room_choices = {
                ["BeachSinglePalmTreeHome"] = 1 -- MR went from 1-5
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachSinglePalmTreeHome",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        -- Test tasks ================================================================================================================================================================
        AddTask("IslandParadise", {
            locks = {},
            keys_given = {},
            region_id = "ship42",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSand"] = 1, -- CM + math.random(0, 2),
                ["Jungle"] = 2, -- CM + math.random(0, 1),
                ["MeadowMandrake"] = 1,
                ["Magma"] = 1, -- CM + math.random(0, 1),
                ["JungleDenseVery"] = math.random(0, 1)
            },
            room_bg = GROUND.BEACH,
            -- background_room={"BeachSand", "BeachGravel", "BeachUnkept", "Jungle"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("PiggyParadise", {
            locks = {},
            keys_given = {},
            region_id = "ship43",
            room_choices = {
                ["JungleDenseBerries"] = 3,
                ["BeachPiggy"] = 5 + math.random(1, 3)
            },
            room_bg = GROUND.TIDALMARSH,
            background_room = {"BeachSand", "BeachPiggy", "BeachPiggy", "BeachPiggy", "TidalMarsh"},
            colour = {
                r = 0.5,
                g = 0,
                b = 1,
                a = 1
            }
        })

        AddTask("BeachPalmForest", {
            locks = {},
            keys_given = {},
            region_id = "ship44",
            room_choices = {
                ["BeachPalmForest"] = 1 + math.random(0, 3)
            },
            -- room_bg=GROUND.IMPASSABLE,
            -- background_room="BGImpassable",
            room_bg = GROUND.TIDALMARSH,
            background_room = "BeachPalmForest",
            colour = {
                r = 0.5,
                g = 0,
                b = 1,
                a = 1
            }
        })

        AddTask("ThemeMarshCity", {
            locks = LOCKS.ISLAND3,
            keys_given = {},
            region_id = "ship45",
            -- entrance_room = "ForceDisconnectedRoom",
            room_choices = {
                ["TidalMermMarsh"] = 1 + math.random(0, 1),
                ["ToxicTidalMarsh"] = 1 + math.random(0, 1),
                ["JungleSpidersDense"] = 1 -- CM was 3,
            },
            room_bg = GROUND.TIDALMARSH,
            background_room = {"BeachSand", "BeachPiggy", "TidalMarsh"},
            colour = {
                r = 0.5,
                g = 0,
                b = 1,
                a = 1
            }
        })

        AddTask("Spiderland", {
            locks = {},
            keys_given = {},
            region_id = "ship46",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["MagmaSpiders"] = 1,
                ["JungleSpidersDense"] = 2,
                ["JungleSpiderCity"] = 1 -- need to make this jungly instead of using basegame trees and ground
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"BeachGravel"}, -- removed MagmaSpiders
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleBamboozled", {
            locks = {},
            keys_given = {},
            region_id = "ship47",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleBamboozled"] = 1 + math.random(0, 1) -- added the random bonus room
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleBamboozled"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleMonkeyHell", {
            locks = {},
            keys_given = {},
            region_id = "ship48",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleMonkeyHell"] = 3
                -- ["JungleDenseBerries"] =1,
                -- ["JungleDenseMedHome"] =1,
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"Jungle"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleCritterCrunch", {
            locks = {},
            keys_given = {},
            region_id = "ship49",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleCritterCrunch"] = 2,
                ["JungleDenseCritterCrunch"] = 1
                -- ["Jungle"] = 1,
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseCritterCrunch"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleShroomin", {
            locks = {},
            keys_given = {},
            region_id = "ship50",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleShroomin"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseMedHome"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleRockyDrop", {
            locks = {},
            keys_given = {},
            region_id = "ship51",
            room_choices = {
                ["MagmaSpiders"] = 2, -- CM was 3
                ["JungleRockyDrop"] = 4, -- CM was 8
                ["Jungle"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseMedHome"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleEyePlant", {
            locks = {},
            keys_given = {},
            region_id = "ship52",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleEyeplant"] = 1,
                ["TidalMarsh"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseMedHome"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleBerries", {
            locks = {},
            keys_given = {},
            region_id = "ship53",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleDenseBerries"] = 4
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleSparse", "Jungle"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleNoBerry", {
            locks = {},
            keys_given = {},
            region_id = "ship54",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleNoBerry"] = 3
                --[[ ["Jungle"] = 1,
			["JungleDenseVery"] = 1, ]]
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleSparse", "Jungle"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleNoRock", {
            locks = {},
            keys_given = {},
            region_id = "ship55",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleNoRock"] = 1,
                -- ["JungleEyeplant"] = 1,
                ["TidalMarsh"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseMed", "JungleDense"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleNoMushroom", {
            locks = {},
            keys_given = {},
            region_id = "ship56",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleNoMushroom"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleNoMushroom"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleNoFlowers", {
            locks = {},
            keys_given = {},
            region_id = "ship57",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleNoFlowers"] = math.random(3, 5)
                -- ["JungleDenseMedHome"] = 1,
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"Jungle", "JungleDense"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleEvilFlowers", {
            locks = {},
            keys_given = {},
            region_id = "ship58",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleEvilFlowers"] = 2,
                ["ToxicTidalMarsh"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleDenseMed", "JungleClearing"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandJungleSkeleton", {
            locks = {},
            keys_given = {},
            region_id = "ship59",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["JungleSkeleton"] = 1,
                ["JungleDenseMedHome"] = 1,
                ["TidalMermMarsh"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"Jungle", "JungleDense"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachCrabTown", {
            locks = {},
            keys_given = {},
            region_id = "ship60",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachCrabTown"] = math.random(1, 3)
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachDunes", {
            locks = {},
            keys_given = {},
            region_id = "ship61",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachDunes"] = 1,
                ["BeachUnkept"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand", "BeachUnkept"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachGrassy", {
            locks = {},
            keys_given = {},
            region_id = "ship62",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachGrassy"] = 1,
                ["BeachPalmForest"] = 1,
                ["BeachSandHome"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachUnkept", "BeachGravel"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachSappy", {
            locks = {},
            keys_given = {},
            region_id = "ship63",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSappy"] = 1,
                ["BeachSand"] = 1,
                ["BeachUnkept"] = 1 -- was BeachGravel
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSandHome", "BeachSappy"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachRocky", {
            locks = {},
            keys_given = {},
            region_id = "ship64",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachRocky"] = 1,
                -- ["BeachGravel"] = 1,
                ["BeachUnkept"] = 1,
                ["BeachSandHome"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachUnkept", "BeachSandHome"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachLimpety", {
            locks = {},
            keys_given = {},
            region_id = "ship65",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachLimpety"] = 1,
                ["BeachSand"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand", "BeachUnkept"}, -- was BeachGravel instead of Unkept
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachForest", {
            locks = {},
            keys_given = {},
            region_id = "ship66",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachPalmForest"] = 1,
                ["BeachSandHome"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachUnkept", "BeachSandHome"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachSpider", {
            locks = {},
            keys_given = {},
            region_id = "ship67",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachSpider"] = 2
                -- ["BeachUnkept"] = 1,
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand", "BeachUnkept"}, -- was BeachGravel instead of Unkept
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachNoFlowers", {
            locks = {},
            keys_given = {},
            region_id = "ship68",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachNoFlowers"] = 1,
                ["BeachUnkept"] = 1 -- was BeachGravel
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachNoLimpets", {
            locks = {},
            keys_given = {},
            region_id = "ship69",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachNoLimpets"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSand"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandBeachNoCrabbits", {
            locks = {},
            keys_given = {},
            region_id = "ship70",
            crosslink_factor = math.random(0, 1),
            make_loop = math.random(0, 100) < 50,
            room_choices = {
                ["BeachNoCrabbits"] = 2
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachNoCrabbits"}, -- was BeachGravel instead of Unkept
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandMangroveOxBoon", {
            locks = {},
            keys_given = {},
            region_id = "ship71",
            room_choices = {
                ["JungleNoRock"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"JungleNoRock"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandMeadowBees", {
            locks = {},
            keys_given = {},
            region_id = "ship72",
            room_choices = {
                ["MeadowBees"] = 1,
                ["NoOxMeadow"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = {"NoOxMeadow"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandMeadowCarroty", {
            locks = {},
            keys_given = {},
            region_id = "ship73",
            room_choices = {
                ["MeadowCarroty"] = 1,
                ["NoOxMeadow"] = 1
            },
            room_bg = GROUND.MEADOW,
            background_room = {"NoOxMeadow"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandRockyGold", {
            locks = {},
            keys_given = {},
            region_id = "ship74",
            room_choices = {
                ["MagmaGoldBoon"] = 1,
                ["MagmaGold"] = 1,
                ["BeachSandHome"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = {"BeachSandHome"},
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandRockyTallBeach", {
            locks = {},
            keys_given = {},
            region_id = "ship75",
            room_choices = {
                ["MagmaTallBird"] = 1,
                ["GenericMagmaNoThreat"] = 1,
                ["BeachUnkept"] = 1 -- was BeachGravel
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachUnkept",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("IslandRockyTallJungle", {
            locks = {},
            keys_given = {},
            region_id = "ship76",
            room_choices = {
                ["MagmaTallBird"] = 1,
                ["BG_Magma"] = 1,
                ["JungleDenseMed"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDenseMed",
            colour = {
                r = 1,
                g = 1,
                b = 0,
                a = 1
            }
        })

        AddTask("ShellingOut", {
            locks = {},
            keys_given = {},
            region_id = "ship78",
            room_choices = {
                ["BeachShells"] = 2
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachShells",
            colour = {
                r = 1,
                g = 0,
                b = 0.6,
                a = 1
            }
        })

        AddTask("Cranium", {
            locks = {},
            keys_given = {},
            region_id = "ship79",
            room_choices = {
                ["BeachSkull"] = 1,
                ["Jungle"] = 2
            },
            room_bg = GROUND.BEACH,
            background_room = "Jungle",
            colour = {
                r = 1,
                g = 0,
                b = 0.6,
                a = 1
            }
        })

        AddTask("CrashZone", {
            locks = {},
            keys_given = {},
            region_id = "ship80",
            room_choices = {
                ["Jungle"] = 2,
                ["MagmaForest"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "Jungle",
            colour = {
                r = 1,
                g = 0,
                b = 0.6,
                a = 1
            }
        })

        AddTask("PirateBounty", {
            locks = {},
            keys_given = {},
            region_id = "ship80",
            room_choices = {
                ["BeachX"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "BeachUnkeptDubloon",
            colour = {
                r = 1,
                g = 0,
                b = 0.6,
                a = 1
            }
        })

    end

    if GetModConfigData("Shipwrecked") == 20 then
        AddTask("XISTO6", {
            locks = LOCKS.NONE,
            keys_given = {KEYS.PICKAXE, KEYS.AXE, KEYS.GRASS, KEYS.WOOD, KEYS.TIER1},
            room_choices = {
                ["MAINMagmaGold"] = 2,
                ["MAINMagmaGoldBoon"] = 1
            },
            room_bg = GROUND.MAGMAFIELD,
            background_room = "MAINMagma",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO7", {
            locks = {LOCKS.ROCKS},
            keys_given = {KEYS.TRINKETS, KEYS.STONE, KEYS.WOOD, KEYS.TIER1},
            room_choices = {
                ["MAINPigVillagesw"] = 1,
                ["MAINJungleDenseBerries"] = 1,
                ["MAINBeachShark"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINJungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO8", {
            locks = {LOCKS.ROCKS, LOCKS.BASIC_COMBAT, LOCKS.TIER1},
            keys_given = {KEYS.MEAT, KEYS.POOP, KEYS.WOOL, KEYS.GRASS, KEYS.TIER2},
            room_choices = {
                ["MAINMagmaTallBird"] = 1,
                ["MAINMagmaGoldBoon"] = 1
            },
            room_bg = GROUND.MAGMAFIELD,
            background_room = "MAINBeachDunes",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO9", {
            locks = {LOCKS.SPIDERDENS, LOCKS.TIER2},
            keys_given = {KEYS.MEAT, KEYS.SILK, KEYS.SPIDERS, KEYS.TIER3},
            room_choices = {
                [salasjungle1[math.random(1, 24)]] = 1,
                ["MAINJungleRockSkull"] = 1,
                [salasjungle1[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = salasjungle1[math.random(1, 24)],
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO11", {
            locks = {LOCKS.BEEHIVE, LOCKS.TIER1},
            keys_given = {KEYS.HONEY, KEYS.TIER2},
            room_choices = {
                ["MAINMagmaForest"] = 1, -- MR went from 1-3
                ["MAINJungleDense"] = 1,
                ["MAINJunglePigs"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINJungleDense",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO14", {
            locks = {LOCKS.PIGKING, LOCKS.TIER2},
            keys_given = {KEYS.PIGS, KEYS.GOLD, KEYS.TIER3},
            room_choices = {
                [salasvolcano1[math.random(1, 5)]] = 1,
                ["MAINVolcanoAsh"] = 1,
                ["MAINVolcano"] = 1,
                ["MAINVolcanoObsidian"] = 1
            },
            room_bg = GROUND.VOLCANO,
            background_room = "MAINVolcanoNoise",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO15", {
            locks = {LOCKS.ADVANCED_COMBAT, LOCKS.MONSTERS_DEFEATED, LOCKS.TIER3},
            keys_given = {KEYS.WALRUS, KEYS.TIER4},
            room_choices = {
                ["MAINTidalMermMarsh"] = 1,
                [salasbeach1[math.random(1, 24)]] = 1,
                ["MAINBeachSappy"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINBeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO16", {
            locks = {LOCKS.ADVANCED_COMBAT, LOCKS.MONSTERS_DEFEATED, LOCKS.TIER4},
            keys_given = {KEYS.HOUNDS, KEYS.TIER5, KEYS.ROCKS},
            room_choices = {
                [salasjungle1[math.random(1, 24)]] = 1,
                [salasbeach1[math.random(1, 24)]] = 1

            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINBeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO17", {
            locks = {LOCKS.BASIC_COMBAT, LOCKS.TIER2},
            keys_given = {KEYS.POOP, KEYS.WOOL, KEYS.WOOD, KEYS.GRASS, KEYS.TIER2},
            room_choices = {
                ["MAINJungleDenseMed"] = 1,
                [salasbeach1[math.random(1, 24)]] = 1,
                [salasbeach1[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINBeachSand",
            "MAINBeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO20", {
            locks = {LOCKS.SPIDERS_DEFEATED},
            keys_given = {KEYS.PICKAXE, KEYS.TIER2},
            room_choices = {
                [salasjungle1[math.random(1, 33)]] = 1,
                --        [salasjungle1[math.random(1, 33)]] = 1,
                ["MAINJungleMonkeyHell"] = 2
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINTidalMarsh",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO26", {
            locks = {LOCKS.PIGGIFTS, LOCKS.TIER1},
            keys_given = {KEYS.PIGS, KEYS.MEAT, KEYS.GRASS, KEYS.WOOD, KEYS.TIER2},
            room_choices = {
                [salasbeach1[math.random(1, 24)]] = 1,
                [salasbeach1[math.random(1, 24)]] = 1,
                [salastidal1[math.random(1, 4)]] = 1,
                [salasbeach1[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "MAINBeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO27", {
            locks = {LOCKS.SPIDERDENS, LOCKS.MONSTERS_DEFEATED, LOCKS.TIER3},
            keys_given = {KEYS.SPIDERS, KEYS.TIER4},
            room_choices = {
                ["MAINMagma"] = 1, -- MR went from 1-3
                ["MAINMagmaGold"] = 1,
                ["MAINMagmaGoldmoon"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "MAINMagmaGold",
            "MAINMagmaHomeBoon",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO28", {
            locks = {LOCKS.KILLERBEES, LOCKS.TIER3},
            keys_given = {KEYS.HONEY, KEYS.TIER3},
            room_choices = {
                ["MAINJungleNoBerry"] = 1,
                ["MAINTidalSharkHome"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINJungleRockyDrop",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO38", {
            locks = {LOCKS.SPIDERS_DEFEATED, LOCKS.TIER1},
            keys_given = {KEYS.BEEHAT, KEYS.GRASS, KEYS.TIER1},
            room_choices = {
                ["MAINBeaverkinghome"] = 1,
                ["MAINBeaverkingcity"] = 1,
                [salasmeadow1[math.random(1, 9)]] = 1
            },
            room_bg = GROUND.MEADOW,
            background_room = "MAINMeadowFlowery",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO39", {
            locks = {LOCKS.ADVANCED_COMBAT, LOCKS.MONSTERS_DEFEATED, LOCKS.TIER4},
            keys_given = {KEYS.WALRUS, KEYS.TIER5},
            room_choices = {
                ["MAINBeachPalmCasino"] = 1,
                [salasbeach1[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = salasbeach1[math.random(1, 24)],
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO43", {
            locks = {LOCKS.TIER1},
            keys_given = {KEYS.GRASS, KEYS.MEAT, KEYS.TIER1},
            room_choices = {
                [salasbeach1[math.random(1, 24)]] = 1,
                [salasbeach1[math.random(1, 24)]] = 1, -- CM was 5 + 
                ["MAINBeachShark"] = 1
            },
            room_bg = GROUND.BEACH,
            background_room = "MAINBeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO45", {
            locks = {LOCKS.BASIC_COMBAT, LOCKS.TIER1},
            keys_given = {KEYS.MEAT, KEYS.GRASS, KEYS.HONEY, KEYS.TIER2},
            room_choices = {
                ["MAINBeachSand"] = 1,
                ["MAINBeachPiggy"] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINJungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO50", {
            locks = {LOCKS.TIER1},
            keys_given = {KEYS.TIER2},
            room_choices = {
                [salasjungle1[math.random(1, 24)]] = 1,
                ["MAINDoyDoyM"] = 1,
                [salasjungle1[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINJungle",
            colour = {1, .5, .5, .2}
        })

        AddTask("XISTO51", {
            locks = {LOCKS.TIER1},
            keys_given = {KEYS.ROCKS, KEYS.GOLD, KEYS.TIER2},
            room_choices = {
                [salasjungle1[math.random(1, 24)]] = 1,
                ["MAINDoyDoyF"] = 1,
                [salasjungle1[math.random(1, 24)]] = 1
            },
            room_bg = GROUND.JUNGLE,
            background_room = "MAINJungle",
            colour = {1, .5, .5, .2}
        })

    end

    if GetModConfigData("Shipwrecked") == 25 or GetModConfigData("kindofworld") == 10 then

        AddTask("A_MISTO39", {
            locks = {},
            keys_given = {KEYS.MUSHROOM, KEYS.RABBIT, KEYS.AREA, KEYS.CAVERN, KEYS.SINKHOLE, KEYS.PASSAGE},
            region_id = "island2",
            room_choices = {
                ["BeachPalmCasino"] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.BEACH,
            background_room = salasbeach[math.random(1, 24)],
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK1", {
            locks = {LOCKS.MUSHROOM},
            keys_given = {KEYS.CAVE},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO6", {
            locks = {LOCKS.CAVE},
            keys_given = {KEYS.EASY},
            region_id = "island2",
            room_choices = {
                ["MagmaGold"] = 2,
                ["MagmaGoldBoon"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.MAGMAFIELD,
            background_room = "Magma",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK7", {
            locks = {LOCKS.EASY},
            keys_given = {KEYS.EASY},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO7", {
            locks = {LOCKS.EASY},
            keys_given = {KEYS.EASY},
            region_id = "island2",
            room_choices = {
                ["PigVillagesw"] = 1,
                ["JungleDenseBerries"] = 1,
                ["BeachShark"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_MISTO8", {
            locks = {LOCKS.EASY},
            keys_given = {KEYS.EASY},
            region_id = "island2",
            room_choices = {
                ["MagmaTallBird"] = 1,
                ["MagmaGoldBoon"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.MAGMAFIELD,
            background_room = "BeachDunes",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK2", {
            locks = {LOCKS.RABBIT},
            keys_given = {KEYS.INNERTIER},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO9", {
            locks = {LOCKS.INNERTIER},
            keys_given = {KEYS.MEDIUM},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["JungleRockSkull"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = salasjungle[math.random(1, 24)],
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK8", {
            locks = {LOCKS.MEDIUM},
            keys_given = {KEYS.MEDIUM},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO11", {
            locks = {LOCKS.MEDIUM},
            keys_given = {KEYS.MEDIUM},
            region_id = "island2",
            room_choices = {
                ["MagmaForest"] = 1, -- MR went from 1-3
                ["JungleDense"] = 1,
                ["JunglePigs"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDense",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_MISTO14", {
            locks = {LOCKS.MEDIUM},
            keys_given = {KEYS.MEDIUM},
            region_id = "island2",
            room_choices = {
                [salasvolcano[math.random(1, 5)]] = 1,
                ["VolcanoAsh"] = 1,
                ["Volcano"] = 1,
                ["VolcanoObsidian"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.VOLCANO,
            background_room = "VolcanoNoise",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK3", {
            locks = {LOCKS.AREA},
            keys_given = {KEYS.OUTERTIER},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO15", {
            locks = {LOCKS.OUTERTIER},
            keys_given = {KEYS.HARD},
            region_id = "island2",
            room_choices = {
                ["TidalMermMarsh"] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                ["BeachSappy"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "BeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK9", {
            locks = {LOCKS.HARD},
            keys_given = {KEYS.HARD},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO16", {
            locks = {LOCKS.HARD},
            keys_given = {KEYS.HARD},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1

            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_MISTO17", {
            locks = {LOCKS.HARD},
            keys_given = {KEYS.HARD},
            region_id = "island2",
            room_choices = {
                ["JungleDenseMed"] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "BeachSand",
            "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK4", {
            locks = {LOCKS.CAVERN},
            keys_given = {KEYS.LIGHT},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO20", {
            locks = {LOCKS.LIGHT},
            keys_given = {KEYS.BLUE},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 33)]] = 1,
                --        [salasjungle[math.random(1, 33)]] = 1,
                ["JungleMonkeyHell"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "TidalMarsh",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK10", {
            locks = {LOCKS.BLUE},
            keys_given = {KEYS.BLUE},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO26", {
            locks = {LOCKS.BLUE},
            keys_given = {KEYS.BLUE},
            region_id = "island2",
            room_choices = {
                [salasbeach[math.random(1, 24)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1,
                [salastidal[math.random(1, 4)]] = 1,
                [salasbeach[math.random(1, 24)]] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.BEACH,
            background_room = "BeachUnkept",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_MISTO27", {
            locks = {LOCKS.BLUE},
            keys_given = {KEYS.BLUE},
            region_id = "island2",
            room_choices = {
                ["Magma"] = 1, -- MR went from 1-3
                ["MagmaGold"] = 1,
                ["MagmaGoldmoon"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.BEACH,
            background_room = "MagmaGold",
            "MagmaHomeBoon",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK5", {
            locks = {LOCKS.SINKHOLE},
            keys_given = {KEYS.FUNGUS},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO28", {
            locks = {LOCKS.FUNGUS},
            keys_given = {KEYS.RED},
            region_id = "island2",
            room_choices = {
                ["JungleNoBerry"] = 1,
                ["TidalSharkHome"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "JungleRockyDrop",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK11", {
            locks = {LOCKS.RED},
            keys_given = {KEYS.RED},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO38", {
            locks = {LOCKS.RED},
            keys_given = {KEYS.RED},
            region_id = "island2",
            room_choices = {
                ["Beaverkinghome"] = 1,
                ["Beaverkingcity"] = 1,
                [salasmeadow[math.random(1, 9)]] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.MEADOW,
            background_room = "MeadowFlowery",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_MISTO43", {
            locks = {LOCKS.RED},
            keys_given = {KEYS.RED},
            region_id = "island2",
            room_choices = {
                [salasbeach[math.random(1, 24)]] = 1,
                --        [salasbeach[math.random(1, 24)]] = 1,		 --CM was 5 + 
                ["BeachShark"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.BEACH,
            background_room = "BeachSand",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK6", {
            locks = {LOCKS.PASSAGE},
            keys_given = {KEYS.LABYRINTH},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO45", {
            locks = {LOCKS.LABYRINTH},
            keys_given = {KEYS.GREEN},
            region_id = "island2",
            room_choices = {
                ["BeachSand"] = 1,
                ["BeachPiggy"] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "JungleDenseMed",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_BLANK12", {
            locks = {LOCKS.GREEN},
            keys_given = {KEYS.GREEN},
            region_id = "island2",
            room_choices = {
                ["ForceDisconnectedRoom"] = 2
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.IMPASSABLE,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 0.6,
                g = 0.6,
                b = 0.0,
                a = 1
            }
        })

        AddTask("A_MISTO50", {
            locks = {LOCKS.GREEN},
            keys_given = {KEYS.GREEN},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["DoyDoyM"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "Jungle",
            colour = {1, .5, .5, .2}
        })

        AddTask("A_MISTO51", {
            locks = {LOCKS.GREEN},
            keys_given = {KEYS.GREEN},
            region_id = "island2",
            room_choices = {
                [salasjungle[math.random(1, 24)]] = 1,
                ["DoyDoyF"] = 1,
                [salasjungle[math.random(1, 24)]] = 1
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.JUNGLE,
            background_room = "Jungle",
            colour = {1, .5, .5, .2}
        })

    end
    --------------------------------------------------cultivated room--------------------------------------------------------------------------------------------------------------------
    fazendas = {
        [1] = "farm_1",
        [2] = "farm_2",
        [3] = "farm_3",
        [4] = "farm_4",
        [5] = "farm_5"
    }

    AddRoom("BG_cultivated_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            }
        }
    })

    AddRoom("cultivated_base_1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },

            countprefabs = {
                crabapple_tree = 4

            },
            countstaticlayouts = {
                ["farm_1"] = 1
            }
        }
    })

    AddRoom("cultivated_base_2", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },

            countprefabs = {
                crabapple_tree = 4
            },

            countstaticlayouts = {
                ["farm_2"] = 1
            }
        }
    })

    AddRoom("cultivated_base_3", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                ["farm_3"] = 1
            }
        }
    })

    AddRoom("cultivated_base_4", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                ["farm_4"] = 1
            }

        }
    })

    AddRoom("cultivated_base_5", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                ["farm_5"] = 1
            }

        }
    })

    AddRoom("piko_land", {
        colour = {
            r = 1.0,
            g = 0.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece", "hamlet"},
        contents = {
            distributepercent = 0.06, -- 0.1
            distributeprefabs = {
                --	grass = 0.05,
                --	flower = 0.3,
                rock1 = 0.01,
                teatree = 2.0
            },
            countprefabs = {
                teatree_piko_nest_patch = 1
            }
        }

    })

    ----------------------------------------------------------- painted room--------------------------------------------------------------------------------------------------
    ----------------------------------------------------------- battlegrounds room--------------------------------------------------------------------------------------------------
    AddRoom("BG_battleground_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("battleground_ribs", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_ribs = 1,
                vampirebatcave_potential = 1,
                maze_cave_roc_entrance = 1
            }
        }
    })
    AddRoom("battleground_claw", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_claw = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("battleground_claw1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_claw = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("battleground_leg", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_leg = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("battleground_leg1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_leg = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    AddRoom("battleground_head", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            --					countstaticlayouts={["CaveEntrance"]=1},
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_head = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("BG_painted_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PAINTED,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .15, -- .26
            distributeprefabs = {
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.2,
                thunderbirdnest = 0.1,
                sedimentpuddle = 0.1,
                pangolden = 0.005
            },
            countprefabs = {
                pangolden = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    -------------------------------------------room deep florest hamlet-------------------------------------------
    AddRoom("deeprainforest_gas", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.45, -- .45
            distributeprefabs = {
                rainforesttree_rot = 4,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                poisonmist = 8,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            }
        }
    })

    AddRoom("deeprainforest_gas_entrance6", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.45, -- .45
            distributeprefabs = {
                rainforesttree_rot = 4,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                poisonmist = 8,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            },
            countprefabs = {
                maze_pig_ruins_entrance6 = 1
            }
        }
    })

    AddRoom("deeprainforest_gas_flytrap_grove", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_head"] = 1,
                ["pig_ruins_artichoke"] = 1
            },
            distributepercent = 0.5, -- .45
            distributeprefabs = {
                rainforesttree_rot = 2,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                -- mistarea = 6,	
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
            }
        }
    })

    AddRoom("BG_rainforest_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = .38, -- .5
            distributeprefabs = {
                rainforesttree = 0.6, -- 1.4,
                grass_tall = .5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                dungpile = 0.03,
                fireflies = 0.05,
                peagawk = 0.01,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                --										randomdust = 0.005,										
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                foliage = 1
            }
        }
    })

    AddRoom("rainforest_ruins", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = .35, -- .5
            distributeprefabs = {
                rainforesttree = .5, -- .7,
                grass_tall = 0.5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                vampirebatcave_potential = 1,
                peekhenspawner = 2
            }
        }
    })

    AddRoom("rainforest_ruins_entrance", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = .35, -- .5
            distributeprefabs = {
                rainforesttree = .5, -- .7,
                grass_tall = 0.5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                peekhenspawner = 2
            }
        }
    })

    AddRoom("BG_deeprainforest_base", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.5,
            distributeprefabs = {
                rainforesttree = 2, -- 4,
                tree_pillar = 0.5, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                --										hanging_vine_patch = 0.1,	
                pig_ruins_torch = 0.02,
                --										mean_flytrap = 0.05,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                vampirebatcave_potential = 1
            }

        }
    })

    AddRoom("deeprainforest_spider_monkey_nest", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 3, -- 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                spider_monkey_tree = 1,
                spider_monkey = 1
                --					                	hanging_vine_patch = 1,
            }
        }
    })

    AddRoom("deeprainforest_flytrap_grove", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["nettlegrove"] = function()
                    if math.random(1, 10) > 7 then
                        return 1
                    end
                    return 0
                end
            },
            distributepercent = 0.25,
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
                --					                	hanging_vine_patch = math.random(0,2),
            }
        }
    })

    AddRoom("deeprainforest_flytrap_grove_PigRuinsEntrance5", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(6, 11),
                --					                	adult_flytrap = math.random(2, 6),
                --					                	hanging_vine_patch = math.random(0,2)
            }
        }
    })

    AddRoom("deeprainforest_fireflygrove", {
        colour = {
            r = 1,
            g = 1,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- 0.25, --.3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 5,
                --										hanging_vine_patch = 0.1,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                fireflies = math.random(5, 10)
            }
        }
    })

    AddRoom("deeprainforest_ruins_entrance", {
        colour = {
            r = 1,
            g = 0.1,
            b = 0.2,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {}

        }
    })

    AddRoom("deeprainforest_ruins_entrance2", {
        colour = {
            r = 1,
            g = 0.1,
            b = 0.2,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {}

        }
    })

    AddRoom("deeprainforest_ruins_exit", {
        colour = {
            r = 0.2,
            g = 0.1,
            b = 1,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {}

        }
    })

    AddRoom("deeprainforest_ruins_exit2", {
        colour = {
            r = 0.2,
            g = 0.1,
            b = 1,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["nettlegrove"] = 1
            },
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                -- 	pig_ruins_torch = 3,
                -- 	pig_ruins_exit = 1,
                -- 	pig_ruins_head = 1,					                	
            }

        }
    })

    AddRoom("deeprainforest_anthill", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                anthill = 1
                --					                	pighead = 4,
            }

        }
    })
    AddRoom("deeprainforest_mandrakeman", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["mandraketown"] = 1
            },
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                mandrakehouse = 2
            }

        }
    })
    AddRoom("deeprainforest_anthill_exit", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_entrance_5"] = GetModConfigData("pigruins")
            },
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            }

        }
    })

    AddRoom("deeprainforest_anthill_exit2", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "hamlet", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                maze_anthillentradarainha = GetModConfigData("anthill"),
                underwater_entrance2 = 1
            }

        }
    })

    ----------------------------------------------------------- plain room--------------------------------------------------------------------------------------------------
    AddRoom("BG_plains_inicio", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "Chester_Eyebone", "hamlet"},
        contents = {
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            }
        }
    })

    AddRoom("BG_plains_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy"] = 1,
                ["pig_ruins_nocanopy_2"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pugalisk_fountain"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1,
                vampirebatcave_entrance_roc = 1,
                gravestone = 5
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy2", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy_3"] = 1,
                ["pig_ruins_nocanopy_4"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("BG_plains_base_nocanopy3", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy_4"] = 1,
                ["pig_ruins_nocanopy"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("plains_tallgrass", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .15, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("plains_ruins", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("plains_ruins_set", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("plains_pogs", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            },
            countprefabs = {
                pog = 2
            }
        }
    })

    AddRoom("plains_pogs_ruin", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison", "hamlet"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            },
            countprefabs = {
                pog = 2
            }
        }
    })

    --------------------------------------------------main hamlet------------------------------------------------------------------
    fazendas = {
        [1] = "farm_1",
        [2] = "farm_2",
        [3] = "farm_3",
        [4] = "farm_4",
        [5] = "farm_5"
    }

    AddRoom("MAINBG_cultivated_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            }
        }
    })

    AddRoom("MAINcultivated_base_1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },

            countprefabs = {
                crabapple_tree = 4

            },
            countstaticlayouts = {
                ["farm_1"] = 1
            }
        }
    })

    AddRoom("MAINcultivated_base_2", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },

            countprefabs = {
                crabapple_tree = 4
            },

            countstaticlayouts = {
                ["farm_2"] = 1
            }
        }
    })

    AddRoom("MAINcultivated_base_3", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                ["farm_3"] = 1
            }
        }
    })

    AddRoom("MAINcultivated_base_4", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                ["farm_4"] = 1
            }

        }
    })

    AddRoom("MAINcultivated_base_5", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = 0.06, ---0.1
            distributeprefabs = {
                -- 			grass = 0.05,
                --			flower = 0.3,
                rock1 = 0.01,
                teatree = 0.1
                --			peekhenspawner = 0.003,
            },
            countstaticlayouts = {
                ["farm_5"] = 1
            }

        }
    })

    AddRoom("MAINpiko_land", {
        colour = {
            r = 1.0,
            g = 0.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.FIELDS,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = 0.06, -- 0.1
            distributeprefabs = {
                --	grass = 0.05,
                --	flower = 0.3,
                rock1 = 0.01,
                teatree = 2.0
            },
            countprefabs = {
                teatree_piko_nest_patch = 1
            }
        }

    })

    ----------------------------------------------------------- painted room--------------------------------------------------------------------------------------------------
    ----------------------------------------------------------- battlegrounds room--------------------------------------------------------------------------------------------------
    AddRoom("MAINBG_battleground_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("MAINbattleground_ribs", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_ribs = 1,
                vampirebatcave_potential = 1,
                maze_cave_roc_entrance = 1
            }
        }
    })
    AddRoom("MAINbattleground_claw", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_claw = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("MAINbattleground_claw1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_claw = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("MAINbattleground_leg", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_leg = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("MAINbattleground_leg1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_leg = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    AddRoom("MAINbattleground_head", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.DIRT,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            --					countstaticlayouts={["CaveEntrance"]=1},
            distributepercent = .22, -- .22, --.26
            distributeprefabs = {
                rainforesttree = 0.1,
                flower = 0.7,
                meteor_impact = 0.5,
                charcoal = 0.5,
                rainforesttree_burnt = 1,

                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                ancient_robot_head = 1,
                vampirebatcave_potential = 1
            }
        }
    })

    AddRoom("MAINBG_painted_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PAINTED,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .15, -- .26
            distributeprefabs = {
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.2,
                thunderbirdnest = 0.1,
                sedimentpuddle = 0.1,
                pangolden = 0.005
            },
            countprefabs = {
                pangolden = 1,
                vampirebatcave_potential = 1
            }
        }
    })
    -------------------------------------------room deep florest hamlet-------------------------------------------
    AddRoom("MAINdeeprainforest_gas", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.45, -- .45
            distributeprefabs = {
                rainforesttree_rot = 4,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                poisonmist = 8,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            }
        }
    })

    AddRoom("MAINdeeprainforest_gas_entrance6", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.45, -- .45
            distributeprefabs = {
                rainforesttree_rot = 4,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                poisonmist = 8,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            },
            countprefabs = {
                maze_pig_ruins_entrance6 = 1,
                vampirebatcave_entrance_roc = 1
            }
        }
    })

    AddRoom("MAINdeeprainforest_gas_flytrap_grove", {
        colour = {
            r = 1,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.GASJUNGLE,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_head"] = 1,
                ["pig_ruins_artichoke"] = 1
            },
            distributepercent = 0.5, -- .45
            distributeprefabs = {
                rainforesttree_rot = 2,
                tree_pillar = 0.5,
                nettle = 0.12,
                red_mushroom = 0.3,
                green_mushroom = 0.3,
                blue_mushroom = 0.3,
                --	berrybush = 1,
                --										lightrays_jungle = 1.2,
                -- mistarea = 6,	
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
            }
        }
    })

    AddRoom("MAINBG_rainforest_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = .38, -- .5
            distributeprefabs = {
                rainforesttree = 0.6, -- 1.4,
                grass_tall = .5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                dungpile = 0.03,
                fireflies = 0.05,
                peagawk = 0.01,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                --										randomdust = 0.005,										
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                foliage = 1
            }
        }
    })

    AddRoom("MAINrainforest_ruins", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = .35, -- .5
            distributeprefabs = {
                rainforesttree = .5, -- .7,
                grass_tall = 0.5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                vampirebatcave_potential = 1,
                peekhenspawner = 2
            }
        }
    })

    AddRoom("MAINrainforest_ruins_entrance", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.RAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = .35, -- .5
            distributeprefabs = {
                rainforesttree = .5, -- .7,
                grass_tall = 0.5,
                sapling = .6,
                flower_rainforest = 0.1,
                flower = 0.05,
                --	randomrelic = 0.008,
                --	randomruin = 0.005,	
                randomdust = 0.005,
                rock_flippable = 0.08,
                radish_planted = 0.05,
                asparagus_planted = 0.05
            },
            countprefabs = {
                peekhenspawner = 2
            }
        }
    })

    AddRoom("MAINBG_deeprainforest_base", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.5,
            distributeprefabs = {
                rainforesttree = 2, -- 4,
                tree_pillar = 0.5, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                --										hanging_vine_patch = 0.1,	
                pig_ruins_torch = 0.02,
                --										mean_flytrap = 0.05,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                vampirebatcave_potential = 1
            }

        }
    })

    AddRoom("MAINdeeprainforest_spider_monkey_nest", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 3, -- 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                spider_monkey_tree = 1,
                spider_monkey = 1
                --					                	hanging_vine_patch = 1,
            }
        }
    })

    AddRoom("MAINdeeprainforest_flytrap_grove", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            countstaticlayouts = {
                ["nettlegrove"] = function()
                    if math.random(1, 10) > 7 then
                        return 1
                    end
                    return 0
                end
            },
            distributepercent = 0.25,
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                randomrelic = 0.02,
                randomruin = 0.02,
                randomdust = 0.02,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(10, 15),
                --					                	adult_flytrap = math.random(3, 7),
                --					                	hanging_vine_patch = math.random(0,2),
            }
        }
    })

    AddRoom("MAINdeeprainforest_flytrap_grove_PigRuinsEntrance5", {
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                --					                	mean_flytrap = math.random(6, 11),
                --					                	adult_flytrap = math.random(2, 6),
                --					                	hanging_vine_patch = math.random(0,2)
            }
        }
    })

    AddRoom("MAINdeeprainforest_fireflygrove", {
        colour = {
            r = 1,
            g = 1,
            b = 0.2,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- 0.25, --.3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1, -- 0.5,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 5,
                --										hanging_vine_patch = 0.1,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                fireflies = math.random(5, 10)
            }
        }
    })

    AddRoom("MAINdeeprainforest_ruins_entrance", {
        colour = {
            r = 1,
            g = 0.1,
            b = 0.2,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {}

        }
    })

    AddRoom("MAINdeeprainforest_ruins_entrance2", {
        colour = {
            r = 1,
            g = 0.1,
            b = 0.2,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {}

        }
    })

    AddRoom("MAINdeeprainforest_ruins_exit", {
        colour = {
            r = 0.2,
            g = 0.1,
            b = 1,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {}

        }
    })

    AddRoom("MAINdeeprainforest_ruins_exit2", {
        colour = {
            r = 0.2,
            g = 0.1,
            b = 1,
            a = 0.5
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            countstaticlayouts = {
                ["nettlegrove"] = 1
            },
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },
            countprefabs = {
                -- 	pig_ruins_torch = 3,
                -- 	pig_ruins_exit = 1,
                -- 	pig_ruins_head = 1,					                	
            }

        }
    })

    AddRoom("MAINdeeprainforest_anthill", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                anthill = 1
                --					                	pighead = 4,
            }

        }
    })
    AddRoom("MAINdeeprainforest_mandrakeman", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            countstaticlayouts = {
                ["mandraketown"] = 1
            },
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                mandrakehouse = 2
            }

        }
    })
    AddRoom("MAINdeeprainforest_anthill_exit", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_entrance_5"] = GetModConfigData("pigruins")
            },
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            }

        }
    })

    AddRoom("MAINdeeprainforest_anthill_exit2", {
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 0.3
        },
        value = GROUND.DEEPRAINFOREST,
        tags = {"ExitPiece", "RoadPoison", "folha"},
        contents = {
            distributepercent = 0.25, -- .3
            distributeprefabs = {
                rainforesttree = 4,
                tree_pillar = 1,
                nettle = 0.12,
                flower_rainforest = 1,
                --										lightrays_jungle = 1.2,								
                deep_jungle_fern_noise = 1,
                jungle_border_vine = 0.5,
                fireflies = 0.2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1,
                radish_planted = 0.5
            },

            countprefabs = {
                maze_anthillentradarainha = GetModConfigData("anthill"),
                underwater_entrance2 = 1
            }

        }
    })

    ----------------------------------------------------------- plain room--------------------------------------------------------------------------------------------------
    AddRoom("MAINBG_plains_inicio", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "Chester_Eyebone"},
        contents = {
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            }
        }
    })

    AddRoom("MAINBG_plains_base", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("MAINBG_plains_base_nocanopy", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy"] = 1,
                ["pig_ruins_nocanopy_2"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("MAINBG_plains_base_nocanopy1", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["pugalisk_fountain"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1,
                vampirebatcave_entrance_roc = 1,
                gravestone = 5
            }
        }
    })

    AddRoom("MAINBG_plains_base_nocanopy2", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy_3"] = 1,
                ["pig_ruins_nocanopy_4"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("MAINBG_plains_base_nocanopy3", {
        colour = {
            r = 1.0,
            g = 1.0,
            b = 1.0,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["pig_ruins_nocanopy_4"] = 1,
                ["pig_ruins_nocanopy"] = 1
            },
            distributepercent = .25, -- .22, --.26
            distributeprefabs = {
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                dungpile = 0.03,
                peagawk = 0.01,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("MAINplains_tallgrass", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .15, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                --		randomrelic = 0.0016,
                -- randomruin = 0.0025,	
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("MAINplains_ruins", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("MAINplains_ruins_set", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                grass_tall_patch = 2,
                grass_tall_infested = 1
            }
        }
    })

    AddRoom("MAINplains_pogs", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            },
            countprefabs = {
                pog = 2
            }
        }
    })

    AddRoom("MAINplains_pogs_ruin", {
        colour = {
            r = 0.0,
            g = 1,
            b = 0.3,
            a = 0.3
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .25, -- .15, -- .3
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05
            },
            countprefabs = {
                pog = 2
            }
        }
    })
    ---------------------------------------------------------------------------TASK ORIGINAL VOLCANO--------------------------------------------------------------
    AddTask("TIDALMARSH_TASK_FOREST", {
        locks = {LOCKS.GREEN},
        keys_given = {KEYS.GREEN},
        room_choices = {
            ["TidalMarsh"] = 1,
            ["TidalSharkHome"] = 1,
            ["TidalMermMarsh"] = 1
        },
        --	entrance_room = "TidalMarsh",
        room_bg = GROUND.TIDALMARSH,
        background_room = "TidalMarsh",
        colour = {
            r = 1,
            g = 0,
            b = 0.6,
            a = 1
        }
    })

    -----------------------------------------------------------

    AddTask("VOLCANO_TASK_FOREST", {
        locks = {LOCKS.BATS},
        keys_given = {KEYS.BATS},
        room_choices = {
            ["VolcanoRock"] = 1,
            ["VolcanoStart"] = 1,
            ["VolcanoAsh"] = 1,
            ["VolcanoNoise"] = 1
        },
        --	entrance_room = "Magmadragoon",
        room_bg = GROUND.VOLCANO,
        background_room = "VolcanoNoise",
        colour = {
            r = 1,
            g = 0,
            b = 0.6,
            a = 1
        }
    })

    -----------------------------------------------------------

    AddTask("BEACH_TASK_FOREST", {
        locks = {LOCKS.PASSAGE},
        keys_given = {KEYS.PASSAGE},
        room_choices = {
            ["BeachShells"] = 1,
            ["BeachPiggy"] = 1,
            ["BeachPalmForest"] = 2,
            ["DoydoyBeach"] = 1,
            ["JungleDenseMed"] = 1,
            ["BeachPalmCasino"] = 1,
            ["DoyDoyM"] = 1
        },

        --	entrance_room = "BeachSandHome",
        room_bg = GROUND.BEACH,
        background_room = "BeachSandHome",
        colour = {
            r = 1,
            g = 0,
            b = 0.6,
            a = 1
        }
    })

    --------------------------------------------------
    AddTask("JUNGLE_TASK_FOREST", {
        locks = {LOCKS.TREES, LOCKS.TIER2},
        keys_given = {KEYS.PIGS, KEYS.WOOD, KEYS.MEAT, KEYS.TIER2},
        room_choices = {
            ["JungleDense"] = 1,
            ["JungleDenseHome"] = 1,
            ["TidalMarsh1"] = 1,
            ["JungleDenseCritterCrunch"] = 1,
            ["JunglePigs"] = 1,
            ["DoydoyBeach1"] = 1,
            ["DoyDoyF"] = 1,
            ["PigVillagesw"] = 1
        },
        room_bg = GROUND.JUNGLE,
        background_room = "Jungle",
        colour = {
            r = 1,
            g = 0,
            b = 0.6,
            a = 1
        }
    })
    --------------------------------------------------------
    AddTask("MEADOW_TASK_FOREST", {
        locks = {LOCKS.BASIC_COMBAT, LOCKS.TIER2},
        keys_given = {KEYS.POOP, KEYS.WOOL, KEYS.WOOD, KEYS.GRASS, KEYS.TIER2},
        room_choices = {
            ["Beaverkinghome"] = 2,
            ["Beaverkingcity"] = 1
        },
        room_bg = GROUND.MEADOW,
        background_room = "Beaverkingcity",
        colour = {
            r = 1,
            g = 0,
            b = 0.6,
            a = 1
        }
    })
    ----------------------------------------------
    AddTask("MAGMAFIELD_TASK_FOREST", {
        locks = {LOCKS.TIER3, LOCKS.ADVANCED_COMBAT},
        keys_given = {KEYS.TIER4},
        room_choices = {
            ["Magma"] = 1,
            ["MagmaVolcano"] = 1,
            ["MagmaGold"] = 2,
            ["MagmaGoldmoon"] = 1,
            ["MagmaGoldBoon"] = 2
        },
        --	entrance_room = "Magmadragoon",
        room_bg = GROUND.MAGMAFIELD,
        background_room = "MagmaForest",
        colour = {
            r = 1,
            g = 0,
            b = 0.6,
            a = 1
        }
    })

    -------------------------------------------------------- SW PLUS ---------------------------------------------------------
    AddRoom("strange_island_eldorado", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["eldorado"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                fireflies = 0.1,
                tree_forest_deep = 1,
                roc_nest_tree1 = 0.5,
                roc_nest_tree2 = 0.5,
                roc_nest_bush = 0.5,
                goldnugget = 1,
                berrybush2 = .1,
                flower = .05,
                --										bambootree = 0.5,
                --										bush_vine = .1,
                is_goldobi = .1,
                s_goldobi = .1
            },

            countprefabs = {
                tidalpool = 3
            }

        }
    })

    AddRoom("snapdragonforest", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"RoadPoison", "tropical"},
        contents = {
            --					countstaticlayouts={["vacation"]=1},					
            distributepercent = .2,
            distributeprefabs = {
                fireflies = 0.1,
                tree_forest_deep = 1,
                roc_nest_tree1 = 0.5,
                roc_nest_tree2 = 0.5,
                roc_nest_bush = 0.5,
                goldnugget = 1,
                berrybush2 = .1,
                flower = .05,
                --										bambootree = 0.5,
                --										bush_vine = .1,
                is_goldobi = .1,
                s_goldobi = .1
            },

            countprefabs = {
                snapdragon = 6
            }
        }
    })

    AddRoom("snapdragonforestback", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"RoadPoison", "tropical"},
        contents = {
            --					countstaticlayouts={["vacation"]=1},					
            distributepercent = .2,
            distributeprefabs = {
                fireflies = 0.1,
                tree_forest_deep = 1,
                roc_nest_tree1 = 0.5,
                roc_nest_tree2 = 0.5,
                roc_nest_bush = 0.5,
                goldnugget = 1,
                berrybush2 = .1,
                flower = .05,
                --										bambootree = 0.5,
                --										bush_vine = .1,
                is_goldobi = .1,
                s_goldobi = .1
            },

            countprefabs = {}
        }
    })

    AddRoom("strange_island_walrusvacation", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["vacation"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                sapling = 0.25,
                grass = .5,
                palmtree = .1,
                wildborehouse = .05,
                limpetrock = 0.1,
                sandhill = .3,
                seashell_beached = .125
            },

            countprefabs = {}

        }
    })

    AddRoom("strange_island_tikitribe", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.RAINFOREST,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["tikitribe"] = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                fireflies = 0.1,
                tree_forest = .5,
                berrybush2 = .1,
                flower = .05,
                grass_tall = 0.25,
                cave_banana_tree = .1,
                marsh_bush = .1
            },

            countprefabs = {
                tikistick = math.random(2, 5)
            }

        }
    })
    AddRoom("strange_island_tikitribe2", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.RAINFOREST,
        tags = {"RoadPoison", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                fireflies = 0.1,
                tree_forest = .5,
                berrybush2 = .1,
                flower = .05,
                grass_tall = 0.25,
                cave_banana_tree = .1,
                marsh_bush = .1
            },

            countprefabs = {
                tikistick = math.random(2, 5)
            }

        }
    })

    AddRoom("JungleDense_plus", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.RAINFOREST,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > 0.9 and 1) or 0
                end
            },
            distributepercent = 0.4,
            distributeprefabs = {
                fireflies = 0.02, -- was 0.2,
                tree_forest = 3, -- was 4,
                rock1 = 0.05,
                rock2 = 0.1, -- was .05
                -- grassnova = 1, --was .05
                -- saplingnova = .8,
                berrybush2 = .1,
                berrybush2_snake = 0.04,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .05,
                flower = 0.75,
                grass_tall = 1,
                flint = 0.1,
                spider_monkey_tree = .1, -- was .01
                marsh_bush = 1,
                snake_hole = 0.1,
                -- wildborehouse = 0.03, --was 0.015,
                --					                    primeapebarrel_plus = .2,
                cave_banana_tree = 0.01
            }
        }
    })

    ---------------------------------------------------------------------------------------------------
    AddRoom("NoOxMeadow", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .4, -- .1, --lowered from .2
            distributeprefabs = {
                flint = 0.01,
                grassnova = .4,
                -- ox = 0.05,
                sweet_potato_planted = 0.05,
                beehive = 0.003,
                wasphive = 0.003,
                rocks = 0.003,
                rock_flintless = 0.01,
                flower = .25
            }
        }
    })

    AddRoom("MeadowOxBoon", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .4, -- was .1,
            distributeprefabs = {
                --    ox = .5, --was 1,
                grassnova = 1,
                flower = .5,
                beehive = 0.1,
                wasphive = 0.003
            }
        }
    })

    AddRoom("MeadowFlowery", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .5, -- .1, --lowered from .2
            distributeprefabs = {
                flower = .5,
                beehive = .05, -- was .4
                grassnova = .4,
                rocks = .05,
                mandrake_planted = 0.005
            }
        }
    })

    AddRoom("MeadowBees", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .4, -- .1, --lowered from .2
            distributeprefabs = {
                flint = 0.05, -- was .01
                grassnova = 3, -- was .4,
                -- ox = 3,
                sweet_potato_planted = 0.1, -- was .05,
                rock_flintless = 0.01,
                flower = 0.15,
                beehive = 0.2, -- lowered from 1
                wasphive = 0.05
            }
        }
    })

    AddRoom("MeadowCarroty", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .35, -- was .1
            distributeprefabs = {
                sweet_potato_planted = 1,
                grassnova = 1.5,
                rocks = .2,
                flower = .5
            }
        }
    })

    --[[AddRoom("MeadowWetlands", {
					colour={r=.8,g=.4,b=.4,a=.50},
					value = GROUND.MEADOW,
					tags = {"ExitPiece", "RoadPoison", "tropical"},
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                    --pond = 1,
					                    pond_mos = .8,
					                    grassnova = .5,
					                    flower = .3,
					                    saplingnova = .2,
					                    sweet_potato_planted = .1,  
					                },
					            }
					})
]]
    AddRoom("MeadowSappy", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                grassnova = 3,
                -- saplingnova = 1,
                flower = .5,
                beehive = .1, -- was 1,
                sweet_potato_planted = 0.3,
                wasphive = 0.01 -- was 0.001
            }
        }
    })

    AddRoom("MeadowSpider", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            distributepercent = .4, -- was .2
            distributeprefabs = {
                spiderden = .1,
                grassnova = 1,
                -- saplingnova = .8,
                -- ox = .5,
                flower = .5
            }
        }
    })

    AddRoom("MeadowRocky", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {

            distributepercent = .4, -- was .1,
            distributeprefabs = {
                rock_flintless = 1,
                rocks = 1,
                rock1 = 1,
                rock2 = 1,
                grassnova = 4, -- was 2
                flower = 1
            }
        }
    })

    AddRoom("MeadowMandrake", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                grassnova = .8,
                -- saplingnova = .8,
                sweet_potato_planted = 0.05,
                rocks = 0.003,
                rock_flintless = 0.01,
                flower = .25
            },
            countprefabs = {
                mandrake_planted = math.random(1, 2)
            }
        }
    })

    -- Forest-magma-------------------------------------------------------------------------------------------------------------

    AddRoom("Magma", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                magmarock = 2, -- nitre
                magmarock_gold = 1,
                rock1 = .25,
                rock2 = .25, -- gold 
                rocks = .25,
                flint = 0.5, -- lowered from 3
                spiderden = .1
                -- saplingnova = 1.0,
            }
        }
    })

    AddRoom("MagmaHome", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                magmarock_gold = 2,
                magmarock = 2,
                rock1 = .2, -- nitre
                -- rock2 = 2, --gold
                rock_flintless = 1,
                rocks = .25, -- was 0.5
                flint = 0.1, -- lowered from 3
                -- rock_ice = 1,
                -- tallbirdnest= --2, --.1,
                spiderden = .1
                -- saplingnova = 0.5,

            },

            countprefabs = {
                flint = 4
            }
        }
    })

    AddRoom("MagmaHomeBoon", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                -- rock1 = 2, --nitre
                rock2 = 1, -- gold
                rock_flintless = 2,
                rocks = .25,
                flint = 1, -- lowered from 3
                -- rock_ice = 1,
                -- tallbirdnest= --2, --.1,
                spiderden = .1,
                saplingnova = 0.5
            },

            countprefabs = {
                flint = 4
            }
        }
    })

    AddRoom("BG_Magma", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                flint = 0.5,
                rock1 = 0.2,
                rock2 = 1,
                rocks = 25,
                tallbirdnest = 0.08,
                saplingnova = 1.5,
                spiderden = .1
            }
        }
    })

    AddRoom("GenericMagmaNoThreat", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                magmarock = 2,
                magmarock_gold = 1,
                rock1 = 0.3,
                rock2 = 0.3,
                -- rock_ice = .75,
                rocks = .25,
                flint = 1.5,
                saplingnova = .05,
                blue_mushroom = .002,
                green_mushroom = .002,
                red_mushroom = .002,
                spiderden = .1
            }
        }
    })

    AddRoom("MagmaVolcano", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                rock1 = 2,
                rock2 = 2,
                rocks = .25,
                flint = 0.,
                -- saplingnova = .5,
                spiderden = .1
            }

        }
    })

    AddRoom("Volcano", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison", "tropical"},
        --					required_prefabs = {"volcano"},
        contents = {
            --									countstaticlayouts={["Entradavulcao"]=1}, --adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .3,
                rock_charcoal = .3,
                volcano_shrub = .2,
                charcoal = 0.04,
                skeleton = 0.1
            },

            countprefabs = {
                volcanofog = math.random(1, 2),
                volcano = function()
                    if GetModConfigData("Volcano") == false then
                        return 1
                    else
                        return 0
                    end
                end,
                cave_entrance_vulcao = function()
                    if GetModConfigData("Volcano") == true then
                        return 1
                    else
                        return 0
                    end
                end
            },

            prefabdata = {
                magmarock = {
                    regen = true
                },
                magmarock_gold = {
                    regen = true
                }
            }
        }
    })

    AddRoom("Volcanofundo", {
        colour = {
            r = 0.8,
            g = .8,
            b = .1,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison", "tropical"},
        contents = {
            --						     green_mushroom = .05,
            --					         reeds =  2,
            countprefabs = {}
        }
    })

    AddRoom("Magmadragoon", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = 0.2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                rock1 = 0.1, -- nitre
                rock2 = 0.1, -- gold
                rock_flintless = 0.4,
                rocks = 0.4,
                flint = 0.2, -- lowered from 3
                --  tallbirdnest= .2, --.1,
                --					                    dragoonden= 0.7,
                saplingnova = .3

            },
            countprefabs = {
                dragoonden = 4,
                rock_moon = 2
            }
        }
    })

    AddRoom("MagmaGold", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 0.8,
                magmarock_gold = 1, -- gold
                rock1 = 0.5,
                rock2 = 0.3,
                rock_flintless = .1,
                rocks = 0.4,
                flint = .1,
                rock_moon = 0.1,
                goldnugget = .25,
                tallbirdnest = .2,
                saplingnova = .5,
                spiderden = .1
            }
        }
    })

    AddRoom("MagmaGoldmoon", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            --									countstaticlayouts={["CaveEntrance"]=1}, --adds 1 per room					
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 0.8,
                magmarock_gold = 1, -- gold
                rock1 = 0.5,
                rock2 = 0.3,
                rock_flintless = .1,
                rocks = 0.4,
                flint = .1,
                rock_moon = 0.1,
                goldnugget = .25,
                tallbirdnest = .2,
                saplingnova = .5,
                spiderden = .1
            },
            countprefabs = {
                rock_moon_shell = 1,
                meteorspawner = 2
            }
        }
    })

    AddRoom("MagmaGoldBoon", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock_gold = 1,
                rock1 = 0.5,
                rock2 = 0.3,
                rocks = 3,
                flint = 1,
                goldnugget = 1,
                tallbirdnest = .1,
                rock_moon = 2
                -- saplingnova = .5,
                -- spiderden= .1,
            }
        }
    })

    AddRoom("MagmaTallBird", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.75,
                rock1 = 0.5,
                rock2 = 0.3,
                rocks = 1,
                rock_moon = 0.1,
                rock_flintless = 1,
                tallbirdnest = .25,
                -- saplingnova = .5,
                spiderden = .1
            }
        }
    })

    AddRoom("MagmaForest", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.25,
                rock1 = 0.5,

                rock2 = 0.3,
                obsidian = .02,
                -- elephantcactus = 0.2,
                rocks = 2,
                rock_flintless = 1,
                rock_moon = 0.1,
                jungletree = 0.5,
                saplingnova = 2,
                spiderden = .15
            },

            prefabdata = {
                jungletree = {
                    burnt = true
                }
            }
        }
    })

    AddRoom("MagmaSpiders", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"ExitPiece", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 2,
                magmarock_gold = 1,
                rock1 = 2, -- nitre
                rock2 = 2, -- gold
                rock_flintless = 2,
                rocks = 1,
                rock_moon = 0.1,
                flint = 1, -- lowered from 3
                -- rock_ice = 1,
                tallbirdnest = .2, -- .1,
                spiderden = 1.5, -- .5,
                sapling = .5

            }
        }
    })
    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Forest-volcano-------------------------------------------------------------------------------------------------------------

    AddRoom("VolcanoRock", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison", "tropical"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                flint = .5,
                obsidian = .02,
                -- rocks = 1,
                charcoal = 0.04,
                skeleton = 0.25
                -- elephantcactus = 0.3,

                -- coffeebush = 0.25,
                -- dragoonden = .2,
            },

            countprefabs = {
                -- palmtree = math.random(8, 16),
                volcanofog = math.random(1, 2)
            }
        }
    })

    AddRoom("VolcanoAsh", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.ASH,
        tags = {"RoadPoison", "tropical"},
        contents = {
            distributepercent = .1,
            countstaticlayouts = {
                ["CoffeeBushBunch"] = 1
            }, -- adds 1 per room
            distributeprefabs = {
                -- rocks = 1,
                skeleton = 0.05,
                coffeebush = 0.04
                -- elephantcactus = 0.09,     
                -- dragoonden = .2,
            },

            countprefabs = {
                -- palmtree = math.random(4, 8),
                volcanofog = math.random(1, 2),
                coffeebush = 6,
                charcoal = 4,
                volcano_shrub = 3,
                elephantcactus = 5
            }
        }
    })

    AddRoom("VolcanoObsidian", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison", "tropical"},
        contents = {
            --									countstaticlayouts={["beaverking"]=1}, --adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .3,
                rock_charcoal = .3,
                volcano_shrub = .2,
                charcoal = 0.04,
                skeleton = 0.1,
                dragoonden = .05,
                elephantcactus = 0.1
                -- coffeebush = 1,
            },

            countprefabs = {
                volcanofog = math.random(1, 2)
            }
        }
    })

    AddRoom("VolcanoStart", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["Entradavulcao"] = 1
            }, -- adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .5,
                rock_charcoal = .5,
                volcano_shrub = .5,
                charcoal = 0.04,
                skeleton = 0.1
            },

            countprefabs = {
                volcanofog = math.random(1, 2),
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    AddRoom("VolcanoNoise", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["CoffeeBushBunch"] = function()
                    if math.random() < 0.25 then
                        return 1
                    else
                        return 0
                    end
                end
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .5,
                rock_charcoal = .5,
                volcano_shrub = .5,
                charcoal = 0.04,
                skeleton = 0.1,
                dragoonden = .05,
                elephantcactus = 1,
                coffeebush = 1
            },

            countprefabs = {
                volcanofog = math.random(1, 2)
            }
        }
    })

    AddRoom("VolcanoObsidianBench", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["ObsidianWorkbench"] = 1
            }, -- adds 1 per room
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                obsidian = .2,
                charcoal = 0.04,
                skeleton = 0.5
            },
            countprefabs = {
                volcanofog = math.random(1, 2),
                cavelight = 2,
                cavelight_small = 2,
                firetwister = 1
            }
        }
    })

    AddRoom("VolcanoAltar", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["volcano_altar"] = GetModConfigData("forge")
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                charcoal = 0.04,
                skeleton = 0.5
            },

            countprefabs = {
                volcanofog = math.random(1, 2),
                cavelight = 2,
                cavelight_small = 2
            }

        }
    })

    AddRoom("VolcanoLavaarena", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["lava_arena"] = GetModConfigData("forge")
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                charcoal = 0.04,
                skeleton = 0.5
            },

            countprefabs = {
                volcanofog = math.random(1, 2)
            }

        }
    })

    AddRoom("VolcanoCage", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["WoodlegsUnlock"] = 1
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                charcoal = 0.04,
                skeleton = 0.5,
                dragoonden = .2,
                coffeebush = 0.25
            },

            countprefabs = {
                volcanofog = 1,
                cavelight = 2,
                cavelight_small = 2
            }
        }
    })

    AddRoom("VolcanoLava", {
        colour = {
            r = 1.0,
            g = 0.55,
            b = 0,
            a = .50
        },
        value = GROUND.IMPASSABLE,
        type = "blank",
        tags = {},
        contents = {
            distributepercent = 0,
            distributeprefabs = {}
        }
    })

    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Forest-tidalmarsh-------------------------------------------------------------------------------------------------------------					

    AddRoom("TidalMarsh", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = 0.4,
            distributeprefabs = {
                jungletree = .05,
                marsh_bush = .05,
                --					                    tidalpool = 0.08,										
                reeds = 1,
                spiderden = .01,
                green_mushroom = 1,
                --					                    mermhouse = 0.01, --was 0.04
                mermfishhouse = 0.05,
                poisonhole = 0.15,
                --					                    seaweed_planted = 0.5,
                --					                    fishinhole = .1,
                flupspawner = 0.7,
                flup = 1
            },
            countprefabs = {
                -- mermfishhouse = 5,
                tidalpool = 2,
                mermfishhouse = 2,
                reeds = 3,
                --										mermhouse = 2,
                poisonhole = 3
            }
        }
    })

    AddRoom("TidalMarsh1", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = 0.4,
            distributeprefabs = {
                jungletree = .01,
                -- marsh_bush = .05,
                reeds = 1,
                -- spiderden=.01,
                poisonhole = 0.5,
                green_mushroom = 0.4,
                --                                        mermhouse = 0.2,
                --                                        mermfishhouse = 1.0,
                --                                        tidalpool = 0.8,
                -- poisonhole = 0.1,
                --                                        seaweed_planted = 0.5,
                --                                        fishinhole = .1,
                flupspawner_sparse = 0.2
                --                                        flup = 1,
            },

            countprefabs = {
                mermfishhouse = 3,
                tidalpool = 3

            }
        }
    })

    AddRoom("TidalMermMarsh", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = 0.1,
            distributeprefabs = {
                jungletree = .05,
                marsh_bush = .05,
                reeds = 1,
                spiderden = .01,
                green_mushroom = 1.02,
                --					                    mermhouse = 0.2,
                --					                    mermfishhouse = 1.0,
                poisonhole = 0.2,
                --					                    seaweed_planted = 0.5,
                --					                    fishinhole = .1,
                flupspawner_sparse = 0.3
                --										tidalpool = 1,
                --					                    flup = 1,
            },

            countprefabs = {
                mermfishhouse = 2,
                tidalpool = 2,
                reeds = 6
            }
        }
    })

    AddRoom("TidalSharkHome", {
        colour = {
            r = 0.8,
            g = .8,
            b = .1,
            a = .50
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        --	required_prefabs = {"tigersharkpool"},
        contents = {
            green_mushroom = .05,
            reeds = 2,
            countstaticlayouts = {
                ["tigersharkarea"] = 1
            }, -- adds 1 per room
            countprefabs = {
                -- marsh_bush = 1,
                tidalpool = 3,
                reeds = 7,
                poisonhole = 5,
                mermfishhouse = 2,
                green_mushroom = 7
                -- tigersharkpool = 1,
                -- flupspawner = 3,
            }
        }
    })

    AddRoom("ToxicTidalMarsh", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = 0.2,
            distributeprefabs = {
                jungletree = .05,
                marsh_bush = .05,
                tidalpool = 0.2,
                reeds = 2, -- was 4
                spiderden = .01,
                green_mushroom = 1.02,
                mermhouse = 0.1, -- was 0.04
                mermfishhouse = 0.05,
                poisonhole = 1, -- was 2
                -- seaweed_planted = 0.5,
                fishinhole = .1,
                flupspawner_dense = 1,
                flup = 2
            }
        }
    })

    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Beach-------------------------------------------------------------------------------------------------------------					

    AddRoom("BeachSand", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                -- rock2 = .2,
                beehive = .01, -- was .05, 
                -- flower = .04, --trying
                grassnova = .2, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .01,
                crate = .01
            }

        }
    })

    AddRoom("BeachSandHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3, -- upped from .05
            distributeprefabs = {
                seashell_beached = .25,
                rock_limpet = .05,
                crabhole = .1, -- was 0.2
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .05,
                rock_flintless = .1, -- trying
                -- beehive = .05, --trying
                -- flower = .04, --trying
                grassnova = .5, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .1, -- was .6,
                crate = .025
            },

            countprefabs = {
                flint = 1,
                saplingnova = 1
            }

        }
    })

    AddRoom("BeachUnkept", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3, -- lowered from .3
            distributeprefabs = {
                seashell_beached = 0.125,
                grassnova = .3, -- down from 3
                saplingnova = .1, -- lowered from 15
                -- flower = 0.05,
                rock_limpet = .02,
                crabhole = .015, -- was .03
                palmtree = .1,
                rocks = .003,
                beehive = .003,
                flint = .02,
                sandhill = .05,
                -- rock2 = .01,
                dubloon = .001,
                wildborehouse = .007
            },
            countprefabs = {
                flint = 3,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                saplingnova = 3,
                grassnova = 3
                -- sandhill = .05,
            }

        }
    })
    AddRoom("BeachUnkeptInicio", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3, -- lowered from .3
            distributeprefabs = {
                seashell_beached = 0.125,
                grassnova = .3, -- down from 3
                saplingnova = .1, -- lowered from 15
                -- flower = 0.05,
                rock_limpet = .02,
                crabhole = .015, -- was .03
                palmtree = .1,
                rocks = .003,
                beehive = .003,
                flint = .02,
                sandhill = .05,
                -- rock2 = .01,
                dubloon = .001,
                wildborehouse = .007
            },
            countprefabs = {
                flint = 3,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                saplingnova = 6,
                grassnova = 6
                -- sandhill = .05,
            }

        }
    })
    AddRoom("BeachX", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["x_spot"] = 1
            },
            distributepercent = .3, -- lowered from .3
            distributeprefabs = {
                seashell_beached = 0.125,
                -- grassnova = .3, --down from 3
                -- saplingnova = .1, --lowered from 15
                -- flower = 0.05,
                rock_limpet = .02,
                -- crabhole = .015, --was .03
                palmtree = .1,
                -- rocks = .003,
                -- beehive = .003,
                -- flint = .02,
                sandhill = .05,
                -- rock2 = .01,
                dubloon = .001
                -- wildborehouse = .007,
            },
            countprefabs = {
                -- flint = 2,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                -- saplingnova = 3,
                -- grassnova = 3,
                -- sandhill = .05,
            }

        }
    })
    AddRoom("BeachUnkeptDubloon", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                seashell_beached = 0.025,
                grassnova = .1, -- was .3
                saplingnova = .05, -- was .15
                -- flower = 0.05,
                rock_limpet = .02,
                -- crabhole = .015, --was .03
                palmtree = .1,
                rocks = .003,
                -- beehive = .003,
                flint = .01, -- was .02,
                sandhill = .05,
                -- rock2 = .01,
                goldnugget = .007,
                dubloon = .01, -- this should be relatively high on this island
                skeleton = .025,
                wildborehouse = .005
            }

        }
    })

    AddRoom("BeachGravel", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                rock_limpet = 0.01,
                rocks = 0.1,
                flint = 0.02,
                rock1 = 0.05,
                -- rock2 = 0.05,
                rock_flintless = 0.05,
                grassnova = .05,
                -- flower = 0.05, --removed as it's used on NoFlower island
                sandhill = .05,
                seashell_beached = .025,
                wildborehouse = .005
            }
        }
    })

    AddRoom("BeachSinglePalmTreeHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                -- rock2 = .2,
                beehive = .01, -- was .05, 
                -- flower = .04, --trying
                grassnova = .2, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .01,
                crate = .01
            }

        }
    })

    AddRoom("DoydoyBeach1", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {

            distributepercent = .1,
            distributeprefabs = {
                flower_evil = 0.2,
                jungletree = 1, -- one palm tree
                fireflies = 1, -- results in an empty beach because these only show at night
                flower = .4,
                bambootree = 0.5, -- one palm tree
                bush_vine = 0.2 -- one palm tree
                -- sandhill = .5,
            },
            countprefabs = {
                -- doydoy = 1,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                -- beachresurrector = 1,
                -- sandhill = .05,
            }
        }
    })

    AddRoom("DoydoyBeach", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "ExitPiece", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_evil = 0.5,
                fireflies = 1, -- results in an empty beach because these only show at night
                flower = .3,
                palmtree = 1, -- one palm tree
                crabhole = 0.3, -- one palm tree
                sandhill = .05
            },
            countprefabs = {
                -- doydoy = 1,
                crate = 2,
                --	palmtree = 1, --one palm tree
                seashell_beached = 1 -- one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                -- beachresurrector = 1,
                -- sandhill = .05,
            }
        }
    })

    AddRoom("BeachWaspy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1, -- just copied this whole thing from EvilFlowerPatch in terrain_grass
            distributeprefabs = {
                flower_evil = 0.05,
                -- fireflies = .1, -- was 1, now .1 (results in an empty beach because these only show at night)
                wasphive = .005,
                sandhill = .05,
                rock_limpet = 0.01,
                flint = .005,
                seashell_beached = .025
            }

        }
    })

    AddRoom("BeachPalmForest", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                palmtree = .5,
                sandhill = .05,
                crabhole = .025,
                crate = 0.02,
                grassnova = .05,
                rock_limpet = .015,
                flint = .005,
                seashell_beached = .025,
                wildborehouse = .005
            }
        }
    })

    AddRoom("BeachPiggy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2, -- just copied this whole thing from EvilFlowerPatch in terrain_grass
            distributeprefabs = {
                saplingnova = 0.25,
                grassnova = .5,
                palmtree = .1,
                wildborehouse = .05,
                rock_limpet = 0.1,
                sandhill = .3,
                seashell_beached = .125
            }

        }
    })
    AddRoom("BeachCassino", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2, -- just copied this whole thing from EvilFlowerPatch in terrain_grass
            distributeprefabs = {
                saplingnova = 0.25,
                grassnova = .5,
                palmtree = .1,
                wildborehouse = .05,
                rock_limpet = 0.1,
                sandhill = .3,
                seashell_beached = .125
            }

        }
    })

    AddRoom("BeesBeach", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .3, -- Up from .025
            distributeprefabs = {
                seashell_beached = 0.025,
                rock_limpet = .05, -- reducing from .2 (everything is so low here)
                crabhole = .2,
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                beehive = .1, -- was .5
                wasphive = .05,
                -- flower = .04, --trying
                grassnova = .4, -- trying
                saplingnova = .4, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .4 -- was .04
            }

        }
    })

    AddRoom("BeachCrabTown", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = 0.005,
                crabhole = 1,
                saplingnova = .2,
                palmtree = .75,
                grassnova = .5,
                -- flower=.1,
                seashell_beached = .01,
                rocks = .1,
                rock1 = .2,
                -- fireflies=.1,
                -- spiderden=.001,
                flint = .01,
                sandhill = .3
            }

        }
    })

    AddRoom("BeachDunes", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                sandhill = 1.5,
                grassnova = 1,
                seashell_beached = .5,
                saplingnova = 1,
                rock1 = .5,
                rock_limpet = 0.1,
                wildborehouse = .05
            }

        }
    })

    AddRoom("BeachGrassy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},

        contents = {
            distributepercent = .2, -- was .1
            distributeprefabs = {
                grassnova = 1.5,
                rock_limpet = .25,
                beehive = .1,
                sandhill = 1,
                rock1 = .5,
                crabhole = .5,
                flint = .05,
                seashell_beached = .25
            }

        }
    })

    AddRoom("BeachSappy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                saplingnova = 1,
                crabhole = .5,
                palmtree = 1,
                rock_limpet = 0.1,
                flint = .05,
                seashell_beached = .25
            }

        }
    })

    AddRoom("BeachRocky", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                rock1 = 1,
                -- rock2 = 1, removing to take gold vein rocks out of all beaches
                rocks = 1,
                rock_flintless = 1,
                grassnova = 2,
                crabhole = 2,
                rock_limpet = 0.01,
                flint = .05,
                seashell_beached = .25,
                wildborehouse = .05
            }

        }
    })

    AddRoom("BeachLimpety", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                rock_limpet = 1,
                rock1 = 1,
                grassnova = 1,
                seashell = 1,
                saplingnova = .5,
                flint = .05,
                seashell_beached = .25,
                wildborehouse = .05
            }

        }
    })

    AddRoom("BeachSpider", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                rock_limpet = 0.01,
                spiderden = 0.5,
                palmtree = 1,
                grassnova = 1,
                rocks = 0.5,
                saplingnova = 0.2,
                flint = .05,
                seashell_beached = .25,
                wildborehouse = .025
            }

        }
    })

    AddRoom("BeachNoFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.0025,
                rock_limpet = .005, -- reducing from .03 (everything is so low here)
                crabhole = .002,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .005, -- trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055
            }

        }
    })

    AddRoom("BeachFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .5, -- was .1
            distributeprefabs = {
                beehive = .1, -- was .5
                flower = 2, -- was 1
                palmtree = .3,
                rock1 = .1,
                grassnova = .2,
                saplingnova = .1,
                seashell_beached = .025,
                rock_limpet = 0.01,
                flint = .05
            }

        }
    })

    AddRoom("BeachNoLimpets", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.0025,
                crabhole = .002,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .0025, -- trying
                -- flower = 0.04, --trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055,
                wildborehouse = .05
            }

        }
    })

    AddRoom("BeachNoCrabbits", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.0025,
                rock_limpet = 0.01,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .005, -- trying
                -- flower = 0.04, --trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055
            }

        }
    })

    AddRoom("BeachPalmCasino", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["slotmachine"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.025,
                rock_limpet = 0.01,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .005, -- trying
                -- flower = 0.04, --trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055
            },

            countprefabs = {
                packim_fishbone = 1,
                underwater_entrance1 = 1, -- function() if GLOBAL.KnownModIndex:IsModEnabled("Creep in the deeps TE") then return 1 end return 0 end,
                gravestone = 5
            }

        }
    })
    AddRoom("BeachShells", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                seashell_beached = 1.25,
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .025, -- was .1,
                -- rock2 = .05, --was .2,
                beehive = .02,
                -- flower = .04,
                grassnova = .3, -- was .2,
                saplingnova = .2,
                -- fireflies = .02,
                -- spiderden = .03,
                flint = .25,
                sandhill = .1, -- was .6,
                wildborehouse = .05
            },

            countprefabs = {
                -- beachresurrector = 1,
                crate = 5
                -- sharkittenspawner = 1,
            }

        }
    })
    AddRoom("BeachShark", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                seashell_beached = 1.25,
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .025, -- was .1,
                -- rock2 = .05, --was .2,
                beehive = .02,
                -- flower = .04,
                grassnova = .3, -- was .2,
                saplingnova = .2,
                -- fireflies = .02,
                -- spiderden = .03,
                flint = .25,
                sandhill = .1, -- was .6,
                wildborehouse = .05
            },

            countprefabs = {
                -- beachresurrector = 1,
                crate = 5
                -- sharkittenspawner = 1,
            }

        }
    })
    AddRoom("BeachShells1", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                seashell_beached = 1.25,
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .025, -- was .1,
                -- rock2 = .05, --was .2,
                beehive = .02,
                -- flower = .04,
                grassnova = .3, -- was .2,
                saplingnova = .2,
                -- fireflies = .02,
                -- spiderden = .03,
                flint = .25,
                sandhill = .1, -- was .6,
                wildborehouse = .05
            },

            countprefabs = {
                -- beachresurrector = 1,
                crate = 5
                -- sharkittenspawner = 1,
            }

        }
    })

    AddRoom("BeachSkull", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .1,
                beehive = .01,
                grassnova = .2,
                saplingnova = .2,
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .005,
                crate = 0.04
            }

        }
    })

    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Forest-jungle-------------------------------------------------------------------------------------------------------------									

    AddRoom("JunglePigs", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        --	required_prefabs = {"slipstor"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            -- countstaticlayouts={["DefaultPigking"]=1}, --adds 1 per room
            distributepercent = 0.3,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 3,
                rock1 = 0.05,
                flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .8,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05,
                bush_vine = 1,
                snake_hole = 0.1
                --					                    wildborehouse = 0.9, --was .015 and also was 2.15??
                -- wildborehouse=.05,
            },
            countprefabs = {
                -- doydoybaby = 1,
                -- doydoy = 1,
                primeapebarrel = 2
            }
        }
    })

    AddRoom("Beaverkinghome", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MEADOW,
        -- required_prefabs = {"octopusking"},
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            -- countstaticlayouts={["octopusking"]=1}, --adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                -- sweet_potato_planted = 0.5, 
                grassnova = 1,
                -- beehive = 0.003,
                rocks = 0.003,
                rock_flintless = 0.01,
                flower = .25
            },
            countprefabs = {
                mandrake_planted = 1,
                -- doydoybaby = 1,
                -- doydoy = 1,
                -- octopusking = 1,
                sweet_potato_planted = 7,
                beehive = 5
            }
        }
    })

    AddRoom("Beaverkingcity", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            --									countstaticlayouts=
            --									{
            --										["LivingJungleTree"]= function() return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0 end	
            --									},
            -- countstaticlayouts={["DefaultPigking"]=1}, --adds 1 per room
            distributepercent = 0.35,
            distributeprefabs = {
                --   sweet_potato_planted = 1, 
                grassnova = 1,
                rocks = .2,
                rock_flintless = 0.01,
                flower = 0.15
                -- beehive = 0.3, -- lowered from 1
            },
            countprefabs = {
                sweet_potato_planted = 7,
                beehive = 5
            }
        }
    })

    AddRoom("JungleEyeplant", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 2, -- was 3
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 1,
                bambootree = 0.5,
                spiderden = .25, -- was .001
                bush_vine = 1,
                snake_hole = 0.1,
                -- wildborehouse = .5, --just added
                eyeplant = 4
            },

            countprefabs = {
                lureplant = 2
            }
        }
    })

    AddRoom("JungleFrogSanctuary", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.35,
            distributeprefabs = {
                fireflies = 1,
                -- palmtree = 0.5,
                jungletree = 1, -- was 3
                rock1 = 0.05,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 1,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 0.6,
                snake_hole = 0.1,
                pond = 0.1 -- was 6

            }
        }
    })

    AddRoom("JungleBees", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3,
            distributeprefabs = {
                beehive = 0.2,
                fireflies = 0.2,
                jungletree = 4,
                rock1 = 0.05,
                flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .8,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.75,
                bambootree = 1,
                spiderden = .01, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("JungleDenseVery", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .4, -- lowered from 1.0
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 1, -- lowered from 6
                rock2 = 0.05,
                flint = 0.05,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05,
                bush_vine = 1,
                snake_hole = 0.1,
                primeapebarrel = 0.05,
                --					                    wildborehouse = .125, --was .05,
                cave_banana_tree = 0.02
            }
        }
    })

    AddRoom("JungleClearing", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["MushroomRingLarge"] = function()
                    if math.random(0, 1000) > 985 then
                        return 1
                    end
                    return 0
                end
            },

            distributepercent = .2, -- was .1
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 1,
                rock1 = 0.03,
                primeapebarrel = 0.1,
                flint = 0.03,
                grassnova = .03, -- was .05
                red_mushroom = .07,
                green_mushroom = .07,
                blue_mushroom = .07,
                flower = 0.75,
                bambootree = .5,
                wasphive = 0.125, -- was 0.5
                spiderden = 0.1
            }
        }
    })

    AddRoom("Jungle", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3, -- was 0.2
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.5, --lowered this from 6
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                -- grassnova = .01, --was .05
                -- saplingnova = .8,
                berrybush2 = .09, -- was .0003
                berrybush2_snake = 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                snake_hole = 0.01, -- was 0.1
                primeapebarrel = .1, -- was .05,
                cave_banana_tree = 0.005,
                spiderden = .05 -- was .01,
                -- wildborehouse = 0.25,										
            }
        }
    })

    AddRoom("JungleRockSkull", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["skull_isle2"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                berrybush2 = .09, -- was .0003
                berrybush2_snake = 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                snake_hole = 0.01, -- was 0.1
                primeapebarrel = .1, -- was .05,
                cave_banana_tree = 0.005,
                spiderden = .05 -- was .01,									
            }

        }
    })
    AddRoom("DoyDoyF", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["doydoyf"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                berrybush2 = .09, -- was .0003
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                spiderden = 0 -- was .01,										
            }

        }
    })
    AddRoom("JungleSparse", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.25,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = .05,
                jungletree = 2, -- .6,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = .3,
                flint = .1, -- dropped
                -- saplingnova = .8,
                berrybush2 = .05, -- was .03
                berrybush2_snake = 0.01,
                -- grassnova = 1,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = .5, -- was 0.75
                bambootree = 1,
                bush_vine = .2, -- was 1
                snake_hole = 0.01, -- was 0.1
                spiderden = 0.05
                -- wildborehouse = 0.25,
            }
        }
    })

    AddRoom("JungleSparseHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3, -- upped from 0.15
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = .05,
                jungletree = .6,
                rock_flintless = 0.05,
                -- rock2 = 0.05, --gold rock
                flint = .1, -- dropped
                -- grassnova = .6, --raised from 05 
                -- saplingnova = .8,
                berrybush2 = .05, -- was .03
                berrybush2_snake = 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 2, -- was 0.75,
                bambootree = 1,
                bush_vine = 1,
                snake_hole = 0.1,
                spiderden = .01
                -- wildborehouse = 0.25,
            }
        }
    })

    AddRoom("JungleDense", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.4,
            distributeprefabs = {
                fireflies = 0.02, -- was 0.2,
                -- palmtree = 0.05,
                jungletree = 3, -- was 4,
                rock1 = 0.05,
                rock2 = 0.1, -- was .05
                -- grassnova = 1, --was .05
                -- saplingnova = .8,
                berrybush2 = .1,
                berrybush2_snake = 0.04,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .05,
                flower = 0.75,
                bambootree = 1,
                flint = 0.1,
                spiderden = .1, -- was .01
                bush_vine = 1,
                snake_hole = 0.1,
                -- wildborehouse = 0.03, --was 0.015,
                primeapebarrel = .2,
                cave_banana_tree = 0.01
            }
        }
    })

    AddRoom("JungleDenseHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3, -- lowered from 0.4
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 4,
                rock1 = 0.05,
                -- rock2 = 0.05, --gold rock
                -- grassnova = 1, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = 0.03, -- was 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                flint = 0.1,
                spiderden = .01,
                bush_vine = 1.5,
                snake_hole = 0.1
                -- wildborehouse = 0.03, --was 0.015,
                -- wildborehouse=.05,
            }
        }
    })

    AddRoom("JungleDenseMed", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "tropical"},
        contents = {
            distributepercent = 0.5, ---was 0.75
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- lowered from 6
                rock1 = 0.05,
                rock2 = 0.05,
                -- grassnova = .02, --was .05
                -- saplingnova = .8,
                berrybush2 = .06, -- was .03,
                berrybush2_snake = .02, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05, -- was .01,
                bush_vine = 2,
                snake_hole = 0.1
                -- wildborehouse = 0.03, --was 0.015,
            }
        }
    })

    AddRoom("JungleDenseBerries", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end,
                ["BerryBushBunch"] = 1
            },
            distributepercent = 0.35,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 4, -- was 6
                rock1 = 0.05,
                rock2 = 0.05,
                -- grassnova = .02, --was .05
                -- saplingnova = .8,
                berrybush2 = .6, -- was .03
                berrybush2_snake = .03, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05, -- was .01
                bush_vine = 1,
                snake_hole = 0.1
                -- wildborehouse = 0.15, --was 0.015,
            }
        }
    })

    AddRoom("JungleDenseMedHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"ExitPiece", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.6, -- was 0.75
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 2, -- was 6
                rock_flintless = 0.05,
                berrybush2 = .06, -- was .03,
                berrybush2_snake = .02, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1, -- was 1
                spiderden = .05, -- was .01
                bush_vine = 0.8, -- was 1
                snake_hole = 0.1
            },
            countprefabs = {
                bambootree = 5,
                bush_vine = 2
            }
        }
    })

    AddRoom("JunglePigGuards", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["pigguard_berries_easy"] = 1
            }, -- adds 1 per room
            distributepercent = 0.3,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 3,
                rock1 = 0.05,
                flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .8,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05,
                bush_vine = 1,
                snake_hole = 0.1
                -- wildborehouse=.05,
            }
        }
    })

    AddRoom("JungleFlower", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- was 3
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 1,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
                -- pond = 1, --frog pond
            },
            countprefabs = {
                -- butterfly_areaspawner = 6,
            }
        }
    })

    AddRoom("JungleSpidersDense", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.5, -- lowered from .5
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 4,
                rock1 = 0.05,
                rock2 = 0.05,
                -- grassnova = 1, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                flint = 0.1,
                spiderden = .5,
                bush_vine = 1,
                snake_hole = 0.1,
                -- wildborehouse = 0.015,
                primeapebarrel = .2, -- was .05,
                cave_banana_tree = 0.01
            }
        }
    })

    AddRoom("JungleSpiderCity", {
        colour = {
            r = .30,
            g = .20,
            b = .50,
            a = .50
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            countprefabs = {
                goldnugget = function()
                    return 3 + math.random(3)
                end
            },
            distributepercent = 0.3,
            distributeprefabs = {
                jungletree = 3,
                spiderden = 0.3
            },
            prefabdata = {
                spiderden = function()
                    if math.random() < 0.2 then
                        return {
                            growable = {
                                stage = 3
                            }
                        }
                    else
                        return {
                            growable = {
                                stage = 2
                            }
                        }
                    end
                end
            }
        }
    })

    AddRoom("JungleBamboozled", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .4, -- was .5, 
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = .09,
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = .025,
                -- saplingnova = .04,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.1,
                bambootree = 1, -- was .5,
                spiderden = .05, -- was .001,
                bush_vine = .04,
                snake_hole = 0.1

            }

        }
    })

    AddRoom("JungleMonkeyHell", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .3, -- was .5
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 2, -- was .4, 
                rock1 = 0.125, -- was 0.5,
                rock2 = 0.125, -- was 0.5,
                primeapebarrel = .04, -- was .8,
                skeleton = .1,
                flint = 0.5,
                -- grassnova = .75,
                -- saplingnova = .4,
                berrybush2 = .1,
                berrybush2_snake = .02,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .01,
                bambootree = 0.5,
                spiderden = .01,
                bush_vine = .04,
                snake_hole = 0.01

            },
            countprefabs = {
                cave_banana_tree = 3
            }
        }
    })

    AddRoom("JungleCritterCrunch", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                fireflies = 0.5,
                -- palmtree = 0.05,
                jungletree = 3, -- was 3
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .06, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 2,
                bambootree = 1,
                spiderden = 0.5,
                bush_vine = 0.2,
                snake_hole = 0.1,
                beehive = 1.5, -- was 3,
                wasphive = 2

            }
        }
    })

    AddRoom("JungleDenseCritterCrunch", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.5, -- was 0.75
            distributeprefabs = {
                fireflies = 1,
                -- palmtree = 0.05,
                jungletree = 6,
                rock_flintless = 0.05,
                -- rock2 = 0.05, --gold rock
                -- grassnova = .05,
                -- saplingnova = .8,
                berrybush2 = .75, -- was 0.3
                berrybush2_snake = .04, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1.5,
                bambootree = 1, -- was 1
                spiderden = .05, -- was .5,
                bush_vine = 0.8, -- was 1
                snake_hole = 0.1,
                -- wildborehouse = 0.03, --was 0.015,
                beehive = .01 -- was 2,
            }
        }
    })

    AddRoom("JungleShroomin", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = .5,
                jungletree = 3,
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = 1, --was .4,
                -- saplingnova = .3,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .07, -- was .01,
                red_mushroom = 3,
                green_mushroom = 3,
                blue_mushroom = 2,
                flower = 0.7,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = .5,
                snake_hole = 0.1

            }
        }
    })

    AddRoom("JungleRockyDrop", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .35,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 6,
                rock1 = 1, -- was 3
                rock2 = .5, -- was 2
                rock_flintless = 2,
                rocks = 3,
                -- flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .07, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .9,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("JungleGrassy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- was 3
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = 5,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .2,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("JungleSappy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 1.5, -- was 3
                rock1 = 0.05,
                -- flint = 0.05,
                -- grassnova = .025,
                saplingnova = 6,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .3,
                bambootree = 0.5,
                spiderden = .001,
                bush_vine = 0.3,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("JungleEvilFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- was 3
                rock1 = 0.05,
                -- flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .9,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1,
                flower_evil = 10,
                wasphive = 0.25 -- just added
            }

        }
    })

    AddRoom("JungleParrotSanctuary", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.9,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = .5,
                rock1 = 0.5,
                rock2 = 0.5,
                rocks = 0.4,
                -- grassnova = 0.5, --was .05
                -- saplingnova  = 8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.2,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.05, --was 0.005,
                primeapebarrel = 0.05,
                fireflies = 0.02,
                cave_banana_tree = 0.02
            }

        }
    })

    AddRoom("JungleNoBerry", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5, -- was .5,
                rock1 = 0.5,
                rock2 = 0.5,
                rocks = 0.4,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.2,
                bambootree = 3, -- was 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.05, --was 0.005,
                primeapebarrel = 0.05,
                fireflies = 0.02,
                cave_banana_tree = 0.02
            }

        }
    })

    AddRoom("JungleNoRock", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.2,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .05,
                berrybush2_snake = 0.01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.2,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.005,
                primeapebarrel = .25, -- was .05,
                fireflies = 0.02,
                cave_banana_tree = 0.02
            }

        }
    })

    AddRoom("JungleNoMushroom", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {

            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.4, -- was 0.2
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = 0.04,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                flower = 0.2,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.05, --was 0.005,
                primeapebarrel = .15, -- was .05,
                fireflies = 0.02,
                cave_banana_tree = 0.01
            }

        }
    })

    AddRoom("JungleNoFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {

            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },

            distributepercent = 0.2,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = 0.04,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.25,
                primeapebarrel = .15, -- was .05,
                -- pond = 0.05,
                fireflies = 0.02,
                cave_banana_tree = 0.01
            }

        }
    })

    AddRoom("JungleMorePalms", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5,
            distributeprefabs = {
                -- palmtree = 3,
                jungletree = .3,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = 0.04,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.6,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.005,
                primeapebarrel = .15, -- was .05,
                fireflies = 0.02,
                cave_banana_tree = 0.01
            }

        }
    })

    AddRoom("DoyDoyM", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            countstaticlayouts = {
                ["doydoym"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                berrybush2 = .09, -- was .0003
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                primeapebarrel = .1, -- was .05,
                spiderden = 0 -- was .01,											
            }

        }
    })

    AddRoom("JungleSkeleton", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 1.5, -- was 3
                rock1 = 0.05,
                -- flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .9,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1,
                flower_evil = .001,
                skeleton = 1.25
            }
        }
    })

    -------------------------------------start room to portal room-------------------------------------------------------------
    AddRoom("BeachPortalRoom", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "tropical"},
        contents = {
            -- countstaticlayouts={["shipwrecked_start"]=1}, 
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .5,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                -- rock2 = .2,
                beehive = .01, -- was .05, 
                -- flower = .04, --trying
                grassnova = .2, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .005,
                crate = .01
            },
            countprefabs = {
                spawnpoint_multiplayer = 1
                -- vidanomar = 1,
                -- lake = 1,
            }

        }
    })

    AddRoom("PigVillagesw", {
        colour = {
            r = 0.3,
            g = .8,
            b = .5,
            a = .50
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison", "tropical"},
        contents = {
            countstaticlayouts = {
                ["Farmplot"] = function()
                    return math.random(2, 5)
                end,
                ["wildboreking"] = 1
            },

            countprefabs = {
                firepit = 1,
                wildborehouse = function()
                    return 3 + math.random(4)
                end
            },
            distributepercent = .1,
            distributeprefabs = {
                grassnova = .05,
                berrybush2 = .05,
                berrybush_juicy = 0.025
            }
        }
    })
    ------------------------------------------------------------------Mainland SW------------------------------------------------	

    AddRoom("MAINNoOxMeadow", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .4, -- .1, --lowered from .2
            distributeprefabs = {
                flint = 0.01,
                grassnova = .4,
                -- ox = 0.05,
                sweet_potato_planted = 0.05,
                beehive = 0.003,
                wasphive = 0.003,
                rocks = 0.003,
                rock_flintless = 0.01,
                flower = .25
            }
        }
    })

    AddRoom("MAINMeadowOxBoon", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .4, -- was .1,
            distributeprefabs = {
                --    ox = .5, --was 1,
                grassnova = 1,
                flower = .5,
                beehive = 0.1,
                wasphive = 0.003
            }
        }
    })

    AddRoom("MAINMeadowFlowery", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .5, -- .1, --lowered from .2
            distributeprefabs = {
                flower = .5,
                beehive = .05, -- was .4
                grassnova = .4,
                rocks = .05,
                mandrake_planted = 0.005
            }
        }
    })

    AddRoom("MAINMeadowBees", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .4, -- .1, --lowered from .2
            distributeprefabs = {
                flint = 0.05, -- was .01
                grassnova = 3, -- was .4,
                -- ox = 3,
                sweet_potato_planted = 0.1, -- was .05,
                rock_flintless = 0.01,
                flower = 0.15,
                beehive = 0.2, -- lowered from 1
                wasphive = 0.05
            }
        }
    })

    AddRoom("MAINMeadowCarroty", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            countstaticlayouts = meadow_fairy_rings,
            distributepercent = .35, -- was .1
            distributeprefabs = {
                sweet_potato_planted = 1,
                grassnova = 1.5,
                rocks = .2,
                flower = .5
            }
        }
    })

    --[[AddRoom("MAINMeadowWetlands", {
					colour={r=.8,g=.4,b=.4,a=.50},
					value = GROUND.MEADOW,
					tags = {"ExitPiece", "RoadPoison"},
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                    --pond = 1,
					                    pond_mos = .8,
					                    grassnova = .5,
					                    flower = .3,
					                    saplingnova = .2,
					                    sweet_potato_planted = .1,  
					                },
					            }
					})
]]
    AddRoom("MAINMeadowSappy", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                grassnova = 3,
                -- saplingnova = 1,
                flower = .5,
                beehive = .1, -- was 1,
                sweet_potato_planted = 0.3,
                wasphive = 0.01 -- was 0.001
            }
        }
    })

    AddRoom("MAINMeadowSpider", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .4, -- was .2
            distributeprefabs = {
                spiderden = .1,
                grassnova = 1,
                -- saplingnova = .8,
                -- ox = .5,
                flower = .5
            }
        }
    })

    AddRoom("MAINMeadowRocky", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {

            distributepercent = .4, -- was .1,
            distributeprefabs = {
                rock_flintless = 1,
                rocks = 1,
                rock1 = 1,
                rock2 = 1,
                grassnova = 4, -- was 2
                flower = 1
            }
        }
    })

    AddRoom("MAINMeadowMandrake", {
        colour = {
            r = .8,
            g = .4,
            b = .4,
            a = .50
        },
        value = GROUND.MEADOW,
        tags = {"ExitPiece", "RoadPoison"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                grassnova = .8,
                -- saplingnova = .8,
                sweet_potato_planted = 0.05,
                rocks = 0.003,
                rock_flintless = 0.01,
                flower = .25
            },
            countprefabs = {
                mandrake_planted = math.random(1, 2)
            }
        }
    })

    -- Forest-magma-------------------------------------------------------------------------------------------------------------

    AddRoom("MAINMagma", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                magmarock = 2, -- nitre
                magmarock_gold = 1,
                rock1 = .25,
                rock2 = .25, -- gold 
                rocks = .25,
                flint = 0.5, -- lowered from 3
                spiderden = .1
                -- saplingnova = 1.0,
            }
        }
    })

    AddRoom("MAINMagmaHome", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                magmarock_gold = 2,
                magmarock = 2,
                rock1 = .2, -- nitre
                -- rock2 = 2, --gold
                rock_flintless = 1,
                rocks = .25, -- was 0.5
                flint = 0.1, -- lowered from 3
                -- rock_ice = 1,
                -- tallbirdnest= --2, --.1,
                spiderden = .1
                -- saplingnova = 0.5,

            },

            countprefabs = {
                flint = 4
            }
        }
    })

    AddRoom("MAINMagmaHomeBoon", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                -- rock1 = 2, --nitre
                rock2 = 1, -- gold
                rock_flintless = 2,
                rocks = .25,
                flint = 1, -- lowered from 3
                -- rock_ice = 1,
                -- tallbirdnest= --2, --.1,
                spiderden = .1,
                saplingnova = 0.5
            },

            countprefabs = {
                flint = 4
            }
        }
    })

    AddRoom("MAINBG_Magma", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                flint = 0.5,
                rock1 = 0.2,
                rock2 = 1,
                rocks = 25,
                tallbirdnest = 0.08,
                saplingnova = 1.5,
                spiderden = .1
            }
        }
    })

    AddRoom("MAINGenericMagmaNoThreat", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                magmarock = 2,
                magmarock_gold = 1,
                rock1 = 0.3,
                rock2 = 0.3,
                -- rock_ice = .75,
                rocks = .25,
                flint = 1.5,
                blue_mushroom = .002,
                green_mushroom = .002,
                red_mushroom = .002,
                saplingnova = .5,
                spiderden = .1
            }
        }
    })

    AddRoom("MAINMagmaVolcano", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                rock1 = 2,
                rock2 = 2,
                rocks = .25,
                flint = 0.,
                -- saplingnova = .5,
                spiderden = .1
            }

        }
    })

    AddRoom("MAINVolcano", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison"},
        --					required_prefabs = {"volcano"},
        contents = {
            --									countstaticlayouts={["Entradavulcao"]=1}, --adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .3,
                rock_charcoal = .3,
                volcano_shrub = .2,
                charcoal = 0.04,
                skeleton = 0.1
            },

            countprefabs = {
                volcanofog = math.random(1, 2),
                volcano = function()
                    if GetModConfigData("Volcano") == false then
                        return 1
                    else
                        return 0
                    end
                end,
                cave_entrance_vulcao = function()
                    if GetModConfigData("Volcano") == true then
                        return 1
                    else
                        return 0
                    end
                end
            },

            prefabdata = {
                magmarock = {
                    regen = true
                },
                magmarock_gold = {
                    regen = true
                }
            }
        }
    })

    AddRoom("MAINVolcanofundo", {
        colour = {
            r = 0.8,
            g = .8,
            b = .1,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison"},
        contents = {
            --						     green_mushroom = .05,
            --					         reeds =  2,
            countprefabs = {}
        }
    })

    AddRoom("MAINMagmadragoon", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = 0.2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                rock1 = 0.1, -- nitre
                rock2 = 0.1, -- gold
                rock_flintless = 0.4,
                rocks = 0.4,
                flint = 0.2, -- lowered from 3
                --  tallbirdnest= .2, --.1,
                --					                    dragoonden= 0.7,
                saplingnova = .3

            },
            countprefabs = {
                dragoonden = 4,
                rock_moon = 2
            }
        }
    })

    AddRoom("MAINMagmaGold", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 0.8,
                magmarock_gold = 1, -- gold
                rock1 = 0.5,
                rock2 = 0.3,
                rock_flintless = .1,
                rocks = 0.4,
                flint = .1,
                rock_moon = 0.1,
                goldnugget = .25,
                tallbirdnest = .2,
                saplingnova = .5,
                spiderden = .1
            }
        }
    })

    AddRoom("MAINMagmaGoldmoon", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            --									countstaticlayouts={["CaveEntrance"]=1}, --adds 1 per room					
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 0.8,
                magmarock_gold = 1, -- gold
                rock1 = 0.5,
                rock2 = 0.3,
                rock_flintless = .1,
                rocks = 0.4,
                flint = .1,
                rock_moon = 0.1,
                goldnugget = .25,
                tallbirdnest = .2,
                saplingnova = .5,
                spiderden = .1
            },
            countprefabs = {
                rock_moon_shell = 1,
                meteorspawner = 2
            }
        }
    })

    AddRoom("MAINMagmaGoldBoon", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock_gold = 1,
                rock1 = 0.5,
                rock2 = 0.3,
                rocks = 3,
                flint = 1,
                goldnugget = 1,
                tallbirdnest = .1,
                rock_moon = 2
                -- saplingnova = .5,
                -- spiderden= .1,
            }
        }
    })

    AddRoom("MAINMagmaTallBird", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.75,
                rock1 = 0.5,
                rock2 = 0.3,
                rocks = 1,
                rock_moon = 0.1,
                rock_flintless = 1,
                tallbirdnest = .25,
                -- saplingnova = .5,
                spiderden = .1
            }
        }
    })

    AddRoom("MAINMagmaForest", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.25,
                rock1 = 0.5,

                rock2 = 0.3,
                obsidian = .02,
                -- elephantcactus = 0.2,
                rocks = 2,
                rock_flintless = 1,
                rock_moon = 0.1,
                jungletree = 0.5,
                saplingnova = 2,
                spiderden = .15
            },

            prefabdata = {
                jungletree = {
                    burnt = true
                }
            }
        }
    })

    AddRoom("MAINMagmaSpiders", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MAGMAFIELD,
        tags = {"ExitPiece"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                magmarock = 2,
                magmarock_gold = 1,
                rock1 = 2, -- nitre
                rock2 = 2, -- gold
                rock_flintless = 2,
                rocks = 1,
                rock_moon = 0.1,
                flint = 1, -- lowered from 3
                -- rock_ice = 1,
                tallbirdnest = .2, -- .1,
                spiderden = 1.5, -- .5,
                sapling = .5

            }
        }
    })
    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Forest-volcano-------------------------------------------------------------------------------------------------------------

    AddRoom("MAINVolcanoRock", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                flint = .5,
                obsidian = .02,
                -- rocks = 1,
                charcoal = 0.04,
                skeleton = 0.25
                -- elephantcactus = 0.3,

                -- coffeebush = 0.25,
                -- dragoonden = .2,
            },

            countprefabs = {
                -- palmtree = math.random(8, 16),
                volcanofog = math.random(1, 2)
            }
        }
    })

    AddRoom("MAINVolcanoAsh", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.ASH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .1,
            countstaticlayouts = {
                ["CoffeeBushBunch"] = 1
            }, -- adds 1 per room
            distributeprefabs = {
                -- rocks = 1,
                skeleton = 0.05,
                coffeebush = 0.04
                -- elephantcactus = 0.09,     
                -- dragoonden = .2,
            },

            countprefabs = {
                -- palmtree = math.random(4, 8),
                volcanofog = math.random(1, 2),
                coffeebush = 6,
                charcoal = 4,
                volcano_shrub = 3,
                elephantcactus = 5
            }
        }
    })

    AddRoom("MAINVolcanoObsidian", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison"},
        contents = {
            --									countstaticlayouts={["beaverking"]=1}, --adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .3,
                rock_charcoal = .3,
                volcano_shrub = .2,
                charcoal = 0.04,
                skeleton = 0.1,
                dragoonden = .05,
                elephantcactus = 0.1
                -- coffeebush = 1,
            },

            countprefabs = {
                volcanofog = math.random(1, 2)
            }
        }
    })

    AddRoom("MAINVolcanoStart", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["Entradavulcao"] = 1
            }, -- adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .5,
                rock_charcoal = .5,
                volcano_shrub = .5,
                charcoal = 0.04,
                skeleton = 0.1
            },

            countprefabs = {
                volcanofog = math.random(1, 2),
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    AddRoom("MAINVolcanoNoise", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.VOLCANO,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["CoffeeBushBunch"] = function()
                    if math.random() < 0.25 then
                        return 1
                    else
                        return 0
                    end
                end
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = .5,
                magmarock_gold = .5,
                rock_obsidian = .5,
                rock_charcoal = .5,
                volcano_shrub = .5,
                charcoal = 0.04,
                skeleton = 0.1,
                dragoonden = .05,
                elephantcactus = 1,
                coffeebush = 1
            },

            countprefabs = {
                volcanofog = math.random(1, 2)
            }
        }
    })

    AddRoom("MAINVolcanoObsidianBench", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["ObsidianWorkbench"] = 1
            }, -- adds 1 per room
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 1,
                obsidian = .2,
                charcoal = 0.04,
                skeleton = 0.5
            },
            countprefabs = {
                volcanofog = math.random(1, 2),
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    AddRoom("MAINVolcanoAltar", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["volcano_altar"] = GetModConfigData("forge")
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                charcoal = 0.04,
                skeleton = 0.5
            },

            countprefabs = {
                volcanofog = math.random(1, 2),
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }

        }
    })

    AddRoom("MAINVolcanoLavaarena", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["lava_arena"] = GetModConfigData("forge")
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                charcoal = 0.04,
                skeleton = 0.5
            },

            countprefabs = {
                volcanofog = math.random(1, 2)
            }

        }
    })

    AddRoom("MAINVolcanoCage", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.BEARDRUG,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["WoodlegsUnlock"] = 1
            },
            distributepercent = .1,
            distributeprefabs = {
                magmarock = 1,
                charcoal = 0.04,
                skeleton = 0.5,
                dragoonden = .2,
                coffeebush = 0.25
            },

            countprefabs = {
                volcanofog = 1,
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    AddRoom("MAINVolcanoLava", {
        colour = {
            r = 1.0,
            g = 0.55,
            b = 0,
            a = .50
        },
        value = GROUND.IMPASSABLE,
        type = "blank",
        tags = {},
        contents = {
            distributepercent = 0,
            distributeprefabs = {}
        }
    })

    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Forest-tidalmarsh-------------------------------------------------------------------------------------------------------------					

    AddRoom("MAINTidalMarsh", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = 0.4,
            distributeprefabs = {
                jungletree = .05,
                marsh_bush = .05,
                --					                    tidalpool = 0.08,										
                reeds = 1,
                spiderden = .01,
                green_mushroom = 1,
                --					                    mermhouse = 0.01, --was 0.04
                mermfishhouse = 0.05,
                poisonhole = 0.15,
                --					                    seaweed_planted = 0.5,
                --					                    fishinhole = .1,
                flupspawner = 0.7,
                flup = 1
            },
            countprefabs = {
                -- mermfishhouse = 5,
                tidalpool = 2,
                mermfishhouse = 2,
                reeds = 3,
                -- mermhouse = 2,
                poisonhole = 3
            }
        }
    })

    AddRoom("MAINTidalMarsh1", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = 0.4,
            distributeprefabs = {
                jungletree = .01,
                -- marsh_bush = .05,
                reeds = 1,
                -- spiderden=.01,
                poisonhole = 0.5,
                green_mushroom = 0.4,
                --                                        mermhouse = 0.2,
                --                                        mermfishhouse = 1.0,
                --                                        tidalpool = 0.8,
                -- poisonhole = 0.1,
                --                                        seaweed_planted = 0.5,
                --                                        fishinhole = .1,
                flupspawner_sparse = 0.2
                --                                        flup = 1,
            },

            countprefabs = {
                mermfishhouse = 3,
                tidalpool = 3

            }
        }
    })

    AddRoom("MAINTidalMermMarsh", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = 0.1,
            distributeprefabs = {
                jungletree = .05,
                marsh_bush = .05,
                reeds = 1,
                spiderden = .01,
                green_mushroom = 1.02,
                --					                    mermhouse = 0.2,
                --					                    mermfishhouse = 1.0,
                poisonhole = 0.2,
                --					                    seaweed_planted = 0.5,
                --					                    fishinhole = .1,
                flupspawner_sparse = 0.3
                --										tidalpool = 1,
                --					                    flup = 1,
            },

            countprefabs = {
                mermfishhouse = 2,
                tidalpool = 2,
                reeds = 6
            }
        }
    })

    AddRoom("MAINTidalSharkHome", {
        colour = {
            r = 0.8,
            g = .8,
            b = .1,
            a = .50
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        --	required_prefabs = {"tigersharkpool"},
        contents = {
            green_mushroom = .05,
            reeds = 2,
            countstaticlayouts = {
                ["tigersharkarea"] = 1
            }, -- adds 1 per room
            countprefabs = {
                -- marsh_bush = 1,
                tidalpool = 3,
                reeds = 7,
                poisonhole = 5,
                mermfishhouse = 2,
                green_mushroom = 7
                -- tigersharkpool = 1,
                -- flupspawner = 3,
            }
        }
    })

    AddRoom("MAINToxicTidalMarsh", {
        colour = {
            r = 0,
            g = .5,
            b = .5,
            a = .10
        },
        value = GROUND.TIDALMARSH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = 0.2,
            distributeprefabs = {
                jungletree = .05,
                marsh_bush = .05,
                tidalpool = 0.2,
                reeds = 2, -- was 4
                spiderden = .01,
                green_mushroom = 1.02,
                mermhouse = 0.1, -- was 0.04
                mermfishhouse = 0.05,
                poisonhole = 1, -- was 2
                -- seaweed_planted = 0.5,
                fishinhole = .1,
                flupspawner_dense = 1,
                flup = 2
            }
        }
    })

    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Beach-------------------------------------------------------------------------------------------------------------					

    AddRoom("MAINBeachSand", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                -- rock2 = .2,
                beehive = .01, -- was .05, 
                -- flower = .04, --trying
                grassnova = .2, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .01,
                crate = .01
            }

        }
    })

    AddRoom("MAINBeachSandHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3, -- upped from .05
            distributeprefabs = {
                seashell_beached = .25,
                rock_limpet = .05,
                crabhole = .1, -- was 0.2
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .05,
                rock_flintless = .1, -- trying
                -- beehive = .05, --trying
                -- flower = .04, --trying
                grassnova = .5, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .1, -- was .6,
                crate = .025
            },

            countprefabs = {
                flint = 1,
                saplingnova = 1
            }

        }
    })

    AddRoom("MAINBeachUnkept", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3, -- lowered from .3
            distributeprefabs = {
                seashell_beached = 0.125,
                grassnova = .3, -- down from 3
                saplingnova = .1, -- lowered from 15
                -- flower = 0.05,
                rock_limpet = .02,
                crabhole = .015, -- was .03
                palmtree = .1,
                rocks = .003,
                beehive = .003,
                flint = .02,
                sandhill = .05,
                -- rock2 = .01,
                dubloon = .001,
                wildborehouse = .007
            },
            countprefabs = {
                flint = 3,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                saplingnova = 3,
                grassnova = 3
                -- sandhill = .05,
            }

        }
    })
    AddRoom("MAINBeachUnkeptInicio", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3, -- lowered from .3
            distributeprefabs = {
                seashell_beached = 0.125,
                grassnova = .3, -- down from 3
                saplingnova = .1, -- lowered from 15
                -- flower = 0.05,
                rock_limpet = .02,
                crabhole = .015, -- was .03
                palmtree = .1,
                rocks = .003,
                beehive = .003,
                flint = .02,
                sandhill = .05,
                -- rock2 = .01,
                dubloon = .001,
                wildborehouse = .007
            },
            countprefabs = {
                flint = 3,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                saplingnova = 6,
                grassnova = 6
                -- sandhill = .05,
            }

        }
    })
    AddRoom("MAINBeachX", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["x_spot"] = 1
            },
            distributepercent = .3, -- lowered from .3
            distributeprefabs = {
                seashell_beached = 0.125,
                -- grassnova = .3, --down from 3
                -- saplingnova = .1, --lowered from 15
                -- flower = 0.05,
                rock_limpet = .02,
                -- crabhole = .015, --was .03
                palmtree = .1,
                -- rocks = .003,
                -- beehive = .003,
                -- flint = .02,
                sandhill = .05,
                -- rock2 = .01,
                dubloon = .001
                -- wildborehouse = .007,
            },
            countprefabs = {
                -- flint = 2,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                -- saplingnova = 3,
                -- grassnova = 3,
                -- sandhill = .05,
            }

        }
    })
    AddRoom("MAINBeachUnkeptDubloon", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                seashell_beached = 0.025,
                grassnova = .1, -- was .3
                saplingnova = .05, -- was .15
                -- flower = 0.05,
                rock_limpet = .02,
                -- crabhole = .015, --was .03
                palmtree = .1,
                rocks = .003,
                -- beehive = .003,
                flint = .01, -- was .02,
                sandhill = .05,
                -- rock2 = .01,
                goldnugget = .007,
                dubloon = .01, -- this should be relatively high on this island
                skeleton = .025,
                wildborehouse = .005
            }

        }
    })

    AddRoom("MAINBeachGravel", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                rock_limpet = 0.01,
                rocks = 0.1,
                flint = 0.02,
                rock1 = 0.05,
                -- rock2 = 0.05,
                rock_flintless = 0.05,
                grassnova = .05,
                -- flower = 0.05, --removed as it's used on NoFlower island
                sandhill = .05,
                seashell_beached = .025,
                wildborehouse = .005
            }
        }
    })

    AddRoom("MAINBeachSinglePalmTreeHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                -- rock2 = .2,
                beehive = .01, -- was .05, 
                -- flower = .04, --trying
                grassnova = .2, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .01,
                crate = .01
            }

        }
    })

    AddRoom("MAINDoydoyBeach1", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {

            distributepercent = .1,
            distributeprefabs = {
                flower_evil = 0.2,
                jungletree = 1, -- one palm tree
                fireflies = 1, -- results in an empty beach because these only show at night
                flower = .4,
                bambootree = 0.5, -- one palm tree
                bush_vine = 0.2 -- one palm tree
                -- sandhill = .5,
            },
            countprefabs = {
                -- doydoy = 1,
                -- jungletree = 3, --one palm tree
                -- seashell_beached = 1, --one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                -- beachresurrector = 1,
                -- sandhill = .05,
            }
        }
    })

    AddRoom("MAINDoydoyBeach", {
        colour = {
            r = .66,
            g = .66,
            b = .66,
            a = .50
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone", "ExitPiece"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_evil = 0.5,
                fireflies = 1, -- results in an empty beach because these only show at night
                flower = .3,
                palmtree = 1, -- one palm tree
                crabhole = 0.3, -- one palm tree
                sandhill = .05
            },
            countprefabs = {
                -- doydoy = 1,
                crate = 2,
                --	palmtree = 1, --one palm tree
                seashell_beached = 1 -- one seashell
                -- coconut = 1, --one coconut
                -- mandrake =0.05,
                -- beachresurrector = 1,
                -- sandhill = .05,
            }
        }
    })

    AddRoom("MAINBeachWaspy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1, -- just copied this whole thing from EvilFlowerPatch in terrain_grass
            distributeprefabs = {
                flower_evil = 0.05,
                -- fireflies = .1, -- was 1, now .1 (results in an empty beach because these only show at night)
                wasphive = .005,
                sandhill = .05,
                rock_limpet = 0.01,
                flint = .005,
                seashell_beached = .025
            }

        }
    })

    AddRoom("MAINBeachPalmForest", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                palmtree = .5,
                sandhill = .05,
                crabhole = .025,
                crate = 0.02,
                grassnova = .05,
                rock_limpet = .015,
                flint = .005,
                seashell_beached = .025,
                wildborehouse = .005
            }
        }
    })

    AddRoom("MAINBeachPiggy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2, -- just copied this whole thing from EvilFlowerPatch in terrain_grass
            distributeprefabs = {
                saplingnova = 0.25,
                grassnova = .5,
                palmtree = .1,
                wildborehouse = .05,
                rock_limpet = 0.1,
                sandhill = .3,
                seashell_beached = .125
            }

        }
    })
    AddRoom("MAINBeachCassino", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2, -- just copied this whole thing from EvilFlowerPatch in terrain_grass
            distributeprefabs = {
                saplingnova = 0.25,
                grassnova = .5,
                palmtree = .1,
                wildborehouse = .05,
                rock_limpet = 0.1,
                sandhill = .3,
                seashell_beached = .125
            }

        }
    })

    AddRoom("MAINBeesBeach", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .3, -- Up from .025
            distributeprefabs = {
                seashell_beached = 0.025,
                rock_limpet = .05, -- reducing from .2 (everything is so low here)
                crabhole = .2,
                palmtree = .3,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                beehive = .1, -- was .5
                wasphive = .05,
                -- flower = .04, --trying
                grassnova = .4, -- trying
                saplingnova = .4, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .4 -- was .04
            }

        }
    })

    AddRoom("MAINBeachCrabTown", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = 0.005,
                crabhole = 1,
                saplingnova = .2,
                palmtree = .75,
                grassnova = .5,
                -- flower=.1,
                seashell_beached = .01,
                rocks = .1,
                rock1 = .2,
                -- fireflies=.1,
                -- spiderden=.001,
                flint = .01,
                sandhill = .3
            }

        }
    })

    AddRoom("MAINBeachDunes", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                sandhill = 1.5,
                grassnova = 1,
                seashell_beached = .5,
                saplingnova = 1,
                rock1 = .5,
                rock_limpet = 0.1,
                wildborehouse = .05
            }

        }
    })

    AddRoom("MAINBeachGrassy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},

        contents = {
            distributepercent = .2, -- was .1
            distributeprefabs = {
                grassnova = 1.5,
                rock_limpet = .25,
                beehive = .1,
                sandhill = 1,
                rock1 = .5,
                crabhole = .5,
                flint = .05,
                seashell_beached = .25
            }

        }
    })

    AddRoom("MAINBeachSappy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                saplingnova = 1,
                crabhole = .5,
                palmtree = 1,
                rock_limpet = 0.1,
                flint = .05,
                seashell_beached = .25
            }

        }
    })

    AddRoom("MAINBeachRocky", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                rock1 = 1,
                -- rock2 = 1, removing to take gold vein rocks out of all beaches
                rocks = 1,
                rock_flintless = 1,
                grassnova = 2,
                crabhole = 2,
                rock_limpet = 0.01,
                flint = .05,
                seashell_beached = .25,
                wildborehouse = .05
            }

        }
    })

    AddRoom("MAINBeachLimpety", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1,
            distributeprefabs = {
                rock_limpet = 1,
                rock1 = 1,
                grassnova = 1,
                seashell = 1,
                saplingnova = .5,
                flint = .05,
                seashell_beached = .25,
                wildborehouse = .05
            }

        }
    })

    AddRoom("MAINBeachSpider", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                rock_limpet = 0.01,
                spiderden = 0.5,
                palmtree = 1,
                grassnova = 1,
                rocks = 0.5,
                saplingnova = 0.2,
                flint = .05,
                seashell_beached = .25,
                wildborehouse = .025
            }

        }
    })

    AddRoom("MAINBeachNoFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.0025,
                rock_limpet = .005, -- reducing from .03 (everything is so low here)
                crabhole = .002,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .005, -- trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055
            }

        }
    })

    AddRoom("MAINBeachFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .5, -- was .1
            distributeprefabs = {
                beehive = .1, -- was .5
                flower = 2, -- was 1
                palmtree = .3,
                rock1 = .1,
                grassnova = .2,
                saplingnova = .1,
                seashell_beached = .025,
                rock_limpet = 0.01,
                flint = .05
            }

        }
    })

    AddRoom("MAINBeachNoLimpets", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.0025,
                crabhole = .002,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .0025, -- trying
                -- flower = 0.04, --trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055,
                wildborehouse = .05
            }

        }
    })

    AddRoom("MAINBeachNoCrabbits", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.0025,
                rock_limpet = 0.01,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .005, -- trying
                -- flower = 0.04, --trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055
            }

        }
    })

    AddRoom("MAINBeachPalmCasino", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["slotmachine"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                seashell_beached = 0.025,
                rock_limpet = 0.01,
                palmtree = .3,
                rocks = .003, -- trying
                beehive = .005, -- trying
                -- flower = 0.04, --trying
                grassnova = .3, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .002, --trying
                flint = .05,
                sandhill = .055
            },

            countprefabs = {
                packim_fishbone = 1,
                underwater_entrance1 = 1, -- function() if GLOBAL.KnownModIndex:IsModEnabled("Creep in the deeps TE") then return 1 end return 0 end,
                gravestone = 5
            }

        }
    })
    AddRoom("MAINBeachShells", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                seashell_beached = 1.25,
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .025, -- was .1,
                -- rock2 = .05, --was .2,
                beehive = .02,
                -- flower = .04,
                grassnova = .3, -- was .2,
                saplingnova = .2,
                -- fireflies = .02,
                -- spiderden = .03,
                flint = .25,
                sandhill = .1, -- was .6,
                wildborehouse = .05
            },

            countprefabs = {
                -- beachresurrector = 1,
                crate = 5
                -- sharkittenspawner = 1,
            }

        }
    })
    AddRoom("MAINBeachShark", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                seashell_beached = 1.25,
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .025, -- was .1,
                -- rock2 = .05, --was .2,
                beehive = .02,
                -- flower = .04,
                grassnova = .3, -- was .2,
                saplingnova = .2,
                -- fireflies = .02,
                -- spiderden = .03,
                flint = .25,
                sandhill = .1, -- was .6,
                wildborehouse = .05
            },

            countprefabs = {
                -- beachresurrector = 1,
                crate = 5
                -- sharkittenspawner = 1,
            }

        }
    })
    AddRoom("MAINBeachShells1", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                seashell_beached = 1.25,
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .025, -- was .1,
                -- rock2 = .05, --was .2,
                beehive = .02,
                -- flower = .04,
                grassnova = .3, -- was .2,
                saplingnova = .2,
                -- fireflies = .02,
                -- spiderden = .03,
                flint = .25,
                sandhill = .1, -- was .6,
                wildborehouse = .05
            },

            countprefabs = {
                -- beachresurrector = 1,
                crate = 5
                -- sharkittenspawner = 1,
            }

        }
    })

    AddRoom("MAINBeachSkull", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .3,
                rocks = .03,
                rock1 = .1,
                beehive = .01,
                grassnova = .2,
                saplingnova = .2,
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .005,
                crate = 0.04
            }

        }
    })

    --[[ROOMS]] ---------------------------------------------------------------------------------------------------------------
    -- Forest-jungle-------------------------------------------------------------------------------------------------------------								

    AddRoom("MAINJunglePigs", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        --	required_prefabs = {"slipstor"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            -- countstaticlayouts={["DefaultPigking"]=1}, --adds 1 per room
            distributepercent = 0.3,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 3,
                rock1 = 0.05,
                flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .8,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05,
                bush_vine = 1,
                snake_hole = 0.1
                --					                    wildborehouse = 0.9, --was .015 and also was 2.15??
                -- wildborehouse=.05,
            },
            countprefabs = {
                -- doydoybaby = 1,
                -- doydoy = 1,
                primeapebarrel = 2
            }
        }
    })

    AddRoom("MAINBeaverkinghome", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.MEADOW,
        -- required_prefabs = {"octopusking"},
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            -- countstaticlayouts={["octopusking"]=1}, --adds 1 per room
            distributepercent = .2,
            distributeprefabs = {
                -- sweet_potato_planted = 0.5, 
                grassnova = 1,
                -- beehive = 0.003,
                rocks = 0.003,
                rock_flintless = 0.01,
                flower = .25
            },
            countprefabs = {
                mandrake_planted = 1,
                -- doydoybaby = 1,
                -- doydoy = 1,
                -- octopusking = 1,
                sweet_potato_planted = 7,
                beehive = 5
            }
        }
    })

    AddRoom("MAINBeaverkingcity", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.MEADOW,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            --									countstaticlayouts=
            --									{
            --										["LivingJungleTree"]= function() return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0 end	
            --									},
            -- countstaticlayouts={["DefaultPigking"]=1}, --adds 1 per room
            distributepercent = 0.35,
            distributeprefabs = {
                --   sweet_potato_planted = 1, 
                grassnova = 1,
                rocks = .2,
                rock_flintless = 0.01,
                flower = 0.15
                -- beehive = 0.3, -- lowered from 1
            },
            countprefabs = {
                sweet_potato_planted = 7,
                beehive = 5
            }
        }
    })

    AddRoom("MAINJungleEyeplant", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 2, -- was 3
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 1,
                bambootree = 0.5,
                spiderden = .25, -- was .001
                bush_vine = 1,
                snake_hole = 0.1,
                -- wildborehouse = .5, --just added
                eyeplant = 4
            },

            countprefabs = {
                lureplant = 2
            }
        }
    })

    AddRoom("MAINJungleFrogSanctuary", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.35,
            distributeprefabs = {
                fireflies = 1,
                -- palmtree = 0.5,
                jungletree = 1, -- was 3
                rock1 = 0.05,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 1,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 0.6,
                snake_hole = 0.1,
                pond = 0.1 -- was 6

            }
        }
    })

    AddRoom("MAINJungleBees", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3,
            distributeprefabs = {
                beehive = 0.2,
                fireflies = 0.2,
                jungletree = 4,
                rock1 = 0.05,
                flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .8,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.75,
                bambootree = 1,
                spiderden = .01, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("MAINJungleDenseVery", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .4, -- lowered from 1.0
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 1, -- lowered from 6
                rock2 = 0.05,
                flint = 0.05,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05,
                bush_vine = 1,
                snake_hole = 0.1,
                primeapebarrel = 0.05,
                --					                    wildborehouse = .125, --was .05,
                cave_banana_tree = 0.02
            }
        }
    })

    AddRoom("MAINJungleClearing", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["MushroomRingLarge"] = function()
                    if math.random(0, 1000) > 985 then
                        return 1
                    end
                    return 0
                end
            },

            distributepercent = .2, -- was .1
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 1,
                rock1 = 0.03,
                primeapebarrel = 0.1,
                flint = 0.03,
                grassnova = .03, -- was .05
                red_mushroom = .07,
                green_mushroom = .07,
                blue_mushroom = .07,
                flower = 0.75,
                bambootree = .5,
                wasphive = 0.125, -- was 0.5
                spiderden = 0.1
            }
        }
    })

    AddRoom("MAINJungle", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3, -- was 0.2
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.5, --lowered this from 6
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                -- grassnova = .01, --was .05
                -- saplingnova = .8,
                berrybush2 = .09, -- was .0003
                berrybush2_snake = 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                snake_hole = 0.01, -- was 0.1
                primeapebarrel = .1, -- was .05,
                cave_banana_tree = 0.005,
                spiderden = .05 -- was .01,
                -- wildborehouse = 0.25,										
            }
        }
    })

    AddRoom("MAINJungleRockSkull", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["skull_isle2"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                berrybush2 = .09, -- was .0003
                berrybush2_snake = 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                snake_hole = 0.01, -- was 0.1
                primeapebarrel = .1, -- was .05,
                cave_banana_tree = 0.005,
                spiderden = .05 -- was .01,									
            }

        }
    })
    AddRoom("MAINDoyDoyF", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["doydoyf"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                berrybush2 = .09, -- was .0003
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                spiderden = 0 -- was .01,										
            }

        }
    })
    AddRoom("MAINJungleSparse", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.25,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = .05,
                jungletree = 2, -- .6,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = .3,
                flint = .1, -- dropped
                -- saplingnova = .8,
                berrybush2 = .05, -- was .03
                berrybush2_snake = 0.01,
                -- grassnova = 1,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = .5, -- was 0.75
                bambootree = 1,
                bush_vine = .2, -- was 1
                snake_hole = 0.01, -- was 0.1
                spiderden = 0.05
                -- wildborehouse = 0.25,
            }
        }
    })

    AddRoom("MAINJungleSparseHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3, -- upped from 0.15
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = .05,
                jungletree = .6,
                rock_flintless = 0.05,
                -- rock2 = 0.05, --gold rock
                flint = .1, -- dropped
                -- grassnova = .6, --raised from 05 
                -- saplingnova = .8,
                berrybush2 = .05, -- was .03
                berrybush2_snake = 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 2, -- was 0.75,
                bambootree = 1,
                bush_vine = 1,
                snake_hole = 0.1,
                spiderden = .01
                -- wildborehouse = 0.25,
            }
        }
    })

    AddRoom("MAINJungleDense", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.4,
            distributeprefabs = {
                fireflies = 0.02, -- was 0.2,
                -- palmtree = 0.05,
                jungletree = 3, -- was 4,
                rock1 = 0.05,
                rock2 = 0.1, -- was .05
                -- grassnova = 1, --was .05
                -- saplingnova = .8,
                berrybush2 = .1,
                berrybush2_snake = 0.04,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .05,
                flower = 0.75,
                bambootree = 1,
                flint = 0.1,
                spiderden = .1, -- was .01
                bush_vine = 1,
                snake_hole = 0.1,
                -- wildborehouse = 0.03, --was 0.015,
                primeapebarrel = .2,
                cave_banana_tree = 0.01
            }
        }
    })

    AddRoom("MAINJungleDenseHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3, -- lowered from 0.4
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 4,
                rock1 = 0.05,
                -- rock2 = 0.05, --gold rock
                -- grassnova = 1, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = 0.03, -- was 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                flint = 0.1,
                spiderden = .01,
                bush_vine = 1.5,
                snake_hole = 0.1
                -- wildborehouse = 0.03, --was 0.015,
                -- wildborehouse=.05,
            }
        }
    })

    AddRoom("MAINJungleDenseMed", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.5, ---was 0.75
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- lowered from 6
                rock1 = 0.05,
                rock2 = 0.05,
                -- grassnova = .02, --was .05
                -- saplingnova = .8,
                berrybush2 = .06, -- was .03,
                berrybush2_snake = .02, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05, -- was .01,
                bush_vine = 2,
                snake_hole = 0.1
                -- wildborehouse = 0.03, --was 0.015,
            }
        }
    })

    AddRoom("MAINJungleDenseBerries", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end,
				["BerryBushBunch"] = 1
            },
            distributepercent = 0.35,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 4, -- was 6
                rock1 = 0.05,
                rock2 = 0.05,
                -- grassnova = .02, --was .05
                -- saplingnova = .8,
                berrybush2 = .6, -- was .03
                berrybush2_snake = .03, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05, -- was .01
                bush_vine = 1,
                snake_hole = 0.1
                -- wildborehouse = 0.15, --was 0.015,
            }
        }
    })

    AddRoom("MAINJungleDenseMedHome", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"ExitPiece", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.6, -- was 0.75
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 2, -- was 6
                rock_flintless = 0.05,
                berrybush2 = .06, -- was .03,
                berrybush2_snake = .02, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1, -- was 1
                spiderden = .05, -- was .01
                bush_vine = 0.8, -- was 1
                snake_hole = 0.1
            },
            countprefabs = {
                bambootree = 5,
                bush_vine = 2
            }
        }
    })

    AddRoom("MAINJunglePigGuards", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["pigguard_berries_easy"] = 1
            }, -- adds 1 per room
            distributepercent = 0.3,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 3,
                rock1 = 0.05,
                flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .8,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.75,
                bambootree = 1,
                spiderden = .05,
                bush_vine = 1,
                snake_hole = 0.1
                -- wildborehouse=.05,
            }
        }
    })

    AddRoom("MAINJungleFlower", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- was 3
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 1,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
                -- pond = 1, --frog pond
            },
            countprefabs = {
                -- butterfly_areaspawner = 6,
            }
        }
    })

    AddRoom("MAINJungleSpidersDense", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.5, -- lowered from .5
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 4,
                rock1 = 0.05,
                rock2 = 0.05,
                -- grassnova = 1, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was 0.01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 0.75,
                bambootree = 1,
                flint = 0.1,
                spiderden = .5,
                bush_vine = 1,
                snake_hole = 0.1,
                -- wildborehouse = 0.015,
                primeapebarrel = .2, -- was .05,
                cave_banana_tree = 0.01
            }
        }
    })

    AddRoom("MAINJungleSpiderCity", {
        colour = {
            r = .30,
            g = .20,
            b = .50,
            a = .50
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            countprefabs = {
                goldnugget = function()
                    return 3 + math.random(3)
                end
            },
            distributepercent = 0.3,
            distributeprefabs = {
                jungletree = 3,
                spiderden = 0.3
            },
            prefabdata = {
                spiderden = function()
                    if math.random() < 0.2 then
                        return {
                            growable = {
                                stage = 3
                            }
                        }
                    else
                        return {
                            growable = {
                                stage = 2
                            }
                        }
                    end
                end
            }
        }
    })

    AddRoom("MAINJungleBamboozled", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .4, -- was .5, 
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = .09,
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = .025,
                -- saplingnova = .04,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 0.1,
                bambootree = 1, -- was .5,
                spiderden = .05, -- was .001,
                bush_vine = .04,
                snake_hole = 0.1

            }

        }
    })

    AddRoom("MAINJungleMonkeyHell", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .3, -- was .5
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 2, -- was .4, 
                rock1 = 0.125, -- was 0.5,
                rock2 = 0.125, -- was 0.5,
                primeapebarrel = .04, -- was .8,
                skeleton = .1,
                flint = 0.5,
                -- grassnova = .75,
                -- saplingnova = .4,
                berrybush2 = .1,
                berrybush2_snake = .02,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .01,
                bambootree = 0.5,
                spiderden = .01,
                bush_vine = .04,
                snake_hole = 0.01

            },
            countprefabs = {
                cave_banana_tree = 3
            }
        }
    })

    AddRoom("MAINJungleCritterCrunch", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                fireflies = 0.5,
                -- palmtree = 0.05,
                jungletree = 3, -- was 3
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .06, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = 2,
                bambootree = 1,
                spiderden = 0.5,
                bush_vine = 0.2,
                snake_hole = 0.1,
                beehive = 1.5, -- was 3,
                wasphive = 2

            }
        }
    })

    AddRoom("MAINJungleDenseCritterCrunch", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.5, -- was 0.75
            distributeprefabs = {
                fireflies = 1,
                -- palmtree = 0.05,
                jungletree = 6,
                rock_flintless = 0.05,
                -- rock2 = 0.05, --gold rock
                -- grassnova = .05,
                -- saplingnova = .8,
                berrybush2 = .75, -- was 0.3
                berrybush2_snake = .04, -- was .01,
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1.5,
                bambootree = 1, -- was 1
                spiderden = .05, -- was .5,
                bush_vine = 0.8, -- was 1
                snake_hole = 0.1,
                -- wildborehouse = 0.03, --was 0.015,
                beehive = .01 -- was 2,
            }
        }
    })

    AddRoom("MAINJungleShroomin", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = .5,
                jungletree = 3,
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = 1, --was .4,
                -- saplingnova = .3,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .07, -- was .01,
                red_mushroom = 3,
                green_mushroom = 3,
                blue_mushroom = 2,
                flower = 0.7,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = .5,
                snake_hole = 0.1

            }
        }
    })

    AddRoom("MAINJungleRockyDrop", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .35,
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 6,
                rock1 = 1, -- was 3
                rock2 = .5, -- was 2
                rock_flintless = 2,
                rocks = 3,
                -- flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .07, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .9,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("MAINJungleGrassy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- was 3
                rock1 = 0.05,
                -- flint=0.05,
                -- grassnova = 5,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .2,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("MAINJungleSappy", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 1.5, -- was 3
                rock1 = 0.05,
                -- flint = 0.05,
                -- grassnova = .025,
                saplingnova = 6,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .3,
                bambootree = 0.5,
                spiderden = .001,
                bush_vine = 0.3,
                snake_hole = 0.1
            }
        }
    })

    AddRoom("MAINJungleEvilFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 2, -- was 3
                rock1 = 0.05,
                -- flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .9,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1,
                flower_evil = 10,
                wasphive = 0.25 -- just added
            }

        }
    })

    AddRoom("MAINJungleParrotSanctuary", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.9,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = .5,
                rock1 = 0.5,
                rock2 = 0.5,
                rocks = 0.4,
                -- grassnova = 0.5, --was .05
                -- saplingnova  = 8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.2,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.05, --was 0.005,
                primeapebarrel = 0.05,
                fireflies = 0.02,
                cave_banana_tree = 0.02
            }

        }
    })

    AddRoom("MAINJungleNoBerry", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.3,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5, -- was .5,
                rock1 = 0.5,
                rock2 = 0.5,
                rocks = 0.4,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.2,
                bambootree = 3, -- was 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.05, --was 0.005,
                primeapebarrel = 0.05,
                fireflies = 0.02,
                cave_banana_tree = 0.02
            }

        }
    })

    AddRoom("MAINJungleNoRock", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.2,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .05,
                berrybush2_snake = 0.01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.2,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.005,
                primeapebarrel = .25, -- was .05,
                fireflies = 0.02,
                cave_banana_tree = 0.02
            }

        }
    })

    AddRoom("MAINJungleNoMushroom", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {

            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = 0.4, -- was 0.2
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = 0.04,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                flower = 0.2,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.05, --was 0.005,
                primeapebarrel = .15, -- was .05,
                fireflies = 0.02,
                cave_banana_tree = 0.01
            }

        }
    })

    AddRoom("MAINJungleNoFlowers", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {

            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },

            distributepercent = 0.2,
            distributeprefabs = {
                -- palmtree = 0.05,
                jungletree = 5,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = 0.04,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.25,
                primeapebarrel = .15, -- was .05,
                -- pond = 0.05,
                fireflies = 0.02,
                cave_banana_tree = 0.01
            }

        }
    })

    AddRoom("MAINJungleMorePalms", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5,
            distributeprefabs = {
                -- palmtree = 3,
                jungletree = .3,
                rock1 = 0.05,
                rock2 = 0.05,
                rocks = 0.04,
                -- grassnova = 0.6, --was .05
                -- saplingnova = .8,
                berrybush2 = .1, -- was .05,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = 0.05,
                green_mushroom = 0.03,
                blue_mushroom = 0.02,
                flower = 0.6,
                bambootree = 0.5,
                flint = 0.001,
                spiderden = 0.5,
                bush_vine = 0.9,
                snake_hole = 0.1,
                -- wildborehouse = 0.005,
                primeapebarrel = .15, -- was .05,
                fireflies = 0.02,
                cave_banana_tree = 0.01
            }

        }
    })

    AddRoom("MAINDoyDoyM", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            countstaticlayouts = {
                ["doydoym"] = 1
            }, -- adds 1 per room
            distributepercent = .1, -- Lowered a bit
            distributeprefabs = {
                fireflies = 0.2,
                jungletree = 3,
                rock1 = 0.05, -- was .01
                rock2 = 0.1, -- was .05
                flint = 0.1, -- was 0.03,
                berrybush2 = .09, -- was .0003
                red_mushroom = .03,
                green_mushroom = .02,
                blue_mushroom = .02,
                flower = 1, -- was 0.75,
                bambootree = 1,
                bush_vine = .2, -- was 1
                primeapebarrel = .1, -- was .05,
                spiderden = 0 -- was .01,											
            }

        }
    })

    AddRoom("MAINJungleSkeleton", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["LivingJungleTree"] = function()
                    return (math.random() > LIVINGJUNGLETREE_CHANCE and 1) or 0
                end
            },
            distributepercent = .5, -- was 0.35
            distributeprefabs = {
                fireflies = 0.2,
                -- palmtree = 0.05,
                jungletree = 1.5, -- was 3
                rock1 = 0.05,
                -- flint = 0.05,
                -- grassnova = .025,
                -- saplingnova = .4,
                berrybush2 = .05, -- was .01,
                berrybush2_snake = .05, -- was .01,
                red_mushroom = .06,
                green_mushroom = .04,
                blue_mushroom = .04,
                flower = .9,
                bambootree = 0.5,
                spiderden = .05, -- was .001
                bush_vine = 1,
                snake_hole = 0.1,
                flower_evil = .001,
                skeleton = 1.25
            }
        }
    })

    -------------------------------------start room to portal room-------------------------------------------------------------
    AddRoom("MAINBeachPortalRoom", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            -- countstaticlayouts={["shipwrecked_start"]=1}, 
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = .05,
                crabhole = .2,
                palmtree = .5,
                rocks = .03, -- trying
                rock1 = .1, -- trying
                -- rock2 = .2,
                beehive = .01, -- was .05, 
                -- flower = .04, --trying
                grassnova = .2, -- trying
                saplingnova = .2, -- trying
                -- fireflies = .02, --trying
                -- spiderden = .03, --trying
                flint = .05,
                sandhill = .6,
                seashell_beached = .02,
                wildborehouse = .005,
                crate = .01
            },
            countprefabs = {
                spawnpoint_multiplayer = 1
                -- vidanomar = 1,
                -- lake = 1,
            }

        }
    })

    AddRoom("MAINPigVillagesw", {
        colour = {
            r = 0.3,
            g = .8,
            b = .5,
            a = .50
        },
        value = GROUND.JUNGLE,
        tags = {"Chester_Eyebone", "RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["Farmplot"] = function()
                    return math.random(2, 5)
                end,
                ["wildboreking"] = 1
            },

            countprefabs = {
                firepit = 1,
                wildborehouse = function()
                    return 3 + math.random(4)
                end
            },
            distributepercent = .1,
            distributeprefabs = {
                grassnova = .05,
                berrybush2 = .05,
                berrybush_juicy = 0.025
            }
        }
    })

    ----------------------------------------------Ham caves---------------------------------------------------------------------------
    -- plainscave
    AddRoom("HamLightPlantField", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .4,
            distributeprefabs = {
                flower_cave = 1.0,
                flower_cave_double = 0.5,
                flower_cave_triple = 0.5,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,

                pig_ruins_head = 0.02,
                flower_rainforest = 2,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 1,
                deep_jungle_fern_noise_plant2 = 1,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            }
        }
    })

    -- plainscave 2
    AddRoom("HamLightPlantFieldexit", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .4,
            distributeprefabs = {
                flower_cave = 1.0,
                flower_cave_double = 0.5,
                flower_cave_triple = 0.5,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,

                pig_ruins_head = 0.02,
                flower_rainforest = 2,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05
            },
            countprefabs = {
                cave_exit_ham1 = 1
            }
        }
    })

    -- plainscave 3
    AddRoom("HamWormPlantField", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,

                pillar_cave_flintless = 0.02,

                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.01,
                asparagus_planted = 0.05,

                wormlight_plant = 0.2

            }
        }
    })

    -- plainscave 4 fern
    AddRoom("HamFernGully", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .5,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- plainscave
    AddRoom("HamSlurtlePlains", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .4,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- plainscave
    AddRoom("HamMudWithRabbit", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- plainscave
    AddRoom("HamMudWithRabbitexit", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05

            },
            countprefabs = {
                cave_exit_ham2 = 1
            }
        }
    })

    -- plainscave
    AddRoom("HamBGMud", {
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.SINKHOLE,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.02,
                pig_ruins_pig = 0.02,
                pig_ruins_light_beam = 0.02,
                pig_ruins_head = 0.02,
                pillar_cave_flintless = 0.02,
                deep_jungle_fern_noise_plant = 0.5,
                deep_jungle_fern_noise_plant2 = 0.5,
                clawpalmtree = 0.5,
                grass_tall = 1,
                sapling = .3,
                flower = 0.05,
                peagawk = 0.01,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                pog = 0.03,
                asparagus_planted = 0.05,

                cave_fern = 2.0,
                wormlight_plant = 0.05
            }
        }
    })

    -- cave iron
    AddRoom("HamBatCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                goldnugget = .05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            }
        }
    })

    -- cave iron
    AddRoom("HamBattyCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                goldnugget = .05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.1,
                slurtlehole = 0.5
            }
        }
    })
    -- cave iron
    AddRoom("HamFernyBatCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                goldnugget = .05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            }
        }
    })

    -- cave iron
    AddRoom("HamFernyBatCaveexit", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                cave_fern = 0.5,
                goldnugget = .05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            },
            countprefabs = {
                cave_exit_ham3 = 1
            }
        }
    })

    -- caveiron
    AddRoom("HamBGBatCaveRoom", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.MUD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .13,
            distributeprefabs = {
                cave_fern = 0.5,
                goldnugget = .05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                pillar_cave_rock = 0.08,
                fissure = 0.05,
                tubertree = 1,
                gnatmound = 0.1,
                rocks = 0.1,
                nitre = 0.1,
                flint = 0.05,
                iron = 0.3,
                --            thunderbirdnest = 0.1,
                sedimentpuddle = 0.2,
                pangolden = 0.02,
                slurtlehole = 0.5
            }
        }
    })

    -- fip
    AddRoom("HamSlurtleCanyon", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                rock_flintless = 1.0,
                rock_flintless_med = 1.0,
                rock_flintless_low = 1.0,
                pillar_cave_flintless = 0.2,

                stalagmite_tall = 0.5,
                stalagmite_tall_med = 0.2,
                stalagmite_tall_low = 0.2,
                fissure = 0.01,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2
            }
        }
    })

    -- fip
    AddRoom("HamBatsAndSlurtles", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                rock_flintless = 1.0,
                rock_flintless_med = 1.0,
                rock_flintless_low = 1.0,
                pillar_cave_flintless = 0.2,
                stalagmite_tall = 0.5,
                stalagmite_tall_med = 0.2,
                deco_hive_debris = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2,
                antchest = 1
            }
        }
    })

    -- fip
    AddRoom("HamRockyPlains", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                antcombhomecave = 0.15,
                sapling = 0.2,
                guano = 0.27,
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                fissure = 0.05,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2,
                pond_cave = 2
            }
        }
    })

    -- fip
    AddRoom("HamRockyPlainsexit", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,
                ant_cave_lantern = 0.1,
                rock_flippable = 0.7,
                rock_antcave = 0.3,
                sapling = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                antcombhomecave = 1,
                giantgrubspawner = 1
            }
        }
    })

    -- fip
    AddRoom("HamRockyHatchingGrounds", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .30,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2
            }
        }
    })

    -- fip
    AddRoom("HamBatsAndRocky", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},
        type = GLOBAL.NODE_TYPE.SeparatedRoom,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
        contents = {
            countstaticlayouts = {
                ["antqueencave"] = 1
            },
            distributepercent = .35,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                --		antchest = 1,
            }
        }
    })

    -- fip
    AddRoom("HamBGRockyCaveRoom", {
        colour = {
            r = 0.7,
            g = 0.7,
            b = 0.7,
            a = 0.9
        },
        value = GROUND.MUD,
        --    tags = {"Hutch_Fishbowl"},	
        type = GLOBAL.NODE_TYPE.Room,
        internal_type = GLOBAL.NODE_INTERNAL_CONNECTION_TYPE.EdgeSite,
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,
                rock_flippable = 0.3,
                rock_antcave = 0.7,
                sapling = 0.2,
                deco_cave_ceiling_drip_2 = 0.1
            },
            countprefabs = {
                antcombhomecave = 2,
                giantgrubspawner = 1,
                ant_cave_lantern = 2
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamRedMushForest", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,
                stalagmite = 0.5,
                spiderhole = 0.05,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamRedSpiderForest", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,
                stalagmite = 1.5,
                spiderhole = 0.4,
                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamRedSpiderForestexit", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,
                spiderhole = 0.4,
                stalagmite = 0.2,
                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamRedMushPillars", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                mushtree_yelow = 6.0,
                yelow_mushroom = 0.9,
                stalagmite = 0.5,
                spiderhole = 0.01,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamStalagmiteForest", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,
                stalagmite = 3.5,
                spiderhole = 0.15,
                pillar_cave = 0.5,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamSpillagmiteMeadow", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,
                stalagmite = 1.5,
                spiderhole = 0.45,
                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            },
            countprefabs = {
                maze_pig_ruins_entrance2 = 1
            }
        }
    })

    -- Gass MIX MUSH
    AddRoom("HamBGRedMush", {
        colour = {
            r = 0.8,
            g = 0.1,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_yelow = 9.0,
                yelow_mushroom = 0.9,

                pillar_cave = 0.05,
                cavelight = 0.6,
                --			poisonmist = 8,
                rock_flippable = 0.05,
                jungle_border_vine = 0.5,
                pig_ruins_torch = 0.2,
                pig_ruins_head = 0.5,
                pig_ruins_pig = 0.5,
                pig_ruins_ant = 0.5
            }
        }
    })

    -- Green mush forest
    AddRoom("HamGreenMushForest", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.1,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- green
    AddRoom("HamGreenMushPonds", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                pond = 1,

                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- Greenmush Sinkhole
    AddRoom("HamGreenMushSinkhole", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            countstaticlayouts = {
                ["EvergreenSinkhole"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight_small = 0.05,
                grass = 0.1,
                sapling = 0.1,
                twiggytree = 0.04,
                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,
                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- green
    AddRoom("HamGreenMushMeadow", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                cavelight_small = 0.05,

                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            },
            countprefabs = {
                maze_pig_ruins_entrance = 1
            }
        }
    })

    -- green
    AddRoom("HamGreenMushRabbits", {
        colour = {
            r = 0.1,
            g = 0.8,
            b = 0.3,
            a = 0.9
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            countstaticlayouts = {
                ["farm_3"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                grass = 0.1,
                sapling = 0.1,
                twiggytree = 0.04,

                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            },
            countprefabs = {
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    -- Green Mush and Sinkhole Noise
    AddRoom("HamGreenMushNoise", {
        colour = {
            r = .36,
            g = .32,
            b = .38,
            a = .50
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- Green
    AddRoom("HamBGGreenMush", {
        colour = {
            r = .36,
            g = .32,
            b = .38,
            a = .50
        },
        value = GROUND.RAINFOREST,
        tags = {"Hutch_Fishbowl", "folha"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                mushtree_small = 5.0,
                green_mushroom = 3.0,
                flower_cave = 0.2,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.1,

                spider_monkey_tree = 1,
                spider_monkey = 1,
                rainforesttree = 6, -- 4,
                pillar_cave = 1, -- 0.5,
                flower_rainforest = 4,
                berrybush_juicy = 2,
                cavelight = 0.6,
                deep_jungle_fern_noise = 2,
                jungle_border_vine = 2,
                fireflies = 0.2,
                hanging_vine_patch = 2,
                pig_ruins_torch = 0.02,
                rock_flippable = 0.1
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBlueMushForest", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .5,
            distributeprefabs = {
                mushtree_tall = 4.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBlueMushMeadow", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_tall = 1.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBlueSpiderForest", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            countstaticlayouts = {
                ["mandraketown"] = 1
            },

            distributepercent = .3,
            distributeprefabs = {
                mushtree_tall = 3.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            },
            countprefabs = {
                cavelight = 3,
                cavelight_small = 3,
                cavelight_tiny = 3
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamDropperDesolation", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .2,
            distributeprefabs = {
                mushtree_tall = 1.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- Blue mush forest
    AddRoom("HamBGBlueMush", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MEADOW,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .5,
            distributeprefabs = {
                mushtree_tall = 5.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                sapling = 1,
                grass_tall = 3,
                ox = 0.5,
                teatree = 0.8,
                teatree_piko_nest_patch = 0.5
            }
        }
    })

    -- vampire
    AddRoom("HamSpillagmiteForest", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.FUNGUS,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                deco_cave_ceiling_trim = 0.3,
                deco_cave_beam_room = 0.3,
                stalagmite = 0.3,
                stalagmite_tall = 0.3,
                deco_cave_stalactite = 0.3,
                rocks = 0.3,
                twigs = 1,
                cave_fern = 0.8,
                deco_cave_bat_burrow = 0.2,
                mushtree_medium = 1.0,
                spiderhole = 0.1
            }
        }
    })

    -- vampire
    AddRoom("HamDropperCanyon", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.FUNGUS,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                deco_cave_ceiling_trim = 0.3,
                deco_cave_beam_room = 0.3,
                stalagmite = 0.3,
                stalagmite_tall = 0.3,
                deco_cave_stalactite = 0.3,
                rocks = 0.3,
                twigs = 1,
                cave_fern = 0.8,
                deco_cave_bat_burrow = 0.2,
                mushtree_medium = 1.0,
                spiderhole = 0.1
            }
        }
    })

    -- vampire
    AddRoom("HamStalagmitesAndLights", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.FUNGUS,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                deco_cave_ceiling_trim = 0.3,
                deco_cave_beam_room = 0.3,
                stalagmite = 0.3,
                stalagmite_tall = 0.3,
                deco_cave_stalactite = 0.3,
                rocks = 0.3,
                twigs = 1,
                cave_fern = 0.8,
                deco_cave_bat_burrow = 0.2,
                mushtree_medium = 1.0,
                spiderhole = 0.1
            }
        }
    })

    -- red
    AddRoom("HamSpidersAndBats", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                dropperweb = 0.2,
                mushtree_medium = 2.0
            }
        }
    })

    -- red
    AddRoom("HamThuleciteDebris", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .20,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                dropperweb = 0.2,
                mushtree_medium = 2.0
            }
        }
    })

    -- red
    AddRoom("HamBGSpillagmite", {
        colour = {
            r = 0.4,
            g = 0.4,
            b = 0.4,
            a = 0.9
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        tags = {"Hutch_Fishbowl"},
        contents = {
            distributepercent = .35,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                --		   dropperweb= 0.2,
                mushtree_medium = 2.0
            }
        }
    })

    -- red não usado
    AddRoom("HamCaveExitRoom", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.QUAGMIRE_PARKFIELD,
        contents = {
            countstaticlayouts = {
                ["CaveExit"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                flower_cave_triple = 0.1,
                pillar_cave_rock = 0.1,

                rock1 = 0.1,
                flint = 0.1,
                roc_nest_tree1 = 0.1,
                roc_nest_tree2 = 0.1,
                roc_nest_branch1 = 0.5,
                roc_nest_branch2 = 0.5,
                roc_nest_bush = 1,
                rocks = 0.5,
                twigs = 1,
                rock2 = 0.1,
                --		   tallbirdnest= 0.2,
                mushtree_medium = 2.0
            }
        }
    })
    --------------------------------------------------------------------------together island task-------------------------------------------------------------------------------------------------------------------------------------

    AddTask("MDig that rock", {
        locks = {},
        keys_given = {},
        region_id = "together1",
        room_choices = {
            ["Graveyard"] = 1,
            ["Rocky"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["CritterDen"] = function()
                return 1
            end,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.ROCKY,
        background_room = "BGNoise",
        colour = {
            r = 0,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("MGreat Plains", {
        locks = {},
        keys_given = {},
        region_id = "together2",
        room_choices = {
            ["BeefalowPlain"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            -- ["Wormhole_Plains"] = 1,
            ["Plain"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 2
        },
        room_bg = GROUND.SAVANNA,
        background_room = "BGSavanna",
        colour = {
            r = 0,
            g = 1,
            b = 1,
            a = 1
        }
    })

    AddTask("MSqueltch", {
        locks = {},
        keys_given = {},
        region_id = "together3",
        room_choices = {
            ["Marsh"] = function()
                return 5 + math.random(SIZE_VARIATION)
            end,
            -- ["Forest"] = function() return math.random(SIZE_VARIATION) end, 
            -- ["DeepForest"] = function() return 1+math.random(SIZE_VARIATION) end,
            ["SlightlyMermySwamp"] = 1
        },
        room_bg = GROUND.MARSH,
        background_room = "BGMarsh",
        colour = {
            r = .05,
            g = .05,
            b = .05,
            a = 1
        }
    })

    AddTask("MBeeeees!", {
        locks = {},
        keys_given = {},
        region_id = "together4",
        room_choices = {
            ["BeeClearing"] = 1,
            -- ["Wormhole"] = 1,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION) - 1
            end,
            ["BeeQueenBee"] = 1,
            ["FlowerPatch"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 0,
            g = 1,
            b = 0.3,
            a = 1
        }
    })

    AddTask("MSpeak to the king", {
        locks = {},
        keys_given = {},
        region_id = "together5",
        room_choices = {
            ["PigKingdom"] = 1,
            ["MagicalDeciduous"] = 1,
            ["DeepDeciduous"] = function()
                return 3 + math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGDeciduous",
        colour = {
            r = 1,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("MForest hunters", {
        locks = {},
        keys_given = {},
        region_id = "together6",
        room_choices = {
            ["WalrusHut_Grassy"] = 1,
            -- ["Wormhole"] = 1,
            ["Forest"] = 1,
            ["ForestMole"] = 2,
            ["DeepForest"] = 1,
            ["Clearing"] = 1,
            ["MoonbaseOne"] = 1
        },
        room_bg = GROUND.FOREST,
        background_room = "BGForest",
        colour = {
            r = .15,
            g = .5,
            b = .05,
            a = 1
        }
    })

    AddTask("MBadlands", {
        locks = {},
        keys_given = {},
        region_id = "together7",
        room_choices = {
            ["DragonflyArena"] = 1,
            ["Badlands"] = 2,
            ["HoundyBadlands"] = function()
                return (math.random() < 0.33) and 2 or 1
            end,
            ["BarePlain"] = 1,
            ["BuzzardyBadlands"] = function()
                return (math.random() < 0.5) and 2 or 1
            end
        },
        room_bg = GROUND.DIRT,
        background_room = "BGBadlands",
        colour = {
            r = 1,
            g = 0.6,
            b = 1,
            a = 1
        }
    })

    AddTask("MFor a nice walk", {
        locks = {},
        keys_given = {},
        region_id = "together8",
        room_choices = {
            ["BeefalowPlain"] = 1,
            ["MandrakeHome"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            -- ["Wormhole"] = 1,
            ["DeepForest"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.FOREST,
        background_room = "BGForest",
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("MLightning Bluff", {
        locks = {},
        keys_given = {},
        region_id = "together9",
        room_choices = {
            ["LightningBluffAntlion"] = 1,
            ["LightningBluffLightning"] = 1,
            ["LightningBluffOasis"] = 1,
            ["BGLightningBluff"] = 2
        },
        room_bg = GROUND.DIRT,
        background_room = "BGLightningBluff",
        colour = {
            r = .05,
            g = .5,
            b = .05,
            a = 1
        }
    })

    ------------options tasks---- 	

    AddTask("MBefriend the pigs", {
        locks = {},
        keys_given = {},
        region_id = "together10",
        room_choices = {
            ["PigVillage"] = 1,
            -- ["Wormhole"] = 1,
            ["Forest"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Marsh"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["DeepForest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 1
        },
        room_bg = GROUND.FOREST,
        background_room = "BGForest",
        colour = {
            r = 1,
            g = 0,
            b = 0,
            a = 1
        }
    })

    AddTask("MKill the spiders", {
        locks = {},
        keys_given = {},
        region_id = "together11",
        room_choices = {
            ["SpiderVillage"] = 2,
            -- ["Wormhole"] = 1,
            ["CrappyForest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["CrappyDeepForest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 1
        },
        room_bg = GROUND.ROCKY,
        background_room = "BGRocky",
        colour = {
            r = .25,
            g = .4,
            b = .06,
            a = 1
        }
    })

    AddTask("MKiller bees!", {
        locks = {},
        keys_given = {},
        region_id = "together12",
        entrance_room = "Waspnests1",
        room_choices = {
            -- ["Wormhole"] = 1,
            ["Waspnests1"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["FlowerPatch"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 1,
            g = 0.1,
            b = 0.1,
            a = 1
        }
    })

    AddTask("MMake a Beehat", {
        locks = {},
        keys_given = {},
        region_id = "together13",
        room_choices = {
            -- ["Wormhole_Plains"] = 1,
            ["Rocky"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["FlowerPatch"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 1,
            g = 1,
            b = 0.5,
            a = 1
        }
    })

    AddTask("MThe hunters", {
        locks = {},
        keys_given = {},
        region_id = "together14",
        room_choices = {
            ["WalrusHut_Plains"] = 1,
            ["WalrusHut_Grassy"] = 1,
            ["WalrusHut_Rocky"] = 1,
            ["Clearing"] = 2,
            ["BGGrass"] = 2,
            ["BGRocky"] = 2
        },
        room_bg = GROUND.SAVANNA,
        background_room = "BGSavanna",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("MMagic meadow", {
        locks = {},
        keys_given = {},
        region_id = "together15",
        room_choices = {
            ["Pondopolis"] = 2,
            ["Clearing"] = 2 -- have to have at least a few rooms for tagging
        },
        room_bg = GROUND.FOREST,
        background_room = "Clearing",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("MFrogs and bugs", {
        locks = {},
        keys_given = {},
        region_id = "together16",
        room_choices = {
            ["Pondopolis"] = 1,
            ["BeeClearing"] = 1,
            ["FlowerPatch"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 2,
            ["GrassyMoleColony"] = 1
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("MMole Colony Deciduous", {
        locks = {},
        keys_given = {},
        region_id = "together17",
        room_choices = {
            ["MolesvilleDeciduous"] = 1,
            ["DeepDeciduous"] = 2,
            ["DeciduousMole"] = 2,
            ["DeciduousClearing"] = 1
        },
        room_bg = GROUND.DECIDUOUS,
        background_room = "BGDeciduous",
        colour = {
            r = .15,
            g = .5,
            b = .05,
            a = 1
        }
    })

    AddTask("MMole Colony Rocks", {
        locks = {},
        keys_given = {},
        region_id = "together18",
        room_choices = {
            ["RockyBuzzards"] = 1,
            -- ["Wormhole"] = 1,
            ["GenericRockyNoThreat"] = function()
                return 2 + math.random(SIZE_VARIATION)
            end,
            ["MolesvilleRocky"] = 1
        },
        room_bg = GROUND.ROCKY,
        background_room = "BGRocky",
        colour = {
            r = 1,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("MMooseBreedingTask", {
        locks = {},
        keys_given = {},
        region_id = "together19",
        room_choices = {
            ["MooseGooseBreedingGrounds"] = 1
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 1,
            g = 0.7,
            b = 1,
            a = 1
        }
    })
    --------------------------------------------------------------------------together continent task-------------------------------------------------------------------------------------------------------------------------------------
    AddRoom("Waspnests1", {
        colour = {
            r = 0.9,
            g = 0.1,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.GRASS,
        tags = {"ForceConnected", "RoadPoison"},
        contents = {
            distributepercent = 0.5,
            distributeprefabs = {
                flower = 6,
                beehive = 1,
                grass = 2,
                wasphive = 1
            }
        }
    })

    AddTask("XDig that rock", {
        locks = {},
        keys_given = {},
        region_id = "togethercontinent",
        room_choices = {
            ["Graveyard"] = 1,
            ["Rocky"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["CritterDen"] = function()
                return 1
            end,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.ROCKY,
        background_room = "BGNoise",
        colour = {
            r = 0,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("XGreat Plains", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["BeefalowPlain"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            -- ["Wormhole_Plains"] = 1,
            ["Plain"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 2
        },
        room_bg = GROUND.SAVANNA,
        background_room = "BGSavanna",
        colour = {
            r = 0,
            g = 1,
            b = 1,
            a = 1
        }
    })

    AddTask("XSqueltch", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["Marsh"] = function()
                return 5 + math.random(SIZE_VARIATION)
            end,
            -- ["Forest"] = function() return math.random(SIZE_VARIATION) end, 
            -- ["DeepForest"] = function() return 1+math.random(SIZE_VARIATION) end,
            ["SlightlyMermySwamp"] = 1
        },
        room_bg = GROUND.MARSH,
        background_room = "BGMarsh",
        colour = {
            r = .05,
            g = .05,
            b = .05,
            a = 1
        }
    })

    AddTask("XBeeeees!", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["BeeClearing"] = 1,
            -- ["Wormhole"] = 1,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION) - 1
            end,
            ["BeeQueenBee"] = 1,
            ["FlowerPatch"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 0,
            g = 1,
            b = 0.3,
            a = 1
        }
    })

    AddTask("XSpeak to the king", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["PigKingdom"] = 1,
            ["MagicalDeciduous"] = 1,
            ["DeepDeciduous"] = function()
                return 3 + math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGDeciduous",
        colour = {
            r = 1,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("XForest hunters", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["WalrusHut_Grassy"] = 1,
            -- ["Wormhole"] = 1,
            ["Forest"] = 1,
            ["ForestMole"] = 2,
            ["DeepForest"] = 1,
            ["Clearing"] = 1,
            ["MoonbaseOne"] = 1
        },
        room_bg = GROUND.FOREST,
        background_room = "BGForest",
        colour = {
            r = .15,
            g = .5,
            b = .05,
            a = 1
        }
    })

    AddTask("XBadlands", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["DragonflyArena"] = 1,
            ["Badlands"] = 2,
            ["HoundyBadlands"] = function()
                return (math.random() < 0.33) and 2 or 1
            end,
            ["BarePlain"] = 1,
            ["BuzzardyBadlands"] = function()
                return (math.random() < 0.5) and 2 or 1
            end
        },
        room_bg = GROUND.DIRT,
        background_room = "BGBadlands",
        colour = {
            r = 1,
            g = 0.6,
            b = 1,
            a = 1
        }
    })

    AddTask("XFor a nice walk", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["BeefalowPlain"] = 1,
            ["MandrakeHome"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            -- ["Wormhole"] = 1,
            ["DeepForest"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.FOREST,
        background_room = "BGForest",
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("XLightning Bluff", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["LightningBluffAntlion"] = 1,
            ["LightningBluffLightning"] = 1,
            ["LightningBluffOasis"] = 1,
            ["BGLightningBluff"] = 2
        },
        room_bg = GROUND.DIRT,
        background_room = "BGLightningBluff",
        colour = {
            r = .05,
            g = .5,
            b = .05,
            a = 1
        }
    })

    ------------options tasks---- 	

    AddTask("XBefriend the pigs", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["PigVillage"] = 1,
            -- ["Wormhole"] = 1,
            ["Forest"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Marsh"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["DeepForest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 1
        },
        room_bg = GROUND.FOREST,
        background_room = "BGForest",
        colour = {
            r = 1,
            g = 0,
            b = 0,
            a = 1
        }
    })

    AddTask("XKill the spiders", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["SpiderVillage"] = 2,
            -- ["Wormhole"] = 1,
            ["CrappyForest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["CrappyDeepForest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 1
        },
        room_bg = GROUND.ROCKY,
        background_room = "BGRocky",
        colour = {
            r = .25,
            g = .4,
            b = .06,
            a = 1
        }
    })

    AddTask("XKiller bees!", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        entrance_room = "Waspnests1",
        room_choices = {
            -- ["Wormhole"] = 1,
            ["Waspnests1"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["Forest"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["FlowerPatch"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 1,
            g = 0.1,
            b = 0.1,
            a = 1
        }
    })

    AddTask("XMake a Beehat", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            -- ["Wormhole_Plains"] = 1,
            ["Rocky"] = function()
                return math.random(SIZE_VARIATION)
            end,
            ["FlowerPatch"] = function()
                return math.random(SIZE_VARIATION)
            end
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 1,
            g = 1,
            b = 0.5,
            a = 1
        }
    })

    AddTask("XThe hunters", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["WalrusHut_Plains"] = 1,
            ["WalrusHut_Grassy"] = 1,
            ["WalrusHut_Rocky"] = 1,
            ["Clearing"] = 2,
            ["BGGrass"] = 2,
            ["BGRocky"] = 2
        },
        room_bg = GROUND.SAVANNA,
        background_room = "BGSavanna",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("XMagic meadow", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["Pondopolis"] = 2,
            ["Clearing"] = 2 -- have to have at least a few rooms for tagging
        },
        room_bg = GROUND.FOREST,
        background_room = "Clearing",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("XFrogs and bugs", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["Pondopolis"] = 1,
            ["BeeClearing"] = 1,
            ["FlowerPatch"] = function()
                return 1 + math.random(SIZE_VARIATION)
            end,
            ["Clearing"] = 2,
            ["GrassyMoleColony"] = 1
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("XMole Colony Deciduous", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["MolesvilleDeciduous"] = 1,
            ["DeepDeciduous"] = 2,
            ["DeciduousMole"] = 2,
            ["DeciduousClearing"] = 1
        },
        room_bg = GROUND.DECIDUOUS,
        background_room = "BGDeciduous",
        colour = {
            r = .15,
            g = .5,
            b = .05,
            a = 1
        }
    })

    AddTask("XMole Colony Rocks", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["RockyBuzzards"] = 1,
            -- ["Wormhole"] = 1,
            ["GenericRockyNoThreat"] = function()
                return 2 + math.random(SIZE_VARIATION)
            end,
            ["MolesvilleRocky"] = 1
        },
        room_bg = GROUND.ROCKY,
        background_room = "BGRocky",
        colour = {
            r = 1,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("XMooseBreedingTask", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        region_id = "togethercontinent",
        room_choices = {
            ["MooseGooseBreedingGrounds"] = 1
        },
        room_bg = GROUND.GRASS,
        background_room = "BGGrass",
        colour = {
            r = 1,
            g = 0.7,
            b = 1,
            a = 1
        }
    })

    --------------------------------------------------moon island task---------------------------------------------------
    AddTask("XMoonIsland_IslandShards", {
        locks = {},
        keys_given = {},
        region_id = "moon1",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "nohunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_IslandShard"] = function()
                return 3 + math.random(2)
            end,
            ["Empty_Cove"] = 2
        },
        room_bg = GROUND.PEBBLEBEACH,
        background_room = "Empty_Cove",
        cove_room_name = "Blank",
        make_loop = true,
        crosslink_factor = 2,
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("XMoonIsland_Beach", {
        locks = {},
        keys_given = {},
        region_id = "moon2",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        entrance_room = "MoonIsland_Blank",
        room_choices = {
            ["MoonIsland_Beach"] = 2
        },
        room_bg = GROUND.PEBBLEBEACH,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        make_loop = true,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("XMoonIsland_Forest", {
        locks = {},
        keys_given = {},
        region_id = "moon3",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_Forest"] = 3
        },
        room_bg = GROUND.METEOR,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        crosslink_factor = 1,
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("XMoonIsland_Mine", {
        locks = {},
        keys_given = {},
        region_id = "moon4",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_Mine"] = 3
        },
        room_bg = GROUND.METEOR,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = .05,
            g = .5,
            b = .05,
            a = 1
        }
    })

    AddTask("XMoonIsland_Baths", {
        locks = {},
        keys_given = {},
        region_id = "moon5",
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_Baths"] = 2,
            ["MoonIsland_Meadows"] = 2
        },
        room_bg = GROUND.METEOR,
        background_room = "MoonIsland_Meadows",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        required_prefabs = {"moon_fissure", "moon_altar_rock_glass", "moon_altar_rock_seed", "moon_altar_rock_idol"},
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    --------------------------------------------moon merged-----------------------------------------
    AddTask("MMoonIsland_IslandShards", {
        locks = {LOCKS.NONE},
        keys_given = {KEYS.ISLAND_TIER2},
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "nohunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_IslandShard"] = function()
                return 3 + math.random(2)
            end,
            ["Empty_Cove"] = 2
        },
        room_bg = GROUND.PEBBLEBEACH,
        background_room = "Empty_Cove",
        cove_room_name = "Blank",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("MMoonIsland_Beach", {
        locks = {LOCKS.ISLAND_TIER2},
        keys_given = {KEYS.ISLAND_TIER3},
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        entrance_room = "MoonIsland_Blank",
        room_choices = {
            ["MoonIsland_Beach"] = 2
        },
        room_bg = GROUND.PEBBLEBEACH,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("MMoonIsland_Forest", {
        locks = {LOCKS.ISLAND_TIER4},
        keys_given = {},
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_Forest"] = 3
        },
        room_bg = GROUND.METEOR,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        crosslink_factor = 1,
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("MMoonIsland_Mine", {
        locks = {LOCKS.ISLAND_TIER4},
        keys_given = {},
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_Mine"] = 3
        },
        room_bg = GROUND.METEOR,
        background_room = "Empty_Cove",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        colour = {
            r = .05,
            g = .5,
            b = .05,
            a = 1
        }
    })

    AddTask("MMoonIsland_Baths", {
        locks = {LOCKS.ISLAND_TIER3},
        keys_given = {KEYS.ISLAND_TIER4},
        level_set_piece_blocker = true,
        room_tags = {"RoadPoison", "moonhunt", "nohasslers", "lunacyarea", "not_mainland"},
        room_choices = {
            ["MoonIsland_Baths"] = 2,
            ["MoonIsland_Meadows"] = 2
        },
        room_bg = GROUND.METEOR,
        background_room = "MoonIsland_Meadows",
        cove_room_name = "Empty_Cove",
        cove_room_chance = 1,
        cove_room_max_edges = 2,
        required_prefabs = {"moon_fissure", "moon_altar_rock_glass", "moon_altar_rock_seed", "moon_altar_rock_idol"},
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })
    ----------------------------------------- ROT -----------------------------------------------------------------------------
    ----------------------organizar aqui ainda------------------------
    ---------------------------------------------------------
    AddRoom("PorklandPortalRoom", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PLAINS,
        tags = {"RoadPoison", "Chester_Eyebone"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                clawpalmtree = .25,
                grass_tall = 1,
                flower = 0.05,
                pog = 0.1,
                randomdust = 0.0025,
                rock_flippable = 0.08,
                aloe_planted = 0.08,
                asparagus_planted = 0.05

            },
            countprefabs = {
                spawnpoint_multiplayer = 1
            }

        }
    })

    AddRoom("Rockyham", {
        colour = {
            r = .55,
            g = .75,
            b = .75,
            a = .50
        },
        value = GROUND.PLAINS,
        tags = {"ExitPiece", "Chester_Eyebone"},
        contents = {
            countprefabs = {
                meteorspawner = 1,
                rock_moon = 1,
                burntground_faded = 1
            },
            distributepercent = .1,
            distributeprefabs = {
                rock1 = 2,
                rock2 = 2,
                rock_ice = 1,
                --					                    tallbirdnest=.1,
                spiderden = .01,
                blue_mushroom = .002,
                grass_tall = 0.3
            }
        }
    })

    AddTask("Dig that hamlet", {
        locks = {LOCKS.ROCKS},
        keys_given = {KEYS.TRINKETS, KEYS.STONE, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["MAINdeeprainforest_flytrap_grove"] = 1,
            ["MAINRockyham"] = 1,
            ["MAINdeeprainforest_ruins_exit"] = 1
            --			["Forest"] = 1,				
        },
        room_bg = GROUND.PLAINS,
        background_room = "MAINRockyham",
        colour = {
            r = 0,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("iniciosw", {
        locks = LOCKS.NONE,
        keys_given = {KEYS.PICKAXE, KEYS.AXE, KEYS.GRASS, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["MAINJungleDenseMedHome"] = 2
        },
        room_bg = GROUND.JUNGLE,
        background_room = "MAINBeachUnkeptInicio",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("iniciosw2", {
        locks = {LOCKS.ROCKS},
        keys_given = {KEYS.TRINKETS, KEYS.STONE, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["MAINJungleGrassy"] = 1
        },
        room_bg = GROUND.JUNGLE,
        background_room = "MAINJungleDenseMedHome",
        colour = {
            r = 0,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("inicioswsw", {
        locks = LOCKS.NONE,
        keys_given = {KEYS.PICKAXE, KEYS.AXE, KEYS.GRASS, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["JungleDenseMedHome"] = 2
        },
        room_bg = GROUND.JUNGLE,
        background_room = "BeachUnkeptInicio",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("inicioswsw2", {
        locks = {LOCKS.ROCKS},
        keys_given = {KEYS.TRINKETS, KEYS.STONE, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["JungleGrassy"] = 1
        },
        room_bg = GROUND.JUNGLE,
        background_room = "JungleDenseMedHome",
        colour = {
            r = 0,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("inicioham", {
        locks = LOCKS.NONE,
        keys_given = {KEYS.PICKAXE, KEYS.AXE, KEYS.GRASS, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["MAINBG_plains_inicio"] = 2
        },
        room_bg = GROUND.PLAINS,
        background_room = "MAINBG_plains_base",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("inicioham2", {
        locks = {LOCKS.ROCKS},
        keys_given = {KEYS.TRINKETS, KEYS.STONE, KEYS.WOOD, KEYS.TIER1},
        room_choices = {
            ["MAINdeeprainforest_fireflygrove"] = 1
        },
        room_bg = GROUND.DEEPRAINFOREST,
        background_room = "MAINBG_deeprainforest_base",
        colour = {
            r = 0,
            g = 0,
            b = 1,
            a = 1
        }
    })
    --------------------------------------separahamcave--------------------------------------------------------
    AddTask("separahamcave", {
        locks = {LOCKS.SACRED},
        keys_given = KEYS.LAND_DIVIDE_5,
        room_choices = {
            ["ForceDisconnectedRoom"] = 10
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.VOLCANO,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("HamMudWorld", {
        locks = {LOCKS.LAND_DIVIDE_5},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND2},
        room_choices = {
            ["HamLightPlantField"] = 1,
            ["HamLightPlantFieldexit"] = 1,
            ["HamWormPlantField"] = 1,
            ["HamFernGully"] = 1,
            ["HamSlurtlePlains"] = 1,
            ["HamMudWithRabbit"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGMud",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("HamMudCave", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND2},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND3},
        room_choices = {
            ["HamWormPlantField"] = 1,
            ["HamSlurtlePlains"] = 1,
            ["HamMudWithRabbit"] = 1,
            ["HamMudWithRabbitexit"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGBatCaveRoom",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("HamMudLights", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND2},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND3},
        room_choices = {
            ["HamLightPlantField"] = 3,
            ["HamWormPlantField"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamWormPlantField",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.7,
            g = 0.5,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("HamMudPit", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND2},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND3},
        room_choices = {
            ["SlurtlePlains"] = 1,
            ["PitRoom"] = 2
        },
        background_room = "HamFernGully",
        room_bg = GROUND.MUD,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    ------------------------------------------------------------
    -- Main Caves Branches
    ------------------------------------------------------------
    -- Big Bat Cave
    AddTask("HamBigBatCave", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamBatCave"] = 3,
            ["HamBattyCave"] = 1,
            ["HamFernyBatCave"] = 1,
            ["HamFernyBatCaveexit"] = 1,
            ["PitRoom"] = 2
        },
        background_room = "HamBGBatCaveRoom",
        room_bg = GROUND.CAVE,
        colour = {
            r = 0.8,
            g = 0.8,
            b = 0.8,
            a = 0.9
        }
    })

    -- Rocky Land
    AddTask("HamRockyLand", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4, KEYS.ISLAND7},
        room_choices = {
            ["HamSlurtleCanyon"] = 1,
            ["HamBatsAndSlurtles"] = 1,
            ["HamRockyPlains"] = 1,
            ["HamRockyPlainsexit"] = 1, ---sem saida
            ["HamRockyHatchingGrounds"] = 1,
            ["HamBatsAndRocky"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGRockyCaveRoom",
        room_bg = GROUND.CAVE,
        colour = {
            r = 0.5,
            g = 0.5,
            b = 0.5,
            a = 0.9
        }
    })

    ----------------------------------

    -- Red Forest
    AddTask("HamRedForest", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamRedMushForest"] = 2,
            ["HamRedSpiderForest"] = 1,
            ["HamRedSpiderForestexit"] = 1, ---sem saida
            ["HamRedMushPillars"] = 1,
            ["HamStalagmiteForest"] = 1,
            ["HamSpillagmiteMeadow"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGRedMush",
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        colour = {
            r = 1.0,
            g = 0.5,
            b = 0.5,
            a = 0.9
        }
    })

    AddRoom("caveruinexitroom", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.SINKHOLE,
        contents = {
            countstaticlayouts = {
                ["ruins_exit"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight = 0.05,
                cavelight_small = 0.05,
                cavelight_tiny = 0.05,
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.05,
                cave_fern = 0.5,
                fireflies = 0.01,

                red_mushroom = 0.1,
                green_mushroom = 0.1,
                blue_mushroom = 0.1
            }
        }
    })

    AddRoom("caveruinexitroom2", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.SINKHOLE,
        contents = {
            countstaticlayouts = {
                ["ruins_exit2"] = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight = 0.05,
                cavelight_small = 0.05,
                cavelight_tiny = 0.05,
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.05,
                cave_fern = 0.5,
                fireflies = 0.01,

                red_mushroom = 0.1,
                green_mushroom = 0.1,
                blue_mushroom = 0.1
            }
        }
    })

    AddTask("caveruinsexit", {
        locks = {LOCKS.ENTRANCE_INNER},
        keys_given = {},
        room_choices = {
            ["caveruinexitroom"] = 1
        },
        background_room = "BGSinkhole",
        room_bg = GROUND.SINKHOLE,
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 1
        }
    })

    AddTask("caveruinsexit2", {
        locks = {LOCKS.ENTRANCE_OUTER},
        keys_given = {},
        room_choices = {
            ["caveruinexitroom2"] = 1
        },
        background_room = "BGSinkhole",
        room_bg = GROUND.SINKHOLE,
        colour = {
            r = 1,
            g = 0,
            b = 1,
            a = 1
        }
    })

    -- Green Forest
    AddTask("HamGreenForest", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamGreenMushForest"] = 2,
            ["HamGreenMushPonds"] = 1,
            ["HamGreenMushSinkhole"] = 1,
            ["HamGreenMushMeadow"] = 1,
            ["HamGreenMushRabbits"] = 1,
            ["HamGreenMushNoise"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGGreenMush",
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        colour = {
            r = 0.5,
            g = 1.0,
            b = 0.5,
            a = 0.9
        }
    })

    -- Blue Forest
    AddTask("HamBlueForest", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4, KEYS.ISLAND5},
        room_choices = {
            ["HamBlueMushForest"] = 3,
            ["HamBlueMushMeadow"] = 2,
            ["HamBlueSpiderForest"] = 1,
            ["HamDropperDesolation"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGBlueMush",
        room_bg = GROUND.QUAGMIRE_PARKFIELD,
        colour = {
            r = 0.5,
            g = 0.5,
            b = 1.0,
            a = 0.9
        }
    })

    --------------------ham pigmaze--------------------------

    AddTask("HamMoonCaveForest", {
        locks = {LOCKS.ISLAND5},
        keys_given = {KEYS.ISLAND6},
        room_tags = {"nocavein"},
        room_choices = {
            ["HamCaveGraveyard"] = 1,
            ["HamCaveGraveyardentrance"] = 1
        },
        background_room = "HamCaveGraveyard",
        room_bg = GROUND.FUNGUSMOON,
        colour = {
            r = 0.3,
            g = 0.3,
            b = 0.3,
            a = 0.9
        }
    })

    AddTask("HamArchiveMaze", {
        locks = {LOCKS.ISLAND6},
        keys_given = {},
        room_tags = {"nocavein"},
        entrance_room = "HamArchiveMazeEntrance",
        room_choices = {
            ["ArchiveMazeRooms"] = 4
        },
        room_bg = GROUND.ARCHIVE,
        --    maze_tiles = {rooms = {"archive_hallway"}, bosses = {"archive_hallway"}, keyroom = {"archive_keyroom"}, archive = {start={"archive_start"}, finish={"archive_end"}}, bridge_ground=GROUND.FAKE_GROUND},
        maze_tiles = {
            rooms = {"hamlet_hallway", "hamlet_hallway_two"},
            bosses = {"hamlet_hallway"},
            archive = {
                keyroom = {"hamlet_keyroom"}
            },
            special = {
                finish = {"hamlet_end"},
                start = {"hamlet_start"}
            },
            bridge_ground = GROUND.FAKE_GROUND
        },
        background_room = "ArchiveMazeRooms",
        cove_room_chance = 0,
        cove_room_max_edges = 0,
        make_loop = true,
        colour = {
            r = 1,
            g = 0,
            b = 0.0,
            a = 1
        }
    })

    AddRoom("HamArchiveMazeEntrance", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.CAVE_NOISE,
        tags = {"MazeEntrance", "RoadPoison"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                tree_forest_rot = 0.05,
                lightflier_flower = 0.01,
                cavelightmoon = 0.01,
                cavelightmoon_small = 0.01,
                cavelightmoon_tiny = 0.01,

                stalagmite_tall = 0.03,
                stalagmite_tall_med = 0.03,
                stalagmite_tall_low = 0.03,
                batcave = 0.01
            }
        }
    })

    AddRoom("HamCaveGraveyardentrance", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.MARSH,
        tags = {"RoadPoison", "Mist"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                tree_forest_rot = 0.05,

                lightflier_flower = 0.01,

                cavelightmoon = 0.01,
                cavelightmoon_small = 0.01,
                cavelightmoon_tiny = 0.01,

                pigghostspawner = 0.005,
                piggravestone1 = 0.02,
                piggravestone2 = 0.02
            }
        }
    })

    AddRoom("HamCaveGraveyard", {
        colour = {
            r = .010,
            g = .010,
            b = .10,
            a = .50
        },
        value = GROUND.MARSH,
        tags = {"Mist"},
        contents = {
            countprefabs = {
                tree_forest_rot = 20,
                pigghostspawner = 10,
                goldnugget = function()
                    return math.random(10)
                end,
                piggravestone1 = function()
                    return 10 + math.random(4)
                end,
                piggravestone2 = function()
                    return 10 + math.random(4)
                end
            }
        }
    })
    ----------------------------------------------

    AddTask("HamSpillagmiteCaverns", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamSpidersAndBats"] = 1,
            ["HamThuleciteDebris"] = 1,
            ["PitRoom"] = 1
        },
        background_room = "HamBGSpillagmite",
        room_bg = GROUND.UNDERROCK,
        colour = {
            r = 0.3,
            g = 0.3,
            b = 0.3,
            a = 0.9
        }
    })

    AddTask("HamSpillagmiteCaverns1", {
        locks = {LOCKS.ISLAND1, LOCKS.ISLAND3},
        keys_given = {KEYS.ISLAND1, KEYS.ISLAND4},
        room_choices = {
            ["HamSpillagmiteForest"] = 1,
            ["HamDropperCanyon"] = 1,
            ["HamStalagmitesAndLights"] = 1
        },
        background_room = "HamSpillagmiteForest",
        room_bg = GROUND.FUNGUS,
        colour = {
            r = 0.3,
            g = 0.3,
            b = 0.3,
            a = 0.9
        }
    })
    ---------------------------------------------------------------------------------------------------------------
    if GetModConfigData("kindofworld") == 10 and GetModConfigData("togethercaves_shipwreckedworld") == 0 then
        AddTask("separavulcao", {
            locks = {LOCKS.NONE},
            keys_given = KEYS.LAND_DIVIDE_1,
            room_choices = {
                ["ForceDisconnectedRoom"] = 10
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.VOLCANO,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 1,
                g = 1,
                b = 1,
                a = 0.3
            }
        })

    elseif GetModConfigData("Volcano") == true then
        AddTask("separavulcao", {
            locks = {LOCKS.RUINS},
            keys_given = KEYS.LAND_DIVIDE_1,
            room_choices = {
                ["ForceDisconnectedRoom"] = 10
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.VOLCANO,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 1,
                g = 1,
                b = 1,
                a = 0.3
            }
        })

    else

        AddTask("separavulcao", {
            locks = {LOCKS.RUINS},
            keys_given = KEYS.LAND_DIVIDE_3,
            room_choices = {
                ["ForceDisconnectedRoom"] = 10
            },
            entrance_room = "ForceDisconnectedRoom",
            room_bg = GROUND.VOLCANO,
            background_room = "ForceDisconnectedRoom",
            colour = {
                r = 1,
                g = 1,
                b = 1,
                a = 0.3
            }
        })
    end

    AddTask("vulcaonacaverna", {
        locks = {LOCKS.LAND_DIVIDE_1},
        keys_given = {KEYS.ISLAND_1},
        crosslink_factor = 0,
        make_loop = true,
        room_choices = {

            ["VolcanoAsh"] = 5,
            ["VolcanoNoise"] = 6,
            ["VolcanoStart"] = 1,
            ["VolcanoObsidian"] = 4,
            ["VolcanoRock"] = 4

        },
        entrance_room = "ForceDisconnectedRoom",
        background_room = "VolcanoNoise",
        room_bg = GROUND.VOLCANO,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("vulcaonacaverna1", {
        locks = {LOCKS.ISLAND_1},
        keys_given = {KEYS.ISLAND_1},
        crosslink_factor = 0,
        make_loop = true,
        room_choices = {

            ["VolcanoAltar"] = 1

        },
        entrance_room = "VolcanoRock",
        background_room = "VolcanoRock",
        room_bg = GROUND.VOLCANO,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("vulcaonacaverna2", {
        locks = {LOCKS.ISLAND_1},
        keys_given = {KEYS.ISLAND_1},
        crosslink_factor = 0,
        make_loop = true,
        room_choices = {

            ["VolcanoObsidianBench"] = 1
        },
        entrance_room = "VolcanoObsidian",
        background_room = "VolcanoObsidian",
        room_bg = GROUND.VOLCANO,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("vulcaonacaverna3", {
        locks = {LOCKS.ISLAND_1},
        keys_given = {KEYS.LAND_DIVIDE_2},
        crosslink_factor = 0,
        make_loop = true,
        room_choices = {

            ["VolcanoCage"] = 1

        },
        entrance_room = "VolcanoAsh",
        background_room = "VolcanoAsh",
        room_bg = GROUND.VOLCANO,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    AddTask("vulcaonacaverna4", {
        locks = {LOCKS.LAND_DIVIDE_2},
        keys_given = {KEYS.LAND_DIVIDE_3},
        crosslink_factor = 0,
        make_loop = true,
        room_choices = {

            ["VolcanoLavaarena"] = 1

        },
        entrance_room = "ForceDisconnectedRoom",
        background_room = "ForceDisconnectedRoom",
        room_bg = GROUND.IMPASSABLE,
        colour = {
            r = 0.6,
            g = 0.4,
            b = 0.0,
            a = 0.9
        }
    })

    -------------------------------------------------------------frost cave-----------------------------------
    AddTask("frostcavedivide", {
        locks = {LOCKS.LAND_DIVIDE_3},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        room_choices = {
            ["ForceDisconnectedRoom"] = 10
        },
        entrance_room = "ForceDisconnectedRoom",
        room_bg = GROUND.IMPASSABLE,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("Frostcavetask", {
        locks = {LOCKS.QUAGMIRE_GATEWAY},
        keys_given = {KEYS.QUAGMIRE_GATEWAY},
        room_choices = {
            ["frostBatCave"] = 1,
            ["frostBattyCave"] = 1,
            ["frostFernyBatCave"] = 1,
            ["frostBlueMushForest"] = 1,
            ["frostBlueMushMeadow"] = 1,
            ["frostBlueSpiderForest"] = 1,
            ["frostDropperDesolation"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "FrostIsland_Meadowscave",
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("frostExitRoom", {
        locks = {LOCKS.ENTRANCE_INNER, LOCKS.ENTRANCE_OUTER},
        keys_given = {},
        room_choices = {
            ["frostExitRoom"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "BGSinkhole",
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddRoom("frostExitRoom", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.SINKHOLE,
        contents = {
            countprefabs = {
                frosttocave = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight = 0.05,
                cavelight_small = 0.05,
                cavelight_tiny = 0.05,
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.05,
                cave_fern = 0.5,
                fireflies = 0.01,

                red_mushroom = 0.1,
                green_mushroom = 0.1,
                blue_mushroom = 0.1
            }
        }
    })

    AddRoom("frostBatCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"frost"},
        contents = {
            countstaticlayouts = {
                ["IceSpiderpillar"] = 1
            },
            distributepercent = .15,
            distributeprefabs = {
                batcave = 0.05,
                guano = 0.27,
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                frostpillar_rock = 0.08,
                fissure = 0.05
            }
        }
    })

    -- Very batty bat cave
    AddRoom("frostBattyCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"frost"},
        contents = {
            countprefabs = {
                slipstor = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                batcave = 0.15,
                guano = 0.27,
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.4,
                stalagmite_tall_med = 0.4,
                stalagmite_tall_low = 0.4,
                frostpillar_rock = 0.08,
                fissure = 0.05
            }
        }
    })
    -- Ferny bat cave
    AddRoom("frostFernyBatCave", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"frost"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                cave_fern = 0.5,
                batcave = 0.05,
                guano = 0.27,
                goldnugget = .05,
                flint = 0.05,
                stalagmite_tall = 0.1,
                stalagmite_tall_med = 0.1,
                stalagmite_tall_low = 0.1,
                frostpillar_rock = 0.08,
                fissure = 0.05
            }
        }
    })

    AddRoom("frostBlueMushForest", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"frost"},
        contents = {
            distributepercent = .6,
            distributeprefabs = {
                mushtree_tall = 6.0,
                blue_mushroom = 0.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,
                batcave = 0.005,
                dropperweb = 0.015,
                trapslugspawner = 0.001
            }
        }
    })

    -- Blue light meadow
    AddRoom("frostBlueMushMeadow", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"frost"},
        contents = {
            distributepercent = .3,
            distributeprefabs = {
                mushtree_tall = 1.0,
                blue_mushroom = 2.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                batcave = 0.005,
                dropperweb = 0.015,

                trapslugspawner = 0.001
            }
        }
    })

    -- Dropper forest
    AddRoom("frostBlueSpiderForest", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"frost"},
        contents = {
            distributepercent = .4,
            distributeprefabs = {
                mushtree_tall = 3.0,
                blue_mushroom = 2.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                dropperweb = 0.1,
                boneshard = 0.2,
                houndbone = 0.2,

                trapslugspawner = 0.001
            }
        }
    })

    -- Dropper desolation
    AddRoom("frostDropperDesolation", {
        colour = {
            r = 0.1,
            g = 0.1,
            b = 0.8,
            a = 0.9
        },
        value = GROUND.WATER_MANGROVE,
        tags = {"frost"},
        contents = {
            countprefabs = {
                frosttocave = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                mushtree_tall = 2.0,
                blue_mushroom = 1.5,
                flower_cave = 0.1,
                flower_cave_double = 0.05,
                flower_cave_triple = 0.05,

                dropperweb = 1.5,
                boneshard = 0.4,
                houndbone = 1.6,

                trapslugspawner = 0.001
            }
        }
    })
    ---------------------------------------------------------creep in the deeps------------------------------------
    AddTask("underwaterdivide", {
        locks = {LOCKS.LAND_DIVIDE_3},
        keys_given = {KEYS.LAND_DIVIDE_4},
        room_choices = {
            ["ForceDisconnectedRoom"] = 20
        },
        level_set_piece_blocker = true,
        entrance_room = "VolcanoObsidian",
        room_bg = GROUND.IMPASSABLE,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 1,
            g = 1,
            b = 1,
            a = 0.3
        }
    })

    AddTask("UnderwaterStart", {
        locks = LOCKS.LAND_DIVIDE_4,
        keys_given = {KEYS.JUNGLE_DEPTH_1, KEYS.JUNGLE_DEPTH_2, KEYS.JUNGLE_DEPTH_3},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomCoralPatch"] = (math.random() > 0.5 and 1) or 0,
            ["startPatch"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("SandyBiome", {
        locks = LOCKS.JUNGLE_DEPTH_1,
        keys_given = {KEYS.OTHER_JUNGLE_DEPTH_1},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomTreasureTrove"] = (math.random() > 0.5 and 1) or 0,
            ["SandyBottomCoralPatch"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("ReefBiome", {
        locks = LOCKS.JUNGLE_DEPTH_2,
        keys_given = {KEYS.OTHER_JUNGLE_DEPTH_2},

        room_choices = {
            ["CoralReef"] = math.random(2),
            ["CoralReefLight"] = (math.random() > 0.5 and 1) or 0,
            ["CoralReefJunked"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_CoralReef",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("KelpBiome", {
        locks = LOCKS.JUNGLE_DEPTH_3,
        keys_given = {KEYS.LOST_JUNGLE_DEPTH_2},

        room_choices = {
            ["KelpForest"] = math.random(2),
            ["KelpForestInfested"] = (math.random() > 0.5 and 1) or 0,
            ["KelpForestLight"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_KelpForest",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("RockyBiome", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_1,
        keys_given = {KEYS.PINACLE},

        room_choices = {
            ["RockyBottom"] = math.random(2),
            ["RockyBottomBroken"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "bg_RockyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("MoonBiome", {
        locks = LOCKS.PINACLE,
        keys_given = {KEYS.WILD_JUNGLE_DEPTH_2},

        room_choices = {
            ["LunnarBottom"] = 2,
            ["LunnarBottomBroken"] = 1,
            ["Lunnarrocks"] = 1,
            ["Lunnarrocksgnar"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.PEBBLEBEACH,
        background_room = "bg_LunnarBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("OpenWaterBiome", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_1,
        keys_given = {KEYS.PINACLE},

        entrance_room = "TidalZoneEntrance",
        room_choices = {
            ["TidalZone"] = math.random(2)
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_TidalZone",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    AddTask("UnderwaterExit1", {
        locks = LOCKS.WILD_JUNGLE_DEPTH_2,
        keys_given = {KEYS.WILD_JUNGLE_DEPTH_2},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomCoralPatch"] = (math.random() > 0.5 and 1) or 0,
            ["exitPatch1"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })
    -----------------------

    AddTask("EntranceToReef", {
        locks = {LOCKS.SPIDERS_DEFEATED},
        keys_given = {KEYS.SPIDERS},

        room_choices = {
            ["UnderwaterEntrance"] = 1
        },
        room_bg = GROUND.FOREST,
        background_room = "BGGrass",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    -------------new tasks-------------------------------------------------------
    AddTask("task_underground_beach", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_1},
        room_choices = {
            ["beach1"] = 1,
            ["beach2"] = 1,
            ["beach_crab"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "beach_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwatermagmafield", {
        locks = LOCKS.OTHER_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_1},
        room_choices = {
            ["underwatermagmafield1"] = 2,
            ["underwatermagmafield"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "underwatermagmafield",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwater_kraken_zone", {
        locks = LOCKS.CIVILIZATION_1,
        keys_given = {KEYS.OTHER_CIVILIZATION_1},
        room_choices = {
            ["kraken_zone"] = 1,
            ["kraken_zone_basic"] = 2
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.IMPASSABLE,
        background_room = "kraken_zone_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("secretcavedivisor", {
        locks = LOCKS.OTHER_CIVILIZATION_1,
        keys_given = KEYS.WILD_JUNGLE_DEPTH_1,
        room_choices = {
            ["ForceDisconnectedRoom"] = 6
        },
        level_set_piece_blocker = true,
        entrance_room = "cave_underwater1_entrance",
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "ForceDisconnectedRoom",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("task_secretcave1", {
        locks = LOCKS.WILD_JUNGLE_DEPTH_1,
        keys_given = KEYS.WILD_JUNGLE_DEPTH_1,
        room_choices = {
            ["cave_underwater1_part1"] = 1
            --			["cave_underwater1_part2"] =  1, 			
        },
        level_set_piece_blocker = true,
        --		entrance_room = "ForceDisconnectedRoom",		
        room_bg = GROUND.IMPASSABLE,
        background_room = "cave_underwater_base",
        colour = {
            r = 0.2,
            g = 0.6,
            b = 0.2,
            a = 0.3
        }
    })

    AddTask("atlantidaExitRoom", {
        locks = {LOCKS.ENTRANCE_INNER, LOCKS.ENTRANCE_OUTER},
        keys_given = {},
        room_choices = {
            ["atlantidaExitRoom"] = 1
        },
        room_bg = GROUND.WATER_MANGROVE,
        background_room = "BGSinkhole",
        colour = {
            r = 0.6,
            g = 0.6,
            b = 0.0,
            a = 1
        }
    })

    AddTask("task_underwaterlavarock", {
        locks = LOCKS.LOST_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_2},
        room_choices = {
            ["underwaterlavarock"] = 3
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_ROCKY,
        background_room = "underwaterlavarock",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwaterothers", {
        locks = LOCKS.LOST_JUNGLE_DEPTH_2,
        keys_given = {KEYS.CIVILIZATION_2},
        room_choices = {
            ["underwaterothers_lobster"] = 1,
            ["underwaterothers_basic"] = 2
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "underwaterothers_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("task_underwaterwatercoral", {
        locks = LOCKS.CIVILIZATION_2,
        keys_given = {KEYS.OTHER_CIVILIZATION_2},
        room_choices = {
            ["underwaterwatercoral_octopus"] = 1,
            ["underwaterwatercoral"] = 2

        },
        level_set_piece_blocker = true,
        room_bg = GROUND.PAINTED,
        background_room = "underwaterwatercoral_bg",
        colour = {
            r = 0,
            g = 1,
            b = 0,
            a = 1
        }
    })

    AddTask("UnderwaterExit2", {
        locks = LOCKS.OTHER_CIVILIZATION_2,
        keys_given = {KEYS.OTHER_CIVILIZATION_2},

        room_choices = {
            ["SandyBottom"] = math.random(2),
            ["SandyBottomCoralPatch"] = (math.random() > 0.5 and 1) or 0,
            ["exitPatch2"] = 1
        },
        level_set_piece_blocker = true,
        room_bg = GROUND.UNDERWATER_SANDY,
        background_room = "bg_SandyBottom",
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        }
    })

    ---------------------new creeps rooms-------------------------------
    AddRoom("beach1", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                sandhill = .3,
                seashell_beached = .5,
                rock_limpet = 0.08,
                crate = 0.1,
                jellyfish_underwater = 0.1,
                fish2_alive = 0.1,
                fish3_alive = 0.05,
                shrimp = 0.1,
                bubble_vent = 0.03,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("beach2", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                sandhill = 0.5,
                seashell_beached = 0.5,
                rock_limpet = 1,
                crate = 0.1,
                stungrayunderwater = 1,
                jellyfish_underwater = 0.1,
                fish2_alive = 0.1,
                --										shrimp = 0.1,										
                fish3_alive = 0.05,
                bubble_vent = 0.03,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("beach_crab", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                sandhill = 0.5,
                seashell_beached = 1,
                rock_limpet = 0.5,
                crate = 0.1,
                crabhole = 1,
                fish2_alive = 0.05,
                fish3_alive = 0.05,
                --										shrimp = 0.1,										
                bubble_vent = 0.03,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("beach_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.BEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .25,
            distributeprefabs = {
                sandhill = 1,
                seashell_beached = 0.5,
                rock_limpet = 0.5,
                crate = 0.1,
                fish2_alive = 0.1,
                fish3_alive = 0.05,
                squidunderwater = 0.002,
                bubble_vent = 0.03,
                --										shrimp = 0.1,
                bioluminescence = 0.03,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterothers_lobster", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										shrimp = 0.1,
                dogfish_under = 0.5,
                fish_coi = 0.5,
                lobsterunderwater = 1,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterothers_basic", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										shrimp = 0.1,
                dogfish_under = 0.5,
                fish_coi = 0.5,
                tidal_node = 0.5,
                lobsterunderwater = 1,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterothers_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										shrimp = 0.1,
                dogfish_under = 0.5,
                fish_coi = 0.5,
                --										bioluminescence = 0.03,	
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("kraken_zone_basic", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                wreckunderwater = 0.5,
                --										shrimp = 0.1,
                quagmire_salmom_alive = 0.1,
                crate = 0.1,
                redbarrelunderwater = 0.2,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                tidal_node = 0.1
            }

        }
    })

    AddRoom("kraken_zone", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                krakenunderwater = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --                                      mussel_bed = .2,
                commonfish = 0.05,
                shrimp = 0.1,
                quagmire_salmom_alive = 0.1,
                redbarrelunderwater = 0.1,
                wreckunderwater = 0.5,
                crate = 0.5,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("kraken_zone_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                --										mussel_bed =.2,
                commonfish = 0.05,
                shrimp = 0.1,
                quagmire_salmom_alive = 0.1,
                wreckunderwater = 0.5,
                crate = 0.1,
                redbarrelunderwater = 0.2,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                tidal_node = 0.1
            }

        }
    })

    AddRoom("cave_underwater1_entrance", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                secretcaveentrance = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                stalagmite = 0.15,
                stalagmite_med = 0.15,
                stalagmite_low = 0.15,
                pillar_cave = 0.08,
                uw_flowers = 0.05,
                dogfish_under = 0.1,
                commonfish = 0.1
            }

        }
    })

    AddRoom("cave_underwater1_part1", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countstaticlayouts = {
                ["atlantida"] = 1
            },
            distributepercent = .175,
            distributeprefabs = {
                stalagmite = .025,
                stalagmite_med = .025,
                stalagmite_low = .025,
                bioluminescence = 0.01,
                fissure = 0.002,
                lichen = .25,
                cave_fern = 1,
                pillar_algae = .05
            }
        }
    })

    AddRoom("atlantidaExitRoom", {
        colour = {
            r = .25,
            g = .28,
            b = .25,
            a = .50
        },
        value = GROUND.SINKHOLE,
        contents = {
            countprefabs = {
                underwater_entrance3 = 1
            },
            distributepercent = .2,
            distributeprefabs = {
                cavelight = 0.05,
                cavelight_small = 0.05,
                cavelight_tiny = 0.05,
                flower_cave = 0.5,
                flower_cave_double = 0.1,
                flower_cave_triple = 0.05,
                cave_fern = 0.5,
                fireflies = 0.01,

                red_mushroom = 0.1,
                green_mushroom = 0.1,
                blue_mushroom = 0.1
            }
        }
    })

    AddRoom("cave_underwater1_part2", {
        colour = {
            r = 0.3,
            g = 0.2,
            b = 0.1,
            a = 0.3
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = .15,
            distributeprefabs = {
                stalagmite = 0.15,
                stalagmite_med = 0.15,
                stalagmite_low = 0.15,
                pillar_cave = 0.08,
                fissure = 0.05
            }
        }
    })

    AddRoom("cave_underwater_base", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0.9
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            --									countstaticlayouts={
            --										["CaveBase"]=1,
            --									},
            distributepercent = .15,
            distributeprefabs = {
                bioluminescence = 0.3,
                quagmire_salmom_alive = 0.15,
                stalagmite_tall_low = 1,
                stalagmite_tall_med = 0.6,
                stalagmite_tall = 0.2,
                pillar_cave = .05,
                pillar_stalactite = .05
            }

        }
    })

    AddRoom("underwaterlavarock", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                rock_limpet = 0.1,
                spongea = .2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                commonfish = 0.05,
                --										shrimp = 0.1,
                dogfish_under = 0.1,
                fish_coi = 0.1,
                redbarrelunderwater = 0.2,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwatermagmafield", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.2,
                iron_boulder = 0.6,
                rock_cave = 0.5,
                quagmire_salmom_alive = 0.05,
                dogfish_under = 0.1,
                rock_charcoal = 0.5,
                --									squid = 0.002,
                bubble_vent = 0.01,
                --									shrimp = 0.1,
                --									bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwatermagmafield1", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.MAGMAFIELD,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },
            distributepercent = .25,
            distributeprefabs = {
                magmarock = 1,
                magmarock_gold = 0.2,
                iron_ore = 0.03,
                iron_boulder = 0.8,
                rock_cave = 0.5,
                quagmire_salmom_alive = 0.05,
                dogfish_under = 0.1,
                rock_charcoal = 0.5,
                --									squid = 0.002,
                bubble_vent = 0.01,
                shrimp = 0.1,
                --									bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterwatercoral", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PAINTED,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                coral_brain_rockunderwater = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                coralreefunderwater = 1,
                bubble_vent = 0.03,
                uw_flowers = .1,
                shrimp = 0.1,
                fish4_alive = 0.1,
                fish5_alive = 0.1,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterwatercoral_octopus", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PAINTED,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                coral_brain_rockunderwater = 1,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
                --									octopuskingunderwater = 1,
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                coralreefunderwater = 1,
                bubble_vent = 0.03,
                uw_flowers = .1,
                shrimp = 0.1,
                fish4_alive = 0.1,
                fish5_alive = 0.1,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })

    AddRoom("underwaterwatercoral_bg", {
        colour = {
            r = .5,
            g = 0.6,
            b = .080,
            a = .10
        },
        value = GROUND.PAINTED,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end,
                coral_brain_rockunderwater = 1
            },
            distributepercent = .25,
            distributeprefabs = {
                spongea = .2,
                coralreefunderwater = 0.2,
                bubble_vent = 0.03,
                uw_flowers = .1,
                fish4_alive = 0.05,
                fish5_alive = 0.05,
                --										bioluminescence = 0.03,		
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }

        }
    })
    ------------------------------------------------------------------------------------------
    -- Sandy rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("SandyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("startPatch", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_exit = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("exitPatch1", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_exit1 = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("exitPatch2", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_exit2 = 1
            },
            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.01,
                clam = 0.06,
                sponge = 0.25,
                rainbowjellyfish_underwater = 0.01,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("SandyBottomTreasureTrove", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.35,
                sandstone_boulder = 0.01,
                uw_coral = 0.4,
                uw_coral_blue = 0.3,
                uw_coral_green = 0.3,
                --			seatentacle = 0.01,
                rotting_trunk = 0.2,
                bubble_vent = 0.03,
                kelpunderwater = 0.5,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.05,
                wormplant = 0.1,
                sea_eel = 0.2,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.1,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("SandyBottomCoralPatch", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                seagrass = 0.01,
                sandstone_boulder = 0.1,
                uw_coral = 0.25,
                uw_coral_blue = 0.25,
                uw_coral_green = 0.25,
                reef_jellyfish = 0.1,
                bubble_vent = 0.03,
                kelpunderwater = 0.2,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                decorative_shell = 0.2,
                wormplant = 0.1,
                clam = 0.06,
                sponge = 0.25,
                sea_cucumber = 0.3,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Reef rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("CoralReef", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.6,
            distributeprefabs = {
                sandstone_boulder = 0.01,
                uw_coral = 1.5,
                uw_coral_blue = 1.5,
                uw_coral_green = 1,
                reef_jellyfish = 0.4,
                --			seatentacle = 0.5,
                bubble_vent = 0.03,
                squidunderwater = 0.001,
                decorative_shell = 0.2,
                sea_eel = 0.2,
                sponge = 0.15,
                rainbowjellyfish_underwater = 0.01,
                commonfish = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("CoralReefJunked", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                sandstone_boulder = 0.01,
                uw_coral = 1.3,
                uw_coral_blue = 1.3,
                uw_coral_green = 1.3,
                reef_jellyfish = 0.4,
                --			seatentacle = 0.5,
                bubble_vent = 0.03,
                squidunderwater = 0.01,
                cut_orange_coral = 1,
                decorative_shell = 0.05,
                sea_eel = 0.2,
                sponge = 0.15,
                commonfish = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("CoralReefLight", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                gnarwailunderwater = 1
            },

            distributepercent = 0.3,
            distributeprefabs = {
                sandstone_boulder = 0.05,
                uw_coral = 1,
                uw_coral_blue = 1,
                uw_coral_green = 1,
                iron_boulder = 0.5,
                bubble_vent = 0.03,
                rotting_trunk = 0.1,
                reef_jellyfish = 0.4,
                squidunderwater = 0.01,
                decorative_shell = 0.1,
                wormplant = 0.1,
                sponge = 0.15,
                commonfish = 0.2,
                rainbowjellyfish_underwater = 0.01,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Kelp rooms
    ------------------------------------------------------------------------------------------

    AddRoom("KelpForest", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                kelpunderwater = 2.5,
                rotting_trunk = 0.01,
                seagrass = 0.005,
                sandstone_boulder = 0.0008,
                squidunderwater = 0.001,
                flower_sea = 0.1,
                sea_eel = 0.001,
                bubble_vent = 0.03,
                commonfish = 0.2,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("KelpForestLight", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2) - 1)
                end,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },
            distributepercent = 0.6,
            distributeprefabs = {
                kelpunderwater = 0.5,
                rotting_trunk = 0.05,
                seagrass = 0.005,
                sandstone_boulder = 0.0008,
                --			mermworkerhouse = 0.02,
                squidunderwater = 0.0001,
                --			seatentacle = 0.0001,
                flower_sea = 0.1,
                sea_eel = 0.002,
                bubble_vent = 0.03,
                commonfish = 0.05,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("KelpForestInfested", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.6,
            distributeprefabs = {
                kelpunderwater = 2.5,
                rotting_trunk = 0.01,
                seagrass = 0.005,
                sandstone_boulder = 0.008,
                reef_jellyfish = 0.2,
                squidunderwater = 0.005,
                flower_sea = 0.1,
                sea_eel = 0.001,
                rainbowjellyfish_underwater = 0.01,
                bubble_vent = 0.03,
                commonfish = 0.15,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Rocky rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("RockyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.225,
            distributeprefabs = {
                rock1 = 0.1,
                rock2 = 0.05,
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("RockyBottomBroken", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.15,
            distributeprefabs = {
                rocks = 0.1,
                rock1 = 0.1,
                rock2 = 0.05,
                iron_ore = 0.03,
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Lunnar rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("LunnarBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                seaweedunderwater = 2
            }
        }
    })

    AddRoom("LunnarBottomBroken", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = 1,
                gnarwailunderwater = 1,
                sunkenchest_spawner = function()
                    return (math.random(2) - 1)
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                singingshell_octave3 = 0.1,
                singingshell_octave4 = 0.1,
                singingshell_octave5 = 0.1,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                seaweedunderwater = 0.1
            }
        }
    })

    AddRoom("Lunnarrocks", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = function()
                    return (math.random(2))
                end
            },

            distributepercent = 0.3,
            distributeprefabs = {
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                saltstack = 1,
                seastack = 1
            }
        }
    })

    AddRoom("Lunnarrocksgnar", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                geothermal_vent = 1,
                gnarwailunderwater = 1
            },

            distributepercent = 0.3,
            distributeprefabs = {
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.5,
                pond_algae = 0.5,
                saltstack = 1,
                seastack = 1
            }
        }
    })

    AddRoom("bg_LunnarBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.PEBBLEBEACH,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.20,
            distributeprefabs = {
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                shell_cluster = 0.01,
                oceanfishableflotsam = 0.1,
                trap_starfish = 0.5,
                dead_sea_bones = 0.4,
                pond_algae = 0.5,
                seaweedunderwater = 0.2,
                seastack = 0.3,
                uw_coral = 0.2,
                uw_coral_blue = 0.2,
                uw_coral_green = 0.2
            }
        }
    })
    ------------------------------------------------------------------------------------------
    -- Open water rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("TidalZoneEntrance", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.7,
            distributeprefabs = {
                seagrass = 0.05,
                sandstone = 0.35,
                uw_coral = 0.01,
                uw_coral_blue = 0.01,
                uw_coral_green = 0.01,
                cut_orange_coral = 0.1,
                tidal_node = 5,
                sponge = 0.01,
                bubble_vent = 0.03,
                commonfish = 0.05,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("TidalZone", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.7,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.04,
                uw_coral_blue = 0.04,
                uw_coral_green = 0.04,
                cut_orange_coral = 0.3,
                tidal_node = 5,
                squidunderwater = 0.008,
                sponge = 0.03,
                bubble_vent = 0.03,
                commonfish = 0.05,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Background rooms
    ------------------------------------------------------------------------------------------	

    AddRoom("bg_SandyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.25,
            distributeprefabs = {
                seagrass = 0.15,
                uw_coral = 0.02,
                uw_coral_blue = 0.03,
                uw_coral_green = 0.03,
                kelpunderwater = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2,
                uw_flowers = 0.1
            }
        }
    })

    AddRoom("bg_CoralReef", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.8,
            distributeprefabs = {
                sandstone_boulder = 0.01,
                uw_coral = 2,
                uw_coral_blue = 2.5,
                uw_coral_green = 2,
                reef_jellyfish = 0.3,
                kelpunderwater = 1,
                bubble_vent = 0.1,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("bg_KelpForest", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.8,
            distributeprefabs = {
                kelpunderwater = 2.5,
                rotting_trunk = 0.01,
                seagrass = 0.005,
                sandstone_boulder = 0.0008,
                flower_sea = 0.1,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("bg_RockyBottom", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_ROCKY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.15,
            distributeprefabs = {
                rock1 = 0.1,
                rock2 = 0.05,
                iron_boulder = 0.4,
                squidunderwater = 0.002,
                lava_stone = 0.005,
                sponge = 0.001,
                bubble_vent = 0.01,
                commonfish = 0.1,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    AddRoom("bg_TidalZone", {
        colour = {
            r = 0,
            g = 0,
            b = 0,
            a = 0
        },
        value = GROUND.UNDERWATER_SANDY,
        tags = {"RoadPoison"},
        contents = {
            distributepercent = 0.9,
            distributeprefabs = {
                seagrass = 0.25,
                sandstone = 0.45,
                uw_coral = 0.1,
                uw_coral_blue = 0.1,
                uw_coral_green = 0.1,
                cut_orange_coral = 0.3,
                tidal_node = 5,
                commonfish = 0.05,
                rainbowjellyfish_underwater = 0.01,
                shrimp = 0.1,
                reeflight_small = 0.2,
                reeflight_tiny = 0.2
            }
        }
    })

    ------------------------------------------------------------------------------------------
    -- Underwater Entrance
    ------------------------------------------------------------------------------------------

    AddRoom("UnderwaterEntrance", {
        colour = {
            r = 1,
            g = 0,
            b = 0,
            a = 0.3
        },
        value = GROUND.FOREST,
        tags = {"RoadPoison"},
        contents = {
            countprefabs = {
                underwater_entrance = 1
            },
            distributepercent = 0.25,
            distributeprefabs = {
                grass = 2,
                sapling = 2,
                green_mushroom = 3,
                blue_mushroom = 3,
                flower = 1,
                houndbone = 1
                -- reeds = 1,
                -- evergreen_sparse = .5,
            }
        }
    })

    ------------------------------------------------------------------------------------------------------
    ----------------------------------cherry forest--------------------------------------------------------------------
    if GLOBAL.KnownModIndex:IsModEnabled("workshop-1289779251") then

        AddTask("cherry_arquipelago", {
            locks = {},
            keys_given = {KEYS.ISLAND_TIERCHERRY},
            region_id = "islandcherry",
            room_tags = {"RoadPoison", "cherryarea", "not_mainland"},
            type = GLOBAL.NODE_TYPE.SeparatedRoom,
            room_choices = {
                ["CherryForestArchipelago"] = 5,
                ["CherryBugs"] = 2,

                ["CherrySpawn"] = 1,
                ["CherryTrees"] = 1,
                ["CherryDeepForest"] = 1,

                ["CherryWeb"] = 1,

                ["BGGrass"] = 2
            },
            room_bg = GROUND.GRASS,
            background_room = "Empty_Cove",
            cove_room_name = "BGCherryIsland",
            make_loop = true,
            crosslink_factor = 2,
            cove_room_chance = 1,
            cove_room_max_edges = 2,
            colour = {
                r = 1,
                g = 0.4,
                b = 0.4,
                a = 0.1
            }
        })

        AddTask("cherry_grove", {
            locks = {},
            keys_given = {KEYS.ISLAND_TIERCHERRY},
            region_id = "islandcherry",
            room_tags = {"RoadPoison", "cherryarea", "not_mainland"},
            room_choices = {
                ["CherryForestIsland"] = 5,
                ["CherryBugs"] = 1,

                ["CherrySpawn"] = 1,
                ["CherryTrees"] = 1,
                ["CherryDeepForest"] = 1,

                ["CherryWeb"] = 1,

                ["BGGrass"] = 2
            },
            room_bg = GROUND.GRASS,
            background_room = "BGCherry",
            cove_room_name = "Empty_Cove",
            make_loop = true,
            crosslink_factor = 2,
            cove_room_chance = 1,
            cove_room_max_edges = 2,
            colour = {
                r = 1,
                g = 0.4,
                b = 0.4,
                a = 0.1
            }
        })

        AddTask("cherry_island", {
            locks = {},
            keys_given = {KEYS.ISLAND_TIERCHERRY},
            region_id = "islandcherry",
            room_tags = {"RoadPoison", "cherryarea", "not_mainland"},
            room_choices = {
                ["CherryForestIsland"] = 5,
                ["CherryBugs"] = 2,

                ["CherrySpawn"] = 1,
                ["CherryTrees"] = 1,
                ["CherryDeepForest"] = 1,

                ["CherryWeb"] = 1,

                ["BGGrass"] = 2
            },
            room_bg = GROUND.GRASS,
            background_room = "Empty_Cove",
            cove_room_name = "BGCherry",
            make_loop = true,
            crosslink_factor = 2,
            cove_room_chance = 1,
            cove_room_max_edges = 2,
            colour = {
                r = 1,
                g = 0.4,
                b = 0.4,
                a = 0.1
            }
        })

        AddTask("cherry_mainland", {
            locks = LOCKS.NONE,
            keys_given = {KEYS.TIER1, KEYS.TIER2, KEYS.TIER3},
            room_tags = {"cherryarea"},
            room_choices = {
                ["CherryForest"] = 5,
                ["CherryBugs"] = 2,

                ["CherrySpawn"] = 1,
                ["CherryTrees"] = 1,
                ["CherryDeepForest"] = 1,

                ["CherryVillage"] = 1
            },
            room_bg = GROUND.CHERRY,
            background_room = "BGCherry",
            colour = {
                r = .5,
                g = 0.6,
                b = .080,
                a = .10
            }
        })
    end

    ----------------------------------------------------------------------------------
    if GetModConfigData("kindofworld") == 10 then

        AddStartLocation("tropicalexperience", {
            name = "tropicalexperience",
            location = "forest",
            start_setpeice = "BeachStart",
            start_node = "MAINBeachPortalRoom"
        })

        local function LevelPreInit(level)

            if level.location == "cave" then
                level.overrides.keep_disconnected_tiles = true
                if level.location == "cave" and GetModConfigData("togethercaves_shipwreckedworld") == 0 then
                    level.tasks = {}
                    level.numoptionaltasks = 0
                    level.set_pieces = {}
                end

                table.insert(level.tasks, "separavulcao")
                table.insert(level.tasks, "vulcaonacaverna")
                table.insert(level.tasks, "vulcaonacaverna1")
                table.insert(level.tasks, "vulcaonacaverna2")
                table.insert(level.tasks, "vulcaonacaverna3")
                table.insert(level.tasks, "vulcaonacaverna4")

                if GetModConfigData("frost_islandworld") == 10 then
                    table.insert(level.tasks, "frostcavedivide")
                    table.insert(level.tasks, "Frostcavetask")
                    table.insert(level.tasks, "frostExitRoom")
                end

                if GetModConfigData("underwater") then
                    table.insert(level.tasks, "underwaterdivide")
                    table.insert(level.tasks, "UnderwaterStart")
                    table.insert(level.tasks, "SandyBiome")
                    table.insert(level.tasks, "ReefBiome")
                    table.insert(level.tasks, "KelpBiome")
                    table.insert(level.tasks, "RockyBiome")
                    table.insert(level.tasks, "MoonBiome")
                    table.insert(level.tasks, "OpenWaterBiome")
                    table.insert(level.tasks, "task_underground_beach")
                    table.insert(level.tasks, "task_underwaterothers")
                    table.insert(level.tasks, "task_underwater_kraken_zone")
                    table.insert(level.tasks, "secretcavedivisor")
                    table.insert(level.tasks, "task_secretcave1")
                    if GetModConfigData("togethercaves_shipwreckedworld") == 1 then
                        table.insert(level.tasks, "atlantidaExitRoom")
                    end
                    table.insert(level.tasks, "task_underwaterlavarock")
                    table.insert(level.tasks, "task_underwatermagmafield")
                    table.insert(level.tasks, "task_underwaterwatercoral")
                    table.insert(level.tasks, "UnderwaterExit1")
                end

                -----------------------------hamlet caves----------------------------------------
                if GetModConfigData("hamletcaves_shipwreckedworld") == 1 then
                    table.insert(level.tasks, "separahamcave")
                    table.insert(level.tasks, "HamMudWorld")
                    table.insert(level.tasks, "HamMudCave")
                    table.insert(level.tasks, "HamMudLights")
                    table.insert(level.tasks, "HamMudPit")

                    table.insert(level.tasks, "HamBigBatCave")
                    table.insert(level.tasks, "HamRockyLand")
                    table.insert(level.tasks, "HamRedForest")
                    table.insert(level.tasks, "HamGreenForest")
                    table.insert(level.tasks, "HamBlueForest")
                    table.insert(level.tasks, "HamSpillagmiteCaverns")
                    table.insert(level.tasks, "HamSpillagmiteCaverns1")
                    table.insert(level.tasks, "caveruinsexit")
                    table.insert(level.tasks, "caveruinsexit2")

                    table.insert(level.tasks, "HamMoonCaveForest")
                    table.insert(level.tasks, "HamArchiveMaze")
                end

            end

            if level.location == "forest" then
                level.overrides.start_location = "tropicalexperience"
            end

        end

        AddLevelPreInitAny(LevelPreInit)

        local function TasksetPreInit(taskset)
            if taskset.location ~= "forest" then
                return
            end
            taskset.tasks = {}
            table.insert(taskset.tasks, "inicioswsw")
            table.insert(taskset.tasks, "inicioswsw2")
            table.insert(taskset.tasks, "TROPICAL39")
            table.insert(taskset.tasks, "TROPICAL9")
            table.insert(taskset.tasks, "TROPICAL50")
            table.insert(taskset.tasks, "TROPICAL51")
            table.insert(taskset.tasks, "TROPICAL28")
            table.insert(taskset.tasks, "PirateBounty")
            table.insert(taskset.tasks, "TROPICAL14")
            taskset.valid_start_tasks = {"iniciosw"}
            taskset.numoptionaltasks = GetModConfigData("howmanyislands")
            taskset.optionaltasks = {"HomeIslandSmall", "HomeIslandSmallBoon", "HomeIslandMed", "HomeIslandLarge",
                                     "HomeIslandLargeBoon", "DesertIsland", "JungleMarsh", "BeachJingleS",
                                     "BeachBothJungles", "BeachJungleD", "BeachSavanna", "GreentipA", "GreentipB",
                                     "HalfGreen", "BeachRockyland", "LotsaGrass", "AllBeige", "BeachMarsh", "Verdant",
                                     "VerdantMost", "Vert", "Florida Timeshare", "JungleSRockyland", "JungleSSavanna",
                                     "JungleBeige", "FullofBees", "JungleDense", "JungleDMarsh", "JungleDRockyland",
                                     "JungleDRockyMarsh", "JungleDSavanna", "JungleDSavRock", "HotNSticky", "Marshy",
                                     "NoGreen A", "NoGreen B", "Savanna", "Rockyland", "PalmTreeIsland",
                                     "IslandParadise", "PiggyParadise", "BeachPalmForest", "ThemeMarshCity",
                                     "Spiderland", "IslandJungleBamboozled", "IslandJungleMonkeyHell",
                                     "IslandJungleCritterCrunch", "IslandJungleShroomin", "IslandJungleRockyDrop",
                                     "IslandJungleEyePlant", "IslandJungleBerries", "IslandJungleNoBerry",
                                     "IslandJungleNoRock", "IslandJungleNoMushroom", "IslandJungleNoFlowers",
                                     "IslandJungleEvilFlowers", "IslandJungleSkeleton", "IslandBeachCrabTown",
                                     "IslandBeachDunes", "IslandBeachGrassy", "IslandBeachSappy", "IslandBeachRocky",
                                     "IslandBeachLimpety", "IslandBeachForest", "IslandBeachSpider",
                                     "IslandBeachNoFlowers", "IslandBeachNoLimpets", "IslandBeachNoCrabbits",
                                     "IslandMangroveOxBoon", "IslandMeadowBees", "IslandMeadowCarroty",
                                     "IslandRockyGold", "IslandRockyTallBeach", "IslandRockyTallJungle", "ShellingOut",
                                     "Cranium", "CrashZone"}

            if GetModConfigData("Shipwreckedworld_plus") == true then
                -- table.insert(taskset.tasks, "MISTO_eldorado")
                -- table.insert(taskset.tasks, "MISTO_tikitribe")
                -- table.insert(taskset.tasks, "MISTO_walrusvacation")
                -- table.insert(taskset.tasks, "pantanojunto")
                table.insert(taskset.tasks, "pandataskjunto")
                table.insert(taskset.tasks, "eldoradojunto")
                table.insert(taskset.tasks, "tikitribejunto")
                table.insert(taskset.tasks, "walrusvacationjunto")
            end

            -- if GetModConfigData("pandabiomeworld") == true then
            -- table.insert(taskset.tasks, "pandatask")
            -- end

            -- if GetModConfigData("swampyveniceworld") == true then
            -- table.insert(taskset.tasks, "pantano")
            -- end

            if GetModConfigData("frost_islandworld") == 10 then
                table.insert(taskset.tasks, "FrostIsland_Wildbeaver")
                table.insert(taskset.tasks, "FrostIsland_Beach")
                table.insert(taskset.tasks, "FrostIsland_deciduoustree")
                table.insert(taskset.tasks, "FrostIsland_Mammoth")
                table.insert(taskset.tasks, "FrostIsland_Mine")
                table.insert(taskset.tasks, "FrostIsland_palace")
                table.insert(taskset.tasks, "FrostIsland_maxwell")
                table.insert(taskset.tasks, "FrostIsland_icelake")
            end

            if GetModConfigData("Moonshipwrecked") == 1 then
                table.insert(taskset.tasks, "MoonIsland_IslandShards")
                table.insert(taskset.tasks, "MoonIsland_Beach")
                table.insert(taskset.tasks, "MoonIsland_Forest")
                table.insert(taskset.tasks, "MoonIsland_Baths")
                table.insert(taskset.tasks, "MoonIsland_Mine")
            end

            ---------------umcompromissing-------------------------------------
            if GLOBAL.KnownModIndex:IsModEnabled("workshop-2039181790") then
                table.insert(taskset.tasks, "GiantTrees")
            end
            ----------------------------------------------------------------------
            --------------------underwater--------------------------------------------
            if GetModConfigData("underwater") then
                table.insert(taskset.tasks, "EntranceToReef")
            end
            -----------------------------cherry forest-----------------------------------------------------
            if GLOBAL.KnownModIndex:IsModEnabled("workshop-1289779251") then

                if GetModConfigData("cherryforest") == 10 then
                    table.insert(taskset.tasks, "cherry_mainland")
                end

                if GetModConfigData("cherryforest") == 20 then
                    table.insert(taskset.tasks, "cherry_island")
                end

                if GetModConfigData("cherryforest") == 30 then
                    table.insert(taskset.tasks, "cherry_grove")
                end

                if GetModConfigData("cherryforest") == 40 then
                    table.insert(taskset.tasks, "cherry_arquipelago")
                end

                if GetModConfigData("cherryforest") == 50 then
                    AddTaskPreInit("MoonIsland_IslandShards", function(task)
                        task.room_choices["CherryForestIsland2"] = 2
                    end)
                    AddTaskPreInit("MoonIsland_Beach", function(task)
                        task.room_choices["CherryBugs"] = 1
                    end)
                    AddTaskPreInit("MoonIsland_Forest", function(task)
                        task.room_choices["CherrySpawn"] = 1
                    end)
                    AddTaskPreInit("MoonIsland_Mine", function(task)
                        task.room_choices["CherryDeepForest"] = 1
                    end)
                    AddTaskPreInit("MoonIsland_Baths", function(task)
                        task.room_choices["CherryTrees"] = 1
                    end)
                end

            end
            ----------------------------------------------------------------------------

            taskset.set_pieces = {}

            if GetModConfigData("Moonshipwrecked") == 1 then
                taskset.set_pieces["MoonAltarRockGlass"] = {
                    count = 1,
                    tasks = {"MoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockIdol"] = {
                    count = 1,
                    tasks = {"MoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockSeed"] = {
                    count = 1,
                    tasks = {"MoonIsland_Mine"}
                }
                taskset.set_pieces["BathbombedHotspring"] = {
                    count = 1,
                    tasks = {"MoonIsland_Baths"}
                }
                taskset.set_pieces["MoonFissures"] = {
                    count = 1,
                    tasks = {"MoonIsland_Fissures", "MoonIsland_Mine", "MoonIsland_Forest"}
                }
            end

            if GetModConfigData("togethercaves_shipwreckedworld") == 1 then
                taskset.set_pieces["CaveEntrance"] = {
                    count = 10,
                    tasks = {"HomeIslandSmall", "HomeIslandSmallBoon", "HomeIslandMed", "HomeIslandLarge",
                             "HomeIslandLargeBoon", "DesertIsland", -- "VolcanoIsland",
                    "JungleMarsh", "BeachJingleS", "BeachBothJungles", "BeachJungleD", "BeachSavanna", "GreentipA",
                             "GreentipB", "HalfGreen", "BeachRockyland", "LotsaGrass", "AllBeige", "BeachMarsh",
                             "Verdant", "VerdantMost", "Vert", "Florida Timeshare", "JungleSRockyland",
                             "JungleSSavanna", "JungleBeige", "FullofBees", "JungleDense", "JungleDMarsh",
                             "JungleDRockyland", "JungleDRockyMarsh", "JungleDSavanna", "JungleDSavRock", "HotNSticky",
                             "Marshy", "NoGreen A", "NoGreen B", "Savanna", "Rockyland", "PalmTreeIsland",
                             "IslandParadise", "PiggyParadise", "BeachPalmForest", "ThemeMarshCity", "Spiderland",
                             "IslandJungleBamboozled", "IslandJungleMonkeyHell", "IslandJungleCritterCrunch",
                             "IslandJungleShroomin", "IslandJungleRockyDrop", "IslandJungleEyePlant",
                             "IslandJungleBerries", "IslandJungleNoBerry", "IslandJungleNoRock",
                             "IslandJungleNoMushroom", "IslandJungleNoFlowers", "IslandJungleEvilFlowers",
                             "IslandJungleSkeleton", "IslandBeachCrabTown", "IslandBeachDunes", "IslandBeachGrassy",
                             "IslandBeachSappy", "IslandBeachRocky", "IslandBeachLimpety", "IslandBeachForest",
                             "IslandBeachSpider", "IslandBeachNoFlowers", "IslandBeachNoLimpets",
                             "IslandBeachNoCrabbits", "IslandMangroveOxBoon", "IslandMeadowBees", "IslandMeadowCarroty",
                             "IslandRockyGold", "IslandRockyTallBeach", "IslandRockyTallJungle", "ShellingOut",
                             "Cranium", "CrashZone"}
                }
            end

            if GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_exit"] = {
                    count = 1,
                    tasks = {"HomeIslandSmall", "HomeIslandSmallBoon", "HomeIslandMed", "HomeIslandLarge",
                             "HomeIslandLargeBoon", "DesertIsland", -- "VolcanoIsland",
                    "JungleMarsh", "BeachJingleS", "BeachBothJungles", "BeachJungleD", "BeachSavanna", "GreentipA",
                             "GreentipB", "HalfGreen", "BeachRockyland", "LotsaGrass", "AllBeige", "BeachMarsh",
                             "Verdant", "VerdantMost", "Vert", "Florida Timeshare", "JungleSRockyland",
                             "JungleSSavanna", "JungleBeige", "FullofBees", "JungleDense", "JungleDMarsh",
                             "JungleDRockyland", "JungleDRockyMarsh", "JungleDSavanna", "JungleDSavRock", "HotNSticky",
                             "Marshy", "NoGreen A", "NoGreen B", "Savanna", "Rockyland", "PalmTreeIsland",
                             "IslandParadise", "PiggyParadise", "BeachPalmForest", "ThemeMarshCity", "Spiderland",
                             "IslandJungleBamboozled", "IslandJungleMonkeyHell", "IslandJungleCritterCrunch",
                             "IslandJungleShroomin", "IslandJungleRockyDrop", "IslandJungleEyePlant",
                             "IslandJungleBerries", "IslandJungleNoBerry", "IslandJungleNoRock",
                             "IslandJungleNoMushroom", "IslandJungleNoFlowers", "IslandJungleEvilFlowers",
                             "IslandJungleSkeleton", "IslandBeachCrabTown", "IslandBeachDunes", "IslandBeachGrassy",
                             "IslandBeachSappy", "IslandBeachRocky", "IslandBeachLimpety", "IslandBeachForest",
                             "IslandBeachSpider", "IslandBeachNoFlowers", "IslandBeachNoLimpets",
                             "IslandBeachNoCrabbits", "IslandMangroveOxBoon", "IslandMeadowBees", "IslandMeadowCarroty",
                             "IslandRockyGold", "IslandRockyTallBeach", "IslandRockyTallJungle", "ShellingOut",
                             "Cranium", "CrashZone"}
                }
            end

            if GetModConfigData("hamletcaves_shipwreckedworld") == 1 then
                taskset.set_pieces["cave_entranceham1"] = {
                    count = 1,
                    tasks = {"HomeIslandSmall", "HomeIslandSmallBoon", "HomeIslandMed", "HomeIslandLarge",
                             "HomeIslandLargeBoon", "DesertIsland", -- "VolcanoIsland",
                    "JungleMarsh", "BeachJingleS", "BeachBothJungles", "BeachJungleD", "BeachSavanna", "GreentipA",
                             "GreentipB", "HalfGreen", "BeachRockyland", "LotsaGrass", "AllBeige", "BeachMarsh",
                             "Verdant", "VerdantMost", "Vert", "Florida Timeshare", "JungleSRockyland",
                             "JungleSSavanna", "JungleBeige", "FullofBees", "JungleDense", "JungleDMarsh",
                             "JungleDRockyland", "JungleDRockyMarsh", "JungleDSavanna", "JungleDSavRock", "HotNSticky",
                             "Marshy", "NoGreen A", "NoGreen B", "Savanna", "Rockyland", "PalmTreeIsland",
                             "IslandParadise", "PiggyParadise", "BeachPalmForest", "ThemeMarshCity", "Spiderland",
                             "IslandJungleBamboozled", "IslandJungleMonkeyHell", "IslandJungleCritterCrunch",
                             "IslandJungleShroomin", "IslandJungleRockyDrop", "IslandJungleEyePlant",
                             "IslandJungleBerries", "IslandJungleNoBerry", "IslandJungleNoRock",
                             "IslandJungleNoMushroom", "IslandJungleNoFlowers", "IslandJungleEvilFlowers",
                             "IslandJungleSkeleton", "IslandBeachCrabTown", "IslandBeachDunes", "IslandBeachGrassy",
                             "IslandBeachSappy", "IslandBeachRocky", "IslandBeachLimpety", "IslandBeachForest",
                             "IslandBeachSpider", "IslandBeachNoFlowers", "IslandBeachNoLimpets",
                             "IslandBeachNoCrabbits", "IslandMangroveOxBoon", "IslandMeadowBees", "IslandMeadowCarroty",
                             "IslandRockyGold", "IslandRockyTallBeach", "IslandRockyTallJungle", "ShellingOut",
                             "Cranium", "CrashZone"}
                }
                taskset.set_pieces["cave_entranceham2"] = {
                    count = 1,
                    tasks = {"HomeIslandSmall", "HomeIslandSmallBoon", "HomeIslandMed", "HomeIslandLarge",
                             "HomeIslandLargeBoon", "DesertIsland", -- "VolcanoIsland",
                    "JungleMarsh", "BeachJingleS", "BeachBothJungles", "BeachJungleD", "BeachSavanna", "GreentipA",
                             "GreentipB", "HalfGreen", "BeachRockyland", "LotsaGrass", "AllBeige", "BeachMarsh",
                             "Verdant", "VerdantMost", "Vert", "Florida Timeshare", "JungleSRockyland",
                             "JungleSSavanna", "JungleBeige", "FullofBees", "JungleDense", "JungleDMarsh",
                             "JungleDRockyland", "JungleDRockyMarsh", "JungleDSavanna", "JungleDSavRock", "HotNSticky",
                             "Marshy", "NoGreen A", "NoGreen B", "Savanna", "Rockyland", "PalmTreeIsland",
                             "IslandParadise", "PiggyParadise", "BeachPalmForest", "ThemeMarshCity", "Spiderland",
                             "IslandJungleBamboozled", "IslandJungleMonkeyHell", "IslandJungleCritterCrunch",
                             "IslandJungleShroomin", "IslandJungleRockyDrop", "IslandJungleEyePlant",
                             "IslandJungleBerries", "IslandJungleNoBerry", "IslandJungleNoRock",
                             "IslandJungleNoMushroom", "IslandJungleNoFlowers", "IslandJungleEvilFlowers",
                             "IslandJungleSkeleton", "IslandBeachCrabTown", "IslandBeachDunes", "IslandBeachGrassy",
                             "IslandBeachSappy", "IslandBeachRocky", "IslandBeachLimpety", "IslandBeachForest",
                             "IslandBeachSpider", "IslandBeachNoFlowers", "IslandBeachNoLimpets",
                             "IslandBeachNoCrabbits", "IslandMangroveOxBoon", "IslandMeadowBees", "IslandMeadowCarroty",
                             "IslandRockyGold", "IslandRockyTallBeach", "IslandRockyTallJungle", "ShellingOut",
                             "Cranium", "CrashZone"}
                }
                taskset.set_pieces["cave_entranceham3"] = {
                    count = 1,
                    tasks = {"HomeIslandSmall", "HomeIslandSmallBoon", "HomeIslandMed", "HomeIslandLarge",
                             "HomeIslandLargeBoon", "DesertIsland", -- "VolcanoIsland",
                    "JungleMarsh", "BeachJingleS", "BeachBothJungles", "BeachJungleD", "BeachSavanna", "GreentipA",
                             "GreentipB", "HalfGreen", "BeachRockyland", "LotsaGrass", "AllBeige", "BeachMarsh",
                             "Verdant", "VerdantMost", "Vert", "Florida Timeshare", "JungleSRockyland",
                             "JungleSSavanna", "JungleBeige", "FullofBees", "JungleDense", "JungleDMarsh",
                             "JungleDRockyland", "JungleDRockyMarsh", "JungleDSavanna", "JungleDSavRock", "HotNSticky",
                             "Marshy", "NoGreen A", "NoGreen B", "Savanna", "Rockyland", "PalmTreeIsland",
                             "IslandParadise", "PiggyParadise", "BeachPalmForest", "ThemeMarshCity", "Spiderland",
                             "IslandJungleBamboozled", "IslandJungleMonkeyHell", "IslandJungleCritterCrunch",
                             "IslandJungleShroomin", "IslandJungleRockyDrop", "IslandJungleEyePlant",
                             "IslandJungleBerries", "IslandJungleNoBerry", "IslandJungleNoRock",
                             "IslandJungleNoMushroom", "IslandJungleNoFlowers", "IslandJungleEvilFlowers",
                             "IslandJungleSkeleton", "IslandBeachCrabTown", "IslandBeachDunes", "IslandBeachGrassy",
                             "IslandBeachSappy", "IslandBeachRocky", "IslandBeachLimpety", "IslandBeachForest",
                             "IslandBeachSpider", "IslandBeachNoFlowers", "IslandBeachNoLimpets",
                             "IslandBeachNoCrabbits", "IslandMangroveOxBoon", "IslandMeadowBees", "IslandMeadowCarroty",
                             "IslandRockyGold", "IslandRockyTallBeach", "IslandRockyTallJungle", "ShellingOut",
                             "Cranium", "CrashZone"}
                }
            end

            taskset.ocean_prefill_setpieces["coralpool1"] = {
                count = 3 * GetModConfigData("coralbiome")
            }
            taskset.ocean_prefill_setpieces["coralpool2"] = {
                count = 3 * GetModConfigData("coralbiome")
            }
            taskset.ocean_prefill_setpieces["coralpool3"] = {
                count = 2 * GetModConfigData("coralbiome")
            }
            taskset.ocean_prefill_setpieces["octopuskinghome"] = {
                count = GetModConfigData("octopusking")
            }
            taskset.ocean_prefill_setpieces["mangrove1"] = {
                count = 2 * GetModConfigData("mangrove")
            }
            taskset.ocean_prefill_setpieces["mangrove2"] = {
                count = GetModConfigData("mangrove")
            }
            taskset.ocean_prefill_setpieces["wreck"] = {
                count = GetModConfigData("shipgraveyard")
            }
            taskset.ocean_prefill_setpieces["wreck2"] = {
                count = GetModConfigData("shipgraveyard")
            }
            taskset.ocean_prefill_setpieces["kraken"] = {
                count = GetModConfigData("kraken")
            }

            taskset.ocean_population = {"OceanCoastalShore_SW", "OceanCoastal_SW", "OceanSwell_SW", "OceanRough_SW",
                                        "OceanReef_SW", "OceanHazardous_SW"}

            taskset.location = "forest"

        end

        AddTaskSetPreInitAny(TasksetPreInit)

    else

        if GetModConfigData("startlocation") == 5 then
            if GetModConfigData("tropicalshards") == 30 then
                AddStartLocation("tropicalexperience", {
                    name = "tropicalexperience",
                    location = "forest",
                    start_setpeice = "lobby",
                    start_node = "Clearing"
                })
            else
                AddStartLocation("tropicalexperience", {
                    name = "tropicalexperience",
                    location = "forest",
                    start_setpeice = "DefaultStart",
                    start_node = "Clearing"
                })
            end

        end

        if GetModConfigData("startlocation") == 10 then
            AddStartLocation("tropicalexperience", {
                name = "tropicalexperience",
                location = "forest",
                start_setpeice = "BeachStart",
                start_node = "MAINBeachPortalRoom"
            })
        end

        if GetModConfigData("startlocation") == 15 then
            AddStartLocation("tropicalexperience", {
                name = "tropicalexperience",
                location = "forest",
                start_setpeice = "porkland_start",
                start_node = "PorklandPortalRoom"
            })
        end

        local function LevelPreInit(level)

            if level.location == "cave" then
                level.overrides.keep_disconnected_tiles = true
                table.insert(level.tasks, "separavulcao")

                if GetModConfigData("hamlet_caves") == 1 then
                    table.insert(level.tasks, "separahamcave")
                    table.insert(level.tasks, "HamMudWorld")
                    table.insert(level.tasks, "HamMudCave")
                    table.insert(level.tasks, "HamMudLights")
                    table.insert(level.tasks, "HamMudPit")

                    table.insert(level.tasks, "HamBigBatCave")
                    table.insert(level.tasks, "HamRockyLand")
                    table.insert(level.tasks, "HamRedForest")
                    table.insert(level.tasks, "HamGreenForest")
                    table.insert(level.tasks, "HamBlueForest")
                    table.insert(level.tasks, "HamSpillagmiteCaverns")
                    table.insert(level.tasks, "HamSpillagmiteCaverns1")
                    table.insert(level.tasks, "caveruinsexit")
                    table.insert(level.tasks, "caveruinsexit2")

                    table.insert(level.tasks, "HamMoonCaveForest")
                    table.insert(level.tasks, "HamArchiveMaze")

                end

                if GetModConfigData("Volcano") == true and GetModConfigData("Shipwrecked") ~= 5 or
                    GetModConfigData("tropicalshards") == 30 then
                    table.insert(level.tasks, "vulcaonacaverna")
                    table.insert(level.tasks, "vulcaonacaverna1")
                    table.insert(level.tasks, "vulcaonacaverna2")
                    table.insert(level.tasks, "vulcaonacaverna3")
                    table.insert(level.tasks, "vulcaonacaverna4")
                end

                if GetModConfigData("frost_island") == 10 then
                    table.insert(level.tasks, "frostcavedivide")
                    table.insert(level.tasks, "Frostcavetask")
                    table.insert(level.tasks, "frostExitRoom")
                end

                table.insert(level.tasks, "underwaterdivide")
                if GetModConfigData("underwater") then
                    table.insert(level.tasks, "UnderwaterStart")
                    table.insert(level.tasks, "SandyBiome")
                    table.insert(level.tasks, "ReefBiome")
                    table.insert(level.tasks, "KelpBiome")
                    table.insert(level.tasks, "RockyBiome")
                    table.insert(level.tasks, "MoonBiome")
                    table.insert(level.tasks, "OpenWaterBiome")
                    table.insert(level.tasks, "task_underground_beach")
                    table.insert(level.tasks, "task_underwaterothers")
                    table.insert(level.tasks, "task_underwater_kraken_zone")
                    table.insert(level.tasks, "secretcavedivisor")
                    table.insert(level.tasks, "task_secretcave1")
                    table.insert(level.tasks, "atlantidaExitRoom")
                    table.insert(level.tasks, "task_underwaterlavarock")
                    table.insert(level.tasks, "task_underwatermagmafield")
                    table.insert(level.tasks, "task_underwaterwatercoral")
                    if GetModConfigData("Shipwrecked") ~= 5 or GetModConfigData("enableallprefabs") == true then
                        table.insert(level.tasks, "UnderwaterExit1")
                    end
                    if GetModConfigData("Hamlet") ~= 5 or GetModConfigData("kindofworld") == 5 or
                        GetModConfigData("enableallprefabs") == true then
                        table.insert(level.tasks, "UnderwaterExit2")
                    end
                end

            end

            if level.location == "forest" then
                level.overrides.start_location = "tropicalexperience"
            end

        end

        AddLevelPreInitAny(LevelPreInit)

        local function TasksetPreInit(taskset)
            if taskset.location ~= "forest" then
                return
            end
            taskset.tasks = {}

            if GetModConfigData("startlocation") == 5 then
                table.insert(taskset.tasks, "Make a pick")

                if GetModConfigData("Together") ~= 20 then
                    table.insert(taskset.tasks, "Dig that rock")
                end
                taskset.valid_start_tasks = {"Make a pick"}
            end

            if GetModConfigData("startlocation") == 10 then
                table.insert(taskset.tasks, "iniciosw")
                table.insert(taskset.tasks, "iniciosw2")

                taskset.valid_start_tasks = {"iniciosw"}
            end

            if GetModConfigData("startlocation") == 15 then
                table.insert(taskset.tasks, "inicioham")
                table.insert(taskset.tasks, "inicioham2")

                taskset.valid_start_tasks = {"inicioham"}
            end

            if GetModConfigData("Hamlet") == 20 then
                table.insert(taskset.tasks, "Edge_of_the_unknown") -- pugalisk
                -- table.insert(taskset.tasks, "XEdge_of_the_unknown")
                table.insert(taskset.tasks, "Xplains")
                table.insert(taskset.tasks, "Xplains_ruins")
                table.insert(taskset.tasks, "XDeep_rainforest")
                table.insert(taskset.tasks, "XDeep_rainforest_2")
                table.insert(taskset.tasks, "Xpainted_sands")
                table.insert(taskset.tasks, "XEdge_of_civilization")
                table.insert(taskset.tasks, "XDeep_rainforest_mandrake")
                table.insert(taskset.tasks, "Xrainforest_ruins")
                table.insert(taskset.tasks, "XDeep_lost_ruins_gas")
                table.insert(taskset.tasks, "XEdge_of_the_unknown_2")
            end

            if GetModConfigData("Hamlet") == 15 then

                table.insert(taskset.tasks, "Edge_of_the_unknown")
                table.insert(taskset.tasks, "plains")
                table.insert(taskset.tasks, "plains_ruins")
                table.insert(taskset.tasks, "Deep_rainforest")
                table.insert(taskset.tasks, "Deep_rainforest_2")
                table.insert(taskset.tasks, "painted_sands")
                table.insert(taskset.tasks, "Edge_of_civilization")
                table.insert(taskset.tasks, "Deep_rainforest_mandrake")
                table.insert(taskset.tasks, "rainforest_ruins")
                table.insert(taskset.tasks, "Deep_lost_ruins_gas")
                table.insert(taskset.tasks, "Edge_of_the_unknown_2")
            end

            if GetModConfigData("Hamlet") == 10 then
                -- table.insert(taskset.tasks, "MEdge_of_the_unknown")
                table.insert(taskset.tasks, "Edge_of_the_unknown") -- pugalisk
                table.insert(taskset.tasks, "Mplains")
                table.insert(taskset.tasks, "Mplains_ruins")
                table.insert(taskset.tasks, "MDeep_rainforest")
                table.insert(taskset.tasks, "MDeep_rainforest_2")
                table.insert(taskset.tasks, "Mpainted_sands")
                table.insert(taskset.tasks, "MEdge_of_civilization")
                table.insert(taskset.tasks, "MDeep_rainforest_mandrake")
                table.insert(taskset.tasks, "Mrainforest_ruins")
                table.insert(taskset.tasks, "MDeep_lost_ruins_gas")
                table.insert(taskset.tasks, "MEdge_of_the_unknown_2")
            end

            ---------------------Main Land------------------------	
            if GetModConfigData("pigcity1") == 10 then
                table.insert(taskset.tasks, "XPigcity")
                table.insert(taskset.tasks, "XPigcityside1")
                table.insert(taskset.tasks, "XPigcityside2")
                table.insert(taskset.tasks, "XPigcityside3")
                table.insert(taskset.tasks, "XPigcityside4")
            end

            ------------continent----------------------
            if GetModConfigData("pigcity1") == 15 then
                table.insert(taskset.tasks, "MPigcity")
                table.insert(taskset.tasks, "MPigcityside1")
                table.insert(taskset.tasks, "MPigcityside2")
                table.insert(taskset.tasks, "MPigcityside3")
                table.insert(taskset.tasks, "MPigcityside4")
            end

            --------------island-------------------------
            if GetModConfigData("pigcity1") == 20 then
                table.insert(taskset.tasks, "Pigcity")
                table.insert(taskset.tasks, "Deep_rainforest_4")
            end

            ---------------------Main Land------------------------	
            if GetModConfigData("pigcity2") == 10 then
                table.insert(taskset.tasks, "XPigcity2")
                table.insert(taskset.tasks, "XPigcity2side1")
                table.insert(taskset.tasks, "XPigcity2side2")
                table.insert(taskset.tasks, "XPigcity2side3")
                table.insert(taskset.tasks, "XPigcity2side4")
                table.insert(taskset.tasks, "XDeep_rainforest_3")
            end

            ------------continent----------------------
            if GetModConfigData("pigcity2") == 15 then
                table.insert(taskset.tasks, "MPigcity2")
                table.insert(taskset.tasks, "MPigcity2side1")
                table.insert(taskset.tasks, "MPigcity2side2")
                table.insert(taskset.tasks, "MPigcity2side3")
                table.insert(taskset.tasks, "MPigcity2side4")
                table.insert(taskset.tasks, "MDeep_rainforest_3")
            end

            --------------island-------------------------
            if GetModConfigData("pigcity2") == 20 then
                table.insert(taskset.tasks, "Pigcity2")
                table.insert(taskset.tasks, "Deep_rainforest_3")
            end

            if GetModConfigData("pinacle") == 1 then
                table.insert(taskset.tasks, "pincale")
            end

            if GetModConfigData("gorgeisland") == 1 then
                table.insert(taskset.tasks, "gorgeisland")
            end

            if GetModConfigData("frost_island") == 10 then
                table.insert(taskset.tasks, "FrostIsland_Wildbeaver")
                table.insert(taskset.tasks, "FrostIsland_Beach")
                table.insert(taskset.tasks, "FrostIsland_deciduoustree")
                table.insert(taskset.tasks, "FrostIsland_Mammoth")
                table.insert(taskset.tasks, "FrostIsland_Mine")
                table.insert(taskset.tasks, "FrostIsland_palace")
                table.insert(taskset.tasks, "FrostIsland_maxwell")
                table.insert(taskset.tasks, "FrostIsland_icelake")
            end

            if GetModConfigData("Shipwrecked_plus") == true then
                -- table.insert(taskset.tasks, "MISTO_eldorado")
                -- table.insert(taskset.tasks, "MISTO_tikitribe")
                -- table.insert(taskset.tasks, "MISTO_walrusvacation")
                -- table.insert(taskset.tasks, "pantanojunto")
                table.insert(taskset.tasks, "pandataskjunto")
                table.insert(taskset.tasks, "eldoradojunto")
                table.insert(taskset.tasks, "tikitribejunto")
                table.insert(taskset.tasks, "walrusvacationjunto")
            end

            -- if GetModConfigData("pandabiome") == true then
            -- table.insert(taskset.tasks, "pandatask")
            -- end

            -- if GetModConfigData("swampyvenice") == true then
            -- table.insert(taskset.tasks, "pantano")
            -- end

            if 1 == 2 then
                table.insert(taskset.tasks, "pantanojunto")
                table.insert(taskset.tasks, "pandataskjunto")
                table.insert(taskset.tasks, "eldoradojunto")
                table.insert(taskset.tasks, "tikitribejunto")
                table.insert(taskset.tasks, "walrusvacationjunto")
                table.insert(taskset.tasks, "pincalejunto")
                table.insert(taskset.tasks, "gorgeislandjunto")
            end

            if GetModConfigData("Shipwrecked") == 10 then
                table.insert(taskset.tasks, "MISTO6")
                table.insert(taskset.tasks, "MISTO7")
                table.insert(taskset.tasks, "MISTO8")
                table.insert(taskset.tasks, "MISTO9")
                table.insert(taskset.tasks, "MISTO11")
                table.insert(taskset.tasks, "MISTO14")
                table.insert(taskset.tasks, "MISTO15")
                table.insert(taskset.tasks, "MISTO16")
                table.insert(taskset.tasks, "MISTO17")
                table.insert(taskset.tasks, "MISTO20")
                table.insert(taskset.tasks, "MISTO26")
                table.insert(taskset.tasks, "MISTO27")
                table.insert(taskset.tasks, "MISTO28")
                table.insert(taskset.tasks, "MISTO38")
                table.insert(taskset.tasks, "MISTO39")
                table.insert(taskset.tasks, "MISTO43")
                table.insert(taskset.tasks, "MISTO45")
                table.insert(taskset.tasks, "MISTO50")
                table.insert(taskset.tasks, "MISTO51")
            end

            if GetModConfigData("Shipwrecked") == 15 then
                table.insert(taskset.tasks, "TROPICAL6")
                table.insert(taskset.tasks, "TROPICAL7")
                table.insert(taskset.tasks, "TROPICAL8")
                table.insert(taskset.tasks, "TROPICAL9")
                table.insert(taskset.tasks, "TROPICAL11")
                table.insert(taskset.tasks, "TROPICAL14")
                table.insert(taskset.tasks, "TROPICAL15")
                table.insert(taskset.tasks, "TROPICAL16")
                table.insert(taskset.tasks, "TROPICAL17")
                table.insert(taskset.tasks, "TROPICAL20")
                table.insert(taskset.tasks, "TROPICAL26")
                table.insert(taskset.tasks, "TROPICAL27")
                table.insert(taskset.tasks, "TROPICAL28")
                table.insert(taskset.tasks, "TROPICAL38")
                table.insert(taskset.tasks, "TROPICAL39")
                table.insert(taskset.tasks, "TROPICAL43")
                table.insert(taskset.tasks, "TROPICAL45")
                table.insert(taskset.tasks, "TROPICAL50")
                table.insert(taskset.tasks, "TROPICAL51")
            end

            if GetModConfigData("Shipwrecked") == 20 then
                table.insert(taskset.tasks, "XISTO6")
                table.insert(taskset.tasks, "XISTO7")
                table.insert(taskset.tasks, "XISTO8")
                table.insert(taskset.tasks, "XISTO9")
                table.insert(taskset.tasks, "XISTO11")
                table.insert(taskset.tasks, "XISTO14")
                table.insert(taskset.tasks, "XISTO15")
                table.insert(taskset.tasks, "XISTO16")
                table.insert(taskset.tasks, "XISTO17")
                table.insert(taskset.tasks, "XISTO20")
                table.insert(taskset.tasks, "XISTO26")
                table.insert(taskset.tasks, "XISTO27")
                table.insert(taskset.tasks, "XISTO28")
                table.insert(taskset.tasks, "XISTO38")
                table.insert(taskset.tasks, "XISTO39")
                table.insert(taskset.tasks, "XISTO43")
                table.insert(taskset.tasks, "XISTO45")
                table.insert(taskset.tasks, "XISTO50")
                table.insert(taskset.tasks, "XISTO51")

                -- table.insert(taskset.tasks, "MAGMAFIELD_TASK_FOREST")
                -- table.insert(taskset.tasks, "VOLCANO_TASK_FOREST")
                -- table.insert(taskset.tasks, "MEADOW_TASK_FOREST")
                -- table.insert(taskset.tasks, "TIDALMARSH_TASK_FOREST")
                -- table.insert(taskset.tasks, "JUNGLE_TASK_FOREST")
                -- table.insert(taskset.tasks, "BEACH_TASK_FOREST")
            end

            if GetModConfigData("Shipwrecked") == 25 then
                table.insert(taskset.tasks, "A_MISTO6")
                table.insert(taskset.tasks, "A_MISTO7")
                table.insert(taskset.tasks, "A_MISTO8")
                table.insert(taskset.tasks, "A_MISTO9")
                table.insert(taskset.tasks, "A_MISTO11")
                table.insert(taskset.tasks, "A_MISTO14")
                table.insert(taskset.tasks, "A_MISTO15")
                table.insert(taskset.tasks, "A_MISTO16")
                table.insert(taskset.tasks, "A_MISTO17")
                table.insert(taskset.tasks, "A_MISTO20")
                table.insert(taskset.tasks, "A_MISTO26")
                table.insert(taskset.tasks, "A_MISTO27")
                table.insert(taskset.tasks, "A_MISTO28")
                table.insert(taskset.tasks, "A_MISTO38")
                table.insert(taskset.tasks, "A_MISTO39")
                table.insert(taskset.tasks, "A_MISTO43")
                table.insert(taskset.tasks, "A_MISTO45")
                table.insert(taskset.tasks, "A_MISTO50")
                table.insert(taskset.tasks, "A_MISTO51")
                table.insert(taskset.tasks, "A_BLANK1")
                table.insert(taskset.tasks, "A_BLANK2")
                table.insert(taskset.tasks, "A_BLANK3")
                table.insert(taskset.tasks, "A_BLANK4")
                table.insert(taskset.tasks, "A_BLANK5")
                table.insert(taskset.tasks, "A_BLANK6")
                table.insert(taskset.tasks, "A_BLANK7")
                table.insert(taskset.tasks, "A_BLANK8")
                table.insert(taskset.tasks, "A_BLANK9")
                table.insert(taskset.tasks, "A_BLANK10")
                table.insert(taskset.tasks, "A_BLANK11")
                table.insert(taskset.tasks, "A_BLANK12")
            end

            if GetModConfigData("Together") == 10 then
                table.insert(taskset.tasks, "XDig that rock")
                table.insert(taskset.tasks, "XGreat Plains")
                table.insert(taskset.tasks, "XSqueltch")
                table.insert(taskset.tasks, "XBeeeees!")
                table.insert(taskset.tasks, "XSpeak to the king")
                table.insert(taskset.tasks, "XForest hunters")
                table.insert(taskset.tasks, "XBadlands")
                table.insert(taskset.tasks, "XFor a nice walk")
                table.insert(taskset.tasks, "XLightning Bluff")
                table.insert(taskset.tasks, "XBefriend the pigs")
                table.insert(taskset.tasks, "XKill the spiders")
                table.insert(taskset.tasks, "XKiller bees!")
            end

            if GetModConfigData("Together") == 15 then
                table.insert(taskset.tasks, "MDig that rock")
                table.insert(taskset.tasks, "MGreat Plains")
                table.insert(taskset.tasks, "MSqueltch")
                table.insert(taskset.tasks, "MBeeeees!")
                table.insert(taskset.tasks, "MSpeak to the king")
                table.insert(taskset.tasks, "MForest hunters")
                table.insert(taskset.tasks, "MBadlands")
                table.insert(taskset.tasks, "MFor a nice walk")
                table.insert(taskset.tasks, "MLightning Bluff")
                table.insert(taskset.tasks, "MBefriend the pigs")
                table.insert(taskset.tasks, "MKill the spiders")
                table.insert(taskset.tasks, "MKiller bees!")
            end

            if GetModConfigData("Together") == 20 then
                table.insert(taskset.tasks, "Dig that rock")
                table.insert(taskset.tasks, "Great Plains")
                table.insert(taskset.tasks, "Squeltch")
                table.insert(taskset.tasks, "Beeeees!")
                table.insert(taskset.tasks, "Speak to the king")
                table.insert(taskset.tasks, "Forest hunters")
                table.insert(taskset.tasks, "Badlands")
                table.insert(taskset.tasks, "For a nice walk")
                table.insert(taskset.tasks, "Lightning Bluff")
            end

            if GLOBAL.KnownModIndex:IsModEnabled("workshop-2039181790") then
                table.insert(taskset.tasks, "GiantTrees")
            end

            if GetModConfigData("underwater") then
                table.insert(taskset.tasks, "EntranceToReef")
            end

            -----------------------------cherry forest-----------------------------------------------------
            if GLOBAL.KnownModIndex:IsModEnabled("workshop-1289779251") then

                if GetModConfigData("cherryforest") == 10 then
                    table.insert(taskset.tasks, "cherry_mainland")
                end

                if GetModConfigData("cherryforest") == 20 then
                    table.insert(taskset.tasks, "cherry_island")
                end

                if GetModConfigData("cherryforest") == 30 then
                    table.insert(taskset.tasks, "cherry_grove")
                end

                if GetModConfigData("cherryforest") == 40 then
                    table.insert(taskset.tasks, "cherry_arquipelago")
                end

                if GetModConfigData("cherryforest") == 50 then
                    AddTaskPreInit("MoonIsland_IslandShards", function(task)
                        task.room_choices["CherryForestIsland2"] = 2
                    end)
                    AddTaskPreInit("MoonIsland_Beach", function(task)
                        task.room_choices["CherryBugs"] = 1
                    end)
                    AddTaskPreInit("MoonIsland_Forest", function(task)
                        task.room_choices["CherrySpawn"] = 1
                    end)
                    AddTaskPreInit("MoonIsland_Mine", function(task)
                        task.room_choices["CherryDeepForest"] = 1
                    end)
                    AddTaskPreInit("MoonIsland_Baths", function(task)
                        task.room_choices["CherryTrees"] = 1
                    end)
                end

            end
            ----------------------------------------------------------------------------

            if GetModConfigData("Moon") == 10 then
                table.insert(taskset.tasks, "MoonIsland_IslandShards")
                table.insert(taskset.tasks, "MoonIsland_Beach")
                table.insert(taskset.tasks, "MoonIsland_Forest")
                table.insert(taskset.tasks, "MoonIsland_Baths")
                table.insert(taskset.tasks, "MoonIsland_Mine")
            end

            if GetModConfigData("Moon") == 15 then
                table.insert(taskset.tasks, "XMoonIsland_IslandShards")
                table.insert(taskset.tasks, "XMoonIsland_Beach")
                table.insert(taskset.tasks, "XMoonIsland_Forest")
                table.insert(taskset.tasks, "XMoonIsland_Baths")
                table.insert(taskset.tasks, "XMoonIsland_Mine")
            end

            if GetModConfigData("Moon") == 20 then
                table.insert(taskset.tasks, "MMoonIsland_IslandShards")
                table.insert(taskset.tasks, "MMoonIsland_Beach")
                table.insert(taskset.tasks, "MMoonIsland_Forest")
                table.insert(taskset.tasks, "MMoonIsland_Baths")
                table.insert(taskset.tasks, "MMoonIsland_Mine")
            end

            -----------------------------------------------a partir daqui modo de jogo 3 ilhas------------------------------------------------------------------------------

            taskset.numoptionaltasks = 0
            taskset.optionaltasks = {}

            if GetModConfigData("Together") == 20 then
                taskset.numoptionaltasks = 5
                table.insert(taskset.optionaltasks, "Befriend the pigs")
                table.insert(taskset.optionaltasks, "Kill the spiders")
                table.insert(taskset.optionaltasks, "Killer bees!")
                table.insert(taskset.optionaltasks, "Make a Beehat")
                table.insert(taskset.optionaltasks, "The hunters")
                table.insert(taskset.optionaltasks, "Magic meadow")
                table.insert(taskset.optionaltasks, "Frogs and bugs")
                table.insert(taskset.optionaltasks, "Mole Colony Deciduous")
                table.insert(taskset.optionaltasks, "Mole Colony Rocks")
                table.insert(taskset.optionaltasks, "MooseBreedingTask")
            end

            if GetModConfigData("Together") == 15 then
                taskset.numoptionaltasks = 2
                table.insert(taskset.optionaltasks, "MMake a Beehat")
                table.insert(taskset.optionaltasks, "MThe hunters")
                table.insert(taskset.optionaltasks, "MMagic meadow")
                table.insert(taskset.optionaltasks, "MFrogs and bugs")
                table.insert(taskset.optionaltasks, "MMole Colony Deciduous")
                table.insert(taskset.optionaltasks, "MMole Colony Rocks")
                table.insert(taskset.optionaltasks, "MMooseBreedingTask")
            end

            if GetModConfigData("Together") == 10 then
                taskset.numoptionaltasks = 2
                table.insert(taskset.optionaltasks, "XMake a Beehat")
                table.insert(taskset.optionaltasks, "XThe hunters")
                table.insert(taskset.optionaltasks, "XMagic meadow")
                table.insert(taskset.optionaltasks, "XFrogs and bugs")
                table.insert(taskset.optionaltasks, "XMole Colony Deciduous")
                table.insert(taskset.optionaltasks, "XMole Colony Rocks")
                table.insert(taskset.optionaltasks, "XMooseBreedingTask")
            end

            taskset.set_pieces = {}

            if GetModConfigData("Together") == 10 then
                taskset.set_pieces = {
                    ["ResurrectionStone"] = {
                        count = 2,
                        tasks = {"Make a pick", "XDig that rock", "XGreat Plains", "XSqueltch", "XBeeeees!",
                                 "XSpeak to the king", "XForest hunters", "XBadlands", "XFor a nice walk",
                                 "XLightning Bluff"}
                    },
                    ["WormholeGrass"] = {
                        count = 8,
                        tasks = {"Make a pick", "XDig that rock", "XGreat Plains", "XSqueltch", "XBeeeees!",
                                 "XSpeak to the king", "XForest hunters", "XBadlands", "XFor a nice walk",
                                 "XLightning Bluff"}
                    },
                    ["MooseNest"] = {
                        count = 9,
                        tasks = {"Make a pick", "XDig that rock", "XGreat Plains", "XSqueltch", "XBeeeees!",
                                 "XSpeak to the king", "XForest hunters", "XBadlands", "XFor a nice walk",
                                 "XLightning Bluff"}
                    },
                    ["CaveEntrance"] = {
                        count = 10,
                        tasks = {"Make a pick", "XDig that rock", "XGreat Plains", "XSqueltch", "XBeeeees!",
                                 "XSpeak to the king", "XForest hunters", "XBadlands", "XFor a nice walk",
                                 "XLightning Bluff"}
                    },
                    ["Sculptures_5"] = {
                        count = 1,
                        tasks = {"Make a pick", "XDig that rock", "XGreat Plains", "XSqueltch", "XBeeeees!",
                                 "XSpeak to the king", "XForest hunters", "XBadlands", "XFor a nice walk",
                                 "XLightning Bluff"}
                    }
                }
            end

            if GetModConfigData("Together") == 15 then
                taskset.set_pieces = {
                    ["ResurrectionStone"] = {
                        count = 2,
                        tasks = {"Make a pick", "MDig that rock", "MGreat Plains", "MSqueltch", "MBeeeees!",
                                 "MSpeak to the king", "MForest hunters", "MBadlands", "MFor a nice walk",
                                 "MLightning Bluff"}
                    },
                    ["WormholeGrass"] = {
                        count = 8,
                        tasks = {"Make a pick", "MDig that rock", "MGreat Plains", "MSqueltch", "MBeeeees!",
                                 "MSpeak to the king", "MForest hunters", "MBadlands", "MFor a nice walk",
                                 "MLightning Bluff"}
                    },
                    ["MooseNest"] = {
                        count = 9,
                        tasks = {"Make a pick", "MDig that rock", "MGreat Plains", "MSqueltch", "MBeeeees!",
                                 "MSpeak to the king", "MForest hunters", "MBadlands", "MFor a nice walk",
                                 "MLightning Bluff"}
                    },
                    ["CaveEntrance"] = {
                        count = 10,
                        tasks = {"Make a pick", "MDig that rock", "MGreat Plains", "MSqueltch", "MBeeeees!",
                                 "MSpeak to the king", "MForest hunters", "MBadlands", "MFor a nice walk",
                                 "MLightning Bluff"}
                    },
                    ["Sculptures_5"] = {
                        count = 1,
                        tasks = {"Make a pick", "MDig that rock", "MGreat Plains", "MSqueltch", "MBeeeees!",
                                 "MSpeak to the king", "MForest hunters", "MBadlands", "MFor a nice walk",
                                 "MLightning Bluff"}
                    }
                }
            end

            if GetModConfigData("Together") == 20 then
                taskset.set_pieces = {
                    ["ResurrectionStone"] = {
                        count = 2,
                        tasks = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!",
                                 "Speak to the king", "Forest hunters", "Badlands", "For a nice walk", "Lightning Bluff"}
                    },
                    ["WormholeGrass"] = {
                        count = 8,
                        tasks = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!",
                                 "Speak to the king", "Forest hunters", "Badlands", "For a nice walk", "Lightning Bluff"}
                    },
                    ["MooseNest"] = {
                        count = 9,
                        tasks = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!",
                                 "Speak to the king", "Forest hunters", "Badlands", "For a nice walk", "Lightning Bluff"}
                    },
                    ["CaveEntrance"] = {
                        count = 10,
                        tasks = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!",
                                 "Speak to the king", "Forest hunters", "Badlands", "For a nice walk", "Lightning Bluff"}
                    },
                    ["Sculptures_5"] = {
                        count = 1,
                        tasks = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!",
                                 "Speak to the king", "Forest hunters", "Badlands", "For a nice walk", "Lightning Bluff"}
                    }
                }
            end

            if GetModConfigData("Moon") == 10 then
                taskset.set_pieces["MoonAltarRockGlass"] = {
                    count = 1,
                    tasks = {"MoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockIdol"] = {
                    count = 1,
                    tasks = {"MoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockSeed"] = {
                    count = 1,
                    tasks = {"MoonIsland_Mine"}
                }
                taskset.set_pieces["BathbombedHotspring"] = {
                    count = 1,
                    tasks = {"MoonIsland_Baths"}
                }
                taskset.set_pieces["MoonFissures"] = {
                    count = 1,
                    tasks = {"MoonIsland_Fissures", "MoonIsland_Mine", "MoonIsland_Forest"}
                }
            end

            if GetModConfigData("Moon") == 15 then
                taskset.set_pieces["MoonAltarRockGlass"] = {
                    count = 1,
                    tasks = {"XMoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockIdol"] = {
                    count = 1,
                    tasks = {"XMoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockSeed"] = {
                    count = 1,
                    tasks = {"XMoonIsland_Mine"}
                }
                taskset.set_pieces["BathbombedHotspring"] = {
                    count = 1,
                    tasks = {"XMoonIsland_Baths"}
                }
                taskset.set_pieces["MoonFissures"] = {
                    count = 1,
                    tasks = {"XMoonIsland_Fissures", "XMoonIsland_Mine", "XMoonIsland_Forest"}
                }
            end

            if GetModConfigData("Moon") == 20 then
                taskset.set_pieces["MoonAltarRockGlass"] = {
                    count = 1,
                    tasks = {"MMoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockIdol"] = {
                    count = 1,
                    tasks = {"MMoonIsland_Mine"}
                }
                taskset.set_pieces["MoonAltarRockSeed"] = {
                    count = 1,
                    tasks = {"MMoonIsland_Mine"}
                }
                taskset.set_pieces["BathbombedHotspring"] = {
                    count = 1,
                    tasks = {"MMoonIsland_Baths"}
                }
                taskset.set_pieces["MoonFissures"] = {
                    count = 1,
                    tasks = {"MMoonIsland_Fissures", "MMoonIsland_Mine", "MMoonIsland_Forest"}
                }
            end

            -----------------------------------

            if GetModConfigData("Together") == 10 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_entrance"] = {
                    count = 1,
                    tasks = {"Make a pick", "XDig that rock", "XGreat Plains", "XSqueltch", "XBeeeees!",
                             "XSpeak to the king", "XForest hunters", "XBadlands", "XFor a nice walk",
                             "XLightning Bluff"}
                }
                taskset.set_pieces["hamlet_entrance"] = {
                    count = 1,
                    tasks = {"Make a pick", "XDig that rock", "XGreat Plains", "XSqueltch", "XBeeeees!",
                             "XSpeak to the king", "XForest hunters", "XBadlands", "XFor a nice walk",
                             "XLightning Bluff"}
                }
            end

            if GetModConfigData("Together") == 15 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_entrance"] = {
                    count = 1,
                    tasks = {"Make a pick", "MDig that rock", "MGreat Plains", "MSqueltch", "MBeeeees!",
                             "MSpeak to the king", "MForest hunters", "MBadlands", "MFor a nice walk",
                             "MLightning Bluff"}
                }
                taskset.set_pieces["hamlet_entrance"] = {
                    count = 1,
                    tasks = {"Make a pick", "MDig that rock", "MGreat Plains", "MSqueltch", "MBeeeees!",
                             "MSpeak to the king", "MForest hunters", "MBadlands", "MFor a nice walk",
                             "MLightning Bluff"}
                }
            end

            if GetModConfigData("Together") == 20 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_entrance"] = {
                    count = 1,
                    tasks = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!",
                             "Speak to the king", "Forest hunters", "Badlands", "For a nice walk", "Lightning Bluff"}
                }
                taskset.set_pieces["hamlet_entrance"] = {
                    count = 1,
                    tasks = {"Make a pick", "Dig that rock", "Great Plains", "Squeltch", "Beeeees!",
                             "Speak to the king", "Forest hunters", "Badlands", "For a nice walk", "Lightning Bluff"}
                }
            end

            if GetModConfigData("lobbyexit") == true then
                taskset.set_pieces["lobby_exit"] = {
                    count = 1,
                    tasks = {"Make a pick"}
                }
            end

            --------------------------------

            if GetModConfigData("Shipwrecked") == 10 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_exit"] = {
                    count = 1,
                    tasks = {"MISTO6", "MISTO7", "MISTO8", "MISTO9", "MISTO11", "MISTO14", "MISTO15", "MISTO16",
                             "MISTO17", "MISTO20", "MISTO26", "MISTO27", "MISTO28", "MISTO38", "MISTO39", "MISTO43",
                             "MISTO45", "MISTO50", "MISTO51"}
                }
            end

            if GetModConfigData("Shipwrecked") == 15 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_exit"] = {
                    count = 1,
                    tasks = {"TROPICAL6", "TROPICAL7", "TROPICAL8", "TROPICAL9", "TROPICAL11", "TROPICAL14",
                             "TROPICAL15", "TROPICAL16", "TROPICAL17", "TROPICAL20", "TROPICAL26", "TROPICAL27",
                             "TROPICAL28", "TROPICAL38", "TROPICAL39", "TROPICAL43", "TROPICAL45", "TROPICAL50",
                             "TROPICAL51"}
                }
            end

            if GetModConfigData("Shipwrecked") == 20 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_exit"] = {
                    count = 1,
                    tasks = {"XISTO6", "XISTO7", "XISTO8", "XISTO9", "XISTO11", "XISTO14", "XISTO15", "XISTO16",
                             "XISTO17", "XISTO20", "XISTO26", "XISTO27", "XISTO28", "XISTO38", "XISTO39", "XISTO43",
                             "XISTO45", "XISTO50", "XISTO51"}
                }
            end

            if GetModConfigData("Shipwrecked") == 25 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["sw_exit"] = {
                    count = 1,
                    tasks = {"A_MISTO6", "A_MISTO7", "A_MISTO8", "A_MISTO9", "A_MISTO11", "A_MISTO14", "A_MISTO15",
                             "A_MISTO16", "A_MISTO17", "A_MISTO20", "A_MISTO26", "A_MISTO27", "A_MISTO28", "A_MISTO38",
                             "A_MISTO39", "A_MISTO43", "A_MISTO45", "A_MISTO50", "A_MISTO51"}
                }
            end

            -----------------------------
            if GetModConfigData("Hamlet") == 20 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["hamlet_exit"] = {
                    count = 1,
                    tasks = {"Xplains", "Xplains_ruins", "XDeep_rainforest", "XDeep_rainforest_2", "Xpainted_sands",
                             "XEdge_of_civilization", "XDeep_rainforest_mandrake", "Xrainforest_ruins"}
                }
            end

            if GetModConfigData("Hamlet") == 15 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["hamlet_exit"] = {
                    count = 1,
                    tasks = {"plains", "plains_ruins", "Deep_rainforest", "Deep_rainforest_2", "painted_sands",
                             "Edge_of_civilization", "Deep_rainforest_mandrake", "rainforest_ruins"}
                }
            end

            if GetModConfigData("Hamlet") == 10 and GetModConfigData("tropicalshards") ~= 0 then
                taskset.set_pieces["hamlet_exit"] = {
                    count = 1,
                    tasks = {"Mplains", "Mplains_ruins", "MDeep_rainforest", "MDeep_rainforest_2", "Mpainted_sands",
                             "MEdge_of_civilization", "MDeep_rainforest_mandrake", "Mrainforest_ruins"}
                }
            end
            ----------------------------

            --------------------------------------------------cave entrances hamlet----------------------------------------------------
            if GetModConfigData("Hamlet") == 20 and GetModConfigData("hamlet_caves") == 1 then
                taskset.set_pieces["cave_entranceham1"] = {
                    count = 1,
                    tasks = {"Xplains", "Xplains_ruins", "XDeep_rainforest", "XDeep_rainforest_2", "Xpainted_sands",
                             "XEdge_of_civilization", "XDeep_rainforest_mandrake", "Xrainforest_ruins"}
                }
                taskset.set_pieces["cave_entranceham2"] = {
                    count = 1,
                    tasks = {"Xplains", "Xplains_ruins", "XDeep_rainforest", "XDeep_rainforest_2", "Xpainted_sands",
                             "XEdge_of_civilization", "XDeep_rainforest_mandrake", "Xrainforest_ruins"}
                }
                taskset.set_pieces["cave_entranceham3"] = {
                    count = 1,
                    tasks = {"Xplains", "Xplains_ruins", "XDeep_rainforest", "XDeep_rainforest_2", "Xpainted_sands",
                             "XEdge_of_civilization", "XDeep_rainforest_mandrake", "Xrainforest_ruins"}
                }
            end

            if GetModConfigData("Hamlet") == 15 and GetModConfigData("hamlet_caves") == 1 then
                taskset.set_pieces["cave_entranceham1"] = {
                    count = 1,
                    tasks = {"plains", "plains_ruins", "Deep_rainforest", "Deep_rainforest_2", "painted_sands",
                             "Edge_of_civilization", "Deep_rainforest_mandrake", "rainforest_ruins"}
                }
                taskset.set_pieces["cave_entranceham2"] = {
                    count = 1,
                    tasks = {"plains", "plains_ruins", "Deep_rainforest", "Deep_rainforest_2", "painted_sands",
                             "Edge_of_civilization", "Deep_rainforest_mandrake", "rainforest_ruins"}
                }
                taskset.set_pieces["cave_entranceham3"] = {
                    count = 1,
                    tasks = {"plains", "plains_ruins", "Deep_rainforest", "Deep_rainforest_2", "painted_sands",
                             "Edge_of_civilization", "Deep_rainforest_mandrake", "rainforest_ruins"}
                }
            end

            if GetModConfigData("Hamlet") == 10 and GetModConfigData("hamlet_caves") == 1 then
                taskset.set_pieces["cave_entranceham1"] = {
                    count = 1,
                    tasks = {"Mplains", "Mplains_ruins", "MDeep_rainforest", "MDeep_rainforest_2", "Mpainted_sands",
                             "MEdge_of_civilization", "MDeep_rainforest_mandrake", "Mrainforest_ruins"}
                }
                taskset.set_pieces["cave_entranceham2"] = {
                    count = 1,
                    tasks = {"Mplains", "Mplains_ruins", "MDeep_rainforest", "MDeep_rainforest_2", "Mpainted_sands",
                             "MEdge_of_civilization", "MDeep_rainforest_mandrake", "Mrainforest_ruins"}
                }
                taskset.set_pieces["cave_entranceham3"] = {
                    count = 1,
                    tasks = {"Mplains", "Mplains_ruins", "MDeep_rainforest", "MDeep_rainforest_2", "Mpainted_sands",
                             "MEdge_of_civilization", "MDeep_rainforest_mandrake", "Mrainforest_ruins"}
                }
            end
            ----------------------------

            taskset.ocean_prefill_setpieces["coralpool1"] = {
                count = 3 * GetModConfigData("coralbiome")
            }
            taskset.ocean_prefill_setpieces["coralpool2"] = {
                count = 3 * GetModConfigData("coralbiome")
            }
            taskset.ocean_prefill_setpieces["coralpool3"] = {
                count = 2 * GetModConfigData("coralbiome")
            }
            taskset.ocean_prefill_setpieces["octopuskinghome"] = {
                count = GetModConfigData("octopusking")
            }
            taskset.ocean_prefill_setpieces["mangrove1"] = {
                count = 2 * GetModConfigData("mangrove")
            }
            taskset.ocean_prefill_setpieces["mangrove2"] = {
                count = GetModConfigData("mangrove")
            }
            taskset.ocean_prefill_setpieces["wreck"] = {
                count = GetModConfigData("shipgraveyard")
            }
            taskset.ocean_prefill_setpieces["wreck2"] = {
                count = GetModConfigData("shipgraveyard")
            }
            taskset.ocean_prefill_setpieces["kraken"] = {
                count = GetModConfigData("kraken")
            }
            taskset.ocean_prefill_setpieces["quagmire_kitchen"] = {
                count = GetModConfigData("gorgecity")
            }

            taskset.ocean_population = {"OceanCoastalShore", "OceanCoastal_TE", "OceanSwell", "OceanRough", "OceanReef",
                                        "OceanHazardous"}

            taskset.location = "forest"

        end

        AddTaskSetPreInitAny(TasksetPreInit)

    end
end
