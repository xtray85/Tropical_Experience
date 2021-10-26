require "stategraphs/SGsnowbeetle"

local DUNG_BEETLE_RUN_SPEED = 6
local DUNG_BEETLE_WALK_SPEED = 3.5	
local DUNG_BEETLE_HEALTH = 60

local assets=
{
	Asset("ANIM", "anim/dung_beetle_basic.zip"),
	Asset("ANIM", "anim/snow_beetle_build.zip"),
}

local prefabs =
{
    "snowbigball",
    "monstermeat",
--    "chitin",
}


SetSharedLootTable( 'snowbeetle',
{
    {'monstermeat',  1},
--    {'chitin',    0.5},

})

local beetlesounds = 
{
    scream = "dontstarve_DLC003/creatures/dungbeetle/scream",
    hurt = "dontstarve_DLC003/creatures/dungbeetle/hit",
}

local brain = require "brains/dungbeetlebrain"

local function OnWake(inst)

end

local function OnSleep(inst)

end

local function falloffdung(inst)
    inst:PushEvent("bumped")
end

local function OnAttacked(inst, data)
    local freezetask = inst:DoTaskInTime(1, function() 
        if inst:HasTag("hasdung") and not inst.components.freezable:IsFrozen() then
            falloffdung(inst)        
        end
    end)
end

local function HitShake()
    TheCamera:Shake("VERTICAL", 0.1, 0.01, 1)
end

local function oncollide(inst, other)

    if inst.sg:HasStateTag("running") and inst:HasTag("hasdung")  then

        if other then
            HitShake()    
            falloffdung(inst)
        end 
    end

end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 2, 1.5)
    inst.entity:AddNetwork()

    inst.Transform:SetSixFaced()
	MakeCharacterPhysics(inst, 1, 0.5)

    inst:AddTag("hasdung")	
	
    anim:SetBank("dung_beetle")
    anim:SetBuild("snow_beetle_build")
    if inst:HasTag("hasdung") then
        anim:PlayAnimation("ball_idle")
    else
        anim:PlayAnimation("idle")
    end
 
    inst:AddTag("animal") 
    inst:AddTag("snowbeetle")  
 	inst:AddTag("walrus")
	inst:AddTag("houndfriend")	
 
 	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
 
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = DUNG_BEETLE_RUN_SPEED
    inst.components.locomotor.walkspeed = DUNG_BEETLE_WALK_SPEED
	
    inst.data = {}  
    
    inst:AddComponent("knownlocations")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(DUNG_BEETLE_HEALTH)
    inst.components.health.murdersound = "dontstarve/rabbit/scream_short"
    
    MakeSmallBurnableCharacter(inst, "body")
    MakeTinyFreezableCharacter(inst, "body")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('snowbeetle')
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst, viewer)
    if not inst:HasTag("hasdung") then
    return "UNDUNGED"
    end
    end
    inst:AddComponent("sleeper")

    inst:SetBrain(brain)
    inst:SetStateGraph("SGsnowbeetle")
    inst.Physics:SetCollisionCallback(oncollide)	
	
    inst.sg:GoToState("idle")  
	
	inst.OnEntityWake = OnWake
	inst.OnEntitySleep = OnSleep    
    
    inst.sounds = beetlesounds

    inst.OnSave = function(inst, data)
    end        
    
    inst.OnLoad = function(inst, data)
    end
  
    inst:ListenForEvent("attacked", OnAttacked)

    return inst
end

return Prefab( "forest/animals/snowbeetle", fn, assets, prefabs) 
