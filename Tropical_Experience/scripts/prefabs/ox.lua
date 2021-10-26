local brain = require "brains/oxbrain"
local brainbaby = require "brains/babybeefalobrain"
require "stategraphs/SGox"

local assets=
{
	Asset("ANIM", "anim/ox_basic.zip"),
	Asset("ANIM", "anim/ox_actions.zip"),
	Asset("ANIM", "anim/ox_build.zip"),
	Asset("ANIM", "anim/ox_baby_build.zip"),

	Asset("ANIM", "anim/ox_basic_water.zip"),
	Asset("ANIM", "anim/ox_actions_water.zip"),
    Asset("ANIM", "anim/ox_shaved_build.zip"),

	Asset("ANIM", "anim/ox_heat_build.zip"),
	Asset("SOUND", "sound/beefalo.fsb"),
}

local total_day_time = 480
local	    OX_HEALTH = 500
local	    OX_DAMAGE = 34
local	    OX_MATING_SEASON_LENGTH = 3
local	    OX_MATING_SEASON_WAIT = 20
local	    OX_MATING_SEASON_BABYDELAY = total_day_time*1.5
local	    OX_MATING_SEASON_BABYDELAY_VARIANCE = 0.5*total_day_time
local	    OX_TARGET_DIST = 5
local	    OX_CHASE_DIST = 30
local	    OX_FOLLOW_TIME = 30


local prefabs =
{
	"meat",
	"poop",
	"ox_horn",
	--"horn",
}

SetSharedLootTable( 'ox',
{
	{'meat',            1.00},
	{'meat',            1.00},
	{'meat',            1.00},
	{'ox_horn',         0.50},
	{'beefalowool',       0.50},
})

SetSharedLootTable( 'oxbaby',
{
	{'smallmeat',            1.00},
	{'smallmeat',            1.00},
	{'smallmeatt',           1.00},
	{'ox_horn',              0.13},
})

local sounds = 
{
	angry = "dontstarve_DLC002/creatures/OX/angry",
	curious = "dontstarve_DLC002/creatures/OX/curious",
	
	attack_whoosh = "dontstarve_DLC002/creatures/OX/attack_whoosh",
	chew = "dontstarve_DLC002/creatures/OX/bellow",
	grunt = "dontstarve_DLC002/creatures/OX/bellow",
	hairgrow_pop = "dontstarve_DLC002/creatures/OX/bellow",
	hairgrow_vocal = "dontstarve_DLC002/creatures/OX/bellow",
	sleep = "dontstarve_DLC002/creatures/OX/sleep",
	tail_swish = "dontstarve_DLC002/creatures/OX/bellow",
	walk_land = "dontstarve_DLC002/creatures/OX/walk_land",
	walk_water = "dontstarve_DLC002/creatures/OX/walk_water",

	death = "dontstarve_DLC002/creatures/OX/death",
	mating_call = "dontstarve_DLC002/creatures/OX/mating_call",

	emerge = "dontstarve_DLC002/creatures/seacreature_movement/water_emerge_med",
	submerge = "dontstarve_DLC002/creatures/seacreature_movement/water_emerge_med",
}

local soundsbaby =
{
	angry = "dontstarve_DLC002/creatures/OX/angry",
	curious = "dontstarve_DLC002/creatures/OX/curious",
	
	attack_whoosh = "dontstarve_DLC002/creatures/OX/attack_whoosh",
	chew = "dontstarve_DLC002/creatures/OX/bellow",
	grunt = "dontstarve_DLC002/creatures/OX/bellow",
	hairgrow_pop = "dontstarve_DLC002/creatures/OX/bellow",
	hairgrow_vocal = "dontstarve_DLC002/creatures/OX/bellow",
	sleep = "dontstarve_DLC002/creatures/OX/sleep",
	tail_swish = "dontstarve_DLC002/creatures/OX/bellow",
	walk_land = "dontstarve_DLC002/creatures/OX/walk_land",
	walk_water = "dontstarve_DLC002/creatures/OX/walk_water",

	death = "dontstarve_DLC002/creatures/OX/death",
	mating_call = "dontstarve_DLC002/creatures/OX/mating_call",

	emerge = "dontstarve_DLC002/creatures/seacreature_movement/water_emerge_med",
	submerge = "dontstarve_DLC002/creatures/seacreature_movement/water_emerge_med",
    walk = "dontstarve/creatures/beefalo_baby/walk",
    yell = "dontstarve/creatures/beefalo_baby/yell",
    swish = "dontstarve/creatures/beefalo_baby/tail_swish",
}

local function OnEnterMood(inst)
	if inst.components.beard and inst.components.beard.bits > 0 then
		inst.AnimState:SetBuild("ox_heat_build")
		inst.AnimState:SetBank("ox")
		inst:AddTag("scarytoprey")
	end
