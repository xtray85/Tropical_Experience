local assets=
{
	Asset("ANIM", "anim/pig_coin_silver.zip"),
}

local prefabs =
{

}

local function shine(inst)
    inst.task = nil
    if inst.entity:IsAwake() then
       inst:DoTaskInTime(4 + math.random() * 5, shine)
    end
end

local function onwake(inst)
    inst.task = inst:DoTaskInTime(4+math.random()*5, function() shine(inst) end)
end

local function fn(Sim)
    
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()
    inst.entity:AddNetwork()

    inst.OnEntityWake = onwake

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)
  --  MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.MEDIUM, TUNING.WINDBLOWN_SCALE_MAX.MEDIUM)

	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )    
	
    inst.AnimState:SetBank("coin")
    inst.AnimState:SetBuild("pig_coin_silver")
    inst.AnimState:PlayAnimation("idle")
	
    inst:AddTag("molebait")
    inst:AddTag("oinc")

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.hungervalue = 1
    
--    inst:AddComponent("currency")
    
    inst:AddComponent("inspectable")
     
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

    inst:AddComponent("bait")
    inst.oincvalue = 10

    inst:AddComponent("tradable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
    
    return inst
end

return Prefab( "common/inventory/oinc10", fn, assets, prefabs)
