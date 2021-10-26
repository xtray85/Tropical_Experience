require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/chattynode"

local SEE_PLAYER_DIST = 5
local SEE_FOOD_DIST = 10
local MAX_WANDER_DIST = 15
local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 20
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8
local fishtime = 1000

local AVOID_PLAYER_DIST = 3
local AVOID_PLAYER_STOP = 6
local STOP_RUN_DIST = 10

local GoatmumBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GoHomeAction(inst)
    if inst.components.combat.target ~= nil then
        return
    end
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home ~= nil
        and home:IsValid()
        and not (home.components.burnable ~= nil and home.components.burnable:IsBurning())
        and not home:HasTag("burnt")
        and BufferedAction(inst, home, ACTIONS.GOHOME)
        or nil
end

local function GetFaceTargetFn(inst)
    return FindClosestPlayerToInst(inst, SEE_PLAYER_DIST, true)
end

local function KeepFaceTargetFn(inst, target)
    return target:IsValid() and inst:IsNear(target, SEE_PLAYER_DIST)
end

local function ShouldGoHome(inst)
    if not TheWorld.state.isday then
        return false
    end
    --one merm should stay outside
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home == nil
        or home.components.childspawner == nil
        or home.components.childspawner:CountChildrenOutside() > 1
end

local function IsHomeOnFire(inst)
    return inst.components.homeseeker
        and inst.components.homeseeker.home
        and inst.components.homeseeker.home.components.burnable
        and inst.components.homeseeker.home.components.burnable:IsBurning()
end

function GoatmumBrain:OnStart(inst)
    local root = PriorityNode(
    {
--        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
--        RunAway(self.inst, "scarytoprey", AVOID_PLAYER_DIST, AVOID_PLAYER_STOP),
--        RunAway(self.inst, "scarytoprey", SEE_PLAYER_DIST, STOP_RUN_DIST, nil, true),				
				
				
       WhileNode(function() return self.inst.components.hauntable ~= nil and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
--        WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
--            ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST))),
--        WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
--            RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
        WhileNode( function() return IsHomeOnFire(self.inst) end, "HomeOnFire", Panic(self.inst)),
        WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
        DoAction(self.inst, GoHomeAction, "Go Home", true)),
--        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
    }, 0.25)

    local IsIdle =
    PriorityNode(
    {
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
    }, 0.25)

   
    self.bt = BT(self.inst, root)
end

return GoatmumBrain
