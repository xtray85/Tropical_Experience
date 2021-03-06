return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 12,
  height = 12,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "setpiecemod/tiles.png",
      imagewidth = 512,
      imageheight = 128,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "BG_TILES",
      x = 0,
      y = 0,
      width = 12,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3
      }
    },
    {
      type = "objectgroup",
      name = "FG_OBJECTS",
      visible = true,
      opacity = 0.9,
      properties = {},
      objects = {
        {
          name = "pond",
          type = "pond",
          shape = "rectangle",
          x = 550,
          y = 675,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 573,
          y = 627,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 557,
          y = 733,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 497,
          y = 674,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 343,
          y = 735,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 292,
          y = 674,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 384,
          y = 641,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 85,
          y = 729,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 173,
          y = 598,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 64,
          y = 567,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 121,
          y = 423,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 59,
          y = 297,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 51,
          y = 192,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 103,
          y = 61,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 163,
          y = 148,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 154,
          y = 215,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 674,
          y = 201,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 631,
          y = 287,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 681,
          y = 288,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 741,
          y = 425,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 649,
          y = 481,
          width = 13,
          height = 18,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 581,
          y = 492,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_tall",
          type = "cristaled_tree_tall",
          shape = "ellipse",
          x = 723,
          y = 471,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 645,
          y = 405,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 731,
          y = 531,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 645,
          y = 573,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 725,
          y = 689,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "cristaled_tree_short",
          type = "cristaled_tree_short",
          shape = "ellipse",
          x = 562,
          y = 119,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_normal",
          shape = "rectangle",
          x = 168,
          y = 699,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_short",
          shape = "rectangle",
          x = 113,
          y = 641,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_tall",
          shape = "rectangle",
          x = 260,
          y = 603,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_normal",
          shape = "rectangle",
          x = 495,
          y = 583,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_normal",
          shape = "rectangle",
          x = 707,
          y = 355,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_short",
          shape = "rectangle",
          x = 274,
          y = 119,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_tall",
          shape = "rectangle",
          x = 428,
          y = 45,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_normal",
          shape = "rectangle",
          x = 675,
          y = 90,
          width = 0,
          height = 1,
          visible = true,
          properties = {}
        },
        {
          name = "stick tree",
          type = "twiggy_tall",
          shape = "rectangle",
          x = 496,
          y = 101,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 516,
          y = 634,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 506,
          y = 717,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 252,
          y = 725,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 45,
          y = 628,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 50,
          y = 380,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 84,
          y = 443,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 164,
          y = 277,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 67,
          y = 125,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 127,
          y = 100,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 310,
          y = 47,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 419,
          y = 104,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 618,
          y = 163,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 725,
          y = 123,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "sugar can bush",
          type = "snowberrybush",
          shape = "rectangle",
          x = 670,
          y = 41,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 512,
          y = 512,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 576,
          y = 384,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 512,
          y = 256,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 384,
          y = 192,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 256,
          y = 256,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 192,
          y = 384,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 256,
          y = 512,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "frostpillar_rock",
          type = "frostpillar_rock",
          shape = "rectangle",
          x = 384,
          y = 576,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 448,
          y = 544,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 308,
          y = 536,
          width = 24,
          height = 22,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 223,
          y = 450,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 219,
          y = 314,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 450,
          y = 223,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 319,
          y = 214,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 544,
          y = 438,
          width = 22,
          height = 22,
          visible = true,
          properties = {}
        },
        {
          name = "dropperweb",
          type = "dropperweb",
          shape = "rectangle",
          x = 546,
          y = 312,
          width = 23,
          height = 22,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 410,
          y = 324,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 366,
          y = 336,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 328,
          y = 382,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 379,
          y = 385,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 428,
          y = 376,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "cave_exit_frost",
          shape = "rectangle",
          x = 462,
          y = 329,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 381,
          y = 443,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 433,
          y = 430,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 307,
          y = 325,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 362,
          y = 285,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 331,
          y = 428,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite_med",
          shape = "rectangle",
          x = 269,
          y = 372,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite_med",
          shape = "rectangle",
          x = 328,
          y = 481,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 274,
          y = 421,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 260,
          y = 325,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 307,
          y = 272,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite",
          shape = "rectangle",
          x = 419,
          y = 263,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite_med",
          shape = "rectangle",
          x = 484,
          y = 388,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite_med",
          shape = "rectangle",
          x = 381,
          y = 492,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "stalagmite_med",
          shape = "rectangle",
          x = 359,
          y = 239,
          width = 36,
          height = 36,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock",
          shape = "ellipse",
          x = 436,
          y = 700,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock1",
          shape = "ellipse",
          x = 360,
          y = 687,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock2",
          shape = "ellipse",
          x = 99,
          y = 495,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock3",
          shape = "ellipse",
          x = 143,
          y = 533,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock4",
          shape = "ellipse",
          x = 149,
          y = 345,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock5",
          shape = "ellipse",
          x = 42,
          y = 233,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock6",
          shape = "ellipse",
          x = 188,
          y = 77,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock7",
          shape = "ellipse",
          x = 62,
          y = 23,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock",
          shape = "ellipse",
          x = 325,
          y = 82,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock1",
          shape = "ellipse",
          x = 488,
          y = 29,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock2",
          shape = "ellipse",
          x = 476,
          y = 148,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock3",
          shape = "ellipse",
          x = 603,
          y = 52,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock4",
          shape = "ellipse",
          x = 736,
          y = 189,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock5",
          shape = "ellipse",
          x = 693,
          y = 419,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock6",
          shape = "ellipse",
          x = 732,
          y = 295,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock7",
          shape = "ellipse",
          x = 611,
          y = 531,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock",
          shape = "ellipse",
          x = 438,
          y = 492,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock1",
          shape = "ellipse",
          x = 234,
          y = 369,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock2",
          shape = "ellipse",
          x = 408,
          y = 273,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock3",
          shape = "ellipse",
          x = 682,
          y = 611,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock4",
          shape = "ellipse",
          x = 399,
          y = 733,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock5",
          shape = "ellipse",
          x = 463,
          y = 626,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lava_pond_rock6",
          shape = "ellipse",
          x = 679,
          y = 740,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "berrybush_juicy",
          shape = "ellipse",
          x = 610,
          y = 654,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "berrybush_juicy",
          shape = "ellipse",
          x = 617,
          y = 604,
          width = 34,
          height = 27,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "berrybush_juicy",
          shape = "ellipse",
          x = 659,
          y = 664,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pillar_stalactite",
          shape = "ellipse",
          x = 219,
          y = 653,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pillar_stalactite",
          shape = "ellipse",
          x = 378,
          y = 432,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pillar_stalactite",
          shape = "ellipse",
          x = 608,
          y = 212,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pillar_stalactite",
          shape = "ellipse",
          x = 222,
          y = 147,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pillar_stalactite",
          shape = "ellipse",
          x = 619,
          y = 697,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pillar_stalactite",
          shape = "ellipse",
          x = 658,
          y = 337,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pillar_stalactite",
          shape = "ellipse",
          x = 89,
          y = 158,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
