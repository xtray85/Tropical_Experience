local assets =
{
    Asset("ANIM", "anim/flood.zip"),
}


local function QueueRemove(inst)
local x, y, z = inst.Transform:GetWorldPosition()
local sandbags = TheSim:FindEntities(x,y,z, 10,{"removealagamento"})
if #sandbags > 3 then inst:Remove() end
if TheWorld.state.wetness < 1 then
inst.AnimState:PlayAnimation("sai")
inst:DoTaskInTime(2, function(inst)	inst:Remove() end)
end




if math.random() < 0.10 then
local invader = GetClosestInstWithTag("player", inst, 25)
local outrobicho = GetClosestInstWithTag("mosquito", inst, 20)
if invader and not outrobicho then
local x, y, z = inst.Transform:GetWorldPosition()
local bicho = SpawnPrefab("mosquito_poison")
bicho.Transform:SetPosition(x, y, z)
end
end



end


local function OnEntityWake(inst)
inst.components.ripplespawner:Start()
end

local function OnEntitySleep(inst)
inst.components.ripplespawner:Stop()
end

local function fn()
    local inst = CreateEntity()
--    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()	

--    inst.MiniMapEntity:SetIcon("gold_puddle.png")
    inst.AnimState:SetBank("flood")
    inst.AnimState:SetBuild("flood")
    inst.AnimState:PlayAnimation("chega")		
    inst.AnimState:PushAnimation("idle", true)	
	inst.Transform:SetScale(1.5, 1.5, 1.5)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
	
    inst:AddTag("NOCLICK")
    inst:AddTag("marepracolocar")
	inst:AddTag("mare")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddTag("alagamentopraremovergrande")	
	inst:AddComponent("ripplespawner")
	inst.components.ripplespawner.range = 8	
	inst.components.ripplespawner:Start()	

	inst:WatchWorldState("startday", QueueRemove)
	inst:WatchWorldState("stopday", QueueRemove)
	
	inst.OnEntitySleep = OnEntitySleep
	inst.OnEntityWake = OnEntityWake	

    return inst
end

return Prefab("floodsw", fn, assets)
