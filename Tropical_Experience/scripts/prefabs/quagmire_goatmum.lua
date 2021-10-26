local assets =
{
    Asset("ANIM", "anim/quagmire_goatmom_basic.zip"),
}


local prefabs =
{
    "meat",
}

local loot =
{
    "meat",
}

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 40

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker and inst.components.combat:CanTarget(attacker) then
        inst.components.combat:SetTarget(attacker)
        local targetshares = MAX_TARGET_SHARES
        if inst.components.homeseeker and inst.components.homeseeker.home then
            local home = inst.components.homeseeker.home
            if home and home.components.childspawner and inst:GetDistanceSqToInst(home) <= SHARE_TARGET_DIST*SHARE_TARGET_DIST then
                targetshares = targetshares - home.components.childspawner.childreninside
                home.components.childspawner:ReleaseAllChildren(attacker)
            end
            inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude)
                return dude.components.homeseeker
                       and dude.components.homeseeker.home
                       and dude.components.homeseeker.home == home
            end, targetshares)
        end
    end
end

local function retargetfn(inst, target)

end

local function keeptargetfn(inst, target)
    local home = inst.components.homeseeker and inst.components.homeseeker.home
    if home then
        return home:GetDistanceSqToInst(target) < TUNING.MERM_DEFEND_DIST*TUNING.MERM_DEFEND_DIST
               and home:GetDistanceSqToInst(inst) < TUNING.MERM_DEFEND_DIST*TUNING.MERM_DEFEND_DIST
    end
    return inst.components.combat:CanTarget(target)
end

local function fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

     MakeCharacterPhysics(inst, 50, .4)

	inst.DynamicShadow:SetSize(2, 1)

    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(1.3, 1.3, 1.3)
--	inst.Transform:SetRotation(180)

	local minimap = inst.entity:AddMiniMapEntity()
--	minimap:SetIcon("minimap_octopusking.png")
    inst.MiniMapEntity:SetPriority(1)

    inst.AnimState:SetBank("quagmire_goatmom_basic")
    inst.AnimState:SetBuild("quagmire_goatmom_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("hat")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = TUNING.MERM_RUN_SPEED
    inst.components.locomotor.walkspeed = TUNING.MERM_WALK_SPEED

--    inst:AddComponent("health")
--    inst.components.health:SetMaxHealth(50000)

--    inst:AddComponent("combat")
--    inst.components.combat.hiteffectsymbol = "pig_torso"
--	inst.components.combat:SetAttackPeriod(TUNING.MERM_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(TUNING.MERM_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, retargetfn)
--    inst.components.combat:SetKeepTargetFunction(keeptargetfn)	
	
	
    MakeHauntablePanic(inst)

--    inst:AddComponent("lootdropper")
--    inst.components.lootdropper:SetLoot(loot)

    inst:AddComponent("inventory")

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")

--    MakeMediumBurnableCharacter(inst, "pig_torso")
--    MakeMediumFreezableCharacter(inst, "pig_torso")

--    inst:ListenForEvent("attacked", OnAttacked)    
	
	inst:SetStateGraph("SGgoatmum")

local brain = require "brains/goatbrain"  --"brains/goatmumbrain"
    inst:SetBrain(brain)

	inst:AddComponent("store")

    return inst	
end

return Prefab("quagmire_goatmum", fn, assets, prefabs)
