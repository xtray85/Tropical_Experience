local assets =
{
	Asset("ANIM", "anim/fish_dogfish.zip"),
}

local prefabs =
{
	"fish_med"
}

local	    SOLOFISH_WALK_SPEED = 5
local	    SOLOFISH_RUN_SPEED = 8
local	    SOLOFISH_HEALTH = 100
local	    SOLOFISH_WANDER_DIST = 10

local brain = require "brains/solofishbrain"

local function SetLocoState(inst, state)
    --"above" or "below"
    inst.LocoState = string.lower(state)
end

local function IsLocoState(inst, state)
    return inst.LocoState == string.lower(state)
end

local function ShouldSleep(inst)
 return false
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

local function solofishfn()

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst:AddTag("aquatic")
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

--	MakePoisonableCharacter(inst)
    MakeCharacterPhysics(inst, 1, 0.5)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
	inst.Physics:CollidesWith(COLLISION.OBSTACLES)	
    inst.entity:AddSoundEmitter()

	inst.AnimState:SetBank("dogfish")
    inst.AnimState:SetBuild("fish_dogfish")
    inst.AnimState:PlayAnimation("shadow", true)
    anim:SetRayTestOnBB(true)
    anim:SetOrientation( ANIM_ORIENTATION.OnGround )

	anim:SetLayer( LAYER_BACKGROUND )
	anim:SetSortOrder( 3 )
	
	inst:AddTag("tropicalspawner")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
	
	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = SOLOFISH_WALK_SPEED
	inst.components.locomotor.runspeed = SOLOFISH_RUN_SPEED



    inst:AddComponent("inspectable")
    inst.no_wet_prefix = true

	inst:AddComponent("knownlocations")

	inst:AddComponent("combat")
    --inst.components.combat.hiteffectsymbol = "chest"
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(SOLOFISH_HEALTH)

    inst:AddComponent("eater")
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"fish_med"})

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    MakeMediumFreezableCharacter(inst, "dogfish_body")

    SetLocoState(inst, "below")
    inst.SetLocoState = SetLocoState
    inst.IsLocoState = IsLocoState

    inst:SetStateGraph("SGsolofish")
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240 + math.random()*240)	

    inst:SetBrain(brain)

	return inst
end

return Prefab( "ocean/objects/solofish", solofishfn, assets, prefabs)