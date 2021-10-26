local assets =
{
    Asset("ANIM", "anim/gold_puddle.zip"),
	Asset("MINIMAP_IMAGE", "penguin"),
}

local SNOW_THRESH = 0.10
local FADE_FRAMES = math.floor(5 / FRAMES + .5)

local function UpdateFade(inst, dframes)
--print(inst.fadeval:value() - (dframes or 0))
    if inst.isfaded:value() then
        if inst.fadeval:value() < FADE_FRAMES then
            inst.fadeval:set_local(2)
        elseif inst.fadetask ~= nil then
            inst.fadetask:Cancel()
            inst.fadetask = nil
            if inst.queueremove then
			
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 15, nil,{"flying","INLIMBO"}, {"plant", "monster","animal","character","isinventoryitem","tree","structure"})
for k,item in pairs(ents) do
if item.rippletask then
item.rippletask:Cancel()
item.rippletask = nil
end
end			
	
				inst:Remove()
            end
        end
    elseif inst.fadeval:value() > 0 then
        inst.fadeval:set_local(2)
    elseif inst.fadetask ~= nil then
        inst.fadetask:Cancel()
        inst.fadetask = nil
    end

    if inst._ice ~= nil and inst._ice:IsValid() then
        inst._ice.AnimState:SetErosionParams(math.min(1, inst.fadeval:value() / FADE_FRAMES), .1, 1)
    end
if inst.fadeval:value() < 10 then
inst:AddTag("alagamento")	
else
inst:RemoveTag("alagamento")	
end
end

local function OnIsFadedDirty(inst)
    if inst.fadetask == nil then
        inst.fadetask = inst:DoPeriodicTask(FRAMES, UpdateFade, nil, 1)
    end
    UpdateFade(inst)
end

local function OnSnowLevel(inst, snowlevel)
    if snowlevel > SNOW_THRESH then
        if inst.isfaded:value() then
            inst.isfaded:set(false)
            OnIsFadedDirty(inst)
        end
    elseif not inst.isfaded:value() then
        inst.isfaded:set(true)
        OnIsFadedDirty(inst)
    end
end

local function OnEntityWake(inst)
inst.components.ripplespawner:Start()
    inst:WatchWorldState("wetness", OnSnowLevel)
--    if TheWorld.state.snowlevel > SNOW_THRESH then
        inst.isfaded:set(false)
        inst.fadeval:set(0)
--    else
--        inst.isfaded:set(true)
--        inst.fadeval:set(FADE_FRAMES)
--    end
    UpdateFade(inst)
end

local function OnEntitySleep(inst)
inst.components.ripplespawner:Stop()
    if inst.fadetask ~= nil then
        inst.fadetask:Cancel()
        inst.fadetask = nil
    end
    inst:StopWatchingWorldState("wetness", OnSnowLevel)
end

local function OnInit(inst)
    if not inst:IsAsleep() then
        OnEntityWake(inst)
    end
    inst.OnEntityWake = OnEntityWake
    inst.OnEntitySleep = OnEntitySleep
end

local function CreateIceFX()
    local inst = CreateEntity()

    inst:AddTag("NOCLICK")
    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.Transform:SetScale(1.5, 1.5, 1.5)
    inst.AnimState:SetBank("gold_puddle")
    inst.AnimState:SetBuild("gold_puddle")
    inst.AnimState:PlayAnimation("big_idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetErosionParams(1, .1, 1)

    return inst
end

local function QueueRemove(inst)
if inst:IsAsleep() or (inst.fadetask == nil and inst.isfaded:value()) or TheWorld.state.wetness < 1 then
	inst:Remove()
	else
	inst.queueremove = true
	end
end

local function OnIsDay(inst)
if inst:HasTag("alagamento") then
local invader = GetClosestInstWithTag("player", inst, 25)
if invader then
local x, y, z = inst.Transform:GetWorldPosition()
local bicho = SpawnPrefab("snake_amphibious")
bicho.Transform:SetPosition(x, y, z)
end
end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("gold_puddle.png")

    inst:AddTag("NOCLICK")
    inst:AddTag("alagamentopraremovergrande")	
    inst._ice = CreateIceFX()
    inst._ice.entity:SetParent(inst.entity)

    inst.fadeval = net_byte(inst.GUID, "penguin_ice.fadeval", "fadevaldirty")
    inst.isfaded = net_bool(inst.GUID, "penguin_ice.isfaded", "isfadeddirty")
    inst.fadeval:set(FADE_FRAMES)
    inst.isfaded:set(true)

    inst.fadetask = nil

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("fadevaldirty", UpdateFade)
        inst:ListenForEvent("isfadeddirty", OnIsFadedDirty)

        return inst
    end
	
	inst:AddComponent("ripplespawner")
	inst.components.ripplespawner.range = 8	
	
	inst:WatchWorldState("isday", OnIsDay)	
    inst:DoTaskInTime(0, OnInit)

	inst.QueueRemove = QueueRemove

    -- penguin spawner administers the ice fields
    inst.persists = false
	
	inst:WatchWorldState("startday", QueueRemove)		

    return inst
end

return Prefab("flood_ice", fn, assets)
