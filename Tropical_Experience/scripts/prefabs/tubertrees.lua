local assets =
{
	Asset("ANIM", "anim/tuber_tree_build.zip"),
	Asset("ANIM", "anim/tuber_bloom_build.zip"),

	Asset("ANIM", "anim/tuber_tree.zip"),
	Asset("ANIM", "anim/dust_fx.zip"),
	Asset("SOUND", "sound/forest.fsb"),
	--Asset("INV_IMAGE", "jungleTreeSeed"),
	Asset("MINIMAP_IMAGE", "tuber_trees"),
}

local prefabs =
{
    "tuber_crop",
    "charcoal",
}

SetSharedLootTable( 'tubertree',
{
    {'tuber_crop',  1.0},
    {'tuber_crop',  1.0},
    {'tuber_crop',  1.0},	
})

SetSharedLootTable( 'tubertree_bloom',
{
    {'tuber_bloom_crop',  1.0},
    {'tuber_bloom_crop',  1.0},
    {'tuber_bloom_crop',  1.0},	
})

local function sway(inst)
    inst.AnimState:PushAnimation("sway2_loop_tall", true)
end

local function chop_tree(inst, chopper, chops)
    if not (chopper ~= nil and chopper:HasTag("playerghost")) then
        inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
    end
    inst.AnimState:PlayAnimation("chop_tall")
    sway(inst)
end

local function set_stump(inst)
    inst:RemoveComponent("workable")
    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
    inst:RemoveComponent("hauntable")
    if not inst:HasTag("burnt") then
        MakeSmallBurnable(inst)
        MakeSmallPropagator(inst)
        MakeHauntableIgnite(inst)
    end
    RemovePhysicsColliders(inst)
    inst:AddTag("stump")
    inst.MiniMapEntity:SetIcon("tuber_trees.png")
end

local function dig_up_stump(inst, chopper)
	inst.components.lootdropper:SpawnLootPrefab("tuber_crop")
	
	if inst.components.mystery and inst.components.mystery.investigated then
		inst.components.lootdropper:SpawnLootPrefab(inst.components.mystery.reward)
	end	
	inst:Remove()
end

local function chop_down_tree(inst, chopper)
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")
    if not (chopper ~= nil and chopper:HasTag("playerghost")) then
        inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
    end
    inst.AnimState:PlayAnimation("fallleft_tall")
    inst.AnimState:PushAnimation("stump_tall", false)
    set_stump(inst)
    inst.components.lootdropper:DropLoot()

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(dig_up_stump)
    inst.components.workable:SetWorkLeft(1)
end

local function chop_down_burnt_tree(inst, chopper)
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")
    if not (chopper ~= nil and chopper:HasTag("playerghost")) then
        inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
    end
    inst.AnimState:PlayAnimation("chop_burnt_tall")
    set_stump(inst)
    RemovePhysicsColliders(inst)
    inst:ListenForEvent("animover", inst.Remove)
    inst.components.lootdropper:DropLoot()
end

local function OnBurnt(inst)
    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
    inst:RemoveComponent("hauntable")
    MakeHauntableWork(inst)

    inst.components.lootdropper:SetLoot({"charcoal"})

    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(nil)
    inst.components.workable:SetOnFinishCallback(chop_down_burnt_tree)
    inst.AnimState:PlayAnimation("burnt_tall", true)
    inst:AddTag("burnt")
    inst.MiniMapEntity:SetIcon("tuber_trees.png")
end

local function inspect_tree(inst)
    return (inst:HasTag("burnt") and "BURNT")
        or (inst:HasTag("stump") and "CHOPPED")
        or (inst.components.burnable ~= nil and
            inst.components.burnable:IsBurning() and
            "BURNING")
        or nil
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
    if inst:HasTag("stump") then
        data.stump = true
    end
end

local function onload(inst, data)
    if data ~= nil then
        if data.stump then
            set_stump(inst)
            inst.AnimState:PlayAnimation("stump_tall", false)
            if data.burnt or inst:HasTag("burnt") then
                DefaultBurntFn(inst)
            else
                inst:AddComponent("workable")
                inst.components.workable:SetWorkAction(ACTIONS.DIG)
                inst.components.workable:SetOnFinishCallback(dig_up_stump)
                inst.components.workable:SetWorkLeft(1)
            end
        elseif data.burnt and not inst:HasTag("burnt") then
            OnBurnt(inst)
        end
    end
end

local function OnSeasonChange(inst)
if TheWorld.state.issummer then
    inst.AnimState:SetBuild("tuber_bloom_build")
    inst.AnimState:SetBank("tubertree")
	if inst.components.lootdropper ~= nil then
    inst.components.lootdropper:SetChanceLootTable('tubertree_bloom')	
	end	
else
    inst.AnimState:SetBuild("tuber_tree_build")
    inst.AnimState:SetBank("tubertree")
	if inst.components.lootdropper ~= nil then
    inst.components.lootdropper:SetChanceLootTable('tubertree')	
	end	
end

end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddDynamicShadow()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .25)

    inst.MiniMapEntity:SetIcon("tuber_trees.png")
    inst.MiniMapEntity:SetPriority(-1)

    inst:AddTag("tree")
	inst:AddTag("tubertree")
	inst:AddTag("plant")

    inst.AnimState:SetBuild("tuber_tree_build")
    inst.AnimState:SetBank("tubertree")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeLargeBurnable(inst)
    inst.components.burnable:SetOnBurntFn(OnBurnt)
    MakeSmallPropagator(inst)

    inst:AddComponent("lootdropper") 
    inst.components.lootdropper:SetChanceLootTable('tubertree')

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HACK)
    inst.components.workable:SetWorkLeft(10)
    inst.components.workable:SetOnWorkCallback(chop_tree)
    inst.components.workable:SetOnFinishCallback(chop_down_tree)

    MakeHauntableWorkAndIgnite(inst)

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)
    sway(inst)
    inst.AnimState:SetTime(math.random()*2)

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = inspect_tree

		inst:AddComponent("mystery")

    inst.OnSave = onsave
    inst.OnLoad = onload
    MakeSnowCovered(inst)
	
	inst:WatchWorldState("startday", OnSeasonChange)
	inst:DoTaskInTime(0, OnSeasonChange)	

    return inst
end

return Prefab("tubertree", fn, assets)		