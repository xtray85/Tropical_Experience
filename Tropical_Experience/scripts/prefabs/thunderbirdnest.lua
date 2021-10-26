local assets =
{
	Asset("ANIM", "anim/thunderbird_nest.zip"),
    Asset("MINIMAP_IMAGE", "thunderbirdnest"),
}

local prefabs =
{
    "thunderbird",
    "iron",
}

local function onpicked(inst, picker)
	inst.thief = picker
	inst.AnimState:PlayAnimation("nest")
	inst.components.childspawner.noregen = true
end

local function onmakeempty(inst)
	inst.AnimState:PlayAnimation("nest")
	inst.components.childspawner.noregen = true
end

local function onregrow(inst)
	inst.AnimState:PlayAnimation("orenest")
end

local function onspawned(inst, child)
    if child.components.homeseeker then
        child.components.homeseeker:SetHome(inst)
    end
end

local function OnSave(inst, data)
end

local function OnLoad(inst, data)
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("thunderbirdnest.png")

    inst.AnimState:SetBuild("thunderbird_nest")
    inst.AnimState:SetBank("thunderbird_nest")
    inst.AnimState:PlayAnimation("orenest", false)
	
    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("pickable")
    --inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
    inst.components.pickable:SetUp("iron", nil)
    inst.components.pickable.onpickedfn = onpicked
    inst.components.pickable.onregenfn = onregrow
    inst.components.pickable.makeemptyfn = onmakeempty

--    MakeMediumBurnable(inst)
--    MakeSmallPropagator(inst)

    -------------------
    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "thunderbird"
    inst.components.childspawner.spawnoffscreen = true
    inst.components.childspawner:SetRegenPeriod(5*16*TUNING.SEG_TIME)
    inst.components.childspawner:SetSpawnPeriod(0)
	inst.components.childspawner:SetSpawnedFn(onspawned)
    inst.components.childspawner:SetMaxChildren(1)
    inst.components.childspawner:StartSpawning()
    -------------------

    inst:AddComponent("inspectable")
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
    return inst
end

return Prefab( "common/objects/thunderbirdnest", fn, assets, prefabs)