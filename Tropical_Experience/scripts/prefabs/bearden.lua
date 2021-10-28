require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/polarb_den.zip"),
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

local function OnStartDay(inst)
    --print(inst, "OnStartDay")
    if inst.components.spawner:IsOccupied() then
        inst.components.spawner:ReleaseChild()
    end
end

local function spawncheckday(inst)
    inst.inittask = nil
inst:WatchWorldState("startday", OnStartDay)
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

    inst.AnimState:SetBank("critterlab")
    inst.AnimState:SetBuild("polarb_den")
    inst.AnimState:PlayAnimation("idle")
    inst.Transform:SetScale(2.3, 2.3, 2.3)	
	inst.AnimState:OverrideSymbol("eyes", "dragoon_den", "")
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 255/255)	

	inst:AddTag("structure")
	
--	inst.AnimState:SetMultColour(100/255, 100/255, 40/255, 1)	

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
    inst.components.spawner:Configure("bear", TUNING.TOTAL_DAY_TIME*1)
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
    inst.components.spawner:CancelSpawning()

	inst:AddComponent("inspectable")

    inst.inittask = inst:DoTaskInTime(0, oninit)	
	return inst
end

return Prefab("bearden", fn, assets, prefabs)