require "prefabutil"

local assets =
    {
        Asset("ANIM", "anim/sandbag_small.zip"),
--		Asset("ANIM", "anim/sandbag.zip"),
    }

local prefabs =
    {
        "collapse_small",
		"sand",
			"gridplacer",
    }
	
local function OnIsPathFindingDirty(inst)
    if inst._ispathfinding:value() then
        if inst._pfpos == nil then
            inst._pfpos = inst:GetPosition()
            TheWorld.Pathfinder:AddWall(inst._pfpos:Get())
        end
    elseif inst._pfpos ~= nil then
        TheWorld.Pathfinder:RemoveWall(inst._pfpos:Get())
        inst._pfpos = nil
    end
end

local function InitializePathFinding(inst)
    inst:ListenForEvent("onispathfindingdirty", OnIsPathFindingDirty)
    OnIsPathFindingDirty(inst)
end

local function makeobstacle(inst)
    inst.Physics:SetActive(true)
    inst._ispathfinding:set(true)
end

local function clearobstacle(inst)
    inst.Physics:SetActive(false)
    inst._ispathfinding:set(false)
end

local anims =
{
    { threshold = 0, anim = "rubble" },
    { threshold = 0.4, anim = "heavy_damage" },
    { threshold = 0.5, anim = "half" },
    { threshold = 0.99, anim = "light_damage" },
    { threshold = 1, anim = { "full", "full", "full" } },
}

	local function resolveanimtoplay(inst, percent)
    for i, v in ipairs(anims) do
        if percent <= v.threshold then
            if type(v.anim) == "table" then
                -- get a stable animation, by basing it on world position
                local x, y, z = inst.Transform:GetWorldPosition()
                local x = math.floor(x)
                local z = math.floor(z)
                local q1 = #v.anim + 1
                local q2 = #v.anim + 4
                local t = ( ((x%q1)*(x+3)%q2) + ((z%q1)*(z+3)%q2) )% #v.anim + 1
                return v.anim[t]
            else
                return v.anim
            end
        end
    end
end

local function onhealthchange(inst, old_percent, new_percent)
    local anim_to_play = resolveanimtoplay(inst, new_percent)
    if new_percent > 0 then
        if old_percent <= 0 then
            makeobstacle(inst)
        end
 --       inst.AnimState:PlayAnimation(anim_to_play.."_hit")
        inst.AnimState:PlayAnimation(anim_to_play, false)
    else
        if old_percent > 0 then
            clearobstacle(inst)
        end
        inst.AnimState:PlayAnimation(anim_to_play)
    end
end

local function keeptargetfn()
    return false
end

local function onload(inst)
    if inst.components.health:IsDead() then
        clearobstacle(inst)
    end
end

local function onremove(inst)
    inst._ispathfinding:set_local(false)
    OnIsPathFindingDirty(inst)
end

    local function ondeploywall(inst, pt, deployer)
        --inst.SoundEmitter:PlaySound("dontstarve/creatures/spider/spider_egg_sack")
        local wall = SpawnPrefab("sandbag") 
        if wall ~= nil then 
            local x = math.floor(pt.x) + .5
            local z = math.floor(pt.z) + .5
            wall.Physics:SetCollides(false)
            wall.Physics:Teleport(x, 0, z)
            wall.Physics:SetCollides(true)
            inst.components.stackable:Get():Remove()
			
        end
    end

    local function onhammered(inst, worker)
    local num_loots = math.max(1, math.floor(2 * inst.components.health:GetPercent()))
    for i = 1, num_loots do
    inst.components.lootdropper:SpawnLootPrefab("sand")
    end

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())

        inst:Remove()
    end

    local function itemfn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		MakeInventoryFloatable(inst)		

        inst:AddTag("wallbuilder")

        inst.AnimState:SetBank("sandbag_small")
        inst.AnimState:SetBuild("sandbag_small")
        inst.AnimState:PlayAnimation("idle")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

        inst:AddComponent("inspectable")
        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"	

        inst:AddComponent("repairer")

	    inst.components.repairer.repairmaterial = "sandbag"
	    inst.components.repairer.healthrepairvalue = 200 / 2

        inst:AddComponent("deployable")
        inst.components.deployable.ondeploy = ondeploywall
        inst.components.deployable:SetDeployMode(DEPLOYMODE.WALL)
        inst.components.deployable:SetDeploySpacing(5)

        MakeHauntableLaunch(inst)

        return inst
    end

local function onhit(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sandbag")		
	
	local healthpercent = inst.components.health:GetPercent()
	local anim_to_play = resolveanimtoplay(inst, healthpercent)
	inst.AnimState:PlayAnimation(anim_to_play)		
end

local function onrepaired(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sandbag")		
	makeobstacle(inst)
end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        inst.Transform:SetEightFaced()

        MakeObstaclePhysics(inst, 1)
        inst.Physics:SetDontRemoveOnSleep(true)

        --inst.Transform:SetScale(0.5,0.5,0.5)

        inst:AddTag("wall")
        inst:AddTag("noauradamage")
        inst:AddTag("nointerpolate")
		inst:AddTag("removealagamento")

        inst.AnimState:SetBank("sandbag_small")
        inst.AnimState:SetBuild("sandbag_small")
	    inst.AnimState:PlayAnimation("full", false)

        MakeSnowCoveredPristine(inst)

        inst._pfpos = nil
        inst._ispathfinding = net_bool(inst.GUID, "_ispathfinding", "onispathfindingdirty")
        makeobstacle(inst)
        --Delay this because makeobstacle sets pathfinding on by default
        --but we don't to handle it until after our position is set
        inst:DoTaskInTime(0, InitializePathFinding)

        inst.OnRemoveEntity = onremove

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")
		
        inst:AddComponent("repairable")
	    inst.components.repairable.repairmaterial = "sandbag"
	    inst.components.repairable.onrepaired = onrepaired

        inst:AddComponent("combat")
	    inst.components.combat.onhitfn = onhit

        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(200)
        inst.components.health:SetCurrentHealth(200)
        inst.components.health.ondelta = onhealthchange
        inst.components.health.nofadeout = true
        inst.components.health.canheal = false

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(3)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit) 


        MakeHauntableWork(inst)

        inst.OnLoad = onload

        MakeSnowCovered(inst)

        return inst
    end

    return Prefab("sandbag", fn, assets, prefabs),
        Prefab("sandbag_item", itemfn, assets, { "sandbag_", "sandbag_item_placer" }),
        MakePlacer("sandbag_item_placer", "sandbag_small", "sandbag_small", "full", false, false, true, 1.0, nil, "eight")