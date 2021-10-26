local prefabs =
{
    "tumbleweed",
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "tumbleweed"
    inst.components.childspawner:SetMaxChildren(math.random(TUNING.MIN_TUMBLEWEEDS_PER_SPAWNER,TUNING.MAX_TUMBLEWEEDS_PER_SPAWNER))
    inst.components.childspawner:SetSpawnPeriod(math.random(TUNING.MIN_TUMBLEWEED_SPAWN_PERIOD, TUNING.MAX_TUMBLEWEED_SPAWN_PERIOD))
    inst.components.childspawner:SetRegenPeriod(TUNING.TUMBLEWEED_REGEN_PERIOD)
    inst.components.childspawner.spawnoffscreen = true
    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "quagmire_pebblecrab"
    inst.components.childspawner:SetMaxChildren(2)
    inst.components.childspawner:SetSpawnPeriod(math.random(TUNING.MIN_TUMBLEWEED_SPAWN_PERIOD, TUNING.MAX_TUMBLEWEED_SPAWN_PERIOD))
    inst.components.childspawner:SetRegenPeriod(TUNING.TUMBLEWEED_REGEN_PERIOD)
    inst.components.childspawner.spawnoffscreen = true
    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "trapslug"
    inst.components.childspawner:SetMaxChildren(math.random(1,2))
    inst.components.childspawner:SetSpawnPeriod(math.random(TUNING.MIN_TUMBLEWEED_SPAWN_PERIOD, TUNING.MAX_TUMBLEWEED_SPAWN_PERIOD))
    inst.components.childspawner:SetRegenPeriod(TUNING.TUMBLEWEED_REGEN_PERIOD)
    inst.components.childspawner.spawnoffscreen = true
    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

local function fn5()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "billsnow"
    inst.components.childspawner:SetMaxChildren(1)
    inst.components.childspawner:SetSpawnPeriod(math.random(TUNING.MIN_TUMBLEWEED_SPAWN_PERIOD, TUNING.MAX_TUMBLEWEED_SPAWN_PERIOD))
    inst.components.childspawner:SetRegenPeriod(TUNING.TUMBLEWEED_REGEN_PERIOD)
    inst.components.childspawner.spawnoffscreen = true
    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

local function fn6()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "giantsnow"
    inst.components.childspawner:SetMaxChildren(1)
    inst.components.childspawner:SetSpawnPeriod(math.random(TUNING.MIN_TUMBLEWEED_SPAWN_PERIOD, TUNING.MAX_TUMBLEWEED_SPAWN_PERIOD))
    inst.components.childspawner:SetRegenPeriod(TUNING.TUMBLEWEED_REGEN_PERIOD)
    inst.components.childspawner.spawnoffscreen = true
    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

local function fn7()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "giantgrub"
    inst.components.childspawner:SetMaxChildren(1)
    inst.components.childspawner:SetSpawnPeriod(math.random(TUNING.MIN_TUMBLEWEED_SPAWN_PERIOD, TUNING.MAX_TUMBLEWEED_SPAWN_PERIOD))
    inst.components.childspawner:SetRegenPeriod(TUNING.TUMBLEWEED_REGEN_PERIOD)
    inst.components.childspawner.spawnoffscreen = true
    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

local function fn8()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "pigghost"
    inst.components.childspawner:SetMaxChildren(1)
    inst.components.childspawner:SetSpawnPeriod(5)
    inst.components.childspawner:SetRegenPeriod(5)
    inst.components.childspawner.spawnoffscreen = true
    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

return Prefab("tumbleweedspawner", fn, nil, prefabs),
	   Prefab("pebblecrabspawner", fn2, nil, prefabs),
	   Prefab("trapslugspawner", fn3, nil, prefabs),	
	   Prefab("billsnowspawner", fn5, nil, prefabs),	
	   Prefab("giantsnowspawner", fn6, nil, prefabs),
	   Prefab("giantgrubspawner", fn7, nil, prefabs),	   
	   Prefab("pigghostspawner", fn8, nil, prefabs)	
