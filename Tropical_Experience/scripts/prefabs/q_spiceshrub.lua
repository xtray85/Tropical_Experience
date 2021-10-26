local assets =
{
    Asset("ANIM", "anim/quagmire_spiceshrub.zip"),
    Asset("ANIM", "anim/quagmire_spotspice_sprig.zip"),
    Asset("ANIM", "anim/quagmire_spotspice_ground.zip"),
}

local prefabs =
{
    "quagmire_spotspice_sprig",
}

local prefabs_ground =
{
    "quagmire_burnt_ingredients",
}

------------------------------
local function onpickedfn(inst, picker)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
        inst.AnimState:PushAnimation("picked", false)
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
        inst.AnimState:PlayAnimation("picked")
end

local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
        end

        inst.components.lootdropper:SpawnLootPrefab(
            withered and
            "quagmire_spotspice_sprig" or
            "dug_grass"
        )
    end
    inst:Remove()
end

local function shrub_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst.MiniMapEntity:SetIcon("quagmire_spotspice_shrub.png")

    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetBuild("quagmire_spiceshrub")
    inst.AnimState:SetBank("quagmire_spiceshrub")
    inst.AnimState:PlayAnimation("idle", true)
	MakeObstaclePhysics(inst, 0.35)

        inst:AddTag("renewable")
        inst:AddTag("witherable")

    inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.AnimState:SetTime(math.random() * 2)
        local color = 0.75 + math.random() * 0.25
        inst.AnimState:SetMultColour(color, color, color, 1)

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"

        inst.components.pickable:SetUp("quagmire_spotspice_sprig", TUNING.GRASS_REGROW_TIME)
        inst.components.pickable.onregenfn = onregenfn
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
--        inst.components.pickable.makebarrenfn = makebarrenfn
        inst.components.pickable.max_cycles = 20
        inst.components.pickable.cycles_left = 20
--        inst.components.pickable.ontransplantfn = ontransplantfn

        inst:AddComponent("witherable")

        inst:AddComponent("lootdropper")
        inst:AddComponent("inspectable")

--		if not GetGameModeProperty("disable_transplanting") then
--			inst:AddComponent("workable")
--			inst.components.workable:SetWorkAction(ACTIONS.DIG)
--			inst.components.workable:SetOnFinishCallback(dig_up)
--			inst.components.workable:SetWorkLeft(1)
--		end
        ---------------------

        MakeMediumBurnable(inst)
        MakeSmallPropagator(inst)
        MakeNoGrowInWinter(inst)
        MakeHauntableIgnite(inst)
		MakeSnowCovered(inst, .01)		
        ---------------------

    return inst
end

local function sprig_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	

    inst.AnimState:SetBank("quagmire_spotspice_sprig")
    inst.AnimState:SetBuild("quagmire_spotspice_sprig")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("cattoy")
    inst:AddTag("renewable")
	inst:AddTag("plant")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

--    inst:AddComponent("edible")
--    inst.components.edible.healthvalue = TUNING.HEALING_MEDSMALL
--    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
--    inst.components.edible.foodtype = FOODTYPE.VEGGIE
	
--    inst:AddComponent("perishable")
--    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
--    inst.components.perishable:StartPerishing()
--    inst.components.perishable.onperishreplacement = "spoiled_food"	

    inst:AddComponent("inspectable")
    inst:AddComponent("tradable")

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
	
	inst:AddComponent("mealable")
	inst.components.mealable:SetType("spice")		

    MakeHauntableLaunchAndIgnite(inst)
    return inst
end

local function groundspice_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	

    inst.AnimState:SetBank("quagmire_spotspice_ground")
    inst.AnimState:SetBuild("quagmire_spotspice_ground")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("quagmire_stewable")
    inst:AddTag("spice")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inventoryitem")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM	
	
    inst:AddComponent("inspectable")
    inst:AddComponent("tradable")	
	
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)	

    MakeHauntableLaunchAndIgnite(inst)
	
    return inst
end

return Prefab("quagmire_spotspice_shrub", shrub_fn, assets, prefabs),
			Prefab("quagmire_spotspice_sprig", sprig_fn, assets),
		    Prefab("quagmire_spotspice_ground", groundspice_fn, assets, prefabs_ground)