end

local function OnLeaveMood(inst)
	if inst.components.beard and inst.components.beard.bits > 0 then
		inst.AnimState:SetBuild("ox_build")
		inst.AnimState:SetBank("ox")
		inst:RemoveTag("scarytoprey")
	end
end

local function Retarget(inst)
	local notags = {"FX", "NOCLICK","INLIMBO", "ox", "aquatic", "wall"}

	if inst.components.herdmember
	   and inst.components.herdmember:GetHerd()
	   and inst.components.herdmember:GetHerd().components.mood
	   and inst.components.herdmember:GetHerd().components.mood:IsInMood() then
		return FindEntity(inst, OX_TARGET_DIST, function(guy)
			return inst.components.combat:CanTarget(guy)  	
		end, nil, notags)
	end
end

local function KeepTarget(inst, target)
	
	if inst.components.herdmember
	   and inst.components.herdmember:GetHerd()
	   and inst.components.herdmember:GetHerd().components.mood
	   and inst.components.herdmember:GetHerd().components.mood:IsInMood() then
		local herd = inst.components.herdmember and inst.components.herdmember:GetHerd()
		if herd and herd.components.mood and herd.components.mood:IsInMood() then
			return distsq(Vector3(herd.Transform:GetWorldPosition() ), Vector3(inst.Transform:GetWorldPosition() ) ) < OX_CHASE_DIST*OX_CHASE_DIST
		end
	end

	return true
end

local function OnNewTarget(inst, data)
	if inst.components.follower and data and data.target and data.target == inst.components.follower.leader then
		inst.components.follower:SetLeader(nil)
	end
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
	inst.components.combat:ShareTarget(data.attacker, 30,function(dude)
		return dude:HasTag("ox") and not dude:HasTag("player") and not dude.components.health:IsDead()
	end, 5)
end

local function GetStatus(inst)
	if inst.components.follower.leader ~= nil then
		return "FOLLOWER"
	end
end

local function OnWaterChange(inst, onwater)
	if onwater then
		inst.sg:GoToState("submerge")
	else
		inst.sg:GoToState("emerge")
	end
end

local function OnPooped(inst, poop)
	local heading_angle = -(inst.Transform:GetRotation()) + 180

	local pos = Vector3(inst.Transform:GetWorldPosition())
	pos.x = pos.x + (math.cos(heading_angle*DEGREES))
	pos.y = pos.y + 0.9
	pos.z = pos.z + (math.sin(heading_angle*DEGREES))
	poop.Transform:SetPosition(pos.x, pos.y, pos.z)
	
	if poop.components.inventoryitem then 
--		poop.components.inventoryitem:OnStartFalling()
	end
end

local function OnResetBeard(inst)
inst.AnimState:SetBuild("ox_build")
inst.AnimState:AddOverrideBuild("ox_shaved_build")
end

--tune the beard economy...
local BEARD_DAYS = { 2, 4, 9 }
local BEARD_BITS = { 1, 2,  3 }

local function OnGrowShortBeard(inst)
	inst.AnimState:AddOverrideBuild("ox_build")
    inst.components.beard.bits = BEARD_BITS[1]
end

local function OnEntityWake(inst)
	inst.components.tiletracker:Start()
end

local function OnEntitySleep(inst)
	inst.components.tiletracker:Stop()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.sounds = sounds
	inst.entity:AddNetwork()
	inst.walksound = sounds.walk_land
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 6, 2 )
	inst.Transform:SetSixFaced()


	MakeCharacterPhysics(inst, 100, .75)
--	MakeAmphibiousCharacterPhysics(inst, 100, .5)
--	MakePoisonableCharacter(inst)
	inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)

	
	inst:AddTag("ox")
	anim:SetBank("ox")
	anim:SetBuild("ox_build")
--	inst.AnimState:AddOverrideBuild("ox_shaved_build")
	anim:PlayAnimation("idle_loop", true)
	
	inst:AddTag("animal")
	inst:AddTag("largecreature")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE }, { FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE })
	
	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "beefalo_body"
	inst.components.combat:SetDefaultDamage(OX_DAMAGE)
	inst.components.combat:SetRetargetFunction(1, Retarget)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	 
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(OX_HEALTH)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('ox')    
	
	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = GetStatus
	
	inst:AddComponent("knownlocations")
	inst:AddComponent("herdmember")
	inst.components.herdmember.herdprefab = "oxherd"

	-- inst:ListenForEvent("entermood", OnEnterMood)
	-- inst:ListenForEvent("leavemood", OnLeaveMood)
	
	inst:AddComponent("leader")
	inst:AddComponent("follower")
	inst.components.follower.maxfollowtime = OX_FOLLOW_TIME
	inst.components.follower.canaccepttarget = false
	inst:ListenForEvent("newcombattarget", OnNewTarget)
	inst:ListenForEvent("attacked", OnAttacked)

	inst:AddComponent("periodicspawner")
	inst.components.periodicspawner:SetPrefab("poop")
	inst.components.periodicspawner:SetRandomTimes(40, 60)
	inst.components.periodicspawner:SetDensityInRange(20, 2)
	inst.components.periodicspawner:SetMinimumSpacing(8)
	inst.components.periodicspawner:SetOnSpawnFn(OnPooped)
	inst.components.periodicspawner:Start()

	MakeLargeBurnableCharacter(inst, "swap_fire")
	MakeLargeFreezableCharacter(inst, "beefalo_body")
	
	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.walkspeed = 1.5
	inst.components.locomotor.runspeed = 7
	
