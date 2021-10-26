require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/minperiod"

local TIME_BETWEEN_EATING = 3.5

local SEE_FOOD_DIST = 15
local SEE_STRUCTURE_DIST = 30

local BASE_TAGS = {"structure"}
local FOOD_TAGS = {"edible"}
local STEAL_TAGS = {"structure"}
local NO_TAGS = {"FX", "NOCLICK", "DECOR", "INLIMBO", "AQUATIC"}


local MAX_CHASE_TIME = 20
local MAX_WANDER_DIST = 16
local MAX_CHASEAWAY_DIST = 32
local START_FACE_DIST = 6
local KEEP_FACE_DIST = 8
local WARN_BEFORE_ATTACK_TIME = 2
local DOYDOY_MATING_DANCE_DIST = 3 

local VALID_FOODS = 
{
	"berries",
	"cave_banana",
	"carrot",
	"blue_cap",
	"green_cap",
	"seeds"
	--"limpets",
}


local function ItemIsInList(item, list)
	for k,v in pairs(list) do
		if v == item or k == item then
			return true
		end
	end
end

local function EatFoodAction(inst)  --Look for food to eat

	local target = nil
	local action = nil

	if inst.sg:HasStateTag("busy") and not
	inst.sg:HasStateTag("wantstoeat") then
		return
	end

	if inst.components.inventory and inst.components.eater then
		target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
		if target then return BufferedAction(inst,target,ACTIONS.EAT) end
	end

	local pt = inst:GetPosition()
	local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, SEE_FOOD_DIST, FOOD_TAGS, NO_TAGS) 

	if not target then
		for k,v in pairs(ents) do
			if v and v:IsOnValidGround() and 
			inst.components.eater:CanEat(v) and
			v:GetTimeAlive() > 5 and 
			v.components.inventoryitem and not 
			v.components.inventoryitem:IsHeld() then
				target = v
				break
			end
		end
	end    

	if target then
		local action = BufferedAction(inst,target,ACTIONS.PICKUP)
		return action 
	end
end

local function StealFoodAction(inst) --Look for things to take food from (EatFoodAction handles picking up/ eating)

	-- Food On Ground > Pots = Farms = Drying Racks > Plants

	local target = nil

	if inst.sg:HasStateTag("busy") or 
	(inst.components.inventory and inst.components.inventory:IsFull()) then
		return
	end

	local pt = inst:GetPosition()
	local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, SEE_STRUCTURE_DIST, nil, NO_TAGS) 
	--Look for crop/ cookpots/ drying rack, harvest them.
	if not target then
		for k,item in pairs(ents) do
			if (item.components.stewer and item.components.stewer:IsDone()) or
			(item.components.dryer and item.components.dryer:IsDone()) or
			(item.components.crop and item.components.crop:IsReadyForHarvest()) then
				target = item
			end
		end
	end

	if target then
		return BufferedAction(inst, target, ACTIONS.HARVEST)
	end

	--Berrybushes, carrots etc.
	if not target then
		for k,item in pairs(ents) do
			if item.components.pickable and 
			item.components.pickable.caninteractwith and 
			item.components.pickable:CanBePicked() and
			ItemIsInList(item.components.pickable.product, VALID_FOODS) then
				target = item
				break
			end
		end
	end

	if target then
		return BufferedAction(inst, target, ACTIONS.PICK)
	end
end

local function CanMate(doy)
	if doy == nil then
		return false
	end

--	if not TheWorld.state.isday then
--		return false
--	end
	
if doy.components.inventoryitem and doy.components.inventoryitem:IsHeld() then	
		return false
end

	if doy:IsAsleep() then
		return false
	end

	if doy.components.sleeper:IsAsleep() then
		return false
	end
	
	--计算时间间隔
	if doy.day_to_spawn and doy.day_to_spawn > 0 then
		return false
	end

	return true
end

local function MateAction(inst)
	--渡渡鸟总数量限制
	if seabeach_amount.doydoy > tonumber(doydoy_total_limit) then
		return
	end

	
if CanMate(inst) and inst:HasTag("daddy") then
local parceira = GetClosestInstWithTag("mommy", inst, 4)
if not parceira then return false end
if parceira and parceira.components.inventoryitem and parceira.components.inventoryitem:IsHeld() then return false end		
	
		local pt = inst:GetPosition()
		local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, SEE_STRUCTURE_DIST, {"mommy"}) 
		for k,item in pairs(ents) do
			if CanMate(item) then
                inst.sg:GoToState("mate")
				inst.day_to_spawn = tonumber(doydoy_mate_time)
				item.day_to_spawn = tonumber(doydoy_mate_time)
			end
		end
	end
end

local DoydoyBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
end)

function DoydoyBrain:OnStart()
	
	local eatnode =
	PriorityNode(
	{
		DoAction(self.inst, StealFoodAction),
	}, 2)

	local root =
	PriorityNode(
	{
		DoAction(self.inst, function() return MateAction(self.inst) end, "Mate", true),

		WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
		
		DoAction(self.inst, EatFoodAction), 
		MinPeriod(self.inst, math.random(4,6), true, eatnode),
		Wander(self.inst, nil, 15),
	},1)
	
	self.bt = BT(self.inst, root) 
		
end

return DoydoyBrain
