require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/attackwall"
require "behaviours/panic"
require "behaviours/minperiod"
require "behaviours/standstill"
require "giantutils"

local BossBoarte = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local SEE_DIST = 30
local CHASE_DIST = 32
local CHASE_TIME = 20
local arsq = 7 * 7
local wwRadius = 5
local wwTargetNeed = 2
local wwcd = 12
local gbcd = 12

local function GetHomePos(inst)
    local home = GetHome(inst)
    return home ~= nil and home:GetPosition() or nil
end

local function GetWanderPoint(inst)
    local target = inst.components.knownlocations:GetLocation("spawnpoint")
    return target ~= nil and target:GetPosition() or nil
end

local function ShouldGroundBurn(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	return GetTime() - inst.lastGroundBurn > gbcd
		and #FindPlayersInRangeSq(x, y, z, 400, true) ~= 0
end

local function ShouldWhirlWind(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	return GetTime() - inst.lastWirlWind > wwcd
		and #TheSim:FindEntities(x, y, z, wwRadius, { "_combat" }, { "INLIMBO" }) > wwTargetNeed
end

local function ShouldPreformCombo(inst)
	return inst.components.combat.target
		and inst:GetDistanceSqToInst(inst.components.combat.target) <= arsq + 4
		and GetTime() - inst.lastCombo > inst:CalculateComboCD()
end

local function ShouldGroundSlam(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	return GetTime() - inst.lastGroundSlam > inst:CalculateGroundSlamCD()
		and IsAnyPlayerInRange(x, y, z, 12, true) 
end


function BossBoarte:OnStart()
    
    local root = PriorityNode(
    {
		--WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst) ),
		ChaseAndAttack(self.inst, CHASE_TIME, CHASE_DIST),
		ParallelNode{
            SequenceNode{
                WaitNode(10),
                ActionNode(function() self.inst:SetEvaded() end),
            },
            Wander(self.inst, GetWanderPoint, 5),
        },

		StandStill(self.inst, function() return true end),
    }, .25)
    
    self.bt = BT(self.inst, root)
    
end

return BossBoarte