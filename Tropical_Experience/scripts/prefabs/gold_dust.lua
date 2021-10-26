local assets=
{
	Asset("ANIM", "anim/gold_dust.zip"),
}

local function shine(inst)
    inst.task = nil
	inst.AnimState:PlayAnimation("sparkle")
	inst.AnimState:PushAnimation("idle")
	inst.task = inst:DoTaskInTime(4+math.random()*5, function() shine(inst) end)
end


local function fn(Sim) 
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
	MakeInventoryFloatable(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.MEDIUM, TUNING.WINDBLOWN_SCALE_MAX.MEDIUM)
--	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	
    inst.AnimState:SetBank("gold_dust")
    inst.AnimState:SetBuild("gold_dust")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("edible")
    inst.components.edible.foodtype = "GOLDDUST"
    inst.components.edible.hungervalue = 1
    inst:AddComponent("tradable")
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("stackable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("bait")
    inst:AddTag("molebait")
    inst:AddTag("scarerbait")

    shine(inst)    return inst
end

return Prefab( "common/inventory/gold_dust", fn, assets) 
