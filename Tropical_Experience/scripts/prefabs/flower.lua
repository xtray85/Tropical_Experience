local assets = {Asset("ANIM", "anim/flowers.zip")}
local prefabs = {"petals", "flower_evil", "flower_withered", "planted_flower"}
local DAYLIGHT_SEARCH_RANGE = 30
local names = {"f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10"}
local ROSE_NAME = "rose"
local ROSE_CHANCE = 0.01

local function setflowertype(inst, name)
    if inst.animname == nil or (name ~= nil and inst.animname ~= name) then
        if inst.animname == ROSE_NAME then
            inst:RemoveTag("thorny")
        end
        inst.animname = name or (math.random() < ROSE_CHANCE and ROSE_NAME or names[math.random(#names)])
        inst.AnimState:PlayAnimation(inst.animname)
        if inst.animname == ROSE_NAME then
            inst:AddTag("thorny")
        end
    end
end

local function onsave(inst, data)
    data.anim = inst.animname
    data.planted = inst.planted
end

local function onload(inst, data)
    setflowertype(inst, data ~= nil and data.anim or nil)
    inst.planted = data ~= nil and data.planted or nil
end

local function onpickedfn(inst, picker)
    local pt = inst:GetPosition()
    local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
    if tiletype == GROUND.SUBURB or tiletype == GROUND.FOUNDATION or tiletype == GROUND.COBBLEROAD or tiletype ==
        GROUND.LAWN or tiletype == GROUND.FIELDS then
        if picker and picker:HasTag("player") and not picker:HasTag("sneaky") then
            local x, y, z = inst.Transform:GetWorldPosition()
            local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
            local eles = TheSim:FindEntities(x, y, z, 40, {"guard"})
            for k, guardas in pairs(eles) do
                if guardas.components.combat and guardas.components.combat.target == nil then
                    guardas.components.combat:SetTarget(picker)
                end
            end
        end
    end

    local pos = inst:GetPosition()

    if picker ~= nil then
        if picker.components.sanity ~= nil and not picker:HasTag("plantkin") then
            picker.components.sanity:DoDelta(TUNING.SANITY_TINY)
        end

        if inst.animname == ROSE_NAME and picker.components.combat ~= nil and
            not (picker.components.inventory ~= nil and picker.components.inventory:EquipHasTag("bramble_resistant")) then
            picker.components.combat:GetAttacked(inst, TUNING.ROSE_DAMAGE)
            picker:PushEvent("thorns")
        end
    end

    if not inst.planted then
        TheWorld:PushEvent("beginregrowth", inst)
    end

    inst:Remove()

    TheWorld:PushEvent("plantkilled", {
        doer = picker,
        pos = pos
    }) -- this event is pushed in other places too
end

local function GetStatus(inst)
    return inst.animname == ROSE_NAME and "ROSE" or nil
end

local function testfortransformonload(inst)
    return TheWorld.state.isfullmoon
end

local function DieInDarkness(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, 0, z, DAYLIGHT_SEARCH_RANGE, {"daylight", "lightsource"})
    for i, v in ipairs(ents) do
        local lightrad = v.Light:GetCalculatedRadius() * .7
        if v:GetDistanceSqToPoint(x, y, z) < lightrad * lightrad then
            -- found light
            return
        end
    end
    -- in darkness
    inst:Remove()
    SpawnPrefab("flower_withered").Transform:SetPosition(x, y, z)
end

local function OnIsCaveDay(inst, isday)
    if isday then
        inst:DoTaskInTime(5.0 + math.random() * 5.0, DieInDarkness)
    end
end

local function OnBurnt(inst)
    if not inst.planted then
        TheWorld:PushEvent("beginregrowth", inst)
    end
    DefaultBurntFn(inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("flowers")
    inst.AnimState:SetBuild("flowers")
    inst.AnimState:SetRayTestOnBB(true)

    inst:AddTag("flower")
    inst:AddTag("cattoy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("petals", 10)
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.quickpick = true
    inst.components.pickable.wildfirestarter = true

    -- inst:AddComponent("transformer")
    -- inst.components.transformer:SetTransformWorldEvent("isfullmoon", true)
    -- inst.components.transformer:SetRevertWorldEvent("isfullmoon", false)
    -- inst.components.transformer:SetOnLoadCheck(testfortransformonload)
    -- inst.components.transformer.transformPrefab = "flower_evil"

    MakeSmallBurnable(inst)
    inst.components.burnable:SetOnBurntFn(OnBurnt)

    MakeSmallPropagator(inst)

    inst:AddComponent("halloweenmoonmutable")
    inst.components.halloweenmoonmutable:SetPrefabMutated("moonbutterfly_sapling")

    if TheWorld:HasTag("cave") then
        inst:WatchWorldState("iscaveday", OnIsCaveDay)
    end

    MakeHauntableChangePrefab(inst, "flower_evil")

    if not POPULATING then
        setflowertype(inst)
    end
    --------SaveLoad
    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:ListenForEvent("beginaporkalypse", function()
        local flor = SpawnPrefab("flower_evil")
        if flor then
            flor.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst:Remove()
        end
    end, TheWorld)

    inst:DoTaskInTime(0.2, function(inst)
        local map = TheWorld.Map
        local x, y, z = inst.Transform:GetWorldPosition()
        local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
        if ground == GROUND.RAINFOREST or ground == GROUND.DEEPRAINFOREST or ground == GROUND.GASJUNGLE then
            local flor = SpawnPrefab("flower_rainforest")
            if flor then
                flor.Transform:SetPosition(inst.Transform:GetWorldPosition())
                inst:Remove()
            end
        end
    end)

    inst:DoTaskInTime(0.4, function(inst)
        local map = TheWorld.Map
        local x, y, z = inst.Transform:GetWorldPosition()
        local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
        if ground ~= GROUND.RAINFOREST and ground ~= GROUND.DEEPRAINFOREST and ground ~= GROUND.GASJUNGLE then
            if TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.aporkalypse_active == true then
                local flor = SpawnPrefab("flower_evil")
                if flor then
                    flor.Transform:SetPosition(inst.Transform:GetWorldPosition())
                    inst:Remove()
                end
            end
        end
    end)

    return inst
end

function rosefn()
    local inst = fn()

    inst:SetPrefabName("flower")

    if not TheWorld.ismastersim then
        return inst
    end

    setflowertype(inst, ROSE_NAME)

    return inst
end

function plantedflowerfn()
    local inst = fn()

    inst:SetPrefabName("flower")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.planted = true

    return inst
end

return Prefab("flower", fn, assets, prefabs), Prefab("flower_rose", rosefn, assets, prefabs),
    Prefab("planted_flower", plantedflowerfn, assets, prefabs)
