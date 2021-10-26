local function MakeTrinket(num)
    
    local name = "trinket_giftshop_"..tostring(num)
    local prefabname = "common/inventory/"..name
    
    local assets=
    {
        Asset("ANIM", "anim/trinkets_giftshop.zip"),      
    }
    
    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddNetwork()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        
        MakeInventoryPhysics(inst)
        MakeInventoryFloatable(inst)
        
        inst.AnimState:SetBank("trinkets_giftshop")
        inst.AnimState:SetBuild("trinkets_giftshop")
        inst.AnimState:PlayAnimation(tostring(num))

		inst:AddTag("molebait")
        inst:AddTag("cattoy")
        inst:AddTag("trinket")
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end
        
        inst:AddComponent("inspectable")
        inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("tradable")
        inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.TRINKETS[num] or 3

		inst:AddComponent("inventoryitem")
	    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"		
		
        inst:AddComponent("bait")

        return inst
    end
    
    return Prefab( prefabname, fn, assets)
end

local ret = {}

    table.insert(ret, MakeTrinket(1))
    table.insert(ret, MakeTrinket(3))
    table.insert(ret, MakeTrinket(4))    


return unpack(ret) 
