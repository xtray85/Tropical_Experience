--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

local assets=
{
	Asset("ANIM", "anim/lavaarena_boaron_basic.zip"),
}

local prefabs =
{
	"meat",
}

SetSharedLootTable( "hatty_piggy",
{
--	{"quagmire_coin1",   1.0},
})

SetSharedLootTable( "nohatty_piggy",
{
	{"meat",   1.0},
})

local keepDistSq = TUNING.HATTY_PIGGY_TFC.KEEPDIST * TUNING.HATTY_PIGGY_TFC.KEEPDIST
local shareDist = TUNING.HATTY_PIGGY_TFC.SHARE_DIST
local targetDist = TUNING.SPIKY_TURTLE_TFC.TARGET_DIST

local function OnNewTarget(inst, data)
	if inst.components.sleeper:IsAsleep() then
		inst.components.sleeper:WakeUp()
	end
end

local function retargetfn(inst)
local player = GetClosestInstWithTag("player", inst, 70)
if player and not inst:HasTag("nohat") then return inst.components.combat:SetTarget(player) end
	local notags = {"player", "smallcreature", "FX", "NOCLICK", "INLIMBO"}
	return FindEntity(inst, targetDist, function(guy)
		return  inst.components.combat:CanTarget(guy)
	end, {"monster"}, notags)
end

local function retargetfn2(inst)
local player = GetClosestInstWithTag("player", inst, 10)
if player then return inst.components.combat:SetTarget(player) end
	local notags = {"player", "smallcreature", "FX", "NOCLICK", "INLIMBO"}
	return FindEntity(inst, targetDist, function(guy)
		return  inst.components.combat:CanTarget(guy)
	end, {"monster"}, notags)
end

local function KeepTarget(inst, target)
	return inst.components.combat:CanTarget(target) and inst:GetDistanceSqToInst(target) <= (keepDistSq)
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
	inst.components.combat:ShareTarget(data.attacker, shareDist, function(dude) return dude:HasTag("piggy") and not dude.components.health:IsDead() end, 2)
end

local function OnAttackOther(inst, data)
	inst.components.combat:ShareTarget(data.attacker, shareDist, function(dude) return dude:HasTag("piggy") and not dude.components.health:IsDead() end, 2)
end

local function GetDebugString(inst)
	return string.format("can charge in: %i", GetTime() - inst.chargeLastTime)
end

local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddPhysics()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()

	inst.DynamicShadow:SetSize(1.75, .75)
    inst.Transform:SetSixFaced()
    inst.Transform:SetScale(.8, .8, .8)

    MakeCharacterPhysics(inst, 50, .5)

    inst.AnimState:SetBank("boaron")
    inst.AnimState:SetBuild("lavaarena_boaron_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)

	inst:AddTag("scarytoprey")
	--inst:AddTag("monster")
	inst:AddTag("hostile")
	inst:AddTag("boar")
	inst:AddTag("Arena")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("knownlocations")

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = TUNING.HATTY_PIGGY_TFC.RUNSPEED
	
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")		

	inst:SetStateGraph("SGhattypiggy_tfc")
	inst:SetBrain(require "brains/hattypiggy_tfcbrain")

	inst:AddComponent("eater")
	inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	inst.components.eater:SetCanEatHorrible(false)

	--inst.components.eater.strongstomach = true -- can eat monster meat!

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.HATTY_PIGGY_TFC.HEALTH)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.HATTY_PIGGY_TFC.DAMAGE)
	inst.components.combat:SetAttackPeriod(TUNING.HATTY_PIGGY_TFC.ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(3, retargetfn)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat:SetRange(TUNING.HATTY_PIGGY_TFC.RANGE)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("hatty_piggy")

	inst:AddComponent("inspectable")

	--inst:AddComponent("sanityaura")
	--inst.components.sanityaura.aurafn = SanityAura

	inst:AddComponent("sleeper")
	inst.components.sleeper:SetNocturnal(false)

	--inst.OnSave = OnSave
	--inst.OnLoad = OnLoad

	inst:ListenForEvent("attacked", OnAttacked)
	--inst:ListenForEvent("onattackother", OnAttackOther)
	inst:ListenForEvent("newcombattarget", OnNewTarget)

	MakeLargeFreezableCharacter(inst, "body")
	MakeMediumBurnableCharacter(inst, "body")
	
	inst.chargeLastTime = GetTime()

	inst.debugstringfn = GetDebugString

	return inst
end

local function fn1(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddPhysics()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()

	inst.DynamicShadow:SetSize(1.75, .75)
    inst.Transform:SetSixFaced()
    inst.Transform:SetScale(.8, .8, .8)

    MakeCharacterPhysics(inst, 50, .5)

    inst.AnimState:SetBank("boaron")
    inst.AnimState:SetBuild("lavaarena_boaron_basic")
	inst.AnimState:OverrideSymbol("helmet", "lavaarena_boaron_basic", "")
    inst.AnimState:PlayAnimation("idle_loop", true)
	    inst.AnimState:Hide("hat")

	inst:AddTag("nohat")
	inst:AddTag("scarytoprey")
	--inst:AddTag("monster")
	inst:AddTag("hostile")
		inst:AddTag("walrus")
		inst:AddTag("houndfriend")		

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("knownlocations")

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = TUNING.HATTY_PIGGY_TFC.RUNSPEED
	
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")		

	inst:SetStateGraph("SGhattypiggy_tfc")
	inst:SetBrain(require "brains/hattypiggy_tfcbrain")

	inst:AddComponent("eater")
	inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	inst.components.eater:SetCanEatHorrible(false)

	--inst.components.eater.strongstomach = true -- can eat monster meat!

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.HATTY_PIGGY_TFC.HEALTH)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.HATTY_PIGGY_TFC.DAMAGE)
	inst.components.combat:SetAttackPeriod(TUNING.HATTY_PIGGY_TFC.ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(3, retargetfn2)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat:SetRange(TUNING.HATTY_PIGGY_TFC.RANGE)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("nohatty_piggy")

	inst:AddComponent("inspectable")

	--inst:AddComponent("sanityaura")
	--inst.components.sanityaura.aurafn = SanityAura

	inst:AddComponent("sleeper")
	inst.components.sleeper:SetNocturnal(false)

	--inst.OnSave = OnSave
	--inst.OnLoad = OnLoad

	inst:ListenForEvent("attacked", OnAttacked)
	--inst:ListenForEvent("onattackother", OnAttackOther)
	inst:ListenForEvent("newcombattarget", OnNewTarget)

	MakeLargeFreezableCharacter(inst, "body")
	MakeMediumBurnableCharacter(inst, "body")
	
	inst.chargeLastTime = GetTime()

	inst.debugstringfn = GetDebugString

	return inst
end
return Prefab("hatty_piggy_tfc", fn, assets, prefabs),
Prefab("nohatty_piggy_tfc", fn1, assets, prefabs)