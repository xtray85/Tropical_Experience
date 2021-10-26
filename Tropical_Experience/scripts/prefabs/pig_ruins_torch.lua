require "prefabutil"

local ANIM_ORIENTATION =
{
	Default = 0,
	OnGround = 1,
	RotatingBillboard = 2,
}

local FIREPIT_RAIN_RATE = 2
local FIREPIT_WIND_RATE = 1

local assets =
{
	Asset("ANIM", "anim/ruins_torch.zip"),
    Asset("ANIM", "anim/interior_wall_decals_ruins.zip"),   
    Asset("ANIM", "anim/interior_wall_decals_ruins_blue.zip"),   	
    Asset("MINIMAP_IMAGE", "ruins_torch"), 
}

local prefabs =
{
    "campfirefire"
}    

local function onignite(inst)
    if not inst.components.cooker then
        inst:AddComponent("cooker")
    end

    local pt = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 50,{"pig_writing_1"},{"INTERIOR_LIMBO"})
    for i, ent in ipairs(ents) do      
        ent:PushEvent("fire_lit")        
    end

end

local function onextinguish(inst)
    if inst.components.cooker then
        inst:RemoveComponent("cooker")
    end
    if inst.components.fueled then
        inst.components.fueled:InitializeFuelLevel(0)
    end
end

local function destroy(inst)
	local time_to_wait = 1
	local time_to_erode = 1
	local tick_time = TheSim:GetTickTime()

	if inst.DynamicShadow then
        inst.DynamicShadow:Enable(false)
    end

	inst:StartThread( function()
		local ticks = 0
		while ticks * tick_time < time_to_wait do
			ticks = ticks + 1
			Yield()
		end

		ticks = 0
		while ticks * tick_time < time_to_erode do
			local erode_amount = ticks * tick_time / time_to_erode
			inst.AnimState:SetErosionParams( erode_amount, 0.1, 1.0 )
			ticks = ticks + 1
			Yield()
		end
		inst:Remove()
	end)
end

local function onsave(inst, data)    
    data.rotation = inst.Transform:GetRotation()
    if inst.flipped then
        data.flipped = inst.flipped
    end    
end


local function onload(inst, data)
    if data then
        if data.rotation then
            inst.Transform:SetRotation(data.rotation)
        end
        if data.flipped then
            inst.flipped = data.flipped
            local rx,ry,rz = inst.Transform:GetScale()
            inst.Transform:SetScale(rx,ry,-rz)
        end         
    end  
end

local function fn(Sim)

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    anim:SetBank("pigtorch")
    anim:SetBuild("ruins_torch")
    anim:PlayAnimation("idle")
    
    ---inst.AnimState:SetRayTestOnBB(true);
    inst:AddTag("campfire")
    inst:AddTag("structure")    
    
    MakeObstaclePhysics(inst, .2)
	
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    -----------------------
    inst:AddComponent("propagator")
    -----------------------
    
    inst:AddComponent("burnable")

    inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0), "fire_marker" )
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
  -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.CAMPFIRE_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(4)
    
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    inst.components.fueled:SetUpdateFn( function()
        local rate = 1 
        if TheWorld.state.israining then
            inst.components.fueled.rate = 1 + FIREPIT_RAIN_RATE * TheWorld.state.wetness
        end
        rate = rate + FIREPIT_WIND_RATE

        inst.components.fueled.rate = rate 
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
    
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)
    -----------------------------
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t= {"EMBERS","LOW","NORMAL","HIGH"} 
            return t[sec]
        end
    end
    
    --------------------

    inst.OnSave = onsave 
    inst.OnLoad = onload 
           
    return inst
end

local function pillarfn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    anim:SetBank("pigtorch")
    anim:SetBuild("ruins_torch")
    anim:PlayAnimation("idle")
    
    ---inst.AnimState:SetRayTestOnBB(true);
    inst:AddTag("campfire")
    inst:AddTag("structure")    

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("ruins_torch.png")	
    
    MakeObstaclePhysics(inst, .2)
	
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    -----------------------
    inst:AddComponent("propagator")
    -----------------------
    
    inst:AddComponent("burnable")

    inst.components.burnable:AddBurnFX("campfirefire", Vector3(-60,0,0), "fire_marker" )
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
  -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.CAMPFIRE_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(4)
    
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    inst.components.fueled:SetUpdateFn( function()
        local rate = 1 
        if TheWorld.state.israining then
            inst.components.fueled.rate = 1 + FIREPIT_RAIN_RATE * TheWorld.state.wetness
        end
        rate = rate + FIREPIT_WIND_RATE

        inst.components.fueled.rate = rate 
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
    
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)
    -----------------------------
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t= {"EMBERS","LOW","NORMAL","HIGH"} 
            return t[sec]
        end
    end
    
    --------------------

    inst.OnSave = onsave 
    inst.OnLoad = onload 
  
    return inst
end

