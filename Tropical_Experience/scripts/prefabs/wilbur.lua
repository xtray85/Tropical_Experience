local MakePlayerCharacter = require "prefabs/player_common"

local assets = 
{
--	Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/player_ghost_withhat.zip"),
    Asset("ANIM", "anim/ghost_build.zip"),
	Asset( "IMAGE", "images/avatars/avatar_wilbur.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_wilbur.xml" ),
    Asset( "IMAGE", "images/avatars/avatar_ghost_wilbur.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_wilbur.xml" ),
	Asset( "IMAGE", "images/avatars/self_inspect_wilbur.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_wilbur.xml" ),
    Asset( "IMAGE", "bigportraits/wilbur.tex" ),
    Asset( "ATLAS", "bigportraits/wilbur.xml" ),
	Asset("ANIM", "anim/wilbur.zip"),
	Asset("ANIM", "anim/wilbur_run.zip"),	
}

local prefabs = 
{
}

local start_inv = 
{
}

local contador = 0

--local function movimento(inst)
--if inst.sg:HasStateTag("running") and not inst:HasTag("correndo") and not inst:HasTag("aquatic") then
--contador = contador + 1
--end

--if contador >= 80 and not inst:HasTag("correndo") and not inst:HasTag("aquatic") then
--inst:AddTag("corendo")
--contador = 0
--end

--end


local function movimento(inst)
if not inst.sg:HasStateTag("monkey") and not inst.sg:HasStateTag("sailing") then
inst.timeinmotion = 0
end
if inst.sg:HasStateTag("sailing") and not inst.sg:HasStateTag("monkey") and not inst:HasTag("aquatic") then
inst.timeinmotion = inst.timeinmotion + 1
end
end

local function oneat(inst, food)
	if food and (food.prefab == "cave_banana" or food.prefab == "cave_banana_cooked") then
		if inst.components.sanity then
			inst.components.sanity:DoDelta(TUNING.SANITY_SMALL)
		end
	end
end

local function onbecamehuman(inst)
	inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED-0.5
	inst.components.hunger:SetRate(1*TUNING.WILSON_HUNGER_RATE)
	inst:AddTag("slowed")
end

local function onbecameghost(inst)
end

local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "wilbur.png" )
	inst.soundsname = "wilbur"
	inst:AddTag("wilbur")
	inst:AddTag("monkey")
	inst:AddTag("primeape")
    inst:AddTag("slowed")	
	inst.timeinmotion = 0	
	inst:ListenForEvent("locomote", movimento)
end

local master_postinit = function(inst)

	inst.components.health:SetMaxHealth(125)
	inst.components.hunger:SetMax(175)
	inst.components.sanity:SetMax(150)
	
	inst.components.foodaffinity:AddPrefabAffinity("cave_banana", TUNING.AFFINITY_15_CALORIES_HUGE)	
	inst.components.foodaffinity:AddPrefabAffinity("cave_banana_cooked", TUNING.AFFINITY_15_CALORIES_HUGE)	

	inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("poop")
	inst.components.periodicspawner:SetRandomTimes(TUNING.TOTAL_DAY_TIME * 2.45, TUNING.SEG_TIME * 2.2)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()
	inst.ghostbuild="ghost_build"
	
	inst.components.eater:SetOnEatFn(oneat)
	inst.components.eater.ignoresspoilage = true
	
	inst.components.hunger:SetRate(1*TUNING.WILSON_HUNGER_RATE)
	inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED-0.5

	inst.OnLoad = onload
	inst.OnNewSpawn = onload
	inst.timeinmotion = 0	
--	inst:ListenForEvent("locomote", movimento)
	
end

return MakePlayerCharacter("wilbur", prefabs, assets, common_postinit, master_postinit, start_inv)