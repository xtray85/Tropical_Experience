
local assets=
{
	Asset("ANIM", "anim/swap_harpoon.zip"),
	Asset("ANIM", "anim/harpoon.zip"),
}

local prefabs = 
{
	"impact",
}

local	    HARPOON_DAMAGE = 200
local	    HARPOON_USES = 10
local	    HARPOON_RANGE = 6
local	    HARPOON_SPEED = 30

local function onfinished(inst)
	inst:Remove()
end

local function onequip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_object", "swap_harpoon", "swap_object")
	owner.AnimState:Show("ARM_carry") 
	owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_object")
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal") 
end

local function onhit(inst, attacker, target)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

inst.AnimState:SetOrientation(ANIM_ORIENTATION.Default)
	
	
	local impactfx = SpawnPrefab("impact")
	if impactfx and attacker then
		local follower = impactfx.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		impactfx:FacePoint(attacker.Transform:GetWorldPosition())
	end
end

local function thrownfn(inst)
	inst.AnimState:PlayAnimation("thrown")
end

local function onthrown(inst, data)
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
end


local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)
	

inst.Physics:ClearCollisionMask() 
inst.Physics:CollidesWith(COLLISION.GROUND)
	
	inst.AnimState:SetBank("harpoon")
	inst.AnimState:SetBuild("harpoon")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("thrown")
	inst:AddTag("projectile")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(HARPOON_USES)
	inst.components.finiteuses:SetUses(HARPOON_USES)
	inst.components.finiteuses:SetOnFinished(onfinished)

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(HARPOON_DAMAGE)
	inst.components.weapon:SetRange(HARPOON_RANGE, HARPOON_RANGE+2)
	
	inst:AddComponent("projectile")
	inst.components.projectile:SetSpeed(HARPOON_SPEED)
	inst.components.projectile:SetOnHitFn(onhit)
	inst.components.projectile:SetOnThrownFn(thrownfn)
	inst:ListenForEvent("onthrown", onthrown)

	return inst
end

return Prefab( "harpoon", fn, assets, prefabs)
