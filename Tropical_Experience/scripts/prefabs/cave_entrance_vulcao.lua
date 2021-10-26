local assets =
{
	Asset("ANIM", "anim/volcano.zip"),
    Asset("ANIM", "anim/vamp_bat_entrance.zip"),	
}

local prefabs =
{

}

local function SpawnFireRain(inst)

local invader = GetClosestInstWithTag("player", inst, 100)
if invader and math.random() > 0.75 then
inst.sg:GoToState("erupt")

end
end


local function OnSeasonChange(inst)
    if not (TheWorld.state.iswinter) and not inst:HasTag("ativo") then
        inst.sg:GoToState("active")
		inst:AddTag("ativo")
	end
		
    if  (TheWorld.state.iswinter) and inst:HasTag("ativo")then
        inst.sg:GoToState("dormant") 
		inst:RemoveTag("ativo")
    end	
if inst:HasTag("ativo") and not inst.sg:HasStateTag("atacando") then
SpawnFireRain(inst)
end
end 

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("volcano.png")

	inst.AnimState:SetBank("volcano")
	inst.AnimState:SetBuild("volcano")
	inst.AnimState:PlayAnimation("dormant_idle", true)
	inst:AddTag("vulcaomigrador")	
    inst:AddTag("antlion_sinkhole_blocker")
	inst.Transform:SetScale(0.5, 0.5, 0.5)	
    inst.entity:AddLight()
    inst.Light:SetFalloff(0.4)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(10)
    inst.Light:SetColour(249/255, 130/255, 117/255)
    inst.Light:Enable(true)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
--[[
    if TheNet:GetServerIsClientHosted() and not (TheShard:IsMaster() or TheShard:IsSecondary()) then
        --On non-sharded servers we'll make these vanish for now, but still generate them
        --into the world so that they can magically appear in existing saves when sharded
        RemovePhysicsColliders(inst)
        inst.AnimState:SetScale(0,0)
        inst.MiniMapEntity:SetEnabled(false)
        inst:AddTag("NOCLICK")
        inst:AddTag("CLASSIFIED")
    end
]]
    inst:AddComponent("inspectable")
    inst:AddComponent("worldmigrator")
	inst.components.worldmigrator.id = 778
	inst.components.worldmigrator.receivedPortal = 777
	
	if TUNING.tropical.tropicalshards == 5 or  TUNING.tropical.tropicalshards == 10 or  TUNING.tropical.tropicalshards == 20 or  TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "2"	
	end	
	
	
		
--	if not inst:HasTag("NOCLICK") then
--	inst:DoPeriodicTask(15, OnSeasonChange)
--	end
	
	inst:SetStateGraph("SGvolcano")

    return inst
end

local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("vamp_bat_cave.png")

    inst.AnimState:SetBuild("vamp_bat_entrance")
    inst.AnimState:SetBank("vampbat_den")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    if TheNet:GetServerIsClientHosted() and not (TheShard:IsMaster() or TheShard:IsSecondary()) then
        --On non-sharded servers we'll make these vanish for now, but still generate them
        --into the world so that they can magically appear in existing saves when sharded
        RemovePhysicsColliders(inst)
        inst.AnimState:SetScale(0,0)
        inst.MiniMapEntity:SetEnabled(false)
        inst:AddTag("NOCLICK")
        inst:AddTag("CLASSIFIED")
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("worldmigrator")
	inst.components.worldmigrator.id = 558
	inst.components.worldmigrator.receivedPortal = 557
	
	if TUNING.tropical.tropicalshards == 5 or  TUNING.tropical.tropicalshards == 10 or  TUNING.tropical.tropicalshards == 20 or  TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "2"	
	end	

    return inst
end

-------------------------frost to cave-------------------------------------------
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

local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "vamp_bat_cave.png" )

    inst.AnimState:SetBuild("vamp_bat_entrance")
    inst.AnimState:SetBank("vampbat_den")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("trader")
    inst:AddTag("alltrader")

    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
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
	if v ~= inst and v.prefab == "frosttocave" then
	inst.components.teleporter.targetTeleporter = v
	v.components.teleporter.targetTeleporter = inst
	end
	end

end)
	
	
    return inst
end

return Prefab("cave_entrance_vulcao", fn, assets, prefabs),
	   Prefab("cave_entrance_frost", fn2, assets, prefabs),
	   Prefab("frosttocave", fn3, assets, prefabs)
