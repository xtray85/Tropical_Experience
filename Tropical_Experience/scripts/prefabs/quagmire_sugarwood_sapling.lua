local assets =
{
    Asset("ANIM", "anim/sugarwood_seed.zip"),
	
	Asset( "IMAGE", "images/inventoryimages/sugarwood_seed.tex" ),
	Asset( "ATLAS", "images/inventoryimages/sugarwood_seed.xml" ),
}

local function growintotree(inst)
    local tree = SpawnPrefab("sugarwood_short")
	
    if tree then
        tree.Transform:SetPosition(inst.Transform:GetWorldPosition())
		tree.SoundEmitter:PlaySound("dontstarve/forest/treeGrow")
		SpawnPrefab("purple_leaves_chop").Transform:SetPosition(inst.Transform:GetWorldPosition())
        inst:Remove()
    end
end

local function startgrowing(inst)
    if not inst.components.timer:TimerExists("grow") then
        local growtime = GetRandomWithVariance(360, 30)

        inst.components.timer:StartTimer("grow", growtime)
    end
end

local function isburning(inst)
    inst.components.timer:StopTimer("grow")
end

local function resumegrowing(inst)
    if not inst.components.timer:TimerExists("grow") then
        local growtime = GetRandomWithVariance(360, 30)

        inst.components.timer:StartTimer("grow", growtime)
    end
end

local function ontimerdone(inst, data)
    if data.name == "grow" then
        growintotree(inst)
    end
end

local function dig(inst, digger)
    inst.components.lootdropper:SpawnLootPrefab("twigs")
	
    inst:Remove()
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("sugarwood_seed")
	inst.AnimState:SetBuild("sugarwood_seed")
	inst.AnimState:PlayAnimation("idle_planted")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	
	inst:AddComponent("timer")

	inst:AddComponent("lootdropper")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig)
	inst.components.workable:SetWorkLeft(1)

	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	MakeSmallPropagator(inst)

	MakeHauntableIgnite(inst)
	
	inst:ListenForEvent("timerdone", ontimerdone)
	inst:ListenForEvent("onignite", isburning)
	inst:ListenForEvent("onextinguish", resumegrowing)
	
	inst:DoTaskInTime(0, startgrowing)

	return inst
end

local function ondeploy(inst, pt, deployer)
	local sapling = SpawnPrefab("sugarwood_sapling") 
	
	if sapling then 
		deployer.SoundEmitter:PlaySound("dontstarve/common/plant")
		sapling.Transform:SetPosition(pt.x, pt.y, pt.z) 
	end 
end

local function seed_fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("sugarwood_seed")
	inst.AnimState:SetBuild("sugarwood_seed")
	inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sugarwood_seed.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("deployable")
	inst.components.deployable.ondeploy = ondeploy
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)

	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
	MakeSmallPropagator(inst)

	MakeHauntableIgnite(inst)

	return inst
end

return Prefab("sugarwood_sapling", fn, assets),
	Prefab("sugarwood_seed", seed_fn, assets),
	MakePlacer("sugarwood_seed_placer", "sugarwood_seed", "sugarwood_seed", "idle_planted")
