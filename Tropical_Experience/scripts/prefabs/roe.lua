require "prefabs/roe_fish"
local assets=
{
	Asset("ANIM", "anim/roe.zip"),
}

local prefabs =
{

}    

local SEEDS_GROW_TIME = 300*6

for k,v in pairs(ROE_FISH) do
    if v.createPrefab then
	   table.insert(prefabs, k)
    end
end

local function pickproduct(inst)
	
	local total_w = 0

	for k,v in pairs(ROE_FISH) do
		total_w = total_w + (v.seedweight or 1)
	end

	local rnd = math.random()*total_w
	for k,v in pairs(ROE_FISH) do        
		rnd = rnd - (v.seedweight or 1)
        if rnd <= 0 then
            return k
        end                
	end
	
	return "fish2"
end


local function raw()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()    
    MakeInventoryPhysics(inst)
--    MakeInventoryFloatable(inst, "idle_water", "idle")    
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)
    
    inst.AnimState:SetBank("roe")
    inst.AnimState:SetBuild("roe")
    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:PlayAnimation("idle")

    inst:AddTag("roe")
	MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
	
	inst:AddTag("oceanfishing_lure")	
    inst:AddTag("spawnnosharx")

    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY/2
    
    inst:AddComponent("cookable")
    inst.components.cookable.product = "roe_cooked"

	inst:AddComponent("bait")
    inst:AddComponent("seedable")
    inst.components.seedable.growtime = SEEDS_GROW_TIME
    inst.components.seedable.product = pickproduct
	
	inst:AddComponent("oceanfishingtackle")
	inst.components.oceanfishingtackle:SetupLure({build = "oceanfishing_lure_mis", symbol = "hook_seeds", single_use = true, lure_data = { charm = 0.3, reel_charm = -0.3, radius = 3.0, style = "rot", timeofday = {day = 1, dusk = 1, night = 1}, dist_max = 2 }})
	
     
    return inst
end

local function cooked()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()    
    MakeInventoryPhysics(inst)
--    MakeInventoryFloatable(inst, "cooked_water", "cooked")    

--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)
    
    inst.AnimState:SetBank("roe")
    inst.AnimState:SetBuild("roe")
    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:PlayAnimation("cooked")
    
    inst:AddTag("spawnnosharx")
	inst:AddTag("oceanfishing_lure")
	
	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = 0
    inst.components.edible.foodstate = "COOKED"
	inst.components.edible.hungervalue = TUNING.CALORIES_TINY/2
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERFAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)	
	
	inst:AddComponent("oceanfishingtackle")
	inst.components.oceanfishingtackle:SetupLure({build = "oceanfishing_lure_mis", symbol = "hook_seeds", single_use = true, lure_data = { charm = 0.3, reel_charm = -0.3, radius = 3.0, style = "rot", timeofday = {day = 1, dusk = 1, night = 1}, dist_max = 2 }})
	
 
    return inst
end

return Prefab( "shipwrecked/roe", raw, assets, prefabs),
       Prefab( "shipwrecked/roe_cooked", cooked, assets, prefabs)              
