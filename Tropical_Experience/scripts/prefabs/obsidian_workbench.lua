require "prefabutil"
require "recipe"
require "modutil"

local assets=
{
	Asset("ANIM", "anim/workbench_obsidian.zip"),
}


local function turnlightoff(inst, light)
    if light then
        light:Enable(false)
    end
end

local function OnTurnOn(inst)
    inst.components.prototyper.on = true  -- prototyper doesn't set this until after this function is called!!
    inst.AnimState:PlayAnimation("proximity_pre")
    inst.AnimState:PushAnimation("proximity_loop", true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/obsidian_workbench_LP", "loop")
    inst.Light:Enable(true)
    inst.components.lighttweener:StartTween(nil, 0, nil, nil, nil, 0.2) 
end

local function OnTurnOff(inst)
    inst.components.prototyper.on = false  -- prototyper doesn't set this until after this function is called
    inst.AnimState:PlayAnimation("proximity_pst")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:KillSound("loop")
    inst.components.lighttweener:StartTween(nil, 0, nil, nil, nil, 0.2, turnlightoff)
end

---------------------------------

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	local minimap = inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("workbench_obsidian.png")	
	
	
	
	MakeObstaclePhysics(inst, 2, 1.2)
    
	inst:AddTag("prototyper")
	inst:AddTag("altar")
    inst:AddTag("structure")
    inst:AddTag("stone")
	inst:AddTag("antlion_sinkhole_blocker")
	
	inst.AnimState:SetBank("workbench_obsidian")
	inst.AnimState:SetBuild("workbench_obsidian")
	inst.AnimState:PlayAnimation("idle")

    local light = inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:SetRadius(.6)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(1,1,1)

	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lighttweener")
    inst.components.lighttweener:StartTween(light, 1, .9, 0.9, {255/255,177/255,164/255}, 0, turnlightoff)

	inst:AddComponent("prototyper")
	inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.OBSIDIAN_TWO
	inst.components.prototyper.onturnoff = OnTurnOff
	inst.components.prototyper.onturnon = OnTurnOn
--	inst.components.prototyper.onactivate = onactivate
	
    inst:AddComponent("inspectable")
	
--	inst:DoTaskInTime(0, MakePrototyper)
	
    return inst
end

return Prefab( "obsidian_workbench", fn, assets, prefabs)