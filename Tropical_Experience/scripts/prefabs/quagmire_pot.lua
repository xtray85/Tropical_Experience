local prefabs =
{
    "quagmire_food",
    "quagmire_burnt_ingredients",
}

local function OnEntityReplicated(inst)
    if inst.replica.container ~= nil then
        inst.replica.container:WidgetSetup(inst.prefab)
    end
end

local function MakePot(suffix, goop_suffix, numslots, tag)
    local name = "pot"..suffix
    local animname = "quagmire_" .. name
    local assets =
    {
        Asset("ANIM", "anim/quagmire_pot_hanger.zip"),
        Asset("ANIM", "anim/"..animname..".zip"),
        Asset("ANIM", "anim/quagmire_ui_pot_1x"..tostring(numslots)..".zip"),
        Asset("INV_IMAGE", animname.."_overcooked"),
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)
        inst.AnimState:SetBank(animname)
        inst.AnimState:SetBuild(animname)
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:OverrideSymbol("goop"..goop_suffix, "quagmire_pot_hanger", "goop"..goop_suffix)
        inst.AnimState:Hide("goop")

        inst:AddTag("quagmire_stewer")
        inst:AddTag("quagmire_pot")

        if tag ~= nil then
            inst:AddTag(tag)
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            inst.OnEntityReplicated = OnEntityReplicated

            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = animname

        inst:AddComponent("container")
        inst.components.container:WidgetSetup(name)

        inst:AddComponent("specialstewer_dish")
        inst.components.specialstewer_dish:SetDishType("pot")

        -- event_server_data("quagmire", "prefabs/quagmire_pot").master_postinit(inst, suffix, numslots)

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

--For searching: "quagmire_pot", "quagmire_pot_small", "quagmire_pot_syrup"
return MakePot("", "", 4),
    MakePot("_small", "", 3),
    MakePot("_syrup", "_syrup", 3, "quagmire_syrup_cooker")
