local assets =
{
	Asset("ANIM", "anim/key_to_city.zip"),
    Asset("INV_IMAGE", "key_to_city"),
}

local function OnTurnOn(inst)
inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_run","sound")
end

local function OnTurnOff(inst)
inst:DoTaskInTime(1.5, function() 
inst.SoundEmitter:KillSound("sound")
inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl1_ding","sound")     
end)
end

local function canCurrentlyPrototypeTestFn(inst)
    return not TheCamera.interior
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("keytocity")
    inst.AnimState:SetBuild("key_to_city")
    inst:AddTag("prototyper")
    inst:AddTag("no_interior_protoyping")
    inst:AddTag("irreplaceable")

    inst.AnimState:PlayAnimation("idle")
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    inst:AddComponent("prototyper")
    inst.components.prototyper.onturnon = OnTurnOn
    inst.components.prototyper.onturnoff = OnTurnOff    
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.CITY_TWO
	
    return inst
end

return Prefab( "common/inventory/key_to_city", fn, assets)

