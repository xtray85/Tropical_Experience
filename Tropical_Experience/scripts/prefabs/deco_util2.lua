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
    if inst.textura then
        data.textura = inst.textura
    end	
    if inst.textura2 then
        data.textura2 = inst.textura2
    end		
    return references
end

local function onload(inst, data)
    if data and data.textura and data.textura == "pillar_square_corner" then
	inst.AnimState:SetBank("wall_decals_accademia")
	inst.AnimState:SetBuild("interior_wall_decals_accademia")
	inst.AnimState:PlayAnimation(data.textura, true)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)	
    inst.textura = data.textura
    end	
	
    if data and data.textura2 and data.textura2 == "pillar_square_front" then
	inst.AnimState:SetBank("wall_decals_accademia")
	inst.AnimState:SetBuild("interior_wall_decals_accademia")
	inst.AnimState:PlayAnimation(data.textura2, true)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)	
    inst.textura2 = data.textura2
    end	
	
	
    if data and data.textura and data.textura == "pillar_corner" then
	inst.AnimState:SetBank("wall_decals_millinery")
	inst.AnimState:SetBuild("interior_wall_decals_millinery")
	inst.AnimState:PlayAnimation(data.textura, true)	
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)	
    inst.textura = data.textura
    end	
	
    if data and data.textura2 and data.textura2 == "pillar_front" then
	inst.AnimState:SetBank("wall_decals_millinery")
	inst.AnimState:SetBuild("interior_wall_decals_millinery")
	inst.AnimState:PlayAnimation(data.textura2, true)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)	
    inst.textura2 = data.textura2
    end	

    if data and data.textura and data.textura == "pillar_round_corner" then
	inst.AnimState:SetBank("wall_decals_accademia")
	inst.AnimState:SetBuild("interior_wall_decals_accademia")
	inst.AnimState:PlayAnimation(data.textura, true)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)	
    inst.textura = data.textura
    end	
	
    if data and data.textura2 and data.textura2 == "pillar_round_front" then
	inst.AnimState:SetBank("wall_decals_accademia")
	inst.AnimState:SetBuild("interior_wall_decals_accademia")
	inst.AnimState:PlayAnimation(data.textura2, true)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)		
    inst.textura2 = data.textura2
    end	

    if data and data.textura and data.textura == "pillar_corner2" then
	inst.AnimState:SetBank("wall_decals_hoofspa")
	inst.AnimState:SetBuild("interior_wall_decals_hoofspa")	
	inst.AnimState:PlayAnimation("pillar_corner", true)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)		
    inst.textura = data.textura
    end	
	
    if data and data.textura2 and data.textura2 == "pillar" then
	inst.AnimState:SetBank("wall_decals_hoofspa")
	inst.AnimState:SetBuild("interior_wall_decals_hoofspa")	
	inst.AnimState:PlayAnimation(data.textura2, true)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetRadius(2)	
    inst.textura2 = data.textura2
    end		


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
		inst:AddTag("liberado")

        if data.children then
