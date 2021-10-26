local assets =
{
    Asset("ANIM", "anim/volcano_lava.zip"),
}

local rock_assets =
{
    Asset("ANIM", "anim/scorched_rock.zip"),
}

local NUM_ROCK_TYPES = 7

local function makerock(rocktype)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("scorched_rock")
        inst.AnimState:SetBuild("scorched_rock")
        inst.AnimState:PlayAnimation("idle"..rocktype)

        if rocktype:len() > 0 then
            inst:SetPrefabNameOverride("lava_pond_rock")
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("hauntable")
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

        return inst
    end
    return Prefab("lava_pond_rock"..rocktype, fn, rock_assets)
end

local function SpawnRocks(inst)
    inst.task = nil
    if inst.rocks == nil then
        inst.rocks = {}
        for i = 1, math.random(2, 4) do
            local theta = math.random() * 2 * PI
            local rocktype = math.random(NUM_ROCK_TYPES)
            table.insert(inst.rocks,
            {
                rocktype = rocktype > 1 and tostring(rocktype) or "",
                offset =
                {
                    math.sin(theta) * 2.1 + math.random() * .3,
                    0,
                    math.cos(theta) * 2.1 + math.random() * .3,
                },
            })
        end
    end
    for i, v in ipairs(inst.rocks) do
        if type(v.rocktype) == "string" and type(v.offset) == "table" and #v.offset == 3 then
            local rock = SpawnPrefab("lava_pond_rock"..v.rocktype)
            if rock ~= nil then
                rock.entity:SetParent(inst.entity)
                rock.Transform:SetPosition(unpack(v.offset))
                rock.persists = false
            end
        end
    end
end

local function OnSave(inst, data)
    data.rocks = inst.rocks
end

local function OnLoad(inst, data)
    if data ~= nil and data.rocks ~= nil and inst.rocks == nil and inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
        inst.rocks = data.rocks
        SpawnRocks(inst)
    end
end

local function OnCollide(inst, other)
    if other ~= nil and
        other:IsValid() and
        inst:IsValid() and
        other.components.burnable ~= nil and
        other.components.fueled == nil then
        other.components.burnable:Ignite(true, inst)
    end
end

--------------------------------------------------------------------------

local function OnInit(inst)

local x, y, z = inst.Transform:GetWorldPosition()
for i, v in ipairs(TheSim:FindEntities(x, 0, z, 50, nil, nil, { "_health" })) do
if v.components.temperature ~= nil then

local newtemp = v.components.temperature.current + 10
if newtemp < v.components.temperature:GetMax() + 10 then
v.components.temperature.current = v.components.temperature.current + 10
end
end
end
inst:DoTaskInTime(5+(math.random()*2), OnInit)
end

--------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.Transform:SetScale(2.65, 2.65, 2.65)
--	inst.Transform:SetScale(4, 4, 4)

--	MakeObstaclePhysics(inst, 200, 200)
	MakeObstaclePhysics(inst, 70, 70)

inst.AnimState:SetBuild("volcano_lava")
    inst.AnimState:SetBank("volcano_lava")
	inst.Transform:SetFourFaced()
--	inst.AnimState:PlayAnimation("dump")
--    inst.AnimState:PushAnimation("idle_loop")
    inst.AnimState:PlayAnimation("idle_lava", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("lava_pond.png")

    inst:AddTag("lava")
    inst:AddTag("antlion_sinkhole_blocker")

    --cooker (from cooker component) added to pristine state for optimization
    inst:AddTag("cooker")

    inst.Light:Enable(true)
    inst.Light:SetRadius(1.5)
    inst.Light:SetFalloff(0.66)
    inst.Light:SetIntensity(0.66)
    inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)

--    inst._isengaged = net_bool(inst.GUID, "lava_pond._isengaged", "isengageddirty")
--    inst._playingmusic = false
--    inst._musictask = nil

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(8)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.Physics:SetCollisionCallback(OnCollide)

    inst:AddComponent("inspectable")
    inst:AddComponent("heater")
    inst.components.heater.heat = 500

	
    inst:AddComponent("propagator")
    inst.components.propagator.damages = true
    inst.components.propagator.propagaterange = 12
    inst.components.propagator.damagerange = 12
    inst.components.propagator:StartSpreading()

    inst:AddComponent("cooker")

    inst.rocks = nil
    inst.task = inst:DoTaskInTime(0, SpawnRocks)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    --Delay registration until after our position is set
    inst:DoTaskInTime(0, OnInit)

    return inst
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.Transform:SetScale(4, 4, 4)

	MakeObstaclePhysics(inst, 200, 200)

inst.AnimState:SetBuild("volcano_lava")
    inst.AnimState:SetBank("volcano_lava")
	inst.Transform:SetFourFaced()
--	inst.AnimState:PlayAnimation("dump")
--    inst.AnimState:PushAnimation("idle_loop")
    inst.AnimState:PlayAnimation("idle_lava", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("lava_pond.png")

    inst:AddTag("lava")
    inst:AddTag("antlion_sinkhole_blocker")

    --cooker (from cooker component) added to pristine state for optimization
    inst:AddTag("cooker")

    inst.Light:Enable(true)
    inst.Light:SetRadius(1.5)
    inst.Light:SetFalloff(0.66)
    inst.Light:SetIntensity(0.66)
    inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)

--    inst._isengaged = net_bool(inst.GUID, "lava_pond._isengaged", "isengageddirty")
--    inst._playingmusic = false
--    inst._musictask = nil

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(8)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.Physics:SetCollisionCallback(OnCollide)

    inst:AddComponent("inspectable")
    inst:AddComponent("heater")
    inst.components.heater.heat = 500

	
    inst:AddComponent("propagator")
    inst.components.propagator.damages = true
    inst.components.propagator.propagaterange = 12
    inst.components.propagator.damagerange = 12
    inst.components.propagator:StartSpreading()

    inst:AddComponent("cooker")

    inst.rocks = nil
    inst.task = inst:DoTaskInTime(0, SpawnRocks)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    --Delay registration until after our position is set
    inst:DoTaskInTime(0, OnInit)

    return inst
end

local ret = { makerock("") }
local prefabs = { "lava_pond_rock" }
for i = 2, NUM_ROCK_TYPES do
    table.insert(ret, makerock(tostring(i)))
    table.insert(prefabs, "lava_pond_rock"..tostring(i))
end
table.insert(ret, Prefab("lavapondbig", fn, assets, prefabs))
table.insert(ret, Prefab("lavapondbig1", fn1, assets, prefabs))
prefabs = nil
return unpack(ret)
