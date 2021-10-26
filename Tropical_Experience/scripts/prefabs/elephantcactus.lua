local brain = require "brains/elephantcactusbrain"

local seg_time = 30 --each segment of the clock is 30 seconds
local total_day_time = seg_time*16
local ELEPHANTCACTUS_DAMAGE = 20
local ELEPHANTCACTUS_HEALTH = 400
local ELEPHANTCACTUS_RANGE = 5
local ELEPHANTCACTUS_REGROW_PERIOD = 2
local ELEPHANTCACTUS_REGROW_TIME = 10
local ELEPHANTCACTUS_NORMAL_PICKTIME = seg_time * 12
local ELEPHANTCACTUS_REGROW_STUMP_NORMAL = total_day_time / 2
local ELEPHANTCACTUS_REGROW_NORMAL_ACTIVE = 1 -- total_day_time * 2

local assets =
{
	Asset("ANIM", "anim/cactus_volcano.zip"),
	Asset("MINIMAP_IMAGE", "cactus_volcano"),
}

local prefabs = 
{
	"dug_elephantcactus",
	"cactus_meat",
	"twigs",
}

local function ontransplantfn(inst)
	--inst.components.pickable:MakeBarren()
end

local function makeemptyfn(inst)
	if inst.components.pickable and inst.components.pickable.withered then
		active.sg:GoToState("grow_spike")
	end
end

local function makebarrenfn(inst)
	if inst.components.pickable and inst.components.pickable.withered then
		if not inst.components.pickable.hasbeenpicked then
			inst.AnimState:PlayAnimation("full_to_dead")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/volcano_cactus/full_to_dead")
		else
			inst.AnimState:PlayAnimation("empty_to_dead")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/volcano_cactus/death")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/volcano_cactus/empty_to_dead")
		end
		inst.AnimState:PushAnimation("idle_dead")
	else
		inst.AnimState:PlayAnimation("idle_dead")
	end
end

local function pickanim(inst)
	if inst.components.pickable then
		if inst.components.pickable:CanBePicked() then
			return "idle_spike"
		else
			if inst.components.pickable:IsBarren() then
				return "idle_dead"
			else
				return "idle"
			end
		end
	end

	return "idle"
end

local function shake(inst)
	if inst.components.pickable and inst.components.pickable:CanBePicked() then
		inst.AnimState:PlayAnimation("shake")
	else
		inst.AnimState:PlayAnimation("shake_empty")
	end
	inst.AnimState:PushAnimation(pickanim(inst), false)
end

local function onpickedfn(inst, picker)
	if inst.components.pickable then
		inst.AnimState:PlayAnimation("chopped")
		
		if inst.components.pickable:IsBarren() then
			inst.AnimState:PushAnimation("idle_dead")
		else
			inst.AnimState:PushAnimation("idle")
		end
	end	
	if picker.components.combat then
		picker.components.combat:GetAttacked(inst, TUNING.MARSHBUSH_DAMAGE)
		picker:PushEvent("thorns")
	end
end

local function makefullfn(inst)
	local anim = pickanim(inst)
	inst.AnimState:PlayAnimation(anim)
end


local function dig_up(inst, chopper)
	if inst.components.pickable then
		if inst.components.pickable:CanBePicked() then
			inst.components.lootdropper:SpawnLootPrefab("cactus_meat")
		else
			inst.components.lootdropper:SpawnLootPrefab("twigs")
			inst.components.lootdropper:SpawnLootPrefab("twigs")
		end
	else
		inst.components.lootdropper:SpawnLootPrefab("dug_elephantcactus")
	end
	
	inst:Remove()
end

local function getregentimefn(inst)
	if inst.components.pickable then
		local num_cycles_passed = math.min(inst.components.pickable.max_cycles - inst.components.pickable.cycles_left, 0)
		return TUNING.BERRY_REGROW_TIME + TUNING.BERRY_REGROW_INCREASE*num_cycles_passed+ math.random()*TUNING.BERRY_REGROW_VARIANCE
	else
		return TUNING.BERRY_REGROW_TIME
	end
	
end

local function retargetfn(inst)
	local newtarget = FindEntity(inst, ELEPHANTCACTUS_RANGE, function(guy)
			return guy.components.health and not guy.components.health:IsDead()
	end, nil, {"elephantcactus", "FX", "NOCLICK"})

	return newtarget
end

local function shouldKeepTarget(inst, target)
	if target and target:IsValid() and
		(target.components.health and not target.components.health:IsDead()) then
		local distsq = target:GetDistanceSqToInst(inst)
		return distsq < ELEPHANTCACTUS_RANGE*ELEPHANTCACTUS_RANGE
	else
		return false
	end
end

local function onactivechange(inst)
	local active = SpawnPrefab("elephantcactus_active")
	if active then 
		active.Physics:Teleport(inst.Transform:GetWorldPosition())
		inst:Remove()
	end
end

local function onnormalchange(inst)
	local normal = SpawnPrefab("elephantcactus")
	if normal then 
		normal.Physics:Teleport(inst.Transform:GetWorldPosition())
		inst:Remove()
	end
