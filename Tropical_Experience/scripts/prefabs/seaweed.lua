local assets=
{
	Asset("ANIM", "anim/seaweed.zip"),
    Asset("ANIM", "anim/meat_rack_food.zip"),
}


local prefabs = 
{
    "seaweed_planted",
    "seaweed_cooked",
    "seaweed_dried",
}

local perish_warp = 1--/200
local calories_per_day = 75
local HEALING_TINY = 1
local HEALING_SMALL = 3
local STACK_SIZE_SMALLITEM = 40
local CALORIES_TINY = calories_per_day/8
local CALORIES_SMALL = calories_per_day/6
local SANITY_SMALL = 10
local PERISH_FAST = 6*480*perish_warp
local PERISH_MED = 10*480*perish_warp
local PERISH_PRESERVED = 20*480*perish_warp
local DRY_FAST = 480
local POOP_FERTILIZE = 300
local POOP_SOILCYCLES = 10
local POOP_WITHEREDCYCLES = 1

local function defaultfn(sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    inst.AnimState:SetRayTestOnBB(true);    
    inst.AnimState:SetBank("seaweed")
    inst.AnimState:SetBuild("seaweed")
    
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    inst.entity:SetPristine()
	
	inst:AddTag("aquatic")

    if not TheWorld.ismastersim then
        return inst
    end

  
    
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst:AddComponent("bait")   
    inst:AddComponent("inspectable")
 
    inst:AddComponent("inventoryitem")
    

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
    inst.components.edible.healthvalue = HEALING_TINY
    inst.components.edible.hungervalue = CALORIES_TINY
    inst.components.edible.sanityvalue = -SANITY_SMALL
    inst.components.perishable:SetPerishTime(PERISH_FAST)

    inst:AddComponent("cookable")
    inst.components.cookable.product = "seaweed_cooked"

    inst:AddComponent("dryable")
    inst.components.dryable:SetProduct("seaweed_dried")
    inst.components.dryable:SetDryTime(DRY_FAST)
    inst.AnimState:PlayAnimation("idle", true)

	inst:AddComponent("talker")

    inst:AddComponent("fertilizer")
    inst.components.fertilizer.fertilizervalue = POOP_FERTILIZE
    inst.components.fertilizer.soil_cycles = POOP_SOILCYCLES
    inst.components.fertilizer.withered_cycles = POOP_WITHEREDCYCLES
	
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    return inst
end 


local function cookedfn(sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    inst.AnimState:SetRayTestOnBB(true);    
    inst.AnimState:SetBank("seaweed")
    inst.AnimState:SetBuild("seaweed")
    
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

	inst:AddTag("aquatic")
		
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
 
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("bait")
    inst:AddComponent("inspectable")
 
    inst:AddComponent("inventoryitem")
    

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
    inst.components.edible.foodstate = "COOKED"
    inst.components.edible.healthvalue = HEALING_SMALL
    inst.components.edible.hungervalue = CALORIES_TINY
    inst.components.edible.sanityvalue = 0--TUNING.SANITY_SMALL
    inst.components.perishable:SetPerishTime(PERISH_MED)
    inst.AnimState:PlayAnimation("cooked", true)
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    return inst
end 

local function driedfn(sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    inst.AnimState:SetRayTestOnBB(true);    
    inst.AnimState:SetBank("seaweed")
    inst.AnimState:SetBuild("seaweed")
    
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

	inst:AddTag("aquatic")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

  
    
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst:AddComponent("bait")    
    inst:AddComponent("inspectable")
	
	
	inst:AddComponent("inventoryitem")
	


    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
    inst.components.edible.foodstate = "DRIED"
    inst.components.edible.healthvalue = HEALING_SMALL
    inst.components.edible.hungervalue = CALORIES_SMALL
    inst.components.edible.sanityvalue = 0--TUNING.SANITY_SMALL
    inst.components.perishable:SetPerishTime(PERISH_PRESERVED)
    inst.AnimState:SetBank("meat_rack_food")
    inst.AnimState:SetBuild("meat_rack_food")
    inst.AnimState:PlayAnimation("idle_dried_seaweed", true)

	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"    
    return inst
end 

return Prefab( "seaweed", defaultfn, assets, prefabs), 
       Prefab( "seaweed_cooked", cookedfn, assets), 
       Prefab( "seaweed_dried", driedfn, assets)
