local assets =
{
	Asset("ANIM", "anim/maxwell_build.zip"),
    Asset("ANIM", "anim/maxwell_basic.zip"),
	Asset("ANIM", "anim/maxwell_adventure.zip"),
	Asset("ANIM", "anim/maxwell_endgame.zip"),
}


local maxbosswellmaxlife = 9000

local prefabs = 
{
}

local armasdotesouro =
{
		[1] = "tfwp_healing_staff",		
		[2] = "tfwp_control_book",
		[3] = "tfwp_infernal_staff",
        [4] = "tfwp_lava_hammer",		
		[5] = "tfwp_dragon_dart",	
		[6] = "tfwp_spear_lance",		
		[7] = "tfwp_lava_dart",
		[8] = "tfwp_spear_gung",	
		[9] = "tfwp_summon_book",		
		[10] = "lavaarena_armor_hpdamager",
		[11] = "lavaarena_armor_hprecharger",
		[12] = "lavaarena_armor_hppetmastery",
		[13] = "lavaarena_armor_hpextraheavy",
		[14] = "lavaarena_armorextraheavy",
		[15] = "lavaarena_armorheavy",
		[16] = "lavaarena_armormediumrecharger",
		[17] = "lavaarena_armormediumdamager",
		[18] = "lavaarena_armormedium",
		[19] = "lavaarena_armorlightspeed",
		[20] = "lavaarena_armorlight",
		[21] = "lavaarena_lightdamagerhat",
		[22] = "lavaarena_strongdamagerhat",
		[23] = "lavaarena_feathercrownhat",
		[24] = "lavaarena_rechargerhat",
		[25] = "lavaarena_healingflowerhat",
		[26] = "lavaarena_tiaraflowerpetalshat",
		[27] = "lavaarena_eyecirclethat",
		[28] = "lavaarena_crowndamagerhat",
		[29] = "lavaarena_healinggarlandhat",
		[30] = "tfwp_heavy_sword",
    }


SetSharedLootTable( 'maxwell_boss',
{
    {armasdotesouro[math.random(1, 30)],   1.00},
    {armasdotesouro[math.random(1, 30)],   1.00},
    {armasdotesouro[math.random(1, 30)],   1.00},
    {armasdotesouro[math.random(1, 30)],   1.00},
    {armasdotesouro[math.random(1, 30)],   1.00},
    {armasdotesouro[math.random(1, 30)],   1.00},
    {armasdotesouro[math.random(1, 30)],   1.00},
    {'armor_sanity',       1.00},
    {'amulet',   		    1.00},
    {'purpleamulet',       1.00},
    {'orangestaf',     		  1.00},
    {'telestaff',      		 1.00},
    {'nightmarefuel',       1.00},
    {'nightmarefuel',       1.00},
    {'nightmarefuel',       1.00},
})

local bosswelltalks = {
"You will not win this time.",
"Feel my power.",
"The shadows will return.",
"I am the king of this place.",
}

local function magicattack(inst)
local num_lightnings = inst.form + 1
	if not inst.components.health:IsDead() then
		ShakeAllCameras(CAMERASHAKE.FULL, .7, .02, .3, inst, 40)
		
		local pt = inst:GetPosition()
	
		inst:StartThread(function()
			for k = 0, num_lightnings do
local a, b, c = inst.Transform:GetWorldPosition()
SpawnPrefab("maxwellshadowmeteor").Transform:SetPosition(a + math.random(-15, 15), b, c + math.random(-15, 15))
				local rad = math.random(3, 15)
				local angle = k * 4 * PI / num_lightnings
				local pos = pt + Vector3(rad * math.cos(angle), 0, rad * math.sin(angle))
				TheWorld:PushEvent("ms_sendlightningstrike", pos)
				Sleep(.3 + math.random() * .2)
			end
		end)
	end			
end

local function Teletransporte(inst, starttime)
	
		inst:DoTaskInTime(starttime, function() 
			inst.bosswelltalking = true

			inst.components.health:SetInvincible(true)
			inst.AnimState:PlayAnimation("dialog"..inst.form.."_pre") 
			inst.AnimState:PushAnimation("dialog"..inst.form.."_loop", true)
			inst.SoundEmitter:PlaySound("dontstarve/maxwell/talk_LP", "talkbosswell")
			
			inst.components.talker:Say(bosswelltalks[math.random(3)])			
					
			inst:DoTaskInTime(4, function() 		
			inst.SoundEmitter:KillSound("talkbosswell")
			inst.AnimState:PlayAnimation("dialog"..inst.form.."_pst")
			inst.AnimState:PushAnimation("idle"..inst.form.."_loop", true)			
			inst.bosswelltalking = false
			inst.components.health:SetInvincible(false)

			local invader = GetClosestInstWithTag("player", inst, 30)
			if invader then
			magicattack(inst)
			end
			
			Teletransporte(inst, math.random(15, 20))		
			end)
			
			
			inst:DoTaskInTime(22, function()
				inst.components.talker:Say("")
			end)

		end)
