
local function create_light(eater, lightprefab)
    if eater.wormlight ~= nil then
        if eater.wormlight.prefab == lightprefab then
            eater.wormlight.components.spell.lifetime = 0
            eater.wormlight.components.spell:ResumeSpell()
            return
        else
            eater.wormlight.components.spell:OnFinish()
        end
    end

    local light = SpawnPrefab(lightprefab)
    light.components.spell:SetTarget(eater)
    if light:IsValid() then
        if light.components.spell.target == nil then
            light:Remove()
        else
            light.components.spell:StartSpell()
        end
    end
end


local function item_oneaten(inst, eater)
    create_light(eater, "wormlight_light")
end

local assets=
{
	Asset("ANIM", "anim/dragoon_heart.zip"),
}

local prefabs =
{
    "wormlight_light",
}

local function item_commonfn(bank, build, masterfn)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("dragoon_heart")
    inst.AnimState:SetBuild("dragoon_heart")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    MakeInventoryPhysics(inst)

    inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetRadius(0.5)
    inst.Light:SetColour(169/255, 231/255, 245/255)
    inst.Light:Enable(true)

    inst:AddTag("lightbattery")
    inst:AddTag("vasedecoration")
	MakeInventoryFloatable(inst)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "dragoonheart"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("tradable")
    inst:AddComponent("vasedecoration")
    inst:AddComponent("edible")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("fuel")
    inst.components.fuel.fueltype = FUELTYPE.WORMLIGHT

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

    if masterfn ~= nil then
        masterfn(inst)
    end

    return inst
end

local function itemfn()
    return item_commonfn(
        "dragoon_heart",
        "dragoon_heart",
        function(inst)
            inst.components.edible.foodtype = FOODTYPE.MEAT
            inst.components.edible.healthvalue = TUNING.HEALING_MEDSMALL + TUNING.HEALING_SMALL
            inst.components.edible.hungervalue = TUNING.CALORIES_MED
            inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL
            inst.components.edible:SetOnEatenFn(item_oneaten)

            inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL * 1.33
        end
    )
end

return  Prefab("dragoonheart", itemfn, assets, prefabs)