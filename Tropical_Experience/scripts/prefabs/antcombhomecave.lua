local assets =
{
	Asset("ANIM", "anim/ant_house.zip"),
}

local prefabs =
{
	"antman2",
}

local function ReturnChildren(inst)
	for k,child in pairs(inst.components.childspawner.childrenoutside) do
		if child.components.homeseeker then
			child.components.homeseeker:GoHome()
		end
		child:PushEvent("gohome")
	end
end

local function onnear(inst)
    if inst.components.childspawner.childreninside >= inst.components.childspawner.maxchildren then
        local tries = 10
        while inst.components.childspawner:CanSpawn() and tries > 0 do
            local bat = inst.components.childspawner:SpawnChild()
--            if bat ~= nil then
--                bat:DoTaskInTime(0, function() bat:PushEvent("panic") end)
--            end
            tries = tries - 1
        end
        inst.SoundEmitter:PlaySound("dontstarve/cave/bat_cave_explosion")
        inst.SoundEmitter:PlaySound("dontstarve/creatures/bat/taunt")
    end
end

local function onaddchild( inst, count )
    if inst.components.childspawner.childreninside == inst.components.childspawner.maxchildren then
        inst.AnimState:PlayAnimation("hit",true)
        inst.SoundEmitter:PlaySound("dontstarve/cave/bat_cave_warning", "full")
    end
end

local function onspawnchild( inst, child )
    inst.AnimState:PlayAnimation("idle",true)
    inst.SoundEmitter:KillSound("full")
    inst.SoundEmitter:PlaySound("dontstarve/cave/bat_cave_bat_spawn")
end

local function OnEntityWake(inst)
    if inst.components.childspawner.childreninside == inst.components.childspawner.maxchildren then
        inst.AnimState:PlayAnimation("hit",true)
        inst.SoundEmitter:PlaySound("dontstarve/cave/bat_cave_warning", "full")
    end
end

local function OnEntitySleep(inst)
    inst.SoundEmitter:KillSound("full")
end

local function onisday(inst, isday)
    if isday then
        inst.components.childspawner:StartSpawning()
    else
        inst.components.childspawner:StartSpawning()
    end
end


local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("ant_house.png")

    inst.AnimState:SetBuild("ant_house")
    inst.AnimState:SetBank("ant_house")
    inst.AnimState:PlayAnimation("idle")

    MakeObstaclePhysics(inst, 1.3)

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("childspawner")
	inst.components.childspawner:SetRegenPeriod(TUNING.BATCAVE_REGEN_PERIOD)
	inst.components.childspawner:SetSpawnPeriod(TUNING.BATCAVE_SPAWN_PERIOD)
	inst.components.childspawner:SetMaxChildren(2)
	inst.components.childspawner.childname = "antman2"
    inst.components.childspawner:StartSpawning()
    inst.components.childspawner:StartRegen()
    inst.components.childspawner:SetOnAddChildFn( onaddchild )
    inst.components.childspawner:SetSpawnedFn( onspawnchild )
    -- initialize with no children
    inst.components.childspawner.childreninside = 0

    inst:AddComponent("inspectable")

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetDist(6, 40)

    onisday(inst, TheWorld.state.iscaveday)
    inst:WatchWorldState("iscaveday", onisday)

	return inst
end

local function fn1()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("ant_house.png")

    inst.AnimState:SetBuild("ant_house")
    inst.AnimState:SetBank("ant_house")
    inst.AnimState:PlayAnimation("idle")

    MakeObstaclePhysics(inst, 1.3)

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("childspawner")
	inst.components.childspawner:SetRegenPeriod(TUNING.BATCAVE_REGEN_PERIOD)
	inst.components.childspawner:SetSpawnPeriod(TUNING.BATCAVE_SPAWN_PERIOD)
	inst.components.childspawner:SetMaxChildren(1)
	inst.components.childspawner.childname = "antman_warrior"
    inst.components.childspawner:StartSpawning()
    inst.components.childspawner:StartRegen()
    inst.components.childspawner:SetOnAddChildFn( onaddchild )
    inst.components.childspawner:SetSpawnedFn( onspawnchild )
    -- initialize with no children
    inst.components.childspawner.childreninside = 0

    inst:AddComponent("inspectable")

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetDist(6, 40)

    onisday(inst, TheWorld.state.iscaveday)
    inst:WatchWorldState("iscaveday", onisday)

	return inst
end

return Prefab("antcombhomecave", fn, assets, prefabs),
	   Prefab("antcombhomecavewarrior", fn1, assets, prefabs)
