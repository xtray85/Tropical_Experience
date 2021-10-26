local TRADER = {
	pigman_collector = 		{ items= {"stinger","silk","mosquitosack","chitin","venus_stalk","venomgland","spidergland","lotus_flower","trinket_1","trinket_2","trinket_3","trinket_4","trinket_5","trinket_6,trinket_7","trinket_8","trinket_9","trinket_10","trinket_11","trinket_12","trinket_13","trinket_14","trinket_15","trinket_16","trinket_17","trinket_18","trinket_19","trinket_20","trinket_21","trinket_22","trinket_23","trinket_24","trinket_25","trinket_26","trinket_27","trinket_28","trinket_29","trinket_30","trinket_31","trinket_32","trinket_33","trinket_34","trinket_35","trinket_36","trinket_37","trinket_38","trinket_39","trinket_40","trinket_41","trinket_42","trinket_43","trinket_44","trinket_45","trinket_46"},					
								delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_COLLECTOR_TRADE,  reward = "oinc",   rewardqty=3},
	pigman_banker = 		{ items= {"redgem","bluegem","purplegem", "greengem", "orangegem", "yellowgem"},
								delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_BANKER_TRADE, 	 reward = "oinc10", rewardqty=1},
	pigman_beautician = 	{ items= {"feather_crow","feather_robin","feather_robin_winter","peagawkfeather","doydoyfeather","feather_thunder", "feather_canary"},					
								delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_BEAUTICIAN_TRADE, reward = "oinc",   rewardqty=2},
	pig_eskimo = 			{ items= {"fish2_alive", "fish3_alive", "fish4_alive", "fish5_alive", "fish6_alive", "fish7_alive","coi_alive","salmon_alive","ballphinocean_alive","swordfishjocean_alive","swordfishjocean2_alive","dogfishocean_alive","whaleblueocean_alive","sharxocean_alive",
"oceanfish_small_1_inv", "oceanfish_small_2_inv", "oceanfish_small_3_inv", "oceanfish_small_4_inv", "oceanfish_small_5_inv", "oceanfish_small_6_inv", "oceanfish_small_7_inv", "oceanfish_small_8_inv", "oceanfish_small_9_inv",
"oceanfish_medium_1_inv", "oceanfish_medium_2_inv", "oceanfish_medium_3_inv", "oceanfish_medium_4_inv", "oceanfish_medium_5_inv", "oceanfish_medium_6_inv","oceanfish_medium_7_inv","oceanfish_medium_8_inv"},					
								delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_ESKIMO_TRADE, reward = "oinc",   rewardqty=2},
	pigman_mechanic = 		{ items= {"boards","rope","cutstone","papyrus"},
								delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_MECHANIC_TRADE, 	 reward = "oinc",   rewardqty=2},
	pigman_professor =		{ items= {"relic_1", "relic_2", "relic_3"}, 
								delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_PROFESSOR_TRADE,  reward = "oinc10", rewardqty=1},								
	pigman_hunter = 		{ items= {"houndstooth","stinger"},	   delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_HUNTER_TRADE, 	reward = "oinc",   rewardqty=5},
	pigman_mayor = 			{ items= {"goldnugget"},	   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_MAYOR_TRADE, 	    reward = "oinc",   rewardqty=1},
	pigman_florist = 		{ items= {"petals","petals_evil","succulent_picked","foliage"},  delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_FLORIST_TRADE,    reward = "oinc",   rewardqty=1},
	pigman_storeowner = 	{ items= {"clippings"},		   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_STOREOWNER_TRADE, reward = "oinc",   rewardqty=1},
	pigman_farmer = 		{ items= {"cutgrass","twigs"}, delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_FARMER_TRADE, 	reward = "oinc",   rewardqty=1},
	pigman_miner = 			{ items= {"rocks"},			   delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_MINER_TRADE, 	    reward = "oinc",   rewardqty=1},
	pigman_erudite = 		{ items= {"nightmarefuel"},	   delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_ERUDITE_TRADE,    reward = "oinc",   rewardqty=5},
	pigman_hatmaker =		{ items= {"silk"},			   delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_HATMAKER_TRADE,	reward = "oinc",   rewardqty=5},
	pigman_queen = 			{ items= {"pigcrownhat","pig_scepter","relic_4","relic_5"},
	         				   delay=0, reset=0, current=0, desc=STRINGS.CITY_PIG_QUEEN_TRADE,		reward = "key_to_city",   rewardqty=1},
	pigman_usher =		    { items= {"honey","jammypreserves","icecream","pumpkincookie","waffles","berries","berries_cooked", "berries_juicy", "berries_juicy _cooked"},                 
								delay=0, reset=1, current=0, desc=STRINGS.CITY_PIG_USHER_TRADE,  reward = "oinc",   rewardqty=4},

	pigman_royalguard = 	{items={"spear","spear_wathgrithr"},
															num=3, current=0,	desc=STRINGS.CITY_PIG_GUARD_TRADE, 		reward = "oinc"},
	pigman_royalguard_2 = 	{items={"spear","spear_wathgrithr"},				
															num=3, current=0,	desc=STRINGS.CITY_PIG_GUARD_TRADE, 		reward = "oinc"},	
--	pigman_shopkeep = 		{items={},						num=5, current=0,	desc=STRINGS.CITY_PIG_SHOPKEEP_TRADE, 	reward = "oinc"},
}

