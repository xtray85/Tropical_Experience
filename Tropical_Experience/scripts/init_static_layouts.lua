local require = GLOBAL.require
local GROUND = GLOBAL.GROUND
local Layouts = require("map/layouts").Layouts
local StaticLayout = require("map/static_layout")
			
Layouts["tigersharkarea"] = StaticLayout.Get("map/static_layouts/tigersharkarea", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE,})						
			
Layouts["CoffeeBushBunch"] = StaticLayout.Get("map/static_layouts/coffeebushbunch", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["Entradavulcao"] = StaticLayout.Get("map/static_layouts/volcano_start", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["ObsidianWorkbench"] = StaticLayout.Get("map/static_layouts/volcano_workbench", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["WoodlegsUnlock"] = StaticLayout.Get("map/static_layouts/woodlegs_unlock", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
			
Layouts["volcano_altar"] = StaticLayout.Get("map/static_layouts/volcano_altar", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			

Layouts["lava_arena"] = StaticLayout.Get("map/static_layouts/lava_arena", {start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED, fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = GLOBAL.LAYOUT_POSITION.CENTER, disable_transform = true,})	

Layouts["LivingJungleTree"] = StaticLayout.Get("map/static_layouts/livingjungletree")
Layouts["BerryBushBunch"] = StaticLayout.Get("map/static_layouts/berrybushbunch", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["slotmachine"] = StaticLayout.Get("map/static_layouts/slotmachine", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
            fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["skull_isle2"] = StaticLayout.Get("map/static_layouts/skull_isle2", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["coral"] = StaticLayout.Get("map/static_layouts/coral", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["entradadaarena"] = StaticLayout.Get("map/static_layouts/entradadaarena", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["doydoym"] = StaticLayout.Get("map/static_layouts/doydoym", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["doydoyf"] = StaticLayout.Get("map/static_layouts/doydoyf", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
			
Layouts["strangerlord"] = StaticLayout.Get("map/static_layouts/strangerlord", {layout_position = 1, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	
Layouts["strangerpigs"] = StaticLayout.Get("map/static_layouts/strangerpigs", {layout_position = 1, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			
Layouts["strangerlavaarena"] = StaticLayout.Get("map/static_layouts/strangerlavaarena", {layout_position = 1, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		

Layouts["eldorado"] = StaticLayout.Get("map/static_layouts/eldorado", {layout_position = 1, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	
Layouts["tikitribe"] = StaticLayout.Get("map/static_layouts/tikitribe", {
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	
Layouts["vacation"] = StaticLayout.Get("map/static_layouts/vacation", {layout_position = 1, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	

Layouts["city"] = StaticLayout.Get("map/static_layouts/city", {layout_position = 1, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	
						
Layouts["BeachStart"] = StaticLayout.Get("map/static_layouts/beachstart", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
		
Layouts["volcano_entrance"] = StaticLayout.Get("map/static_layouts/volcano_entrance", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
			
Layouts["x_spot"] = StaticLayout.Get("map/static_layouts/x_spot", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	
Layouts["lobby"] = StaticLayout.Get("map/static_layouts/lobby", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	
Layouts["mactuskgrass"] = StaticLayout.Get("map/static_layouts/mactuskgrass", {start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})				
Layouts["mastuskrocky"] = StaticLayout.Get("map/static_layouts/mastuskrocky", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	
Layouts["mactusksavanna"] = StaticLayout.Get("map/static_layouts/mactusksavanna", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		

Layouts["pugalisk_fountain"] = StaticLayout.Get("map/static_layouts/pugalisk_fountain", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["farm_1"] = StaticLayout.Get("map/static_layouts/farm_1", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["farm_2"] = StaticLayout.Get("map/static_layouts/farm_2", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["farm_3"] = StaticLayout.Get("map/static_layouts/farm_3", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["farm_4"] = StaticLayout.Get("map/static_layouts/farm_4", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["farm_5"] = StaticLayout.Get("map/static_layouts/farm_5", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["farm_fill_1"] = StaticLayout.Get("map/static_layouts/farm_fill_1", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["farm_fill_2"] = StaticLayout.Get("map/static_layouts/farm_fill_2", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["farm_fill_3"] = StaticLayout.Get("map/static_layouts/farm_fill_3", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			
Layouts["cidade1"] = StaticLayout.Get("map/static_layouts/cidade1", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		
Layouts["cidade2"] = StaticLayout.Get("map/static_layouts/cidade2", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})				
Layouts["mandraketown"] = StaticLayout.Get("map/static_layouts/mandraketown", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
		
Layouts["porkland_start"] = StaticLayout.Get("map/static_layouts/porkland_start", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["IceSpiderpillar"] = StaticLayout.Get("map/static_layouts/IceSpiderpillar", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["nettlegrove"] = StaticLayout.Get("map/static_layouts/nettlegrove", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["pantano"] = StaticLayout.Get("map/static_layouts/pantano", {layout_position = GLOBAL.LAYOUT_POSITION.RANDOM, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
			
------------------------------extras--------------------------------------------------------------------			
Layouts["pig_ruins_entrance_1"] = StaticLayout.Get("map/static_layouts/pig_ruins_entrance_1", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_entrance_2"] = StaticLayout.Get("map/static_layouts/pig_ruins_entrance_2", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_entrance_3"] = StaticLayout.Get("map/static_layouts/pig_ruins_entrance_3", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_entrance_4"] = StaticLayout.Get("map/static_layouts/pig_ruins_entrance_4", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_entrance_5"] = StaticLayout.Get("map/static_layouts/pig_ruins_entrance_5", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_exit_1"] = StaticLayout.Get("map/static_layouts/pig_ruins_exit_1", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_exit_2"] = StaticLayout.Get("map/static_layouts/pig_ruins_exit_2", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_exit_4"] = StaticLayout.Get("map/static_layouts/pig_ruins_exit_4", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			
			
Layouts["lilypad"] = StaticLayout.Get("map/static_layouts/lilypad", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["pig_ruins_artichoke"] = StaticLayout.Get("map/static_layouts/pig_ruins_artichoke", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["pig_ruins_head"] = StaticLayout.Get("map/static_layouts/pig_ruins_head", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
			
Layouts["pig_ruins_nocanopy"] = StaticLayout.Get("map/static_layouts/pig_ruins_nocanopy", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_nocanopy_2"] = StaticLayout.Get("map/static_layouts/pig_ruins_nocanopy_2", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_nocanopy_3"] = StaticLayout.Get("map/static_layouts/pig_ruins_nocanopy_3", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["pig_ruins_nocanopy_4"] = StaticLayout.Get("map/static_layouts/pig_ruins_nocanopy_4", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			
			
Layouts["roc_cave"] = StaticLayout.Get("map/static_layouts/roc_cave", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
Layouts["roc_nest"] = StaticLayout.Get("map/static_layouts/roc_nest", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		
		
Layouts["sw_exit"] = StaticLayout.Get("map/static_layouts/sw_exit", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		
Layouts["hamlet_exit"] = StaticLayout.Get("map/static_layouts/hamlet_exit", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		
Layouts["sw_entrance"] = StaticLayout.Get("map/static_layouts/sw_entrance", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		
Layouts["hamlet_entrance"] = StaticLayout.Get("map/static_layouts/hamlet_entrance", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})		

Layouts["lobby_exit"] = StaticLayout.Get("map/static_layouts/lobby_exit", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			

Layouts["cave_entranceham1"] = StaticLayout.Get("map/static_layouts/cave_entranceham1", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			

Layouts["cave_entranceham2"] = StaticLayout.Get("map/static_layouts/cave_entranceham2", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			

Layouts["cave_entranceham3"] = StaticLayout.Get("map/static_layouts/cave_entranceham3", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			

Layouts["ruins_exit"] = StaticLayout.Get("map/static_layouts/ruins_exit", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["ruins_exit2"] = StaticLayout.Get("map/static_layouts/ruins_exit2", { start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["atlantida"] = StaticLayout.Get("map/static_layouts/atlantida", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["antqueencave"] = StaticLayout.Get("map/static_layouts/antqueencave", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})

Layouts["oceanworldstart"] = StaticLayout.Get("map/static_layouts/oceanworldstart", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
		
Layouts["octopuskinghome"] = StaticLayout.Get("map/static_layouts/octopuskinghome", {
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
areas =
		{
			treearea = function() 
				local stuff = {}

				table.insert(stuff,"coralreef")
				for i=1,6 do
					if math.random() < 0.1 then
						table.insert(stuff,"coralreef")
					end
				end

				table.insert(stuff,"coralreef")
--				table.insert(stuff,"oceanvine_deco")


				if math.random()<0.2 then
					table.insert(stuff,"coralreef")
				end

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"spidercoralhole")
					end
				end	

--				for i=1,3 do
--					if math.random()<0.3 then
--						table.insert(stuff,"oceanvine_deco")
--					end
--				end				

				for i=1,4 do
					if math.random()<0.3 then
						table.insert(stuff,"fishinhole")
					end
				end
                
                for i=1,2 do
	                if math.random()<0.3 then
	                    table.insert(stuff,"ballphinhouse")
	                end
            	end


                for i=1,10 do
                    if math.random()<0.4 then
                        table.insert(stuff, "mussel_farm")
                    end
                end

				return stuff
			end,
			
			notreearea = function() 
			local variador = math.random()
			if variador > 0.4 then return {"coralreef"} else
			local tipo = math.random(1,25)
			if tipo == 1 then return {"mussel_farm"} end
			if tipo == 2 then return {"mussel_farm"} end
			if tipo == 3 then return {"mussel_farm"} end
			if tipo == 4 then return {"mussel_farm"} end
			if tipo == 5 then return {"mussel_farm"} end			
			if tipo == 6 then return {"seaweed_planted"} end
			if tipo == 7 then return {"seaweed_planted"} end
			if tipo == 8 then return {"seaweed_planted"} end
			if tipo == 9 then return {"seaweed_planted"} end
			if tipo == 10 then return {"seaweed_planted"} end
			if tipo == 11 then return {"spidercoralhole"} end			
			if tipo == 12 then return {"spidercoralhole"} end
			if tipo == 13 then return {"ballphinhouse"} end
			if tipo == 14 then return {"ballphinhouse"} end			
			if tipo == 15 then return {"ballphinhouse"} end
			if tipo == 16 then return {"fishinhole"} end
			if tipo == 17 then return {"fishinhole"} end
			if tipo == 18 then return {"fishinhole"} end
			if tipo == 19 then return {"fishinhole"} end			
			if tipo == 20 then return {"coral_brain_rock"} end
			if tipo == 21 then return {"lobsterhole"} end
			if tipo == 22 then return {"lobsterhole"} end
			if tipo == 23 then return {"lobsterhole"} end			
			if tipo == 24 then return {"messagebottle1"} end 			
			if tipo == 25 then return {"tar_pool"} end  			
				
			end		
			end,
		},

	
})	
	

Layouts["coralpool1"] = StaticLayout.Get("map/static_layouts/coralpool1", 
{
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,

	areas =
		{
			coralzone = function() 
			local variador = math.random()
			if variador > 0.4 then return {"coralreef"} else
			local tipo = math.random(1,25)
			if tipo == 1 then return {"mussel_farm"} end
			if tipo == 2 then return {"mussel_farm"} end
			if tipo == 3 then return {"mussel_farm"} end
			if tipo == 4 then return {"mussel_farm"} end
			if tipo == 5 then return {"mussel_farm"} end			
			if tipo == 6 then return {"seaweed_planted"} end
			if tipo == 7 then return {"seaweed_planted"} end
			if tipo == 8 then return {"seaweed_planted"} end
			if tipo == 9 then return {"seaweed_planted"} end
			if tipo == 10 then return {"seaweed_planted"} end
			if tipo == 11 then return {"spidercoralhole"} end			
			if tipo == 12 then return {"spidercoralhole"} end
			if tipo == 13 then return {"ballphinhouse"} end
			if tipo == 14 then return {"ballphinhouse"} end			
			if tipo == 15 then return {"ballphinhouse"} end
			if tipo == 16 then return {"fishinhole"} end
			if tipo == 17 then return {"fishinhole"} end
			if tipo == 18 then return {"fishinhole"} end
			if tipo == 19 then return {"fishinhole"} end			
			if tipo == 20 then return {"coral_brain_rock"} end
			if tipo == 21 then return {"lobsterhole"} end
			if tipo == 22 then return {"lobsterhole"} end
			if tipo == 23 then return {"lobsterhole"} end			
			if tipo == 24 then return {"messagebottle1"} end 			
			if tipo == 25 then return {"tar_pool"} end  			
				
			end

			end,	
		},
})



Layouts["coralpool2"] = StaticLayout.Get("map/static_layouts/coralpool2", 
{
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
	areas =
		{
			coralzone = function() 
			local variador = math.random()
			if variador > 0.4 then return {"coralreef"} else
			local tipo = math.random(1,25)
			if tipo == 1 then return {"mussel_farm"} end
			if tipo == 2 then return {"mussel_farm"} end
			if tipo == 3 then return {"mussel_farm"} end
			if tipo == 4 then return {"mussel_farm"} end
			if tipo == 5 then return {"mussel_farm"} end			
			if tipo == 6 then return {"seaweed_planted"} end
			if tipo == 7 then return {"seaweed_planted"} end
			if tipo == 8 then return {"seaweed_planted"} end
			if tipo == 9 then return {"seaweed_planted"} end
			if tipo == 10 then return {"seaweed_planted"} end
			if tipo == 11 then return {"spidercoralhole"} end			
			if tipo == 12 then return {"spidercoralhole"} end
			if tipo == 13 then return {"ballphinhouse"} end
			if tipo == 14 then return {"ballphinhouse"} end			
			if tipo == 15 then return {"ballphinhouse"} end
			if tipo == 16 then return {"fishinhole"} end
			if tipo == 17 then return {"fishinhole"} end
			if tipo == 18 then return {"fishinhole"} end
			if tipo == 19 then return {"fishinhole"} end			
			if tipo == 20 then return {"coral_brain_rock"} end
			if tipo == 21 then return {"lobsterhole"} end
			if tipo == 22 then return {"lobsterhole"} end
			if tipo == 23 then return {"lobsterhole"} end			
			if tipo == 24 then return {"messagebottle1"} end 			
			if tipo == 25 then return {"tar_pool"} end  			
				
			end

			end,	
		},

})


Layouts["coralpool3"] = StaticLayout.Get("map/static_layouts/coralpool3", 
{
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
	areas =
		{
			coralzone = function() 
			local variador = math.random()
			if variador > 0.4 then return {"coralreef"} else
			local tipo = math.random(1,25)
			if tipo == 1 then return {"mussel_farm"} end
			if tipo == 2 then return {"mussel_farm"} end
			if tipo == 3 then return {"mussel_farm"} end
			if tipo == 4 then return {"mussel_farm"} end
			if tipo == 5 then return {"mussel_farm"} end			
			if tipo == 6 then return {"seaweed_planted"} end
			if tipo == 7 then return {"seaweed_planted"} end
			if tipo == 8 then return {"seaweed_planted"} end
			if tipo == 9 then return {"seaweed_planted"} end
			if tipo == 10 then return {"seaweed_planted"} end
			if tipo == 11 then return {"spidercoralhole"} end			
			if tipo == 12 then return {"spidercoralhole"} end
			if tipo == 13 then return {"ballphinhouse"} end
			if tipo == 14 then return {"ballphinhouse"} end			
			if tipo == 15 then return {"ballphinhouse"} end
			if tipo == 16 then return {"fishinhole"} end
			if tipo == 17 then return {"fishinhole"} end
			if tipo == 18 then return {"fishinhole"} end
			if tipo == 19 then return {"fishinhole"} end			
			if tipo == 20 then return {"ballphinhouse"} end
			if tipo == 21 then return {"lobsterhole"} end
			if tipo == 22 then return {"lobsterhole"} end
			if tipo == 23 then return {"lobsterhole"} end			
			if tipo == 24 then return {"messagebottle1"} end 			
			if tipo == 25 then return {"tar_pool"} end  			
				
			end

			end,	
		},
})


Layouts["oceanbamboforest"] = StaticLayout.Get("map/static_layouts/oceanbamboforest", 
{
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
disable_transform = true,
	areas =
		{
			objetoaleatorio = function() 
			local variador = math.random()
			if variador > 0.3 then return {"oceanbambootree"} else
			local tipo = math.random(1,20)
			if tipo == 1 then return {"frogsplash"} end 			
			if tipo == 2 then return {"frogsplash"} end  
			if tipo == 3 then return {"tree_mangrovebee"} end
			if tipo == 4 then return {"oceanbambootreebig"} end
			if tipo == 5 then return {"spidercoralhole"} end
			if tipo == 6 then return {"grasswater"} end
			if tipo == 7 then return {"fishinhole"} end
			if tipo == 8 then return {"waterygrave"} end
			if tipo == 9 then return {"oceansapling"} end
			if tipo == 10 then return {"oceanbush_vine"} end
			if tipo == 11 then return {"oceanbambootreebig"} end
			if tipo == 12 then return {"oceanbambootreebig"} end
			if tipo == 13 then return {"mussel_farm"} end  
			if tipo == 14 then return {"seaweed_planted"} end  
			if tipo == 15 then return {"oceanbush_vine"} end  
			if tipo == 16 then return {"tree_mangrovebee"} end  
			if tipo == 17 then return {"driftwood_log"} end  
			if tipo == 18 then return {"oceansapling"} end  
			if tipo == 19 then return {"oceanbush_vine"} end  
			if tipo == 20 then return {"oceanbush_vine"} end		
			end

			end,	
		},
})	
	
Layouts["lilypadnovo"] = StaticLayout.Get("map/static_layouts/lilypadnovo", {
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE,
	areas =
		{
			objetoaleatorio = function() 
			local variador = math.random()
			if variador > 0.4 then return {"lotus"} else
			local tipo = math.random(1,11)
			if tipo == 1 then return {"reeds_water"} end 			
			if tipo == 2 then return {"reeds_water"} end  
			if tipo == 3 then return {"reeds_water"} end
			if tipo == 4 then return {"reeds_water"} end
			if tipo == 5 then return {"reeds_water"} end
			if tipo == 6 then return {"reeds_water"} end
			if tipo == 7 then return {"reeds_water"} end
			if tipo == 8 then return {"watercress_planted"} end
			if tipo == 9 then return {"watercress_planted"} end
			if tipo == 10 then return {"watercress_planted"} end
			if tipo == 11 then return {"driftwood_log"} end			
			
			end

			end,	
		},
})

Layouts["lilypadnovograss"] = StaticLayout.Get("map/static_layouts/lilypadnovograss", {
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE,
	areas =
		{
			objetoaleatorio = function() 
			local variador = math.random()
			if variador > 0.4 then return {"lotus"} else
			local tipo = math.random(1,11)
			if tipo == 1 then return {"grass_tallwater"} end 			
			if tipo == 2 then return {"grass_tallwater"} end  
			if tipo == 3 then return {"grass_tallwater"} end
			if tipo == 4 then return {"grass_tallwater"} end
			if tipo == 5 then return {"grass_tallwater"} end
			if tipo == 6 then return {"grass_tallwater"} end
			if tipo == 7 then return {"grass_tallwater"} end
			if tipo == 8 then return {"watercress_planted"} end
			if tipo == 9 then return {"watercress_planted"} end
			if tipo == 10 then return {"watercress_planted"} end
			if tipo == 11 then return {"driftwood_log"} end			
			
			end

			end,	
		},
})

	
Layouts["mangrove1"] = StaticLayout.Get("map/static_layouts/mangrove1", {
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
areas =
		{
			treearea = function() 
				local stuff = {}

				table.insert(stuff,"tree_mangrove")
				for i=1,6 do
					if math.random() < 0.1 then
						table.insert(stuff,"tree_mangrove")
					end
				end

				table.insert(stuff,"tree_mangrove")
				table.insert(stuff,"oceanvine_deco")


				if math.random()<0.2 then
					table.insert(stuff,"tree_mangrove")
				end

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"watertree_root")
					end
				end	

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"oceanvine_deco")
					end
				end				

				for i=1,4 do
					if math.random()<0.3 then
						table.insert(stuff,"fishinhole")
					end
				end
                
                for i=1,2 do
	                if math.random()<0.3 then
	                    table.insert(stuff,"tree_mangrovebee")
	                end
            	end


                for i=1,10 do
                    if math.random()<0.4 then
                        table.insert(stuff, "fireflies")
                    end
                end

				return stuff
			end,
			
			notreearea = function() 
			local variador = math.random()
			if variador > 0.4 then return {"grasswater"} else
			local tipo = math.random(1,8)
			if tipo == 1 then return {"oceansapling"}	
			elseif tipo == 2 then return {"seacucumber_planted"}
			elseif tipo == 3 then return {"seataro_planted"}
			elseif tipo == 4 then return {"mussel_farm"}
			elseif tipo == 5 then return {"seaweed_planted"}
			elseif tipo == 6 then return {"driftwood_log"}
			elseif tipo == 7 then return {"watercress_planted"}
			elseif tipo == 8 then return {"reeds_water"} 
			else
			return {"grasswater"}
			end
			end
			
			
			end,
		},

	
})


Layouts["mangrove2"] = StaticLayout.Get("map/static_layouts/mangrove1", {
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
areas =
		{
			treearea = function() 
				local stuff = {}

				table.insert(stuff,"tree_mangrove")
				for i=1,6 do
					if math.random() < 0.1 then
						table.insert(stuff,"tree_mangrove")
					end
				end

				table.insert(stuff,"tree_mangrove")
				table.insert(stuff,"oceanvine_deco")


				if math.random()<0.2 then
					table.insert(stuff,"tree_mangrove")
				end

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"watertree_root")
					end
				end	

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"oceanvine_deco")
					end
				end				

				for i=1,4 do
					if math.random()<0.3 then
						table.insert(stuff,"fishinhole")
					end
				end
                
                for i=1,2 do
	                if math.random()<0.3 then
	                    table.insert(stuff,"tree_mangrovebee")
	                end
            	end


                for i=1,10 do
                    if math.random()<0.4 then
                        table.insert(stuff, "fireflies")
                    end
                end

				return stuff
			end,
			
			notreearea = function() 
			local variador = math.random()
			if variador > 0.6 then return {"oceanbambootree"} else
			local tipo = math.random(1,10)
			if tipo == 1 then return {"oceansapling"}	
			elseif tipo == 2 then return {"seacucumber_planted"}
			elseif tipo == 3 then return {"seataro_planted"}
			elseif tipo == 4 then return {"mussel_farm"}
			elseif tipo == 5 then return {"oceanbush_vine"}
			elseif tipo == 6 then return {"driftwood_log"}
			elseif tipo == 7 then return {"oceanbush_vine"}
			elseif tipo == 8 then return {"oceanbush_vine"} 
			elseif tipo == 9 then return {"oceanbambootreebig"} 			
			elseif tipo == 10 then return {"oceanbambootreebig"} 			
			else
			return {"oceanbambootree"}
			end
			end
			
			
			end,
		},

	
})
	

Layouts["oceanforest"] = StaticLayout.Get("map/static_layouts/oceanforest", 
{
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
disable_transform = true,
	areas =
		{
			objetoaleatorio = function() 
			local variador = math.random()
			if variador > 0.3 then return {"tree_mangrove"} else
			local tipo = math.random(1,20)
			if tipo == 1 then return {"frogsplash"}		
			elseif tipo == 2 then return {"oceansapling"}
			elseif tipo == 3 then return {"tree_mangrovebee"}
			elseif tipo == 4 then return {"tentacleunderwater"}
			elseif tipo == 5 then return {"spidercoralhole"}
			elseif tipo == 6 then return {"grasswater"}
			elseif tipo == 7 then return {"fishinhole"}
			elseif tipo == 8 then return {"waterygrave"}
			elseif tipo == 9 then return {"redbarrel"}
			elseif tipo == 10 then return {"mermboat"}
			elseif tipo == 11 then return {"seacucumber_planted"}
			elseif tipo == 12 then return {"seataro_planted"}
			elseif tipo == 13 then return {"mussel_farm"}
			elseif tipo == 14 then return {"seaweed_planted"}
			elseif tipo == 15 then return {"oxbaby"}
			elseif tipo == 16 then return {"ox"}
			elseif tipo == 17 then return {"driftwood_log"}
			elseif tipo == 18 then return {"watercress_planted"}
			elseif tipo == 19 then return {"reeds_water"}
			elseif tipo == 20 then return {"luggagechest_spawner"}
			else
			return {"tree_mangrove"} 
			end
			end

			end,	
		},
})	

Layouts["oceanrocks"] = StaticLayout.Get("map/static_layouts/oceanrocks", 
{
layout_position = GLOBAL.LAYOUT_POSITION.CENTER, 
start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
disable_transform = true,
	areas =
		{
			rochaaleatoria = function() 
			local variador = math.random()
			if variador > 0.8 then return {"grasswater"} else
			local tipo = math.random(1,10)
			if tipo == 1 then return {"tree_mangrovebee"} end 			
			if tipo == 2 then return {"frogsplash"} end  
			if tipo == 3 then return {"frogsplash"} end
			if tipo == 4 then return {"frogsplash"} end
			if tipo == 5 then return {"frogsplash"} end
			if tipo == 6 then return {"oceansapling"} end
			if tipo == 7 then return {"reeds_water"} end	
			if tipo == 8 then return {"reeds_water"} end	
			if tipo == 9 then return {"seaweed_planted"} end	
			if tipo == 10 then return {"mussel_farm"} end				
			end

			end,	
		},
})	
		
Layouts["icebergs"] = StaticLayout.Get("map/static_layouts/icebergs", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})	

Layouts["oceangrotolunar"] = StaticLayout.Get("map/static_layouts/oceangrotolunar", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})			
-----------------------------------------------------------------------------------------------			
			
			
Layouts["wildboreking"] = StaticLayout.Get("map/static_layouts/wildboreking", {layout_position = GLOBAL.LAYOUT_POSITION.CENTER, start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
			fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,})
			
Layouts["quagmire_kitchen"] = StaticLayout.Get("map/static_layouts/quagmire_kitchen", 
{

        start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = GLOBAL.LAYOUT_POSITION.CENTER,
		disable_transform = true,

		areas =
		{
			quagmire_parkspike_row = function(area, data) 
				local vert = data.height > data.width
--				local x = vert and (data.x) or (data.x - data.width/2.0)
--				local y = vert and (data.y - data.height/2.0) or (data.y)
				local x = data.x - data.width/2.0
				local y = data.y - data.height/2.0
				local spacing = 0.18
				local num = math.ceil((vert and data.height or data.width) / spacing)

				local prefabs = {}
				for i = 1, num do
					table.insert(prefabs, 
					{
						prefab = i % 2 == (vert and 0 or 1) and "quagmire_parkspike_short" or "quagmire_parkspike",
						x = x,
						y = y,
					})
					if vert then
						y = y + spacing
					else
						x = x + spacing
					end
				end
				return prefabs
			end,
		},
    })
	
Layouts["wreck"] = StaticLayout.Get("map/static_layouts/wreck", 
{

        start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = GLOBAL.LAYOUT_POSITION.CENTER,
		disable_transform = true,

		areas =
		{
			debris_area = function() 
				local stuff = {}

				table.insert(stuff,"wreck")
				for i=1,6 do
					if math.random() < 0.1 then
						table.insert(stuff,"wreck")
					end
				end

				table.insert(stuff,"luggagechest_spawner")
				table.insert(stuff,"waterygrave")


				if math.random()<0.2 then
					table.insert(stuff,"luggagechest_spawner")
				end

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"redbarrel")
					end
				end	

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"waterygrave")
					end
				end				

				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment01")
					end
				end
				
				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment02")
					end
				end


				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment03")
					end
				end				
				
						
                
                for i=1,2 do
	                if math.random()<0.3 then
	                    table.insert(stuff,"whale_bluefinal")
	                end
            	end


                for i=1,4 do
                    if math.random()<0.4 then
                        table.insert(stuff, "fishinhole")
                    end
                end

				return stuff
			end,					
			
		},
    })	


Layouts["wreck2"] = StaticLayout.Get("map/static_layouts/wreck2", 
{

        start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = GLOBAL.LAYOUT_POSITION.CENTER,
		disable_transform = true,

		areas =
		{
			debris_area = function() 
				local stuff = {}

				table.insert(stuff,"wreck")
				for i=1,6 do
					if math.random() < 0.1 then
						table.insert(stuff,"wreck")
					end
				end

				table.insert(stuff,"luggagechest_spawner")
				table.insert(stuff,"waterygrave")


				if math.random()<0.2 then
					table.insert(stuff,"luggagechest_spawner")
				end

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"redbarrel")
					end
				end	

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"waterygrave")
					end
				end				

				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment01")
					end
				end
				
				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment02")
					end
				end


				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment03")
					end
				end				
				
						
                
                for i=1,2 do
	                if math.random()<0.3 then
	                    table.insert(stuff,"whale_bluefinal")
	                end
            	end


                for i=1,4 do
                    if math.random()<0.4 then
                        table.insert(stuff, "fishinhole")
                    end
                end

				return stuff
			end,					
			
		},
    })		
	
Layouts["iceberg1"] = StaticLayout.Get("map/static_layouts/iceberg1", 
{

        start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = GLOBAL.LAYOUT_POSITION.CENTER,
		disable_transform = true,

		areas =
		{
			treearea = function() 
				local stuff = {}

				table.insert(stuff,"rock_ice_frost")
				for i=1,6 do
					if math.random() < 0.1 then
						table.insert(stuff,"rock_ice_frost")
					end
				end

				table.insert(stuff,"rock_ice_frost")
				table.insert(stuff,"rock_ice_frost")


				if math.random()<0.2 then
					table.insert(stuff,"rock_ice_frost")
				end

				for i=1,3 do
					if math.random()<0.6 then
						table.insert(stuff,"icedpad")
					end
				end	

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"fishinhole")
					end
				end				
				--[[
				for i=1,4 do
					if math.random()<0.3 then
						table.insert(stuff,"lightrays_canopy")
					end
				end
			]]
                
                for i=1,2 do
	                if math.random()<0.3 then
	                    table.insert(stuff,"whale_bluefinal")
	                end
            	end


               for i=1,4 do
                    if math.random()<0.4 then
                        table.insert(stuff, "rock_ice_frost")
                    end
                end

				return stuff
			end,					
			
		},
    })	
	
Layouts["kraken"] = StaticLayout.Get("map/static_layouts/kraken", 
{

        start_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        fill_mask = GLOBAL.PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
        layout_position = GLOBAL.LAYOUT_POSITION.CENTER,
		disable_transform = true,

		areas =
		{
			debris_area = function() 
				local stuff = {}

				table.insert(stuff,"wreck")
				for i=1,6 do
					if math.random() < 0.1 then
						table.insert(stuff,"wreck")
					end
				end

				table.insert(stuff,"luggagechest_spawner")
				table.insert(stuff,"waterygrave")


				if math.random()<0.2 then
					table.insert(stuff,"luggagechest_spawner")
				end

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"redbarrel")
					end
				end	

				for i=1,3 do
					if math.random()<0.3 then
						table.insert(stuff,"waterygrave")
					end
				end				

				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment01")
					end
				end
				
				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment02")
					end
				end


				for i=1,4 do
					if math.random()<0.1 then
						table.insert(stuff,"boatfragment03")
					end
				end				
				
						
                
                for i=1,2 do
	                if math.random()<0.3 then
	                    table.insert(stuff,"redbarrel")
	                end
            	end


                for i=1,4 do
                    if math.random()<0.1 then
                        table.insert(stuff, "fishinhole")
                    end
                end

				return stuff
			end,					
			
		},
    })		
	
----------------------------------------------------------	
	
	
--[[
Layouts["CrabKing1"] = StaticLayout.Get("map/static_layouts/crabking1", {
		min_dist_from_land = 0,
		areas =
		{
			stack_area = function() return math.random() < 0.9 and {"seastack"} or nil end,
		}
    })
	]]
--[[
Layouts["HermitcrabIsland"] = StaticLayout.Get("map/static_layouts/hermitcrab_01",
	{
		add_topology = {room_id = "StaticLayoutIsland:HermitcrabIsland", tags = {"RoadPoison", "nohunt", "nohasslers", "not_mainland"}},
		min_dist_from_land = 0,
	})
]]	
	
----------------------------------------------------

local layoutsToRemake = { "volcano_entrance" }
local layoutsToRemakeGrounds = 
{ 
	volcano_entrance = {GROUND.BEACH, GROUND.VOLCANO}
}
local layoutsToRemakeTiles = 
{
	volcano_entrance =
	{

	
		{2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2},	
	
	
	
	}
}

--for _, layoutName in pairs(layoutsToRemake) do
--	if layoutsToRemakeTiles[layoutName] and layoutsToRemakeGrounds[layoutName] then
--		Layouts[layoutName].ground_types = layoutsToRemakeGrounds[layoutName]
--		Layouts[layoutName].ground = layoutsToRemakeTiles[layoutName]
--	else
--		print("Table are not declared for ", layoutName, " layout!")
--	end
--end			



local layoutsToRemake = { "tigersharkarea" , "skull_isle2", "doydoym" , "doydoyf", "cidade1", "cidade2", "city", "vacation", "lava_arena", "lilypad", "lobby", "atlantida", 
"pig_ruins_entrance_1", "pig_ruins_entrance_2", "pig_ruins_entrance_3", "pig_ruins_entrance_4", "pig_ruins_entrance_5", "pig_ruins_exit_1", "pig_ruins_exit_2", "pig_ruins_exit_4", 
"pig_ruins_head", "pig_ruins_nocanopy", "pig_ruins_nocanopy_2", "pig_ruins_nocanopy_3", "pig_ruins_nocanopy_4", "cave_entranceham1", "cave_entranceham2", "cave_entranceham3",
"farm_1", "farm_2", "farm_3", "farm_4", "farm_5", "nettlegrove", "pantano", "pugalisk_fountain", "quagmire_kitchen"}
local layoutsToRemakeGrounds = 
{ 
	tigersharkarea = {GROUND.BEACH, GROUND.OCEAN_COASTAL},
	skull_isle2 = {GROUND.MAGMAFIELD, GROUND.BEACH},
	x_spot = {GROUND.MAGMAFIELD, GROUND.BEACH},
	doydoym = {GROUND.BEACH},
	doydoyf = {GROUND.BEACH},
	cidade1 = {GROUND.COBBLEROAD, GROUND.FOUNDATION, GROUND.CHECKEREDLAWN},
	cidade2 = {GROUND.COBBLEROAD, GROUND.FOUNDATION, GROUND.CHECKEREDLAWN},
	city = {GROUND.WATER_MANGROVE, GROUND.WATER_MANGROVE},
	vacation = {GROUND.BEACH},
	lava_arena = {GROUND.IMPASSABLE, GROUND.PIGRUINS, GROUND.BATFLOOR},
	lilypad = {GROUND.OCEAN_COASTAL, GROUND.OCEAN_COASTAL,GROUND.OCEAN_COASTAL},
	IceSpiderpillar = {GROUND.WATER_MANGROVE, GROUND.WATER_MANGROVE},
	lobby = {GROUND.IMPASSABLE, GROUND.CHECKEREDLAWN, GROUND.COBBLEROAD, GROUND.BEACH, GROUND.FOREST, GROUND.GRASS, GROUND.FOUNDATION},
	atlantida = {GROUND.IMPASSABLE, GROUND.BATTLEGROUND, GROUND.UNDERWATER_ROCKY},
	pig_ruins_entrance_1 = {GROUND.DEEPRAINFOREST, GROUND.BATTLEGROUND},
	pig_ruins_entrance_2 = {GROUND.DEEPRAINFOREST, GROUND.BATTLEGROUND},
	pig_ruins_entrance_3 = {GROUND.BATTLEGROUND, GROUND.DEEPRAINFOREST},	
	pig_ruins_entrance_4 = {GROUND.BATTLEGROUND, GROUND.DEEPRAINFOREST},
	pig_ruins_entrance_5 = {GROUND.DEEPRAINFOREST, GROUND.BATTLEGROUND},
	pig_ruins_exit_1	 = {GROUND.DEEPRAINFOREST, GROUND.BATTLEGROUND},
	pig_ruins_exit_2	 = {GROUND.DEEPRAINFOREST, GROUND.BATTLEGROUND},
	pig_ruins_exit_4	 = {GROUND.DEEPRAINFOREST, GROUND.BATTLEGROUND},
	pugalisk_fountain 	 = {GROUND.BATTLEGROUND},
	pig_ruins_head 	 	 = {GROUND.BATTLEGROUND},	
	pig_ruins_nocanopy 	 = {GROUND.BATTLEGROUND},
	pig_ruins_nocanopy_2 = {GROUND.BATTLEGROUND},
	pig_ruins_nocanopy_3 = {GROUND.BATTLEGROUND},
	pig_ruins_nocanopy_4 = {GROUND.BATTLEGROUND},	
	cave_entranceham1 	 = {GROUND.BATTLEGROUND},
	cave_entranceham2 	 = {GROUND.BATTLEGROUND},
	cave_entranceham3 	 = {GROUND.BATTLEGROUND},
	farm_1	 			 = {GROUND.FIELDS, GROUND.SUBURB},
	farm_2	 			 = {GROUND.FIELDS, GROUND.SUBURB},
	farm_3	 			 = {GROUND.FIELDS, GROUND.SUBURB},
	farm_4	 			 = {GROUND.FIELDS, GROUND.SUBURB},
	farm_5	 			 = {GROUND.FIELDS, GROUND.SUBURB},
	nettlegrove		 	 = {GROUND.DEEPRAINFOREST, GROUND.DEEPRAINFOREST},
	pantano 			 = {GROUND.MARSH},
	quagmire_kitchen 	 = {GROUND.QUAGMIRE_PEATFOREST, GROUND.ROAD, GROUND.QUAGMIRE_GATEWAY, GROUND.QUAGMIRE_PARKFIELD, GROUND.QUAGMIRE_PARKSTONE, GROUND.FARMING_SOIL, GROUND.QUAGMIRE_CITYSTONE},
}
local layoutsToRemakeTiles = 
{

	    atlantida =	
	{
	
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1},
        {1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	
	},


	lobby =
	{

	     {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 6, 6, 6, 6, 6, 6, 3, 4, 4, 4, 4, 4, 4, 1, 1, 1},
         {1, 1, 1, 6, 6, 6, 6, 6, 6, 3, 4, 4, 4, 4, 4, 4, 1, 1, 1},
         {1, 1, 1, 6, 6, 6, 6, 6, 6, 3, 4, 4, 4, 4, 4, 4, 1, 1, 1},
         {1, 1, 1, 6, 6, 6, 6, 6, 6, 3, 4, 4, 4, 4, 4, 4, 1, 1, 1},
         {1, 1, 1, 6, 6, 6, 6, 6, 6, 3, 4, 4, 4, 4, 4, 4, 1, 1, 1},
         {1, 1, 1, 6, 6, 6, 6, 6, 3, 3, 3, 4, 4, 4, 4, 4, 1, 1, 1},
         {1, 1, 1, 3, 3, 3, 3, 3, 3, 7, 3, 3, 3, 3, 3, 3, 1, 1, 1},
         {1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 5, 5, 5, 5, 5, 1, 1, 1},
         {1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 5, 5, 5, 5, 5, 5, 1, 1, 1},
         {1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 5, 5, 5, 5, 5, 5, 1, 1, 1},
         {1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 5, 5, 5, 5, 5, 5, 1, 1, 1},
         {1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 5, 5, 5, 5, 5, 5, 1, 1, 1},
         {1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 5, 5, 5, 5, 5, 5, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         
	
	},

	IceSpiderpillar =
	{

	     {0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0},
         {0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
         {0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
         {2, 2, 2, 2, 1, 1, 2, 2, 1, 2, 2, 2},
         {2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2},
         {2, 2, 2, 2, 1, 1, 2, 1, 2, 2, 2, 2},
         {2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2},
         {2, 2, 2, 1, 1, 2, 1, 1, 2, 2, 2, 2},
         {2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2},
         {2, 2, 2, 2, 1, 2, 2, 1, 1, 2, 2, 2},
         {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0},
         {0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0},
         
	
	},

	tigersharkarea =
	{

	     {0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0},
         {0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0},
         {0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 0},
         {2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2},
         {2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2},
         {2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2},
         {2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2},
         {0, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2},
         {0, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 0},
         {0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0},
         {0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0},	
	
	},
	
	lilypad =
	{
	
	     {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
         {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
         {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
         {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
         {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
         {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
         {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},	

	},

	
		skull_isle2 =
	{

	     {0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 0, 0, 0, 0},
         {0, 0, 2, 2, 2, 1, 1, 1, 1, 2, 1, 2, 2, 2, 0, 0, 0, 0, 0},
         {2, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 0, 0, 0, 0},
         {0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 0, 2, 0},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 0},
         {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 0, 0},
         {0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 0, 0},
         {0, 2, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0},
         {0, 0, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 0, 0},
         {0, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 0, 0, 0},
         {0, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 0, 0, 0},
         {0, 0, 0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 0, 0, 0, 0},
         {0, 0, 0, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 0, 0, 0, 0},
         {0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0},
         {0, 0, 0, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 0, 0, 0, 0},
         {0, 0, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 0, 0, 0, 0, 0},
         {0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 2, 2, 2, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0},	
	
	},
		doydoym =
	{

	
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 1, 0, 0, 0},
        {0, 1, 0, 1, 1, 1, 1, 1, 0, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1},
        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {0, 0, 0, 0, 1, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	
	
	
	},
	doydoyf =
	{

	
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 1, 0, 0, 0},
        {0, 1, 0, 1, 1, 1, 1, 1, 0, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1},
        {0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {0, 0, 0, 0, 1, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	
	
	
	},
	    x_spot =
	{

	
		{0, 0, 2, 2, 2, 0, 0},
		{0, 2, 2, 1, 2, 2, 0},
		{2, 2, 2, 1, 2, 2, 2},
		{2, 1, 1, 1, 1, 1, 2},
		{2, 2, 2, 1, 2, 2, 2},	
		{0, 2, 2, 1, 2, 2, 0},	
		{0, 0, 2, 2, 2, 0, 0},
	
	},

	    vacation =
	{	
		{1, 1, 1, 1},
		{1, 1, 1, 1},
		{1, 1, 1, 1},
		{1, 1, 1, 1},		
	},
	
	
	cidade1 =
{
       { 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0},
       { 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0},
       { 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 0, 0, 0},
       { 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 0, 0, 0},
       { 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 0, 0, 0},
       { 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 0, 0, 0},
       { 0, 0, 0, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 0, 0},
       { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 0, 0},
       { 0, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 0, 0},
       { 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 0, 0},
       { 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 0, 0, 0},
       { 0, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 0, 0, 0},
       { 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 0, 0, 0},
       { 0, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 0, 0},
       { 0, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 0, 0},
       { 0, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 0, 0},
       { 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 0, 0},
       { 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 0},
       { 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 0},
       { 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2},
       { 0, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 2, 2, 0, 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3, 2, 2, 0, 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1},
       { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2},
       { 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
       { 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
       { 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
       { 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0},
       { 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0},
       { 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0},
       { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0},
       { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0},
       { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
      
      },	
	  
	  
	cidade2 =
	{

	  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 2, 0, 0},
      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 3, 3, 2, 2, 2, 2, 2, 2, 2, 0, 0},
      {0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0},
      {0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2},
      {0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2},
      {0, 0, 0, 0, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2},
      {0, 0, 0, 0, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
      {0, 0, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
      {0, 0, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 2, 2, 1, 2},
      {0, 0, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 2, 2, 1, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 2, 2, 1, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2},
      {2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 1, 0},
      {2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 1, 0},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 1, 0},
      {2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 1, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 1, 2},
      {2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2},
      {2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2},
      {0, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 0},
      {0, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 0},
      {0, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 2, 1, 0},
      {0, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
      {0, 2, 1, 2, 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
      {2, 2, 1, 2, 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0},
      {2, 2, 1, 2, 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0},
      {2, 2, 1, 2, 2, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0},
      {2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0},
      {0, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0},
      {0, 0, 1, 2, 0, 0, 0, 0, 0, 2, 2, 2, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0},
      {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0},
	
	},	  
	
	
		city =
	{

		{2, 2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2, 2},
		{2, 2, 2, 2, 2, 2},	
		{2, 2, 2, 2, 2, 2},
	
	},	
	
	    lava_arena =	
	{
	
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},  
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},   
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},    
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},    
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},     
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},   
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 3, 2, 2, 3, 3, 2, 2, 3, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},      
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 3, 3, 2, 3, 2, 2, 3, 2, 3, 3, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},   
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 2, 3, 3, 2, 3, 3, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},     
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 2, 3, 3, 2, 3, 3, 3, 3, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},    
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 2, 3, 2, 2, 3, 2, 3, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 3, 3, 2, 2, 3, 3, 2, 2, 3, 3, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},  
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},    
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},  
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},     
        {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},  
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	
	},
	
	    pig_ruins_entrance_1 =	
	{
        {1, 1, 1, 1, 1, 1, 0},
        {1, 2, 2, 2, 2, 2, 1},
        {1, 2, 2, 2, 2, 2, 1},
        {1, 1, 2, 2, 1, 1, 1},
        {1, 2, 2, 1, 2, 2, 1},
        {1, 2, 2, 1, 2, 2, 1},
        {0, 1, 1, 1, 1, 1, 1},
     },
	    pig_ruins_entrance_2 =	
	{
        {1, 1, 1, 1, 1, 1, 0},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 1, 2, 1, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 2, 2, 2, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 0},
     },
	    pig_ruins_entrance_3 =	
	{
        {2, 2, 2, 2, 2, 2, 0},
        {2, 1, 1, 1, 1, 2, 2},
        {2, 2, 1, 1, 1, 2, 2},
        {2, 1, 1, 2, 1, 2, 2},
        {2, 1, 1, 1, 1, 2, 2},
        {2, 2, 1, 1, 2, 2, 2},
        {2, 2, 2, 2, 2, 2, 0},
     },
	    pig_ruins_entrance_4 =	
	{
        {2, 2, 2, 2, 2, 2, 0},
        {2, 2, 1, 1, 1, 1, 2},
        {2, 1, 1, 1, 1, 1, 2},
        {2, 2, 1, 1, 2, 2, 2},
        {2, 1, 1, 2, 1, 2, 2},
        {2, 2, 1, 2, 1, 2, 2},
        {0, 2, 2, 2, 2, 2, 2},
     },
	    pig_ruins_entrance_5 =	
	{
        {1, 1, 1, 1, 1, 1, 0},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 1, 2, 1, 1, 1},
        {1, 2, 1, 1, 1, 1, 1},
        {1, 1, 2, 1, 2, 1, 1},
        {0, 1, 1, 1, 1, 1, 1},
     },	 
	 
	    pig_ruins_exit_1 =	
	{
        {1, 1, 1, 1, 1, 1, 0},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 1, 2, 1, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 2, 2, 2, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 0},
     },	 	 

	    pig_ruins_exit_2 =	
	{
        {0, 1, 1, 1, 1, 1, 0},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 1, 1},
        {1, 1, 1, 2, 2, 1, 1},
        {1, 1, 2, 2, 2, 1, 1},
        {0, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 0, 0},
     },	 

	    pig_ruins_exit_4 =	
	{
        {0, 1, 1, 1, 1, 1, 0},
        {1, 1, 2, 2, 1, 1, 1},
        {1, 1, 2, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 1, 1},
        {1, 1, 1, 2, 2, 1, 1},
        {0, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 0, 0},
     },	 

	    pugalisk_fountain =	
	{
        {0, 0, 1, 1, 0, 0, 1},
        {0, 1, 1, 1, 1, 1, 0},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {0, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 0},
        {0, 0, 1, 1, 1, 0, 0},
     },	 	 
	 
	    pig_ruins_head =	
	{
        {1, 1},
        {1, 1},
     },	 	 

	    pig_ruins_nocanopy =	
	{
        {1, 1},
        {1, 1},
     },	

	    pig_ruins_nocanopy_2 =	
	{
        {1, 1},
        {1, 1},
     },
	    pig_ruins_nocanopy_3 =	
	{
        {0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0},
        {0, 1, 1, 1, 1, 0},
        {0, 1, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0},
     },
	    pig_ruins_nocanopy_4 =	
	{
        {1, 1, 1},
        {1, 1, 1},
        {1, 1, 0},
     },	 
	 
	    cave_entranceham1 =	
	{
        {0, 1, 1, 0},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {0, 1, 1, 0},
     },	
	 
	    cave_entranceham2 =	
	{
        {0, 1, 1, 0},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {0, 1, 1, 0},
     },	
	 
	    cave_entranceham3 =	
	{
        {0, 1, 1, 0},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {0, 1, 1, 0},
     },		 
	 
	    farm_1 =	
	{
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 5, 5, 1, 1, 1, 1},
        {1, 1, 1, 5, 5, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1},
     },	
	    farm_2 =	
	{
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 5, 5, 5, 5, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 5, 5, 5, 5, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
     },	
	    farm_3 =	
	{
        {1, 1, 1, 1, 1, 1, 1, 1, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 0},
        {1, 1, 4, 4, 4, 4, 1, 1, 0},
        {1, 4, 4, 4, 4, 4, 4, 1, 0},
        {1, 1, 4, 4, 4, 4, 1, 1, 0},
        {1, 1, 1, 4, 4, 1, 1, 1, 0},
        {1, 1, 1, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
     },	
	    farm_4 =	
	{
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
     },	
	    farm_5 =	
	{
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 2, 2, 2, 2, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
     },	
	 
	    nettlegrove =	
	{
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
     },		 

	pantano =
	{
	
	     {0, 1, 0},
	     {0, 1, 0},
	     {0, 0, 0},
	},	 


	
	    quagmire_kitchen =	
	{
	
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 5, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 1, 3, 1, 0, 0, 0, 0, 0, 4, 4, 4, 4, 5, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 1, 3, 3, 2, 2, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 4, 4, 5, 4, 4, 5, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 1, 3, 3, 1, 3, 3, 3, 3, 2, 3, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 3, 1, 3, 3, 3, 3, 2, 2, 2, 2, 3, 3, 3, 7, 7, 5, 5, 5, 5, 5, 4, 4, 5, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 2, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3, 1, 1, 3, 6, 3, 3, 3, 3, 2, 3, 3, 2, 3, 3, 0, 0, 0, 0, 0, 4, 4, 5, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 1, 3, 3, 3, 6, 3, 3, 3, 2, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 6, 3, 3, 3, 3, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 6, 6, 3, 3, 6, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 3, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 3, 7, 0, 0, 0, 7, 7, 0, 7, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 1, 3, 3, 3, 3, 3, 3, 3, 2, 7, 7, 0, 7, 7, 7, 7, 2, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 3, 3, 3, 3, 3, 3, 0, 7, 7, 2, 7, 7, 2, 7, 7, 7, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 0, 0, 7, 7, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 0, 0, 0, 7, 7, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 3, 3, 3, 3, 0, 3, 3, 3, 0, 0, 0, 7, 7, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 3, 3, 0, 0, 3, 0, 0, 0, 0, 0, 7, 2, 7, 7, 7, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 2, 7, 0, 7, 7, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 2, 2, 7, 7, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 7, 7, 7, 2, 2, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 7, 7, 2, 2, 2, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 7, 1, 7, 7, 1, 1, 1, 0, 0, 0, 7, 7, 2, 2, 2, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 7, 7, 7, 7, 7, 7, 1, 6, 1, 0, 0, 0, 7, 7, 2, 2, 2, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 7, 7, 7, 7, 7, 7, 7, 7, 1, 1, 1, 0, 0, 0, 7, 7, 2, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 7, 7, 7, 7, 7, 7, 7, 7, 7, 1, 1, 1, 0, 0, 7, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 7, 7, 7, 7, 7, 7, 7, 7, 1, 1, 1, 0, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 7, 7, 7, 7, 7, 7, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 7, 7, 7, 7, 7, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 7, 7, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 7, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	
	},	
	 
}

for _, layoutName in pairs(layoutsToRemake) do
	if layoutsToRemakeTiles[layoutName] and layoutsToRemakeGrounds[layoutName] then
		Layouts[layoutName].ground_types = layoutsToRemakeGrounds[layoutName]
		Layouts[layoutName].ground = layoutsToRemakeTiles[layoutName]
	else
		print("Table are not declared for ", layoutName, " layout!")
	end
end				
			

