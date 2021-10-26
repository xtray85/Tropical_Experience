--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

local assets =
{
    Asset("ANIM", "anim/lavaarena_snapper_basic.zip"),
}

local assets_fx =
{
    Asset("ANIM", "anim/gooball_fx.zip"),
}

local assets_banner =
{
    Asset("ANIM", "anim/lavaarena_battlestandard.zip"),
}

SetSharedLootTable( "lizardman",
{
--    {"meat", 1.0},
--    {"meat", 1.0},
})

local targetDist = TUNING.LIZARDMAN_TFC.TARGET_DIST
local keepDistSq = TUNING.LIZARDMAN_TFC.KEEP_TARGET_DIST * TUNING.LIZARDMAN_TFC.KEEP_TARGET_DIST
local shareDist = TUNING.LIZARDMAN_TFC.SHARE_TARGET_DIST
local tornsRange = TUNING.LIZARDMAN_TFC.ATTACK_RANGE
local tornsDamage = TUNING.LIZARDMAN_TFC.TORNS_DAMAGE

local function OnNewTarget(inst, data)
	if inst.components.sleeper:IsAsleep() then
		inst.components.sleeper:WakeUp()
	end
end

local function Retarget(inst)
local player = GetClosestInstWithTag("player", inst, 70)
if player then return inst.components.combat:SetTarget(player) end
    local notags = {}
    notags = {"FX", "NOCLICK", "INLIMBO", "lizardman", "player"}
	return FindEntity(inst, targetDist, function(guy)
		return  inst.components.combat:CanTarget(guy)
	end, nil, notags)
end

local function KeepTarget(inst, target)
	return inst.components.combat:CanTarget(target) and inst:GetDistanceSqToInst(target) <= (keepDistSq)
end

local function OnAttacked(inst, data)
    local function IsArmored()
        return data.attacker.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) 
            and data.attacker.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) 
    end

    if data.attacker == nil 
        or data.attacker.components.combat == nil 
        or data.attacker.components.health == nil 
    then 
        return 
    end

	inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, shareDist, 
        function(dude) 
            return dude:HasTag("lizardman") 
                and not dude.components.health:IsDead() 
        end, 5)

    if data.attacker:IsNear(inst, tornsRange) then
        if data.attacker.components.inventory == nil then
            data.attacker.components.health:DoDelta(tornsDamage, false, nil, false, inst, false)
            data.attacker:PushEvent("thorns")
        elseif not IsArmored() then
            data.attacker.components.health:DoDelta(tornsDamage, false, nil, false, inst, false)
            data.attacker:PushEvent("thorns")
        end
    end
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, 
        shareDist, 
        function(dude) 
            return dude:HasTag("lizardman") 
                and not dude.components.health:IsDead() 
        end, 5)
end

local function MakeWeapon(inst)
    if inst.components.inventory ~= nil then
        local weapon = CreateEntity()
        weapon.entity:AddTransform()
        MakeInventoryPhysics(weapon)
        weapon:AddComponent("weapon")
        weapon.components.weapon:SetDamage(TUNING.LIZARDMAN_TFC.DAMAGE)--TUNING.SPIDER_SPITTER_DAMAGE_RANGED)
        weapon.components.weapon:SetRange(TUNING.LIZARDMAN_TFC.DIST_ATTACK_RANGE, TUNING.LIZARDMAN_TFC.DIST_ATTACK_RANGE + 4)
        weapon.components.weapon:SetProjectile("lizardman_spit_tfc")
        weapon:AddComponent("inventoryitem")
        weapon.persists = false
        weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
        weapon:AddComponent("equippable")
        inst.weapon = weapon
        inst.components.inventory:Equip(inst.weapon)
        inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
    end
end

