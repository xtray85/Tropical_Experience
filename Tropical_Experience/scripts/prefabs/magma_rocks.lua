local assets =
{
	Asset("ANIM", "anim/rock_magma_gold.zip"),
	Asset("ANIM", "anim/rock_magma.zip"),
	Asset("MINIMAP_IMAGE", "rockmagma"),
}

local prefabs =
{
	"rocks",
	"nitre",
	"flint",
	"goldnugget",
	"redgem",
	"bluegem",
	"flamegeyser"
}

local loot_table = {
        {chance = 0.75,   	item = "rocks"},
        {chance = 0.25,   	item = "flint"},
        {chance = 0.25,    	item = "nitre"},
        {chance = 0.0025,   item = "redgem"},
        {chance = 0.005,    item = "bluegem"},
}
local FLAMEGEYSER_SPAWN_CHANCE = 0.5

local function GetLoot(loot_table, num)
	local total = 0
	local loot = {}
	
	for k,v in ipairs(loot_table) do
		total = total + v.chance
	end
	for i = 1, num do
		local rand = math.random() * total
		for k,v in ipairs(loot_table) do
			rand = rand - v.chance
			if rand <= 0 then
				table.insert(loot, v.item)
				break
			end
		end
	end
	return loot
end

local STAGES = {
	{ animation = "low", work = 2,
      stage_initfn = function(inst) end },
	{ animation = "med", work = 4, },
	{ animation = "full", work = 6, },
}

local function SetStage(inst, stage)
	inst.stage = stage
	inst.AnimState:PlayAnimation(STAGES[inst.stage].animation)
	
	if STAGES[inst.stage].stage_initfn ~= nil then
		STAGES[inst.stage].stage_initfn(inst)
	end
end

local function onworked(inst, worker, workleft)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/dig_rockpile")
	
	local nextStage = 3 
	if workleft <= 0 then  		nextStage = 0
	elseif workleft <= 2 then  	nextStage = 1
	elseif workleft <= 4 then  	nextStage = 2
	end 
	
	local numDrops = inst.stage - nextStage
	local doGeyser = nextStage == 0 and math.random() < FLAMEGEYSER_SPAWN_CHANCE

	if doGeyser then 
		local geyser = SpawnPrefab("flamegeyser")
		geyser.Transform:SetPosition(inst:GetPosition():Get())
		geyser:OnErupt()
	end 

	for i = 1, numDrops do 
		local loot = GetLoot(inst.loot,math.random(2,3))
		local pt = inst:GetPosition()
		if doGeyser then 
			for k,v in pairs(loot) do
				local item = inst.components.lootdropper:SpawnLootPrefab(v,pt)
				local vx, vy, vz = item.Physics:GetVelocity()
				item.Physics:SetVel(vx, 35, vz)
			end
		else 
			for i, v in ipairs(loot) do 
				inst.components.lootdropper:SpawnLootPrefab(v,pt)
			end
		end 
	end 

	if nextStage ~= inst.stage then 
		if nextStage == 0 then inst:Remove()
		else SetStage(inst, nextStage)
		end
	end 
end

local function OnSave(inst, data)
	data.stage = inst.stage
end

local function OnLoad(inst, data)
	if data and data.stage then
		SetStage(inst, data.stage)
		inst.components.workable:SetWorkLeft(STAGES[inst.stage].work)
	end
end

local function commonfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

	MakeObstaclePhysics(inst, 1)

	inst.MiniMapEntity:SetIcon( "rockmagma.png" )

    inst.AnimState:SetBank("rock_magma")
    inst.AnimState:SetBuild("rock_magma")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetWorkLeft(6)
	inst.components.workable:SetOnWorkCallback(onworked)

	inst:AddComponent("lootdropper")
	inst.loot = loot_table

	inst.stage = 3
	SetStage(inst, inst.stage)

	inst.displaynamefn = function(inst) return STRINGS.NAMES["MAGMAROCK"] end

	inst.OnLoad = OnLoad
	inst.OnSave = OnSave

    MakeHauntableWork(inst)
	
	return inst
end

----------GOLD ROCKS------------

local gold_loot_table = {
    {chance = 0.75,   	item = "rocks"},
    {chance = 0.25,   	item = "flint"},
    {chance = 0.25,    	item = "goldnugget"},
    {chance = 0.0025, 	item = "redgem"},
    {chance = 0.005,    item = "bluegem"},
}

local function gold_commonfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	
	MakeObstaclePhysics(inst, 1)

	inst.MiniMapEntity:SetIcon( "rockmagma.png" )

    inst.AnimState:SetBank("rock_magma_gold")
    inst.AnimState:SetBuild("rock_magma_gold")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetWorkLeft(6)
	inst.components.workable:SetOnWorkCallback(onworked)

	inst:AddComponent("lootdropper")
	inst.loot = gold_loot_table

	inst.displaynamefn = function(inst) return STRINGS.NAMES["MAGMAROCK_GOLD"] end

	inst.stage = 3
	SetStage(inst, inst.stage)

	inst.OnLoad = OnLoad
	inst.OnSave = OnSave

    MakeHauntableWork(inst)
	
	return inst
end

return 	Prefab("magmarock_gold", gold_commonfn, assets, prefabs),
		Prefab("magmarock", commonfn, assets, prefabs)
