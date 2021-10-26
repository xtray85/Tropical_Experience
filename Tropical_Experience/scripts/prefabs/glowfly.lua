require("brains/mosquitobrain")
require "stategraphs/SGglowfly"

local GLOWFLY_COCOON_HEALTH = 300
local SPRING_COMBAT_MOD = 1.33
local SEG_TIME = 30

local assets=
{
	Asset("ANIM", "anim/lantern_fly.zip"),	
	Asset("INV_IMAGE", "lantern_fly"),
}

local prefabs = 
{
	"lightbulb",
}

local sounds =
{
	takeoff = "dontstarve/creatures/mosquito/mosquito_takeoff",
	attack = "dontstarve/creatures/mosquito/mosquito_attack",
	buzz = "dontstarve_DLC003/creatures/glowfly/buzz_LP",
	hit = "dontstarve_DLC003/creatures/glowfly/hit",
	death = "dontstarve_DLC003/creatures/glowfly/death",
	explode = "dontstarve/creatures/mosquito/mosquito_explo",
}

SetSharedLootTable( 'glowfly',
{
	{'lightbulb', .1},
})


SetSharedLootTable( 'glowflyinventory',
{
	{'lightbulb', 1},
})

local INTENSITY = .75
local SHARE_TARGET_DIST = 30
local MAX_TARGET_SHARES = 10

local function fadein(inst)
	if inst.components.fader then
    inst.components.fader:StopAll()
	end
    inst.Light:Enable(true)
	if inst:IsAsleep() then
		inst.Light:SetIntensity(INTENSITY)
	else
		inst.Light:SetIntensity(0)
		if inst.components.fader then
		inst.components.fader:Fade(0, INTENSITY, 3+math.random()*2, function(v) inst.Light:SetIntensity(v) end, function() end)
		end
	end
end

local function fadeout(inst)
	if inst.components.fader then
    inst.components.fader:StopAll()
	end
	if inst:IsAsleep() then
		if inst.components.fader then
		inst.Light:SetIntensity(0)
		end
	else
		inst.components.fader:Fade(INTENSITY, 0, .75+math.random()*1, function(v) inst.Light:SetIntensity(v) end, function() inst.Light:Enable(false) end)
	end
end

local function onnear(inst)
	if inst:HasTag("readytohatch") then
		inst:DoTaskInTime(5+math.random()*3, function() inst:PushEvent("hatch") end)
	end
end

local function changetococoon(inst,forced)
    local pos = Vector3(inst.Transform:GetWorldPosition() )
    local bug = SpawnPrefab("glowfly_cocoon")
    if bug then
        bug.Transform:SetPosition(pos.x,pos.y,pos.z)
    end 

	inst.SoundEmitter:KillSound("buzz")	
	inst:Remove()


	
--	if not TheWorld.state.issummer then
--        inst:AddTag("readytohatch")
--        inst:AddComponent("playerprox")
--        inst.components.playerprox:SetDist(5,10)
--        inst.components.playerprox:SetOnPlayerNear(onnear)                          
--    end
end

local function updatelight(inst)
--print(TheWorld.state.remainingdaysinseason)


--if TheWorld.state.remainingdaysinseason < 4 and not inst:HasTag("cocoon") and math.random() < 0.30 then

if TheWorld.state.iswinter and not inst:HasTag("cocoon") and math.random() < 0.30 then

local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))
if ground ~= GROUND.OCEAN_SWELL and ground ~= GROUND.OCEAN_WATERLOG and ground ~= GROUND.OCEAN_BRINEPOOL and ground ~= GROUND.OCEAN_HAZARDOUS and ground ~= GROUND.OCEAN_ROUGH and ground ~= GROUND.OCEAN_COASTAL_SHORE and ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and ground ~= GROUND.OCEAN_COASTAL then
return changetococoon(inst)
end	

end


    if (TheWorld.state.isnight or TheWorld.state.isdusk or inst:HasTag("under_leaf_canopy")  ) and not inst.components.inventoryitem.owner then
        if not inst.lighton then
            fadein(inst)
        else
            inst.Light:Enable(true)
            inst.Light:SetIntensity(INTENSITY)
        end
        inst.lighton = true
    else
        if inst.lighton then
            fadeout(inst)
        else
            inst.Light:Enable(false)
            inst.Light:SetIntensity(0)
        end
        inst.lighton = false
    end

end

local function OnWorked(inst, worker)
    if worker.components.inventory ~= nil then
        worker.components.inventory:GiveItem(inst, nil, inst:GetPosition())
    end
end

local function OnWake(inst)
	if not inst.components.inventoryitem:IsHeld() and not inst:HasTag("cocoon") then
		inst.SoundEmitter:PlaySound(inst.sounds.buzz, "buzz")
	end
end

local function OnSleep(inst)	
	inst.SoundEmitter:KillSound("buzz")
end


local function OnPickedUp(inst)
	inst.SoundEmitter:KillSound("buzz")
	inst.components.lootdropper:SetChanceLootTable('glowflyinventory')
end

