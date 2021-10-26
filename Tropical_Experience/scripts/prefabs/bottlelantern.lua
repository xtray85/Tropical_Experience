local		dusk_time = 120
local		night_time = 60
local	    BOAT_TORCH_LIGHTTIME = night_time*1.75
local	    BOAT_LANTERN_LIGHTTIME = (night_time+dusk_time)*2.6
local	    BOTTLE_LANTERN_LIGHTTIME = (night_time+dusk_time)*2.6

local assets =
{
	Asset("ANIM", "anim/lantern_bottle.zip"),
	Asset("ANIM", "anim/swap_bottlle_lantern.zip"),
    Asset("SOUND", "sound/wilson.fsb"),
}

local prefabs =
{
    "lanternlightbottle",
}

local function DoTurnOffSound(inst, owner)
    inst._soundtask = nil
    (owner ~= nil and owner:IsValid() and owner.SoundEmitter or inst.SoundEmitter):PlaySound("dontstarve_DLC002/common/bottlelantern_turnoff")
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
        inst._light.SoundEmitter:PlaySound("dontstarve_DLC002/common/bottlelantern_turnon")
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

local function stoptrackingowner(inst)
    if inst._owner ~= nil then
        inst:RemoveEventCallback("equip", inst._onownerequip, inst._owner)
        inst._owner = nil
    end
end

local function starttrackingowner(inst, owner)
    if owner ~= inst._owner then
        stoptrackingowner(inst)
        if owner ~= nil and owner.components.inventory ~= nil then
            inst._owner = owner
            inst:ListenForEvent("equip", inst._onownerequip, owner)
        end
    end
end

