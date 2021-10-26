require "brains/bunnymanbrain"
require "stategraphs/SGmandrakeman"

local assets =
{
	Asset("ANIM", "anim/elderdrake_basic.zip"),
	Asset("ANIM", "anim/elderdrake_actions.zip"),
	Asset("ANIM", "anim/elderdrake_attacks.zip"),
    Asset("ANIM", "anim/elderdrake_build.zip"),   

	Asset("SOUND", "sound/bunnyman.fsb"),
}

local prefabs =
{
    "meat",
    "monstermeat",
    "manrabbit_tail",
}


local MANDRAKEMAN_DAMAGE = 40
local MANDRAKEMAN_HEALTH = 200
local MANDRAKEMAN_ATTACK_PERIOD = 2
local MANDRAKEMAN_RUN_SPEED = 6
local MANDRAKEMAN_WALK_SPEED = 3
local MANDRAKEMAN_PANIC_THRESH = .333
local MANDRAKEMAN_HEALTH_REGEN_PERIOD = 5
local MANDRAKEMAN_HEALTH_REGEN_AMOUNT = (200/120)*5
local MANDRAKEMAN_SEE_MANDRAKE_DIST = 8
local MANDRAKEMAN_TARGET_DIST = 10
local MANDRAKEMAN_DEFEND_DIST = 30
local MANDRAKE_SLEEP_TIME = 10
local MANDRAKE_SLEEP_RANGE = 15
local MANDRAKE_SLEEP_RANGE_COOKED = 25

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local function ontalk(inst, script)
	inst.SoundEmitter:PlaySound("dontstarve/creatures/bunnyman/idle_med")
end

local function CalcSanityAura(inst, observer)

	if inst.beardlord then
        return -TUNING.SANITYAURA_MED
    end
    
    if inst.components.follower and inst.components.follower.leader == observer then
		return TUNING.SANITYAURA_SMALL
	end
	
	return 0
end


local function ShouldAcceptItem(inst, item)
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        return true
	end
    if inst:HasTag("grumpy") then
        return false
    end
    if item.components.edible then
        
        if item.components.edible.foodtype == FOODTYPE.VEGGIE
           and inst.components.follower.leader
           and inst.components.follower:GetLoyaltyPercent() > 0.9 then
            return false
        end
        
        return true
    end

end

local function OnGetItemFromPlayer(inst, giver, item)
    --I eat food
    if item.components.edible ~= nil then
        --meat makes us friends (unless I'm a guard)
        if item.components.edible.foodtype == FOODTYPE.VEGGIE then
            if inst.components.combat:TargetIs(giver) then
                inst.components.combat:SetTarget(nil)
            elseif giver.components.leader ~= nil and not (inst:HasTag("guard") or giver:HasTag("monster")) then
                giver:PushEvent("makefriend")
                giver.components.leader:AddFollower(inst)
                inst.components.follower:AddLoyaltyTime(TUNING.RABBIT_CARROT_LOYALTY)
--                inst.components.follower.maxfollowtime =
--                    giver:HasTag("polite")
--                    and TUNING.PIG_LOYALTY_MAXTIME + TUNING.PIG_LOYALTY_POLITENESS_MAXTIME_BONUS
--                    or TUNING.PIG_LOYALTY_MAXTIME
            end
        end
        if inst.components.sleeper:IsAsleep() then
            inst.components.sleeper:WakeUp()
        end
    end	
	
	
    --I wear hats
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        local current = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if current ~= nil then
            inst.components.inventory:DropItem(current)
        end
        inst.components.inventory:Equip(item)
        inst.AnimState:Show("hat")
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end


local function OnAttacked(inst, data)
    --print(inst, "OnAttacked")
    local attacker = data.attacker
    inst.components.combat:SetTarget(attacker)
    inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude.prefab == inst.prefab end, MAX_TARGET_SHARES)
end

local function OnNewTarget(inst, data)
    inst.components.combat:ShareTarget(data.target, SHARE_TARGET_DIST, function(dude) return dude.prefab == inst.prefab end, MAX_TARGET_SHARES)
end

local function is_mandrake(item)
    return item:HasTag("mandrake")
end

