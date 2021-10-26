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
        local interiorSpawner = TheWorld.components.interiorspawner 
        if interiorSpawner.current_interior then
            local originpt = interiorSpawner:getSpawnOrigin()
            local x, y, z = inst.Transform:GetWorldPosition()
            local dropdir = Vector3(originpt.x - x, 0.0, originpt.z - z):GetNormalized()
            inst.components.lootdropper.dropdir = dropdir
            inst.components.lootdropper:DropLoot()
        end
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

    if inst.childrenspawned then
        data.childrenspawned = inst.childrenspawned 
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

    data.children = {}
    if inst.decochildrenToRemove then
        for i, child in ipairs(inst.decochildrenToRemove) do
            table.insert(data.children, child.GUID)
            table.insert(references, child.GUID)
        end
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
    if data.childrenspawned then
        inst.childrenspawned = data.childrenspawned
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

        inst.decochildrenToRemove = {}
        if data.children then
            for i,child in ipairs(data.children) do
                local childent = ents[child]
                if childent then
                    table.insert(inst.decochildrenToRemove, childent.entity)
                end
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
        if not inst:IsInLimbo() then inst.Light:Enable(true) end
        inst.components.lighttweener:StartTween(nil, lights.day.radius, lights.day.intensity, lights.day.falloff, {lights.day.color[1],lights.day.color[2],lights.day.color[3]}, 2)
    end,

    dusk = function(inst) 
        local lights = inst.lightsetting
        if not inst:IsInLimbo() then inst.Light:Enable(true) end       
        inst.components.lighttweener:StartTween(nil, lights.dusk.radius, lights.dusk.intensity, lights.dusk.falloff, {lights.dusk.color[1],lights.dusk.color[2],lights.dusk.color[3]}, 2)
    end,

    night = function(inst) 
        local lights = inst.lightsetting
        if TheWorld.state.moonphase == "full" then
            inst.components.lighttweener:StartTween(nil, lights.full.radius, lights.full.intensity, lights.full.falloff, {lights.full.color[1],lights.full.color[2],lights.full.color[3]}, 4)
        else
            inst.components.lighttweener:StartTween(nil, 0, 0, 1, {0, 0, 0}, 6, turnoff)
        end    
    end,
}

local function timechange(inst)    
    if TheWorld.state.isday then
        inst.AnimState:PlayAnimation("to_day")
        inst.AnimState:PushAnimation("day_loop", true)
--        if inst.Light then
 --           phasefunctions["day"](inst)
  --      end
    elseif TheWorld.state.isnight then
       inst.AnimState:PlayAnimation("to_night")
        inst.AnimState:PushAnimation("night_loop", true)
--        if inst.Light then
--            phasefunctions["night"](inst)
--        end
    elseif TheWorld.state.isdusk then
        inst.AnimState:PlayAnimation("to_dusk")
        inst.AnimState:PushAnimation("dusk_loop", true)
