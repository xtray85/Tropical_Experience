local brain = require "brains/treeguardbrain"

local assets =
{
	Asset("ANIM", "anim/treeguard_walking.zip"),
	Asset("ANIM", "anim/treeguard_actions.zip"),
	Asset("ANIM", "anim/treeguard_attacks.zip"),
	Asset("ANIM", "anim/treeguard_idles.zip"),
	Asset("ANIM", "anim/treeguard_build.zip"),
}

local prefabs =
{
	"meat",
	"log",
	"character_fire",
    "livinglog",
    "treeguard_coconut",
}

SetSharedLootTable( 'treeguard',
{
    {"livinglog",   1.0},
    {"livinglog",   1.0},
    {"livinglog",   1.0},
    {"livinglog",   0.5},
    {"livinglog",   0.5},
    {"livinglog",   0.5},
    {"monstermeat", 1.0},
	{"monstermeat", 0.5},
    {"coconut",     1.0},
    {"coconut",     0.5},
	{"palmleaf",    1.0},
    {"palmleaf",    0.5},
})

local function OnLoad(inst, data)
    if data and data.hibernate then
        inst.components.sleeper.hibernate = true
    end
    if data and data.sleep_time then
         inst.components.sleeper.testtime = data.sleep_time
    end
    if data and data.sleeping then
         inst.components.sleeper:GoToSleep()
    end
end

local function OnSave(inst, data)
    if inst.components.sleeper:IsAsleep() then
        data.sleeping = true
        data.sleep_time = inst.components.sleeper.testtime
    end

    if inst.components.sleeper:IsHibernating() then
        data.hibernate = true
    end
end

local function CalcSanityAura(inst, observer)

	if inst.components.combat.target then
		return -TUNING.SANITYAURA_LARGE
	else
		return 0.1
	end

	return 0
end

local function OnBurnt(inst)
    if inst.components.propagator and inst.components.health and not inst.components.health:IsDead() then
        inst.components.propagator.acceptsheat = true
    end
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
end

local function OnAttack(inst, data)
    local numshots = 2
    if data.target then
        for i = 0, numshots - 1 do
            local offset = Vector3(math.random(-4, 4), math.random(-4, 4), math.random(-4, 4))
            inst.components.thrower:Throw(data.target:GetPosition() + offset)
        end
    end
    if data.target then
            local offset = Vector3(0, 0, 0)
            inst.components.thrower:Throw(data.target:GetPosition() + offset)
    end
end

local function SetRangeMode(inst)
    if inst.combatmode == "RANGE" then
        return
    end

    inst.combatmode = "RANGE"
    inst.components.combat:SetDefaultDamage(0)
    inst.components.combat:SetAttackPeriod(5)
    inst.components.combat:SetRange(20, 25)
    inst:ListenForEvent("onattackother", OnAttack)
end

local function SetMeleeMode(inst)
    if inst.combatmode == "MELEE" then
        return
    end

    inst.combatmode = "MELEE"
    inst.components.combat:SetDefaultDamage(150)
    inst.components.combat:SetAttackPeriod(3)
    inst.components.combat:SetRange(20, 3)
    inst:RemoveEventCallback("onattackother", OnAttack)
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()

	shadow:SetSize( 4, 1.5 )
    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 1000, .5)

    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("leif")
    inst:AddTag("tree")
    inst:AddTag("largecreature")
	inst:AddTag("epic")

    inst.AnimState:SetBank("treeguard")
    inst.AnimState:SetBuild("treeguard_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
       	return inst
   	end

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 1.5

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    MakeLargeBurnableCharacter(inst, "marker")
    inst.components.burnable.flammability = .333
    inst.components.burnable:SetOnBurntFn(OnBurnt)
    inst.components.propagator.acceptsheat = true

    MakeHugeFreezableCharacter(inst, "marker")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(1750)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "marker"
    inst.components.combat:SetDefaultDamage(150)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRange(20, 25)
    inst.components.combat.playerdamagepercent = .33

    inst:AddComponent("thrower")
    inst.components.thrower.throwable_prefab = "treeguard_coconut"

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('treeguard')

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:SetStateGraph("SGtreeguard")
    inst:SetBrain(brain)

    inst.OnLoad = OnLoad
    inst.OnSave = OnSave

    inst.SetRange = SetRangeMode
    inst.SetMelee = SetMeleeMode

    inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

return Prefab( "common/treeguard", fn, assets, prefabs)
