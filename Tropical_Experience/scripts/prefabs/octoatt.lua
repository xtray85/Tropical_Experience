local assets=
{
	Asset("ANIM", "anim/sharx_build.zip"),
	Asset("ANIM", "anim/sharx.zip"),
	Asset("SOUND", "sound/chess.fsb"),
}

local function OnHit(inst, owner, target)
    inst:Remove()
    --inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/shotexplo")
end

local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	inst.Transform:SetFourFaced()
	trans:SetScale(0.5,0.5,0.5)
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
    
    anim:SetBank("sharx")
    anim:SetBuild("sharx_build")
    anim:PlayAnimation("run_water_loop")
	inst.AnimState:OverrideSymbol("shark_fin_swim", "sharx_build", "droplet")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
    
    inst:AddTag("projectile")
    inst.persists = false
    
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(15)
    inst.components.projectile:SetHoming(true)
    inst.components.projectile:SetHitDist(1.5)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(OnHit)
    inst.components.projectile.range = 20
    
    return inst
end

return Prefab( "common/inventory/octoatt", fn, assets) 
