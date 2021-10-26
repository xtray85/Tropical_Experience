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

local BeetletaurBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetHealAuras(inst, range)
    local pos = inst:GetPosition()
    local range = range or 8
    local heal_auras = TheSim:FindEntities(pos.x, 0, pos.z, range, {"healingcircle"})
    if heal_auras then
        table.sort(heal_auras, function(a,b)
            local a_distance_sq = distsq(a:GetPosition(), pos)
            local b_distance_sq = distsq(b:GetPosition(), pos)
            return a_distance_sq <= b_distance_sq
        end)
    end
    return heal_auras
end

local function GetNoBusyTags(inst)
	return not (inst.sg:HasStateTag("attack") or inst.sg:HasStateTag("frozen") or inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("busy"))
end

local function ShouldChaseAndAttack(inst)
    return true
end

local function AvoidHealAuras(inst)
    return inst.avoid_heal_auras and GetHealAuras(inst)
end

local behaviour_values = {
    chaseandattack_condition_fn = ShouldChaseAndAttack,
    wander_condition_fn = ShouldChaseAndAttack,
    findavoidanceobjectsfn = AvoidHealAuras,
    avoid_dist = 4,
}

local function GetWanderPoint(inst)
    local target = inst.components.knownlocations:GetLocation("spawnpoint")
    return target ~= nil and target:GetPosition() or nil
end

function BeetletaurBrain:OnStart()
    
    local root = PriorityNode(
    {
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

return BeetletaurBrain
