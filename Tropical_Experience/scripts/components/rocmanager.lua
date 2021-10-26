
local SPAWNDIST = 40
local TESTTIME = 100 --TUNING.SEG_TIME*4

local Rocmanager = Class(function(self, inst)
	self.disabled = false
	self.inst = inst
	self.inst:DoPeriodicTask(TESTTIME,function() self:ShouldSpawn() end) -- 
	self.roc = nil
	self.nexttime = self:GetNextSpawnTime()
	self._activeplayers = {}		

	
local function OnPlayerJoined(src, player)
    for i, v in ipairs(self._activeplayers) do
        if v == player then
            return
        end
    end
    table.insert(self._activeplayers, player)
end

local function OnPlayerLeft(src, player)
    for i, v in ipairs(self._activeplayers) do
        if v == player then
            table.remove(self._activeplayers, i)
            return
        end
    end
end

--------------------------------------------------------------------------
--[[ Initialization ]]
--------------------------------------------------------------------------

--Initialize variables
for i, v in ipairs(AllPlayers) do
    table.insert(self._activeplayers, v)
end

--Register events
inst:ListenForEvent("ms_playerjoined", OnPlayerJoined, TheWorld)
inst:ListenForEvent("ms_playerleft", OnPlayerLeft, TheWorld)	
end)

function Rocmanager:OnSave()	
	local refs = {}
	local data = {}
	data.disabled = self.disabled
	data.nexttime = self.nexttime
	return data, refs
end 

function Rocmanager:OnLoad(data)

	if data.disabled then
		self.disabled = data.disabled
	end
	if data.nexttime then
		self.nexttime = data.nexttime
	end
end
function Rocmanager:RemoveRoc(inst)
	if self.roc == inst then 
		self.roc = nil
	end
end

function Rocmanager:GetNextSpawnTime()
	return (TUNING.TOTAL_DAY_TIME * 10)  + (math.random() * TUNING.TOTAL_DAY_TIME * 10)
end

function Rocmanager:ShouldSpawn()
	if self.disabled then
		return
	end

	-- will only spawn before the first half of daylight. 
	if not self.roc and TheWorld.state.isday then --clock:GetNormTime() < (clock.daysegs / 16) /2 then 

		-- do test stuff.
		if self.nexttime <= 0 then
		
    for i, v in ipairs(self._activeplayers) do
			
		if v ~= nil then
		local px,py,pz = v.Transform:GetWorldPosition()
		local ground = GetWorld()
		local tile = ground.Map:GetTileAtPoint(px, py, pz)
		if tile ~= GROUND.IMPASSABLE or tile ~= GROUND.INVALID then
			local pt= Vector3(v.Transform:GetWorldPosition())
			local angle = math.random()* 2*PI
			local offset = Vector3(SPAWNDIST * math.cos( angle ), 0, -SPAWNDIST * math.sin( angle ))
			local roc = SpawnPrefab("roc")
			roc.Transform:SetPosition(pt.x+offset.x,0,pt.z+offset.z)
			self.roc = roc
			self.nexttime = self:GetNextSpawnTime()	
		end	
		end	
		
    end			
		else
			self.nexttime = self.nexttime - TESTTIME
		end
	end
end

function Rocmanager:LongUpdate(dt)
	self.nexttime = self.nexttime - dt
end

function Rocmanager:OnUpdate(dt)

end

return Rocmanager