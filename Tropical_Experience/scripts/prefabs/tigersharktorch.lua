local assets =
{
--    Asset("ANIM", "anim/beaver_torch.zip"),
}

local prefabs =
{
    "tigershark",
    "collapse_small",
}

local respawndays = 30  --revive em no maximo 20 dias mas pode reviver antes

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
	local invader = GetClosestInstWithTag("tigershark", inst, 200)
	if not invader then
    local slipstor = SpawnPrefab("tigershark")
    slipstor.Transform:SetPosition(inst.Transform:GetWorldPosition())
	slipstor.entrada = 1
    end end
	inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)
end

local function OnVacate(inst)
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

 --   MakeObstaclePhysics(inst, 0.33)

--    inst.AnimState:SetBank("pigtorch")
--    inst.AnimState:SetBuild("bea_torch")
--    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("tigersharkhome")
	inst:AddTag("aquatic")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(1)
	inst.components.health:SetInvincible(true)

	inst:AddComponent("combat")

    return inst
end

return Prefab("tigersharktorch", fn, assets, prefabs)
