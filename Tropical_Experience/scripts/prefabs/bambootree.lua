local assets=
{
    Asset("ANIM", "anim/bamboo.zip"),
    Asset("ANIM", "anim/bambootree.zip"),
    Asset("ANIM", "anim/bambootree_build.zip"),	
}

local prefabs =
{
    "bamboo",
    "dug_bambootree",
}
local respawndays = 2  --tempo para renascer em dias

local function makeanims(stage)
	return {
		idle="idle",
		blown1="blown_loop1",
		blown2="blown_loop2",
		blown_pre="blown_pre",
		blown_pst="blown_pst",
	}
end

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
    inst.AnimState:PlayAnimation("grow")
--    inst.AnimState:PushAnimation("sway", true)
	inst.AnimState:PushAnimation("idle",true)
	inst:AddTag("machetecut")
    inst.components.workable:SetWorkLeft(6)
	inst.components.workable:SetWorkAction(ACTIONS.HACK)
	if inst.prefab ~= "oceanbambootree" and inst.prefab ~= "oceanbambootreebig" then 
	MakeObstaclePhysics(inst, 0.35)
	end
    end
end


local function dig_up(inst, worker)

if inst:HasTag("machetecut") then
inst:RemoveTag("machetecut")
inst.components.workable:SetWorkAction(ACTIONS.DIG)
inst.components.workable:SetWorkLeft(1)
inst.components.lootdropper:SpawnLootPrefab("bamboo")
inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)

return 
end


	if not inst:HasTag("machetecut") then
		if inst.components.lootdropper ~= nil then
			inst.components.lootdropper:SpawnLootPrefab("dug_bambootree")
		end
		inst:Remove()
	end

end

local function dig_up2(inst, worker)

if inst:HasTag("machetecut") then
inst:RemoveTag("machetecut")
inst.components.workable:SetWorkAction(ACTIONS.DIG)
inst.components.workable:SetWorkLeft(1)
inst.components.lootdropper:SpawnLootPrefab("bamboo")
inst.components.lootdropper:SpawnLootPrefab("bamboo")
inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)

return 
end


	if not inst:HasTag("machetecut") then
		if inst.components.lootdropper ~= nil then
			inst.components.lootdropper:SpawnLootPrefab("dug_bambootree")
		end
		inst:Remove()
	end

end

local function onhackedfn(inst, hacker, hacksleft)
	if not inst:HasTag("machetecut") then return end
	local fx = SpawnPrefab("hacking_bamboo_fx")
    local x, y, z = inst.Transform:GetWorldPosition()
    fx.Transform:SetPosition(x,y + math.random()*2,z)

	if(hacksleft <= 0) then
		inst.AnimState:PlayAnimation("picking")
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/bamboo_drop")
		if inst.prefab ~= "oceanbambootree" and inst.prefab ~= "oceanbambootreebig" then 
		RemovePhysicsColliders(inst)
		end
	else
		inst.AnimState:PlayAnimation("chop")
		inst.AnimState:PushAnimation("idle")
	end
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/bamboo_hack")
end


local function OnSave(inst, data)
if not inst:HasTag("machetecut") then
    data.tag = 1
end
end

local function OnLoad(inst, data)
    if data and data.tag == 1 then
				inst.AnimState:PlayAnimation("picked")				
				inst:RemoveTag("machetecut")
				inst.components.workable:SetWorkAction(ACTIONS.DIG)
				inst.components.workable:SetWorkLeft(1)			
	if inst.prefab ~= "oceanbambootree" and inst.prefab ~= "oceanbambootreebig" then 
				RemovePhysicsColliders(inst)
	end		
    end	
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("bambootree.png" )

    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:SetBank("bambootree")
	inst.AnimState:SetBuild("bambootree_build")
	inst.AnimState:PlayAnimation("idle",true)
	MakeObstaclePhysics(inst, .35)

	inst:AddTag("machetecut")
	inst:AddTag("bambootree")
	inst:AddTag("plant")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)

	inst:AddComponent("interactions")	
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
	
	inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HACK)
    inst.components.workable:SetOnFinishCallback(dig_up)
    inst.components.workable:SetWorkLeft(6)
	inst.components.workable.onwork = onhackedfn

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    MakeHauntableIgnite(inst)
	
	inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("bambootree.png" )

    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:SetBank("bambootree")
	inst.AnimState:SetBuild("bambootree_build")
	inst.AnimState:PlayAnimation("idle",true)
	inst.Transform:SetScale(1, 2, 1)
	MakeObstaclePhysics(inst, .35)

	inst:AddTag("machetecut")
	inst:AddTag("bambootree")
	inst:AddTag("plant")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)

	inst:AddComponent("interactions")	
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
	
	inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HACK)
    inst.components.workable:SetOnFinishCallback(dig_up2)
    inst.components.workable:SetWorkLeft(6)
	inst.components.workable.onwork = onhackedfn

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    MakeHauntableIgnite(inst)
	
	inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    return inst
