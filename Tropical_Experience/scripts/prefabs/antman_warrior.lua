require "brains/antwarriorbrain"
require "stategraphs/SGwarriorant"
require "brains/antwarriorbrain_egg"

local assets =
{
	Asset("ANIM", "anim/antman_basic.zip"),
	Asset("ANIM", "anim/antman_attacks.zip"),
	Asset("ANIM", "anim/antman_actions.zip"),
    Asset("ANIM", "anim/antman_egghatch.zip"),
    Asset("ANIM", "anim/antman_guard_build.zip"),
    Asset("ANIM", "anim/antman_warpaint_build.zip"),

    Asset("ANIM", "anim/antman_translucent_build.zip"),
}

local prefabs =
{
    "monstermeat",
    "chitin",
    "antman_warrior_egg"
}

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30
local ANTMAN_WARRIOR_DAMAGE = 34 * 1.25
local ANTMAN_WARRIOR_HEALTH = 300
local ANTMAN_WARRIOR_ATTACK_PERIOD = 3
local ANTMAN_WARRIOR_TARGET_DIST = 16

local ANTMAN_WARRIOR_RUN_SPEED = 7
local ANTMAN_WARRIOR_WALK_SPEED = 3.5

local ANTMAN_WARRIOR_REGEN_TIME = 34
local ANTMAN_WARRIOR_RELEASE_TIME = 34

local ANTMAN_WARRIOR_ATTACK_ON_SIGHT_DIST = 8

local function ontalk(inst, script)
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/crickant/abandon")
end

local function OnAttackedByDecidRoot(inst, attacker)
    local fn = function(dude) return dude:HasTag("antman") end

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = nil
    ents = TheSim:FindEntities(x, y, z, SHARE_TARGET_DIST / 2)
    
    if ents then
        local num_helpers = 0
        for k, v in pairs(ents) do
            if v ~= inst and v.components.combat and not (v.components.health and v.components.health:IsDead()) and fn(v) then
                if v:PushEvent("suggest_tree_target", {tree=attacker}) then
                    num_helpers = num_helpers + 1
                end
            end
            if num_helpers >= MAX_TARGET_SHARES then
                break
            end     
        end
    end
end

local function OnAttacked(inst, data)
    local attacker = data.attacker
    inst:ClearBufferedAction()

    if attacker.prefab == "deciduous_root" and attacker.owner then
        OnAttackedByDecidRoot(inst, attacker.owner)
    elseif attacker.prefab ~= "deciduous_root" then
        inst.components.combat:SetTarget(attacker)
        inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, function(dude) return dude:HasTag("ant") end, MAX_TARGET_SHARES)
    end
end

local builds = {"antman_translucent_build"}-- {"antman_build"} 

local function is_complete_disguise(target)
if not target then return end
    return target:HasTag("has_antmask") and target:HasTag("has_antsuit") or target:HasTag("antlingual")
end

local function NormalRetargetFn(inst)
    return FindEntity(inst, ANTMAN_WARRIOR_TARGET_DIST,
        function(guy)
            if guy.components.health and not guy.components.health:IsDead() and inst.components.combat:CanTarget(guy) then
                if guy:HasTag("monster") then return guy end
                if guy:HasTag("player") and guy.components.inventory and guy:GetDistanceSqToInst(inst) < ANTMAN_WARRIOR_ATTACK_ON_SIGHT_DIST*ANTMAN_WARRIOR_ATTACK_ON_SIGHT_DIST and not guy:HasTag("antlingual") then return guy end
            end
        end
    )
end

local function NormalKeepTargetFn(inst, target)
    --give up on dead guys, or guys in the dark, or werepigs
    return inst.components.combat:CanTarget(target)
           and (not target.LightWatcher or target.LightWatcher:IsInLight())
           and not (target.sg and target.sg:HasStateTag("transform") )
end

local function TransformToNormal(inst)
    local normal = SpawnPrefab("antman")
    normal.Transform:SetPosition(  inst.Transform:GetWorldPosition() )
    inst:Remove()
end


