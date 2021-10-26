require "stategraphs/SGrabbit"

local assets=
{
	Asset("ANIM", "anim/lobster_build.zip"),
	Asset("ANIM", "anim/lobster_build_color.zip"),
	Asset("ANIM", "anim/lobster.zip"),
}

local prefabs =
{
	"smallmeat",
	"cookedsmallmeat",
	"lobster_dead",
}

local LOBSTER_HEALTH = 25
local LOBSTER_WALK_SPEED = 1.5
local LOBSTER_RUN_SPEED = 4
local TOTAL_DAY_TIME = 480
		
local brain = require "brains/lobsterbrain"

local function GetCookProductFn(inst)
	return "lobster_dead_cooked"
end

local function OnCookedFn(inst)
	inst.SoundEmitter:PlaySound("dontstarve/rabbit/scream_short")
end

local function OnAttacked(inst, data)
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 30, {'lobster'})
	
	local num_friends = 0
	local maxnum = 5
	for k,v in pairs(ents) do
		v:PushEvent("gohome")
		num_friends = num_friends + 1
		
		if num_friends > maxnum then
			break
		end
	end
end

local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.Transform:SetFourFaced()

    local physics = inst.entity:AddPhysics()
    physics:SetMass(1)
    physics:SetCapsule(0.5, 1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
	
	inst:AddTag("animal")
	inst:AddTag("prey")
	inst:AddTag("smallcreature")
	inst:AddTag("canbetrapped")
	inst:AddTag("packimfood")
	inst:AddTag("fireimmune")
	inst:AddTag("tropicalspawner")	

	anim:SetBank("lobster")
	inst.AnimState:SetBuild("lobster_build_color")
	inst.AnimState:SetMultColour(255/255, 0/255, 0/255, 1)		
	
	anim:PlayAnimation("idle")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = LOBSTER_WALK_SPEED
	inst.components.locomotor.runspeed = LOBSTER_RUN_SPEED
	
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater.strongstomach = true -- can eat monster meat!

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	
	inst:AddComponent("tradable")
	inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT

	inst:AddComponent("cookable")
	inst.components.cookable.product = GetCookProductFn
	inst.components.cookable:SetOnCookedFn(OnCookedFn)
	
	inst:AddComponent("knownlocations")

	inst:AddComponent("combat")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(LOBSTER_HEALTH)
	inst.components.health.murdersound = "dontstarve_DLC002/creatures/lobster/death"
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"lobster_dead"})
	inst.components.lootdropper.nojump = true
	
	inst:AddComponent("inspectable")

	MakeSmallBurnableCharacter(inst, "chest")
	MakeTinyFreezableCharacter(inst, "chest")

	inst.no_wet_prefix = true
	inst:ListenForEvent("attacked", OnAttacked)
	inst:SetStateGraph("SGlobster")
	inst:SetBrain(brain)	
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

	return inst
end

return Prefab("lobsterunderwater", fn, assets, prefabs)
