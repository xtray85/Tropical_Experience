local assets=
{
	Asset("ANIM", "anim/underwater_entrance.zip"),
}

local prefabs = 
{
	"exitcavelight"
}  

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(0.3, 0.3, 0.3)
    inst.MiniMapEntity:SetIcon("entrance_open.tex")
	
    anim:SetBank("entrance_reef")
    anim:SetBuild("underwater_entrance")
	
	inst.AnimState:PlayAnimation("idle_open")

    inst:AddTag("antlion_sinkhole_blocker")
	inst:AddTag("entrada_submersa")
	inst:AddTag("teleportapracaverna")	

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
	inst.components.worldmigrator.id = 878
	inst.components.worldmigrator.receivedPortal = 877
	
	if TUNING.tropical.tropicalshards == 5 or  TUNING.tropical.tropicalshards == 10 or  TUNING.tropical.tropicalshards == 20 or TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "2"	
	end
	
    return inst
end

local function fn1(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(0.3, 0.3, 0.3)
    inst.MiniMapEntity:SetIcon("entrance_open.tex")
	
    anim:SetBank("entrance_reef")
    anim:SetBuild("underwater_entrance")
	
	inst.AnimState:PlayAnimation("idle_open")

    inst:AddTag("antlion_sinkhole_blocker")
	inst:AddTag("entrada_submersa")
	inst:AddTag("teleportapracaverna")	

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
	inst.components.worldmigrator.id = 888
	inst.components.worldmigrator.receivedPortal = 887	
	
	if TUNING.tropical.tropicalshards == 5 or  TUNING.tropical.tropicalshards == 10 or  TUNING.tropical.tropicalshards == 20 or TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "2"	
	end	
	
    return inst
end

local function fn2(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)
	inst.Transform:SetScale(0.3, 0.3, 0.3)
    inst.MiniMapEntity:SetIcon("entrance_open.tex")
	
    anim:SetBank("entrance_reef")
    anim:SetBuild("underwater_entrance")
	
	inst.AnimState:PlayAnimation("idle_open")

    inst:AddTag("antlion_sinkhole_blocker")
	inst:AddTag("entrada_submersa")
	inst:AddTag("teleportapracaverna")	

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
	inst.components.worldmigrator.id = 898
	inst.components.worldmigrator.receivedPortal = 897	

	if TUNING.tropical.tropicalshards == 5 or  TUNING.tropical.tropicalshards == 10 or  TUNING.tropical.tropicalshards == 20 or TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "2"	
	end
	
    return inst
end

-----------------------------------cave teleport-------------------------
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
	minimap:SetIcon( "entrance_open.tex" )

    inst.AnimState:SetBuild("underwater_entrance")
    inst.AnimState:SetBank("entrance_reef")
    inst.AnimState:PlayAnimation("idle_open")

    inst:AddTag("trader")
    inst:AddTag("alltrader")

    inst:AddTag("antlion_sinkhole_blocker")
	inst.Transform:SetScale(0.3, 0.3, 0.3)	
	

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
	if v ~= inst and v.prefab == "underwater_exit3" then
	inst.components.teleporter.targetTeleporter = v
	v.components.teleporter.targetTeleporter = inst
	end
	end

end)
	
	
    return inst
end

return 	Prefab( "common/underwater_entrance", fn, assets, prefabs),
		Prefab( "common/underwater_entrance1", fn1, assets, prefabs), 
		Prefab( "common/underwater_entrance2", fn2, assets, prefabs),
		Prefab( "common/underwater_entrance3", fn3, assets, prefabs)		