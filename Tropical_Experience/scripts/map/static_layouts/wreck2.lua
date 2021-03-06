return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 30,
  height = 30,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      filename = "../../../../../Checkout_1/tools/tiled/dont_starve/ground.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../../../../../Checkout_1/tools/tiled/dont_starve/tiles.png",
      imagewidth = 512,
      imageheight = 512,
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
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 18, 18, 18, 18, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 26, 26, 26, 26, 26, 18, 18, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 18, 18, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0,
        0, 0, 0, 0, 0, 0, 18, 18, 18, 26, 26, 26, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0,
        0, 0, 0, 0, 18, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0,
        0, 0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0,
        0, 0, 0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0,
        0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0,
        0, 0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0,
        0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0,
        0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0,
        0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0,
        0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0,
        0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0, 0,
        0, 0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0, 0, 0,
        0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0, 0,
        0, 0, 0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0, 0,
        0, 0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0, 0,
        0, 0, 0, 0, 18, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 18, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 18, 18, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 26, 26, 26, 26, 26, 26, 26, 18, 18, 18, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 26, 26, 26, 18, 18, 18, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 18, 18, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "FG_OBJECTS",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
	  
	  
        {
          name = "",
          type = "rookwaterfixo",
          shape = "rectangle",
          x = 700,
          y = 700,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }, 
	  
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 324,
          y = 388,
          width = 312,
          height = 377,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 674,
          y = 799,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 1312,
          y = 548,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 1116,
          y = 1252,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 643,
          y = 387,
          width = 308,
          height = 375,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 329,
          y = 771,
          width = 304,
          height = 367,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 709,
          y = 1203,
          width = 374,
          height = 367,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 647,
          y = 831,
          width = 494,
          height = 371,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 1153,
          y = 869,
          width = 420,
          height = 411,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 1097,
          y = 1295,
          width = 354,
          height = 361,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 987,
          y = 515,
          width = 288,
          height = 339,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "tar_pool",
          shape = "rectangle",
          x = 987,
          y = 165,
          width = 284,
          height = 347,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 1281,
          y = 167,
          width = 284,
          height = 347,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "debris_area",
          shape = "rectangle",
          x = 1291,
          y = 577,
          width = 284,
          height = 287,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