end

local DAMAGE_SCALE = 0.5
local function OnCollide(inst, data)
    local boat_physics = data.other.components.boatphysics
    if boat_physics ~= nil then
        local hit_velocity = math.floor(math.abs(boat_physics:GetVelocity() * data.hit_dot_velocity) * DAMAGE_SCALE / boat_physics.max_velocity + 0.5)
        inst.components.workable:WorkedBy(data.other, hit_velocity * TUNING.SEASTACK_MINE)
    end
end

local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("bambootree.png" )

    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:SetBank("bambootree")
	inst.AnimState:SetBuild("bambootree_build")
	inst.AnimState:PlayAnimation("idle",true)
	
	
    inst:SetPhysicsRadiusOverride(1.8)
    MakeWaterObstaclePhysics(inst, 0.35, 2, 1.25)
    inst:AddTag("ignorewalkableplatforms")
	inst:SetPrefabNameOverride("bambootree")	
	
    MakeInventoryFloatable(inst, "med", 0, {1.1, 0.9, 1.1})
    inst.components.floater.bob_percent = 0

    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)	

	inst:AddTag("machetecut")
	inst:AddTag("bambootree")
	inst:AddTag("plant")	
    inst:AddTag("ignorewalkableplatforms")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)

	inst:AddComponent("interactions")	
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
	
	inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HACK)
    inst.components.workable:SetOnFinishCallback(dig_up)
    inst.components.workable:SetWorkLeft(6)
	inst.components.workable.onwork = onhackedfn

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    MakeHauntableIgnite(inst)	
	
	inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	
    inst:ListenForEvent("on_collide", OnCollide)	

    return inst
end

local function fn3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("bambootree.png" )

    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:SetBank("bambootree")
	inst.AnimState:SetBuild("bambootree_build")
	inst.AnimState:PlayAnimation("idle",true)
	inst.Transform:SetScale(1, 1.8, 1)
	
    inst:SetPhysicsRadiusOverride(1.8)
    MakeWaterObstaclePhysics(inst, 0.35, 2, 1.25)
    inst:AddTag("ignorewalkableplatforms")	
	inst:SetPrefabNameOverride("bambootreebig")
	
    MakeInventoryFloatable(inst, "med",  0, {1.1, 0.6, 1.1})
    inst.components.floater.bob_percent = 0

    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)	
	
	inst:AddTag("machetecut")
	inst:AddTag("bambootree")
	inst:AddTag("plant")	
    inst:AddTag("ignorewalkableplatforms")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)

	inst:AddComponent("interactions")	
    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
	
	inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HACK)
    inst.components.workable:SetOnFinishCallback(dig_up2)
    inst.components.workable:SetWorkLeft(6)
	inst.components.workable.onwork = onhackedfn

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    MakeHauntableIgnite(inst)		
	
	inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	
    inst:ListenForEvent("on_collide", OnCollide)	

    return inst
end

return Prefab("bambootree", fn, assets, prefabs),
	   Prefab("bambootreebig", fn1, assets, prefabs),
	   Prefab("oceanbambootree", fn2, assets, prefabs),
	   Prefab("oceanbambootreebig", fn3, assets, prefabs) 	   