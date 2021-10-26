local Oxygen = Class(function(self, inst)
    self.inst = inst
   
	self.max = 100
    self.current = self.max
	self.rate = 0
	self.hurtrate = 5
	self.burning = true
	
	self.inst:StartUpdatingComponent(self)
end)

function Oxygen:Pause()
    self.burning = false
end

function Oxygen:Resume()
    self.burning = true
end

function Oxygen:IsDrowning()
	return (self.current <= 0)
end

function Oxygen:OnSave()
    return
    {
        oxigenio = self.current,
    }
end

function Oxygen:OnLoad(data)
    if data.oxigenio ~= nil then
        self.current = data.oxigenio
		self:DoDelta(0)
	end
end

--[[

function Oxygen:OnSave()
	local data = {}
	data.current = self.current
	
	if self.max ~= 100 then
		data.max = self.max
	end
	
	return data
end

function Oxygen:OnLoad(data)
	
	if data.max then
		self.max = data.max
	end
	
	if data.current then
        self.current = self.max --data.current
		
		if self.current <= 0 then
			self.current = 0.001
		end
	end 
end
]]

function Oxygen:GetCurrent()
	return self.current
end

function Oxygen:GetMax()
	return self.max
end

function Oxygen:GetDelta()
	return self.rate
end

function Oxygen:GetPercent()	
	return self.current / self.max
end

function Oxygen:SetPercent(n)
    local target = n * self.max
    local delta = target - self.current
    self:DoDelta(delta)
end

function Oxygen:GetDebugString()
    return string.format("%2.2f / %2.2f at %2.4f", self.current, self.max, self.rate)
end

function Oxygen:SetMax(amount)
    self.max = amount
    self.current = amount
end

function Oxygen:GetRate()
	return self.rate
end

function Oxygen:DoDelta(delta, overtime)
	
	-- No oxygen loss while invincible or teleporting
	if self.inst.components.health and self.inst.components.health.invincible == true or self.inst.is_teleporting == true then
		return
	end
	
local map = TheWorld.Map
local x, y, z = self.inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
local ground1 = map:GetTile(map:GetTileCoordsAtPoint(x+5, y, z))
local ground2 = map:GetTile(map:GetTileCoordsAtPoint(x-5, y, z))
local ground3 = map:GetTile(map:GetTileCoordsAtPoint(x, y, z+5))
local ground4 = map:GetTile(map:GetTileCoordsAtPoint(x, y, z-5))
local naagua = false
if ground == GROUND.UNDERWATER_SANDY or ground == GROUND.UNDERWATER_ROCKY or (ground == GROUND.BEACH and TheWorld:HasTag("cave"))  or (ground == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave"))  or (ground == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground1 == GROUND.UNDERWATER_SANDY or ground1 == GROUND.UNDERWATER_ROCKY or (ground1 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground1 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground1 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave"))or (ground1 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground1 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground2 == GROUND.UNDERWATER_SANDY or ground2 == GROUND.UNDERWATER_ROCKY or (ground2 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground2 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground2 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave"))or (ground2 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground2 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground3 == GROUND.UNDERWATER_SANDY or ground3 == GROUND.UNDERWATER_ROCKY or (ground3 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground3 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground3 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave"))or (ground3 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground3 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground4 == GROUND.UNDERWATER_SANDY or ground4 == GROUND.UNDERWATER_ROCKY or (ground4 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground4 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground4 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave"))or (ground4 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground4 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end



	-- Oxygen loss only occurs while underwater
	if not naagua then		
		self.rate = 0
		self.current = self.max	
		return
	end
	
	-- No oxygen loss if you don't breathe
--	if self.inst:HasTag("robot") or self.inst:HasTag("waterbreather") then
--		return
--	end

	-- Hook for external shenanigans
    if self.redirect then
        self.redirect(self.inst, delta, overtime)
        return
    end
	
	
    if self.inst:HasTag("respire") then	
	delta = 10 
	self.inst:RemoveTag("respire")
	end
	
	

    if self.ignore then return end

	-- Update values
    local old = self.current

    self.current = self.current + delta
    if self.current < 0 then 
        self.current = 0
    elseif self.current > self:GetMax() then
        self.current = self:GetMax()
    end
    
    local oldpercent = old/self.max
    local newpercent = self.current/self.max
    
    self.inst:PushEvent("oxygendelta", {oldpercent = oldpercent, newpercent = newpercent, overtime=overtime})
	
	-- Drowning!
	if old > 0 and self.current <= 0 then
        self.inst:PushEvent("startdrowning")
    elseif old <= 0 and self.current > 0 then
        self.inst:PushEvent("stopdrowning")
    end
	
	-- Running out of oxygen!
	if (newpercent > UW_TUNING.OXYGEN_THRESH) ~= (oldpercent > UW_TUNING.OXYGEN_THRESH) then
		if newpercent <= UW_TUNING.OXYGEN_THRESH then
			self.inst:PushEvent("runningoutofoxygen")
		end
	end	
end

function Oxygen:OnUpdate(dt)
	-- Recalculate
	self:Recalc(dt)
	
	-- Drowning!
	if self:IsDrowning() and self.inst.components.health and not self.inst.components.health:IsDead() and self.burning then
		self.inst.components.health:DoDelta(-self.hurtrate*dt, true, "drowning")
	end

end

function Oxygen:Recalc(dt)
	
	if not self.burning then
		return
	end
	
	local loss_delta = UW_TUNING.OXYGEN_LOSS_RATE
	local oxygen_supply = self.oxygen_supply or 0
	
	-- Oxygen suppliers items
local equipamento3 = self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
local equipamento4 = self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.NECK)
local equipamento5 = self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)

