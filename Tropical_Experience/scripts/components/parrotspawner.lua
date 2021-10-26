--------------------------------------------------------------------------
--[[ BirdSpawner class definition ]]
--------------------------------------------------------------------------
function GetMoney(inventory)
	local money = 0

	local hasoincs,oincamount = inventory:Has("oinc", 0)
	local hasoinc10s,oinc10amount = inventory:Has("oinc10", 0)
	local hasoinc100s,oinc100amount = inventory:Has("oinc100", 0)
		
	money = oincamount + (oinc10amount *10)+ (oinc100amount *100)
	return money
end

return Class(function(self, inst)

assert(TheWorld.ismastersim, "BirdSpawner should not exist on client")

--------------------------------------------------------------------------
--[[ Constants ]]
--------------------------------------------------------------------------

--Note: in winter, 'robin' is replaced with 'robin_winter' automatically
local BIRD_TYPES = {}


BIRD_TYPES =
{
[GROUND.OCEAN_HAZARDOUS] = {"wave_ripple"},
[GROUND.OCEAN_ROUGH] = {"wave_ripple" },
[GROUND.OCEAN_SWELL] = {"wave_ripple" },
}

--------------------------------------------------------------------------
--[[ Member variables ]]
--------------------------------------------------------------------------

--Public
self.inst = inst


--Private
local _activeplayers = {}
local _scheduledtasks = {}
local _worldstate = TheWorld.state
local _map = TheWorld.Map
local _groundcreep = TheWorld.GroundCreep
local _updating = false
local _birds = {}
local _maxbirds = 100 --numero de efeitos de agua
local _minspawndelay = 2
local _maxspawndelay = 6
local _timescale = 1
local tempodovento = 4
local tempodohail = 4
local numeroderoc = 1
local diadobandido = 0
local diadobramble = 0
local contadordovulcao = 0
local diadoterremoto = 0
local vulcaonojogo = nil
local cinzas = nil
--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------

local function CalcValue(player, basevalue, modifier)
	local ret = basevalue
	local attractor = player and player.components.birdattractor
	if attractor then
		ret = ret + attractor.spawnmodifier:CalculateModifierFromKey(modifier)
	end
	return ret
end

local function SpawnBirdForPlayer(player, reschedule)
    local pt = player:GetPosition()
-----------------------------------agua no pe que beleza heim?-----------------------------------------

local ex, ey, ez = player.Transform:GetWorldPosition()
local pt=Vector3(ex, ey, ez)
local map = TheWorld.Map
--local ex, ey, ez = inst.Transform:GetWorldPosition()
local posicao = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez))
---------------------------------------------adiciona bramble -------------------------------------------------------------

if (TUNING.tropical.kindofworld == 5) or (TUNING.tropical.kindofworld == 15 and TUNING.tropical.hamlet ~= 5) then

if diadobramble ~= TheWorld.state.cycles then
diadobramble = TheWorld.state.cycles


if TheWorld.state.issummer and (TheWorld.state.remainingdaysinseason == 3 or TheWorld.state.remainingdaysinseason == 6 or TheWorld.state.remainingdaysinseason == 9 or TheWorld.state.remainingdaysinseason == 12 or 
TheWorld.state.remainingdaysinseason == 15 or TheWorld.state.remainingdaysinseason == 17 or TheWorld.state.remainingdaysinseason == 19) then

local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
local curr = map:GetTile(map:GetTileCoordsAtPoint(x,0,z))
local curr1 = map:GetTile(map:GetTileCoordsAtPoint(x-4,0,z))
local curr2 = map:GetTile(map:GetTileCoordsAtPoint(x+4,0,z))
local curr3 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z-4))
local curr4 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z+4))
-------------------coloca os itens------------------------
if curr == GROUND.RAINFOREST and curr1 == GROUND.RAINFOREST and curr2 == GROUND.RAINFOREST and curr3 == GROUND.RAINFOREST and curr4 == GROUND.RAINFOREST or
curr == GROUND.DEEPRAINFOREST and curr1 == GROUND.DEEPRAINFOREST and curr2 == GROUND.DEEPRAINFOREST and curr3 == GROUND.DEEPRAINFOREST and curr4 == GROUND.DEEPRAINFOREST or
curr == GROUND.GASJUNGLE and curr1 == GROUND.GASJUNGLE and curr2 == GROUND.GASJUNGLE and curr3 == GROUND.GASJUNGLE and curr4 == GROUND.GASJUNGLE or
curr == GROUND.PLAINS and curr1 == GROUND.PLAINS and curr2 == GROUND.PLAINS and curr3 == GROUND.PLAINS and curr4 == GROUND.PLAINS then 
local colocaitem = SpawnPrefab("bramble") 
colocaitem.Transform:SetPosition(x, 0, z)
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

