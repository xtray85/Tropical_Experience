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
	Asset("ANIM", "anim/grotto_grub_nest.zip"),
}

local prefabs = 
{
	"grotto_grub",
}


local function fn()
    	local inst = CreateEntity()
    	local trans = inst.entity:AddTransform()
    	local anim = inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon("grotto_grub_nest.png")

        inst.Transform:SetScale(1, 1, 1)

        MakeObstaclePhysics(inst, 1.3)

        anim:SetBank("grotto_grub_nest")
        anim:SetBuild("grotto_grub_nest")	
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("structure")	
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end		
		
		inst:AddComponent("lootdropper")
		inst.components.lootdropper:SetLoot({"rocks", "rocks", "honey", "honeycomb"})
  
        inst:AddComponent("childspawner")
        inst.components.childspawner.childname = "grotto_grub"
        inst.components.childspawner:SetRegenPeriod(ANTMAN_REGEN_TIME)
        inst.components.childspawner:SetSpawnPeriod(ANTMAN_RELEASE_TIME)
        inst.components.childspawner:SetMaxChildren(math.random(ANTMAN_MIN, ANTMAN_MAX))
        inst.components.childspawner:StartSpawning()
		
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.MINE)
		inst.components.workable:SetWorkLeft(6)
		inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)
            local pt = Point(inst.Transform:GetWorldPosition())
            if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
                inst.components.lootdropper:DropLoot(pt)
                inst:Remove()
				
			else
			inst.AnimState:PlayAnimation("idle", true)
            end
        end)			

        inst:AddComponent("inspectable")		

        return inst
end

return  Prefab("common/objects/grotto_grub_nest",fn, assets, prefabs)