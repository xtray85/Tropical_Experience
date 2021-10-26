
require "stategraphs/SGweevole"

local assets =
{
    Asset("ANIM", "anim/weevole.zip"),
}

local prefabs =
{
    "weevole_carapace",
}

SetSharedLootTable("weevole_loot",
{
    {'weevole_carapace',        1},
})

local WEEVOLE_WALK_SPEED = 5
local WEEVOLE_HEALTH = 150
local WEEVOLE_DAMAGE = 6
local WEEVOLE_PERIOD_MIN = 4
local WEEVOLE_PERIOD_MAX = 5
local WEEVOLE_ATTACK_RANGE = 5
local WEEVOLE_HIT_RANGE = 1.5
local WEEVOLE_MELEE_RANGE = 1.5
local WEEVOLE_RUN_AWAY_DIST = 3
local WEEVOLE_STOP_RUN_AWAY_DIST = 5
local WEEVOLE_TARGET_DIST = 6
local WEEVOLEDEN_MAX_WEEVOLES = 3

local brain = require "brains/weevolebrain"

local function retargetfn(inst)
    local dist = WEEVOLE_TARGET_DIST
    local notags = {"FX", "NOCLICK","INLIMBO", "wall", "weevole", "structure", "aquatic"}
    return FindEntity(inst, dist, function(guy)
        return  inst.components.combat:CanTarget(guy)
    end, nil, notags)
end

local function keeptargetfn(inst, target)
   return target ~= nil
        and target.components.combat ~= nil
        and target.components.health ~= nil
        and not target.components.health:IsDead()
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, 
		function(dude)
			return dude:HasTag("weevole")
				and not dude.components.health:IsDead()
		end, 10)
end

local function OnFlyIn(inst)
    inst.DynamicShadow:Enable(false)
    inst.components.health:SetInvincible(true)
    local x,y,z = inst.Transform:GetWorldPosition()
    inst.Transform:SetPosition(x,15,z)
end

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .5)

    inst.DynamicShadow:SetSize(1.5, .5)
    inst.Transform:SetSixFaced()

    inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("insect")
    inst:AddTag("hostile")
    inst:AddTag("canbetrapped")
    inst:AddTag("smallcreature")
    inst:AddTag("weevole")
    inst:AddTag("animal")

    inst.AnimState:SetBank("weevole")
    inst.AnimState:SetBuild("weevole")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    -- locomotor must be constructed before the stategraph!
    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    inst.components.locomotor.walkspeed = WEEVOLE_WALK_SPEED
	
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")		

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable("weevole_loot")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(WEEVOLE_HEALTH)

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetDefaultDamage(WEEVOLE_DAMAGE)
    inst.components.combat:SetAttackPeriod(GetRandomMinMax(WEEVOLE_PERIOD_MIN, WEEVOLE_PERIOD_MAX))
    inst.components.combat:SetRange(WEEVOLE_ATTACK_RANGE, WEEVOLE_HIT_RANGE)

    inst:AddComponent("knownlocations")
    inst:AddComponent("inspectable")

    inst:ListenForEvent("attacked", OnAttacked)

--    MakePoisonableCharacter(inst)

    inst:AddComponent("eater")
    inst.components.eater.foodprefs = { "WOOD","SEEDS" }
    inst.components.eater.ablefoods = { "WOOD","SEEDS" }
    --inst.OnEntitySleep = OnEntitySleep
    --inst.OnEntityWake = OnEntityWake

	--inst.FindNewHomeFn = FindNewHome
    
    inst:SetStateGraph("SGweevole")
    inst:SetBrain(brain)

    MakeSmallBurnableCharacter(inst, "body")
    MakeSmallFreezableCharacter(inst, "body")

	inst:ListenForEvent("fly_in", OnFlyIn) -- matches enter_loop logic so it does not happen a frame late

    return inst
end

return Prefab("weevole", fn, assets, prefabs)