local function KillerRetarget(inst)
	local range = 20
	if TheWorld.state.isspring then
		range = range * SPRING_COMBAT_MOD
	end
	local notags = {"FX", "NOCLICK","INLIMBO", "insect"}
	local yestags = {"character", "animal", "monster"}
	return FindEntity(inst, range, function(guy)
		return inst.components.combat:CanTarget(guy)
	end, nil, notags, yestags)
end

local function OnAttacked(inst, data)
	inst.components.combat:SetTarget(data.attacker)
	local shareRange = SHARE_TARGET_DIST
	if TheWorld.state.isspring then
		shareRange = shareRange * SPRING_COMBAT_MOD
	end
	inst.components.combat:ShareTarget(data.attacker, shareRange, function(dude) return dude:HasTag("mosquito") and not dude.components.health:IsDead() end, MAX_TARGET_SHARES)
end

local function OnKilled(inst)
	if inst.components.fader then
    inst.components.fader:Fade(INTENSITY, 0, .75+math.random()*1, function(v) inst.Light:SetIntensity(v) end, function() inst.Light:Enable(false) end)
	end
end

local function OnBorn(inst)	
	if inst.components.fader then
	inst.components.fader:Fade(0, INTENSITY, .75+math.random()*1, function(v) inst.Light:SetIntensity(v) end)
	end
end


local function OnEntityWake(inst)

	if not inst.components.inventoryitem:IsHeld() then
		inst.SoundEmitter:PlaySound(inst.sounds.buzz, "buzz")
	end
end

local function OnEntitySleep(inst)
	inst.SoundEmitter:KillSound("buzz")
end

local function checkRemoveGlowfly(inst)
local jogador = GetClosestInstWithTag("player", inst, 80)
	if not inst:HasTag("cocoonspawn") and not jogador then
--		print("REMOVING GLOWFLY, TOO FAR AWAY")
		inst:Remove()
	end
end
 
local function OnRemoveEntity(inst)	
end

local function begincocoonstage(inst)
	inst:AddTag("wantstococoon")
end

local function inspect(inst)
    if inst:HasTag("cocoon") then
        return "COCOON"
    elseif inst.components.health:GetPercent() <= 0 then
    	return "DEAD"    
    elseif inst.components.sleeper:IsAsleep() then
    	return "SLEEPING"	
    end
end


local function setcocoontask(inst, time)
	if not time then
		time = math.random()*3
	end
	inst.cocoon_task, inst.cocoon_taskinfo = inst:ResumeTask(time, function() inst.begincocoonstage(inst) end ) --+ (math.random()*TUNING.SEG_TIME*2)
end


local function OnDropped(inst)
	inst.components.lootdropper:SetChanceLootTable('glowfly')
	inst.sg:GoToState("idle")
	if inst.components.workable then
		inst.components.workable:SetWorkLeft(1)
	end
	if inst.brain then
		inst.brain:Start()
	end
	if inst.sg then
		inst.sg:Start()
	end
	if inst.components.stackable then
		while inst.components.stackable:StackSize() > 1 do
			local item = inst.components.stackable:Get()
			if item then
				if item.components.inventoryitem then
					item.components.inventoryitem:OnDropped()
				end
				item.Physics:Teleport(inst.Transform:GetWorldPosition() )
			end
		end
	end
end

local function GloStandardSleepChecks(inst)
    return not (inst.components.homeseeker ~= nil and
            inst.components.homeseeker.home ~= nil and
                inst.components.homeseeker.home:IsValid() and
                inst:IsNear(inst.components.homeseeker.home, 40))
        and not (inst.components.combat ~= nil and inst.components.combat.target ~= nil)
        and not (inst.components.burnable ~= nil and inst.components.burnable:IsBurning())
        and not (inst.components.freezable ~= nil and inst.components.freezable:IsFrozen())
        and not (inst.components.teamattacker ~= nil and inst.components.teamattacker.inteam)
        and not inst.sg:HasStateTag("busy")
end

local function ShouldSleep(inst)
local x, y, z = inst.Transform:GetWorldPosition()
if TheWorld.Map:IsOceanTileAtPoint(x, y, z) and TheWorld.Map:GetPlatformAtPoint(x, z) == nil then return false end

    local watchlight = inst.LightWatcher ~= nil or (inst.components.sleeper and inst.components.sleeper.watchlight)
    return GloStandardSleepChecks(inst)
            -- sleep in the overworld at night
        and (not TheWorld:HasTag("cave") and TheWorld.state.isnight
            -- in caves, sleep at night if we have a lightwatcher and are in the dark
            or (TheWorld:HasTag("cave") and TheWorld.state.iscavenight and (not watchlight or not inst:IsInLight())))
end

