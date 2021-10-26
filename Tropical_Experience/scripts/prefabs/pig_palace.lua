require "prefabutil"
require "recipes"

local assets =
{
    Asset("ANIM", "anim/palace.zip"),
    Asset("ANIM", "anim/pig_shop_doormats.zip"),
    Asset("ANIM", "anim/palace_door.zip"),
}

local prefabs = 
{
    "trinket_giftshop_1",
    "trinket_giftshop_3",
    "trinket_giftshop_4",
    "grounded_wilba"
}

local function LightsOn(inst)
    if not inst:HasTag("burnt") then
        inst.Light:Enable(true)
        inst.AnimState:PlayAnimation("lit", true)
        inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lighton")
        inst.lightson = true
    end
end

local function LightsOff(inst)
    if not inst:HasTag("burnt") then
        inst.Light:Enable(false)
        inst.AnimState:PlayAnimation("idle", true)
        inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lightoff")
        inst.lightson = false
    end
end

local function onfar(inst) 
    if not inst:HasTag("burnt") then
        if inst.components.spawner and inst.components.spawner:IsOccupied() then
            LightsOn(inst)
        end
    end
end

local function getstatus(inst)
    if inst:HasTag("burnt") then
        return "BURNT"
    elseif inst.components.spawner and inst.components.spawner:IsOccupied() then
        if inst.lightson then
            return "FULL"
        else
            return "LIGHTSOUT"
        end
    end
end

local function onnear(inst) 
    if not inst:HasTag("burnt") then
        if inst.components.spawner and inst.components.spawner:IsOccupied() then
            LightsOff(inst)
        end
    end
end

local function onwere(child)
    if child.parent and not child.parent:HasTag("burnt") then
        child.parent.SoundEmitter:KillSound("pigsound")
        child.parent.SoundEmitter:PlaySound("dontstarve/pig/werepig_in_hut", "pigsound")
    end
end

local function onnormal(child)
    if child.parent and not child.parent:HasTag("burnt") then
        child.parent.SoundEmitter:KillSound("pigsound")
        child.parent.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/city_pig/pig_in_house_LP", "pigsound")
    end
end

local function onoccupied(inst, child)
    if not inst:HasTag("burnt") then
    	inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/city_pig/pig_in_house_LP", "pigsound")
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
    	
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end

    	-- inst.doortask = inst:DoTaskInTime(1, function() if not inst.components.playerprox:IsPlayerClose() then LightsOn(inst) end end)
        inst.doortask = inst:DoTaskInTime(1, function() LightsOn(inst) end)

    	if child then
    	    inst:ListenForEvent("transformwere", onwere, child)
    	    inst:ListenForEvent("transformnormal", onnormal, child)
    	end
    end
end

local function onvacate(inst, child)
    if not inst:HasTag("burnt") then
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end

        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
        inst.SoundEmitter:KillSound("pigsound")
    	
    	if child then
    	    inst:RemoveEventCallback("transformwere", onwere, child)
    	    inst:RemoveEventCallback("transformnormal", onnormal, child)

            if child.components.werebeast then
    		    child.components.werebeast:ResetTriggers()
    		end

    		if child.components.health then
    		    child.components.health:SetPercent(1)
    		end
    	end    
    end
end
        
        
local function onhammered(inst, worker)
    if inst:HasTag("fire") and inst.components.burnable then
        inst.components.burnable:Extinguish()
    end

    if inst.doortask then
        inst.doortask:Cancel()
        inst.doortask = nil
    end

	if inst.components.spawner then inst.components.spawner:ReleaseChild() end

	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function ongusthammerfn(inst)
    onhammered(inst, nil)
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
    	inst.AnimState:PlayAnimation("hit")
    	inst.AnimState:PushAnimation("idle")
    end
end

