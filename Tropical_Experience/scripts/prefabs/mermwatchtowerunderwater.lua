local assets =
{
    Asset("ANIM", "anim/merm_guard_tower.zip"),
    Asset("MINIMAP_IMAGE", "merm_guard_tower"),
}

local prefabs =
{
    "mermguard",
    "collapse_big",
}


local function onhammered(inst, worker)
    inst:RemoveComponent("childspawner")
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
        if inst.components.childspawner ~= nil then
            inst.components.childspawner:ReleaseAllChildren(worker)
        end
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", true)
end

local function StartSpawning(inst)
    if  inst.components.childspawner ~= nil then
        inst.components.childspawner:StartSpawning()
        inst.AnimState:Show("flag")
        inst.AnimState:PlayAnimation("flagup")
        inst.AnimState:PushAnimation("idle")
    end
end

local function StopSpawning(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:StopSpawning()
        inst.AnimState:PlayAnimation("flagdown")
    end
end

local function OnSpawned(inst, child)
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
        if  inst.components.childspawner ~= nil and
            inst.components.childspawner:CountChildrenOutside() >= 1 and
            child.components.combat.target == nil then
            StartSpawning(inst)
        end
end

local function OnGoHome(inst, child)
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
        if inst.components.childspawner ~= nil and
            inst.components.childspawner:CountChildrenOutside() < 1 then
            StartSpawning(inst)
        end
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("merm_guard_tower.png")

    inst.AnimState:SetBank("merm_guard_tower")
    inst.AnimState:SetBuild("merm_guard_tower")
    inst.AnimState:PlayAnimation("idle", true)


    inst:AddTag("structure")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper")
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "mermfisherguardunderwater"
    inst.components.childspawner:SetSpawnedFn(OnSpawned)
    inst.components.childspawner:SetGoHomeFn(OnGoHome)
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME * 0.5)
    inst.components.childspawner:SetSpawnPeriod(10)
    inst.components.childspawner:SetMaxChildren(TUNING.MERMWATCHTOWER_MERMS)

    inst:AddComponent("inspectable")

    inst:DoTaskInTime(0, function(inst)
        inst.components.childspawner:ReleaseAllChildren()
        inst.components.childspawner:StartSpawning()
    end)

    return inst
end

return Prefab("mermwatchtowerunderwater", fn, assets, prefabs)

