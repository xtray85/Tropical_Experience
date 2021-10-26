local assets =
{
    Asset("ANIM", "anim/beds.zip"),
}

--We don't watch "stopnight" because that would not work in a clock
--without night phase
local function wakeuptest(inst, phase)
    if phase ~= "night" then
        inst.components.sleepingbag:DoWakeUp()
    end
end

local function onfinished(inst)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onwake(inst, sleeper, nostatechange)
    if inst.sleeptask ~= nil then
        inst.sleeptask:Cancel()
        inst.sleeptask = nil
    end

    inst:StopWatchingWorldState("phase", wakeuptest)

    if not nostatechange then
        if sleeper.sg:HasStateTag("bedroll") then
            sleeper.sg.statemem.iswaking = true
        end
        sleeper.sg:GoToState("wakeup")
    end

--    if inst.components.finiteuses == nil or inst.components.finiteuses:GetUses() <= 0 then
--        if inst.components.stackable ~= nil then
--            inst.components.stackable:Get():Remove()
--        else
--            inst:Remove()
--        end
--    end
end

local function onsleeptick(inst, sleeper)
    local isstarving = false

    if sleeper.components.hunger ~= nil then
        sleeper.components.hunger:DoDelta(inst.hunger_tick, true, true)
        isstarving = sleeper.components.hunger:IsStarving()
    end

    if sleeper.components.sanity ~= nil and sleeper.components.sanity:GetPercentWithPenalty() < 1 then
        sleeper.components.sanity:DoDelta(inst.sanity_tick, true)
    end

    if not isstarving and inst.components.sleepingbag.healthsleep and sleeper.components.health ~= nil then
        sleeper.components.health:DoDelta(inst.health_tick, true, "bedroll", true)
    end

    if sleeper.components.temperature ~= nil then
        if inst.sleep_temp_min ~= nil and sleeper.components.temperature:GetCurrent() < inst.sleep_temp_min then
            sleeper.components.temperature:SetTemperature(sleeper.components.temperature:GetCurrent() + TUNING.SLEEP_TEMP_PER_TICK)
        elseif inst.sleep_temp_max ~= nil and sleeper.components.temperature:GetCurrent() > inst.sleep_temp_max then
            sleeper.components.temperature:SetTemperature(sleeper.components.temperature:GetCurrent() - TUNING.SLEEP_TEMP_PER_TICK)
        end
    end
	
    if inst.components.finiteuses then
	if inst.components.finiteuses.current <= 0 then
	inst.components.sleepingbag:DoWakeUp()
	onfinished(inst)
	end
        inst.components.finiteuses.current = inst.components.finiteuses.current - 0.02
    end

    if isstarving then
        inst.components.sleepingbag:DoWakeUp()
    end
end

local function onsleep(inst, sleeper)
    -- check if we're in an invalid period (i.e. daytime). if so: wakeup
    inst:WatchWorldState("phase", wakeuptest)

    if inst.sleeptask ~= nil then
        inst.sleeptask:Cancel()
    end
    inst.sleeptask = inst:DoPeriodicTask(TUNING.SLEEP_TICK_PERIOD, onsleeptick, nil, sleeper)
end

local function onuse_straw(inst, sleeper)
--    sleeper.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw")
end

local function onuse_furry(inst, sleeper)
--    local skin_build = inst:GetSkinBuild()
--    if skin_build ~= nil then
--        sleeper.AnimState:OverrideItemSkinSymbol("swap_bedroll", skin_build, "bedroll_furry", inst.GUID, "swap_bedroll_furry")
--    else
--        sleeper.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_furry", "bedroll_furry")
--    end
end

local function onhammered(inst)
    if inst.components.lootdropper then
            inst.components.lootdropper:DropLoot()
    end
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    if inst.SoundEmitter then
        inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    end
    inst:Remove()
end  

local function common_fn(anim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    inst:AddTag("cama")
    inst:AddTag("structure")	

--    MakeObstaclePhysics(inst, 1)
--	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)

    inst.AnimState:SetBank("beds")
    inst.AnimState:SetBuild("beds")
    inst.AnimState:PlayAnimation(anim)

