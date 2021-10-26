local assets=
{
	Asset("ANIM", "anim/machete.zip"),
	Asset("ANIM", "anim/machete_obsidian.zip"),
	Asset("ANIM", "anim/goldenmachete.zip"),
	Asset("ANIM", "anim/swap_machete.zip"),
	Asset("ANIM", "anim/swap_machete_obsidian.zip"),
	Asset("ANIM", "anim/swap_goldenmachete.zip"),
}

 
 
local function ondropped(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))


local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
local plataforma = false
local pos_x, pos_y, pos_z = inst.Transform:GetWorldPosition()
local entities = TheSim:FindEntities(x, 0, z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS, WALKABLE_PLATFORM_TAGS)
for i, v in ipairs(entities) do
local walkable_platform = v.components.walkableplatform
if walkable_platform and walkable_platform.radius == nil then walkable_platform.radius = 4 end         
if walkable_platform ~= nil then  
local platform_x, platform_y, platform_z = v.Transform:GetWorldPosition()
local distance_sq = VecUtil_LengthSq(x - platform_x, z - platform_z)
if distance_sq <= walkable_platform.radius * walkable_platform.radius then plataforma = true end
end
end			
		
if not plataforma and (ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS) then
inst.AnimState:PlayAnimation("idle_water", true)
inst.AnimState:OverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:OverrideSymbol("water_shadow", "ripple_build", "water_shadow")		
if not inst.replica.inventoryitem:IsHeld() then	inst.components.inventoryitem:AddMoisture(80) end
else
inst.AnimState:SetLayer(LAYER_WORLD)
inst.AnimState:PlayAnimation("idle", true)
inst.AnimState:ClearOverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:ClearOverrideSymbol("water_shadow", "ripple_build", "water_shadow")	
end
end
 
 
 
local function onfinished(inst)
	inst:Remove()
end

local wilson_attack = 34
local MACHETE_DAMAGE = wilson_attack* .88
local MACHETE_USES = 100 --lols why does it have 400 uses?
local OBSIDIANTOOLFACTOR = 2.5

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_machete", "swap_machete")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	-- MakeInventoryFloatable(inst, "idle_water", "idle")

	anim:SetBank("machete")
	anim:SetBuild("machete")
	anim:PlayAnimation("idle")

	inst:AddTag("sharp")
	inst:AddTag("machete")
	inst:AddTag("aquatic")

    if not TheWorld.ismastersim then
        return inst
    end
	inst.entity:SetPristine()
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(MACHETE_DAMAGE)

	-----
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.HACK, 2.5)
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(MACHETE_USES)
	inst.components.finiteuses:SetUses(MACHETE_USES)
	inst.components.finiteuses:SetOnFinished( onfinished)
	inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1 / OBSIDIANTOOLFACTOR)
	-------
	inst:AddComponent("equippable")

	inst:AddComponent("inspectable")



	inst.components.equippable:SetOnEquip( onequip )

	inst.components.equippable:SetOnUnequip( onunequip)

	return inst
end

local function normal(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	-- MakeInventoryFloatable(inst, "idle_water", "idle")

	anim:SetBank("machete")
	anim:SetBuild("machete")
	anim:PlayAnimation("idle")

	inst:AddTag("sharp")
	inst:AddTag("machete")
	inst:AddTag("aquatic")

    if not TheWorld.ismastersim then
        return inst
    end
	inst.entity:SetPristine()
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(MACHETE_DAMAGE)

	-----
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.HACK)
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(MACHETE_USES)
	inst.components.finiteuses:SetUses(MACHETE_USES)
	inst.components.finiteuses:SetOnFinished( onfinished)
	inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1)
	-------
	inst:AddComponent("equippable")

	inst:AddComponent("inspectable")



	inst.components.equippable:SetOnEquip( onequip )

	inst.components.equippable:SetOnUnequip( onunequip)

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst.components.inventoryitem:SetOnDroppedFn(ondropped)
	inst:DoTaskInTime(0, ondropped)	
	return inst
end

