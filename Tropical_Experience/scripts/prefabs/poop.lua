local assets =
{
    Asset("ANIM", "anim/poop.zip"),
	Asset("SCRIPT", "scripts/prefabs/fertilizer_nutrient_defs.lua"),	
	Asset("ANIM", "anim/monkey_projectile.zip"),
	Asset("ANIM", "anim/swap_poop.zip"),	
}

local prefabs =
{
    "flies",
    "poopcloud",
    "gridplacer_farmablesoil",	
}

local FERTILIZER_DEFS = require("prefabs/fertilizer_nutrient_defs").FERTILIZER_DEFS

local function OnBurn(inst)
    DefaultBurnFn(inst)
    if inst.flies ~= nil then
        inst.flies:Remove()
        inst.flies = nil
    end
end

local function FuelTaken(inst, taker)
    local fx = taker.components.burnable ~= nil and taker.components.burnable.fxchildren[1] or nil
    local x, y, z
    if fx ~= nil and fx:IsValid() then
        x, y, z = fx.Transform:GetWorldPosition()
    else
        x, y, z = taker.Transform:GetWorldPosition()
    end
    SpawnPrefab("poopcloud").Transform:SetPosition(x, y + 1, z)
end

local function OnDropped(inst)
    if inst.flies == nil then
        inst.flies = inst:SpawnChild("flies")
    end
	
	inst.x, inst.y, inst.z = inst.Transform:GetWorldPosition()
end

local function OnPickup(inst, player, pos)
if inst:HasTag("podepegar") then -- print("1") 
inst:RemoveTag("podepegar")

    if inst.flies ~= nil then
        inst.flies:Remove()
        inst.flies = nil
    end
	
	local x,y,z = player.Transform:GetWorldPosition()
	local radius = 20
	local ents = TheSim:FindEntities(x,y,z, radius, {"city_pig"}, {"guard"})

	local closest_pig = nil
	for _, pig in pairs(ents) do
--	print(pig)
		if pig.components.citypossession then
			closest_pig = pig
			break
		end
	end

	if closest_pig then
--	print("3")
		closest_pig.poop_tip = true
	end
end
end

local function OnPickup2(inst)
	
end

local function OnHitPoop(inst, attacker, target)
    local other = SpawnPrefab("poop_splat")
	local pt = inst:GetPosition()
    other.Transform:SetPosition(pt:Get())
	inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey/poopsplat")
	if target and target:HasTag("bird") then 
	target:DoTaskInTime(0.1, function(target) target.sg:GoToState("stunned") end)
	end
    inst:Remove()
end

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_poop", "swap_poop")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onthrown(inst, attacker, target)
--	if attacker and attacker.prefab == "wilbur" then
    inst.AnimState:SetBank("monkey_projectile")
    inst.AnimState:SetBuild("monkey_projectile")
    inst.AnimState:PlayAnimation("idle", true)
    inst.components.weapon:SetDamage(10)
	inst.Physics:ClearCollisionMask() 
	inst.Physics:CollidesWith(COLLISION.GROUND)	
--	else
--    local x, y, z = inst.Transform:GetWorldPosition()	
--	local merda = SpawnPrefab("poop")
--	merda.Transform:SetPosition(x, y , z)
--    inst:Remove()
--	end
end

local function GetFertilizerKey(inst)
    return inst.prefab
end

local function fertilizerresearchfn(inst)
    return inst:GetFertilizerKey()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("poop")
    inst.AnimState:SetBuild("poop")
    inst.AnimState:PlayAnimation("dump")

    MakeInventoryFloatable(inst, "med", 0.1, 0.73)
    MakeDeployableFertilizerPristine(inst)
	inst:AddTag("pooptocompact")	
    inst:AddTag("fertilizerresearchable")
	
    inst.GetFertilizerKey = GetFertilizerKey

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:PushAnimation("idle", false)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst:AddComponent("stackable")
	
    inst:AddComponent("fertilizerresearchable")
    inst.components.fertilizerresearchable:SetResearchFn(fertilizerresearchfn)	

    inst:AddComponent("fertilizer")
    inst.components.fertilizer.fertilizervalue = TUNING.POOP_FERTILIZE
    inst.components.fertilizer.soil_cycles = TUNING.POOP_SOILCYCLES
    inst.components.fertilizer.withered_cycles = TUNING.POOP_WITHEREDCYCLES
    inst.components.fertilizer:SetNutrients(FERTILIZER_DEFS.poop.nutrients)

    inst:AddComponent("smotherer")
    inst:AddComponent("interactions")
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPickupFn(OnPickup)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup2)

    inst.flies = inst:SpawnChild("flies")

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL
    inst.components.fuel:SetOnTakenFn(FuelTaken)

    if TheNet:GetServerGameMode() == "quagmire" then
        inst.components.fuel:SetOnTakenFn(nil)
    end

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    inst.components.burnable:SetOnIgniteFn(OnBurn)
    MakeSmallPropagator(inst)

    MakeDeployableFertilizer(inst)
    MakeHauntableLaunchAndIgnite(inst)

    return inst
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("monkey_projectile")
    inst.AnimState:SetBuild("monkey_projectile")
    inst.AnimState:PlayAnimation("idle", false)

    MakeInventoryFloatable(inst)

	inst:AddTag("thrown")
	inst:AddTag("projectile")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:PushAnimation("idle", false)

    inst:AddComponent("inspectable")
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(OnEquip)
	inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable.equipstack = true
	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetRange(8, 10)	

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    inst:AddComponent("stackable")
	
	inst:AddComponent("projectile")
	inst.components.projectile:SetSpeed(20)
	inst.components.projectile.hitdist = 0.5
	inst.components.projectile:SetOnHitFn(OnHitPoop)
	inst.components.projectile:SetOnThrownFn(onthrown)	

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL
    inst.components.fuel:SetOnTakenFn(FuelTaken)

    return inst
end

return Prefab("poop", fn, assets, prefabs),
		Prefab("poop2", fn1, assets, prefabs)
