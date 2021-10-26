--Need to make this enemy much less player focused.
--Doesn't target player by default.
    --Only if hit or if sharkittens threatened.

local assets =
{
    Asset("ANIM", "anim/tigershark_ground_build.zip"),
	Asset("ANIM", "anim/tigershark_ground.zip"),
    Asset("ANIM", "anim/tigershark_water_build.zip"),
	Asset("ANIM", "anim/tigershark_water.zip"),
	Asset("ANIM", "anim/tigershark_water_ripples_build.zip"),
}

local prefabs =
{
	"tigersharkshadow",
    "groundpound_fx",
    "groundpoundring_fx",
	"shark_gills",
}

SetSharedLootTable('tigershark',
{
    {"bell1", 1.00},
	{"harpoon", 1.00},
	{"shark_gills", 1.00},
	{"shark_gills", 1.00},
	{"shark_gills", 1.00},
	{"tigereye", 1.00},
})

local TARGET_DIST = 20
local HEALTH_THRESHOLD = 0.1
local HOME_PROTECTION_DISTANCE = 15

local brain = require "brains/tigersharkbrain"

local function ShouldSleep(inst)

if TheWorld.state.isday and not inst.sg:HasStateTag("specialattack") and inst.components.combat.target == nil and math.random() > 0.95 then
return true
end
return false
end

local function ShouldWake(inst)

return  not TheWorld.state.isday
end

local function MakeWater(inst)
    inst:ClearStateGraph()
    inst:SetStateGraph("SGtigershark_water")
    inst.AnimState:SetBuild("tigershark_water_build")
    inst.AnimState:AddOverrideBuild("tigershark_water_ripples_build")
    inst:AddTag("aquatic")
    inst.DynamicShadow:Enable(false)
end

local function MakeGround(inst)
    inst:ClearStateGraph()
    inst:SetStateGraph("SGtigershark_ground")
    inst.AnimState:SetBuild("tigershark_ground_build")
    inst:RemoveTag("aquatic")
    inst.DynamicShadow:Enable(true)
end

