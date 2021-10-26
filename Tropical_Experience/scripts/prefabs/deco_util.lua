local ANIM_ORIENTATION =
{
	Default = 0,
	OnGround = 1,
	RotatingBillboard = 0,
}

local DECO_RUINS_BEAM_WORK = 6

function MakeInteriorPhysics(inst, rad, height, width)
    height = height or 20

    inst:AddTag("blocker")
     local phys = inst.entity:AddPhysics()
    inst.Physics:SetMass(0) 
--    inst.Physics:SetRectangle(rad,height,width)
--    inst.Physics:SetCollisionGroup(GetWorldCollision())
    phys:SetCollisionGroup(COLLISION.CHARACTERS)
    phys:ClearCollisionMask()
    phys:CollidesWith(COLLISION.WORLD)
    phys:CollidesWith(COLLISION.OBSTACLES)
    phys:CollidesWith(COLLISION.SMALLOBSTACLES)
    phys:CollidesWith(COLLISION.CHARACTERS)
    phys:CollidesWith(COLLISION.GIANTS)
end

local function setScale(inst)
    inst.Transform:SetScale(1, 0.95, 1)
end

local function smash(inst)
    if inst.components.lootdropper then
            inst.components.lootdropper:DropLoot()
    end
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    if inst.SoundEmitter then
        inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    end

    inst:Remove()
end    

local function setPlayerUncraftable(inst)
    inst:AddComponent("lootdropper")
    inst.entity:AddSoundEmitter()
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)
            if workleft <= 0 then
                smash(inst)
            end
        end)
end

local function onBuilt(inst)
    setPlayerUncraftable(inst)
    inst.onbuilt = true

    if inst:HasTag("cornerpost") then
        local pt = inst:GetPosition()
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 1, {"cornerpost"})
        for i,ent in ipairs(ents) do
            if ent ~= inst then
                smash(ent)
            end
        end
    end 

    if inst:HasTag("centerlight") then
        local pt = inst:GetPosition()
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 1, {"centerlight"})
        for i,ent in ipairs(ents) do
            if ent ~= inst then
               smash(ent)
            end
        end
    end   

    if inst:HasTag("wallsection") then
        local pt = inst:GetPosition()
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 1, {"wallsection"})
        for i,ent in ipairs(ents) do
            if ent ~= inst then
               smash(ent)
            end
        end
    end           
end

local function onsave(inst, data)    
    local references = {}
    data.rotation = inst.Transform:GetRotation()
    local pt = Vector3(inst.Transform:GetScale())
    data.scalex = pt.x
    data.scaley = pt.y
    data.scalez = pt.z

    if inst.sunraysspawned then
        data.sunraysspawned = inst.sunraysspawned
    end
    --if inst.flipped then
        --data.flipped = inst.flipped
    --end    
    if inst.setbackground then
        data.setbackground = inst.setbackground
    end
    if inst:HasTag("dartthrower") then
        data.dartthrower = true
    end
    if inst:HasTag("dartthrower_right") then
        data.dartthrower_right = true
    end
    if inst:HasTag("dartthrower_left") then
        data.dartthrower_left = true
    end
    if inst:HasTag("playercrafted") then
        data.playercrafted = true
    end    

    if inst.dust then
        data.dust = inst.dust.GUID
        table.insert(references, data.dust)
    end

    if inst.swinglight then
        data.swinglight = inst.swinglight.GUID
        table.insert(references, data.swinglight)
    end    

    if inst.animdata then
        data.animdata = inst.animdata
    end

    if inst.onbuilt then
        data.onbuilt = inst.onbuilt
    end
    if inst.recipeproxy then
        data.recipeproxy = inst.recipeproxy
    end
    return references
end

local function onload(inst, data)
if data then
    if data.rotation then
        inst.Transform:SetRotation(data.rotation)
    end
    if data.scalex  then
        inst.Transform:SetScale( data.scalex, data.scaley, data.scalez)
    end
    if data.sunraysspawned then
        inst.sunraysspawned = data.sunraysspawned
    end  
    --if data.flipped then
    --    inst.flipped = data.flipped        
    --end       
    if data.dartthrower then
       inst:AddTag("dartthrower")
    end
    if data.dartthrower_right then
        inst:AddTag("dartthrower_right")
    end
    if  data.dartthrower_left then
        inst:AddTag("dartthrower_left")
    end
    if data.playercrafted then
        inst:AddTag("playercrafted")
    end    
    if data.setbackground then
        inst.AnimState:SetLayer( LAYER_WORLD_BACKGROUND )
        inst.AnimState:SetSortOrder(data.setbackground)   
        inst.setbackground = data.setbackground
    end 
    if data.animdata then
        inst.animdata = data.animdata
        if inst.animdata.build then
            inst.AnimState:SetBuild(inst.animdata.build)
        end
        if inst.animdata.bank then
            inst.AnimState:SetBank(inst.animdata.bank)
        end
        if inst.animdata.anim then
            inst.AnimState:PlayAnimation(inst.animdata.anim,inst.animdata.animloop)
        end                
    end
        
    if data.onbuilt then
        setPlayerUncraftable(inst)
        inst.onbuilt = data.onbuilt
    end

    if data.recipeproxy then
        inst.recipeproxy = data.recipeproxy
    end    
end	
end

local function loadpostpass(inst,ents, data)
    if data then
        if data.swinglight then  
            local swinglight = ents[data.swinglight]
            if swinglight then
                inst.swinglight = swinglight.entity
            end
        end
        if data.dust then  
            local dust = ents[data.dust]
            if dust then
                inst.dust = dust.entity
            end
        end  
           
    end
end

local function onremove(inst)

    if inst.decochildrenToRemove then
        for i,child in ipairs(inst.decochildrenToRemove) do
            child:Remove()
        end
    end

    if inst.swinglight then
        inst.swinglight:Remove()
    end
    if inst.dust then
        inst.dust:Remove()
    end

