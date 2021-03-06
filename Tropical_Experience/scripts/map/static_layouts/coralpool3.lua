return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 20,
  height = 20,
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
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20,
        0, 0, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0,
        0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0,
        0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0,
        20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 20, 20, 20, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 273,
          y = 254,
          width = 59,
          height = 77,
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
          x = 1040,
          y = 448,
          width = 58,
          height = 133,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 369,
          y = 513,
          width = 48,
          height = 70,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 366,
          y = 233,
          width = 50,
          height = 100,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 676,
          y = 591,
          width = 332,
          height = 41,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 294,
          y = 1037,
          width = 37,
          height = 45,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 542,
          y = 472,
          width = 71,
          height = 84,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 166,
          y = 351,
          width = 362,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coral_brain_rock",
          shape = "rectangle",
          x = 442,
          y = 1037,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 314,
          y = 620,
          width = 29,
          height = 269,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 348,
          y = 914,
          width = 75,
          height = 83,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 444,
          y = 1062,
          width = 117,
          height = 71,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 872,
          y = 368,
          width = 103,
          height = 53,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 482,
          y = 908,
          width = 85,
          height = 115,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 1024,
          y = 269,
          width = 130,
          height = 133,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 392,
          y = 620,
          width = 65,
          height = 249,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 842,
          y = 466,
          width = 149,
          height = 81,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 696,
          y = 447,
          width = 72,
          height = 87,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 211,
          y = 1113,
          width = 198,
          height = 37,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 208,
          y = 485,
          width = 112,
          height = 70,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 502,
          y = 594,
          width = 123,
          height = 236,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 1000,
          y = 458,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 482,
          y = 736,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 163,
          y = 418,
          width = 362,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 256,
          y = 398,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "coralzone",
          shape = "rectangle",
          x = 650,
          y = 588,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
