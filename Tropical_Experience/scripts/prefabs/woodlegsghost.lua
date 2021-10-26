local assets =
{

}


local function ShouldAcceptItem(inst, item, giver)
    return item.prefab == "reviver"
end

local function OnGetItem(inst, giver, item)
    if item ~= nil and item.prefab == "reviver" then
        item:PushEvent("usereviver", { user = giver })
        item:Remove()
		
		SpawnPrefab("die_fx").Transform:SetPosition(inst:GetPosition():Get())
		inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_get_bloodpump")
		
		inst:DoTaskInTime(40 * FRAMES, function()
			inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_use_bloodpump")
			
			TheWorld:PushEvent("ms_sendlightningstrike", inst:GetPosition())

local woodlegres = SpawnPrefab("woodlegs1").Transform:SetPosition(inst:GetPosition():Get())
			
			inst:Remove()
		end)
    end
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 0.25)

    inst.AnimState:SetBank("ghost")
    inst.AnimState:SetBuild("ghost_build")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	

	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItem
	inst.components.trader.deleteitemonaccept = false

    MakeHauntableWork(inst)
    MakeSnowCovered(inst)
	

	
    return inst
end

return Prefab("woodlegsghost", fn, assets)