--    MakeInventoryFloatable(inst, "small", 0.2, 0.95)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(onhammered)
--   inst.components.workable:SetOnWorkCallback(onhit)	

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished(onfinished)

    MakeSmallBurnable(inst, TUNING.LONG_BURNABLE)
    MakeSmallPropagator(inst)

    inst:AddComponent("sleepingbag")
    inst.components.sleepingbag.onsleep = onsleep
    inst.components.sleepingbag.onwake = onwake	

    MakeHauntableLaunchAndIgnite(inst)

    return inst
end

local function bed0()
    local inst = common_fn("bed0")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(5)
    inst.components.finiteuses:SetUses(5)	

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * .67
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5	
    inst.components.sleepingbag.healthsleep = false

    return inst
end

local function bed1()
    local inst = common_fn("bed1")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.finiteuses:SetMaxUses(6)
    inst.components.finiteuses:SetUses(6)		
	
    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * .80
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5	
    inst.components.sleepingbag.healthsleep = false

    return inst
end

local function bed2()
    local inst = common_fn("bed2")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(7)
    inst.components.finiteuses:SetUses(7)		

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5
    inst.components.sleepingbag.healthsleep = false

    return inst
end

local function bed3()
    local inst = common_fn("bed3")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(9)
    inst.components.finiteuses:SetUses(9)		

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * 1.2
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5

    return inst
end

local function bed4()
    local inst = common_fn("bed4")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(12)
    inst.components.finiteuses:SetUses(12)		

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * 1.2
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK * 1.2
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5
--    inst.onuse = onuse_furry

    return inst
end

local function bed5()
    local inst = common_fn("bed5")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(12)
    inst.components.finiteuses:SetUses(12)		

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * 1.2
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK * 1.4
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5
--    inst.onuse = onuse_furry

    return inst
end

local function bed6()
    local inst = common_fn("bed6")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(12)
    inst.components.finiteuses:SetUses(12)		

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * 1.4
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK * 1.6
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5
--    inst.onuse = onuse_furry

    return inst
end

local function bed7()
    local inst = common_fn("bed7")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(12)
    inst.components.finiteuses:SetUses(12)		

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * 1.4
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK * 1.8
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5
--    inst.onuse = onuse_furry

    return inst
end

local function bed8()
    local inst = common_fn("bed8")
	inst.Transform:SetScale(1.4, 1.4, 1.4)
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.components.finiteuses:SetMaxUses(12)
    inst.components.finiteuses:SetUses(12)		

    inst.sanity_tick = TUNING.SLEEP_SANITY_PER_TICK * 1.4
    inst.health_tick = TUNING.SLEEP_HEALTH_PER_TICK * 2
    inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK
    inst.sleep_temp_min = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY
    inst.sleep_temp_max = TUNING.SLEEP_TARGET_TEMP_BEDROLL_FURRY * 1.5
--    inst.onuse = onuse_furry

    return inst
end

return 
	Prefab("bed0", bed0, assets),
	Prefab("bed1", bed1, assets),
    Prefab("bed2", bed2, assets),
    Prefab("bed3", bed3, assets),
    Prefab("bed4", bed4, assets),
    Prefab("bed5", bed5, assets),
    Prefab("bed6", bed6, assets),
    Prefab("bed7", bed7, assets),
    Prefab("bed8", bed8, assets),
	MakePlacer("bed0_placer", "beds", "beds", "bed0", nil, nil, nil, 1.4),
	MakePlacer("bed1_placer", "beds", "beds", "bed1", nil, nil, nil, 1.4),
	MakePlacer("bed2_placer", "beds", "beds", "bed2", nil, nil, nil, 1.4),
	MakePlacer("bed3_placer", "beds", "beds", "bed3", nil, nil, nil, 1.4),
	MakePlacer("bed4_placer", "beds", "beds", "bed4", nil, nil, nil, 1.4),
	MakePlacer("bed5_placer", "beds", "beds", "bed5", nil, nil, nil, 1.4),
	MakePlacer("bed6_placer", "beds", "beds", "bed6", nil, nil, nil, 1.4),
	MakePlacer("bed7_placer", "beds", "beds", "bed7", nil, nil, nil, 1.4),
	MakePlacer("bed8_placer", "beds", "beds", "bed8", nil, nil, nil, 1.4)
