require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"
require "behaviours/chaseandattack"
require "behaviours/leash"
require "behaviours/follow"
require "behaviours/faceentity"
require "behaviours/findlight"
require "behaviours/chattynode"

local MIN_FOLLOW_DIST = 5
local TARGET_FOLLOW_DIST = 7
local MAX_FOLLOW_DIST = 10

local RUN_AWAY_DIST = 7
local STOP_RUN_AWAY_DIST = 15

local SEE_FOOD_DIST = 10

local MAX_WANDER_DIST = 20

local MAX_CHASE_TIME = 60
local MAX_CHASE_DIST = 40

local TIME_BETWEEN_EATING = 30

local LEASH_RETURN_DIST = 15
local LEASH_MAX_DIST = 20

local 	    MONKEYBALL_USES = 10
local 	    MONKEYBALL_PASS_TO_PLAYER_CHANCE = 0.5

local NO_LOOTING_TAGS = { "INLIMBO", "catchable", "fire", "irreplaceable", "heavy", "outofreach" }
local NO_PICKUP_TAGS = deepcopy(NO_LOOTING_TAGS)
table.insert(NO_PICKUP_TAGS, "_container")

local PrimeapeBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function ShouldRunFn(inst, hunter)
    if inst.components.combat.target then
        return hunter:HasTag("player")
    end
end

local function GetPoop(inst)
    if inst.sg:HasStateTag("busy") then
        return
    end

    local target = FindEntity(inst,
        SEE_FOOD_DIST,
        function(item)
            return item.prefab == "poop"
                and not item:IsNear(inst.components.combat.target, RUN_AWAY_DIST)
                and item:IsOnValidGround()
        end,
        nil,
        NO_PICKUP_TAGS
    )

    return target ~= nil and BufferedAction(inst, target, ACTIONS.PICKUP) or nil
end

local ValidFoodsToPick =
{
    "cave_banana",
"livinglog",
"nightmarefuel",
"wathgrithrhat",
"spear_wathgrithr",
"honeycomb",		
"firestaff",
"transistor",
"silk",
"goldnugget",
"cutreeds",
"flint",
"rocks",	
"footballhat",
"charcoal",
"nitre",
"dug_grass",
"sapling",
"houndstooth",
"jellybean",
"icestaff",		
"royal_jelly",
"honey",
"trunk_summer",
"trunk_winter",
"trunk_cooked",
"wetgoop",
"butter",
"goatmilk",
"wormlight",
"seeds",
"seeds_cooked",
"bonestew",
"butterflymuffin",
"carrot_seeds",
"corn_seeds",
"dragonfruit_seeds",
"perogies",
"powcake",
"butterflywings",
"batwing",
"turkeydinner",
"unagi",
"glommerfuel",
"wormlight_lesser",
"tallbirdegg_cooked",
"acorn_cooked",
"petals",
"rottenegg",
"meatballs",
"frogglebunwich",
"pomegranate_seeds",
"jammypreserves",
"fruitmedley",
"honeynuggets",
"kabobs",
"monsterlasagna",
"lightbulb",
"ratatouille",
"stuffedeggplant",
"taffy",
"flowersalad",
"eggplant_seeds",
"watermelonicle",
"pumpkin_seeds",
"trailmix",
"cutlichen",
"petals_evil",
"batwing_cooked",
"plantmeat",
"plantmeat_cooked",
"foliage",
"phlegm",
"ice",
"gunpowder",
"featherhat",
"trap_teeth",
"beemine",
"blowdart_fire",
"blowdart_pipe",
"blowdart_sleep",
"blowdart_yellow",
"boomerang",
"manrabbit_tail",
"spoiled_food",
"durian_seeds",
"pigskin",
"watermelon_seeds",
"eel",
"eel_cooked",
"dragonfruit",
"mole",
"dragonfruit_cooked",
"meat",
"cookedmeat",
"meat_dried",
"monstermeat",
"cookedmonstermeat",
"monstermeat_dried",
"smallmeat",
"cookedsmallmeat",
"smallmeat_dried",
"drumstick",
"drumstick_cooked",
"froglegs",
"froglegs_cooked",
"fish",
"fish_cooked",
"blue_cap",
"blue_cap_cooked",
"green_cap",
"green_cap_cooked",
"red_cap",
"red_cap_cooked",
"eggplant",
"eggplant_cooked",
"carrot",
"carrot_cooked",
"corn",
"corn_cooked",
"pumpkin",
"pumpkin_cooked",
"cactus_meat",
"cactus_meat_cooked",
"cactus_flower",
"berries_juicy",
"berries_juicy_cooked",
"berries",
"berries_cooked",
"cave_banana_cooked",
"durian",
"durian_cooked",
"pomegranate",
"pomegranate_cooked",
"watermelon",
"watermelon_cooked",
"bird_egg",
"bird_egg_cooked",
"tallbirdegg",
}

