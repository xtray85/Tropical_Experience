local assets =
{
    Asset("ANIM", "anim/quagmire_pot.zip"),
    Asset("ANIM", "anim/quagmire_pot_small.zip"),
    Asset("ANIM", "anim/quagmire_pot_syrup.zip"),
    Asset("ANIM", "anim/quagmire_pot_hanger.zip"),
    -- Asset("ANIM", "anim/quagmire_pot_fire.zip"),
}

local prefabs =
{
    "quagmire_pot_hanger_item",
}

local prefabs_item =
{
    "quagmire_pot_hanger",
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

local function OnPotSteam(inst)
    local fx = CreateEntity()

    fx:AddTag("FX")
    fx:AddTag("NOCLICK")
    --[[Non-networked entity]]
    fx.entity:SetCanSleep(false)
    fx.persists = false

    fx.entity:AddTransform()
    fx.entity:AddAnimState()
    fx.entity:AddSoundEmitter()

    fx.AnimState:SetBank("quagmire_pot_hanger")
    fx.AnimState:SetBuild("quagmire_pot_hanger")
    fx.AnimState:PlayAnimation("steam")
    fx.AnimState:SetFinalOffset(1)

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

local function OnRemoveEntity(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil and parent.highlightchildren ~= nil then
        table.removearrayvalue(parent.highlightchildren, inst)
        if parent.prefab == "firepit" and #parent.highlightchildren <= 0 then
            parent.highlightchildren = nil
        end
    end
end

local function OnCompleted(inst)
    inst.pot._steam:push()
    OnPotSteam(inst.pot)
    inst.SoundEmitter:KillSound("snd")
    local animname = inst.pot and "idle_loop" or "idle"
    inst.pot.AnimState:PlayAnimation(animname, true)
end

local function OnCookingStep(inst, multiplier)
    local animname = inst.pot and "idle_loop" or "idle"
    inst.SoundEmitter:KillSound("snd")
    if inst.components.specialstewer:IsWorking() and multiplier > 0 then
        inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_rattle", "snd")
        if multiplier > 1.0 then
            animname = "cooking_boil_big"
        elseif multiplier >= 0.5 then
            animname = "cooking_boil_small"
        end
    end
    inst.pot.AnimState:PlayAnimation(animname, true)
end

local function GetContainer(inst)
    return inst.dish and inst.dish.components.container or nil
end

local function SetDish(inst, doer, dish)
if inst.components.specialstewer then inst.components.specialstewer:StartWorking() end
    if inst.dish ~= nil and dish == nil then
        local overridebuild = "quagmire_" .. inst.dish.prefab
        inst.dish = nil
        inst.pot.AnimState:ClearOverrideBuild(overridebuild)
        inst:RemoveTag("takeshelfitem")
        inst.pot.AnimState:PlayAnimation("take_pot")
        inst.pot.AnimState:PushAnimation("idle", true)
        inst.components.shelf.cantakeitem = false
    elseif inst.dish == nil and dish ~= nil then
        inst.dish = dish
        local overridebuild = "quagmire_" .. inst.dish.prefab
        inst.pot.AnimState:AddOverrideBuild(overridebuild)
        inst.pot.AnimState:OverrideSymbol("pot", overridebuild, "pot")
        inst.pot.AnimState:PlayAnimation("place_pot")
        inst.pot.AnimState:PushAnimation("idle_loop", true)
        if doer then
            doer.components.inventory:RemoveItem(dish)
        end
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

local function OnInstall(inst, target)
    inst.entity:SetParent(target.entity)

    target:AddTag("specialstewer_dishtaker")
    target:AddTag("pot_hanger")	
    target.dish = nil
    target.pot = inst

    target.components.specialstewer.oncompletefn = OnCompleted
    target.components.specialstewer.oncookingstepfn = OnCookingStep
    target.components.specialstewer.containerfn = GetContainer
    target.components.specialstewer.cookertype = "pot"
    target.components.specialstewer:StartWorking()

    target.components.shelf.ontakeitemfn = OnDishTaken

    target.SetDish = SetDish
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("quagmire_pot_hanger")
    inst.AnimState:SetBuild("quagmire_pot_hanger")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("mouseover")
    inst.AnimState:Hide("goop")
    inst.AnimState:Hide("goop_small")
    inst.AnimState:Hide("goop_syrup")

    inst.AnimState:SetFinalOffset(-2)

    inst:AddTag("FX")

    inst._steam = net_event(inst.GUID, "potsteam")

    inst.entity:SetPristine()

    inst.OnRemoveEntity = OnRemoveEntity

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = OnEntityReplicated
        inst:ListenForEvent("potsteam", OnPotSteam)

        return inst
    end

    inst.OnInstall = OnInstall

    -- event_server_data("quagmire", "prefabs/quagmire_pot_hanger").master_postinit(inst, AddHighlightChildren, OnPotSteam)

    return inst
end

local function itemfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)
    inst.AnimState:SetBank("quagmire_pot_hanger")
    inst.AnimState:SetBuild("quagmire_pot_hanger")
    inst.AnimState:PlayAnimation("item")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("installable")
    inst.components.installable:SetUp("pot_hanger", "specialstewer")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "quagmire_pot_hanger_item"

    -- event_server_data("quagmire", "prefabs/quagmire_pot_hanger").master_postinit_item(inst)

    return inst
end

return Prefab("pot_hanger", fn, assets, prefabs),
    Prefab("pot_hanger_item", itemfn, assets, prefabs_item)
