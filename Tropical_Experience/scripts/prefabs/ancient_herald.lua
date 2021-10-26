local brain = require "brains/ancientheraldbrain"
require "stategraphs/SGancientherald"

local ANCIENT_HERALD_HEALTH = 8000
local ANCIENT_HERALD_DAMAGE = 50

local assets =
{
    Asset("ANIM", "anim/ancient_spirit.zip"),
}

local prefabs =
{
    "ancient_remnant",
    "nightmarefuel",
    "armorvortexcloak",
}

local TARGET_DIST = 30

local function CalcSanityAura(inst, observer)
    if inst.components.combat.target then
        return -TUNING.SANITYAURA_HUGE
    else
        return -TUNING.SANITYAURA_LARGE
    end
    
    return 0
end

local function RetargetFn(inst)
    return FindEntity(inst, TARGET_DIST, function(guy)
        return inst.components.combat:CanTarget(guy)
               and not guy:HasTag("prey")
               and not guy:HasTag("smallcreature")
               and guy.components.combat.target == inst
--               and (inst.components.knownlocations:GetLocation("targetbase") == nil 
--			   or guy.components.combat.target == inst)
    end)
end


local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
end


local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
end

local function oncollide(inst, other)
    if not other:HasTag("tree") then return end
    
    local v1 = Vector3(inst.Physics:GetVelocity())
    if v1:LengthSq() < 1 then return end

    inst:DoTaskInTime(2*FRAMES, function()
        if other and other.components.workable and other.components.workable.workleft > 0 then
            SpawnPrefab("collapse_small").Transform:SetPosition(other:GetPosition():Get())
            other.components.workable:Destroy(inst)
        end
    end)

end

local loot = {}

SetSharedLootTable( 'ancientherald',
{
    {'nightmarefuel',              1.00},
    {'nightmarefuel',              1.00},
    {'nightmarefuel',              0.33},
    {'armorvortexcloak',              1.00},	
})

local function fn(Sim)    
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()	
    
    local s  = 1.25
    inst.Transform:SetScale(s,s,s)
    -- shadow:SetSize( 6, 3.5 )
    trans:SetSixFaced()

    MakeCharacterPhysics(inst, 1000, .5)

    inst:AddTag("epic")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("ancient")
    inst:AddTag("shadow")
    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")
    inst:AddTag("laser_immune")
--    inst:AddTag("notarget")
    inst:AddTag("ancient_herald")

    anim:SetBank("ancient_spirit")
    anim:SetBuild("ancient_spirit")
    anim:PlayAnimation("idle", true)
	
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    
    ------------------------------------------

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.GHOST_SPEED
    inst.components.locomotor.runspeed = TUNING.GHOST_SPEED
    --inst.components.locomotor.directdrive = true

    ------------------------------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    ------------------
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(ANCIENT_HERALD_HEALTH)

    ------------------
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(ANCIENT_HERALD_DAMAGE)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetRetargetFunction(3, RetargetFn)    
    ------------------------------------------

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('ancientherald')
	
    ------------------------------------------
    inst:SetStateGraph("SGancientherald")
    inst:SetBrain(brain)	
    
    ------------------------------------------
    inst:AddComponent("inspectable")
    ------------------------------------------
    
    inst:ListenForEvent("attacked", OnAttacked)

    inst.sg:GoToState("appear")

    inst:DoTaskInTime(0, function() 
        inst.home_pos = Point(inst.Transform:GetWorldPosition()) 
    end )
	
	inst:ListenForEvent("endaporkalypse", 
	function() 
    inst:Remove()
	end, TheWorld)	
	

    inst.summon_time = GetTime()
    inst.taunt_time = GetTime()

    return inst
end

return Prefab( "common/monsters/ancient_herald", fn, assets, prefabs)