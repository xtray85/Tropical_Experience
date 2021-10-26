local assets =
{
    Asset("ANIM", "anim/quagmire_rubble.zip"),
	Asset("ANIM", "anim/quagmire_pebble_crab.zip"),
}

local brain = require "brains/pebblecrabbrain"

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst)
end

local function gosleep(inst)
	inst:PushEvent("gotosleep")
end

local function wakeup(inst)
	inst:PushEvent("onwakeup")
end

local function OnIsDay(inst)
    if not TheWorld.state.isday then
		inst:DoTaskInTime(2.5 + 2 * math.random(), gosleep)
	--	inst:PushEvent("gotosleep")
	else
		inst:DoTaskInTime(0, wakeup)
	--	inst:PushEvent("onwakeup")
	end
end

local function crab()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 1, .25)

    inst.DynamicShadow:SetSize(1, .75)
    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("quagmire_pebble_crab")
    inst.AnimState:SetBuild("quagmire_pebble_crab")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("animal")
    inst:AddTag("prey")
    inst:AddTag("smallcreature")
    inst:AddTag("canbetrapped")
    inst:AddTag("cattoy")
    inst:AddTag("crab") 	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.RABBIT_HEALTH)	
	
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })	
	
	inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = 1
    inst.components.locomotor.walkspeed = 1
	
	inst:AddComponent("knownlocations")
	
	inst:SetStateGraph("SGpebblecrab")
	
	inst:AddComponent("homeseeker")
	
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"quagmire_crabmeat"})
	
--	inst:WatchWorldState("isday", OnIsDay)

--	inst:DoTaskInTime(0, OnIsDay)
	
    inst:SetBrain(brain)

	inst:AddComponent("inspectable")
	
    return inst
end

return Prefab("quagmire_pebblecrab", crab, assets)
