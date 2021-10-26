local prefabs =
{
    "doydoy",
}

local respawndays = 5  --revive em 8 dias

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
        local beaverking = SpawnPrefab("doydoy")
        beaverking.Transform:SetPosition(inst.Transform:GetWorldPosition())
        beaverking.entrada = 1
	inst:Remove()
    end
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)
    return inst
end

return Prefab("doydoy_spawner", fn, nil, prefabs)
