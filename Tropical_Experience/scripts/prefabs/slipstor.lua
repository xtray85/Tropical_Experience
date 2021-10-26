local brain = require "brains/slipstorbrain"

local assets =
{
    Asset("ANIM", "anim/slipstor_build.zip"),
    Asset("ANIM", "anim/slipstor_basic.zip"),
    Asset("ANIM", "anim/slipstor_actions.zip"),
    Asset("ANIM", "anim/slipstor_attacks.zip"),
}

local prefabs =
{
    "meat",
    "log", 
    "character_fire",
    "livinglog",
}

local function SetLeifScale(inst, scale)
    inst._scale = scale ~= 1 and scale or nil

    inst.Transform:SetScale(scale, scale, scale)
    inst.Physics:SetCapsule(.5 * scale, 1)
    inst.DynamicShadow:SetSize(4 * scale, 1.5 * scale)

    inst.components.locomotor.walkspeed = 1.5 * scale

    inst.components.combat:SetDefaultDamage(TUNING.LEIF_DAMAGE * scale)
    inst.components.combat:SetRange(3 * scale)

    local health_percent = inst.components.health:GetPercent()
    inst.components.health:SetMaxHealth(TUNING.LEIF_HEALTH * scale)
    inst.components.health:SetPercent(health_percent, true)
end

local function onpreloadfn(inst, data)
    if data ~= nil and data.leifscale ~= nil then
        SetLeifScale(inst, data.leifscale)
    end
end

local function onloadfn(inst, data)
if data == nil then return end
	if data.entrada then inst.entrada = data.entrada end
    if data ~= nil then
        if data.sleep_time ~= nil then
            inst.components.sleeper.testtime = data.sleep_time
        end
        if data.sleeping then
            inst.components.sleeper:GoToSleep()
        end
    end
end

local function onsavefn(inst, data)
    data.leifscale = inst._scale
	data.entrada = inst.entrada
    if inst.components.sleeper:IsAsleep() then
        data.sleeping = true
        data.sleep_time = inst.components.sleeper.testtime
    end
end

local function CalcSanityAura(inst)
    return inst.components.combat.target ~= nil and -TUNING.SANITYAURA_LARGE or -TUNING.SANITYAURA_MED
end

local function OnBurnt(inst)
    if inst.components.propagator and inst.components.health and not inst.components.health:IsDead() then
        inst.components.propagator.acceptsheat = true
    end
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
end

local function onspawnspider(inst, spider)
    spider.sg:GoToState("taunt")
end

local function IsDefender(child)
    return child.prefab == "slip"
end

local function SpawnDefenders(inst, attacker)
    if not inst.components.health:IsDead() then
 --       inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/spiderLair_hit")
 --       inst.AnimState:PlayAnimation(inst.anims.hit)
 --       inst.AnimState:PushAnimation(inst.anims.idle)
        if inst.components.childspawner ~= nil then
            local max_release_per_stage = { 2, 4, 6 }
            local num_to_release = math.min(1 , inst.components.childspawner.childreninside)
            local num_warriors = math.min(num_to_release, 1)
            num_to_release = 1
            num_warriors = 1
            num_warriors = num_warriors - inst.components.childspawner:CountChildrenOutside(IsDefender)
            for k = 1, num_to_release do
                inst.components.childspawner.childname = k <= num_warriors and "slip" or "slip"
                local spider = inst.components.childspawner:SpawnChild()
                if spider ~= nil and attacker ~= nil and spider.components.combat ~= nil then
                    spider.components.combat:SetTarget(attacker)
                    spider.components.combat:BlankOutAttacks(1.5 + math.random() * 2)
					inst.sg:GoToState("spawnin")
                end
            end
            inst.components.childspawner.childname = "slip"

            local emergencyspider = inst.components.childspawner:TrySpawnEmergencyChild()
            if emergencyspider ~= nil then
                emergencyspider.components.combat:SetTarget(attacker)
                emergencyspider.components.combat:BlankOutAttacks(1.5 + math.random() * 2)
            end
        end
    end
end

local function IsInvestigator(child)
    return child.components.knownlocations:GetLocation("investigate") ~= nil
end

local function SpawnInvestigators(inst, data)
    if not inst.components.health:IsDead() and not (inst.components.freezable ~= nil and inst.components.freezable:IsFrozen()) then
--        inst.AnimState:PlayAnimation(inst.anims.hit)
--        inst.AnimState:PushAnimation(inst.anims.idle)
        if inst.components.childspawner ~= nil then
            local max_release_per_stage = { 1, 2, 3 }
            local num_to_release = math.min(max_release_per_stage3 or 1, inst.components.childspawner.childreninside)
            num_to_release = 3
            local num_investigators = inst.components.childspawner:CountChildrenOutside(IsInvestigator)
            num_to_release = num_to_release - num_investigators
            local targetpos = data ~= nil and data.target ~= nil and data.target:GetPosition() or nil
            for k = 1, num_to_release do
                local spider = inst.components.childspawner:SpawnChild()
                if spider ~= nil and targetpos ~= nil then
                    spider.components.knownlocations:RememberLocation("investigate", targetpos)
                end
            end
        end
    end
