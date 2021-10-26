local assets =
{
    Asset("ANIM", "anim/grotto_grub.zip"),
    Asset("ANIM", "anim/grotto_grubmore.zip"),
}

local brain = require "brains/grottogrubbrain"

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

local function NormalRetargetFn(inst)
    return FindEntity(inst, TUNING.PIG_TARGET_DIST,
        function(guy)
            if guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) then
                if guy:HasTag("player") and guy.components.inventory and guy:GetDistanceSqToInst(inst) < 25 then return guy end
            end
        end)
end

local function NormalKeepTargetFn(inst, target)
    --give up on dead guys, or guys in the dark, or werepigs
    return inst.components.combat:CanTarget(target)
end

local function OnAttacked(inst, data)
    local attacker = data.attacker
    inst:ClearBufferedAction()

    if attacker.prefab == "deciduous_root" and attacker.owner then 
        OnAttackedByDecidRoot(inst, attacker.owner)
    elseif attacker.prefab ~= "deciduous_root" then
        inst.components.combat:SetTarget(attacker)
        inst.components.combat:ShareTarget(attacker, 30, function(dude) return dude:HasTag("ant") end, 5)
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
	inst.Transform:SetScale(1.5, 1.5, 1.5)
--    inst.DynamicShadow:SetSize(1, .75)
--	inst.Transform:SetNoFaced()
--    inst.Transform:SetSixFaced()
	inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("grub")
    inst.AnimState:SetBuild("grotto_grub")
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
    inst.components.health:SetMaxHealth(250)	
	
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })	
	
	inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = 1
    inst.components.locomotor.walkspeed = 1
	
	inst:AddComponent("knownlocations")
	
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(DefaultSleepTest)
    inst.components.sleeper:SetWakeTest(DefaultWakeTest)
	
    inst:AddComponent("combat")
--    inst.components.combat.hiteffectsymbol = "antman_torso"	
    inst.components.combat:SetDefaultDamage(34 * 2/3)
    inst.components.combat:SetAttackPeriod(3)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)
    inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)
    inst.components.combat:SetTarget(nil)	
	
	inst:AddComponent("homeseeker")
	
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"quagmire_crabmeat"})
	
--	inst:WatchWorldState("isday", OnIsDay)

--	inst:DoTaskInTime(0, OnIsDay)

	inst:SetStateGraph("SGgrotogrub")
	
    inst:SetBrain(brain)

	inst:AddComponent("inspectable")
	
    inst:ListenForEvent("attacked", OnAttacked)	
	
    return inst
end

return Prefab("grotto_grub", crab, assets)
