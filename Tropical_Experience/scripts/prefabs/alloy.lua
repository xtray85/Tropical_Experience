local assets=
{
	Asset("ANIM", "anim/alloy.zip"),
	Asset("ANIM", "anim/alloygold.zip"),
	Asset("ANIM", "anim/alloystone.zip"),	
}

local function shine(inst)
    inst.task = nil
    if inst.entity:IsAwake() then
        inst:DoTaskInTime(4+math.random()*5, function() shine(inst) end)
    end
end

local function onwake(inst)
    inst.task = inst:DoTaskInTime(4+math.random()*5, function() shine(inst) end)
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	
    inst.AnimState:SetBank("alloy")
    inst.AnimState:SetBuild("alloy")
    inst.AnimState:PlayAnimation("idle")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.hungervalue = 2
    inst:AddComponent("tradable")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("stackable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"	
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
    inst:AddComponent("bait")
    inst:AddTag("molebait")
    inst:AddTag("scarerbait")
	
    inst:AddComponent("fuel")
    inst.components.fuel.fueltype = FUELTYPE.LIVINGARTIFACT
    inst.components.fuel.fuelvalue = 20	
    
    inst.OnEntityWake = onwake

    shine(inst)    
    return inst
end

local function fn2(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.MEDIUM, TUNING.WINDBLOWN_SCALE_MAX.MEDIUM)

	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	
    inst.AnimState:SetBank("alloy")
    inst.AnimState:SetBuild("alloygold")
    inst.AnimState:PlayAnimation("idle")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.hungervalue = 2
    inst:AddComponent("tradable")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("stackable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	
    inst:AddComponent("bait")
    inst:AddTag("molebait")
    inst:AddTag("scarerbait")
    
    inst.OnEntityWake = onwake

    shine(inst)    
    return inst
end

local function fn3(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
	
    inst.AnimState:SetBank("alloy")
    inst.AnimState:SetBuild("alloystone")
    inst.AnimState:PlayAnimation("idle")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.hungervalue = 2
    inst:AddComponent("tradable")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("stackable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	
    inst:AddComponent("bait")
    inst:AddTag("molebait")
    inst:AddTag("scarerbait")
    
    inst.OnEntityWake = onwake

    shine(inst)    
    return inst
end

return Prefab( "common/inventory/alloy", fn, assets),
Prefab( "common/inventory/goldenbar", fn2, assets), 
Prefab( "common/inventory/stonebar", fn3, assets) 