local function common()
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize(1.5, .75)

    local light = inst.entity:AddLight()
    light:SetFalloff(.35)
    light:SetIntensity(.25)
    light:SetRadius(1)
    light:SetColour(120/255, 120/255, 120/255)
    light:Enable(false)

    trans:SetFourFaced()
    trans:SetScale(1.15, 1.15, 1.15)

    inst.entity:AddLightWatcher()
    
    inst:AddComponent("talker")
    inst.components.talker.ontalk = ontalk
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0, -400, 0)

    MakeCharacterPhysics(inst, 50, .5)

	inst.build = "antman_guard_build"	
    inst:AddTag("character")
    inst:AddTag("antmanwarrior")
    inst:AddTag("ant")
    inst:AddTag("scarytoprey")
    anim:SetBank("antman")
	inst.AnimState:SetBuild(inst.build)	
    anim:PlayAnimation("idle_loop")
    anim:Hide("hat")	
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = ANTMAN_WARRIOR_RUN_SPEED --5
    inst.components.locomotor.walkspeed = ANTMAN_WARRIOR_WALK_SPEED --3
    ------------------------------------------
    -- boat hopping setup
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")			
	
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "antman_torso"
    inst.components.combat.debris_immune = true
    inst.components.combat:SetRetargetFunction(3, NormalRetargetFn)
    inst.components.combat:SetTarget(nil)
    inst.components.combat:SetDefaultDamage(ANTMAN_WARRIOR_DAMAGE)
    inst.components.combat:SetAttackPeriod(ANTMAN_WARRIOR_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(NormalKeepTargetFn)	

    MakeMediumBurnableCharacter(inst, "antman_torso")

    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.ANTWARRIORNAMES
    inst.components.named:PickNewName()
	
    ------------------------------------------
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(ANTMAN_WARRIOR_HEALTH)
	
    inst:AddComponent("inventory")
	
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({})
    inst.components.lootdropper:AddRandomLoot("monstermeat", 3)
    inst.components.lootdropper:AddRandomLoot("chitin", 1)
    inst.components.lootdropper.numrandomloot = 1

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false	
	inst.components.inventoryitem:SetSinks(true)		
	
    inst:AddComponent("knownlocations")
    inst:AddComponent("sleeper")
    inst:AddComponent("inspectable")
    ------------------------------------------
    MakeMediumFreezableCharacter(inst, "antman_torso")
    ------------------------------------------

    inst.OnSave = function(inst, data)
        data.build = inst.build

        if inst.queen then
            data.queen_guid = inst.queen.GUID
        end
    end        
    
    inst.OnLoad = function(inst, data)
		if data then
			inst.build = data.build or builds[1]
			inst.AnimState:SetBuild(inst.build)
		end
    end

    
    inst:ListenForEvent("attacked", OnAttacked)
    
    inst.SetAporkalypse = function(enabled)
		local player = GetClosestInstWithTag("player", inst, 30)	
        if player and enabled then
            inst.Light:Enable(true)
            inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
            inst.build = "antman_warpaint_build"
			inst.AnimState:SetBuild(inst.build)		
			inst.components.health:SetMaxHealth(ANTMAN_WARRIOR_HEALTH + 100)
        else
            inst.Light:Enable(false)
            inst.AnimState:SetBloomEffectHandle( "" )
            inst.build = "antman_guard_build"
			inst.AnimState:SetBuild(inst.build)			
        end

        inst.AnimState:SetBuild(inst.build)
    end

    inst:ListenForEvent("antqueenbattle", function() inst.SetAporkalypse(true) end, TheWorld)
--    inst:ListenForEvent("endaporkalypse", function() 
--        if inst:HasTag("aporkalypse_cleanup") then
--            if not inst:IsInLimbo() then
--                TransformToNormal(inst)
--            end
--        else
--            inst.SetAporkalypse(false)
--        end
--    end, TheWorld)

--    inst:ListenForEvent("exitlimbo", function(inst) 
--        if inst:HasTag("aporkalypse_cleanup") and not GetAporkalypse():IsActive() then 
--            TransformToNormal(inst)
--        end 
--    end)

	inst:ListenForEvent("beginaporkalypse", function() 
	inst.Light:Enable(true)
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.build = "antman_warpaint_build"
	inst.AnimState:SetBuild(inst.build)	
	end, TheWorld)
	
	
	inst:ListenForEvent("endaporkalypse", 
	function() 
    local warrior = SpawnPrefab("antman")
    warrior.Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst:Remove()	
	end, TheWorld)
	
	inst:DoTaskInTime(0.2, function(inst) 
    if TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.aporkalypse_active == true then
	inst.Light:Enable(true)
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.build = "antman_warpaint_build"
	inst.AnimState:SetBuild(inst.build)	
	else
	inst.Light:Enable(false)
    inst.AnimState:SetBloomEffectHandle( "" )
    inst.build = "antman_guard_build"
	inst.AnimState:SetBuild(inst.build)	
	end
	end)

    local brain = require "brains/antwarriorbrain"
    inst:SetBrain(brain)
    inst:SetStateGraph("SGwarriorant")

    return inst
end

return Prefab("common/characters/antman_warrior", common, assets, prefabs)