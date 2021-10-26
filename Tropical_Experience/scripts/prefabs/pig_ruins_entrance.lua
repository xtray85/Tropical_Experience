require "prefabutil"
require "recipes"

local assets =
{
    Asset("ANIM", "anim/pig_ruins_entrance.zip"),
    Asset("ANIM", "anim/pig_ruins_entrance_build.zip"),
    Asset("ANIM", "anim/pig_ruins_entrance_top_build.zip"),
}

local prefabs = 
{

}

local RUINS_ENTRANCE_VINES_HACKS = 4
local RUINS_DOOR_VINES_HACKS = 2

local function refreshImage(inst)
    if inst:HasTag("top_ornament") then
        inst.AnimState:AddOverrideBuild("pig_ruins_entrance_top_build")
        inst.AnimState:Hide("swap_ornament2")
        inst.AnimState:Hide("swap_ornament3")
        inst.AnimState:Hide("swap_ornament4")        
    elseif inst:HasTag("top_ornament2") then
        inst.AnimState:AddOverrideBuild("pig_ruins_entrance_top_build")
        inst.AnimState:Hide("swap_ornament3")
        inst.AnimState:Hide("swap_ornament4")
        inst.AnimState:Hide("swap_ornament")
    elseif inst:HasTag("top_ornament3") then
        inst.AnimState:AddOverrideBuild("pig_ruins_entrance_top_build")
        inst.AnimState:Hide("swap_ornament2")
        inst.AnimState:Hide("swap_ornament4")
        inst.AnimState:Hide("swap_ornament")
    elseif inst:HasTag("top_ornament4") then
        inst.AnimState:AddOverrideBuild("pig_ruins_entrance_top_build")
        inst.AnimState:Hide("swap_ornament2")
        inst.AnimState:Hide("swap_ornament3")
        inst.AnimState:Hide("swap_ornament")        
    else
        inst.AnimState:Hide("swap_ornament4")
        inst.AnimState:Hide("swap_ornament3")
        inst.AnimState:Hide("swap_ornament2")
        inst.AnimState:Hide("swap_ornament")
        inst.AnimState:OverrideSymbol("statue_01", "pig_ruins_entrance", "")                
        inst.AnimState:OverrideSymbol("swap_ornament", "pig_ruins_entrance", "")                
   --     inst.AnimState:OverrideSymbol("swap_ornament", "pig_ruins_entrance", "vines")                
    --    inst.AnimState:OverrideSymbol("swap_ornament2", "pig_ruins_entrance", "vines")                
     --   inst.AnimState:OverrideSymbol("swap_ornament3", "pig_ruins_entrance", "vines")                
    end
end

local function onhit(inst, worker)
if inst.components.workable and inst.components.workable.workleft == 3 then inst.stage = 3 end
if inst.components.workable and inst.components.workable.workleft == 2 then inst.stage = 2 end
if inst.components.workable and inst.components.workable.workleft == 1 then inst.stage = 1 end
if inst.components.workable and inst.components.workable.workleft < 1 then inst.stage = 0 end

    if inst.stage >= 3 then
        inst.AnimState:PlayAnimation("hit_closed")
    elseif inst.stage == 2 then 
        inst.AnimState:PlayAnimation("hit_med")
    elseif inst.stage == 1 then 
        inst.AnimState:PlayAnimation("hit_low")
	else	
    inst.AnimState:PlayAnimation("idle_open")	
	inst.components.teleporter.enabled = true
	inst:RemoveComponent("workable")
    end
--	print(inst.stage)
	
    refreshImage(inst)
end

local function onsave(inst, data)
    data.stage = inst.stage
    if inst:HasTag("maze_generated") then
        data.maze_generated = true
    end
    
    if inst:HasTag("top_ornament") then
        data.top_ornament = true
    end
    if inst:HasTag("top_ornament2") then
        data.top_ornament2 = true
    end
    if inst:HasTag("top_ornament3") then
        data.top_ornament3 = true
    end        
end

local function onload(inst, data)
    if data then
        if data.stage then
            inst.stage = data.stage
			if inst.components.workable then inst.components.workable:SetWorkLeft(data.stage) end
			onhit(inst)
        end
		
        if data.maze_generated then
            inst:AddTag("maze_generated")
        end
        if data.top_ornament then
            inst:AddTag("top_ornament")
        end
        if data.top_ornament2 then
            inst:AddTag("top_ornament2")
        end
        if data.top_ornament3 then
            inst:AddTag("top_ornament3")
        end
    end
    
    refreshImage(inst)
end

local function onhackedfn(inst, hacker, hacksleft) 
    local fx = SpawnPrefab("hacking_fx")
    local x, y, z= inst.Transform:GetWorldPosition()
    fx.Transform:SetPosition(x,y + math.random()*2,z)
	inst.stage = inst.stage - 1
--    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/vine_hack")
    onhit(inst, hacker)
end

----------------------------------------------------------entrada-----------------------------------------------------------------------------
local function OnDoneTeleporting(inst, obj)
    if obj and obj:HasTag("player") then
	obj.mynetvarCameraMode:set(3)
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

        if doer.components.talker ~= nil then
            doer.components.talker:ShutUp()
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


