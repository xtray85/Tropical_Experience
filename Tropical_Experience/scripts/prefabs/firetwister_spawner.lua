local prefabs =
{
    "twister",
}

local respawndays = 75  --revive em 75 dias

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
        local twister = SpawnPrefab("firetwister")
        twister.Transform:SetPosition(inst.Transform:GetWorldPosition())
        twister.entrada = 1
	inst:Remove()
    end
end



local function fn()
    local inst = CreateEntity()
	inst.entity:AddNetwork()
	
    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)
    return inst
end

return Prefab("firetwister_spawner", fn, nil, prefabs)