local function wallfn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    anim:SetBank("interior_wall_decals_ruins")
    anim:SetBuild("interior_wall_decals_ruins")
    anim:PlayAnimation("sconce_front") 
    
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 1 )
	
    inst:AddTag("campfire")
    inst:AddTag("structure")    
    inst:AddTag("wall_torch")
	
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("ruins_torch.png")	
    
    MakeObstaclePhysics(inst, .2)
	
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    -----------------------
    inst:AddComponent("propagator")
    -----------------------
    
    inst:AddComponent("burnable")

    inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0), "fire_marker" )
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
  -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.CAMPFIRE_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(4)
    
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    inst.components.fueled:SetUpdateFn( function()
        local rate = 1 
        if TheWorld.state.israining then
            inst.components.fueled.rate = 1 + FIREPIT_RAIN_RATE * TheWorld.state.wetness
        end
        rate = rate + FIREPIT_WIND_RATE

        inst.components.fueled.rate = rate 
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
    
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)
    -----------------------------
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t= {"EMBERS","LOW","NORMAL","HIGH"} 
            return t[sec]
        end
    end
    
    --------------------

    inst.OnSave = onsave 
    inst.OnLoad = onload 
  
    return inst
end

local function sidewallfn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    anim:SetBank("interior_wall_decals_ruins")
    anim:SetBuild("interior_wall_decals_ruins")
    anim:PlayAnimation("sconce_sidewall")
  
	inst.Transform:SetTwoFaced() 
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )  
    inst:AddTag("campfire")
    inst:AddTag("structure")    
    inst:AddTag("wall_torch")
	
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("ruins_torch.png")	
    
    MakeObstaclePhysics(inst, .2)



    inst:SetPrefabNameOverride("pig_ruins_torch_wall")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    -----------------------
    inst:AddComponent("propagator")
    -----------------------
    
    inst:AddComponent("burnable")

    inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0), "fire_marker" )
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
  -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.CAMPFIRE_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(4)
    
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    inst.components.fueled:SetUpdateFn( function()
        local rate = 1 
        if TheWorld.state.israining then
            inst.components.fueled.rate = 1 + FIREPIT_RAIN_RATE * TheWorld.state.wetness
        end
        rate = rate + FIREPIT_WIND_RATE

        inst.components.fueled.rate = rate 
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
    
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)
    -----------------------------
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t= {"EMBERS","LOW","NORMAL","HIGH"} 
            return t[sec]
        end
    end
    --------------------

    inst.OnSave = onsave 
    inst.OnLoad = onload 
  
    return inst
end


local function wallbluefn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    anim:SetBank("interior_wall_decals_ruins")
    anim:SetBuild("interior_wall_decals_ruins_blue")
    anim:PlayAnimation("sconce_front") 
    
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 1 )
	
    inst:AddTag("campfire")
    inst:AddTag("structure")    
    inst:AddTag("wall_torch")
	
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("ruins_torch.png")	
    
    MakeObstaclePhysics(inst, .2)
	
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    -----------------------
    inst:AddComponent("propagator")
    -----------------------
    
    inst:AddComponent("burnable")

    inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0), "fire_marker" )
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
  -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.CAMPFIRE_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(4)
    
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    inst.components.fueled:SetUpdateFn( function()
        local rate = 1 
        if TheWorld.state.israining then
            inst.components.fueled.rate = 1 + FIREPIT_RAIN_RATE * TheWorld.state.wetness
        end
        rate = rate + FIREPIT_WIND_RATE

        inst.components.fueled.rate = rate 
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
    
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)
    -----------------------------
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t= {"EMBERS","LOW","NORMAL","HIGH"} 
            return t[sec]
        end
    end
    
    --------------------

    inst.OnSave = onsave 
    inst.OnLoad = onload 
  
    return inst
end

local function sidewallbluefn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    anim:SetBank("interior_wall_decals_ruins")
    anim:SetBuild("interior_wall_decals_ruins_blue")
    anim:PlayAnimation("sconce_sidewall")
	
	inst.Transform:SetTwoFaced()	
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )  
    inst:AddTag("campfire")
    inst:AddTag("structure")    
    inst:AddTag("wall_torch")
	
inst.Transform:SetRotation(270)	
	
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("ruins_torch.png")	
    
    MakeObstaclePhysics(inst, .2)



    inst:SetPrefabNameOverride("pig_ruins_torch_wall")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    -----------------------
    inst:AddComponent("propagator")
    -----------------------
    
    inst:AddComponent("burnable")

    inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,0,0), "fire_marker" )
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
  -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.CAMPFIRE_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(4)
    
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
    inst.components.fueled:SetUpdateFn( function()
        local rate = 1 
        if TheWorld.state.israining then
            inst.components.fueled.rate = 1 + FIREPIT_RAIN_RATE * TheWorld.state.wetness
        end
        rate = rate + FIREPIT_WIND_RATE

        inst.components.fueled.rate = rate 
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
    
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(0)
    -----------------------------
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t= {"EMBERS","LOW","NORMAL","HIGH"} 
            return t[sec]
        end
    end
    --------------------

    inst.OnSave = onsave 
    inst.OnLoad = onload 
  
    return inst
end

return  Prefab( "common/objects/pig_ruins_torch", pillarfn, assets, prefabs),
        Prefab( "common/objects/pig_ruins_torch_wall", wallfn, assets, prefabs),
        Prefab( "common/objects/pig_ruins_torch_sidewall", sidewallfn, assets, prefabs),
    
        Prefab( "common/objects/pig_ruins_torch_wall_blue", wallbluefn, assets, prefabs),
        Prefab( "common/objects/pig_ruins_torch_sidewall_blue", sidewallbluefn, assets, prefabs)

