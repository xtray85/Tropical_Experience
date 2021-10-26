local assets =
{
Asset("ANIM", "anim/lavaarena_portal.zip"),
}

local fx_assets =
{
    Asset("ANIM", "anim/lavaarena_portal_fx.zip"),
}

local function OnDoneTeleporting(inst, obj)
    if inst.closetask ~= nil then
        inst.closetask:Cancel()
    end

    if obj ~= nil and obj:HasTag("player") then
        obj:DoTaskInTime(1, obj.PushEvent, "wormholespit") -- for wisecracker
    end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)

        local other = inst.components.teleporter.targetTeleporter
        if other ~= nil then
            DeleteCloseEntsWithTag("WORM_DANGER", other, 15)
        end

        if doer.components.talker ~= nil then
            doer.components.talker:ShutUp()
        end
        if doer.components.sanity ~= nil then
            doer.components.sanity:DoDelta(-TUNING.SANITY_MED)
        end

        --Sounds are triggered in player's stategraph
    elseif inst.SoundEmitter ~= nil then
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportworm/swallow")
    end
end

local function OnActivateByOther(inst, source, doer)
--    if not inst.sg:HasStateTag("open") then
--        inst.sg:GoToState("opening")
--    end
end

local function onaccept(inst, giver, item)
    inst.components.inventory:DropItem(item)
    inst.components.teleporter:Activate(item)
end

local function StartTravelSound(inst, doer)
    inst.SoundEmitter:PlaySound("dontstarve/common/teleportworm/swallow")
    doer:PushEvent("wormholetravel", WORMHOLETYPE.WORM) --Event for playing local travel sound
end

local function onclose(inst)
local invader = GetClosestInstWithTag("lavaarena_portal_activeanim", inst, 3)
if invader then
invader:Remove()
end
end

local function onopen(inst)
local invader = GetClosestInstWithTag("lavaarena_portal_activeanim", inst, 3)
if not invader then
local portaentrada = SpawnPrefab("lavaarena_portal_activeanim")
local a, b, c = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(a, b, c)
end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("lavaarena_portal")
    inst.AnimState:SetBank("lavaarena_portal")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(6)
    inst.AnimState:SetFinalOffset(2)

    inst.Transform:SetEightFaced()
    --trader, alltrader (from trader component) added to pristine state for optimization
    inst:AddTag("trader")
    inst:AddTag("alltrader")

    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(10, 13)
    inst.components.playerprox:SetOnPlayerNear(onopen)
    inst.components.playerprox:SetOnPlayerFar(onclose)	
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

    inst:AddComponent("inventory")

    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false
	
inst:DoTaskInTime(1, function(inst)		
for k,v in pairs(Ents) do
if v ~= inst and v.prefab == "lavarenaescada" then
inst.components.teleporter.targetTeleporter = v
v.components.teleporter.targetTeleporter = inst
end
end

end)
	
	
    return inst
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("lavaarena_portal")
    inst.AnimState:SetBank("lavaarena_portal")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
    inst.AnimState:SetSortOrder(6)
    inst.AnimState:SetFinalOffset(2)

    inst.Transform:SetEightFaced()
    --trader, alltrader (from trader component) added to pristine state for optimization
    inst:AddTag("trader")
    inst:AddTag("alltrader")

    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(10, 13)
    inst.components.playerprox:SetOnPlayerNear(onopen)
    inst.components.playerprox:SetOnPlayerFar(onclose)	
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

    inst:AddComponent("inventory")

    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false
	
	
    return inst
end

local function activefx_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("lavaarena_portal_fx")
    inst.AnimState:SetBank("lavaportal_fx")
    inst.AnimState:PlayAnimation("portal_pre")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:OverrideMultColour(1, 1, 1, .6)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
    inst.AnimState:SetSortOrder(6)
    inst.AnimState:SetFinalOffset(1)

	inst:AddTag("lavaarena_portal_activeanim")
	
    inst.entity:AddLight()
    inst.Light:SetFalloff(0.4)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(3)
    inst.Light:SetColour(249/255, 130/255, 117/255)
    inst.Light:Enable(true)		
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:PushAnimation("portal_loop")

    inst.persists = false

    return inst
end

return Prefab("lavaarena_portal_activeanim", activefx_fn, fx_assets), 
Prefab("lavarenaescada", fn, assets),
Prefab("lavarenaescada2", fn1, assets)
