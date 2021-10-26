local function AddHighlightChildren(inst, target)
    if target.prefab == "firepit" then
        if target.highlightchildren == nil then
            target.highlightchildren = { inst }
        else
            table.insert(target.highlightchildren, inst)
        end
    end
end

local function KillFX(fx)
    if not fx.killed then
        fx.killed = true

        local len = fx.AnimState:GetCurrentAnimationLength()
        local remaining = len - (fx.AnimState:GetCurrentAnimationTime() % len)
        if remaining > 0 then
            local parent = fx.entity:GetParent()
            if parent ~= nil then
                fx.entity:SetParent(nil)
                fx.Transform:SetPosition(parent.Transform:GetWorldPosition())
            end
            fx:DoTaskInTime(remaining, fx.Remove)
        else
            fx:Remove()
        end
    end
end

local function CreateBurntSmoke(build, sound)
    local fx = CreateEntity()

    fx:AddTag("FX")
    fx:AddTag("NOCLICK")
    --[[Non-networked entity]]
    fx.entity:SetCanSleep(false)
    fx.persists = false

    fx.entity:AddTransform()
    fx.entity:AddAnimState()
    if sound then
        fx.entity:AddSoundEmitter()
    end

    fx.AnimState:SetBank(build)
    fx.AnimState:SetBuild(build)
    fx.AnimState:PlayAnimation("cooking_burnt_loop", true)
    fx.AnimState:Hide("grill")

    fx.KillFX = KillFX

    return fx
end

local function OnBurntDirty(inst)
    if inst._burnt:value() > 0 then
        if inst._smokefrontfx == nil then
            inst._smokefrontfx = CreateBurntSmoke(inst.prefab, true)
            inst._smokefrontfx.AnimState:Hide("smoke_back")
            inst._smokefrontfx.AnimState:SetFinalOffset(3)
            inst._smokefrontfx.entity:SetParent(inst.entity)
        end
        if inst._smokebackfx == nil then
            inst._smokebackfx = CreateBurntSmoke(inst.prefab, false)
            inst._smokebackfx.AnimState:Hide("smoke_front")
            inst._smokebackfx.AnimState:SetFinalOffset(1)
            inst._smokebackfx.entity:SetParent(inst.entity)
        end
        if inst._burnt:value() == 1 then
            inst._smokefrontfx.AnimState:SetAddColour(.15, .15, 0, 0)
            inst._smokebackfx.AnimState:SetAddColour(.15, .15, 0, 0)
            inst._smokefrontfx.SoundEmitter:KillSound("smoke")
        else
            inst._smokefrontfx.AnimState:SetAddColour(0, 0, 0, 0)
            inst._smokebackfx.AnimState:SetAddColour(0, 0, 0, 0)
            if not inst._smokefrontfx.SoundEmitter:PlayingSound("smoke") then
                inst._smokefrontfx.SoundEmitter:PlaySound("dontstarve/quagmire/common/cooking/burnt_LP", "smoke", .25)
            end
        end
    else
        if inst._smokefrontfx ~= nil then
            inst._smokefrontfx:KillFX()
            inst._smokefrontfx = nil
        end
        if inst._smokebackfx ~= nil then
            inst._smokebackfx:KillFX()
            inst._smokebackfx = nil
        end
    end
end

local function OnGrillSmoke(inst)
    local fx = CreateEntity()
    local animname = inst.prefab == "grill_small" and "quagmire_grill_small" or "quagmire_grill"

    fx:AddTag("FX")
    fx:AddTag("NOCLICK")
    --[[Non-networked entity]]
    fx.entity:SetCanSleep(false)
    fx.persists = false

    fx.entity:AddTransform()
    fx.entity:AddAnimState()
    fx.entity:AddSoundEmitter()

    fx.AnimState:SetBank(animname)
    fx.AnimState:SetBuild(animname)
    fx.AnimState:PlayAnimation("smoke")
    fx.AnimState:SetFinalOffset(3)

    fx:ListenForEvent("animover", fx.Remove)

    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx.SoundEmitter:PlaySound("dontstarve/common/cookingpot_open", nil, .6)
    fx.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")

    return fx
end

local function OnEntityReplicated(inst)
    local parent = inst.entity:GetParent()
    print(parent)
    -- local parent = inst
    if parent ~= nil then
        print("yes")
        AddHighlightChildren(inst, parent)
        if parent.replica.container ~= nil then
            print("Replica detected")
            parent.replica.container:WidgetSetup(inst.prefab)
        end
    end
end

