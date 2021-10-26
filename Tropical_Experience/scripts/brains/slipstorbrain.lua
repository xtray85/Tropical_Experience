require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/attackwall"

local SEE_PLAYER_DIST = 5
local MAX_CHASE_TIME = 20
local MAX_CHASE_DIST = 25


local SlipstorBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function SlipstorBrain:OnStart()
    local root =
        PriorityNode(
        {
		WhileNode(function() return self.inst.components.hauntable ~= nil and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
            ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST))),
			AttackWall(self.inst),
            ChaseAndAttack(self.inst),
            Wander(self.inst)            
        },1)
    
    self.bt = BT(self.inst, root)
end

return SlipstorBrain