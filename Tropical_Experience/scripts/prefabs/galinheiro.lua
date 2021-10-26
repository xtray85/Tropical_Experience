require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/galinheiro.zip"),
}

local prefabs =
{
	"chicken",
}

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
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
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle")
    end
end

local function StartSpawning(inst)
    if not inst:HasTag("burnt") and
        not TheWorld.state.iswinter and
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
	    inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle")
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
	    inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle")
        if inst.components.childspawner ~= nil and
            inst.components.childspawner:CountChildrenOutside() < 1 then
            StartSpawning(inst)
        end
    end
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local function onignite(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren()
    end
end

local function onburntup(inst)
    inst.AnimState:PlayAnimation("burnt")
end

local function OnIsDay(inst, isday)
    if isday and not inst:HasTag("burnt") then
		StartSpawning(inst)
    else
        StopSpawning(inst)
    end
end


local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(3, 3, 3)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("galinheiro.png")

	anim:SetBank("galinheiro")
	anim:SetBuild("galinheiro")
	anim:PlayAnimation("idle", true)

	inst:AddTag("structure")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
        inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({})
    inst.components.lootdropper:AddRandomLoot("boards", 4)
    inst.components.lootdropper:AddRandomLoot("cutgrass", 10)
    inst.components.lootdropper.numrandomloot = 5		

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(5)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "chicken"
    inst.components.childspawner:SetSpawnedFn(OnSpawned)
    inst.components.childspawner:SetGoHomeFn(OnGoHome)
    inst.components.childspawner.emergencychildname = "chicken"
    inst.components.childspawner:SetEmergencyRadius(15)
    inst.components.childspawner:SetRegenPeriod(TUNING.TOTAL_DAY_TIME)
    inst.components.childspawner:SetSpawnPeriod(40)
    inst.components.childspawner:SetMaxChildren(3)
    inst.components.childspawner:SetMaxEmergencyChildren(1)


        inst:WatchWorldState("isday", OnIsDay)

        StartSpawning(inst)

        MakeMediumBurnable(inst, nil, nil, true)
        MakeLargePropagator(inst)
        inst:ListenForEvent("onignite", onignite)
        inst:ListenForEvent("burntup", onburntup)

        inst:AddComponent("inspectable")

        MakeSnowCovered(inst)

        inst.OnSave = onsave
        inst.OnLoad = onload

	inst:ListenForEvent("onbuilt", onbuilt)
	
	return inst
end

return Prefab("galinheiro", fn, assets, prefabs),
		MakePlacer("galinheiro_placer", "galinheiro", "galinheiro", "idle", nil, nil, nil, 3)  