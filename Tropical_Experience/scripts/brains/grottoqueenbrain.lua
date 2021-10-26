require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"

local SEE_PLAYER_DIST = 5
local SEE_FOOD_DIST = 10
local MAX_WANDER_DIST = 15
local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 20
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8

local GrottoqueeBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetHomePos(inst)
    return inst.components.knownlocations:GetLocation("home") or nil
end

local function GetFaceTargetFn(inst)
    return FindClosestPlayerToInst(inst, SEE_PLAYER_DIST, true)
end

local function KeepFaceTargetFn(inst, target)
    return target:IsValid() and inst:IsNear(target, SEE_PLAYER_DIST)
end

function GrottoqueeBrain:OnStart()
    local root = PriorityNode(
    {
--        WhileNode(function() return self.inst.components.hauntable ~= nil and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
--        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
--        WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
--            ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST))),
--        WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
--            RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
--        WhileNode( function() return IsHomeOnFire(self.inst) end, "HomeOnFire", Panic(self.inst)),
--        WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
--            DoAction(self.inst, GoHomeAction, "Go Home", true)),
--        DoAction(self.inst, EatFoodAction, "Eat Food"),
        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
    }, .25)

    self.bt = BT(self.inst, root)
end

return GrottoqueeBrain
