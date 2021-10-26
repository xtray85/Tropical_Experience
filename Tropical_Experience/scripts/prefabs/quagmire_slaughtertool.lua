local assets =
{
    Asset("ANIM", "anim/quagmire_slaughtertool.zip"),
}

local function GetSlaughterActionString(inst, target)
    local t = GetTime()
    if target ~= inst._lasttarget or inst._lastactionstr == nil or inst._actionresettime < t then
        inst._lastactionstr = GetRandomItem(STRINGS.ACTIONS.SLAUGHTER)
        inst._lasttarget = target
    end
    inst._actionresettime = t + .1
    return inst._lastactionstr
end

local function fn()
       local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)		
		
		inst.AnimState:SetBank("quagmire_slaughtertool")
		inst.AnimState:SetBuild("quagmire_slaughtertool")
		inst.AnimState:PlayAnimation("idle")
		
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

		inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
		
		inst:AddComponent("slaughtertool")
		
	    if TheNet:GetServerGameMode() ~= "quagmire" then
        inst:AddComponent("finiteuses")
        inst.components.finiteuses:SetMaxUses(TUNING.TRAP_USES)
        inst.components.finiteuses:SetUses(TUNING.TRAP_USES)
        inst.components.finiteuses:SetOnFinished(inst.Remove)
        end	
		
		MakeHauntableLaunch(inst)
		
        return inst
end

return Prefab("quagmire_slaughtertool", fn, assets)