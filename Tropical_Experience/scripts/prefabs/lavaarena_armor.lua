local function MakeArmour(name, data)
    local assets =
    {
        Asset("ANIM", "anim/"..data.build..".zip"),
    }
	
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

local onequipfns = 
{
    lavaarena_armorlight = function(inst, owner)
        OnEquip(inst, owner)
    end,
	
    lavaarena_armormediumdamager = function(inst, owner)
        OnEquip(inst, owner)
    end,
	
    lavaarena_armormediumrecharger = function(inst, owner)
        OnEquip(inst, owner)
    end,	
	
    lavaarena_armorextraheavy = function(inst, owner)
        OnEquip(inst, owner)
		owner:AddTag("wereplayer")
    end,
	
    lavaarena_armor_hpextraheavy = function(inst, owner)
        OnEquip(inst, owner)
		owner:AddTag("wereplayer")
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth + 100 
		owner.components.health:DoDelta(0)
		end
    end,

    lavaarena_armor_hpdamager = function(inst, owner)
        OnEquip(inst, owner)
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth + 50 
		owner.components.health:DoDelta(0)
		end
    end,

    lavaarena_armor_hprecharger = function(inst, owner)
        OnEquip(inst, owner)
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth + 50 
		owner.components.health:DoDelta(0)
		end
    end,

    lavaarena_armor_hppetmastery = function(inst, owner)
        OnEquip(inst, owner)
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth + 75 
		owner.components.health:DoDelta(0)
		end
    end,	
	
}

local onunequipfns = 
{

    lavaarena_armorlight = function(inst, owner) 
        OnUnequip(inst, owner)
    end,
	
    lavaarena_armormediumdamager = function(inst, owner)
        OnUnequip(inst, owner)
    end,	
	
	
	
    lavaarena_armormediumrecharger = function(inst, owner) 
        OnUnequip(inst, owner)
    end,	

    lavaarena_armorextraheavy = function(inst, owner) 
        OnUnequip(inst, owner)
		owner:RemoveTag("wereplayer")
    end,
	
    lavaarena_armor_hpextraheavy = function(inst, owner) 
        OnUnequip(inst, owner)
		owner:AddTag("wereplayer")		
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth - 100 
		owner.components.health:DoDelta(0)
		end
    end,
	
    lavaarena_armor_hpdamager = function(inst, owner) 
        OnUnequip(inst, owner)	
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth - 50 
		owner.components.health:DoDelta(0)
		end
    end,

    lavaarena_armor_hprecharger = function(inst, owner) 
        OnUnequip(inst, owner)	
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth - 50 
		owner.components.health:DoDelta(0)
		end
    end,

    lavaarena_armor_hppetmastery = function(inst, owner) 
        OnUnequip(inst, owner)	
		if owner.components.health then 
		owner.components.health.maxhealth = owner.components.health.maxhealth - 75 
		owner.components.health:DoDelta(0)
		end
    end,	
	
}

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)
		
        inst.AnimState:SetBank(data.build)
        inst.AnimState:SetBuild(data.build)
        inst.AnimState:PlayAnimation("anim")

        for i, v in ipairs(data.tags) do
            inst:AddTag(v)
        end