end

local function MatarTropas(inst)
local trono = GetClosestInstWithTag("maxwelllock", inst, 70)
if trono then
local xpos, ypos, zpos = trono.Transform:GetWorldPosition()
local ajudantes = TheSim:FindEntities(xpos, ypos, zpos, 70, { "shadowminion2" })
	for k, minion in pairs(ajudantes) do
		SpawnPrefab("shadow_despawn").Transform:SetPosition(minion.Transform:GetWorldPosition())
		minion:Remove()		
	end
	
end
end

local function StartTrackingPet(inst, minion)
    inst.minions[minion] = true
    inst.numminions = inst.numminions + 1
	inst:ListenForEvent("onremove", inst._onstoptrackingpet, minion)
    inst:ListenForEvent("death", inst._onstoptrackingpet, minion)	
	SpawnPrefab("shadow_despawn").Transform:SetPosition(minion.Transform:GetWorldPosition())
end

local function minionsaparecem(inst, attacker)
local trono = GetClosestInstWithTag("maxwelllock", inst, 70)
if trono then
local xpos, ypos, zpos = trono.Transform:GetWorldPosition()
local ajudantes = TheSim:FindEntities(xpos, ypos, zpos, 70, { "shadowminion2" })
if #ajudantes > inst.form then return end



local minion = SpawnPrefab("shadowtroop")

minion.Transform:SetPosition(xpos - math.random(-18, 12), ypos, zpos - math.random(-30, 30))
end	

end

local function OnHit(inst, attacker, damage) 
if inst:HasTag("teletransportando") then return end
if not inst.components.health:IsDead() then
inst.tomouataque = inst.tomouataque + 1	
minionsaparecem(inst, attacker)
minionsaparecem(inst, attacker)
minionsaparecem(inst, attacker)
	
SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition())

if inst.form == 2 and inst.components.health and  inst.components.health.currenthealth > inst.components.health.maxhealth * 0.6 then
inst.form = 3
end

if inst.form == 2 and inst.components.health and  inst.components.health.currenthealth < inst.components.health.maxhealth * 0.6 and inst.components.health.currenthealth > inst.components.health.maxhealth * 0.3 then
inst.form = 4
end

if inst.components.health and  inst.components.health.currenthealth < inst.components.health.maxhealth * 0.3 then
inst.form = 5
end

if inst.tomouataque > 4 and inst.form == 3 and inst.bosswelltalking == false then
inst:AddTag("teletransportando")
inst.AnimState:PlayAnimation("disappear"..inst.form.."")
inst.form = 2
inst.components.health:SetInvincible(true)
inst:DoTaskInTime(1, function()
local trono = GetClosestInstWithTag("maxwelllock", inst, 70)
if trono then
local xpos, ypos, zpos = trono.Transform:GetWorldPosition()
inst.Transform:SetPosition(xpos - math.random(-18, 12), ypos, zpos - math.random(-30, 30))
end	
inst.AnimState:PushAnimation("appear"..inst.form.."")
inst.AnimState:PushAnimation("idle"..inst.form.."_loop", true)
inst.components.health:SetInvincible(false)
inst.tomouataque = 0 
inst:RemoveTag("teletransportando")
end)
return end


if inst.tomouataque > 4 and inst.form == 4 and inst.bosswelltalking == false then
inst:AddTag("teletransportando")
inst.AnimState:PlayAnimation("disappear"..inst.form.."")
inst.form = 4
inst.components.health:SetInvincible(true)
inst:DoTaskInTime(1, function()
local trono = GetClosestInstWithTag("maxwelllock", inst, 70)
if trono then
local xpos, ypos, zpos = trono.Transform:GetWorldPosition()
inst.Transform:SetPosition(xpos - math.random(-18, 12), ypos, zpos - math.random(-30, 30))
end	
inst.AnimState:PushAnimation("appear"..inst.form.."")
inst.AnimState:PushAnimation("idle"..inst.form.."_loop", true)
inst.components.health:SetInvincible(false)
inst.tomouataque = 0 
inst:RemoveTag("teletransportando")
end)
return end

