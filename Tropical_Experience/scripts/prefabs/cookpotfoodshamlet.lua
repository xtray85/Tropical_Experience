local assets =
{
	Asset("ANIM", "anim/asparagussoup.zip"),
	Asset("ANIM", "anim/spicyvegstinger.zip"),
	Asset("ANIM", "anim/feijoada.zip"),
	Asset("ANIM", "anim/steamedhamsandwich.zip"),
	Asset("ANIM", "anim/hardshell_tacos.zip"),
	Asset("ANIM", "anim/gummy_cake.zip"),
	Asset("ANIM", "anim/tea.zip"),
	Asset("ANIM", "anim/icedtea.zip"),
	Asset("ANIM", "anim/snakebonesoup.zip"),
	Asset("ANIM", "anim/nettlelosange.zip"),
	Asset("ANIM", "anim/fruityjuice.zip"),
}

local prefabs = 
{
	"spoiled_food",
}

local function fnasparagussoup(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("asparagussoup")
	inst.AnimState:SetBuild("asparagussoup")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = TUNING.HEALING_MED
	inst.components.edible.hungervalue = TUNING.CALORIES_MEDSMALL
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function fnspicyvegstinger(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("spicyvegstinger")
	inst.AnimState:SetBuild("spicyvegstinger")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_MED
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function fnfeijoada(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("feijoada")
	inst.AnimState:SetBuild("feijoada")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_MED
	inst.components.edible.hungervalue = TUNING.CALORIES_HUGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MED

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FASTISH)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)			
    return inst
end

local function fnsteamedhamsandwich(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("steamedhamsandwich")
	inst.AnimState:SetBuild("steamedhamsandwich")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_LARGE
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MED

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function fnhardshell_tacos(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("hardshell_tacos")
	inst.AnimState:SetBuild("hardshell_tacos")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = TUNING.HEALING_MED
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function fngummy_cake(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("gummy_cake")
	inst.AnimState:SetBuild("gummy_cake")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = -TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_SUPERHUGE
	inst.components.edible.sanityvalue = -TUNING.SANITY_TINY

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function fntea(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("tes")
	inst.AnimState:SetBuild("tea")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_ONE_DAY)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "icedtea"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)	
    return inst
end

local function fnicedtea(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("icedtea")
	inst.AnimState:SetBuild("icedtea")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function fnsnakebonesoup(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("snakebonesoup")
	inst.AnimState:SetBuild("snakebonesoup")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_LARGE
	inst.components.edible.hungervalue = TUNING.CALORIES_MED
	inst.components.edible.sanityvalue = TUNING.SANITY_SMALL

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)	
    return inst
end

local function oneatnettlelosange(inst, eater)
    if eater.components.temperature ~= nil and eater.components.temperature.hayfever then
    eater.components.temperature.hayfever = - 19000
    end
end

local function fnnettlelosange(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("nettlelosange")
	inst.AnimState:SetBuild("nettlelosange")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = TUNING.HEALING_MED
	inst.components.edible.hungervalue = TUNING.CALORIES_MED
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY
    inst.components.edible:SetOnEatenFn(oneatnettlelosange)	

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function oneat(inst, eater)
    if eater.components.temperature ~= nil then
	eater.components.temperature:DoDelta(-30)
    end
end

local function fnfruityjuice(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("fruityjuice")
	inst.AnimState:SetBuild("fruityjuice")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "VEGGIE"
	inst.components.edible.healthvalue = 20
	inst.components.edible.hungervalue = 25
	inst.components.edible.sanityvalue = 33
	inst.components.edible:SetOnEatenFn(oneat)
	
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

return Prefab( "common/inventory/asparagussoup", fnasparagussoup, assets, prefabs ),
	   Prefab( "common/inventory/spicyvegstinger", fnspicyvegstinger, assets, prefabs ),
	   Prefab( "common/inventory/feijoada", fnfeijoada, assets, prefabs ),
	   Prefab( "common/inventory/steamedhamsandwich", fnsteamedhamsandwich, assets, prefabs ),
	   Prefab( "common/inventory/hardshell_tacos", fnhardshell_tacos, assets, prefabs ),
	   Prefab( "common/inventory/gummy_cake", fngummy_cake, assets, prefabs ),
	   Prefab( "common/inventory/tea", fntea, assets, prefabs ),
	   Prefab( "common/inventory/icedtea", fnicedtea, assets, prefabs ),
	   Prefab( "common/inventory/snakebonesoup", fnsnakebonesoup, assets, prefabs ),
	   Prefab( "common/inventory/nettlelosange", fnnettlelosange, assets, prefabs ),
	   Prefab( "common/inventory/fruityjuice", fnfruityjuice, assets, prefabs )	   