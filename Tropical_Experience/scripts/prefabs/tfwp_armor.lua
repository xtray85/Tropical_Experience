local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_body", inst._baseBuild, "swap_body")

    if inst.components.fueled then
        inst.components.fueled:StartConsuming()
    end
end

local function OnUnequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")

    if inst.components.fueled then
        inst.components.fueled:StopConsuming()
    end
end

local function SetModifiers(inst, owner, mods)
    if mods.damage and owner.components.combat ~= nil then
        owner.components.combat.externaldamagemultipliers:SetModifier(inst, mods.damage, inst._baseName .. "bonus")
    end
    if mods.spellpower and owner.components.gfspellcaster ~= nil then
        owner.components.gfspellcaster.spellPowerExternal:SetModifier(inst, mods.spellpower, inst._baseName .. "bonus")
    end
    if mods.spellrecharge and owner.components.gfspellcaster ~= nil then
        owner.components.gfspellcaster.rechargeExternal:SetModifier(inst, mods.spellrecharge, inst._baseName .. "bonus")
    end
    if mods.movement and owner.components.locomotor ~= nil then
        owner.components.locomotor:SetExternalSpeedMultiplier(inst, inst._baseName .. "bonus", mods.movement) 
    end
end

local function RemoveModifiers(inst, owner)
    if owner.components.combat ~= nil then
        owner.components.combat.externaldamagemultipliers:RemoveModifier(inst, inst._baseName .. "bonus") 
    end
    if owner.components.gfspellcaster ~= nil then
        owner.components.gfspellcaster.rechargeExternal:RemoveModifier(inst, inst._baseName .. "bonus") 
        owner.components.gfspellcaster.spellPowerExternal:RemoveModifier(inst, inst._baseName .. "bonus") 
    end
    if owner.components.locomotor ~= nil then
        owner.components.locomotor:RemoveExternalSpeedMultiplier(inst, inst._baseName .. "bonus") 
    end
end

local preinitfns = 
{
    steel_wool = function(inst)
        inst:AddTag("fur")
    end,

    golden_chain = function(inst)
        inst:AddTag("metal")
    end,

    moon_heavy = function(inst)
        inst:AddTag("marble")
    end,

    leather_light = function(inst)
        inst:AddTag("fur")
        inst:AddTag("waterproofer")
    end,

    grass_tunic = function(inst)
        inst:AddTag("grass")
    end,

    tusk_vest = function(inst)
        inst:AddTag("fur")
    end,

    worm_suit = function(inst)
        inst:AddTag("fur")
    end,
}

local function TuskVestBuff(owner)
    --local owner = inst.components.inventoryitem.owner
    --if owner == nil or not owner:IsValid() then return end
    owner.components.gfeffectable:RemoveAllEffectsWithTag("tusk_vest")
    if TheWorld:HasTag("cave") then
        if TheWorld.state.iscavenight then
            owner.components.gfeffectable:PushEffect("tusk_vest_speed")
        elseif TheWorld.state.iscaveday then
            owner.components.gfeffectable:PushEffect("tusk_vest_damage")
        else
            owner.components.gfeffectable:PushEffect("tusk_vest_heal")
        end
    else
        if TheWorld.state.isnight then
            owner.components.gfeffectable:PushEffect("tusk_vest_speed")
        elseif TheWorld.state.isday then
            owner.components.gfeffectable:PushEffect("tusk_vest_damage")
        else
            owner.components.gfeffectable:PushEffect("tusk_vest_heal")
        end
    end
end

local function WormSuitBuff(owner)
    owner.components.gfeffectable:PushEffect("worm_suit_buff")
end

local postinitfns = 
{
    steel_wool = function(inst)
        inst:AddComponent("insulator")
        inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)
    end,

    leather_light = function(inst)
        inst:AddComponent("insulator")
        inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)
        inst:AddComponent("waterproofer")
        inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)
    end,

    grass_tunic = function(inst)
        inst:AddComponent("insulator")
        inst.components.insulator:SetSummer()
        inst.components.insulator:SetInsulation(TUNING.INSULATION_SMALL)
    end,

    tusk_vest = function(inst)
        inst:AddComponent("insulator")
        inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)
    end
}

local onequipfns = 
{
    steel_wool = function(inst, owner)
        OnEquip(inst, owner)
        local mods = {damage = 1.1}
        SetModifiers(inst, owner, mods)
    end,

    golden_chain = function(inst, owner)
        OnEquip(inst, owner)
        local mods = {spellpower = 1.1}
        SetModifiers(inst, owner, mods)
    end,

    moon_heavy = function(inst, owner)
        OnEquip(inst, owner)
        local mods = {movement = 0.85}
        SetModifiers(inst, owner, mods)
    end,

    leather_light = function(inst, owner)
        OnEquip(inst, owner)
        local mods = {spellrecharge = 0.9}
        SetModifiers(inst, owner, mods)
    end,

    grass_tunic = function(inst, owner)
        OnEquip(inst, owner)
        local mods = {movement = 1.1}
        SetModifiers(inst, owner, mods)
    end,

    hypno_coat = function(inst, owner) 
        OnEquip(inst, owner)
        if owner._hctask ~= nil then owner._hctask:Cancel() owner._hctask = nil end
        if rawget(_G, "GF") ~= nil and owner.components.leader ~= nil then
            owner._hctask = owner:DoPeriodicTask(5, function(owner)
                for follower, _ in pairs(owner.components.leader.followers) do
                    if follower.components.gfeffectable ~= nil then
                        follower.components.gfeffectable:PushEffect("hypno_coat_buff", owner)
                    end
                end
            end)
        end
    end,

    tusk_vest = function(inst, owner)
        OnEquip(inst, owner)
        if owner.components.gfeffectable ~= nil then
            owner.components.gfeffectable:RemoveAllEffectsWithTag("tusk_vest")
            if TheWorld:HasTag("cave") then
                if TheWorld.state.iscaveday then
                    owner.components.gfeffectable:PushEffect("tusk_vest_speed")
                elseif TheWorld.state.iscavedusk then
                    owner.components.gfeffectable:PushEffect("tusk_vest_damage")
                else
                    owner.components.gfeffectable:PushEffect("tusk_vest_heal")
                end
            else
                if TheWorld.state.isday then
                    owner.components.gfeffectable:PushEffect("tusk_vest_speed")
                elseif TheWorld.state.isdusk then
                    owner.components.gfeffectable:PushEffect("tusk_vest_damage")
                else
                    owner.components.gfeffectable:PushEffect("tusk_vest_heal")
                end
            end
            owner:WatchWorldState("phase", TuskVestBuff)
        end
    end,

    worm_suit = function(inst, owner)
        OnEquip(inst, owner)
        if owner.components.gfeffectable ~= nil then
            owner:ListenForEvent("onhitother", WormSuitBuff)
        end
    end,
}

