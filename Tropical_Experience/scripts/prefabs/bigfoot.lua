require "stategraphs/SGbigfoot"

local assets = {
	Asset("ANIM", "anim/foot_basic.zip"),
	Asset("ANIM", "anim/foot_build.zip"),
	Asset("ANIM", "anim/foot_print.zip"),
	Asset("ANIM", "anim/foot_shadow.zip"),
}

local prefabs = {
	"groundpound_fx",
	"groundpoundring_fx",
}

local ShadowWarnTime = 2

local function DoStep(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/glommer/foot_ground")
	--ShakeAllCameras(CAMERASHAKE.VERTICAL, 0.5, 0.03, 2, inst, 40)
	for i, v in ipairs(AllPlayers) do
		v:ShakeCamera(CAMERASHAKE.VERTICAL, 0.5, 0.03, 2, inst, 40)
	end
	inst.components.groundpounder:GroundPound()
	inst:SpawnPrint()
	TheWorld:PushEvent("bigfootstep")
end

local function roundToNearest(numToRound, multiple)
	local half = multiple / 2
	return numToRound + half - (numToRound + half) % multiple
end

local function GetRotation(inst)
	local rotationTranslation = {
		["0"] = 180, -- "right"
		["1"] = 135, -- "up"
		["2"] = 0, -- "left"
		["3"] = -135, --"down"
	}
	local cameraVec = TheCamera:GetDownVec()
	local cameraAngle =  math.atan2(cameraVec.z, cameraVec.x)
	cameraAngle = cameraAngle * (180 / math.pi)
	cameraAngle = roundToNearest(cameraAngle, 45)
	local rot = inst.AnimState:GetCurrentFacing()
	return rotationTranslation[tostring(rot)] - cameraAngle
end

local function SpawnPrint(inst)
	local footprint = SpawnPrefab("bigfootprint")
	footprint.Transform:SetPosition(inst:GetPosition():Get())
	footprint.Transform:SetRotation(GetRotation(inst))
end

local function SimulateStep(inst)
	inst:DoTaskInTime(ShadowWarnTime, function(inst) 
		inst:DoStep()
		inst:Remove()
	end)
end

local function StartStep(inst)
	local shadow = SpawnPrefab("bigfootshadow")
	shadow.Transform:SetPosition(inst:GetPosition():Get())
	shadow.Transform:SetRotation(GetRotation(inst))
	inst:Hide()
	inst:DoTaskInTime(ShadowWarnTime - (5 * FRAMES), function(inst) inst.sg:GoToState("stomp") end)
end

local function foot_fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.Transform:SetFourFaced()

	inst.AnimState:SetBank("foot")
	inst.AnimState:SetBuild("foot_build")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(2000)

	inst:AddComponent("groundpounder")
	inst.components.groundpounder.destroyer = true

	inst:AddComponent("inspectable")

	inst:SetStateGraph("SGbigfoot")

	inst.SpawnPrint = SpawnPrint
	inst.DoStep = DoStep
	inst.SimulateStep = SimulateStep -- For really far away steps.

	inst.StartStep = StartStep

	return inst
end

local function footprint_fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("foot_print")
	inst.AnimState:SetBuild("foot_print")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(3)

	inst.Transform:SetRotation(0)

	inst:AddTag("scarytoprey")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, 15, function(inst) inst:Remove() end)

	inst.persists = false

	return inst
end

local easing = require("easing")

local function LerpOut(inst)
	local timeToLeave = 1.33
	if not inst.sizeTask then
		inst.LeaveTime = inst:GetTimeAlive() + timeToLeave
		inst.sizeTask = inst:DoPeriodicTask(FRAMES, LerpOut)
		inst.components.colourtweener:StartTween({0, 0, 0, 0}, timeToLeave, function() inst:Remove() end)
	end
	local t = timeToLeave - (inst.LeaveTime - inst:GetTimeAlive())
	local s = easing.outCirc(t, 1, inst.StartingScale - 1, timeToLeave)
	inst.Transform:SetScale(s, s, s)
end

local function LerpIn(inst)
	local s = easing.inExpo(inst:GetTimeAlive(), inst.StartingScale, 1 - inst.StartingScale, inst.TimeToImpact)
	inst.Transform:SetScale(s, s, s)
	if s <= 1 then
		inst.sizeTask:Cancel()
		inst.sizeTask = nil
	end
end

local function shadow_fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("foot_shadow")
	inst.AnimState:SetBuild("foot_shadow")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(3)
	inst.AnimState:SetMultColour(0, 0, 0, 0)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst.persists = false

	local s = 2
	inst.StartingScale = s
	inst.Transform:SetScale(s, s, s)
	inst.TimeToImpact = ShadowWarnTime

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0, 0, 0, 1}, inst.TimeToImpact, function() inst:DoTaskInTime(45*FRAMES, LerpOut) end)

	inst.sizeTask = inst:DoPeriodicTask(FRAMES, LerpIn)

	return inst
end

return Prefab("common/bigfoot", foot_fn, assets, prefabs), Prefab("common/bigfootprint", footprint_fn, assets, prefabs), Prefab("common/bigfootshadow", shadow_fn, assets, prefabs)
