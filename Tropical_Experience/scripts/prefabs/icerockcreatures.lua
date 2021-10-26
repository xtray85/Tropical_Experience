local assets =
{
    Asset("ANIM", "anim/deerclops_basic.zip"),
    Asset("ANIM", "anim/deerclops_yule.zip"),
    Asset("ANIM", "anim/bearger_basic.zip"),
    Asset("ANIM", "anim/bearger_yule.zip"),	
    Asset("ANIM", "anim/ds_spider_basic.zip"),
    Asset("ANIM", "anim/spider_build.zip"),	
    Asset("ANIM", "anim/leif_actions.zip"),
    Asset("ANIM", "anim/leif_build.zip"),
    Asset("ANIM", "anim/leif_lumpy_build.zip"),	
    Asset("ANIM", "anim/cristaled_tree_short.zip"),	
    Asset("ANIM", "anim/cristaled_tree_tall.zip"),		
    Asset("ANIM", "anim/cristaled_tre2_short.zip"),	
    Asset("ANIM", "anim/cristaled_tre2_tall.zip"),		
	
    Asset("ANIM", "anim/ds_pig_basic.zip"),
    Asset("ANIM", "anim/pig_build.zip"),	
    Asset("ANIM", "anim/crow.zip"),
    Asset("ANIM", "anim/crow_build.zip"),
    Asset("ANIM", "anim/carrat_basic.zip"),
    Asset("ANIM", "anim/carrat_build.zip"),	
}

local prefabs =
{
    "rocks",
    "nitre",
    "flint",
    "goldnugget",
    "moonrocknugget",
    "moonglass",
    "moonrockseed",
    "rock_break_fx",
    "collapse_small",
}

SetSharedLootTable('cristaled_tree2',
{
	{"rocks", 0.20},
	{"ice", 0.30},
	{"log", 0.10},
})

SetSharedLootTable('cristaled_tree',
{
	{"ice", 0.30},
})

local function OnWork(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("icedeerclops")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	monstro.sg:GoToState("taunt")
	end
	inst.components.lootdropper:DropLoot()
	inst:Remove()	
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWork2(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("icebearger")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	monstro.sg:GoToState("yawn")
	end
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWork3(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("spider")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	end
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWork4(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("pigman")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	end
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWork5(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("leif")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	end
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWork6(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("leif_sparse")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	end
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWork7(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("crow")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	end
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWorkcarrat(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
    local monstro = SpawnPrefab("carrat")
	if monstro then 
	monstro.Transform:SetPosition(pt:Get())
	end
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
    inst.AnimState:PlayAnimation("frozen_loop_pst")
    inst.AnimState:PushAnimation("frozen")	
--	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 0/255 *)	
    end
end

local function OnWorktree1(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
	if workleft >= 5 then
    inst.AnimState:PlayAnimation("petrify_in")
    inst.AnimState:PushAnimation("full")
	inst.components.lootdropper:DropLoot()	
	end
	if workleft <= 6 and workleft >= 3 then
    inst.AnimState:PlayAnimation("med")
	inst.components.lootdropper:DropLoot()
	end
	if workleft <= 2 then
    inst.AnimState:PlayAnimation("low")
	inst.components.lootdropper:DropLoot()
	end	
    end
end

local function OnWorktree2(inst, worker, workleft)
    if workleft <= 0 then
    local pt = inst:GetPosition()
	inst.components.lootdropper:DropLoot()	
	inst:Remove()
    else
	if workleft >= 8 then
    inst.AnimState:PlayAnimation("petrify_in")
    inst.AnimState:PushAnimation("full")
	end
	if workleft <= 7 and workleft >= 4 then
    inst.AnimState:PlayAnimation("med")
	inst.components.lootdropper:DropLoot()
	end
	if workleft <= 3 then
    inst.AnimState:PlayAnimation("low")
	inst.components.lootdropper:DropLoot()
	end	
    end
end

local function rockdeerclops()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("deerclops")
    inst.AnimState:SetBuild("deerclops_yule")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen")
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.65
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})	

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE * 2)
    inst.components.workable:SetOnWorkCallback(OnWork)

--    local multcolour = 0.5
--    local color = multcolour + math.random() * (1.0 - multcolour)
--    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

local function rockbearger()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("bearger")
    inst.AnimState:SetBuild("bearger_yule")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen")
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE * 2)
    inst.components.workable:SetOnWorkCallback(OnWork2)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

local function rockspider()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("spider")
    inst.AnimState:SetBuild("spider_build")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen")
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork3)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

local function rockpigman()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("pigman")
    inst.AnimState:SetBuild("pig_build")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen")
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork4)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

local function rockleif()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("leif")
    inst.AnimState:SetBuild("leif_build")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen", false)
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE*2)
    inst.components.workable:SetOnWorkCallback(OnWork5)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

local function rockleif2()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("leif")
    inst.AnimState:SetBuild("leif_lumpy_build")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen", false)
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE*2)
    inst.components.workable:SetOnWorkCallback(OnWork6)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end