--            if not inst.childrenspawned then
			inst:DoTaskInTime(1, function(inst)
                for i, child in ipairs(data.children) do
                    local childprop = SpawnPrefab(child)
					local x, y, z = inst.Transform:GetWorldPosition()
                    childprop.Transform:SetPosition(x ,y, z)
                    childprop.Transform:SetRotation(inst.Transform:GetRotation())
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
                MakeInteriorPhysics(inst, 1.3, 1, 0.2)
            elseif physics == "sofa_physics_vert" then
                MakeInteriorPhysics(inst, 0.4, 1, 1.3)                
            elseif physics == "chair_physics" then
                MakeInteriorPhysics(inst, 1, 1, 1)
            elseif physics == "desk_physics" then
                MakeInteriorPhysics(inst, 2, 1, 1)
            elseif physics == "tree_physics" then
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
    Asset("ANIM", "anim/ceiling_lights.zip"),
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
    Asset("ANIM", "anim/interior_wall_decals_batcave.zip"),
    Asset("ANIM", "anim/interior_wall_decals_deli.zip"),
    Asset("ANIM", "anim/interior_wall_decals_florist.zip"),
    Asset("ANIM", "anim/interior_wall_decals_mayorsoffice.zip"),
    Asset("ANIM", "anim/interior_wall_decals_palace.zip"),
    Asset("ANIM", "anim/interior_wall_decals_ruins.zip"),
    Asset("ANIM", "anim/interior_wall_decals_ruins_blue.zip"),    
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
	
    NONE =
    { 
        intensity = 0,
        color     = {97/255, 197/255, 50/255},
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
-------------------deco_plantholder------
Prefab("deco_plantholder_basic",          decofn("interior_plant", "interior_plant", "plant_basic",          {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_wip",            decofn("interior_plant", "interior_plant", "plant_wip",            {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_fancy",          decofn("interior_plant", "interior_plant", "plant_fancy",          {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_bonsai",         decofn("interior_plant", "interior_plant", "plant_bonsai",         {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_dishgarden",     decofn("interior_plant", "interior_plant", "plant_dishgarden",     {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_philodendron",   decofn("interior_plant", "interior_plant", "plant_philodendron",   {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_orchid",         decofn("interior_plant", "interior_plant", "plant_orchid",         {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_draceana",       decofn("interior_plant", "interior_plant", "plant_draceana",       {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_xerographica",   decofn("interior_plant", "interior_plant", "plant_xerographica",   {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_birdcage",       decofn("interior_plant", "interior_plant", "plant_birdcage",       {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_palm",           decofn("interior_plant", "interior_plant", "plant_palm",           {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_zz",             decofn("interior_plant", "interior_plant", "plant_zz",             {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_fernstand",      decofn("interior_plant", "interior_plant", "plant_fernstand",      {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_fern",           decofn("interior_plant", "interior_plant", "plant_fern",           {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_terrarium",      decofn("interior_plant", "interior_plant", "plant_terrarium",      {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_plantpet",       decofn("interior_plant", "interior_plant", "plant_plantpet",       {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_traps",          decofn("interior_plant", "interior_plant", "plant_traps",          {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_pitchers",       decofn("interior_plant", "interior_plant", "plant_pitchers",       {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_plantholder_marble",         decofn("interior_floor_decor", "interior_floor_decor", "plant",    {tags={"furniture"}, onbuilt=true }), assets, prefabs),


MakePlacer("deco_plantholder_basic_placer",          "interior_plant", "interior_plant", "plant_basic"),
MakePlacer("deco_plantholder_wip_placer",            "interior_plant", "interior_plant", "plant_wip"),
MakePlacer("deco_plantholder_fancy_placer",          "interior_plant", "interior_plant", "plant_fancy"),
MakePlacer("deco_plantholder_bonsai_placer",         "interior_plant", "interior_plant", "plant_bonsai"),
MakePlacer("deco_plantholder_dishgarden_placer",     "interior_plant", "interior_plant", "plant_dishgarden"),
MakePlacer("deco_plantholder_philodendron_placer",   "interior_plant", "interior_plant", "plant_philodendron"),
MakePlacer("deco_plantholder_orchid_placer",         "interior_plant", "interior_plant", "plant_orchid"),
MakePlacer("deco_plantholder_draceana_placer",       "interior_plant", "interior_plant", "plant_draceana"),
MakePlacer("deco_plantholder_xerographica_placer",   "interior_plant", "interior_plant", "plant_xerographica"),
MakePlacer("deco_plantholder_birdcage_placer",       "interior_plant", "interior_plant", "plant_birdcage"),
MakePlacer("deco_plantholder_palm_placer",           "interior_plant", "interior_plant", "plant_palm"),
MakePlacer("deco_plantholder_zz_placer",             "interior_plant", "interior_plant", "plant_zz"),
MakePlacer("deco_plantholder_fernstand_placer",      "interior_plant", "interior_plant", "plant_fernstand"),
MakePlacer("deco_plantholder_fern_placer",           "interior_plant", "interior_plant", "plant_fern"),
MakePlacer("deco_plantholder_terrarium_placer",      "interior_plant", "interior_plant", "plant_terrarium"),
MakePlacer("deco_plantholder_plantpet_placer",       "interior_plant", "interior_plant", "plant_plantpet"),
MakePlacer("deco_plantholder_traps_placer",          "interior_plant", "interior_plant", "plant_traps"),
MakePlacer("deco_plantholder_pitchers_placer",       "interior_plant", "interior_plant", "plant_pitchers"),
MakePlacer("deco_plantholder_winterfeasttreeofsadness_placer",   "interior_plant", "interior_plant", "plant_winterfeasttreeofsadness"),
MakePlacer("deco_plantholder_winterfeasttree_placer",            "interior_floorlamp", "interior_floorlamp", "festivetree_idle"),












--------------deco academy-------
Prefab("deco_accademy_barrier",           decofn("interior_wall_decals_accademia", "wall_decals_accademia", "velvetrope_backwall",   {physics="sofa_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_barrier_vert",      decofn("interior_wall_decals_accademia", "wall_decals_accademia", "velvetrope_sidewall",   {physics="sofa_physics_vert", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_vause",             decofn("interior_wall_decals_accademia", "wall_decals_accademia", "sculpture_vase",        {tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_graniteblock",      decofn("interior_wall_decals_accademia", "wall_decals_accademia", "stoneblock",            {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_potterywheel_urn",  decofn("interior_wall_decals_accademia", "wall_decals_accademia", "pottingwheel_urn",      {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_potterywheel",      decofn("interior_wall_decals_accademia", "wall_decals_accademia", "pottingwheel",          {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_anvil",             decofn("interior_wall_decals_accademia", "wall_decals_accademia", "anvil",                 {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_table_books",       decofn("interior_wall_decals_accademia", "wall_decals_accademia", "table_books",           {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_accademy_cornerbeam",        decofn("interior_wall_decals_accademia", "wall_decals_accademia", "pillar_square_front",   {decal=false, loopanim=true, light=DecoCreator:GetLights().SMALL, tags={"cornerpost"}, onbuilt=true}), assets, prefabs),    
Prefab("deco_accademy_beam",              decofn("interior_wall_decals_accademia", "wall_decals_accademia", "pillar_square_corner",  {decal=false, loopanim=true, light=DecoCreator:GetLights().SMALL}), assets, prefabs),
Prefab("deco_accademy_pig_king_painting", decofn("interior_wall_decals_accademia", "wall_decals_accademia", "picture_backwall",      {decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
		------------deco_antiquities----------------
Prefab("deco_antiquities_screamcatcher",      decofn("ceiling_decor", "ceiling_decor", "scream_catcher_idle",                            {loopanim=true}),  assets, prefabs),
Prefab("deco_antiquities_windchime",          decofn("ceiling_decor", "ceiling_decor", "windchime_idle",                                 {loopanim=true}), assets, prefabs),
Prefab("deco_antiquities_cornerbeam",         decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "pillar_corner",     {decal=true, light=DecoCreator:GetLights().NONE, background=3, tags={"NOBLOCK","cornerpost","poste"}}), assets, prefabs),
Prefab("deco_antiquities_cornerbeam2",        decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "pillar_sidewall",   {decal=true, light=DecoCreator:GetLights().NONE, tags={"NOBLOCK","cornerpost","postef"}}), assets, prefabs),
Prefab("deco_antiquities_endbeam",            decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "pillar_front",      {decal=true}), assets, prefabs),
Prefab("deco_antiquities_beefalo_side",       decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "beefalo_sidewall",  {decal=true, tags={"NOBLOCK"}}), assets, prefabs),
Prefab("deco_antiquities_beefalo",            decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "beefalo_front",     {decal=true, tags={"wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_antiquities_wallfish_side",      decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "fish_sidewall",     {decal=true, background=3, tags={"NOBLOCK"} }), assets, prefabs),
--Prefab("deco_antiquities_wallfish",           decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "fish_front",        {decal=true, background=3, tags={"NOBLOCK","wallsection"}, onbuilt=true}), assets, prefabs),
Prefab("deco_antiquities_pallet_sidewall",    decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "pallet_sidewall",   {decal=true, background=3}), assets, prefabs),
Prefab("deco_antiquities_wallpaper_rip1",     decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "hole_1",            {decal=true, background=3}), assets, prefabs),
Prefab("deco_antiquities_wallpaper_rip2",     decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "hole_2",            {decal=true, background=3}), assets, prefabs),
Prefab("deco_antiquities_wallpaper_rip3",     decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "hole_3",            {decal=true, background=3}), assets, prefabs),
Prefab("deco_antiquities_walllight",          decofn("interior_wall_decals_antiquities", "wall_decals_antiquities", "sconce_sidewall1",  {decal=true, light=DecoCreator:GetLights().SMALL, tags={"NOBLOCK"}}), assets, prefabs),


		-------------------deco_chair-----------------------
Prefab("deco_chair_classic",  decofn("interior_chair", "interior_chair", "chair_classic",    {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_corner",   decofn("interior_chair", "interior_chair", "chair_corner",     {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_bench",    decofn("interior_chair", "interior_chair", "chair_bench",      {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_horned",   decofn("interior_chair", "interior_chair", "chair_horned",     {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_footrest", decofn("interior_chair", "interior_chair", "chair_footrest",   {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_lounge",   decofn("interior_chair", "interior_chair", "chair_lounge",     {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_massager", decofn("interior_chair", "interior_chair", "chair_massager",   {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_stuffed",  decofn("interior_chair", "interior_chair", "chair_stuffed",    {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_rocking",  decofn("interior_chair", "interior_chair", "chair_rocking",    {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),
Prefab("deco_chair_ottoman",  decofn("interior_chair", "interior_chair", "chair_ottoman",    {physics="chair_physics", tags={"furniture"}, decal=true, onbuilt=true}), assets, prefabs),

MakePlacer("chair_classic_placer",          "interior_chair", "interior_chair", "chair_classic"),
MakePlacer("chair_corner_placer",           "interior_chair", "interior_chair", "chair_corner"),
MakePlacer("chair_bench_placer",            "interior_chair", "interior_chair", "chair_bench"),
MakePlacer("chair_horned_placer",           "interior_chair", "interior_chair", "chair_horned"),
MakePlacer("chair_footrest_placer",         "interior_chair", "interior_chair", "chair_footrest"),
MakePlacer("chair_lounge_placer",           "interior_chair", "interior_chair", "chair_lounge"),
MakePlacer("chair_massager_placer",         "interior_chair", "interior_chair", "chair_massager"),
MakePlacer("chair_stuffed_placer",          "interior_chair", "interior_chair", "chair_stuffed"),
MakePlacer("chair_rocking_placer",          "interior_chair", "interior_chair", "chair_rocking"),
MakePlacer("chair_ottoman_placer",          "interior_chair", "interior_chair", "chair_ottoman"),






------------------------------deco_florist----------------
Prefab("deco_florist_vines1", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "vines_1", {decal=true, background=2}), assets, prefabs),
Prefab("deco_florist_vines2", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "vines_2", {decal=true, background=2}), assets, prefabs),
Prefab("deco_florist_vines3", decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "vines_3", {decal=true, background=2}), assets, prefabs),
Prefab("deco_florist_hangingplant1", decofn("ceiling_decor", "ceiling_decor", "plant1_idle", {loopanim=true}), assets, prefabs),
Prefab("deco_florist_hangingplant2", decofn("ceiling_decor", "ceiling_decor", "plant2_idle", {loopanim=true}), assets, prefabs),
Prefab("deco_florist_plantholder",    decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "plantstand"), assets, prefabs),
Prefab("deco_florist_latice_front",   decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "lattice_front"), assets, prefabs),
Prefab("deco_florist_latice_side",    decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "lattice_sidewall", {decal=true}), assets, prefabs),
Prefab("deco_florist_pillar_front",   decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "pillar_front", {decal=true}), assets, prefabs),
Prefab("deco_florist_pillar_side",    decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "pillar_sidewall",      {decal=true}), assets, prefabs),
Prefab("deco_florist_picture",        decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "pictureframe_front",   {decal=true, background=2}), assets, prefabs),
Prefab("deco_florist_cagedplant",     decofn("interior_wall_decals_florist", "interior_wall_decals_florist", "cageplant_front",      {decal=true, background=2}), assets, prefabs),

        -- Tinker
Prefab("deco_tinker_beam", 			decofn("interior_pillar", "interior_pillar", "basic_front",                          {decal=true, loopanim=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),  
Prefab("deco_tinker_cornerbeam", 	decofn("interior_pillar", "interior_pillar", "basic_corner",                         {decal=true, loopanim=true, tags={"NOBLOCK","cornerpost"}, onbuilt=true}), assets, prefabs),  
Prefab("deco_rollholder",  			decofn("interior_floor_decor",         "interior_floor_decor", "rollholder",         {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),        
Prefab("deco_rollholder_front",  	decofn("interior_floor_decor",   "interior_floor_decor", "rollholder_front",         {physics="sofa_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_filecabinet",  		decofn("interior_floor_decor",         "interior_floor_decor", "filecabinet",        {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_rollchest",  			decofn("interior_floor_decor",         "interior_floor_decor", "chest_open",          {physics="post_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_worktable",  			decofn("interior_floor_decor",         "interior_floor_decor", "worktable",            {physics="sofa_physics", tags={"furniture"}, onbuilt=true }), assets, prefabs),


------------deco_lamp
Prefab("deco_lamp_fringe",        decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_fringe",         {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_stainglass",    decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_stainglass",     {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_downbridge",    decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_downbridge",     {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_2embroidered",  decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_2embroidered",   {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_ceramic",       decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_ceramic",        {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_glass",         decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_glass",          {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_2fringes",      decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_2fringes",       {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_candelabra",    decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_candelabra",     {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_elizabethan",   decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_elizabethan",    {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_gothic",        decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_gothic",         {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_orb",           decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_orb",            {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_bellshade",     decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_bellshade",      {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_crystals",      decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_crystals",       {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_upturn",        decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_upturn",         {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_2upturns",      decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_2upturns",       {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_spool",         decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_spool",          {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_edison",        decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_edison",         {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_adjustable",    decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_adjustable",     {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_rightangles",   decofn("interior_floorlamp", "interior_floorlamp", "floorlamp_rightangles",    {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),
Prefab("deco_lamp_hoofspa",       decofn("interior_floor_decor" ,"interior_floor_decor", "lamp",                 {physics="post_physics", light=DecoCreator:GetLights().SMALL, tags={"furniture"}, onbuilt=true }), assets, prefabs),

MakePlacer("deco_lamp_fringe_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_fringe"),
MakePlacer("deco_lamp_stainglass_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_stainglass"), 
MakePlacer("deco_lamp_downbridge_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_downbridge"),   
MakePlacer("deco_lamp_2embroidered_placer",  "interior_floorlamp", "interior_floorlamp", "floorlamp_2embroidered"), 
MakePlacer("deco_lamp_ceramic_placer",  "interior_floorlamp", "interior_floorlamp", "floorlamp_ceramic"),  
MakePlacer("deco_lamp_glass_placer",   "interior_floorlamp", "interior_floorlamp", "floorlamp_glass"),   
MakePlacer("deco_lamp_2fringes_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_2fringes"),   
MakePlacer("deco_lamp_candelabra_placer",  "interior_floorlamp", "interior_floorlamp", "floorlamp_candelabra"), 
MakePlacer("deco_lamp_elizabethan_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_elizabethan"),  
MakePlacer("deco_lamp_gothic_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_gothic"), 
MakePlacer("deco_lamp_orb_placer",   "interior_floorlamp", "interior_floorlamp", "floorlamp_orb"),    
MakePlacer("deco_lamp_bellshade_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_bellshade"), 
MakePlacer("deco_lamp_crystals_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_crystals"), 
MakePlacer("deco_lamp_upturn_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_upturn"),  
MakePlacer("deco_lamp_2upturns_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_2upturns"),
MakePlacer("deco_lamp_spool_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_spool"),  
MakePlacer("deco_lamp_edison_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_edison"),
MakePlacer("deco_lamp_adjustable_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_adjustable"), 
MakePlacer("deco_lamp_rightangles_placer", "interior_floorlamp", "interior_floorlamp", "floorlamp_rightangles"),
MakePlacer("deco_lamp_hoofspa_placer",  "interior_floor_decor" ,"interior_floor_decor", "lamp")
