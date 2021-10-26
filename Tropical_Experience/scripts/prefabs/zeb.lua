require("brains/zebbrain")
require "stategraphs/SGzeb"

local ZEB_DAMAGE = 20
local ZEB_ATTACK_RANGE = 3
local ZEB_ATTACK_PERIOD = 2
local ZEB_WALK_SPEED = 6
local ZEB_RUN_SPEED = 10
local ZEB_TARGET_DIST = 5
local ZEB_CHASE_DIST = 30
local ZEB_FOLLOW_TIME = 30
local ZEB_MATING_SEASON_BABYDELAY = 480*1.5
local ZEB_MATING_SEASON_BABYDELAY_VARIANCE = 0.5*480 


local assets =
{
    Asset("ANIM", "anim/zeb_build.zip"),
    Asset("ANIM", "anim/zeb.zip"),
    Asset("SOUND", "sound/lightninggoat.fsb"),
}

local prefabs =
{
    "meat",
}

SetSharedLootTable( 'zeb',
{
    {'meat',             1.00},
    {'meat',             1.00},
    {'meat',             0.50},
})

local function RetargetFn(inst)
    if inst.charged then
        -- Look for non-wall targets first
        local targ = FindEntity(inst, ZEB_TARGET_DIST, function(guy)
            return not guy:HasTag("zeb") and 
                    inst.components.combat:CanTarget(guy) and 
                    not guy:HasTag("wall")
        end)
        -- If none, look for walls
        if not targ then
            targ = FindEntity(inst, ZEB_TARGET_DIST, function(guy)
                return not guy:HasTag("zeb") and 
                        inst.components.combat:CanTarget(guy)
            end)
        end
        return targ
    end
end

local function KeepTargetFn(inst, target)
    if target:HasTag("wall") then 
        local newtarg = FindEntity(inst, ZEB_TARGET_DIST, function(guy)
            return not guy:HasTag("zeb") and 
                    inst.components.combat:CanTarget(guy) and 
                    not guy:HasTag("wall")
        end)
        return newtarg == nil
    else
        return true
    end
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, 20, function(dude) return dude:HasTag("zeb") end, 3) 
end

local function getstatus(inst, viewer)

end

local function fn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()	

	shadow:SetSize(1.75,.75)
    
    inst.Transform:SetFourFaced()
    
	MakeCharacterPhysics(inst, 100, 1)

    anim:SetBank("zeb")
    anim:SetBuild("zeb_build")
    anim:PlayAnimation("idle_loop", true)
    
    ------------------------------------------

    inst:AddTag("zeb")
    inst:AddTag("animal")    
    ------------------------------------------

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
	
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(350)
	
	
    
    ------------------
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(ZEB_DAMAGE)
    inst.components.combat:SetRange(ZEB_ATTACK_RANGE)
    inst.components.combat.hiteffectsymbol = "sprint"
    inst.components.combat:SetAttackPeriod(ZEB_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(1, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetHurtSound("dontstarve_DLC003/creatures/zeb/attack")
    ------------------------------------------
 
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(4)
    
    ------------------------------------------

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('zeb') 
    
    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    ------------------------------------------

    inst:AddComponent("knownlocations")

    ------------------------------------------

    inst:ListenForEvent("attacked", OnAttacked)

    ------------------------------------------

    MakeMediumBurnableCharacter(inst, "spring")
    MakeMediumFreezableCharacter(inst, "spring")

    ------------------------------------------

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = ZEB_WALK_SPEED
    inst.components.locomotor.runspeed = ZEB_RUN_SPEED
	
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")		

    inst:SetStateGraph("SGzeb")
    local brain = require("brains/zebbrain")
    inst:SetBrain(brain)

    return inst
end

return Prefab( "common/monsters/zeb", fn, assets, prefabs) 