local function OnRemoveEntity(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil and parent.highlightchildren ~= nil then
        table.removearrayvalue(parent.highlightchildren, inst)
        if parent.prefab == "firepit" and #parent.highlightchildren <= 0 then
            parent.highlightchildren = nil
        end
    end
end

-- TODO
local function OnEmbersDirty(inst)
    if inst._embers:value() <= 0 then
        inst.embersfx:Hide()
    else
        inst.embersfx:Show()
        if inst._embers:value() <= 1 then
            inst.embersfx.AnimState:Show("ember1")
            inst.embersfx.AnimState:Hide("ember2")
            inst.embersfx.AnimState:Hide("ember3")
        elseif inst._embers:value() <= 2 then
            inst.embersfx.AnimState:Hide("ember1")
            inst.embersfx.AnimState:Show("ember2")
            inst.embersfx.AnimState:Hide("ember3")
        else
            inst.embersfx.AnimState:Hide("ember1")
            inst.embersfx.AnimState:Show("ember2")
            inst.embersfx.AnimState:Show("ember3")
        end
    end
end

local function CreateEmbers(build)
    local fx = CreateEntity()

    fx:AddTag("FX")
    fx:AddTag("NOCLICK")
    --[[Non-networked entity]]
    fx.entity:SetCanSleep(false)
    fx.persists = false

    fx.entity:AddTransform()
    fx.entity:AddAnimState()

    fx.AnimState:SetBank(build)
    fx.AnimState:SetBuild(build)
    fx.AnimState:PlayAnimation("embers", true)
    fx.AnimState:SetFinalOffset(3)

    fx:Hide()

    return fx
end

local ret = {}

local function onopen(inst)
    if not inst:HasTag("burnt") then
        inst.grill.AnimState:PlayAnimation("open", true)
        inst.grill.SoundEmitter:KillSound("snd")
        inst.grill.SoundEmitter:PlaySound("dontstarve/common/cookingpot_open")
        inst.grill.SoundEmitter:PlaySound("dontstarve/common/cookingpot", "snd")
    end
end

local function onclose(inst)
    if inst.grill == nil then
        return
    end
    if not inst.grill:HasTag("burnt") then
        if not inst.components.specialstewer:IsCooking() then
            inst.grill.AnimState:PlayAnimation("idle")
            inst.grill.SoundEmitter:KillSound("snd")
        end
        inst.grill.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
    end
end

local function CanInstall(target)
    return target == "firepit"
end

local function OnCookingStep(inst, multiplier)
    if inst.grill == nil then
        return
    end
    local anim = "idle"
    inst.SoundEmitter:KillSound("snd")
    if inst.components.specialstewer:IsWorking() and multiplier > 0 then
        inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_rattle", "snd")
        if multiplier > 1.0 then
            anim = "cooking_grill_big"
        elseif multiplier >= 0.5 then
            anim = "cooking_grill_small"
        end
    end
    local embervalue = math.max(math.floor(multiplier * 2), 3)
    inst.grill._embers:set(embervalue)
    inst.grill.AnimState:PlayAnimation(anim, true)
end

local function OnCompleted(inst)
    if inst.grill == nil then
        return
    end
    inst.grill._smoke:push()
    local fx = OnGrillSmoke(inst.grill)
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:KillSound("snd")
    inst.grill.AnimState:PlayAnimation("idle", true)
end

local function OnInstall(inst, target)
    target.grill = inst
    inst.firepit = target

    inst.entity:SetParent(target.entity)
    -- target:AddComponent("inspectable")
    target:SetPrefabNameOverride(inst.prefab)

    target.components.specialstewer:StartWorking()
    target.components.specialstewer.oncompletefn = OnCompleted
    target.components.specialstewer.oncookingstepfn = OnCookingStep
    target.components.specialstewer.cookertype = "grill"
    -- inst.components.specialstewer.cookertype = "grill"inst:AddComponent("container")

    -- Hack needed to set the correct widget for clients (container_replica sucks)
    target.prefaboverride:set(inst)
    target.components.container:WidgetSetup(inst.prefab)
    target.components.container.canbeopened = true
    target.components.container.onopenfn = onopen
    target.components.container.onclosefn = onclose
    -- inst.components.container.numslots = size
end

local function MakeGrill(name, size)
    local animname = "quagmire_" .. name

    local assets =
    {
        Asset("ANIM", "anim/"..animname..".zip"),
        Asset("ANIM", "anim/quagmire_pot_fire.zip"),
        Asset("ANIM", "anim/quagmire_ui_pot_1x"..tostring(size)..".zip"),
    }

    local prefabs =
    {
        name.."_item",
        "quagmire_food_plate_burnt",
    }

    local prefabs_item =
    {
        name,
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        -- inst:AddTag("structure")
        -- inst:AddTag("readytocook")

        inst.AnimState:SetBank(animname)
        inst.AnimState:SetBuild(animname)
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:SetFinalOffset(-2)

        -- MakeObstaclePhysics(inst, .6, 10)

        inst.AnimState:SetFinalOffset(-2)

        inst:AddTag("FX")

        -- inst.smoke = CreateSmoke()


        inst._smoke = net_event(inst.GUID, name.."._smoke")
        -- inst._burnt = net_tinybyte(inst.GUID, name.."._burnt", "burntdirty")
        inst._embers = net_tinybyte(inst.GUID, name.."._embers", "embersdirty")

        inst.entity:SetPristine()

        inst.embersfx = CreateEmbers(animname)
        inst.embersfx.entity:SetParent(inst.entity)

        -- inst.embersfx = CreateEmbers(name)
        -- inst.embersfx.entity:SetParent(inst.entity)

        inst.OnRemoveEntity = OnRemoveEntity

        if not TheWorld.ismastersim then
            inst.OnEntityReplicated = OnEntityReplicated
            inst:ListenForEvent(name.."._smoke", OnGrillSmoke)
            -- inst:ListenForEvent("burntdirty", OnBurntDirty)
            inst:ListenForEvent("embersdirty", OnEmbersDirty)

            return inst
        end

        inst.OnInstall = OnInstall

        inst.onopen = onopen
        inst.onclose = onclose

        -- event_server_data("quagmire", "prefabs/quagmire_grill").master_postinit(inst, name, AddHighlightChildren, OnBurntDirty, OnGrillSmoke, OnEmbersDirty)

        return inst
    end

    local function itemfn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)
        inst.AnimState:SetBank(animname)
        inst.AnimState:SetBuild(animname)
        inst.AnimState:PlayAnimation("item")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("installable")
        inst.components.installable:SetUp(name, "specialstewer")

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = animname .. "_item"

        -- event_server_data("quagmire", "prefabs/quagmire_grill").master_postinit_item(inst, name)

        return inst
    end

    table.insert(ret, Prefab(name, fn, assets, prefabs))
    table.insert(ret, Prefab(name.."_item", itemfn, assets, prefabs_item))
end

MakeGrill("grill", 4)
MakeGrill("grill_small", 3)
return unpack(ret)