local function OnDay(inst)
    --print(inst, "OnDay")
    if not inst:HasTag("burnt") then
        if inst.components.spawner:IsOccupied() then
            LightsOff(inst)

            if inst.doortask then
                inst.doortask:Cancel()
                inst.doortask = nil
            end

            inst.doortask = inst:DoTaskInTime(1 + math.random()*2, function() inst.components.spawner:ReleaseChild() end)
        end
    end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end

    if inst:HasTag("spawned_shop") then
        data.spawned_shop = true
    end
end

local function onload(inst, data)
    if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end

    if data and data.spawned_shop then
        inst:AddTag("spawned_shop")
    end
end

local function usedoor(inst,data)
    if inst.usesounds then
        if data and data.doer and data.doer.SoundEmitter then
            for i,sound in ipairs(inst.usesounds)do
                data.doer.SoundEmitter:PlaySound(sound)
            end
        end
    end
end
--------------------------------------do teleporter------------------------
local function OnDoneTeleporting(inst, obj)


end
local function StartTravelSound(inst, doer)

end

local function OnActivateByOther(inst, source, doer)
--	if not inst.sg:HasStateTag("open") then
--		inst.sg:GoToState("opening")
--	end
	if doer ~= nil and doer.Physics ~= nil then
		doer.Physics:CollidesWith(COLLISION.WORLD)
	end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)
	doer.mynetvarCameraMode:set(1)
	
        local other = inst.components.teleporter.targetTeleporter
        if other ~= nil then
            DeleteCloseEntsWithTag("WORM_DANGER", other, 15)
        end		
			
        --Sounds are triggered in player's stategraph
    elseif inst.SoundEmitter ~= nil then

    end
end
-----------------------------------------------------------------------------
local function OnHaunt(inst, haunter)
inst.components.teleporter:Activate(haunter)
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local light = inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "pig_palace.png" )

    light:SetFalloff(1)
    light:SetIntensity(.5)
    light:SetRadius(1)
    light:Enable(false)
    light:SetColour(180/255, 195/255, 50/255)
    
    MakeObstaclePhysics(inst, 1.25)

    anim:SetBank("palace")

    anim:SetBuild("palace")

    anim:PlayAnimation("idle", true)


    inst:AddTag("structure")
	inst:AddTag("hamletteleport")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("lootdropper")

--    inst:AddComponent("door")
    --[[
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	]]
	inst:AddComponent("spawner")
	WorldSettings_Spawner_SpawnDelay(inst, TUNING.TOTAL_DAY_TIME*4, true)
    inst.components.spawner:Configure("pigman_royalguard_3", TUNING.TOTAL_DAY_TIME*4)
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
	
	inst:WatchWorldState("isday", OnDay)	  
   
    inst:AddComponent("inspectable")    
	
    inst.components.inspectable.getstatus = getstatus
	
	MakeSnowCovered(inst, .01)

    inst:AddComponent("fixable")
    inst.components.fixable:AddRecinstructionStageData("rubble", "pig_shop", "palace")
    inst.components.fixable:AddRecinstructionStageData("unbuilt", "pig_shop", "palace")

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
	inst.components.teleporter.hamlet = true	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)	
	
    inst:ListenForEvent("burntup", function(inst)
        inst.components.fixable:AddRecinstructionStageData("burnt", "pig_shop", "palace", 1)
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
        inst:Remove()
    end)

    inst:ListenForEvent("onignite", function(inst, data)
        if inst.components.spawner then
            inst.components.spawner:ReleaseChild()
        end
    end)

    inst.OnSave = onsave 
    inst.OnLoad = onload

	inst:ListenForEvent( "onbuilt", onbuilt)
    inst:DoTaskInTime(math.random(), function() 
        if TheWorld.state.isday then 
            OnDay(inst)
        end 
    end)
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		

    inst.usesounds = {"Hamlet/common/objects/store/door_open"}
    inst:ListenForEvent("usedoor", function(inst,data) usedoor(inst,data) end)  

    return inst
end

return Prefab("common/objects/pig_palace", fn, assets, prefabs)

