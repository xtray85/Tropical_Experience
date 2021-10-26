local prefabs =
{
    "snowwarg",
}

local respawndays = 20  --revive em 8 dias

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
        local slipstor = SpawnPrefab("snowwarg")
        slipstor.Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst:Remove()
    end
end



local function fn()
    local inst = CreateEntity()
	inst.entity:AddNetwork()

	inst.entity:SetPristine()
		
    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)

    return inst
end

return Prefab("snowwarg_spawner", fn, nil, prefabs)