local function turnon(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if not inst.components.fueled:IsEmpty() then
inst.components.fueled:StartConsuming()
		
        local owner = inst.components.inventoryitem.owner

        if inst._light == nil then
            inst._light = SpawnPrefab("lanternlightbottle")
            inst._light._lantern = inst
            inst:ListenForEvent("onremove", onremovelight, inst._light)
            fuelupdate(inst)
            PlayTurnOnSound(inst)
        end
        inst._light.entity:SetParent((owner or inst).entity)

		
local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
local plataforma = false
local pos_x, pos_y, pos_z = inst.Transform:GetWorldPosition()
local entities = TheSim:FindEntities(x, 0, z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS, WALKABLE_PLATFORM_TAGS)
for i, v in ipairs(entities) do
local walkable_platform = v.components.walkableplatform 
if walkable_platform and walkable_platform.radius == nil then walkable_platform.radius = 4 end        
if walkable_platform ~= nil then  
local platform_x, platform_y, platform_z = v.Transform:GetWorldPosition()
local distance_sq = VecUtil_LengthSq(x - platform_x, z - platform_z)
if distance_sq <= walkable_platform.radius * walkable_platform.radius then plataforma = true end
end
end			
		
if not plataforma and (ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS) then
inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
inst.AnimState:PlayAnimation("idle_on_water", true)
inst.AnimState:OverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:OverrideSymbol("water_shadow", "ripple_build", "water_shadow")
else

inst.AnimState:SetLayer(LAYER_WORLD)
inst.AnimState:PlayAnimation("idle_on", true)	
inst.AnimState:ClearOverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:ClearOverrideSymbol("water_shadow", "ripple_build", "water_shadow")	
end	

        if owner ~= nil and inst.components.equippable:IsEquipped() then
            owner.AnimState:Show("LANTERN_OVERLAY")
        end

        inst.components.machine.ison = true

--        inst.components.inventoryitem:ChangeImageName("lantern_lit")
    end
end

local function turnoff(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

    stoptrackingowner(inst)

    inst.components.fueled:StopConsuming()

    if inst._light ~= nil then
        inst._light:Remove()
        PlayTurnOffSound(inst)
    end

local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
local plataforma = false
local pos_x, pos_y, pos_z = inst.Transform:GetWorldPosition()
local entities = TheSim:FindEntities(x, 0, z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS, WALKABLE_PLATFORM_TAGS)
for i, v in ipairs(entities) do
local walkable_platform = v.components.walkableplatform  
if walkable_platform and walkable_platform.radius == nil then walkable_platform.radius = 4 end     
if walkable_platform ~= nil then  
local platform_x, platform_y, platform_z = v.Transform:GetWorldPosition()
local distance_sq = VecUtil_LengthSq(x - platform_x, z - platform_z)
if distance_sq <= walkable_platform.radius * walkable_platform.radius then plataforma = true end
end
end			
		
if not plataforma and (ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS) then
inst.AnimState:PlayAnimation("idle_water", true)
else
inst.AnimState:PlayAnimation("idle_off", true)		
end	

    if inst.components.equippable:IsEquipped() then
        inst.components.inventoryitem.owner.AnimState:Hide("LANTERN_OVERLAY")
    end

    inst.components.machine.ison = false

 --   inst.components.inventoryitem:ChangeImageName("lantern")
end

local function OnRemove(inst)
    if inst._light ~= nil then
        inst._light:Remove()
    end
    if inst._soundtask ~= nil then
        inst._soundtask:Cancel()
    end
end

local function ondropped(inst)
    turnoff(inst)
    turnon(inst)
end

local function onequip(inst, owner) 
    if not owner.sg:HasStateTag("rowing") then
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal")
        owner.AnimState:OverrideSymbol("lantern_overlay", "swap_bottlle_lantern", "lantern_overlay")
    	
        if inst.components.fueled:IsEmpty() then
            owner.AnimState:OverrideSymbol("swap_object", "swap_bottlle_lantern", "swap_lantern_off")
    		owner.AnimState:Hide("LANTERN_OVERLAY") 
        else
            owner.AnimState:OverrideSymbol("swap_object", "swap_bottlle_lantern", "swap_lantern_on")
    		owner.AnimState:Show("LANTERN_OVERLAY") 
        end
        inst.components.machine:TurnOn()
    end 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:ClearOverrideSymbol("lantern_overlay")
	owner.AnimState:Hide("LANTERN_OVERLAY") 	
end

local function nofuel(inst)
    if inst.components.equippable:IsEquipped() and inst.components.inventoryitem.owner ~= nil then
        local data =
        {
            prefab = inst.prefab,
            equipslot = inst.components.equippable.equipslot,
        }
        turnoff(inst)
        inst.components.inventoryitem.owner:PushEvent("torchranout", data)
    else
        turnoff(inst)
    end
end

local function ontakefuel(inst)
    if inst.components.equippable:IsEquipped() then
        turnon(inst)
    end
end

--------------------------------------------------------------------------

local function OnLightWake(inst)
    if not inst.SoundEmitter:PlayingSound("loop") then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/bottlelantern_lp", "loop")
    end
end

local function OnLightSleep(inst)
    inst.SoundEmitter:KillSound("loop")
end

--------------------------------------------------------------------------

local function lanternlightbottlefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetColour(0/255, 180/255, 255/255)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst.OnEntityWake = OnLightWake
    inst.OnEntitySleep = OnLightSleep

    return inst
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("lantern_bottle")
    inst.AnimState:SetBuild("lantern_bottle")
    inst.AnimState:PlayAnimation("idle_off")

    inst:AddTag("light")
	inst:AddTag("aquatic")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(turnoff)

    inst:AddComponent("equippable")

    inst:AddComponent("fueled")

    inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
    inst.components.machine.cooldowntime = 0

    inst.components.fueled.fueltype = FUELTYPE.CAVE
    inst.components.fueled:InitializeFuelLevel(TUNING.LANTERN_LIGHTTIME)
    inst.components.fueled:SetDepletedFn(nofuel)
    inst.components.fueled:SetUpdateFn(fuelupdate)
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting = true

    inst._light = nil

    MakeHauntableLaunch(inst)

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst.OnRemoveEntity = OnRemove

    inst._onownerequip = function(owner, data)
        if data.item ~= inst and
            (   data.eslot == EQUIPSLOTS.HANDS or
                (data.eslot == EQUIPSLOTS.BODY and data.item:HasTag("heavy"))
            ) then
            turnoff(inst)
        end
    end

    return inst
end

return Prefab("bottlelantern", fn, assets, prefabs),
    Prefab("lanternlightbottle", lanternlightbottlefn)