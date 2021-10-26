--require "prefabutil"
require "brains/octobrain"
require "stategraphs/SGoctopus"

local soundprefix = "researchlab"
local name = "researchlab"
local rowboatassets = 
{
Asset("ANIM", "anim/octopus_build.zip"),
}

local prefabs =
{
    "octoatt",
	"blubber",
	"trinket_12",	
}

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local function WeaponDropped(inst)
    inst:Remove()
end

local function EquipWeapon(inst)
    if inst.components.inventory and not inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
        local weapon = CreateEntity()
        weapon.entity:AddTransform()
        weapon:AddComponent("weapon")
        weapon.components.weapon:SetDamage(inst.components.combat.defaultdamage)
        weapon.components.weapon:SetRange(inst.components.combat.attackrange, inst.components.combat.attackrange+4)
        weapon.components.weapon:SetProjectile("octoatt")
        weapon:AddComponent("inventoryitem")
        weapon.persists = false
        weapon.components.inventoryitem:SetOnDroppedFn(WeaponDropped)
        weapon:AddComponent("equippable")
        
        inst.components.inventory:Equip(weapon)
    end
end
-----------------------------------
local function OnAttacked(inst, data)
    local attacker = data.attacker
    inst:ClearBufferedAction()
	inst.components.combat:SetTarget(attacker)
	inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("octopus") end, MAX_TARGET_SHARES)
    --inst.components.combat:SetTarget(data.attacker)
end
local function Retarget(inst)
    return FindEntity(inst, TUNING.PIG_TARGET_DIST,
        function(guy)
            if not guy.LightWatcher or guy.LightWatcher:IsInLight() then
                return guy:HasTag("monster") and guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) and not 
                (inst.components.follower.leader ~= nil and guy:HasTag("abigail"))
            end
        end)
end
local function KeepTarget(inst, target)
    return inst.components.combat:CanTarget(target)
end
local function OnNewTarget(inst, data)
end

SetSharedLootTable('octopusplus',
{
    {"blubber", 1.00},
	{"trinket_12", 0.25},
})

local function rowboatfn(sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local brain = require "brains/octobrain"
    inst.entity:AddSoundEmitter() 	
	
	MakeCharacterPhysics(inst, 10, 1)

	trans:SetFourFaced()
	trans:SetScale(1.5,1.5,1.5)

	inst.AnimState:SetBuild("octopus_build")
	inst.AnimState:SetBank("octoboat")
	inst.AnimState:PlayAnimation("run_loop", true)

	inst:AddTag("octopus")
    inst:AddTag("ignorewalkableplatforms")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"
    inst.components.combat:SetRange(TUNING.WALRUS_ATTACK_DIST)
    inst.components.combat:SetDefaultDamage(TUNING.WALRUS_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.WALRUS_ATTACK_PERIOD)
    --inst.components.combat:SetRetargetFunction(3, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
	
	inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = 4
    inst.components.locomotor.walkspeed = 2
	
	inst:AddComponent("health")
    inst.components.health:SetMaxHealth(120)
	inst.components.combat:SetRetargetFunction(3, Retarget)
    inst.components.combat:SetTarget(nil)
	
    inst:AddComponent("inventory")
    inst:AddComponent("knownlocations")
    inst:AddComponent("follower")
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('octopusplus')	
	
	inst:SetStateGraph("SGoctopus")	
    inst:SetBrain(brain)	
	
	inst:DoTaskInTime(1, EquipWeapon)
	
    inst:ListenForEvent("attacked", OnAttacked)    
    inst:ListenForEvent("newcombattarget", OnNewTarget)
	return inst
end 


return Prefab( "common/objects/octopus", rowboatfn, rowboatassets, prefabs)
