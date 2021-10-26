local assets =
{
    Asset("ANIM", "anim/quagmire_goatkid_basic.zip"),
	Asset("ANIM", "anim/quagmire_swampig_build.zip"),
}

local brain = require "brains/goatbrain"

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

    MakeObstaclePhysics(inst, 0.8, .4)

    inst.DynamicShadow:SetSize(1.5, 0.75)

    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(.8, .8, .8)
--	inst.Transform:SetRotation(180)

	local minimap = inst.entity:AddMiniMapEntity()
--	minimap:SetIcon("minimap_octopusking.png")
    inst.MiniMapEntity:SetPriority(1)

	inst.AnimState:SetBank("quagmire_goatkid_basic")
    inst.AnimState:SetBuild("quagmire_goatkid_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("hat")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
--	inst:AddComponent("locomotor")
--    inst.components.locomotor.runspeed = TUNING.MERM_RUN_SPEED
--    inst.components.locomotor.walkspeed = TUNING.MERM_WALK_SPEED

--    inst:AddComponent("health")
--    inst.components.health:SetMaxHealth(TUNING.MERM_HEALTH*1000)

--    inst:AddComponent("combat")
--    inst.components.combat.hiteffectsymbol = "pig_torso"
--	inst.components.combat:SetAttackPeriod(TUNING.MERM_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(TUNING.MERM_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, retargetfn)
--    inst.components.combat:SetKeepTargetFunction(keeptargetfn)	
	
	
    MakeHauntablePanic(inst)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)

    inst:AddComponent("inventory")

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")

    MakeMediumBurnableCharacter(inst, "pig_torso")
    MakeMediumFreezableCharacter(inst, "pig_torso")

--    inst:ListenForEvent("attacked", OnAttacked)    
	
	inst:SetStateGraph("SGgoat")

    inst:SetBrain(brain)
	inst:AddComponent("store")

    return inst	
end

local function fn1()

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 0.8, .4)

    inst.DynamicShadow:SetSize(1.5, 0.75)

    inst.Transform:SetFourFaced()
    inst.Transform:SetScale(.8, .8, .8)
--	inst.Transform:SetRotation(180)

	local minimap = inst.entity:AddMiniMapEntity()
--	minimap:SetIcon("minimap_octopusking.png")
    inst.MiniMapEntity:SetPriority(1)

	inst.AnimState:SetBank("quagmire_goatkid_basic")
    inst.AnimState:SetBuild("quagmire_goatkid_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("hat")
	
	inst:SetPrefabNameOverride("quagmire_goatkid")		

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    MakeHauntablePanic(inst)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)

    inst:AddComponent("inventory")

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")

    MakeMediumBurnableCharacter(inst, "pig_torso")
    MakeMediumFreezableCharacter(inst, "pig_torso")

--    inst:ListenForEvent("attacked", OnAttacked)    
	
	inst:SetStateGraph("SGgoat")

    inst:SetBrain(brain)
	inst:AddComponent("store")

    return inst	
end


local sounds = 
{
	talk = "dontstarve/quagmire/creature/goat_kid/talk",
	trade = "dontstarve/quagmire/creature/goat_kid/item_sold",
}

local function ontalk(inst)
    inst.SoundEmitter:PlaySound(inst.sounds.talk)
	
	local strid = math.random(#STRINGS.BILLY_GREETING)
	
	inst.components.talker:Say(STRINGS.BILLY_GREETING[strid])
end

local function ontrade(inst)
    inst.SoundEmitter:PlaySound(inst.sounds.trade)
	
	local strid = math.random(#STRINGS.GOATKID_TALK_TRADE)
	
	inst.components.talker:Say(STRINGS.GOATKID_TALK_TRADE[strid])
end

local function fnmerm1()

    local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddDynamicShadow()
		inst.entity:AddNetwork()

		MakeObstaclePhysics(inst, 0.2)
		
		inst.Transform:SetFourFaced()
		
		inst.AnimState:SetBank("pigman")
		inst.AnimState:SetBuild("merm_trader1_build")
		inst.AnimState:PlayAnimation("idle_loop", true)

		inst.DynamicShadow:SetSize(1.5, .75)

		inst:AddTag("character")
		inst:AddTag("merm")

		inst:AddComponent("talker")
		inst.components.talker.fontsize = 35
		inst.components.talker.font = TALKINGFONT
		inst.components.talker.offset = Vector3(0, -400, 0)
		inst.components.talker:MakeChatter()
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end
		
		inst.sounds = sounds
		
		inst:AddComponent("inspectable")
		inst:AddComponent("locomotor")
		inst:SetStateGraph("SGmermtrader")
		inst:SetBrain(brain)

		inst:AddComponent("store")		

    return inst	
end


local function fnmerm2()

    local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddDynamicShadow()
		inst.entity:AddNetwork()

		MakeObstaclePhysics(inst, 0.2)
		
		inst.Transform:SetFourFaced()
		
		inst.AnimState:SetBank("pigman")
		inst.AnimState:SetBuild("merm_trader2_build")
		inst.AnimState:PlayAnimation("idle_loop", true)

		inst.DynamicShadow:SetSize(1.5, .75)

		inst:AddTag("character")
		inst:AddTag("merm")

		inst:AddComponent("talker")
		inst.components.talker.fontsize = 35
		inst.components.talker.font = TALKINGFONT
		inst.components.talker.offset = Vector3(0, -400, 0)
		inst.components.talker:MakeChatter()
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end
		
		inst.sounds = sounds
		
		inst:AddComponent("inspectable")
		inst:AddComponent("locomotor")
		inst:SetStateGraph("SGmermtrader")
		inst:SetBrain(brain)

		inst:AddComponent("store")		

    return inst	
end

local function fnmerm3()

    local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddDynamicShadow()
		inst.entity:AddNetwork()

		MakeObstaclePhysics(inst, 0.2)
		
		inst.Transform:SetFourFaced()
		
		inst.AnimState:SetBank("pigman")
		inst.AnimState:SetBuild("merm_trader1_build")
		inst.AnimState:OverrideSymbol("swap_hat", "hat_top", "swap_hat")	
		inst.AnimState:OverrideSymbol("pig_arm", "merm_trader2_build", "pig_arm")	
		inst.AnimState:OverrideSymbol("pig_torso", "merm_trader2_build", "pig_torso")		
		inst.AnimState:PlayAnimation("idle_loop", true)

		inst.DynamicShadow:SetSize(1.5, .75)

		inst:AddTag("character")
		inst:AddTag("merm")

		inst:AddComponent("talker")
		inst.components.talker.fontsize = 35
		inst.components.talker.font = TALKINGFONT
		inst.components.talker.offset = Vector3(0, -400, 0)
		inst.components.talker:MakeChatter()
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end
		
		inst.sounds = sounds
		
		inst:AddComponent("inspectable")
		inst:AddComponent("locomotor")
		inst:SetStateGraph("SGmermtrader")
		inst:SetBrain(brain)

		inst:AddComponent("store")		

    return inst	
end

return Prefab("quagmire_goatkid", fn, assets, prefabs),
	   Prefab("quagmire_goatkid2", fn1, assets, prefabs),
	   Prefab("quagmire_trader_merm", fnmerm1, assets, prefabs),
	   Prefab("quagmire_trader_merm2", fnmerm2, assets, prefabs),
	   Prefab("quagmire_trader_merm3", fnmerm3, assets, prefabs)