local assets =
{
    Asset("ANIM", "anim/quagmire_tree_cotton_trunk_build.zip"),
    Asset("ANIM", "anim/quagmire_blue_cotton_build.zip"),
    Asset("MINIMAP_IMAGE", "minimap_saptree.tex"),
}

local prefabs =
{
    "log",
    "twigs",
    -- "quagmire_sap",
    -- "quagmire_sap_spoiled",
    "sugarwood_leaf_fx",
    "sugarwood_leaf_fx_chop",
    "sugarwood_leaf_withered_fx",
    "sugarwood_leaf_withered_fx_chop",
}

local seg_time = 30 --each segment of the clock is 30 seconds
local total_day_time = seg_time*16

local day_segs = 10
local day_time = seg_time * day_segs
local PALMTREE_GROW_TIME =
	    {
	        {base=1.5*day_time, random=0.5*day_time},   --tall to short
	        {base=5*day_time, random=2*day_time},   --short to normal
	        {base=5*day_time, random=2*day_time},   --normal to tall
	    }

local	   	PALMTREE_CHOPS_SMALL = 5
local	    PALMTREE_CHOPS_NORMAL = 10
local	    PALMTREE_CHOPS_TALL = 15
local	    PALMTREE_COCONUT_CHANCE = 0.01
local	    LEIF_REAWAKEN_RADIUS = 20
local	    LEIF_BURN_TIME = 10
local	    LEIF_BURN_DAMAGE_PERCENT = 1/8
local	    LEIF_MIN_DAY = 3
local	    LEIF_PERCENT_CHANCE = 1/50
local	    LEIF_MAXSPAWNDIST = 15



local BUCKET_STAGES =
{
    "empty",
    "full",
    "overflow",
}

local DEFAULT_TREE_DEF = math.random(1,3)
local TREE_DEFS =
{




    {
        prefab_name = "cottontree_small",
        anim_file = "quagmire_tree_cotton_short",
        loot = {
            "log"
        },
    },
    {
        prefab_name = "cottontree_normal",
        anim_file = "quagmire_tree_cotton_normal",
        loot = {
            "log",
            "log",
--			"quagmire_sap",			
			"cottontree_cone",
        },
    },
    {
        prefab_name = "cottontree_tall",
        anim_file = "quagmire_tree_cotton_tall",
        loot = {
            "log",
            "log",
            "log",
--			"quagmire_sap",
--			"quagmire_sap",			
			"cottontree_cone",
        },
    },
}

for i, v in ipairs(TREE_DEFS) do
    table.insert(assets, Asset("ANIM", "anim/"..v.anim_file..".zip"))
end


local function PushSway(inst)
--	if math.random() > .5 then
--		inst.AnimState:PushAnimation(inst.anims.sway1, true)
--	else
--		inst.AnimState:PushAnimation(inst.anims.sway2, true)
--	end
end

local function Sway(inst)
--	if math.random() > .5 then
--		inst.AnimState:PlayAnimation(inst.anims.sway1, true)
--	else
--		inst.AnimState:PlayAnimation(inst.anims.sway2, true)
--	end
--	inst.AnimState:SetTime(math.random()*2)
end

local function SetStage(inst, stage)
    stage = stage or DEFAULT_TREE_DEF
    inst.stage = stage
    inst.AnimState:SetBank(TREE_DEFS[stage].anim_file)
	
	local map = TheWorld.Map
	local x, y, z = inst.Transform:GetWorldPosition()
	local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
    inst.components.lootdropper:SetLoot(TREE_DEFS[stage].loot)
end

local function PushSway(inst, skippre)
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


local function chop_tree(inst, chopper, chops)
	if chopper and chopper.components.beaverness and chopper.isbeavermode and chopper.isbeavermode:value() then
		inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/beaver_chop_tree")
	else
		inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
	end
	
	local fx = SpawnPrefab("green_leaves_chop")
    local x, y, z= inst.Transform:GetWorldPosition()
    fx.Transform:SetPosition(x,y,z)

    -- Force update anims if monster
    inst.AnimState:PlayAnimation("chop")

    PushSway(inst)
end

