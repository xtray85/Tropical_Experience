local assets=
{
	Asset("ANIM", "anim/coconade_obsidian.zip"),
	Asset("ANIM", "anim/swap_coconade_obsidian.zip"),
}

local prefabs = 
{

}	

local function OnHitWater(inst, attacker, target)


    inst.SoundEmitter:KillSound("hiss")
	SpawnPrefab("obsidianbombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())
inst.SoundEmitter:PlaySound("dontstarve/common/dropwood")

	    inst:Remove()		
end


local function onthrown(inst)
  inst._fx = SpawnPrefab("torchfire")
    inst._fx.entity:SetParent(inst.entity)
            inst._fx.entity:AddFollower()
            inst._fx.Follower:FollowSymbol(inst.GUID, "coconade01", 40,-105, 0)
    inst.AnimState:PlayAnimation("throw")
    inst:AddTag("NOCLICK")
    inst.persists = false

  inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
    inst.Physics:SetMass(1)
    inst.Physics:SetCapsule(0.2, 0.2)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.ITEMS)
end


local function ReticuleTargetFn()
    local player = ThePlayer
    local ground = TheWorld.Map
    local x, y, z
    --Attack range is 8, leave room for error
    --Min range was chosen to not hit yourself (2 is the hit range)
    for r = 6.5, 3.5, -.25 do
        x, y, z = player.entity:LocalToWorldSpace(r, 0, 0)
        if ground:IsPassableAtPoint(x, y, z) then
            return Vector3(x, y, z)
        end
    end
    return Vector3(x, y, z)
end
	
local function OnIgniteFn(inst)
	SpawnPrefab("obsidianbombactive").Transform:SetPosition(inst.Transform:GetWorldPosition())
	   inst:Remove()
end
	
local function onequip(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_object", "swap_coconade_obsidian", "swap_coconade_obsidian")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end
	
local function fn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)	
    
	inst.AnimState:SetBank("coconade_obsidian")
	inst.AnimState:SetBuild("coconade_obsidian")
	inst.AnimState:PlayAnimation("idle")
    
	inst:AddTag("aquatic")
	  
	inst.entity:SetPristine()
	  
    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("reticule")
    inst.components.reticule.targetfn = ReticuleTargetFn
    inst.components.reticule.ease = true	
		
    inst:AddComponent("inventoryitem")
	
	inst:AddComponent("locomotor")

    inst:AddComponent("complexprojectile")
	
    inst.components.complexprojectile:SetHorizontalSpeed(15)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrown)
    inst.components.complexprojectile:SetOnHit(OnHitWater)
	

	MakeSmallBurnable(inst, 3 + math.random() * 3)
    inst.components.burnable:SetOnBurntFn(nil)
    inst.components.burnable:SetOnIgniteFn(OnIgniteFn)

	
    inst:AddComponent("inspectable")

	inst.components.inventoryitem.imagename = "obsidianbomb"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetRange(10, 12)
	

	inst:AddComponent("wateryprotection")
	inst.components.wateryprotection.witherprotectiontime = TUNING.WATERBALLOON_PROTECTION_TIME


	 inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	    inst.components.equippable.equipstack = true

	 inst:AddComponent("stackable")
    return inst
end

return Prefab( "common/inventory/obsidianbomb", fn, assets) 
