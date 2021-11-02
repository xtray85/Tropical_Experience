local assets =
{
    Asset("ANIM", "anim/orbfx.zip")
}

local function doloop(inst)
    local x = inst.radius * math.cos(inst.angle)
    local z = inst.radius * math.sin(inst.angle)
    inst.Transform:SetPosition(x, 1, z)

    inst.angle = inst.angle + 0.1
    if inst.angle >= 360 then
        inst.angle = 0
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("orbfx")
    inst.AnimState:SetBuild("orbfx")
    inst.AnimState:PlayAnimation("tornado_loop", true)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.Transform:SetScale(0.1,0.1,0.1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.angle = 0
    inst.radius = 1.25
    inst:DoTaskInTime(0, function() 
        inst:DoPeriodicTask(0.1, doloop)
    end)

    return inst
end

return Prefab("orbfx", fn, assets)