local function makefn(name,build_interiors, dungeonname)

    local function fn(Sim)
        local inst = CreateEntity()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
        inst.entity:AddSoundEmitter()
	    inst.entity:AddNetwork()
        --trans:SetEightFaced()

        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon( "pig_ruins_entrance.png" )

        MakeObstaclePhysics(inst, 1.20)

        anim:SetBank("pig_ruins_entrance")

        anim:SetBuild("pig_ruins_entrance_build")

        anim:PlayAnimation("idle_closed", true)

        --inst:AddTag("structure")
        inst:AddTag("ruins_exit")
		inst:AddTag("hamletteleport")

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end	
		
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HACK)
--		inst.components.workable:SetOnFinishCallback(dig_up)
		inst.components.workable:SetWorkLeft(RUINS_ENTRANCE_VINES_HACKS)
		inst.components.workable.onwork = onhackedfn

        inst:AddComponent("shearable")

        inst:AddComponent("inspectable")  


		inst:AddComponent("teleporter")
		inst.components.teleporter.onActivate = OnActivate
		inst.components.teleporter.onActivateByOther = OnActivateByOther
		inst.components.teleporter.offset = 0
		inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
		inst:ListenForEvent("doneteleporting", OnDoneTeleporting)


        if dungeonname == "RUINS_1" then
            inst:AddTag("top_ornament") 
        elseif dungeonname == "RUINS_2" then
            inst:AddTag("top_ornament2") 
        elseif dungeonname == "RUINS_3" then
            inst:AddTag("top_ornament3") 
        elseif dungeonname == "RUINS_4" or dungeonname == "RUINS_5" then
            inst:AddTag("top_ornament4")             
        end

       inst.stage = 4
       refreshImage(inst)


        if dungeonname == "RUINS_SMALL" then
            inst.stage = 0 
			inst.AnimState:PlayAnimation("idle_open")	
			inst.components.teleporter.enabled = true
			inst:RemoveComponent("workable")
            refreshImage(inst)
        end	
		
		if inst.stage <= 0 then inst.components.teleporter.enabled = true else
		inst.components.teleporter.enabled = false end	
        
        MakeSnowCovered(inst, .01)

--[[
        inst:ListenForEvent("burntup", function(inst)
            inst.components.fixable:AddRecinstructionStageData("burnt","pig_shop",build,1)
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
]]
        inst.OnSave = onsave
        inst.OnLoad = onload			

        return inst
    end
    return fn
end
 
 local function makefn2(name,build_interiors, dungeonname)

    local function fn(Sim)
        local inst = CreateEntity()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
        inst.entity:AddSoundEmitter()
	    inst.entity:AddNetwork()
        --trans:SetEightFaced()

        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon( "pig_ruins_entrance.png" )

        MakeObstaclePhysics(inst, 1.20)

        anim:SetBank("pig_ruins_entrance")

        anim:SetBuild("pig_ruins_entrance_build")

        anim:PlayAnimation("idle_closed", true)

        --inst:AddTag("structure")
        inst:AddTag("ruins_exit")
		inst:AddTag("hamletteleport")

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end		
		
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HACK)
--		inst.components.workable:SetOnFinishCallback(dig_up)
		inst.components.workable:SetWorkLeft(RUINS_ENTRANCE_VINES_HACKS)
		inst.components.workable.onwork = onhackedfn

        inst:AddComponent("shearable")

        inst:AddComponent("inspectable")  


		inst:AddComponent("teleporter")
		inst.components.teleporter.onActivate = OnActivate
		inst.components.teleporter.onActivateByOther = OnActivateByOther
		inst.components.teleporter.offset = 0
		inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
		inst:ListenForEvent("doneteleporting", OnDoneTeleporting)


        if dungeonname == "RUINS_1" then
            inst:AddTag("top_ornament") 
        elseif dungeonname == "RUINS_2" then
            inst:AddTag("top_ornament2") 
        elseif dungeonname == "RUINS_3" then
            inst:AddTag("top_ornament3") 
        elseif dungeonname == "RUINS_4" or dungeonname == "RUINS_5" then
            inst:AddTag("top_ornament4")             
        end

        inst.stage = 0 
        inst.components.workable:SetWorkLeft(0)
        refreshImage(inst)
	
		
		if inst.stage <= 0 then inst.components.teleporter.enabled = true else
		inst.components.teleporter.enabled = false end	
        
        MakeSnowCovered(inst, .01)

        inst.OnSave = onsave
        inst.OnLoad = onload
				

        return inst
    end
    return fn
end
 
return Prefab("common/objects/pig_ruins_entrance", makefn("pig_ruins_entrance", true,"RUINS_1"), assets, prefabs ),
       Prefab("common/objects/pig_ruins_exit", makefn2("pig_ruins_entrance", false,"RUINS_1"), assets, prefabs ),

       Prefab("common/objects/pig_ruins_entrance2", makefn("pig_ruins_entrance", true,"RUINS_2"), assets, prefabs ),
       Prefab("common/objects/pig_ruins_exit2", makefn2("pig_ruins_entrance", false,"RUINS_2"), assets, prefabs ),

       Prefab("common/objects/pig_ruins_entrance3", makefn("pig_ruins_entrance", true,"RUINS_3"), assets, prefabs ),
       Prefab("common/objects/pig_ruins_entrance4", makefn("pig_ruins_entrance", true,"RUINS_4"), assets, prefabs ),
       Prefab("common/objects/pig_ruins_exit4", makefn2("pig_ruins_entrance", false,"RUINS_4"), assets, prefabs ),
  
       Prefab("common/objects/pig_ruins_entrance5", makefn("pig_ruins_entrance", true,"RUINS_5"), assets, prefabs ),
  
       Prefab("common/objects/pig_ruins_entrance_small", makefn("pig_ruins_entrance", true,"RUINS_SMALL"), assets, prefabs ),
	   Prefab("common/objects/pig_ruins_entrance6", makefn("pig_ruins_entrance", true,"RUINS_SMALL"), assets, prefabs )