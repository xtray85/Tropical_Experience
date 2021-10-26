
local RowboatWakeSpawner = Class(function(self, inst)
    self.inst = inst
    self.timeSinceSpawn = 0
    self.spawning = false
    self.spawnPeriod = 0.2
    self.lastWake = nil 
end)


function RowboatWakeSpawner:StartSpawning()
    self.inst:StartUpdatingComponent(self)
    self.spawning = true 
    self.timeSinceSpawn = self.spawnPeriod --So that one gets spawned as soon as the boat starts moving 
end 

function RowboatWakeSpawner:StopSpawning()
    self.inst:StopUpdatingComponent(self)
    self.spawning = false 
end 

function RowboatWakeSpawner:OnUpdate(dt)
    if self.lastWake then  --Hacky way to fix the animation facing the wrong direction for one frame
        self.lastWake:Show()
        self.lastWake = nil 
    end 

    if self.spawning then 
        self.timeSinceSpawn = self.timeSinceSpawn + dt
        if self.timeSinceSpawn > self.spawnPeriod then 
            local wake = SpawnPrefab( "rowboat_wake")
            local x, y, z = self.inst.Transform:GetWorldPosition()
            wake.Transform:SetPosition( x, y, z )
            wake.Transform:SetRotation(self.inst.Transform:GetRotation())
            self.lastWake = wake
            wake:Hide() --Hide for a frame, hacky fix 
            self.timeSinceSpawn = 0
        end 
    end 
end




return RowboatWakeSpawner
