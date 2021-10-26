local easing = require("easing") --mudei as linhas 266 ate a 270 para fazer frio na terra gelada

local ZERO_DISTANCE = 10
local ZERO_DISTSQ = ZERO_DISTANCE * ZERO_DISTANCE

local function oncurrent(self, current)
    if self.inst.player_classified ~= nil then
        self.inst.player_classified:SetTemperature(current)
    end
end

local function onsheltered(inst, data)
    if type(data) == "table" then
        inst.components.temperature.sheltered = data.sheltered
        if data.level then
            inst.components.temperature.sheltered_level = data.level
        end
    else
        inst.components.temperature.sheltered = data
    end
end

local Temperature = Class(function(self, inst)
    self.inst = inst
    self.settemp = nil
    self.current = TUNING.STARTING_TEMP
    self.maxtemp = TUNING.MAX_ENTITY_TEMP
    self.mintemp = TUNING.MIN_ENTITY_TEMP
    self.overheattemp = TUNING.OVERHEAT_TEMP
    self.hurtrate = TUNING.WILSON_HEALTH / TUNING.FREEZING_KILL_TIME
    --self.overheathurtrate = nil --defaults to use same as .hurtrate (freezing rate)
    self.inherentinsulation = 0
    self.inherentsummerinsulation = 0
    self.shelterinsulation = TUNING.INSULATION_MED_LARGE
    self.bellytemperaturedelta = nil
    self.bellytime = nil
    self.bellytask = nil
    self.ignoreheatertags = { "INLIMBO" }
    self.usespawnlight = nil
	self.hayfever = 0
    --At max moisture, the player will feel cooler than at minimum
    self.maxmoisturepenalty = TUNING.MOISTURE_TEMP_PENALTY

    --Cached update values
    self.totalmodifiers = 0
    self.externalheaterpower = 0
    self.delta = 0
    self.rate = 0

    self.sheltered = false
    self.sheltered_level = 1	
    self.inst:ListenForEvent("sheltered", onsheltered)

    self:OnUpdate(0)
    self.inst:StartUpdatingComponent(self)
end,
nil,
{
    current = oncurrent,
})

function Temperature:SetFreezingHurtRate(rate)
    self.hurtrate = rate
end

function Temperature:SetOverheatHurtRate(rate)
    self.overheathurtrate = rate
end

function Temperature:DoDelta(delta)
    local winterInsulation,summerInsulation = self:GetInsulation()

    if delta > 0 then
        delta = delta * (TUNING.SEG_TIME / (TUNING.SEG_TIME + summerInsulation))
    else
        delta = delta * (TUNING.SEG_TIME / (TUNING.SEG_TIME + winterInsulation))
    end

    self:SetTemperature(self.current + delta)
end

local function ClearBellyTemperature(inst, self)
    self.bellytemperaturedelta = nil
    self.bellytime = nil
    if self.bellytask ~= nil then
        self.bellytask:Cancel()
        self.bellytask = nil
    end
end

function Temperature:SetTemperatureInBelly(delta, duration)
    self.bellytemperaturedelta = delta
    self.bellytime = GetTime() + duration
    if self.bellytask ~= nil then
        self.bellytask:Cancel()
    end
    self.bellytask = self.inst:DoTaskInTime(duration, ClearBellyTemperature, self)
end

function Temperature:OnRemoveFromEntity()
    ClearBellyTemperature(nil, self)
    if self.inst.player_classified ~= nil then
        self.inst.player_classified.isfreezing:set(false)
    end
    self.inst:RemoveEventCallback("sheltered", onsheltered)
end

function Temperature:GetCurrent()
    return self.current
end

function Temperature:GetMax()
    return self.maxtemp
end

function Temperature:OnSave()
    return
    {
        current = self.current,
        bellytemperaturedelta = self.bellytemperaturedelta,
        bellytime = self.bellytemperaturedelta ~= nil and self.bellytime - GetTime() or nil,
    }
end

