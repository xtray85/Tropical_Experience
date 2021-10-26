require "prefabutil"

--The test to see if a boat can be built in a certain position is defined in the builder component Builder:CanBuildAtPoint
local assets = 
{
	Asset("ANIM", "anim/raft_basic.zip"),
	Asset("ANIM", "anim/raft_log_build.zip"),
	Asset("ANIM", "anim/boat_hud_raft.zip"),
}

local controlador = nil

local prefabs =
{

}


local function OnSave(inst, data)
if inst:HasTag("ocupado") then data.apaga = 1 end
end

local function OnLoad(inst, data)
if data and data.apaga then inst:Remove() end


inst:DoTaskInTime(0, function(inst)

local jogador = inst.components.inventoryitem.owner
if jogador ~= nil then

jogador.components.inventory:DropItem(inst)
jogador:AddComponent("driver")
jogador.components.driver:OnMount(inst)
end
	end)	

end

local function onfinished(inst)


inst:Remove()
end

local function onhammered(inst)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("log").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("log").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("log").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("cutgrass").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("cutgrass").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.Transform:SetFourFaced()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.overridebuild = "raft_log_build"
	inst.banc = "raft"
	inst.entity:AddNetwork()
--	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--	inst.AnimState:SetSortOrder(0)

	MakeWaterObstaclePhysics(inst, 0.5, 2, 1.25)

	inst.AnimState:SetBuild("raft_log_build")
	inst.AnimState:SetBank("raft")
	inst.AnimState:PlayAnimation("run_loop", true)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("lograft.png")
	
	inst:AddTag("boat")
	inst:AddTag("aquatic")
	inst:AddTag("ignorewalkableplatforms")	
	
	inst.entity:AddPhysics()
	inst.Physics:SetCylinder(0.25,2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

-------------------adiciona container------------------------------------
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("lograft_old")
    inst.replica.container:WidgetSetup("lograft_old")
--------------------------------------------------------------------------		
	inst:AddComponent("interactions")
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
    inst.components.edible.hungervalue = 2
    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
	
	inst:AddComponent("equippable")

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(150)
	inst.components.finiteuses:SetUses(150)
	inst.components.finiteuses:SetOnFinished(onfinished)
--	inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1)

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(150, 0.99)

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered)


    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst.components.equippable.equipslot = EQUIPSLOTS.BARCO
	inst.components.inventoryitem.cangoincontainer = false
	inst.components.inventoryitem.canbepickedup = false
--    inst:AddComponent("stackable")
--    inst:AddComponent("bait")

--    MakeHauntableLaunchAndSmash(inst)
	
	inst.OnLoad = OnLoad
	inst.OnSave = OnSave

    return inst
end

return Prefab("lograft_old", fn, assets)
	