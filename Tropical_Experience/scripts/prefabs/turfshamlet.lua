local assets =
{
	Asset("ANIM", "anim/turf2.zip"),
	Asset("ANIM", "anim/turf_1.zip"),
}

local prefabs =
{
    "gridplacer",
}

local function make_turf(tile, data)
    local function ondeploy(inst, pt, deployer)
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            deployer.SoundEmitter:PlaySound("dontstarve/wilson/dig")
        end

        local map = TheWorld.Map
        local original_tile_type = map:GetTileAtPoint(pt:Get())
        local x, y = map:GetTileCoordsAtPoint(pt:Get())
        if x ~= nil and y ~= nil then
            map:SetTile(x, y, tile)
            map:RebuildLayer(original_tile_type, x, y)
            map:RebuildLayer(tile, x, y)
        end

        local minimap = TheWorld.minimap.MiniMap
        minimap:RebuildLayer(original_tile_type, x, y)
        minimap:RebuildLayer(tile, x, y)

        inst.components.stackable:Get():Remove()
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)	

		inst.AnimState:SetBank("turf")
		inst.AnimState:SetBuild("turf_1")
        inst.AnimState:PlayAnimation(data.anim)

        inst:AddTag("groundtile")
        inst:AddTag("molebait")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

        inst:AddComponent("inspectable")
		inst:AddComponent("inventoryitem")
		--inst.components.inventoryitem.imagename = data.name
    	inst.components.inventoryitem.atlasname = data.invent
		
		if data.invent == "images/inventoryimages/volcanoinventory.xml" then inst.caminho = "images/inventoryimages/volcanoinventory.xml" end
		
        inst:AddComponent("bait")

        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.MED_FUEL
        MakeMediumBurnable(inst, TUNING.MED_BURNTIME)
        MakeSmallPropagator(inst)
        MakeHauntableLaunchAndIgnite(inst)

        inst:AddComponent("deployable")
        inst.components.deployable:SetDeployMode(DEPLOYMODE.TURF)
        inst.components.deployable.ondeploy = ondeploy
        inst.components.deployable:SetUseGridPlacer(true)

        ---------------------
        return inst
    end

    return Prefab("turf_"..data.name, fn, assets, prefabs)
end

local ret = {}
table.insert(ret, make_turf(GROUND.CHECKEREDLAWN or GROUND.MARSH, {name = "checkeredlawn", anim = "checkeredlawn", invent = "images/inventoryimages/volcanoinventory.xml"}))
table.insert(ret, make_turf(GROUND.SUBURB or GROUND.MARSH, {name = "suburb", anim = "mossy_blossom", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.FOUNDATION or GROUND.MARSH, {name = "foundation", anim = "fanstone", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.COBBLEROAD or GROUND.MARSH, {name = "cobbleroad", anim = "cobbleroad", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.GASJUNGLE or GROUND.MARSH, {name = "gasjungle", anim = "gasjungle", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.FIELDS or GROUND.MARSH, {name = "fields", anim = "farmland", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.RAINFOREST or GROUND.MARSH, {name = "rainforest", anim = "rainforest", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.DEEPRAINFOREST or GROUND.MARSH, {name = "deeprainforest", anim = "deepjungle", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation 

table.insert(ret, make_turf(GROUND.PAINTED or GROUND.MARSH, {name = "painted", anim = "bog", invent = "images/turfs/turf01-9.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.PLAINS or GROUND.MARSH, {name = "plains", anim = "plains", invent = "images/turfs/turf01-10.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.BATTLEGROUND or GROUND.MARSH, {name = "battleground", anim = "pig_ruins", invent = "images/turfs/turf01-11.xml"})) --place a marsh

table.insert(ret, make_turf(GROUND.BEARDRUG or GROUND.MARSH, {name = "beardrug", anim = "beard_hair", invent = "images/turfs/turf01-14.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.PIGRUINS or GROUND.MARSH, {name = "pigruins", anim = "pig_ruins", invent = "images/inventoryimages/volcanoinventory.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.ANTFLOOR or GROUND.MARSH, {name = "antfloor", anim = "antcave", invent = "images/turfs/turf01-13.xml"})) --place a marsh tile, if the swamp generation is disabled
table.insert(ret, make_turf(GROUND.BATFLOOR or GROUND.MARSH, {name = "batfloor", anim = "batcave", invent = "images/turfs/turf01-12.xml"})) --place a marsh tile, if the swamp generation is disabled


return unpack(ret)