end

local function turnoff(inst, light)
    if light then
        light:Enable(false)
    end   
end

local phasefunctions = 
{
    day = function(inst)
        local lights = inst.lightsetting
        inst.Light:Enable(true)
--		print("dia")
        inst.components.lighttweener:StartTween(nil, lights.day.radius, lights.day.intensity, lights.day.falloff, {lights.day.color[1],lights.day.color[2],lights.day.color[3]}, 2)
    end,

    dusk = function(inst) 
        local lights = inst.lightsetting
        inst.Light:Enable(true)
--		print("tarde")		
        inst.components.lighttweener:StartTween(nil, lights.dusk.radius, lights.dusk.intensity, lights.dusk.falloff, {lights.dusk.color[1],lights.dusk.color[2],lights.dusk.color[3]}, 2)
    end,

    night = function(inst) 
        local lights = inst.lightsetting
        if TheWorld.state.moonphase == "full" then
--		print("lua")		
            inst.components.lighttweener:StartTween(nil, lights.full.radius, lights.full.intensity, lights.full.falloff, {lights.full.color[1],lights.full.color[2],lights.full.color[3]}, 4)
        else
--		print("noite")		
            inst.components.lighttweener:StartTween(nil, 0, 0, 1, {0, 0, 0}, 6, turnoff)
        end    
    end,
}

local function timechange(inst)    
    if TheWorld.state.isday then
        inst.AnimState:PlayAnimation("to_day")
        inst.AnimState:PushAnimation("day_loop", true)
        if inst.Light then
--		print("gtgtgtdgssd")
           phasefunctions["day"](inst)
		end
    elseif TheWorld.state.isnight then
       inst.AnimState:PlayAnimation("to_night")
        inst.AnimState:PushAnimation("night_loop", true)
        if inst.Light then
            phasefunctions["night"](inst)
        end
    elseif TheWorld.state.isdusk then
        inst.AnimState:PlayAnimation("to_dusk")
        inst.AnimState:PushAnimation("dusk_loop", true)
        if inst.Light then
           phasefunctions["dusk"](inst)
      end
    end
end

local function mirror_blink_idle(inst)
    if inst.isneer then
        local anim = inst.AnimState
        anim:PlayAnimation("shadow_blink")
        anim:PushAnimation("shadow_idle", true)
    end
    inst.blink_task = inst:DoTaskInTime(10 + (math.random()*50), function() mirror_blink_idle(inst) end) 
end

local function mirror_OnNear(inst)
    local anim= inst.AnimState
    anim:PlayAnimation("shadow_in")
    anim:PushAnimation("shadow_idle", true)

    inst.blink_task = inst:DoTaskInTime(10 + (math.random()*50), function() mirror_blink_idle(inst) end) 
    inst.isneer = true
end

local function mirror_OnFar(inst)
    if inst.isneer then        
        local anim = inst.AnimState
        anim:PlayAnimation("shadow_out")
        anim:PushAnimation("idle", true)    
        inst.isneer = nil
        inst.blink_task:Cancel()
        inst.blink_task = nil
    end
end

function decofn(build, bank, animframe, data, assets, prefabs)
    if not data then
        data = {}
    end    

    local loopanim = data.loopanim
    local decal = data.decal
    local background = data.background
    local light = data.light
    local followlight = data.followlight
    local scale = data.scale
    local mirror = data.mirror
    local physics = data.physics
    local windowlight = data.windowlight
    local workable = data.workable
    local prefabname = data.prefabname
    local minimapicon = data.minimapicon
    local tags = data.tags or {}

    local function fn(Sim)
        local inst = CreateEntity()
		    inst.entity:AddNetwork()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()

        anim:SetBuild(build)
        anim:SetBank(bank)
        anim:PlayAnimation(animframe, loopanim)

        inst.Transform:SetRotation(-90)

        for i, tag in ipairs(tags) do
            inst:AddTag(tag)
        end
		inst:AddTag("liberado")		

        if data.children then
--            if not inst.childrenspawned then
			inst:DoTaskInTime(1, function(inst)
                for i, child in ipairs(data.children) do
                    local childprop = SpawnPrefab(child)
					childprop.entity:SetParent(inst.entity)
					childprop.Transform:SetRotation(inst.Transform:GetRotation())
					childprop.Transform:SetPosition(0, 0, 0)				
                    if not inst.decochildrenToRemove then
                        inst.decochildrenToRemove = {}
                    end       
                    table.insert(inst.decochildrenToRemove,childprop)
                end
			end)
--            end
--            inst.childrenspawned = true
        end

        if minimapicon then
            local minimap = inst.entity:AddMiniMapEntity()
            minimap:SetIcon(minimapicon)
        end

        if background then
            inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
            inst.AnimState:SetSortOrder(background)   
            inst.setbackground = background
        end

        if physics then
            if physics == "sofa_physics" then
                MakeObstaclePhysics(inst, 1.3, 1)
            elseif physics == "sofa_physics_vert" then
                MakeObstaclePhysics(inst, 0.4, 1)                
            elseif physics == "chair_physics" then
                MakeObstaclePhysics(inst, 1, 1)
            elseif physics == "desk_physics" then
                MakeObstaclePhysics(inst, 2, 1)
            elseif physics == "tree_physics" then
				MakeObstaclePhysics(inst, 4)
                inst:AddTag("blocker")
                inst.entity:AddPhysics()
                inst.Physics:SetMass(0)
                inst.Physics:SetCylinder(4.7, 4.0)
                inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
                inst.Physics:ClearCollisionMask()
                inst.Physics:CollidesWith(COLLISION.ITEMS)
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)				
            elseif physics == "pond_physics" then
                inst:AddTag("blocker")
                inst.entity:AddPhysics()
                inst.Physics:SetMass(0)
                inst.Physics:SetCylinder(1.6, 4.0)
                inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
                inst.Physics:ClearCollisionMask()
                inst.Physics:CollidesWith(COLLISION.ITEMS)
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)
            elseif physics == "big_post_physics" then
                MakeObstaclePhysics(inst, 0.75)
            elseif physics == "post_physics" then
                MakeObstaclePhysics(inst, .25)
            end
        end

        if scale then
            anim:SetScale(scale.x, scale.y, scale.z)
        end

        inst.OnSave = onsave 
        inst.OnLoad = onload
        inst.LoadPostPass = loadpostpass

