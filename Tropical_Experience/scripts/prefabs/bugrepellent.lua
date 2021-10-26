local assets=
{
    Asset("ANIM", "anim/bugrepellent.zip"),
    Asset("ANIM", "anim/swap_bugrepellent.zip"),
}

local prefabs =
{
    "impact",
    "gascloud",
}

local BUGREPELLENT_USES = 20

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_bugrepellent", "swap_bugrepellent")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_object")
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function onhit(inst, attacker, target)
    local impactfx = SpawnPrefab("impact")
    if impactfx and attacker then
	    local follower = impactfx.entity:AddFollower()
	    follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
        impactfx:FacePoint(attacker.Transform:GetWorldPosition())
    end
    inst:Remove()
end

local function onthrown(inst, data)
    inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
    inst.AnimState:PlayAnimation("speargun")
end

local function poisonattack(inst, attacker, target)
    if target.components.poisonable then
        target.components.poisonable:Poison()
    end
    if target.components.combat then
        target.components.combat:SuggestTarget(attacker)
    end
    if target.sg and target.sg.sg.states.hit then
        target.sg:GoToState("hit")
    end
end

local function onfinished(inst)
    inst:Remove()
end


local function commonfn()


	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	
    --inst.Transform:SetFourFaced()
    anim:SetBank("bugrepellent")
    anim:SetBuild("bugrepellent")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("bugrepellent")
	inst:AddTag("aquatic") 
  
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("gasser")    

    inst:AddComponent("inspectable")

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.equipstack = true

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(BUGREPELLENT_USES)
    inst.components.finiteuses:SetUses(BUGREPELLENT_USES)
    inst.components.finiteuses:SetOnFinished( onfinished )    
    inst.components.finiteuses:SetConsumption(ACTIONS.GAS, 1)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
    return inst
end

return Prefab( "common/inventory/bugrepellent", commonfn, assets, prefabs)

