local assets =
{
	Asset("ANIM", "anim/flotsam.zip"),
	Asset("ANIM", "anim/fishschool.zip"),
	Asset("ANIM", "anim/fish2.zip"),
	Asset("ANIM", "anim/coi.zip"),	
}

local water_prefabs =
{
	"splash",
	"oceanfishableflotsam",
}

local SWIMMING_COLLISION_MASK   = COLLISION.GROUND
								+ COLLISION.LAND_OCEAN_LIMITS
								+ COLLISION.OBSTACLES
								+ COLLISION.SMALLOBSTACLES
local PROJECTILE_COLLISION_MASK = COLLISION.GROUND

local NUM_LOOTS = 2

local MAX_CATCH_RADIUS = 1.4

local REEL_SPEED_LOW = 0.5
local REEL_SPEED_HIGH = 2.25

local UNREEL_RATE = .5


local HOOK_CANT_TAGS = { "INLIMBO" }
local HOOK_ONEOF_TAGS = { "fishinghook" }
local function OnUpdate(inst)
	local rod = inst.components.oceanfishable:GetRod()

	if rod == nil then
		local hook = FindEntity(inst, MAX_CATCH_RADIUS, nil, nil, HOOK_CANT_TAGS, HOOK_ONEOF_TAGS)

		if hook ~= nil and hook.components.oceanfishable ~= nil then
			inst.components.oceanfishable:SetRod(hook.components.oceanfishable:GetRod())
		end
	else
		local vx, vy, vz = inst.Physics:GetVelocity()
		local cur_speed = vx * vx + vz * vz
		cur_speed = cur_speed == 0 and cur_speed or math.sqrt(cur_speed)

		local delta = rod:GetPosition() - inst:GetPosition()
		local angle = math.atan2(delta.z, delta.x)

		local tension = rod.components.oceanfishingrod ~= nil and rod.components.oceanfishingrod:GetTensionRating() or 0

		if tension > TUNING.OCEAN_FISHING.LINE_TENSION_HIGH then
			cur_speed = Lerp(REEL_SPEED_LOW, REEL_SPEED_HIGH, math.sin(Remap(tension, TUNING.OCEAN_FISHING.LINE_TENSION_HIGH, 1, 0, 1) * math.pi * .5))
			inst.Physics:SetVel(math.cos(angle) * cur_speed, 0, math.sin(angle) * cur_speed)
		end
	end
end

local function StartUpdating(inst)
	if inst.updatetask ~= nil then
		inst.updatetask:Cancel()
	end
	inst.updatetask = inst:DoPeriodicTask(0, OnUpdate)
end

local function StopUpdating(inst)
	if inst.updatetask ~= nil then
		inst.updatetask:Cancel()
		inst.updatetask = nil
	end
end

local function playlandfx(inst)
	local puddle = SpawnPrefab("splash")
	puddle.entity:SetParent(inst.entity)
	local scale = 1.15
	puddle.Transform:SetScale(scale, scale, scale)
	puddle.Transform:SetRotation(math.random() * 360)
end

local function renova(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local item = SpawnPrefab("fishinhole")
	item.Transform:SetPosition(x, y, z)
	inst:Remove()
end

local function renova2(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local item = SpawnPrefab("fishinholeham")
	item.Transform:SetPosition(x, y, z)
	inst:Remove()
end

local function OnLand(inst)
	local x, y, z = inst.Transform:GetWorldPosition()

	local land_in_water = not TheWorld.Map:IsPassableAtPoint(x, y, z)
	if land_in_water then
		StartUpdating(inst)

--	    inst:RemoveComponent("complexprojectile")
		inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
		inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
		inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)
		inst.AnimState:SetBuild("fishschool")
		inst.AnimState:SetBank("fishschool")
		inst.AnimState:PlayAnimation("idle_loop_gone", true)
		inst.Transform:SetScale(0.7, 0.7, 0.7)	
	    SpawnPrefab("splash").Transform:SetPosition(x, y, z)
		inst:DoTaskInTime(120, renova)
		
		local item = SpawnPrefab("oceanfish_small_61")
		item.Transform:SetPosition(x, y, z)
		item.Transform:SetRotation(inst.Transform:GetRotation())
	else
		local item = SpawnPrefab("oceanfish_small_61_inv")
		item.Transform:SetPosition(x, y, z)
		item.Transform:SetRotation(inst.Transform:GetRotation())
		item:DoTaskInTime(2*FRAMES, playlandfx)
		
--	    inst:RemoveComponent("complexprojectile")
		inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
		inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
		inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)
		inst.AnimState:SetBuild("fishschool")
		inst.AnimState:SetBank("fishschool")
		inst.AnimState:PlayAnimation("idle_loop_gone", true)
		inst.Transform:SetScale(0.7, 0.7, 0.7)	
		inst:DoTaskInTime(120, renova)

	end