--        if inst.Light then
 --           phasefunctions["dusk"](inst)
 --       end
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

        if data.children then
            if not inst.childrenspawned then
                for i, child in ipairs(data.children) do
                    local childprop = SpawnPrefab(child)
                    local pt = Vector3(inst.Transform:GetWorldPosition())
                    childprop.Transform:SetPosition(pt.x ,pt.y, pt.z)
                    childprop.Transform:SetRotation(inst.Transform:GetRotation())
                    if not inst.decochildrenToRemove then
                        inst.decochildrenToRemove = {}
                    end       
                    table.insert(inst.decochildrenToRemove,childprop)
                end
            end
            inst.childrenspawned = true
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
                MakeInteriorPhysics(inst, 1.3, 1, 0.2)
            elseif physics == "sofa_physics_vert" then
                MakeInteriorPhysics(inst, 0.4, 1, 1.3)                
            elseif physics == "chair_physics" then
                MakeInteriorPhysics(inst, 1, 1, 1)
            elseif physics == "desk_physics" then
                MakeInteriorPhysics(inst, 2, 1, 1)
            elseif physics == "tree_physics" then
				MakeObstaclePhysics(inst, 4)
                inst:AddTag("blocker")
 --               inst.entity:AddPhysics()
 --               inst.Physics:SetMass(0)
 --               inst.Physics:SetCylinder(4.7, 4.0)
 --               inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
 --               inst.Physics:ClearCollisionMask()
 --               inst.Physics:CollidesWith(COLLISION.ITEMS)
 --               inst.Physics:CollidesWith(COLLISION.CHARACTERS)	
				
				
				
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
		if scale == "alto" then anim:SetScale(1.5, 2.5, 1.5) else
            anim:SetScale(scale.x, scale.y, scale.z)
		end
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
                inst:DoTaskInTime(0, function()
--[[
				if not inst.sunraysspawned then
                        inst.swinglight = SpawnPrefab("swinglightobject")
                        inst.swinglight.setLightType(inst.swinglight, followlight)
                        if windowlight then
                            inst.swinglight.setListenEvents(inst.swinglight)                           
                        end                        
                        local follower = inst.swinglight.entity:AddFollower()
                        follower:FollowSymbol( inst.GUID, "light_circle", 0, 0, 0 )
                        inst.swinglight.followobject =  {GUID=inst.GUID, symbol="light_circle", x=0, y=0, z=0}
                        inst.sunraysspawned = true
                    end
]]
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
                            print("QUAKE: CAVE IN!!!")
                        else
                           TheWorld.components.quaker_interior:ForceQuake("pillarshake", inst)
                           print("QUAKE: pillar!!!")
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
    Asset("ANIM", "anim/interior_wall_decals_antcave.zip"),
    Asset("ANIM", "anim/interior_wall_decals_batcave.zip"),
    Asset("ANIM", "anim/interior_wall_decals_ruins.zip"),
    Asset("ANIM", "anim/interior_wall_decals_ruins_blue.zip"),
    Asset("ANIM", "anim/interior_wall_grottogub_cave.zip"),
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

return
        --BAT CAVE
Prefab("deco_cave_beam_room", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "pillar_front",                  {decal=true, physics="big_post_physics", workable=true, minimapicon="vamp_cave_pillar.png"}),  assets, prefabs),
Prefab("deco_cave_cornerbeam", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "pillar_corner",                {decal=true, background=3, tags={"cornerpost"}}), assets, prefabs),
Prefab("deco_cave_pillar_side", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "pillar_sidewall",             {decal=true}), assets, prefabs),
Prefab("deco_cave_ceiling_trim", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "ceiling_trim_1"), assets, prefabs),
Prefab("deco_cave_ceiling_trim_2", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "ceiling_trim_2",           {decal=true, background=3}), assets, prefabs),
Prefab("deco_cave_ceiling_trim_3", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "ceiling_trim_3"), assets, prefabs),   
Prefab("deco_cave_floor_trim", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "floor_trim_1",                 {decal=true, background=3}), assets, prefabs),
Prefab("deco_cave_floor_trim_2", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "floor_trim_2",               {decal=true, background=3}), assets, prefabs),
Prefab("deco_cave_floor_trim_front", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "floor_trim_3"), assets, prefabs),
Prefab("deco_cave_stalactite", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "stalactite"), assets, prefabs),
Prefab("deco_cave_bat_burrow", decofn("interior_wall_decals_batcave", "interior_wall_decals_cave", "bat_burrow",                   {decal=true, physics="pond_physics", prefabname="deco_cave_bat_burrow", minimapicon="vamp_cave_burrow.png"}), assets, prefabs),


Prefab("grotto_pillar_bug", decofn("interior_wall_grottogub_cave", "interior_wall_grottogub_cave", "pillar_front",               {decal=true, physics="big_post_physics", workable=true, minimapicon="grotto_pillar_bug.png", scale = "alto"}), assets, prefabs), 

        --ANT HIVE
Prefab("deco_hive_beam_room", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "pillar_front",               {decal=true, physics="big_post_physics", workable=true, minimapicon="vamp_cave_pillar.png"}), assets, prefabs), 
Prefab("deco_hive_cornerbeam", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "pillar_corner",             {decal=true, background=3, tags={"cornerpost"}}), assets, prefabs),
Prefab("deco_hive_pillar_side", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "pillar_sidewall",          {decal=true}), assets, prefabs),
Prefab("deco_hive_floor_trim", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "floor_trim_1"),  assets, prefabs),
Prefab("deco_hive_beam_broken_room", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "pillar_front_crumble_idle",           {decal=true, physics="big_post_physics", minimapicon="vamp_cave_pillar.png"}),  assets, prefabs),
Prefab("deco_hive_stalactite", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "stalactite"), assets, prefabs),
Prefab("deco_hive_broken_pillar", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "pillar_broken"), assets, prefabs),
Prefab("deco_hive_debris", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "rock_debris"), assets, prefabs),      

Prefab("deco_cave_honey_drip_1", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "honey_wall_1",                      {decal=true, background=3}), assets, prefabs),
Prefab("deco_cave_ceiling_drip_2", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "honey_floor_1",                   {decal=true, background=3}), assets, prefabs),
Prefab("deco_cave_honey_drip_side_1", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "honey_wall_2",                 {decal=true, background=3}), assets, prefabs),
Prefab("deco_cave_honey_drip_side_2", decofn("interior_wall_decals_antcave", "interior_wall_decals_antcave", "honey_floor_2",                {decal=true, background=3}), assets, prefabs),


       -- PIG RUINS
