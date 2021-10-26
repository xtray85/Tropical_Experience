local assets=
{
	Asset("ANIM", "anim/bush_vine.zip"),
}

local prefabs =
{
    "vine",
    "dug_bush_vine",
	"hacking_fx",
}

local respawndays = 2  --tempo para renascer em dias

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
    inst.AnimState:PlayAnimation("grow")
--    inst.AnimState:PushAnimation("sway", true)
	inst.AnimState:PushAnimation("idle",true)
	inst:AddTag("machetecut")
    inst.components.workable:SetWorkLeft(6)
	inst.components.workable:SetWorkAction(ACTIONS.HACK)
	if inst.prefab ~= "oceanbush_vine" then 	
	MakeObstaclePhysics(inst, 0.35)
	end
    end
end


local function dig_up(inst, worker)

if inst:HasTag("machetecut") then
inst:RemoveTag("machetecut")
inst.components.workable:SetWorkAction(ACTIONS.DIG)
inst.components.workable:SetWorkLeft(1)
inst.components.lootdropper:SpawnLootPrefab("vine")
inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)


return 
end


	if not inst:HasTag("machetecut") then
		if inst.components.lootdropper ~= nil then
			inst.components.lootdropper:SpawnLootPrefab("dug_bush_vine")
		end
		inst:Remove()
	end

end

local function onhackedfn(inst, hacker, hacksleft)
if not inst:HasTag("machetecut") then return end
	local fx = SpawnPrefab("hacking_fx")
    local x, y, z= inst.Transform:GetWorldPosition()
    fx.Transform:SetPosition(x,y + math.random()*2,z)

	if(hacksleft <= 0) then

		inst.AnimState:PlayAnimation("disappear")
		inst.AnimState:PushAnimation("hacked_idle")
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/vine_drop")
	if inst.prefab ~= "oceanbush_vine" then 		
		RemovePhysicsColliders(inst)
	end	
	else

		inst.AnimState:PlayAnimation("chop")
		inst.AnimState:PushAnimation("idle")
	end
	
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/vine_hack")
end


local function OnSave(inst, data)
if not inst:HasTag("machetecut") then
    data.tag = 1
end
end

local function OnLoad(inst, data)
    if data and data.tag == 1 then
				inst.AnimState:PlayAnimation("hacked_idle")				
				inst:RemoveTag("machetecut")
				inst.components.workable:SetWorkAction(ACTIONS.DIG)
				inst.components.workable:SetWorkLeft(1)
				if inst.prefab ~= "oceanbush_vine" then 
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

    inst.MiniMapEntity:SetIcon("bushVine.png" )

    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:SetBank("bush_vine")
	inst.AnimState:SetBuild("bush_vine")
	inst.AnimState:PlayAnimation("idle",true)
	--MakeObstaclePhysics(inst, 0.35)
	MakeSmallObstaclePhysics(inst, .1)

	inst:AddTag("machetecut")
	inst:AddTag("plant")	

    inst:AddTag("bush_vine")

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

local DAMAGE_SCALE = 0.5
local function OnCollide(inst, data)
    local boat_physics = data.other.components.boatphysics
    if boat_physics ~= nil then
        local hit_velocity = math.floor(math.abs(boat_physics:GetVelocity() * data.hit_dot_velocity) * DAMAGE_SCALE / boat_physics.max_velocity + 0.5)
        inst.components.workable:WorkedBy(data.other, hit_velocity * TUNING.SEASTACK_MINE)
    end
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("bushVine.png" )

    inst.AnimState:SetRayTestOnBB(true)
	inst.AnimState:SetBank("bush_vine")
	inst.AnimState:SetBuild("bush_vine")
	inst.AnimState:PlayAnimation("idle",true)

	inst:AddTag("machetecut")
	inst:AddTag("plant")	

    inst:AddTag("bush_vine")
    inst:AddTag("ignorewalkableplatforms")		
	
    inst:SetPhysicsRadiusOverride(1.8)
    MakeWaterObstaclePhysics(inst, 0.35, 2, 1.25)
    inst:AddTag("ignorewalkableplatforms")	
	inst:SetPrefabNameOverride("bush_vine")
	
    MakeInventoryFloatable(inst, "med",  0, {1.1, 0.6, 1.1})
    inst.components.floater.bob_percent = 0	
	
    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)	

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

return Prefab("bush_vine", fn, assets, prefabs),
	   Prefab("oceanbush_vine", fn1, assets, prefabs)