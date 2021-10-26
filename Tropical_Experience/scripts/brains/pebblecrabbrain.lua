require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/leash"

local MAX_WANDER_DIST = 15
local WAIT_PERIOD = 10
local STOP_RUN_DIST = 10
local SEE_PLAYER_DIST = 5
local AVOID_PLAYER_DIST = 3
local AVOID_PLAYER_STOP = 6
local SEE_BAIT_DIST = 15

local function GetHomePos(inst)
    return inst.components.knownlocations:GetLocation("home") or nil
end

local function GoHomeAction(inst)
    if inst.components.homeseeker and 
       inst.components.homeseeker.home and 
       inst.components.homeseeker.home:IsValid() and
	   inst.sg:HasStateTag("trapped") == false then
        return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function ShowAction(inst)
    if inst.sg:HasStateTag("trapped") == false then
        return BufferedAction(inst, nil, ACTIONS.SHOWCRAB)
    end
end

local function HideAction(inst)
    if inst.sg:HasStateTag("trapped") == false then
        return BufferedAction(inst, nil, ACTIONS.HIDECRAB)
    end
end

local function TakeBaitAction(inst)
    local target = FindEntity(inst, SEE_BAIT_DIST, function(item) return inst.components.eater:CanEat(item) end, nil, {"outofreach"})
   
	if target and inst.isunder == nil then
        local act = BufferedAction(inst, target, ACTIONS.EAT)
		
        return act
    end
end

local PebbleCrabBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

function PebbleCrabBrain:OnStart()
	local root =

	PriorityNode(
	{
		WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        WhileNode( function() return FindClosestPlayerToInst(self.inst, 6, true) end, "OnSeePlayer", 
			DoAction(self.inst, HideAction, "go hide")),
        WhileNode( function() return not FindClosestPlayerToInst(self.inst, 12, true) and self.inst.isunder end, "OnNoPlayer", 
			DoAction(self.inst, ShowAction, "emerge")),
		DoAction(self.inst, TakeBaitAction, "take bait", false),
		Wander(self.inst, GetHomePos, MAX_WANDER_DIST),
	}, 0.5)
	self.bt = BT(self.inst, root)
end

return PebbleCrabBrain
