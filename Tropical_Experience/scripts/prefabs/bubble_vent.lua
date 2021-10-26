local assets=
{
	Asset("ANIM", "anim/vent.zip"),
}

local function onsave(inst, data)
	data.anim = inst.animname
end

local function onload(inst, data)
    if data and data.anim then
        inst.animname = data.anim
	    inst.AnimState:PlayAnimation(inst.animname)
	end
end

local function OnEntityWake(inst)
	inst.components.bubbleblower:Start()	
end

local function OnEntitySleep(inst)
	inst.components.bubbleblower:Stop()
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddNetwork()	
	
	local minimap = inst.entity:AddMiniMapEntity()
	inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("vent.tex")
	
	inst.entity:AddAnimState()
	inst.AnimState:SetBank("air_vent")
	inst.AnimState:SetBuild("vent")
	inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetRayTestOnBB(true);
	
	inst.Transform:SetScale(0.5, 0.5, 0.5)
  
    inst:AddTag("vent")
	inst:AddTag("underwater")

	inst:AddComponent("bubbleblower")
	inst.components.bubbleblower:SetXZOffset(30)
	inst.components.bubbleblower:SetYOffset(40)
    inst.components.bubbleblower:SetBubbleRate(5)
	
	inst:AddComponent("oxygenaura")
	inst.components.oxygenaura:SetAura(UW_TUNING.GEOTHERMAL_VENT_AIR*0.5)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep	
	
    return inst
end

return Prefab( "underwater/objects/bubble_vent", fn, assets) 
