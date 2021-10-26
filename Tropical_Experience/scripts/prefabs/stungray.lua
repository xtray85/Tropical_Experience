
local assets=
{
	Asset("ANIM", "anim/stinkray.zip"),
	Asset("SOUND", "sound/bat.fsb"),
	Asset("MINIMAP_IMAGE", "stinkray"),
}

local prefabs =
{
	"venomgland",
	"poisonbubble_short",
	"monstermeat",
	"splash_water",
}

local SLEEP_DIST_FROMHOME = 1
local SLEEP_DIST_FROMTHREAT = 20
local MAX_CHASEAWAY_DIST = 80
local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local       	STINKRAY_DAMAGE = 3
local        STINKRAY_HEALTH = 100
local        STINKRAY_ATTACK_PERIOD = 1
local        STINKRAY_ATTACK_DIST = 2
local	    STINKRAY_TARGET_DIST = 6
 local       STINKRAY_WALK_SPEED = 8
local        STINKRAY_CHASE_TIME = 3
local        STINKRAY_CHASE_DIST = 10
local        STINKRAY_SCALE_FLYING = 1.05
local		STINKRAY_SCALE_WATER = 1.00

local function KeepThreat(inst, threat)
	return threat:GetIsOnWater(threat:GetPosition():Get()) -- and not (threat.components.poisonable and threat.components.poisonable:IsPoisoned())
end

local function MakeTeam(inst, attacker)
    local leader = SpawnPrefab("teamleader")
    leader.components.teamleader:SetUp(attacker, inst)
    leader.components.teamleader:BroadcastDistress(inst)
end

local function Retarget(inst)
    local ta = inst.components.teamattacker
	local notags = {"FX", "NOCLICK","INLIMBO", "stungray"}
	local yestags = {"monster", "character"}
	
    local newtarget = FindEntity(inst, STINKRAY_TARGET_DIST, function(guy)
            return inst.components.combat:CanTarget(guy)
        end,
        nil,
        notags,
        yestags
    )
    if newtarget and not ta.inteam and not ta:SearchForTeam() then
        MakeTeam(inst, newtarget)
    end

    if ta.inteam and not ta.teamleader:CanAttack() then
        return newtarget
    end
end

local function KeepTarget(inst, target)
--[[
if target then
local map = TheWorld.Map
local x, y, z = target.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_HAZARDOUS then
if inst.components.teamleader then inst.components.teamleader:DisbandTeam() end
print("chega") 
end
end
]]
    return (inst.components.teamattacker.inteam and not inst.components.teamattacker.teamleader:CanAttack())
        or inst.components.teamattacker.orders == ORDERS.ATTACK
end

local SLEEP_DIST_FROMHOME = 1
local SLEEP_DIST_FROMTHREAT = 20
local MAX_CHASEAWAY_DIST = 80
local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 40

local function OnAttacked(inst, data)
    if not inst.components.teamattacker.inteam and not inst.components.teamattacker:SearchForTeam() then
        MakeTeam(inst, data.attacker)
    elseif inst.components.teamattacker.teamleader then
        inst.components.teamattacker.teamleader:BroadcastDistress(inst)   --Ask for  help!
    end

    if inst.components.teamattacker.inteam and not inst.components.teamattacker.teamleader:CanAttack() then
        local attacker = data and data.attacker
        inst.components.combat:SetTarget(attacker)
        inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("bat") end, MAX_TARGET_SHARES)
    end
end

local function OnCombatTarget(inst, data)
	--If you're in a team or have a combat target then run.
	if (data and data.target) or inst.components.teamattacker.inteam then
		inst.components.locomotor:SetShouldRun(true)
	else
		inst.components.locomotor:SetShouldRun(false)
	end
end

local function SetLocoState(inst, state)
	--"gotofly" or "gotoswim"
	inst.LocoState = string.lower(state)
end

local function IsLocoState(inst, state)
	return inst.LocoState == string.lower(state)
end

local function ShouldSleep(inst)
 return false
end

local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
	shadow:SetSize( 1.75, .6 )
	shadow:Enable(false)

	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.Transform:SetNoFaced()

	inst.scale_flying = STINKRAY_SCALE_FLYING
	inst.scale_water = STINKRAY_SCALE_WATER
	inst.Transform:SetScale(inst.scale_water, inst.scale_water, inst.scale_water)

	MakeCharacterPhysics(inst, 1, .5)

	anim:SetBank("stinkray")
	anim:SetBuild("stinkray")

	inst:AddTag("aquatic")
	inst:AddTag("monster")
	inst:AddTag("hostile")
	inst:AddTag("stungray")
	inst:AddTag("scarytoprey")
	inst:AddTag("flying")	
	inst:AddTag("tropicalspawner")	
	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end	
	
	inst:AddComponent("locomotor")
	inst.components.locomotor:SetSlowMultiplier( 1 )
	inst.components.locomotor:SetTriggersCreep(false)
	inst.components.locomotor.pathcaps = { ignorecreep = true }
	inst.components.locomotor.walkspeed = STINKRAY_WALK_SPEED

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!

	inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(ShouldSleep)

	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "bat_body"
	inst.components.combat:SetAttackPeriod(STINKRAY_ATTACK_PERIOD)
	inst.components.combat:SetRange(STINKRAY_ATTACK_DIST)
	inst.components.combat:SetRetargetFunction(3, Retarget)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat.poisonous = true
	inst.components.combat.gasattack = true 
--	inst.components.combat:SetOnHitOther(OnHitOther)
	inst.components.combat:SetDefaultDamage(10)

	inst:AddComponent("poisonous")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(STINKRAY_HEALTH)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:AddRandomLoot("venomgland", 1)   
	inst.components.lootdropper:AddRandomLoot("monstermeat", 2)
	inst.components.lootdropper.numrandomloot = 1

	inst:AddComponent("inventory")

	inst:AddComponent("inspectable")
	inst:AddComponent("knownlocations")

	inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)

	MakeMediumBurnableCharacter(inst, "ray_face")
	MakeMediumFreezableCharacter(inst, "ray_face")

	inst:AddComponent("teamattacker")
	inst.components.teamattacker.team_type = "stungray"
	inst.components.teamattacker.run = true

	inst:ListenForEvent("attacked", OnAttacked)
--	inst:ListenForEvent("newcombattarget", OnCombatTarget)
--	inst:ListenForEvent("losttarget", OnCombatTarget)

	SetLocoState(inst, "swim")
	inst.SetLocoState = SetLocoState
	inst.IsLocoState = IsLocoState
	
	inst:SetStateGraph("SGStungray")
	local brain = require "brains/stungraybrain"
	inst:SetBrain(brain)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)		

	return inst
end

return Prefab("forest/monsters/stungray", fn, assets, prefabs)
