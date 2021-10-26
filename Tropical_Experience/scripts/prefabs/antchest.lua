require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/ant_chest.zip"),
	Asset("ANIM", "anim/ant_chest_honey_build.zip"),
	Asset("ANIM", "anim/ant_chest_nectar_build.zip"),
	Asset("ANIM", "anim/treasure_chest_cork.zip"),	
}

local prefabs =
{
	"collapse_small",
	"lavaarena_creature_teleport_small_fx",
}

local function onopen(inst) 
	if not inst:HasTag("burnt") then
			inst.AnimState:PushAnimation("open", false)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end
end

local function onclose(inst)
	if not inst:HasTag("burnt") then
			inst.AnimState:PlayAnimation("close", true)
			inst.AnimState:PushAnimation("closed", true)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")

	end
end

local function onopencork(inst) 
	if not inst:HasTag("burnt") then
			inst.AnimState:PlayAnimation("open", true)
			inst.AnimState:PushAnimation("open_loop", true)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end
end

local function onclosecork(inst)
	if not inst:HasTag("burnt") then
			inst.AnimState:PlayAnimation("close", true)
			inst.AnimState:PushAnimation("closed", true)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")

	end
end

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	if inst.components.container then inst.components.container:DropEverything() end
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")	
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("closed", true)
		if inst.components.container then 
			inst.components.container:DropEverything() 
			inst.components.container:Close()
		end
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", true)
end

local function onsave(inst, data)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() or inst:HasTag("burnt") then
        data.burnt = true
    end
	if inst.honeyWasLoaded then
		data.honeyWasLoaded = inst.honeyWasLoaded
	end
end

local function onload(inst, data)
    if data ~= nil and data.burnt and inst.components.burnable ~= nil then
        inst.components.burnable.onburnt(inst)
    end
	if data and data.honeyWasLoaded then
		inst.honeyWasLoaded = data.honeyWasLoaded
	end
end

local function testitem_honeychest(inst, item, slot)
	return item.prefab == "honey" or item.prefab == "nectar_pod"
end

local function LoadHoneyFirstTime(inst)
	if not inst.honeyWasLoaded then
		inst.honeyWasLoaded = true

if inst.components.container then
local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 1)		

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 2)	

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 3)	

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 4)	

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 5)	

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 6)	

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 7)	

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 8)	

local single1 = SpawnPrefab("honey")
inst.components.container:GiveItem(single1, 9)	
end
end
end

local function RefreshAntChestBuild(inst)
	local containsHoney  = false
	local containsNectar = false

	for index = 1, #slotpos, 1 do
		local item = inst.components.container:GetItemInSlot(index)

		if item then
			if item.prefab == "honey" then
				containsHoney = true
			end

			if item.prefab == "nectar_pod" then
				containsNectar = true
			end
		end
	end

	if containsHoney then
		inst.AnimState:SetBuild("ant_chest_honey_build")
		inst.MiniMapEntity:SetIcon("ant_chest_honey.png")
	elseif containsNectar then
		inst.AnimState:SetBuild("ant_chest_nectar_build")
		inst.MiniMapEntity:SetIcon("ant_chest_nectar.png")
	else
		inst.AnimState:SetBuild("ant_chest")
		inst.MiniMapEntity:SetIcon("ant_chest.png")
	end
end

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.MiniMapEntity:SetIcon("antchest.png")
	
	inst.AnimState:SetBank("ant_chest")
	inst.AnimState:SetBuild("ant_chest_honey_build")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("treasurechest") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("treasurechest")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
--	inst.components.container.itemtestfn = testitem_honeychest

	inst:AddComponent("lootdropper")

	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
--	inst:ListenForEvent("itemget", function() RefreshAntChestBuild(inst) end)
--	inst:ListenForEvent("itemlose", function() RefreshAntChestBuild(inst) end)
	inst:DoTaskInTime(0.01, function() LoadHoneyFirstTime(inst) end)	
	
		inst.OnSave = onsave 
		inst.OnLoad = onload	
	
	
	return inst
end

local function fn1(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.MiniMapEntity:SetIcon("treasure_chest_cork")
	
	inst.AnimState:SetBank("treasure_chest_cork")
	inst.AnimState:SetBuild("treasure_chest_cork")
	inst.AnimState:PlayAnimation("closed", true)
	
--	inst:AddTag("structure")
    inst:AddTag("chest")
	inst:AddTag("pogproof")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("corkchest") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("corkchest")
	inst.components.container.onopenfn = onopencork
    inst.components.container.onclosefn = onclosecork

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)

	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
	return inst
end

return 	Prefab("common/antchest", fn, assets),
		Prefab("common/corkchest", fn1, assets),
		MakePlacer("common/corkchest_placer", "chest", "treasure_chest_cork", "closed")