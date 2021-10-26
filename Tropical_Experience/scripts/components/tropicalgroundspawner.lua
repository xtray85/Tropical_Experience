local SCHOOL_SIZE = {
	TINY = 		{min=1,max=3},
	SMALL = 	{min=2,max=5},
	MEDIUM = 	{min=4,max=6},
	LARGE = 	{min=6,max=10},	
}

local SCHOOL_AREA = {
	TINY = 		1,
	SMALL = 	3,
	MEDIUM = 	6,
	LARGE = 	10,	
}

local seg_time = 30
local total_day_time = seg_time*16
local SCHOOL_SPAWN_DELAY = {min=0.5*seg_time, max=2*seg_time}
local SCHOOL_SPAWNER_FISH_CHECK_RADIUS = 30
local SCHOOL_SPAWNER_MAX_FISH = 10
local SCHOOL_SPAWNER_BLOCKER_MOD = 1/3
local SCHOOL_SPAWNER_BLOCKER_LIFETIME = total_day_time

local CRIATURAS = 
{
	hanging_vine_patch = { 
	  	prefab = "hanging_vine_patch", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},
	
--	snapdragon = { 
--	  	prefab = "snapdragon", 
--	  	schoolmin = 1,
--	  	schoolmax = 1,
--	  	schoolrange = SCHOOL_AREA.TINY,		
--	},	
	
	mean_flytrap = { 
	  	prefab = "mean_flytrap", 
	  	schoolmin = 2,
	  	schoolmax = 6,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},	

	adult_flytrap = { 
	  	prefab = "adult_flytrap", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},		
	
	lightrays_jungle = { 
	  	prefab = "lightrays_jungle", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},		
	
	zeb = { 
	  	prefab = "zeb", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.MEDIUM,		
	},		
	
	pog = { 
	  	prefab = "pog", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},		
	
	robin = { 
	  	prefab = "robin", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},	

	crow = { 
	  	prefab = "crow", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},	

	kingfisher = { 
	  	prefab = "kingfisher", 
	  	schoolmin = 1,
	  	schoolmax = 1,
	  	schoolrange = SCHOOL_AREA.TINY,		
	},		
}

local SCHOOL_VERY_COMMON		= 4
local SCHOOL_COMMON				= 2
local SCHOOL_UNCOMMON			= 1
local SCHOOL_RARE				= 0.25

local PESODOGRUPO = {
	[SEASONS.AUTUMN] = {
	
	    [GROUND.DEEPRAINFOREST] = 
		{
--	        snapdragon = 				0.2,
	        hanging_vine_patch = 		1,
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.GASJUNGLE] = 
		{
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.PLAINS] = 
		{
	        pog = 						0.2,
			zeb = 			    		0.1,	
			robin = 			    	0.5,	
			crow = 			    		0.5,	
			kingfisher = 			    0.5,	
	    },

		
    },
	
	[SEASONS.WINTER] = {
	
	    [GROUND.DEEPRAINFOREST] = 
		{
--	        snapdragon = 				0.2,
	        hanging_vine_patch = 		1,
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.GASJUNGLE] = 
		{
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.PLAINS] = 
		{
	        pog = 						0.2,
			zeb = 			    		0.1,	
			robin = 			    	0.5,	
			crow = 			    		0.5,	
			kingfisher = 			    0.5,	
	    },

	    [GROUND.FIELDS] = 
		{
			robin = 			    	0.5,	
			crow = 			    		0.5,			
	    },		
		
    },

	[SEASONS.SPRING] = {
	
	    [GROUND.DEEPRAINFOREST] = 
		{
--	        snapdragon = 				0.2,
	        hanging_vine_patch = 		1,
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.GASJUNGLE] = 
		{
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.PLAINS] = 
		{
	        pog = 						0.2,
			zeb = 			    		0.1,	
			robin = 			    	0.5,	
			crow = 			    		0.5,	
			kingfisher = 			    0.5,	
	    },
		
    },

	[SEASONS.SUMMER] = {
	
	    [GROUND.DEEPRAINFOREST] = 
		{
--	        snapdragon = 				0.2,
	        hanging_vine_patch = 		1,
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.GASJUNGLE] = 
		{
	        mean_flytrap = 				1,
			adult_flytrap = 			0.5,
			lightrays_jungle =			1,			
	    },
		
	    [GROUND.PLAINS] = 
		{
	        pog = 						0.2,
			zeb = 			    		0.1,	
			robin = 			    	0.5,	
			crow = 			    		0.5,	
			kingfisher = 			    0.5,	
	    },
		
    },	
}


