local assets =
{
	Asset("ANIM", "anim/modifier_orb.zip"),
}
local function OnLink(inst, rarity)
    if rarity == "mythic" and inst:HasTag("playerghost") then
        inst:PushEvent("respawnfromghost", { source = { name = "Mythicalness", components = {} } })
    end
    local items = {}
    for k,v in pairs(inst.components.inventory.itemslots) do
        if v then
            table.insert(items, v)
        end
    end
    for k,v in pairs(inst.components.inventory.equipslots) do
        if v then
            table.insert(items, v)
        end
    end
    if inst.components.inventory:GetOverflowContainer() then
        for k,v in pairs(inst.components.inventory:GetOverflowContainer().slots) do
            if v then
                table.insert(items, v)
            end
        end
    end
    local bestrarity, actualitems = GetBestPossibleRarity(items, rarity)
    if bestrarity and bestrarity ~= "bad" and bestrarity ~= "worst" and GetTableSize(actualitems) > 0 then
        local item = GetRandomItem(actualitems)
        if item and item:IsValid() and item.components.modifier then--in case we managed to magically end up here without these
            item.components.modifier:GenerateType(bestrarity)
            return
        end
    end
end

local function OnSpawn(inst, target, rarity)
    rarity = rarity or ""
    inst:SpawnChild("yellowamuletlight")
    if inst.AnimState:BuildHasSymbol("spinner_".. rarity) then
        inst.AnimState:OverrideSymbol("spinner", "modifier_orb", "spinner_"..rarity)
    end
    local x,y,z = inst.Transform:GetWorldPosition()
    local count = 0.1
    inst.risetask = inst:DoPeriodicTask(0, function()--probably better off to just do this via animation?
        inst.Transform:SetPosition(x,count,z)
        count = count + 0.3 + (count > 6 and 0.2 or 0)
        if count > 20 then
            inst.risetask:Cancel()
            target:AddChild(inst)
            inst.falltask = inst:DoPeriodicTask(0, function()
                inst.Transform:SetPosition(0,count,0)
                count = count - 0.3 + (count < 5 and -0.1 or 0)
                if count <= 0.5 then
                    inst.falltask:Cancel()
                    if rarity ~= "" then OnLink(target, rarity) end
                    inst:Remove()
                end
            end)
        end
    end)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    MakeCharacterPhysics(inst, 0, .1)
    RemovePhysicsColliders(inst)

	inst.AnimState:SetBank("modifier_orb")--temp
    inst.AnimState:SetBuild("modifier_orb")
    inst.AnimState:PlayAnimation("idle", true)
	
	--inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_despawn")
	
    inst.Transform:SetFourFaced()
	inst.Transform:SetScale(0.5,0.5,0.5) --width,height,thiccccness
	
    inst:AddTag("FX")
	inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst.entity:SetCanSleep(false)
    inst.persists = false
    inst.OnSpawn = OnSpawn
    
    inst:DoTaskInTime(60, inst.Remove)--1minute timeout

    return inst
end

return Prefab("modifierfx", fn, assets)