local assets =
{
	Asset("ANIM", "anim/tarlamp.zip"),
	Asset("ANIM", "anim/swap_tarlamp.zip"),
    Asset("ANIM", "anim/swap_tarlamp_boat.zip"),
}
 
 
local prefabs =
{
"tarlampfire",
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
        inst._light.SoundEmitter:PlaySound("dontstarve/wilson/lantern_on")
    end
end

local function fuelupdate(inst)
    if inst._light ~= nil then
        local fuelpercent = inst.components.fueled:GetPercent()
        inst._light.Light:SetIntensity(.75)
        inst._light.Light:SetRadius(2)
        inst._light.Light:SetFalloff(0.5)
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
    if not inst.components.fueled:IsEmpty() then
        inst.components.fueled:StartConsuming()

        local owner = inst.components.inventoryitem.owner

        if inst._light == nil then
            inst._light = SpawnPrefab("tarlampfire")
            inst._light._lantern = inst
            inst:ListenForEvent("onremove", onremovelight, inst._light)
            fuelupdate(inst)
            PlayTurnOnSound(inst)
        end
        inst._light.entity:SetParent((owner or inst).entity)

local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

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
inst.AnimState:OverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:OverrideSymbol("water_shadow", "ripple_build", "water_shadow")
if not inst.replica.inventoryitem:IsHeld() then	inst.components.inventoryitem:AddMoisture(80) end
			inst.AnimState:PlayAnimation("idle_on_water", true)
        else
inst.AnimState:SetLayer(LAYER_WORLD)
inst.AnimState:ClearOverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:ClearOverrideSymbol("water_shadow", "ripple_build", "water_shadow")
            inst.AnimState:PlayAnimation("idle_on")
        end

        if owner ~= nil and inst.components.equippable:IsEquipped() then
            owner.AnimState:Show("LANTERN_OVERLAY")
        end

        inst.components.machine.ison = true

--        inst.components.inventoryitem:ChangeImageName("lantern_lit")
    end
end

local function turnoff(inst)
    stoptrackingowner(inst)

    inst.components.fueled:StopConsuming()

    if inst._light ~= nil then
        inst._light:Remove()
        PlayTurnOffSound(inst)
    end

local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

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
inst.AnimState:OverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:OverrideSymbol("water_shadow", "ripple_build", "water_shadow")
if not inst.replica.inventoryitem:IsHeld() then	inst.components.inventoryitem:AddMoisture(80) end
inst.AnimState:PlayAnimation("idle_off_water", true)
    else
inst.AnimState:SetLayer(LAYER_WORLD)
inst.AnimState:ClearOverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:ClearOverrideSymbol("water_shadow", "ripple_build", "water_shadow")
            inst.AnimState:PlayAnimation("idle_off")
    end	

    if inst.components.equippable:IsEquipped() then
        inst.components.inventoryitem.owner.AnimState:Hide("LANTERN_OVERLAY")
    end

    inst.components.machine.ison = false

--    inst.components.inventoryitem:ChangeImageName("lantern")
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
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
local ground1 = map:GetTile(map:GetTileCoordsAtPoint(x+5, y, z))
local ground2 = map:GetTile(map:GetTileCoordsAtPoint(x-5, y, z))
local ground3 = map:GetTile(map:GetTileCoordsAtPoint(x, y, z+5))
local ground4 = map:GetTile(map:GetTileCoordsAtPoint(x, y, z-5))
local naagua = false
if ground == GROUND.UNDERWATER_SANDY or ground == GROUND.UNDERWATER_ROCKY or (ground == GROUND.BEACH and TheWorld:HasTag("cave"))   or (ground == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground1 == GROUND.UNDERWATER_SANDY or ground1 == GROUND.UNDERWATER_ROCKY or (ground1 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground1 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground1 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground1 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground1 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground2 == GROUND.UNDERWATER_SANDY or ground2 == GROUND.UNDERWATER_ROCKY or (ground2 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground2 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground2 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground2 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground2 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground3 == GROUND.UNDERWATER_SANDY or ground3 == GROUND.UNDERWATER_ROCKY or (ground3 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground3 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground3 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground3 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground3 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground4 == GROUND.UNDERWATER_SANDY or ground4 == GROUND.UNDERWATER_ROCKY or (ground4 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground4 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground4 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground4 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground4 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
	
	owner.AnimState:OverrideSymbol("swap_object", "swap_tarlamp", "swap_lantern")
if naagua == false then

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    owner.AnimState:OverrideSymbol("swap_object", "swap_tarlamp", "swap_lantern")
    owner.AnimState:OverrideSymbol("lantern_overlay", "swap_tarlamp", "lantern_overlay")

    if inst.components.fueled:IsEmpty() then
        owner.AnimState:Hide("LANTERN_OVERLAY")
    else
        owner.AnimState:Show("LANTERN_OVERLAY")
        turnon(inst)
    end
end	
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:ClearOverrideSymbol("lantern_overlay")
    owner.AnimState:Hide("LANTERN_OVERLAY")

    if inst.components.machine.ison then
        starttrackingowner(inst, owner)
    end
end

local function depleted(inst)
local barco = GetClosestInstWithTag("boat", inst, 0.5)
if barco and inst.components.inventoryitem:IsHeldBy(barco) then
if barco then barco.AnimState:ClearOverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
inst:Remove()
return end

    if not inst.equippedby then
        local ash = SpawnPrefab( "ash" )
        ash.Transform:SetPosition(inst:GetPosition():Get())        
    end
end

local function nofuel(inst)
depleted(inst)
turnoff(inst) 
local owner = inst.components.inventoryitem.owner                                
if owner then
owner:PushEvent("torchranout", {torch = inst})
end
inst:Remove() 
end

local function ontakefuel(inst)
    if inst.components.equippable:IsEquipped() then
        turnon(inst)
    end
end

--------------------------------------------------------------------------

local function OnLightWake(inst)
    if not inst.SoundEmitter:PlayingSound("loop") then
        inst.SoundEmitter:PlaySound("dontstarve/wilson/lantern_LP", "loop")
    end
end

local function OnLightSleep(inst)
    inst.SoundEmitter:KillSound("loop")
end

--------------------------------------------------------------------------

local function tarlampfirefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetColour(197/255,197/255,50/255)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst.OnEntityWake = OnLightWake
    inst.OnEntitySleep = OnLightSleep

    return inst
end

local function liga(inst)
if not inst.components.fueled:IsEmpty() then
inst.components.fueled:StartConsuming()

local owner = inst.components.inventoryitem.owner

 if inst._light == nil then
    inst._light = SpawnPrefab("tarlampfire")
     inst._light._lantern = inst
     inst:ListenForEvent("onremove", onremovelight, inst._light)
     fuelupdate(inst)
     PlayTurnOnSound(inst)
end
     inst._light.entity:SetParent((owner or inst).entity)
	inst.AnimState:OverrideSymbol("swap_lantern", "swap_tarlamp_boat","swap_lantern")
--	inst.components.inventoryitem:ChangeImageName("boat_torch")
	if inst.navio then inst.navio.AnimState:OverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
    end
end

local function desliga(inst)
    inst.components.fueled:StopConsuming()

    if inst._light ~= nil then
        inst._light:Remove()
        PlayTurnOffSound(inst)
    end
--inst.components.inventoryitem:ChangeImageName("boat_torch_off")
inst.AnimState:OverrideSymbol("swap_lantern", "swap_tarlamp_boat","swap_lantern_off")
if inst.navio then inst.navio.AnimState:OverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
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
	inst.build = "swap_tarlamp_boat"
    inst.symbol = "swap_lantern"
    inst.symboltooverride = "swap_lantern"
    inst.navio = nil

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("tarlamp")
    inst.AnimState:SetBuild("tarlamp")
    inst.AnimState:PlayAnimation("idle_off")
   
    inst:AddTag("boatlight")
	inst:AddTag("aquatic")	
    inst:AddTag("light")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	inst:AddComponent("interactions")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
	-----------------------------------
    inst:AddComponent("lighter")
    -----------------------------------
	
	inst:AddComponent("burnable")
    inst.components.burnable.canlight = false
    inst.components.burnable.fxprefab = nil	

    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(turnoff)
	
	inst:AddComponent("heater")
    inst.components.heater.equippedheat = 5

    inst:AddComponent("equippable")
	
	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.LIGHTER_DAMAGE)
    inst.components.weapon:SetAttackCallback(
        function(attacker, target)
            if target.components.burnable then
                if math.random() < TUNING.LIGHTER_ATTACK_IGNITE_PERCENT*target.components.burnable.flammability then
                    target.components.burnable:Ignite()
                end
            end
        end
    )	
	
    inst:AddComponent("fueled")

    inst:AddComponent("machine")
    inst.components.machine.turnonfn = turnon
    inst.components.machine.turnofffn = turnoff
    inst.components.machine.cooldowntime = 0

    inst.components.fueled.fueltype = FUELTYPE.CAVE
    inst.components.fueled:InitializeFuelLevel(TUNING.TORCH_FUEL)
    inst.components.fueled:SetDepletedFn(nofuel)
    inst.components.fueled:SetUpdateFn(fuelupdate)
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
--    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
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
	inst:DoPeriodicTask(0.5, mudasimbolo)
    return inst
end

return Prefab("tarlamp", fn, assets, prefabs),
    Prefab("tarlampfire", tarlampfirefn)