Prefab("deco_ruins_crack_roots1", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "hole_1",            {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_crack_roots2", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "hole_2",            {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_crack_roots3", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "roots_1",           {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_crack_roots4", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "roots_2",           {decal=true, background=1}), assets, prefabs),

Prefab("deco_ruins_roots1", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "vines_1",                 {decal=true, background=2}), assets, prefabs),
Prefab("deco_ruins_roots2", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "vines_2",                 {decal=true, background=2}), assets, prefabs),
Prefab("deco_ruins_roots3", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "vines_3",                 {decal=true, background=2}), assets, prefabs),

Prefab("deco_ruins_pigking_relief", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "relief_king",     {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigman_relief2", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "relief_happy",    {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigqueen_relief", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "relief_queen",   {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigman_relief1", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "relief_confused", {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigman_relief3", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "relief_surprise", {decal=true, background=1}), assets, prefabs),

Prefab("deco_ruins_pigman_relief_side", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "relief_sidewall",  {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigman_relief4", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "relief_head",        {decal=true, background=1}), assets, prefabs),

Prefab("deco_ruins_cornerbeam", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "pillar_corner",          {decal=true, background=3, tags={"cornerpost"}}), assets, prefabs),
Prefab("deco_ruins_cornerbeam_heavy", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "pillar_corner_lg", {decal=true, background=3, tags={"cornerpost"}}), assets, prefabs), 

Prefab("deco_ruins_corner_tree", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "giant_roots",         {decal=true, background=3, physics="tree_physics"}), assets, prefabs),  -- , minimapicon="pig_ruins_tree_roots_int.png"
Prefab("deco_ruins_beam_heavy", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "pillar_side_lg",       {decal=true, background=3}), assets, prefabs), 
Prefab("deco_ruins_beam", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "pillar_front",               {decal=true}), assets, prefabs), 

Prefab("deco_ruins_beam_room", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "pillar_front",          {decal=true, physics="post_physics", workable=true, minimapicon="pig_ruins_pillar.png"}), assets, prefabs), 
Prefab("deco_ruins_beam_room_broken", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "pillar_broken",  {decal=true, physics="post_physics", minimapicon="pig_ruins_pillar.png"}), assets, prefabs), 
Prefab("deco_ruins_beam_broken", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "pillar_broken",       {decal=true, background=3}), assets, prefabs), 
Prefab("deco_ruins_wallstrut", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "support_side",          {decal=true}), assets, prefabs),
Prefab("deco_ruins_walltorch", decofn("interior_wall_decals_ruins", "interior_wall_decals_ruins", "sconce_metal_sidewall", {decal=true, background=3}),  assets, prefabs),

                    -- THE BLUE RUINS ART
Prefab("deco_ruins_pigking_relief_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "relief_king",     {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigman_relief2_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "relief_happy",    {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigqueen_relief_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "relief_queen",   {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigman_relief1_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "relief_confused", {decal=true, background=1}), assets, prefabs),
Prefab("deco_ruins_pigman_relief3_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "relief_surprise", {decal=true, background=1}), assets, prefabs),

Prefab("deco_ruins_pigman_relief_side_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "relief_sidewall",  {decal=true, background=1}),  assets, prefabs),

Prefab("deco_ruins_pigman_relief4_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "relief_head",        {decal=true, background=1}),  assets, prefabs),

Prefab("deco_ruins_cornerbeam_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "pillar_corner",          {decal=true, background=3, tags={"cornerpost"}}),  assets, prefabs),
Prefab("deco_ruins_cornerbeam_heavy_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "pillar_corner_lg", {decal=true, background=3, tags={"cornerpost"}}),  assets, prefabs),
   
Prefab("deco_ruins_beam_heavy_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "pillar_side_lg",       {decal=true, background=3}),  assets, prefabs),
Prefab("deco_ruins_beam_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "pillar_front",               {decal=true}),  assets, prefabs),

Prefab("deco_ruins_beam_room_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "pillar_front",          {decal=true, physics="post_physics", workable=true, minimapicon="pig_ruins_pillar.png"}), assets, prefabs), 
Prefab("deco_ruins_beam_room_broken_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "pillar_broken",  {decal=true, physics="post_physics", minimapicon="pig_ruins_pillar.png"}), assets, prefabs), 
Prefab("deco_ruins_beam_broken_blue", decofn("interior_wall_decals_ruins_blue", "interior_wall_decals_ruins", "pillar_broken",       {decal=true, background=3}), assets, prefabs)
