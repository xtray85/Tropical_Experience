local assets =
{
    Asset("ANIM", "anim/twister_build.zip"),
    Asset("ANIM", "anim/twister_basic.zip"),
    Asset("ANIM", "anim/twister_actions.zip"),
    Asset("ANIM", "anim/twister_seal.zip"),
}

local prefabs =
{
    "collapse_small",
	"volcanostaff",
--	"turbine_blades",
--    "twister_seal",
--    "magic_seal",
}


local TWISTER_CALM_WALK_SPEED = 5
local TWISTER_ANGRY_WALK_SPEED = 8
local TWISTER_RUN_SPEED = 13
local TWISTER_HEALTH = 9000
local TWISTER_DAMAGE = 150
local TWISTER_VACUUM_DAMAGE = 500
local TWISTER_VACUUM_SANITY_HIT = -33
local TWISTER_VACUUM_DISTANCE = 15
local TWISTER_PLAYER_VACUUM_DISTANCE = 30
local TWISTER_ATTACK_PERIOD = 3
local TWISTER_MELEE_RANGE = 6
local TWISTER_ATTACK_RANGE = 6
local TWISTER_VACUUM_COOLDOWN = 20
local TWISTER_CHARGE_COOLDOWN = 10
local TWISTER_VACUUM_ANTIC_TIME = 5
local TWISTER_VACUUM_TIME = 5

local TWISTER_WAVES_ANTIC_TIME = 7
local TWISTER_WAVES_TIME = 5

local TWISTER_SEAL_HEALTH = 10

SetSharedLootTable('twister',
{
    {
	'obsidian',   1.00}
	,
})

local TARGET_DIST = 60

local function OnEntitySleep(inst)
--    if inst.shouldGoAway then
--        inst:Remove()
--    end
end

local function CalcSanityAura(inst, observer)
    if inst.components.combat.target then
        return -TUNING.SANITYAURA_HUGE
    end

    return -TUNING.SANITYAURA_LARGE
end

local function RetargetFn(inst)
local player = GetClosestInstWithTag("player", inst, 70)
if player then return inst.components.combat:SetTarget(player) else
inst.components.combat:SetTarget(nil) end
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target) 
end

local function OnSave(inst, data)
    data.CanVacuum = inst.CanVacuum
    data.CanCharge = inst.CanCharge
--    data.shouldGoAway = inst.shouldGoAway
end

local function OnLoad(inst, data)
    if data then
        inst.CanVacuum = data.CanVacuum
        inst.CanCharge = data.CanCharge
--        inst.shouldGoAway = data.shouldGoAway or false
    end
end

--local function OnSeasonChange(inst, data)
--    inst.shouldGoAway = TheWorld.state.iswinter or TheWorld.state.isautumn or TheWorld.state.issummer or inst.shouldGoAway
--
--    if inst:IsAsleep() then
--        OnEntitySleep(inst)
--    end
--end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
end

local function ontimerdone(inst, data)
    if data.name == "Vacuum" then 
        inst.CanVacuum = true 
    elseif data.name == "Charge" then
        inst.CanCharge = true
    end
end

local function OnKill(inst, data)
--    if data and data.victim:HasTag("Player") then
--        inst.shouldGoAway = true
--    end
end

local function OnDead(inst)
--    AwardRadialAchievement("bearger_killed", inst:GetPosition(), TUNING.ACHIEVEMENT_RADIUS_FOR_GIANT_KILL)
--    inst.components.shedder:StopShedding()
    TheWorld:PushEvent("twisterkilled", inst)
end

local function OnRemove(inst)
    TheWorld:PushEvent("twisterremoved", inst)
end

local function fn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()
	shadow:SetSize(6, 3.5)
    
    inst.Transform:SetFourFaced()
    
    local s = 1
    trans:SetScale(s,s,s)

    local physics = inst.entity:AddPhysics()
    physics:SetMass(1000)
    physics:SetCapsule(1.5, 1)
    physics:SetFriction(0)
    physics:SetDamping(5)
    physics:SetCollisionGroup(COLLISION.CHARACTERS)
    physics:ClearCollisionMask()
    physics:CollidesWith(COLLISION.GROUND)
    physics:CollidesWith(COLLISION.CHARACTERS)
--	physics:CollidesWith(COLLISION.WAVES)

    anim:SetBank("twister")
    anim:SetBuild("twister_build")
    anim:PlayAnimation("idle_loop", true)
    
    -------------------

    inst:AddTag("amphibious")
	inst:AddTag("epic")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("twister")
    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
        return inst
    end

    ------------------

    inst:AddComponent("inventory")
    inst:AddComponent("timer")
	inst:AddComponent("knownlocations")

    ------------------
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    ------------------
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TWISTER_HEALTH)
    inst.components.health.destroytime = 5
    
    ------------------

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TWISTER_DAMAGE)
    inst.components.combat.playerdamagepercent = .5
    inst.components.combat:SetRange(TWISTER_ATTACK_RANGE, TWISTER_MELEE_RANGE)
    inst.components.combat:SetAreaDamage(TWISTER_MELEE_RANGE, 0.8)
    inst.components.combat:SetAttackPeriod(TWISTER_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    --inst.components.combat:SetHurtSound("")
 
    ------------------

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable("twister")
    
    ------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    ------------------

    inst:AddComponent("vacuum")
    inst.components.vacuum:TurnOn()
    inst.components.vacuum.playervacuumdamage = TWISTER_VACUUM_DAMAGE
    inst.components.vacuum.playervacuumsanityhit = TWISTER_VACUUM_SANITY_HIT
    inst.components.vacuum.vacuumradius = TWISTER_VACUUM_DISTANCE
    inst.components.vacuum.playervacuumradius = TWISTER_PLAYER_VACUUM_DISTANCE

    ------------------

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TWISTER_CALM_WALK_SPEED
    inst.components.locomotor.runspeed = TWISTER_RUN_SPEED
    inst.components.locomotor:SetShouldRun(true)
	
	inst:AddComponent("rowboatwakespawner")
    ------------------
    
    inst:SetStateGraph("SGtwister")
    local brain = require("brains/twisterbrain")
    inst:SetBrain(brain)

    ------------------

--    inst:ListenForEvent("seasonChange", function() OnSeasonChange(inst) end, TheWorld)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("entitysleep", OnEntitySleep)
    inst:ListenForEvent("timerdone", ontimerdone)
    inst:ListenForEvent("killed", OnKill)
    inst:ListenForEvent("death", OnDead)	
    inst:ListenForEvent("onremove", OnRemove)	

    ------------------

    inst.CanVacuum = true
    inst.CanCharge = true
--    inst.shouldGoAway = false
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/twister_active", "wind_loop")
    inst.SoundEmitter:SetParameter("wind_loop", "intensity", 0)

    inst.AnimState:Hide("twister_water_fx")
    ------------------

    return inst
end

return Prefab( "common/monsters/twister", fn, assets, prefabs)