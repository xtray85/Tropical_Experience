require "prefabutil"

local prefabs =
{
	"collapse_small",
}

local assets =
{
	Asset("ANIM", "anim/quagmire_seedpacket.zip"),
}

local function OnUnwrapped(inst, pos, doer)
	local moisture = inst.components.inventoryitem:GetMoisture()
	local iswet = inst.components.inventoryitem:IsWet()
	
	for i, v in ipairs(inst.loot) do
		local item = SpawnPrefab(v)
		if item ~= nil then
			local pt = inst:GetPosition()

			item.Transform:SetPosition(pt:Get())
			
			if item.Physics ~= nil then
				local angle = math.random() * 2 * PI
				local speed = math.random() * 2
				
				item.Physics:SetVel(speed * math.cos(angle), GetRandomWithVariance(8, 4), speed * math.sin(angle))

				if inst ~= nil and inst.Physics ~= nil then
					local radius = item:GetPhysicsRadius(1) + inst:GetPhysicsRadius(1)
					
					item.Transform:SetPosition(
						pt.x + math.cos(angle) * radius,
						pt.y,
						pt.z + math.sin(angle) * radius
					)
				end
			end
			if item.components.inventoryitem ~= nil then
				item.components.inventoryitem:InheritMoisture(moisture, iswet)
			end
		end
	end
	SpawnPrefab("quagmire_seedpacket_unwrap").Transform:SetPosition(pos:Get())
	if doer ~= nil and doer.SoundEmitter ~= nil then
		doer.SoundEmitter:PlaySound("dontstarve/common/together/packaged")
	end
	inst:Remove()
end

local function MakeLoot(inst)
    local possible_loot =
    {
        {chance = 6, 		item = "wheat_seeds"},
        {chance = 6, 		item = "potato_seeds"},
        {chance = 6,  		item = "tomato_seeds"},
        {chance = 6,		item = "onion_seeds"},
        {chance = 6,		item = "turnip_seeds"},
        {chance = 6,		item = "carrot_seeds"},
        {chance = 6,		item = "garlic_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 4
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function MakeLoot1(inst)
    local possible_loot =
    {
        {chance = 10, 		item = "wheat_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 5
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function MakeLoot2(inst)
    local possible_loot =
    {
        {chance = 10, 		item = "potato_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 5
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function MakeLoot3(inst)
    local possible_loot =
    {
        {chance = 10, 		item = "tomato_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 5
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function MakeLoot4(inst)
    local possible_loot =
    {
        {chance = 10, 		item = "onion_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 5
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function MakeLoot5(inst)
    local possible_loot =
    {
        {chance = 10, 		item = "turnip_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 5
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function MakeLoot6(inst)
    local possible_loot =
    {
        {chance = 10, 		item = "carrot_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 5
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function MakeLoot7(inst)
    local possible_loot =
    {
        {chance = 10, 		item = "garlic_seeds"},
    }

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    inst.lootaggro = {}
    local next_loot = nil
    local next_aggro = nil
    local next_chance = nil
    local num_loots = 5
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next_loot = n.item
                if n.aggro then next_aggro = true end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, next_loot)
            if next_aggro then 
                table.insert(inst.lootaggro, true)
            else
                table.insert(inst.lootaggro, false)
            end
            num_loots = num_loots - 1
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot(inst)

    return inst
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("seed_mix", "quagmire_seedpacket", "seed_1")	
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot1(inst)

    return inst
end

local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("seed_mix", "quagmire_seedpacket", "seed_2")	
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot2(inst)

    return inst
end

local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("seed_mix", "quagmire_seedpacket", "seed_3")
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot3(inst)

    return inst
end

local function fn4()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("seed_mix", "quagmire_seedpacket", "seed_4")	
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot4(inst)

    return inst
end

local function fn5()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("seed_mix", "quagmire_seedpacket", "seed_5")	
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot5(inst)

    return inst
end

local function fn6()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("seed_mix", "quagmire_seedpacket", "seed_6")	
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot6(inst)

    return inst
end

local function fn7()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("quagmire_seedpacket")
    inst.AnimState:SetBuild("quagmire_seedpacket")
    inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("seed_mix", "quagmire_seedpacket", "seed_7")	
    
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	
	inst:AddComponent("unwrappable")
	inst.components.unwrappable:SetOnUnwrappedFn(OnUnwrapped)
	
	inst:AddComponent("inventoryitem")
	
	MakeLoot7(inst)

    return inst
end
return Prefab("quagmire_seedpacket_mix", fn, assets, prefabs),
	   Prefab("quagmire_seedpacket_1", fn1, assets, prefabs),
	   Prefab("quagmire_seedpacket_2", fn2, assets, prefabs),
	   Prefab("quagmire_seedpacket_3", fn3, assets, prefabs),
	   Prefab("quagmire_seedpacket_4", fn4, assets, prefabs),
	   Prefab("quagmire_seedpacket_5", fn5, assets, prefabs),
	   Prefab("quagmire_seedpacket_6", fn6, assets, prefabs),
	   Prefab("quagmire_seedpacket_7", fn7, assets, prefabs)   