end
end


end

---------------------------------------------adiciona erupção -------------------------------------------------------------
if TUNING.tropical.volcaniceruption ~= 5 then

if not vulcaonojogo then
for k,v in pairs(Ents) do
if v:HasTag("vulcaomigrador") then vulcaonojogo = v end
if not vulcaonojogo then vulcaonojogo = 10 end
--print(vulcaonojogo)
end
end

local vx, vy, vz = player.Transform:GetWorldPosition()
if TheWorld.state.issummer and math.fmod (TheWorld.state.remainingdaysinseason, 3) ~= 0 and diadoterremoto ~= 0 then
diadoterremoto = 0
end
if (TheWorld.state.issummer and math.fmod (TheWorld.state.remainingdaysinseason, 3) == 0 and TheWorld.state.seasonprogress > 0.1 and (player.components.areaaware:CurrentlyInTag("tropical") or TheWorld.Map:IsOceanTileAtPoint(vx, vy, vz))) or
   (TheWorld.state.issummer and math.fmod (TheWorld.state.remainingdaysinseason, 3) == 0 and TheWorld.state.seasonprogress > 0.1 and (TUNING.tropical.volcaniceruption == 20)) then
--print(diadoterremoto)

diadoterremoto = diadoterremoto + 1
--------------------------------tremor um-------------------------------
if diadoterremoto == 50 then
ShakeAllCameras(CAMERASHAKE.FULL, 8, .04, .8, player, 40)
player.SoundEmitter:PlaySound("dontstarve/cave/earthquake", "earthquake")
player:DoTaskInTime(7, function(inst) 
inst.SoundEmitter:KillSound("earthquake") 
player.components.talker:Say(STRINGS.CHARACTERS.GENERIC.ANNOUNCE_QUAKE)
end)
end
--------------------------------tremor dois-------------------------------
if diadoterremoto == 150 then
ShakeAllCameras(CAMERASHAKE.FULL, 12, .04, .8, player, 40)
player.SoundEmitter:PlaySound("dontstarve/cave/earthquake", "earthquake")
player:DoTaskInTime(10, function(inst) 
inst.SoundEmitter:KillSound("earthquake") 
player.components.talker:Say(STRINGS.CHARACTERS.GENERIC.ANNOUNCE_QUAKE)
end)
end
--------------------------------tremor três-------------------------------
if diadoterremoto == 200 then
ShakeAllCameras(CAMERASHAKE.FULL, 18, .04, .8, player, 40)
player.SoundEmitter:PlaySound("dontstarve/cave/earthquake", "earthquake")
player:DoTaskInTime(15, function(inst) 
inst.SoundEmitter:KillSound("earthquake") 
player.components.talker:Say(STRINGS.CHARACTERS.GENERIC.ANNOUNCE_VOLCANO_ERUPT)
end)
end
-------------------------------chuva de fogo-----------------
if (diadoterremoto > 200 and diadoterremoto < (600 - (TheWorld.state.remainingdaysinseason*20)) and player.components.areaaware and player.components.areaaware:CurrentlyInTag("tropical") or diadoterremoto > 200 and diadoterremoto < (600 - (TheWorld.state.remainingdaysinseason*20)) and TheWorld.Map:IsOceanTileAtPoint(vx, vy, vz)) or
   diadoterremoto > 200 and diadoterremoto < (600 - (TheWorld.state.remainingdaysinseason*20)) and TUNING.tropical.volcaniceruption == 20 then
    
   
--if not cinzas then
player:AddTag("cinzas")
--cinzas = SpawnPrefab("ashfx")
--cinzas.entity:SetParent(player.entity )
--cinzas.particles_per_tick = 6
--end

