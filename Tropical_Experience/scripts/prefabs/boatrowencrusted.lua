require "prefabutil"

--The test to see if a boat can be built in a certain position is defined in the builder component Builder:CanBuildAtPoint
local assets = 
{
	Asset("ANIM", "anim/rowboat_basic.zip"),
	Asset("ANIM", "anim/rowboat_encrusted_build.zip"),
	Asset("ANIM", "anim/swap_sail.zip"),
	Asset("ANIM", "anim/swap_lantern_boat.zip"),
	Asset("ANIM", "anim/boat_hud_encrusted.zip"),
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
	SpawnPrefab("limestone").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("limestone").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("boards").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("boards").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("boards").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

----------------------------------------

local function equipaItem(inst, data)
local sailslot = inst.components.container:GetItemInSlot(1)
if sailslot ~= nil then inst.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol) end
local luzslot = inst.components.container:GetItemInSlot(2)
if luzslot ~= nil then inst.AnimState:OverrideSymbol(luzslot.symboltooverride, luzslot.build, luzslot.symbol) end
if luzslot and luzslot:HasTag("boatlight") then luzslot:AddTag("nonavio") end
if luzslot then luzslot.navio = inst end
if sailslot then sailslot.navio = inst end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.Transform:SetFourFaced()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.overridebuild = "rowboat_encrusted_build"
	inst.banc = "rowboat"
	inst.entity:AddNetwork()
--	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--	inst.AnimState:SetSortOrder(0)

	MakeWaterObstaclePhysics(inst, 0.5, 2, 1.25)

	inst.AnimState:SetBuild("rowboat_encrusted_build")
	inst.AnimState:SetBank("rowboat")
	inst.AnimState:PlayAnimation("run_loop", true)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("encrustedboat.png")	
	
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
    inst.components.container:WidgetSetup("encrustedboat")
    inst.replica.container:WidgetSetup("encrustedboat")
--------------------------------------------------------------------------
	
	inst:AddComponent("interactions")
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
    inst.components.edible.hungervalue = 2
    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
	
	inst:AddComponent("equippable")

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(800)
	inst.components.finiteuses:SetUses(800)
	inst.components.finiteuses:SetOnFinished(onfinished)
--	inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1)

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(800, 0.99)

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
	inst:ListenForEvent("itemget", equipaItem)

--    MakeHauntableLaunchAndSmash(inst)
	
	inst.OnLoad = OnLoad
	inst.OnSave = OnSave

    return inst
end

return Prefab("encrustedboat", fn, assets)
	