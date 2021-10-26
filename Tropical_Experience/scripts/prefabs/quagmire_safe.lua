local assets =
{
	Asset("ANIM", "anim/quagmire_safe.zip"),
	Asset("ANIM", "anim/quagmire_ui_chest_3x3.zip"),
}

local safe_contents = {

	{ "plate_silver", "plate_silver", "plate_silver", "quagmire_sapbucket", "quagmire_sapbucket", "quagmire_sapbucket", "quagmire_sapbucket", "quagmire_seedpacket_mix", "quagmire_seedpacket_mix"},
	{ "plate_silver", "plate_silver", "plate_silver", "monstermeat", "quagmire_seedpacket_4", "quagmire_seedpacket_7"},
	{ "plate_silver", "plate_silver", "plate_silver", "tree_syrup_contest", "honeycomb"}
	
}

local function GetContestContents1(inst)
	for k, v in pairs(safe_contents[1]) do
		local item  = SpawnPrefab(v)
		
		if item then
			inst.components.container:GiveItem(item)
		end
	end
end

local function GetContestContents2(inst)
	for k, v in pairs(safe_contents[2]) do
		local item  = SpawnPrefab(v)
		
		if item then
			inst.components.container:GiveItem(item)
		end
	end
end

local function GetContestContents3(inst)
	for k, v in pairs(safe_contents[3]) do
		local item  = SpawnPrefab(v)
		
		if item then
			inst.components.container:GiveItem(item)
		end
	end
end

local function onclose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/safe/close")
	inst.AnimState:PlayAnimation("close")
	inst.AnimState:PushAnimation("idle_unlock")
end

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/safe/open")
	inst.AnimState:PlayAnimation("open")
	inst.AnimState:PushAnimation("opened")
end

local function DisplayNameFn(inst)
    return inst.replica.container:CanBeOpened() and STRINGS.NAMES.QUAGMIRE_SAFE_UNLOCKED or STRINGS.NAMES.QUAGMIRE_SAFE_LOCKED
end

local function onusekey(inst, key, doer)
    if not key:IsValid() or key.components.klaussackkey == nil or inst.unlocked then
        return false, nil, false
    elseif key.components.klaussackkey.keytype ~= inst.keyid then
        return false, "QUAGMIRE_WRONGKEY", false
    end

    inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/safe/key")

	inst.components.container.canbeopened = true
	
	inst.unlocked = true
	
	if inst.full1 then
		GetContestContents1(inst)
	end

	if inst.full2 then
		GetContestContents2(inst)
	end
	
	if inst.full3 then
		GetContestContents3(inst)
	end	
	
	inst.AnimState:PlayAnimation("unlock")
	inst.AnimState:PushAnimation("idle_unlock")
	
    return true, nil, true
end

local function onsave(inst, data)
	data.unlocked = inst.unlocked
end

local function onload(inst, data)
	if data then
		inst.unlocked = data.unlocked
		inst.components.container.canbeopened = inst.unlocked and true or false
		inst.AnimState:PlayAnimation(inst.unlocked and "idle_unlock" or "closed")
	end
	
	if inst.unlocked then
	inst.components.container.canbeopened = inst.unlocked and true or false
	inst.AnimState:PlayAnimation(inst.unlocked and "idle_unlock" or "closed")
	end	
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("structure")
	inst:AddTag("safe")

	MakeObstaclePhysics(inst, .5)
	
    inst.AnimState:SetBank("quagmire_safe")
    inst.AnimState:SetBuild("quagmire_safe")
    inst.AnimState:PlayAnimation("closed")
  
	MakeSnowCoveredPristine(inst)
	
	inst:SetPrefabNameOverride("quagmire_safe")
	
	inst.displaynamefn = DisplayNameFn
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("quagmire_safe")
        end)
        return inst
    end

    inst:AddComponent("inspectable")

	inst:AddComponent("klaussacklock")
	inst.components.klaussacklock:SetOnUseKey(onusekey)
	
	inst.keyid = "safe_key"
	
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("quagmire_safe")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	
	inst.OnSave = onsave
	inst.OnLoad = onload
	
    return inst
end

local function regular_fn()
	local inst = fn()
	
	inst:AddTag("fridge")
    inst:AddTag("nocool")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.unlocked = true
	inst.components.container.canbeopened = inst.unlocked and true or false
	inst.AnimState:PlayAnimation(inst.unlocked and "idle_unlock" or "closed")	
	
	return inst
end

local function locked_fn1()
	local inst = fn()
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.components.container.canbeopened = false
	
	inst.unlocked = false
	
	inst.full1 = true

	return inst
end

local function locked_fn2()
	local inst = fn()
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.components.container.canbeopened = false
	
	inst.unlocked = false
	
	inst.full2 = true

	return inst
end

local function locked_fn3()
	local inst = fn()
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.components.container.canbeopened = false
	
	inst.unlocked = false
	
	inst.full3 = true

	return inst
end

return Prefab("quagmire_safe", regular_fn, assets, prefabs),
	MakePlacer("quagmire_safe_placer", "quagmire_safe", "quagmire_safe", "closed"),
	Prefab("quagmire_safe1", locked_fn1, assets, prefabs),
	Prefab("quagmire_safe2", locked_fn2, assets, prefabs),
	Prefab("quagmire_safe3", locked_fn3, assets, prefabs)
