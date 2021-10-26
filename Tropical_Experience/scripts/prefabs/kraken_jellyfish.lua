local assets=
{
	Asset("ANIM", "anim/jellyfish.zip"),
}

local prefabs=
{
	"jellyfish_dead",
}
local	    JELLYFISH_DAMAGE = 5
local 		JELLYFISH_HEALTH = 50
local       JELLYFISH_WALK_SPEED = 2

local function onattacked(inst, data)
    if data and data.attacker.components.health and data.attacker:HasTag("player") and not data.attacker.components.inventory:IsInsulated() then
            data.attacker.components.health:DoDelta(-JELLYFISH_DAMAGE)
            if data.attacker:HasTag("player") then
                data.attacker.sg:GoToState("electrocute")
            end
    end
end

local function ShouldSleep(inst)
 return false
end

local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	inst.sg:GoToState("some")
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    local physics = inst.entity:AddPhysics()
    MakeCharacterPhysics(inst, 1, 0.5)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("jellyfish")
    inst.AnimState:SetBuild("jellyfish")  
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("aquatic")	
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = JELLYFISH_WALK_SPEED 

    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
    inst.AnimState:SetLayer(LAYER_BELOW_GROUND)


    inst:AddComponent("combat")
    inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/jellyfish/hit")
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(JELLYFISH_HEALTH)

    MakeMediumFreezableCharacter(inst, "jelly")
    inst:ListenForEvent("attacked", onattacked)

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(ShouldSleep)
	
	inst:SetStateGraph("SGjellyfishkraken")
	local brain = require "brains/jellyfishbrain"
    inst:SetBrain(brain)	
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 10)	

    inst:SetPrefabNameOverride("jellyfish_planted")	
	
    return inst
end

return  Prefab( "common/inventory/kraken_jellyfish", fn, assets, prefabs)