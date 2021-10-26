require "behaviours/standstill"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/wander"
require "behaviours/chaseandattack"


local StungrayBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

local MAX_CHASE_TIME = 20
local MAX_CHASE_DIST = 20
local SEE_FOOD_DIST = 30
local MAX_WANDER_DIST = 10
local NO_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO" }

local function GoHomeAction(inst)
    return inst.components.homeseeker ~= nil
        and inst.components.homeseeker.home ~= nil
        and inst.components.homeseeker.home:IsValid()
        and inst.components.homeseeker.home.components.childspawner ~= nil
        and not inst.components.teamattacker.inteam
        and BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
        or nil
end

local BATDESTINATION_TAG = { "batdestination" }
local function EscapeAction(inst)
    if TheWorld.state.iscaveday then
        return GoHomeAction(inst)
    end
    -- wander up through a sinkhole at night
    local x, y, z = inst.Transform:GetWorldPosition()
    local exit = TheSim:FindEntities(x, 0, z, TUNING.BAT_ESCAPE_RADIUS, BATDESTINATION_TAG)[1]
    return exit ~= nil
        and (exit.components.childspawner ~= nil or
            exit.components.hideout ~= nil)
        and BufferedAction(inst, exit, ACTIONS.GOHOME)
        or nil
end

local function EatFoodAction(inst)
    if inst.sg:HasStateTag("busy") then
        return
    elseif inst.components.inventory ~= nil and inst.components.eater ~= nil then
        local target = inst.components.inventory:FindItem(function(item)
            return inst.components.eater:CanEat(item)
        end)
        if target ~= nil then
            return BufferedAction(inst, target, ACTIONS.EAT)
        end
    end

    local target = FindEntity(
        inst,
        SEE_FOOD_DIST,
        function(item)
            return item:GetTimeAlive() >= 8
                and item:IsOnPassablePoint(true)
                and inst.components.eater:CanEat(item)
        end,
        nil,
        NO_TAGS,
        inst.components.eater:GetEdibleTags()
    )
    return target ~= nil and BufferedAction(inst, target, ACTIONS.PICKUP) or nil
end

local function EatFoodAction(inst)

    local target = nil

    if inst.sg:HasStateTag("busy") then
        return
    end

    if inst.components.inventory and inst.components.eater then
        target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        if target then return BufferedAction(inst,target,ACTIONS.EAT) end
    end


    if not target then
        local notags = {"FX", "NOCLICK", "DECOR","INLIMBO"}
        target = FindEntity(inst, 30, function(item)
            if item:GetTimeAlive() < 8  then return false end
            if item.Transform == nil then return false end 
            if not item:IsOnValidGround() then
                return false
            end
            return inst.components.eater:CanEat(item)

            end, nil, notags)
    end

    if target then
        return BufferedAction(inst,target,ACTIONS.PICKUP)
    end

    -- local target = FindEntity(inst, 30, function(item) return inst.components.eater:CanEat(item) and not (item.components.inventoryitem and item.components.inventoryitem:IsHeld()) end)
    -- if target then
    --     local act = BufferedAction(inst, target, ACTIONS.EAT)
    --     act.validfn = function() return not (target.components.inventoryitem and target.components.inventoryitem:IsHeld()) end
    --     return act
    -- end
end

function StungrayBrain:OnStart()
    local root = PriorityNode(
    {
--        EventNode(self.inst, "panic",
--            ParallelNode{
--                Panic(self.inst),
--                WaitNode(6),
--            }),
--        WhileNode(function() return self.inst.components.health.takingfiredamage or self.inst.components.hauntable.panic end, "Panic", Panic(self.inst)),
        AttackWall(self.inst),
        ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST),
        WhileNode(function() return TheWorld.state.isday end, "IsDay",
            DoAction(self.inst, GoHomeAction)),
        WhileNode(function() return self.inst.components.teamattacker.teamleader == nil end, "No Leader",
            PriorityNode{
                DoAction(self.inst, EatFoodAction),
--                MinPeriod(self.inst, TUNING.BAT_ESCAPE_TIME, false,
--                    DoAction(self.inst, EscapeAction)),
                Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
            }),
    }, .25)
    self.bt = BT(self.inst, root)
end

return StungrayBrain
