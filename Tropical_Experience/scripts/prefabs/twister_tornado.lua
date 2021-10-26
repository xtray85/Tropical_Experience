local assets =
{
    Asset("ANIM", "anim/twister_build.zip"),
    Asset("ANIM", "anim/twister_basic.zip"),
    Asset("ANIM", "anim/twister_actions.zip"),
    Asset("ANIM", "anim/twister_seal.zip"),
}

local function getspawnlocation(inst, target)
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
    local x2, y2, z2 = target.Transform:GetWorldPosition()
    return x1 + .15 * (x2 - x1), 0, z1 + .15 * (z2 - z1)
end

local function ontornadolifetime(inst)
    inst.task = nil
	inst.Physics:Stop()
    inst.AnimState:PlayAnimation("tornado_pst")
	inst:DoTaskInTime(1, inst:Remove())		
end

local function SetDuration(inst, duration)
    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst.task = inst:DoTaskInTime(duration, ontornadolifetime)
end

local function causadano(inst)
local player = GetClosestInstWithTag("player", inst, 3)
if player and player.components.health then
inst.components.combat.target = player
--inst.components.combat:DoAttack()
player.components.health:DoDelta(-2)
end
end

local function tornado_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.Transform:SetScale(0.5, 0.5, 0.5)

    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBank("twister")
    inst.AnimState:SetBuild("twister_build")
	inst.AnimState:OverrideSymbol("paw", "twister_build", "")	
	inst.AnimState:OverrideSymbol("tail", "twister_build", "")	
	inst.AnimState:OverrideSymbol("body", "twister_build", "")	
	inst.AnimState:Hide("twister_water_fx")	
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")
	--inst:AddTag("fire")
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("knownlocations")
	
	--inst:AddComponent("propagator")
    --inst.components.propagator.damagerange = 3
    --inst.components.propagator.damages = true

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.TORNADO_WALK_SPEED * 0.2
    inst.components.locomotor.runspeed = TUNING.TORNADO_WALK_SPEED * 0.7
	
    inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(7)

    inst.WINDSTAFF_CASTER = nil
    inst.persists = false

    inst.SetDuration = SetDuration
    inst:SetDuration(TUNING.TORNADO_LIFETIME)
	
	inst:DoPeriodicTask(0.5, causadano)

    return inst
end

return Prefab("twister_tornado", tornado_fn, assets)
