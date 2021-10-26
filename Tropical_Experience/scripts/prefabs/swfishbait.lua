require "prefabs/veggies"
require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/swfishbait.zip"),
	Asset("ANIM", "anim/oceanfishing_lure_mis.zip"),
}

local prefabs =
{
    "spoiled_food",
}


local function raw()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("swfishbait")
    inst.AnimState:SetBuild("swfishbait")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetRayTestOnBB(true)

	inst:AddTag("oceanfishing_lure")
	inst:AddTag("swfishbait")		

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"		
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndPerish(inst)

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("oceanfishingtackle")
	inst.components.oceanfishingtackle:SetupLure({build = "oceanfishing_lure_mis", symbol = "hook_seeds", single_use = true, lure_data = { charm = 0.2, reel_charm = -0.3, radius = 3.0, style = "swfish", timeofday = {day = 1, dusk = 1, night = 1}, dist_max = 1 }})
	

    return inst
end

return Prefab("swbait", raw, assets, prefabs)
