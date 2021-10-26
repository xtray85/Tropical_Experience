require "stategraphs/SGgiantgrub"

function ChangeToUndergroundCharacterPhysics(inst)

    local phys = inst.Physics
    phys:SetCollisionGroup(COLLISION.CHARACTERS)
    phys:ClearCollisionMask()
    phys:CollidesWith(COLLISION.WORLD)
    phys:CollidesWith(COLLISION.OBSTACLES)
--    phys:CollidesWith(COLLISION.SMALLOBSTACLES)
    phys:CollidesWith(COLLISION.CHARACTERS)
--    phys:CollidesWith(COLLISION.GIANTS)
end	


local assets =
{
	Asset("ANIM", "anim/giant_grub.zip"),
	Asset("ANIM", "anim/giant_snow.zip"),
}

local prefabs =
{
	-- TODO: Put related prefab names here.
}

local giantgrubsounds =
{
	-- TODO: Put related audio here.
}

local brain = require "brains/giantgrubbrain"

local SEE_VICTIM_DIST = 10
local GIANT_GRUB_WALK_SPEED = 2
local GIANT_GRUB_DAMAGE = 44
local GIANT_GRUB_HEALTH = 600
local GIANT_GRUB_ATTACK_PERIOD = 3
local GIANT_GRUB_ATTACK_RANGE = 3
local GIANT_GRUB_TARGET_DIST = 25

local function IsCompleteDisguise(target)
   return target:HasTag("has_antmask") and target:HasTag("has_antsuit")
end

local function IsPreferedTarget(target)
	return IsCompleteDisguise(target) or (target.prefab == "antman")
end

local function SetState(inst, state)
	--"under" or "above"
    inst.State = string.lower(state)
    if inst.State == "under" then
        ChangeToUndergroundCharacterPhysics(inst)
    elseif inst.State == "above" then
        ChangeToCharacterPhysics(inst)
    end
end

local function IsState(inst, state)
    return inst.State == string.lower(state)
end

local function CanBeAttacked(inst, attacker)
	return inst.State == "above"
end

local function Retarget(inst)
	local instPos = Vector3(inst.Transform:GetWorldPosition())
    local entsNearby = TheSim:FindEntities(instPos.x, instPos.y, instPos.z, SEE_VICTIM_DIST)
    local playerIsPossibleTarget = false

    for k, v in pairs(entsNearby) do
    	if inst.components.combat:CanTarget(v) and (v.prefab ~= "giantgrub") then
    		if v:HasTag("player") then
    			playerIsPossibleTarget = true
    		end

    		if IsPreferedTarget(v) then
	    		return v
	    	end
    	end
    end

    if playerIsPossibleTarget then
    	return ThePlayer
    end

    if #entsNearby > 0 then
    	return entsNearby[1]
    end

    return nil
end

local function KeepTarget(inst, target)
    return inst.components.combat:CanTarget(target) and target:HasTag("player")
end

local function OnSleep(inst)
    inst.SoundEmitter:KillAllSounds()
end

local function OnRemove(inst)
    inst.SoundEmitter:KillAllSounds()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

	shadow:SetSize(1, 0.75)
	inst.Transform:SetFourFaced()
	inst.Transform:SetScale(3, 3, 3)

	MakeCharacterPhysics(inst, 1, 0.5)
--	MakePoisonableCharacter(inst)

	MakeSmallBurnableCharacter(inst, "chest")
	MakeTinyFreezableCharacter(inst, "chest")

	anim:SetBank("giant_grub")
	anim:SetBuild("giant_snow")
	anim:PlayAnimation("idle", true)

	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("giantgrub")
    inst:AddTag("walrus")
    inst:AddTag("houndfriend")	
    inst:AddTag("giantsnow")	
	

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = GIANT_GRUB_WALK_SPEED

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(GIANT_GRUB_HEALTH)
	inst.components.health.murdersound = "dontstarve/rabbit/scream_short"

	inst:AddComponent("inspectable")
	inst:AddComponent("sleeper")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false	
	inst.components.inventoryitem:SetSinks(true)		

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"monstermeat"})

	inst:AddComponent("knownlocations")
	inst:DoTaskInTime(0, function() inst.components.knownlocations:RememberLocation("home", Point(inst.Transform:GetWorldPosition()), true) end)

    inst:AddComponent("groundpounder")
  	inst.components.groundpounder.destroyer = true
	inst.components.groundpounder.damageRings = 2
	inst.components.groundpounder.destructionRings = 0
	inst.components.groundpounder.numRings = 2

	inst.CanGroundPound = true

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(GIANT_GRUB_DAMAGE)
	inst.components.combat:SetAttackPeriod(GIANT_GRUB_ATTACK_PERIOD)
	inst.components.combat:SetRange(GIANT_GRUB_ATTACK_RANGE, GIANT_GRUB_ATTACK_RANGE)
	inst.components.combat:SetRetargetFunction(3, Retarget)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat.canbeattackedfn = CanBeAttacked
	inst.components.combat.hiteffectsymbol = "chest"

	inst:SetStateGraph("SGgiantgrub")
	inst:SetBrain(brain)
	inst.data = {}

	inst.sounds = giantgrubsounds

	inst.attackUponSurfacing = false

    SetState(inst, "under")
    inst.SetState = SetState
    inst.IsState = IsState

	inst.OnEntitySleep = OnSleep
    inst.OnRemoveEntity = OnRemove
    inst:ListenForEvent("enterlimbo", OnRemove)

	return inst
end

return Prefab("forest/animals/giantsnow", fn, assets, prefabs)