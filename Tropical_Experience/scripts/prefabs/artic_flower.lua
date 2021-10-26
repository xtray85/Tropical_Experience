local assets =
{
    Asset("ANIM", "anim/arctic_flowers.zip"),
}

local prefabs =
{
    "petals",
}

local names = {"f1","f2","f3","f4","f5","f6","f7","f8","f9","f10"}

local function onsave(inst, data)
    data.anim = inst.animname
end

local function onload(inst, data)
	inst.animname = data ~= nil and data.animname or nil	
	if inst.animname == nil then inst.animname = names[math.random(#names)] end
	inst.AnimState:PlayAnimation(inst.animname)
end

local function onpickedfn(inst, picker)
    local pos = inst:GetPosition()

    if picker ~= nil then
        if picker.components.sanity ~= nil and not picker:HasTag("plantkin") then
            picker.components.sanity:DoDelta(TUNING.SANITY_TINY)
        end
    end

    inst:Remove()

    TheWorld:PushEvent("plantkilled", { doer = picker, pos = pos }) --this event is pushed in other places too
end

local function OnBurnt(inst)
--	if not inst.planted then
--		TheWorld:PushEvent("beginregrowth", inst)
--	end
    DefaultBurntFn(inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("arctic_flowers")
    inst.AnimState:SetBuild("arctic_flowers")
    inst.AnimState:SetRayTestOnBB(true)
    if inst.animname == nil then inst.animname = names[math.random(#names)] end
	inst.AnimState:PlayAnimation(inst.animname)
	inst.Transform:SetScale(1.7, 1.7, 1.7)

    inst:AddTag("flower")
    inst:AddTag("cattoy")
	
	inst:SetPrefabNameOverride("flower")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("petals", 10)
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.quickpick = true

    MakeSmallBurnable(inst)
    inst.components.burnable:SetOnBurntFn(OnBurnt)

    MakeSmallPropagator(inst)

    --------SaveLoad
    inst.OnSave = onsave
    inst.OnLoad = onload	

    return inst
end

return Prefab("arctic_flowers", fn, assets, prefabs)
