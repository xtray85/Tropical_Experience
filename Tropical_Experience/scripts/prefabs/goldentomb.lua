local assets =
{
	Asset("ANIM", "anim/golden_tomb.zip"),
    Asset("SOUND", "sound/monkey.fsb"),
}

local prefabs =
{
    "goldmonkey",
	"goldnugget",
    "collapse_small",
}

SetSharedLootTable( 'goldentomb',
{
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
	{'goldnugget',1.0},
})

local function shake(inst)
    local anim = ((math.random() > .5) and "move1") or "move2"
    --inst.AnimState:PlayAnimation(anim)
    inst.AnimState:PushAnimation("idle")
    inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey/barrel_rattle")
end

local function onhammered(inst, worker)
    inst.shake:Cancel()
    inst.shake = nil
    inst.components.lootdropper:DropLoot()
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if inst.components.childspawner then
        inst.components.childspawner:ReleaseAllChildren(worker)
    end
    --inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", false)

    inst.shake:Cancel()
    inst.shake = nil
    inst.shake = inst:DoPeriodicTask(GetRandomWithVariance(10, 3), shake)
end

local function ReturnChildren(inst)
	for k,child in pairs(inst.components.childspawner.childrenoutside) do
		if child.components.homeseeker then
			child.components.homeseeker:GoHome()
		end
		child:PushEvent("gohome")
	end

    if not inst.task then
        inst.task = inst:DoTaskInTime(math.random(60, 120), function() 
            inst.task = nil 
            inst:PushEvent("safetospawn")
        end)
    end
end

local function OnIgniteFn(inst)
	--inst.AnimState:PlayAnimation("shake", true)
    inst.shake:Cancel()
    inst.shake = nil
    if inst.components.childspawner then
        inst.components.childspawner:ReleaseAllChildren()
        inst:RemoveComponent("childspawner")
    end
end

local function ongohome(inst, child)
    if child.components.inventory then
        child.components.inventory:DropEverything(false, true)
    end
end

local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .75 )
    inst.entity:AddSoundEmitter()
    --MakeObstaclePhysics( inst, 1)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("goldtomb_icon.tex")

    anim:SetBank("walrus_house")
    anim:SetBuild("golden_tomb")
    anim:PlayAnimation("idle", true)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	inst:AddComponent( "childspawner" )
	inst.components.childspawner:SetRegenPeriod(1200)
	inst.components.childspawner:SetSpawnPeriod(30)
	inst.components.childspawner:SetMaxChildren(1)
	inst.components.childspawner:StartRegen()
	inst.components.childspawner.childname = "goldmonkey"
    inst.components.childspawner:StartSpawning()
    inst.components.childspawner.ongohome = ongohome
    inst.components.childspawner:SetSpawnedFn(shake)

	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('goldentomb')

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("inspectable")

    inst.shake = inst:DoPeriodicTask(GetRandomWithVariance(10, 3), shake )
	return inst
end

return Prefab( "cave/objects/goldentomb", fn, assets, prefabs) 