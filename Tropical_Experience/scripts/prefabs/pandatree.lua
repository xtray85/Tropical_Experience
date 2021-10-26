local assets =
{
    Asset("ANIM", "anim/pandatreebuild.zip"),
	Asset("ANIM", "anim/panda_bighouse.zip"),
	Asset("ANIM", "anim/pigruins_build.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()

    MakeObstaclePhysics(inst, 1.5)
    inst.Physics:SetCylinder(1.35, 3)
	inst.Transform:SetScale(1.5, 1.5, 1.5)

    inst.MiniMapEntity:SetIcon("pandatree.png")

    inst.AnimState:SetBank("pillar_archive")
    inst.AnimState:SetBuild("pandatreebuild")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

local function StartSpawning(inst)
    if not inst:HasTag("burnt") and
        inst.components.childspawner ~= nil then
        inst.components.childspawner:StartSpawning()
    end
end

local function StopSpawning(inst)
    if not inst:HasTag("burnt") and inst.components.childspawner ~= nil then
        inst.components.childspawner:StopSpawning()
    end
end

local function OnSpawned(inst, child)
    if not inst:HasTag("burnt") then
        if TheWorld.state.isday and
            inst.components.childspawner ~= nil and
            inst.components.childspawner:CountChildrenOutside() >= 1 and
            child.components.combat.target == nil then
            StopSpawning(inst)
        end
    end
end

local function OnGoHome(inst, child)
    if not inst:HasTag("burnt") then
        if inst.components.childspawner ~= nil and
            inst.components.childspawner:CountChildrenOutside() < 1 then
            StartSpawning(inst)
        end
    end
end

local function OnIsDay(inst, isday)
  if not TheWorld.state.isday then
        StopSpawning(inst)
  elseif not inst:HasTag("burnt") then
            inst.components.childspawner:ReleaseAllChildren()
        StartSpawning(inst)
    end
	
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst:RemoveComponent("childspawner")
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        if inst.components.childspawner ~= nil then
            inst.components.childspawner:ReleaseAllChildren(worker)
        end
        inst.AnimState:PushAnimation("idle")
    end
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()

    MakeObstaclePhysics(inst, 1.5)
    inst.Physics:SetCylinder(1.35, 3)
	inst.Transform:SetScale(1.5, 1.5, 1.5)

    inst.MiniMapEntity:SetIcon("pandahouse.png")

    inst.AnimState:SetBank("pillar_archive")
    inst.AnimState:SetBuild("panda_bighouse")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
        inst:AddComponent("lootdropper")
	
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(5)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)	
	
    inst:AddComponent("childspawner")
	inst.components.childspawner.childname = "panda"
    inst.components.childspawner:SetSpawnedFn(OnSpawned)
    inst.components.childspawner:SetGoHomeFn(OnGoHome)
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 4)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(1)	
	
        inst:AddComponent("inspectable")
	
    inst:WatchWorldState("isday", OnIsDay)

    StartSpawning(inst)	

    return inst
end

local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()

    MakeObstaclePhysics(inst, 1.5)
    inst.Physics:SetCylinder(1.35, 3)
	inst.Transform:SetScale(1.5, 1.5, 1.5)

    inst.MiniMapEntity:SetIcon("pig_ruins_pillar.png")

    inst.AnimState:SetBank("pillar_archive")
    inst.AnimState:SetBuild("pigruins_build")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

return Prefab("pandatree", fn, assets),
	   Prefab("pandahouse", fn1, assets),
       MakePlacer("pandahouse_placer", "pillar_archive", "panda_bighouse", "idle", nil,nil, nil, nil, nil, nil, nil, nil),
	   Prefab("pillar_pigarchive", fn2, assets)	   
