require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/octopus_chest.zip"),
	Asset("ANIM", "anim/kraken_chest.zip"),
	Asset("ANIM", "anim/luggage.zip"),
	Asset("ANIM", "anim/treasure_chest_roottrunk.zip"),
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

local function onclose(inst)
	if not inst:HasTag("burnt") then
			inst.AnimState:PushAnimation("closed", true)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")

	end
end

local function oncloseocto(inst)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("close")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")

		if not inst.components.container:IsEmpty() then
			inst.AnimState:PushAnimation("closed", true)
			return
		else
		
			inst.AnimState:PushAnimation("sink", false)
			
			inst:DoTaskInTime(96*FRAMES, function (inst)
				inst.SoundEmitter:PlaySound("dontstarve_DLC002/quacken/tentacle_submerge")
			end)

			inst:ListenForEvent("animqueueover", function (inst)
				inst:Remove()
			end)
		end
	end
end

local function oncloseb(inst)
if inst.components.container then inst.components.container:DropEverything() end
SpawnPrefab("lavaarena_creature_teleport_small_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())

local pt = inst:GetPosition()
local jogadores = TheSim:FindEntities(pt.x, pt.y, pt.z, 70, {"player"})
for k,player in pairs(jogadores) do
if player.components.hunger then
player.components.hunger:DoDelta(500)
end
if player.components.sanity then
player.components.sanity:DoDelta(500)
end

if player.components.health then
player.components.health:DoDelta(500)
end
end

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

local function onhammered2(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
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

local function fn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.MiniMapEntity:SetIcon("kraken_chest.png")
	
	inst.AnimState:SetBank("kraken_chest")
	inst.AnimState:SetBuild("kraken_chest")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("treasurechest") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("treasurechest")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit) 

	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
	return inst
end

local function fn1(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	    MakeInventoryPhysics(inst)

--	inst.MiniMapEntity:SetIcon("lovelychest.tex")
	
	inst.AnimState:SetBank("octopus_chest")
	inst.AnimState:SetBuild("octopus_chest")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("treasurechest") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("treasurechest")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = oncloseocto

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit) 

	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
	return inst
end

local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end

local function fn2(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	    MakeInventoryPhysics(inst)

	inst.MiniMapEntity:SetIcon("luggage_chest.png")
	
	inst.AnimState:SetBank("luggage")
	inst.AnimState:SetBuild("luggage")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("treasurechest") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("treasurechest")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit) 

	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)		
	
	return inst
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

	inst.MiniMapEntity:SetIcon("luggage_chest.png")
	
	inst.AnimState:SetBank("chest")
	inst.AnimState:SetBuild("treasure_chest")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("treasurechest") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("treasurechest")
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

local function onopenroot(inst) 
	if not inst:HasTag("burnt") then
			inst.AnimState:PushAnimation("open", false)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	end
end

local function oncloseroot(inst)
	if not inst:HasTag("burnt") then
			inst.AnimState:PlayAnimation("close", false)	
			inst.AnimState:PushAnimation("closed", false)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")

	end
end

local function fn4(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.MiniMapEntity:SetIcon("roottrunk.png")
	
--	inst.AnimState:SetBank("roottrunk")
--	inst.AnimState:SetBuild("treasure_chest_roottrunk")
--	inst.AnimState:PlayAnimation("closed", true)
--	inst:AddTag("structure")
--    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("shadowchester") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("shadowchester")
	inst.components.container.onopenfn = onopenroot
    inst.components.container.onclosefn = oncloseroot

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered2)
	inst.components.workable:SetOnWorkCallback(onhit)

--	inst:ListenForEvent( "onbuilt", onbuilt)
--	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
	return inst
end

local function fn5(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

	inst.MiniMapEntity:SetIcon("roottrunk.png")
	
	inst.AnimState:SetBank("roottrunk")
	inst.AnimState:SetBuild("treasure_chest_roottrunk")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
    inst:AddTag("chest")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("shadowchester") 
		end
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("shadowchester")
	inst.components.container.onopenfn = onopenroot
    inst.components.container.onclosefn = oncloseroot

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered2)
	inst.components.workable:SetOnWorkCallback(onhit)

	inst:ListenForEvent( "onbuilt", onbuilt)
	MakeSnowCovered(inst, .01)	

	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	
	inst:ListenForEvent("onopen", function() if TheWorld.components.roottrunkinventory then TheWorld.components.roottrunkinventory:empty(inst) end end)
	inst:ListenForEvent("onclose", function() if TheWorld.components.roottrunkinventory then TheWorld.components.roottrunkinventory:fill(inst) end end)
	
	return inst
end

return 	Prefab("common/octopuschest", fn1, assets),
		Prefab("common/krakenchest", fn, assets),
		Prefab("common/luggagechest", fn2, assets),
		Prefab("common/lavarenachest", fn3, assets),
		Prefab("common/roottrunk", fn4, assets),	
		Prefab("common/roottrunk_child", fn5, assets),
		MakePlacer("common/roottrunk_child_placer", "roottrunk", "treasure_chest_roottrunk", "closed")