end

local function OnLand2(inst)
	local x, y, z = inst.Transform:GetWorldPosition()

	local land_in_water = not TheWorld.Map:IsPassableAtPoint(x, y, z)
	if land_in_water then
		StartUpdating(inst)

--	    inst:RemoveComponent("complexprojectile")
		inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
		inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
		inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)
		inst.AnimState:SetBuild("fishschool")
		inst.AnimState:SetBank("fishschool")
		inst.AnimState:PlayAnimation("idle_loop_gone", true)
		inst.Transform:SetScale(0.7, 0.7, 0.7)	
	    SpawnPrefab("splash").Transform:SetPosition(x, y, z)
		inst:DoTaskInTime(120, renova2)
		
		local item = SpawnPrefab("oceanfish_small_10")
		item.Transform:SetPosition(x, y, z)
		item.Transform:SetRotation(inst.Transform:GetRotation())
	else
		local item = SpawnPrefab("oceanfish_small_10_inv")
		item.Transform:SetPosition(x, y, z)
		item.Transform:SetRotation(inst.Transform:GetRotation())
		item:DoTaskInTime(2*FRAMES, playlandfx)
		
--	    inst:RemoveComponent("complexprojectile")
		inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
		inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
		inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)
		inst.AnimState:SetBuild("fishschool")
		inst.AnimState:SetBank("fishschool")
		inst.AnimState:PlayAnimation("idle_loop_gone", true)
		inst.Transform:SetScale(0.7, 0.7, 0.7)	
		inst:DoTaskInTime(120, renova2)

	end
end

local function OnMakeProjectile(inst)
	StopUpdating(inst)

    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetOnHit(OnLand)

	inst.Physics:SetCollisionMask(PROJECTILE_COLLISION_MASK)

    inst.AnimState:SetSortOrder(0)
    inst.AnimState:SetLayer(LAYER_WORLD)
    inst.AnimState:SetBuild("fish2")
    inst.AnimState:SetBank("fish2")	
	inst.Transform:SetScale(1, 1, 1)	
	inst.AnimState:PlayAnimation("catching_loop", true)

    SpawnPrefab("splash").Transform:SetPosition(inst.Transform:GetWorldPosition())

	return inst
end

local function OnMakeProjectile2(inst)
	StopUpdating(inst)

    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetOnHit(OnLand2)

	inst.Physics:SetCollisionMask(PROJECTILE_COLLISION_MASK)

    inst.AnimState:SetSortOrder(0)
    inst.AnimState:SetLayer(LAYER_WORLD)
    inst.AnimState:SetBuild("coi")
    inst.AnimState:SetBank("coi")	
	inst.Transform:SetScale(1, 1, 1)	
	inst.AnimState:PlayAnimation("catching_loop", true)

    SpawnPrefab("splash").Transform:SetPosition(inst.Transform:GetWorldPosition())

	return inst
end

local function OnReelingIn(inst, doer)
	SpawnPrefab("splash").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function OnReelingInPst(inst, doer)
	local rod = inst.components.oceanfishable:GetRod()
	if rod == nil or (rod.components.oceanfishingrod ~= nil and not rod.components.oceanfishingrod:IsLineTensionHigh()) then
    inst.AnimState:SetBuild("oceanfish_small_2")
    inst.AnimState:SetBank("oceanfish_small")	
	inst.Transform:SetScale(1, 1, 1)	
		inst.AnimState:PlayAnimation("struggle_pre")
		inst.AnimState:PushAnimation("struggle_loop")
		inst.AnimState:PushAnimation("struggle_pst")
		inst.AnimState:PushAnimation("walk_loop", true)
	end
