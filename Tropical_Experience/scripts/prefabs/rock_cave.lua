local assets =
{
	Asset("ANIM", "anim/rock_antcave.zip"),
}

local prefabs =
{
	"rocks",
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

SetSharedLootTable( 'rockcave',
{
	{"rocks", 1.0},
	{"rocks", 1.0},
	{"flint", 0.5},
	{"flint", 0.25},
	{"rocks", 0.25},
})

local function baserock2_fn()
local inst = CreateEntity()
local anim = "full"
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

--	inst.MiniMapEntity:SetIcon("minimap_rock_charcoal.png")
	
	inst.AnimState:SetBank("rock")
	inst.AnimState:SetBuild("rock_antcave")
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
	
	inst.components.lootdropper:SetChanceLootTable('rockcave')

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
--    inst.components.inspectable.nameoverride = "ROCK"
    MakeSnowCovered(inst)

    MakeHauntableWork(inst)

    return inst
end

return Prefab("rock_cave", baserock2_fn, assets, prefabs)