local function ItemIsInList(item, list)
    for k, v in pairs(list) do
        if v == item or k == item then
            return true
        end
    end
end

local function SetCurious(inst)
    inst._curioustask = nil
    inst.curious = true
end

local function EatFoodAction(inst)
    if inst.sg:HasStateTag("busy") or
        (inst.components.eater:TimeSinceLastEating() ~= nil and inst.components.eater:TimeSinceLastEating() < TIME_BETWEEN_EATING) or
        (inst.components.inventory ~= nil and inst.components.inventory:IsFull()) or
        math.random() < .75 then
        return
    elseif inst.components.inventory ~= nil and inst.components.eater ~= nil then
        local target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
        if target ~= nil then
local map = TheWorld.Map
local x, y, z = target.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then				
            return BufferedAction(inst, target, ACTIONS.EAT) end
        end
    end

    --Get the stuff around you and store it in ents
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, SEE_FOOD_DIST,
        nil,
        NO_PICKUP_TAGS,
        { "_inventoryitem", "pickable", "readyforharvest" })

    --If you're not wearing a hat, look for a hat to wear!
    if inst.components.inventory ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) == nil then
        for i, item in ipairs(ents) do
            if item.components.equippable ~= nil and
                item.components.equippable.equipslot == EQUIPSLOTS.HEAD and
                item.components.inventoryitem ~= nil and
                item.components.inventoryitem.canbepickedup and
                item:IsOnValidGround() then
				
				

local map = TheWorld.Map
local x, y, z = item.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then				
                return BufferedAction(inst, item, ACTIONS.PICKUP) end
            end
        end
    end

    --Look for food on the ground, pick it up
    for i, item in ipairs(ents) do
        if item:GetTimeAlive() > 8 and
            item.components.inventoryitem ~= nil and
            item.components.inventoryitem.canbepickedup and
--            inst.components.eater:CanEat(item) and
            item:IsOnValidGround() then
local map = TheWorld.Map
local x, y, z = item.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then				
            return BufferedAction(inst, item, ACTIONS.PICKUP) end
        end
    end

    --Look for harvestable items, pick them.
    for i, item in ipairs(ents) do
        if item.components.pickable ~= nil and
            item.components.pickable.caninteractwith and
            item.components.pickable:CanBePicked() and
            (item.prefab == "worm" or ItemIsInList(item.components.pickable.product, ValidFoodsToPick)) then
local map = TheWorld.Map
local x, y, z = item.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then				
            return BufferedAction(inst, item, ACTIONS.PICK) end
        end
    end

    --Look for crops items, harvest them.
    for i, item in ipairs(ents) do
        if item.components.crop ~= nil and
            item.components.crop:IsReadyForHarvest() then
