local moon_assets =
{
    Asset("ANIM", "anim/ds_spider_basic.zip"),
    Asset("ANIM", "anim/ds_spider_snow.zip"),
    Asset("SOUND", "sound/spider.fsb"),
}

local prefabs =
{
    "spidergland",
    "monstermeat",
    "silk",
    "spider_web_spit",
	"snowspider_spike",
}

local brain = require "brains/spiderbrain"

local function ShouldAcceptItem(inst, item, giver)

    local in_inventory = inst.components.inventoryitem.owner ~= nil
    if in_inventory and not inst.components.eater:CanEat(item) then
        return false, "SPIDERNOHAT"
    end

    return (giver:HasTag("spiderwhisperer") and inst.components.eater:CanEat(item)) or
           (item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD)
end

local SPIDER_TAGS = { "spider" }
local SPIDER_IGNORE_TAGS = { "FX", "NOCLICK", "DECOR", "INLIMBO" }
local function GetOtherSpiders(inst, radius, tags)
    tags = tags or SPIDER_TAGS
    local x, y, z = inst.Transform:GetWorldPosition()
    return TheSim:FindEntities(x, y, z, radius, nil, SPIDER_IGNORE_TAGS, tags)
end

local function OnGetItemFromPlayer(inst, giver, item)

    if inst.components.eater:CanEat(item) then
        inst.components.eater:Eat(item)

        local state = "eat"
        if inst.components.inventoryitem.owner ~= nil then
            state = "idle"
        end

        inst.sg:GoToState(state)

        local playedfriendsfx = false
        if inst.components.combat.target == giver then
            inst.components.combat:SetTarget(nil)
        elseif giver.components.leader ~= nil and
            inst.components.follower ~= nil then
            
            if giver.components.minigame_participator == nil then
                giver:PushEvent("makefriend")
                giver.components.leader:AddFollower(inst)
                playedfriendsfx = true
            end
        end

        if giver.components.leader ~= nil then
            local spiders = GetOtherSpiders(inst, 15)
            local maxSpiders = TUNING.SPIDER_FOLLOWER_COUNT

            for i, v in ipairs(spiders) do
                if maxSpiders <= 0 then
                    break
                end

                if v.components.combat.target == giver then
                    v.components.combat:SetTarget(nil)
                elseif giver.components.leader ~= nil and
                    v.components.follower ~= nil and
                    v.components.follower.leader == nil then
                    if not playedfriendsfx then
                        giver:PushEvent("makefriend")
                        playedfriendsfx = true
                    end
                    giver.components.leader:AddFollower(v)
                end
                maxSpiders = maxSpiders - 1

                if v.components.sleeper:IsAsleep() then
                    v.components.sleeper:WakeUp()
                end
            end
        end
    -- I also wear hats
    elseif item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        local current = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if current ~= nil then
            inst.components.inventory:DropItem(current)
        end
        inst.components.inventory:Equip(item)
        inst.AnimState:Show("hat")
    end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("taunt")
    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end
end

local function HasFriendlyLeader(inst, target)
    local leader = inst.components.follower.leader
    local target_leader = (target.components.follower ~= nil) and target.components.follower.leader or nil
    
    if leader ~= nil and target_leader ~= nil then

        if target_leader.components.inventoryitem then
            target_leader = target_leader.components.inventoryitem:GetGrandOwner()
            -- Don't attack followers if their follow object has no owner
            if target_leader == nil then
                return true
            end
        end

        local PVP_enabled = TheNet:GetPVPEnabled()
        return leader == target or (target_leader ~= nil 
                and (target_leader == leader or (target_leader:HasTag("player") 
                and not PVP_enabled))) or
                (target.components.domesticatable and target.components.domesticatable:IsDomesticated() 
                and not PVP_enabled) or
                (target.components.saltlicker and target.components.saltlicker.salted
                and not PVP_enabled)
    
    elseif target_leader ~= nil and target_leader.components.inventoryitem then
        -- Don't attack webber's chester
        target_leader = target_leader.components.inventoryitem:GetGrandOwner()
        return target_leader ~= nil and target_leader:HasTag("spiderwhisperer")
    end

    return false
end


