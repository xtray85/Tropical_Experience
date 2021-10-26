--[[
birds.lua
This assumes the bird already has a build, inventory icon, sounds and a feather_name prefab exists
]]--
local brain = require "brains/birdbrain"

local assets =
{
    Asset("ANIM", "anim/crow.zip"),
--	Asset("ANIM", "anim/parrot_build.zip"),
	Asset("ANIM", "anim/toucan_build"),
}

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and not inst.sg:HasStateTag("flying")
end

local function OnAttacked(inst, data)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, 30, {'bird'})
    
    local num_friends = 0
    local maxnum = 5
    for k,v in pairs(ents) do
        if v ~= inst then
            v:PushEvent("gohome")
            num_friends = num_friends + 1
        end
        
        if num_friends > maxnum then
            
			return
        end
        
    end
end

local function OnTrapped(inst, data)

    if data and data.trapper and data.trapper.settrapsymbols then
        data.trapper.settrapsymbols(inst.trappedbuild)
    end
end

local function OnDropped(inst)
    inst.sg:GoToState("stunned")
end

local function SeedSpawnTest()
    return not TheWorld.state.iswinter
end

local function makebird(name, soundname, loottable, psprefab, foodtype, scale)
    local assets=
    {
	    Asset("ANIM", "anim/crow.zip"),
	    Asset("ANIM", "anim/"..name.."_build.zip"),
		Asset("SOUNDPACKAGE", "sound/dontstarve_DLC002.fev"),
		Asset("SOUND", "sound/dontstarve_shipwreckedSFX.fsb"),
    }
	
	local prefabs = 
	{
		"cookedsmallmeat",
	}
	
	prefabs[2] = psprefab or "seeds"-- add the periodspawnprefab to "prefabs" list
	
	if loottable ~= nil then-- -- add all loot to "prefabs" list
		for key, loot in pairs(loottable) do
			key = tonumber(key)
			prefabs[key+2] = loot[1]--key+2 is due to the fact that "prefabs" list already has 2 values in it
		end
	end
    
    local function fn()
        local inst = CreateEntity()

        --Core components
        inst.entity:AddTransform()

        inst.entity:AddNetwork()

        inst.entity:AddPhysics()

        inst.entity:AddAnimState()
        inst.entity:AddDynamicShadow()


        inst.entity:AddSoundEmitter()


        --Initialize physics
        inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.GROUND)
        inst.Physics:SetSphere(1)
        inst.Physics:SetMass(1)


        inst:AddTag("bird")
        inst:AddTag(name)
        inst:AddTag("smallcreature")
		
		
		--if inst.HasTag("phoenix")
		--then

		scale = scale or 1 
		inst.flyawaydistance = 4
        inst.Transform:SetTwoFaced()   
        inst.AnimState:SetBank("crow")
        inst.AnimState:SetBuild(name.."_build")
        inst.AnimState:PlayAnimation("idle")
		inst.DynamicShadow:SetSize(scale, scale - 0.25)
        inst.DynamicShadow:Enable(false)
		
		inst.Transform:SetScale(scale, scale, scale)
	
        MakeFeedablePetPristine(inst)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.entity:SetPristine()

        inst.sounds =
        {
            takeoff = "dontstarve_DLC002/creatures/toucan/takeoff",
            chirp = "dontstarve_DLC002/creatures/toucan/chirp",
            flyin = "dontstarve/birds/flyin",
        }
        inst.trappedbuild = name.."_build"
        
        inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
        inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	    inst.components.locomotor:SetTriggersCreep(false)
        inst:SetStateGraph("SGbird")

		if loottable ~= nil then
			inst:AddComponent("lootdropper")
			inst.components.lootdropper.numrandomloot = 1
			for key, loot in pairs(loottable) do
				inst.components.lootdropper:AddRandomLoot(loot[1], loot[2], loot[3])--loot[1] is prefab, loot[2] is rarity
			end
		end
		
        inst:AddComponent("occupier")
        
        inst:AddComponent("eater")
        inst.components.eater:SetDiet({ FOODTYPE.SEEDS }, { FOODTYPE.SEEDS })
        
        inst:AddComponent("sleeper")
        inst.components.sleeper:SetSleepTest(ShouldSleep)

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.nobounce = true
        inst.components.inventoryitem.canbepickedup = false
        inst.components.inventoryitem.canbepickedupalive = true
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

        inst:AddComponent("cookable")
        inst.components.cookable.product = "cookedsmallmeat"

        inst:AddComponent("combat")
        inst.components.combat.hiteffectsymbol = "crow_body"
        --inst.components.combat.canbeattackedfn = canbeattacked
        inst:AddComponent("health")
		inst.components.health:SetMaxHealth(TUNING.BIRD_HEALTH)
		inst.components.health.murdersound = "dontstarve/wilson/hit_animal"
        
        inst:AddComponent("inspectable")
       
        inst:SetBrain(brain)
        
		
		
		
		--fix this for phoenix---
        MakeSmallBurnableCharacter(inst, "crow_body")
        MakeTinyFreezableCharacter(inst, "crow_body")

		inst:AddComponent("hauntable")
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
        inst:AddComponent("periodicspawner")
		inst.components.periodicspawner:SetPrefab(psprefab or "seeds")--set to psprefab or "seeds"(it will be set to "seeds" if psprefab is nil)
        inst.components.periodicspawner:SetDensityInRange(40, 2)
        inst.components.periodicspawner:SetMinimumSpacing(7)
		inst.components.periodicspawner:SetSpawnTestFn( SeedSpawnTest )

        inst:ListenForEvent("ontrapped", OnTrapped)

        inst:ListenForEvent("attacked", OnAttacked)

		local birdspawner = TheWorld.components.birdspawner
        if birdspawner ~= nil then
            inst:ListenForEvent("onremove", birdspawner.StopTrackingFn)
            inst:ListenForEvent("enterlimbo", birdspawner.StopTrackingFn)
            --inst:ListenForEvent("exitlimbo", extrabirdspawner.StartTrackingFn)
            birdspawner:StartTracking(inst)
        end

        MakeFeedablePet(inst, TUNING.BIRD_PERISH_TIME, nil, OnDropped)

        return inst
    end
    
    return Prefab("forest/animals/"..name, fn, assets, prefabs)
end

return makebird("quagmire_pigeon", "quagmire_pigeon",	{{"seeds", 0.5}, {"smallmeat", 0.5}, {"feather_robin_winter", 0.1}},"seeds", 1)
