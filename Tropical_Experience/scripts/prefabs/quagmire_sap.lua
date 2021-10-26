
local assets =
{
    Asset("ANIM", "anim/quagmire_sap.zip"),
}

local function MakeSap(name, fresh)
   local function fn()
	   local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)		

		inst.AnimState:SetBank("quagmire_sap")
		inst.AnimState:SetBuild("quagmire_sap")
		inst.AnimState:PlayAnimation(fresh and "idle" or "idle_spoiled")
		
		inst:SetPrefabNameOverride(fresh and "quagmire_sap" or "quagmire_sap_spoiled")

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end
		
		inst:AddComponent("edible")
		inst.components.edible.foodtype = FOODTYPE.GENERIC
		inst.components.edible.healthvalue = 0
		inst.components.edible.sanityvalue = 0
		inst.components.edible.hungervalue = 4.7

		inst:AddComponent("inspectable")
		inst.components.inspectable.nameoverride = fresh and "quagmire_sap" or "quagmire_sap_spoiled"
		
		inst:AddComponent("fuel")
		inst.components.fuel.fuelvalue = TUNING.MED_FUEL

		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.imagename = fresh and "quagmire_sap" or "quagmire_sap_spoiled"
		
		inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

		MakeHauntableLaunchAndPerish(inst)
		MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
		MakeSmallPropagator(inst)
		
		return inst
	end

    return Prefab(name, fn, assets, fresh and prefabs or nil)
end

return MakeSap("sap", true),
    MakeSap("sap_spoiled", false)	