local TARGET_MUST_TAGS = { "_combat", "character" }
local TARGET_CANT_TAGS = { "spiderwhisperer", "spiderdisguise", "INLIMBO" }
local function FindTarget(inst, radius)
    if not inst.no_targeting then
        return FindEntity(
            inst,
            SpringCombatMod(radius),
            function(guy)
                return (not inst.bedazzled and (not guy:HasTag("monster") or guy:HasTag("player")))
                    and inst.components.combat:CanTarget(guy)
                    and not (inst.components.follower ~= nil and inst.components.follower.leader == guy)
                    and not HasFriendlyLeader(inst, guy)
            end,
            TARGET_MUST_TAGS,
            TARGET_CANT_TAGS
        )
    end
end

local function NormalRetarget(inst)
    return FindTarget(inst, inst.components.knownlocations:GetLocation("investigate") ~= nil and TUNING.SPIDER_INVESTIGATETARGET_DIST or TUNING.SPIDER_TARGET_DIST)
end

local function WarriorRetarget(inst)
    return FindTarget(inst, TUNING.SPIDER_WARRIOR_TARGET_DIST)
end

local function keeptargetfn(inst, target)
   return target ~= nil
        and target.components.combat ~= nil
        and target.components.health ~= nil
        and not target.components.health:IsDead()
        and not (inst.components.follower ~= nil and
                (inst.components.follower.leader == target or inst.components.follower:IsLeaderSame(target)))
end

local function BasicWakeCheck(inst)
    return inst.components.combat:HasTarget()
        or (inst.components.homeseeker ~= nil and inst.components.homeseeker:HasHome())
        or inst.components.burnable:IsBurning()
        or inst.components.freezable:IsFrozen()
        or inst.components.health.takingfiredamage
        or inst.components.follower:GetLeader() ~= nil
        or inst.summoned
end

local function ShouldSleep(inst)
    return TheWorld.state.iscaveday and not BasicWakeCheck(inst)
end

local function ShouldWake(inst)
    return not TheWorld.state.iscaveday
        or BasicWakeCheck(inst)
        or (inst:HasTag("spider_warrior") and
            FindTarget(inst, TUNING.SPIDER_WARRIOR_WAKE_RADIUS) ~= nil)
end

local function DoReturn(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    if home ~= nil and
        home.components.childspawner ~= nil and
        not (inst.components.follower ~= nil and
            inst.components.follower.leader ~= nil) then
        home.components.childspawner:GoHome(inst)
    end
end

local function OnIsCaveDay(inst, iscaveday)
    if not iscaveday then
        inst.components.sleeper:WakeUp()
    elseif inst:IsAsleep() then
        DoReturn(inst)
    end
end

local function OnEntitySleep(inst)
    if TheWorld.state.iscaveday then
        DoReturn(inst)
    end
end


local SPIDERDEN_TAGS = {"spiderden"}
local function SummonFriends(inst, attacker)
    local radius = (inst.prefab == "spider" or inst.prefab == "spider_warrior") and 
                    SpringCombatMod(TUNING.SPIDER_SUMMON_WARRIORS_RADIUS) or
                    TUNING.SPIDER_SUMMON_WARRIORS_RADIUS

    local den = GetClosestInstWithTag(SPIDERDEN_TAGS, inst, radius)

    if den ~= nil and den.components.combat ~= nil and den.components.combat.onhitfn ~= nil then
        den.components.combat.onhitfn(den, attacker)
    end
end

local function OnAttacked(inst, data)
    if inst.no_targeting then
        return
    end

    inst.defensive = false
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, function(dude)
        local should_share = dude:HasTag("spider")
            and not dude.components.health:IsDead()
            and dude.components.follower ~= nil
            and dude.components.follower.leader == inst.components.follower.leader

        if should_share and dude.defensive and not dude.no_targeting then
            dude.defensive = false
        end

        return should_share
    end, 10)
end

local function SetHappyFace(inst, is_happy)
    if is_happy then
        inst.AnimState:OverrideSymbol("face", inst.build, "happy_face")    
    else
        inst.AnimState:ClearOverrideSymbol("face")
    end
end

local function OnStartLeashing(inst, data)
    inst:SetHappyFace(true)

    if inst.recipe then
        local leader = inst.components.follower.leader
        if leader.components.builder and not leader.components.builder:KnowsRecipe(inst.recipe) and leader.components.builder:CanLearn(inst.recipe) then
            leader.components.builder:UnlockRecipe(inst.recipe)
        end
    end
