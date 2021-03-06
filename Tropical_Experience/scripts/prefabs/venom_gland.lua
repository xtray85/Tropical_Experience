local assets =
{
    Asset("ANIM", "anim/venom_gland.zip"),
}

local MAX_VENOM_GLAND_DAMAGE = 80
local MIN_VENOM_GLAND_LEFTOVER = 5

local function oneat(inst, eater)
	
    if eater.components.poisonable then
        eater.components.poisonable:WearOff()
	end
    
	local dmg = MAX_VENOM_GLAND_DAMAGE
    if eater.components.health and eater.components.health.currenthealth <= MAX_VENOM_GLAND_DAMAGE then
    dmg = eater.components.health.currenthealth - MIN_VENOM_GLAND_LEFTOVER
    end
	
	if eater.components.health then
	eater.components.health:DoDelta(-dmg, nil, "venom_gland")	
	end
	
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("venom_gland")
    inst.AnimState:SetBuild("venom_gland")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("cattoy")
    MakeInventoryFloatable(inst)

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

return Prefab("venomgland", fn, assets)