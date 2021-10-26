local assets=
{
	Asset("ANIM", "anim/coconade.zip"),
	Asset("ANIM", "anim/swap_coconade.zip"),
}

local COCONADE_DAMAGE = 250

local prefabs = 
{

}	

local function OnHitWater(inst, attacker, target)
inst.SoundEmitter:KillSound("hiss")
inst.components.explosive:OnBurnt()
local x, y, z = inst.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then
inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")
local explode = SpawnPrefab("explode_small")
explode.Transform:SetPosition(x, y, z)
else
local splash = SpawnPrefab("bombsplash")
splash.Transform:SetPosition(x, y, z)
inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/splash_large")
end
inst:Remove()		
end


local function onthrown(inst)
  inst._fx = SpawnPrefab("torchfire")
    inst._fx.entity:SetParent(inst.entity)
    inst._fx.entity:AddFollower()
    inst._fx.Follower:FollowSymbol(inst.GUID, "coconade01", 40,-105, 0)
    inst.AnimState:PlayAnimation("throw", true)
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
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
    DefaultBurnFn(inst)
end
	
local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_coconade", "swap_coconade")
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
    
	inst.AnimState:SetBank("coconade")
	inst.AnimState:SetBuild("coconade")
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
	
    inst.components.complexprojectile:SetHorizontalSpeed(20)
    inst.components.complexprojectile:SetGravity(-40)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrown)
    inst.components.complexprojectile:SetOnHit(OnHitWater)
	

    inst:AddComponent("explosive")
    inst.components.explosive.explosivedamage = COCONADE_DAMAGE
	inst.components.explosive.explosiverange = 6	
	
	MakeSmallBurnable(inst, 3 + math.random() * 3)
    inst.components.burnable:SetOnBurntFn(nil)
    inst.components.burnable:SetOnIgniteFn(OnIgniteFn)

	
    inst:AddComponent("inspectable")

	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
    inst.components.weapon:SetRange(10, 12)
	

	inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	    inst.components.equippable.equipstack = true

	 inst:AddComponent("stackable")
    return inst
end

return Prefab( "common/inventory/coconade", fn, assets) 
