local function PushSway(inst)
    inst.AnimState:PushAnimation(math.random() < .5 and "sway1_loop" or "sway2_loop", true)
end

local function DigUpStump(inst)
    inst.components.lootdropper:SpawnLootPrefab("log")
    inst:Remove()
end

local function ChopDownTreeShake(inst)
    ShakeAllCameras(
        CAMERASHAKE.FULL,
        .25,
        .03,
        inst.components.growable ~= nil and inst.components.growable.stage > 2 and .5 or .25,
        inst,
        6
    )
end

local function MakeStump(inst)
    inst:RemoveComponent("burnable")
	inst:RemoveComponent("propagator")
	
    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
	
    inst:RemoveTag("shelter")
    inst:RemoveTag("cattoyairborne")
	
    inst:AddTag("stump")

    RemovePhysicsColliders(inst)

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)	
    inst.components.workable:SetOnFinishCallback(DigUpStump)
    inst.components.workable:SetWorkLeft(1)
	
	inst.AnimState:PlayAnimation("stump")	
end

local function GetStatus(inst)
    return "NORMAL"
end

local function ChopDownTree(inst, chopper)
    inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")

    local pt = inst:GetPosition()
    local hispos = chopper:GetPosition()
    local he_right = (hispos - pt):Dot(TheCamera:GetRightVec()) > 0
	
    if he_right then
        inst.AnimState:PlayAnimation("fallleft")
        if inst.components.sappy and inst.components.sappy.stage == 3 then
        --    inst.components.lootdropper:SpawnLootPrefab("saugarwood_seed", pt - TheCamera:GetRightVec())
        end
        inst.components.lootdropper:DropLoot(pt - TheCamera:GetRightVec())
		inst.components.lootdropper:SpawnLootPrefab("sugarwood_seed", pt - TheCamera:GetRightVec())		
    else
        inst.AnimState:PlayAnimation("fallright")
        if inst.components.sappy and inst.components.sappy.stage == 3 then
        --    inst.components.lootdropper:SpawnLootPrefab("saugarwood_seed", pt - TheCamera:GetRightVec())
        end
        inst.components.lootdropper:DropLoot(pt + TheCamera:GetRightVec())
		inst.components.lootdropper:SpawnLootPrefab("sugarwood_seed", pt - TheCamera:GetRightVec())
    end

	inst.AnimState:PushAnimation("stump")
	
	inst.components.sappy:RemoveTapper()
	inst:RemoveTag("sappy")
	
    inst:DoTaskInTime(.4, ChopDownTreeShake)

    MakeStump(inst)
end

local function OnChop(inst, chopper)
	local x, y, z = inst.Transform:GetWorldPosition()

	if inst:HasTag("withered") then
		SpawnPrefab("sugarwood_leaf_withered_fx").Transform:SetPosition(x, 1, z)
	elseif not inst:HasTag("dead") then
		SpawnPrefab("sugarwood_leaf_fx").Transform:SetPosition(x, 1, z)
	end
	
	if not (chopper ~= nil and chopper:HasTag("playerghost")) then
        inst.SoundEmitter:PlaySound(
            chopper ~= nil and chopper:HasTag("beaver") and
            "dontstarve/characters/woodie/beaver_chop_tree" or
            "dontstarve/wilson/use_axe_tree"
        )
    end
	
	inst.components.sappy:RemoveTapper()
	inst:RemoveTag("sappy")
	
    inst.AnimState:PlayAnimation("chop")

    PushSway(inst)
end

local function OnLoad(inst, data)
    if data then
        if data.stump then
			MakeStump(inst)
		end
    end
end

local function OnSave(inst, data)
    if inst:HasTag("stump") then
        data.stump = true
    end
end

local function MakeTree(stage, data)
	local assets =
	{
		Asset("ANIM", "anim/quagmire_sapbucket.zip"),
		Asset("ANIM", "anim/quagmire_tree_cotton_build.zip"),
		Asset("ANIM", "anim/quagmire_tree_cotton_trunk_build.zip"),
		Asset("MINIMAP_IMAGE", "minimap_saptree.tex"),
	}

	local prefabs =
	{
		"log",
		"twigs",
		"sugarwood_leaf_fx",
		"sugarwood_leaf_fx_chop",
		"sugarwood_leaf_withered_fx",
		"sugarwood_leaf_withered_fx_chop",
	}

	table.insert(assets, Asset("ANIM", "anim/"..data.anim_file..".zip"))

	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		
		local minimap = inst.entity:AddMiniMapEntity()
		
		inst.entity:AddNetwork()

		MakeObstaclePhysics(inst, .25)

		minimap:SetIcon("quagmire_sugarwoodtree.png")
		minimap:SetPriority(1)

	--    inst.Transform:SetScale(0.8, 0.8, 0.8)

		inst:SetPrefabNameOverride("quagmire_sugarwoodtree")

		inst:AddTag("tree")
		inst:AddTag("shelter")

		inst.AnimState:SetBank(data.anim_file)
		inst.AnimState:SetBuild("quagmire_tree_cotton_build")
		inst.AnimState:AddOverrideBuild("quagmire_sapbucket")
		inst.AnimState:AddOverrideBuild("quagmire_tree_cotton_trunk_build")
		inst.AnimState:Hide("swap_tapper")
		inst.AnimState:Hide("sap")
		inst.AnimState:PlayAnimation("sway1_loop", true)
		
		inst.AnimState:OverrideSymbol("swap_sapbucket", "quagmire_sapbucket", "swap_sapbucket_empty")

		MakeSnowCoveredPristine(inst)

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("inspectable")
		inst.components.inspectable.getstatus = GetStatus

		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.CHOP)
		inst.components.workable:SetWorkLeft(stage * 5)
		inst.components.workable:SetOnFinishCallback(ChopDownTree)
		inst.components.workable:SetOnWorkCallback(OnChop)

		inst:AddComponent("lootdropper")
		inst.components.lootdropper:SetLoot( data.loot )
		
		inst:AddComponent("sappy")
		inst.components.sappy.stage = stage
		
		inst:AddComponent("hauntable")
		
		MakeLargeBurnable(inst)
		MakeLargePropagator(inst)

		inst.OnSave = OnSave
		inst.OnLoad = OnLoad

		return inst
	end

    return Prefab(data.prefab_name, fn, assets, prefabs)
end

local prefabs = {}

local TREE_DEFS =
{
    {
        prefab_name = "sugarwood_short",
        anim_file = "quagmire_tree_cotton_short",
        loot = {
            "log"
        },
    },
    {
        prefab_name = "sugarwood_normal",
        anim_file = "quagmire_tree_cotton_normal",
        loot = {
            "log",
            "log",
        },
    },
    {
        prefab_name = "sugarwood_tall",
        anim_file = "quagmire_tree_cotton_tall",
        loot = {
            "log",
            "log",
            "log",
        },
    },
}

for i, v in ipairs(TREE_DEFS) do
    table.insert(prefabs, MakeTree(i, v))
end

return unpack(prefabs)