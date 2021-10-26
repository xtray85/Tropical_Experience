local assets =
{
    Asset("ANIM", "anim/merm_king_carpet.zip"),
    Asset("MINIMAP_IMAGE", "merm_king_carpet"),
    Asset("MINIMAP_IMAGE", "merm_king_carpet_occupied"),
    Asset("MINIMAP_IMAGE", "merm_king_carpet_construction"),
}

local prefabs =
{
    "mermkingunderwter"
}

local respawndays = 5  --revive em no maximo 20 dias mas pode reviver antes

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
	local invader = GetClosestInstWithTag("mermking", inst, 100)
	if not invader then
    local mermking = SpawnPrefab("mermkingunderwater")
    mermking.Transform:SetPosition(inst.Transform:GetWorldPosition())
    end end
	inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.Transform:SetScale(2, 2, 2)

    inst.MiniMapEntity:SetIcon("merm_king_carpet.png")

    inst.AnimState:SetBank("merm_king_carpet")
    inst.AnimState:SetBuild("merm_king_carpet")
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    inst:AddTag("mermthrone")
	inst:AddTag("NOCLICK")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)

    return inst
end



return  Prefab("mermthroneunderwater", fn, assets, prefabs)