local Economy = Class(function(self, inst)
    self.inst = inst
	self.cities = {} 

	self.inst:WatchWorldState("isday",function() self:processdelays() end)
    for i=1,NUM_TRINKETS do
		table.insert(TRADER.pigman_collector.items, "trinket_" .. i)
	end
end)


function Economy:OnSave()	
	local refs = {}
	local data = {}
	data.cities = self.cities

	for city,data in pairs(self.cities)do
		for item,itemdata in pairs(data) do
			for guid,guiddata in pairs(itemdata.GUIDS) do
				table.insert(refs,guid)
			end
		end
	end

	return data, refs
end 

function Economy:OnLoad(data)
	if data and data.cities then
		self.cities = data.cities
	end
end

function Economy:LoadPostPass(ents, data)

	for city,data in pairs(self.cities)do
		for item,itemdata in pairs(data) do
			local newguids = {}
			for guid,guiddata in pairs(itemdata.GUIDS) do

			 	local child = ents[guid]
			    if child then
			    	newguids[child.entity.GUID] = guiddata
			    end
				
			end
			itemdata.GUIDS = newguids
		end
	end
end

function Economy:GetTradeItems(traderprefab)
	if TRADER[traderprefab] then
		return TRADER[traderprefab].items
	end
end
function Economy:GetTradeItemDesc(traderprefab)		
	if not TRADER[traderprefab] then
		return nil
	end
	return TRADER[traderprefab].desc
end

function Economy:GetDelay(traderprefab,city,inst)
if traderprefab == "pigman_banker" then
return TRADER.pigman_banker.delay
elseif traderprefab == "pigman_beautician" then
return TRADER.pigman_beautician.delay
elseif traderprefab == "pig_eskimo" then
return TRADER.pig_eskimo.delay
elseif traderprefab == "pigman_mechanic" then
return TRADER.pigman_mechanic.delay
elseif traderprefab == "pigman_professor" then
return TRADER.pigman_professor.delay
elseif traderprefab == "pigman_hunter" then
return TRADER.pigman_hunter.delay
elseif traderprefab == "pigman_mayor" then
return TRADER.pigman_mayor.delay
elseif traderprefab == "pigman_florist" then
return TRADER.pigman_florist.delay
elseif traderprefab == "pigman_storeowner" then
return TRADER.pigman_storeowner.delay
elseif traderprefab == "pigman_farmer" then
return TRADER.pigman_farmer.delay
elseif traderprefab == "pigman_miner" then
return TRADER.pigman_miner.delay
elseif traderprefab == "pigman_erudite" then
return TRADER.pigman_erudite.delay
elseif traderprefab == "pigman_hatmaker" then
return TRADER.pigman_hatmaker.delay
elseif traderprefab == "pigman_queen" then
return TRADER.pigman_queen.delay
elseif traderprefab == "pigman_usher" then
return TRADER.pigman_usher.delay
else
return 0
end
end

function Economy:MakeTrade(traderprefab,city,inst)
if traderprefab == "pigman_banker" then
return TRADER.pigman_banker.reward , TRADER.pigman_banker.rewardqty
elseif traderprefab == "pigman_beautician" then
return TRADER.pigman_beautician.reward , TRADER.pigman_beautician.rewardqty
elseif traderprefab == "pig_eskimo" then
return TRADER.pig_eskimo.reward , TRADER.pig_eskimo.rewardqty
elseif traderprefab == "pigman_mechanic" then
return TRADER.pigman_mechanic.reward , TRADER.pigman_mechanic.rewardqty
elseif traderprefab == "pigman_professor" then
return TRADER.pigman_professor.reward , TRADER.pigman_professor.rewardqty
elseif traderprefab == "pigman_hunter" then
return TRADER.pigman_hunter.reward , TRADER.pigman_hunter.rewardqty
elseif traderprefab == "pigman_mayor" then
return TRADER.pigman_mayor.reward , TRADER.pigman_mayor.rewardqty
elseif traderprefab == "pigman_florist" then
return TRADER.pigman_florist.reward , TRADER.pigman_florist.rewardqty
elseif traderprefab == "pigman_storeowner" then
return TRADER.pigman_storeowner.reward , TRADER.pigman_storeowner.rewardqty
elseif traderprefab == "pigman_farmer" then
return TRADER.pigman_farmer.reward , TRADER.pigman_farmer.rewardqty
elseif traderprefab == "pigman_miner" then
return TRADER.pigman_miner.reward , TRADER.pigman_miner.rewardqty
elseif traderprefab == "pigman_erudite" then
return TRADER.pigman_erudite.reward , TRADER.pigman_erudite.rewardqty
elseif traderprefab == "pigman_hatmaker" then
return TRADER.pigman_hatmaker.reward , TRADER.pigman_hatmaker.rewardqty
elseif traderprefab == "pigman_queen" then
return TRADER.pigman_queen.reward , TRADER.pigman_queen.rewardqty
elseif traderprefab == "pigman_usher" then
return TRADER.pigman_usher.reward , TRADER.pigman_usher.rewardqty
else
return "oinc" , 1
end
end 

function Economy:processdelays()
--	print("resetting delays")

	for c, city in ipairs(self.cities) do
		for i,trader in pairs(city) do
			for guid,data in pairs(trader.GUIDS)do
				if data > 0 then
					data = data -1
					trader.GUIDS[guid] = data
				end
			end		
		end
	end
end

function Economy:AddCity(city)  
	self.cities[city] = deepcopy(TRADER)

	for i,item in pairs(self.cities[city]) do
		item.GUIDS = {}
	end

end

return Economy