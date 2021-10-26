--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

require "behaviours/wander"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/doaction"
require "behaviours/standstill"
require "behaviours/runaway"

local Lizardman_TFCBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

local bannerRecharge = TUNING.LIZARDMAN_TFC.BANNER_RECHARGE
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
	if inst.components.homeseeker 
		and inst.components.homeseeker.home 
		and inst.components.homeseeker.home:IsValid() 
		and not inst.components.combat.target
	then
    	return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function ShouldPlaceBanner(inst) 
	local combat = inst.components.combat
	return combat ~= nil and combat.target ~= nil 
		and not inst.sg:HasStateTag("banner")
		and GetTime() - inst.bannerLastTime >= bannerRecharge
end

function Lizardman_TFCBrain:OnStart()
	
	local root = PriorityNode(
	{
		WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst) ),
		
		WhileNode( function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
			ChaseAndAttack(self.inst, 8, 30) ),
		WhileNode(function() return ShouldPlaceBanner(self.inst) end, "Place Banner",
			ActionNode(function() self.inst:PushEvent("placebanner") end)),
		WhileNode( function() return self.inst.components.combat.target and self.inst.components.combat:InCooldown() end, "Dodge",
			RunAway(self.inst, function() return self.inst.components.combat.target end, 8, 16) ),

		DoAction(self.inst, EatFoodAction, "eat food", true ),
		WhileNode( function() return TheWorld.state.iscavenight end, "Home Night",
			DoAction(self.inst, GoHomeAction, "Go Home", true )),
		WhileNode(function() return GetHome(self.inst) end, "Home Wander", 
			Wander(self.inst, GetHomePos, 8) ),

		Wander(self.inst, GetWanderPoint, 20),
		StandStill(self.inst, function() return true end),
	}, .25)
	
	self.bt = BT(self.inst, root)
	
end

return Lizardman_TFCBrain
