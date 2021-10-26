require "stategraphs/SGbillsnow"
local brain = require "brains/billbrain"

local assets =
{
	Asset("ANIM", "anim/bill_agro_build.zip"),
	Asset("ANIM", "anim/bill_basic.zip"),
}

local BILL_TUMBLE_SPEED = 8
local BILL_RUN_SPEED = 5
local BILL_DAMAGE = 34 * 0.5
local BILL_HEALTH = 250
local BILL_ATTACK_PERIOD = 3
local BILL_TARGET_DIST = 50
local BILL_AGGRO_DIST = 15
local BILL_EAT_DELAY = 3.5
local BILL_SPAWN_CHANCE = 0.2

local prefabs =
{
	"bill_quill",
}

local billsounds =
{
	-- TODO: Put related audio here.
}

SetSharedLootTable( 'bill',
{
    {'meat',            1.00},
--    {'bill_quill',      1.00},
--    {'bill_quill',      1.00},
--    {'bill_quill',      0.33},
})

function IsBillFood(item)
	return item:HasTag("billfood")
end

local function KeepTarget(inst, target)
    return inst.components.combat:CanTarget(target) and target:HasTag("player")
end

local function CanEat(inst, item)
	return item:HasTag("billfood")
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, 20, function(dude) return dude:HasTag("platapine") end, 2)
end

local function fn(Sim)
	local inst    = CreateEntity()
	local trans   = inst.entity:AddTransform()
	local anim    = inst.entity:AddAnimState()
	local physics = inst.entity:AddPhysics()
	local sound   = inst.entity:AddSoundEmitter()
	local shadow  = inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

	inst.letsGetReadyToTumble = false

	shadow:SetSize(1, 0.75)
	inst.Transform:SetFourFaced()

--	MakeAmphibiousCharacterPhysics(inst, 1, 0.5)
	MakeCharacterPhysics(inst, 1, 0.5)	
--	MakePoisonableCharacter(inst)

	anim:SetBank("bill")
	anim:SetBuild("bill_agro_build")
	anim:PlayAnimation("idle", true)

	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("platapine")
    inst:AddTag("walrus")
    inst:AddTag("houndfriend")	
	
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	

	inst:AddComponent("locomotor")
	
	inst.components.locomotor.runspeed = BILL_RUN_SPEED

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(BILL_HEALTH)
	inst.components.health.murdersound = "dontstarve/rabbit/scream_short"

	inst:AddComponent("inspectable")
	inst:AddComponent("sleeper")
	inst:AddComponent("eater")
	inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })
--	inst.components.eater:SetCanEatTestFn(CanEat)

	inst:AddComponent("knownlocations")
	inst:DoTaskInTime(0, function() inst.components.knownlocations:RememberLocation("home", Point(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("lootdropper")	
    inst.components.lootdropper:SetChanceLootTable('bill')

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(BILL_DAMAGE)
	inst.components.combat:SetAttackPeriod(BILL_ATTACK_PERIOD)
	inst.components.combat:SetRange(2, 3)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat.hiteffectsymbol = "chest"

	MakeSmallBurnableCharacter(inst, "chest")
	MakeTinyFreezableCharacter(inst, "chest")

	inst:ListenForEvent("attacked", OnAttacked)

	inst:SetStateGraph("SGbillsnow")
	inst:SetBrain(brain)
	inst.data = {}

	inst.sounds = billsounds

	return inst
end

return Prefab("forest/animals/billsnow", fn, assets, prefabs)
