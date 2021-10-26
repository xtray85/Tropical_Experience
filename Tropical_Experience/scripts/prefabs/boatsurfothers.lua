local assets =
{
    Asset("ANIM", "anim/raft_basic.zip"),
	Asset("ANIM", "anim/raft_surfboard_build.zip"),
	Asset("ANIM", "anim/raft_build.zip"),
	Asset("ANIM", "anim/raft_log_build.zip"),	
    Asset("ANIM", "anim/raft_rot.zip"),		
}

local prefabs =
{
}

local function fnsurf()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")
    inst:AddTag("DECOR")
	
	inst.AnimState:SetBank("raft")	
	inst.AnimState:SetBuild("raft_surfboard_build")
	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("run_loop", true)	


    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER.OCEAN_BOAT)
    inst.AnimState:SetFinalOffset(1)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetScale(1,1,1)	
    inst.Transform:SetRotation(0)
	
    inst:AddTag("barco")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
     
	inst:AddComponent("interactions")
	 
    inst.persists = false

    return inst
end

local function fnraft()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")
    inst:AddTag("DECOR")
	
	inst.AnimState:SetBank("raft")	
	inst.AnimState:SetBuild("raft_build")
	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("run_loop", true)	


    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER.OCEAN_BOAT)
    inst.AnimState:SetFinalOffset(1)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetScale(1,1,1)	
    inst.Transform:SetRotation(0)
	
    inst:AddTag("barco")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
     
	inst:AddComponent("interactions")
	 
    inst.persists = false

    return inst
end

local function fnlog()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")
    inst:AddTag("DECOR")
	
	inst.AnimState:SetBank("raft")	
	inst.AnimState:SetBuild("raft_log_build")
	inst.Transform:SetFourFaced()
    inst.AnimState:PlayAnimation("run_loop", true)	


    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER.OCEAN_BOAT)
    inst.AnimState:SetFinalOffset(1)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetScale(1,1,1)	
    inst.Transform:SetRotation(0)
	
    inst:AddTag("barco")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
     
	inst:AddComponent("interactions")
	 
    inst.persists = false

    return inst
end

local function fnraftrot()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")
    inst:AddTag("DECOR")
	
    inst.AnimState:SetBank("raft_rot")
    inst.AnimState:SetBuild("raft_rot")
    inst.AnimState:PlayAnimation("idle_full", true)	
    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER.OCEAN_BOAT)
	inst.AnimState:SetFinalOffset(1)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetScale(0.8,0.8,0.8)
	
    inst:AddTag("barco")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
     
	inst:AddComponent("interactions")
	 
    inst.persists = false

    return inst
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")
    inst:AddTag("DECOR")


--	inst.AnimState:SetBuild("rowboat_build")
--	inst.AnimState:SetBank("rowboat")
--	inst.Transform:SetFourFaced()
--    inst.AnimState:PlayAnimation("run_loop", true)
--    inst.AnimState:SetLayer(LAYER_BELOW_GROUND)
--	inst.AnimState:SetScale(2,2,2)
--    inst.Transform:SetRotation(0)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
 
    inst.persists = false

    return inst
end

return Prefab("boatlipsurfboard", fnsurf, assets, prefabs), 
Prefab("boatlipraft", fnraft, assets, prefabs),
Prefab("boatliplograft", fnlog, assets, prefabs),
Prefab("boatlipinvisible", fn, assets, prefabs),
Prefab("boatlipraftrot", fnraftrot, assets, prefabs)
	