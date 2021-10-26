local assets=
{
	Asset("ANIM", "anim/swap_lantern_boat.zip"),
    Asset("INV_IMAGE", "boat_lantern_off"),
}

local BOAT_LANTERN_LIGHTTIME = (60+120)*2.6

local prefabs =
{
    "lanternlight",
}

local function DoTurnOffSound(inst, owner)
    inst._soundtask = nil
    (owner ~= nil and owner:IsValid() and owner.SoundEmitter or inst.SoundEmitter):PlaySound("dontstarve/wilson/lantern_off")
end

local function PlayTurnOffSound(inst)
    if inst._soundtask == nil and inst:GetTimeAlive() > 0 then
        inst._soundtask = inst:DoTaskInTime(0, DoTurnOffSound, inst.components.inventoryitem.owner)
    end
end

local function PlayTurnOnSound(inst)
    if inst._soundtask ~= nil then
        inst._soundtask:Cancel()
        inst._soundtask = nil
    elseif not POPULATING then
        inst._light.SoundEmitter:PlaySound("dontstarve_DLC002/common/boatlantern_turnon")
    end
end

local function fuelupdate(inst)
    if inst._light ~= nil then
        local fuelpercent = inst.components.fueled:GetPercent()
        inst._light.Light:SetIntensity(Lerp(.4, .6, fuelpercent))
        inst._light.Light:SetRadius(Lerp(3, 5, fuelpercent))
        inst._light.Light:SetFalloff(.9)
    end
end

local function onremovelight(light)
    light._lantern._light = nil
end

local function liga(inst)
if not inst.components.fueled:IsEmpty() then
inst.components.fueled:StartConsuming()

local owner = inst.components.inventoryitem.owner

 if inst._light == nil then
    inst._light = SpawnPrefab("lanternlight")
     inst._light._lantern = inst
     inst:ListenForEvent("onremove", onremovelight, inst._light)
     fuelupdate(inst)
     PlayTurnOnSound(inst)
end
    inst._light.entity:SetParent((owner or inst).entity)
	inst.AnimState:OverrideSymbol("swap_lantern", "swap_lantern_boat","swap_lantern")
	inst.components.inventoryitem:ChangeImageName("boat_lantern")
	if inst.navio then inst.navio.AnimState:OverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
    end
end

local function desliga(inst)
    inst.components.fueled:StopConsuming()

    if inst._light ~= nil then
        inst._light:Remove()
        PlayTurnOffSound(inst)
    end
inst.components.inventoryitem:ChangeImageName("boat_lantern_off")
inst.AnimState:OverrideSymbol("swap_lantern", "swap_lantern_boat","swap_lantern_off")
if inst.navio then inst.navio.AnimState:OverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
end


local function OnRemove(inst)
    if inst._light ~= nil then
        inst._light:Remove()
    end
    if inst._soundtask ~= nil then
        inst._soundtask:Cancel()
    end
end

local function nofuel(inst)
if inst.navio then inst.navio.AnimState:ClearOverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
inst.navio = nil
inst:RemoveTag("ligado")
desliga(inst)
end
--------------------------------------------------------------------------

local function OnLightWake(inst)
    if not inst.SoundEmitter:PlayingSound("loop") then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/boatlantern_lp", "loop")
    end
end

local function OnLightSleep(inst)
    inst.SoundEmitter:KillSound("loop")
end

--------------------------------------------------------------------------

local function OnSave(inst, data)
if inst:HasTag("ligado") then data.luz = 1 end
end

local function OnLoad(inst, data)
if data and data.luz ~= nil then inst:AddTag("ligado") liga(inst) end
end

local function mudasimbolo(inst)
---------verifica se ta dentro do navio--------------
local barco = GetClosestInstWithTag("boat", inst, 0.5)
local player = GetClosestInstWithTag("player", inst, 0.5)
if not barco then 
if inst:HasTag("nonavio") then inst:RemoveTag("nonavio") end
return end
if barco and player and inst.components.inventoryitem:IsHeldBy(player) then
if inst:HasTag("nonavio") then inst:RemoveTag("nonavio") end
return end
if barco then
if not inst:HasTag("nonavio") then inst:AddTag("nonavio") end
end


if inst:HasTag("ligado") then
inst.symbol = "swap_lantern"
liga(inst)
else
inst.symbol = "swap_lantern_off"
desliga(inst)
end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
--  MakeInventoryFloatable(inst, "idle_water", "idle")
    inst.build = "swap_lantern_boat"
    inst.symbol = "swap_lantern_off"
    inst.symboltooverride = "swap_lantern"
	inst.navio = nil
	
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("lantern_boat")
    inst.AnimState:SetBuild("swap_lantern_boat")
    inst.AnimState:PlayAnimation("idle_water")

    inst:AddTag("light")
    inst:AddTag("boatlight")
	MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("interactions")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("fueled")

    inst.components.fueled.fueltype = FUELTYPE.CAVE
    inst.components.fueled:InitializeFuelLevel(BOAT_LANTERN_LIGHTTIME)
    inst.components.fueled:SetDepletedFn(nofuel)
    inst.components.fueled:SetUpdateFn(fuelupdate)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting = true
	
    inst._light = nil

    MakeHauntableLaunch(inst)

    inst.OnRemoveEntity = OnRemove
	inst:ListenForEvent("onpickup", nofuel)
	inst:DoPeriodicTask(0.5, mudasimbolo)
	
	inst.OnLoad = OnLoad
	inst.OnSave = OnSave

    return inst
end

return Prefab( "common/inventory/boat_lantern", fn, assets)