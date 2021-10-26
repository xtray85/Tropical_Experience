require "brains/perdbrain"
require "stategraphs/SGperd"

local THUNDERBIRD_RUN_SPEED = 5.5
local THUNDERBIRD_WALK_SPEED = 2

local assets=
{
	--Asset("ANIM", "anim/perd_basic.zip"),
	Asset("ANIM", "anim/thunderbird.zip"),
    Asset("ANIM", "anim/thunderbird_fx.zip"),
	Asset("SOUND", "sound/perd.fsb"),
}

local prefabs =
{
    "drumstick",
    "feather_thunder",
    "thunderbird_fx",
}

local loot = 
{
    "drumstick",
    "drumstick",
    "feather_thunder"
}

local function DoLightning(inst, target)
    local LIGHTNING_COUNT = 3
    local COOLDOWN = 60

    if TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.aporkalypse_active == true then
        LIGHTNING_COUNT = 10
    end

    for i=1, LIGHTNING_COUNT do
        inst:DoTaskInTime(0.4*i, function ()
            local rad = math.random(4, 8)
            local angle = i*((4*PI)/LIGHTNING_COUNT)
            local pos = Vector3(target.Transform:GetWorldPosition()) + Vector3(rad*math.cos(angle), 0, rad*math.sin(angle))
            TheWorld:PushEvent("ms_sendlightningstrike", pos) 
        end)
    end

    inst.cooling_down = true
    inst:DoTaskInTime(COOLDOWN, function () inst.cooling_down = false end)
end

local function spawnfx(inst)
    if not inst.fx then
        inst.fx = SpawnPrefab("thunderbird_fx")
        local x,y,z = inst.Transform:GetWorldPosition()
        inst.fx.Transform:SetPosition(x, y, z)

        local follower = inst.fx.entity:AddFollower()
        follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
        inst.fx:FacePoint(inst.Transform:GetWorldPosition())
   end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .75 )
    inst.Transform:SetFourFaced()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 50, .5)
--    MakePoisonableCharacter(inst)
     
    anim:SetBank("thunderbird")
    anim:SetBuild("thunderbird")
    anim:Hide("hat")

    inst:AddTag("character")
    inst:AddTag("berrythief")
 
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
 
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })
--    table.insert(inst.components.eater.foodprefs, "RAW")
--    table.insert(inst.components.eater.ablefoods, "RAW")
    
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetWakeTest( function() return true end)    --always wake up if we're asleep

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "pig_torso"
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.PERD_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.PERD_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.PERD_ATTACK_PERIOD)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
    	
    inst:AddComponent("inventory")
    inst:AddComponent("inspectable")

    inst:AddComponent("locomotor")
    inst.components.locomotor.runspeed = THUNDERBIRD_RUN_SPEED
    inst.components.locomotor.walkspeed = THUNDERBIRD_WALK_SPEED
	
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")			
    
    inst:SetStateGraph("SGthunderbird")	
    local brain = require "brains/thunderbirdbrain"
    inst:SetBrain(brain)

    
    inst.special_action = function (act)
        inst.sg:GoToState("thunder_attack")
    end

    local light = inst.entity:AddLight()
    light:SetFalloff(.7)
    light:SetIntensity(.75)
    light:SetRadius(2.5)
    light:SetColour(120/255, 120/255, 120/255)
    light:Enable(true)

    inst:DoTaskInTime(0.1, function() spawnfx(inst) end)

    inst.DoLightning = DoLightning
    MakeMediumFreezableCharacter(inst, "pig_torso")
    MakeMediumBurnableCharacter(inst, "pig_torso")

    inst.components.burnable.lightningimmune = true
    
    return inst
end

local function fx_fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("NOCLICK")
    anim:SetBank("thunderbird_fx")
    anim:SetBuild("thunderbird_fx")

    return inst
end

return Prefab( "forest/animals/thunderbird", fn, assets, prefabs),
       Prefab( "forest/animals/thunderbird_fx", fx_fn, assets, prefabs)