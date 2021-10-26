local assets=
{
	Asset("ANIM", "anim/fennel.zip"),
	Asset("ANIM", "anim/onion_planted.zip"),
}

local prefabs=
{
	"fennel",
}

local function onpicked(inst)
    TheWorld:PushEvent("beginregrowth", inst)
    inst:Remove()
end

local function fn()
    --Carrot you eat is defined in veggies.lua
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("fennel")
    inst.AnimState:SetBuild("fennel")
    inst.AnimState:PlayAnimation("planted")
    inst.AnimState:SetRayTestOnBB(true)
	inst.Transform:SetScale(0.7, 0.7, 0.7)		

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("fennel", 10)
    inst.components.pickable.onpickedfn = onpicked

    inst.components.pickable.quickpick = true

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end

local function fn1(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeSmallPropagator(inst)	
    MakeInventoryPhysics(inst)
		
	inst.AnimState:SetBank("fennel")
	inst.AnimState:SetBuild("fennel")
	inst.AnimState:PlayAnimation("idle")
	inst:AddTag("aquatic")
	inst.Transform:SetScale(0.7, 0.7, 0.7)		
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst.entity:SetPristine()
	
	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.VEGGIE
	inst.components.edible.healthvalue = TUNING.HEALING_TINY
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = 0
			
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

	inst:AddComponent("cookable")
    inst.components.cookable.product="fennel_cooked"

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
	
	end

local function fn2(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeSmallPropagator(inst)	
    MakeInventoryPhysics(inst)
		
	inst.AnimState:SetBank("fennel")
	inst.AnimState:SetBuild("fennel")
	inst.AnimState:PlayAnimation("cooked")
	inst:AddTag("aquatic")
	inst.Transform:SetScale(0.7, 0.7, 0.7)	
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst.entity:SetPristine()
	
	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.VEGGIE
	inst.components.edible.healthvalue = TUNING.HEALING_TINY
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = 0
			
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

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
	
	end
	
local function fnonion()
    --Carrot you eat is defined in veggies.lua
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("onion_planted")
    inst.AnimState:SetBuild("onion_planted")
    inst.AnimState:PlayAnimation("planted")
    inst.AnimState:SetRayTestOnBB(true)
	inst.Transform:SetScale(1, 1, 1)		

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("onion", 10)
    inst.components.pickable.onpickedfn = onpicked

    inst.components.pickable.quickpick = true

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end	

return Prefab( "fennel_planted", fn, assets),
	   Prefab( "fennel_cooked", fn2, assets),
	   Prefab( "fennel", fn1, assets, prefabs ),
	   Prefab( "onion_planted", fnonion, assets)
