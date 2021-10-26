local assets =
{
	Asset("ANIM", "anim/ballphin.zip"),
}

local prefabs =
{
	"ballphinpod",
	"fishmeat_small",
	"dorsalfin",
	"messagebottleempty",
}


local       BALLPHIN_TARGET_DIST = 8
local		BALLPHIN_KEEP_TARGET_DIST = 15
local		BALLPHIN_FRIEND_CHANCE = 0.01 -- chance that ballphins will spawn to assist you during a sharx attack
local 		PIG_TARGET_DIST = 16
local	    SOLOFISH_WALK_SPEED = 5
local	    SOLOFISH_RUN_SPEED = 8
local	    SOLOFISH_HEALTH = 100
local	    SOLOFISH_WANDER_DIST = 10
local	    SNAKE_DAMAGE = 10
local       SNAKE_ATTACK_PERIOD = 3
local       SNAKE_JUNGLETREE_CHANCE = 0.5
local		SOLOFISH_HEALTH = 100

local brain = require "brains/ballphinbrain"


local SHARE_TARGET_DIST = 30

local function OnNewTarget(inst, data)
	if inst.components.sleeper:IsAsleep() then
		inst.components.sleeper:WakeUp()
	end
end

local function NormalRetargetFn(inst)
	return FindEntity(inst, PIG_TARGET_DIST,
		function(guy)
			if not guy.LightWatcher or guy.LightWatcher:IsInLight() then
				return guy.components.health and not guy.components.health:IsDead() 
					and inst.components.combat:CanTarget(guy)
			end
		end, {"monster"}, {"abigail"})
end
-- local function NormalKeepTargetFn(inst, target)
--     --give up on dead guys, or guys in the dark, or werepigs
--     return inst.components.combat:CanTarget(target)
--            and (not target.LightWatcher or target.LightWatcher:IsInLight())
--            and not (target.sg and target.sg:HasStateTag("transform") )
-- end

local function retargetfn(inst)
	local dist = BALLPHIN_TARGET_DIST
	return FindEntity(inst, dist, function(guy) 
		--return not guy:HasTag("wall") and not (guy:HasTag("ballphin") ) and inst.components.combat:CanTarget(guy)
		return guy.components.health and not guy.components.health:IsDead()
			and inst.components.combat:CanTarget(guy)
	end, {"monster"}, {"abigail"})
end

local function KeepTarget(inst, target)
	if inst:HasTag('ballphinfriend') then
		return inst.components.combat:CanTarget(target) and inst:GetDistanceSqToInst(target) <= (40*40)
	else
		return inst.components.combat:CanTarget(target) and inst:GetDistanceSqToInst(target) <= (BALLPHIN_KEEP_TARGET_DIST*BALLPHIN_KEEP_TARGET_DIST)
	end
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
	inst.components.combat:ShareTarget(data.attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("ballphin")and not dude.components.health:IsDead() end, 5)
end

