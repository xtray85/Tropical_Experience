require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/chattynode"
require "behaviours/follow"

local BrainCommon = require "brains/braincommon"

local SEE_PLAYER_DIST = 5
local SEE_FOOD_DIST = 10
local MAX_WANDER_DIST = 15
local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 20
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8
local fishtime = 1000

local MIN_FOLLOW_DIST     = 1
local TARGET_FOLLOW_DIST  = 5
local MAX_FOLLOW_DIST     = 9

local AVOID_PLAYER_DIST = 3
local AVOID_PLAYER_STOP = 6
local STOP_RUN_DIST = 10

local SEE_TREE_DIST       = 15
local KEEP_CHOPPING_DIST  = 10

local SEE_ROCK_DIST       = 15
local KEEP_MINING_DIST    = 10

local SEE_HAMMER_DIST     = 15
local KEEP_HAMMERING_DIST = 10

local SEE_THRONE_DISTANCE = 50

local FACETIME_BASE       = 2
local FACETIME_RAND       = 2

local MermFisherBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function EatFoodAction(inst)
    local target = nil
    if inst.components.inventory ~= nil and inst.components.eater ~= nil then
        target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
    end
    if target == nil then
        target = FindEntity(inst, SEE_FOOD_DIST, function(item) return inst.components.eater:CanEat(item) end, { "edible_VEGGIE" }, { "INLIMBO" })
        --check for scary things near the food
        if target ~= nil and GetClosestInstWithTag("scarytoprey", target, SEE_PLAYER_DIST) ~= nil then
            target = nil
        end
    end
    if target ~= nil then
        local act = BufferedAction(inst, target, ACTIONS.EAT)
        act.validfn = function() return target.components.inventoryitem == nil or target.components.inventoryitem.owner == nil or target.components.inventoryitem.owner == inst end
        return act
    end
end

local function FindFoodAction(inst)
    if inst.sg:HasStateTag("busy") then
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
                and item.components.edible ~= nil
                and (not noveggie or item.components.edible.foodtype == FOODTYPE.MEAT)
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
                and (not noveggie or item.components.shelf.itemonshelf.components.edible.foodtype == FOODTYPE.MEAT)
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
    if inst.components.timer:TimerExists("dontfacetime") then
        return nil
    end
    local shouldface = inst.components.follower.leader or FindClosestPlayerToInst(inst, SEE_PLAYER_DIST, true)
    if shouldface and not inst.components.timer:TimerExists("facetime") then
        inst.components.timer:StartTimer("facetime", FACETIME_BASE + math.random()*FACETIME_RAND)
    end
    return shouldface
end

local function KeepFaceTargetFn(inst, target)
    if inst.components.timer:TimerExists("dontfacetime") then
        return nil
    end    
    local keepface = (inst.components.follower.leader and inst.components.follower.leader == target) or (target:IsValid() and inst:IsNear(target, SEE_PLAYER_DIST)) 
    if not keepface then
        inst.components.timer:StopTimer("facetime")
    end
    return keepface
end


-- Chop

local function IsDeciduousTreeMonster(guy)
    return guy.monster and guy.prefab == "deciduoustree"
end

local function FindDeciduousTreeMonster(inst)
    return FindEntity(inst, SEE_TREE_DIST / 3, IsDeciduousTreeMonster, { "CHOP_workable" })
end

local function KeepChoppingAction(inst)
    local keep_chopping = inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_CHOPPING_DIST))
        or FindDeciduousTreeMonster(inst) ~= nil
    
    return keep_chopping
end

local function StartChoppingCondition(inst)
    local chop_condition = inst.tree_target ~= nil
        or (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
            inst.components.follower.leader.sg:HasStateTag("chopping"))
        or FindDeciduousTreeMonster(inst) ~= nil

    return chop_condition
end

local function FindTreeToChopAction(inst)
    local target = FindEntity(inst, SEE_TREE_DIST, nil, { "CHOP_workable" })
    if target ~= nil then
        if inst.tree_target ~= nil then
            target = inst.tree_target
            inst.tree_target = nil
        else
            target = FindDeciduousTreeMonster(inst) or target
        end
        
        return BufferedAction(inst, target, ACTIONS.CHOP)
    end
end
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Mine

local function KeepMiningAction(inst)
    local keep_mining = (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_MINING_DIST))
    
    return keep_mining
end

local function StartMiningCondition(inst)
    local mine_condition = (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
            inst.components.follower.leader.sg:HasStateTag("mining"))

    return mine_condition
end

local function FindRockToMineAction(inst)
    local target = FindEntity(inst, SEE_ROCK_DIST, nil, { "MINE_workable" })
    if target ~= nil then
        return BufferedAction(inst, target, ACTIONS.MINE)
    end