function Temperature:OnLoad(data)
    if data.bellytemperaturedelta ~= nil then
        self:SetTemperatureInBelly(data.bellytemperaturedelta, data.bellytime)
    end

    if data.current ~= nil and self.current ~= data.current then
        if self.inst:HasTag("player") then
            --world updates while players are logged off, so it looks glitchy
            --when you log off with winter temperature and log back into summer
            local world_temp = TheWorld.state.temperature

            if data.current > self.current then
                if world_temp > self.current then
                    self.current = math.min(data.current, world_temp)
                    self:OnUpdate(0)
                end
            elseif world_temp < self.current then
                self.current = math.max(data.current, world_temp)
                self:OnUpdate(0)
            end
        else
            self.current = data.current
            self:OnUpdate(0)
        end
    end
end

function Temperature:IgnoreTags(...)
    self.ignoreheatertags = { "INLIMBO", ... }
end

function Temperature:SetTemp(temp)
    self.settemp = temp
    if temp ~= nil then
        self:SetTemperature(temp)
    end
end

function Temperature:SetTemperature(value)
    local last = self.current
    self.current = value

    if (self.current < 0) ~= (last < 0) then
        self.inst:PushEvent(self.current < 0 and "startfreezing" or "stopfreezing")
    end

    if (self.current > self.overheattemp) ~= (last > self.overheattemp) then
        self.inst:PushEvent(self.current > self.overheattemp and "startoverheating" or "stopoverheating")
    end

    self.inst:PushEvent("temperaturedelta", { last = last, new = self.current })
end

function Temperature:GetDebugString()
	local winter, summer = self:GetInsulation()
    return string.format("%2.2fC at %2.2f (delta: %2.2f) (modifiers: %2.2f) (insulation: %d, %d)", self.current, self.rate, self.delta, self.totalmodifiers, winter, summer)
end

function Temperature:IsFreezing()
    return self.current < 0
end

function Temperature:IsOverheating()
    return self.current > self.overheattemp
end

function Temperature:SetModifier(name, value)
    if value == nil or value == 0 then
        return self:RemoveModifier(name)
    elseif self.temperature_modifiers == nil then
        self.temperature_modifiers = { [name] = value }
        self.totalmodifiers = value
        return
    end
    local m = self.temperature_modifiers[name]
    if m == value then
        return
    end
    self.temperature_modifiers[name] = value
    self.totalmodifiers = self.totalmodifiers + value - (m or 0)
end

function Temperature:RemoveModifier(name)
    if self.temperature_modifiers == nil then
        return
    end
    local m = self.temperature_modifiers[name]
    if m == nil then
        return
    end
    self.temperature_modifiers[name] = nil
    if next(self.temperature_modifiers) == nil then
        self.temperature_modifiers = nil
        self.totalmodifiers = 0
    else
        self.totalmodifiers = self.totalmodifiers - m
    end
end

function Temperature:GetInsulation()
    local winterInsulation = self.inherentinsulation
    local summerInsulation = self.inherentsummerinsulation

    if self.inst.components.inventory ~= nil then
        for k, v in pairs(self.inst.components.inventory.equipslots) do
            if v.components.insulator ~= nil then
                local insulationValue, insulationType = v.components.insulator:GetInsulation()
                
                if insulationType == SEASONS.WINTER then
                    winterInsulation = winterInsulation + insulationValue
                elseif insulationType == SEASONS.SUMMER then
                    summerInsulation = summerInsulation + insulationValue
                else
                    print(v, " has invalid insulation type: ", insulationType)
                end
            end
        end
    end

    if self.inst.components.beard ~= nil then
        --Beards help winterInsulation but hurt summerInsulation
        winterInsulation = winterInsulation + self.inst.components.beard:GetInsulation()
        summerInsulation = summerInsulation - self.inst.components.beard:GetInsulation()
    end

    if self.sheltered then
        summerInsulation = summerInsulation + self.shelterinsulation
    end

    if TheWorld.state.isdusk then
        summerInsulation = summerInsulation + TUNING.DUSK_INSULATION_BONUS
    elseif TheWorld.state.isnight then
        summerInsulation = summerInsulation + TUNING.NIGHT_INSULATION_BONUS
    end

    return math.max(0, winterInsulation), math.max(0, summerInsulation)
end

function Temperature:GetMoisturePenalty()
    return self.inst.components.moisture ~= nil and -Lerp(0, self.maxmoisturepenalty, self.inst.components.moisture:GetMoisturePercent()) or 0
end

