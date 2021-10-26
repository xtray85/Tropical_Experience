require "brains/rabid_beetlebrain"
require "stategraphs/SGrabid_beetle"

local trace = function() end


local RABID_BEETLE_HEALTH = 60
local RABID_BEETLE_DAMAGE =  10
local RABID_BEETLE_ATTACK_PERIOD = 2
local RABID_BEETLE_TARGET_DIST = 20
local RABID_BEETLE_SPEED = 12
local RABID_BEETLE_FOLLOWER_TARGET_DIST = 10
local RABID_BEETLE_FOLLOWER_TARGET_KEEP = 20

local assets=
{
	Asset("ANIM", "anim/rabid_beetle.zip"),
	Asset("SOUND", "sound/hound.fsb"),
}

local prefabs =
{
	"chitin",
    "lightbulb",
}

SetSharedLootTable( 'rabid_beetle',
{
    {'chitin', 0.2},
    {'lightbulb', 0.08},
})
 
SetSharedLootTable( 'rabid_beetle_inventory',
{
    {'lightbulb', 1},
    {'chitin', 0.6},
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
    return not TheWorld.state.isday
    and not (inst.components.combat and inst.components.combat.target)
    and not (inst.components.burnable and inst.components.burnable:IsBurning() )
    and (not inst.components.homeseeker or inst:IsNear(inst.components.homeseeker.home, SLEEP_NEAR_HOME_DISTANCE))
end

local function OnNewTarget(inst, data)
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function retargetfn(inst)
    local dist = RABID_BEETLE_TARGET_DIST
    local notags = {"FX", "NOCLICK","INLIMBO", "wall", "rabid_beetle", "cocoon"}
    return FindEntity(inst, dist, function(guy) 
		local shouldtarget = inst.components.combat:CanTarget(guy)
        return shouldtarget
    end, nil, notags)
end

local function KeepTarget(inst, target)
    local shouldkeep = inst.components.combat:CanTarget(target) and inst:IsNear(target, RABID_BEETLE_FOLLOWER_TARGET_KEEP)
--    local onboat = target.components.driver and target.components.driver:GetIsDriving()
    return shouldkeep
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("rabid_beetle") and not dude.components.health:IsDead() end, 5)
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude:HasTag("rabid_beetle") and not dude.components.health:IsDead() end, 5)
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

--local function OnDropped(inst)
--    inst.components.lootdropper:SetChanceLootTable('rabid_beetle')
--    inst.sg:GoToState("idle")

--    if inst.brain then
--        inst.brain:Start()
--    end
--    if inst.sg then
--        inst.sg:Start()
--    end    
--end

--local function OnPickedUp(inst)
--    inst.components.lootdropper:SetChanceLootTable('rabid_beetle_inventory')
--end

local function fncommon()
	local inst = CreateEntity()
	inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 2.5, 1.5 )
    inst.Transform:SetFourFaced()
	
	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("animal")
    inst:AddTag("insect")    
    inst:AddTag("hostile")
    inst:AddTag("rabid_beetle")
    inst:AddTag("canbetrapped")
    inst:AddTag("smallcreature")
	
    MakeCharacterPhysics(inst, 5, .5)
 --   MakePoisonableCharacter(inst)

    inst.Transform:SetScale(0.6,0.6,0.6)  
     
    anim:SetBank("rabid_beetle")
    anim:SetBuild("rabid_beetle")
    anim:PlayAnimation("idle")
 
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = RABID_BEETLE_SPEED

    inst:AddComponent("follower")
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(RABID_BEETLE_HEALTH)
    inst.components.health.murdersound = "dontstarve_DLC003/creatures/enemy/rabid_beetle/death"
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED
    
--    inst:AddComponent("inventoryitem")
--    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
--    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickedUp)
--    inst.components.inventoryitem.canbepickedup = false
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(RABID_BEETLE_DAMAGE)
    inst.components.combat:SetAttackPeriod(RABID_BEETLE_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetRange(2)
    -- inst.components.combat:SetHurtSound("dontstarve_DLC003/creatures/enemy/rabid_beetle/hurt")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('rabid_beetle')
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    inst:ListenForEvent("newcombattarget", OnNewTarget)
	
    MakeMediumFreezableCharacter(inst, "bottom")
    MakeMediumBurnableCharacter(inst, "bottom")	
	
	inst:SetStateGraph("SGrabid_beetle")

    local brain = require "brains/rabid_beetlebrain"
    inst:SetBrain(brain)

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)

    return inst
end


return Prefab( "monsters/rabid_beetle", fncommon, assets, prefabs)