contadordovulcao = contadordovulcao + 1
if contadordovulcao > TheWorld.state.remainingdaysinseason then
if vulcaonojogo and vulcaonojogo ~= 10 and not vulcaonojogo.sg:HasStateTag("atacando") then vulcaonojogo.sg:GoToState("erupt") end
--print(vulcaonojogo)
contadordovulcao = 0
local chuvadefogo

local casa = GetClosestInstWithTag("blows_air", player, 30)
if not casa then
if math.random() <= 0.25 then
chuvadefogo = SpawnPrefab("dragoonegg_falling")
else
chuvadefogo = SpawnPrefab("firerain")
end
chuvadefogo.Transform:SetPosition(vx+math.random(-15, 15), 0, vz+math.random(-15, 15))
chuvadefogo:StartStep()
end
end
else
--if cinzas then
player:RemoveTag("cinzas")
--cinzas:Remove()
--cinzas = nil
--end
end

end
end
----------------------------adiciona hail----------------------------------------
if (TUNING.tropical.hail and TUNING.tropical.hamworld ~= 5) then
if player.components.areaaware and player.components.areaaware:CurrentlyInTag("tropical") then
if TheWorld.components.worldstate.data.israining and TheWorld.state.isspring and math.random() < 0.07 then
tempodohail = tempodohail - 3
end

if TheWorld.components.worldstate.data.issnowing and TheWorld.state.iswinter and math.random() < 0.03 then
tempodohail = tempodohail - 3
end

if tempodohail <= 0 then
local a, b, c = player.Transform:GetWorldPosition()
local casa = GetClosestInstWithTag("blows_air", player, 30)
if not casa then
local hail = SpawnPrefab("hail_ice")
hail.Transform:SetPosition(a+math.random(-15, 15), 35, c+math.random(-15, 15))
end
tempodohail = 4
end
end
end

---------------------------------------------ventania -------------------------------------------------------------
if TUNING.tropical.wind ~= 5 then
if posicao == GROUND.OCEAN_COASTAL or posicao == GROUND.OCEAN_WATERLOG or posicao == GROUND.OCEAN_COASTAL_SHORE or posicao == GROUND.OCEAN_SWELL or posicao == GROUND.OCEAN_ROUGH or posicao == GROUND.OCEAN_BRINEPOOL or posicao == GROUND.OCEAN_BRINEPOOL_SHORE or posicao == GROUND.OCEAN_HAZARDOUS or player.components.areaaware and player.components.areaaware:CurrentlyInTag("tropical") or player.components.areaaware and player.components.areaaware:CurrentlyInTag("hamlet") or TUNING.tropical.wind == 20 then
--print("tropical")
if TheWorld.components.worldstate.data.israining and TheWorld.state.isautumn and math.random() < 0.07 then
tempodovento = tempodovento - 1
end

if TheWorld.components.worldstate.data.issnowing and TheWorld.state.iswinter and math.random() < 0.13 then
tempodovento = tempodovento - 1
end

if TheWorld.components.worldstate.data.israining and TheWorld.state.issummer and math.random() < 0.02 then
tempodovento = tempodovento - 1
end

if tempodovento <= 0 then
local a, b, c = player.Transform:GetWorldPosition()
local casa = GetClosestInstWithTag("blows_air", player, 30)
if not casa then
local vento = SpawnPrefab("ventania")
vento.Transform:SetPosition(a, b, c)
end
tempodovento = 4
end
end
end
---------------------------------------------------------------------------------------------------

	
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 64, { "onda" })
    if #ents < CalcValue(player, _maxbirds, "maxbirds") then
        local spawnpoint = self:GetSpawnPoint(pt)
        if spawnpoint ~= nil then
            self:SpawnBird(spawnpoint, player)
        end
    end
    _scheduledtasks[player] = nil
    reschedule(player)
end

local function ScheduleSpawn(player, initialspawn)
    if _scheduledtasks[player] == nil then
        _scheduledtasks[player] = player:DoTaskInTime(0.6, SpawnBirdForPlayer, ScheduleSpawn)
    end
end

