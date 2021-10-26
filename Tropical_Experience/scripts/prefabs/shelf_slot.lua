local assets =
{
    --Asset("ANIM", "anim/store_items.zip"),
    Asset("ANIM", "anim/shelf_slot.zip"),
}

local prefabs =
{

}

local function empty(inst)     
    local item =  inst.components.pocket:RemoveItem("shelfitem")  
    if item then    
        inst.components.shelfer:ReturnGift(item)
        local pt = inst.Transform:GetWorldPosition()
        if inst.components.shelfer.shelf then
            pt = inst.components.shelfer.shelf.Transform:GetWorldPosition()
        end
        --DropLootPrefab
		if item and inst.components.lootdropper then
        inst.components.lootdropper:DropLoot(pt)
		end
    end
end

local function common()
    local inst = CreateEntity()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()

    anim:SetBuild("shelf_slot")
    anim:SetBank("shelf_slot")
    anim:PlayAnimation("idle")
	inst.AnimState:SetMultColour(255/255, 255/255, 255/255, 0.02)	
--    anim:Hide("mouseclick")

    inst:AddTag("cost_one_oinc")
    inst:AddTag("NOBLOCK")
    inst:AddTag("shelfcanaccept")
	
    inst:AddComponent("pocket")

    inst:AddComponent("shelfer")	
	
    inst.AnimState:SetLayer(LAYER_WORLD)
    inst.AnimState:SetSortOrder(3)	
   
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
   
    inst:AddComponent("lootdropper")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.canbepickedup = false
    inst.empty = empty

    return inst
end

return Prefab( "shelf_slot", common, assets, prefabs)       
   