local function OnAttackOther(inst, data)
	inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude:HasTag("ballphin") and not dude.components.health:IsDead() end, 5)
	-- local splash = SpawnPrefab("splash_water_drop")
	-- local pos = inst:GetPosition()
	-- splash.Transform:SetPosition(pos.x, pos.y, pos.z)
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
    inst.entity:AddNetwork()
	--local minimap = inst.entity:AddMiniMapEntity()
	--minimap:SetIcon( "fish.png" )

	inst:AddTag("ballphin")

	MakeCharacterPhysics(inst, 1, 0.5)
	-- inst.Physics:ClearCollisionMask()
	-- inst.Physics:CollidesWith(COLLISION.WORLD)
	inst.entity:AddSoundEmitter()

	inst.Transform:SetFourFaced()

	inst.AnimState:SetBank("ballphin")
	inst.AnimState:SetBuild("ballphin")  
	inst.AnimState:PlayAnimation("idle", true)

	anim:SetRayTestOnBB(true)

	inst.entity:SetPristine()

        if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = SOLOFISH_WALK_SPEED -- 2--3.0
	inst.components.locomotor.runspeed = SOLOFISH_RUN_SPEED--5--6.0 
	
	inst:AddComponent("inspectable")
	inst.no_wet_prefix = true

	inst:AddComponent("herdmember")
	inst.components.herdmember.herdprefab = "ballphinpod"

	inst:AddComponent("teamattacker")
	inst.components.teamattacker.team_type = "ballphin"
	inst.components.teamattacker.leashdistance = 99999

	inst:AddComponent("knownlocations")
	
	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(SNAKE_DAMAGE)
	inst.components.combat:SetAttackPeriod(SNAKE_ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(3, retargetfn)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/balphin/hit")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(SOLOFISH_HEALTH)

	inst:AddComponent("sleeper")

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({})
    inst.components.lootdropper:AddRandomLoot("fishmeat_small",2)
    inst.components.lootdropper:AddRandomLoot("dorsalfin",1)
    inst.components.lootdropper:AddRandomLoot("messagebottleempty",1)
    inst.components.lootdropper.numrandomloot = 1

	inst:ListenForEvent("newcombattarget", OnNewTarget)
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("onattackother", OnAttackOther)

	MakeMediumFreezableCharacter(inst, "ballphin_body")

	inst:SetStateGraph("SGballphin")
	inst:SetBrain(brain)
	
--    inst:AddComponent("timer")
--    inst:ListenForEvent("timerdone", OnTimerDone)
--    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)		
	return inst
end

local function fn1()

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	--local minimap = inst.entity:AddMiniMapEntity()
	--minimap:SetIcon( "fish.png" )

	inst:AddTag("ballphin")
	inst:AddTag("tropicalspawner")

	MakeCharacterPhysics(inst, 1, 0.5)
	-- inst.Physics:ClearCollisionMask()
	-- inst.Physics:CollidesWith(COLLISION.WORLD)
	inst.entity:AddSoundEmitter()

	inst.Transform:SetFourFaced()

	inst.AnimState:SetBank("ballphin")
	inst.AnimState:SetBuild("ballphin")  
	inst.AnimState:PlayAnimation("idle", true)

	anim:SetRayTestOnBB(true)

	inst.entity:SetPristine()

        if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = SOLOFISH_WALK_SPEED -- 2--3.0
	inst.components.locomotor.runspeed = SOLOFISH_RUN_SPEED--5--6.0 
	
	inst:AddComponent("inspectable")
	inst.no_wet_prefix = true

	inst:AddComponent("herdmember")
	inst.components.herdmember.herdprefab = "ballphinpod"

	inst:AddComponent("teamattacker")
	inst.components.teamattacker.team_type = "ballphin"
	inst.components.teamattacker.leashdistance = 99999

	inst:AddComponent("knownlocations")
	
	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(SNAKE_DAMAGE)
	inst.components.combat:SetAttackPeriod(SNAKE_ATTACK_PERIOD)
	inst.components.combat:SetRetargetFunction(3, retargetfn)
	inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/balphin/hit")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(SOLOFISH_HEALTH)

	inst:AddComponent("sleeper")

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({})
    inst.components.lootdropper:AddRandomLoot("fishmeat_small",2)
    inst.components.lootdropper:AddRandomLoot("dorsalfin",1)
    inst.components.lootdropper:AddRandomLoot("messagebottleempty",1)
    inst.components.lootdropper.numrandomloot = 1

	inst:ListenForEvent("newcombattarget", OnNewTarget)
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("onattackother", OnAttackOther)

	MakeMediumFreezableCharacter(inst, "ballphin_body")

	inst:SetStateGraph("SGballphin")
	inst:SetBrain(brain)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)		
	return inst
end

return Prefab( "ocean/objects/ballphin", fn, assets, prefabs),
	   Prefab( "ocean/objects/ballphin2", fn1, assets, prefabs)