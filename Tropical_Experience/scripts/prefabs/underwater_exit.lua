local assets=
{
	Asset("ANIM", "anim/cave_exit_rope.zip"),
	Asset("ANIM", "anim/underwater_exit.zip"),
}

local function OnEntityWake(inst)
	inst.components.bubbleblower:Start()	
end

local function OnEntitySleep(inst)
	inst.components.bubbleblower:Stop()
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()		
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
     
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "cave_open2.png" )
	inst.Transform:SetScale(2, 2, 2)
	MakeObstaclePhysics(inst, 1)	
    anim:SetBank("underwater_exit")
    anim:SetBuild("underwater_exit")
	
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("teleportaprafloresta")	
    inst:AddTag("vent")
	inst:AddTag("underwater")

	inst:AddComponent("bubbleblower")
	inst.components.bubbleblower:SetYOffset(40)
	inst.components.bubbleblower:SetYOffset(30)
    inst.components.bubbleblower:SetBubbleRate(5)
	
	inst:AddComponent("oxygenaura")
	inst.components.oxygenaura:SetAura(UW_TUNING.GEOTHERMAL_VENT_AIR*0.5)	
	
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
	inst.components.worldmigrator.id = 877
	inst.components.worldmigrator.receivedPortal = 878
	
	if TUNING.tropical.tropicalshards == 5 or  TUNING.tropical.tropicalshards == 10 or  TUNING.tropical.tropicalshards == 20 or TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "1"	
	end	

	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep		

    return inst
end

local function fn1(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()		
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
     
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "cave_open2.png" )    
	inst.Transform:SetScale(2, 2, 2)
	MakeObstaclePhysics(inst, 1)	
    anim:SetBank("underwater_exit")
    anim:SetBuild("underwater_exit")
	
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("teleportapranaufrago")	
    inst:AddTag("vent")
	inst:AddTag("underwater")

	inst:AddComponent("bubbleblower")
	inst.components.bubbleblower:SetYOffset(40)
	inst.components.bubbleblower:SetYOffset(30)
    inst.components.bubbleblower:SetBubbleRate(5)
	
	inst:AddComponent("oxygenaura")
	inst.components.oxygenaura:SetAura(UW_TUNING.GEOTHERMAL_VENT_AIR*0.5)	
	
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
	inst.components.worldmigrator.id = 887
	inst.components.worldmigrator.receivedPortal = 888
	
	if TUNING.tropical.tropicalshards == 5 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "1"	
	end	
	
	if TUNING.tropical.tropicalshards == 10 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "3"	
	end		
	
	if TUNING.tropical.tropicalshards == 20 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "3"	
	end		
	
	if TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "3"	
	end	
	
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep		

    return inst
end

local function fn2(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()		
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
     
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "cave_open2.png" )
	inst.Transform:SetScale(2, 2, 2)
	MakeObstaclePhysics(inst, 1)	
    anim:SetBank("underwater_exit")
    anim:SetBuild("underwater_exit")
	
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("teleportaprahamlet")		
    inst:AddTag("vent")
	inst:AddTag("underwater")

	inst:AddComponent("bubbleblower")
	inst.components.bubbleblower:SetYOffset(40)
	inst.components.bubbleblower:SetYOffset(30)
    inst.components.bubbleblower:SetBubbleRate(5)
	
	inst:AddComponent("oxygenaura")
	inst.components.oxygenaura:SetAura(UW_TUNING.GEOTHERMAL_VENT_AIR*0.5)	
	
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
	inst.components.worldmigrator.id = 897
	inst.components.worldmigrator.receivedPortal = 898
	
	if TUNING.tropical.tropicalshards == 5 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "3"	
	end	
	
	if TUNING.tropical.tropicalshards == 10 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "3"	
	end		
	
	if TUNING.tropical.tropicalshards == 20 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "4"	
	end	
	
	if TUNING.tropical.tropicalshards == 30 then
	inst.components.worldmigrator.auto = false
	inst.components.worldmigrator.linkedWorld = "4"	
	end		
	
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep		

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
	minimap:SetIcon( "cave_open2.png" )

    inst.AnimState:SetBuild("underwater_exit")
    inst.AnimState:SetBank("underwater_exit")
    inst.AnimState:PlayAnimation("idle")
	inst.Transform:SetScale(2, 2, 2)	

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
	if v ~= inst and v.prefab == "underwater_entrance3" then
	inst.components.teleporter.targetTeleporter = v
	v.components.teleporter.targetTeleporter = inst
	end
	end

end)
	
	
    return inst
end

return 	Prefab( "common/underwater_exit", fn, assets),
		Prefab( "common/underwater_exit1", fn1, assets),
		Prefab( "common/underwater_exit2", fn2, assets),
		Prefab( "common/underwater_exit3", fn3, assets)		
