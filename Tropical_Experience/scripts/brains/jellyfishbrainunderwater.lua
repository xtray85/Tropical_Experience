require "behaviours/wander"
require "behaviours/migrate"

local MAX_WANDER_DIST = 40


local JellyfishBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)


function JellyfishBrain:OnInitializationComplete()
--      self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()), true)
 end

function JellyfishBrain:OnStart()
    local migrationMgr = TheWorld.components.underwatermigration
    
    local root = PriorityNode(
    {
        WhileNode(function() return migrationMgr and migrationMgr:IsMigrationActive() end, "Migrating",
                PriorityNode({
                    Migrate(self.inst, function() return self.inst.components.knownlocations:GetLocation("migration") end),
                    Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("migration") end, MAX_WANDER_DIST * 0.25)
                }, 1)
            ),	
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST)
    }, .25)
    self.bt = BT(self.inst, root)
end

return JellyfishBrain
