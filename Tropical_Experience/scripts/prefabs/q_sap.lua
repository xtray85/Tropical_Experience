local assets =
{
    Asset("ANIM", "anim/quagmire_sap.zip"),
}

local prefabs =
{
    "spoiled_food",
}

local function MakeSap(name, fresh)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBuild("quagmire_sap")
        inst.AnimState:SetBank("quagmire_sap")
        inst.AnimState:PlayAnimation(fresh and "idle" or "idle_spoiled")

		inst:AddTag("honeyed")
		inst:AddTag("sweetener")

		MakeInventoryFloatable(inst, "med", nil, 0.8)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

--    inst:AddComponent("edible")
--    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
--    inst.components.edible.hungervalue = TUNING.CALORIES_TINY

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("inventoryitem")

    MakeHauntableLaunchAndPerish(inst)

        return inst
    end

    return Prefab(name, fn, assets, fresh and prefabs or nil)
end

return MakeSap("quagmire_sap", true)
