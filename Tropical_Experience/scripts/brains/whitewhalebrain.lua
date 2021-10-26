require "behaviours/wander"
require "behaviours/chaseandattack"


local LEASH_RETURN_DIST = 5
local LEASH_MAX_DIST = 10

local wander_times =
{
	minwalktime = 4,
	randwalktime = 4,
	minwaittime = 4,
	randwaittime = 3,
}

local	    WHALE_WHITE_CHASE_DIST = 40
local	    WHALE_WHITE_FOLLOW_TIME = 90

local WhiteWhaleBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

function WhiteWhaleBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()), true)
end

function WhiteWhaleBrain:OnStart()
local map = TheWorld.Map
local x, y, z = self.inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))	
	local root = PriorityNode(
	{
		SequenceNode{
            ConditionNode(function() 
	            if ground == GROUND.OCEAN_COASTAL then
	            	self.inst.hitshallow = true
	            end
	            return ground == GROUND.OCEAN_COASTAL or self.inst.hitshallow
	        end, "HitShallow"),

            ParallelNodeAny {
                WaitNode(15+math.random()*2),
                Leash(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, LEASH_MAX_DIST, LEASH_RETURN_DIST),
            },
            DoAction(self.inst, function() self.inst.hitshallow = nil end ),
        },

		ChaseAndAttack(self.inst, WHALE_WHITE_FOLLOW_TIME, WHALE_WHITE_CHASE_DIST),
		Wander(self.inst, nil, nil, wander_times)
	}, .25)
	
	self.bt = BT(self.inst, root)
end

return WhiteWhaleBrain
