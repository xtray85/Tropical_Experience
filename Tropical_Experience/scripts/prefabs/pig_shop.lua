require "prefabutil"
require "recipes"

local assets =
{
    Asset("ANIM", "anim/pig_shop.zip"),    
	Asset("ANIM", "anim/pig_shop_florist.zip"),
    Asset("ANIM", "anim/pig_shop_hoofspa.zip"),
    Asset("ANIM", "anim/pig_shop_produce.zip"),
    Asset("ANIM", "anim/pig_shop_general.zip"),
    Asset("ANIM", "anim/pig_shop_deli.zip"),    
    Asset("ANIM", "anim/pig_shop_antiquities.zip"),       

    Asset("ANIM", "anim/flag_post_duster_build.zip"),    
    Asset("ANIM", "anim/flag_post_wilson_build.zip"),    

    Asset("ANIM", "anim/pig_cityhall.zip"),      
    Asset("ANIM", "anim/pig_shop_arcane.zip"),
    Asset("ANIM", "anim/pig_shop_weapons.zip"),
    Asset("ANIM", "anim/pig_shop_accademia.zip"),
    Asset("ANIM", "anim/pig_shop_millinery.zip"),
    Asset("ANIM", "anim/pig_shop_bank.zip"),
    Asset("ANIM", "anim/pig_shop_tinker.zip"),
}

shops =
{
[1] = "pig_shop_deli",
[2] = "pig_shop_general",
[3] = "pig_shop_hoofspa",
[4] = "pig_shop_produce",
[5] = "pig_shop_florist",
[6] = "pig_shop_antiquities",
[7] = "pig_shop_academy",
[8] = "pig_shop_arcane",
[9] = "pig_shop_weapons",
[10] = "pig_shop_hatshop",
[11] = "pig_shop_cityhall",
}


local prefabs = 
{

}

local SHOPSOUND_ENTER1 = "Hamlet/common/objects/store/door_open"
local SHOPSOUND_ENTER2 = "Hamlet/common/objects/store/door_entrance"
local SHOPSOUND_EXIT = "Hamlet/common/objects/store/door_close"

