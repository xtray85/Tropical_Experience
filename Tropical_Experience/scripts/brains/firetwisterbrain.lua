require "behaviours/chaseandattack"
require "behaviours/wander"

local fireTwisterBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetHomePos(inst)
    return inst.components.knownlocations:GetLocation("spawnpoint")
end

function fireTwisterBrain:OnStart()
    local root = PriorityNode(
    {
        ChaseAndAttack(self.inst),
        Wander(self.inst, GetHomePos, 35),
    }, .1)

    self.bt = BT(self.inst, root)
end

function fireTwisterBrain:OnInitializationComplete()
    local pos = self.inst:GetPosition()
    pos.y = 0
    self.inst.components.knownlocations:RememberLocation("spawnpoint", pos, true)
end

return fireTwisterBrain