local map = TheWorld.Map
local x, y, z = item.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then				
            return BufferedAction(inst, item, ACTIONS.HARVEST) end
        end
    end

    if not inst.curious or inst.components.combat:HasTarget() then
        return
    end

    ---At the very end, look for a random item to pick up and do that.
    for i, item in ipairs(ents) do
        if item.components.inventoryitem ~= nil and
            item.components.inventoryitem.canbepickedup and
            item:IsOnValidGround() then
            inst.curious = false
            if inst._curioustask ~= nil then
                inst._curioustask:Cancel()
            end
            inst._curioustask = inst:DoTaskInTime(10, SetCurious)
local map = TheWorld.Map
local x, y, z = item.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_COASTAL and
ground ~= GROUND.OCEAN_COASTAL_SHORE and
ground ~= GROUND.OCEAN_SWELL and
ground ~= GROUND.OCEAN_ROUGH and
ground ~= GROUND.OCEAN_BRINEPOOL and
ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
ground ~= GROUND.OCEAN_WATERLOG and
ground ~= GROUND.OCEAN_HAZARDOUS then				
            return BufferedAction(inst, item, ACTIONS.PICKUP) end
        end
    end
end

local function OnLootingCooldown(inst)
    inst._canlootcheststask = nil
    inst.canlootchests = true
end

