local reef_assets =
{
	Asset("ANIM", "anim/coral_rock_underwater.zip"),
	Asset("MINIMAP_IMAGE", "coral_rock"),
}

local CORAL_MINE = 9

local prefabs =
{
	"coral",
	"limestone",
}

SetSharedLootTable( 'coral_full',
{
    {'coral',  1.00},
    {'coral',  0.50},
})

SetSharedLootTable( 'coral_med',
{
    {'coral',  1.00},
    {'coral',  0.25},
})

SetSharedLootTable( 'coral_low',
{
    {'limestone',  1.00},
    {'limestone',  0.66},
    {'limestone',  0.33},
	{'corallarve',  1.00},    
})

local function getsmallgrowtime(inst) return 480 * 6 end
local function getmedgrowtime(inst) return 480 * 6 end

local function SetSmall(inst)
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.AnimState:PlayAnimation("low"..inst.animnumber, true)
	inst.components.workable:SetWorkLeft(1)
	inst.components.growable:StartGrowing()
	inst.components.lootdropper:SetChanceLootTable('coral_low')
end

local function SetMedium(inst)
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.AnimState:PlayAnimation("med"..inst.animnumber, true)
	inst.components.workable:SetWorkLeft(CORAL_MINE - 4)
	inst.components.growable:StartGrowing()
	inst.components.lootdropper:SetChanceLootTable('coral_med')
end

local function SetLarge(inst)
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.AnimState:PlayAnimation("full"..inst.animnumber, true)
	inst.components.workable:SetWorkLeft(CORAL_MINE)
	inst.components.lootdropper:SetChanceLootTable('coral_full')
end

local growth_stages = {
    {name="small", time = getsmallgrowtime, fn = SetSmall, anim = "low" },
    {name="med", time = getmedgrowtime , fn = SetMedium, transition = "low_to_med", anim = "med" },
	{name="large", fn = SetLarge, transition = "med_to_full", anim = "full"}}


local function OnGrowthFn(inst, last, current)
	if growth_stages[current].transition then
		inst.AnimState:PlayAnimation(growth_stages[current].transition..inst.animnumber)
		inst.AnimState:PushAnimation(growth_stages[current].anim..inst.animnumber, true)
	else
		inst.AnimState:PlayAnimation(growth_stages[current].anim..inst.animnumber, true)	
	end
end

local LappingSound
local function StartLappingSound(inst)
	local dt = 3 + math.random()*3
	inst.task = inst:DoTaskInTime(dt, function(inst) LappingSound(inst) end)
end

LappingSound = function(inst)
--	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/lapping_coral")
	StartLappingSound(inst)
end

local function OnWake(inst)
	StartLappingSound(inst)
end

local function OnSleep(inst)
	if inst.task then
		inst.task:Cancel()
		inst.task = nil
	end
end

local function reef_fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeObstaclePhysics(inst, 1)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("minimap_coralreef.png" )
	
	inst.AnimState:SetBank("coral_rock_underwater")
	inst.AnimState:SetBuild("coral_rock_underwater")	
	
	inst.Transform:SetScale(3, 3, 3)	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
	
	inst:AddComponent("lootdropper") 
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(CORAL_MINE)
	
	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/coral_break")
				SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
				inst.components.lootdropper:DropLoot(pt)
				inst:Remove()
			else
				if workleft == 1 and inst.components.growable.stage ~= 1 then
					inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/coral_break")
					inst.components.lootdropper:DropLoot(pt)
					inst.components.growable:SetStage(1)
				elseif workleft <= 5 and workleft > 1 and inst.components.growable.stage ~= 2  then
					inst.components.lootdropper:DropLoot(pt)
					inst.components.growable:SetStage(2)

				end
			end
		end)

	inst.animnumber = math.random(1,3)

    local r = 0.8 + math.random() * 0.2
    local g = 0.8 + math.random() * 0.2
    local b = 0.8 + math.random() * 0.2
    anim:SetMultColour(r, g, b, 1)    
    inst:AddComponent("growable")
	inst.components.growable.stages = growth_stages
	inst.components.growable:SetStage(3)
--	inst.components.growable:SetOnGrowthFn(OnGrowthFn)
	inst.components.growable.growoffscreen = true
	
--	inst:AddComponent("waveobstacle")

	inst:AddComponent("inspectable")
	MakeSnowCovered(inst, .01)      

	inst.OnEntitySleep = OnSleep
	inst.OnEntityWake = OnWake

	inst.components.lootdropper:SetChanceLootTable('coral_full')
	return inst
end

return Prefab("coralreefunderwater", reef_fn, reef_assets, prefabs)