local function RetargetFn(inst)
    
    local defenseTarget = inst
    local home = inst.components.homeseeker and inst.components.homeseeker.home
    if home and inst:GetDistanceSqToInst(home) < MANDRAKEMAN_DEFEND_DIST*MANDRAKEMAN_DEFEND_DIST then
        defenseTarget = home
    end
    local dist = MANDRAKEMAN_TARGET_DIST
    local invader = FindEntity(defenseTarget or inst, dist, function(guy)
        return guy:HasTag("player") and not guy:HasTag("mandrakeman") and inst:HasTag("grumpy")
    end)
    return invader

--[[
    return FindEntity(inst, TUNING.PIG_TARGET_DIST,
        function(guy)
            
            if guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) then
                if guy:HasTag("monster") then return guy end
                if guy:HasTag("player") and guy.components.inventory and guy:GetDistanceSqToInst(inst) < TUNING.MANDRAKEMAN_SEE_MANDRAKE_DIST*TUNING.MANDRAKEMAN_SEE_MANDRAKE_DIST and guy.components.inventory:FindItem(is_mandrake ) then return guy end
            end
        end)
        ]]
end
local function KeepTargetFn(inst, target)
    local home = inst.components.homeseeker and inst.components.homeseeker.home
    if home then
        return home:GetDistanceSqToInst(target) < MANDRAKEMAN_DEFEND_DIST*MANDRAKEMAN_DEFEND_DIST
               and home:GetDistanceSqToInst(inst) < MANDRAKEMAN_DEFEND_DIST*MANDRAKEMAN_DEFEND_DIST
    end
    return inst.components.combat:CanTarget(target)     
end


