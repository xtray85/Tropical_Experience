local assets =
{
	Asset("ANIM", "anim/fish_swordfish.zip"),
    Asset("ANIM", "anim/fish_swordfish01.zip"),
    Asset("ANIM", "anim/fish_med01.zip"),
}

local invassets=
{
	Asset("ANIM", "anim/fish_swordfish.zip"),
}

local prefabs =
{
	"dead_swordfish"
}

local	    SWORDFISH_WALK_SPEED = 5
local	    SWORDFISH_RUN_SPEED = 8
local	    SWORDFISH_HEALTH = 300
local	    SWORDFISH_WANDER_DIST = 10
local	    SWORDFISH_TARGET_DIST =12
local	    SWORDFISH_DAMAGE = 30
local    SWORDFISH_ATTACK_PERIOD = 2

local brain = require "brains/swordfishbrain"


local function retargetfn(inst)
    local dist = SWORDFISH_TARGET_DIST
    local notags = {"FX", "NOCLICK","INLIMBO", "swordfish"}
    local yestags = {"aquatic"}
    return FindEntity(inst, dist, function(guy) 
		local shouldtarget =  inst.components.combat:CanTarget(guy)
        return shouldtarget
    end, yestags, notags)
end

local function KeepTarget(inst, target)
    local shouldkeep = inst.components.combat:CanTarget(target)
    local onwater = target:HasTag("aquatic")
    --local onboat = target.components.driver and target.components.driver:GetIsDriving()
    return shouldkeep and onwater
end

local function SetLocoState(inst, state)
    --"above" or "below"
    inst.LocoState = string.lower(state)
end

local function IsLocoState(inst, state)
    return inst.LocoState == string.lower(state)
end

local function ShouldSleep(inst)
 return false
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

local function swordfishfn()

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()
	inst:AddTag("aquatic")
	inst:AddTag("swordfish")
	inst:AddTag("scarytoprey")
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	local anim = inst.entity:AddAnimState()

--	MakePoisonableCharacter(inst)
    MakeCharacterPhysics(inst, 5, 1.25)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)	
	

    inst.AnimState:SetBank("swordfish")
    inst.AnimState:SetBuild("fish_swordfish")  
    inst.AnimState:PlayAnimation("shadow", true)
    anim:SetRayTestOnBB(true)
    anim:SetOrientation(ANIM_ORIENTATION.OnGround)
    
    anim:SetLayer(LAYER_BACKGROUND)
    anim:SetSortOrder(3)
	
	inst:AddTag("tropicalspawner")	

	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		

	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = SWORDFISH_WALK_SPEED
	inst.components.locomotor.runspeed = SWORDFISH_RUN_SPEED	
    inst:AddComponent("inspectable")
    inst.no_wet_prefix = true

    inst:AddComponent("knownlocations")
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(SWORDFISH_DAMAGE)
    inst.components.combat:SetAttackPeriod(SWORDFISH_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    --inst.components.combat.hiteffectsymbol = "chest"
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(SWORDFISH_HEALTH)

    inst:AddComponent("eater")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"dead_swordfish"})

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    MakeMediumFreezableCharacter(inst, "swordfish_body")

    SetLocoState(inst, "below")
    inst.SetLocoState = SetLocoState
    inst.IsLocoState = IsLocoState

	inst:SetStateGraph("SGswordfish")

	inst:SetBrain(brain)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)		

	return inst
end

return Prefab("ocean/objects/swordfish", swordfishfn, assets, prefabs)
