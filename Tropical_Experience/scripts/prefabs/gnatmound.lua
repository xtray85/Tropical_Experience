local assets =
{
    Asset("ANIM", "anim/gnat_mound.zip"),
    Asset("MINIMAP_IMAGE", "gnat_mound"),
}

local GNATMOUND_REGEN_TIME = 30 * 4
local GNATMOUND_RELEASE_TIME = 30
local GNATMOUND_MAX_WORK	= 6
local GNATMOUND_MAX_CHILDREN	= 1

local prefabs =
{
	"gnat",
}

SetSharedLootTable( 'gnatmound',
{
    {'rocks',  1.00},

    {'rocks',  1.00/4},

    {'flint',  0.60/4},

    {'iron',  1.00/4},    
})

local function onworked(inst)
    inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local function onhit(inst)
        
    if inst.components.workable.workleft == 4 or inst.components.workable.workleft == 2 or inst.components.workable.workleft == 0 then
        inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
        inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
        if inst.components.childspawner then
            inst.components.childspawner:ReleaseAllChildren()

        end        
    end

    if inst.components.workable.workleft > 4 then
        inst.AnimState:PlayAnimation("full", false)
    elseif inst.components.workable.workleft > 2 then
        inst.AnimState:PlayAnimation("med", false)
    elseif inst.components.workable.workleft > 0 then    
        inst.AnimState:PlayAnimation("low", false)
    end
end

local function rebuildfn(inst)

    if inst.components.workable.workleft > 4 then
        inst.AnimState:PlayAnimation("full", false)
    elseif inst.components.workable.workleft > 2 then
        inst.AnimState:PlayAnimation("med2", false)
    elseif inst.components.workable.workleft > 0 then    
        inst.AnimState:PlayAnimation("low2", false)
    end
end

local function OnEntityWake(inst)
    if inst.components.childspawner then
        inst.components.childspawner:StartSpawning()
    end
end

local function OnEntitySleep(inst)
end

local function onsave(inst, data)
--    data.lives = inst.lives_left
end

local function onload(inst, data)
rebuildfn(inst)	
end

local function regen(inst)
    if inst.components.workable.workleft < 6 then
	inst.components.workable.workleft = inst.components.workable.workleft + 1
	end
rebuildfn(inst)		
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, .5)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "gnat_mound.png" )

	anim:SetBank("gnat_mound")
	anim:SetBuild("gnat_mound")
	anim:PlayAnimation("full")

    inst:AddTag("structure")
    inst:AddTag("gnatmound")

	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
    -------------------
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetMaxWork(GNATMOUND_MAX_WORK)
    inst.components.workable:SetWorkLeft(GNATMOUND_MAX_WORK)
    inst.components.workable:SetOnFinishCallback(onworked)
    inst.components.workable:SetOnWorkCallback(onhit)       

   -------------------
	inst:AddComponent("childspawner")
	inst.components.childspawner.childname = "gnat"
	inst.components.childspawner:SetRegenPeriod(GNATMOUND_REGEN_TIME)
	inst.components.childspawner:SetSpawnPeriod(GNATMOUND_RELEASE_TIME)
	inst.components.childspawner:SetMaxChildren(GNATMOUND_MAX_CHILDREN)
    ---------------------
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('gnatmound')

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    ---------------------
    inst:AddComponent("inspectable")

    MakeSnowCovered(inst)

	inst.OnEntitySleep = OnEntitySleep
	inst.OnEntityWake = OnEntityWake

    inst.rebuildfn = rebuildfn
	
	inst:WatchWorldState("startday", regen)	
    
    inst.OnSave = onsave
    inst.OnLoad = onload

	return inst
end

return Prefab( "forest/monsters/gnatmound", fn, assets, prefabs ) 

