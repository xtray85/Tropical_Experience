require "stategraphs/SGcrocodog"

local trace = function() end

local assets=
{
	Asset("ANIM", "anim/crocodog_basic.zip"),
	Asset("ANIM", "anim/crocodog.zip"),
	Asset("ANIM", "anim/crocodog_poison.zip"),
	Asset("ANIM", "anim/crocodog_water.zip"),
    Asset("ANIM", "anim/crocodog_basic_water.zip"),
	Asset("ANIM", "anim/watercrocodog.zip"),
	Asset("ANIM", "anim/watercrocodog_poison.zip"),
	Asset("ANIM", "anim/watercrocodog_water.zip"),
}


local        HOUND_HEALTH = 150
local        HOUND_DAMAGE = 20
local        HOUND_ATTACK_PERIOD = 2
local        HOUND_TARGET_DIST = 20
local        HOUND_SPEED = 10
local        CLAYHOUND_SPEED = 8.5

local        HOUND_FOLLOWER_TARGET_DIST = 10
local        HOUND_FOLLOWER_TARGET_KEEP = 20
local        HOUND_FOLLOWER_AGGRO_DIST = 8
local        HOUND_FOLLOWER_RETURN_DIST = 12

local        FIREHOUND_HEALTH = 100
local        FIREHOUND_DAMAGE = 30
local        FIREHOUND_ATTACK_PERIOD = 2
local        FIREHOUND_SPEED = 10

local       ICEHOUND_HEALTH = 100
local        ICEHOUND_DAMAGE = 30
local        ICEHOUND_ATTACK_PERIOD = 2
local        ICEHOUND_SPEED = 10

local SANITYAURA_MED = 100/(30*5)

local prefabs =
{
    "houndstooth",
	"monstermeat",
--    "ice_puddle",
}

SetSharedLootTable( 'crocodog',
{
    {'monstermeat', 1.000},
    {'houndstooth',  0.125},
    {'houndstooth',  0.125},
})
 
SetSharedLootTable( 'crocodog_poison',
{
    {'monstermeat', 1.0},
    {'houndstooth', 1.0},
    {'venomgland',      0.2},
})

SetSharedLootTable( 'crocodog_water',
{
    {'monstermeat', 1.0},
    {'houndstooth', 1.0},
    {'houndstooth', 1.0},
    {'seaweed',   0.2},
})

local WAKE_TO_FOLLOW_DISTANCE = 8
local SLEEP_NEAR_HOME_DISTANCE = 10
local SHARE_TARGET_DIST = 30
local HOME_TELEPORT_DIST = 30

local NO_TAGS = {"FX", "NOCLICK","DECOR","INLIMBO"}

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or (inst.components.follower and inst.components.follower.leader and not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE))
end

local function ShouldSleep(inst)
    return inst:HasTag("pet_hound")
    and not TheWorld.state.isday
    and not (inst.components.combat and inst.components.combat.target)
    and not (inst.components.burnable and inst.components.burnable:IsBurning() )
    and (not inst.components.homeseeker or inst:IsNear(inst.components.homeseeker.home, SLEEP_NEAR_HOME_DISTANCE))
end

local function OnEntityWake(inst)
	inst.components.tiletracker:Start()
end

--local function OnEntitySleep(inst)
--	inst.components.tiletracker:Stop()
--end

local function OnNewTarget(inst, data)
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end


local function retargetfn(inst)
    local dist = HOUND_TARGET_DIST
    if inst:HasTag("pet_hound") then
        dist = HOUND_FOLLOWER_TARGET_DIST
    end
    local notags = {"FX", "NOCLICK","INLIMBO", "wall", "houndmound", "hound", "houndfriend"}
    return FindEntity(inst, dist, function(guy) 
		local shouldtarget = inst.components.combat:CanTarget(guy)
        return shouldtarget
    end, nil, notags)
end

local function KeepTarget(inst, target)
    local shouldkeep = inst.components.combat:CanTarget(target) and (not inst:HasTag("pet_hound") or inst:IsNear(target, HOUND_FOLLOWER_TARGET_KEEP))
    return shouldkeep
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("hound") or dude:HasTag("houndfriend") and not dude.components.health:IsDead() end, 5)
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude:HasTag("hound") or dude:HasTag("houndfriend") and not dude.components.health:IsDead() end, 5)
end

