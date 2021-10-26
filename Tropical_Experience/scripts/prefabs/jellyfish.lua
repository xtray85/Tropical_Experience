local assets=
{
	Asset("ANIM", "anim/jellyfish.zip"),
--    Asset("ANIM", "anim/meat_rack_food.zip"),
--    Asset("INV_IMAGE", "jellyJerky"),
}


local prefabs=
{
    "jellyfish_planted",
}

local	    JELLYFISH_WALK_SPEED = 2
local	    JELLYFISH_DAMAGE = 0
local	    JELLYFISH_HEALTH = 50
local 		total_day_time = 480
local      JELLYFISH_HEALTH = 50

PERISH_ONE_DAY = total_day_time

local function playshockanim(inst)
    if inst:HasTag("aquatic") then
        inst.AnimState:PlayAnimation("idle_water_shock")
        inst.AnimState:PushAnimation("idle_water", true)
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_water")
    else
        inst.AnimState:PlayAnimation("idle_ground_shock")
        inst.AnimState:PushAnimation("idle_ground", true)
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_land")
    end
	local pclose = GetClosestInstWithTag("player", inst, 2)
	if pclose and pclose.components.health then
	pclose.components.health:DoDelta(-5)
	pclose.sg:GoToState("electrocute")
	end		
end

local function playDeadAnimation(inst)
    inst.AnimState:PlayAnimation("idle_ground", true) 
end 

local function ondropped(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))   

if ground == GROUND.OCEAN_COASTAL or 
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_COASTAL_SHORE or 
ground == GROUND.OCEAN_SWELL or 
ground == GROUND.OCEAN_ROUGH or 
ground == GROUND.OCEAN_BRINEPOOL or 
ground == GROUND.OCEAN_BRINEPOOL_SHORE or 
ground == GROUND.OCEAN_HAZARDOUS then
if not inst.replica.inventoryitem:IsHeld() then
local replacement = SpawnPrefab("jellyfish_planted")
replacement.Transform:SetPosition(inst.Transform:GetWorldPosition())
inst:Remove()
end 
end
end

local function onpickup(inst, pickupguy)
    if inst:HasTag("stinger") and pickupguy.components.combat and pickupguy.components.inventory then
        if not pickupguy.components.inventory:IsInsulated() then
            pickupguy.components.health:DoDelta(-JELLYFISH_DAMAGE)
            if pickupguy:HasTag("player") then
                pickupguy.sg:GoToState("electrocute")
            end
        end
        inst:RemoveTag("stinger")
    end

    if inst.shocktask then
        inst.shocktask:Cancel()
        inst.shocktask = nil
    end
end

local function defaultfn(sim)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    inst.AnimState:SetRayTestOnBB(true);    
    inst.AnimState:SetBank("jellyfish")
    inst.AnimState:SetBuild("jellyfish")

    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )
	MakeInventoryFloatable(inst)
	inst:AddTag("show_spoilage")
		
		
	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    inst:AddComponent("perishable")
  
    inst:AddComponent("tradable")

    inst.components.perishable:SetPerishTime(PERISH_ONE_DAY * 1.5)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "jellyfish_dead"

    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPickupFn(onpickup)
    inst.AnimState:PlayAnimation("idle_ground", true)

    inst:AddComponent("cookable")
    inst.components.cookable.product = "jellyfish_cooked"
   
    inst:AddComponent("health")
    inst.components.health.murdersound = "dontstarve_DLC002/creatures/jellyfish/death_murder"


    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"jellyfish_dead"}) --Replace with dead jelly
	
		inst:DoTaskInTime(0, ondropped)	

    return inst

end 

local function deadfn(sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    inst.AnimState:SetRayTestOnBB(true);    
    inst.AnimState:SetBank("jellyfish")
    inst.AnimState:SetBuild("jellyfish")
	inst.AnimState:PlayAnimation("idle_ground", true)

    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )
	MakeInventoryFloatable(inst)
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    inst.components.inventoryitem:SetOnPickupFn(onpickup)
    inst:AddComponent("perishable")
  
    inst:AddComponent("tradable")

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"


    inst:AddComponent("cookable")
    inst.components.cookable.product = "jellyfish_cooked"

    inst:AddComponent("dryable")
    inst.components.dryable:SetProduct("jellyjerky")
    inst.components.dryable:SetDryTime(TUNING.DRY_FAST)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    return inst
end


local function cookedfn(sim)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    inst.AnimState:SetRayTestOnBB(true);    
    inst.AnimState:SetBank("jellyfish")
    inst.AnimState:SetBuild("jellyfish")
	inst.AnimState:PlayAnimation("cooked", true)
	
	MakeInventoryFloatable(inst)	

    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    inst:AddComponent("perishable")
  
    inst:AddComponent("tradable")

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
    inst.components.edible.foodstate = "COOKED"
    inst.components.edible.hungervalue = TUNING.CALORIES_MEDSMALL
    inst.components.edible.sanityvalue = 0--TUNING.SANITY_SMALL
    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM
    return inst 
end 

local function driedfn(sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    inst.AnimState:SetRayTestOnBB(true);    
    inst.AnimState:SetBank("meat_rack_food")
    inst.AnimState:SetBuild("meat_rack_food")
    inst.AnimState:PlayAnimation("idle_dried_large", true)

    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )
	
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

        if not TheWorld.ismastersim then
        return inst
    end	
	
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    inst:AddComponent("perishable")
  
    inst:AddComponent("tradable")
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
    inst.components.edible.foodstate = "DRIED"
    inst.components.edible.hungervalue = TUNING.CALORIES_MEDSMALL
    inst.components.edible.sanityvalue = 0--TUNING.SANITY_SMALL
    inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
    

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM
    return inst

end 

return Prefab( "common/inventory/jellyfish", defaultfn, assets), 
       Prefab( "common/inventory/jellyfish_dead", deadfn, assets), 
       Prefab( "common/inventory/jellyfish_cooked", cookedfn, assets), 
       Prefab( "common/inventory/jellyjerky", driedfn, assets)