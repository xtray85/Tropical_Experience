local assets =
{
    Asset("ANIM", "anim/quagmire_salt_pond.zip"),
    Asset("ANIM", "anim/splash.zip"),	
}

local havesttime = 150

local prefabs =
{
    "quagmire_salmon",
}

local function onharvest(inst, picker)
	if inst.rack then
		inst.rack.AnimState:PlayAnimation("picked")
		inst.rack.AnimState:PushAnimation("idle", true)
		inst.rack.AnimState:Hide("salt")
	end

	if inst.components.setupable.item == "quagmire_salt_rack_item" then
		inst.components.harvestable:SetGrowTime(havesttime)
	elseif picker and picker.components.inventory then		
		inst.components.setupable:Unsetup()
	end	
	
	inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishcaught")
end

local function unsetupfn(inst)
	if inst.rack then
		inst.rack:Remove()
		inst.rack = nil
	end
	
	local loot = SpawnPrefab(inst.components.setupable.item)
	
	if loot then
		if loot.components.inventoryitem then
			loot.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
		end
		
		if loot.components.finiteuses then
			loot.components.finiteuses.current = inst.components.setupable.uses
		end
		
		picker.components.inventory:GiveItem(loot, nil, inst:GetPosition())
	end
	
    inst:AddComponent("fishable")
    inst.components.fishable:SetRespawnTime(TUNING.FISH_RESPAWN_TIME)
    inst.components.fishable:AddFish("oceanfish_small_11_inv")
	inst.components.fishable.maxfish = 6
	inst.components.fishable.fishleft = 6
end

local function ongrow(inst)
	if inst.rack then
		inst.rack.AnimState:PlayAnimation("grow")
		inst.rack.AnimState:PushAnimation("idle", true)
		inst.rack.AnimState:Show("salt")
		
		inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishcaught")
	end
end

local function setupfn(inst, item)	
	if inst.rack == nil and item then
		inst.rack = inst:SpawnChild("quagmire_salt_rack")
		inst.rack.AnimState:PlayAnimation("place")
		inst.rack.AnimState:PushAnimation("idle", true)
		
		inst.components.harvestable:StartGrowing(item.prefab == "quagmire_salt_rack_item" and havesttime)
		
		inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/craft/salt_rack")
	elseif inst.rack == nil then
		inst.rack = inst:SpawnChild("quagmire_salt_rack")
		
		if inst.rack and inst.components.harvestable.produce > 0 then
			inst.rack.AnimState:Show("salt")
		end
	end
	
	inst:RemoveComponent("fishable")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 2)

    inst.AnimState:SetBuild("quagmire_salt_pond")
    inst.AnimState:SetBank("quagmire_salt_pond")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("minimap_quagmire_pond_salt.png")

    inst:AddTag("watersource")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    inst:AddTag("saltwater")

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("fishable")
    inst.components.fishable:SetRespawnTime(TUNING.FISH_RESPAWN_TIME)
    inst.components.fishable:AddFish("fishaa")
	inst.components.fishable.maxfish = 5
	inst.components.fishable.fishleft = 5

	inst:AddComponent("harvestable")
	inst.components.harvestable:SetUp("saltrock", 1, havesttime, onharvest, ongrow)
	inst.components.harvestable:StopGrowing()
	
	inst:AddComponent("setupable")
	inst.components.setupable.setupitem = "saltrack"
	inst.components.setupable.setupfn = setupfn
	
	inst:AddComponent("watersource")

    return inst
end

return Prefab("quagmire_pond_salt", fn, assets, prefabs)
