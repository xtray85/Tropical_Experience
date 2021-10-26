
local assets = 
{
	Asset("ANIM", "anim/woodlegs_cage.zip"),
}

local prefabs = 
{
	"collapse_big",
	"log",
	"boards",
	"rocks",
}

local loot = 
{
	"log",
	"log",
	"boards",
	"boards",
	"rocks",
}

local function onhammered(inst)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	
	anim:SetBank("woodlegs_cage")
	anim:SetBuild("woodlegs_cage")
	
	anim:PlayAnimation("idle_swing", true)

	inst.AnimState:Hide("KEY1")
	inst.AnimState:Hide("KEY2")
	inst.AnimState:Hide("KEY3")	

	MakeObstaclePhysics(inst, 1.1)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("minimap_woodlegs_cage.png")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(onhammered)	

	inst:AddComponent("inspectable")	

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"boards"})
	inst.components.lootdropper:AddRandomLoot("rope", 10)
	inst.components.lootdropper:AddRandomLoot("boards",10)
	inst.components.lootdropper:AddRandomLoot("log",10)
	
	inst.components.lootdropper.numrandomloot = 4	
	
	

--	inst.AnimState:AddOverrideBuild("wilsha")

	
	return inst
end

return Prefab( "common/objects/woodlegs_cage_underwater", fn, assets, prefabs )
