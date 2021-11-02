local assets = {
    Asset("ANIM", "anim/buff_fx.zip"),
}

local function sign()
	return math.random(0,1) == 1 and 1 or -1
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    MakeCharacterPhysics(inst, 0, .1)
    RemovePhysicsColliders(inst)

	inst.AnimState:SetBank("buff_fx")
    inst.AnimState:SetBuild("buff_fx")
    inst.AnimState:PlayAnimation("positive")
    inst.AnimState:SetMultColour(0.75, 0.75, 0.75, 0.75)
    
	--inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_despawn")
	
    inst.Transform:SetFourFaced()
    local scale = 1.5 + math.random()
	inst.Transform:SetScale(scale, scale, scale) --width,height,thiccccness
	
    inst:AddTag("FX")
	inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst.entity:SetCanSleep(false)
    inst.persists = false
    inst.anim = function(inst, anim, icon, delta) 
        if anim then
            inst.AnimState:PlayAnimation(anim) 
        end
        if icon and type(icon) == "table" then
            inst.AnimState:OverrideSymbol("heart", icon.build, icon.symbol)
        end
        if delta and type(delta) == "table" then
            inst.AnimState:OverrideSymbol("arrow", delta.build, delta.symbol)
        end
    end
    
    inst.Transform:SetPosition(sign() * (math.random()/2), 0.5 + math.random(), sign() * (math.random()/2))

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

return Prefab("buff_fx", fn, assets)