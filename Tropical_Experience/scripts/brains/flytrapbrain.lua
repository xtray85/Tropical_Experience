require "behaviours/wander"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/attackwall"
require "behaviours/minperiod"
require "behaviours/faceentity"
require "behaviours/doaction"
require "behaviours/standstill"

local FlytrapBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

local SEE_FOOD_DIST = 10


local function EatFoodAction(inst)
    local target = FindEntity(inst,
        SEE_FOOD_DIST,
        function(item)
            return inst.components.eater:CanEat(item)
                and item:IsOnValidGround()
                and item:GetTimeAlive() > TUNING.SPIDER_EAT_DELAY
        end,
        nil,
        { "outofreach" }
    )
    return target ~= nil and BufferedAction(inst, target, ACTIONS.EAT) or nil
end

function FlytrapBrain:OnStart()
	
	local root = PriorityNode(
	{
		WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst) ),

		DoAction(self.inst, function() return EatFoodAction(self.inst) end ),
		
		ChaseAndAttack(self.inst, 10),
        StandStill(self.inst),
		--Wander(self.inst, function() return self.inst:GetPosition() end, 15),

	}, .25)
	
	self.bt = BT(self.inst, root)
	
end

return FlytrapBrain
