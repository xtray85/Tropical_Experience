
require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/icemachine.zip"),
	--Asset("MINIMAP_IMAGE", "icemachine"),
}

local prefabs =
{
	"collapse_small",
	"ice",
}

local MACHINESTATES =
{
	ON = "_on",
	OFF = "_off",
}

local seg_time = 30
local ICEMAKER_SPAWN_TIME = seg_time
local ICEMAKER_FUEL_MAX = seg_time * 3

local function spawnice(inst)
	inst:RemoveEventCallback("animover", spawnice)

    local ice = SpawnPrefab("ice")
    local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,2,0)
    ice.Transform:SetPosition(pt:Get())
    local down = TheCamera:GetDownVec()
    local angle = math.atan2(down.z, down.x) + (math.random()*60)*DEGREES
    local sp = 3 + math.random()
    ice.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, sp*math.sin(angle))
   -- ice.components.inventoryitem:OnStartFalling()

    --Machine should only ever be on after spawning an ice
	inst.components.fueled:StartConsuming()
	inst.AnimState:PlayAnimation("idle_on", true)
end


local function onhammered(inst, worked)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")

	inst:Remove()
end

local function fueltaskfn(inst)
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
local fx = SpawnPrefab("shock_machines_fx")
if fx then local pt = inst:GetPosition() fx.Transform:SetPosition(pt.x, pt.y, pt.z) end 
if inst.SoundEmitter then inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_water") end
return 
end
	inst.AnimState:PlayAnimation("use")
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/icemachine_start")
	inst.components.fueled:StopConsuming() --temp pause fuel so we don't run out in the animation.
	inst:ListenForEvent("animover", spawnice)
end

local function ontakefuelfn(inst)
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
local fx = SpawnPrefab("shock_machines_fx")
if fx then local pt = inst:GetPosition() fx.Transform:SetPosition(pt.x, pt.y, pt.z) end 
if inst.SoundEmitter then inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/jellyfish/electric_water") end 
end
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/machine_fuel")
	inst.components.fueled:StartConsuming()
end

local function fuelupdatefn(inst, dt)
	-- TODO: summer season rate adjustment?
	inst.components.fueled.rate = 1
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit"..inst.machinestate)
	inst.AnimState:PushAnimation("idle"..inst.machinestate, true)
	inst:RemoveEventCallback("animover", spawnice)
	if inst.machinestate == MACHINESTATES.ON then
		inst.components.fueled:StartConsuming() --resume fuel consumption incase you were interrupted from fueltaskfn
	end
end

local function fuelsectioncallback(new, old, inst)
	if new == 0 and old > 0 then
		inst.machinestate = MACHINESTATES.OFF
		inst.AnimState:PlayAnimation("turn"..inst.machinestate)
		inst.AnimState:PushAnimation("idle"..inst.machinestate, true)
		inst.SoundEmitter:KillSound("loop")
		if inst.fueltask ~= nil then
			inst.fueltask:Cancel()
			inst.fueltask = nil
		end
	elseif new > 0 and old == 0 then
		inst.machinestate = MACHINESTATES.ON
		inst.AnimState:PlayAnimation("turn"..inst.machinestate)
		inst.AnimState:PushAnimation("idle"..inst.machinestate, true)
		if not inst.SoundEmitter:PlayingSound("loop") then
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/icemachine_lp", "loop")
		end
		if inst.fueltask == nil then
			inst.fueltask = inst:DoPeriodicTask(ICEMAKER_SPAWN_TIME, fueltaskfn)
		end
	end
end

local function getstatus(inst)
	local sec = inst.components.fueled:GetCurrentSection()
	if sec == 0 then
		return "OUT"
	elseif sec <= 4 then
		local t = {"VERYLOW","LOW","NORMAL","HIGH"}
		return t[sec]
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle"..inst.machinestate)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/icemaker_place")
end

--local function onFloodedStart(inst)
--	if inst.components.fueled then 
--		inst.components.fueled.accepting = false
--	end 
--end 

--local function onFloodedEnd(inst)
--	if inst.components.fueled then 
--		inst.components.fueled.accepting = true
----	end 
--end 

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddNetwork()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "icemachine.png" )

	inst.AnimState:SetBank("icemachine")
	inst.AnimState:SetBuild("icemachine")

	MakeObstaclePhysics(inst, .4)

    inst:AddTag("structure")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("lootdropper")

	inst:AddComponent("fueled")
	inst.components.fueled.maxfuel = ICEMAKER_FUEL_MAX
	inst.components.fueled.accepting = true
	inst.components.fueled:SetSections(4)
	inst.components.fueled.ontakefuelfn = ontakefuelfn
	inst.components.fueled:SetUpdateFn(fuelupdatefn)
	inst.components.fueled:SetSectionCallback(fuelsectioncallback)
	inst.components.fueled:InitializeFuelLevel(ICEMAKER_FUEL_MAX/2)
	inst.components.fueled:StartConsuming()

	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)

	--inst:AddComponent("floodable")
--	inst.components.floodable.onStartFlooded = onFloodedStart
	--inst.components.floodable.onStopFlooded = onFloodedEnd
--	--inst.components.floodable.floodEffect = "shock_machines_fx"
	--inst.components.floodable.floodSound = "dontstarve_DLC002/creatures/jellyfish/electric_land"

	inst.machinestate = MACHINESTATES.ON
	inst:ListenForEvent( "onbuilt", onbuilt)

	return inst
end

return Prefab( "common/objects/icemaker", fn, assets, prefabs),
		MakePlacer( "common/icemaker_placer", "icemachine", "icemachine", "idle_off" )
