--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

require "behaviours/wander"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/minperiod"
require "behaviours/doaction"
require "behaviours/standstill"

local HattyPiggy_TFCBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

local chargeRecharge = TUNING.HATTY_PIGGY_TFC.CHARGE_RECHARGE
local minChargeRange = TUNING.HATTY_PIGGY_TFC.RANGE * TUNING.HATTY_PIGGY_TFC.RANGE + 4
local maxChargeRange = minChargeRange + 16
local SEE_DIST = 30

local function NumInDiapason(num, min, max)
	return num >= min and num <= max
end

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

local function ShouldCharge(inst) 
if inst:HasTag("nohat") then return false end
	local combat = inst.components.combat
	return combat ~= nil and combat.target ~= nil 
		and not inst.sg:HasStateTag("attack")
		and NumInDiapason(inst:GetDistanceSqToInst(combat.target), minChargeRange, maxChargeRange)
		and GetTime() - inst.chargeLastTime >= chargeRecharge
end

function HattyPiggy_TFCBrain:OnStart()
	
	local root = PriorityNode(
	{
		WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst) ),
		WhileNode(function() return ShouldCharge(self.inst) end, "Charge",
			ActionNode(function() self.inst:PushEvent("docharge", self.inst.components.combat.target) end)),
		ChaseAndAttack(self.inst, 30),

--		DoAction(self.inst, EatFoodAction, "EatFood", true ),

		WhileNode( function() return TheWorld.state.iscavenight end, "Home Night",
			DoAction(self.inst, GoHomeAction, "Go Home", true )),
		WhileNode(function() return GetHome(self.inst) end, "Home Wander", 
			Wander(self.inst, GetHomePos, 8) ),
		
		Wander(self.inst, GetWanderPoint, 20),

	}, .25)
	
	self.bt = BT(self.inst, root)
	
end

return HattyPiggy_TFCBrain
