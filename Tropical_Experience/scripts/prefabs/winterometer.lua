require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/winter_meter.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function DoCheckTemp(inst)
local alagado = GetClosestInstWithTag("mare", inst, 10)

if alagado then 
inst.AnimState:SetPercent("meter", math.random())
if math.random() > 0.90 then
local fx = SpawnPrefab("shock_machines_fx")
if fx then local pt = inst:GetPosition() fx.Transform:SetPosition(pt.x, pt.y, pt.z) end 
if inst.SoundEmitter then inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_water") end
end
else 
    if not inst:HasTag("burnt") then
        inst.AnimState:SetPercent("meter", 1 - math.clamp(TheWorld.state.temperature, 0, TUNING.OVERHEAT_TEMP) / TUNING.OVERHEAT_TEMP)
    end
end	
end

local function StartCheckTemp(inst)
    if inst.task == nil and not inst:HasTag("burnt") then 
        inst.task = inst:DoPeriodicTask(2, DoCheckTemp, 0)
    end
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then 
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst)
    if not inst:HasTag("burnt") then 
        if inst.task ~= nil then
            inst.task:Cancel()
            inst.task = nil
        end
        inst.AnimState:PlayAnimation("hit")
        --the global animover handler will restart the check task
    end
end

local function onbuilt(inst)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    inst.AnimState:PlayAnimation("place")
    inst.SoundEmitter:PlaySound("dontstarve/common/winter_meter_craft")
    --the global animover handler will restart the check task
end

local function makeburnt(inst)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
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

local function OnEntityWake(inst)
if inst.task then
inst.task:Cancel()
inst.task = nil
end
if inst.task == nil and not inst:HasTag("burnt") then
   inst.task = inst:DoPeriodicTask(2, DoCheckTemp, 0)
end
end

local function OnEntitySleep(inst)
if inst.task then
inst.task:Cancel()
inst.task = nil
end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .4)

    inst.MiniMapEntity:SetIcon("winterometer.png")

    inst.AnimState:SetBank("winter_meter")
    inst.AnimState:SetBuild("winter_meter")
    inst.AnimState:SetPercent("meter", 0)

    inst:AddTag("structure")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)       
    MakeSnowCovered(inst)

    inst:ListenForEvent("onbuilt", onbuilt)
--    inst:ListenForEvent("animover", StartCheckTemp)

    MakeSmallBurnable(inst, nil, nil, true)
    MakeSmallPropagator(inst)

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:ListenForEvent("burntup", makeburnt)

--    StartCheckTemp(inst)

    MakeHauntableWork(inst)
	
	inst.OnEntitySleep = OnEntitySleep
	inst.OnEntityWake = OnEntityWake		

    return inst
end

return Prefab("winterometer", fn, assets, prefabs),
    MakePlacer("winterometer_placer", "winter_meter", "winter_meter", "idle")