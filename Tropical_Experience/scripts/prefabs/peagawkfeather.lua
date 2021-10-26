local assets=
{
	Asset("ANIM", "anim/feather_peagawk.zip"),
}
 
local function fn(Sim)
    
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    --MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.MEDIUM, TUNING.WINDBLOWN_SCALE_MAX.MEDIUM)


	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	
    inst.AnimState:SetBank("feather_peagawk")
    inst.AnimState:SetBuild("feather_peagawk")
    inst.AnimState:PlayAnimation("idle")

	MakeInventoryFloatable(inst)
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.hungervalue = 2
    inst:AddComponent("tradable")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("stackable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("bait")
    inst:AddTag("molebait")
    inst:AddTag("scarerbait")
    
    return inst
end

return Prefab( "common/inventory/peagawkfeather", fn, assets) 