end

local function OverrideUnreelRateFn(inst, rod)
	return UNREEL_RATE
end

local function OnSetRod(inst, rod)
	if rod ~= nil then
		inst:AddTag("scarytooceanprey")
	else
		inst:RemoveTag("scarytooceanprey")
	end

	SpawnPrefab("splash").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function OnEntityWake(inst)
	StartUpdating(inst)
end

local function OnEntitySleep(inst)
	StopUpdating(inst)
end

local function waterfn(data)
   local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddPhysics()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "fish2.png" )	

    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0.16)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
	inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
    inst.Physics:SetCapsule(0.5, 1)

    inst:AddTag("ignorewalkableplatforms")
	inst:AddTag("notarget")
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")-- it's fine to build things on top of them
	inst:AddTag("oceanfishable")
	inst:AddTag("oceanfishinghookable")
	inst:AddTag("swimming")
	inst:AddTag("winchtarget")--from winchtarget component

    inst.AnimState:SetBuild("fishschool")
    inst.AnimState:SetBank("fishschool")
    inst.AnimState:PlayAnimation("idle_loop_full", true)
	inst.Transform:SetScale(0.7, 0.7, 0.7)	

    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
    inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("oceanfishable")
	inst.components.oceanfishable.makeprojectilefn = OnMakeProjectile
	inst.components.oceanfishable.onreelinginfn = OnReelingIn
	inst.components.oceanfishable.onreelinginpstfn = OnReelingInPst
	inst.components.oceanfishable.onsetrodfn = OnSetRod
	inst.components.oceanfishable.overrideunreelratefn = OverrideUnreelRateFn
	inst.components.oceanfishable.catch_distance = TUNING.OCEAN_FISHING.MUDBALL_CATCH_DIST

	inst.OnEntityWake = OnEntityWake
    inst.OnEntitySleep = OnEntitySleep

	StartUpdating(inst)

    return inst
end

local function waterfn2(data)
   local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddPhysics()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "coi.png" )	

    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0.16)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
	inst.Physics:SetCollisionMask(SWIMMING_COLLISION_MASK)
    inst.Physics:SetCapsule(0.5, 1)

    inst:AddTag("ignorewalkableplatforms")
	inst:AddTag("notarget")
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")-- it's fine to build things on top of them
	inst:AddTag("oceanfishable")
	inst:AddTag("oceanfishinghookable")
	inst:AddTag("swimming")
	inst:AddTag("winchtarget")--from winchtarget component

    inst.AnimState:SetBuild("fishschool")
    inst.AnimState:SetBank("fishschool")
    inst.AnimState:PlayAnimation("idle_loop_full", true)
	inst.Transform:SetScale(0.7, 0.7, 0.7)	

    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
    inst.AnimState:SetLayer(LAYER_WIP_BELOW_OCEAN)
	
	inst:SetPrefabNameOverride("fishinhole")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("oceanfishable")
	inst.components.oceanfishable.makeprojectilefn = OnMakeProjectile2
	inst.components.oceanfishable.onreelinginfn = OnReelingIn
	inst.components.oceanfishable.onreelinginpstfn = OnReelingInPst
	inst.components.oceanfishable.onsetrodfn = OnSetRod
	inst.components.oceanfishable.overrideunreelratefn = OverrideUnreelRateFn
	inst.components.oceanfishable.catch_distance = TUNING.OCEAN_FISHING.MUDBALL_CATCH_DIST

	inst.OnEntityWake = OnEntityWake
    inst.OnEntitySleep = OnEntitySleep

	StartUpdating(inst)

    return inst
end

return Prefab("fishinhole", waterfn, assets, water_prefabs),
	   Prefab("fishinholeham", waterfn2, assets, water_prefabs)