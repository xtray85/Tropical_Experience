require "stategraphs/SGchicken"

local INTENSITY = .5

local assets =
{
	Asset("ANIM", "anim/chicken.zip"),
}

local prefabs =
{
	"drumstick",
	"drumstick_cooked",
	"bird_egg",
	"feather_chicken",
}

local chickensounds = 
{
	scream = "dontstarve_DLC001/creatures/buzzard/hurt",
	hurt = "dontstarve_DLC001/creatures/buzzard/hurt",
}

local brain = require "brains/chickenbrain"

local function OnWake(inst, pos)   
end

local function OnSleep(inst)
	if inst.checktask then
		inst.checktask:Cancel()
		inst.checktask = nil
	end
end

local function OnStartDay(inst)
    if inst.components.combat:HasTarget() ~= nil then
    	inst.components.combat:SetTarget(nil)
    end
end

local function CanShareTarget(dude)
    return not dude:IsInLimbo()
        and not dude.components.health:IsDead()
end

local function OnAttacked(inst, data)
if  data and data.attacker and data.attacker:HasTag("player") and not data.attacker:HasTag("sneaky") then
local x, y, z = inst.Transform:GetWorldPosition()
local eles = TheSim:FindEntities(x,y,z, 40,{"guard"})
for k,guardas in pairs(eles) do 
if guardas.components.combat and guardas.components.combat.target == nil then guardas.components.combat:SetTarget(data.attacker) end
end 
end

	inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, CanShareTarget, 1, {"chickenfamily"})
    if math.random() < 0.15 then
        local hot = inst.components.burnable
    	if hot ~= nil and hot:IsBurning() then
            local loot = inst.components.lootdropper:SpawnLootPrefab("bird_egg_cooked")
            loot.Transform:SetScale(.75, .75, .75)
        else
            local loot = inst.components.lootdropper:SpawnLootPrefab("bird_egg")
            loot.Transform:SetScale(.75, .75, .75)
        end
    end
end

local function OnDeath(inst)
	if math.random() < 0.15 then
    	local hot = inst.components.burnable
    	if inst:HasTag("fire") or (hot ~= nil and hot:IsBurning()) then
            local loot = inst.components.lootdropper:SpawnLootPrefab("drumstick_cooked")
            loot.Transform:SetScale(.75, .75, .75)
        else
            local loot = inst.components.lootdropper:SpawnLootPrefab("drumstick")
            loot.Transform:SetScale(.75, .75, .75)
        end
    end
    if math.random() < 0.5 then
    	local hot = inst.components.burnable
    	if hot ~= nil and hot:IsBurning() then
            local loot = inst.components.lootdropper:SpawnLootPrefab("bird_egg_cooked")
            loot.Transform:SetScale(.75, .75, .75)
        else
            local loot = inst.components.lootdropper:SpawnLootPrefab("bird_egg")
            loot.Transform:SetScale(.75, .75, .75)
        end
    end
	if math.random() < 0.1 then
    	local hot = inst.components.burnable
    	if hot ~= nil and hot:IsBurning() then
            local loot = inst.components.lootdropper:SpawnLootPrefab("ash")
        else
            local loot = inst.components.lootdropper:SpawnLootPrefab("feather_chicken")
        end
    end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()

	inst.entity:AddNetwork()

	shadow:SetSize(1, 0.75)
	
	inst.Transform:SetFourFaced()

	inst:AddTag("chickenfamily")

	MakeCharacterPhysics(inst, 1, 0.12)

	anim:SetBank("chicken")
	anim:SetBuild("chicken")
	anim:PlayAnimation("idle", true)
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = TUNING.RABBIT_RUN_SPEED

	inst:SetStateGraph("SGchicken")

	inst:AddTag("animal")
	inst:AddTag("prey")
	inst:AddTag("chicken")
	inst:AddTag("smallcreature")

	inst:SetBrain(brain)

	inst.data = {}

	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.SEEDS }, { FOODTYPE.SEEDS })
    inst.components.eater:SetCanEatRaw()

	inst:AddComponent("knownlocations")

	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "chest"

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(TUNING.RABBIT_HEALTH)
	inst.components.health:StartRegen(1, 8)
	
	MakeSmallBurnableCharacter(inst, "body")
	MakeTinyFreezableCharacter(inst, "chest")

	inst:AddComponent("lootdropper")

	inst:AddComponent("inspectable")
	inst:AddComponent("sleeper")
	
	    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")	

	inst.sounds = chickensounds

	inst.OnEntityWake = OnWake
	inst.OnEntitySleep = OnSleep 

	inst:WatchWorldState("startcaveday", OnStartDay)  

	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("death", OnDeath)

	inst:DoPeriodicTask(10.0, function() inst.improvise = true end)

	return inst
end

return Prefab("forest/animals/chicken", fn, assets, prefabs)
