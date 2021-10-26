require "prefabutil"
local assets =
{
	Asset("ANIM", "anim/jungletreeseed.zip"),
}

local function growtree(inst)
	-- print ("GROWTREE")
    inst.growtask = nil
    inst.growtime = nil
	local tree = SpawnPrefab("tree_forest_short") 
    if tree then 
		tree.Transform:SetPosition(inst.Transform:GetWorldPosition() ) 
        tree:growfromseed()--PushEvent("growfromseed")
        inst:Remove()
	end
end

local function growtree1(inst)
	-- print ("GROWTREE")
    inst.growtask = nil
    inst.growtime = nil
	local tree = SpawnPrefab("tree_forest_deep_short") 
    if tree then 
		tree.Transform:SetPosition(inst.Transform:GetWorldPosition() ) 
        tree:growfromseed()--PushEvent("growfromseed")
        inst:Remove()
	end
end

local function growtree2(inst)
	-- print ("GROWTREE")
    inst.growtask = nil
    inst.growtime = nil
	local tree = SpawnPrefab("tree_forest_rot_short") 
    if tree then 
		tree.Transform:SetPosition(inst.Transform:GetWorldPosition() ) 
        tree:growfromseed()--PushEvent("growfromseed")
        inst:Remove()
	end
end

local function plant(inst, growtime) 
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("locomotor")
    RemovePhysicsColliders(inst)
    inst.AnimState:PlayAnimation("idle_planted")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst.growtime = GetTime() + growtime
    -- print ("PLANT", growtime)
    inst.growtask = inst:DoTaskInTime(growtime, growtree)
end

local function plant1(inst, growtime) 
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("locomotor")
    RemovePhysicsColliders(inst)
    inst.AnimState:PlayAnimation("idle_planted")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst.growtime = GetTime() + growtime
    -- print ("PLANT", growtime)
    inst.growtask = inst:DoTaskInTime(growtime, growtree1)
end

local function plant2(inst, growtime) 
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("locomotor")
    RemovePhysicsColliders(inst)
    inst.AnimState:PlayAnimation("idle_planted")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst.growtime = GetTime() + growtime
    -- print ("PLANT", growtime)
    inst.growtask = inst:DoTaskInTime(growtime, growtree2)
end

local function ondeploy (inst, pt) 
    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get() )
    local timeToGrow = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
    plant(inst, timeToGrow)
	
	--tell any nearby leifs to chill out
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, TUNING.LEIF_PINECONE_CHILL_RADIUS, {"leif"})
	
	local played_sound = false
	for k,v in pairs(ents) do
		
		local chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_FAR
		if distsq(pt, Vector3(v.Transform:GetWorldPosition())) < TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS*TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS then
			chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_CLOSE
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

local function ondeploy1 (inst, pt) 
    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get() )
    local timeToGrow = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
    plant1(inst, timeToGrow)
	
	--tell any nearby leifs to chill out
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, TUNING.LEIF_PINECONE_CHILL_RADIUS, {"leif"})
	
	local played_sound = false
	for k,v in pairs(ents) do
		
		local chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_FAR
		if distsq(pt, Vector3(v.Transform:GetWorldPosition())) < TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS*TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS then
			chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_CLOSE
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

local function ondeploy2 (inst, pt) 
    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get() )
    local timeToGrow = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
    plant2(inst, timeToGrow)
	
	--tell any nearby leifs to chill out
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, TUNING.LEIF_PINECONE_CHILL_RADIUS, {"leif"})
	
	local played_sound = false
	for k,v in pairs(ents) do
		
		local chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_FAR
		if distsq(pt, Vector3(v.Transform:GetWorldPosition())) < TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS*TUNING.LEIF_PINECONE_CHILL_CLOSE_RADIUS then
			chill_chance = TUNING.LEIF_PINECONE_CHILL_CHANCE_CLOSE
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
        local growtime = GetRandomWithVariance(TUNING.PINECONE_GROWTIME.base, TUNING.PINECONE_GROWTIME.random)
        inst.growtime = GetTime() + growtime
        inst.growtask = inst:DoTaskInTime(growtime, growtree)
    end
end


