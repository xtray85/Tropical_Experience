require "behaviours/wander"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/attackwall"
require "behaviours/minperiod"
require "behaviours/leash"
require "behaviours/faceentity"
require "behaviours/doaction"
require "behaviours/standstill"

local OtterBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
    --self.reanimatetime = nil
end)

local SEE_DIST = 30

local MIN_FOLLOW_LEADER = 2
local MAX_FOLLOW_LEADER = 6
local TARGET_FOLLOW_LEADER = (MAX_FOLLOW_LEADER + MIN_FOLLOW_LEADER) / 2

local LEASH_RETURN_DIST = 10
local LEASH_MAX_DIST = 40

local HOUSE_MAX_DIST = 40
local HOUSE_RETURN_DIST = 50

local FISHING_COMBAT_DIST = 8

local SIT_BOY_DIST = 10
local SEE_FOOD_DIST = 15 --10

local MAX_FISER_DIST = TUNING.OCEAN_FISHING.MAX_HOOK_DIST

local STRUGGLE_WANDER_TIMES = {minwalktime=0.3, randwalktime=0.2, minwaittime=0.0, randwaittime=0.0}
local STRUGGLE_WANDER_DATA = {wander_dist = 6, should_run = true}

local TIREDOUT_WANDER_TIMES = {minwalktime=0.5, randwalktime=0.5, minwaittime=0.0, randwaittime=0.0}
local TIREDOUT_WANDER_DATA = {wander_dist = 6, should_run = false}

local FISHING_COMBAT_DIST = 8

local OCEANFISH_TAGS = {"oceanfish"}

local function EatFoodAction(inst)
    local target = FindEntity(inst, SEE_DIST, function(item) return inst.components.eater:CanEat(item) and item:IsOnPassablePoint(true) end)
    return target ~= nil and BufferedAction(inst, target, ACTIONS.EAT) or nil
end

