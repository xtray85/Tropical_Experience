local prefabs =
{
    "wildboreking",
}

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
        local pigking = SpawnPrefab("wildboreking")
        pigking.Transform:SetPosition(inst.Transform:GetWorldPosition())
        pigking.sg:GoToState("lying")
	inst:Remove()
    end
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("spawndelay", 60*8* 10 ) 
    return inst
end

return Prefab("wildboreking_spawner", fn, nil, prefabs)
