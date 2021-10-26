require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/raft_basic.zip"),
	Asset("ANIM", "anim/raft_surfboard_build.zip"),
	Asset("ANIM", "anim/boat_hud_raft.zip"),
	Asset("ANIM", "anim/surfboard.zip"),
	Asset("ANIM", "anim/corkboat.zip"),	
	Asset("ANIM", "anim/rowboat_basic.zip"),
	Asset("ANIM", "anim/rowboat_build.zip"),
	Asset("ANIM", "anim/raft_build.zip"),
	Asset("ANIM", "anim/rowboat_cargo_build.zip"),
	Asset("ANIM", "anim/rowboat_armored_build.zip"),
	Asset("ANIM", "anim/rowboat_encrusted_build.zip"),
	Asset("ANIM", "anim/raft_log_build.zip"),
	Asset("ANIM", "anim/pirate_boat_build.zip"),	
	Asset("ANIM", "anim/coracle_boat_build.zip"),	
}

local prefabs =
{

}


local function drop(inst, pt, deployer)
inst.Physics:Teleport(pt:Get())
local map = TheWorld.Map
local ex, ey, ez = inst.Transform:GetWorldPosition()
local movimento
if inst.prefab == ("surfboarditem") then
local movimento = SpawnPrefab("surfboard")
else
local movimento = SpawnPrefab("corkboat")
end
if movimento then
movimento.Transform:SetPosition(ex, ey, ez)
movimento.components.finiteuses.current = inst.components.finiteuses.current
end
return inst:Remove()
end