local function CancelSpawn(player)
    if _scheduledtasks[player] ~= nil then
        _scheduledtasks[player]:Cancel()
        _scheduledtasks[player] = nil
    end
end

local function ToggleUpdate(force)

for i, v in ipairs(_activeplayers) do
if v.components.inventory and GetMoney(v.components.inventory) >= 2 and math.random() > 0.6 then
local pt = v:GetPosition()
if (TUNING.tropical.hamlet ~= 5 or TUNING.tropical.kindofworld == 5) and TUNING.tropical.kindofworld ~= 10 then
local map = TheWorld.Map
local x,y,z = pt:Get()
local ents = TheSim:FindEntities(x,y,z, 40,{"bandit_cover"})
if #ents > 1 then
local cover = ents[math.random(1,#ents)]
if cover then
local x2,y2,z2 = cover.Transform:GetWorldPosition()
if TheWorld.Map:IsVisualGroundAtPoint(x2,y2,z2) then
local bandidao = SpawnPrefab("pigbandit")
bandidao.Transform:SetPosition(x2,y2,z2)
end
end		
end
end
end
end



    if _maxbirds > 0 then
        if not _updating then
            _updating = true
            for i, v in ipairs(_activeplayers) do
                ScheduleSpawn(v, true)
            end
        elseif force then
            for i, v in ipairs(_activeplayers) do
                CancelSpawn(v)
                ScheduleSpawn(v, true)
            end
        end
    elseif _updating then
        _updating = false
        for i, v in ipairs(_activeplayers) do
            CancelSpawn(v)
        end
    end
end

local function PickBird(spawnpoint)
    local tile = _map:GetTileAtPoint(spawnpoint:Get())
    local bird = GetRandomItem(BIRD_TYPES[tile]) -- or "flood"
--    if bird == "crow" then
--        local x, y, z = spawnpoint:Get()
--        local canarylure = TheSim:FindEntities(x, y, z, TUNING.BIRD_CANARY_LURE_DISTANCE, { "scarecrow" })
--        if #canarylure ~= 0 then
--            bird = "canary"
--        end
--    end

    return bird --_worldstate.iswinter and bird == "wave_shimmer" and "wave_shimmer_med" or _worldstate.issummer and bird == "wave_shimmer" and "wave_shimmer_deep" or bird
end

local function AutoRemoveTarget(inst, target)
    if _birds[target] ~= nil and target:IsAsleep() then
        target:Remove()
    end
end

--------------------------------------------------------------------------
--[[ Private event handlers ]]
--------------------------------------------------------------------------

local function OnTargetSleep(target)
    inst:DoTaskInTime(0, AutoRemoveTarget, target)
end

local function OnIsRaining(inst, israining)
    _timescale = israining and TUNING.BIRD_RAIN_FACTOR or 1
end

local function OnPlayerJoined(src, player)
    for i, v in ipairs(_activeplayers) do
        if v == player then
            return
        end
    end
    table.insert(_activeplayers, player)
    if _updating then
        ScheduleSpawn(player, true)
    end
end

local function OnPlayerLeft(src, player)
    for i, v in ipairs(_activeplayers) do
        if v == player then
            CancelSpawn(player)
            table.remove(_activeplayers, i)
            return
        end
    end
end

--------------------------------------------------------------------------
--[[ Initialization ]]
--------------------------------------------------------------------------

--Initialize variables
for i, v in ipairs(AllPlayers) do
    table.insert(_activeplayers, v)
end

--Register events
inst:WatchWorldState("israining", OnIsRaining)
inst:WatchWorldState("isnight", ToggleUpdate)
inst:ListenForEvent("ms_playerjoined", OnPlayerJoined, TheWorld)
inst:ListenForEvent("ms_playerleft", OnPlayerLeft, TheWorld)

--------------------------------------------------------------------------
--[[ Post initialization ]]
--------------------------------------------------------------------------

function self:OnPostInit()
    OnIsRaining(inst, _worldstate.israining)
    ToggleUpdate(true)
end

--------------------------------------------------------------------------
--[[ Public member functions ]]
--------------------------------------------------------------------------

function self:SetSpawnTimes(delay)
	print "DEPRECATED: SetSpawnTimes() in birdspawner.lua, use birdattractor.spawnmodifier instead"
    _minspawndelay = delay.min
    _maxspawndelay = delay.max
end

function self:SetMaxBirds(max)
	print "DEPRECATED: SetMaxBirds() in birdspawner.lua, use birdattractor.spawnmodifier instead"
    _maxbirds = max
    ToggleUpdate(true)
end

function self:ToggleUpdate()
	ToggleUpdate(true)
end

function self:SpawnModeNever()
    self:SetMaxBirds(10)
end

function self:SpawnModeHeavy()
    self:SetMaxBirds(10)
end

function self:SpawnModeMed()
    self:SetMaxBirds(10)
end

function self:SpawnModeLight()
    self:SetMaxBirds(10)
end


function SpawnWavesSW(inst, numWaves, totalAngle, waveSpeed, wavePrefab, initialOffset, idleTime, instantActive, random_angle)
	wavePrefab = wavePrefab or "rogue_wave"
	totalAngle = math.clamp(totalAngle, 1, 360)

    local pos = inst:GetPosition()
    local startAngle = (random_angle and math.random(-180, 180)) or inst.Transform:GetRotation()
    local anglePerWave = totalAngle/(numWaves - 1)

	if totalAngle == 360 then
		anglePerWave = totalAngle/numWaves
	end

    --[[
    local debug_offset = Vector3(2 * math.cos(startAngle*DEGREES), 0, -2 * math.sin(startAngle*DEGREES)):Normalize()
    inst.components.debugger:SetOrigin("debugy", pos.x, pos.z)
    local debugpos = pos + (debug_offset * 2)
    inst.components.debugger:SetTarget("debugy", debugpos.x, debugpos.z)
    inst.components.debugger:SetColour("debugy", 1, 0, 0, 1)
	--]]

    for i = 0, numWaves - 1 do
        local wave = SpawnPrefab(wavePrefab)

        local angle = (startAngle - (totalAngle/2)) + (i * anglePerWave)
        local rad = initialOffset or (inst.Physics and inst.Physics:GetRadius()) or 0.0
        local total_rad = rad + wave.Physics:GetRadius() + 0.1
        local offset = Vector3(math.cos(angle*DEGREES),0, -math.sin(angle*DEGREES)):Normalize()
        local wavepos = pos + (offset * total_rad)

--        if inst:GetIsOnWater(wavepos:Get()) then
	        wave.Transform:SetPosition(wavepos:Get())

	        local speed = waveSpeed or 6
	        wave.Transform:SetRotation(angle)
	        wave.Physics:SetMotorVel(speed, 0, 0)
	        wave.idle_time = idleTime or 5

	        if instantActive then
	        	wave.sg:GoToState("idle")
	        end

	        if wave.soundtidal then
--	        	wave.SoundEmitter:PlaySound("dontstarve_DLC002/common/rogue_waves/"..wave.soundtidal)
	        end
--        else
--        	wave:Remove()
--        end
    end
end





function self:GetSpawnPoint(pt)
    --We have to use custom test function because birds can't land on creep
    local function TestSpawnPoint(offset)
        local spawnpoint = pt + offset
        return not _groundcreep:OnCreep(spawnpoint:Get())   end

    local theta = math.random() * 2 * PI
    local radius = 2 + math.random() * 25
    local resultoffset = FindValidPositionByFan(theta, radius, 12, TestSpawnPoint)

    if resultoffset ~= nil then
        return pt + resultoffset
    end
end

function self:SpawnBird(spawnpoint, player)
    local prefab = PickBird(spawnpoint)
----------------------------flood--------------------------------------
if TUNING.tropical.springflood ~= 5 then			

if (TheWorld.state.isspring and TheWorld.state.iswet and TheWorld.state.israining and math.random() > 0.80 and player and player.components.areaaware and player.components.areaaware:CurrentlyInTag("tropical")) or
   (TheWorld.state.isspring and TheWorld.state.iswet and TheWorld.state.israining and math.random() > 0.80 and player and  TUNING.tropical.springflood == 20) then
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x, spawnpoint.y, spawnpoint.z) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x, spawnpoint.y, spawnpoint.z+6) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x, spawnpoint.y, spawnpoint.z-6) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x+6, spawnpoint.y, spawnpoint.z) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x-6, spawnpoint.y, spawnpoint.z) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x+6, spawnpoint.y, spawnpoint.z+6) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x+6, spawnpoint.y, spawnpoint.z-6) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x-6, spawnpoint.y, spawnpoint.z-6) then return end
if TheWorld.Map:IsOceanTileAtPoint(spawnpoint.x+6, spawnpoint.y, spawnpoint.z+6) then return end
local casa = GetClosestInstWithTag("blows_air", player, 30)
if casa then return end