local spawnprefabs =
{
    "pig_shop_florist",
    "pig_shop_general",
    "pig_shop_hoofspa",
    "pig_shop_produce",    
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
        child.parent.SoundEmitter:PlaySound("Hamet/creatures/city_pig/pig_in_house_LP", "pigsound")
    end
end

local function onoccupied(inst, child)
    if not inst:HasTag("burnt") then
    	inst.SoundEmitter:PlaySound("Hamet/creatures/city_pig/pig_in_house_LP", "pigsound")
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
    	
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
    	--inst.doortask = inst:DoTaskInTime(1, function() if not inst.components.playerprox:IsPlayerClose() then LightsOn(inst) end end)
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
local targetpos = inst:GetPosition()
local package = SpawnPrefab("bundled_structure")
if package and package.components.bundled_structure then
if inst.components.teleporter ~= nil and inst.components.teleporter:IsBusy() then
return false
end
package.components.bundled_structure:Pack(inst)
package.Transform:SetPosition(targetpos:Get())
SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
if worker and worker.SoundEmitter then
worker.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
end
end
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
    if not inst:HasTag("burnt") then
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
        inst.doortask = inst:DoTaskInTime(1, function() LightsOn(inst) end)  
--		inst.components.teleporter.enabled = true		
    end
end

local function OnDusk(inst)
    --print(inst, "OnDay")
    if not inst:HasTag("burnt") then       
        LightsOff(inst)
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
--	inst.components.teleporter.enabled = false	
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

    if inst.interiorID then
        data.interiorID = inst.interiorID
    end
	
	data.build = inst.build	
end

local function onload(inst, data)
    if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
    if data and data.spawned_shop then
        inst:AddTag("spawned_shop")
    end
    if data and data.interiorID then
        inst.interiorID = data.interiorID
    end    
	
    if data and data.build then
        inst.build = data.build
        inst.AnimState:SetBuild(inst.build)
    end	
end

local function spawn_shop(inst)  
   -- print("CHECKING",inst.cancelspawn,inst.forcespawn)

    if not inst.cancelspawn then
        if inst.forcespawn then
            local spawn = inst.forcespawn

            local pt = Vector3(inst.Transform:GetWorldPosition())
           -- local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 3, {"structure"})
            if spawn then -- and  #ents == 0 
                --print("SPAWNING",spawn)
                local shop = SpawnPrefab(spawn)                
                shop.Transform:SetPosition(inst.Transform:GetWorldPosition())
                if not shop.components.citypossession then
                    shop:AddComponent("citypossession")
                end
                shop.components.citypossession.cityID = inst.components.citypossession.cityID                 
            end                    
        else

            local nilwieght = inst.nilwieght or 6

            local spawn_list = 
            {
                {"pig_shop_florist",1},
                {"pig_shop_general",1},
                {"pig_shop_hoofspa",1},
                {"pig_shop_produce",1},
                {"pig_guard_tower",1},        
                {"pighouse_city",4},
                {nil,nilwieght},
            }

            local total = 0

            for i = 1, #spawn_list do
                total = total + spawn_list[i][2]
            end

            local choice = math.random(0,total)
            total = 0
            for i = 1, #spawn_list do
                total = total + spawn_list[i][2]
                if choice <= total then
                    local spawn = spawn_list[i][1]
                    local pt = Vector3(inst.Transform:GetWorldPosition())
                    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 3, {"structure"})

                    if spawn and  #ents == 0 then
                        local shop = SpawnPrefab(spawn)
                        shop.Transform:SetPosition(inst.Transform:GetWorldPosition())                                                      
                        if not shop.components.citypossession then
                            shop:AddComponent("citypossession")
                        end
                        if  inst.components.citypossession and inst.components.citypossession.cityID then
                            shop.components.citypossession.cityID = inst.components.citypossession.cityID                                                                             
                        end
                    end
                    break
                end
            end
        end
    end
    inst:Remove()
end

local function makespawnerfn(Sim)
    print("SPAWNER SPAWNING")

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()

    trans:SetEightFaced()

    MakeObstaclePhysics(inst, 1)
    anim:SetBank("pig_shop")
    anim:PlayAnimation("idle",true)
    
    inst:AddTag("pig_shop_spawner")

	
-----------------adicionei pra criar sopping aleatorio-----------------	

------------------------------------------------------------------------
	
    inst:DoTaskInTime(1, function() 
	local coloca = SpawnPrefab(shops[math.random(1, 11)])
    local x,y,z = inst.Transform:GetWorldPosition()
    coloca.Transform:SetPosition(x, y, z)		
	
	
	
	print("KILLING A SHOP SPAWNER") inst:Remove() 
	
	
	
	end ) -- spawn_shop(inst)

    return inst    
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
    if inst.closetask ~= nil then
        inst.closetask:Cancel()
    end

    if obj ~= nil and obj:HasTag("player") then
        obj:DoTaskInTime(1, obj.PushEvent, "wormholespit") -- for wisecracker
    end

end
local function StartTravelSound(inst, doer)
    doer.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/store/door_open")
--    doer:PushEvent("wormholetravel", WORMHOLETYPE.WORM) --Event for playing local travel sound
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
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/store/door_close")
    end
end

local function makefn(name,build, bank, data)

    local function fn(Sim)
    	local inst = CreateEntity()
    	local trans = inst.entity:AddTransform()
    	local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
		inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()

    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon( name .. ".png" )

        light:SetFalloff(1)
        light:SetIntensity(.5)
        light:SetRadius(1)
        light:Enable(false)
        light:SetColour(180/255, 195/255, 50/255)
        
        MakeObstaclePhysics(inst, 1.25)

        if bank then
            anim:SetBank(bank)
        else
            anim:SetBank("pig_shop")
        end

        anim:SetBuild(build)

        anim:PlayAnimation("idle",true)
	    anim:Hide("YOTP")			

        inst:AddTag(name)

        inst:AddTag("structure")
		inst:AddTag("hamletteleport")
		
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
		
        inst:AddComponent("lootdropper")

