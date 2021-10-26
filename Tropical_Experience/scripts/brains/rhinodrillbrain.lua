require "behaviours/chaseandattack"
require "behaviours/faceentity"
require "behaviours/follow"
require "behaviours/wander"
require "behaviours/rhinocebrobuff_forge"
require "behaviours/doaction"
require "behaviours/maintaindistance"

local MOB_MAX_CHASE_TIME = 8
local MAX_WANDER_DISTANCE = 5
local CHEER_MIN_DISTANCE = 6
local CHEER_MAX_DISTANCE = 8
local CHASE_DIST = 32
local CHASE_TIME = 20

local RhinodrillBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function ReviveAction(inst)
    if inst.bro and inst.bro.sg and inst.bro:HasTag("corpse") then
        return BufferedAction(inst, inst.bro, ACTIONS.REVIVE_CORPSE)
    end
end

local function IsBroDead(inst)
	return inst.bro and inst.bro.components.health and inst.bro.components.health:IsDead()
end

local function IsBusy(inst)
    return inst.sg:HasStateTag("busy")
end

local function GetBro(inst)
    return inst.bro
end

local function StartCheer(inst)
    if inst.cheer_ready and not IsBroDead(inst) and not IsBusy(inst) then
        inst:PushEvent("startcheer")
        return true
    end
    return false
end

local function ShouldChaseAndAttack(inst)
    return (not inst.bro or not IsBroDead(inst))
end

local function ShouldWander(inst)
    return not IsBroDead(inst)
end

local behavior_values = {
    chaseandattack_condition_fn = ShouldChaseAndAttack,
    wander_condition_fn = ShouldWander,
}

local function GetWanderPoint(inst)
    local target = inst.components.knownlocations:GetLocation("spawnpoint")
    return target ~= nil and target:GetPosition() or nil
end

function RhinodrillBrain:OnStart()
    
    local root = PriorityNode(
    {
		WhileNode(function() return self.inst.bro and self.inst.bro.sg and self.inst.bro:HasTag("corpse") and not self.inst.sg:HasStateTag("reviving") and not self.inst.sg:HasStateTag("knockback") end, "Reviving Bro", DoAction(self.inst, ReviveAction)),
        WhileNode(function() return not IsBroDead(self.inst) and self.inst.cheer_ready and not IsBusy(self.inst) end, "Bro Cheering", MaintainDistance(self.inst, GetBro, CHEER_MIN_DISTANCE, CHEER_MAX_DISTANCE, StartCheer)),
		ChaseAndAttack(self.inst, CHASE_TIME, CHASE_DIST),
		ParallelNode{
            SequenceNode{
                WaitNode(5),
            },
            Wander(self.inst, GetWanderPoint, 5),
        },		
		StandStill(self.inst, function() return true end),
    }, .25)
    self.bt = BT(self.inst, root)
end

return RhinodrillBrain
