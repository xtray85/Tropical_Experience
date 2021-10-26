local assets =
{
    Asset("ANIM", "anim/lakes_tile.zip"),
    Asset("ANIM", "anim/splash.zip"),
    Asset("MINIMAP_IMAGE", "oasis"),
}

local prefabs =
{
    "fish",
}

local distancia = 1
local function OnInit(inst)

end

local function LookForValidTiles(inst)
local world = TheWorld
local impassable = true --GROUND.IMPASSABLE
local width, height = world.Map:GetSize()


local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()


for x = -1000, 1000 do
for z = -1000, 1000 do

local curr = map:GetTile(map:GetTileCoordsAtPoint(x,y, z))
if curr == GROUND.OCEAN_COASTAL_SHORE then

if not TheWorld.Map:IsOceanTileAtPoint(x+distancia, y, z) then			
local lake = SpawnPrefab("floodsw")
lake.Transform:SetPosition(x, y, z)          
end

if not TheWorld.Map:IsOceanTileAtPoint(x-distancia, y, z) then			
local lake = SpawnPrefab("floodsw")
lake.Transform:SetPosition(x, y, z)          
end

if not TheWorld.Map:IsOceanTileAtPoint(x, y, z+distancia) then			
local lake = SpawnPrefab("floodsw")
lake.Transform:SetPosition(x, y, z)          
end

if not TheWorld.Map:IsOceanTileAtPoint(x, y, z-distancia) then			
local lake = SpawnPrefab("floodsw")
lake.Transform:SetPosition(x, y, z)          
end



--local neighbor = map:GetTile(map:GetTileCoordsAtPoint(x,y, z-1))
--if neighbor ~= GROUND.OCEAN_COASTAL_SHORE then              --(neighbor) and neighbor ~= impassable  then
--local lake = SpawnPrefab("floodsw")
--lake.Transform:SetPosition(x, y, z)             
--end


inst:Remove()
            end
        end
    end
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
local minimap = inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.Transform:SetScale(0.9, 0.9, 0.9)

    inst.Transform:SetRotation(45)

    MakeObstaclePhysics(inst, 1)

--	 inst.AnimState:SetBuild("lakes_tile")
--    inst.AnimState:SetBank("oasis_tile")
--    inst.AnimState:PlayAnimation("idle", true)
--	inst.AnimState:SetBank("wall")
--	inst.AnimState:SetBuild("wall_stone")
--	inst.AnimState:PlayAnimation("half")
--    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
	

--	minimap:SetIcon("minimap_lake.tex")
--	inst.MiniMapEntity:SetIcon("lava_pond.png")

    inst:AddTag("novoaceano")
    inst:AddTag("watersource")
    inst:AddTag("birdblocker")
    inst:AddTag("antlion_sinkhole_blocker")
	inst:AddTag("NOCLICK")

    inst:SetDeployExtraSpacing(5)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("talker")
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

	inst:DoTaskInTime(1,  LookForValidTiles)

    return inst
end

local function InitializePathFinding(inst)
    local x, _, z = inst.Transform:GetWorldPosition()
    TheWorld.Pathfinder:AddWall(x - 1, 0, z - 1)
    TheWorld.Pathfinder:AddWall(x - 1, 0, z + 1)
    TheWorld.Pathfinder:AddWall(x + 1, 0, z - 1)
    TheWorld.Pathfinder:AddWall(x + 1, 0, z + 1)
end

--local function OnRemove(inst)
--    local x, _, z = inst.Transform:GetWorldPosition()
--    TheWorld.Pathfinder:RemoveWall(x - 0.5, 0, z - 0.5)
--    TheWorld.Pathfinder:RemoveWall(x - 0.5, 0, z + 0.5)
--    TheWorld.Pathfinder:RemoveWall(x + 0.5, 0, z - 0.5)
--    TheWorld.Pathfinder:RemoveWall(x + 0.5, 0, z + 0.5)
--end

local function wall_lake()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
--	inst.Transform:SetEightFaced()

	inst:AddTag("lakewall")	
	inst:AddTag("blocker")
	local phys = inst.entity:AddPhysics()

	MakeObstaclePhysics(inst, 3.2)

--   inst.AnimState:SetBank("wall")
--   inst.AnimState:SetBuild("wall_stone")
--   inst.AnimState:PlayAnimation("half")

		
	inst:AddTag("NOCLICK")

    inst:DoTaskInTime(1, InitializePathFinding)
--    inst.OnRemoveEntity = OnRemove

	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
			
	return inst
end

return Prefab("lake", fn, assets, prefabs), Prefab("wall_lake", wall_lake)
