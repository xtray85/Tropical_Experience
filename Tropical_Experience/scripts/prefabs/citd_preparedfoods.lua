local function MakePreparedFood(data)

	local assets=
	{
		--Asset("ANIM", "anim/cook_pot_food.zip"),
	}
	
	local prefabs = 
	{
		"spoiled_food",
	}
	
	local function fn(Sim)
		local inst = CreateEntity()
		inst.entity:AddNetwork()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		MakeInventoryPhysics(inst)
		
		inst.AnimState:SetBuild(data.name)
		inst.AnimState:SetBank(data.name)
		inst.AnimState:PlayAnimation("BUILD", false)
		inst.AnimState:SetScale(1.5,1.5,1.5)
	    
	    inst:AddTag("preparedfood")

	    inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end	
		
		inst:AddComponent("edible")
		inst.components.edible.healthvalue = data.health or 0
		inst.components.edible.hungervalue = data.hunger or 0
		inst.components.edible.foodtype = data.foodtype or "GENERIC"
		inst.components.edible.sanityvalue = data.sanity or 0
		inst.components.edible.oneaten = data.oneaten

		inst:AddComponent("inspectable")
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.imagename = data.name
		inst.components.inventoryitem.atlasname = "images/inventoryimages/food/"..data.name..".xml"
		
		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
		
		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(data.perishtime or TUNING.PERISH_SLOW)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"
	    
        MakeSmallBurnable(inst)
		MakeSmallPropagator(inst)   

		inst:AddComponent("bait")
		inst:AddComponent("tradable")
	    
		return inst
	end

	return Prefab( "common/inventory/"..data.name, fn, assets, prefabs)
end


local prefs = {}

local foods = 
{
	sponge_cake = 
	{
		test = function(cooker, names, tags) return tags.dairy and tags.sweetener and tags.sponge and tags.sponge and not tags.meat end,
		priority = 0,
		weight = 1,
		health = 0,
		hunger = 25,
		sanity = 50,
		perishtime = TUNING.PERISH_SUPERFAST,
		cooktime = .5,
	},
	
	fish_n_chips = 
	{
		test = function(cooker, names, tags) return tags.fish and tags.fish >= 2 and tags.veggie and tags.veggie >= 2 end,
		priority = 10,
		weight = 1,
		health = 25,
		hunger = 42.5,
		sanity = 10,
		perishtime = TUNING.PERISH_FAST,
		cooktime = 1,
	},
	
	tuna_muffin = 
	{
		test = function(cooker, names, tags) return tags.fish and tags.fish >= 1 and tags.sponge and tags.sponge >= 1 and not tags.twigs end,
		priority = 5,
		weight = 1,
		health = 0,
		hunger = 32.5,
		sanity = 10,
		perishtime = TUNING.PERISH_MED,
		cooktime = 2,
	},

	tentacle_sushi = 
	{
		test = function(cooker, names, tags) return tags.tentacle and tags.tentacle and tags.sea_veggie and tags.fish >= 0.5 and not tags.twigs end,
		priority = 0,
		weight = 1,
		health = 35,
		hunger = 5,
		sanity = 5,
		perishtime = TUNING.PERISH_MED,
		cooktime = 2,
	},

	flower_sushi = 
	{
		test = function(cooker, names, tags) return tags.flower and tags.sea_veggie and tags.fish and tags.fish >= 1 and not tags.twigs end,
		priority = 0,
		weight = 1,
		health = 10,
		hunger = 5,
		sanity = 30,
		perishtime = TUNING.PERISH_MED,
		cooktime = 2,
	},

	fish_sushi = 
	{
		test = function(cooker, names, tags) return tags.tentacle and tags.veggie >= 1 and tags.fish and tags.fish >= 1 and not tags.twigs end,
		priority = 0,
		weight = 1,
		health = 5,
		hunger = 50,
		sanity = 0,
		perishtime = TUNING.PERISH_MED,
		cooktime = 2,
	},

	seajelly = 
	{
		test = function(cooker, names, tags) return tags.sea_jelly and tags.sea_jelly > 1 and names.saltrock and names.saltrock > 1 and not tags.meat end,
		priority = 0,
		weight = 1,
		health = 20,
		hunger = 40,
		sanity = 3,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 2,
	},
}

for k, recipe in pairs(foods) do
	recipe.name = k
	recipe.weight = recipe.weight or 1
	recipe.priority = recipe.priority or 0
end

for k,v in pairs(foods) do
	table.insert(prefs, MakePreparedFood(v))
end

return unpack(prefs) 
