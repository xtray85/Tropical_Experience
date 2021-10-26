require("constants")

local easing = require("easing")

local function spawnCloudPuff(x, y, z)
	local cloudpuff = SpawnPrefab( "cloudpuff" )
	cloudpuff.Transform:SetPosition( x, y, z )
end

local function isSky(map, x, y, z)
	return (GROUND.IMPASSABLE == map:GetTileAtPoint(x, y, z)) and
           (GROUND.IMPASSABLE == map:GetTileAtPoint(x + 1.0, y, z)) and
           (GROUND.IMPASSABLE == map:GetTileAtPoint(x - 1.0, y, z)) and
           (GROUND.IMPASSABLE == map:GetTileAtPoint(x, y, z + 1.0)) and
           (GROUND.IMPASSABLE == map:GetTileAtPoint(x, y, z - 1.0))
end

local CloudPuffManager = Class(function(self, inst)
	self.inst = inst

	self.cloudpuff_per_sec = 3 ---mudei
	self.cloudpuff_spawn_rate = 3 -------mudei

	self.inst:StartUpdatingComponent(self)
end)

local function getCloudPuffRadius()
	-- From values from camera_volcano.lua, camera range 30 to 100
	local percent = (TheCamera:GetDistance() - 30) / (70)
	local row_radius = (24 - 16) * percent + 16
	local col_radius = (8 - 2) * percent + 2

	return row_radius, col_radius
end

function CloudPuffManager:OnUpdate(dt)
	local map = TheWorld.Map
	if map == nil then
		return
	end
	
	
for i, v in ipairs(AllPlayers) do
	local px, py, pz = v.Transform:GetWorldPosition()

	self.cloudpuff_spawn_rate = self.cloudpuff_spawn_rate + self.cloudpuff_per_sec * dt

	local radius = getCloudPuffRadius()

	while self.cloudpuff_spawn_rate > 10.0 do
		local dx, dz = radius * UnitRand(), radius * UnitRand()
		local x, y, z = px + dx, py, pz + dz

		if isSky(map, x, y, z) then
			spawnCloudPuff(x, y, z)
		end

		self.cloudpuff_spawn_rate = self.cloudpuff_spawn_rate - 1.0
	end
end	

end

return CloudPuffManager
