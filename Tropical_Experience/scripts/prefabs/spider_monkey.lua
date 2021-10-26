require "brains/spidermonkeybrain"
require "stategraphs/SGspidermonkey"

local assets = 
{
	--Asset("ANIM", "anim/kiki_basic.zip"),
	--Asset("ANIM", "anim/spidermonkey_build.zip"),
    Asset("ANIM", "anim/spiderape_basics.zip"),
    Asset("ANIM", "anim/spiderape_build.zip"),

	Asset("SOUND", "sound/monkey.fsb"),
}

local prefabs = 
{
	"poop",
--	"monkeyprojectile",
	"monstermeat",
	"spidergland",
}

local SLEEP_DIST_FROMHOME   = 1
local SLEEP_DIST_FROMTHREAT = 20
local MAX_CHASEAWAY_DIST    = 32
local MAX_TARGET_SHARES     = 5
local SHARE_TARGET_DIST     = 40

local SPIDER_MONKEY_SPEED_AGITATED = 5.5
local SPIDER_MONKEY_SPEED = 5.5		
local SPIDER_MONKEY_HEALTH = 400

local SPIDER_MONKEY_DAMAGE = 50
local SPIDER_MONKEY_ATTACK_PERIOD = 2
local SPIDER_MONKEY_ATTACK_RANGE = 4
local SPIDER_MONKEY_HIT_RANGE = 3
local SPIDER_MONKEY_MELEE_RANGE = 4
local SPIDER_MONKEY_TARGET_DIST = 8
local SPIDER_MONKEY_WAKE_RADIUS = 6

local SPIDER_MONKEY_DEFEND_DIST = 12

local SPIDER_MONKEY_MATING_SEASON_BABYDELAY = 480*1.5
local SPIDER_MONKEY_MATING_SEASON_BABYDELAY_VARIANCE = 0.5*480

local MONKEY_MELEE_DAMAGE = 20
local MONKEY_HEALTH = 125
local MONKEY_ATTACK_PERIOD = 2
local MONKEY_MELEE_RANGE = 3
local MONKEY_RANGED_RANGE = 17
local MONKEY_MOVE_SPEED = 7
local MONKEY_NIGHTMARE_CHASE_DIST = 40





SetSharedLootTable('spidermonkey',
{
    {'monstermeat',     1.0},
    {'monstermeat',     1.0},    
    {'spidergland',    0.75},
    {'beardhair',      0.75},
    {'beardhair',      0.75},
    {'beardhair',      0.75},
    {'silk',           0.25},
})

local function oneat(inst)
	-- Monkey ate some food. Give him some poop!
	if inst.components.inventory then
		local maxpoop = 3
		local poopstack = inst.components.inventory:FindItem(function(item) return item.prefab == "poop" end)
		if poopstack and poopstack.components.stackable.stacksize < maxpoop then
			local newpoop = SpawnPrefab("poop")
			inst.components.inventory:GiveItem(newpoop)
		elseif not poopstack then
			local newpoop = SpawnPrefab("poop")
			inst.components.inventory:GiveItem(newpoop)
		end
	end
end

local function OnAttacked(inst, data)
	inst.components.combat:SuggestTarget(data.attacker)
end

local function FindThreatToNest(inst)
    local notags = {"FX", "NOCLICK", "INLIMBO", "spidermonkey", "monkey"}
    local yestags = {"character", "monster"}
    if inst.components.homeseeker and inst.components.homeseeker:HasHome() then
        return FindEntity(inst.components.homeseeker.home, SPIDER_MONKEY_DEFEND_DIST, function(guy)
            return guy.components.health
                and not guy.components.health:IsDead()
                and inst.components.combat:CanTarget(guy)
        end, nil, notags, yestags)
    end
end

local function retargetfn(inst)
	local newtarget = FindThreatToNest(inst)

    if not newtarget then
        local notags = {"FX", "NOCLICK", "INLIMBO", "aquatic", "spidermonkey", "monkey"}
        local yestags = {"character", "monster"}
        newtarget = FindEntity(inst,SPIDER_MONKEY_TARGET_DIST, function(guy)
            return  guy.components.health
                and not guy.components.health:IsDead()
                and inst.components.combat:CanTarget(guy)
        end, nil, notags, yestags)
    end

	return newtarget	
end

local function KeepTarget(inst, target)
    local home = inst.components.homeseeker and inst.components.homeseeker.home

    if home then     
        return distsq(Vector3(home.Transform:GetWorldPosition()), Vector3(inst.Transform:GetWorldPosition())) < MAX_CHASEAWAY_DIST*MAX_CHASEAWAY_DIST       
    else
        return true
    end
