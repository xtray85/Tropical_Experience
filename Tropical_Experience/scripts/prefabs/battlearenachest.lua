require "prefabutil"

local assets=
{
}

local prefabs =
{
	"collapse_small",
	"lavaarena_creature_teleport_small_fx",
}

local function onopen(inst) 
	if not inst:HasTag("burnt") then
			inst.AnimState:PushAnimation("opened", true)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end
end

local function oncloseb(inst)
if inst.components.container then inst.components.container:DropEverything() end
SpawnPrefab("lavaarena_creature_teleport_small_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
inst:Remove()
end 

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	if inst.components.container then inst.components.container:DropEverything() end
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")	
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("closed", true)
		if inst.components.container then 
			inst.components.container:DropEverything() 
			inst.components.container:Close()
		end
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", true)
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
		data.burnt = true
	end
end

local function onfar(inst)

end

local function fn3(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	    MakeInventoryPhysics(inst)

	inst.MiniMapEntity:SetIcon("luggagechest.png")
	
	inst.AnimState:SetBank("chest")
	inst.AnimState:SetBuild("treasure_chest")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("chester")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = oncloseb

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	
	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 7)
    inst.components.playerprox:SetOnPlayerNear(oncloseb)
    inst.components.playerprox:SetOnPlayerFar(onfar)

	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
	return inst
end

return 	Prefab("common/lavarenachest", fn3, assets)