local notags = {'NOBLOCK', 'player', 'FX'}
local function test_ground(inst, pt)
	local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
	local ground_OK = tiletype ~= GROUND.ROCKY and tiletype ~= GROUND.ROAD and tiletype ~= GROUND.IMPASSABLE and tiletype ~= GROUND.MAGMAFIELD and
						tiletype ~= GROUND.UNDERROCK and tiletype ~= GROUND.WOODFLOOR and tiletype ~= GROUND.SAND and 
						tiletype ~= GROUND.CARPET and tiletype ~= GROUND.CHECKER and tiletype < GROUND.UNDERGROUND and
                        tiletype ~= GROUND.ASH and tiletype ~= GROUND.VOLCANO and tiletype ~= GROUND.LAVA_ROCK and tiletype ~= GROUND.BRICK_GLOW
	
	if ground_OK then
		return true
	end
	return false
end

local function describe(inst)
    if inst.growtime then
        return "PLANTED"
    end
end

local function displaynamefn(inst)
    if inst.growtime then
        return STRINGS.NAMES.JUNGLE_TREE_SAPLING
    end
    return STRINGS.NAMES.JUNGLE_TREE_SEED
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

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("jungletreeseed")
    inst.AnimState:SetBuild("jungletreeseed")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("deployedplant")
    

    --inst:AddComponent("edible")
    --inst.components.edible.foodtype = "WOOD"
    --inst.components.edible.woodiness = 2

    inst:AddTag("cattoy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("tradable")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = describe
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    -- inst:AddComponent("appeasement")
    -- inst.components.appeasement.appeasementvalue = TUNING.WRATH_SMALL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	inst:ListenForEvent("onignite", stopgrowing)
    inst:ListenForEvent("onextinguish", restartgrowing)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
    inst:AddComponent("deployable")
    inst.components.deployable.CanDeploy = test_ground
    inst.components.deployable.ondeploy = ondeploy
    
    inst.displaynamefn = displaynamefn

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local function fn1()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("jungletreeseed")
    inst.AnimState:SetBuild("jungletreeseed")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("deployedplant")
    

    --inst:AddComponent("edible")
    --inst.components.edible.foodtype = "WOOD"
    --inst.components.edible.woodiness = 2

    inst:AddTag("cattoy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("tradable")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = describe
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    -- inst:AddComponent("appeasement")
    -- inst.components.appeasement.appeasementvalue = TUNING.WRATH_SMALL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	inst:ListenForEvent("onignite", stopgrowing)
    inst:ListenForEvent("onextinguish", restartgrowing)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
    inst:AddComponent("deployable")
    inst.components.deployable.CanDeploy = test_ground
    inst.components.deployable.ondeploy = ondeploy1
    
    inst.displaynamefn = displaynamefn

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local function fn2()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("jungletreeseed")
    inst.AnimState:SetBuild("jungletreeseed")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("deployedplant")
    

    --inst:AddComponent("edible")
    --inst.components.edible.foodtype = "WOOD"
    --inst.components.edible.woodiness = 2

    inst:AddTag("cattoy")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("tradable")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = describe
    
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    -- inst:AddComponent("appeasement")
    -- inst.components.appeasement.appeasementvalue = TUNING.WRATH_SMALL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	inst:ListenForEvent("onignite", stopgrowing)
    inst:ListenForEvent("onextinguish", restartgrowing)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
    inst:AddComponent("deployable")
    inst.components.deployable.CanDeploy = test_ground
    inst.components.deployable.ondeploy = ondeploy2
    
    inst.displaynamefn = displaynamefn

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

return Prefab( "tree_forestseed", fn, assets),
	   MakePlacer( "tree_forestseed_placer", "jungletreeseed", "jungletreeseed", "idle_planted" ),
	   Prefab( "tree_forest_deep_seed", fn1, assets),
	   MakePlacer( "tree_forest_deep_seed_placer", "jungletreeseed", "jungletreeseed", "idle_planted" ),
       Prefab( "tree_forest_rot_seed", fn2, assets),
	   MakePlacer( "tree_forest_rot_seed_placer", "jungletreeseed", "jungletreeseed", "idle_planted" )  


