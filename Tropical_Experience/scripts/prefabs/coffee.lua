require "prefabutil"

local Assets=
		{
			Asset("ANIM", "anim/coffee.zip"),
		}
	

local function OnEaten(inst, eater)
if eater ~= nil and eater:IsValid() and eater.components.locomotor ~= nil then
if eater._coffee_speedmulttask ~= nil then
eater._coffee_speedmulttask:Cancel()
end
local debuffkey = inst.prefab
eater._coffee_speedmulttask = eater:DoTaskInTime(240, function(i) i.components.locomotor:RemoveExternalSpeedMultiplier(i, debuffkey) i._coffee_speedmulttask = nil end)
eater.components.locomotor:SetExternalSpeedMultiplier(eater, debuffkey, 1.8)
end
end
			

local function cooked(Sim)
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)
		inst.AnimState:SetBank("coffee")
		inst.AnimState:SetBuild("coffee")
		inst.AnimState:PlayAnimation("idle")
		MakeInventoryFloatable(inst)
		inst:AddTag("preparedfood")		

		inst.entity:SetPristine()
		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("edible")
		inst.components.edible.foodtype = "GOODIES"
		inst.components.edible.healthvalue = 3
		inst.components.edible.hungervalue = TUNING.CALORIES_TINY
		inst.components.edible.sanityvalue = -5
		inst.components.edible:SetOnEatenFn(OnEaten)

		MakeHauntableLaunch(inst)

		inst:AddComponent("inspectable")
		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"

		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
  
		return inst
end

return 	Prefab( "coffee", cooked, Assets, prefabs)