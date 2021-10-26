local TileTracker = Class(function(self, inst)
	self.inst = inst
	self.tile = nil
	self.tileinfo = nil
	self.ontilechangefn = nil
	self.onwater = nil
	self.onwaterchangefn = nil
end)

-- function TileTracker:OnEntitySleep()
-- end

-- function TileTracker:OnEntityWake()
-- end

function TileTracker:Start()
	self.inst:StartUpdatingComponent(self)
end

function TileTracker:Stop()
	self.inst:StopUpdatingComponent(self)
end

local function IsWater(tile, inst)
local x, y, z = inst.Transform:GetWorldPosition()
	return TheWorld.Map:IsOceanTileAtPoint(x, y, z) and TheWorld.Map:GetPlatformAtPoint(x, z) == nil
end

function TileTracker:OnUpdate(dt)
local map = TheWorld.Map


local ex, ey, ez = self.inst.Transform:GetWorldPosition()
if TheWorld.Map:IsOceanTileAtPoint(ex, ey, ez)  and TheWorld.Map:GetPlatformAtPoint(ex, ez) == nil then
if self.barreira == nil then
self.inst.Physics:ClearCollidesWith(COLLISION.LIMITS)
self.barreira = true
end 
end


if not TheWorld.Map:IsOceanTileAtPoint(ex, ey, ez)  and TheWorld.Map:GetPlatformAtPoint(ex, ez) == nil then
if self.barreira ~= nil then
self.inst.Physics:CollidesWith(COLLISION.LIMITS)
self.barreira = nil
end 
end



local tile, tileinfo = self.inst:GetCurrentTileType()

	if tile then --and tile ~= self.tile then
		self.tile = tile
		if self.ontilechangefn then
			self.ontilechangefn(self.inst, tile, tileinfo)
		end

		if self.onwaterchangefn or self.inst:HasTag("amphibious") then
			-- local onwater = GetWorld().Map:IsWater(tile)
local onwater = IsWater(tile , self.inst)
			
if onwater ~= self.onwater then
				if self.onwaterchangefn then 
					self.onwaterchangefn(self.inst, onwater)
				end 
--				if self.inst:HasTag("amphibious") then 
--					if onwater then 
--						self.inst:AddTag("aquatic")
--					else
--						self.inst:RemoveTag("aquatic")
--					end 
--				end 
			end
self.onwater = onwater
end
end
end

function TileTracker:SetOnTileChangeFn(fn)
	self.ontilechangefn = fn
end

function TileTracker:SetOnWaterChangeFn(fn)
	self.onwaterchangefn = fn
end

return TileTracker
