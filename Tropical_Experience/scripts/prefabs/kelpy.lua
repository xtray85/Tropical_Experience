require "brains/kelpybrain"
require "stategraphs/SGkelpy"

local assets=
{
    Asset("ANIM", "anim/kelpy_actions.zip"),
    Asset("ANIM", "anim/kelpy_basic.zip"),
    Asset("ANIM", "anim/kelpy_build.zip"),
	Asset("SOUND", "sound/beefalo.fsb"),
}

local prefabs =
{
    --TODO !!
}

SetSharedLootTable( 'kelpy',
{
    {'kelp',             	   0.50},
    {'plantmeat',              0.50},	
})

local sounds = 
{
    walk = "dontstarve/creatures/spider/walk_spider",
    grunt = "dontstarve/creatures/spider/attack_grunt",
    yell = "dontstarve/creatures/spider/scream",
    swish = "dontstarve/creatures/spider/scream",
    curious = "dontstarve/creatures/spider/scream",
    angry = "dontstarve/creatures/spider/scream",
}

local function Retarget(inst)
local player = GetClosestInstWithTag("player", inst, 5)
if player then return inst.components.combat:SetTarget(player) 
end
end

local function KeepTarget(inst, target)
    return true 
end

local function OnAttacked(inst, data)
if inst.components.combat and data.attacker then
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30,function(dude)
        return dude:HasTag("kelpy") and not dude:HasTag("player") and not dude.components.health:IsDead()
    end, 5)
	end
end

local function OnEat(inst, data)

end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.sounds = sounds
	local shadow = inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()	
	
	shadow:SetSize( 6, 2 )
    inst.Transform:SetFourFaced()
    inst.foodItemsEatenCount = 0
    
--    MakePoisonableCharacter(inst)
    MakeCharacterPhysics(inst, 100, .5)
    local scale = 0.8
    inst.Transform:SetScale(scale, scale, scale)
    
    inst:AddTag("kelpy")

    anim:SetBank("kelpy")
    anim:SetBuild("kelpy_build")
    anim:PlayAnimation("idle_loop", true)

    inst:AddTag("animal")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end			
    
--	inst:AddComponent("eater")
--    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.SEEDS })
--    inst.components.eater:SetOnEatFn(OnEat)
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(25)
    inst.components.combat:SetRetargetFunction(1, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)	
     
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.BEEFALO_HEALTH)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('kelpy')    
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("knownlocations")
    
    inst:ListenForEvent("attacked", OnAttacked)


    MakeLargeBurnableCharacter(inst, "swap_fire")
    MakeLargeFreezableCharacter(inst, "beefalo_body")
    
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 3.5
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    
    local brain = require "brains/kelpybrain"
    inst:SetBrain(brain)
    inst:SetStateGraph("SGkelpy")
    return inst
end

return Prefab( "forest/animals/kelpy", fn, assets, prefabs) 
