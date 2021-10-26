local assets =
{  
    Asset("ANIM", "anim/player_house_kits.zip"),  
}

local function onfinished(inst)
	inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBuild("player_house_kits")
    inst.AnimState:SetBank("house_kit")
    inst.AnimState:PlayAnimation("cottage")
	
	inst:AddTag("decoradordecasa")	
	inst:AddTag("player_house_cottage_craft")	

	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem:ChangeImageName("player_house_cottage") 
	
    return inst
end

local function fn1(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBuild("player_house_kits")
    inst.AnimState:SetBank("house_kit")
    inst.AnimState:PlayAnimation("villa")
	
	inst:AddTag("decoradordecasa")	
	inst:AddTag("player_house_villa_craft")	

	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem:ChangeImageName("player_house_villa") 
	
    return inst
end

local function fn2(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBuild("player_house_kits")
    inst.AnimState:SetBank("house_kit")
    inst.AnimState:PlayAnimation("manor")
	
	inst:AddTag("decoradordecasa")	
	inst:AddTag("player_house_manor_craft")	

	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem:ChangeImageName("player_house_manor") 
	
    return inst
end

local function fn3(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBuild("player_house_kits")
    inst.AnimState:SetBank("house_kit")
    inst.AnimState:PlayAnimation("tudor")
	
	inst:AddTag("decoradordecasa")	
	inst:AddTag("player_house_tudor_craft")	

	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem:ChangeImageName("player_house_tudor") 
	
    return inst
end

local function fn4(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBuild("player_house_kits")
    inst.AnimState:SetBank("house_kit")
    inst.AnimState:PlayAnimation("gothic")
	
	inst:AddTag("decoradordecasa")	
	inst:AddTag("player_house_gothic_craft")	

	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem:ChangeImageName("player_house_gothic") 
	
    return inst
end

local function fn5(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBuild("player_house_kits")
    inst.AnimState:SetBank("house_kit")
    inst.AnimState:PlayAnimation("brick")
	
	inst:AddTag("decoradordecasa")	
	inst:AddTag("player_house_brick_craft")	

	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem:ChangeImageName("player_house_brick") 
	
    return inst
end

local function fn6(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBuild("player_house_kits")
    inst.AnimState:SetBank("house_kit")
    inst.AnimState:PlayAnimation("turret")
	
	inst:AddTag("decoradordecasa")	
	inst:AddTag("player_house_turret_craft")	

	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem:ChangeImageName("player_house_turret") 
	
    return inst
end

return 	Prefab( "common/inventory/player_house_cottage_craft", fn, assets),
		Prefab( "common/inventory/player_house_villa_craft", fn1, assets),
		Prefab( "common/inventory/player_house_manor_craft", fn2, assets),
		Prefab( "common/inventory/player_house_tudor_craft", fn3, assets),
		Prefab( "common/inventory/player_house_gothic_craft", fn4, assets),
		Prefab( "common/inventory/player_house_brick_craft", fn5, assets),
		Prefab( "common/inventory/player_house_turret_craft", fn6, assets)



--[[
build, bank, icon, anim
        material("player_house_cottage_craft",      "player_small_house1_cottage_build",    "playerhouse_small",    "player_house_cottage",     "cottage"),
        material("player_house_villa_craft",        "player_large_house1_villa_build",      "playerhouse_large",    "player_house_villa",       "villa"),
        material("player_house_manor_craft",        "player_large_house1_manor_build",      "playerhouse_large",    "player_house_manor",       "manor"),
        material("player_house_tudor_craft",        "player_small_house1_tudor_build",      "playerhouse_small",    "player_house_tudor",       "tudor"),
        material("player_house_gothic_craft",       "player_small_house1_gothic_build",     "playerhouse_small",    "player_house_gothic",      "gothic"),
        material("player_house_brick_craft",        "player_small_house1_brick_build",      "playerhouse_small",    "player_house_brick",       "brick"),
        material("player_house_turret_craft",       "player_small_house1_turret_build",     "playerhouse_small",    "player_house_turret",      "turret")  

]]		