local assets = 
{
	Asset("ANIM", "anim/hat_woodlegs.zip"),
}

local function treasure(x, y, inst)
    local equippable = inst.components.equippable
    if equippable ~= nil and equippable:IsEquipped() then
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if owner ~= nil and owner:HasTag("player") then
	local map = TheWorld.Map
	local x, y
	local sx, sy = map:GetSize()
	
	repeat
		x = math.random(-sx,sx)
		y = math.random(-sy,sy)
		local tile = map:GetTileAtPoint(x, 0, y)
	until 
	tile ~= GROUND.IMPASSABLE and
	tile ~= GROUND.OCEAN_COASTAL and
	tile ~= GROUND.OCEAN_COASTAL_SHORE and
	tile ~= GROUND.OCEAN_SWELL and
	tile ~= GROUND.OCEAN_ROUGH and
	tile ~= GROUND.OCEAN_BRINEPOOL and
	tile ~= GROUND.OCEAN_BRINEPOOL_SHORE and
	tile ~= GROUND.OCEAN_WATERLOG and
	tile ~= GROUND.OCEAN_HAZARDOUS	
	
	
	
	
	
	
	
	SpawnPrefab("buriedtreasure").Transform:SetPosition(x, 0, y)
	
	owner:DoTaskInTime(0, function() 
		owner.player_classified.MapExplorer:RevealArea(x, 0, y)
	end)
	
	if owner.player_classified.revealtreasure then
		local val = (x+16384)*65536+(y+16384)
		owner.player_classified.revealtreasure:set_local(val)
		owner.player_classified.revealtreasure:set(val)
	end	
	    owner.components.talker:Say(GetString(owner, "ANNOUNCE_TREASURE"))
    end
    end
end

local function OnEquip(inst, owner, phase)
    owner.AnimState:OverrideSymbol("swap_hat", "hat_woodlegs", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Show("HAIR_HAT")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Hide("HAIR")
        
    if owner:HasTag("player") then
	owner.AnimState:Hide("HEAD")
	owner.AnimState:Show("HEAD_HAT")
    end
	
    if inst.components.fueled then
       inst.components.fueled:StartConsuming()        
    end
	
end
	
local function OnUnequip(inst, owner)
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

local function fn()
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("woodlegshat")
    inst.AnimState:SetBuild("hat_woodlegs")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("hat")
	MakeInventoryFloatable(inst)
		
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("fueled") 
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TUNING.WINTERHAT_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)
    inst.components.fueled:SetSections(6)
    inst.components.fueled:SetSectionCallback(treasure)
	
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")	
    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("luckyhat", fn, assets, prefabs)