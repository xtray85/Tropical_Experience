require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/flotsam_armoured_build.zip"),
    Asset("ANIM", "anim/flotsam_cargo_build.zip"),
    Asset("ANIM", "anim/flotsam_bamboo_build.zip"),
    Asset("ANIM", "anim/flotsam_debris_sw.zip"),
    Asset("ANIM", "anim/flotsam_lograft_build.zip"),
    Asset("ANIM", "anim/flotsam_rowboat_build.zip"),
    Asset("ANIM", "anim/flotsam_surfboard_build.zip"),
}

local prefabs =
{
    
}

local function onhammered(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
--	inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
    inst:Remove()
end

local function fn(build)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)

    inst.AnimState:SetBank("flotsam_debris_sw")
    inst.AnimState:SetBuild("flotsam_armoured_build")
    inst.AnimState:PlayAnimation("idle", true)
	local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(0.8, 0.8, 0.8)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("hauntable")
    inst:AddComponent("inspectable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"boards"})

    return inst
end

local function fn1(build)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)

    inst.AnimState:SetBank("flotsam_debris_sw")
    inst.AnimState:SetBuild("flotsam_cargo_build")
    inst.AnimState:PlayAnimation("idle", true)
	local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(0.8, 0.8, 0.8)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("hauntable")
    inst:AddComponent("inspectable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"boards"})

    return inst
end

local function fn2(build)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)

    inst.AnimState:SetBank("flotsam_debris_sw")
    inst.AnimState:SetBuild("flotsam_bamboo_build")
    inst.AnimState:PlayAnimation("idle", true)
	local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(0.8, 0.8, 0.8)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("hauntable")
    inst:AddComponent("inspectable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"bamboo"})

    return inst
end

local function fn3(build)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)

    inst.AnimState:SetBank("flotsam_debris_sw")
    inst.AnimState:SetBuild("flotsam_lograft_build")
    inst.AnimState:PlayAnimation("idle", true)
	local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(0.8, 0.8, 0.8)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("hauntable")
    inst:AddComponent("inspectable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"log"})

    return inst
end

local function fn4(build)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)

    inst.AnimState:SetBank("flotsam_debris_sw")
    inst.AnimState:SetBuild("flotsam_rowboat_build")
    inst.AnimState:PlayAnimation("idle", true)
	local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(0.8, 0.8, 0.8)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("hauntable")
    inst:AddComponent("inspectable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"boards"})

    return inst
end

local function fn5(build)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)

    inst.AnimState:SetBank("flotsam_debris_sw")
    inst.AnimState:SetBuild("flotsam_surfboard_build")
    inst.AnimState:PlayAnimation("idle", true)
	local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(0.8, 0.8, 0.8)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("hauntable")
    inst:AddComponent("inspectable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"log"})

    return inst
end

local function fn6(build)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeObstaclePhysics(inst, 0.3)

    inst.AnimState:SetBank("flotsam_debris_sw")
    inst.AnimState:SetBuild("flotsam_cargo_build")
    inst.AnimState:PlayAnimation("idle", true)
	local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(0.8, 0.8, 0.8)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.WOOD
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0

    MakeLargeBurnable(inst)
    MakeLargePropagator(inst)

    inst:AddComponent("hauntable")
    inst:AddComponent("inspectable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"limestone"})

    return inst
end

return Prefab("flotsam_armoured_build", fn, assets, prefabs),
       Prefab("flotsam_cargo_build", fn1, assets, prefabs),
       Prefab("flotsam_bamboo_build", fn2, assets, prefabs),
	   Prefab("flotsam_lograft_build", fn3, assets, prefabs),
	   Prefab("flotsam_rowboat_build", fn4, assets, prefabs),
	   Prefab("flotsam_surfboard_build", fn5, assets, prefabs),
 	   Prefab("flotsam_encrusted_build", fn6, assets, prefabs)      
