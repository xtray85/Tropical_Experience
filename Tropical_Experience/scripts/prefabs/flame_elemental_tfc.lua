--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

local assets=
{
	Asset("ANIM", "anim/lavaarena_elemental_basic.zip"),
	Asset("ANIM", "anim/fireball_2_fx.zip"),
}

local prefabs =
{
	"ash",
}

SetSharedLootTable( "flame_elemental",
{
	{"ash",   1.0},
	{"ash",   1.0},
})

local function retargetfn(inst)
	local dist = TUNING.FLAME_ELEMENTAL_TFC.RANGE
	local notags = {"FX", "NOCLICK", "INLIMBO"}
	return FindEntity(inst, dist, function(guy)
		return  inst.components.combat:CanTarget(guy)
	end, {"monster"}, notags)
end

local function KeepTarget(inst, target)
	return inst.components.combat:CanTarget(target) 
		and inst:GetDistanceSqToInst(target) <= (TUNING.FLAME_ELEMENTAL_TFC.RANGE * TUNING.FLAME_ELEMENTAL_TFC.RANGE)
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
end

local function OnAttackOther(inst, data)
	if target.components.burnable ~= nil 
		and not target.components.burnable:IsBurning() 
		and target.components.fueled == nil
	then
		if math.random() < 0.05 then
			target.components.burnable:Ignite(true)
		end
        if target.components.freezable ~= nil and target.components.freezable:IsFrozen() then
            target.components.freezable:Unfreeze()
		end
    end
end

local function GoSuicide(inst)
	if not inst.components.health:IsDead() then
		inst.components.health:DoDelta(10)
	end
end

local function MakeWeapon(inst)
    if inst.components.inventory ~= nil then
        local weapon = CreateEntity()
        weapon.entity:AddTransform()
        MakeInventoryPhysics(weapon)
        weapon:AddComponent("weapon")
        weapon.components.weapon:SetDamage(TUNING.FLAME_ELEMENTAL_TFC.DAMAGE)
        weapon.components.weapon:SetRange(TUNING.FLAME_ELEMENTAL_TFC.RANGE)--, TUNING.FLAME_ELEMENTAL_TFC.RANGE + 4)
		weapon.components.weapon:SetProjectile("flame_elemental_proj_tfc")
        weapon:AddComponent("inventoryitem")
        weapon.persists = false
        weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
        weapon:AddComponent("equippable")
        inst.weapon = weapon
        inst.components.inventory:Equip(inst.weapon)
    end
end

local function GetDebugString(inst)
	return string.format("can slide: %s", tostring(inst.canSlide))
end

local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddPhysics()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.entity:AddDynamicShadow()

	MakeCharacterPhysics(inst, 250, 1.5)

	inst.DynamicShadow:SetSize(2.5, 1.5)
	inst.Transform:SetFourFaced()

	inst.AnimState:SetBank("lavaarena_elemental_basic")
	inst.AnimState:SetBuild("lavaarena_elemental_basic")
	--inst.AnimState:PlayAnimation("spawn")

	inst:AddTag("scarytoprey")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
	end
	
    --inst.persists = false

	inst:SetStateGraph("SGflameelemental_tfc")
	inst:SetBrain(require "brains/flameelemental_tfcbrain")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.FLAME_ELEMENTAL_TFC.HEALTH)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.FLAME_ELEMENTAL_TFC.DAMAGE)
	inst.components.combat:SetAttackPeriod(TUNING.FLAME_ELEMENTAL_TFC.ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(3, retargetfn)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat:SetRange(TUNING.FLAME_ELEMENTAL_TFC.RANGE)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("flame_elemental")

	inst:AddComponent("inspectable")
	inst:AddComponent("inventory")

	MakeWeapon(inst)
	inst._stask = inst:DoPeriodicTask(1, GoSuicide)

	inst:ListenForEvent("attacked", OnAttacked)

	return inst
end

local function OnThrown(inst) 
    inst:Show() 
    inst.AnimState:PlayAnimation("idle_loop")
end

local function OnHit(inst) 
    inst.AnimState:PlayAnimation("disappear")
    inst:ListenForEvent("animover", function(inst) inst:Remove() end)
end

local function OnMiss(inst) 
    inst.AnimState:PlayAnimation("disappear")
    inst:ListenForEvent("animover", function(inst) inst:Remove() end)
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
    inst.AnimState:PlayAnimation("idle_loop")
    inst.AnimState:SetMultColour(1, 0.7, 0.7, 1)
    inst.AnimState:SetFinalOffset(-1)

    inst.Transform:SetTwoFaced()

    --inst:Hide()

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
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetLaunchOffset(Vector3(2, 0.3, 2))

    return inst
end

return Prefab("flame_elemental_tfc", fn, assets, prefabs),
	Prefab("flame_elemental_proj_tfc", projfn, assets, prefabs)