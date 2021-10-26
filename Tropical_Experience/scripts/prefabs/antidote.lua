local assets =
{
    Asset("ANIM", "anim/poison_antidote.zip"),
}

local function oneat(inst, eater)
    if eater.components.poisonable ~= nil then
        eater.components.poisonable:WearOff()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("poison_antidote")
    inst.AnimState:SetBuild("poison_antidote")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("aquatic")
	inst:AddTag("preparedfood")	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)

    ---------------------

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("stackable")
    inst:AddComponent("tradable")

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.sanityvalue = 0
    inst.components.edible.temperaturedelta = 0
    inst.components.edible.temperatureduration = 0
    inst.components.edible:SetOnEatenFn(oneat)

    return inst
end

return Prefab("antidote", fn, assets)