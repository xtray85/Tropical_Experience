local assets =
{
    Asset("ANIM", "anim/quacken_tentacle.zip"),
    Asset("MINIMAP_IMAGE", "quacken_tentacle"),
}

local prefabs =
{
    "krakenunderwater_tentacle",
}

SetSharedLootTable('krakenunderwater_tentacle',
{
    {'tentaclespots', 0.10},
    {'tentaclespike', 0.05},
})

local function Retarget(inst)
    return FindEntity(inst, 7, function(guy) 
        if guy.components.combat and guy.components.health and not guy.components.health:IsDead() then
            return not (guy.prefab == inst.prefab)
        end
    end, nil, {"prey"}, {"character", "monster", "animal"})
end

local function ShouldKeepTarget(inst, target)
    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
        local distsq = target:GetDistanceSqToInst(inst)
        return distsq < 100
    else
        return false
    end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

    anim:SetBank("quacken_tentacle")
    anim:SetBuild("quacken_tentacle")
    anim:PlayAnimation("enter", true)
	
	inst.AnimState:OverrideSymbol("column", "quacken_tentacle", "")
	inst.AnimState:OverrideSymbol("droplet", "quacken_tentacle", "")
	inst.AnimState:OverrideSymbol("droplet_single", "quacken_tentacle", "")
	inst.AnimState:OverrideSymbol("ripple2", "quacken_tentacle", "")
	inst.AnimState:OverrideSymbol("sidesplash", "quacken_tentacle", "")
	inst.AnimState:OverrideSymbol("splash", "quacken_tentacle", "")
	inst.AnimState:OverrideSymbol("splash_cone", "quacken_tentacle", "")
	inst.AnimState:OverrideSymbol("tentacle_fade", "quacken_tentacle", "")

    inst:AddTag("kraken")
    inst:AddTag("tentacle")
    inst:AddTag("nowaves")
    inst:AddTag("epic")
    inst:AddTag("noteleport")
	
	if not TheWorld.ismastersim then
        return inst
    end	

	MakeWaterObstaclePhysics(inst, 1, 2, 1.25)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("quacken_tentacle.png")

    inst:AddComponent("inspectable")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(180)

    inst:AddComponent("combat")
    inst.components.combat:SetRange(4)
    inst.components.combat:SetDefaultDamage(30)
    inst.components.combat:SetAttackPeriod(8)
    inst.components.combat:SetRetargetFunction(1, Retarget)
    inst.components.combat:SetKeepTargetFunction(ShouldKeepTarget)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('krakenunderwater_tentacle')

    inst:AddComponent("locomotor")
    
    inst:SetStateGraph("SGkrakententacleunderwater")
    local brain = require("brains/krakententaclebrain")
    inst:SetBrain(brain)
	
	inst.buraco2 = SpawnPrefab("krakenholefundo")
	inst.buraco2.entity:SetParent(inst.entity)
	inst.buraco2.Transform:SetPosition(0, -0.2, 0)	
	inst.buraco2.Transform:SetScale(0.5, 0.5, 0.5)

	inst.buraco1 = SpawnPrefab("krakenholefrente")
	inst.buraco1.entity:SetParent(inst.entity)
	inst.buraco1.Transform:SetPosition(0, 0.2, 0)
	inst.buraco1.Transform:SetScale(0.5, 0.5, 0.5)	

	return inst
end

return Prefab("krakenunderwater_tentacle", fn, assets, prefabs)
