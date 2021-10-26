local assets=
{
	Asset("ANIM", "anim/swap_cannon.zip"),
}

local prefabs = 
{
    "cannonshot",
    "collapse_small",
}

local WOODLEGS_BOATCANNON_DAMAGE = 50
local BOATCANNON_DAMAGE = 100
local BOATCANNON_RADIUS = 4
local BOATCANNON_BUILDINGDAMAGE = 10
local BOATCANNON_AMMO_COUNT = 15

local function onthrowfn(inst)
    if inst.components.finiteuses then
        inst.components.finiteuses:Use()
    end
end

local function canshootfn(inst, pt)
    return inst.components.equippable:IsEquipped()
end

local function retirado(inst)
if inst.navio then inst.navio.AnimState:ClearOverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
inst.navio = nil
end

local function onfinished(inst)
inst:Remove()
end

local function fn(Sim)

    --NOTE!! Most of the logic for this happens in cannonshot.lua

	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
    inst.AnimState:SetBank("cannon")
    inst.AnimState:SetBuild("swap_cannon")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryPhysics(inst)
--    MakeInventoryFloatable(inst, "idle_water", "idle")
    inst.build = "swap_cannon"
    inst.symbol = "swap_cannon"
    inst.symboltooverride = "swap_lantern" --swap_lantern_off
	inst.navio = nil
	
    inst:AddTag("cannon")
    inst:AddTag("boatcannon")
	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

--    inst:AddComponent("equippable")
--    inst.components.equippable.boatequipslot = BOATEQUIPSLOTS.BOAT_LAMP
--    inst.components.equippable.equipslot = nil
--    inst.components.equippable:SetOnEquip( onequip )
--    inst.components.equippable:SetOnUnequip( onunequip )

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(BOATCANNON_AMMO_COUNT)
    inst.components.finiteuses:SetUses(BOATCANNON_AMMO_COUNT)
    inst.components.finiteuses:SetOnFinished(onfinished)


    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = function() 
        return inst.components.thrower:GetThrowPoint()
    end
    inst.components.reticule.ease = true

    inst:AddComponent("thrower")
    inst.components.thrower.throwable_prefab = "cannonshot"
    inst.components.thrower.onthrowfn = onthrowfn
    inst.components.thrower.canthrowatpointfn = canshootfn
	inst:ListenForEvent("onpickup", retirado)	

    return inst
end

return Prefab( "common/inventory/boatcannon", fn, assets, prefabs)