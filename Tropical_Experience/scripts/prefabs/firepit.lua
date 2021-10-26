require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/firepit.zip"),
}

local prefabs =
{
    "campfirefire",
    "collapse_small",
    "ash",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local x, y, z = inst.Transform:GetWorldPosition()
    SpawnPrefab("ash").Transform:SetPosition(x, y, z)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(x, y, z)
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
end

local function onextinguish(inst)
    if inst.components.fueled ~= nil then
        inst.components.fueled:InitializeFuelLevel(0)
    end
end

local function ontakefuel(inst)
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
inst.components.burnable:Extinguish()
end	
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
	if inst.components.specialstewer then 
    if inst.components.installations and inst.components.installations:IsInstalled() then
	inst.components.specialstewer:StartWorking() 
    end	 
	end
end

local function updatefuelrate(inst)
    inst.components.fueled.rate = TheWorld.state.israining and 1 + TUNING.FIREPIT_RAIN_RATE * TheWorld.state.precipitationrate or 1
end

local function onupdatefueled(inst)
    if inst.components.burnable ~= nil and inst.components.fueled ~= nil then
        updatefuelrate(inst)
        inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
    end
end

local function onfuelchange(newsection, oldsection, inst, doer)
    if newsection <= 0 then
        inst.components.burnable:Extinguish()
    else
        if not inst.components.burnable:IsBurning() then
            updatefuelrate(inst)
            inst.components.burnable:Ignite(nil, nil, doer)
        end
        inst.components.burnable:SetFXLevel(newsection, inst.components.fueled:GetSectionPercent())
    end
end

local SECTION_STATUS =
{
    [0] = "OUT",
    [1] = "EMBERS",
    [2] = "LOW",
    [3] = "NORMAL",
    [4] = "HIGH",
}
local function getstatus(inst)
    return SECTION_STATUS[inst.components.fueled:GetCurrentSection()]
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", false)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
inst.components.burnable:Extinguish()
end	
end

local function OnHaunt(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE and
        inst.components.fueled ~= nil and
        not inst.components.fueled:IsEmpty() then
        inst.components.fueled:DoDelta(TUNING.MED_FUEL)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    --#HAUNTFIX
    --elseif math.random() <= TUNING.HAUNT_CHANCE_HALF and
        --inst.components.workable ~= nil and
        --inst.components.workable:CanBeWorked() then
        --inst.components.workable:WorkedBy(haunter, 1)
        --inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        --return true
    end
    return false
end

local function OnInit(inst)
    if inst.components.burnable ~= nil then
        inst.components.burnable:FixFX()
    end
    inst:AddTag("cooker")
end

local installables =
{
    "grill",
    "grill_small",
    "pot_hanger",
    "oven",
}

local function CanInstall(prefab)
    for _,v in ipairs(installables) do
        if prefab == v then
            return true
        end
    end
    return false
end

local function OnInstall(inst, target)
    inst:OnInstall(target)
end

local function OnPreLoad(inst, data)
	if data ~= nil and data._has_debuffable then
		inst:AddComponent("debuffable")
	end
    if data and data.installed and data.specialstewer then
        local obj = inst.components.installations:Install(data.installation)
        inst.components.specialstewer:OnLoad(data.specialstewer)
        if data.dish then
            local dish = SpawnSaveRecord(data.dish)
            inst:SetDish(nil, dish)
        end
--        if data.container then
--            inst.components.container:OnLoad(data.container)
--        end
    end
end

local function OnSave(inst, data)
	data._has_debuffable = inst.components.debuffable ~= nil
    if inst.components.installations and inst.components.installations:IsInstalled() then
        data.installed = true
        data.installation = inst.components.installations.installation.prefab
        data.specialstewer = inst.components.specialstewer:OnSave()
        if inst.components.shelf then
            data.dish = inst.dish and inst.dish:GetSaveRecord() or nil
        end
--        if inst.components.container then
--            data.container = inst.components.container:OnSave()
--        end
    end
end

--------------------------------------------------------------------------
--quagmire

local function OnPrefabOverrideDirty(inst)
    if inst.prefaboverride:value() ~= nil then
        inst:SetPrefabNameOverride(inst.prefaboverride:value().prefab)
        if not TheWorld.ismastersim and inst.replica.container:CanBeOpened() then
            inst.replica.container:WidgetSetup(inst.prefaboverride:value().prefab)
        end
    end
end

local function OnRadiusDirty(inst)
    inst:SetPhysicsRadiusOverride(inst.radius:value() > 0 and inst.radius:value() / 100 or nil)
end

--------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("firepit.png")
    inst.MiniMapEntity:SetPriority(1)

    inst.AnimState:SetBank("firepit")
    inst.AnimState:SetBuild("firepit")
    inst.AnimState:PlayAnimation("idle", false)

    inst:AddTag("campfire")
    inst:AddTag("structure")
    inst:AddTag("wildfireprotected")

    --cooker (from cooker component) added to pristine state for optimization
    inst:AddTag("cooker")
	
	-- for storytellingprop component
	inst:AddTag("storytellingprop")	

    if TheNet:GetServerGameMode() == "quagmire" then
        inst:AddTag("installations")
        inst:AddTag("quagmire_stewer")
        inst:AddTag("quagmire_cookwaretrader")

        inst.takeitem = net_entity(inst.GUID, "firepit.takeitem")
        inst.prefaboverride = net_entity(inst.GUID, "firepit.prefaboverride", "prefaboverridedirty")
        inst.radius = net_byte(inst.GUID, "firepit.radius", "radiusdirty")

        if not TheWorld.ismastersim then
            inst:ListenForEvent("prefaboverridedirty", OnPrefabOverrideDirty)
            inst:ListenForEvent("radiusdirty", OnRadiusDirty)
        end

        inst.curradius = .6
        MakeObstaclePhysics(inst, inst.curradius)
    else
        MakeObstaclePhysics(inst, .6)
        inst.prefaboverride = net_entity(inst.GUID, "firepit.prefaboverride", "prefaboverridedirty")

        if not TheWorld.ismastersim then
            inst:AddTag("installations")
            inst:ListenForEvent("prefaboverridedirty", OnPrefabOverrideDirty)
        end
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -----------------------
    inst:AddComponent("burnable")
    --inst.components.burnable:SetFXLevel(2)
    inst.components.burnable:AddBurnFX("campfirefire", Vector3(0, 0, 0), "firefx", true)
    inst:ListenForEvent("onextinguish", onextinguish)

    -------------------------
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    inst:AddComponent("shelf")
    -------------------------
    inst:AddComponent("cooker")
    -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true

    inst.components.fueled:SetSections(4)
    inst.components.fueled.bonusmult = TUNING.FIREPIT_BONUS_MULT
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:SetUpdateFn(onupdatefueled)
    inst.components.fueled:SetSectionCallback(onfuelchange)
    inst.components.fueled:InitializeFuelLevel(TUNING.FIREPIT_FUEL_START)

    inst:AddComponent("storytellingprop")
	
    -----------------------------
    if TheNet:GetServerGameMode() == "quagmire" then
        event_server_data("quagmire", "prefabs/firepit").master_postinit(inst, OnPrefabOverrideDirty, OnRadiusDirty)
    end
    -----------------------------

    inst:AddComponent("hauntable")
    inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_HUGE
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    -----------------------------

    inst:AddComponent("installations")
    inst.components.installations:SetUp(CanInstall, OnInstall)

    inst:AddComponent("container")
--    inst.components.container:WidgetSetup(inst.prefab)
    inst.components.container.canbeopened = false

    inst:AddComponent("specialstewer")

    -----------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    inst:ListenForEvent("onbuilt", onbuilt)

    inst:DoTaskInTime(0, OnInit)

    inst.OnSave = OnSave
    inst.OnPreLoad = OnPreLoad
	
    inst.restart_firepit = function( inst )
        local fuel_percent = inst.components.fueled:GetPercent()
        inst.components.fueled:MakeEmpty()
        inst.components.fueled:SetPercent( fuel_percent )
    end	

    return inst
end

return Prefab("firepit", fn, assets, prefabs),
    MakePlacer("firepit_placer", "firepit", "firepit", "preview")
