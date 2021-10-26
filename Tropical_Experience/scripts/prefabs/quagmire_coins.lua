local assets =
{
    Asset("ANIM", "anim/quagmire_coins.zip"),
}

local prefabs =
{
    "quagmire_coin_fx",
}

local function MakeCoin(id, hasfx)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("quagmire_coins")
        inst.AnimState:SetBuild("quagmire_coins")
        inst.AnimState:PlayAnimation("idle")
        if id > 1 then
            inst.AnimState:OverrideSymbol("coin01", "quagmire_coins", "coin0"..tostring(id))
            inst.AnimState:OverrideSymbol("coin_shad1", "quagmire_coins", "coin_shad"..tostring(id))
        end

        inst:AddTag("quagmire_coin")

        MakeInventoryPhysics(inst)

        inst.entity:SetPristine()

	MakeInventoryFloatable(inst)		
		
        if not TheWorld.ismastersim then
            return inst
        end

	inst:AddComponent("inspectable")	
	inst:AddComponent("tradable")
	inst:AddComponent("inventoryitem")
	inst:AddComponent("stackable")	
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM	
		
        return inst
    end

    return Prefab("quagmire_coin"..id, fn, assets, hasfx and prefabs or nil)
end

local function fxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("quagmire_coins")
    inst.AnimState:SetBuild("quagmire_coins")
    inst.AnimState:PlayAnimation("opal_loop", true)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")	
	inst:AddComponent("tradable")
	inst:AddComponent("inventoryitem")	
	
    return inst
end

return MakeCoin(1),
    MakeCoin(2),
    MakeCoin(3),
    MakeCoin(4, true),
    Prefab("quagmire_coin_fx", fxfn, assets)