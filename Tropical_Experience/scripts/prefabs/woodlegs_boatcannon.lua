local assets=
{
	Asset("ANIM", "anim/swap_cannon_pirate.zip"),
}

local prefabs = 
{
--    "woodlegs_cannonshot",
    "collapse_small",
}

local BOATCANNON_AMMO_COUNT = 12

local function onmounted(data, inst)
    data.driver.AnimState:OverrideSymbol("swap_lantern", "swap_cannon_pirate", "swap_cannon")
end 

local function ondismounted(data, inst) 
    data.driver.AnimState:ClearOverrideSymbol("swap_lantern")
end 

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_lantern", "swap_cannon_pirate", "swap_cannon")
    if owner.components.drivable and owner.components.drivable.driver then 
        owner.components.drivable.driver.AnimState:OverrideSymbol("swap_lantern", "swap_cannon_pirate", "swap_cannon")
    end 
    inst.equippedby = owner 
    inst:ListenForEvent("mounted", function(boat,data) onmounted(data, inst) end, owner)
    inst:ListenForEvent("dismounted", function(boat,data) ondismounted(data, inst) end, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_lantern")
    if owner.components.drivable and owner.components.drivable.driver then 
        owner.components.drivable.driver.AnimState:ClearOverrideSymbol("swap_lantern")
    end 
    inst.equippedby = nil 
    inst:RemoveEventCallback("mounted", onmounted, owner)
    inst:RemoveEventCallback("dismounted", ondismounted, owner)
    inst:Remove()
end

local function onfinished(inst)
     if inst.equippedby then 
        inst.equippedby.AnimState:ClearOverrideSymbol("swap_lantern")
        if inst.equippedby.components.drivable and inst.equippedby.components.drivable.driver then 
           inst.equippedby.components.drivable.driver.AnimState:ClearOverrideSymbol("swap_lantern")
        end 
    end 
    inst:Remove()
end

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

local function fn(Sim)

    --NOTE!! Most of the logic for this happens in cannonshot.lua

	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("cannon")
    inst.AnimState:SetBuild("swap_cannon_pirate")
    inst.AnimState:PlayAnimation("anim")

    MakeInventoryPhysics(inst)
--    MakeInventoryFloatable(inst, "idle_water", "idle")
    inst.build = "swap_cannon_pirate"
    inst.symbol = "swap_cannon"
    inst.symboltooverride = "swap_lantern" --swap_lantern_off
	inst.navio = nil

    inst:AddTag("boatcannon")
    inst:AddTag("cannon")
	
	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end	

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(BOATCANNON_AMMO_COUNT)
    inst.components.finiteuses:SetUses(BOATCANNON_AMMO_COUNT)
    inst.components.finiteuses:SetOnFinished( onfinished)
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = function() 
        return inst.components.thrower:GetThrowPoint()
    end
    inst.components.reticule.ease = true
--[[
    inst:AddComponent("thrower")
    inst.components.thrower.throwable_prefab = "woodlegs_cannonshot"
    inst.components.thrower.onthrowfn = onthrowfn
    inst.components.thrower.canthrowatpointfn = canshootfn
]]	
	
	
	inst:ListenForEvent("onpickup", retirado)
    return inst
end

return Prefab( "common/inventory/woodlegs_boatcannon", fn, assets, prefabs)