--        if decal then
--            inst.AnimState:SetOrientation(ANIM_ORIENTATION.RotatingBillboard)
--        else
            inst.Transform:SetTwoFaced()
--        end

        if loopanim then
            anim:SetTime(math.random() * anim:GetCurrentAnimationLength())
        end

        if not data.curtains then
            anim:Hide("curtain")
        end

        if data.dayevents then
		inst:WatchWorldState("isday", timechange)
		inst:WatchWorldState("isdusk", timechange)
		inst:WatchWorldState("isnight", timechange)

            timechange(inst)
        end

        if light then

            if followlight then
				inst.persists = false
                inst:DoTaskInTime(0, function()

--				if not inst.sunraysspawned then
                        inst.swinglight = SpawnPrefab("swinglightobject")
                        inst.swinglight.setLightType(inst.swinglight, followlight)
                        if windowlight then
                            inst.swinglight.setListenEvents(inst.swinglight)                           
                        end                        
                        local follower = inst.swinglight.entity:AddFollower()
                        follower:FollowSymbol( inst.GUID, "light_circle", 0, 0, 0 )
                        inst.swinglight.followobject =  {GUID=inst.GUID, symbol="light_circle", x=0, y=0, z=0}
--                        inst.sunraysspawned = true
--                    end

                end)
            else 

                inst.entity:AddLight()
                inst.Light:SetIntensity(light.intensity)
                inst.Light:SetColour(light.color[1], light.color[2], light.color[3])
                inst.Light:SetFalloff(light.falloff)
                inst.Light:SetRadius(light.radius)
                inst.Light:Enable(true)
                inst:AddComponent("fader")
            end
        end

		
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
		
		
        if mirror then
            inst:AddComponent("playerprox")
            inst.components.playerprox:SetOnPlayerNear(mirror_OnNear)
            inst.components.playerprox:SetOnPlayerFar(mirror_OnFar)
            inst.components.playerprox:SetDist(2, 2.1)
        end

        if workable then
            inst:AddComponent("inspectable")

            inst.entity:AddSoundEmitter()

            inst:AddComponent("workable")
            inst.components.workable:SetWorkAction(ACTIONS.MINE)
            inst.components.workable:SetWorkLeft(DECO_RUINS_BEAM_WORK)
            inst.components.workable:SetOnWorkCallback(
                function(inst, worker, workleft)
                    local animlevel = workleft/DECO_RUINS_BEAM_WORK
                    if animlevel <= 0 then
                        inst.AnimState:PlayAnimation("pillar_front_crumble")
                    elseif animlevel < 1/3 then
                        inst.AnimState:PlayAnimation("pillar_front_break_2")
                    elseif animlevel < 2/3 then
                        inst.AnimState:PlayAnimation("pillar_front_break_1")
                    end
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
                   -- TheWorld.components.quaker:MiniQuake(3, 5, 1.5, worker) 
                    if TheWorld.components.quaker_interior then
                        if workleft <= 0 then
                            TheWorld.components.quaker_interior:ForceQuake("cavein", inst)
                            inst.components.workable:SetWorkable(false)
--                            print("QUAKE: CAVE IN!!!")
                        else
                           TheWorld.components.quaker_interior:ForceQuake("pillarshake", inst)
--                           print("QUAKE: pillar!!!")
                        end
                    end
                   -- TheCamera:Shake("FULL", 1.0, 0.05, .2)
                end)
        end

        if prefabname then
            inst:AddComponent("inspectable")
            inst:SetPrefabName(prefabname)
        end

        if prefabname == "pig_latin_1" then
            inst:AddTag("pig_writing_1")
            TheWorld:ListenForEvent("doorused", function(world, data) 
                    if not inst:HasTag("INTERIOR_LIMBO") then
                        inst:DoTaskInTime(1,
                            function()
                                local pt = Vector3(inst.Transform:GetWorldPosition())
                                local torches = TheSim:FindEntities(pt.x, pt.y, pt.z, 50, {"wall_torch"}, {"INTERIOR_LIMBO"})
                                local closedoors = false
                                for i,torch in ipairs(torches)do
                                    if not torch.components.cooker then
                                        closedoors = true
                                    end
                                end

                                if closedoors then
                                    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 50, {"lockable_door"}, {"INTERIOR_LIMBO"})
                                    for i, ent in ipairs(ents)do
                                        if ent ~= data.door then
                                            ent:PushEvent("close")
                                        end
                                    end
                                end
                            end)
                    end
                end, TheWorld)


            inst:ListenForEvent("fire_lit", function() 
                    local opendoors = true
                    local pt = Vector3(inst.Transform:GetWorldPosition())
                    local torches = TheSim:FindEntities(pt.x, pt.y, pt.z, 50, {"wall_torch"}, {"INTERIOR_LIMBO"})

                    for i,torch in ipairs(torches)do
                        if not torch.components.cooker then
                            opendoors = false
                        end
                    end

                    if opendoors then
                        local pt = Vector3(inst.Transform:GetWorldPosition())
                        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 50, nil, {"INTERIOR_LIMBO"})
                        for i, ent in ipairs(ents)do
                            if ent:HasTag("lockable_door") then
                                ent:PushEvent("open")
                            end
                        end
                    end                   
                end)
        end


        inst:ListenForEvent("onremove", function() 
                onremove(inst)
            end)
        
        inst:DoTaskInTime(0,function() 
                if inst:HasTag("playercrafted") then
                    setPlayerUncraftable(inst)
                end
            end)

        if data.onbuilt then
            inst:ListenForEvent( "onbuilt", function()
                onBuilt(inst)
            end)        
        end

        if data.adjustanim then
            if false then
                anim:PlayAnimation(animframe .. "_front")
            else
                anim:PlayAnimation(animframe .. "_side")
            end
        end

        if data.recipeproxy then
            inst.recipeproxy = data.recipeproxy
        end

        return inst
    end
    return fn
