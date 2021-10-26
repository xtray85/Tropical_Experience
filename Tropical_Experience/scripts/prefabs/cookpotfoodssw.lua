local assets =
{
--	Asset("ANIM", "anim/cook_pot_swsw.zip"),
	Asset("ANIM", "anim/bananapop.zip"),
	Asset("ANIM", "anim/ceviche.zip"),
	Asset("ANIM", "anim/sweetpotatosouffle.zip"),
	Asset("ANIM", "anim/seafoodgumbo.zip"),
	Asset("ANIM", "anim/surfnturf.zip"),
	Asset("ANIM", "anim/jellyopop.zip"),
	Asset("ANIM", "anim/sharkfinsoup.zip"),
	Asset("ANIM", "anim/musselbouillabaise.zip"),
	Asset("ANIM", "anim/monstertartare.zip"),
	Asset("ANIM", "anim/lobsterdinner.zip"),
	Asset("ANIM", "anim/lobsterbisque.zip"),
	Asset("ANIM", "anim/freshfruitcrepes.zip"),
	Asset("ANIM", "anim/bisque.zip"),
	Asset("ANIM", "anim/californiaroll.zip"),
	Asset("ANIM", "anim/caviar.zip"),
	Asset("ANIM", "anim/tropicalbouillabaisse.zip"),
}

local prefabs = 
{
	"spoiled_food",
}

local function fnbananapop(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("bananapop")
	inst.AnimState:SetBuild("bananapop")
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
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE
	inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP
	inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_AVERAGE
	
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

	
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)	
    return inst
end

local function fnceviche(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("ceviche")
	inst.AnimState:SetBuild("ceviche")
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
	inst.components.edible.hungervalue = TUNING.CALORIES_MED
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY
	inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP
	inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_AVERAGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	
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

local function fnsweetpotatosouffle(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("sweetpotatosouffle")
	inst.AnimState:SetBuild("sweetpotatosouffle")
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
	inst.components.edible.sanityvalue = TUNING.SANITY_MED

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnseafoodgumbo(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("seafoodgumbo")
	inst.AnimState:SetBuild("seafoodgumbo")
	inst.AnimState:PlayAnimation("idle")
			
	inst.entity:SetPristine()

	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_LARGE
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MEDLARGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnsurfnturf(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("surfnturf")
	inst.AnimState:SetBuild("surfnturf")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_HUGE
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnsharkfinsoup(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("sharkfinsoup")
	inst.AnimState:SetBuild("sharkfinsoup")
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
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnmusselbouillabaise(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("musselbouillabaise")
	inst.AnimState:SetBuild("musselbouillabaise")
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
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MED

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnmonstertartare(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("monstertartare")
	inst.AnimState:SetBuild("monstertartare")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_SMALL

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnlobsterbisque(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("lobsterbisque")
	inst.AnimState:SetBuild("lobsterbisque")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_HUGE
	inst.components.edible.hungervalue = TUNING.CALORIES_MED
	inst.components.edible.sanityvalue = TUNING.SANITY_SMALL

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnfreshfruitcrepes(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("freshfruitcrepes")
	inst.AnimState:SetBuild("freshfruitcrepes")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_HUGE
	inst.components.edible.hungervalue = TUNING.CALORIES_SUPERHUGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MED

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnlobsterdinner(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("lobsterdinner")
	inst.AnimState:SetBuild("lobsterdinner")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_HUGE
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_HUGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnbisque(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("bisque")
	inst.AnimState:SetBuild("bisque")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_HUGE
	inst.components.edible.hungervalue = TUNING.CALORIES_MEDSMALL
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fncaliforniaroll(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("californiaroll")
	inst.AnimState:SetBuild("californiaroll")
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
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_SMALL
	
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fnjellyopop(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("jellyopop")
	inst.AnimState:SetBuild("jellyopop")
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
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = 0

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)		
    return inst
end

local function fncaviar(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("caviar")
	inst.AnimState:SetBuild("caviar")
	inst.AnimState:PlayAnimation("idle")
			
	inst:AddTag("preparedfood")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()
    
	if not TheWorld.ismastersim then
		return inst
	end
	

	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

local function fntropicalbouillabaisse(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("tropicalbouillabaisse")
	inst.AnimState:SetBuild("tropicalbouillabaisse")
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
	inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MED

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

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

return Prefab( "common/inventory/bananapop", fnbananapop, assets, prefabs ),
	   Prefab( "common/inventory/ceviche", fnceviche, assets, prefabs ),
	   Prefab( "common/inventory/sweetpotatosouffle", fnsweetpotatosouffle, assets, prefabs ),
--	   Prefab( "common/inventory/seafoodgumbo", fnseafoodgumbo, assets, prefabs ),
--	   Prefab( "common/inventory/surfnturf", fnsurfnturf, assets, prefabs ),
	   Prefab( "common/inventory/jellyopop", fnjellyopop, assets, prefabs ),
	   Prefab( "common/inventory/sharkfinsoup", fnsharkfinsoup, assets, prefabs ),
	   Prefab( "common/inventory/musselbouillabaise", fnmusselbouillabaise, assets, prefabs ),
	   Prefab( "common/inventory/monstertartare", fnmonstertartare, assets, prefabs ),
	   Prefab( "common/inventory/lobsterdinner", fnlobsterdinner, assets, prefabs ),
	   Prefab( "common/inventory/lobsterbisque", fnlobsterbisque, assets, prefabs ),
	   Prefab( "common/inventory/freshfruitcrepes", fnfreshfruitcrepes, assets, prefabs ),
	   Prefab( "common/inventory/bisque", fnbisque, assets, prefabs ),
--	   Prefab( "common/inventory/californiaroll", fncaliforniaroll, assets, prefabs ),
	   Prefab( "common/inventory/caviar", fncaviar, assets, prefabs ),
	   Prefab( "common/inventory/tropicalbouillabaisse", fntropicalbouillabaisse, assets, prefabs )