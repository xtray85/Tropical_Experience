local assets =
{
    Asset("ANIM", "anim/quagmire_mushroomstump.zip"),
}

local prefabs =
{
    "quagmire_mushrooms",
}

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("pick")
	inst.AnimState:PushAnimation("idle")
	
	inst.AnimState:OverrideSymbol("a1", "quagmire_mushroomstump", "q")
	inst.AnimState:OverrideSymbol("a2", "quagmire_mushroomstump", "q")
	inst.AnimState:OverrideSymbol("a3", "quagmire_mushroomstump", "q")
	inst.AnimState:OverrideSymbol("a4", "quagmire_mushroomstump", "q")
	inst.AnimState:OverrideSymbol("a5", "quagmire_mushroomstump", "q")
end

local function makefullfn(inst)
	inst.SoundEmitter:PlaySound("dontstarve/common/farm_harvestable")
	inst.AnimState:PlayAnimation("pick")
	inst.AnimState:PushAnimation("idle")
	
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a1", "quagmire_mushroomstump", "b1")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a1", "quagmire_mushroomstump", "c1")
	else
		inst.AnimState:OverrideSymbol("a1", "quagmire_mushroomstump", "a1")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a2", "quagmire_mushroomstump", "b2")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a2", "quagmire_mushroomstump", "c2")
	else
		inst.AnimState:OverrideSymbol("a2", "quagmire_mushroomstump", "a2")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a3", "quagmire_mushroomstump", "b3")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a3", "quagmire_mushroomstump", "c3")
	else
		inst.AnimState:OverrideSymbol("a3", "quagmire_mushroomstump", "a3")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a4", "quagmire_mushroomstump", "b4")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a4", "quagmire_mushroomstump", "c4")
	else
		inst.AnimState:OverrideSymbol("a4", "quagmire_mushroomstump", "a4")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a5", "quagmire_mushroomstump", "b5")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a5", "quagmire_mushroomstump", "c5")
	else
		inst.AnimState:OverrideSymbol("a5", "quagmire_mushroomstump", "a5")
	end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.Transform:SetScale(0.7, 0.7, 0.7)

    MakeSmallObstaclePhysics(inst, .2)
    inst:SetPhysicsRadiusOverride(1.0)

    inst.MiniMapEntity:SetIcon("quagmire_mushroomstump.png")

    inst.AnimState:SetBank("quagmire_mushroomstump")
    inst.AnimState:SetBuild("quagmire_mushroomstump")
    inst.AnimState:PlayAnimation("idle", true)
	
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a1", "quagmire_mushroomstump", "b1")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a1", "quagmire_mushroomstump", "c1")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a2", "quagmire_mushroomstump", "b2")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a2", "quagmire_mushroomstump", "c2")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a3", "quagmire_mushroomstump", "b3")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a3", "quagmire_mushroomstump", "c3")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a4", "quagmire_mushroomstump", "b4")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a4", "quagmire_mushroomstump", "c4")
	end
	if math.random() <= 0.33 then
		inst.AnimState:OverrideSymbol("a5", "quagmire_mushroomstump", "b5")
	elseif math.random() <= 0.66 then
		inst.AnimState:OverrideSymbol("a5", "quagmire_mushroomstump", "c5")
	end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	
	inst:AddComponent("pickable")
	inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
	inst.components.pickable:SetUp("quagmire_mushrooms", TUNING.CAVE_BANANA_GROW_TIME)
	inst.components.pickable.onregenfn = makefullfn
	inst.components.pickable.onpickedfn = makeemptyfn
	inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.makefullfn = makefullfn
	
	inst:AddComponent("hauntable")
	
    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
	
    return inst
end

return Prefab("quagmire_mushroomstump", fn, assets, prefabs)
