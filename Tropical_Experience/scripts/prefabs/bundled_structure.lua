
local assets =
{
	Asset("ANIM", "anim/bundled_structure.zip"),
}
local function ondeploy(inst, pt, deployer)
	if inst.components.bundled_structure then
		inst.components.bundled_structure:Unpack(pt)
		inst:Remove()
	end
end	

local function get_name(inst)
	return #inst._name:value() > 0 and "Packaged "..inst._name:value() or "Packaged objects"
end

local function fullfn()
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	
	
	inst.AnimState:SetBank("bundled_structure")
    inst.AnimState:SetBuild("bundled_structure")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("bundled_structure")	
	inst:AddTag("nonpackable")
	inst._name = net_string(inst.GUID, "bundled_structure._name")
	inst.displaynamefn = get_name
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")

	inst:AddComponent("bundled_structure")	
	inst:AddComponent("deployable")
	inst.components.deployable.ondeploy = ondeploy
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

	MakeMediumBurnable(inst)
    MakeMediumPropagator(inst)
	MakeHauntableLaunchAndSmash(inst)
	
    return inst
end	
	
return Prefab("bundled_structure", fullfn, assets),
	MakePlacer("bundled_structure_placer", "bundled_structure", "bundled_structure", "idle")
