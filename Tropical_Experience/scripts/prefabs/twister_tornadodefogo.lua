local assets =
{
    Asset("ANIM", "anim/tornado.zip"),
    Asset("ANIM", "anim/staffs.zip"),
    Asset("ANIM", "anim/swap_staffs.zip"),
}

local prefabs =
{
    "tornado",
}

local function getspawnlocation(inst, target)
    local x1, y1, z1 = inst.Transform:GetWorldPosition()
    local x2, y2, z2 = target.Transform:GetWorldPosition()
    return x1 + .15 * (x2 - x1), 0, z1 + .15 * (z2 - z1)
end

local function spawntornado(staff, target, pos)
    local tornado = SpawnPrefab("twister_tornadodefogo")
    tornado.WINDSTAFF_CASTER = staff.components.inventoryitem.owner
    tornado.WINDSTAFF_CASTER_ISPLAYER = tornado.WINDSTAFF_CASTER ~= nil and tornado.WINDSTAFF_CASTER:HasTag("player")
    tornado.Transform:SetPosition(getspawnlocation(staff, target))
    tornado.components.knownlocations:RememberLocation("target", target:GetPosition())

    if tornado.WINDSTAFF_CASTER_ISPLAYER then
        tornado.overridepkname = tornado.WINDSTAFF_CASTER:GetDisplayName()
        tornado.overridepkpet = true
    end

    staff.components.finiteuses:Use(1)
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_tornado_stick", "swap_tornado_stick")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function staff_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("staffs")
    inst.AnimState:SetBuild("staffs")
    inst.AnimState:PlayAnimation("windstaff")
	inst:SetColour(235/255, 121/255, 12/255)

    inst:AddTag("nopunch")

    --Sneak these into pristine state for optimization
    inst:AddTag("quickcast")

    inst.spelltype = "SCIENCE"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -------
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.TORNADOSTAFF_USES)
    inst.components.finiteuses:SetUses(TUNING.TORNADOSTAFF_USES)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("spellcaster")
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canonlyuseonworkable = true
    inst.components.spellcaster.canonlyuseoncombat = true
    inst.components.spellcaster.quickcast = true
    inst.components.spellcaster:SetSpellFn(spawntornado)
    inst.components.spellcaster.castingstate = "castspell_tornado"

    MakeHauntableLaunch(inst)

    return inst
end

local brain = require("brains/tornadobrain")

local function ontornadolifetime(inst)
    inst.task = nil
    inst.sg:GoToState("despawn")
end

local function SetDuration(inst, duration)
    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst.task = inst:DoTaskInTime(duration, ontornadolifetime)
end

local function tornado_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.Transform:SetScale(2, 2, 2)

    inst.AnimState:SetFinalOffset(2)
    inst.AnimState:SetBank("tornado")
    inst.AnimState:SetBuild("tornado")
	inst.AnimState:SetMultColour(255/255, 150/255, 0/255, 1)
    inst.AnimState:PlayAnimation("tornado_pre")
    inst.AnimState:PushAnimation("tornado_loop")

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tornado", "spinLoop")
	--inst:AddTag("fire")
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
	
    inst.entity:AddLight()
    inst.Light:SetFalloff(0.4)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(2)
    inst.Light:SetColour(249/255, 130/255, 117/255)
    inst.Light:Enable(true)		

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

    inst:SetStateGraph("SGtwistertornado")
    inst:SetBrain(brain)

    inst.WINDSTAFF_CASTER = nil
    inst.persists = false

    inst.SetDuration = SetDuration
    inst:SetDuration(TUNING.TORNADO_LIFETIME)

    return inst
end

return Prefab("twister_tornadodefogo", tornado_fn, assets)
--Prefab("sail_stick", staff_fn, assets, prefabs)
