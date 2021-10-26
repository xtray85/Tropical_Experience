require "stategraphs/SGadultflytrap"

local ADULT_FLYTRAP_HEALTH = 400
local ADULT_FLYTRAP_DAMAGE = 30
local ADULT_FLYTRAP_ATTACK_PERIOD = 5
local ADULT_FLYTRAP_ATTACK_DIST = 4
local ADULT_FLYTRAP_STOPATTACK_DIST = 6

local assets=
{
    Asset("ANIM", "anim/venus_flytrap_lg_build.zip"),
	Asset("ANIM", "anim/venus_flytrap_planted.zip"),
    Asset("SOUND", "sound/tentacle.fsb"),
    Asset("MINIMAP_IMAGE", "mean_flytrap"),
}

local prefabs =
{
    "plantmeat",
    "venus_stalk",
    "vine",
    "nectar_pod",
}

SetSharedLootTable( 'adult_flytrap',
{
    {'plantmeat',   1.0},
    {'plantmeat',   0.5},   
    {'vine',        1.0},
    {'vine',        0.5},
    {'venus_stalk', 1.0},
    {'nectar_pod',  1.0},
    {'nectar_pod',  0.3},
})

local function grownplant(inst)
    local pt = Vector3(inst.Transform:GetWorldPosition())
    local angle = math.random() * 360
    if angle > 360 then angle = angle - 360 end    
    local radius = 15
    local offset = FindWalkableOffset(pt, angle*DEGREES, radius, 20, true, false) -- try avoiding walls
    if offset then
        
    local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, radius, {"flytrap"})
        if #ents<5 then            
            local plant = SpawnPrefab("mean_flytrap")
            local pt = pt+offset
            plant.Transform:SetPosition(pt.x,pt.y,pt.z)
            plant.sg:GoToState("enter")
            inst.sg:GoToState("taunt")
        end
    end

    inst.startGrowTask(inst)
end

local function startGrowTask(inst, time)
    if not time then
        time = math.random()*(480*2) + (480*2)
    end

    if inst.growtask then inst.growtask:Cancel() inst.growtask = nil end

    inst.taskinfo = nil
    inst.growtask, inst.growtaskinfo = inst:ResumeTask(time, function() grownplant(inst) end)    

    --inst.growtask = inst:DoTaskInTime(time,function() grownplant(inst) end)
end

local function retargetfn(inst)
    return FindEntity(inst, ADULT_FLYTRAP_ATTACK_DIST, function(guy) 
        if guy.components.combat and guy.components.health and not guy.components.health:IsDead() then
            return (guy.components.combat.target == inst or guy:HasTag("character") or guy:HasTag("monster") or guy:HasTag("animal")) and not guy:HasTag("flytrap") and not (guy.prefab == inst.prefab) and not guy:HasTag("plantkin")
        end
    end)
end


local function shouldKeepTarget(inst, target)
    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
        local distsq = target:GetDistanceSqToInst(inst)
        return distsq < ADULT_FLYTRAP_STOPATTACK_DIST*ADULT_FLYTRAP_STOPATTACK_DIST
    else
        return false
    end
end

local function onsave(inst, data)
    if inst.growtaskinfo then
        data.growtask = inst:TimeRemainingInTask(inst.growtaskinfo)
    end
    if inst:HasTag("spawned")then
        data.spawned = true
    end
end

local function onload(inst, data)
    if data then 
        if data.growtask then
            startGrowTask(inst, data.growtask)
        end        
        if data.spawned then
            inst:AddTag("spawned")
        end
    end    
     
end

local function onSpawn(inst)
    if not inst:HasTag("spawned") then
        inst.start_scale = 1.4
        inst.inc_scale = (1.8 - 1.4) /5
        inst.sg:GoToState("grow")  
        inst:AddTag("spawned")
    else
        inst.sg:GoToState("idle")
        inst.Transform:SetScale(1.8,1.8,1.8)    
        inst.Transform:SetRotation(math.random(360))
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local physics = inst.entity:AddPhysics()
    local sound = inst.entity:AddSoundEmitter()    
    inst.entity:AddNetwork()



    MakeObstaclePhysics(inst, .25)   
    inst.Transform:SetFourFaced()

    inst.AnimState:Hide("root")
    inst.AnimState:Hide("leaf")
    
    inst.AnimState:SetBank("venus_flytrap_planted")
    inst.AnimState:SetBuild("venus_flytrap_lg_build")
    inst.AnimState:PlayAnimation("idle")
 	inst.entity:AddSoundEmitter()

    inst:AddTag("character")
    inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("flytrap")
    inst:AddTag("hostile")
    inst:AddTag("animal")
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "mean_flytrap.png" )

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(ADULT_FLYTRAP_HEALTH)

    inst:AddComponent("combat")
    inst.components.combat:SetRange(ADULT_FLYTRAP_ATTACK_DIST)
    inst.components.combat:SetDefaultDamage(ADULT_FLYTRAP_DAMAGE)
    inst.components.combat:SetAttackPeriod(ADULT_FLYTRAP_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(GetRandomWithVariance(2, 0.5), retargetfn)
    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)
  
    MakeLargeFreezableCharacter(inst)
    MakeMediumBurnableCharacter(inst, "stem")
    
	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED
    
    inst.OnSave = onsave 
    inst.OnLoad = onload
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('adult_flytrap')
    
    inst:SetStateGraph("SGadultflytrap")
    
    inst.startGrowTask = startGrowTask

    startGrowTask(inst)

    inst.onSpawn = onSpawn
    inst:DoTaskInTime(0,function() onSpawn(inst) end)

    return inst
end

return Prefab( "marsh/monsters/adult_flytrap", fn, assets, prefabs) 