local function SetShort(inst)
	inst.anims = SetStage(inst, 1)

	if inst.components.workable then
		inst.components.workable:SetWorkLeft(PALMTREE_CHOPS_SMALL)
	end
	-- if inst:HasTag("shelter") then inst:RemoveTag("shelter") end

--	inst.components.lootdropper:SetChanceLootTable(GetBuild(inst).short_loot)
	Sway(inst)
end

local function GrowShort(inst)
--	inst.AnimState:PlayAnimation("quagmire_tree_cotton_short")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treeGrowFromWilt")
	PushSway(inst)
end

local function SetNormal(inst)
	inst.anims = SetStage(inst, 2)

	if inst.components.workable then
		inst.components.workable:SetWorkLeft(PALMTREE_CHOPS_NORMAL)
	end
	-- if inst:HasTag("shelter") then inst:RemoveTag("shelter") end

--	inst.components.lootdropper:SetChanceLootTable(GetBuild(inst).normal_loot)
	Sway(inst)
end

local function GrowNormal(inst)
--	inst.AnimState:PlayAnimation("quagmire_tree_cotton_normal")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treeGrow")
	PushSway(inst)
end

local function SetTall(inst)
	inst.anims = SetStage(inst, 3)
	if inst.components.workable then
		inst.components.workable:SetWorkLeft(PALMTREE_CHOPS_TALL)
	end
	-- inst:AddTag("shelter")

--	inst.components.lootdropper:SetChanceLootTable(GetBuild(inst).tall_loot)
	--inst.components.lootdropper:AddChanceLoot("coconut", 0.167)

	Sway(inst)
end

local function GrowTall(inst)
--	inst.AnimState:PlayAnimation("cottontree_tall")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treeGrow")
	PushSway(inst)
end

local growth_stages =
{
	{name="short", time = function(inst) return GetRandomWithVariance(TUNING.EVERGREEN_GROW_TIME[1].base, TUNING.EVERGREEN_GROW_TIME[1].random) end, fn = function(inst) SetShort(inst) end,  growfn = function(inst) GrowShort(inst) end , leifscale=.7 },
	{name="normal", time = function(inst) return GetRandomWithVariance(TUNING.EVERGREEN_GROW_TIME[2].base, TUNING.EVERGREEN_GROW_TIME[2].random) end, fn = function(inst) SetNormal(inst) end, growfn = function(inst) GrowNormal(inst) end, leifscale=1 },
	{name="tall", time = function(inst) return GetRandomWithVariance(TUNING.EVERGREEN_GROW_TIME[3].base, TUNING.EVERGREEN_GROW_TIME[3].random) end, fn = function(inst) SetTall(inst) end, growfn = function(inst) GrowTall(inst) end, leifscale=1.25 },
	--{name="old", time = function(inst) return GetRandomWithVariance(TUNING.EVERGREEN_GROW_TIME[4].base, TUNING.EVERGREEN_GROW_TIME[4].random) end, fn = function(inst) SetOld(inst) end, growfn = function(inst) GrowOld(inst) end },
}

local function chop_down_burnt_tree(inst, chopper)
	inst:RemoveComponent("workable")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
	inst.AnimState:PlayAnimation(inst.anims.chop_burnt)
	RemovePhysicsColliders(inst)
	inst:ListenForEvent("animover", function() inst:Remove() end)
	inst.components.lootdropper:SpawnLootPrefab("charcoal")
	inst.components.lootdropper:DropLoot()
	if inst.pineconetask then
		inst.pineconetask:Cancel()
		inst.pineconetask = nil
	end
end	

local function MakeStump(inst)
    inst:RemoveComponent("burnable")
    MakeSmallBurnable(inst)
    inst:RemoveComponent("propagator")
    MakeSmallPropagator(inst)
    inst:RemoveComponent("workable")
    inst:RemoveTag("shelter")
    inst:RemoveTag("cattoyairborne")
    inst:AddTag("stump")

    RemovePhysicsColliders(inst)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(DigUpStump)
    inst.components.workable:SetWorkLeft(1)

    if inst.components.growable ~= nil then
        inst.components.growable:StopGrowing()
    end
end

local function GetStatus(inst)
    return "NORMAL"
end