local sandbags = TheSim:FindEntities(spawnpoint.x, spawnpoint.y, spawnpoint.z, 10,{"removealagamento"})
if #sandbags > 3 then return end
local bird = SpawnPrefab("floodsw")
bird.Transform:SetPosition(spawnpoint:Get())
local outraperto = GetClosestInstWithTag("marepracolocar", bird, 13)
if outraperto then bird:Remove() return end
return end
end
----------------------------------------------------------------------------



if TUNING.tropical.waves == false then return end

if prefab == "wave_ripple" then
if TheWorld.state.issummer and math.random() > 0.10 or TheWorld.state.moonphase == "new" and math.random() > 0.10 then return end

if TheWorld.state.moonphase == "full" and math.random() < 0.3 then
prefab = "rogue_wave"
end

if TheWorld.state.iswinter and math.random() < (TheWorld.state.seasonprogress + 0.2) then
prefab = "rogue_wave"
end

local bird = SpawnPrefab(prefab)
bird.Transform:SetPosition(spawnpoint:Get())
local plataforma = GetClosestInstWithTag("walkableplatform", bird, 8)
if plataforma then bird:Remove() return end



if TheWorld.state.isday then    
bird.Transform:SetRotation(90) 
if prefab == "rogue_wave" then bird.Physics:SetMotorVel(6, 0, 6) else
bird.Physics:SetMotorVel(2, 0, 2)
end
else
bird.Transform:SetRotation(-90)
if prefab == "rogue_wave" then bird.Physics:SetMotorVel(6, 0, 6) else
bird.Physics:SetMotorVel(2, 0, 2)
end
end
return bird
end		