if equipamento3 and equipamento3.prefab == "pearl_amulet" then oxygen_supply = oxygen_supply + 8 end
if equipamento4 and equipamento4.prefab == "pearl_amulet" then oxygen_supply = oxygen_supply + 8 end
if equipamento5 and equipamento5.prefab == "pearl_amulet" then oxygen_supply = oxygen_supply + 8 end
	
	
	local supply_delta = oxygen_supply*UW_TUNING.OXYGEN_AIRINESS
	
	-- Oxygen supplying / removing environmental objects / monsters
	local aura_delta = 0
	local x,y,z = self.inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, UW_TUNING.OXYGEN_EFFECT_RANGE, {"oxygen_aura"})
    for k,v in pairs(ents) do 
		if v.components.oxygenaura and v ~= self.inst then
			local distsq = self.inst:GetDistanceSqToInst(v)
			local aura_val = v.components.oxygenaura:GetAura(self.inst)/math.max(1, distsq)
			aura_delta = aura_delta + aura_val
		end
    end

	-- Final rate of oxygen gain / loss
	self.rate = (supply_delta + loss_delta + aura_delta)	
	
	-- Custom rate adjustment
	if self.custom_rate_fn then
		self.rate = self.rate + self.custom_rate_fn(self.inst)
	end
	
	-- Reduce rate loss if wearing oxygen apparatus
	if self.rate < 0 then

	local equipamento = self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
	local equipamento2 = self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)	


if equipamento and equipamento.prefab == "hat_submarine" then self.rate = self.rate * (1 - 0.95) end
if equipamento and equipamento.prefab == "snorkel" then self.rate = self.rate * (1 - 0.5) end
if equipamento2 and equipamento2:HasTag("diving_suit") then self.rate = self.rate * (1 - 0.5) end

	
end
	
	-- No oxygen loss if you don't breathe
--	if self.inst:HasTag("robot") or self.inst:HasTag("waterbreather") then
--		self.rate = 0
--		return
--	end
	
	self:DoDelta(self.rate*dt, true)
end

function Oxygen:LongUpdate(dt)
	self:OnUpdate(dt)
end

return Oxygen