--        inst:AddComponent("door")
    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
	inst.components.teleporter.hamlet = true	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)	



    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
   	inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
   
		
        inst:AddComponent("inspectable")    

        if name == "pig_shop_cityhall" then
            inst.AnimState:AddOverrideBuild("flag_post_duster_build")
        end
        if name == "pig_shop_cityhall_player" then
           inst.AnimState:AddOverrideBuild("flag_post_wilson_build") 
        end
        
--		if name == "pig_shop_cityhall_player" then
--            ThePlayer:AddTag("mayor")
--        end

        inst.components.inspectable.getstatus = getstatus
    	
    	MakeSnowCovered(inst, .01)

--        inst:AddComponent("fixable")
--        inst.components.fixable:AddRecinstructionStageData("rubble","pig_shop",build)
--        inst.components.fixable:AddRecinstructionStageData("unbuilt","pig_shop",build)

        if not data or not data.indestructable then
            MakeMediumBurnable(inst, nil, nil, true)
            MakeLargePropagator(inst)
        end

--[[
        inst:ListenForEvent("burntup", function(inst)
            inst.components.fixable:AddRecinstructionStageData("burnt","pig_shop",build,1)
            if inst.doortask then
                inst.doortask:Cancel()
                inst.doortask = nil
            end
            inst:Remove()
        end)
]]		
        inst:ListenForEvent("onignite", function(inst, data)
            if inst.components.spawner then
                inst.components.spawner:ReleaseChild()
            end
        end)

        inst.OnSave = onsave 
        inst.OnLoad = onload

    	inst:ListenForEvent( "onbuilt", onbuilt)
        inst:DoTaskInTime(math.random(), function() 
            --print(inst, "spawn check day")
            if TheWorld.state.isday then 
                OnDay(inst)
            end 
        end)		
		
	inst:WatchWorldState("isday", OnDay)
	inst:WatchWorldState("isdusk", OnDusk)			
		


        if data and data.sounds then
            inst.usesounds = data.sounds
        end

--        inst:ListenForEvent("usedoor", function(inst,data) usedoor(inst,data) end)    
       inst.OnEntityWake = function (inst)
        if TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.fiesta_active == true then
            inst.AnimState:Show("YOTP")
        else
            inst.AnimState:Hide("YOTP")
        end	
		end

        return inst
    end
    return fn
end

local function makehousefn(name,build, bank, data)

    local function fn(Sim)
    	local inst = CreateEntity()
    	local trans = inst.entity:AddTransform()
    	local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
		inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()

    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon( name .. ".png" )

        light:SetFalloff(1)
        light:SetIntensity(.5)
        light:SetRadius(1)
        light:Enable(false)
        light:SetColour(180/255, 195/255, 50/255)
        
        MakeObstaclePhysics(inst, 1.25)

        anim:SetBank("pig_house_sale")
        anim:SetBuild(build)
        anim:PlayAnimation("idle",true)
	    anim:Hide("YOTP")	
		inst.AnimState:Hide("boards")		

        inst:AddTag(name)
        inst:AddTag("structure")
		inst:AddTag("hamletteleport")
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end		
		
        inst:AddComponent("lootdropper")

		inst:AddComponent("teleporter")
		inst.components.teleporter.onActivate = OnActivate
		inst.components.teleporter.onActivateByOther = OnActivateByOther
		inst.components.teleporter.offset = 0
		inst.components.teleporter.hamlet = true	
		inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
		inst:ListenForEvent("doneteleporting", OnDoneTeleporting)	
  
		
        inst:AddComponent("inspectable")    

        inst.components.inspectable.getstatus = getstatus
    	
    	MakeSnowCovered(inst, .01)

