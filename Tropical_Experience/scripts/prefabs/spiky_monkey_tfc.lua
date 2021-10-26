--THE FORGE CREATURES
--Created by ksaab
--feel free to use it

local assets =
{
    Asset("ANIM", "anim/lavaarena_trails_basic.zip"),
}

SetSharedLootTable( "spiky_monkey",
{
--    {"meat", 1.0},
--    {"meat", 1.0},
})

local targetDist = TUNING.SPIKY_MONKEY_TFC.TARGET_DIST
local keepDistSq = TUNING.SPIKY_MONKEY_TFC.KEEP_TARGET_DIST * TUNING.SPIKY_MONKEY_TFC.KEEP_TARGET_DIST
local slamRadius = TUNING.SPIKY_MONKEY_TFC.SLAM_RADIUS
local slamDamage = TUNING.SPIKY_MONKEY_TFC.SLAM_DAMAGE

local function OnNewTarget(inst, data)
	if inst.components.sleeper:IsAsleep() then
		inst.components.sleeper:WakeUp()
	end
end

local function Retarget(inst)
local player = GetClosestInstWithTag("player", inst, 70)
if player and not inst:HasTag("nohat") then return inst.components.combat:SetTarget(player) end
	return FindEntity(inst, targetDist, function(guy)
		return  inst.components.combat:CanTarget(guy)
	end, {"monster"}, {"FX", "NOCLICK", "INLIMBO"})
end

local function KeepTarget(inst, target)
	return inst.components.combat:CanTarget(target) and inst:GetDistanceSqToInst(target) <= keepDistSq
end

local function OnAttacked(inst, data)
    if data.attacker == nil and inst.components.combat:CanTarget(data.attacker) then 
        return 
    end

	inst.components.combat:SetTarget(data.attacker)
end

local function OnAttackOther(inst, data)

end

local function SlamAttack(inst)
    local notags = { "shadow", "playerghost", "INLIMBO", "NOCLICK", "FX" }
    local x, y, z = inst.Transform:GetWorldPosition()
    for _, v in pairs(TheSim:FindEntities(x, y, z, slamRadius, {"_combat"}, notags)) do
        if v ~= inst 
            and v:IsValid() 
            and v.entity:IsVisible() 
            and v.components.combat ~= nil 
        then
            v.components.combat:GetAttacked(inst, slamDamage)
            if v:HasTag("player") then
                v.sg:GoToState("knockback", { knocker = inst, radius = 5 })
            end 
        end
    end
    inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/turtillus/grunt")
    inst.components.combat.laststartattacktime = GetTime()
    inst.lastTimeSlam = GetTime()
end

--[[ local function GetDebugString(inst)
    return string.format("last banner %i", GetTime() - inst.bannerLastTime)
end ]]

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    inst.entity:AddPhysics()

    inst.DynamicShadow:SetSize(4, 1.75)
    inst.Transform:SetFourFaced()

    MakeCharacterPhysics(inst, 500, 1.75)

    inst.AnimState:SetBank("trails")
    inst.AnimState:SetBuild("lavaarena_trails_basic")
    inst.AnimState:PlayAnimation("idle_loop")

    inst:AddTag("character")
    inst:AddTag("scarytoprey")
	inst:AddTag("Arena")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
	inst.components.locomotor.runspeed = TUNING.SPIKY_MONKEY_TFC.SPEED

	inst:SetStateGraph("SGspikymonkey_tfc")
	inst:SetBrain(require "brains/spikymonkey_tfcbrain")

	inst:AddComponent("knownlocations")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.SPIKY_MONKEY_TFC.HEALTH)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(TUNING.SPIKY_MONKEY_TFC.DAMAGE)
	inst.components.combat:SetAttackPeriod(TUNING.SPIKY_MONKEY_TFC.ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(5, Retarget)
	inst.components.combat:SetRange(TUNING.SPIKY_MONKEY_TFC.ATTACK_RANGE)
	inst.components.combat.battlecryenabled = true

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("spiky_monkey")

	inst:AddComponent("inspectable")
    inst:AddComponent("inventory")
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetCanEatRaw()
    inst.components.eater.strongstomach = true

    inst:AddComponent("sleeper")
    
    MakeMediumFreezableCharacter(inst, "body")
    MakeMediumBurnableCharacter(inst, "body")

    inst.lastTimeSlam = GetTime()

    inst.SlamAttack = SlamAttack

    inst:ListenForEvent("attacked", OnAttacked)

    --inst.debugstringfn = GetDebugString

    return inst
end

return Prefab("spiky_monkey_tfc", fn, assets, prefabs)
