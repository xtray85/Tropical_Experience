require "behaviours/standandattack"

local TFWPElementalBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

function TFWPElementalBrain:OnStart()
	
	local root = PriorityNode(
	{
		StandAndAttack(self.inst),
	}, .25)
	
	self.bt = BT(self.inst, root)
	
end

return TFWPElementalBrain
