function SetInfo()

--To add a new tile, you should set some parameters in the table below.
--0 [STRING] - name, name of your tile (in lower case, should match the texture and atlas in levels/tiles/) .
--1 [TABLE] (not necessary) - specs, tile edge texture, run/walk/snow/mud sounds for your tile.
--2 [TABLE] (not necessary) - turf, loot for terraformer (prefab, min count, max count), there is no loot, if not setted.
--3 [INTEGER] (not necessary) - layer, tile order in render
--4 [BOOL] (not necessary) - isfloor, if true, then the tile will be counted as flooring (can't place plants on it)

--For example: marsh_sw = { specs = {}, turf = {{"turf_test"}}, layer = 5},


	local NEW_TILE_DESCRIPTION =
	{
		magmafield = 		{ specs = {name = "cave"}, 			turf = {{"turf_magmafield"}} ,	layer = 35}, --example tile
		jungle = 			{ specs = {name = "jungle"}, 		turf = {{"turf_jungle"}} ,	layer = 25}, --example tile
		ash = 				{ specs = {name = "cave"}, 			turf = {{"turf_ash"}} ,	layer = 25}, --example tile
		volcano = 			{ specs = {name = "cave"}, 			turf = {{"turf_volcano"}} ,	layer = 25}, --example tile
		tidalmarsh = 		{ specs = {name = "beach"},			turf = {{"turf_tidalmarsh"}} ,	layer = 25}, --example tile	
		meadow = 			{ specs = {name = "jungle"}, 		turf = {{"turf_meadow"}} ,	layer = 25}, --example tile
		snakeskinfloor = 	{ specs = {name = "carpet"}, 		turf = {{"turf_snakeskinfloor"}} ,	layer = 30, isfloor = true},
		beach = 			{ specs = {name = "beach"}, 		turf = {{"turf_beach"}} ,	layer = 30},
--		water_coral = 		{ specs = {name = "water_coral"}, 	turf = {{"turf_water_coral"}} ,	layer = 20},
		water_mangrove = 	{ specs = {name = "water_mangrove"}, nil, layer = 40, isfloor = true},   -- frost
--		water_deep = 		{ specs = {name = "water_deep"}, 	layer = 33},
--		water_medium = 		{ specs = {name = "water_medium"},	layer = 25},
--		water_shallow = 	{ specs = {name = "water_shallow"} ,	layer = 120},
		plains = 			{ specs = {name = "jungle"}, 		turf = {{"turf_plains"}} ,	layer = 25}, 
		deeprainforest = 	{ specs = {name = "deeprainforest"}, turf = {{"turf_deeprainforest"}} ,	layer = 25}, 
		rainforest = 		{ specs = {name = "rainforest"}, 	turf = {{"turf_rainforest"}} ,	layer = 25}, 	
		painted = 			{ specs = {name = "deeprainforest"}, 		turf = {{"turf_painted"}} ,	layer = 25}, 
		battleground = 		{ specs = {name = "deeprainforest"}, 	turf = {{"turf_battleground"}} ,	layer = 25}, 
		gasjungle = 		{ specs = {name = "deeprainforest"}, 	turf = {{"turf_gasjungle"}} ,	layer = 25}, 
		fields = 			{ specs = {name = "jungle"}, 		turf = {{"turf_fields"}} ,	layer = 25}, 
		checkeredlawn = 	{ specs = {name = "cobbleroad"}, 		turf = {{"turf_checkeredlawn"}} ,	layer = 30, isfloor = true}, 
		suburb = 			{ specs = {name = "deciduous"}, 	turf = {{"turf_suburb"}} ,	layer = 14}, 
		beardrug = 			{ specs = {name = "rocky"}, 		turf = {{"turf_beardrug"}} ,	layer = 30, isfloor = true}, --lavarock
		foundation = 		{ specs = {name = "blocky"}, 		turf = {{"turf_foundation"}} ,	layer = 20}, 
		cobbleroad = 		{ specs = {name = "cobbleroad"}, 	turf = {{"turf_cobbleroad"}} ,	layer = 38, isfloor = true}, 
		antfloor = 			{ specs = {name = "antfloor"}, 		turf = {{"turf_antfloor"}} ,	layer = 25},    --frost lake
		batfloor = 			{ specs = {name = "batfloor"}, 		nil ,	layer = 25},    --lava floor
		pigruins = 			{ specs = {name = "carpet"}, 		nil ,	layer = 30},    --lava_trim
		underwater_sandy = 	{ specs = {name = "cave"},		layer = 5}, --example tile
		underwater_rocky = 	{ specs = {name = "marsh"},		layer = 5}, --example tile			
	}

	return NEW_TILE_DESCRIPTION
end