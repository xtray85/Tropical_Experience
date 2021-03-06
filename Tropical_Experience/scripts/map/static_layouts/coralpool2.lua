return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 22,
  height = 22,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      filename = "../../../../tools/tiled/dont_starve/ground.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../../../../tools/tiled/dont_starve/tiles.png",
      imagewidth = 512,
      imageheight = 384,
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
      width = 22,
      height = 22,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 20, 20, 20, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          type = "coralzone",
          shape = "rectangle",
          x = 663,
          y = 275,
          width = 54,
          height = 269,
          visible = true,
          properties = {}
        },
		
       {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 78,
          y = 80,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },

       {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 78,
          y = 400,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },

       {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 300,
          y = 80,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },

       {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 158,
          y = 80,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },

       {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 78,
          y = 200,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },		
				
		
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 230,
          y = 718,
          width = 86,
          height = 80,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 276,
          y = 276,
          width = 109,
          height = 129,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 378,
          y = 155,
          width = 86,
          height = 68,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 458,
          y = 461,
          width = 48,
          height = 63,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 568,
          y = 457,
          width = 51,
          height = 207,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 276,
          y = 562,
          width = 57,
          height = 110,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 902,
          y = 827,
          width = 54,
          height = 144,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 788,
          y = 966,
          width = 47,
          height = 81,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 815,
          y = 856,
          width = 57,
          height = 57,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 1063,
          y = 977,
          width = 49,
          height = 220,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 399,
          y = 624,
          width = 101,
          height = 151,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 356,
          y = 615,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 433,
          y = 291,
          width = 135,
          height = 75,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 637,
          y = 183,
          width = 210,
          height = 59,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 746,
          y = 274,
          width = 90,
          height = 61,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 505,
          y = 177,
          width = 88,
          height = 67,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 157,
          y = 426,
          width = 59,
          height = 268,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 562,
          y = 712,
          width = 57,
          height = 110,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 866,
          y = 1019,
          width = 49,
          height = 134,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 988,
          y = 968,
          width = 41,
          height = 240,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 356,
          y = 433,
          width = 54,
          height = 47,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 371,
          y = 531,
          width = 54,
          height = 47,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 670,
          y = 768,
          width = 35,
          height = 45,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 728,
          y = 832,
          width = 35,
          height = 41,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 1038,
          y = 1144,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 660,
          y = 338,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 878,
          y = 970,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 450,
          y = 364,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
