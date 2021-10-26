local assets =
{
	Asset("ANIM", "anim/swap_pirate_booty_bag.zip"),
}
local TEMPODAMOEDA = 480

local function SpawnDubloon(inst)
    local dubloon = SpawnPrefab("dubloon")
    local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,2,0)

    dubloon.Transform:SetPosition(pt:Get())
--    local angle = inst.Transform:GetRotation()*(PI/180)
--    local sp = (math.random()+1) * -1
--    dubloon.Physics:SetVel(sp*math.cos(angle), math.random()*2+8, -sp*math.sin(angle))
--  dubloon.components.inventoryitem:OnStartFalling()
	inst.components.fueled.currentfuel = TEMPODAMOEDA
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_body", "swap_pirate_booty_bag", "backpack")
	owner.AnimState:OverrideSymbol("swap_body", "swap_pirate_booty_bag", "swap_body")
    inst.components.container:Open(owner)
	if inst.components.fueled then
       inst.components.fueled:StartConsuming()        
    end
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
	owner.AnimState:ClearOverrideSymbol("backpack")
    inst.components.container:Close(owner)
	
	if inst.components.fueled then
       inst.components.fueled:StopConsuming()        
    end
end

local function onburnt(inst)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
        inst.components.container:Close()
    end

    SpawnPrefab("ash").Transform:SetPosition(inst.Transform:GetWorldPosition())

    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("piratepack.png")

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("pirate_booty_bag")
    inst.AnimState:SetBuild("swap_pirate_booty_bag")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("backpack")
	MakeInventoryFloatable(inst)

    inst.foleysound = "dontstarve/movement/foley/backpack"

    inst.entity:SetPristine()

	 if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("backpack") 
		end
		return inst
	end
	

	inst:AddComponent("fueled") 
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TEMPODAMOEDA)
    inst.components.fueled:SetDepletedFn(SpawnDubloon)

	
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
    inst.components.inventoryitem.cangoincontainer = false

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("backpack")

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
    inst.components.burnable:SetOnBurntFn(onburnt)

    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("piratepack", fn, assets)