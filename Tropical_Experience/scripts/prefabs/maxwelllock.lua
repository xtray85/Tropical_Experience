local PopupDialogScreen = require "screens/popupdialog"

local assets =
{
	Asset("ANIM", "anim/diviningrod.zip"),
    Asset("SOUND", "sound/common.fsb"),
    Asset("ANIM", "anim/diviningrod_maxwell.zip")
}

local prefabs = 
{
--    "diviningrodstart",
}

local function OnUnlock(inst, key, doer)

end

local function OnLock(inst, doer)
    inst.AnimState:PlayAnimation("idle_empty")
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("diviningrod")
    anim:SetBuild("diviningrod_maxwell")
    anim:PlayAnimation("activate_loop", true)
 
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
 
    inst:AddComponent("inspectable")

    inst:AddTag("maxwelllock")

    inst:AddComponent("lock")
    inst.components.lock.locktype = "maxwell"
    inst.components.lock:SetOnUnlockedFn(OnUnlock)
    inst.components.lock:SetOnLockedFn(OnLock)

    return inst
end

return Prefab( "common/maxwelllock", fn, assets, prefabs) 
