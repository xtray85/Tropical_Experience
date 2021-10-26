require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/lifeplant.zip"),
	Asset("ANIM", "anim/lifeplant_fx.zip"),
	Asset("MINIMAP_IMAGE", "lifeplant"),
}

local prefabs =
{
	"collapse_small",
}

local INTENSITY = .5

local function fadein(inst)
    inst.components.fader:StopAll()
    inst.Light:Enable(true)
	if inst:IsAsleep() then
		inst.Light:SetIntensity(INTENSITY)
	else
		inst.Light:SetIntensity(0)
		inst.components.fader:Fade(0, INTENSITY, 3+math.random()*2, function(v) inst.Light:SetIntensity(v) end)
	end
end

local function fadeout(inst)
    inst.components.fader:StopAll()
	if inst:IsAsleep() then
		inst.Light:SetIntensity(0)
	else
		inst.components.fader:Fade(INTENSITY, 0, .75+math.random()*1, function(v) inst.Light:SetIntensity(v) end)
	end
end


local function onburnt(inst)
	inst:AddTag("burnt")
    inst.components.burnable.canlight = false
	
    local ash = SpawnPrefab("ash")
	if ash then
    ash.Transform:SetPosition(inst.Transform:GetWorldPosition())
	end
    inst:Remove()
	
end


local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle")
	end
end

local function onplanted(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle", false)
	inst.SoundEmitter:PlaySound("dontstarve/common/craftable/resurrectionstatue")
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
end

local function onload(inst, data)
	if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end


local function CalcSanityAura(inst, observer)
	return TUNING.SANITYAURA_LARGE
end

local function sparkle(inst)
	local player = GetClosestInstWithTag("player", inst, 5)
if player then
	local sparkle = SpawnPrefab("lifeplant_sparkle")
	sparkle.Transform:SetPosition(player.Transform:GetWorldPosition())
end
end

local function drain(inst)
local player = GetClosestInstWithTag("player", inst, 5)
if player then
	player.components.hunger:DoDelta(-1)
end	
end

local function onnear(inst)	
	if not inst.reserrecting then
		inst.starvetask = inst:DoPeriodicTask(0.5,function() sparkle(inst) end)
		inst.starvetask2 = inst:DoPeriodicTask(2,function() drain(inst) end)
	end
end

local function onfar(inst)
	if inst.starvetask then
		inst.starvetask:Cancel()
		inst.starvetask = nil

		inst.starvetask2:Cancel()
		inst.starvetask2 = nil		
	end
end

local function dig_up(inst, chopper)
		
	local drop = inst.components.lootdropper:SpawnLootPrefab("waterdrop")
	drop.fountain = inst.fountain
	
	inst.dug = true
	inst:Remove()
end

local function manageidle(inst)
	local anim = "idle_gargle"
	if math.random() < 0.5 then
		anim = "idle_vanity"
	end

	inst.AnimState:PlayAnimation(anim)
	inst.AnimState:PushAnimation("idle_loop",true)

	inst:DoTaskInTime(8+(math.random()*20), function() inst.manageidle(inst) end)
end

local function OnHaunt(inst)
inst.AnimState:PlayAnimation("burnt",true)
inst:DoTaskInTime(2, function() inst:Remove() end)


return true
end

local function fn(Sim)
	local inst = CreateEntity()
	
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
    MakeObstaclePhysics(inst, .3)

	inst.MiniMapEntity:SetIcon( "lifeplant.png" )
    
    inst.AnimState:SetBank("lifeplant")
    inst.AnimState:SetBuild("lifeplant")
    inst.AnimState:PlayAnimation("idle_loop",true)
	inst.Transform:SetScale(1.5, 1.5, 1.5)	
    inst.AnimState:SetScale(1.7, 1.7, 1.7)	
	
    inst:AddComponent("fader")	

    inst:AddTag("lifeplant")
    inst:AddTag("resurrector")
	
    local light = inst.entity:AddLight()
    inst.Light:SetIntensity(INTENSITY)
    inst.Light:SetColour(180/255, 195/255, 150/255)
    inst.Light:SetFalloff( 0.9 )
    inst.Light:SetRadius( 2 )	
    inst.Light:Enable(true)    
    fadein(inst)	

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
    
    inst:AddComponent("inspectable")
	
    inst:AddComponent("lootdropper")
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(dig_up)
	
	MakeSnowCovered(inst, .01)    

	inst:AddComponent("burnable")
    inst.components.burnable:SetFXLevel(1)
    inst.components.burnable:SetBurnTime(10)
    inst.components.burnable:AddBurnFX("fire", Vector3(0, 0, 0) )
    inst.components.burnable:SetOnBurntFn(onburnt)
    MakeLargePropagator(inst)

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    inst:AddComponent("playerprox")

    inst.components.playerprox:SetDist(6,7)
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetOnPlayerFar(onfar)

    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

	inst.OnSave = onsave 
    inst.OnLoad = onload

    inst.manageidle = manageidle
    inst:DoTaskInTime(8+(math.random()*20), function() inst.manageidle(inst) end)
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)	
	inst.components.hauntable:SetOnHauntFn(OnHaunt)

   	inst.AnimState:SetMultColour(0.9,0.9,0.9,1)
    return inst
end

local function testforplant(inst)
	local x,y,z = inst.Transform:GetWorldPosition()
	local ent = TheSim:FindFirstEntityWithTag("lifeplant")

	if ent and ent:GetDistanceSqToInst(inst) < 1 then
		inst:Remove()
	end
end

local function onspawn(inst)
	local x,y,z = inst.Transform:GetWorldPosition()
	local ent = TheSim:FindFirstEntityWithTag("lifeplant")
	if ent then
		local x2,y2,z2 = ent.Transform:GetWorldPosition()
    	local angle = inst:GetAngleToPoint(x2, y2, z2)
    	inst.Transform:SetRotation(angle)

		inst.components.locomotor:WalkForward()
		inst:DoPeriodicTask(0.1,function() testforplant(inst) end)
	else
		inst:Remove()
	end
end

local function sparklefn(Sim)
	local inst = CreateEntity()

    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
   
    local physics = inst.entity:AddPhysics()
    physics:SetMass(1)
    physics:SetCapsule(0.3, 1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    RemovePhysicsColliders(inst)
        
	inst.AnimState:SetBank("lifeplant_fx")
    inst.AnimState:SetBuild("lifeplant_fx")
    inst.AnimState:PlayAnimation("single"..math.random(1,3),true)

 
	inst:AddTag("flying")
    inst:AddTag("NOCLICK")
    --inst:AddTag("DELETE_ON_INTERIOR")

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 2
	inst.components.locomotor:SetTriggersCreep(false)

    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst:DoTaskInTime(0,function() onspawn(inst) end)
	
	inst.OnEntitySleep = function() inst:Remove() end

    inst.persists = false	
	
    return inst
end


return Prefab( "common/objects/lifeplant", fn, assets, prefabs),
	   Prefab( "common/objects/lifeplant_sparkle", sparklefn, assets, prefabs)		