end

--local function StartSpawning(inst)
--    if inst.components.childspawner ~= nil and
--        not (inst.components.freezable ~= nil and
--            inst.components.freezable:IsFrozen()) and
--        not TheWorld.state.iscaveday then
--        inst.components.childspawner:StartSpawning()
--    end
--end

local function StopSpawning(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:StopSpawning()
    end
end

--local function OnIsCaveDay(inst, iscaveday)
--    if iscaveday then
--        StopSpawning(inst)
--    else
--        StartSpawning(inst)
--    end
--end

--local function OnInit(inst)
--    inst:WatchWorldState("iscaveday", OnIsCaveDay)
--    OnIsCaveDay(inst, TheWorld.state.iscaveday)
--end

local function OnHaunt(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_HALF then
        local target = FindEntity(
            inst,
            25,
            CanTarget,
            { "_combat", "_health", "character" }, --see entityreplica.lua
            { "player", "spider", "INLIMBO" }
        )
        if target ~= nil then
            SpawnDefenders(inst, target)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
            return true
        end
    end

    if math.random() <= TUNING.HAUNT_CHANCE_RARE then
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
        return true
    end

    return false
end


function OnDeadSlipstor(inst)
local x, y, z = inst.Transform:GetLocalPosition()

--inst:DoTaskInTime(50*FRAMES, function(inst)
--if inst.entrada == nil then 
--local fx = SpawnPrefab("woodlegs_key2")
--if fx then fx.Transform:SetPosition(x, y, z) end
--inst.entrada = 1
--end 
--end)
 
        local spawner = SpawnPrefab("slipstor_spawner")
        if spawner then
           spawner.Transform:SetPosition(x, y, z)
        end
 end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 1000, .5)

    inst.DynamicShadow:SetSize(4, 1.5)
    inst.Transform:SetFourFaced()

    inst:AddTag("epic")
--    inst:AddTag("monster")
--    inst:AddTag("hostile")
    inst:AddTag("largecreature")
	inst:AddTag("slipstor")
	inst:AddTag("slip")

    inst.AnimState:SetBank("slipstor")
    inst.AnimState:SetBuild("slipstor_build")
    inst.AnimState:PlayAnimation("idle_loop", true)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    local color = .5 + math.random() * .5
    inst.AnimState:SetMultColour(color, color, color, 1)

    ------------------------------------------

    inst.OnPreLoad = onpreloadfn
    inst.OnLoad = onloadfn
    inst.OnSave = onsavefn

    ------------------------------------------

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 2.5
    inst:SetStateGraph("SGslipstor")

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    MakeLargeBurnableCharacter(inst, "marker")
    inst.components.burnable.flammability = TUNING.LEIF_FLAMMABILITY
    inst.components.burnable:SetOnBurntFn(OnBurnt)
    inst.components.propagator.acceptsheat = true

    MakeHugeFreezableCharacter(inst, "marker")
    ------------------
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(3500)
	inst.components.health:StartRegen(1, 3)
	
	    inst:AddComponent("childspawner")
        inst.components.childspawner.childname = "slip"
        inst.components.childspawner:SetRegenPeriod(90)
        inst.components.childspawner:SetSpawnPeriod(5)

        inst.components.childspawner.emergencychildname = "slip"
        inst.components.childspawner.emergencychildrenperplayer = 1
		
		
		inst.components.childspawner:SetMaxChildren(9)
        inst.components.childspawner:SetMaxEmergencyChildren(8)
        inst.components.childspawner:SetEmergencyRadius(20)

        inst.components.childspawner:SetSpawnedFn(onspawnspider)
	
	
        inst:AddComponent("hauntable")
        inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_MEDIUM
        inst.components.hauntable:SetOnHauntFn(OnHaunt)

    ------------------

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.LEIF_DAMAGE)
    inst.components.combat.playerdamagepercent = TUNING.LEIF_DAMAGE_PLAYER_PERCENT
    inst.components.combat.hiteffectsymbol = "marker"
    inst.components.combat:SetRange(3)
    inst.components.combat:SetAttackPeriod(TUNING.LEIF_ATTACK_PERIOD)
	inst.components.combat:SetOnHit(SpawnDefenders)

    ------------------------------------------
    MakeHauntableIgnite(inst)
    ------------------------------------------

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
--	inst.components.sleeper:SetSleepTest(NormalShouldSleep)
--    inst.components.sleeper:SetWakeTest(NormalShouldWake)

--        inst:DoTaskInTime(0, OnInit)
    ------------------------------------------

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"steelwool", "steelwool", "steelwool", "monstermeat"})
--	inst:AddComponent("knownlocations")
	inst:ListenForEvent("death", OnDeadSlipstor)
    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()
    ------------------------------------------

    inst:SetBrain(brain)

    inst:ListenForEvent("attacked", OnAttacked)


    inst.SetLeifScale = SetLeifScale

    return inst
end

return Prefab("slipstor", fn, assets, prefabs)
