local function GetObsidianHeat(inst, observer)
    local charge, maxcharge = inst.components.obsidiantool:GetCharge()
    local heat = Lerp(0, TUNING.OBSIDIAN_TOOL_MAXHEAT, charge/maxcharge)
    return heat
end

local function GetObsidianEquippedHeat(inst, observer)
    local heat = GetObsidianHeat(inst, observer)
    heat = math.clamp(heat, 0, TUNING.OBSIDIAN_TOOL_MAXHEAT)
    --awkward/hacky but safer
    if observer.components.temperature then
        local current = observer.components.temperature:GetCurrent()
        if heat > current then
            heat = heat + current
        elseif heat < current then
            heat = current --cancel out heat so tools don't cool you down
        end
    end
    return heat
end

local function ChangeObsidianLight(inst, old, new)
    local percentage = new/inst.components.obsidiantool.maxcharge
    local rad = Lerp(1, 2.5, percentage)

    if percentage >= inst.components.obsidiantool.red_threshold then
        inst.Light:Enable(true)
        inst.Light:SetColour(254/255,98/255,75/255)
        inst.Light:SetRadius(rad)
    elseif percentage >= inst.components.obsidiantool.orange_threshold then
        inst.Light:Enable(true)
        inst.Light:SetColour(255/255,159/255,102/255)
        inst.Light:SetRadius(rad)
    elseif percentage >= inst.components.obsidiantool.yellow_threshold then
        inst.Light:Enable(true)
        inst.Light:SetColour(255/255,223/255,125/255)
        inst.Light:SetRadius(rad)
    else
        inst.Light:Enable(false)
    end
end

local function ManageObsidianLight(inst)
    local cur, max = inst.components.obsidiantool:GetCharge() 
    if cur/max >= inst.components.obsidiantool.yellow_threshold then
        inst.Light:Enable(true)
    else
        inst.Light:Enable(false)
    end
end

local function ObsidianToolAttack(inst, attacker, target, projectile)
    --deal bonus damage to the target based on the original damage of the spear.
    local base_damage = inst.components.weapon.damage
    local charge, maxcharge = inst.components.obsidiantool:GetCharge()
    local damage_mod = Lerp(0, 1, charge/maxcharge) --Deal up to double damage based on charge.

    local remove = false
    if projectile and not inst:HasTag("projectile") then
        inst:AddTag("projectile")
        remove = true
    end
    
    target.components.combat:GetAttacked(attacker, base_damage * damage_mod, inst, "FIRE")

    if remove then
        inst:RemoveTag("projectile")
    end

    --light target on fire if at maximum heat.
    if charge == maxcharge then
        if target.components.burnable then
            target.components.burnable:Ignite()
        end
    end
end

function MakeObsidianTool(inst, tooltype)
    inst:AddTag("obsidian")
    inst:AddTag("notslippery")
    inst.no_wet_prefix = true

    if inst.components.floatable then
        inst.components.floatable:SetOnHitWaterFn(function(inst)
            inst.components.obsidiantool:SetCharge(0)
        end)
    end

    inst:AddComponent("obsidiantool")
    inst.components.obsidiantool.tool_type = tooltype

    if not inst.components.heater then
        --only hook up heater to obsidiantool if the heater isn't already on.
        inst:AddComponent("heater")
        inst.components.heater.show_heat = true

        inst.components.heater.heatfn = GetObsidianHeat
        inst.components.heater.minheat = 0
        inst.components.heater.maxheat = TUNING.OBSIDIAN_TOOL_MAXHEAT

        inst.components.heater.equippedheatfn = GetObsidianEquippedHeat
        --inst.components.heater.minequippedheat = 0
        --inst.components.heater.maxequippedheat = TUNING.OBSIDIAN_TOOL_MAXHEAT

        inst.components.heater.carriedheatfn = GetObsidianHeat
        inst.components.heater.mincarriedheat = 0
        inst.components.heater.maxcarriedheat = TUNING.OBSIDIAN_TOOL_MAXHEAT
    end

    if not inst.Light then
        --only add a light if there is no light already
        inst.entity:AddLight()
        inst.Light:SetFalloff(0.5)
        inst.Light:SetIntensity(0.75)
        inst.components.obsidiantool.onchargedelta = ChangeObsidianLight
        inst:ListenForEvent("equipped", ManageObsidianLight)
        inst:ListenForEvent("onputininventory", ManageObsidianLight)
        inst:ListenForEvent("ondropped", ManageObsidianLight)
    end

    if inst.components.weapon then
        if inst.components.weapon.onattack then
            print("Obsidian Weapon", inst, "already has an onattack!")
        else
            inst.components.weapon:SetOnAttack(ObsidianToolAttack)
        end
    end
end






















local function Makeaxe(name)
	local aname = "axe"..name
	local fname = "axe_"..name --build 2
    local symname = name.."axe" --bank 1
    local prefabname = aname

	local function onequip(inst, owner)
		owner.AnimState:OverrideSymbol("swap_object", "swap_axe", "swap_axe")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	end

	local function onunequip(inst, owner)
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
	end

    local function simple(custom_init)
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)	

        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("axe")
		inst:AddTag(symname)

        if custom_init ~= nil then
            custom_init(inst)
        end

	inst.entity:SetPristine()

        if not TheWorld.ismastersim then
        return inst
    end


        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"
		
        inst:AddComponent("inspectable")

        inst:AddComponent("equippable")
		inst.components.equippable:SetOnEquip(onequip)

		inst.components.equippable:SetOnUnequip(onunequip)
		
		inst:AddComponent("finiteuses")
		inst:AddComponent("tool")
		
		inst:AddComponent("weapon")
		inst.components.weapon:SetDamage(TUNING.AXE_DAMAGE)

        MakeHauntableLaunch(inst)

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
		onequip(inst, owner)
		owner.AnimState:OverrideSymbol("swap_object", "swap_axe_obsidian", "swap_axe")
		inst:ListenForEvent("percentusedchange", PercentChanged)
	end
	local function onunequipobsidian(inst, owner)
		onunequip(inst, owner)
		inst:RemoveEventCallback("percentusedchange", PercentChanged)
	end
	local function obsidian_custom_init(inst)
		inst:RemoveEventCallback("percentusedchange", PercentChanged)
		inst:AddComponent("waterproofer")
		inst.AnimState:SetBuild("axe_obsidian")
		inst.AnimState:SetBank("axe_obsidian")
	end
	local function obsidian(Sim)
		local inst = simple(obsidian_custom_init)

		if not TheWorld.ismastersim then
				return inst
			end
			
		inst.components.finiteuses:SetConsumption(ACTIONS.CHOP, 1 / 2.5)
		inst.components.weapon.attackwear = 1 / 2.5
		inst.components.equippable:SetOnEquip(onequipobsidian)
		inst.components.equippable:SetOnUnequip(onunequipobsidian)

		inst.components.tool:SetAction(ACTIONS.CHOP, 2.5)
		
		inst.gfg = fgf(inst)
		
		return inst
	end
	
    local fn = nil
    local assets = { 	Asset("ANIM", "anim/"..fname..".zip"),
	Asset("ATLAS", "images/inventoryimages/volcanoinventory.xml"),
	Asset("ANIM", "anim/swap_axe_"..name..".zip")
	}
    local prefabs = nil

    if name == "obsidian" then
        fn = obsidian
    elseif name == "cactus" then
        fn = cactus
	end
	
    return Prefab("common/inventory/"..prefabname.."", fn, assets, prefabs)
end
return Makeaxe("obsidian")
