local assets=
{
	Asset("ANIM", "anim/tuna.zip"),
--    Asset("INV_IMAGE", "tuna"),
--    Asset("INV_IMAGE", "tuna_opened"),
}


local prefabs =
{
    "fish_med_cooked",
}    

local function OnStartBundling(inst)

inst:Remove()
end

local function onhacked(inst)
    local nut = inst 
    if inst.components.inventoryitem then 
        local owner = inst.components.inventoryitem.owner
        if inst.components.stackable and inst.components.stackable.stacksize > 1 then 
            nut = inst.components.stackable:Get()
            inst.components.workable:SetWorkLeft(1)
        end 
--        if owner then 
--            local hacked = SpawnPrefab("fish_med_cooked")
--            hacked.components.stackable.stacksize = 1
--            if owner.components.inventory and not owner.components.inventory:IsFull() then
--                owner.components.inventory:GiveItem(hacked)
--            elseif owner.components.container and not owner.components.container:IsFull() then
--                owner.components.container:GiveItem(hacked)
--            else
--                inst.components.lootdropper:DropLootPrefab(hacked)
--            end
--        else 
            inst.components.lootdropper:SpawnLootPrefab("fish_med_cooked")
--        end 
        inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
    end
    nut:Remove()

end 

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    inst.AnimState:SetBank("tuna")
    inst.AnimState:SetBuild("tuna")
    inst.AnimState:PlayAnimation("idle")
    
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
	
	inst:AddTag("tunacan")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("lootdropper")
		
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
    
    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 1

	
	 inst:AddComponent("workable")
     inst.components.workable:SetWorkAction(ACTIONS.HACK)
     inst.components.workable:SetWorkLeft(1)
     inst.components.workable:SetOnFinishCallback(onhacked)
	 
	 inst:AddComponent("interactions") 

    return inst
end

return Prefab("tunacan", fn, assets, prefabs)
