local PopupDialogScreen = require "screens/popupdialog"

local assets=
{
	Asset("ANIM", "anim/cave_entrance.zip"),
	Asset("ANIM", "anim/ruins_entrance.zip"),
	Asset("ANIM", "anim/cave_exit_rope.zip"),
    Asset("ANIM", "anim/rock_batcave.zip"),

	Asset("MINIMAP_IMAGE", "cave_closed"),
	Asset("MINIMAP_IMAGE", "cave_open"),
	Asset("MINIMAP_IMAGE", "cave_open2"),
	Asset("MINIMAP_IMAGE", "ruins_closed"),
    Asset("MINIMAP_IMAGE", "rock_batcave"),    
}

local prefabs = 
{
	"exitcavelight",
	"roc_nest",
	"roc_nest_tree1",
	"roc_nest_tree2",
	"roc_nest_bush",
	"roc_nest_branch1",
	"roc_nest_branch2",
	"roc_nest_trunk",
	"roc_nest_house",
	"roc_nest_rusty_lamp",

	"roc_nest_egg1",
	"roc_nest_egg2",
	"roc_nest_egg3",
	"roc_nest_egg4",

    "roc_nest_debris1",
    "roc_nest_debris2",
    "roc_nest_debris3",
    
	"roc_cave_light_beam",

}

local function Open(inst)

    inst.AnimState:PlayAnimation("open", true)
    inst:RemoveComponent("workable")
    inst.open = true
	inst.components.teleporter.enabled = true
	inst:RemoveComponent("lootdropper")
	inst.MiniMapEntity:SetIcon("cave_open.png")

--	inst.components.door:checkDisableDoor(false, "plug")
end

local function Openexit(inst)

    inst.AnimState:PlayAnimation("idle_open", true)
    inst:RemoveComponent("workable")
    inst.open = true
	inst.components.teleporter.enabled = true
	inst:RemoveComponent("lootdropper")
	inst.MiniMapEntity:SetIcon("cave_open.png")
	
    inst.AnimState:SetBank("doorway_cave")
    inst.AnimState:SetBuild("bat_cave_door")
    inst.AnimState:PlayAnimation("day_loop")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	MakeObstaclePhysics(inst, 0)

--	inst.components.door:checkDisableDoor(false, "plug")
end   

local function OnWork(inst, worker, workleft)
	local pt = Point(inst.Transform:GetWorldPosition())
	if workleft <= 0 then
		inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
		inst.components.lootdropper:DropLoot(pt)
        ProfileStatsSet("cave_entrance_opened", true)
		Open(inst)
	else				
		if workleft < TUNING.ROCKS_MINE*(1/3) then
			inst.AnimState:PlayAnimation("low")
		elseif workleft < TUNING.ROCKS_MINE*(2/3) then
			inst.AnimState:PlayAnimation("med")
		else
			inst.AnimState:PlayAnimation("idle_closed")
		end
	end
end

local function OnWorkexit(inst, worker, workleft)
	local pt1 = Point(inst.Transform:GetWorldPosition())
	local ex, ey, ez = pt1:Get() 
	local pt=Vector3(ex+1,ey,ez)
	if workleft <= 0 then
		inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
		inst.components.lootdropper:DropLoot(pt)
        ProfileStatsSet("cave_entrance_opened", true)
		Openexit(inst)
	else				
		if workleft < TUNING.ROCKS_MINE*(1/3) then
			inst.AnimState:PlayAnimation("low")
		elseif workleft < TUNING.ROCKS_MINE*(2/3) then
			inst.AnimState:PlayAnimation("med")
		else
			inst.AnimState:PlayAnimation("full")
		end
	end
end

local function Close(inst)

    inst.AnimState:PlayAnimation("idle_closed", true)

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
	inst.components.workable:SetOnWorkCallback(OnWork)
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"rocks", "rocks", "flint", "flint", "flint"})

	inst.components.teleporter.enabled = false
    inst.open = false
end      

local function Closeexit(inst)

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
	inst.components.workable:SetOnWorkCallback(OnWorkexit)
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"rocks", "rocks", "flint", "flint", "flint"})

	inst.components.teleporter.enabled = false
    inst.open = false
end  


local function GetStatus(inst)
    if inst.open then
        return "OPEN"
    end
end  


local function onsave(inst, data)
    if inst:HasTag("maze_generated") then
        data.maze_generated = true
    end
	data.open = inst.open    
end

local function onload(inst, data)
    if data then  
        if data.maze_generated then
            inst:AddTag("maze_generated")
        end  
    end

	if data and data.open then
		Open(inst)
		end    
end

local function onloadexit(inst, data)
    if data then  
        if data.maze_generated then
            inst:AddTag("maze_generated")
        end  
    end

	if data and data.open then
		Openexit(inst)
		end    
end

--------------------------------------do teleporter------------------------
local function OnDoneTeleporting(inst, obj)
    if obj and obj:HasTag("player") then
	obj.mynetvarCameraMode:set(5)
	end
end

local function OnDoneTeleportingexit(inst, obj)
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

local function OnActivateexit(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)
	doer.mynetvarCameraMode:set(6)
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

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 1)
    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("cave_closed.png")
    anim:SetBank("cave_entrance")
    anim:SetBuild("cave_entrance")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()
	inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleportingexit)	

    Close(inst)
	inst.OnSave = onsave
	inst.OnLoad = onload	
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		
	
    return inst
end


local function exitfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()    
    inst.entity:AddNetwork()
	
	MakeObstaclePhysics(inst, 1.)
	
	inst.AnimState:SetBank("rock_batcave")
	inst.AnimState:SetBuild("rock_batcave")
	inst.AnimState:PlayAnimation("full")

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "rock_batcave.png" )
	inst:AddTag("hamletteleport")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
	
	inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetChanceLootTable('rock1')
	inst.components.lootdropper.alwaysinfront = true

	inst:AddComponent("inspectable")
	MakeSnowCovered(inst, .01)
	
    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivateexit
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

    Closeexit(inst)
	inst.OnSave = onsave
	inst.OnLoad = onloadexit	
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		
		
	return inst
end



return Prefab( "common/cave_entrance_roc", fn, assets, prefabs),
       Prefab( "common/cave_exit_roc", exitfn, assets, prefabs) 