return Class(function(self, inst)

assert(TheWorld.ismastersim, "SchoolSpawner should not exist on client")

--------------------------------------------------------------------------
--[[ Constants ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ Member variables ]]
--------------------------------------------------------------------------

--Public
self.inst = inst

--Private
local _scheduledtasks = {}

--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------
local TEMPOMINIMO = 5
local TEMPOMAXIMO = 10
local GNARWAIL_TEST_RADIUS = 100
local GNARWAIL_SPAWN_CHANCE = 0.05
local GNARWAIL_SPAWN_RADIUS = 10
local GNARWAIL_TIMING = {8, 10} -- min 8, max 10
local function testforgnarwail(comp, spawnpoint)
    local ents = TheSim:FindEntities(spawnpoint.x, spawnpoint.y, spawnpoint.z, GNARWAIL_TEST_RADIUS, { "flytrap" })
    if #ents < 2 and math.random() < GNARWAIL_SPAWN_CHANCE then
        local offset = FindWalkableOffset(spawnpoint, math.random()*2*PI, GNARWAIL_SPAWN_RADIUS)
        if offset then
            comp.inst:DoTaskInTime(GetRandomMinMax(GNARWAIL_TIMING[1], GNARWAIL_TIMING[2]), function()
                local gnarwail = SpawnPrefab("mean_flytrap")
                gnarwail.Transform:SetPosition(spawnpoint.x + offset.x, 0, spawnpoint.z + offset.z)
--                gnarwail.sg:GoToState("emerge")			
            end)
        end
    end
end

local function SpawnSchoolForPlayer(player, reschedule)
    if self:ShouldSpawnANewSchoolForPlayer(player) then
        local spawnpoint = self:GetSpawnPoint(player:GetPosition())
        if spawnpoint ~= nil then
            self:SpawnSchool(spawnpoint, player)
        end
    end

    _scheduledtasks[player] = nil
    reschedule(player)
end

local function ScheduleSpawn(player)
    if _scheduledtasks[player] == nil then
        _scheduledtasks[player] = player:DoTaskInTime(GetRandomMinMax(TEMPOMINIMO, TEMPOMAXIMO), SpawnSchoolForPlayer, ScheduleSpawn)
    end
end

local function CancelSpawn(player)
    if _scheduledtasks[player] ~= nil then
        _scheduledtasks[player]:Cancel()
        _scheduledtasks[player] = nil
    end
end

local function PickSchool(spawnpoint)
	if PESODOGRUPO[TheWorld.state.season] ~= nil then
		local school_choices = PESODOGRUPO[TheWorld.state.season][TheWorld.Map:GetTileAtPoint(spawnpoint.x,spawnpoint.y,spawnpoint.z)]
		local schooltype = school_choices and weighted_random_choice(school_choices) or nil
		return schooltype ~= nil and CRIATURAS[schooltype] or nil
	end
end

--------------------------------------------------------------------------
--[[ Private event handlers ]]
--------------------------------------------------------------------------

local function OnPlayerJoined(src, player)
	ScheduleSpawn(player)
end

local function OnPlayerLeft(src, player)
    CancelSpawn(player)
end

--------------------------------------------------------------------------
--[[ Initialization ]]
--------------------------------------------------------------------------

--Initialize variables
for i, v in ipairs(AllPlayers) do
    ScheduleSpawn(player)
end

--Register events
inst:ListenForEvent("ms_playerjoined", OnPlayerJoined, TheWorld)
inst:ListenForEvent("ms_playerleft", OnPlayerLeft, TheWorld)

--------------------------------------------------------------------------
--[[ Public member functions ]]
--------------------------------------------------------------------------

function self:ShouldSpawnANewSchoolForPlayer(player, percent_ground)
	local pt = player:GetPosition()
	local percent_ground = 1 - TheWorld.Map:CalcPercentOceanTilesAtPoint(pt.x, pt.y, pt.z, 25)

	if percent_ground > 0.1 then
		local num_school_spawn_blockers = #TheSim:FindEntities(pt.x, pt.y, pt.z, SCHOOL_SPAWNER_FISH_CHECK_RADIUS, {"tropicalspawnblocker"})
		if math.random() < 1 - num_school_spawn_blockers * SCHOOL_SPAWNER_BLOCKER_MOD then
			local pt = player:GetPosition()
			local num_fish = #TheSim:FindEntities(pt.x, pt.y, pt.z, SCHOOL_SPAWNER_FISH_CHECK_RADIUS, {"tropicalspawner"})
			local r = math.random()
			return num_fish == 0 and (r < percent_ground)
					or num_fish <= SCHOOL_SPAWNER_MAX_FISH and (r < (1/(num_fish + 1))*percent_ground)
					or false
			end
	end

	return false
end

function self:GetSpawnPoint(pt)
    local function TestSpawnPoint(offset)
        return PickSchool(pt + offset) and not TheWorld.Map:IsOceanAtPoint((pt + offset):Get())
    end
	local SPAWN_DIST = 23
    local theta = math.random() * 2 * PI
	local resultoffset = FindValidPositionByFan(theta, SPAWN_DIST, 12, TestSpawnPoint)
						or FindValidPositionByFan(theta, SPAWN_DIST, 12, TestSpawnPoint)
						or FindValidPositionByFan(theta, SPAWN_DIST, 12, TestSpawnPoint)
						or nil

    if resultoffset ~= nil then
        return pt + resultoffset
    end
end

local function DoSpawnFish(prefab, pos, rot, herd)
local map = TheWorld.Map
local x, y, z = pos:Get()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground == GROUND.DEEPRAINFOREST or
ground == GROUND.GASJUNGLE then

if prefab == "lightrays_jungle" then
if not TheWorld.state.isnight then
local fish = SpawnPrefab(prefab)
fish.Transform:SetPosition(pos:Get())
end
else
local fish = SpawnPrefab(prefab)
fish.Transform:SetPosition(pos:Get())
--    fish.sg:GoToState("arrive")
end
end


if ground == GROUND.PLAINS and prefab == "pog" or ground == GROUND.PLAINS and prefab == "zeb" then
local fish = SpawnPrefab(prefab)
fish.Transform:SetPosition(pos:Get())
end


end

function self:SpawnSchool(spawnpoint, target)
    local schooldata = PickSchool(spawnpoint)
    if schooldata == nil then
        return
    end
	
	local herd
--	local herd = SpawnPrefab("schoolherd_"..schooldata.prefab)
--	herd.Transform:SetPosition(spawnpoint:Get())

    local schoolsize = math.random(schooldata.schoolmin, schooldata.schoolmax)
    local rotation = math.random()*360

    local school_rand_angle = math.random()*360
	local school_spawnpoint = spawnpoint 
	
	--[[+ (FindWalkableOffset(spawnpoint, school_rand_angle, 20, 12, nil, nil, nil, true)
											or FindWalkableOffset(spawnpoint, school_rand_angle, 13, 12, nil, nil, nil, true)
											or FindWalkableOffset(spawnpoint, school_rand_angle, 7, 12, nil, nil, nil, true)
											or Vector3(0,0,0))
]]
    local count = 0
    for i = 1, schoolsize do
        local radius = math.sqrt(math.random())*schooldata.schoolrange
        local angle = math.random()*360

        local offset = FindWalkableOffset(school_spawnpoint, angle, radius, 12, true, nil, nil, true)
        if offset then
			if count == 0 then
				DoSpawnFish(schooldata.prefab, school_spawnpoint + offset, rotation, herd) 
			else
	            self.inst:DoTaskInTime(0.1+math.random()*1,function() DoSpawnFish(schooldata.prefab, school_spawnpoint + offset, rotation, herd) end)
			end
            count = count + 1
        end
    end

	--print("[schools - SpawnSchool] Spawned " .. tostring(count) .. "x " .. tostring(schooldata.prefab) .. " for " .. tostring(target))

    if count > 0 then
		SpawnPrefab("tropicalspawnblocker").Transform:SetPosition(spawnpoint:Get())

--        self.inst:PushEvent("schoolspawned", {spawnpoint = spawnpoint})

        local tile_at_spawnpoint = TheWorld.Map:GetTileAtPoint(spawnpoint:Get())
--        if tile_at_spawnpoint == GROUND.OCEAN_SWELL or tile_at_spawnpoint == GROUND.OCEAN_ROUGH then
--            testforgnarwail(self, spawnpoint)
--        end
	else
--		herd:Remove()
--		herd = nil
    end
end

--------------------------------------------------------------------------
--[[ Save/Load ]]
--------------------------------------------------------------------------

function self:OnSave()
    return
    {
    }
end

function self:OnLoad(data)
end

--------------------------------------------------------------------------
--[[ Debug ]]
--------------------------------------------------------------------------

function self:GetDebugString()
    local str = nil
	for k, t in pairs(_scheduledtasks) do

		local pt = k:GetPosition()
		local percent_ocean = 1 TheWorld.Map:CalcPercentOceanTilesAtPoint(pt.x, pt.y, pt.z, 25)
		str = (str == nil and "" or "\n")..tostring(k).." in "..string.format("%.2f", GetTaskRemaining(t)).." ocean = "..string.format("%.2f", percent_ocean).."%"
	end
	return str or "no scheduled tasks"
end

--------------------------------------------------------------------------
--[[ End ]]
--------------------------------------------------------------------------

end)
