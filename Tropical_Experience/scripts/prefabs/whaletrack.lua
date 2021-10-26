local assets =
{
	Asset("ANIM", "anim/whale_tracks.zip"),
	Asset("ANIM", "anim/whale_bubbles.zip"),
	Asset("ANIM", "anim/whale_bubble_follow.zip"),
}

local prefabs =
{
    "small_puff"
}

local AUDIO_HINT_MIN = 10
local AUDIO_HINT_MAX = 60

local function GetVerb()
    return "INVESTIGATE"
end

local function OnInvestigated(inst, doer)
    local pt = Vector3(inst.Transform:GetWorldPosition())
    --print("dirtpile - OnInvestigated", pt)

    local hunter = TheWorld.components.whalehunter
    if hunter ~= nil then
        hunter:OnDirtInvestigated(pt, doer)
    end

	inst.AnimState:PlayAnimation("bubble_pst")
    inst:ListenForEvent("animover", inst.Remove)
end

local function addbubblefx(inst)
	local fx = SpawnPrefab("whale_bubbles_fx")
	fx.entity:SetParent(inst.entity)
    fx.AnimState:SetTime(math.random())
	local offset = Vector3(math.random(-1, 1) * math.random(), 0, math.random(-1, 1) * math.random())
	fx.Transform:SetPosition(offset:Get())
end

local function bubblefn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst:AddTag("dirtpile")

	inst.AnimState:SetBank("whaletrack")
	inst.AnimState:SetBuild("whale_tracks")
	inst.AnimState:PlayAnimation("bubble_pre")
	inst.AnimState:PushAnimation("bubble_loop", true)
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )	
	
	inst:SetPhysicsRadiusOverride(2)	

    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/whale_bubble_trail/whale_trail_discovery_LP", "whale_trail_discovery_LP")
	
	local numbubbles = math.random(2, 4)

	for i = 0, numbubbles do
		addbubblefx(inst)
	end	

    inst.GetActivateVerb = GetVerb

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    --inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("activatable")    

    --set required
    inst.components.activatable.OnActivate = OnInvestigated
    inst.components.activatable.inactive = true

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        OnInvestigated(inst, haunter)
        return true
    end)

    --inst:DoTaskInTime(1, OnAudioHint)

    inst.persists = false
    return inst
end

local function commonfn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddPhysics()
	inst.entity:AddSoundEmitter()

	MakeInventoryPhysics(inst)

	return inst
end

local function trackfn()
	local inst = commonfn()

	inst:AddTag("track")

	inst.AnimState:SetBank("whalebubblefollow")
	inst.AnimState:SetBuild("whale_bubble_follow")
	inst.AnimState:PlayAnimation("bubblepop")

	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/whale_bubble_trail/whale_trail_bubble_pop")

    inst:ListenForEvent("animover", inst.Remove)

	inst:AddTag("FX")
	inst:AddTag("NOCLICK")

    inst.persists = false

	return inst
end

local function fxfn()
	local inst = commonfn()

	inst.AnimState:SetBank("whalebubbles")
	inst.AnimState:SetBuild("whale_bubbles")
	inst.AnimState:PlayAnimation("bubble_loop", true)

	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/whale_bubble_trail/whale_trail_discovery_LP", "whale_trail_discovery_LP")

	inst.persists = false

	inst:AddTag("FX")
	inst:AddTag("NOCLICK")

	return inst
end

return Prefab( "ocean/objects/whale_bubbles", bubblefn, assets, prefabs),
Prefab("ocean/fx/whale_bubbles_fx", fxfn, assets, prefabs),
Prefab("ocean/objects/whale_track", trackfn, assets, prefabs)