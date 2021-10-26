require "prefabutil"
local assets =
{
Asset("ANIM", "anim/musselfarm_seed.zip"),
}

local prefabs =
{
    "mussel_farm"
}	
	
local function growcoral(inst)
	inst.growtask:Cancel()
    inst.growtask = nil
    inst.growtime = nil
	local tree = SpawnPrefab("mussel_farm")
	tree.Transform:SetPosition(inst.Transform:GetWorldPosition() )
    tree:growfromseed()
    inst:Remove()
end

local function ondeploy (inst, pt)
    local coral = SpawnPrefab("mussel_farm")
    coral.components.growable:SetStage(2)
    coral.Transform:SetPosition(pt:Get() )
    coral.SoundEmitter:PlaySound("dontstarve_DLC002/common/muscle_plant")
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
        return STRINGS.NAMES.MUSSELFARM
    end
    return STRINGS.NAMES.MUSSELFARM
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

	inst.AnimState:SetBank("musselfarm_seed")
	inst.AnimState:SetBuild("musselfarm_seed")
	inst.AnimState:PlayAnimation("idle")
	
    MakeInventoryFloatable(inst)
	
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

return Prefab( "mussel_bed", fnnubbin, assets, prefabs), MakePlacer( "common/mussel_bed_placer", "musselfarm", "musselfarm", "low1", false, false, false)