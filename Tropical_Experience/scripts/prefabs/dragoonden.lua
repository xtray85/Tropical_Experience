require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/dragoon_den.zip"),
}

local prefabs =
{
	"dragoon",
}

local function ongohome(inst, child)
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle")
end

local function onhammered(inst, worker)
	if inst.components.spawner ~= nil and inst.components.spawner:IsOccupied() then
        inst.components.spawner:ReleaseChild()
    end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle")
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/dragoon_den_place")
end

local function OnStartDay(inst)
    --print(inst, "OnStartDay")
    if inst.components.spawner:IsOccupied() then
        inst.components.spawner:ReleaseChild()
    end
end

local function spawncheckday(inst)
    inst.inittask = nil
inst:WatchWorldState("startcaveday", OnStartDay)
    if inst.components.spawner ~= nil and inst.components.spawner:IsOccupied() then
        if TheWorld.state.iscaveday or
            (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
            inst.components.spawner:ReleaseChild()

        end
    end
end

local function oninit(inst)
    inst.inittask = inst:DoTaskInTime(math.random(), spawncheckday)
    if inst.components.spawner ~= nil and
        inst.components.spawner.child == nil and
        inst.components.spawner.childname ~= nil and
        not inst.components.spawner:IsSpawnPending() then
        local child = SpawnPrefab(inst.components.spawner.childname)
        if child ~= nil then
            inst.components.spawner:TakeOwnership(child)
            inst.components.spawner:GoHome(child)
        end
    end
end

local function onoccupied(inst, child)
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/dragoon/idle")  
end

local function onvacate(inst, child)
        if child ~= nil then
            if child.components.health ~= nil then
                child.components.health:SetPercent(1)
            end
        end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	MakeObstaclePhysics(inst, 1.5)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("dragoon_den.png")

	anim:SetBank("dragoon_den")
	anim:SetBuild("dragoon_den")
	anim:PlayAnimation("idle", true)

	inst:AddTag("structure")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(nil)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)

	inst:AddComponent("spawner")
	WorldSettings_Spawner_SpawnDelay(inst, TUNING.TOTAL_DAY_TIME*1, true)	
    inst.components.spawner:Configure("dragoon", TUNING.TOTAL_DAY_TIME*1)
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
    inst.components.spawner:CancelSpawning()

	inst:AddComponent("inspectable")

	inst:ListenForEvent("onbuilt", onbuilt)

    inst.inittask = inst:DoTaskInTime(0, oninit)	
	return inst
end

return Prefab("dragoonden", fn, assets, prefabs),
		MakePlacer("dragoonden_placer", "dragoon_den", "dragoon_den", "idle")  