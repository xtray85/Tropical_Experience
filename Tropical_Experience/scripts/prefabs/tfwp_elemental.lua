local assets=
{
	Asset("ANIM", "anim/lavaarena_elemental_basic.zip"),
	Asset("ANIM", "anim/fireball_2_fx.zip"),
}

local function retargetfn(inst)
	local dist = TUNING.TFWP_ELEMENTAL.RANGE
	local notags = {"player", "FX", "NOCLICK", "INLIMBO"}
	return FindEntity(inst, dist, function(guy)
		return inst.components.combat:CanTarget(guy)
	end, {"monster"}, notags)
end

local function KeepTarget(inst, target)
	return inst.components.combat:CanTarget(target) 
		and inst:GetDistanceSqToInst(target) <= (TUNING.TFWP_ELEMENTAL.RANGE * TUNING.TFWP_ELEMENTAL.RANGE)
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
end

local function MakeWeapon(inst)
    if inst.components.inventory ~= nil then
        local weapon = CreateEntity()
        weapon.entity:AddTransform()
        MakeInventoryPhysics(weapon)
        weapon:AddComponent("weapon")
        weapon.components.weapon:SetDamage(25)
        weapon.components.weapon:SetRange(TUNING.TFWP_ELEMENTAL.RANGE, TUNING.TFWP_ELEMENTAL.RANGE + 2)
		weapon.components.weapon:SetProjectile("tfwp_elemental_proj")
        weapon:AddComponent("inventoryitem")
        weapon.persists = false
        weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
        weapon:AddComponent("equippable")
        inst.weapon = weapon
        inst.components.inventory:Equip(inst.weapon)
    end
end

local function morre(inst)
inst.sg:GoToState("death")
end

local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddPhysics()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()
	inst.entity:AddLight()

	inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(0.6)
    inst.Light:SetRadius(2)
    inst.Light:SetColour(1, 0.55, 0)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)
	inst.voumorrer = 0

	MakeCharacterPhysics(inst, 250, 1.5)

	inst.DynamicShadow:SetSize(2.5, 1.5)
	inst.Transform:SetFourFaced()

	inst.AnimState:SetBank("lavaarena_elemental_basic")
	inst.AnimState:SetBuild("lavaarena_elemental_basic")

	inst:AddTag("scarytoprey")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
	end
	
    inst.persists = false

	inst:SetStateGraph("SGtfwp_elemetal")
	inst:SetBrain(require "brains/tfwp_elementalbrain")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(800)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(25)
	inst.components.combat:SetAttackPeriod(TUNING.TFWP_ELEMENTAL.ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(3, retargetfn)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat:SetRange(TUNING.TFWP_ELEMENTAL.RANGE * 1.3)

	inst:AddComponent("inspectable")
	inst:AddComponent("inventory")

	MakeWeapon(inst)

	return inst
end

local function OnHit(inst) 
    inst.AnimState:PlayAnimation("disappear")
    inst:ListenForEvent("animover", inst.Remove)
end

local function OnMiss(inst) 
    inst.AnimState:PlayAnimation("disappear")
    inst:ListenForEvent("animover", inst.Remove)
end

local function projfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddPhysics()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

	inst.Transform:SetScale(0.6, 0.6, 0.6)

    inst.AnimState:SetBank("fireball_fx")
    inst.AnimState:SetBuild("fireball_2_fx")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:SetMultColour(1, 0.7, 0.7, 1)
    inst.AnimState:SetFinalOffset(-1)

    inst.Transform:SetTwoFaced()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("projectile")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(40)
    inst.components.projectile:SetHoming(true)
    inst.components.projectile:SetHitDist(1.0)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(OnMiss)
    inst.components.projectile:SetLaunchOffset(Vector3(2, 0.3, 2))

    return inst
end

return Prefab("golem", fn, assets),
	Prefab("tfwp_elemental_proj", projfn, assets)