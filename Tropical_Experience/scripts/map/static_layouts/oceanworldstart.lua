return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 10,
  height = 10,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      filename = "../dont_starve/ground.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../dont_starve/tiles.png",
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
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 4, 0, 0, 0, 0,
        0, 0, 0, 4, 4, 4, 4, 0, 0, 0,
        0, 0, 4, 4, 4, 4, 4, 4, 0, 0,
        0, 0, 4, 4, 4, 4, 4, 4, 0, 0,
        0, 0, 4, 4, 4, 4, 4, 4, 0, 0,
        0, 0, 0, 4, 4, 4, 4, 0, 0, 0,
        0, 0, 0, 0, 4, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          type = "multiplayer_portal",
          shape = "rectangle",
          x = 318,
          y = 286,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "spawnpoint_master",
          shape = "rectangle",
          x = 319,
          y = 285,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "pig_palace2_entrance",
          shape = "rectangle",
          x = 220,
          y = 310,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	
        {
          name = "",
          type = "oincpilefree",
          shape = "rectangle",
          x = 400,
          y = 260,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	

        {
          name = "",
          type = "vidanomarseaworld",
          shape = "rectangle",
          x = 400,
          y = 260,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
		
        {
          name = "",
          type = "cave_entrance",
          shape = "rectangle",
          x = 318,
          y = 220,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },		

        {
          name = "",
          type = "seafaring_prototyper",
          shape = "rectangle",
          x = 370,
          y = 370,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },			
      }
    }
  }
}