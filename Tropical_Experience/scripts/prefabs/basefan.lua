local assets =
{
	Asset("ANIM", "anim/basefan.zip"),
	Asset("ANIM", "anim/sprinkler_placement.zip"),
	Asset("INV_IMAGE", "basefan"),
}

local prefabs =
{

}

local function ontimerdone(inst, data)
    if data.name == "Reload" then
        inst.canFire = true
    end
end

local function TurnOff(inst, instant)
	inst.on = false
	inst.components.fueled:StopConsuming()
	inst:RemoveTag("prevents_hayfever")
	inst:RemoveTag("blows_air")

	if instant then
		inst.sg:GoToState("idle_off")
	else
		inst.sg:GoToState("turn_off")
	end
end

local function TurnOn(inst, instant)
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
local fx = SpawnPrefab("shock_machines_fx")
if fx then local pt = inst:GetPosition() fx.Transform:SetPosition(pt.x, pt.y, pt.z) end 

inst.on = false
return 
end
	inst.on = true
	local randomizedStartTime = POPULATING
	inst.components.fueled:StartConsuming()
	inst:AddTag("prevents_hayfever")
--	inst:AddTag("blows_air")


	if instant then
		inst.sg:GoToState("idle_on")
	else
		inst.sg:GoToState("turn_on")
	end
end

local function OnFuelEmpty(inst)
	inst.components.machine:TurnOff()
end

local function OnFuelSectionChange(old, new, inst)
	local fuelAnim = inst.components.fueled:GetCurrentSection()
	inst.AnimState:OverrideSymbol("swap_meter", "firefighter_meter", fuelAnim)
end

local function CanInteract(inst)
	return not inst.components.fueled:IsEmpty() --and not inst.components.floodable.flooded 
end

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end

	inst.SoundEmitter:KillSound("idleloop")
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")

	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		if not inst.sg:HasStateTag("busy") then
			inst.sg:GoToState("hit")
		end
	end
end

local function getstatus(inst, viewer)
	if inst.on then
		if inst.components.fueled and (inst.components.fueled.currentfuel / inst.components.fueled.maxfuel) <= .25 then
			return "LOWFUEL"
		else
			return "ON"
		end
	else
		return "OFF"
	end
end

local function OnEntitySleep(inst)
    inst.SoundEmitter:KillSound("firesuppressor_idle")
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end

    data.on = inst.on
end

local function onload(inst, data)
	if data and data.burnt and inst.components.burnable and inst.components.burnable.onburnt then
        inst.components.burnable.onburnt(inst)
    end
	if data and data.on then
    inst.on = data.on
	end
end

local function OnLoadPostPass(inst, data)
	if not inst.components.fueled:IsEmpty() then
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("off")	
end

local function ontakefuelfn(inst)
local alagado = GetClosestInstWithTag("mare", inst, 10)
if alagado then
local fx = SpawnPrefab("shock_machines_fx")
if fx then local pt = inst:GetPosition() fx.Transform:SetPosition(pt.x, pt.y, pt.z) end 
inst.on = false
TurnOff(inst)
return 
end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddNetwork()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()

	local minimap = inst.entity:AddMiniMapEntity()	
	minimap:SetPriority(5)
	minimap:SetIcon("basefan.png")

	MakeObstaclePhysics(inst, 1)

	anim:SetBank("basefan")
	anim:SetBuild("basefan")
	anim:PlayAnimation("off")
	inst.on = false
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	

	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus

	inst:AddComponent("machine")
	inst.components.machine.turnonfn = TurnOn
	inst.components.machine.turnofffn = TurnOff
	inst.components.machine.caninteractfn = CanInteract
	inst.components.machine.cooldowntime = 0.5

	inst:AddComponent("fueled")
	inst.components.fueled:SetDepletedFn(OnFuelEmpty)
	inst.components.fueled.accepting = true
	inst.components.fueled:SetSections(10)
	inst.components.fueled.ontakefuelfn = ontakefuelfn
	inst.components.fueled:SetSectionCallback(OnFuelSectionChange)
	inst.components.fueled:InitializeFuelLevel(TUNING.FIRESUPPRESSOR_MAX_FUEL_TIME)
	inst.components.fueled.bonusmult = 5
	inst.components.fueled.secondaryfueltype = "CHEMICAL"

	inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", ontimerdone)

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)

	inst:SetStateGraph("SGbasefan")

	inst.OnSave = onsave
    inst.OnLoad = onload
    inst.OnLoadPostPass = OnLoadPostPass
    inst.OnEntitySleep = OnEntitySleep
	
	inst:ListenForEvent("onbuilt", onbuilt)



	return inst
end

local function OnHit(inst, dist)
	-- SpawnPrefab("splash_snow_fx").Transform:SetPosition(inst:GetPosition():Get())	
	inst:Remove()
end

require "prefabutil"

return Prefab("basefan", fn, assets, prefabs), 
MakePlacer("common/basefan_placer", "sprinkler_placement", "sprinkler_placement", "idle", true, nil, nil, 1.55)