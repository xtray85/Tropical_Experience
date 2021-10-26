local assets=
{
	Asset("ANIM", "anim/grotto_parsnip.zip"),
    Asset("ANIM", "anim/grotto_parsnip_giant.zip"),
}

local prefabs=
{
	"grotto_parsnip",
}

local function onpicked(inst)
    TheWorld:PushEvent("beginregrowth", inst)
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("grotto_parsnip")
    inst.AnimState:SetBuild("grotto_parsnip")
    inst.AnimState:PlayAnimation("planted")
    inst.AnimState:SetRayTestOnBB(true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("grotto_parsnip", 10)
    inst.components.pickable.onpickedfn = onpicked

    inst.components.pickable.quickpick = true

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end

local function fn1(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeSmallPropagator(inst)	
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	
		
	inst.AnimState:SetBank("grotto_parsnip")
	inst.AnimState:SetBuild("grotto_parsnip")
	inst.AnimState:PlayAnimation("idle")
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst.entity:SetPristine()
	
	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.VEGGIE
	inst.components.edible.healthvalue = TUNING.HEALING_TINY
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = 0
			
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "map_icons/creepindedeepicon.xml"
	inst.caminho = "map_icons/creepindedeepicon.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

--	inst:AddComponent("cookable")
--    inst.components.cookable.product="grotto_parsnip_cooked"

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
	
	end

local function fn2(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeSmallPropagator(inst)	
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	
		
	inst.AnimState:SetBank("grotto_parsnip")
	inst.AnimState:SetBuild("grotto_parsnip")
	inst.AnimState:PlayAnimation("idle_eaten")
	
	if not TheWorld.ismastersim then
		return inst
	end
	
	inst.entity:SetPristine()
	
	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.VEGGIE
	inst.components.edible.healthvalue = TUNING.HEALING_TINY/2
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL/2
	inst.components.edible.sanityvalue = 0
			
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "map_icons/creepindedeepicon.xml"
	inst.caminho = "map_icons/creepindedeepicon.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED/2)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("tradable")
	
	MakeHauntableLaunchAndPerish(inst)
		
    return inst
	
	end
	
local function oversized_onfinishwork(inst, chopper)
    inst.components.lootdropper:DropLoot()
    inst:Remove()
end	

local function oversized_onburnt(inst)
    inst.components.lootdropper:DropLoot()
    inst:Remove()
end
	
local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon("grotto_parsnip_giant.png")	

    inst.AnimState:SetBank("grotto_parsnip_giant")
    inst.AnimState:SetBuild("grotto_parsnip_giant")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.CHOP)
--    inst.components.workable:SetOnFinishCallback(oversized_onfinishwork)
    inst.components.workable:SetWorkLeft(8)	



		inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)
            local pt = Point(inst.Transform:GetWorldPosition())
            if workleft <= 0 then
			inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
			inst.components.lootdropper:DropLoot()
			inst:Remove()				
			else
			inst.AnimState:PlayAnimation("idle", true)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
            end
        end)


    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"grotto_parsnip","grotto_parsnip", "grotto_parsnip", "grotto_parsnip_eaten", "grotto_parsnip_eaten", "mosquito", "mosquito", "jellybug"})

    MakeMediumBurnable(inst)
    inst.components.burnable:SetOnBurntFn(oversized_onburnt)
    MakeMediumPropagator(inst)

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end	

return Prefab( "grotto_parsnip_planted", fn, assets),
	   Prefab( "grotto_parsnip", fn1, assets),
	   Prefab( "grotto_parsnip_eaten", fn2, assets),
	   Prefab( "grotto_parsnip_giant", fn3, assets)