local function giveupstring(combatcmp, target)
    return STRINGS.MANDRAKEMAN_GIVEUP[math.random(#STRINGS.MANDRAKEMAN_GIVEUP)]
end


local function battlecry(combatcmp, target)
    
    if target and target.components.inventory then
    

        local item = target.components.inventory:FindItem(function(item) return item:HasTag("mandrake") end )    
        if item then
            return STRINGS.MANDRAKEMAN_MANDRAKE_BATTLECRY[math.random(#STRINGS.MANDRAKEMAN_MANDRAKE_BATTLECRY)]
        end
    end
    return STRINGS.MANDRAKEMAN_BATTLECRY[math.random(4)]
end 

local function DoAreaEffect(inst, knockout)
    inst.SoundEmitter:PlaySound("dontstarve/creatures/mandrake/death")
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, MANDRAKE_SLEEP_RANGE)
    for k,v in pairs(ents) do
        if v.components.sleeper then
            v.components.sleeper:AddSleepiness(10, MANDRAKE_SLEEP_TIME)
        elseif v:HasTag("player") and knockout then
            v.sg:GoToState("wakeup")
            v.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_KNOCKEDOUT") )
        end
    end
end

local function deathscream(inst)
    DoAreaEffect(inst)
end

local function transform(inst,grumpy)
    local anim = inst.AnimState
    if grumpy then    
        inst.AnimState:Show("head_angry")
        inst.AnimState:Hide("head_happy")
        inst:AddTag("grumpy")
    else
        inst.AnimState:Hide("head_angry")
        inst.AnimState:Show("head_happy")        
        inst.sg:GoToState("happy")
        inst:RemoveTag("grumpy")
    end 
end

local function transformtest(inst)
inst:DoTaskInTime(1+(math.random()*1) , 
function() 

    if TheWorld.state.isfullmoon and TheWorld.state.isnight or TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.aporkalypse_active == true then
--        if inst:HasTag("grumpy") then
          transform(inst)
--        end
    else
--        if not inst:HasTag("grumpy") then
          transform(inst,true)
--        end
    end
end)
end

local function OnWake(inst)
     transformtest(inst)
end

local function OnSleep(inst)
	 if inst.checktask then
	 	inst.checktask:Cancel()
	 	inst.checktask = nil
	 end
end

local function ShouldSleep(inst)
if TheWorld.state.isfullmoon then return false end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .75 )
    inst.Transform:SetFourFaced()
    local s = 1.25
    inst.Transform:SetScale(s,s,s)
    inst.entity:AddNetwork()

    inst.entity:AddLightWatcher()
    
    anim:SetBuild("elderdrake_build")  
    anim:SetBank("elderdrake")  

    MakeCharacterPhysics(inst, 50, .5)
--    MakePoisonableCharacter(inst)


    inst:AddTag("character")
    inst:AddTag("pig")
    inst:AddTag("mandrakeman")
    inst:AddTag("scarytoprey")

    inst:AddTag("grumpy")
    
    anim:PlayAnimation("idle_loop")
    anim:Hide("hat")
    anim:Hide("head_happy")

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    ------------------------------------------
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })
--    table.insert(inst.components.eater.foodprefs, "RAW")
--    table.insert(inst.components.eater.ablefoods, "RAW")

    ------------------------------------------
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "elderdrake_torso"
    inst.components.combat.panic_thresh = MANDRAKEMAN_PANIC_THRESH

    inst.components.combat.GetBattleCryString = battlecry
    inst.components.combat.GetGiveUpString = giveupstring

    MakeMediumBurnableCharacter(inst, "elderdrake_torso")

    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.MANDRAKEMANNAMES
    inst.components.named:PickNewName()
    
    ------------------------------------------
    inst:AddComponent("follower")
    inst.components.follower.maxfollowtime = TUNING.PIG_LOYALTY_MAXTIME
    ------------------------------------------
    inst:AddComponent("health")
    inst.components.health:StartRegen(MANDRAKEMAN_HEALTH_REGEN_AMOUNT, MANDRAKEMAN_HEALTH_REGEN_PERIOD)

    ------------------------------------------

    inst:AddComponent("inventory")
    
    ------------------------------------------

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"livinglog","livinglog"})
    --inst.components.lootdropper.numrandomloot = 1

    ------------------------------------------

    inst:AddComponent("knownlocations")
    inst:AddComponent("talker")
    inst.components.talker.ontalk = ontalk
    inst.components.talker.fontsize = 24
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0,-500,0)

    ------------------------------------------

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    
    ------------------------------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    ------------------------------------------

    inst:AddComponent("sleeper")
    
    ------------------------------------------
    MakeMediumFreezableCharacter(inst, "pig_torso")
    
    ------------------------------------------

    inst:AddComponent("inspectable")
	
    inst.components.inspectable.getstatus = function(inst) if inst.components.follower.leader ~= nil then return "FOLLOWER" end end
    ------------------------------------------
    
    inst:ListenForEvent("attacked", OnAttacked)    
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
	--inst.components.werebeast:SetOnWereFn(SetBeardlord)
	--inst.components.werebeast:SetOnNormaleFn(SetNormalRabbit)

    --CheckTransformState(inst)
	inst.OnEntityWake = OnWake
	inst.OnEntitySleep = OnSleep    
    
    
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper.nocturnal = true
	inst.components.sleeper:SetSleepTest(ShouldSleep)

    inst.components.combat:SetDefaultDamage(MANDRAKEMAN_DAMAGE)
    inst.components.combat:SetAttackPeriod(MANDRAKEMAN_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetRetargetFunction(3, RetargetFn)

	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = MANDRAKEMAN_RUN_SPEED
    inst.components.locomotor.walkspeed = MANDRAKEMAN_WALK_SPEED

    inst.components.health:SetMaxHealth(MANDRAKEMAN_HEALTH)

    inst:ListenForEvent("death", deathscream)

	inst:WatchWorldState("isdusk", transformtest)
	inst:WatchWorldState("isnight", transformtest) 
    
    inst.components.trader:Enable()
    --inst.Label:Enable(true)
    --inst.components.talker:StopIgnoringAll()	

    local brain = require "brains/bunnymanbrain"
    inst:SetBrain(brain)
    inst:SetStateGraph("SGmandrakeman")
	
	inst:ListenForEvent("beginaporkalypse", function() transformtest(inst) end, TheWorld)
	inst:ListenForEvent("endaporkalypse", function() transformtest(inst) end, TheWorld)
	inst:DoTaskInTime(0.2, function(inst) transformtest(inst) end)

    return inst
end


return Prefab( "common/characters/mandrakeman", fn, assets, prefabs) 