local function GetReturnPos(inst)
    local rad = 2
    local pos = inst:GetPosition()
    trace("GetReturnPos", inst, pos)
    local angle = math.random()*2*PI
    pos = pos + Point(rad*math.cos(angle), 0, -rad*math.sin(angle))
    trace("    ", pos)
    return pos:Get()
end

local function DoReturn(inst)
    if inst.components.homeseeker and inst.components.homeseeker:HasHome()  then
        if inst:HasTag("pet_hound") then
            if inst.components.homeseeker.home:IsAsleep() and not inst:IsNear(inst.components.homeseeker.home, HOME_TELEPORT_DIST) then
                local x, y, z = GetReturnPos(inst.components.homeseeker.home)
                inst.Physics:Teleport(x, y, z)
                trace("hound warped home", x, y, z)
            end
        elseif inst.components.homeseeker.home.components.childspawner then
            inst.components.homeseeker.home.components.childspawner:GoHome(inst)
        end
    end
end

local function OnWaterChange(inst, onwater)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/emerge")

	if onwater then
        if inst.DynamicShadow then
            inst.DynamicShadow:Enable(false)
        end
    
		inst.AnimState:SetBank("crocodog_water")
        if inst:HasTag("poisonous") then
            inst.AnimState:SetBuild("watercrocodog_poison")
        elseif inst:HasTag("waterous") then
            inst.AnimState:SetBuild("watercrocodog_water")
            inst:RemoveTag("enable_shake")
        else
            inst.AnimState:SetBuild("watercrocodog")
        end
	else
        if inst.DynamicShadow then
            inst.DynamicShadow:Enable(true)
        end

		inst.AnimState:SetBank("crocodog")
        if inst:HasTag("poisonous") then
            inst.AnimState:SetBuild("crocodog_poison")
        elseif inst:HasTag("waterous") then
            inst.AnimState:SetBuild("crocodog_water")
            inst:AddTag("enable_shake")
        else
            inst.AnimState:SetBuild("crocodog")
        end
	end
    
 --   local splash = SpawnPrefab("splash_water")
local splash = SpawnPrefab("frogsplash")	

    local ent_pos = Vector3(inst.Transform:GetWorldPosition())
    splash.Transform:SetPosition(ent_pos.x, ent_pos.y, ent_pos.z)
    
    if inst.sg then
        inst.sg:GoToState("idle")
    end
end

local function OnNight(inst)
    if inst:IsAsleep() then
        DoReturn(inst)  
    end
end


local function OnEntitySleep(inst)
inst.components.tiletracker:Stop()
    if not TheWorld.state.isday then
        DoReturn(inst)
    end
end

local function OnSave(inst, data)
    data.ispet = inst:HasTag("pet_hound")
end
        
local function OnLoad(inst, data)
    if data and data.ispet then
		inst:AddTag("pet_hound")

        if inst.sg then
            inst.sg:GoToState("idle")
        end
    end
end

local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end

local function fndefault()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 3, 1.5 )
    inst.Transform:SetFourFaced()
	inst.entity:AddNetwork()
	
	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("hound")
	inst:AddTag("aquatic")
    inst:AddTag("crocodog")
	inst:AddTag("tropicalspawner")	
	
    MakeCharacterPhysics(inst, 10, .5)
	inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)	
    --MakePoisonableCharacter(inst)
     
    anim:SetBank("crocodog_water")
    anim:SetBuild("watercrocodog")
    anim:PlayAnimation("idle")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    MakeMediumFreezableCharacter(inst, "Crocodog_Body") 
    MakeMediumBurnableCharacter(inst, "Crocodog_Body") 
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = HOUND_SPEED


    inst:AddComponent("tiletracker")
	inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)
	inst.wasintaunt = false
    
    inst:AddComponent("follower")
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(HOUND_HEALTH)
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -SANITYAURA_MED
    
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(HOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(HOUND_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/crocodog/hit")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('crocodog')
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    inst:ListenForEvent("newcombattarget", OnNewTarget)

    inst:ListenForEvent( "dusktime", function() OnNight( inst ) end, TheWorld) 
    inst:ListenForEvent( "nighttime", function() OnNight( inst ) end, TheWorld) 
    inst.OnEntitySleep = OnEntitySleep

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep
    
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)
     inst:SetStateGraph("SGcrocodog")
 local brain = require "brains/crocodogbrain"
    inst:SetBrain(brain)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)	
	
    return inst
