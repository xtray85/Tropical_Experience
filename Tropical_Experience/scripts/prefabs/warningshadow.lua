local assets =
{
    Asset("ANIM", "anim/warning_shadow.zip"),
}

local function shrink(inst, times, startsize, endsize)
    inst.AnimState:SetMultColour(1,1,1,0.33)
    inst.Transform:SetScale(startsize, startsize, startsize)
    inst.components.colourtweener:StartTween({1,1,1,0.75}, times)
    inst.components.sizetweener:StartTween(.5, times, inst.Remove)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("warning_shadow")
    inst.AnimState:SetBuild("warning_shadow")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetFinalOffset(3)

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
	
	inst:AddComponent("sizetweener")
    inst:AddComponent("colourtweener")
	inst.shrink = shrink

    return inst
end

return Prefab("warningshadow", fn, assets)