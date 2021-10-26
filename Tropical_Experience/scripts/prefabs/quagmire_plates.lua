local function MakePlate(basedish, dishtype, assets)
    local assets =
    {
        Asset("ANIM", "anim/quagmire_generic_"..basedish..".zip"),
        Asset("ATLAS", "images/quagmire_food_common_inv_images.xml"),
        Asset("IMAGE", "images/quagmire_food_common_inv_images.tex"),
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)
        inst.AnimState:SetBank("quagmire_generic_"..basedish)
        inst.AnimState:SetBuild("quagmire_generic_"..basedish)
        inst.AnimState:SetScale(0.6, 0.6, 0.6)
        local buildoverride = "quagmire_generic_"..basedish
        if dishtype ~= "generic" and dishtype ~= "silver" then
            buildoverride = "quagmire_" .. dishtype .. "_" .. basedish
        end
        inst.AnimState:OverrideSymbol("generic_"..basedish, buildoverride, dishtype.."_"..basedish)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("replater")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        local imagename = dishtype == "generic" and basedish or (basedish .. "_" .. dishtype)

            inst.components.inventoryitem.imagename = imagename
            inst.components.inventoryitem.atlasname = "images/quagmire_food_common_inv_images.xml"

        inst:AddComponent("replater")
        inst.components.replater:SetUp(basedish, dishtype)

        inst:AddComponent("stackable")

        return inst
    end

    return Prefab(basedish.."_"..dishtype, fn, assets)
end

return MakePlate("plate", "silver"),
    MakePlate("bowl", "silver")