end

local assets =
{
    Asset("ANIM", "anim/interior_unique.zip"),      
    Asset("ANIM", "anim/interior_sconce.zip"),  
    Asset("ANIM", "anim/interior_defect.zip"),  
    Asset("ANIM", "anim/interior_decor.zip"),  
    Asset("ANIM", "anim/interior_pillar.zip"), 
    Asset("ANIM", "anim/containers.zip"),
    Asset("ANIM", "anim/interior_floor_decor.zip"),
    Asset("ANIM", "anim/interior_window.zip"),
    Asset("ANIM", "anim/interior_window_burlap.zip"),
    Asset("ANIM", "anim/interior_window_lightfx.zip"),
    Asset("ANIM", "anim/window_arcane_build.zip"),

    Asset("ANIM", "anim/interior_wall_decals.zip"),
    Asset("ANIM", "anim/interior_wall_decals_hoofspa.zip"),
    Asset("ANIM", "anim/interior_wall_mirror.zip"),
    Asset("ANIM", "anim/interior_chair.zip"),
   
    Asset("ANIM", "anim/interior_wall_decals_antiquities.zip"),
    Asset("ANIM", "anim/interior_wall_decals_arcane.zip"),
    Asset("ANIM", "anim/interior_wall_decals_deli.zip"),
    Asset("ANIM", "anim/interior_wall_decals_florist.zip"),
    Asset("ANIM", "anim/interior_wall_decals_mayorsoffice.zip"),
    Asset("ANIM", "anim/interior_wall_decals_palace.zip"),   
    Asset("ANIM", "anim/interior_wall_decals_accademia.zip"),
    Asset("ANIM", "anim/interior_wall_decals_millinery.zip"),
    Asset("ANIM", "anim/interior_wall_decals_weapons.zip"),

    Asset("ANIM", "anim/interior_wallornament.zip"),

    Asset("ANIM", "anim/window_mayorsoffice.zip"),
    Asset("ANIM", "anim/window_palace.zip"),
    Asset("ANIM", "anim/window_palace_stainglass.zip"),

    Asset("ANIM", "anim/interior_plant.zip"),
    Asset("ANIM", "anim/interior_table.zip"),
    Asset("ANIM", "anim/interior_floorlamp.zip"),

    Asset("ANIM", "anim/interior_window_small.zip"),
    Asset("ANIM", "anim/interior_window_large.zip"),
    Asset("ANIM", "anim/interior_window_tall.zip"),

    Asset("ANIM", "anim/window_weapons_build.zip"),

    Asset("ANIM", "anim/pig_ruins_well.zip"),
    Asset("ANIM", "anim/ceiling_decor.zip"),
    Asset("ANIM", "anim/light_dust_fx.zip"),
}

local prefabs =
{

}

local LIGHTS =
{
    SUNBEAM =
    { 
        day  = {radius = 3, intensity = 0.75, falloff = 0.5, color = {1, 1, 1}},
        dusk = {radius = 2, intensity = 0.75, falloff = 0.5, color = {1/1.8, 1/1.8, 1/1.8}},
        full = {radius = 2, intensity = 0.75, falloff = 0.5, color = {0.8/1.8, 0.8/1.8, 1/1.8}}
    },

    SUNBEAM =
    { 
        intensity = 0.9,
        color     = {197/255, 197/255, 50/255},
        falloff   = 0.5,
        radius    = 2,
    },

    SMALL =
    { 
        intensity = 0.75,
        color     = {97/255, 197/255, 50/255},
        falloff   = 0.7,
        radius    = 1,
    },

    MED =
    { 
        intensity = 0.9,
        color     = {197/255, 197/255, 50/255},
        falloff   = 0.5,
        radius    = 3,
    },

    SMALL_YELLOW =
    { 
        intensity = 0.75,
        color     = {197/255, 197/255, 50/255},
        falloff   = 0.7,
        radius    = 1,
    },
}

local DecoCreator = Class(function(self)

end)

function DecoCreator:GetLights()
    return LIGHTS
end

--function DecoCreator:Create(name, build, bank, anim, data)


