local assets =
{
	Asset("ANIM", "anim/nightmare_crack_ruins.zip"),
	Asset("ANIM", "anim/nightmare_crack_upper.zip"),
}

local prefabs =
{
	"nightmarelightfx",
}

local function onload(inst, data)

end

local function onsave(inst, data)

end

local function OnEntityWake(inst)
	inst.components.bubbleblower:Start()	
end

local function OnEntitySleep(inst)
	inst.components.bubbleblower:Stop()
end

local function fn()

	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "vent.tex" )
	minimap:SetPriority( 1 )

    MakeObstaclePhysics(inst, 1.2)

    anim:SetBuild("nightmare_crack_upper")
    anim:SetBank("nightmare_crack_upper")
    anim:PlayAnimation("idle_open")
	
    inst:AddComponent("lighttweener")
	inst.entity:AddLight()
	
	inst:AddComponent("bubbleblower")
	inst.components.bubbleblower:SetXZOffset(40)
	inst.components.bubbleblower:SetYOffset(60)
    inst.components.bubbleblower:SetBubbleRate(6)	
	
	inst:AddComponent("oxygenaura")
	inst.components.oxygenaura:SetAura(UW_TUNING.GEOTHERMAL_VENT_AIR)	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end			
		
	inst:AddComponent("inspectable")
	
	inst:AddComponent("cooker")
	
	inst:AddComponent("heater")
	inst.components.heater.heat = UW_TUNING.GEOTHERMAL_VENT_HEAT
	
	inst:DoTaskInTime(0, function()
		inst.components.lighttweener:StartTween(inst.Light, 3, .9, 0.9, {0.9, 0.1, 0.1}, 0)
		
		inst.fx = SpawnPrefab("upper_nightmarefissurefx")
		inst.fx.AnimState:PushAnimation("idle_open")
		local pt = inst:GetPosition()
		inst.fx.Transform:SetPosition(pt.x, -0.1, pt.z)
--		inst.fx.components.colourtweener:StartTween({0.9,0.1,0.1,0.3}, 0)
	end)		
	
    inst.OnLoad = onload
    inst.OnSave = onsave
	
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep	
	
    return inst
end

return Prefab( "underwater/objects/geothermal_vent", fn, assets, prefabs)