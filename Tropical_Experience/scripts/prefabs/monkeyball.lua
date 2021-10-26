local assets=
{
	Asset("ANIM", "anim/monkey_ball.zip"),
	Asset("ANIM", "anim/swap_monkeyball.zip"),
}

local prefabs=
{
}

local	MONKEYBALL_USES = 10

local function unclaim(inst)
	inst.claimed = nil
end

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "swap_monkeyball", "swap_monkeyball")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	owner.AnimState:ClearOverrideSymbol("swap_object")
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end


local function onputininventory(inst)
	inst.claimed = true
    inst.Physics:SetFriction(.1)
end

local function onthrown(inst, thrower, pt)
inst.Physics:CollidesWith(COLLISION.GROUND)
--self.inst.Physics:CollidesWith(COLLISION.WORLD)
--inst.Physics:CollidesWith(COLLISION.OBSTACLES)
--inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
inst.Physics:CollidesWith(COLLISION.CHARACTERS)
inst.Physics:CollidesWith(COLLISION.GIANTS)
--targetPos, attacker, owningweapon
local thrower = inst.components.complexprojectile.attacker
    inst.Physics:SetFriction(.2)
	inst.Transform:SetFourFaced()

    inst.AnimState:PlayAnimation("throw", true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/coconade_throw")
end

local function onthrown2(inst, thrower, pt)

	inst.unclaimtask = inst:DoTaskInTime(1, unclaim)

    inst.Physics:SetFriction(.2)
	inst.Transform:SetFourFaced()
	inst:FacePoint(pt:Get())
--    inst.components.floatable:UpdateAnimations("idle_water", "throw")
    inst.AnimState:PlayAnimation("throw", true)
   inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/coconade_throw")

    -- inst.components.inventoryitem.canbepickedup = false
end

local function onhitground(inst)
inst.components.finiteuses:Use(1)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
inst.Physics:CollidesWith(COLLISION.WORLD)
inst.Physics:CollidesWith(COLLISION.OBSTACLES)
inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
inst.Physics:CollidesWith(COLLISION.CHARACTERS)
inst.Physics:CollidesWith(COLLISION.GIANTS)

if ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then
        inst.AnimState:PlayAnimation("idle_water", true)
end
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then
        inst.AnimState:PlayAnimation("idle", true)
	end
end

local function oncollision(inst, other)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/monkey_ball/bounce")
end

local function pop(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/monkey_ball/pop")
	SpawnPrefab("small_puff_light").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("coconut_chunks").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst:Remove()
end

local function onfinished(inst)

inst:Remove()
SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("monkeyball")
	inst.AnimState:SetBuild("monkey_ball")
	inst.AnimState:PlayAnimation("idle")

    MakeSmallBurnable(inst)
	MakeInventoryPhysics(inst)
--	MakeInventoryFloatable(inst, "idle_water", "idle")

--	inst.components.floatable:SetOnHitLandFn(onhitground)
--	inst.components.floatable:SetOnHitWaterFn(onhitground)

	inst:AddTag("thrown")
	inst:AddTag("projectile")
	inst:AddTag("monkeybait")
	MakeInventoryFloatable(inst)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    inst.components.inventoryitem:SetOnPutInInventoryFn(onputininventory)
	inst.components.inventoryitem.bouncesound = "dontstarve_DLC002/common/monkey_ball/bounce"

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.equipstack = true

	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(MONKEYBALL_USES)
	inst.components.finiteuses:SetUses(MONKEYBALL_USES)
	inst.components.finiteuses:SetOnFinished(onfinished)

	inst:AddComponent("throwable")
	inst.components.throwable.onthrown = onthrown2
	
	inst:AddComponent("complexprojectile")
	inst.components.complexprojectile:SetHorizontalSpeed(20)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 3, 0))
    inst.components.complexprojectile:SetOnLaunch(onthrown)
    inst.components.complexprojectile:SetOnHit(onhitground)

	inst:AddComponent("reticule")
    inst.components.reticule.targetfn = function() 
        return inst.components.throwable:GetThrowPoint()
    end
    inst.components.reticule.ease = true

    inst.Physics:SetCollisionCallback(oncollision)

	return inst
end

return Prefab("common/inventory/monkeyball", fn, assets, prefabs)
