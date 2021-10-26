require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/rowboat_basic.zip"),
	Asset("ANIM", "anim/waxwell_shadowboat_build.zip"),
}

local controlador = nil

local prefabs =
{

}


--local function OnSave(inst, data)
--if inst:HasTag("ocupado") then data.apaga = 1 end
--end

local function OnLoad(inst, data)
inst:Remove() 
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
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

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
	inst.overridebuild = "pirate_boat_build"
	inst.banc = "rowboat"
	inst.entity:AddNetwork()

	
	inst:AddTag("shadowboat")

	inst.AnimState:SetBank("rowboat")
	inst.AnimState:SetBuild("waxwell_shadowboat_build")
	inst.AnimState:PlayAnimation("run_loop", true)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(0)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("minimap_woodlegsboat.tex")
	
	inst:AddTag("boat")
	inst:AddTag("aquatic")
	inst:AddTag("NOCLICK")
	
	local phys = inst.entity:AddPhysics()
    phys:SetMass(1)
    phys:SetFriction(1)
    phys:SetDamping(5)
--    phys:SetCollisionGroup(COLLISION.CHARACTERS)
    phys:ClearCollisionMask()
    phys:CollidesWith(COLLISION.WORLD)
    phys:CollidesWith(COLLISION.OBSTACLES)
    phys:CollidesWith(COLLISION.SMALLOBSTACLES)
--    phys:CollidesWith(COLLISION.CHARACTERS)
    phys:CollidesWith(COLLISION.GIANTS)
    phys:SetCapsule(0.5, 1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

-------------------adiciona container------------------------------------
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("woodlegsboat")
    inst.replica.container:WidgetSetup("woodlegsboat")
--------------------------------------------------------------------------	
	inst:AddComponent("interactions")
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
    inst.components.edible.hungervalue = 2
    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")
	
	inst:AddComponent("equippable")

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(999999999999999999999999999999)
	inst.components.finiteuses:SetUses(999999999999999999999999999999)
	inst.components.finiteuses:SetOnFinished(onfinished)
--	inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1)

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
	
	inst.AnimState:SetMultColour(0,0,0,.4)

	inst.no_wet_prefix = true
    MakeHauntableLaunchAndSmash(inst)
	
	inst.OnLoad = OnLoad
--	inst.OnSave = OnSave

    return inst
end

return Prefab("shadowwaxwell_boat", fn, assets)	