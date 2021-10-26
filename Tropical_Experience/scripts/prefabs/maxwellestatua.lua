local assets = 
{
Asset("ANIM", "anim/estatuademaxwell.zip"),
}


local function ItemTradeTest(inst, item)
if item.prefab == "maxwellstatuebracoe" then return true end
if item.prefab == "maxwellstatuebracod" then return true end
if item.prefab == "maxwellstatuecabeca" then return true end
if inst.cab and inst.cab == true and inst.maoe and inst.maoe == true and inst.maod and inst.maod == true and item.prefab == "maxwellshadowheart" then return true end
return false
end

local function ItemGet(inst, giver, item)

if item.prefab == "maxwellstatuebracoe" then
inst.maoe = true
inst.AnimState:OverrideSymbol("maoe", "estatuademaxwell", "maoe")
return 
end

if item.prefab == "maxwellstatuebracod" then
inst.maod = true
	inst.AnimState:OverrideSymbol("maod", "estatuademaxwell", "maod")
return 
end

if item.prefab == "maxwellstatuecabeca" then
inst.cab = true
	inst.AnimState:OverrideSymbol("cab", "estatuademaxwell", "cab")
return 
end

if item.prefab == "maxwellshadowheart" and inst.cab and inst.cab == true and inst.maoe and inst.maoe == true and inst.maod and inst.maod == true then
--giver:ShakeCamera(CAMERASHAKE.SIDE, .7, .05, .75)

local ex, ey, ez = inst.Transform:GetWorldPosition()
local pos = Vector3(ex, ey, ez)

SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition())
TheWorld:PushEvent("ms_sendlightningstrike", pos)	
SpawnPrefab("maxwellboss").Transform:SetPosition(inst.Transform:GetWorldPosition())	
--giver:ShakeCamera(CAMERASHAKE.SIDE, .7, .05, .75)
SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition())
inst:Remove()	
return end

inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_addpart", "teleportato_addpart")
end


local function ItemTest(inst, item, slot)
	return not item:HasTag("nonpotatable")
end

local function onsave(inst, data)
	data.cab = inst.cab
	data.maoe = inst.maoe
	data.maod = inst.maod
end

local function onload(inst, data)
	if data ~= nil and data.cab then
		inst.cab = data.cab
	end
	if data ~= nil and data.maoe then
		inst.maoe = data.maoe
	end
	if data ~= nil and data.maod then
		inst.maod = data.maod
	end	
	
	if inst.cab and inst.cab == true then
	inst.AnimState:OverrideSymbol("cab", "estatuademaxwell", "cab")
	end
	if inst.maoe and inst.maoe == true then
	inst.AnimState:OverrideSymbol("maoe", "estatuademaxwell", "maoe")	
	end
	if inst.maod and inst.maod == true then
	inst.AnimState:OverrideSymbol("maod", "estatuademaxwell", "maod")	
	end		
	
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	anim:SetBank("estatuademaxwell")
	anim:SetBuild("estatuademaxwell")
	anim:PlayAnimation("completa", true)
	inst.AnimState:OverrideSymbol("cab", "estatuademaxwell", "")
	inst.AnimState:OverrideSymbol("maoe", "estatuademaxwell", "")	
	inst.AnimState:OverrideSymbol("maod", "estatuademaxwell", "")	

	MakeObstaclePhysics(inst, 1.1)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetPriority( 5 )

	inst.entity:AddSoundEmitter()

    inst:AddComponent("talker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ItemTradeTest)
	inst.components.trader.onaccept = ItemGet	

	inst:AddComponent("inspectable")

	inst.OnSave = onsave
    inst.OnLoad = onload
	
	return inst
end

local function fnp2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("estatuademaxwell")
    inst.AnimState:SetBuild("estatuademaxwell")
    inst.AnimState:PlayAnimation("maoesquerda")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

    return inst
end

local function fnp3()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("estatuademaxwell")
    inst.AnimState:SetBuild("estatuademaxwell")
    inst.AnimState:PlayAnimation("maodireita")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

    return inst
end

local function fnp4()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("estatuademaxwell")
    inst.AnimState:SetBuild("estatuademaxwell")
    inst.AnimState:PlayAnimation("cabeca")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"

    return inst
end

return Prefab( "common/objects/maxwellestatua", fn, assets, prefabs ),
Prefab( "common/objects/maxwellstatuebracoe", fnp2, assets, prefabs ),
Prefab( "common/objects/maxwellstatuebracod", fnp3, assets, prefabs ),
Prefab( "common/objects/maxwellstatuecabeca", fnp4, assets, prefabs )

