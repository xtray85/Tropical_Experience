local assets =
{
	Asset("ANIM", "anim/rock_obsidian.zip"),
	Asset("ANIM", "anim/rock_charcoal.zip"),
}

local prefabs =
{
	"obsidian",
	"charcoal",
	"flint",
}

local function OnWork(inst, worker, workleft)
    if workleft <= 0 then
        local pt = inst:GetPosition()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pt:Get())
        inst.components.lootdropper:DropLoot(pt)
		
        if inst.showCloudFXwhenRemoved then
            local fx = SpawnPrefab("collapse_small")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end

        inst:Remove()
    else
        inst.AnimState:PlayAnimation(
            (workleft < TUNING.ROCKS_MINE / 3 and "low") or
            (workleft < TUNING.ROCKS_MINE * 2 / 3 and "med") or
            "full"
        )
    end
end


SetSharedLootTable( 'charcoal',
{
	{"charcoal", 1.0},
	{"charcoal", 1.0},
	{"charcoal", 0.5},
	{"charcoal", 0.25},
	{"charcoal", 0.25},
	{"flint", 0.5},
})

local function baserock1_fn()
local inst = CreateEntity()
local anim = "full"
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

	inst.MiniMapEntity:SetIcon("rock_charcoal.png")
	
	inst.AnimState:SetBank("rock_charcoal")
	inst.AnimState:SetBuild("rock_charcoal")
    if type(anim) == "table" then
        for i, v in ipairs(anim) do
            if i == 1 then
                inst.AnimState:PlayAnimation(v)
            else
                inst.AnimState:PushAnimation(v, false)
            end
        end
    else
        inst.AnimState:PlayAnimation(anim)
    end

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork)
	
	inst.components.lootdropper:SetChanceLootTable('charcoal')

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
--    inst.components.inspectable.nameoverride = "ROCK"
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

SetSharedLootTable( 'rock_obsidian',
{
	{"obsidian", 1.0},
	{"obsidian", 1.0},
	{"obsidian", 0.5},
	{"obsidian", 0.25},
	{"obsidian", 0.25},
})

local function baserock_fn()
local inst = CreateEntity()
local anim = "full"
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

	
	inst.MiniMapEntity:SetIcon("rock_obsidian.png")	

	inst.AnimState:SetBank("rock_obsidian")
	inst.AnimState:SetBuild("rock_obsidian")
    if type(anim) == "table" then
        for i, v in ipairs(anim) do
            if i == 1 then
                inst.AnimState:PlayAnimation(v)
            else
                inst.AnimState:PushAnimation(v, false)
            end
        end
    else
        inst.AnimState:PlayAnimation(anim)
    end

    MakeSnowCoveredPristine(inst)

    inst:AddTag("boulder")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper") 

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(nil)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork)
	
	
	inst.components.lootdropper:SetChanceLootTable('rock_obsidian')

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
--    inst.components.inspectable.nameoverride = "ROCK"
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

return Prefab("rock_obsidian", baserock_fn, assets, prefabs),
Prefab("rock_charcoal", baserock1_fn, assets, prefabs)
