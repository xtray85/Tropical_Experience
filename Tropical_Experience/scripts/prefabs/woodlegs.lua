local MakePlayerCharacter = require "prefabs/player_common"

local assets = 
{
--	Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/player_ghost_withhat.zip"),
    Asset("ANIM", "anim/ghost_build.zip"),
	Asset( "IMAGE", "images/avatars/avatar_woodlegs.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_woodlegs.xml" ),
    Asset( "IMAGE", "images/avatars/avatar_ghost_woodlegs.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_woodlegs.xml" ),
	Asset( "IMAGE", "images/avatars/self_inspect_woodlegs.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_woodlegs.xml" ),
    Asset( "IMAGE", "bigportraits/woodlegs.tex" ),
    Asset( "ATLAS", "bigportraits/woodlegs.xml" ),
	Asset("ANIM", "anim/woodlegs.zip"),			
}

local prefabs = 
{
}

local start_inv = 
{
	"luckyhat",
	"boatcannon",
	"boards",
	"boards",
	"boards",
	"boards",
	"dubloon",
	"dubloon",
	"dubloon",
	"dubloon",
}

local function onbecamehuman(inst)
if inst:HasTag("aquatic") then
inst.components.sanity.dapperness = 0
else
inst.components.sanity.dapperness = -TUNING.DAPPERNESS_MED
end
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

local function CanShaveTest(inst)
    return false, "REFUSE"
end

local common_postinit = function(inst) 
	inst.MiniMapEntity:SetIcon( "woodlegs.png" )
	inst:AddTag("woodlegs")
	inst.soundsname = "woodlegs"
	inst:AddTag("bearded")
end

local function sanityfn(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local map = TheWorld.Map	
	local posicao = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))	
	local delta = 0
	if posicao == GROUND.OCEAN_COASTAL or posicao == GROUND.OCEAN_WATERLOG or posicao == GROUND.OCEAN_COASTAL_SHORE or posicao == GROUND.OCEAN_SWELL or posicao == GROUND.OCEAN_ROUGH or posicao == GROUND.OCEAN_BRINEPOOL or posicao == GROUND.OCEAN_BRINEPOOL_SHORE or posicao == GROUND.OCEAN_HAZARDOUS then
		delta = 0.08
	end
	return delta
end

local master_postinit = function(inst)

	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(120)
	inst.components.sanity.dapperness = -TUNING.DAPPERNESS_MED
	inst.components.sanity.custom_rate_fn = sanityfn
	
	inst.components.foodaffinity:AddPrefabAffinity("jellyopop", TUNING.AFFINITY_15_CALORIES_HUGE)	
	
    inst:AddComponent("beard")
    inst.components.beard.canshavetest = CanShaveTest
    inst.components.beard:EnableGrowth(false)
	inst.ghostbuild="ghost_build"
	
	inst:ListenForEvent("locomote", onbecamehuman)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end

return MakePlayerCharacter("woodlegs", prefabs, assets, common_postinit, master_postinit, start_inv)
