require "brains/vampirebatbrain"
require "stategraphs/SGvampirebat"

local assets=
{
    Asset("ANIM", "anim/bat_basic.zip"),
    Asset("ANIM", "anim/bat_vamp_build.zip"),
    Asset("ANIM", "anim/bat_vamp_shadow.zip"),
    Asset("SOUND", "sound/bat.fsb"),
    Asset("INV_IMAGE", "bat"),
}

local prefabs =
{
    "guano",
    "batwing",
    "monstermeat",
}

local SLEEP_DIST_FROMHOME = 1
local SLEEP_DIST_FROMTHREAT = 12
local MAX_CHASEAWAY_DIST = 80
local MAX_TARGET_SHARES = 100
local SHARE_TARGET_DIST = 100

local VAMPIREBAT_HEALTH = 130
local VAMPIREBAT_DAMAGE = 25
local VAMPIREBAT_ATTACK_PERIOD = 1.8
local VAMPIREBAT_WALK_SPEED = 10

local function MakeTeam(inst, attacker)
    local leader = SpawnPrefab("teamleader")
    leader.components.teamleader:SetUp(attacker, inst)
    leader.components.teamleader:BroadcastDistress(inst)
end

local function OnWingDown(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/vampire_bat/flap")
end

local function OnWingDownShadow(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/vampire_bat/distant_flap")
end

local function ShouldSleep(inst)
if 1 == 1 then return false end
    if    (inst.components.combat and inst.components.combat.target)
       or (inst.components.burnable and inst.components.burnable:IsBurning() )
       or (inst.components.freezable and inst.components.freezable:IsFrozen() ) then
        return false
    end
    local nearestEnt = GetClosestInstWithTag("character", inst, SLEEP_DIST_FROMTHREAT)
    return nearestEnt == nil
end

local function ShouldWake(inst)    
    if    (inst.components.combat and inst.components.combat.target)
       or (inst.components.burnable and inst.components.burnable:IsBurning() )
       or (inst.components.freezable and inst.components.freezable:IsFrozen() ) then
        return true
    end
    local nearestEnt = GetClosestInstWithTag("character", inst, SLEEP_DIST_FROMTHREAT)
    return nearestEnt
end

local function ShouldWakeUp(inst)
    if     (inst.components.combat and inst.components.combat.target)
        or (inst.components.burnable and inst.components.burnable:IsBurning() )
        or (inst.components.freezable and inst.components.freezable:IsFrozen() )
--        or (inst.components.teamattacker and inst.components.teamattacker.inteam)
        or (inst.components.health and inst.components.health.takingfiredamage)
        or inst:HasTag("batfrenzy") then
        return true 
    end

    local nearestEnt = GetClosestInstWithTag("character", inst, SLEEP_DIST_FROMTHREAT)
    return nearestEnt == nil
end 

local function ShouldSleep(inst)
if 1 == 1 then return false end
    if     (inst.components.combat and inst.components.combat.target)
        or (inst.components.burnable and inst.components.burnable:IsBurning() )
        or (inst.components.freezable and inst.components.freezable:IsFrozen() )
--        or (inst.components.teamattacker and inst.components.teamattacker.inteam)
        or (inst.components.health and inst.components.health.takingfiredamage)
        or inst:HasTag("batfrenzy") then
        return false
    end
    local nearestEnt = GetClosestInstWithTag("character", inst, SLEEP_DIST_FROMTHREAT)
    return nearestEnt
end 

-- TEAM ATTACKER STUFF


local RETARGET_CANT_TAGS = {"vampirebat"}
local RETARGET_ONEOF_TAGS = {"character", "monster"}
local function retargetfn(inst)
    local ta = inst.components.teamattacker

    local newtarget = FindEntity(inst, TUNING.BAT_TARGET_DIST, function(guy)
            return inst.components.combat:CanTarget(guy)
        end,
        nil,
        RETARGET_CANT_TAGS,
        RETARGET_ONEOF_TAGS
    )

    if newtarget and not ta.inteam and not ta:SearchForTeam() then
        MakeTeam(inst, newtarget)
    end

    if ta.inteam and not ta.teamleader:CanAttack() then
        return newtarget
    end
end

local function KeepTarget(inst, target)
    return (inst.components.teamattacker.inteam and not inst.components.teamattacker.teamleader:CanAttack())
        or inst.components.teamattacker.orders == ORDERS.ATTACK
end

local function OnAttacked(inst, data)
    if not inst.components.teamattacker.inteam and not inst.components.teamattacker:SearchForTeam() then
        MakeTeam(inst, data.attacker)
    elseif inst.components.teamattacker.teamleader then
        inst.components.teamattacker.teamleader:BroadcastDistress(inst)   --Ask for  help!
    end

    if inst.components.teamattacker.inteam and not inst.components.teamattacker.teamleader:CanAttack() then
        local attacker = data and data.attacker
        inst.components.combat:SetTarget(attacker)
        inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("vampirebat") end, MAX_TARGET_SHARES)
    end
end

local function OnAttackOther(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude:HasTag("vampirebat") and not dude.components.health:IsDead() end, 5)
end

--local function OnWaterChange(inst, onwater)
--    if onwater then
--        inst.onwater = true
--    else
--        inst.onwater = false        
--    end
--end

local function onsave(inst, data)    
    if inst:HasTag("batfrenzy") then
        data.batfrenzy = true
    end
    if inst.sg:HasStateTag("sleeping") then
        data.forcesleep = true
    end
end

local function onload(inst, data)
  if data then
    if data.batfrenzy then
        inst:AddTag("batfrenzy")
    end
    if data.forcesleep then
        inst.sg:GoToState("forcesleep")
        inst.components.sleeper.hibernate = true
        inst.components.sleeper:GoToSleep()
    end    
  end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddNetwork()	
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    local shadow = inst.entity:AddDynamicShadow()
    shadow:SetSize( 1.5, .75 )
    inst.Transform:SetFourFaced()

    local scaleFactor = 0.9
    inst.Transform:SetScale(scaleFactor, scaleFactor, scaleFactor)
    
    MakeGhostPhysics(inst, 1, .5)
   -- inst.Physics:SetCollisionGroup(COLLISION.FLYERS)
    --inst.Physics:CollidesWith(COLLISION.FLYERS) 
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)

    inst:AddTag("vampirebat")
    inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("flying")

    anim:SetBank("bat")
    anim:SetBuild("bat_vamp_build")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
    
    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    inst.components.locomotor.walkspeed = VAMPIREBAT_WALK_SPEED

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater.strongstomach = true
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(VAMPIREBAT_HEALTH)
     
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED
    
    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(VAMPIREBAT_DAMAGE)
    inst.components.combat:SetAttackPeriod(VAMPIREBAT_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(3, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
    
    inst:SetStateGraph("SGvampirebat")
 
    local brain = require "brains/vampirebatbrain"
    inst:SetBrain(brain)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({})
    inst.components.lootdropper:AddRandomLoot("monstermeat", 6)
    inst.components.lootdropper:AddRandomLoot("pigskin", 3)
    inst.components.lootdropper:AddRandomLoot("batwing", 1)	
    inst.components.lootdropper.numrandomloot = 1	
	

    inst:AddComponent("inventory")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
    
    inst:ListenForEvent("wingdown", OnWingDown)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onattackother", OnAttackOther)
    --inst:ListenForEvent("death", OnKilled)

--    inst:AddComponent("tiletracker")
--    inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)    

    inst:AddComponent("teamattacker")
    inst.components.teamattacker.team_type = "vampirebat"
--    inst.components.teamattacker.team_type = "vampirebat"
--    inst.MakeTeam = MakeTeam

    MakeMediumBurnableCharacter(inst, "bat_body")
    MakeMediumFreezableCharacter(inst, "bat_body")

    inst.OnSave = onsave 
    inst.OnLoad = onload 

    inst.cavebat = false
    
    return inst
end

local function dodive(inst)
        local bat = SpawnPrefab("vampirebat")
        local spawn_pt = Vector3(inst.Transform:GetWorldPosition())
        if bat and spawn_pt then
            local x,y,z  = spawn_pt:Get()
            bat.Transform:SetPosition(x,y+30,z)           
            bat.sg:GoToState("glide")               
            bat:AddTag("batfrenzy")
			local player = GetClosestInstWithTag("player", inst, 30)
			if player then
			bat.components.combat:SuggestTarget(player)
--            bat:DoTaskInTime(2,function()  bat:PushEvent("attacked", {attacker = player, damage = 0, weapon = nil}) end)
			end
        end
        inst:Remove()

end


local function onsaveshadow(inst, data)    
    if inst.task then
        data.task = inst:TimeRemainingInTask(inst.task)
    end
end

local function onloadshadow(inst, data)
  if data then
    if data.task then
        inst.task = inst:DoTaskInTime(data.task,function() dodive(inst) end)
    end  
  end
end

local function circlingbatfn()
    local inst = CreateEntity()
    inst.entity:AddNetwork()	
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
	
    MakeGhostPhysics(inst, 1, .5)
   -- inst.Physics:SetCollisionGroup(COLLISION.FLYERS)
    --inst.Physics:CollidesWith(COLLISION.FLYERS) 
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)	

    anim:SetBank("bat_vamp_shadow")
    anim:SetBuild("bat_vamp_shadow")
    anim:PlayAnimation("shadow_flap_loop", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.walkspeed = VAMPIREBAT_WALK_SPEED

    inst.AnimState:SetMultColour(1,1,1,0)
    inst:AddComponent("colourtweener")
    inst.components.colourtweener:StartTween({1,1,1,1}, 3)
	
	inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(VAMPIREBAT_DAMAGE)
    inst.components.combat:SetAttackPeriod(VAMPIREBAT_ATTACK_PERIOD)

    inst.persists = false

    -- screech sound
--    inst:DoPeriodicTask(1, function() if math.random()<0.1 then inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/vampire_bat/distant_taunt") end end)

    inst.task = inst:DoTaskInTime(3, function() dodive(inst) end)
	inst:ListenForEvent("endaporkalypse", 
	function() 
    inst:Remove()
	end, TheWorld)	

    inst.OnSave = onsaveshadow
    inst.OnLoad = onloadshadow

    return inst
end

return Prefab("vampirebat", fn, assets, prefabs) ,
       Prefab("circlingbat", circlingbatfn, assets, prefabs)