end

local function OnStopLeashing(inst, data)
    inst.defensive = false
    inst.no_targeting = false

    if not inst.bedazzled then
        inst:SetHappyFace(false)
    end
end

local function OnTrapped(inst, data)
    inst.components.inventory:DropEverything()
end

local function OnEat(inst, data)
    if data.food.components.spidermutator and data.food.components.spidermutator:CanMutate(inst) then
        data.food.components.spidermutator:Mutate(inst)
    end
end

local function OnGoToSleep(inst)
    inst.components.inventoryitem.canbepickedup = true
end

local function OnWakeUp(inst)
    inst.components.inventoryitem.canbepickedup = false
end

local function CalcSanityAura(inst, observer)
    return observer:HasTag("spiderwhisperer") and 0 or inst.components.sanityaura.aura
end

local function HalloweenMoonMutate(inst, new_inst)
    local leader = inst ~= nil and inst.components.follower ~= nil
        and new_inst ~= nil and new_inst.components.follower ~= nil
        and inst.components.follower:GetLeader()
        or nil

    if leader ~= nil then
        new_inst.components.follower:SetLeader(leader)
    end
end

-- Used by the Spitter
local function MakeWeapon(inst)
    if inst.components.inventory ~= nil then
        local weapon = CreateEntity()
        weapon.entity:AddTransform()
        
        MakeInventoryPhysics(weapon)
        
        weapon:AddComponent("weapon")
        weapon.components.weapon:SetDamage(TUNING.SPIDER_SPITTER_DAMAGE_RANGED)
        weapon.components.weapon:SetRange(inst.components.combat.attackrange, inst.components.combat.attackrange + 4)
        weapon.components.weapon:SetProjectile("spider_web_spit")
        
        weapon:AddComponent("inventoryitem")
        weapon.persists = false
        weapon.components.inventoryitem:SetOnDroppedFn(weapon.Remove)
        
        weapon:AddComponent("equippable")
        inst.weapon = weapon
        inst.components.inventory:Equip(inst.weapon)
        inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
    end
end

local function HalloweenMoonMutate(inst, new_inst)
	local leader = inst ~= nil and inst.components.follower ~= nil
		and new_inst ~= nil and new_inst.components.follower ~= nil
		and inst.components.follower:GetLeader()
		or nil

	if leader ~= nil then
		new_inst.components.follower:SetLeader(leader)
		new_inst.components.follower:AddLoyaltyTime(
			inst.components.follower:GetLoyaltyPercent()
			* (new_inst.components.follower.maxfollowtime or inst.components.follower.maxfollowtime)
		)
	end
end