--        inst:AddComponent("fixable")
--        inst.components.fixable:AddRecinstructionStageData("rubble","pig_shop",build)
--        inst.components.fixable:AddRecinstructionStageData("unbuilt","pig_shop",build)

        inst.OnSave = onsave 
        inst.OnLoad = onload

    	inst:ListenForEvent( "onbuilt", onbuilt)

		
--inst:WatchWorldState("isday", function() inst.components.door.disabled = nil end)
--inst:WatchWorldState("isnight", function() inst.components.door.disabled = true end)


        if data and data.sounds then
            inst.usesounds = data.sounds
        end

       inst.OnEntityWake = function (inst)
        if TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.fiesta_active == true then
            inst.AnimState:Show("YOTP")
        else
            inst.AnimState:Hide("YOTP")
        end	
		end

        return inst
    end
    return fn
end

local function makeshop(name, build, bank, data)   
    return Prefab("common/objects/" .. name, makefn(name, build, bank, data), assets, prefabs )
end

local function makehouse(name, build, bank, data)   
    return Prefab("common/objects/" .. name, makehousefn(name, build, bank, data), assets, prefabs )
end

return makeshop("pig_shop_deli",        "pig_shop_deli",        nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),
       makeshop("pig_shop_general",     "pig_shop_general",     nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),
       makeshop("pig_shop_hoofspa",     "pig_shop_hoofspa",     nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),        
       makeshop("pig_shop_produce",     "pig_shop_produce",     nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),
       makeshop("pig_shop_florist",     "pig_shop_florist",     nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),
       makeshop("pig_shop_antiquities", "pig_shop_antiquities", nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ), 

       makeshop("pig_shop_academy",     "pig_shop_accademia",   nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),
       makeshop("pig_shop_arcane",      "pig_shop_arcane",      nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),
       makeshop("pig_shop_weapons",     "pig_shop_weapons",     nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),
       makeshop("pig_shop_hatshop",     "pig_shop_millinery",   nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),

       makeshop("pig_shop_bank",        "pig_shop_bank",        nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),	
       makeshop("pig_shop_tinker",      "pig_shop_tinker",      nil,    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} } ),	   
	   
       makeshop("pig_shop_cityhall", "pig_cityhall", "pig_cityhall",    {indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} }),
       makeshop("pig_shop_cityhall_player", "pig_cityhall", "pig_cityhall",{indestructable=true, sounds = {SHOPSOUND_ENTER1,SHOPSOUND_ENTER2} }), 	   
	      
       Prefab("common/objects/pig_shop_spawner", makespawnerfn, assets, spawnprefabs ),


       MakePlacer("common/pig_shop_deli_placer", "pig_shop", "pig_shop_deli", "idle"),
       MakePlacer("common/pig_shop_general_placer", "pig_shop", "pig_shop_general", "idle"),
       MakePlacer("common/pig_shop_hoofspa_placer", "pig_shop", "pig_shop_hoofspa", "idle"),
       MakePlacer("common/pig_shop_produce_placer", "pig_shop", "pig_shop_produce", "idle"),
       MakePlacer("common/pig_shop_florist_placer", "pig_shop", "pig_shop_florist", "idle"),
       MakePlacer("common/pig_shop_antiquities_placer", "pig_shop", "pig_shop_antiquities", "idle"),
       MakePlacer("common/pig_shop_academy_placer", "pig_shop", "pig_shop_accademia", "idle"),
       MakePlacer("common/pig_shop_arcane_placer", "pig_shop", "pig_shop_arcane", "idle"),
       MakePlacer("common/pig_shop_weapons_placer", "pig_shop", "pig_shop_weapons", "idle"),
       MakePlacer("common/pig_shop_hatshop_placer", "pig_shop", "pig_shop_millinery", "idle"),
       MakePlacer("common/pig_shop_cityhall_placer", "pig_cityhall", "pig_cityhall", "idle"),
       MakePlacer("common/pig_shop_bank_placer", "pig_shop", "pig_shop_bank", "idle"),
       MakePlacer("common/pig_shop_tinker_placer", "pig_shop", "pig_shop_tinker", "idle")  