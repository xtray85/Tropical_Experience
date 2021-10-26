local brain = require("brains/flupbrain")
require("stategraphs/SGflup")

local assets =
{
	Asset("ANIM", "anim/flup_build.zip"),
	Asset("ANIM", "anim/flup_basic.zip"),
}

local prefabs =
{
	"monstermeat",
}

SetSharedLootTable( 'flup',
{
    {'monstermeat',   1.00},
	{'blowdart_flup', 0.25},
})


local	    FLUP_JUMPATTACK_RANGE = 4
local	    FLUP_MELEEATTACK_RANGE = 2
local	    FLUP_HIT_RANGE = 1.75
local	    FLUP_HEALTH = 180
local	    FLUP_ATTACK_PERIOD = 2
local	    FLUP_DAMAGE = 25

local	    FLUP_DART_DAMAGE = 20

local	    FIRE_DART_DAMAGE = 5



local function sleeptestfn(inst)
	return false
end

local function retargetfn(inst)
	if inst.sg:HasStateTag("ambusher") then
		--Hiding in dirt, looking to attack.
		return FindEntity(inst, 7, function(tar)
            local canTarget = inst.components.combat:CanTarget(tar)
            return canTarget
		end, nil, {"flup", "FX", "NOCLICK", "mermfisher"})
	end
end

local function keeptargetfn(inst, target)
	local homePos = inst.components.knownlocations:GetLocation("home")

    return target
          and target.components.combat
          and target.components.health
          and not target.components.health:IsDead()
          and inst:GetPosition():Dist(target:GetPosition()) < 15
          and (homePos and homePos:Dist(target:GetPosition()) < 30)
end

local function oninit(inst)
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then
inst:Remove()
end


end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddPhysics()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()

	inst.DynamicShadow:SetSize(1.5, 0.75)
	inst.Transform:SetFourFaced()

	inst.AnimState:SetBank("flup")
	inst.AnimState:SetBuild("flup_build")
	inst.AnimState:PlayAnimation("idle")

	MakeCharacterPhysics(inst, 1, 0.3)
	
    inst:AddTag("WORM_DANGER")
	inst:AddTag("tentacle")	
	inst:AddTag("flup")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("frog")	

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	
	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 4
	inst.components.locomotor.runspeed = 6.5

	inst:SetStateGraph("SGflup")
	inst:SetBrain(brain)

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(FLUP_HEALTH)

	inst:AddComponent("combat")
	inst.components.combat:SetRetargetFunction(1.5, retargetfn)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
	inst.components.combat:SetDefaultDamage(FLUP_DAMAGE)
	inst.components.combat:SetAttackPeriod(FLUP_ATTACK_PERIOD)
    inst.components.combat:SetRange(FLUP_JUMPATTACK_RANGE, FLUP_HIT_RANGE)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("flup")
	inst:AddComponent("knownlocations")
	inst:AddComponent("inspectable")

	inst:AddComponent("sleeper")
	inst.components.sleeper:SetSleepTest(sleeptestfn)

    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", inst:GetPosition(), true) end)

	MakeTinyFreezableCharacter(inst)
	MakeSmallBurnable(inst)
	inst:DoTaskInTime(1, oninit)
	
	return inst
end

return Prefab("animals/flup", fn, assets, prefabs)