local onunequipfns = 
{
    steel_wool = function(inst, owner)
        OnUnequip(inst, owner)
        RemoveModifiers(inst, owner)
    end,

    golden_chain = function(inst, owner)
        OnUnequip(inst, owner)
        RemoveModifiers(inst, owner)
    end,

    moon_heavy = function(inst, owner)
        OnUnequip(inst, owner)
        RemoveModifiers(inst, owner)
    end,

    leather_light = function(inst, owner)
        OnUnequip(inst, owner)
        RemoveModifiers(inst, owner)
    end,

    grass_tunic = function(inst, owner)
        OnUnequip(inst, owner)
        RemoveModifiers(inst, owner)
    end,

    hypno_coat = function(inst, owner) 
        OnUnequip(inst, owner)
        if owner._hctask ~= nil then owner._hctask:Cancel() owner._hctask = nil end
    end,

    tusk_vest = function(inst, owner)
        OnUnequip(inst, owner)
        if owner.components.gfeffectable ~= nil then
            owner.components.gfeffectable:RemoveAllEffectsWithTag("tusk_vest")
            owner:StopWatchingWorldState("phase", TuskVestBuff)
        end
    end,

    worm_suit = function(inst, owner)
        OnUnequip(inst, owner)
        if owner.components.gfeffectable ~= nil then
            owner:RemoveEventCallback("onhitother", WormSuitBuff)
        end
    end,
}

local function MakeArmor(name, data)
    local build = data.build
    
    local assets = 
    {
        Asset("ANIM", "anim/" .. build .. ".zip"),
    }

    local function common()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)
	
        inst.AnimState:SetBank(build)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("armor")

        inst.foleysound = data.sound or "dontstarve/movement/foley/grassarmour"

        if preinitfns[name] then preinitfns[name](inst) end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/tfwp_inventoryimgs.xml"

        inst:AddComponent("inspectable")

        inst:AddComponent("tradable")

        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.BODY
        inst.components.equippable:SetOnEquip(onequipfns[name] or OnEquip)
        inst.components.equippable:SetOnUnequip(onunequipfns[name] or OnUnequip)

        if data.fueled then
            inst:AddComponent("fueled")
            inst.components.fueled.fueltype = FUELTYPE.USAGE
            inst.components.fueled:InitializeFuelLevel(data.fueled)
            inst.components.fueled:SetDepletedFn(inst.Remove)
        elseif data.armor then
            inst:AddComponent("armor")
            inst.components.armor:InitCondition(data.armor[1] or 1000, data.armor[2] or 0.5)
        end

        MakeHauntableLaunch(inst)

        if postinitfns[name] then postinitfns[name](inst) end

        inst._baseName = name
        inst._baseBuild = build

        return inst
    end

    return Prefab("tfwp_".. name.. "_armor", common, assets)
end

local armor = 
{
    steel_wool = {build = "tfwp_steel_wool_armor", sound = "dontstarve/movement/foley/fur", armor = {1500, 0.85}},
    golden_chain = {build = "tfwp_flint_armor", sound = "dontstarve/movement/foley/metalarmour", armor = {800, 0.5}},
    moon_heavy = {build = "tfwp_moon_heavy_armor", sound = "dontstarve/movement/foley/marblearmour", armor = {2500, 0.95}},
    leather_light = {build = "tfwp_leather_armor", sound = "dontstarve/movement/foley/fur", fueled = TUNING.TOTAL_DAY_TIME * 5},
    grass_tunic = {build = "tfwp_grass_light_armor", sound = "dontstarve/movement/foley/grassarmour", fueled = TUNING.TOTAL_DAY_TIME * 5},

    tusk_vest = {build = "tfwp_tusk_vest_armor", sound = "dontstarve/movement/foley/fur", fueled = TUNING.TOTAL_DAY_TIME * 5},
    hypno_coat = {build = "tfwp_hypno_coat_armor", sound = "dontstarve/movement/foley/grassarmour", fueled = TUNING.TOTAL_DAY_TIME * 5},
    worm_suit = {build = "tfwp_worm_suit_armor", sound = "dontstarve/movement/foley/shellarmour", armor = {1200, 0.4}},
}

local ret = {}

for k, v in pairs(armor) do
    table.insert(ret, MakeArmor(k, v))
end

return unpack(ret)