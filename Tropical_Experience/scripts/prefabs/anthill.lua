require "prefabutil"
require "recipes"

local ROOM_TINY_WIDTH   = 15
local ROOM_TINY_DEPTH   = 10

local ROOM_SMALL_WIDTH  = 18
local ROOM_SMALL_DEPTH  = 12

local ROOM_MEDIUM_WIDTH = 24
local ROOM_MEDIUM_DEPTH = 16

local ROOM_LARGE_WIDTH  = 26
local ROOM_LARGE_DEPTH  = 18

local seg_time = 30 --each segment of the clock is 30 seconds
local TOTAL_DAY_TIME = seg_time*16

local day_segs = 10
local dusk_segs = 4
local night_segs = 2
local wilson_attack = 34

local ANTMAN_DAMAGE = wilson_attack * 2/3
local ANTMAN_HEALTH = 250
local ANTMAN_ATTACK_PERIOD = 3
local ANTMAN_TARGET_DIST = 16
local ANTMAN_LOYALTY_MAXTIME = 2.5*TOTAL_DAY_TIME
local ANTMAN_LOYALTY_PER_HUNGER = TOTAL_DAY_TIME/25
local ANTMAN_MIN_POOP_PERIOD = seg_time * .5

local ANTMAN_RUN_SPEED = 5
local ANTMAN_WALK_SPEED = 3

local ANTMAN_MIN = 3
local ANTMAN_MAX = 4
local ANTMAN_REGEN_TIME = seg_time * 2
local ANTMAN_RELEASE_TIME = seg_time

local ANTMAN_ATTACK_ON_SIGHT_DIST = 4
local ANTMAN_LOYALTY_PER_HUNGER = TOTAL_DAY_TIME/25

local assets =
{
	Asset("ANIM", "anim/ant_hill_entrance.zip"),
    Asset("ANIM", "anim/ant_queen_entrance.zip"),
    Asset("SOUND", "sound/pig.fsb"),
    Asset("MINIMAP_IMAGE", "ant_hill_entrance"), 
    Asset("MINIMAP_IMAGE", "ant_cave_door"), 
}

local prefabs = 
{
	"antman",
--    "antman_warrior",
--    "int_ceiling_dust_fx",
--    "antchest",
--    "giantgrub",
--    "ant_cave_lantern",
--    "antqueen",
}

local function onfar(inst) 
end

local function getstatus(inst)
    if inst:HasTag("burnt") then
        return "BURNT"
    end
end

local function onnear(inst) 
end


local function onoccupied(inst, child)
    if not inst:HasTag("burnt") then
    	inst.SoundEmitter:PlaySound("dontstarve/pig/pig_in_hut", "pigsound")
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
    	
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
    	inst.doortask = inst:DoTaskInTime(1, function() if not inst.components.playerprox:IsPlayerClose() then LightsOn(inst) end end)
    end
end

local function onvacate(inst, child)
    if not inst:HasTag("burnt") then
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
        inst.SoundEmitter:KillSound("pigsound")
    	
    	if child then
    		if child.components.health then
    		    child.components.health:SetPercent(1)
    		end
    	end    
    end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

--------------------------------------do teleporter------------------------
local function OnDoneTeleporting(inst, obj)
    if obj and obj:HasTag("player") then
	obj.mynetvarCameraMode:set(3)
	end
end

local function StartTravelSound(inst, doer)

end

local function OnActivateByOther(inst, source, doer)
--	if not inst.sg:HasStateTag("open") then
--		inst.sg:GoToState("opening")
--	end
	if doer ~= nil and doer.Physics ~= nil then
		doer.Physics:CollidesWith(COLLISION.WORLD)
	end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)
	doer.mynetvarCameraMode:set(1)
	
        local other = inst.components.teleporter.targetTeleporter
        if other ~= nil then
            DeleteCloseEntsWithTag("WORM_DANGER", other, 15)
        end			
        --Sounds are triggered in player's stategraph
    elseif inst.SoundEmitter ~= nil then

    end
end

local function OnHaunt(inst, haunter)
inst.components.teleporter:Activate(haunter)
end

local function fn()
    	local inst = CreateEntity()
    	local trans = inst.entity:AddTransform()
    	local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon("ant_hill_entrance.png")
    
        light:SetFalloff(1)
        light:SetIntensity(.5)
        light:SetRadius(1)
        light:Enable(false)
        light:SetColour(180/255, 195/255, 50/255)

        inst.Transform:SetScale(0.8, 0.8, 0.8)

        MakeObstaclePhysics(inst, 1.3)

        anim:SetBank("ant_hill_entrance")
        anim:SetBuild("ant_hill_entrance")
        anim:PlayAnimation("idle", true)

        inst:AddTag("structure")
        inst:AddTag("anthill_outside")
		inst:AddTag("hamletteleport")		
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end		
		
        inst:AddComponent("lootdropper")
		
    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
	inst.components.teleporter.hamlet = true	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)	
  
        inst:AddComponent("childspawner")
        inst.components.childspawner.childname = "antman"
        inst.components.childspawner:SetRegenPeriod(ANTMAN_REGEN_TIME)
        inst.components.childspawner:SetSpawnPeriod(ANTMAN_RELEASE_TIME)
        inst.components.childspawner:SetMaxChildren(math.random(ANTMAN_MIN, ANTMAN_MAX))
        inst.components.childspawner:StartSpawning()

    	inst:AddComponent("playerprox")
        inst.components.playerprox:SetDist(10, 13)
        inst.components.playerprox:SetOnPlayerNear(onnear)
        inst.components.playerprox:SetOnPlayerFar(onfar)

        inst:AddComponent("inspectable")
        inst.components.inspectable.getstatus = getstatus

    	MakeSnowCovered(inst, .01)
    	inst:ListenForEvent("onbuilt", onbuilt)
		
--    inst:AddComponent("hauntable")
--    inst.components.hauntable:SetOnHauntFn(OnHaunt)			

        return inst
end

return  Prefab("common/objects/anthill",fn, assets, prefabs),
		Prefab("common/objects/anthill_exit_1",fn, assets, prefabs),
		Prefab("common/objects/anthill_exit_2",fn, assets, prefabs)