return
--[[	
local bird = SpawnPrefab("wave_ripple")
bird.Transform:SetPosition(spawnpoint:Get())
local plataforma = GetClosestInstWithTag("walkableplatform", bird, 8)
if plataforma then bird:Remove() return end

    return bird
]]
end

function self.StartTrackingFn(target)
    if _birds[target] == nil then
        _birds[target] = target.persists == true
        target.persists = false
        inst:ListenForEvent("entitysleep", OnTargetSleep, target)
    end
end

function self:StartTracking(target)
    self.StartTrackingFn(target)
end

function self.StopTrackingFn(target)
    local restore = _birds[target]
    if restore ~= nil then
        target.persists = restore
        _birds[target] = nil
        inst:RemoveEventCallback("entitysleep", OnTargetSleep, target)
    end
end

function self:StopTracking(target)
    self.StopTrackingFn(target)
end

--------------------------------------------------------------------------
--[[ Save/Load ]]
--------------------------------------------------------------------------

function self:OnSave()
    return
    {
        maxbirds = _maxbirds,
        minspawndelay = _minspawndelay,
        maxspawndelay = _maxspawndelay,
    }
end

function self:OnLoad(data)
    _maxbirds = data.maxbirds or TUNING.BIRD_SPAWN_MAX
    _minspawndelay = data.minspawndelay or TUNING.BIRD_SPAWN_DELAY.min
    _maxspawndelay = data.maxspawndelay or TUNING.BIRD_SPAWN_DELAY.max

    ToggleUpdate(true)
end

--------------------------------------------------------------------------
--[[ Debug ]]
--------------------------------------------------------------------------

function self:GetDebugString()
    local numbirds = 0
    for k, v in pairs(_birds) do
        numbirds = numbirds + 1
    end
    return string.format("birds:%d/%d", numbirds, _maxbirds)
end

--------------------------------------------------------------------------
--[[ End ]]
--------------------------------------------------------------------------

end)
