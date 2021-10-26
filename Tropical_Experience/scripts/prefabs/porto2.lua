require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/buoy.zip"),
	Asset("ANIM", "anim/fish_farm_ground.zip"),
	Asset("ANIM", "anim/seafarer_boat.zip"),	
}

local prefabs =
{

}

local function ondeploybuoy(inst, pt, deployer)
    local boat = SpawnPrefab("buoy")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)
        inst:Remove()
    end
end

local function fnbuoy(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("buoy")
    inst.AnimState:SetBuild("buoy")
    inst.AnimState:PlayAnimation("ground", true)
	inst.AnimState:OverrideSymbol("light", "buoy", "")
	
--	inst.Transform:SetScale(0.5, 0.5, 0.5)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploybuoy
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end


local function ondeployfish_farm(inst, pt, deployer)
    local boat = SpawnPrefab("fish_farm")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
        inst:Remove()
    end
end

local function fnfish_farm(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("fish_farm_ground")
    inst.AnimState:SetBuild("fish_farm_ground")
    inst.AnimState:PlayAnimation("idle", true)
	
--	inst.Transform:SetScale(0.5, 0.5, 0.5)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployfish_farm
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end

local function ondeployballphinhouse(inst, pt, deployer)
    local boat = SpawnPrefab("ballphinhouse")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
        inst:Remove()
    end
end

local function fnballphinhouse(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("ballphinhouse", true)


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployballphinhouse
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end

local function ondeployresearchlab5(inst, pt, deployer)
    local boat = SpawnPrefab("researchlab5")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
        inst:Remove()
    end
end

local function fnresearchlab5(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("research", true)


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployresearchlab5
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end

local function ondeploytar_extractor(inst, pt, deployer)
    local boat = SpawnPrefab("tar_extractor")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
        inst:Remove()
    end
end

local function test_ground(inst, pt)
local valor
local valor2
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 0.5, {"tar source"}) 
for k,item in pairs(ents) do
if item then
valor = true else valor = false
end
end

local ents2 = TheSim:FindEntities(pt.x, pt.y, pt.z, 4, {"tar_extractor"}) 
for k,item2 in pairs(ents2) do
if item2 then
valor2 = true else valor2 = false
end
end

if valor and not valor2 then return true else return false end
end

local function fntar_extractor(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("extractor", true)


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
	inst.components.deployable.CanDeploy = test_ground
    inst.components.deployable.ondeploy = ondeploytar_extractor
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end

local function ondeploysea_chiminea(inst, pt, deployer)
    local boat = SpawnPrefab("sea_chiminea")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
        inst:Remove()
    end
end

local function fnsea_chiminea(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("firepit", true)


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploysea_chiminea
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end

local function ondeploywaterchest1(inst, pt, deployer)
    local boat = SpawnPrefab("waterchest1")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
        inst:Remove()
    end
end

local function fnwaterchest1(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("chest", true)


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploywaterchest1
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end

local function ondeploysea_yard(inst, pt, deployer)
    local boat = SpawnPrefab("sea_yard")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
        inst:Remove()
    end
end

local function fnsea_yard(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("seayard", true)


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploysea_yard
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.MEDIUM)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	return inst
end

return  Prefab( "porto_buoy", fnbuoy, assets, prefabs),
		MakePlacer( "porto_buoy_placer", "buoy", "buoy", "ground", false, false, false),
		Prefab( "porto_fish_farm", fnfish_farm, assets, prefabs),
		MakePlacer( "porto_fish_farm_placer", "fish_farm", "fish_farm", "idle", false, false, false),
		Prefab( "porto_ballphinhouse", fnballphinhouse, assets, prefabs),
		MakePlacer( "porto_ballphinhouse_placer", "ballphin_house", "ballphin_house", "idle", false, false, false),	
		Prefab( "porto_researchlab5", fnresearchlab5, assets, prefabs),
		MakePlacer( "porto_researchlab5_placer", "researchlab5", "researchlab5", "idle", false, false, false),

		Prefab( "porto_tar_extractor", fntar_extractor, assets, prefabs),
		MakePlacer( "porto_tar_extractor_placer", "tar_extractor", "tar_extractor", "idle", false, false, false),
		Prefab( "porto_sea_chiminea", fnsea_chiminea, assets, prefabs),
		MakePlacer( "porto_sea_chiminea_placer", "fire_water_pit", "fire_water_pit", "idle_water", false, false, false),	
		Prefab( "porto_waterchest1", fnwaterchest1, assets, prefabs),
		MakePlacer( "porto_waterchest1_placer", "water_chest", "water_chest", "closed", false, false, false),
		Prefab( "porto_sea_yard", fnsea_yard, assets, prefabs),
		MakePlacer( "porto_sea_yard_placer", "sea_yard", "sea_yard", "idle", false, false, false)		