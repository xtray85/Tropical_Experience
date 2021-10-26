local MakePlayerCharacter = require "prefabs/player_common"

local assets = 
{
--	Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/player_ghost_withhat.zip"),
    Asset("ANIM", "anim/ghost_build.zip"),
	Asset( "IMAGE", "images/avatars/avatar_walani.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_walani.xml" ),
    Asset( "IMAGE", "images/avatars/avatar_ghost_walani.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_walani.xml" ),
	Asset( "IMAGE", "images/avatars/self_inspect_walani.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_walani.xml" ),
    Asset( "IMAGE", "bigportraits/walani.tex" ),
    Asset( "ATLAS", "bigportraits/walani.xml" ),
	Asset("ANIM", "anim/walani.zip"),
}

local WALANI_HEALTH = 120
local WALANI_SANITY = 200
local WALANI_HUNGER = 200
local WALANI_SANITY_RATE_MODIFIER = -0.5
local WALANI_HUNGER_RATE_MODIFIER = 1

local prefabs = 
{
}

local start_inv = 
{
}


local function onbecamehuman(inst)
	inst.components.sanity.wetnessImmune = true 
	inst.components.moisture.baseDryingRate = 0.2
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * WALANI_HUNGER_RATE_MODIFIER)
	inst.components.sanity.sanityrate = -0.1
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
	inst.MiniMapEntity:SetIcon( "walani.png" )
    inst:AddTag("walani")
	inst.soundsname = "walani"
end


local master_postinit = function(inst)
	inst.components.health:SetMaxHealth(WALANI_HEALTH)
	inst.components.hunger:SetMax(WALANI_HUNGER)
	inst.components.sanity:SetMax(WALANI_SANITY)
	inst.ghostbuild="ghost_build"
	
	inst.components.foodaffinity:AddPrefabAffinity("seafoodgumbo", TUNING.AFFINITY_15_CALORIES_HUGE)
	
	inst.components.moisture.baseDryingRate = 0.2
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * WALANI_HUNGER_RATE_MODIFIER)
	inst.components.sanity.sanityrate = -0.1
	
	inst.OnLoad = onload
end

return MakePlayerCharacter("walani", prefabs, assets, common_postinit, master_postinit, start_inv)
