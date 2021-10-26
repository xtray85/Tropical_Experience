
require "stategraphs/SGroc_tail"

local trace = function() end

local assets=
{
	Asset("ANIM", "anim/roc_tail.zip"),
}

local prefabs =
{

}

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 8, 4 )
	
	inst.Transform:SetSixFaced()

	inst:AddTag("scarytoprey")
	inst:AddTag("monster")
	inst:AddTag("hostile")
	inst:AddTag("roc")
	inst:AddTag("roc_tail")
	inst:AddTag("noteleport")

	anim:SetBank("tail")
	anim:SetBuild("roc_tail")
	anim:PlayAnimation("tail_loop")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("knownlocations")

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(1000)
	inst:AddComponent("inspectable")

	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aurafn = function() return -TUNING.SANITYAURA_LARGE end

	inst:SetStateGraph("SGroc_tail")

	return inst
end

return Prefab("monsters/roc_tail", fn, assets, prefabs)
