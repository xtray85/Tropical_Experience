require "brains/pangoldenbrain"
require "stategraphs/SGPangolden"

local assets=
{
	Asset("ANIM", "anim/pango_basic.zip"),
    Asset("ANIM", "anim/pango_action.zip"),
}

local PANGOLDEN_HEALTH = 500
local PANGOLDEN_DAMAGE = 34
local PANGOLDEN_TARGET_DIST = 5

local PANGOLDEN_CHASE_DIST = 30 
local PANGOLDEN_BALL_DEFENCE = 0.75

local prefabs =
{
    "meat",
}

SetSharedLootTable( 'pangolden',
{
    {'meat',            1.00},
    {'meat',            1.00},
    {'meat',            1.00},
})

local sounds = 
{
    walk = "dontstarve/beefalo/walk",
    grunt = "dontstarve/beefalo/grunt",
    yell = "dontstarve/beefalo/yell",
    swish = "dontstarve/beefalo/tail_swish",
    curious = "dontstarve/beefalo/curious",
    angry = "dontstarve/beefalo/angry",
}

local DRUNK_GOLD = 1/8
local EATEN_GOLD = 1/3

local function Retarget(inst)

end

local function KeepTarget(inst, target)
    return distsq(Vector3(target.Transform:GetWorldPosition() ), Vector3(inst.Transform:GetWorldPosition() ) ) < PANGOLDEN_CHASE_DIST * PANGOLDEN_CHASE_DIST
end

local function OnNewTarget(inst, data)
    if inst.components.follower and data and data.target and data.target == inst.components.follower.leader then
        inst.components.follower:SetLeader(nil)
    end
end

local function OnAttacked(inst, data)
if data and data.attacker then
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30,function(dude)
        return dude:HasTag("pangolden") and not dude:HasTag("player") and not dude.components.health:IsDead()
    end, 5)
	
end
end

local function special_action(act)
    if act.doer.puddle and act.doer.puddle.stage > 0 then
        act.doer.puddle:shrink()          
        act.doer.goldlevel = act.doer.goldlevel + DRUNK_GOLD
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.sounds = sounds
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 6, 2 )
    inst.Transform:SetFourFaced()
    inst.entity:AddNetwork()
    
--    MakePoisonableCharacter(inst)
    MakeCharacterPhysics(inst, 100, .5)
    
    inst:AddTag("pango_baisc")
    anim:SetBank("pango")
    anim:SetBuild("pango_action")
    anim:PlayAnimation("idle_loop", true)
    
    inst:AddTag("pangolden")
    inst:AddTag("animal")
    inst:AddTag("largecreature")
 
	if not TheWorld.ismastersim then
		return inst
	end  
 
    inst:AddComponent("eater")
    inst.components.eater.foodprefs = {"GOLDDUST"}
    inst.components.eater.ablefoods = {"GOLDUST"}
    inst.components.eater.oneatfn = function()
        inst.goldlevel = inst.goldlevel + EATEN_GOLD 
    end

    inst:AddComponent("combat")
--    inst.components.combat.hiteffectsymbol = "pang_bod"
    inst.components.combat:SetDefaultDamage(PANGOLDEN_DAMAGE)
    inst.components.combat:SetRetargetFunction(1, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
     
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(PANGOLDEN_HEALTH)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('pangolden')    
    
    inst:AddComponent("inspectable")
    inst.entity:SetPristine()
  
    inst:AddComponent("knownlocations")

    inst.special_action = special_action

    MakeLargeBurnableCharacter(inst, "swap_fire")
    MakeLargeFreezableCharacter(inst, "pang_bod")
    
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 2.5
    inst.components.locomotor.runspeed = 8
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    
    local brain = require "brains/pangoldenbrain"
    inst:SetBrain(brain)
    inst:SetStateGraph("SGPangolden")



    inst.goldlevel = 0

    inst.OnSave = function(inst, data)
            data.goldlevel = inst.goldlevel              
        end        
        
    inst.OnLoad = function(inst, data)    
            if data then                
                if data.goldlevel then
                    inst.goldlevel = data.goldlevel 
                end
            end
        end    

    return inst
end

return Prefab( "forest/animals/pangolden", fn, assets, prefabs) 