end

local function onload_active(inst, data)
if data == nil then return end
    if data.has_spike then 
    inst.has_spike = data.has_spike
	inst.has_spike = true
    end    	
end

local function onsave_active(inst, data)
	if inst.has_spike then
	data.has_spike = inst.has_spike
	end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("cactus_volcano.png")

	anim:SetBuild("cactus_volcano")
	anim:SetBank("cactus_volcano")
	anim:PlayAnimation("idle_spike", true)
	--anim:SetTime(math.random()*2)

	inst:AddTag("thorny")
	inst:AddTag("elephantcactus")
	inst:AddTag("scarytoprey")
	inst:AddTag("plant")	
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("pickable")
	inst.components.pickable.picksound = "dontstarve/wilson/harvest_sticks"
	
	inst.components.pickable:SetUp("cactus_meat", ELEPHANTCACTUS_NORMAL_PICKTIME)
	inst.components.pickable.getregentimefn = getregentimefn
	inst.components.pickable.onpickedfn = onpickedfn
	inst.components.pickable.makebarrenfn = makebarrenfn
	inst.components.pickable.makefullfn = makefullfn
	inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.ontransplantfn = ontransplantfn
	inst.components.pickable.max_cycles = TUNING.BERRYBUSH_CYCLES + math.random(2)
	inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig_up)
	inst.components.workable:SetWorkLeft(1)
	
	inst:AddComponent("inspectable")

	inst:AddComponent("lootdropper")

	inst.entity:AddSoundEmitter()
	MakeObstaclePhysics(inst, 1)

	inst:DoTaskInTime(ELEPHANTCACTUS_REGROW_NORMAL_ACTIVE, onactivechange)

	return inst
end

local function ontimerdone(inst, data)
	if data.name == "SPIKE" then
		inst.has_spike = true
		inst:PushEvent("growspike")
	end
end

local function OnBlocked(owner, data) 
	if (data.weapon == nil or (not data.weapon:HasTag("projectile") and data.weapon.projectile == nil))
		and data.attacker and data.attacker.components.combat and data.stimuli ~= "thorns" and not data.attacker:HasTag("thorny")
		and (data.attacker.components.combat == nil or (data.attacker.components.combat.defaultdamage > 0)) then
		
		data.attacker.components.combat:GetAttacked(owner, ELEPHANTCACTUS_DAMAGE/2, nil, "thorns")
		owner.SoundEmitter:PlaySound("dontstarve_DLC002/common/armour/cactus")
	end
end

local function activefn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local minimap = inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()
	
	minimap:SetIcon("cactus_volcano.png")

	anim:SetBuild("cactus_volcano")
	anim:SetBank("cactus_volcano")
	anim:PlayAnimation("idle_spike")
	anim:SetTime(math.random()*2)

	inst:AddTag("thorny")
	inst:AddTag("elephantcactus")
	inst:AddTag("plant")	
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	
	MakeLargeFreezableCharacter(inst)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"needlespear"})

	inst.entity:AddSoundEmitter()
	MakeObstaclePhysics(inst, 1)

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(ELEPHANTCACTUS_HEALTH)

	inst:AddComponent("combat")
	inst.components.combat:SetRange(ELEPHANTCACTUS_RANGE)
	inst.components.combat:SetDefaultDamage(ELEPHANTCACTUS_DAMAGE)
	inst.components.combat:SetAreaDamage(ELEPHANTCACTUS_RANGE, 1.0)
	inst.components.combat:SetAttackPeriod(1)
	inst.components.combat:SetRetargetFunction(1, retargetfn)
	inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)
	inst.components.combat.notags = {"elephantcactus", "armorcactus"}
	inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/volcano_cactus/hit")

	inst:AddComponent("timer")
	inst:ListenForEvent("timerdone", ontimerdone)

	inst:ListenForEvent("blocked", OnBlocked)
	inst:ListenForEvent("attacked", OnBlocked)

	inst.has_spike = true

	inst:SetBrain(brain)
	inst:SetStateGraph("SGelephantcactus")
	inst.sg:GoToState("grow_spike")
	
	inst.OnLoad = onload_active
	inst.OnSave = onsave_active

	return inst
end

local function stumpfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("cactus_volcano.png")

	anim:SetBuild("cactus_volcano")
	anim:SetBank("cactus_volcano")
	anim:PlayAnimation("idle_underground")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig_up)
	inst.components.workable:SetWorkLeft(1)
	
	inst:AddComponent("inspectable")

	inst:AddComponent("lootdropper")

	inst:DoTaskInTime(ELEPHANTCACTUS_REGROW_STUMP_NORMAL, onnormalchange)

	return inst
end

-- you can find dug_elephantcactus in plantables.lua
return Prefab("marsh/objects/elephantcactus", fn, assets, prefabs),
	   Prefab("marsh/objects/elephantcactus_active", activefn, assets, prefabs),
	   Prefab("marsh/objects/elephantcactus_stump", stumpfn, assets, prefabs)
