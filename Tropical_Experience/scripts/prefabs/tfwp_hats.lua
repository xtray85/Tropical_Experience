local function OnEqipHelm(inst, owner)
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAIR_HAT")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")

    owner.AnimState:OverrideSymbol("swap_hat", "hat_" .. inst._baseBuild, "swap_hat")

    if owner:HasTag("player") then
        owner.AnimState:Hide("HEAD")
        owner.AnimState:Show("HEAD_HAT")
    end

    if inst.components.fueled then
        inst.components.fueled:StartConsuming()
    end
end

local function OnEqipCrown(inst, owner)
    owner.AnimState:Show("HAT")
    owner.AnimState:OverrideSymbol("swap_hat", "hat_" .. inst._baseBuild, "swap_hat")

    if inst.components.fueled then
        inst.components.fueled:StartConsuming()
    end
end

local function OnUneqipHelm(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_hat")
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAT")
    end

    if inst.components.fueled then
        inst.components.fueled:StopConsuming()
    end
end

local function OnUneqipCrown(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_hat")
    owner.AnimState:Hide("HAT")

    if inst.components.fueled then
        inst.components.fueled:StopConsuming()
    end
end

local function DoPeriodicHeal(inst)
    local owner = inst.components.inventoryitem.owner
    if owner and not owner.components.health:IsDead() and owner.components.health:GetPercent() < 0.8 and owner:IsValid() then
        owner.components.health:DoDelta(0.1, true, inst)
    end
end

local onequipfns = 
{
    healinggarland = function(inst, owner)
        OnEqipCrown(inst, owner)
        if owner.components.health then
            inst._htask = inst:DoPeriodicTask(0.5, DoPeriodicHeal)
        end
    end,
}

local onunequipfns = 
{
    healinggarland = function(inst, owner)
        OnUneqipCrown(inst, owner)
        if inst._htask ~= nil then
            inst._htask:Cancel()
            inst._htask = nil
        end
    end,
}

local function MakeHat(name, data)
    local build = data.build
    
    local assets = 
    {
        Asset("ANIM", "anim/hat_" .. build .. ".zip"),
    }

    local function common()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)	

        inst.AnimState:SetBank(build .. "hat")
        inst.AnimState:SetBuild("hat_" .. build)
        inst.AnimState:PlayAnimation("anim")

        if data.perish then
            inst:AddTag("show_spoilage")
        end
        inst:AddTag("hat")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inventoryitem")

        inst:AddComponent("inspectable")

        inst:AddComponent("tradable")

        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
        inst.components.equippable:SetOnEquip(onequipfns[name] or OnEqipHelm)
        inst.components.equippable:SetOnUnequip(onunequipfns[name] or OnUneqipHelm)

        if data.fueled then
            inst:AddComponent("fueled")
            inst.components.fueled.fueltype = FUELTYPE.MAGIC
            inst.components.fueled:InitializeFuelLevel(data.fueled)
            inst.components.fueled:SetDepletedFn(inst.Remove)
        elseif data.perish then
            inst:AddComponent("perishable")
            inst.components.perishable:SetPerishTime(data.perish)
            inst.components.perishable:StartPerishing()
            inst.components.perishable:SetOnPerishFn(inst.Remove)
        elseif data.armor then
            inst:AddComponent("armor")
            inst.components.armor:InitCondition(data.armor[1] or 1000, data.armor[2] or 0.5)
        end
		
		
		if name == "lightdamager" then	
        inst.components.equippable:AddDamageTypeBuff(false,DAMAGETYPES.PHYSICAL,"barbedhelm",0.1)		
		end

		if name == "strongdamager" then	
        inst.components.equippable:AddDamageTypeBuff(false,DAMAGETYPES.PHYSICAL,"noxhelm",0.15)		
		end

		if name == "feathercrown" then
		inst.components.equippable.walkspeedmult = 1.2
		end
		
		if name == "recharger" then
		inst.components.equippable:AddUniqueBuff({cooldown_mult=-0.20})
		end
		
		if name == "healingflower" then
		inst.components.equippable:AddUniqueBuff({heal_recieved_mult=0.25})
		end
		
		if name == "tiaraflowerpetals" then
		inst.components.equippable:AddUniqueBuff({heal_dealt_mult=0.2})
		end

		if name == "eyecirclet" then
        inst.components.equippable:AddDamageTypeBuff(false,DAMAGETYPES.MAGIC,"clairvoyantcrown",0.25)
		inst.components.equippable.walkspeedmult = 1.1
		inst.components.equippable:AddUniqueBuff({cooldown_mult=-0.20})		
		end			

		if name == "crowndamager" then
        inst.components.equippable:AddDamageTypeBuff(false,DAMAGETYPES.PHYSICAL,"resplendentnoxhelm",0.15)		
		inst.components.equippable.walkspeedmult = 1.1
		inst.components.equippable:AddUniqueBuff({cooldown_mult=-0.20})		
		end
		
		if name == "healinggarland" then
		inst.components.equippable.walkspeedmult = 1.1
		inst.components.equippable:AddUniqueBuff({cooldown_mult=-0.20})		
		end			
		
        MakeHauntableLaunch(inst)

        inst._baseName = name
        inst._baseBuild = build

        return inst
    end

    return Prefab("lavaarena_".. name.. "hat", common, assets)
end

local hats = 
{
    lightdamager = {build = "lightdamager", fueled = TUNING.TOTAL_DAY_TIME * 5},
    strongdamager = {build = "strongdamager", fueled = TUNING.TOTAL_DAY_TIME * 5},
    feathercrown = {build = "feathercrown", fueled = TUNING.TOTAL_DAY_TIME * 5},
    recharger = {build = "recharger", fueled = TUNING.TOTAL_DAY_TIME * 5},
    healingflower = {build = "healingflower", perish = TUNING.TOTAL_DAY_TIME * 3},
    tiaraflowerpetals = {build = "tiaraflowerpetals", perish = TUNING.TOTAL_DAY_TIME * 3},
    eyecirclet = {build = "eyecirclet", fueled = TUNING.TOTAL_DAY_TIME * 5},
    crowndamager = {build = "crowndamager", armor = {1500, 0.7}},
    healinggarland = {build = "healinggarland", perish = TUNING.TOTAL_DAY_TIME * 3},
}

local ret = {}

for k, v in pairs(hats) do
    table.insert(ret, MakeHat(k, v))
end

return unpack(ret)