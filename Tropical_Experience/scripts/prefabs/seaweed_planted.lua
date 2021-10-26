local assets=
{
	Asset("ANIM", "anim/seaweed.zip"),
	Asset("ANIM", "anim/meat_rack_food.zip"),
}		
local prefabs =
{
    "seaweed_planted",
    "seaweed_cooked",
    "seaweed_dried",
}

local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
        end

        inst.components.lootdropper:SpawnLootPrefab(
            (withered) and
            "seaweed" or
            "dug_seaweed"
        )
    end
    inst:Remove()
end

local function onpickedfn(inst, picker)
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked", true)
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle_plant", true)
end

local function makeemptyfn(inst)
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked", true)
end

local function makebarrenfn(inst, wasempty)
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked", true)
end

local function makefullfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle_plant", true)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("seaweed.png" )
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
--	inst.AnimState:SetSortOrder(0)
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetBank("seaweed")
    inst.AnimState:SetBuild("seaweed")
    inst.AnimState:PlayAnimation("idle_plant", true)

    inst:AddTag("renewable")
	inst:AddTag("seaweednarede")
    inst:AddTag("witherable")
	inst:AddTag("ignorewalkableplatforms")
	inst:AddTag("plant")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve_DLC002/common/item_wet_harvest"

    inst.components.pickable:SetUp("seaweed", TUNING.SAPLING_REGROW_TIME)
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.makebarrenfn = makebarrenfn
	inst.components.pickable.makefullfn = makefullfn

    inst:AddComponent("witherable")

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    return inst
end

return Prefab("seaweed_planted", fn, assets, prefabs)