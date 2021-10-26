local assets =
{
    Asset("ANIM", "anim/quagmire_casseroledish.zip"),
    Asset("ANIM", "anim/quagmire_casseroledish_small.zip"),
    Asset("ANIM", "anim/quagmire_oven.zip"),
    Asset("ANIM", "anim/quagmire_oven_fire.zip"),
}

local assets_parts =
{
    Asset("ANIM", "anim/quagmire_oven.zip"),
}

local prefabs =
{
    "quagmire_oven_item",
    "quagmire_oven_back",
}

local prefabs_item =
{
    "quagmire_oven",
}

local function AddHighlightChildren(inst, target)
    if target.prefab == "firepit" then
        if target.highlightchildren == nil then
            target.highlightchildren = { inst }
        else
            table.insert(target.highlightchildren, inst)
        end
    end
end

local function OnBakeSteam(inst)
    local fx = CreateEntity()

    fx:AddTag("FX")
    fx:AddTag("NOCLICK")
    --[[Non-networked entity]]
    fx.entity:SetCanSleep(false)
    fx.persists = false

    fx.entity:AddTransform()
    fx.entity:AddAnimState()
    fx.entity:AddSoundEmitter()

    fx.AnimState:SetBank("quagmire_oven")
    fx.AnimState:SetBuild("quagmire_oven")
    fx.AnimState:PlayAnimation("steam")
    fx.AnimState:SetFinalOffset(3)

    fx:ListenForEvent("animover", fx.Remove)

    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx.SoundEmitter:PlaySound("dontstarve/common/cookingpot_open", nil, .6)
    fx.SoundEmitter:PlaySound("dontstarve/common/cookingpot_close")
end