local UPDATE_SPAWNLIGHT_ONEOF_TAGS = { "HASHEATER", "spawnlight" }
local UPDATE_NOSPAWNLIGHT_MUST_TAGS = { "HASHEATER" }
function Temperature:OnUpdate(dt, applyhealthdelta)
    self.externalheaterpower = 0
    self.delta = 0
    self.rate = 0

    if self.settemp ~= nil or
        self.inst.is_teleporting or
        (self.inst.components.health ~= nil and self.inst.components.health:IsInvincible()) then
        return
    end

    -- Can override range, e.g. in special containers
    local mintemp = self.mintemp
    local maxtemp = self.maxtemp
    local ambient_temperature = TheWorld.state.temperature
-----------------------------------------heatrock----------------------------------------------	
	if self.inst and self.inst:HasTag("heatrock") then
	local ex, ey, ez = self.inst.Transform:GetWorldPosition()	
	local map = TheWorld.Map 
	local posicao = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez)) 
	local posicao1 = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez+5))
	local posicao2 = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez-5))
	local posicao3 = map:GetTile(map:GetTileCoordsAtPoint(ex+5, ey, ez))
	local posicao4 = map:GetTile(map:GetTileCoordsAtPoint(ex-5, ey, ez))	
	
	if posicao == (GROUND.ANTFLOOR) or posicao1 == (GROUND.ANTFLOOR) or posicao2 == (GROUND.ANTFLOOR) or posicao3 == (GROUND.ANTFLOOR) or posicao4 == (GROUND.ANTFLOOR) or
	posicao == (GROUND.WATER_MANGROVE) or posicao1 == (GROUND.WATER_MANGROVE) or posicao2 == (GROUND.WATER_MANGROVE) or posicao3 == (GROUND.WATER_MANGROVE) or posicao4 == (GROUND.WATER_MANGROVE) then
	ambient_temperature = -20
	end
	end	
------------------------------caverna congelada---------------------------------------------
--[[	
	if TheWorld:HasTag("cave") then
	local ex, ey, ez = self.inst.Transform:GetWorldPosition()	
	local map = TheWorld.Map 
	local posicao = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez)) 
	local posicao1 = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez+5))
	local posicao2 = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez-5))
	local posicao3 = map:GetTile(map:GetTileCoordsAtPoint(ex+5, ey, ez))
	local posicao4 = map:GetTile(map:GetTileCoordsAtPoint(ex-5, ey, ez))	
	
	if posicao == (GROUND.ANTFLOOR) or posicao1 == (GROUND.ANTFLOOR) or posicao2 == (GROUND.ANTFLOOR) or posicao3 == (GROUND.ANTFLOOR) or posicao4 == (GROUND.ANTFLOOR) or
	posicao == (GROUND.WATER_MANGROVE) or posicao1 == (GROUND.WATER_MANGROVE) or posicao2 == (GROUND.WATER_MANGROVE) or posicao3 == (GROUND.WATER_MANGROVE) or posicao4 == (GROUND.WATER_MANGROVE) then
	ambient_temperature = -20
	end
	end
]]	
------------------------------------------frost------------------------------------------------------------	
	if self.inst and self.inst.components.areaaware and self.inst.components.areaaware:CurrentlyInTag("frost") then
	ambient_temperature = -20
	elseif
-----------------------------------------------mais quente no inverno ------------------------------	
	TheWorld.state.iswinter and TUNING.tropical.kindofworld == 10 or
	TheWorld.state.iswinter and self.inst and self.inst.components.areaaware and self.inst.components.areaaware:CurrentlyInTag("tropical") or 
	TheWorld.state.iswinter and self.inst and self.inst.components.areaaware and self.inst.components.areaaware:CurrentlyInTag("hamlet") then

	ambient_temperature = TheWorld.state.temperature + 40
	if self.inst.components.moisture and self.inst:HasTag("player") and TheWorld.components.worldstate.data.issnowing then
    self.inst.components.moisture.hamletzone = true
	end
	if self.inst.components.moisture and self.inst:HasTag("player") and not TheWorld.components.worldstate.data.issnowing then
    self.inst.components.moisture.hamletzone = false
	end	
	
	else
	
	if self.inst.components.moisture and self.inst:HasTag("player") then
    self.inst.components.moisture.hamletzone = false
	end	
	
	end	
---------------------------------------frio no verão ------------------------------	
if	TheWorld.state.issummer and TUNING.tropical.kindofworld == 5 or
	TheWorld.state.issummer and self.inst and self.inst.components.areaaware and self.inst.components.areaaware:CurrentlyInTag("hamlet") then
	ambient_temperature = TheWorld.state.temperature - 30
