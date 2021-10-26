local assets =
{
    Asset("ANIM", "anim/quagmire_crate.zip"),
}

local KIT_NAMES =
{
    "pot_hanger",
    "oven",
    "grill_small",
    "grill",
}
local KITS = table.invert(KIT_NAMES)

local KIT_ITEMS =
{
    ["pot_hanger"] =
    {
        "pot_hanger_item",
        "pot_small",
    },
    ["oven"] =
    {
        "oven_item",
        "casseroledish_small",
    },
    ["grill_small"] =
    {
        "grill_small_item",
    },
    ["grill"] =
    {
        "grill_item",
    },
}

local function GetItemData(id)
    local data = {}
    for _, itemprefab in ipairs(KIT_ITEMS[id]) do
        local item = SpawnPrefab(itemprefab)
        if item then
            local record = item:GetSaveRecord()
            table.insert(data, record)
            item:Remove()
        end
    end
    return data
end

local function OnUnwrapped(inst, pos, doer)
    inst.AnimState:PlayAnimation("unwrapped")
    inst:DoTaskInTime(0.5, function() inst:Remove() end)
end

local function GetIndexFromKitNames(name)
    for i, v in ipairs(KIT_NAMES) do
        if v == name then
            return i
        end
    end
end

local function MakeCrate(kit)
    local prefabs
    local name = "quagmire_crate"..(kit ~= nil and ("_"..kit) or "")
    if kit ~= nil then
        prefabs =
        {

        }
    else
        prefabs =
        {
            "ash",
            "quagmire_crate_unwrap",
        }
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)		

        inst.AnimState:SetBank("quagmire_crate")
        inst.AnimState:SetBuild("quagmire_crate")
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("bundle")

        --unwrappable (from unwrappable component) added to pristine state for optimization
        inst:AddTag("unwrappable")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")

        inst:AddComponent("unwrappable")
        inst.components.unwrappable.itemdata = GetItemData(kit)
        inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)



        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local ret =
{
    MakeCrate(),
}
for i, v in ipairs(KIT_NAMES) do
    table.insert(ret, MakeCrate(v))
end
return unpack(ret)
