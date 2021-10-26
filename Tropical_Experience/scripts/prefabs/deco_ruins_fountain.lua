local assets =
{
    Asset("ANIM", "anim/pig_ruins_well.zip"),      
}

local prefabs =
{
 
}

local function ShouldAcceptItem(inst, item)
    if not inst:HasTag("vortex") then
        local can_accept = item.components.currency or item.prefab == "goldnugget" or item.prefab == "dubloon" or item.prefab == "oinc" or item.prefab == "oinc10" or item.prefab == "oinc100"--and (Prefabs[seed_name] or item.prefab == "seeds" or item.components.edible.foodtype == "MEAT") 
    
        return can_accept 
    else
        return true         
    end
end

local function OnRefuseItem(inst, item)
--    inst.AnimState:PlayAnimation("flap")
--    inst.SoundEmitter:PlaySound("dontstarve/birds/wingflap_cage")
--    inst.AnimState:PushAnimation("idle_bird")
end

local function OnGetItemFromPlayer(inst, giver, item)
    if not inst:HasTag("vortex") then
        local value = 0
        if item.prefab == "oinc" then
            value = 1
        elseif item.prefab == "oinc10" then
            value = 10
        elseif item.prefab == "oinc100" then
            value = 100        
        elseif item.prefab == "goldnugget" then
            value = 20
        elseif item.prefab == "dubloon" then
            value = 5
        end

        inst.AnimState:PlayAnimation("splash")
        inst.AnimState:PushAnimation("idle_full",true)   

        inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/small") 

        inst:DoTaskInTime(1, function()
                if math.random() * 25 < value then
				    if giver.components.poisonable ~= nil then
                        giver.components.poisonable:WearOff()
                    end
                    if giver.components.health and  giver.components.health:GetPercent() < 1 then
                        giver.components.health:DoDelta( value*5 ,false,inst.prefab)
                        giver:PushEvent("celebrate")
                    end           
                end
            end)
    else
        inst.AnimState:PlayAnimation("vortex_splash")
        inst.AnimState:PlayAnimation("vortex_empty")
        inst.AnimState:PushAnimation("vortex_idle_full",true)   
        inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/small") 

        local value = 1
        if item.prefab == "nightmarefuel" then
            value = 100
        elseif item.prefab == "redgem" or item.prefab == "bluegem" or item.prefab == "orangegem" or item.prefab == "yellowgem" or item.prefab == "greengem" then
            value = 50               
        end
		
        value = value + math.random()*100		

        inst:DoTaskInTime(1, function()
                local gems = 0
                if value < 100 then
                    if math.random() <= 0.6 then
                        SpawnAt("crawlingnightmare",inst)
                    else
                        SpawnAt("nightmarebeak",inst)
                    end
                elseif value < 150 then
                        gems = 1
                elseif value < 200 then
                       gems = 3
                end

                if gems > 0 then
                    inst.AnimState:PlayAnimation("vortex_splash")
                    inst.AnimState:PushAnimation("vortex_idle_full",true)   
                    inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/small")                
                    for k = 1, gems do
                        local nug = SpawnPrefab("purplegem")
                        local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,4.5,0)
                        
                        nug.Transform:SetPosition(pt:Get())
                        local down = TheCamera:GetDownVec()
                        local angle = math.atan2(down.z, down.x) + (math.random()*60-30)*DEGREES
                        --local angle = (-TUNING.CAM_ROT-90 + math.random()*60-30)/180*PI
                        local sp = math.random()*4+2
                        nug.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, sp*math.sin(angle))
                    end				
--				local x, y, z = inst.Transform:GetWorldPosition()
--				local fonte = SpawnPrefab("deco_ruins_fountain")
--				fonte.Transform:SetPosition(x, y, z)
--				inst:Remove()									
                end
        end)

    end
end

local function decofn()
        local inst = CreateEntity()
	    inst.entity:AddNetwork()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()

        anim:SetBuild("pig_ruins_well")
        anim:SetBank("pig_ruins_well")
        anim:PlayAnimation("idle_full", true)
--        anim:SetOrientation(ANIM_ORIENTATION.RotatingBillboard)  

        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon("pig_ruins_well.png")

        inst:AddTag("blocker")
        inst.entity:AddPhysics()
        inst.Physics:SetMass(0)
        inst.Physics:SetCylinder(2,4.0)
        inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.ITEMS)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS) 

		inst:AddTag("watersource")		

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end	
		
        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        inst.components.trader.onaccept = OnGetItemFromPlayer
        inst.components.trader.onrefuse = OnRefuseItem

        inst:AddComponent("inspectable")

        anim:SetTime(math.random() * anim:GetCurrentAnimationLength())

        return inst
end

local function decofn1()
        local inst = CreateEntity()
	    inst.entity:AddNetwork()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()

        anim:SetBuild("pig_ruins_well")
        anim:SetBank("pig_ruins_well")
        anim:PlayAnimation("vortex_idle_full", true)

        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon("pig_ruins_well_vortex.png")

        inst:AddTag("blocker")
        inst.entity:AddPhysics()
        inst.Physics:SetMass(0)
        inst.Physics:SetCylinder(2,4.0)
        inst.Physics:SetCollisionGroup(COLLISION.OBSTACLES)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.ITEMS)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)   

		inst:AddTag("vortex")		

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end	
		
        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        inst.components.trader.onaccept = OnGetItemFromPlayer
        inst.components.trader.onrefuse = OnRefuseItem

        inst:AddComponent("inspectable")

        anim:SetTime(math.random() * anim:GetCurrentAnimationLength())

        return inst
end
    
	return Prefab("deco_ruins_fountain", decofn, assets, prefabs),
		   Prefab("deco_ruins_endswell", decofn1, assets, prefabs)

