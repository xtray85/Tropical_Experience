--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

require "behaviours/wander"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/minperiod"
require "behaviours/doaction"
require "behaviours/standstill"

local StrangeScorpoin_TFCBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

local function NumInDiapason(num, min, max)
	return num >= min and num <= max
end

local rangeRecharge = TUNING.STRANGE_SCORPION_TFC.RANGE_ATTACK_PERIOD
local maxSpitRange = TUNING.STRANGE_SCORPION_TFC.SPITRANGE * TUNING.STRANGE_SCORPION_TFC.SPITRANGE
local minSpitRange = TUNING.STRANGE_SCORPION_TFC.RANGE * TUNING.STRANGE_SCORPION_TFC.RANGE + 4
local SEE_DIST = 30

local function EatFoodAction(inst)
	local notags = {"FX", "NOCLICK", "DECOR", "INLIMBO"}
	local target = FindEntity(inst, SEE_DIST, function(item) return inst.components.eater:CanEat(item) and item:IsOnValidGround() end, nil, notags)
	if target then
		return BufferedAction(inst, target, ACTIONS.EAT)
	end
end

local function GetHome(inst)
	return inst.components.homeseeker and inst.components.homeseeker.home
end

local function GetHomePos(inst)
	local home = GetHome(inst)
	return home and home:GetPosition()
end

local function GetWanderPoint(inst)
	local target = GetHome(inst) or inst

	if target then
		return target:GetPosition()
	end 
end

local function GoHomeAction(inst)
    if inst.components.homeseeker and 
       inst.components.homeseeker.home and 
	   inst.components.homeseeker.home:IsValid() 
	then
    	return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function ShouldSpit(inst)
	local combat = inst.components.combat
	return combat.target ~= nil 
		and not combat:CanAttack(combat.target)
		and NumInDiapason(inst:GetDistanceSqToInst(combat.target), minSpitRange, maxSpitRange)
		and GetTime() - combat.lastrangeattacktime >= rangeRecharge
end

local function CanSpread(inst)
	return inst.spitCharge >= 5 and inst.components.combat.target ~= nil
end

function StrangeScorpoin_TFCBrain:OnStart()
	
	local root = PriorityNode(
	{
		WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst) ),
		WhileNode(function() return CanSpread(self.inst) end, "Spread Poison",
			ActionNode(function() self.inst:PushEvent("spreadpoison") end)),
		WhileNode(function() return ShouldSpit(self.inst) end, "Spit",
			ActionNode(function() self.inst:PushEvent("dospit", self.inst.components.combat.target) end)),
		ChaseAndAttack(self.inst, 30),

		DoAction(self.inst, EatFoodAction, "EatFood", true ),

		WhileNode( function() return TheWorld.state.iscavenight end, "Home Night",
			DoAction(self.inst, GoHomeAction, "Go Home", true )),
		WhileNode(function() return GetHome(self.inst) end, "Home Wander", 
			Wander(self.inst, GetHomePos, 8) ),

		Wander(self.inst, GetWanderPoint, 20),
	}, .25)
	
	self.bt = BT(self.inst, root)
	
end

return StrangeScorpoin_TFCBrain