--        inst:AddTag("hide_percentage")

        inst.foleysound = data.foleysound

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inventoryitem")
		
        inst:AddComponent("inspectable")	
		
        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.BODY
        inst.components.equippable:SetOnEquip(onequipfns[name] or OnEquip)
        inst.components.equippable:SetOnUnequip(onunequipfns[name] or OnUnequip)
		if name == "lavaarena_armorlightspeed" then
		inst.components.equippable.walkspeedmult = 1.1
		end
		if name == "lavaarena_armorextraheavy" then
		inst.components.equippable.walkspeedmult = 0.85
		end			
		
		if name == "lavaarena_armormediumdamager" then	
        inst.components.equippable:AddDamageTypeBuff(false,DAMAGETYPES.PHYSICAL,"jaggedarmor",0.1)		
		end
		
		if name == "lavaarena_armor_hpdamager" then
        inst.components.equippable:AddDamageTypeBuff(false,DAMAGETYPES.PHYSICAL,"armor_hpdamager",0.2)		
		end
		
		if name == "lavaarena_armorlight" then
		inst.components.equippable:AddUniqueBuff({cooldown_mult=-0.10})
		end
		
		if name == "lavaarena_armormediumrecharger" then
		inst.components.equippable:AddUniqueBuff({cooldown_mult=-0.20})
		end	

		if name == "lavaarena_armor_hprecharger" then		
		inst.components.equippable:AddUniqueBuff({cooldown_mult=-0.30})
		end		
	
        if data.armor then
            inst:AddComponent("armor")
            inst.components.armor:InitCondition(data.armor[1] or 1000, data.armor[2] or 0.5)
        end	
		
        MakeHauntableLaunch(inst)

        inst._baseBuild = data.build
        inst.bonusdeataque = 0		
			
        return inst
    end

    return Prefab(name, fn, assets, data.prefabs)
end

local armors = {}
for k, v in pairs({
    ["lavaarena_armorlight"] =
    {
        build = "armor_light",
        tags = { "grass" },
        foleysound = "dontstarve/movement/foley/grassarmour",
		armor = {1500, 0.50},
    },

    ["lavaarena_armorlightspeed"] =
    {
        build = "armor_lightspeed",
        tags = { "grass" },
        foleysound = "dontstarve/movement/foley/grassarmour",
		armor = {1500, 0.60},
    },

    ["lavaarena_armormedium"] =
    {
        build = "armor_medium",
        tags = { "wood" },
        foleysound = "dontstarve/movement/foley/logarmour",
		armor = {1500, 0.75},
    },

    ["lavaarena_armormediumdamager"] =
    {
        build = "armor_mediumdamager",
        tags = { "wood" },
        foleysound = "dontstarve/movement/foley/logarmour",
		armor = {1500, 0.75},
    },

    ["lavaarena_armormediumrecharger"] =
    {
        build = "armor_mediumrecharger",
        tags = { "wood" },
        foleysound = "dontstarve/movement/foley/logarmour",
		armor = {1500, 0.75},
    },

    ["lavaarena_armorheavy"] =
    {
        build = "armor_heavy",
        tags = { "marble" },
        foleysound = "dontstarve/movement/foley/marblearmour",
		armor = {1500, 0.85},
    },

    ["lavaarena_armorextraheavy"] =
    {
        build = "armor_extraheavy",
        tags = { "marble", "heavyarmor" },
        foleysound = "dontstarve/movement/foley/marblearmour",
		armor = {1500, 0.90},
    },

	---------------------------------------------------------------------------
	-- season 2
    ["lavaarena_armor_hpextraheavy"] =
    {
        build = "armor_hpextraheavy",
        tags = { "ruins", "metal" },
        foleysound = "dontstarve/movement/foley/metalarmour",
		armor = {1500, 0.90},
    },

    ["lavaarena_armor_hppetmastery"] =
    {
        build = "armor_hppetmastery",
        tags = { "ruins", "metal" },
        foleysound = "dontstarve/movement/foley/metalarmour",
		armor = {1500, 0.80},
    },

    ["lavaarena_armor_hprecharger"] =
    {
        build = "armor_hprecharger",
        tags = { "ruins", "metal" },
        foleysound = "dontstarve/movement/foley/metalarmour",
		armor = {1500, 0.80},
    },

    ["lavaarena_armor_hpdamager"] =
    {
        build = "armor_hpdamager",
        tags = { "ruins", "metal" },
        foleysound = "dontstarve/movement/foley/metalarmour",
		armor = {1500, 0.80},
    },

}) do
    table.insert(armors, MakeArmour(k, v))
end

return unpack(armors)
