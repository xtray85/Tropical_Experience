--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

require "behaviours/wander"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/attackwall"
require "behaviours/minperiod"
require "behaviours/faceentity"
require "behaviours/doaction"
require "behaviours/standstill"
require "behaviours/useshield"

local DAMAGE_UNTIL_SHIELD = TUNING.SPIKY_TURTLE_TFC.SHELL_REQ_DAMAGE
local SHIELD_TIME = TUNING.SPIKY_TURTLE_TFC.INSHELL_TIME
local AVOID_PROJECTILE_ATTACKS = false
local HIDE_WHEN_SCARED = true

local SpikyTurtle_TFCBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

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

local function CanSlide(inst)
	return inst.canSlide and not inst.sg:HasStateTag("flip")
end

local function CanUseShield(inst)
	return not inst.sg:HasStateTag("exitshield") and not inst.sg:HasStateTag("flip")
end

function SpikyTurtle_TFCBrain:OnStart()
	
	local root = PriorityNode(
	{
		WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst) ),
		WhileNode(function() return CanSlide(self.inst) end, "GoSlide",
			ActionNode(function() self.inst:PushEvent("goslide") end)),
		WhileNode(function() return CanUseShield(self.inst) end, "OnUseShield",
			UseShield(self.inst, DAMAGE_UNTIL_SHIELD, SHIELD_TIME, AVOID_PROJECTILE_ATTACKS, HIDE_WHEN_SCARED)),
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

return SpikyTurtle_TFCBrain
