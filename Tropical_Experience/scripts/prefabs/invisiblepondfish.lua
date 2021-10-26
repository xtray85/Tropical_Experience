local assets =
{
    Asset("ANIM", "anim/fishaa.zip"),
}

local prefabs =
{
	"oceanfish_small_11_inv",
}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.build = "fishaa"

	inst:DoTaskInTime(1.5, function() 
	local x, y, z = inst.Transform:GetWorldPosition()
	local peixe = SpawnPrefab("oceanfish_small_11_inv")
	if peixe then
	peixe.Transform:SetPosition(x, y, z)
	end 
	inst:Remove()
	end)

    return inst
end


return Prefab("fishaa", fn, assets, prefabs)