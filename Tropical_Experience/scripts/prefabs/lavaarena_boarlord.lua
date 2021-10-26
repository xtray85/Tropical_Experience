
local assets =
{
    Asset("ANIM", "anim/boarlord.zip"),
    Asset("ANIM", "anim/lavaarena_boarlord_dialogue.zip"),
}

--[[
idle
laugh2 (bate no escudo com ele aberto)
laugh_pre 
laugh_loop (bate no escudo com ele fechado)
laugh_pst
sleep_pre
sleep_loop (dorme)
sleep_pst
yell_pre 
yell_loop (levanta e sacode a arma icitando briga)
yell_pst
]]

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 2, .5)

	local minimap = inst.entity:AddMiniMapEntity()
--	minimap:SetIcon("minimap_octopusking.png")
    inst.MiniMapEntity:SetPriority(1)

    inst.DynamicShadow:SetSize(10, 5)

    inst:AddTag("king")
    inst.AnimState:SetBank("boarlord")
    inst.AnimState:SetBuild("boarlord")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("antlion_sinkhole_blocker")

    inst:AddComponent("talker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	inst:AddComponent("store")

    return inst
end

return Prefab("lavaarena_boarlord", fn, assets, prefabs)

