local assets =
{
    Asset("ANIM", "anim/knightboat.zip"),
	Asset("ANIM", "anim/knightboat_death.zip"),
    Asset("ANIM", "anim/knightboat_build.zip"),
}

local prefabs =
{
	"gears",
    "knightboat_cannonshot",
}

SetSharedLootTable("knightboat",
{
    {'gears',  1.00},
    {'gears',  0.66},
    {'gears',  0.33},
})

local SLEEP_DIST_FROMHOME = 1
local SLEEP_DIST_FROMTHREAT = 20
local MAX_CHASEAWAY_DIST = 40
local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 40

local function Retarget(inst)
    local notags = {"FX", "NOCLICK","INLIMBO"}
    local yestags = {"character", "monster"}
    local newtarget = FindEntity(inst, 25, function(guy)
            return inst.components.combat:CanTarget(guy)
    end, nil, notags, yestags)
    return newtarget
end

local function KeepTarget(inst, target)
    local selfpos = inst:GetPosition()
    local targetPos = target:GetPosition()
    return distsq(selfpos, targetPos) < MAX_CHASEAWAY_DIST*MAX_CHASEAWAY_DIST
end

local function OnAttacked(inst, data)
    local attacker = data and data.attacker
    if attacker and attacker:HasTag("chess") then return end
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("chess") end, MAX_TARGET_SHARES)
end

local function OnAttack(inst, data)
    local numshots = 3
    if data.target then
	
local map = TheWorld.Map
local x, y, z = data.target.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
local naagua = false
if ground == GROUND.OCEAN_COASTAL or 
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then naagua = true end	

if naagua == true and not data.target:HasTag("aquatic") then return end
        for i = 0, numshots - 1 do
            local offset = Vector3(math.random(-4, 4), math.random(-4, 4), math.random(-4, 4))
            inst:DoTaskInTime(FRAMES * 10 * i, function()

			local x, y, z = inst.Transform:GetWorldPosition()
			local bomba = SpawnPrefab("knightboat_cannonshot")
			bomba.Transform:SetPosition(x, y+2, z)
			bomba.components.complexprojectile:Launch(data.target:GetPosition() + offset)
            end)
        end		
		
    end
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
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
	inst.entity:AddNetwork()


	MakeCharacterPhysics(inst, 50, 1)

	inst.AnimState:SetBank("knightboat")
	inst.AnimState:SetBuild("knightboat_build")
	inst.AnimState:PlayAnimation("idle_loop")	
	
	
	inst:AddTag("moster")
    inst:AddTag("hostile")
    inst:AddTag("chess")
    inst:AddTag("knight")
	inst:AddTag("tropicalspawner")	

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 4
    inst.components.locomotor.runspeed = 8

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "spring"
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetRetargetFunction(3, Retarget)
    inst.components.combat:SetDefaultDamage(0)
    inst.components.combat:SetAttackPeriod(6)
    inst.components.combat:SetRange(20, 25)
 --   inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/knight_steamboat/hit")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(600)
  
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('knightboat')

    inst:AddComponent("rowboatwakespawner")

    inst:AddComponent("knownlocations")
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", inst:GetPosition(), true) end)

    inst:AddComponent("sleeper")
    inst.components.sleeper.onlysleepsfromitems = true 
    inst.components.sleeper:SetResistance(3)

    inst:SetStateGraph("SGknightboat")
    local brain = require "brains/knightboatbrain"
    inst:SetBrain(brain)

    -- MakeMediumBurnableCharacter(inst, "spring")
    MakeMediumFreezableCharacter(inst, "spring")
    
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttack)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)			

	return inst
end

return Prefab("knightboat", fn, assets, prefabs)