--    inst:AddComponent("beard")
--    inst.components.beard.onreset = OnResetBeard
--    inst.components.beard.prize = "beefalowool"
--    inst.components.beard:AddCallback(BEARD_DAYS[1], OnGrowShortBeard)
--    inst.components.beard:AddCallback(BEARD_DAYS[2], OnGrowShortBeard)
	
	inst:AddComponent("sleeper")
	inst.components.sleeper:SetResistance(3)
	
	inst:AddComponent("tiletracker")
	inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)	
	
	inst:SetBrain(brain)
	inst:SetStateGraph("SGox")

	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep
	
	return inst
end

local function oninit(inst)
if inst then
inst.components.fueled:StartConsuming()
end
end

local function apaga(inst)
SpawnPrefab("ox").Transform:SetPosition(inst.Transform:GetWorldPosition())
inst:Remove()
end


local function fnbaby(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.sounds = soundsbaby
	inst.entity:AddNetwork()
	inst.walksound = sounds.walk_land
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 3, 2 )
	inst.Transform:SetSixFaced()
	inst.Transform:SetScale(0.55, 0.55, 0.55)


	MakeCharacterPhysics(inst, 50, .75)
	inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)	
--	MakeAmphibiousCharacterPhysics(inst, 100, .5)
--	MakePoisonableCharacter(inst)
	
	inst:AddTag("ox")
	anim:SetBank("ox")
	anim:SetBuild("ox_baby_build")
	anim:PlayAnimation("idle_loop", true)
	
	inst:AddTag("animal")
	inst:AddTag("largecreature")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE }, { FOODTYPE.VEGGIE, FOODTYPE.ROUGHAGE })
	
	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "beefalo_body"
	inst.components.combat:SetDefaultDamage(OX_DAMAGE)
	inst.components.combat:SetRetargetFunction(1, Retarget)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	 
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(OX_HEALTH)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('oxbaby')    
	
	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = GetStatus
	
	inst:AddComponent("knownlocations")
	inst:AddComponent("herdmember")
	inst.components.herdmember.herdprefab = "oxherd"

	-- inst:ListenForEvent("entermood", OnEnterMood)
	-- inst:ListenForEvent("leavemood", OnLeaveMood)
	
	inst:AddComponent("leader")
	inst:AddComponent("follower")
	inst.components.follower.maxfollowtime = OX_FOLLOW_TIME
	inst.components.follower.canaccepttarget = false
	inst:ListenForEvent("newcombattarget", OnNewTarget)
	inst:ListenForEvent("attacked", OnAttacked)

	inst:AddComponent("periodicspawner")
	inst.components.periodicspawner:SetPrefab("poop")
	inst.components.periodicspawner:SetRandomTimes(40, 60)
	inst.components.periodicspawner:SetDensityInRange(20, 2)
	inst.components.periodicspawner:SetMinimumSpacing(8)
	inst.components.periodicspawner:SetOnSpawnFn(OnPooped)
	inst.components.periodicspawner:Start()

	MakeLargeBurnableCharacter(inst, "swap_fire")
	MakeLargeFreezableCharacter(inst, "beefalo_body")
	
	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.walkspeed = 1.5
	inst.components.locomotor.runspeed = 7
	
	inst:AddComponent("sleeper")
	inst.components.sleeper:SetResistance(3)
	
	inst:AddComponent("tiletracker")
	inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)	
	
	inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.CAVE
    inst.components.fueled:InitializeFuelLevel(math.random(1920,5760))
    inst.components.fueled:SetDepletedFn(apaga)
--    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)
    inst.components.fueled.accepting = false
	
	inst:SetBrain(brainbaby)
	inst:SetStateGraph("SGox")

	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep
	inst:DoTaskInTime(1, oninit)
	
	return inst
end

return Prefab( "forest/animals/ox", fn, assets, prefabs), Prefab( "forest/animals/oxbaby", fnbaby, assets, prefabs) 
