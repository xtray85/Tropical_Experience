require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/chattynode"

local BrainCommon = require "brains/braincommon"

local START_FACE_DIST = 6
local KEEP_FACE_DIST = 8
local GO_HOME_DIST = 10
local MAX_WANDER_DIST = 8
local MAX_CHASE_TIME = 25
local MAX_CHASE_DIST = 30
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8

local function GoHomeAction(inst)
    if inst.components.combat.target ~= nil then
        return
    end
    local homePos = inst.components.knownlocations:GetLocation("home")
    return homePos ~= nil
        and BufferedAction(inst, nil, ACTIONS.WALKTO, nil, homePos)
        or nil
end

local function AddFuelAction(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    if home ~= nil and home.components.fueled:GetCurrentSection() <= 1 then
        local fuel = inst.components.inventory:FindItem(function(item) return item.prefab == "pigtorch_fuel" end)
        if fuel == nil then
            fuel = SpawnPrefab("pigtorch_fuel")
            if fuel ~= nil then
                inst.components.inventory:GiveItem(fuel)
            end
        end
        return fuel ~= nil
            and BufferedAction(inst, home, ACTIONS.ADDFUEL, fuel)
            or nil
    end
end

local function FindFoodAction(inst)
    if inst.components.inventory ~= nil and inst.components.eater ~= nil then
        local target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        return target ~= nil
            and BufferedAction(inst, target, ACTIONS.EAT)
            or nil
    end
end

local function MindcontrolAction(inst)
 
return BufferedAction(inst, nil, ACTIONS.DIG) or nil

end

local function GetFaceTargetFn(inst)
    local target = FindClosestPlayerToInst(inst, START_FACE_DIST, true)
    return target ~= nil and not target:HasTag("notarget") and target or nil
end

local function KeepFaceTargetFn(inst, target)
    return not target:HasTag("notarget") and inst:IsNear(target, KEEP_FACE_DIST)
end

local function ShouldGoHome(inst)
    local homePos = inst.components.knownlocations:GetLocation("home")
    return homePos ~= nil and inst:GetDistanceSqToPoint(homePos:Get()) > GO_HOME_DIST * GO_HOME_DIST
end

local wildbeaverguardbrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function wildbeaverguardbrain:OnStart()
    local root = PriorityNode(
    {
        BrainCommon.PanicWhenScared(self.inst, .2, "PIG_TALK_PANICBOSS"),
        WhileNode(function() return self.inst.components.hauntable ~= nil and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        ChattyNode(self.inst, "PIG_GUARD_TALK_FIGHT",
            WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
                ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST)))),
        ChattyNode(self.inst, "PIG_GUARD_TALK_FIGHT",
            WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() and math.random(1,4) > 1 end, "Dodge",
                RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST))),
				
				
        ChattyNode(self.inst, "PIG_GUARD_TALK_FIGHT",
            WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() and math.random(1,10) == 1 end, "Mind",
				DoAction(self.inst, function() return MindcontrolAction(self.inst) end))),				
				
				
				
        WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
        ChattyNode(self.inst, "PIG_GUARD_TALK_GOHOME",
            DoAction(self.inst, GoHomeAction, "Go Home", true))),
        ChattyNode(self.inst, "PIG_TALK_FIND_MEAT",
            DoAction(self.inst, function() return FindFoodAction(self.inst) end)),
        ChattyNode(self.inst, "PIG_GUARD_TALK_TORCH",
            DoAction(self.inst, AddFuelAction, "Add Fuel", true)),
        ChattyNode(self.inst, "PIG_GUARD_TALK_LOOKATWILSON",
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn)),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST)
    }, .25)

    self.bt = BT(self.inst, root)
end

return wildbeaverguardbrain