end

------------------------------------------------------------------------------


------------------------------------------------------------------------------
-- Hammer

local function KeepHammeringAction(inst)
    local keep_hammering = (inst.components.follower.leader ~= nil and
            inst:IsNear(inst.components.follower.leader, KEEP_HAMMERING_DIST))
    
    return keep_hammering
end

local function StartHammeringCondition(inst)
    local hammer_condition = (inst.components.follower.leader ~= nil and
            inst.components.follower.leader.sg ~= nil and
            inst.components.follower.leader.sg:HasStateTag("hammering"))

    return hammer_condition
end

local function FindHammerTargetAction(inst)
    local target = FindEntity(inst, SEE_HAMMER_DIST, nil, { "HAMMER_workable" })
    if target ~= nil then
        return BufferedAction(inst, target, ACTIONS.HAMMER)
    end
end
local function GetNoLeaderHomePos(inst)
    if inst.components.follower and inst.components.follower.leader ~= nil then
        return nil
    end

    return inst.components.knownlocations:GetLocation("home")
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

local function Fish(inst)
    local pond = FindEntity(inst, 20, nil, {"fishable"})
    local oceanfish = FindEntity(inst, 8, nil, {"walkableplatform"})
	
	fishtime = fishtime + 1
	
    if pond and not inst.sg:HasStateTag("fishing") and fishtime >= 100 then
	fishtime = 0
    return BufferedAction(inst, pond, ACTIONS.FISH1)
    end
    if oceanfish and not inst.sg:HasStateTag("fishing") and fishtime >= 100 then
	local distancia = oceanfish:GetDistanceSqToInst(inst)
	if distancia > 6 then
--	inst:ForceFacePoint(pos.x, pos.y, pos.z)
	fishtime = 0
    return BufferedAction(inst, pond, ACTIONS.FISH1)
	end
    end	
end

function MermFisherBrain:OnStart(inst)
    local IsThreatened = --When the fisherman has a combat target
    PriorityNode(
    {
--            ChattyNode(self.inst, "PIG_TALK_FIND_MEAT",
--                DoAction(self.inst, FindFoodAction )),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        RunAway(self.inst, "scarytoprey", AVOID_PLAYER_DIST, AVOID_PLAYER_STOP),
        RunAway(self.inst, "scarytoprey", SEE_PLAYER_DIST, STOP_RUN_DIST, nil, true),				
				
				
       WhileNode(function() return self.inst.components.hauntable ~= nil and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
--        WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
--            ChaseAndAttack(self.inst, SpringCombatMod(MAX_CHASE_TIME), SpringCombatMod(MAX_CHASE_DIST))),
--        WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
--            RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
        WhileNode( function() return IsHomeOnFire(self.inst) end, "HomeOnFire", Panic(self.inst)),
        WhileNode(function() return ShouldGoHome(self.inst) end, "ShouldGoHome",
            DoAction(self.inst, GoHomeAction, "Go Home", true)),
        DoAction(self.inst, EatFoodAction, "Eat Food"),
        ChattyNode(self.inst, "MERM_TALK_FOLLOWWILSON",
		  Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST)),	
--        IfNode(function() return self.inst.components.follower.leader ~= nil end, "HasLeader",
--            ChattyNode(self.inst, "MERM_TALK_FOLLOWWILSON",
--                FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn ))),		  
--        FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
        ChattyNode(self.inst, STRINGS.MERM_TALK_FISH,
           DoAction(self.inst, Fish, "Fish Action")),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
    }, 0.25)

    local IsIdle =
    PriorityNode(
    {
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
    }, 0.25)

    local root = PriorityNode(
    {

        WhileNode(function() return self.inst.components.combat.target ~= nil and not self.inst.sg:HasStateTag("fishing") end, "Is Threatened", IsThreatened),
        
            ChattyNode(self.inst, "PIG_TALK_FIND_MEAT",
                DoAction(self.inst, FindFoodAction )),

        ChattyNode(self.inst, "MERM_TALK_FOLLOWWILSON",
		  Follow(self.inst, function() return self.inst.components.follower.leader end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST)),	
--        IfNode(function() return self.inst.components.follower.leader ~= nil end, "HasLeader",
--            ChattyNode(self.inst, "MERM_TALK_FOLLOWWILSON",
--                FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn ))),				
				
        ChattyNode(self.inst, STRINGS.MERM_TALK_FISH,
           DoAction(self.inst, Fish, "Fish Action")),

        WhileNode(function() return not self.inst.sg:HasStateTag("fishing") end, "Is Idle", IsIdle),
    }, 0.25)
    
    self.bt = BT(self.inst, root)
end

return MermFisherBrain