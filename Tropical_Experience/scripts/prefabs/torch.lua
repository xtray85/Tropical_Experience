local assets =
{
    Asset("ANIM", "anim/torch.zip"),
    Asset("ANIM", "anim/swap_torch.zip"),
    Asset("SOUND", "sound/common.fsb"),
}

local prefabs =
{
    "torchfire",
}

local function onequip(inst, owner)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
local ground1 = map:GetTile(map:GetTileCoordsAtPoint(x+5, y, z))
local ground2 = map:GetTile(map:GetTileCoordsAtPoint(x-5, y, z))
local ground3 = map:GetTile(map:GetTileCoordsAtPoint(x, y, z+5))
local ground4 = map:GetTile(map:GetTileCoordsAtPoint(x, y, z-5))
local naagua = false
if ground == GROUND.UNDERWATER_SANDY or ground == GROUND.UNDERWATER_ROCKY or (ground == GROUND.BEACH and TheWorld:HasTag("cave"))  or (ground == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave"))  or (ground == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground1 == GROUND.UNDERWATER_SANDY or ground1 == GROUND.UNDERWATER_ROCKY or (ground1 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground1 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground1 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground1 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground1 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground2 == GROUND.UNDERWATER_SANDY or ground2 == GROUND.UNDERWATER_ROCKY or (ground2 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground2 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground2 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground2 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground2 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground3 == GROUND.UNDERWATER_SANDY or ground3 == GROUND.UNDERWATER_ROCKY or (ground3 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground3 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground3 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground3 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground3 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end
if ground4 == GROUND.UNDERWATER_SANDY or ground4 == GROUND.UNDERWATER_ROCKY or (ground4 == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground4 == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground4 == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground4 == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground4 == GROUND.PAINTED and TheWorld:HasTag("cave")) then naagua = true end


if naagua == false then
    inst.components.burnable:Ignite()
end	

    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_torch", inst.GUID, "swap_torch")
    else
        owner.AnimState:OverrideSymbol("swap_object", "swap_torch", "swap_torch")
    end
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    owner.SoundEmitter:PlaySound("dontstarve/wilson/torch_swing")

if naagua == false then
    if inst.fires == nil then
        inst.fires = {}

        for i, fx_prefab in ipairs(inst:GetSkinName() == nil and { "torchfire" } or SKIN_FX_PREFAB[inst:GetSkinName()] or {}) do
            local fx = SpawnPrefab(fx_prefab)
            fx.entity:SetParent(owner.entity)
            fx.entity:AddFollower()
            fx.Follower:FollowSymbol(owner.GUID, "swap_object", fx.fx_offset_x or 0, fx.fx_offset, 0)
            fx:AttachLightTo(owner)

            table.insert(inst.fires, fx)
        end
    end
end	
end

local function onunequip(inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end

    if inst.fires ~= nil then
        for i, fx in ipairs(inst.fires) do
            fx:Remove()
        end
        inst.fires = nil
        owner.SoundEmitter:PlaySound("dontstarve/common/fireOut")
    end

    inst.components.burnable:Extinguish()
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onpocket(inst, owner)
    inst.components.burnable:Extinguish()
end

local function onattack(weapon, attacker, target)
    --target may be killed or removed in combat damage phase
    if target ~= nil and target:IsValid() and target.components.burnable ~= nil and math.random() < TUNING.TORCH_ATTACK_IGNITE_PERCENT * target.components.burnable.flammability then
        target.components.burnable:Ignite(nil, attacker)
    end
end

local function onupdatefueledraining(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    inst.components.fueled.rate =
        owner ~= nil and
        owner.components.sheltered ~= nil and
        owner.components.sheltered.sheltered and
        (inst._fuelratemult or 1) or
        (1 + TUNING.TORCH_RAIN_RATE * TheWorld.state.precipitationrate) * (inst._fuelratemult or 1)
end

local function onisraining(inst, israining)
    if inst.components.fueled ~= nil then
        if israining then
            inst.components.fueled:SetUpdateFn(onupdatefueledraining)
            onupdatefueledraining(inst)
        else
            inst.components.fueled:SetUpdateFn()
            inst.components.fueled.rate = inst._fuelratemult or 1
        end
    end
end

local function onfuelchange(newsection, oldsection, inst)
    if newsection <= 0 then
        --when we burn out
        if inst.components.burnable ~= nil then
            inst.components.burnable:Extinguish()
        end
        local equippable = inst.components.equippable
        if equippable ~= nil and equippable:IsEquipped() then
            local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
            if owner ~= nil then
                local data =
                {
                    prefab = inst.prefab,
                    equipslot = equippable.equipslot,
                    announce = "ANNOUNCE_TORCH_OUT",
                }
                inst:Remove()
                owner:PushEvent("itemranout", data)
                return
            end
        end
        inst:Remove()
    end
end

local function SetFuelRateMult(inst, mult)
    mult = mult ~= 1 and mult or nil
    if inst._fuelratemult ~= mult then
        inst._fuelratemult = mult
        onisraining(inst, TheWorld.state.israining)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("torch")
    inst.AnimState:SetBuild("swap_torch")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("wildfireprotected")

    --lighter (from lighter component) added to pristine state for optimization
    inst:AddTag("lighter")

    --waterproofer (from waterproofer component) added to pristine state for optimization
    inst:AddTag("waterproofer")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

	MakeInventoryFloatable(inst, "med", nil, 0.68)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.TORCH_DAMAGE)
    inst.components.weapon:SetOnAttack(onattack)

    -----------------------------------
    inst:AddComponent("lighter")
    -----------------------------------

    inst:AddComponent("inventoryitem")
    -----------------------------------

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnPocket(onpocket)
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    -----------------------------------

    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)

    -----------------------------------

    inst:AddComponent("inspectable")

    -----------------------------------

    inst:AddComponent("burnable")
    inst.components.burnable.canlight = false
    inst.components.burnable.fxprefab = nil

    -----------------------------------

    inst:AddComponent("fueled")
    inst.components.fueled:SetSectionCallback(onfuelchange)
    inst.components.fueled:InitializeFuelLevel(TUNING.TORCH_FUEL)
    inst.components.fueled:SetDepletedFn(inst.Remove)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)

    inst:WatchWorldState("israining", onisraining)
    onisraining(inst, TheWorld.state.israining)

    inst._fuelratemult = nil
    inst.SetFuelRateMult = SetFuelRateMult

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("torch", fn, assets, prefabs)
