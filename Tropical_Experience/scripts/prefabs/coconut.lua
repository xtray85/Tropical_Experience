local assets =
{
	Asset("ANIM", "anim/coconut.zip"),
}

local prefabs = 
{
    -- "coconut_cooked", 
    -- "cononut_halved"
}
 
 
local seg_time = 30 --each segment of the clock is 30 seconds
local total_day_time = seg_time*16

local day_segs = 10
local dusk_segs = 4
local night_segs = 2

	--default day composition. changes in winter, etc
local day_time = seg_time * day_segs
local dusk_time = seg_time * dusk_segs
local night_time = seg_time * night_segs
local LEIF_PINECONE_CHILL_RADIUS = 16
local LEIF_PINECONE_CHILL_CHANCE_CLOSE = .33
local LEIF_PINECONE_CHILL_CHANCE_FAR = .15
local LEIF_PINECONE_CHILL_CLOSE_RADIUS = 5
local LEIF_PINECONE_CHILL_RADIUS = 16
local LEIF_REAWAKEN_RADIUS = 20



local COCONUT_GROWTIME = {base=2.5*day_time, random=0.75*day_time}

local function growtree(inst)
	print ("GROWTREE")
    inst.growtask = nil
    inst.growtime = nil
	local tree = SpawnPrefab("palmtree_short") 
    if tree then 
		tree.Transform:SetPosition(inst.Transform:GetWorldPosition() ) 
        tree:growfromseed()--PushEvent("growfromseed")
        inst:Remove()
	end
end

local function plant(inst, growtime)
	
    inst:RemoveComponent("workable")
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("locomotor")
    RemovePhysicsColliders(inst)
--    RemoveBlowInHurricane(inst)
    inst.AnimState:PlayAnimation("planted", true)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst.growtime = GetTime() + growtime
    print ("PLANT", growtime)
    inst.growtask = inst:DoTaskInTime(growtime, growtree)

     if inst.components.edible then
        inst:RemoveComponent("edible")
    end
    if inst.components.bait then
        inst:RemoveComponent("bait")
    end		
	
end

local function ondeploy (inst, pt) 
--    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get() )
    local timeToGrow = GetRandomWithVariance(COCONUT_GROWTIME.base, COCONUT_GROWTIME.random)
    plant(inst, timeToGrow)
	
	--tell any nearby leifs to chill out
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, LEIF_PINECONE_CHILL_RADIUS, {"leif"})
	
	local played_sound = false
	for k,v in pairs(ents) do
		
		local chill_chance = LEIF_PINECONE_CHILL_CHANCE_FAR
		if distsq(pt, Vector3(v.Transform:GetWorldPosition())) < LEIF_PINECONE_CHILL_CLOSE_RADIUS*LEIF_PINECONE_CHILL_CLOSE_RADIUS then
			chill_chance = LEIF_PINECONE_CHILL_CHANCE_CLOSE
		end
	
		if math.random() < chill_chance then
			if v.components.sleeper then
				v.components.sleeper:GoToSleep(1000)
			end
		else
			if not played_sound then
				v.SoundEmitter:PlaySound("dontstarve/creatures/leif/taunt_VO")
				played_sound = true
			end
		end
		
	end
	
end

local function stopgrowing(inst)
    if inst.growtask then
        inst.growtask:Cancel()
        inst.growtask = nil
    end
    inst.growtime = nil
end

local function restartgrowing(inst)
    if inst and not inst.growtask then
        local growtime = GetRandomWithVariance(COCONUT_GROWTIME.base, COCONUT_GROWTIME.random)
        inst.growtime = GetTime() + growtime
        inst.growtask = inst:DoTaskInTime(growtime, growtree)
    end
end


	local function test_ground(inst, pt)
	if(TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get())) == GROUND.BEACH) then return true end --adicionado por vagner
	return false
	end

local function describe(inst)
    if inst.growtime then
        return "PLANTED"
    end
end

local function displaynamefn(inst)
    if inst.growtime then
        return STRINGS.NAMES.COCONUT_SAPLING
    end
    return STRINGS.NAMES.COCONUT