if inst.tomouataque > 4 and inst.form == 5 and inst.bosswelltalking == false then
inst:AddTag("teletransportando")
inst.AnimState:PlayAnimation("disappear"..inst.form.."")
inst.form = 5
inst.components.health:SetInvincible(true)
inst:DoTaskInTime(1, function()
local trono = GetClosestInstWithTag("maxwelllock", inst, 70)
if trono then
local xpos, ypos, zpos = trono.Transform:GetWorldPosition()
inst.Transform:SetPosition(xpos - math.random(-8, 8), ypos, zpos - math.random(-10, 10))
end	
inst.AnimState:PushAnimation("appear"..inst.form.."")
inst.AnimState:PushAnimation("idle"..inst.form.."_loop", true)
inst.components.health:SetInvincible(false)
inst.tomouataque = 0 
inst:RemoveTag("teletransportando")
end)
return end

if inst.bosswelltalking == false then
	inst.AnimState:PlayAnimation("dialog"..inst.form.."_pre")
	inst.AnimState:PushAnimation("idle"..inst.form.."_loop")
end

end
end 

local function OnDeath(inst)
	inst:RemoveComponent("inspectable")
	inst.AnimState:PlayAnimation("disappear"..inst.form.."")
	inst:DoTaskInTime(1, function()
	inst.DynamicShadow:SetSize(0, 0)
	MatarTropas(inst)
	SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition())

--	inst.AnimState:SetBank("FORCEEXPORT/portal")
--    inst.AnimState:SetBuild("maxwell_endgame")
--    inst.AnimState:PushAnimation("anim",true)
--    inst.AnimState:PushAnimation("anim", true)
--    inst.AnimState:PushAnimation("anim", true)	
	inst:DoTaskInTime(0.5, function() SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition()) end)
	inst:DoTaskInTime(1, function() SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition()) end)
	inst:DoTaskInTime(1.5, function() SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition()) end)	
	inst:DoTaskInTime(2, function() SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition()) end)	
	inst:DoTaskInTime(2.5, function() SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition()) end)	
	inst:DoTaskInTime(3, function() SpawnPrefab("shadow_despawn").Transform:SetPosition(inst.Transform:GetWorldPosition()) inst.components.lootdropper:DropLoot() end)			
	inst:DoTaskInTime(3.5, function()
	inst.SoundEmitter:KillSound("talkbosswell")	
	inst.SoundEmitter:KillSound("talkbosswelldeath")	
	inst:Remove()		
	end)

end)
		
end

local function onsave(inst, data)
	data.reloadmaxwellbossspawned = inst.reloadmaxwellbossspawned
	data.form = inst.form
end

local function onload(inst, data)
	if data ~= nil and data.reloadmaxwellbossspawned then
		inst.reloadmaxwellbossspawned = data.reloadmaxwellbossspawned
	end
	if data ~= nil and data.form then
		inst.form = data.form
	end
	
	if inst.reloadmaxwellbossspawned == true then
		MatarTropas(inst)
		inst:Remove()
	end
	
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
	inst.form = 2
	inst.tomouataque = 0
	
    MakeObstaclePhysics(inst, 2, 5)

	inst.Transform:SetTwoFaced()
	inst.DynamicShadow:SetSize( 2, .95 )
	inst.Transform:SetScale(2, 2, 2)

    inst.AnimState:SetBank("maxwell")
    inst.AnimState:SetBuild("maxwell_build")
    inst.AnimState:PlayAnimation("appear"..inst.form.."")
    inst.AnimState:PushAnimation("idle"..inst.form.."_loop", true)
	
	----
	inst:AddTag("epic")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")
	----

    inst.entity:SetPristine()

	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('maxwell_boss')
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 32
	inst.components.talker.font = TALKINGFONT
	inst.components.talker.offset = Vector3(80,-650,0)
	
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.reloadmaxwellbossspawned = false
	inst.bosswelltalking = false
	
--	inst.MiniMapEntity:SetIcon("donbossmaxwellsmap.tex")
	
    -------------------
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(maxbosswellmaxlife)
    inst.components.health.nofadeout = true
    inst:ListenForEvent("death", OnDeath)
    --------------------
    inst:AddComponent("combat")
    inst.components.combat:SetOnHit(OnHit)
    --------------------
    inst:AddComponent("inspectable")
    --------------------
    inst:AddComponent("teleporter")
    inst.components.teleporter:SetEnabled(false)


    inst.numminions = 0
    inst.minions = {}
    inst._onstoptrackingpet = function(minion)
        if inst.minions[minion] then
            inst.minions[minion] = nil
            inst.numminions = inst.numminions - 1
        end
    end
	
	inst.OnSave = onsave
    inst.OnLoad = onload
	
	MatarTropas(inst)

	Teletransporte(inst, 5)
	
    return inst
end

return Prefab("maxwellboss", fn, assets, prefabs)