local function onequipgold(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_goldenmachete", "swap_goldenmachete")
	owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function golden(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	-- MakeInventoryFloatable(inst, "idle_water", "idle")

	inst.AnimState:SetBuild("goldenmachete")
	inst.AnimState:SetBank("machete")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("sharp")
	inst:AddTag("machete")
	inst:AddTag("aquatic")

    if not TheWorld.ismastersim then
        return inst
    end
	inst.entity:SetPristine()
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(MACHETE_DAMAGE)

	-----
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.HACK)
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(MACHETE_USES)
	inst.components.finiteuses:SetUses(MACHETE_USES)
	inst.components.finiteuses:SetOnFinished( onfinished)
	inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1)
	-------
	inst:AddComponent("equippable")

	inst:AddComponent("inspectable")



	inst.components.equippable:SetOnEquip( onequip )

	inst.components.equippable:SetOnUnequip( onunequip)
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst.components.finiteuses:SetConsumption(ACTIONS.HACK, 1 / TUNING.GOLDENTOOLFACTOR)
	inst.components.weapon.attackwear = 1 / TUNING.GOLDENTOOLFACTOR
	inst.components.equippable:SetOnEquip( onequipgold )
	inst.components.inventoryitem:SetOnDroppedFn(ondropped)
	inst:DoTaskInTime(0, ondropped)	
	return inst
end

	local function PercentChanged(inst)
		local equippable = inst.components.equippable
		local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
		if equippable ~= nil and equippable:IsEquipped() then
		if owner ~= nil then
			local newtemp = owner.components.temperature:GetCurrent()
			owner.components.temperature:SetTemperature(newtemp+2)
		end end
	end
	local function gfg(inst)
		local equippable = inst.components.equippable
		local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
		if equippable ~= nil and equippable:IsEquipped() then
            if owner ~= nil then
				if owner.components.temperature ~= nil then
					if owner.components.temperature:GetCurrent() > 65 then
						if inst._Light == nil or not inst._Light:IsValid() then
							inst._Light = SpawnPrefab("playerlight")
						end
						if inst._Light ~= nil then
							inst._Light.entity:SetParent(inst.entity)
						end
					else
					if inst._Light ~= nil then
						if inst._Light:IsValid() then
							inst._Light:Remove()
						end
					end
					end
				end
				end
				else
				if inst._Light ~= nil then
						if inst._Light:IsValid() then
							inst._Light:Remove()
					end
			end
		end
		if inst.components.finiteuses:GetUses() <= 0 then
		inst:Remove()
		end
	end
	local function fgf(inst)
		if inst.gfg ~= nil then
			inst.gfg:Cancel()
		end
		inst.gfg = inst:DoPeriodicTask(.1,gfg)
	end


local function onequipobsidian(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_machete_obsidian", "swap_machete")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	inst:ListenForEvent("percentusedchange", PercentChanged)
end

	local function onunequipobsidian(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
	inst:RemoveEventCallback("percentusedchange", PercentChanged)
	end

	local function obsidian_custom_init(inst)
		inst:RemoveEventCallback("percentusedchange", PercentChanged)
		inst:AddComponent("waterproofer")
		inst.AnimState:SetBuild("machete_obsidian")
		inst.AnimState:SetBank("machete_obsidian")
	end	
	
local function obsidian(Sim)
	local inst = fn(obsidian_custom_init)

	if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst.AnimState:SetBuild("machete_obsidian")
	inst.AnimState:SetBank("machete_obsidian")

	-- inst.components.tool:SetAction(ACTIONS.HACK, TUNING.OBSIDIANTOOL_WORK)

	inst.components.weapon.attackwear = 1 / OBSIDIANTOOLFACTOR
	inst.components.equippable:SetOnEquip(onequipobsidian)
	inst.components.equippable:SetOnUnequip(onunequipobsidian)
	
	inst.gfg = fgf(inst)

	inst.components.inventoryitem:SetOnDroppedFn(ondropped)
	inst:DoTaskInTime(0, ondropped)	

	return inst
end

return Prefab( "machete", normal, assets),
	   Prefab( "goldenmachete", golden, assets),
	   Prefab( "obsidianmachete", obsidian, assets)