end

local function OnSave(inst, data)
    if inst.growtime then
        data.growtime = inst.growtime - GetTime()
    end
end

local function OnLoad(inst, data)
    if data and data.growtime then
        plant(inst, data.growtime)
    end
end

local function common()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	
    -- MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.MEDIUM, TUNING.WINDBLOWN_SCALE_MAX.MEDIUM)

    inst.AnimState:SetBank("coconut")
    inst.AnimState:SetBuild("coconut")
    inst.AnimState:PlayAnimation("idle")
    

   -- inst:AddComponent("edible")
    --inst.components.edible.foodtype = "VEGGIE"
    -- inst:AddTag("coconut")
    inst:AddTag("cattoy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("tradable")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    -- inst.components.inspectable.getstatus = describe
    
    --inst:AddComponent("fuel")
    --inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	inst:ListenForEvent("onignite", stopgrowing)
    inst:ListenForEvent("onextinguish", restartgrowing)
    MakeSmallPropagator(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
   

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.RAW
    --inst:AddComponent("bait")
    

    return inst
end

local function onhacked(inst)
    local nut = inst 
    if inst.components.inventoryitem then 
        local owner = inst.components.inventoryitem.owner
        if inst.components.stackable and inst.components.stackable.stacksize > 1 then 
            nut = inst.components.stackable:Get()
            inst.components.workable:SetWorkLeft(1)
        end 
		inst.components.lootdropper:SpawnLootPrefab("coconut_halved")
		inst.components.lootdropper:SpawnLootPrefab("coconut_halved")
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/bamboo_hack")
    end
	
    nut:Remove()		
end 

local function raw()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	

    inst.AnimState:SetBank("coconut")
    inst.AnimState:SetBuild("coconut")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddTag("cattoy")
	inst:AddTag("deployedplant")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("tradable")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    -- inst.components.inspectable.getstatus = describe
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	inst:ListenForEvent("onignite", stopgrowing)
    inst:ListenForEvent("onextinguish", restartgrowing)
    MakeSmallPropagator(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.RAW
    --inst:AddComponent("bait")
    inst:AddTag("show_spoilage")
	inst:AddTag("machetecut") 
	inst:AddTag("aquatic")	
	
	 inst:AddComponent("interactions")	
	 inst:AddComponent("workable")
     inst.components.workable:SetWorkAction(ACTIONS.HACK)
     inst.components.workable:SetWorkLeft(1)
     inst.components.workable:SetOnFinishCallback(onhacked)

    inst:AddComponent("lootdropper")
    
	inst:AddComponent("deployable")
	inst.components.deployable.CanDeploy = test_ground
    inst.components.deployable.ondeploy = ondeploy
	inst.components.deployable:SetDeployMode(DEPLOYMODE.WALL)

    -- MakeInventoryFloatable(inst, "idle_water", "idle")
    
    inst.displaynamefn = displaynamefn

    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY/2

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

		
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end 

local function cooked()
    local inst = common()

    inst.AnimState:PlayAnimation("cook")
    -- MakeInventoryFloatable(inst, "cooked_water", "cook")
	inst:AddTag("aquatic")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

    inst.components.edible.foodstate = "COOKED"
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
    inst.components.edible.foodtype = FOODTYPE.SEEDS

    return inst
end

local function halved()
    local inst = common()

    inst.AnimState:PlayAnimation("chopped")

    inst:AddTag("cookable")
	inst:AddTag("aquatic")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("cookable")
    inst.components.cookable.product = "coconut_cooked"

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
    -- MakeInventoryFloatable(inst, "chopped_water", "chopped")
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY/2
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
    inst.components.edible.foodtype = FOODTYPE.SEEDS
    

    return inst
end

return Prefab( "coconut", raw, assets, prefabs),
    Prefab( "coconut_cooked", cooked, assets, prefabs),
    Prefab( "coconut_halved", halved, assets, prefabs),
	MakePlacer( "coconut_placer", "coconut", "coconut", "planted" ) 


