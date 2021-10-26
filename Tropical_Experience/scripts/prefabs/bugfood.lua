require "prefabs/veggies"
local assets =
{
    jellybug = { Asset("ANIM", "anim/jellybug.zip"), },
    slugbug = { Asset("ANIM", "anim/slugbug.zip"), },

    jellybug_cooked = { Asset("ANIM", "anim/jellybug_cooked.zip"), },
    slugbug_cooked = { Asset("ANIM", "anim/slugbug_cooked.zip"), },
}

local prefabs =
{
    jellybug =
    {
        "jellybug_cooked",
        "spoiled_food",
    },

    slugbug =
    {
        "slugbug_cooked",
        "spoiled_food",
    }
}

local function jellybug_raw()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)
    
    inst.AnimState:SetBank("jellybug")
    inst.AnimState:SetBuild("jellybug")
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:PlayAnimation("idle", true)

	MakeInventoryFloatable(inst)	

	inst:AddTag("frogbait")  
    inst:AddTag("monstermeat")
 
    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
 
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "VEGGIE"
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL

    inst:AddComponent("bait")
    
    inst:AddComponent("cookable")
    inst.components.cookable.product = "jellybug_cooked"

	inst:AddComponent("bait")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")

  
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    return inst

end

local function jellybug_cooked()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)
    
    inst.AnimState:SetBank("jellybug_cooked")
    inst.AnimState:SetBuild("jellybug_cooked")
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:PlayAnimation("cooked", true)

	inst:AddTag("frogbait")  
    inst:AddTag("monstermeat")
	
	MakeInventoryFloatable(inst)
 
    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
 
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
    inst.components.edible.sanityvalue = -TUNING.SANITY_TINY

    inst:AddComponent("bait")
    
    inst:AddComponent("cookable")
    inst.components.cookable.product = "jellybug_cooked"

	inst:AddComponent("bait")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")

  
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    return inst

end

local function slugbug_raw()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)
    
    inst.AnimState:SetBank("slugbug")
    inst.AnimState:SetBuild("slugbug")
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("monstermeat")
	
	MakeInventoryFloatable(inst)
	
    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
 
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL

    inst:AddComponent("cookable")
    inst.components.cookable.product = "slugbug_cooked"

    inst:AddComponent("bait")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    return inst
end

local function slugbug_cooked()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)
    
    inst.AnimState:SetBank("slugbug_cooked")
    inst.AnimState:SetBuild("slugbug_cooked")
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:PlayAnimation("cooked", true)

    inst:AddTag("monstermeat")
	MakeInventoryFloatable(inst)
	
    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
 
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
    inst.components.edible.sanityvalue = -TUNING.SANITY_TINY

    inst:AddComponent("bait")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    return inst

end

return Prefab("common/inventory/jellybug", jellybug_raw, assets.jellybug, prefabs.jellybug),
       Prefab("common/inventory/jellybug_cooked", jellybug_cooked, assets.jellybug_cooked),
       Prefab("common/inventory/slugbug", slugbug_raw, assets.slugbug, prefabs.slugbug),
       Prefab("common/inventory/slugbug_cooked", slugbug_cooked, assets.slugbug_cooked)