local EndGameDialog = require("screens/endgamedialog")
local assets =
{
	Asset("ANIM", "anim/maxwell_throne.zip"),
    Asset("SOUND", "sound/sanity.fsb"),
    Asset("SOUND", "sound/common.fsb"),
    Asset("SOUND", "sound/wilson.fsb")

}

local prefabs =
{
    "maxwellendgame",
--    "puppet_wilson",
--    "puppet_willow",
--    "puppet_wendy",
--    "puppet_wickerbottom",
--    "puppet_wolfgang",
--    "puppet_wx78",
--    "puppet_wes", 
}

local function SpawnPuppet(inst, name)
    local puppet = SpawnPrefab("maxwellendgame")

    if puppet then
		local pt = Vector3(inst.Transform:GetWorldPosition())
        puppet.Transform:SetPosition(pt.x, pt.y + 0.1, pt.z)
        puppet.persists = false
    end
    return puppet
end

local function DecomposePuppet(inst)
    local tick_time = TheSim:GetTickTime()
    local time_to_erode = 4
    inst.puppet:StartThread( function()
        local ticks = 0
        while ticks * tick_time < time_to_erode do
            local erode_amount = ticks * tick_time / time_to_erode
            inst.puppet.AnimState:SetErosionParams( erode_amount, 0.1, 1.0 )
            ticks = ticks + 1
            Yield()
        end
        inst.puppet:Remove()
    end)
end

local function MaxwellDie(inst)
    inst.puppet.AnimState:PlayAnimation("death")
    inst.SoundEmitter:PlaySound("dontstarve/maxwell/breakchains")    
    inst:DoTaskInTime(113 * (1/30), function() inst.SoundEmitter:PlaySound("dontstarve/maxwell/blowsaway") end)
    inst:DoTaskInTime(95 * (1/30), function() inst.SoundEmitter:PlaySound("dontstarve/maxwell/throne_scream") end)    
    inst:DoTaskInTime(213 * (1/30), function() inst.SoundEmitter:KillSound("deathrattle") end)
end


local function PlayerDie(inst)
    inst.AnimState:PlayAnimation("player_death")
    inst.puppet.AnimState:PlayAnimation("dismount")
    inst.puppet.AnimState:PushAnimation("death", false)
    inst:DoTaskInTime(24 * (1/30), function() inst.SoundEmitter:PlaySound("dontstarve/wilson/death") end)
    inst:DoTaskInTime(40 * (1/30), function() inst.SoundEmitter:KillSound("deathrattle") end)
end

local function fn(Sim)
    local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local shadow = inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()
	shadow:SetSize( 3, 2 )    
	inst.Transform:SetRotation(180)

    anim:SetBank("throne")
    anim:SetBuild("maxwell_throne")
    anim:PlayAnimation("idle")

    inst:AddTag("maxwellthrone")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("inspectable")    

--    inst:DoTaskInTime(0, function() inst.puppet = SpawnPuppet(inst, "maxwellendgame") end)

--  inst:DoTaskInTime(3, DecomposePuppet)	
 
--	inst:DoTaskInTime(3, MaxwellDie)

--	inst:DoTaskInTime(6, PlayerDie) trono cai

    return inst
end

return Prefab( "common/characters/maxwellthrone", fn, assets, prefabs) 
