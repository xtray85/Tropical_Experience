local assets=
{
	Asset("ANIM", "anim/geyser.zip"),
}

local seg_time = 30
local FLAMEGEYSER_SPAWN_CHANCE = 0.5
local FLAMEGEYSER_FUEL_MAX = seg_time*0.5
local FLAMEGEYSER_FUEL_START = seg_time*0.5
local FLAMEGEYSER_REIGNITE_TIME = seg_time
local FLAMEGEYSER_REIGNITE_TIME_VARIANCE = seg_time*0.5

local function OnBurn(inst)
    inst.components.fueled:StartConsuming()
    inst.components.propagator:StartSpreading()
    inst:AddComponent("cooker")
end

local function StartBurning(inst)
    inst.Light:Enable(true)

end

local function OnIgnite(inst)
	inst:DoTaskInTime(5*FRAMES, function(inst)	
	inst.Light:SetRadius(1)
 end)
 
 	inst:DoTaskInTime(30*FRAMES, function(inst)	
	inst.Light:SetRadius(4)
 end)
 
    StartBurning(inst)
    inst.components.fueled:SetPercent(1.0)
    OnBurn(inst)

	inst.sg:GoToState("active_pre")	

	
end

local function SetIgniteTimer(inst)
    inst:DoTaskInTime(GetRandomWithVariance(FLAMEGEYSER_REIGNITE_TIME, FLAMEGEYSER_REIGNITE_TIME_VARIANCE), function()
            inst.components.fueled:SetPercent(1.0)
            OnIgnite(inst)
    end)
end

local function OnErupt(inst)
    StartBurning(inst)
    inst.components.fueled:SetPercent(1.0)
    OnBurn(inst)
    TheCamera:Shake("FULL", 0.7, 0.02, 0.75)
end

local function OnExtinguish(inst, setTimer)
    if setTimer == nil then 
        setTimer = true
    end 
    inst.AnimState:ClearBloomEffectHandle()
    inst.components.fueled:StopConsuming()
    inst.components.propagator:StopSpreading()

	inst.sg:GoToState("flamegeyser_out_pre")	

    if inst.components.cooker then 
        inst:RemoveComponent("cooker")
    end 
	
    if setTimer then 
        SetIgniteTimer(inst)
    end 
end

local function OnIdle(inst)
    inst.AnimState:PlayAnimation("idle_dormant", true)
    inst.Light:Enable(false)
end

local function OnLoad(inst, data)
--    if not inst.components.fueled:IsEmpty() then
--        OnIgnite(inst)
--    else
        SetIgniteTimer(inst)
--    end
end

local heats = { 70, 85, 100, 115 }
local function GetHeatFn(inst)
    return 100 --heats[inst.components.geyserfx.level] or 20
end

local function TakeLightSteps(light, value)
	local function LightToggle(light)
		light.level = (light.level or 0) + value
		if (value > 0 and light.level <= 1) or (value < 0 and light.level > 0) then
			light.Light:SetRadius(light.level)
			light.lighttoggle = light:DoTaskInTime(2 * FRAMES, LightToggle)
		elseif value < 0 then
			light.Light:Enable(false)
			light:Hide()
		end
		light.AnimState:SetScale(light.level, 1)
	end
	if light.lighttoggle ~= nil then
		light.lighttoggle:Cancel()
	end
	light.lighttoggle = light:DoTaskInTime(2 * FRAMES, LightToggle)
end

local function fn(Sim)
	local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local light = inst.entity:AddLight()
    local sound = inst.entity:AddSoundEmitter()
    local minimap = inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()
  	
	inst.Light:SetRadius(4)
	inst.Light:SetIntensity(0.8)
	inst.Light:SetFalloff(0.3)
	inst.Light:SetColour(255, 100, 100)
	inst.Light:Enable(true)
	
	
    MakeObstaclePhysics(inst, 2.05)
    inst.Physics:SetCollides(false)

	minimap:SetIcon("geyser.png")
    anim:SetBank("geyser")
    anim:SetBuild("geyser")
    anim:PlayAnimation("idle_dormant", true)
    anim:SetBloomEffectHandle( "shaders/anim.ksh" )

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	inst:SetStateGraph("SGflamegeyser")
    inst:AddComponent("inspectable")
    inst:AddComponent("heater")
    inst.components.heater.heatfn = GetHeatFn

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = FLAMEGEYSER_FUEL_MAX
    inst.components.fueled.accepting = false
    inst:AddComponent("propagator")
    inst.components.propagator.damagerange = 2
    inst.components.propagator.damages = true

    inst.components.fueled:SetSections(4)
    inst.components.fueled.rate = 1
    inst.components.fueled.period = 1

        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            OnExtinguish(inst)
        else
            local damagerange = {2,2,2,2}
            local ranges = {2,2,2,4}
            local output = {4,10,20,40}
            inst.components.propagator.damagerange = damagerange[section]
            inst.components.propagator.propagaterange = ranges[section]
            inst.components.propagator.heatoutput = output[section]
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(FLAMEGEYSER_FUEL_START)


    if not inst.components.fueled:IsEmpty() then
        OnIgnite(inst)
    end
    
	
    inst.OnIgnite = OnIgnite
    inst.OnErupt = OnErupt
    inst.OnBurn = OnBurn
    inst.OnIdle = OnIdle

    return inst
end

return Prefab( "flamegeyser", fn, assets)