local function EatFishAction(inst)
    if not inst.components.timer:TimerExists("gobble_cooldown") then
        local target = FindEntity(inst, SEE_FOOD_DIST, function(food)
                return TheWorld.Map:IsOceanAtPoint(inst.Transform:GetWorldPosition())
            end,
            nil,
            nil,
            OCEANFISH_TAGS)

        if target then
            inst.foodtarget = target
            local targetpos = Vector3(target.Transform:GetWorldPosition())

            -- signal nearby squid to eat nearby fish
            local fish = TheSim:FindEntities(targetpos.x, targetpos.y, targetpos.z, 10, OCEANFISH_TAGS)
            if #fish >0 then
                for i=#fish,1,-1 do
                    local item = fish[i]
                    if not item.components.oceanfishable or not TheWorld.Map:IsOceanAtPoint(item.Transform:GetWorldPosition()) then
                        table.remove(fish,i)
                    end
                end
            end
            local squidpos = Vector3(inst.Transform:GetWorldPosition())
 --           local herd = inst.components.herdmember:GetHerd()
 --           if herd and #fish > 0 then
 --               for k,v in pairs(herd.components.herd.members) do
 --                   if not k.foodtarget or k.foodtarget == target then
 --                       k.foodtarget = fish[math.random(1,#fish)]
 --                   end
 --               end
 --           end
            local act = BufferedAction(inst, target, ACTIONS.EAT)
            act.validfn = function() return not (target.components.inventoryitem and target.components.inventoryitem:IsHeld()) end
            return act
        end
    end

    return nil
end

local function GetLeader(inst)
    return inst.components.follower ~= nil and inst.components.follower.leader or nil
end

local function GetHome(inst)
    return inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
end

local function GetHomePos(inst)
    local home = GetHome(inst)
    return home ~= nil and home:GetPosition() or nil
end

local function GetNoLeaderLeashPos(inst)
    return GetLeader(inst) == nil and GetHomePos(inst) or nil
end

local function GetWanderPoint(inst)
    local target = GetLeader(inst) or inst:GetNearestPlayer(true)
    return target ~= nil and target:GetPosition() or nil
end

local function ShouldStandStill(inst)
    return inst:HasTag("pet_otter") and not TheWorld.state.isday and not GetLeader(inst) and not inst.components.combat:HasTarget() and inst:IsNear(GetHome(inst), SIT_BOY_DIST)
end

local function FaceFormation(inst)
    if inst.sg:HasStateTag("canrotate") then
        local leader = GetLeader(inst)
        if leader ~= nil then
            inst.Transform:SetRotation(leader.Transform:GetRotation())
        end
    end
end

local function getstruggledirectionFn(inst)
    local rod = inst.components.oceanfishable:GetRod()
    return (inst:GetAngleToPoint(rod.Transform:GetWorldPosition()) + 180 + (math.random(7) - 3.5) * 20) * DEGREES
end

local function gettiredoutdirectionFn(inst)
    local rod = inst.components.oceanfishable:GetRod()
    local angle = inst:GetAngleToPoint(rod.Transform:GetWorldPosition())

    local r = math.random() * 2 - 1
    return (angle + r*r*r * 120) * DEGREES
end

local function GetFisherPosition(inst)
    local rod = inst.components.oceanfishable:GetRod()
    return rod ~= nil and rod:GetPosition() or nil
end

local function TargetFisherman(inst)

    if inst.components.oceanfishable:GetRod() ~= nil then
        local target = inst.components.oceanfishable:GetRod().components.oceanfishingrod.fisher
        if target then
            local distsq = inst:GetDistanceSqToInst(target)

            if distsq < FISHING_COMBAT_DIST * FISHING_COMBAT_DIST then

                inst.components.combat:SetTarget(target)
            end
        end
    end

    return false
end

function OtterBrain:OnStart()
    local root = PriorityNode(
        {
            WhileNode(function() return not self.inst.sg:HasStateTag("jumping") end, "NotJumpingBehaviour",
                PriorityNode({
                    WhileNode(function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
                    WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
                    WhileNode(function() return GetLeader(self.inst) == nil end, "NoLeader", AttackWall(self.inst)),

                    WhileNode(function() return self.inst.components.oceanfishable ~= nil and self.inst.components.oceanfishable:GetRod() ~= nil end, "Hooked",
                        PriorityNode({
                            DoAction(self.inst, TargetFisherman),
                            PriorityNode({
                                WhileNode(function() self.inst.components.oceanfishable:UpdateStruggleState() return self.inst.components.oceanfishable:IsStruggling() end, "struggle",
                                    Wander(self.inst, GetFisherPosition, MAX_FISER_DIST, STRUGGLE_WANDER_TIMES, getstruggledirectionFn, nil, nil, STRUGGLE_WANDER_DATA)),
                                Wander(self.inst, GetFisherPosition, MAX_FISER_DIST, TIREDOUT_WANDER_TIMES, gettiredoutdirectionFn, nil, nil, TIREDOUT_WANDER_DATA),
                            }),
                        })
                    ),

                    WhileNode(function() return self.inst:HasTag("pet_otter") end, "Is Pet", ChaseAndAttack(self.inst, 10)),
                    WhileNode(function() return not self.inst:HasTag("pet_otter") and GetHome(self.inst) ~= nil end, "No Pet Has Home", ChaseAndAttack(self.inst, 10, 20)),
                    WhileNode(function() return not self.inst:HasTag("pet_otter") and GetHome(self.inst) == nil end, "Not Pet", ChaseAndAttack(self.inst, 100)),

                    Leash(self.inst, GetNoLeaderLeashPos, HOUSE_MAX_DIST, HOUSE_RETURN_DIST),

                    DoAction(self.inst, EatFishAction),
                    Follow(self.inst, GetLeader, MIN_FOLLOW_LEADER, TARGET_FOLLOW_LEADER, MAX_FOLLOW_LEADER),
                    FaceEntity(self.inst, GetLeader, GetLeader),

                    StandStill(self.inst, ShouldStandStill),

                    WhileNode(function() return GetHome(self.inst) end, "HasHome", Wander(self.inst, GetHomePos, 8)),
                    Wander(self.inst, GetWanderPoint, 20),
                }, .25)
            ),
        }, .25 )

    self.bt = BT(self.inst, root)
end

return OtterBrain