return
Prefab("window_round", decofn("interior_window", "interior_window_side", "day_loop",          {loopanim=true, decal=true, background=3, dayevents=true,                children={"window_round_light"},          tags={"NOBLOCK","wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("window_round_backwall", decofn("interior_window", "interior_window", "day_loop",               {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_round"}), assets, prefabs),

Prefab("window_round_curtains_nails", decofn("interior_window", "interior_window_side", "day_loop",           {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"NOBLOCK","wallsection", "janela"}, onbuilt=true}), assets, prefabs),
Prefab("window_round_curtains_nails_backwall", decofn("interior_window", "interior_window", "day_loop",       {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_round_curtains_nails"}), assets, prefabs),

Prefab("window_round_burlap", decofn("interior_window_burlap", "interior_window_burlap_side", "day_loop",     {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"NOBLOCK","wallsection","janela"}, onbuilt=true}), assets, prefabs),         
Prefab("window_round_burlap_backwall", decofn("interior_window_burlap", "interior_window_burlap", "day_loop", {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_round_burlap"}), assets, prefabs),                 

Prefab("window_small_peaked", decofn("interior_window_small", "interior_window_small_side", "day_loop",       {loopanim=true, decal=nil, background=3, dayevents=true, curtains=nil, children={"window_round_light"}, tags={"NOBLOCK","wallsection","janela"}, onbuilt=true}), assets, prefabs),         
Prefab("window_small_peaked_backwall", decofn("interior_window_small", "interior_window_small", "day_loop",   {loopanim=true, decal=nil, bckground=3, dayevents=true, curtains=nil, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_small_peaked"}), assets, prefabs),

Prefab("window_large_square", decofn("interior_window_large", "interior_window_side", "day_loop",             {loopanim=true, decal=nil, background=3, dayevents=true, curtains=nil, children={"window_round_light"}, tags={"NOBLOCK","wallsection","janela"}, onbuilt=true}), assets, prefabs),         
Prefab("window_large_square_backwall", decofn("interior_window_large", "interior_window", "day_loop",         {loopanim=true, decal=nil, bckground=3, dayevents=true, curtains=nil, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_large_square"}), assets, prefabs),                 

Prefab("window_tall", decofn("interior_window_tall", "interior_window_tall_side", "day_loop",                 {loopanim=true, decal=nil, background=3, dayevents=true, curtains=nil, children={"window_round_light"}, tags={"NOBLOCK","wallsection","janela"}, onbuilt=true}), assets, prefabs),         
Prefab("window_tall_backwall", decofn("interior_window_tall", "interior_window_tall", "day_loop",             {loopanim=true, decal=nil, bckground=3, dayevents=true, curtains=nil, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_tall"}), assets, prefabs),                 

        --Prefab("window_arcane", "interior_window", "interior_window_side", "day_loop",                        {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"wallsection"}, onbuilt=true}), 
Prefab("window_round_arcane", decofn("window_arcane_build", "interior_window_large_side", "day_loop",         {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"NOBLOCK","wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("window_round_arcane_backwall", decofn("window_arcane_build", "interior_window_large", "day_loop",     {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_round_arcane"}), assets, prefabs),

Prefab("window_small_peaked_curtain", decofn("interior_window_small", "interior_window_side", "day_loop",                      {loopanim=true, decal=nil, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"NOBLOCK","wallsection","janela"}, onbuilt=true}), assets, prefabs),         
Prefab("window_small_peaked_curtain_backwall", decofn("interior_window_small", "interior_window", "day_loop",                  {loopanim=true, decal=nil, background=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_small_peaked_curtain"}), assets, prefabs),                 

Prefab("window_large_square_curtain", decofn("interior_window_large", "interior_window_large_side", "day_loop",     {loopanim=true, decal=nil, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"NOBLOCK","wallsection","janela"}, onbuilt=true}), assets, prefabs),         
Prefab("window_large_square_curtain_backwall", decofn("interior_window_large", "interior_window_large", "day_loop", {loopanim=true, decal=nil, bckground=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_large_square_curtain"}), assets, prefabs),                 

Prefab("window_tall_curtain", decofn("interior_window_tall", "interior_window_tall_side", "day_loop",               {loopanim=true, decal=nil, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"NOBLOCK","wallsection","janela"}, onbuilt=true}), assets, prefabs),         
Prefab("window_tall_curtain_backwall", decofn("interior_window_tall", "interior_window_tall", "day_loop",           {loopanim=true, decal=nil, bckground=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_tall_curtain"}), assets, prefabs),

Prefab("window_round_light", decofn("interior_window", "interior_window_light_side", "day_loop",                    {loopanim=true, decal=true, light=true, dayevents=true, followlight ="natural", windowlight =true, dustzmod=1.3, tags={"NOBLOCK"}}), assets, prefabs),
Prefab("window_round_light_backwall", decofn("interior_window", "interior_window_light", "day_loop",               {loopanim=true, decal=true, light=true, dayevents=true, followlight ="natural", windowlight =true, dustxmod=1.3, tags={"NOBLOCK"}}), assets, prefabs),

Prefab("window_square_weapons", decofn("window_weapons_build", "interior_window_large_side", "day_loop",         {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light"}, tags={"NOBLOCK","wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("window_square_weapons_backwall", decofn("window_weapons_build", "interior_window_large", "day_loop",     {loopanim=true, decal=true, background=3, dayevents=true, curtains=true, children={"window_round_light_backwall"}, tags={"NOBLOCK","wallsection"}, onbuilt=true, recipeproxy="window_square_weapons"}), assets, prefabs),

Prefab("window_sunlight", decofn("interior_window_lightfx", "interior_window_lightfx", "idle_loop_xx",                     {light=true}), assets, prefabs),

Prefab("deco_wallpaper_rip1", decofn("interior_wall_decals", "wall_decals", "1",       {decal=true, tags={"NOBLOCK"}}), assets, prefabs),
Prefab("deco_wallpaper_rip2", decofn("interior_wall_decals", "wall_decals", "2",       {decal=true, tags={"NOBLOCK"}}), assets, prefabs),
Prefab("deco_wallpaper_rip_side1", decofn("interior_wall_decals", "wall_decals", "10", {decal=true, tags={"NOBLOCK"}}), assets, prefabs),
Prefab("deco_wallpaper_rip_side2", decofn("interior_wall_decals", "wall_decals", "11", {decal=true, tags={"NOBLOCK"}, background=3}), assets, prefabs),
Prefab("deco_wallpaper_rip_side3", decofn("interior_wall_decals", "wall_decals", "8",  {tags={"NOBLOCK"}}), assets, prefabs),
Prefab("deco_wallpaper_rip_side4", decofn("interior_wall_decals", "wall_decals", "9",  {tags={"NOBLOCK"}}), assets, prefabs),

Prefab("deco_wood_cornerbeam",  decofn("interior_wall_decals", "wall_decals", "4", {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wood_beam",        decofn("interior_wall_decals", "wall_decals", "3", {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),

Prefab("deco_round_beam",       decofn("interior_wall_decals_accademia", "wall_decals_accademia", "pillar_round_front",  {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_round_cornerbeam", decofn("interior_wall_decals_accademia", "wall_decals_accademia", "pillar_round_corner", {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),

        -- hat store
Prefab("deco_millinery_beam",        decofn("interior_wall_decals_millinery", "wall_decals_millinery", "pillar_front",          {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_millinery_beam2",       decofn("interior_wall_decals_millinery", "wall_decals_millinery", "pillar_boxes_front",    {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_millinery_beam3",       decofn("interior_wall_decals_millinery", "wall_decals_millinery", "pillar_quilted_front",  {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
        
Prefab("deco_millinery_cornerbeam",  decofn("interior_wall_decals_millinery", "wall_decals_millinery", "pillar_corner",         {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_millinery_cornerbeam2", decofn("interior_wall_decals_millinery", "wall_decals_millinery", "pillar_boxes_corner",   {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_millinery_cornerbeam3", decofn("interior_wall_decals_millinery", "wall_decals_millinery", "pillar_quilted_corner", {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
        
Prefab("sewingmachine", decofn("interior_wall_decals_millinery", "wall_decals_millinery", "sewingmachine", {decal=true, tags={"furniture"}, onbuilt=true}), assets, prefabs),
Prefab("worktable", decofn("interior_wall_decals_millinery", "wall_decals_millinery", "worktable", {decal=true, tags={"furniture"}, onbuilt=true}), assets, prefabs),
        
Prefab("picture_1", decofn("interior_wall_decals_millinery", "wall_decals_millinery", "picture1_sidewall", {decal=true}), assets, prefabs),
Prefab("picture_2", decofn("interior_wall_decals_millinery", "wall_decals_millinery", "picture2_sidewall", {decal=true}), assets, prefabs),

Prefab("hat_lamp_side",  decofn("interior_wall_decals_millinery", "wall_decals_millinery", "sconce_sidewall", {decal=true}), assets, prefabs),
Prefab("hat_lamp_front", decofn("interior_wall_decals_millinery", "wall_decals_millinery", "sconce_backwall", {decal=true}), assets, prefabs),

Prefab("hatbox1",  decofn("interior_wall_decals_millinery", "wall_decals_millinery", "hatbox1", {decal=true}), assets, prefabs),
Prefab("hatbox2",  decofn("interior_wall_decals_millinery", "wall_decals_millinery", "hatbox2", {decal=true}), assets, prefabs),

        -- weapon store
Prefab("shield_axes", decofn("interior_wall_decals_weapons", "wall_decals_weapons", "shield_axes", {decal=true}), assets, prefabs),
Prefab("shield_spears", decofn("interior_wall_decals_weapons", "wall_decals_weapons", "shield_spears", {decal=true}), assets, prefabs),
Prefab("spears_sidewall", decofn("interior_wall_decals_weapons", "wall_decals_weapons", "spears_sidewall", {decal=true}), assets, prefabs),
Prefab("shield_sidewall", decofn("interior_wall_decals_weapons", "wall_decals_weapons", "shield_sidewall", {decal=true}), assets, prefabs),

Prefab("deco_weapon_beam1", decofn("interior_wall_decals_weapons", "wall_decals_weapons", "pillar_front", {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_weapon_beam2", decofn("interior_wall_decals_weapons", "wall_decals_weapons", "pillar_corner", {decal=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),

Prefab("wall_light1", decofn("interior_wall_decals", "wall_decals", "6",      {decal=true, light=true}), assets, prefabs),
Prefab("wall_deco_truss1", decofn("interior_wall_decals", "wall_decals", "5", {scale={x=1.12, y=1, z=1}}), assets, prefabs),

Prefab("light_dust_fx", decofn("light_dust_fx", "light_dust_fx", "idle", {loopanim=true, tags={"NOBLOCK"}}), assets, prefabs),

        -- hoofspa
Prefab("deco_marble_beam", decofn("interior_wall_decals_hoofspa", "wall_decals_hoofspa", "pillar",                  {decal=true, loopanim=true, light=DecoCreator:GetLights().SMALL, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_marble_cornerbeam", decofn("interior_wall_decals_hoofspa", "wall_decals_hoofspa", "pillar_corner",     {decal=true, loopanim=true, light=DecoCreator:GetLights().SMALL, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),

Prefab("deco_valence", decofn("interior_wall_decals_hoofspa", "wall_decals_hoofspa",  "vallance_1pc",  {decal=true, background=3}), assets, prefabs),            
Prefab("wall_mirror",  decofn("interior_wall_mirror",         "wall_mirror",          "idle",          {background=3, followlight=true, mirror=true}), assets, prefabs),
Prefab("deco_chaise",  decofn("interior_floor_decor",         "interior_floor_decor", "chaise",        {physics="sofa_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),

Prefab("wall_light_hoofspa", decofn("interior_wall_decals_hoofspa", "wall_decals_hoofspa", "sconce_sidewall",       {light=DecoCreator:GetLights().SMALL}), assets, prefabs),
Prefab("wall_light_hoofspa", decofn("interior_wall_decals_hoofspa", "wall_decals_hoofspa", "sconce_backwall",       {light=DecoCreator:GetLights().SMALL}), assets, prefabs),


  --ruins
     --   Prefab("deco_ruins_fountain", decofn("pig_ruins_well", "pig_ruins_well", "idle_full",                                      {loopanim=true, decal=true, physics="pond_physics", minimapicon="pig_ruins_well.png"}), assets, prefabs),                                                                 

Prefab("deco_ruins_wallcrumble_1", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "2",                 {decal=true, background=1}), assets, prefabs),  
Prefab("deco_ruins_wallcrumble_side_1", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "1",            {decal=true}),  assets, prefabs),
                                                                                                         
--Prefab("deco_ruins_writing1", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "latin_5",                {decal=true, background=1, prefabname="pig_latin_1" }), assets, prefabs),

        -- florist
Prefab("deco_wallpaper_florist_rip1", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "hole_1",     {decal=true, background=1}), assets, prefabs), 
Prefab("deco_wallpaper_florist_rip2", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "hole_2",     {decal=true, background=1}),  assets, prefabs),
Prefab("deco_wallpaper_florist_rip3", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "hole_3",     {decal=true, background=1}),  assets, prefabs),
Prefab("deco_wallpaper_florist_rip4", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "hole_4",     {decal=true, background=1}),  assets, prefabs),

Prefab("deco_wallpaper_florist_side_rip1", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "hole_5_sidewall",    {decal=true}), assets, prefabs),
Prefab("deco_wallpaper_florist_side_rip2", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "hole_6_sidewall",    {decal=true}), assets, prefabs),

Prefab("deco_deli_meatrack", decofn("ceiling_decor", "ceiling_decor", "meatrack_idle",                                             {loopanim=true}), assets, prefabs),
Prefab("deco_deli_basket", decofn("ceiling_decor", "ceiling_decor", "wire_basket_idle",                                            {loopanim=true}), assets, prefabs),

Prefab("deco_general_hangingscale", decofn("ceiling_decor", "ceiling_decor", "scale_idle",                                         {loopanim=true}), assets, prefabs),
Prefab("deco_general_hangingpans", decofn("ceiling_decor", "ceiling_decor", "pans_idle",                                           {loopanim=true}), assets, prefabs),
Prefab("deco_general_trough", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "tiered_trough",              {decal=true}), assets, prefabs),

        --arcane
Prefab("closed_chest", decofn("interior_wall_decals_arcane", "wall_decals_arcane", "chest_closed", {decal=true}), assets, prefabs),
Prefab("open_chest", decofn("interior_wall_decals_arcane", "wall_decals_arcane", "chest_open", {decal=true}), assets, prefabs),
Prefab("containers", decofn("interior_wall_decals_arcane", "wall_decals_arcane", "containers", {decal=true}), assets, prefabs),
Prefab("deco_arcane_bookshelf", decofn("interior_wall_decals_arcane", "wall_decals_arcane", "bookcase_backwall", {decal=true}), assets, prefabs),
Prefab("mirror_backwall", decofn("interior_wall_decals_arcane", "wall_decals_arcane", "mirror_backwall", {decal=true}), assets, prefabs),

        --deli
Prefab("deco_deli_stove_metal_side", decofn("interior_wall_decals_deli", "wall_decals_deli", "stove_sidewall",                               {decal=true}), assets, prefabs),
Prefab("deco_deli_wallpaper_rip_side1", decofn("interior_wall_decals_deli", "wall_decals_deli", "hole_5",                                    {decal=true}), assets, prefabs),
Prefab("deco_deli_wallpaper_rip_side2", decofn("interior_wall_decals_deli", "wall_decals_deli", "hole_6",                                    {decal=true}), assets, prefabs),

Prefab("deco_produce_menu_side", decofn("interior_wall_decals_deli", "wall_decals_deli", "menu_sidewall",                                    {decal=true}), assets, prefabs),
Prefab("deco_produce_menu", decofn("interior_wall_decals_deli", "wall_decals_deli", "menu_front",                                            {decal=true}), assets, prefabs),
Prefab("deco_produce_stone_cornerbeam", decofn("interior_wall_decals_deli", "wall_decals_deli", "pillar_sidewall",                           {decal=true, light=DecoCreator:GetLights().SMALL_YELLOW}), assets, prefabs),-- loopanim=true,

        -- city hall
Prefab("deco_cityhall_picture1", decofn("interior_wall_decals_mayorsoffice", "wall_decals_mayorsoffice", "picture1_sidewall",                {decal=true}), assets, prefabs),
Prefab("deco_cityhall_picture2", decofn("interior_wall_decals_mayorsoffice", "wall_decals_mayorsoffice", "picture2_sidewall",                {decal=true}), assets, prefabs),
Prefab("deco_cityhall_bookshelf", decofn("interior_wall_decals_mayorsoffice", "wall_decals_mayorsoffice", "bookcase_backwall",               {decal=true}), assets, prefabs),
Prefab("deco_cityhall_pillar", decofn("interior_wall_decals_mayorsoffice", "wall_decals_mayorsoffice", "pillar_round_corner",                {decal=true, loopanim=true, light=DecoCreator:GetLights().SMALL}), assets, prefabs),
Prefab("deco_cityhall_cornerbeam", decofn("interior_wall_decals_mayorsoffice", "wall_decals_mayorsoffice", "pillar_flag_corner",             {decal=true, tags={"cornerpost"}}), assets, prefabs),  -- , background=3        
Prefab("window_mayorsoffice", decofn("window_mayorsoffice", "window_mayorsoffice", "day_loop",                                               {loopanim=true, decal=true, background=3, curtains=true}),  assets, prefabs),
Prefab("deco_cityhall_desk", decofn("interior_wall_decals_mayorsoffice", "wall_decals_mayorsoffice", "desk",                                 {light=DecoCreator:GetLights().MED,physics="desk_physics"}), assets, prefabs),
        -- palace        
Prefab("deco_palace_beam_room_tall", decofn("interior_wall_decals_palace", "wall_decals_palace", "pillar_tall",                              {decal=false, physics="post_physics"}), assets, prefabs),
Prefab("deco_palace_beam_room_tall_lights", decofn("interior_wall_decals_palace", "wall_decals_palace", "pillar_tall_lights",                {decal=false, physics="post_physics", light=DecoCreator:GetLights().SMALL}), assets, prefabs),

Prefab("deco_palace_beam_room_tall_corner", decofn("interior_wall_decals_palace", "wall_decals_palace", "pillar_tall_corner",                {decal=false, physics="post_physics"}), assets, prefabs),
Prefab("deco_palace_beam_room_tall_corner_front", decofn("interior_wall_decals_palace", "wall_decals_palace", "pillar_tall_front",           {decal=false, physics="post_physics"}), assets, prefabs),
Prefab("window_palace", decofn("window_palace", "window_palace", "day_loop",                                                                 {loopanim=true, decal=false, background=3, curtains=true}), assets, prefabs), 
Prefab("window_palace_stainglass", decofn("window_palace_stainglass", "window_palace_stainglass", "day_loop",                                {loopanim=true, decal=false, background=3, curtains=true}),  assets, prefabs),

Prefab("deco_palace_banner_big_front", decofn("interior_wall_decals_palace", "wall_decals_palace", "banner_lg_front",                        {decal=false}), assets, prefabs),
Prefab("deco_palace_banner_big_sidewall", decofn("interior_wall_decals_palace", "wall_decals_palace", "banner_lg_sidewall",                  {decal=false}), assets, prefabs),

Prefab("deco_palace_banner_small_front", decofn("interior_wall_decals_palace", "wall_decals_palace", "banner_sml_front",                     {decal=false}), assets, prefabs),
Prefab("deco_palace_banner_small_sidewall", decofn("interior_wall_decals_palace", "wall_decals_palace", "banner_sml_sidewall",               {decal=false}), assets, prefabs),

Prefab("deco_palace_throne", decofn("interior_wall_decals_palace", "wall_decals_palace", "throne",                                           {decal=false, physics="chair_physics"}), assets, prefabs),

Prefab("deco_palace_beam_room_short_corner_lights", decofn("interior_wall_decals_palace", "wall_decals_palace", "pillar_lights_corner",      {decal=false, physics="post_physics", light=DecoCreator:GetLights().SMALL}), assets, prefabs),
Prefab("deco_palace_beam_room_short_corner_front_lights", decofn("interior_wall_decals_palace", "wall_decals_palace", "pillar_lights_front", {decal=false, physics="post_physics", light=DecoCreator:GetLights().SMALL}), assets, prefabs),
Prefab("deco_palace_beam_room_short", decofn("interior_wall_decals_palace", "wall_decals_palace", "pillar",                                  {decal=false, physics="post_physics"}), assets, prefabs),

Prefab("deco_displaycase", decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "displayshelf_corner",                      {decal=false, physics="post_physics"}), assets, prefabs),
Prefab("deco_palace_plant", decofn("interior_wall_decals_palace", "wall_decals_palace", "plant",                                             {decal=false}), assets, prefabs),
--------------------------deco bank
Prefab("deco_bank_clock1_side", decofn( "interior_decor", "interior_decor", "clock1_sidewall",                               {decal=true}), assets, prefabs),
Prefab("deco_bank_clock2_side", decofn( "interior_decor", "interior_decor", "clock2_sidewall",                               {decal=true}), assets, prefabs),
Prefab("deco_bank_clock3_side", decofn( "interior_decor", "interior_decor", "clock3_sidewall",                               {decal=true}), assets, prefabs),
Prefab("deco_bank_marble_beam", decofn( "interior_pillar", "interior_pillar", "pillar_bank_front",                                            {decal=true, loopanim=true, light=DecoCreator:GetLights().SMALL, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_bank_marble_cornerbeam", decofn( "interior_pillar", "interior_pillar", "pillar_bank_corner",                                     {decal=true, loopanim=true, light=DecoCreator:GetLights().SMALL, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),
Prefab("deco_bank_vault", decofn( "interior_unique", "interior_unique", "vault",                                               {decal=true}), assets, prefabs),
---------deco_wall_ornament
Prefab("deco_wallornament_photo",	decofn("interior_wallornament", "interior_wallornament", "photo",				{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_fulllength_mirror",	decofn("interior_wallornament", "interior_wallornament", "fulllength_mirror",	{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_embroidery_hoop",		decofn("interior_wallornament", "interior_wallornament", "embroidery_hoop",	{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_mosaic",				decofn("interior_wallornament", "interior_wallornament", "mosaic",				{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_wreath",				decofn("interior_wallornament", "interior_wallornament", "wreath",				{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_axe",					decofn("interior_wallornament", "interior_wallornament", "axe",				{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_hunt",				decofn("interior_wallornament", "interior_wallornament", "hunt",				{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_periodic_table",		decofn("interior_wallornament", "interior_wallornament", "periodic_table",		{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_gears_art",			decofn("interior_wallornament", "interior_wallornament", "gears_art",			{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_cape",				decofn("interior_wallornament", "interior_wallornament", "cape",				{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_no_smoking",			decofn("interior_wallornament", "interior_wallornament", "no_smoking",			{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_wallornament_black_cat",			decofn("interior_wallornament", "interior_wallornament", "black_cat",			{decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),

----------------------deco_table--------------
Prefab("deco_table_crate",    decofn("interior_table", "interior_table", "table_crate",  {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_table_raw",      decofn("interior_table", "interior_table", "table_raw",    {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_table_diy",      decofn("interior_table", "interior_table", "table_diy",    {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_table_round",    decofn("interior_table", "interior_table", "table_round",  {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_table_banker",   decofn("interior_table", "interior_table", "table_banker", {physics="sofa_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_table_chess",    decofn("interior_table", "interior_table", "table_chess",  {physics="sofa_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),

MakePlacer("deco_chaise_placer",               "interior_floor_decor", "interior_floor_decor", "chaise"),
MakePlacer("deco_lamp_hoofspa_placer",         "interior_floor_decor", "interior_floor_decor", "lamp"),
MakePlacer("deco_plantholder_marble_placer",   "interior_floor_decor", "interior_floor_decor", "plant"),
MakePlacer("deco_table_banker_placer",         "interior_table", "interior_table", "table_banker"),
MakePlacer("deco_table_round_placer",          "interior_table", "interior_table", "table_round"),
MakePlacer("deco_table_diy_placer",            "interior_table", "interior_table", "table_diy"),
MakePlacer("deco_table_raw_placer",            "interior_table", "interior_table", "table_raw"),
MakePlacer("deco_table_crate_placer",          "interior_table", "interior_table", "table_crate"),
MakePlacer("deco_table_chess_placer",          "interior_table", "interior_table", "table_chess")
