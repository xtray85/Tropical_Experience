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
	"turbine_blades",
}
local TARGET_DIST = 60

--local function OnEntitySleep(inst)
--    if inst.shouldGoAway then
--        inst:Remove()
--    end
--end

local function CalcSanityAura(inst, observer)
    if inst.components.combat.target then
        return -TUNING.SANITYAURA_HUGE
    end

    return -TUNING.SANITYAURA_LARGE
end

local function RetargetFn(inst)
    return FindEntity(inst, TARGET_DIST, function(guy)
        return inst.components.combat:CanTarget(guy)
    end, nil, {"prey", "smallcreature", "deer2"})
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target) 
		and target:GetDistanceSqToPoint(inst.components.knownlocations:GetLocation("spawnpoint")) < 20 * 20
end

local function OnSave(inst, data)
    data.CanVacuum = inst.CanVacuum
    data.CanCharge = inst.CanCharge
--    data.shouldGoAway = inst.shouldGoAway
	data.entrada = inst.entrada
end

local function OnLoad(inst, data)
    if data then
        inst.CanVacuum = data.CanVacuum
        inst.CanCharge = data.CanCharge
--        inst.shouldGoAway = data.shouldGoAway or false
    end
	if data == nil then return end
	if data.entrada then inst.entrada = data.entrada end
end

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

--local function OnKill(inst, data)
--    if data and data.victim == ThePlayer then
--        inst.shouldGoAway = true
--    end
--end
local function ItemsMain(inst)
local x, y, z = inst.Transform:GetWorldPosition()
inst.Transform:SetPosition(x, 0, z)
end
local function FlameMain(inst)
local x, y, z = inst.Transform:GetWorldPosition()
if inst.flame1:IsValid() then
inst.flame1.Transform:SetPosition(x, 4, z)
end
if inst.flame2:IsValid() then
inst.flame2.Transform:SetPosition(x, 2, z)
end
if inst.flame3:IsValid() then
inst.flame3.Transform:SetPosition(x, .1, z)
end
end
local function DestroyMain(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
		for i, v in ipairs(TheSim:FindEntities(x, 0, z, 2, nil, {}, { "CHOP_workable"})) do
		if v.components.workable then v.components.workable:Destroy(inst) end
	end
	for i, v in ipairs(TheSim:FindEntities(x, 0, z, 3, nil, {}, {"MINE_workable" })) do
		if v.components.workable then v.components.workable:Destroy(inst) end
	end
end
local function d(inst)
if inst.ItemsMain ~= nil then
	inst.ItemsMain:Cancel()
end
if inst.DestroyMain ~= nil then
	inst.DestroyMain:Cancel()
end
inst.DestroyMain = inst:DoPeriodicTask(0,DestroyMain)
inst.ItemsMain = inst:DoPeriodicTask(0,ItemsMain)
end
local function f(inst)
if inst.FlameMain ~= nil then
	inst.FlameMain:Cancel()
end
inst.FlameMain = inst:DoPeriodicTask(0,FlameMain)
end
local function PushMusic(inst, level)
    if ThePlayer == nil then
        inst._playingmusic = false
    elseif ThePlayer:IsNear(inst, inst._playingmusic and 30 or 20) then
        inst._playingmusic = true
		ThePlayer:PushEvent("triggeredevent", {name = "toadstool"  })
    elseif inst._playingmusic and not ThePlayer:IsNear(inst, 40) then
        inst._playingmusic = false
    end
end
local function validatesack(inst)
end
local function OnInit(inst)
    inst.OnEntityWake = validatesack
    inst.OnEntitySleep = validatesack
    if inst:IsAsleep() then
        validatesack(inst)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	local shadow = inst.entity:AddDynamicShadow()
	inst.entity:AddLight()
	inst.Light:SetRadius(.5)
	inst.Light:SetFalloff(0.5)
	inst.Light:SetIntensity(0.75)
	inst.Light:SetColour(235/255, 121/255, 12/255)
	shadow:SetSize(6, 3.5)
    inst.d = d(inst)
    inst.Transform:SetFourFaced()
    
    local s = 1
    trans:SetScale(s,s,s)

    local physics = inst.entity:AddPhysics()
    physics:SetMass(1000)
    physics:SetCapsule(1.5, 1)
    physics:SetFriction(0)
    physics:SetDamping(5)

    anim:SetBank("twister")
    anim:SetBuild("twister_build")
    anim:PlayAnimation("idle_loop", true)
	
	inst.AnimState:SetMultColour(255/255, 150/255, 0/255, 1)
--  inst.AnimState:OverrideMultColour(255/255, 0, 0, 0.5)	
	
    inst._playingmusic = false
    inst:DoPeriodicTask(1, PushMusic, 0)
    -------------------

    inst:AddTag("amphibious")
	inst:AddTag("epic")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("twister")
    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")
	
    inst.entity:AddLight()
    inst.Light:SetFalloff(0.4)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(4)
    inst.Light:SetColour(249/255, 130/255, 117/255)
    inst.Light:Enable(true)		

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
    inst.components.health:SetMaxHealth(3500)
    inst.components.health.destroytime = 5
    
    ------------------
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(30)
    inst.components.combat.playerdamagepercent = .9
    inst.components.combat:SetRange(6, 12)
    inst.components.combat:SetAreaDamage(6, 0.8)
    inst.components.combat:SetAttackPeriod(3)
    inst.components.combat:SetRetargetFunction(.33, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    --inst.components.combat:SetHurtSound("")
 
    ------------------

    inst:AddComponent("lootdropper")
    
    ------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    ------------------

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 5
    inst.components.locomotor.runspeed = 13
    inst.components.locomotor:SetShouldRun(true)

    ------------------
    
    inst:SetStateGraph("SGfiretwister")
    local brain = require("brains/firetwisterbrain")
    inst:SetBrain(brain)

    ------------------

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("entitysleep", OnEntitySleep)
    inst:ListenForEvent("timerdone", ontimerdone)
--    inst:ListenForEvent("killed", OnKill)

    ------------------

	inst:DoTaskInTime(0, OnInit)

 --   inst.despawnday = TheWorld.state.cycles + TheWorld.state.winterlength

    TheWorld:PushEvent("ms_registertwister", inst)
		
    inst.CanVacuum = true
    inst.CanCharge = true
--    inst.shouldGoAway = false
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    --inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/twister_active", "wind_loop")
    inst.SoundEmitter:SetParameter("wind_loop", "intensity", 0)
    inst.AnimState:Hide("twister_water_fx")
	inst.flame1 = SpawnPrefab("deer_fire_flakes")
	inst:DoTaskInTime(.1, function(inst)
	inst.flame2 = SpawnPrefab("deer_fire_flakes")
	inst:DoTaskInTime(.1, function(inst)
	inst.flame3 = SpawnPrefab("deer_fire_flakes")
	inst.f = f(inst)
	end) end)
    ------------------

    return inst
end

return Prefab( "common/monsters/firetwister", fn, assets, prefabs)