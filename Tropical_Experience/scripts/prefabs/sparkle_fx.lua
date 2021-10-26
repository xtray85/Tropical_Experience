local function Hook(inst, ...)
	inst.entity:AddFollower():FollowSymbol(...)
end

local function fn()
    local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetBank("goldnugget")
    inst.AnimState:SetBuild("gold_nugget")
    inst.AnimState:PlayAnimation("sparkle")
	inst.AnimState:HideSymbol("nugget")
	
	inst:AddTag("FX")
	
    inst.entity:SetPristine()
	
	inst.Hook = Hook

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
	
	inst:ListenForEvent("animover", inst.Remove)
			
	return inst
end

return Prefab("sparkle_fx", fn)