local function OnEntityReplicated(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        AddHighlightChildren(inst, parent)
    end
end

local function OnEntityReplicated_Back(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        local parent2 = parent.entity:GetParent()
        if parent2 ~= nil then
            parent.ovenback = inst
            AddHighlightChildren(inst, parent2)
        end
    end
end

local function OnRemoveEntity(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil and parent.highlightchildren ~= nil then
        table.removearrayvalue(parent.highlightchildren, inst)
        if inst.ovenback ~= nil then
            table.removearrayvalue(parent.highlightchildren, inst.ovenback)
        end
        if parent.prefab == "firepit" and #parent.highlightchildren <= 0 then
            parent.highlightchildren = nil
        end
    end
end

local function OnChimneyFireDirty(inst)
    if inst._chimneyfire:value() then
        inst.chimneyfirefx:Show()
    else
        inst.chimneyfirefx:Hide()
    end
end

local function CreateChimneyFire()
    local fx = CreateEntity()

    fx:AddTag("FX")
    fx:AddTag("NOCLICK")
    --[[Non-networked entity]]
    fx.entity:SetCanSleep(false)
    fx.persists = false

    fx.entity:AddTransform()
    fx.entity:AddAnimState()

    fx.AnimState:SetBank("quagmire_oven")
    fx.AnimState:SetBuild("quagmire_oven")
    fx.AnimState:PlayAnimation("chimney_fire", true)
    fx.AnimState:SetFinalOffset(1)

    fx:Hide()

    return fx
end

local function OnCompleted(inst)
    if inst.oven then
        inst.oven._steam:push()
        OnBakeSteam(inst.oven)
        inst.SoundEmitter:KillSound("snd")
        inst.oven.AnimState:PlayAnimation("idle", true)
    end
end

local function OnCookingStep(inst, multiplier)
    if inst.oven == nil then
        return
    end
    inst.SoundEmitter:KillSound("snd")
    if inst.components.specialstewer:IsWorking() and multiplier > 0 then
        inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_rattle", "snd")
        local chimneyfirevalue = multiplier >= 1 and true or false
        inst.oven._chimneyfire:set(chimneyfirevalue)
        if multiplier > 0 then
        	inst.oven.AnimState:PlayAnimation("cooking_bake_small", true) -- TODO
        else
            inst.oven.AnimState:PlayAnimation("idle")
        end
    else
        inst.oven.AnimState:PlayAnimation("idle")
        inst.oven._chimneyfire:set(false)
    end
    OnChimneyFireDirty(inst.oven)
end

local function GetContainer(inst)
    return inst.dish and inst.dish.components.container or nil
end

local function SetDish(inst, doer, dish)
if inst.components.specialstewer and dish then inst.components.specialstewer:StartWorking() end
    if inst.dish ~= nil and dish == nil then
        local overridebuild = "quagmire_" .. inst.dish.prefab
        inst.dish = nil
        inst.oven.AnimState:ClearOverrideBuild(overridebuild)
        inst:RemoveTag("takeshelfitem")
        inst.components.shelf.cantakeitem = false
    elseif inst.dish == nil and dish ~= nil then
        if doer then
            doer.components.inventory:RemoveItem(dish)
        end
        inst.dish = dish
        local overridebuild = "quagmire_" .. inst.dish.prefab
        inst.oven.AnimState:AddOverrideBuild(overridebuild)
        inst.components.shelf:PutItemOnShelf(dish)
        inst:AddTag("takeshelfitem")
        inst.components.shelf.cantakeitem = true
    end
end

local function OnDishTaken(inst)
    inst:SetDish(nil, nil)
    inst.components.specialstewer:ResetWork()
	inst.SoundEmitter:KillSound("snd")
end

local function backfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("quagmire_oven")
    inst.AnimState:SetBuild("quagmire_oven")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("steam")
    inst.AnimState:Hide("smoke")
    inst.AnimState:Hide("oven")
    --inst.AnimState:Hide("goop")
    inst.AnimState:Hide("goop_small")
    inst.AnimState:Hide("casserole")

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = OnEntityReplicated_Back

        return inst
    end

    inst.persists = false

    return inst
end

local function OnInstall(inst, target)
    local back = SpawnPrefab("oven_back")
    back.entity:SetParent(inst.entity)
	back.Transform:SetPosition(0, -0.1, 0)
    inst.entity:SetParent(target.entity)

    target:AddTag("specialstewer_dishtaker")
    target:AddTag("oven")	
    target.dish = nil
    inst.firepit = target
    target.oven = inst

    target.components.specialstewer.oncompletefn = OnCompleted
    target.components.specialstewer.oncookingstepfn = OnCookingStep
    target.components.specialstewer.containerfn = GetContainer
    target.components.specialstewer.cookertype = "oven"
    target.components.specialstewer:StartWorking()

    -- target:AddComponent("shelf")
    target.components.shelf.ontakeitemfn = OnDishTaken

    target.SetDish = SetDish
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("quagmire_oven")
    inst.AnimState:SetBuild("quagmire_oven")
    inst.AnimState:PlayAnimation("idle")
    --inst.AnimState:Hide("goop")
    inst.AnimState:Hide("goop_small")
    inst.AnimState:Hide("oven_back")
    inst.AnimState:SetFinalOffset(2)

    inst:AddTag("FX")

    inst._steam = net_event(inst.GUID, "ovensteam")
    inst._chimneyfire = net_bool(inst.GUID, "oven._chimneyfire", "chimneyfiredirty")

    inst.entity:SetPristine()

    inst.chimneyfirefx = CreateChimneyFire()
    inst.chimneyfirefx.entity:SetParent(inst.entity)

    inst.OnRemoveEntity = OnRemoveEntity

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = OnEntityReplicated
        inst:ListenForEvent("ovensteam", OnBakeSteam)
        inst:ListenForEvent("chimneyfiredirty", OnChimneyFireDirty)

        return inst
    end

    inst.OnInstall = OnInstall

    -- event_server_data("quagmire", "prefabs/quagmire_oven").master_postinit(inst, AddHighlightChildren, OnBakeSteam, OnChimneyFireDirty)

    return inst
end

local function itemfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)
    inst.AnimState:SetBank("quagmire_oven")
    inst.AnimState:SetBuild("quagmire_oven")
    inst.AnimState:PlayAnimation("item")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("installable")
    inst.components.installable:SetUp("oven", "specialstewer")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "quagmire_oven_item"

    -- event_server_data("quagmire", "prefabs/quagmire_oven").master_postinit_item(inst)

    return inst
end

return Prefab("oven", fn, assets, prefabs),
    Prefab("oven_back", backfn, assets_parts),
    Prefab("oven_item", itemfn, assets_parts, prefabs_item)
