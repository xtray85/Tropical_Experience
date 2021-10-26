require "stategraphs/SGcrab"

local assets=
{
	Asset("ANIM", "anim/crabbit_build.zip"),
	Asset("ANIM", "anim/crabbit_beardling_build.zip"),
	Asset("ANIM", "anim/beardling_crabbit.zip"),

	Asset("ANIM", "anim/crabbit.zip"),
	--Asset("ANIM", "anim/crab_basic.zip"),
	--Asset("ANIM", "anim/crab_build.zip"),
	
}

local   CRAB_WALK_SPEED = 1.5
local   CRAB_RUN_SPEED = 5
local   CRAB_HEALTH = 50
local APPEASEMENT_MEDIUM = 16
local BEARDLING_SANITY = .4
		
local prefabs =
{
    "fishmeat_small",
    "fishmeat_small_cooked",
    "beardhair",
}

local crabbitsounds = 
{
    scream = "dontstarve_DLC002/creatures/crab/scream",
    hurt = "dontstarve_DLC002/creatures/crab/scream_short",
}

local beardsounds = 
{
    scream = "dontstarve_DLC002/creatures/crab/scream",
    hurt = "dontstarve_DLC002/creatures/crab/scream_short",
}


local brain = require "brains/crabbrain"

local function BecomeRabbit(inst)
	if not inst.iscrab then
		inst.AnimState:SetBuild("crabbit_build")
	    inst.components.lootdropper:SetLoot({"fishmeat_small"})
	    inst.iscrab = true
	    inst.components.sanityaura.aura = 0
		inst.components.inventoryitem:ChangeImageName("crab")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
		inst.sounds = crabbitsounds
	end
end

local function BecomeBeardling(inst)
	if inst.iscrab then
		inst.AnimState:SetBuild("crabbit_beardling_build")
	    inst.components.lootdropper:SetLoot{}
		inst.components.lootdropper:AddRandomLoot("beardhair", .5)	    
		inst.components.lootdropper:AddRandomLoot("monstermeat", 1)	    
		inst.components.lootdropper:AddRandomLoot("nightmarefuel", 1)	  
		inst.components.lootdropper.numrandomloot = 1
		inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED		
	    inst.iscrab = false
	    inst.components.inventoryitem:ChangeImageName("crabbit_beardling")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"
		inst.sounds = beardsounds
	end
end

local function CheckTransformState(inst)
	if not inst.components.health:IsDead() then
		local player = GetClosestInstWithTag("player", inst, 17)
		if player and player.components.sanity:GetPercent() < BEARDLING_SANITY then
			BecomeBeardling(inst)
		else
			BecomeRabbit(inst)			
		end
	end
end

local function ondrop(inst)
	inst.sg:GoToState("stunned")
	CheckTransformState(inst)
end

local function OnWake(inst)
	CheckTransformState(inst)
	inst.checktask = inst:DoPeriodicTask(10, CheckTransformState)
end

local function OnSleep(inst)
	 if inst.checktask then
	 	inst.checktask:Cancel()
	 	inst.checktask = nil
	 end
end

local function GetCookProductFn(inst)
	if inst.iscrab then
		return "fishmeat_small_cooked" 
	else 
		return "cookedmonstermeat"
	end
end

local function OnCookedFn(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/scream_short")
end

local function OnAttacked(inst, data)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, 30, {'crab'})
    
    local num_friends = 0
    local maxnum = 5
    for k,v in pairs(ents) do
        v:PushEvent("gohome")
        num_friends = num_friends + 1
        
        if num_friends > maxnum then
            break
        end
    end
end

local function OnDug(inst, worker)
	local rnd = math.random()
	local home = inst.components.homeseeker and inst.components.homeseeker.home
	if rnd >= 0.66 or not home then
		--Sometimes just go to stunned state

		inst:PushEvent("stunned")
	else
		--Sometimes return home instantly?
		worker:DoTaskInTime(1, function()
			worker:PushEvent("crab_fail")
		end)

		inst.components.lootdropper:SpawnLootPrefab("sand")
		local home = inst.components.homeseeker.home
		home.components.spawner:GoHome(inst)
	end
end

local function DisplayName(inst)
    if inst.sg:HasStateTag("invisible") then
        return STRINGS.NAMES.CRAB_HIDDEN
    end
    return STRINGS.NAMES.CRAB
end

local function getstatus(inst)
    if inst.sg:HasStateTag("invisible") then 
        return "HIDDEN"
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .5 )
    inst.Transform:SetFourFaced()
    inst.entity:AddNetwork()
	
    MakeCharacterPhysics(inst, 1, 0.5)
 --   MakePoisonableCharacter(inst)

    anim:SetBank("crabbit")
    anim:SetBuild("crabbit_build")
    anim:PlayAnimation("idle")

    inst:AddTag("animal")
    inst:AddTag("prey")
    inst:AddTag("rabbit")
    inst:AddTag("smallcreature")
    inst:AddTag("canbetrapped")    

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst.data = {}
    
    inst:AddComponent("eater")
    inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT" }
    inst.components.eater.ablefoods = { "MEAT", "VEGGIE", "INSECT" }

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	inst.components.inventoryitem.nobounce = true
	inst.components.inventoryitem.canbepickedup = false
	--inst.components.inventoryitem:SetOnDroppedFn(ondrop) Done in MakeFeedablePet
	inst:AddComponent("sanityaura")

    inst:AddComponent("cookable")
    inst.components.cookable.product = GetCookProductFn
    inst.components.cookable:SetOnCookedFn(OnCookedFn)
    
    inst:AddComponent("knownlocations")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "chest"
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(CRAB_HEALTH)
    inst.components.health.murdersound = "dontstarve_DLC002/creatures/crab/scream_short"

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable.workable = false
    inst.components.workable:SetOnFinishCallback(OnDug)

    MakeSmallBurnableCharacter(inst, "chest")
    MakeTinyFreezableCharacter(inst, "chest")

    inst:AddComponent("lootdropper")

    inst:AddComponent("tradable")
    inst:AddTag("cattoy")
    inst:AddTag("catfood")
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus
    inst:AddComponent("sleeper")

	inst:AddComponent("appeasement")
	inst.components.appeasement.appeasementvalue = APPEASEMENT_MEDIUM
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = CRAB_RUN_SPEED
    inst.components.locomotor.walkspeed = CRAB_WALK_SPEED
    inst:SetStateGraph("SGcrab")	
	
    inst:SetBrain(brain)
	
	BecomeRabbit(inst)
    CheckTransformState(inst)
    inst.CheckTransformState = CheckTransformState
	
	inst.OnEntityWake = OnWake
	inst.OnEntitySleep = OnSleep    
    
    inst.OnSave = function(inst, data)
		data.iscrab = inst.iscrab
    end        
    
    inst.OnLoad = function(inst, data)
        if data then
			if not data.iscrab then
				BecomeBeardling(inst)
	        end
	    end 
    end

    inst.displaynamefn = DisplayName

    inst:ListenForEvent("attacked", OnAttacked)

    MakeFeedablePet(inst, 480*2, nil, ondrop)

    return inst
end

return Prefab( "crab", fn, assets, prefabs) 
