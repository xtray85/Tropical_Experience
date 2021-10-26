local assets = {
	Asset("ANIM", "anim/bell.zip"),
}

local function OnPlayed(inst, musician)
	if TheWorld.components.bigfooter then
		TheWorld.components.bigfooter:SummonFoot(musician:GetPosition())
	end
end

local function shine(inst)
	inst.task = nil
	inst.AnimState:PlayAnimation("sparkle")
	inst.AnimState:PushAnimation("idle")
	inst.task = inst:DoTaskInTime(4 + math.random() * 5, function() shine(inst) end)
end

local function OnPutInInv(inst, owner)
	if owner.prefab == "mole" or owner.prefab == "krampus" then
		inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/glommer_bell")
		OnPlayed(inst, owner)
		if inst.components.finiteuses then inst.components.finiteuses:Use() end
	end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	

	inst.AnimState:SetBank("bell")
	inst.AnimState:SetBuild("bell")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("bell")
	inst:AddTag("molebait")
	inst:AddTag("aquatic")
			
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TUNING.GLOMMERBELL_USES)
	inst.components.finiteuses:SetUses(TUNING.GLOMMERBELL_USES)
	inst.components.finiteuses:SetOnFinished(inst.Remove)
	inst.components.finiteuses:SetConsumption(ACTIONS.PLAY, 0.7)

	inst:AddComponent("inspectable")

	inst:AddComponent("instrument")
	inst.components.instrument.onplayed = OnPlayed

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInv)
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.PLAY)

	inst:ListenForEvent("onstolen", function(inst, data) 
		if data.thief.components.inventory then
			data.thief.components.inventory:GiveItem(inst)
		end 
	end)

	shine(inst)

	return inst
end

return Prefab("bell1", fn, assets)