local function ondropped(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
local pt=Vector3(x,y,z)

if ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_HAZARDOUS or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_BRINEPOOL_SHORE then
drop(inst,pt,inst)
end
if ground ~= GROUND.OCEAN_COASTAL and ground ~= GROUND.OCEAN_WATERLOG and ground ~= GROUND.OCEAN_COASTAL_SHORE and ground ~= GROUND.OCEAN_SWELL and ground ~= GROUND.OCEAN_ROUGH and ground ~= GROUND.OCEAN_BRINEPOOL and ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and ground ~= GROUND.OCEAN_HAZARDOUS then
        inst.AnimState:PlayAnimation("idle", true)
end

end

local function ondeployraft(inst, pt, deployer)
    local boat = SpawnPrefab("raft")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fnraft(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("IDLE")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("bambo")

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployraft
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end

local function ondeployraftold(inst, pt, deployer)
    local boat = SpawnPrefab("raft_old")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fnraftold(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("IDLE")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("bambo")

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployraftold
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end

local function ondeploylograft(inst, pt, deployer)
    local boat = SpawnPrefab("lograft")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fnlograft(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("IDLE")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("log")

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploylograft
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end

local function ondeploylograftold(inst, pt, deployer)
    local boat = SpawnPrefab("lograft_old")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fnlograftold(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("IDLE")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("log")

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploylograftold
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end

local function ondeployrowboat(inst, pt, deployer)
    local boat = SpawnPrefab("rowboat")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fnrowboat(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("row")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployrowboat
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end

local function ondeploycargoboat(inst, pt, deployer)
    local boat = SpawnPrefab("cargoboat")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fncargoboat(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("cargo")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploycargoboat
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end

local function ondeployarmouredboat(inst, pt, deployer)
    local boat = SpawnPrefab("armouredboat")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fnarmouredboat(sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("seashell")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployarmouredboat
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end 

local function ondeployencrustedboat(inst, pt, deployer)
    local boat = SpawnPrefab("encrustedboat")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end
end

local function fnencrustedboat(sim)
	local inst = CreateEntity()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("limestone")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeployencrustedboat
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end 

local function ondeploysurfboard(inst, pt, deployer)
    local boat = SpawnPrefab("surfboard")
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

	if inst.components.finiteuses and  boat.components.finiteuses then boat.components.finiteuses.current = inst.components.finiteuses.current end
		
        inst:Remove()
    end
end
local function ondeploycorkboat(inst, pt, deployer)
    local boat = SpawnPrefab("corkboat")
    if boat ~= nil then
	boat.Transform:SetPosition(pt.x, 0, pt.z)
	
	if inst.components.finiteuses and  boat.components.finiteuses then boat.components.finiteuses.current = inst.components.finiteuses.current end	

        inst:Remove()
    end
end

local function fnsurfboard(sim)
	local inst = CreateEntity()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("IDLE")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("surfboard")
	inst.AnimState:SetBuild("surfboard")
	inst.AnimState:PlayAnimation("idle")

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploysurfboard
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "boat_item"	

    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end 

local function ondeploywoodlegsboat(inst, pt, deployer)
    local boat = SpawnPrefab("woodlegsboat")
	local velaw = SpawnPrefab("woodlegssail") 
	local canhao = SpawnPrefab("boatcannon") 
	boat.components.container:GiveItem(velaw, 1)
	boat.components.container:GiveItem(canhao, 2)	
	
	
	
	
    if boat ~= nil then
        boat.Physics:SetCollides(false)
        boat.Physics:Teleport(pt.x, 0, pt.z)
        boat.Physics:SetCollides(true)

        inst:Remove()
    end	
end

local function fnwoodlegsboat(sim)
	local inst = CreateEntity()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	trans:SetFourFaced()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("seafarer_boat")
    inst.AnimState:SetBuild("seafarer_boat")
    inst.AnimState:PlayAnimation("pirate")
	
    inst:AddTag("boatbuilder")

    MakeInventoryPhysics(inst)

    MakeInventoryFloatable(inst, "med", 0.25, 0.83)

    --Deployable needs to be client side because of the custom deploy range
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploywoodlegsboat
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    --inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    MakeHauntableLaunch(inst)
	
	return inst
end

local function onfinished(inst)
inst:Remove()
end

local function fnsurfboarditem(sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("surfboard")
	inst.AnimState:SetBuild("surfboard")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("aquatic")
	
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploysurfboard
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(100)
	inst.components.finiteuses:SetUses(100)
	inst.components.finiteuses:SetOnFinished(onfinished)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst.components.inventoryitem:SetOnDroppedFn(ondropped)


	return inst
end

local function fncorkboatitem(sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("corkboat")
	inst.AnimState:SetBuild("corkboat")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("aquatic")
	
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploycorkboat
    inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(80)
	inst.components.finiteuses:SetUses(80)
	inst.components.finiteuses:SetOnFinished(onfinished)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	inst.components.inventoryitem:SetOnDroppedFn(ondropped)


	return inst
end


return Prefab( "porto_raft", fnraft, assets, prefabs),
MakePlacer( "porto_raft_placer", "raft", "raft_build", "run_loop", false, false, false),
Prefab( "porto_lograft", fnlograft, assets, prefabs),
MakePlacer( "porto_lograft_placer", "raft", "raft_log_build", "run_loop", false, false, false),
Prefab( "porto_rowboat", fnrowboat, assets, prefabs),
MakePlacer( "porto_rowboat_placer", "rowboat", "rowboat_build", "run_loop", false, false, false),
Prefab( "porto_cargoboat", fncargoboat, assets, prefabs),
MakePlacer( "porto_cargoboat_placer", "rowboat", "rowboat_cargo_build", "run_loop", false, false, false),
Prefab( "porto_armouredboat", fnarmouredboat, assets, prefabs),
MakePlacer( "porto_armouredboat_placer", "rowboat", "rowboat_armored_build", "run_loop", false, false, false),
Prefab( "porto_encrustedboat", fnencrustedboat, assets, prefabs),
MakePlacer( "porto_encrustedboat_placer", "rowboat", "rowboat_encrusted_build", "run_loop", false, false, false),
Prefab( "porto_surfboard", fnsurfboard, assets, prefabs),
MakePlacer( "porto_surfboard_placer",  "raft", "raft_surfboard_build", "run_loop", false, false, false), 
Prefab( "porto_woodlegsboat", fnwoodlegsboat, assets, prefabs),
MakePlacer( "porto_woodlegsboat_placer", "pirate_boat_placer", "pirate_boat_placer", "idle", false, false, false),
Prefab( "surfboarditem", fnsurfboarditem, assets, prefabs),
MakePlacer( "surfboarditem_placer", "raft", "raft_surfboard_build", "run_loop", false, false, false),
Prefab( "corkboatitem", fncorkboatitem, assets, prefabs),
MakePlacer( "corkboatitem_placer", "rowboat", "coracle_boat_build", "run_loop", false, false, false),

Prefab( "porto_raft_old", fnraftold, assets, prefabs),
MakePlacer( "porto_raft_old_placer", "raft", "raft_build", "run_loop", false, false, false),
Prefab( "porto_lograft_old", fnlograftold, assets, prefabs),
MakePlacer( "porto_lograft_old_placer", "raft", "raft_log_build", "run_loop", false, false, false)