local function rockcrow()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("crow")
    inst.AnimState:SetBuild("crow_build")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen", false)
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork7)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

local function cristaled_tree_short()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("cristaled_tree.png")

    inst.AnimState:SetBank("petrified_tree_short")
    inst.AnimState:SetBuild("cristaled_tree_short")

    inst.AnimState:PlayAnimation("full", false)
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetChanceLootTable('cristaled_tree')
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(7)
    inst.components.workable:SetOnWorkCallback(OnWorktree1)

    inst:AddComponent("inspectable")

    MakeHauntableWork(inst)

    return inst
end

local function cristaled_tree_tall()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("cristaled_tree.png")

    inst.AnimState:SetBank("petrified_tree_tall")
    inst.AnimState:SetBuild("cristaled_tree_tall")

    inst.AnimState:PlayAnimation("full", false)
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetChanceLootTable('cristaled_tree')
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(12)
    inst.components.workable:SetOnWorkCallback(OnWorktree2)

    inst:AddComponent("inspectable")

    MakeHauntableWork(inst)

    return inst
end

local function cristaled_tre2_short()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("cristaled_tree.png")

    inst.AnimState:SetBank("petrified_tree_short")
    inst.AnimState:SetBuild("cristaled_tre2_short")

    inst.AnimState:PlayAnimation("full", false)
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetChanceLootTable('cristaled_tree2')
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(7)
    inst.components.workable:SetOnWorkCallback(OnWorktree1)

    inst:AddComponent("inspectable")

    MakeHauntableWork(inst)

    return inst
end

local function cristaled_tre2_tall()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("cristaled_tree.png")

    inst.AnimState:SetBank("petrified_tree_tall")
    inst.AnimState:SetBuild("cristaled_tre2_tall")

    inst.AnimState:PlayAnimation("full", false)
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetChanceLootTable('cristaled_tree2')
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(12)
    inst.components.workable:SetOnWorkCallback(OnWorktree2)

    inst:AddComponent("inspectable")

    MakeHauntableWork(inst)

    return inst
end

local function carrat()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("iceboulder.png")

    inst.AnimState:SetBank("carrat")
    inst.AnimState:SetBuild("carrat_build")
	inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")

    inst.AnimState:PlayAnimation("frozen")
	inst.AnimState:SetAddColour(82 / 255, 115 / 255, 124 / 255, 100/255)	
	
    local s  = 1.5
    inst.Transform:SetScale(s, s, s)

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetLoot({"ice", "ice", "ice"})
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWorkcarrat)

    inst:AddComponent("inspectable")
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

return 	Prefab("icerockdeerclops", rockdeerclops, assets, prefabs),
		Prefab("icerockbearger", rockbearger, assets, prefabs),
		Prefab("icerockspider", rockspider, assets, prefabs),	
		Prefab("icerockpigman", rockpigman, assets, prefabs),
		Prefab("icerockleif", rockleif, assets, prefabs),
		Prefab("icerockleif2", rockleif2, assets, prefabs),
		Prefab("icerockcrow", rockcrow, assets, prefabs),
		Prefab("cristaled_tree_short2", cristaled_tree_short, assets, prefabs),
		Prefab("cristaled_tree_tall2", cristaled_tree_tall, assets, prefabs),	
		Prefab("cristaled_tree_short", cristaled_tre2_short, assets, prefabs),
		Prefab("cristaled_tree_tall", cristaled_tre2_tall, assets, prefabs),
		Prefab("icerockcarrat", carrat, assets, prefabs)			