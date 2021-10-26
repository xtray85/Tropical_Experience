local assets=
{
	Asset("ANIM", "anim/pheromone_stone.zip"),
	Asset("ANIM", "anim/torso_amulets.zip"),
}

--[[ Each amulet has a seperate onequip and onunequip function so we can also
add and remove event listeners, or start/stop update functions here. ]]

---RED

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "pheromone_stone", "blueamulet")     
    owner:AddTag("antlingual")	
end

local function onunequip(inst, owner)  
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner:RemoveTag("antlingual")
end

local function makefn(inst)
    local inst = CreateEntity()
    inst.entity:AddNetwork()    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)   
    MakeInventoryFloatable(inst)
	
    inst.AnimState:SetBank("pheromone_stone")
    inst.AnimState:SetBuild("pheromone_stone")
    inst.AnimState:PlayAnimation("pherostone")	

    inst:AddTag("ant_translator")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/jewlery"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY   
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    return inst
end

return Prefab( "common/inventory/pheromonestone", makefn, assets)