local function PlaceBanner(inst)
    SpawnPrefab("lizardman_banner_tfc").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function GetDebugString(inst)
    return string.format("last banner %i", GetTime() - inst.bannerLastTime)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    inst.entity:AddPhysics()

    inst.DynamicShadow:SetSize(2, .75)
    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 100, .75)

    inst.AnimState:SetBank("snapper")
    inst.AnimState:SetBuild("lavaarena_snapper_basic")
    inst.AnimState:PlayAnimation("idle_loop")

    --inst.AnimState:AddOverrideBuild("fossilized")

    inst:AddTag("character")
    inst:AddTag("scarytoprey")
    --inst:AddTag("hostile")
    inst:AddTag("lizardman")
	inst:AddTag("Arena")

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    --inst.components.talker.colour = Vector3(133/255, 140/255, 167/255)
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter()

    --fossilizable (from fossilizable component) added to pristine state for optimization
    --inst:AddTag("fossilizable")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
	inst.components.locomotor.runspeed = TUNING.LIZARDMAN_TFC.SPEED

	inst:SetStateGraph("SGlizardman_tfc")
	inst:SetBrain(require "brains/lizardman_tfcbrain")

	inst:AddComponent("knownlocations")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.LIZARDMAN_TFC.HEALTH)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.LIZARDMAN_TFC.DAMAGE)
	inst.components.combat:SetAttackPeriod(TUNING.LIZARDMAN_TFC.ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(5, Retarget)
	inst.components.combat:SetRange(TUNING.LIZARDMAN_TFC.DIST_ATTACK_RANGE)
	inst.components.combat.battlecryenabled = false

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("lizardman")

	inst:AddComponent("inspectable")
    inst:AddComponent("inventory")
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.LIZARDMAN }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetCanEatRaw()
    inst.components.eater.strongstomach = true

    inst:AddComponent("sleeper")
    
    MakeMediumFreezableCharacter(inst, "body")
    MakeMediumBurnableCharacter(inst, "body")

    inst:ListenForEvent("attacked", OnAttacked)
    MakeWeapon(inst)

    inst.bannerLastTime = GetTime()

    inst.PlaceBanner = PlaceBanner
    inst.debugstringfn = GetDebugString

    return inst
end

--range attack--------------------------
----------------------------------------
local function OnThrown(inst) 
    inst:Show() 
    inst.AnimState:PlayAnimation("idle_loop")
end

local function OnHit(inst) 
    inst.AnimState:PlayAnimation("blast")
    inst:ListenForEvent("animover", function(inst) inst:Remove() end)
end

local function OnMiss(inst) 
    inst.AnimState:PlayAnimation("disappear")
    inst:ListenForEvent("animover", function(inst) inst:Remove() end)
end

local function fxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddPhysics()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("gooball_fx")
    inst.AnimState:SetBuild("gooball_fx")
    inst.AnimState:PlayAnimation("idle_loop")
    inst.AnimState:SetMultColour(0.4, 1, 0.2, 1)
    inst.Transform:SetScale(0.6, 0.6, 0.6)
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
    inst.components.projectile:SetHoming(false)
    inst.components.projectile:SetHitDist(1.0)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(OnMiss)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetLaunchOffset(Vector3(2, 0.7, 2))

    return inst
end

local function OnBannerDeath(inst)
    inst.AnimState:PlayAnimation("break", false)
end

local function bannerfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddPhysics()

    inst.Transform:SetSixFaced()

    MakeObstaclePhysics(inst, 0.5)

    inst.AnimState:SetBank("lavaarena_battlestandard")
    inst.AnimState:SetBuild("lavaarena_battlestandard")
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)

    inst:AddTag("lizardman")
    inst:AddTag("banner")
	inst:AddTag("Arena")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(100)

	inst:AddComponent("combat")
	--inst:AddComponent("lootdropper")

    inst:AddComponent("inspectable")
    
    inst:ListenForEvent("death", OnBannerDeath)
    inst:DoTaskInTime(10, function(inst) inst.components.health:DoDelta(-100) end)
    
    --MakeMediumBurnableCharacter(inst)

    return inst
end

return Prefab("lizardman_tfc", fn, assets, prefabs),
    Prefab("lizardman_spit_tfc", fxfn, assets_fx),
    Prefab("lizardman_banner_tfc", bannerfn, assets_banner)
