require "behaviours/wander"
require "behaviours/follow"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/doaction"
--require "behaviours/choptree"
require "behaviours/findlight"
require "behaviours/panic"
require "behaviours/chattynode"
require "behaviours/leash"
require "behaviours/chaseandram"


local STOP_RUN_DIST = 12
local SEE_PLAYER_DIST = 7

local AVOID_PLAYER_DIST = 5
local AVOID_PLAYER_STOP = 8

local MAX_CHASE_TIME = 10
local MAX_CHASE_DIST = 30

local SEE_BAIT_DIST = 20
local MAX_IDLE_WANDER_DIST = 10

local WANDER_DIST_DAY = 8
local WANDER_DIST_NIGHT = 4

local START_FACE_DIST = 4
local KEEP_FACE_DIST = 6

local START_FOLLOW_DIST = 13

local MIN_FOLLOW_DIST = 0
local MAX_FOLLOW_DIST = 12
local TARGET_FOLLOW_DIST = 6

local BallphinBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)


function BallphinBrain:OnInitializationComplete()
--	  self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()), true)
 end
 
 local function HasValidHome(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home ~= nil
        and home:IsValid()
        and not (home.components.burnable ~= nil and home.components.burnable:IsBurning())
        and not home:HasTag("burnt")
end

local function GoHomeAction(inst)
    if HasValidHome(inst) and
        not inst.components.combat.target then
            return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local wandertimes =
{
	minwalktime = 2,
	randwalktime =  2,
	minwaittime = 0.1,
	randwaittime = 0.1,
}

local function EatFoodAction(inst)
	local notags = {"FX", "NOCLICK", "DECOR","INLIMBO"}
	local target = FindEntity(inst, SEE_BAIT_DIST, function(item) return inst.components.eater:CanEat(item) and item.components.bait and not item:HasTag("planted") and not (item.components.inventoryitem and item.components.inventoryitem:IsHeld()) end, nil, notags)
	if target then
		local act = BufferedAction(inst, target, ACTIONS.EAT)
		act.validfn = function() return not (target.components.inventoryitem and target.components.inventoryitem:IsHeld()) end
		return act
	end
end

local function GetWanderDistFn(inst)
    if TheWorld.state.isday then
        return WANDER_DIST_NIGHT
    else
        return WANDER_DIST_DAY
    end
end

local function GetFaceTargetFn(inst)
    local target = GetClosestInstWithTag("character", inst, START_FACE_DIST)
    if target and not target:HasTag("notarget") and target:HasTag('aquatic') then
        return target
    end
end

local function KeepFaceTargetFn(inst, target)
    return inst:GetDistanceSqToInst(target) <= KEEP_FACE_DIST*KEEP_FACE_DIST and not target:HasTag("notarget") and target:HasTag('aquatic')
end

local function GetFollowTargetFn(inst)
    local target = GetClosestInstWithTag("character", inst, START_FOLLOW_DIST)
    if target and not target:HasTag("notarget") and target:HasTag('aquatic') then
        return target
    end
end



local function FindFoodAction(inst)
local target = GetClosestInstWithTag("fishinghook", inst, 4)
if target and target.components.oceanfishinghook ~= nil and TheWorld.Map:IsOceanAtPoint(target.Transform:GetWorldPosition()) 
and not target.components.oceanfishinghook:HasLostInterest(inst) and target.components.oceanfishinghook:TestInterest(inst) then --and target:HasTag("swfishbait") then
if target.components.oceanfishinghook.lure_data and target.components.oceanfishinghook.lure_data.style and target.components.oceanfishinghook.lure_data.style == ("swfish")then
local x, y, z = inst.Transform:GetWorldPosition()
local part = SpawnPrefab("oceanfish_small_12")
if part ~= nil then
part.Transform:SetPosition(x, y, z)
if part.components.health ~= nil then
part.components.health:SetPercent(1)
end
end					
inst:Remove() 
end
end

end

function BallphinBrain:OnStart()
	local root = PriorityNode(
	{
		WhileNode(function() return not self.inst:HasTag("ballphinfriend") end, "Not a ballphinfriend", ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST)),
		WhileNode(function() return self.inst:HasTag("ballphinfriend") end, "a ballphinfriend", ChaseAndAttack(self.inst, 100)),
        WhileNode( function() return not TheWorld.state.iscaveday end, "Cave nightness", DoAction(self.inst, GoHomeAction, "go home", true )),		
		Leash(self.inst, function() return self.inst.components.knownlocations:GetLocation("herd") end, 30, 20),
        Follow(self.inst, function() return GetFollowTargetFn(self.inst) end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
		FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
		DoAction(self.inst, FindFoodAction, "eat food", true ),
		Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("herd") end, GetWanderDistFn),
	}, .25)
	self.bt = BT(self.inst, root)
end

return BallphinBrain