local function GetIsOnWater(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then return true
else return false end
end

local function GetTarget(inst)
    --Used for logic of moving between land and water states
    local target = inst.components.combat.target and inst.components.combat.target:GetPosition()

    if not target and inst:GetBufferedAction() then
        target = (inst:GetBufferedAction().target and inst:GetBufferedAction().target:GetPosition()) or inst:GetBufferedAction().pos
    end

    --Returns a position
    return target
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
	inst.AttackCounter = inst.AttackCounter + 0.3
end

local function GoHomeAction(inst)
    if inst.components.combat.target == nil then
        return
    end
    local homePos = inst.components.knownlocations:GetLocation("home")
    return homePos ~= nil
        and DoAction(inst, nil, ACTIONS.WALKTO, nil, homePos)
        or nil
end

local function RetargetFn(inst)
--inst.components.talker:Say(""..inst.components.health:GetPercent().."")
local invader = GetClosestInstWithTag("frog", inst, 17) or GetClosestInstWithTag("flup", inst, 17)
--local casa = GetClosestInstWithTag("tigersharkhome", inst, 20)
--local casa2 = GetClosestInstWithTag("tigersharkhome", inst, 60)
--local casaperto = GetClosestInstWithTag("tigersharkhome", inst, 10)
----------------------acha uma casa nova pro tiger----------------------------------
--if casa2 then
--    if inst.components.knownlocations ~= nil then
--        inst.components.knownlocations:RememberLocation("home", casa2:GetPosition())
--    end
--	if inst.components.homeseeker == nil then
--	    inst:AddComponent("homeseeker")
--	end
--    inst.components.homeseeker:SetHome(casa2)
--end
---------------------------------------------------------------------------------------
--acorda ao entardecer
if not TheWorld.state.isday and inst.sg:HasStateTag("sleeping") then
inst.sg:GoToState("wake") 
end

-----muda a forma de terrestre para aquatico ----------
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

--if not inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") and 
--(ground == GROUND.OCEAN_SWELL or
--ground == GROUND.OCEAN_COASTAL or
--ground == GROUND.OCEAN_COASTAL_SHORE or
--ground == GROUND.OCEAN_ROUGH or
--ground == GROUND.OCEAN_BRINEPOOL or
--ground == GROUND.OCEAN_BRINEPOOL_SHORE or
--ground == GROUND.OCEAN_HAZARDOUS) then
--MakeWater(inst) end

-----muda a forma de aquatico pra terrestre----------
--if inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") and ground ~= GROUND.OCEAN_SWELL and ground ~= GROUND.OCEAN_COASTAL and ground ~= GROUND.OCEAN_COASTAL_SHORE 
--and ground ~= GROUND.OCEAN_ROUGH and ground ~= GROUND.OCEAN_BRINEPOOL and ground ~=GROUND.OCEAN_BRINEPOOL_SHORE and ground ~=GROUND.OCEAN_HAZARDOUS then MakeGround(inst) end



--se ta dentro do lago entao makewater
--if casaperto and not inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") then 
--MakeWater(inst)
--inst.components.combat:SetTarget(nil)
--end

-- tem um invasor perto do rio entao pula nele
--if invader and casa and not inst.sg:HasStateTag("specialattack") and inst:HasTag("aquatic") then
--inst.components.combat:SetTarget(invader)
--inst.CanFly = true
--end

--ta no chao perto da casa e fora do lago e nao tem alvo entao pula na agua
--if casa and not inst.sg:HasStateTag("specialattack") and inst.components.combat.target == nil and not inst:HasTag("aquatic") then
--inst.components.talker:Say("casa")
--inst.components.combat:SetTarget(casa)
--inst.CanFly = true 
--end

-- dentro do lago nao ataca a casa
--if casa and inst.components.combat.target == casa and not inst.sg:HasStateTag("specialattack") and inst:HasTag("aquatic")then
--inst.components.combat:SetTarget(nil)
--end

--se tiver longe de casa volta pra lagoa
--if not casa2 and inst.components.combat and inst.components.combat == nil then
--local homePos = inst.components.knownlocations:GetLocation("home")
--if homePos then
--inst.components.talker:Say("casa2")
--inst.components.combat:SetTarget(nil)
--GoHomeAction(inst)
--end end


end

local function KeepTargetFn(inst, target)

return inst.components.combat:CanTarget(target)
end

local function ontimerdone(inst, data)
--    if data.name == "GroundPound" then
--        inst.CanFly = true
--    elseif data.name == "Run" then
--        inst.CanRun = true
--    end
end

local function OnSave(inst, data)
    data.CanRun = inst.CanRun
    data.NextFeedTime = GetTime() - inst.NextFeedTime
	data.entrada = inst.entrada
end

local function OnLoad(inst, data)
if data.entrada then inst.entrada = data.entrada end
    if data then
        inst.CanRun = data.CanRun or true
        inst.NextFeedTime = data.NextFeedTime or 0
    end
	
--local casa = GetClosestInstWithTag("tigersharkhome", inst, 17)
--se nao ta no lago makeground
--if not casa and inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") then 
--MakeGround(inst)
--end	
	
end

local function CanBeAttacked(inst, attacker)
    return not inst.sg:HasStateTag("specialattack")
end

--local function DoDespawn(inst)
    --Schedule new spawn time
    --Called at the time the tigershark actually leaves the world.
--    local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
--    if home ~= nil then
--        home.components.childspawner:GoHome(inst)
--    else
--        print("no!!!")
--        inst:Remove() --Tigershark was probably debug spawned in?
--    end
--end


local function OnWaterChange(inst, onwater)
--local casaperto = GetClosestInstWithTag("tigersharkhome", inst, 17)
--	inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crocodog/emerge")

	if onwater and not inst.sg:HasStateTag("specialattack") then
	MakeWater(inst) 
	end
	if not onwater and not inst.sg:HasStateTag("specialattack") then --and not casaperto then
	MakeGround(inst)
	end	


	inst.Physics:ClearCollidesWith(COLLISION.LIMITS)    
 --   local splash = SpawnPrefab("splash_water")
--local splash = SpawnPrefab("frogsplash")	

--    local ent_pos = Vector3(inst.Transform:GetWorldPosition())
--    splash.Transform:SetPosition(ent_pos.x, ent_pos.y, ent_pos.z)
end


local function OnEntityWake(inst)
	inst.components.tiletracker:Start()
end

local function OnEntitySleep(inst)
	inst.components.tiletracker:Stop()
end

function OnDeadTiger(inst)
local x, y, z = inst.Transform:GetLocalPosition()
inst:DoTaskInTime(50*FRAMES, function(inst)
if inst.entrada == nil then 
local fx = SpawnPrefab("woodlegs_key3")
if fx then fx.Transform:SetPosition(x, y, z) end
inst.entrada = 1
end end)
 end

local function fn()

	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    inst.Transform:SetFourFaced()
    inst.DynamicShadow:SetSize( 6, 3 )
--    inst.DynamicShadow:Enable(false)
    inst.DynamicShadow:Enable(true)
	
    inst:AddTag("scarytoprey")
    inst:AddTag("tigershark")
    inst:AddTag("largecreature")
    inst:AddTag("epic")
    inst:AddTag("monster")

    MakeCharacterPhysics(inst, 10, 0.5)
	inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)

    inst.AnimState:SetBank("tigershark")
    inst.AnimState:SetRayTestOnBB(true)
	
	
    inst.entity:SetPristine()   

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 8--TUNING.TIGERSHARK_WALK_SPEED
    inst.components.locomotor.runspeed = 10--TUNING.TIGERSHARK_RUN_SPEED

	inst:AddComponent("rowboatwakespawner")
	
	inst:AddComponent("talker")
    inst:AddComponent("inspectable")
    inst.no_wet_prefix = true

	inst:AddComponent("knownlocations")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(8000)
    inst.components.health.absorb = .3

    inst:AddComponent("eater")
    inst.components.eater.foodprefs = { "MEAT" }
    inst.components.eater.ablefoods = { "MEAT", "VEGGIE", "GENERIC" }

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('tigershark')

    inst:AddComponent("groundpounder")
    inst.components.groundpounder.destroyer = true
    inst.components.groundpounder.damageRings = 3
    inst.components.groundpounder.destructionRings = 1
    inst.components.groundpounder.numRings = 3
    inst.components.groundpounder.noTags = {"sharkitten"}

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(100)
    inst.components.combat.playerdamagepercent = .8
    inst.components.combat:SetRange(4, 4)
    inst.components.combat:SetAreaDamage(5, 1.25)
    inst.components.combat:SetAttackPeriod(3)
    inst.components.combat:SetRetargetFunction(1, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat:SetHurtSound("dontstarve_DLC001/creatures/bearger/hurt")
    inst.components.combat.canbeattackedfn = CanBeAttacked
    inst.components.combat.battlecryenabled = false
    inst.components.combat.notags = {"sharkitten"}

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWake)

    inst:ListenForEvent("killed", function(inst, data)
        if inst.components.combat and data and data.victim == inst.components.combat.target then
            inst.components.combat.target = nil
        end
    end)
	inst:ListenForEvent("death", OnDeadTiger)

    inst.CanRun = true --Can do charge attack
    inst.CanFly = false --Can do leap attack
	inst.podeFeed = false -- Can do feed  anim
	inst.podeFeed = false -- Can do feed  anim
	inst.podeTaunt = false -- Can do taunt  anim


    inst.AttackCounter = 0
	inst.TauntCounter = 0
	inst.FeedCounter = 0
	
    inst:AddComponent("tiletracker")
	inst.components.tiletracker:SetOnWaterChangeFn(OnWaterChange)	
	
	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep	
	
    inst.NextFeedTime = 0
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
--    inst.FindSharkHome = FindSharkHome
--    inst.DoDespawn = DoDespawn
    inst.GetTarget = GetTarget

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", ontimerdone)
    inst:ListenForEvent("attacked", OnAttacked)

inst.AnimState:SetBuild("tigershark_water_build")
inst.AnimState:AddOverrideBuild("tigershark_water_ripples_build")
inst:AddTag("aquatic")
inst:SetStateGraph("SGtigershark_water")

	
	inst:SetBrain(brain)

	return inst
end

return Prefab( "tigershark", fn, assets, prefabs)