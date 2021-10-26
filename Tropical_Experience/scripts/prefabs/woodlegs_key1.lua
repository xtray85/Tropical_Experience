local assets=
{
	Asset("ANIM", "anim/woodlegs_key.zip"),
}

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)		
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("woodlegs_key")
	inst.AnimState:SetBuild("woodlegs_key")
	inst.AnimState:PlayAnimation("key1")

	inst:AddTag("aquatic")
	inst:AddTag("woodlegs_key")
	inst:AddTag("woodlegs_key1")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")	
	inst:AddComponent("tradable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"	
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

	return inst
end


return Prefab( "woodlegs_key1", fn, assets)
