require "brains/sharxbrain"
require "stategraphs/SGsharxunderwater"

local trace = function() end

local assets=
{
	Asset("ANIM", "anim/sharxunderwater.zip"),
	Asset("ANIM", "anim/sharx_build.zip"),	
}

local prefabs =
{
    "shark_fin",
	--"shark_gills",
	"monstermeat",
	--"redgem",
	--"bluegem",
}

SetSharedLootTable( 'sharxunderwater',
{
    {'monstermeat', 1.000},
    {'shark_fin',  0.250},
    {'houndstooth',  0.125},
})
 
local 	    SHARX_HEALTH = 300
local 	    SHARX_DAMAGE = 20
local 	    SHARX_ATTACK_PERIOD = 1.5
local 	    SHARX_TARGET_DIST = 20
local     SHARX_SPEED = 10
 
 
local SHARE_TARGET_DIST = 30


local NO_TAGS = {"FX", "NOCLICK","DECOR","INLIMBO"}


local function retargetfn(inst)
    local notags = {"FX", "NOCLICK","INLIMBO", "sharx"}
    local yestags = nil

    local dist = TUNING.HOUND_TARGET_DIST
    return FindEntity(inst, dist, function(guy) 
	   return inst.components.combat:CanTarget(guy)
    end, yestags, notags)
end

local function KeepTarget(inst, target)
    local shouldkeep = inst.components.combat:CanTarget(target) and (not inst:HasTag("pet_hound") or inst:IsNear(target, TUNING.HOUND_FOLLOWER_TARGET_KEEP))
    --local onboat = target.components.driver and target.components.driver:GetIsDriving()
    return shouldkeep
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("sharx")  and not dude.components.health:IsDead() end, 5)
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude:HasTag("sharx")  and not dude.components.health:IsDead() end, 5)
end

local function OnNewTarget(inst, data)
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
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

local function fncommon()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	--local shadow = inst.entity:AddDynamicShadow()
	--shadow:SetSize( 2.5, 1.5 )
    inst.Transform:SetFourFaced()
    inst.entity:AddNetwork()
	
    inst.entity:AddDynamicShadow()
    inst.DynamicShadow:SetSize(2.5, 1.5)	
	
	
	
	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("sharx")
    inst:AddTag("aquatic")
	
    MakeCharacterPhysics(inst, 10, .5)
--    MakePoisonableCharacter(inst)
     
    anim:SetBank("sharxunderwater")
    anim:SetBuild("sharx_build")
    anim:PlayAnimation("idle")
	
	inst.AnimState:OverrideSymbol("droplet", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("ripple_end", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("ripple_still", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("ripple2", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("ripple3", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("ripple4", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("ripple55", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("ripple88", "sharx_build", "")		
	inst.AnimState:OverrideSymbol("splash", "sharx_build", "")		
	inst.AnimState:OverrideSymbol("water_shadow", "sharx_build", "")	
	inst.AnimState:OverrideSymbol("1", "sharx_build", "")
	inst.AnimState:OverrideSymbol("2", "sharx_build", "")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    	
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = SHARX_SPEED
    inst:SetStateGraph("SGsharxunderwater")

    inst:AddComponent("follower")
    
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(SHARX_HEALTH)
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED
    
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(SHARX_DAMAGE)
    inst.components.combat:SetAttackPeriod(SHARX_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetHurtSound( "dontstarve_DLC002/creatures/sharx/hurt")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('sharxunderwater')
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper.onlysleepsfromitems = true 
    
    inst:ListenForEvent("newcombattarget", OnNewTarget)

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)

    MakeMediumFreezableCharacter(inst, "sharx_body")
    local brain = require "brains/sharxbrain"
    inst:SetBrain(brain)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

local function fndefault()
	local inst = fncommon(Sim)
	
    --MakeMediumFreezableCharacter(inst, "hound_body")
    --MakeMediumBurnableCharacter(inst, "hound_body")
	return inst
end



return Prefab( "monsters/sharxunderwater", fndefault, assets, prefabs)
