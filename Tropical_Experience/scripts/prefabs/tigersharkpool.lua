local assets =
{
	Asset("ANIM", "anim/tidal_pool.zip")
}

local prefabs =
{
    "marsh_plant",
    "fish",
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
	{anim="big_idle", rad=14.4, plantcount=8, plantrad=7.0},
}
--{anim="big_idle", rad=2.7, plantcount=4, plantrad=2.9},

local function SetSize(inst, size)
	inst.size = 3 --size or math.random(1, #sizes)
	inst.AnimState:PlayAnimation("big_idle", true)
	inst.Physics:SetCylinder(14.4, 1.0)
	SpawnPlants(inst, "marsh_plant", 8, 7)
end

local function onsave(inst, data)
	data.size = inst.size
	data.entrada = inst.entrada
end

local function onload(inst, data, newents)
	if data and data.size then
		SetSize(inst, data.size)	
	end
	
if data == nil then return end
if data.entrada then inst.entrada = data.entrada end	
end

local function initshark(inst)
 
if inst.entrada == nil then
local x, y, z = inst.Transform:GetLocalPosition()
local fx = SpawnPrefab("tigersharktorch")
fx.Transform:SetPosition(x, y, z)
local tigre = SpawnPrefab("tigershark")
if tigre ~= nil then
tigre.Transform:SetPosition(x, y, z)
end
inst.entrada = 1
end 
inst:Remove()
end


local function antigo(inst)
local L1 = 12

fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+1, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+2, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+3, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+4, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+5, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+6, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+7, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+8, y, z+L1-1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+9, y, z+L1-2)
fx = SpawnPrefab("wall_tigerpond")


fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-1, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-2, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-3, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-4, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-5, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-6, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-7, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-8, y, z+L1-1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-9, y, z+L1-2)
fx = SpawnPrefab("wall_tigerpond")


local L1 = -12

fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+1, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+2, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+3, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+4, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+5, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+6, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+7, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+8, y, z+L1+1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+9, y, z+L1+2)
fx = SpawnPrefab("wall_tigerpond")


fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-1, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-2, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-3, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-4, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-5, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-6, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-7, y, z+L1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-8, y, z+L1+1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x-9, y, z+L1+2)
fx = SpawnPrefab("wall_tigerpond")



local L1 = 12

fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+2)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+3)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+4)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+5)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+6)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+7)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1-1, y, z+8)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1-2, y, z+9)
fx = SpawnPrefab("wall_tigerpond")


fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-2)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-3)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-4)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-5)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-6)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-7)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1-1, y, z-8)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1-2, y, z-9)
fx = SpawnPrefab("wall_tigerpond")



local L1 = -12

fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+2)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+3)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+4)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+5)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+6)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z+7)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1+1, y, z+8)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1+2, y, z+9)
fx = SpawnPrefab("wall_tigerpond")


fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-1)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-2)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-3)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-4)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-5)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-6)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1, y, z-7)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1+1, y, z-8)
fx = SpawnPrefab("wall_tigerpond")
fx.Transform:SetPosition(x+L1+2, y, z-9)
fx = SpawnPrefab("wall_tigerpond")

--inst:Remove()
end

local function commonfn(pondtype)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.Transform:SetScale(2, 2, 2)

    MakeObstaclePhysics(inst, 0)

    inst.AnimState:SetBuild("tidal_pool")
    inst.AnimState:SetBank("tidal_pool")
    inst.AnimState:PlayAnimation("big_idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("tigerpool.png")

    inst:AddTag("watersource")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(8)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.pondtype = pondtype

    inst:AddComponent("childspawner")
    inst.components.childspawner:SetRegenPeriod(TUNING.POND_REGEN_TIME)
    inst.components.childspawner:SetSpawnPeriod(TUNING.POND_SPAWN_TIME)
    inst.components.childspawner:SetMaxChildren(math.random(3, 4))
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

	inst.OnSave = onsave
	inst.OnLoad = onload
	
	inst:DoTaskInTime(0, initshark)
	
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

local function pondflup()
    local inst = commonfn("")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.childspawner.childname = "sharkitten"
    inst.components.fishable:AddFish("fish")

    inst.planttype = "marsh_plant"
    inst.dayspawn = true
    inst.task = inst:DoTaskInTime(0, OnInit)

    return inst
end

local function pondmos()
    local inst = commonfn("_mos")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.childspawner.childname = "frog"
    inst.components.fishable:AddFish("fish")

    inst.planttype = "marsh_plant"
    inst.dayspawn = false
    inst.task = inst:DoTaskInTime(0, OnInit)
    inst:WatchWorldState("startday", OnIsDay)	

    return inst
end

local function wall_tigerpond()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst.Transform:SetEightFaced()
	
	inst:AddTag("blocker")
	local phys = inst.entity:AddPhysics()
	phys:SetMass(0)
	phys:SetCollisionGroup(COLLISION.WORLD)
	phys:ClearCollisionMask()
	phys:CollidesWith(COLLISION.ITEMS)
	phys:CollidesWith(COLLISION.CHARACTERS)
	phys:CollidesWith(COLLISION.GIANTS)
	phys:CollidesWith(COLLISION.FLYERS)
	phys:SetCapsule(0.5, 50)

--   inst.AnimState:SetBank("wall")
--   inst.AnimState:SetBuild("wall_stone")
--   inst.AnimState:PlayAnimation("half")
		
	inst:AddTag("NOCLICK")
			
	return inst
end

return Prefab("wall_tigerpond", wall_tigerpond),Prefab("tigersharkpool", pondflup, assets, prefabs)

