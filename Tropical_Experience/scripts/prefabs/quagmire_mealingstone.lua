local assets =
{
    Asset("ANIM", "anim/quagmire_mealingstone.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/together/clayhound/footstep_hound")
	
	local foodstuff = inst.replica.container ~= nil and inst.replica.container:GetItemInSlot(1) or inst.components.container:GetItemInSlot(1)
	
	if foodstuff ~= nil then
		if foodstuff.prefab == "quagmire_flour" or foodstuff.prefab == "turnip_sugar" then
			inst.SoundEmitter:PlaySound("dontstarve/quagmire/HUD/meal_cooked")
		elseif foodstuff.prefab == "ash" then
			inst.SoundEmitter:PlaySound("dontstarve/quagmire/HUD/failed_recipe")
		end
	end
end

local function onclose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/together/clayhound/stone_shake")
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst, worker)
	
end

local function mealdone(inst)
	if inst.components.mealer ~= nil then
		inst.SoundEmitter:PlaySound("dontstarve/creatures/together/clayhound/stone_shake")
		inst.components.mealer:DoneMealing()
	end
end

local function meal(inst)
	if inst.components.mealer ~= nil then
		inst.AnimState:PlayAnimation("proximity_loop")
		inst.SoundEmitter:PlaySound("dontstarve/creatures/together/clayhound/stone_shake")
		inst.SoundEmitter:PlaySound("dontstarve/creatures/together/clayhound/footstep_hound")
		inst:DoTaskInTime(1.8, mealdone)
	end
end

local function onfar(inst)
    if inst.components.container ~= nil then
        inst.components.container:Close()
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle")
    inst.SoundEmitter:PlaySound("dontstarve/common/cook_pot_craft")
end

local function onsave(inst, data)
	if inst.components.mealer:IsMealing() then
		data.ismealing = true
		data.mealprize = inst.components.mealer.prize
	end
end

local function onload(inst, data)
	if data and data.ismealing then
		inst.components.mealer.prize = data.mealprize
		inst.components.mealer:ResumeMealing()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .4)

    inst.MiniMapEntity:SetPriority(5)
    inst.MiniMapEntity:SetIcon("quagmire_mealingstone.png")

    inst.AnimState:SetBank("quagmire_mealingstone")
    inst.AnimState:SetBuild("quagmire_mealingstone")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("mealingstone")
        end)
        return inst
    end
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("mealingstone")
	inst.components.container.onopenfn = onopen
	
    inst:AddComponent("inspectable")
	
	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(3,5)
    inst.components.playerprox:SetOnPlayerFar(onfar)

    inst:AddComponent("lootdropper")
	
	inst:AddComponent("mealer")
	inst.components.mealer:SetStartMealingFn(meal)
	
--    inst:AddComponent("workable")
--    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
--    inst.components.workable:SetWorkLeft(4)
--    inst.components.workable:SetOnFinishCallback(onhammered)
--    inst.components.workable:SetOnWorkCallback(onhit)
	
	inst:ListenForEvent("onbuilt", onbuilt)

	inst.OnSave = onsave 
	inst.OnLoad = onload

    return inst
end

return Prefab("quagmire_mealingstone", fn, assets, prefabs),
	MakePlacer("mealingstone_placer", "quagmire_mealingstone", "quagmire_mealingstone", "idle")
