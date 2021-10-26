local assets =
{
    Asset("ANIM", "anim/lavaarena_boarrior_basic.zip"),
}

local assetsBurst =
{
    Asset( "ANIM", "anim/lavaarena_boarrior_fx.zip" ),
}

SetSharedLootTable( "bossboarte",
{
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	{"meat",   1.0},
	--{"hephaestus_gift",   1.0},
--	{"gw_echo_amulet",   1.0},
--	{"pig_figure",   1.0}
})

local function OnTimerDone(inst, data)
	if data.name == "regen_bossboar" then
		if inst._spawntask ~= nil then
			inst._spawntask:Cancel()
			inst._spawntask = nil
		end
		inst:Show()
		inst.DynamicShadow:Enable(true)
		GFSoftColourChange(inst, {0, 0, 0, 1}, {0, 0, 0, 0}, 2, 0.1)
		inst:DoTaskInTime(2, function(inst) GFSoftColourChange(inst, {1, 1, 1, 1}, {0, 0, 0, 1}, 2, 0.1) end)
		inst:DoTaskInTime(4, function(inst) 
			inst.brain:Start() 
			inst:SetEngaged()
			inst:ReTarget()
		end)
	end
end

local function OnAttacked(inst, data)
	if data == nil or data.attacker == nil or data.attacker:HasTag("boar") then return end
	if inst.components.combat.target == nil or not inst.components.combat.target:HasTag("player") then
		inst.components.combat:SetTarget(data.attacker)
	end
	if not inst.engaged then
		inst:SetEngaged(inst)
	end
end

local function OnDeath(inst)

end

local function OnHitOther(inst)
	inst.rage = inst.rage + 1
	--("rage", inst.rage)
end

local function ReTarget(inst)
	if not inst.engaged then return nil end

    local newtarget = FindEntity(inst, 50, 
		function(guy)
			return inst.components.combat:CanTarget(guy)
        end,
        { "_combat" },
        { "smallcreature", "playerghost", "shadow", "INLIMBO", "FX", "NOCLICK" }
    )

    if newtarget then
		return newtarget
	end
end

local function SetEngaged(inst)
	if not inst.engaged then
--		inst.components.health:SetMaxHealth(13000)
		inst.engaged = true
	end
end

local function SetEvaded(inst)
	if inst.engaged then
--		inst.components.health:SetPercent(1)
	end
end

local function OnSave(inst, data)
	data.engaged = inst.engaged
end

local function OnLoad(inst, data)
	if data ~= nil then
		if data.engaged then
			inst:DoTaskInTime(0, function()
				local perc = inst.components.health:GetPercent()
				SetEngaged(inst)
--				inst.components.health:SetPercent(perc)
			end)
		end
	end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(5.25, 1.75)
    inst.Transform:SetFourFaced()

    inst:SetPhysicsRadiusOverride(2)
    MakeGiantCharacterPhysics(inst, 1000, 1.2)
    inst.Physics:SetCapsule(2, 2)

    inst.AnimState:SetBank("boarrior")
    inst.AnimState:SetBuild("lavaarena_boarrior_basic")
    inst.AnimState:PlayAnimation("idle_loop", true)

	inst:AddTag("scarytoprey")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("largecreature")
	inst:AddTag("epic")
	inst:AddTag("boar")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = 14
	local sg = require "stategraphs/SGbossboarte"
	inst:SetStateGraph("SGbossboarte")

	local brain = require "brains/bossboarbrainte"
	inst:SetBrain(brain)

	inst:AddComponent("knownlocations")

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(34000)

	inst:AddComponent("combat")
	inst.components.combat:SetDefaultDamage(75)--(100)
	inst.components.combat:SetAttackPeriod(1.5)
	inst.components.combat:SetRetargetFunction(5, ReTarget)
	--inst.components.combat:SetKeepTargetFunction(KeepTarget)
	inst.components.combat:SetRange(6)
	inst.components.combat.battlecryenabled = false

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable("bossboarte")

	inst:AddComponent("inspectable")
	inst:AddComponent("sanityaura")
	inst:AddComponent("explosiveresist")
	
	inst:AddComponent("sleeper")
	inst.components.sleeper:SetResistance(4)
    inst.components.sleeper.diminishingreturns = true
	
	inst:AddComponent("timer")

--[[
if TUNING.tropical.greenmod then
	if rawget(_G, "GF") ~= nil then
		inst:AddComponent("gfspellcaster")
		local spells = 
		{
			"gw_boarrior_burst",
			"gw_boarrior_slam",
			"gw_boarrior_combo",
			"gw_boarrior_whirl",
		}
		inst.components.gfspellcaster:AddSpells(spells)
	end
end	
]]

	inst.rage = 0
	inst._fireburstHitted = {}
	
	inst.OnSave = OnSave
    inst.OnLoad = OnLoad
	inst.ReTarget = ReTarget
	--pull/evade
	inst.engaged = false
	inst.SetEngaged = SetEngaged
	inst.SetEvaded = SetEvaded

	inst:ListenForEvent("death", OnDeath)
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("timerdone", OnTimerDone)
	inst:ListenForEvent("onhitother", OnHitOther)

    return inst
end

--[[BURST]]---------------------------
--------------------------------------
local function DoStrike(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst.striketask = nil
	inst.warnshadow:Remove()
    inst.fireeffect = SpawnPrefab("groundfire")
	inst.fireeffect.Transform:SetPosition(x, y, z)
	
	local meteordamage = 80
    local ents = TheSim:FindEntities(x, y, z, inst.size * TUNING.METEOR_RADIUS, nil)

    for i, ent in ipairs(ents) do
        if inst.parent and ent:IsValid() and not ent:IsInLimbo() 
            and not ent:HasTag("boar")
            and ent.components.combat ~= nil 
            and not table.contains(inst.parent._fireburstHitted, ent)
        then
            ent.components.combat:GetAttacked(inst, meteordamage, nil)
            table.insert(inst.parent._fireburstHitted, ent)
            inst.parent:DoTaskInTime(0.75, function(inst, ent) 
                RemoveByValue(inst._fireburstHitted, ent)
            end, ent)
        end
    end

    inst:Remove()
end

local function StartBurst(inst, parent, size)--, sz)
	inst.size = size and size or 1
    inst.parent = parent
    inst.warnshadow = SpawnPrefab("groundpound_fx")
	inst.warnshadow.Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.warnshadow.Transform:SetScale(inst.size * 0.4, inst.size  * 0.4, inst.size  * 0.4)
    inst.striketask = inst:DoTaskInTime(1, DoStrike)
end

local function fnBurst() 
    local inst = CreateEntity()

    inst.entity:AddTransform()

    inst:AddTag("NOCLICK")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("propagator")
    inst.components.propagator.propagaterange = 4
    inst.components.propagator:StartSpreading() 

    inst.StartBurst = StartBurst
    inst.striketask = nil

    inst:DoTaskInTime(3, function() inst:Remove() end)

    return inst
end

--[[FIRE-FX]]-------------------------
--------------------------------------
local assetsFire =
{
	Asset( "ANIM", "anim/lavaarena_boarrior_fx.zip" ),
}

local function fnFire()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddNetwork()
    local anim = inst.entity:AddAnimState()
    
    anim:SetBuild("lavaarena_boarrior_fx")
   	anim:SetBank("lavaarena_boarrior_fx")
	anim:PlayAnimation( "ground_hit_1", false ) 

	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

    return inst
end

return Prefab("bossboarte", fn, assets),
	Prefab("bossboarfireburst", fnBurst, assetsBurst),
	Prefab("groundfire", fnFire, assetsFire) 
