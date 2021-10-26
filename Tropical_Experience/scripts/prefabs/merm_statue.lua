require "prefabutil"

local prefabs =
{
	"collapse_small",
}

   local assets =
    {
        Asset("ANIM", "anim/mermstatue.zip"),
    }

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("mermstatue")
    inst.AnimState:PushAnimation("mermstatue", false)
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("mermstatue")
    inst.AnimState:PushAnimation("mermstatue", false)
end


local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("mermstatue")
        inst.AnimState:SetBuild("mermstatue")
		inst.AnimState:PlayAnimation("mermstatue")

        MakeObstaclePhysics(inst, .5)

        inst.Transform:SetTwoFaced()

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")
		
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit) 

    inst:ListenForEvent("onbuilt", onbuilt)		

 return inst
end

local function fn1()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("mermstatue")
        inst.AnimState:SetBuild("mermstatue")
        inst.AnimState:PlayAnimation("drome")
		inst.AnimState:SetSortOrder(2)
		inst.Transform:SetScale(3,3,3)
	    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
		inst:AddTag("NOCLICK")
 --       inst.Transform:SetTwoFaced()

 return inst
end

return  Prefab("mermstatue", fn, assets),
		Prefab("drome", fn1, assets)