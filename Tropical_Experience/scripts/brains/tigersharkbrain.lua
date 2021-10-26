require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/chaseandram"
require "behaviours/chaseandattack"

local MAX_IDLE_WANDER_DIST = 40

local MAX_CHASE_TIME = 10
local GIVE_UP_DIST = 20
local MAX_CHARGE_DIST = 60

local DO_ACTIONS_DISTANCE = 30

local FOOD_TAGS = {"edible"}
local NO_TAGS = {"FX", "NOCLICK", "DECOR", "INLIMBO", "kittenchow"}

local GO_HOME_DIST = 10

local RUN_AWAY_DIST = 6
local STOP_RUN_AWAY_DIST = 4

local SEE_FOOD_DIST = 80

local TigersharkBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local wandertimes =
{
    minwalktime = 6,
    randwalktime =  6,
    minwaittime = 5,
    randwaittime = 5,
}

--[[
    intended behaviour cases:

    -defend children from baddies
        -aggressive if player is near home
    -feed children
        -drop food near them
    -hunt prey near player
        -after doing something near the player, return home
--]]

local function GoHomeAction(inst)
    if inst.components.combat.target == nil then
        return
    end
    local homePos = inst.components.knownlocations:GetLocation("home")
    return homePos ~= nil
        and BufferedAction(inst, nil, ACTIONS.WALKTO, nil, homePos)
        or nil
end

local function ShouldGoHome(inst)
    local homePos = inst.components.knownlocations:GetLocation("home")
    return homePos ~= nil and inst:GetDistanceSqToPoint(homePos:Get()) > GO_HOME_DIST * GO_HOME_DIST
end

local function ShouldFindFood(inst)
	local comida = GetClosestInstWithTag("meat", inst, 60)
    return comida
end

--local function FindFoodAction(inst)
--    if inst.components.inventory ~= nil and inst.components.eater ~= nil then
--        local target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
--        return target ~= nil
--            and BufferedAction(inst, target, ACTIONS.EAT)
--            or nil
--    end
--end

local function FeedChildrenAction(inst)
    --If you are holding some food and your children are nearby
    --Go over to them and drop the food.

    if GetTime() < inst.NextFeedTime or inst.components.combat.target ~= nil then
        return
    end

    local kittenHerd = inst:FindSharkHome()

    if kittenHerd and inst:GetPosition():Dist(kittenHerd:GetPosition()) < 40 then --children are nearby
        if kittenHerd.components.childspawner:CountChildrenOutside() > 0 then
            inst.NextFeedTime = GetTime() + 30
            return BufferedAction(inst, kittenHerd, ACTIONS.TIGERSHARK_FEED)
        end
    end
end

local function FindFoodAction(inst)
    if inst:HasTag("aquatic") then
        return
    end

    if inst.components.inventory ~= nil and inst.components.eater ~= nil then
        local target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        if target ~= nil then
            return BufferedAction(inst, target, ACTIONS.EAT)
        end
    end

    local time_since_eat = inst.components.eater:TimeSinceLastEating()
    if time_since_eat ~= nil and time_since_eat <= TUNING.PIG_MIN_POOP_PERIOD * 2 then
        return
    end

    local noveggie = time_since_eat ~= nil and time_since_eat < TUNING.PIG_MIN_POOP_PERIOD * 4

    local target = FindEntity(inst,
        SEE_FOOD_DIST,
        function(item)
            return item:GetTimeAlive() >= 8
                and item.prefab ~= "mandrake"
				and item.prefab ~= "seeds"
                and item.components.edible ~= nil
 --               and (not noveggie or item.components.edible.foodtype == FOODTYPE.MEAT)
                and item:IsOnValidGround()
                and inst.components.eater:CanEat(item)
        end,
        nil,
        { "outofreach" }
    )
    if target ~= nil then
        return BufferedAction(inst, target, ACTIONS.EAT)
    end

    target = FindEntity(inst,
        SEE_FOOD_DIST,
        function(item)
            return item.components.shelf ~= nil
                and item.components.shelf.itemonshelf ~= nil
                and item.components.shelf.cantakeitem
                and item.components.shelf.itemonshelf.components.edible ~= nil
--                and (not noveggie or item.components.shelf.itemonshelf.components.edible.foodtype == FOODTYPE.MEAT)
                and item:IsOnValidGround()
                and inst.components.eater:CanEat(item.components.shelf.itemonshelf)
        end,
        nil,
        { "outofreach" }
    )
    if target ~= nil then
        return BufferedAction(inst, target, ACTIONS.TAKEITEM)
    end
end

local function GetWanderPoint(inst)
    if inst.components.knownlocations and inst.components.knownlocations:GetLocation("point_of_interest") then
        return inst.components.knownlocations:GetLocation("point_of_interest")
    end

--    if inst:FindSharkHome() and inst:GetPosition():Dist(inst:FindSharkHome():GetPosition()) < 40 then
--        return inst:FindSharkHome():GetPosition()
--    end

    return inst:GetPosition()
end

function TigersharkBrain:OnStart()
    local root = PriorityNode(
    {
		WhileNode(function() return ShouldFindFood(self.inst) end, "FindFood",
                DoAction(self.inst, FindFoodAction )),	
	        ChattyNode(self.inst, "PIG_GUARD_TALK_FIGHT",
            WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
                ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHARGE_DIST)))),
        ChattyNode(self.inst, "PIG_GUARD_TALK_FIGHT",
            WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() and math.random(1,4) > 2 end, "Dodge",
                RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST))),
	
--StalkerChaseAndAttack(self.inst)
        ---- Combat Actions ----
 --       WhileNode(function() return self.inst.CanRun and self.inst.components.combat.target and
 --       (distsq(self.inst:GetPosition(), self.inst.components.combat.target:GetPosition()) > 10*10 or self.inst.sg:HasStateTag("running")) end,
 --       "Charge Behaviours", ChaseAndRam(self.inst, MAX_CHASE_TIME, GIVE_UP_DIST, MAX_CHARGE_DIST)),
 --       ChaseAndAttack(self.inst),

--        WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() and math.random(1,4) > 1 end, "Dodge",
--        RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
				
				
--        ChattyNode(self.inst, "PIG_GUARD_TALK_FIGHT",
--            WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() and math.random(1,10) == 1 end, "Mind",
--				DoAction(self.inst, function() return MindcontrolAction(self.inst) end))),	
		
		
		WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
        DoAction(self.inst, GoHomeAction, "Go Home", true)),

--		DoAction(self.inst, function() return FindFoodAction(self.inst) end)
 

        WhileNode(function() return not self.inst.CanFly end, "Wander Behaviours", --Wander around
		Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_IDLE_WANDER_DIST)),
--		Wander(self.inst, function() return GetWanderPoint(self.inst) end, MAX_IDLE_WANDER_DIST, wandertimes)),

    }, .25)
    self.bt = BT(self.inst, root)
end

return TigersharkBrain