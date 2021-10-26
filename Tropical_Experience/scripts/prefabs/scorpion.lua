require "brains/spiderbrain"
require "stategraphs/SGscorpion"

local SCORPION_HEALTH = 200
local SCORPION_DAMAGE = 20
local SCORPION_ATTACK_PERIOD = 3
local SCORPION_TARGET_DIST = 4
local SCORPION_INVESTIGATETARGET_DIST = 6
local SSCORPION_WAKE_RADIUS = 4
local SCORPION_FLAMMABILITY = .33
local SCORPION_SUMMON_WARRIORS_RADIUS = 12
local SCORPION_EAT_DELAY = 1.5
local SCORPION_ATTACK_RANGE = 3		
local SCORPION_STING_RANGE = 2

local SCORPION_WALK_SPEED = 3
local SCORPION_RUN_SPEED = 5

local assets =
{
	Asset("ANIM", "anim/scorpion_basic.zip"),
	Asset("ANIM", "anim/scorpion_build.zip"),
	Asset("SOUND", "sound/spider.fsb"),
}
    
    
local prefabs =
{
	"chitin",
    "monstermeat",
    "venomgland",
    "stinger",
}

SetSharedLootTable( 'scorpion',
{
    {'monstermeat',  1.00},
    {'chitin',  0.3},
    {'venomgland',  0.3},
    {'stinger',  0.3},
})


local SHARE_TARGET_DIST = 30

local function NormalRetarget(inst)
    local targetDist = SCORPION_TARGET_DIST
    if inst.components.knownlocations:GetLocation("investigate") then
        targetDist = SCORPION_INVESTIGATETARGET_DIST
    end
    return FindEntity(inst, targetDist, 
        function(guy) 
            if inst.components.combat:CanTarget(guy) then
                return guy:HasTag("character") or guy:HasTag("pig")
            end
    end)
end

local function FindWarriorTargets(guy)
	return (guy:HasTag("character") or guy:HasTag("pig"))
               and inst.components.combat:CanTarget(guy)
               and not (inst.components.follower and inst.components.follower.leader == guy)
end

local function keeptargetfn(inst, target)
   return target
          and target.components.combat
          and target.components.health
          and not target.components.health:IsDead()
          and not (inst.components.follower and inst.components.follower.leader == target)
end

local function ShouldSleep(inst)
    return false
--[[    
    return TheWorld.state.isday
           and not (inst.components.combat and inst.components.combat.target)
           and not (inst.components.homeseeker and inst.components.homeseeker:HasHome() )
           and not (inst.components.burnable and inst.components.burnable:IsBurning() )
           and not (inst.components.follower and inst.components.follower.leader)
           ]]
end

local function ShouldWake(inst)
    return true
    --[[
    return TheWorld.state.isnight
           or (inst.components.combat and inst.components.combat.target)
           or (inst.components.homeseeker and inst.components.homeseeker:HasHome() )
           or (inst.components.burnable and inst.components.burnable:IsBurning() )
           or (inst.components.follower and inst.components.follower.leader)
           or (inst:HasTag("spider_warrior") and FindEntity(inst, SPIDER_WARRIOR_WAKE_RADIUS, function(...) return FindWarriorTargets(inst, ...) end ))
           ]]
end

--[[
local function DoReturn(inst)
	if inst.components.homeseeker and inst.components.homeseeker.home and inst.components.homeseeker.home.components.childspawner then
		inst.components.homeseeker.home.components.childspawner:GoHome(inst)
	end
end

local function StartDay(inst)
	if inst:IsAsleep() then
		DoReturn(inst)	
	end
end


local function OnEntitySleep(inst)
	if TheWorld.state.isday then
		DoReturn(inst)
	end
end
]]
--[[
local function SummonFriends(inst, attacker)
	local den = GetClosestInstWithTag("spiderden",inst, SPIDER_SUMMON_WARRIORS_RADIUS)
	if den and den.components.combat and den.components.combat.onhitfn then
		den.components.combat.onhitfn(den, attacker)
	end
end
]]

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude:HasTag("scorpion") and not dude.components.health:IsDead() end, 5)
end

local function StartNight(inst)
    inst.components.sleeper:WakeUp()
end

local function create_scorpion(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLightWatcher()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize( 1.5, .5 )
    inst.Transform:SetFourFaced()
   -- inst.Transform:SetScale(0.75,0.75,0.75)
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .5)
--    MakePoisonableCharacter(inst)
    

    inst.AnimState:SetBank("scorpion")
    inst.AnimState:SetBuild("scorpion_build")
    inst.AnimState:PlayAnimation("idle")
  
    inst:AddTag("monster")
    inst:AddTag("insect")
    inst:AddTag("hostile")
    inst:AddTag("scarytoprey")    
    inst:AddTag("scorpion")
    inst:AddTag("canbetrapped")  
	
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
  
    -- locomotor must be constructed before the stategraph!
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = SCORPION_WALK_SPEED
    inst.components.locomotor.runspeed = SCORPION_RUN_SPEED

    
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('scorpion')
    
    ---------------------        
    MakeMediumBurnableCharacter(inst, "body")
    MakeMediumFreezableCharacter(inst, "body")
    inst.components.burnable.flammability = SCORPION_FLAMMABILITY
    ---------------------       
    

    inst:AddComponent("follower")

    ------------------
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(SCORPION_HEALTH)
    ------------------

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)    
    inst.components.combat:SetDefaultDamage(SCORPION_DAMAGE)
    inst.components.combat:SetAttackPeriod(SCORPION_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(1, NormalRetarget)
    inst.components.combat:SetHurtSound("dontstarve/creatures/spider/hit_response")
    inst.components.combat:SetRange(SCORPION_ATTACK_RANGE, SCORPION_ATTACK_RANGE)
    ------------------
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWake)
    ------------------
    
    inst:AddComponent("knownlocations")
    ------------------
    
    inst:AddComponent("eater")
	inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    
    ------------------
    
    inst:AddComponent("inspectable")  
    ------------------
	
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")			
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_SMALL
    
    inst:SetStateGraph("SGscorpion")
    local brain = require "brains/spiderbrain"
    inst:SetBrain(brain)  

    inst:ListenForEvent("attacked", OnAttacked)
	
    return inst
end

return Prefab( "forest/monsters/scorpion", create_scorpion, assets, prefabs)