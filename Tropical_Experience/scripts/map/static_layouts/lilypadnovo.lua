local variador = 3

return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 13,
  height = 13,
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
      width = 13,
      height = 13,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		
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
          type = "watertree_pillar3",
          shape = "rectangle",
          x = 416,
          y = 416,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	  
	  
	  
        {
          name = "",
          type = "jungle_border_vine",
          shape = "rectangle",
          x = 250,
          y = 250,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	


        {
          name = "",
          type = "jungle_border_vine",
          shape = "rectangle",
          x = 250,
          y = 600,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	



        {
          name = "",
          type = "jungle_border_vine",
          shape = "rectangle",
          x = 550,
          y = 300,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	

        {
          name = "",
          type = "jungle_border_vine",
          shape = "rectangle",
          x = 580,
          y = 620,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },		
		
        {
          name = "",
          type = "fishinholeham",
          shape = "rectangle",
          x = 270,
          y = 270,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	


        {
          name = "",
          type = "fishinholeham",
          shape = "rectangle",
          x = 270,
          y = 620,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	



        {
          name = "",
          type = "fishinholeham",
          shape = "rectangle",
          x = 570,
          y = 330,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	

        {
          name = "",
          type = "fishinholeham",
          shape = "rectangle",
          x = 600,
          y = 600,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },			
	  
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 80,
          y = variador * 48,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 128,
          y = variador * 96,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 224,
          y = variador * 48,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 240,
          y = variador * 176,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 144,
          y = variador * 240,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "driftwood_log",
          shape = "rectangle",
          x = variador * 48,
          y = variador * 176,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
		
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 256,
          y = variador * 288,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 288,
          y = variador * 96,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 48,
          y = variador * 288,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "lilypad",
          shape = "rectangle",
          x = variador * 32,
          y = variador * 96,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 192,
          y = variador * 144,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 176,
          y = variador * 128,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 160,
          y = variador * 144,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 144,
          y = variador * 208,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 192,
          y = variador * 192,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 112,
          y = variador * 176,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 80,
          y = variador * 144,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 96,
          y = variador * 112,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 192,
          y = variador * 80,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 160,
          y = variador * 48,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 64,
          y = variador * 240,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 144,
          y = variador * 288,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 224,
          y = variador * 240,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 272,
          y = variador * 224,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 288,
          y = variador * 144,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 272,
          y = variador * 48,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 32,
          y = variador * 48,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 96,
          y = variador * 288,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 16,
          y = variador * 240,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 112,
          y = variador * 48,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 240,
          y = variador * 96,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 192,
          y = variador * 272,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 96,
          y = variador * 224,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 32,
          y = variador * 144,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 128,
          y = variador * 144,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 272,
          y = variador * 176,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },		

        {
          name = "",
          type = "hippopotamoose",
          shape = "rectangle",
          x = variador * 80,
          y = variador * 48,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "hippopotamoose",
          shape = "rectangle",
          x = variador * 200,
          y = variador * 70,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "hippopotamoose",
          shape = "rectangle",
          x = variador * 150,
          y = variador * 240,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "hippopotamoose",
          shape = "rectangle",
          x = variador * 70,
          y = variador * 190,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "hippopotamoose",
          shape = "rectangle",
          x = variador * 50,
          y = variador * 120,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "hippopotamoose",
          shape = "rectangle",
          x = variador * 100,
          y = variador * 110,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
		
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 150,
          y = variador * 126,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },		
		
        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 272,
          y = variador * 256,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },	

        {
          name = "",
          type = "objetoaleatorio",
          shape = "rectangle",
          x = variador * 192,
          y = variador * 224,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        }
		
      }
    }
  }
}