end

local function fnpoison()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 3, 1.5 )
    inst.Transform:SetFourFaced()
	inst.entity:AddNetwork()
	
	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("hound")
	inst:AddTag("aquatic")
    inst:AddTag("crocodog")
	inst:AddTag("poisonous")
	inst:AddTag("tropicalspawner")	
	
    MakeCharacterPhysics(inst, 10, .5)
	inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)
    --MakePoisonableCharacter(inst)
     
    anim:SetBank("crocodog_water")
    inst.AnimState:SetBuild("watercrocodog_poison")
    anim:PlayAnimation("idle")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    MakeMediumFreezableCharacter(inst, "Crocodog_Body") 

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = FIREHOUND_SPEED


    inst:AddComponent("tiletracker")
	inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)
	inst.wasintaunt = false
    
    inst:AddComponent("follower")
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    inst.components.eater.strongstomach = true -- can eat monster meat!
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(FIREHOUND_HEALTH)
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -SANITYAURA_MED

	inst:AddComponent("poisonous")    
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(FIREHOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(FIREHOUND_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/crocodog/hit")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('crocodog')
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    inst:ListenForEvent("newcombattarget", OnNewTarget)

    inst:ListenForEvent( "dusktime", function() OnNight( inst ) end, TheWorld) 
    inst:ListenForEvent( "nighttime", function() OnNight( inst ) end, TheWorld) 
    inst.OnEntitySleep = OnEntitySleep
	
	inst.components.lootdropper:AddRandomLoot("venomgland", 1.00)
    inst.components.lootdropper:SetChanceLootTable('crocodog_poison')

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep
    
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)
	
		inst:ListenForEvent("death", function(inst)
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/death", "explosion")
	end)

    inst:SetStateGraph("SGcrocodog")	
	local brain = require "brains/crocodogbrain"
    inst:SetBrain(brain)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)
	
    return inst
end

local function fnwater()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 3, 1.5 )
    inst.Transform:SetFourFaced()
	inst.entity:AddNetwork()
	
	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("hound")
	inst:AddTag("aquatic")
    inst:AddTag("crocodog")
	inst:AddTag("waterous")
	inst:AddTag("tropicalspawner")	
	
    MakeCharacterPhysics(inst, 10, .5)
	inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)	
    --MakePoisonableCharacter(inst)
     
    anim:SetBank("crocodog_water")
	inst.AnimState:SetBuild("watercrocodog_water")
    anim:PlayAnimation("idle")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    MakeMediumBurnableCharacter(inst, "Crocodog_Body") 	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = ICEHOUND_SPEED


    inst:AddComponent("tiletracker")
	inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)
	inst.wasintaunt = false
    
    inst:AddComponent("follower")
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(ICEHOUND_HEALTH)
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -SANITYAURA_MED
    
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(ICEHOUND_DAMAGE)
    inst.components.combat:SetAttackPeriod(ICEHOUND_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/crocodog/hit")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('crocodog_water')
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    inst:ListenForEvent("newcombattarget", OnNewTarget)

    inst:ListenForEvent( "dusktime", function() OnNight( inst ) end, TheWorld) 
    inst:ListenForEvent( "nighttime", function() OnNight( inst ) end, TheWorld) 

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep
    
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)

    inst:SetStateGraph("SGcrocodog")	
 local brain = require "brains/crocodogbrain"
    inst:SetBrain(brain)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)	

	
    return inst
end

return Prefab( "monsters/crocodog", fndefault, assets, prefabs),
		Prefab( "monsters/poisoncrocodog", fnpoison, assets, prefabs),
		Prefab( "monsters/watercrocodog", fnwater, assets, prefabs)