local function AnnoyLeader(inst)
    if inst.sg:HasStateTag("busy") then
        return
    end
    local lootchests = inst.canlootchests ~= false --nil defaults to true
    local px, py, pz = inst.harassplayer.Transform:GetWorldPosition()
    local mx, my, mz = inst.Transform:GetWorldPosition()
    local ents =
        lootchests and
        TheSim:FindEntities(mx, 0, mz, 30, nil, NO_LOOTING_TAGS, { "_inventoryitem", "_container" }) or
        TheSim:FindEntities(mx, 0, mz, 30, { "_inventoryitem" }, NO_PICKUP_TAGS)

    --Can we hassle the player by taking items from stuff he has killed or worked?
    for i, v in ipairs(ents) do
        if v.components.inventoryitem ~= nil and
            v.components.inventoryitem.canbepickedup and
            v.components.container == nil and
            v:GetTimeAlive() < 5 then
            return BufferedAction(inst, v, ACTIONS.PICKUP)
        end
    end

    --Can we hassle our leader by taking the items he wants?
    local ba = inst.harassplayer:GetBufferedAction()
    if ba ~= nil and ba.action.id == "PICKUP" then
        --The player wants to pick something up. Am I closer than the player?
        local tar = ba.target
        if tar ~= nil and
            tar:IsValid() and
            tar.components.inventoryitem ~= nil and not tar.components.inventoryitem:IsHeld() and
            tar.components.container == nil and
            not (tar:HasTag("irreplaceable") or tar:HasTag("heavy") or tar:HasTag("outofreach")) and
            not (tar.components.burnable ~= nil and tar.components.burnable:IsBurning()) and
            not (tar.components.projectile ~= nil and tar.components.projectile.cancatch and tar.components.projectile.target ~= nil) then
            --I'm closer to the item than the player! Lets go get it!
            local tx, ty, tz = tar.Transform:GetWorldPosition()
            return distsq(px, pz, tx, tz) > distsq(mx, mz, tx, tz)
                and BufferedAction(inst, tar, ACTIONS.PICKUP)
                or nil
        end
    end

    --Can we hassle our leader by toying with his chests? (or bags?)
    --NOTE: stealing throws the item onto the ground, so we do not
    --      need to filter items as strictly as the pickup action.
    if lootchests then
        local items = {}
        for i, v in ipairs(ents) do
            if v.components.container ~= nil and
                v.components.container.canbeopened and
                not v.components.container:IsOpen() and
                v:GetDistanceSqToPoint(px, 0, pz) < 225--[[15 * 15]] then
                for k = 1, v.components.container.numslots do
                    local item = v.components.container.slots[k]
                    if item ~= nil then
                        table.insert(items, item)
                    end
                end
            end
        end

        if #items > 0 then
            inst.canlootchests = false
            if inst._canlootcheststask ~= nil then
                inst._canlootcheststask:Cancel()
            end
            inst._canlootcheststask = inst:DoTaskInTime(math.random(15, 30), OnLootingCooldown)
            local item = items[math.random(#items)]
            local act = BufferedAction(inst, item, ACTIONS.STEAL)
            act.validfn = function()
                local owner = item.components.inventoryitem ~= nil and item.components.inventoryitem.owner or nil
                return owner ~= nil
                    and not (owner.components.inventoryitem ~= nil and owner.components.inventoryitem:IsHeld())
                    and not (owner.components.burnable ~= nil and owner.components.burnable:IsBurning())
                    and owner.components.container ~= nil
                    and owner.components.container.canbeopened
                    and not owner.components.container:IsOpen()
            end
            return act
        end
    end
end

local function GetFaceTargetFn(inst)
    return inst.components.combat.target
end

local function KeepFaceTargetFn(inst, target)
    return target == inst.components.combat.target
end

local function GoHome(inst)
    local homeseeker = inst.components.homeseeker
    if homeseeker and homeseeker.home and homeseeker.home:IsValid()
        and (not homeseeker.home.components.burnable or not homeseeker.home.components.burnable:IsBurning()) then
        return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

local function EquipWeapon(inst, weapon)
    if not weapon.components.equippable:IsEquipped() then
        inst.components.inventory:Equip(weapon)
    end
end

local function HasValidHome(inst)
    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
    return home ~= nil
        and home:IsValid()
        and not (home.components.burnable ~= nil and home.components.burnable:IsBurning())
        and not home:HasTag("burnt")
end

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function GetHomePos(inst)
    return HasValidHome(inst) and inst.components.homeseeker:GetHomePos()
end

local function GetNoLeaderHomePos(inst)
    if GetLeader(inst) then
        return
    end
    return GetHomePos(inst)
end

local function HasMonkeyBait(inst)
    local ball = inst.components.inventory:FindItem(function(item) return item:HasTag("monkeybait") end)
    if ball then
        -- print("I have the ball!")
        return true
    end
end

local function GetRidOfTheBall(inst)
local ball = inst.components.inventory:FindItem(function(item) return item:HasTag("monkeybait") end)
local action
local jogador = GetClosestInstWithTag("player", inst, 10)
if jogador and ball and math.random() < MONKEYBALL_PASS_TO_PLAYER_CHANCE then
--inst.components.talker:Say("casa")
local x, y, z = inst.Transform:GetWorldPosition()
inst.sg:GoToState("throw")
local bomba = SpawnPrefab(ball.prefab)
bomba.Transform:SetPosition(x, y, z)
bomba.components.finiteuses.current = ball.components.finiteuses.current
bomba.components.complexprojectile:Launch(jogador:GetPosition(), inst)
ball:Remove()
elseif ball then
local pos = inst:GetPosition()
local offset, _, _ = FindWalkableOffset(inst:GetPosition(), math.random()*2*PI, math.random()*5 + 5, 8, true, false) -- try to avoid walls
if offset then		
--inst.components.talker:Say("casa")
local x, y, z = inst.Transform:GetWorldPosition()
inst.sg:GoToState("throw")
local bomba = SpawnPrefab(ball.prefab)
bomba.Transform:SetPosition(x, y, z)
bomba.components.finiteuses.current = ball.components.finiteuses.current
bomba.components.complexprojectile:Launch(pos + offset, inst)
ball:Remove()		

elseif ball then
--inst.components.talker:Say("casa")
local x, y, z = inst.Transform:GetWorldPosition()
inst.sg:GoToState("throw")
local bomba = SpawnPrefab(ball.prefab)
bomba.Transform:SetPosition(x, y, z)
bomba.components.finiteuses.current = ball.components.finiteuses.current
bomba.components.complexprojectile:Launch(pos + Vector3(math.random(-4, 4), math.random(-4, 4), math.random(-4, 4)),inst)
ball:Remove()			
end
-- doer, target, action, invobject, pos, recipe, distance, rotation
end
 

 
    return action
end

function PrimeapeBrain:OnStart()
    
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.hauntable and self.inst.components.hauntable.panic end, "PanicHaunted", Panic(self.inst)),
        WhileNode( function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),

        --Monkeys go home when quakes start.
        EventNode(self.inst, "gohome", 
            DoAction(self.inst, GoHome)),

        SequenceNode{
            ConditionNode(function() return HasMonkeyBait(self.inst) end, "HasBall"),
            ParallelNodeAny {
                WaitNode(4+math.random()*2),
                Panic(self.inst),
            },
            DoAction(self.inst, GetRidOfTheBall),
        },
        
        Follow(self.inst, function() return FindEntity(self.inst, 20, HasMonkeyBait, {"primeape"}) end, 1, 1.5, 2),

        --In combat (with the player)... Should only ever use poop throwing.
        RunAway(self.inst, "character", RUN_AWAY_DIST, STOP_RUN_AWAY_DIST, function(hunter) return ShouldRunFn(self.inst, hunter) end),
        WhileNode(function() return self.inst.components.combat.target and self.inst.components.combat.target:HasTag("player") and self.inst.HasAmmo(self.inst) end, "Attack Player",
            SequenceNode({
                ActionNode(function() EquipWeapon(self.inst, self.inst.weaponitems.thrower) end, "Equip thrower"),
                ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST),
            })),
        --Pick up poop to throw
        WhileNode(function() return self.inst.components.combat.target and self.inst.components.combat.target:HasTag("player") and not self.inst.HasAmmo(self.inst) end, "Pick Up Poop", 
            DoAction(self.inst, GetPoop)),
        --Eat/ pick/ harvest foods.
        WhileNode(function() return self.inst.components.combat.target and self.inst.components.combat.target:HasTag("player") or self.inst.components.combat.target == nil end, "Should Eat",
            DoAction(self.inst, EatFoodAction)),
        --Priority must be lower than poop pick up or it will never happen.
        WhileNode(function() return self.inst.components.combat.target and self.inst.components.combat.target:HasTag("player") and not self.inst.HasAmmo(self.inst) end, "Leash to Player",
        PriorityNode{
            Leash(self.inst, function() if self.inst.components.combat.target then return self.inst.components.combat.target:GetPosition() end end, LEASH_MAX_DIST, LEASH_RETURN_DIST),
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn)
        }),


        --In combat with everything else
        WhileNode(function() return self.inst.components.combat.target ~= nil and not self.inst.components.combat.target:HasTag("player") end, "Attack NPC", --For everything else
            SequenceNode({
                ActionNode(function() EquipWeapon(self.inst, self.inst.weaponitems.hitter) end, "Equip hitter"),
                ChaseAndAttack(self.inst, MAX_CHASE_TIME, MAX_CHASE_DIST),
            })),


            ChattyNode(self.inst, "PIG_TALK_FOLLOWWILSON",
                Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST)),
            IfNode(function() return GetLeader(self.inst) end, "has leader",
                ChattyNode(self.inst, "PIG_TALK_FOLLOWWILSON",
                    FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn ))),

            Leash(self.inst, GetNoLeaderHomePos, LEASH_MAX_DIST, LEASH_RETURN_DIST),
			
        --Following
        WhileNode(function() return self.inst.harassplayer end, "Annoy Leader", 
            DoAction(self.inst, AnnoyLeader)),
        Follow(self.inst, function() return self.inst.harassplayer end, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        
        --Doing nothing
        WhileNode(function() return self.inst.harassplayer  end, "Wander Around Leader", 
            Wander(self.inst, function() if self.inst.harassplayer  then return self.inst.harassplayer:GetPosition() end end, MAX_FOLLOW_DIST)),
        WhileNode(function() return not self.inst.harassplayer and not self.inst.components.combat.target end,
        "Wander Around Home", Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST))
    }, .25)
    self.bt = BT(self.inst, root)
end

return PrimeapeBrain