end
if	TheWorld.state.issummer and TUNING.tropical.kindofworld == 10 or
	TheWorld.state.issummer and self.inst and self.inst.components.areaaware and self.inst.components.areaaware:CurrentlyInTag("tropical") then
	ambient_temperature = TheWorld.state.temperature - 10
end
----------------------ajusta temperatura da casa---------------------------
	if self.inst and self.inst:HasTag("player") then
	local interior = GetClosestInstWithTag("blows_air", self.inst, 15)
	if interior and TheWorld.state.iswinter then
	ambient_temperature = TheWorld.state.temperature + 40
	elseif interior and TheWorld.state.issummer then
	ambient_temperature = TheWorld.state.temperature - 30	
	end
	end
---------------------------hay fever-----------------------------------------
local interior = GetClosestInstWithTag("blows_air", self.inst, 15)
if (TheWorld.state.issummer and self.inst and self.inst:HasTag("player") and TUNING.tropical.hayfever == 10 and (self.inst.components.areaaware and self.inst.components.areaaware:CurrentlyInTag("hamlet") or interior)) or
   (TheWorld.state.issummer and self.inst and self.inst:HasTag("player") and TUNING.tropical.hayfever == 20 and (self.inst.components.areaaware and self.inst.components.areaaware:GetCurrentArea() ~= nil or interior)) then
local mascara = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
local fan = GetClosestInstWithTag("prevents_hayfever", self.inst, 15)
if mascara and mascara.prefab == "gasmaskhat" or fan then
if self.hayfever > 0 then self.hayfever = self.hayfever - 1 end else
if not self.inst:HasTag("wereplayer") and not self.inst:HasTag("plantkin") then
self.hayfever = self.hayfever + 1 end
end
if self.inst and self.hayfever and self.hayfever  < 2000 then
if self.inst:HasTag("hayfever1") then self.inst:RemoveTag("hayfever1") end
if self.inst:HasTag("hayfever2") then self.inst:RemoveTag("hayfever2") end
if self.inst:HasTag("hayfever3") then self.inst:RemoveTag("hayfever3") end
if self.inst:HasTag("hayfever4") then self.inst:RemoveTag("hayfever4") end
end

if self.inst and self.hayfever and self.hayfever  < 3000 and self.hayfever  > 2000 then
if not self.inst:HasTag("hayfever1") then self.inst:AddTag("hayfever1") end
if self.inst:HasTag("hayfever2") then self.inst:RemoveTag("hayfever2") end
if self.inst:HasTag("hayfever3") then self.inst:RemoveTag("hayfever3") end
if self.inst:HasTag("hayfever4") then self.inst:RemoveTag("hayfever4") end
end

if self.inst and self.hayfever and self.hayfever  > 3250 then
if not self.inst:HasTag("hayfever2") then self.inst:AddTag("hayfever2") end
if self.inst:HasTag("hayfever1") then self.inst:RemoveTag("hayfever1") end
if self.inst:HasTag("hayfever3") then self.inst:RemoveTag("hayfever3") end
if self.inst:HasTag("hayfever4") then self.inst:RemoveTag("hayfever4") end
end

if self.inst and self.hayfever and self.hayfever  > 3300 then
if not self.inst:HasTag("hayfever3") then self.inst:AddTag("hayfever3") end
if self.inst:HasTag("hayfever2") then self.inst:RemoveTag("hayfever2") end
if self.inst:HasTag("hayfever1") then self.inst:RemoveTag("hayfever1") end
if self.inst:HasTag("hayfever4") then self.inst:RemoveTag("hayfever4") end
end

if self.inst and self.hayfever and self.hayfever  > 3350 then
if not self.inst:HasTag("hayfever4") then self.inst:AddTag("hayfever4") end
if self.inst:HasTag("hayfever2") then self.inst:RemoveTag("hayfever2") end
if self.inst:HasTag("hayfever3") then self.inst:RemoveTag("hayfever3") end
if self.inst:HasTag("hayfever1") then self.inst:RemoveTag("hayfever1") end
end


if self.inst and self.hayfever and self.hayfever  > 3400 then
self.hayfever = math.random(2000, 2500)
if self.inst.sg then self.inst:PushEvent("sneeze") end
end

