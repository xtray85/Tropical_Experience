local assets =
{
    Asset("ANIM", "anim/magic_duct_tape.zip"),
    Asset("ATLAS", "images/magic_duct_tape.xml"),
    Asset("IMAGE", "images/magic_duct_tape.tex"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("magic_duct_tape")
    inst.AnimState:SetBuild("magic_duct_tape")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("mod_disenchanter")

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
    inst.components.inventoryitem.atlasname = "images/magic_duct_tape.xml"
    inst.components.inventoryitem.imagename = "magic_duct_tape"

    inst:AddComponent("modifier_cleaner")

    inst:AddComponent("modifier")

    return inst
end

return Prefab("mod_cleaner", fn, assets)