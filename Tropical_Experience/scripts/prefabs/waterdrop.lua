local assets =
{
	Asset("ANIM", "anim/waterdrop.zip"),
    Asset("ANIM", "anim/lifeplant.zip"),
}

local function IsWater(tile)
	return tile == GROUND.OCEAN_SWELL or 
		tile == GROUND.OCEAN_BRINEPOOL or 
		tile == GROUND.OCEAN_BRINEPOOL_SHORE or 		
		tile == GROUND.OCEAN_HAZARDOUS or
		tile == GROUND.OCEAN_ROUGH or 
		tile == GROUND.IMPASSABLE or 
		tile == GROUND.OCEAN_COASTAL or 
		tile == GROUND.OCEAN_WATERLOG or 		
		tile == GROUND.OCEAN_COASTAL_SHORE		
end

local function oneat(inst, eater)
    if eater.components.poisonable ~= nil then
        eater.components.poisonable:WearOff()
    end
end

local function ondeploy (inst, pt) 
    local plant = SpawnPrefab("lifeplant")
    plant.Transform:SetPosition(pt:Get() )
    plant.AnimState:PlayAnimation("grow")
    plant.AnimState:PushAnimation("idle_loop",true)

    inst.planted = true
    inst:Remove()
end

local notags = {'NOBLOCK', 'player', 'FX'}
local function test_ground(inst, pt)
    local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
    local ground_OK = tiletype ~= GROUND.ROCKY and tiletype ~= GROUND.ROAD and tiletype ~= GROUND.IMPASSABLE and
                        tiletype ~= GROUND.UNDERROCK and tiletype ~= GROUND.WOODFLOOR and 
                        tiletype ~= GROUND.CARPET and tiletype ~= GROUND.CHECKER and tiletype < GROUND.UNDERGROUND and not IsWater(tiletype)
    
    if ground_OK then
        return true
    end
    return false
end


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("waterdrop")
    inst.AnimState:SetBuild("waterdrop")
    inst.AnimState:PlayAnimation("idle")
	
    inst:AddTag("waterdrop")	

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES  
    inst.components.edible.healthvalue = TUNING.HEALING_SUPERHUGE * 3
    inst.components.edible.hungervalue = TUNING.CALORIES_SUPERHUGE * 3
    inst.components.edible.sanityvalue = TUNING.SANITY_HUGE * 3   
    inst.components.edible:SetOnEatenFn(oneat)

    inst:AddComponent("inspectable")
	

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    
    inst:AddComponent("deployable")
    inst.components.deployable.CanDeploy = test_ground
    inst.components.deployable.ondeploy = ondeploy    

    return inst
end

return Prefab( "common/inventory/waterdrop", fn, assets),
       MakePlacer( "common/waterdrop_placer", "lifeplant", "lifeplant", "idle_loop" )