else
if self.hayfever and self.hayfever > 0 then self.hayfever = self.hayfever - 0.25 end
end

--print(self.hayfever)

if self.hayfever and self.hayfever < 2000 then
if self.inst:HasTag("hayfever1") then self.inst:RemoveTag("hayfever1") end
if self.inst:HasTag("hayfever2") then self.inst:RemoveTag("hayfever2") end
if self.inst:HasTag("hayfever3") then self.inst:RemoveTag("hayfever3") end
if self.inst:HasTag("hayfever4") then self.inst:RemoveTag("hayfever4") end
end

if not TheWorld.state.issummer then
self.hayfever = 0
if self.inst:HasTag("hayfever1") then self.inst:RemoveTag("hayfever1") end
if self.inst:HasTag("hayfever2") then self.inst:RemoveTag("hayfever2") end
if self.inst:HasTag("hayfever3") then self.inst:RemoveTag("hayfever3") end
if self.inst:HasTag("hayfever4") then self.inst:RemoveTag("hayfever4") end
end
------------------------------------------------------------------------------------------------------------------------------	

	
    local owner = self.inst.components.inventoryitem ~= nil and self.inst.components.inventoryitem.owner or nil
    if owner ~= nil and owner:HasTag("fridge") and not owner:HasTag("nocool") then
        -- Inside a fridge, excluding icepack ("nocool")
        -- Don't cool it below freezing unless ambient temperature is below freezing
        mintemp = math.max(mintemp, math.min(0, ambient_temperature))
        self.rate = owner:HasTag("lowcool") and -.5 * TUNING.WARM_DEGREES_PER_SEC or -TUNING.WARM_DEGREES_PER_SEC
    else
        -- Prepare to figure out the temperature where we are standing
        local x, y, z = self.inst.Transform:GetWorldPosition()
        local ents = self.usespawnlight and
            TheSim:FindEntities(x, y, z, ZERO_DISTANCE, nil, self.ignoreheatertags, UPDATE_SPAWNLIGHT_ONEOF_TAGS) or
            TheSim:FindEntities(x, y, z, ZERO_DISTANCE, UPDATE_NOSPAWNLIGHT_MUST_TAGS, self.ignoreheatertags)
        if self.usespawnlight and #ents > 0 then
            for i, v in ipairs(ents) do
                if v.components.heater == nil and v:HasTag("spawnlight") then
                    ambient_temperature = math.clamp(ambient_temperature, 10, TUNING.OVERHEAT_TEMP - 20)
                    table.remove(ents, i)
                    break
                end
            end
        end

        --print(ambient_temperature, "ambient_temperature")
        if self.sheltered_level > 1 then
            ambient_temperature = math.min(ambient_temperature,  self.overheattemp - 5)
        end
		
        ambient_temperature = ambient_temperature		
        self.delta = (ambient_temperature + self.totalmodifiers + self:GetMoisturePenalty()) - self.current
        --print(self.delta + self.current, "initial target")

        if self.inst.components.inventory ~= nil then
            for k, v in pairs(self.inst.components.inventory.equipslots) do
                if v.components.heater ~= nil then
                    local heat = v.components.heater:GetEquippedHeat()
                    if heat ~= nil and
                        ((heat > self.current and v.components.heater:IsExothermic()) or
                        (heat < self.current and v.components.heater:IsEndothermic())) then
                        self.delta = self.delta + heat - self.current
                    end
                end
            end
            for k, v in pairs(self.inst.components.inventory.itemslots) do
                if v.components.heater ~= nil then
                    local heat, carriedmult = v.components.heater:GetCarriedHeat()
                    if heat ~= nil and
                        ((heat > self.current and v.components.heater:IsExothermic()) or
                        (heat < self.current and v.components.heater:IsEndothermic())) then
                        self.delta = self.delta + (heat - self.current) * carriedmult
                    end
                end
            end
            local overflow = self.inst.components.inventory:GetOverflowContainer()
            if overflow ~= nil then
                for k, v in pairs(overflow.slots) do
                    if v.components.heater ~= nil then
                        local heat, carriedmult = v.components.heater:GetCarriedHeat()
                        if heat ~= nil and
                            ((heat > self.current and v.components.heater:IsExothermic()) or
                            (heat < self.current and v.components.heater:IsEndothermic())) then
                            self.delta = self.delta + (heat - self.current) * carriedmult
                        end
                    end
                end
            end
        end

        --print(self.delta + self.current, "after carried/equipped")

        -- Recently eaten temperatured food is inherently equipped heat/cold
        if self.bellytemperaturedelta ~= nil and (
                (self.bellytemperaturedelta > 0 and self.current < TUNING.HOT_FOOD_WARMING_THRESHOLD) or
                (self.bellytemperaturedelta < 0 and self.current > TUNING.COLD_FOOD_CHILLING_THRESHOLD)
            ) then
            self.delta = self.delta + self.bellytemperaturedelta
        end

        --print(self.delta + self.current, "after belly")

        -- If very hot (basically only when have overheating screen effect showing) and under shelter, cool slightly
        if self.sheltered and self.current > TUNING.TREE_SHADE_COOLING_THRESHOLD then
            self.delta = self.delta - (self.current - TUNING.TREE_SHADE_COOLER)
        end

        --print(self.delta + self.current, "after shelter")

        for i, v in ipairs(ents) do 
            if v ~= self.inst and
                not v:IsInLimbo() and
                v.components.heater ~= nil and
                (v.components.heater:IsExothermic() or v.components.heater:IsEndothermic()) then

                local heat = v.components.heater:GetHeat(self.inst)
                if heat ~= nil then
                    -- This produces a gentle falloff from 1 to zero.
                    local heatfactor = 1 - self.inst:GetDistanceSqToInst(v) / ZERO_DISTSQ
                    if self.inst:GetIsWet() then
                        heatfactor = heatfactor * TUNING.WET_HEAT_FACTOR_PENALTY
                    end

                    if v.components.heater:IsExothermic() then
                        -- heating heatfactor is relative to 0 (freezing)
                        local warmingtemp = heat * heatfactor
                        if warmingtemp > self.current then
                            self.delta = self.delta + warmingtemp - self.current
                        end
                        self.externalheaterpower = self.externalheaterpower + warmingtemp
                    else--if v.components.heater:IsEndothermic() then
                        -- cooling heatfactor is relative to overheattemp
                        local coolingtemp = (heat - self.overheattemp) * heatfactor + self.overheattemp
                        if coolingtemp < self.current then
                            self.delta = self.delta + coolingtemp - self.current
                        end
                    end
                end
            end
        end

        --print(self.delta + self.current, "after heaters")

        -- Winter insulation only affects you when it's cold out, summer insulation only helps when it's warm
        if ambient_temperature >= TUNING.STARTING_TEMP then
            -- it's warm out
            if self.delta > 0 then
                -- If the player is heating up, defend using insulation.
                local winterInsulation, summerInsulation = self:GetInsulation()
                self.rate = math.min(self.delta, TUNING.SEG_TIME / (TUNING.SEG_TIME + summerInsulation))
            else
                -- If they are cooling, do it at full speed, and faster if they're overheated
                self.rate = math.max(self.delta, self.current >= self.overheattemp and -TUNING.THAW_DEGREES_PER_SEC or -TUNING.WARM_DEGREES_PER_SEC)
            end
        -- it's cold out
        elseif self.delta < 0 then
            -- If the player is cooling, defend using insulation.
            local winterInsulation, summerInsulation = self:GetInsulation()
            self.rate = math.max(self.delta, -TUNING.SEG_TIME / (TUNING.SEG_TIME + winterInsulation))
        else
            -- If they are heating up, do it at full speed, and faster if they're freezing
            self.rate = math.min(self.delta, self.current <= 0 and TUNING.THAW_DEGREES_PER_SEC or TUNING.WARM_DEGREES_PER_SEC)
        end

        --print(self.delta + self.current, "after insulation")
        --print(self.rate, "final rate\n\n")
    end

    self:SetTemperature(math.clamp(self.current + self.rate * dt, mintemp, maxtemp))

    --applyhealthdelta nil defaults to true
    if applyhealthdelta ~= false and self.inst.components.health ~= nil then
        if self.current < 0 then
            self.inst.components.health:DoDelta(-self.hurtrate * dt, true, "cold")
        elseif self.current > self.overheattemp then
            self.inst.components.health:DoDelta(-(self.overheathurtrate or self.hurtrate) * dt, true, "hot")
        end
    end
end

return Temperature