local function ChopDownTree(inst, chopper)
    local days_survived = TheWorld.state.cycles

    inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")


    local pt = inst:GetPosition()
    local hispos = chopper:GetPosition()
    local he_right = (hispos - pt):Dot(TheCamera:GetRightVec()) > 0
    if he_right then
        inst.AnimState:PlayAnimation("fallleft")
        if inst.components.growable ~= nil and inst.components.growable.stage == 3 and inst.leaf_state == "colorful" then
            inst.components.lootdropper:SpawnLootPrefab("acorn", pt - TheCamera:GetRightVec())
        end
        inst.components.lootdropper:DropLoot(pt - TheCamera:GetRightVec())
    else
        inst.AnimState:PlayAnimation("fallright")
        if inst.components.growable ~= nil and inst.components.growable.stage == 3 and inst.leaf_state == "colorful" then
            inst.components.lootdropper:SpawnLootPrefab("acorn", pt - TheCamera:GetRightVec())
        end
        inst.components.lootdropper:DropLoot(pt + TheCamera:GetRightVec())
    end

    inst:DoTaskInTime(.4, ChopDownTreeShake)

    inst.AnimState:PushAnimation("stump")

    MakeStump(inst)
end

local function OnGrow(inst, stage)
    inst.AnimState:PlayAnimation("sap_leak_pre")
    inst.AnimState:PushAnimation("sap_leak_pst")
    inst.AnimState:PushAnimation("idle")
    OnBucketStageChange(inst, stage)
end

local function OnHarvest(inst, picker, produce)
    OnBucketStageChange(inst, 0)
end

local function OnLoad(inst, data)
    if not data then
        return
    end
	
    if data.stage then
        SetStage(inst, data.stage)
    end
	
	if data.stump then
    inst.AnimState:PushAnimation("stump")
    MakeStump(inst)
	end
end

local function OnSave(inst, data)
    if not data then
        return
    end
    if inst.stage then
        data.stage = inst.stage
    end
	
	if inst:HasTag("stump") then
		data.stump = true
	end	
end

local function fn(tree_def)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    local minimap = inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .25)

    minimap:SetIcon("quagmire_sugarwoodtree.png")
    minimap:SetPriority(1)

    inst.Transform:SetScale(0.8, 0.8, 0.8)

    inst:AddTag("tree")
    inst:AddTag("shelter")
    inst:AddTag("cottontree")

    inst.AnimState:SetBank(TREE_DEFS[tree_def or DEFAULT_TREE_DEF].anim_file)
	
	inst.AnimState:SetBuild("quagmire_blue_cotton_build")
    inst.AnimState:AddOverrideBuild("quagmire_tree_cotton_trunk_build")
	inst.AnimState:OverrideSymbol("sap", "uagmire_tree_cotton_trunk_build", "")		
    inst.AnimState:PlayAnimation("sway1_loop", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end			

    MakeLargeBurnable(inst, TUNING.TREE_BURN_TIME)
    inst.components.burnable:SetFXLevel(5)

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.CHOP)
    inst.components.workable:SetOnWorkCallback(chop_tree)
    inst.components.workable:SetOnFinishCallback(ChopDownTree)

    inst:AddComponent("lootdropper")
	
	inst:AddComponent("growable")
	inst.components.growable.stages = growth_stages
--	inst.components.growable:SetStage(l_stage)
	inst.components.growable.loopstages = true
	inst.components.growable.springgrowth = true
	inst.components.growable:StartGrowing()
	
	MakeSnowCovered(inst, .01)	

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local function MakeTree(i, name, _assets, _prefabs)
    local function _fn()
	i =  math.random(1,3)
        local inst = fn(i)
        if not TheWorld.ismastersim then
            return inst
        end
        SetStage(inst, i)
        inst:SetPrefabName("cottontree")
        return inst
    end

    return Prefab(name, _fn, _assets, _prefabs)
end

local tree_prefabs = {}
for i, v in ipairs(TREE_DEFS) do
    table.insert(tree_prefabs, MakeTree(i, v.prefab_name))
    table.insert(prefabs, v.prefab_name)
end

table.insert(tree_prefabs, MakeTree(nil, "cottontree", assets, prefabs))

return unpack(tree_prefabs)