local function create_common(bank, build, tag, common_init)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .5)

    inst.DynamicShadow:SetSize(1.5, .5)
    inst.Transform:SetFourFaced()

    inst:AddTag("cavedweller")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("scarytoprey")
    inst:AddTag("canbetrapped")
    inst:AddTag("smallcreature")
    inst:AddTag("spider")
    inst:AddTag("drop_inventory_pickup")
    inst:AddTag("drop_inventory_murder")
 	inst:AddTag("walrus")
	inst:AddTag("houndfriend")
	
    if tag ~= nil then
        inst:AddTag(tag)
    end

    --trader (from trader component) added to pristine state for optimization
    inst:AddTag("trader")

    inst.AnimState:SetBank(bank)
    inst.AnimState:SetBuild("ds_spider_snow")
    inst.AnimState:PlayAnimation("idle")

	if common_init ~= nil then
		common_init(inst)
	end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    ----------
    inst.OnEntitySleep = OnEntitySleep

    -- locomotor must be constructed before the stategraph!
    inst:AddComponent("locomotor")
    inst.components.locomotor:SetSlowMultiplier( 1 )
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    
    inst:AddComponent("embarker")
    inst:AddComponent("drownable")
	
    inst:SetStateGraph("SGspider")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", .5)
    inst.components.lootdropper:AddRandomLoot("spidergland", .5)
    inst.components.lootdropper:AddRandomHauntedLoot("spidergland", 1)
    inst.components.lootdropper.numrandomloot = 1

    ---------------------
    MakeMediumBurnableCharacter(inst, "body")
    MakeMediumFreezableCharacter(inst, "body")
    inst.components.burnable.flammability = TUNING.SPIDER_FLAMMABILITY
    ---------------------

    inst:AddComponent("health")
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
    inst.components.combat:SetOnHit(SummonFriends)
    inst.components.combat:SetHurtSound("dontstarve/creatures/cavespider/hit_response")
    inst:AddComponent("follower")
    --inst.components.follower.maxfollowtime = TUNING.TOTAL_DAY_TIME

    ------------------

    inst:AddComponent("sleeper")
    inst.components.sleeper.watchlight = true	
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWake)
    ------------------

    inst:AddComponent("knownlocations")

    ------------------

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetStrongStomach(true) -- can eat monster meat!

    ------------------

    inst:AddComponent("inspectable")

    ------------------

    inst:AddComponent("inventory")
    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader:SetAbleToAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false

    ------------------

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/novositens.xml"
	inst.caminho = "images/inventoryimages/novositens.xml"		
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.canbepickedupalive = true	
	
    ------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura
	
    ------------------
    inst:AddComponent("debuffable")
    ------------------
    
    MakeFeedableSmallLivestock(inst, TUNING.SPIDER_PERISH_TIME)
    MakeHauntablePanic(inst)

    inst:SetBrain(brain)

    inst:ListenForEvent("attacked", OnAttacked)
    
    inst:ListenForEvent("startleashing", OnStartLeashing)
    inst:ListenForEvent("stopleashing", OnStopLeashing)
    
    inst:ListenForEvent("ontrapped", OnTrapped)
    inst:ListenForEvent("oneat", OnEat)

    inst:ListenForEvent("gotosleep", OnGoToSleep)
    inst:ListenForEvent("onwakeup", OnWakeUp)

    inst:WatchWorldState("iscaveday", OnIsCaveDay)
    OnIsCaveDay(inst, TheWorld.state.iscaveday)

    inst.build = build
    inst.SetHappyFace = SetHappyFace

    return inst
end

local variations = {1, 2, 3, 4, 5}

local function DoSpikeAttack(inst, pt)
	local x, y, z = pt:Get()
	local inital_r = 1
	x = GetRandomWithVariance(x, inital_r)
	z = GetRandomWithVariance(z, inital_r)

	shuffleArray(variations)

	local num = math.random(2, 4)
    local dtheta = PI * 2 / num
    local thetaoffset = math.random() * PI * 2
    local delaytoggle = 0
	for i = 1, num do
		local r = 1.1 + math.random() * 1.75
		local theta = i * dtheta + math.random() * dtheta * 0.8 + dtheta * 0.2
        local x1 = x + r * math.cos(theta)
        local z1 = z + r * math.sin(theta)
        if TheWorld.Map:IsVisualGroundAtPoint(x1, 0, z1) and not TheWorld.Map:IsPointNearHole(Vector3(x1, 0, z1)) then
            local spike = SpawnPrefab("snowspider_spike")
            spike.Transform:SetPosition(x1, 0, z1)
			spike:SetOwner(inst)
			if variations[i + 1] ~= 1 then
				spike.AnimState:OverrideSymbol("spike01", "spider_frost", "spike0"..tostring(variations[i + 1]))
			end
        end
    end
end

local function spider_moon_common_init(inst)
	inst.Transform:SetScale(1.25, 1.25, 1.25)
end

local function create_moon()
    local inst = create_common("spider_moon", "0", "spider_moon", spider_moon_common_init)

    if not TheWorld.ismastersim then
        return inst
    end

	inst.DoSpikeAttack = DoSpikeAttack

    inst.components.health:SetMaxHealth(TUNING.SPIDER_MOON_HEALTH)

    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_MOON_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.SPIDER_MOON_ATTACK_PERIOD)
    inst.components.combat:SetRange(TUNING.SPIDER_WARRIOR_ATTACK_RANGE, TUNING.SPIDER_WARRIOR_HIT_RANGE)
    inst.components.combat:SetRetargetFunction(1, WarriorRetarget)
    inst.components.combat:SetHurtSound("turnoftides/creatures/together/spider_moon/hit_response")

    inst.components.locomotor.walkspeed = TUNING.SPIDER_HIDER_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.SPIDER_HIDER_RUN_SPEED

    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED
    return inst
end

return Prefab("spider_snow", create_moon, moon_assets, prefabs)