local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddLightWatcher()
	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize( .8, .5 )
    inst.Transform:SetSixFaced()
	inst.entity:AddNetwork()

    inst.Transform:SetScale(0.6,0.6,0.6)    

	----------
	inst:AddTag("insect")
	inst:AddTag("flying")
	inst:AddTag("animal")
	inst:AddTag("smallcreature")
	inst:AddTag("butterfly")
	inst:AddTag("glowfly")

    local physics = inst.entity:AddPhysics()
    physics:SetMass(1)
    physics:SetCapsule(0.5, 1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
	
	inst.AnimState:SetBank("lantern_fly")
	inst.AnimState:SetBuild("lantern_fly")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetRayTestOnBB(true);

	local light = inst.entity:AddLight()
    light:SetFalloff(.7)
    light:SetIntensity(INTENSITY)
    light:SetRadius(2)
    light:SetColour(120/255, 120/255, 120/255)
    light:Enable(false)	
	
    inst:AddComponent("fader")		
	
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

  
	inst.sounds = sounds

	inst.OnEntityWake = OnEntityWake
	inst.OnEntitySleep = OnEntitySleep    

	inst.OnRemoveEntity = OnRemoveEntity

	inst.OnBorn = OnBorn

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
	inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickedUp)
	inst.components.inventoryitem.canbepickedup = false
--	inst.components.inventoryitem:ChangeImageName("lantern_fly")
	
	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	inst.components.locomotor:SetTriggersCreep(false)
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
	inst:SetStateGraph("SGglowfly")


	---------------------

	inst:AddComponent("pollinator")
	---------------------

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('glowfly')

	inst:AddComponent("tradable")
	inst:AddTag("cattoyairborne")

	 ------------------
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked)

	MakeSmallBurnableCharacter(inst, "upper_body", Vector3(0, -1, 1))
	MakeTinyFreezableCharacter(inst, "upper_body", Vector3(0, -1, 1))

	------------------
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(1)

	------------------
	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "body"

	------------------
	inst:AddComponent("sleeper")
	inst.components.sleeper:SetSleepTest(ShouldSleep)

	------------------
	inst:AddComponent("knownlocations")

	------------------    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = inspect
	
	inst:SetBrain(require("brains/glowflybrain"))

	inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("death", OnKilled)

	inst:WatchWorldState("isday", updatelight)
	inst:WatchWorldState("isnight",updatelight)
	inst:WatchWorldState("isdusk", updatelight)
	
    inst.begincocoonstage = begincocoonstage
    inst.changetococoon = changetococoon
    inst.setcocoontask = setcocoontask 
	inst:DoTaskInTime(0.5,function() updatelight(inst) end)

--	inst:DoPeriodicTask(5, function() checkRemoveGlowfly(inst) end)

	return inst
end

local function spawnRabidBeetle(inst)
    local pos = Vector3(inst.Transform:GetWorldPosition() )
    local bug = SpawnPrefab("rabid_beetle")
    if bug then
        bug.Transform:SetPosition(pos.x,pos.y,pos.z)
        bug.sg:GoToState("hatch")
    end 
end

local function OnKilledcocon(inst)
	if inst.components.fader then
    inst.components.fader:Fade(INTENSITY, 0, .75+math.random()*1, function(v) inst.Light:SetIntensity(v) end, function() inst.Light:Enable(false) end)
	end
	inst.AnimState:PlayAnimation("cocoon_idle_pst")	
	inst.AnimState:PushAnimation("cocoon_death")
end

local function OnAttackedcocon(inst, data)
	inst.AnimState:PlayAnimation("cocoon_hit")
end

local function fn2(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.Transform:SetSixFaced()
	inst.entity:AddNetwork()

    inst.Transform:SetScale(0.6,0.6,0.6)    

	----------
	inst:AddTag("insect")
	inst:AddTag("flying")
	inst:AddTag("animal")
	inst:AddTag("smallcreature")
	inst:AddTag("butterfly")
	inst:AddTag("cocoon")	

    local physics = inst.entity:AddPhysics()
    physics:SetMass(100)
    physics:SetCapsule(0.5, 1)
    inst.Physics:SetFriction(1)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
	
	inst.AnimState:SetBank("lantern_fly")
	inst.AnimState:SetBuild("lantern_fly")
	inst.AnimState:PlayAnimation("cocoon_idle_pre")
	inst.AnimState:PushAnimation("cocoon_idle_loop")	
	
	inst.sounds = sounds	
	
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('glowfly')

	MakeSmallBurnableCharacter(inst, "upper_body", Vector3(0, -1, 1))
	MakeTinyFreezableCharacter(inst, "upper_body", Vector3(0, -1, 1))

	------------------
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(300)

	------------------
	inst:AddComponent("combat")
	inst.components.combat.hiteffectsymbol = "body"

    inst:AddComponent("inspectable")

--    inst:ListenForEvent("death", OnKilledcocon)
--	inst:ListenForEvent("attacked", OnAttackedcocon)

	inst:DoTaskInTime(math.random(50,200),function(inst) 
    inst.AnimState:PlayAnimation("cocoon_idle_pst")
	spawnRabidBeetle(inst)	
	inst:DoTaskInTime(1,function(inst) inst:Remove() end)
	end)

	inst:SetStateGraph("SGglowfly")

	return inst
end

return Prefab( "forest/monsters/glowfly", fn, assets, prefabs), 
Prefab( "forest/monsters/glowfly_cocoon", fn2, assets, prefabs)
