require "prefabutil"
local assets =
{
Asset("ANIM", "anim/teatree_nut.zip"),
}

local prefabs = 
{
  --  "acorn_cooked",
    "spoiled_food"
}

local function growtree(inst)
	print ("GROWTREE")
    inst.growtask = nil
    inst.growtime = nil
	local tree = SpawnPrefab("teatree") 
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
--    RemoveBlowInHurricane(inst)
    inst.AnimState:PlayAnimation("idle_planted")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst.growtime = GetTime() + growtime
    if inst.components.edible then
        inst:RemoveComponent("edible")
    end
    print ("PLANT", growtime)

      inst.growtask = inst:DoTaskInTime(growtime, growtree)
end

local function ondeploy (inst, pt) 
    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get() )
	inst:RemoveComponent("perishable")
    
    local timeToGrow = GetRandomWithVariance(TUNING.ACORN_GROWTIME.base, TUNING.ACORN_GROWTIME.random)
    plant(inst, timeToGrow)	
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
        local growtime = GetRandomWithVariance(TUNING.ACORN_GROWTIME.base, TUNING.ACORN_GROWTIME.random)
        inst.growtime = GetTime() + growtime
        inst.growtask = inst:DoTaskInTime(growtime, growtree)
    end
end


local notags = {'NOBLOCK', 'player', 'FX'}
local function test_ground(inst, pt)
	local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
	local ground_OK = tiletype ~= GROUND.ROCKY and tiletype ~= GROUND.ROAD and tiletype ~= GROUND.IMPASSABLE and tiletype ~= GROUND.INTERIOR and
						tiletype ~= GROUND.UNDERROCK and tiletype ~= GROUND.WOODFLOOR and 
						tiletype ~= GROUND.CARPET and tiletype ~= GROUND.CHECKER and tiletype < GROUND.UNDERGROUND
	
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
        return STRINGS.NAMES.TEATREE_SAPLING
    end
    return STRINGS.NAMES.TEATREE_NUT
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

local function oneat(inst, eater)
    if eater.components.temperature ~= nil and eater.components.temperature.hayfever then
    eater.components.temperature.hayfever = 200
    end
end

local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("teatree_nut")
    inst.AnimState:SetBuild("teatree_nut")
    inst.AnimState:PlayAnimation("idle")


    inst:AddComponent("cookable")
    inst.components.cookable.product = "teatree_nut_cooked"

    inst:AddTag("icebox_valid")
    inst:AddTag("cattoy")
	inst:AddTag("deployedplant")
	
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
    inst:AddComponent("tradable")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
    inst:AddTag("show_spoilage")

    inst:AddComponent("edible")
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.antihistamine = 60
    inst.components.edible.foodtype = "SEEDS"
    inst.components.edible.foodstate = "RAW"
    inst.components.edible:SetOnEatenFn(oneat)	

    inst:AddComponent("bait")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = describe
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	inst:ListenForEvent("onignite", stopgrowing)
    inst:ListenForEvent("onextinguish", restartgrowing)
    MakeSmallPropagator(inst)
--    inst.components.burnable:MakeDragonflyBait(3)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
    
    inst:AddComponent("deployable")
    inst.components.deployable.CanDeploy = test_ground
    inst.components.deployable.ondeploy = ondeploy

    inst.displaynamefn = displaynamefn
    
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local function cooked()
    local inst = CreateEntity()
    inst.entity:AddNetwork()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("teatree_nut")
    inst.AnimState:SetBuild("teatree_nut")
    inst.AnimState:PlayAnimation("cooked")

	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("edible")
    inst.components.edible.foodstate = "COOKED"
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
    inst.components.edible.antihistamine = 120
    inst.components.edible.foodtype = "SEEDS"
    inst.components.edible:SetOnEatenFn(oneat)	

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    return inst
end

return Prefab( "common/inventory/teatree_nut", fn, assets, prefabs),
       Prefab("common/inventory/teatree_nut_cooked", cooked, assets),
	   MakePlacer( "common/teatree_nut_placer", "teatree_nut", "teatree_nut", "idle_planted" ) 


