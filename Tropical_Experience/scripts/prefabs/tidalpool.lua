local assets =
{
	Asset("ANIM", "anim/tidal_pool.zip")
}

local prefabs =
{
    "marsh_plant",
    "pondfish",
    "flup",
}

local function SpawnPlants(inst, plantname, count, maxradius)

	if inst.decor then
		for i,item in ipairs(inst.decor) do
			item:Remove()
		end
	end
	inst.decor = {}

	local plant_offsets = {}

	for i=1,math.random(math.ceil(count/2),count) do
		local a = math.random()*math.pi*2
		local x = math.sin(a)*maxradius+math.random()*0.2
		local z = math.cos(a)*maxradius+math.random()*0.2
		table.insert(plant_offsets, {x,0,z})
	end

	for k, offset in pairs( plant_offsets ) do
		local plant = SpawnPrefab( plantname )
		plant.entity:SetParent( inst.entity )
		plant.Transform:SetPosition( offset[1], offset[2], offset[3] )
		table.insert( inst.decor, plant )
	end
end

local sizes =
{
	{anim="small_idle", rad=2.0, plantcount=2, plantrad=1.6},
	{anim="med_idle", rad=2.6, plantcount=3, plantrad=2.5},
	{anim="big_idle", rad=3.6, plantcount=4, plantrad=3.4},
}
--{anim="big_idle", rad=2.7, plantcount=4, plantrad=2.9},

local function SetSize(inst, size)
inst.size = math.random(1, 3)
if inst.size == 1 then
inst.AnimState:PlayAnimation("small_idle", true)
inst.Physics:SetCylinder(2.0, 1.0)
SpawnPlants(inst, "marsh_plant", 3, 1.6)
end
if inst.size == 2 then
inst.AnimState:PlayAnimation("med_idle", true)
inst.Physics:SetCylinder(2.6, 1.0)
SpawnPlants(inst, "marsh_plant", 4, 2.5)
end
if inst.size == 3 then
inst.AnimState:PlayAnimation("big_idle", true)
inst.Physics:SetCylinder(3.6, 1.0)
SpawnPlants(inst, "marsh_plant", 5, 3.4)
end
end

local function onsave(inst, data)
	data.size = inst.size
end

local function onload(inst, data, newents)
	if data and data.size then
		SetSize(inst, data.size)
	end
end

local function commonfn(pondtype)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1.95)

    inst.AnimState:SetBuild("tidal_pool")
    inst.AnimState:SetBank("tidal_pool")
    inst.AnimState:PlayAnimation("small_idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("minimap_tidalpool.png")

    inst:AddTag("watersource")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.pondtype = pondtype

    inst:AddComponent("childspawner")
    inst.components.childspawner:SetRegenPeriod(TUNING.POND_REGEN_TIME)
    inst.components.childspawner:SetSpawnPeriod(TUNING.POND_SPAWN_TIME)
    inst.components.childspawner:SetMaxChildren(math.random(1, 2))
    inst.components.childspawner:StartRegen()

    inst.frozen = nil
    inst.plants = nil
    inst.plant_ents = nil

    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "pond"

    inst:AddComponent("fishable")
    inst.components.fishable:SetRespawnTime(TUNING.FISH_RESPAWN_TIME)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
    inst:AddComponent("watersource")	

	inst.OnSave = onsave
	inst.OnLoad = onload
	
	SetSize(inst)

    return inst
end

local function ReturnChildren(inst)
    for k, child in pairs(inst.components.childspawner.childrenoutside) do
        if child.components.homeseeker ~= nil then
            child.components.homeseeker:GoHome()
        end
        child:PushEvent("gohome")
    end
end

local function OnIsDay(inst, isday)
    if isday ~= inst.dayspawn then
        inst.components.childspawner:StopSpawning()
        ReturnChildren(inst)
 --   elseif not TheWorld.state.iswinter then
		else
        inst.components.childspawner:StartSpawning()
    end
end

local function OnInit(inst)
    inst.task = nil
    inst:WatchWorldState("startday", OnIsDay)
--    inst:WatchWorldState("snowlevel", OnSnowLevel)
    OnIsDay(inst, TheWorld.state.isday)
--    OnSnowLevel(inst, TheWorld.state.snowlevel)
end

local function pondmos()
    local inst = commonfn("_mos")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.childspawner.childname = "mosquito_poison"
    inst.components.fishable:AddFish("pondfish")

    inst.planttype = "marsh_plant"
    inst.dayspawn = false
    inst.task = inst:DoTaskInTime(0, OnInit)

    return inst
end

return Prefab("tidalpool", pondmos, assets, prefabs)

