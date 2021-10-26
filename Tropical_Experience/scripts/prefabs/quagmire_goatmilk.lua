local assets =
{
    Asset("ANIM", "anim/quagmire_goatmilk.zip"),
}

local function MakeMilk()
	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)
		
		inst.AnimState:SetBuild("quagmire_goatmilk")
		inst.AnimState:SetBank("quagmire_goatmilk")
		inst.AnimState:PlayAnimation("idle")
		
		inst:AddTag("catfood")
		inst:AddTag("quagmire_stewable")		

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("edible")
		inst.components.edible.healthvalue = TUNING.HEALING_SMALL
		inst.components.edible.hungervalue = TUNING.CALORIES_MED
		
		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(TUNING.PERISH_FASTISH)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"

		inst:AddComponent("tradable")

		inst:AddComponent("inspectable")
		
		inst:AddComponent("inventoryitem")
		
		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

		MakeHauntableLaunchAndPerish(inst)

		return inst
	end
	
	return Prefab("quagmire_goatmilk", fn, assets, prefabs)
end


return MakeMilk()
