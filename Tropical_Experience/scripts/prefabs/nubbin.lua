require "prefabutil"
local assets =
{
Asset("ANIM", "anim/nubbin.zip"),
}

local prefabs =
{
    "spoiled_food"
}


local function growcoral(inst)
	inst.growtask:Cancel()
    inst.growtask = nil
    inst.growtime = nil
	local tree = SpawnPrefab("coralreef")
	tree.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    tree:growfromseed()
    inst:Remove()
end

local function ondeploy (inst, pt)
    local coral = SpawnPrefab("coralreef")
    coral.components.growable:SetStage(1)
    coral.Transform:SetPosition(pt:Get() )
    coral.SoundEmitter:PlaySound("dontstarve_DLC002/seacreature_movement/splash_medium")
    inst:Remove()
end

local function stopgrowing(inst)
    if inst.growtask then
        inst.growtask:Cancel()
        inst.growtask = nil
    end
    inst.growtime = nil
end

local notags = {'NOBLOCK', 'player', 'FX'}


local function describe(inst)
    if inst.growtime then
        return "PLANTED"
    end
end

local function displaynamefn(inst)
    if inst.growtime then
        return STRINGS.NAMES.NUBBIN
    end
    return STRINGS.NAMES.NUBBIN
end

local function OnSave(inst, data)
    if inst.growtime then
        data.growtime = inst.growtime - GetTime()
    end
end

local function OnLoad(inst, data)
    if data and data.growtime then
        plant(inst, data.growtime)
    end
end


local function fnnubbin(sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	

	inst.AnimState:SetBank("nubbin")
	inst.AnimState:SetBuild("nubbin")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("aquatic")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
	inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER)
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

	return inst
end

return Prefab( "nubbin", fnnubbin, assets, prefabs), MakePlacer( "common/nubbin_placer", "coral_rock", "coral_rock", "low1", false, false, false)