end

local function IsInCharacterList(name)
	local characters = GetActiveCharacterList()

	for k,v in pairs(characters) do
		if name == v then
			return true
		end
	end
end

local function OnMonkeyDeath(inst, data)
	if data.inst:HasTag("monkey") then	-- A monkey died! 
		if IsInCharacterList(data.cause) then	-- And it was the player! Run home!
			-- Drop all items, go home
			inst:DoTaskInTime(math.random(), function() 
				if inst.components.inventory then
					inst.components.inventory:DropEverything(false, true)
				end

				if inst.components.homeseeker and inst.components.homeseeker.home then
					inst.components.homeseeker.home:PushEvent("monkeydanger")
				end
			end)
		end
	end
end

local function onpickup(inst, data)
	if data.item then
		if data.item.components.equippable and
		data.item.components.equippable.equipslot == EQUIPSLOTS.HEAD and not 
		inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) then
			-- Ugly special case for how the PICKUP action works.
			-- Need to wait until PICKUP has called "GiveItem" before equipping item.
			inst:DoTaskInTime(0.1, function() inst.components.inventory:Equip(data.item) end)		
		end
	end
end

local function DoFx(inst)
    if ExecutingLongUpdate then
        return
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/ghost_spawn")
    
    local fx = SpawnPrefab("statue_transition_2")
    if fx then
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx.AnimState:SetScale(.8, .8, .8)
    end
    fx = SpawnPrefab("statue_transition")
    if fx then
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx.AnimState:SetScale(.8, .8, .8)
    end
end

local function onnear(inst) 
    inst:AddTag("agitated")
    inst:PushEvent("agitated")
    -- inst.components.locomotor.walkspeed = SPIDER_MONKEY_SPEED_AGITATED
end

local function onfar(inst) 
    inst:RemoveTag("agitated")
    -- inst.components.locomotor.walkspeed = SPIDER_MONKEY_SPEED
end

local function OnSave(inst, data)

end

local function OnLoad(inst, data)

end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()	
    inst.soundtype = ""
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize(2, 1.25)
    inst.entity:AddNetwork()
	
	inst.Transform:SetFourFaced()

	--inst.Transform:SetScale(2.2, 2.2, 2.2)
	MakeCharacterPhysics(inst, 40, 1.5)
    MakeMediumBurnableCharacter(inst)
    MakeMediumFreezableCharacter(inst)

    anim:SetBank("spiderape")
	anim:SetBuild("SpiderApe_build")
	
	anim:PlayAnimation("idle_loop", true)

	inst:AddTag("spidermonkey")
	inst:AddTag("animal")

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("inventory")

	inst:AddComponent("inspectable")

	inst:AddComponent("thief")

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier(1)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = false }
    inst.components.locomotor.walkspeed = SPIDER_MONKEY_SPEED_AGITATED
    inst.components.locomotor.runspeed = SPIDER_MONKEY_SPEED_AGITATED    

    inst:AddComponent("combat")
    inst.components.combat:SetAttackPeriod(SPIDER_MONKEY_ATTACK_PERIOD)
    inst.components.combat:SetRange(SPIDER_MONKEY_MELEE_RANGE)
    inst.components.combat:SetRetargetFunction(1, retargetfn)
    inst.components.combat:SetDefaultDamage(SPIDER_MONKEY_DAMAGE)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(SPIDER_MONKEY_HEALTH)
    
    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("poop")
    inst.components.periodicspawner:SetRandomTimes(200, 400)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(15)
    inst.components.periodicspawner:Start()

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable("spidermonkey")
    inst.components.lootdropper.droppingchanceloot = false

	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })
	inst.components.eater:SetOnEatFn(oneat)

	inst:AddComponent("sleeper")
	-- inst.components.sleeper:SetNocturnal()
	
    inst:AddComponent("knownlocations")
    inst:AddComponent("herdmember")
    inst.components.herdmember:SetHerdPrefab("spider_monkey_herd")

	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(20, 23)
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetOnPlayerFar(onfar)
    
	inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED

	local brain = require "brains/spidermonkeybrain"
	inst:SetBrain(brain)
	inst:SetStateGraph("SGspidermonkey")

	inst.curious = true

    inst.listenfn = function(listento, data) OnMonkeyDeath(inst, data) end

	inst:ListenForEvent("onpickup", onpickup)
    inst:ListenForEvent("attacked", OnAttacked)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

	return inst
end

return Prefab("porkland/monsters/spider_monkey", fn, assets, prefabs)
