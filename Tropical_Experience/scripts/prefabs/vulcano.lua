require "prefabutil"

local assets =
{
	hatch =
	{
		Asset("ANIM", "anim/vulcano_hatch.zip"),
		Asset("ANIM", "anim/vulcano_floor.zip"),
	},
	tile = { Asset("ANIM", "anim/vulcano_floor.zip") },
}

local BASEMENT_SHADE = 0.5
local TAMANHODOMAPA = 8
local WALL_ANIM_VARIANTS = { "fullA", "fullB", "fullC" }






local function OnSave(inst, data)
	data.entrada = inst.entrada
end


local function OnLoad(inst, data)
if data == nil then return end
	if data.entrada then inst.entrada = data.entrada end

end

local function OnActivateByOther(inst, source, doer)
--	if not inst.sg:HasStateTag("open") then
--		inst.sg:GoToState("opening")
--	end
	if doer ~= nil and doer.Physics ~= nil then
		doer.Physics:CollidesWith(COLLISION.WORLD)
	end
end

local function ExitOnActivateByOther(inst, other, doer)
	if doer ~= nil
	and doer.sg ~= nil and not doer:HasTag("playerghost") then
		doer.sg.statemem.teleportarrivestate = "jumpout_ceiling"
	end
end

local function ChainPlayerprox(inst, near) --currently doesn't work
	local link = inst.components.teleporter.targetTeleporter
	if Waffles1.Valid(link) and not link:IsAsleep() then
		if near then
			link.components.playerprox.onnear(link, true)
		else
			link.components.playerprox.onfar(link, true)
		end
	end
end

local function PlayTravelSound(inst, doer)
	inst.SoundEmitter:PlaySound("dontstarve/cave/rope_down")
end

local function ReceiveItem(teleporter, item)
	if item.Transform ~= nil then
		local x, y, z = teleporter.inst.Transform:GetWorldPosition()
		local angle = math.random() * 2 * PI
		
		if item.Physics ~= nil then
			item.Physics:Stop()
			if teleporter.inst:IsAsleep() then				
				local radius = teleporter.inst:GetPhysicsRadius(0) + math.random()
				item.Physics:Teleport(x + math.cos(angle) * radius, 0, z - math.sin(angle) * radius)
			else
				TemporarilyRemovePhysics(item, 1)
				local speed = 2 + math.random() * .5 + teleporter.inst:GetPhysicsRadius(0)
				item.Physics:Teleport(x, 4, z)
				item.Physics:SetVel(speed * math.cos(angle), -1, speed * math.sin(angle))
			end
		else
			local radius = 2 + math.random()
			item.Transform:SetPosition(x + math.cos(angle) * radius, 0,	z - math.sin(angle) * radius)
		end
	end
end

local function OnMouseOver(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	inst.highlightchildren = TheSim:FindEntities(x, y, z, 0, { "DECOR" })
end

local function OnActivate(inst, doer)
	if doer:HasTag("player") then
		if doer.components.talker ~= nil then
			doer.components.talker:ShutUp()
		end
	else
		inst.SoundEmitter:PlaySound("dontstarve/cave/rope_up")
	end
end

local function TakeLightSteps(light, value)
	local function LightToggle(light)
		light.level = (light.level or 0) + value
		if (value > 0 and light.level <= 1) or (value < 0 and light.level > 0) then
			light.Light:SetRadius(light.level)
			light.lighttoggle = light:DoTaskInTime(2 * FRAMES, LightToggle)
		elseif value < 0 then
			light.Light:Enable(false)
			light:Hide()
		end
		light.AnimState:SetScale(light.level, 1)
	end
	if light.lighttoggle ~= nil then
		light.lighttoggle:Cancel()
	end
	light.lighttoggle = light:DoTaskInTime(2 * FRAMES, LightToggle)
end

local function OnNearExit(inst, chain)
	inst.hatchlight.Light:Enable(true)
	inst.hatchlight:Show()
	
	TakeLightSteps(inst.hatchlight, 0.2)
	
	if not chain then
		ChainPlayerprox(inst, true)
	end
end

local function OnFarExit(inst, chain)	
	TakeLightSteps(inst.hatchlight, -0.2)
	
	if not chain then
		ChainPlayerprox(inst, false)
	end
end

local function OnNearEntrance(inst, chain)
--	if inst.components.teleporter:IsActive() and not inst.sg:HasStateTag("open") then
--		inst.sg:GoToState("opening")
--	end
	
--	if not chain then
--		ChainPlayerprox(inst, true)
--	end
end

local function OnFarEntrance(inst, chain)
--	if not inst.components.teleporter:IsBusy() and inst.sg:HasStateTag("open") then
--		inst.sg:GoToState("closing")
--	end
	
--	if not chain then
--		ChainPlayerprox(inst, false)
--	end
end

local function OnAccept(inst, giver, item)
	inst.components.inventory:DropItem(item)
	inst.components.teleporter:Activate(item)
end

local function wall_common(build)
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst.Transform:SetEightFaced()
	
	inst:AddTag("blocker")
	local phys = inst.entity:AddPhysics()
	phys:SetMass(0)
	phys:SetCollisionGroup(COLLISION.WORLD)
	phys:ClearCollisionMask()
	phys:CollidesWith(COLLISION.ITEMS)
	phys:CollidesWith(COLLISION.CHARACTERS)
	phys:CollidesWith(COLLISION.GIANTS)
	phys:CollidesWith(COLLISION.FLYERS)
	phys:SetCapsule(0.5, 50)

    inst.Transform:SetScale (scale[math.random (1, 6)], scale[math.random (5, 9)], scale[math.random (1, 6)])
    inst.Transform:SetRotation(math.random (125, 145), 0, 0)    inst.Transform:SetScale (scale[math.random (1, 6)], scale[math.random (5, 9)], scale[math.random (1, 6)])
    inst.Transform:SetRotation(math.random (125, 145), 0, 0)
	
    inst.AnimState:SetBank("volcano_cloud")
    inst.AnimState:SetBuild("volcano_cloud")
	inst.AnimState:OverrideShade(BASEMENT_SHADE)
		
	inst:AddTag("NOCLICK")
	inst:AddTag("vulcano_part")
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end
	
--	inst.AnimState:PlayAnimation(WALL_ANIM_VARIANTS[math.random(#WALL_ANIM_VARIANTS)])
	
--	inst.persists = false
			
	return inst
end

local function wall1()
	return wall_common("wall_stone")
end

local function wall2()
	return wall_common("wall_wood")
end


local function IsNearBasement(x, y, z)
	return #TheSim:FindEntities(x, 0, z, 100, { "alt_tile" }) > 0
end

local function entrance()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	inst.Transform:SetTwoFaced()
	
	MakeObstaclePhysics(inst, 0.65)
	
	inst.AnimState:SetBank("volcano_entrance")
	inst.AnimState:SetBuild("volcano_entrance")
	inst.AnimState:PlayAnimation("idle")	
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)
	
	inst.MiniMapEntity:SetIcon("minimap_volcano_entrance.tex")
	
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
	
	inst:SetDeployExtraSpacing(2.5)
			
	if not TheNet:IsDedicated() then
		inst:ListenForEvent("mouseover", OnMouseOver)
	end
	
	inst.entity:SetPristine()
		
	if not TheWorld.ismastersim then
		return inst
	end
		

	inst:AddComponent("inspectable")
--    inst.components.inspectable.getstatus = GetStatus
	
	inst:AddComponent("teleporter")
	inst.components.teleporter.onActivate = OnActivate
	inst.components.teleporter.onActivateByOther = OnActivateByOther
	inst.components.teleporter.offset = 0
	inst.components.teleporter.travelcameratime = 0.6
	inst.components.teleporter.travelarrivetime = 0.5
	
	inst:AddComponent("playerprox")
	inst.components.playerprox:SetDist(4, 5)
	inst.components.playerprox.onnear = OnNearEntrance
	inst.components.playerprox.onfar = OnFarEntrance
	
	inst:AddComponent("inventory")

	inst:AddComponent("trader")
	inst.components.trader.acceptnontradable = true
	inst.components.trader.onaccept = OnAccept
	inst.components.trader.deleteitemonaccept = false


--		if inst.components.teleporter.targetTeleporter ~= nil then
--		inst:RemoveEventCallback("onbuilt", OnBuilt)
--		return
--	end
if inst.entrada == nil then 	
--	local tries = 0
	local basement_position = nil
--	while true do	
		local x = -1800
		local z = 1800
--		if not IsNearBasement(x, 0, z) then  ------------------------------------------- retirar IsNearBasement
			basement_position = { x, 0, z }
--			break
--		else
--			tries = tries + 1
--			if tries > 50 then
--				TheNet:Announce("Failed to find valid position for basement.")
--				Waffles1.DespawnRecipe(inst, true)
--				return
--			end
--		end
--	end
	
	inst.exit = SpawnPrefab("escadadovulcao2")
	inst.exit.Transform:SetPosition(unpack(basement_position))
	
	
---------------------------cria a parede inicio------------------------------------------------------------------	
local y = 0	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)
	
--tamanho do mapa	
	local POS = {}
--multiplo de 27 + metade dele	
		for x = -27*TAMANHODOMAPA-13, 27*TAMANHODOMAPA+13 do
		for z = -27*TAMANHODOMAPA-13, 27*TAMANHODOMAPA+13 do
			if x == 27*TAMANHODOMAPA+13 or x == -27*TAMANHODOMAPA-13 or z == 27*TAMANHODOMAPA+13 or z == -27*TAMANHODOMAPA-13 then
				table.insert(POS, { x = x, z = z })
			end
		end
	end


	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab("wallfog")
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end	
----------------------------cria a parede fim-------------------------------------------------------------	
--------------------------------------------cria o piso e itens inicio -------------------------------------------------------		
	local POS = {}
	local POS1 = {}
	local POS2 = {}	
	local POS3 = {}	
	local POS4 = {}	



	
	for x = -27*TAMANHODOMAPA, 27*TAMANHODOMAPA do
		for z = -27*TAMANHODOMAPA, 27*TAMANHODOMAPA do
		

		
-- adiciona na tabela POS multiplos de 27 que e o tamanho do mapa
			if math.fmod (x, 27) == 0 and math.fmod (z, 27)==0 then			
				table.insert(POS, { x = x, z = z })				
			end
--adiciona na tabela POS1 multiplos de 3

--		    if math.fmod (x, 3) == 0 and math.fmod (z, 27)==0 then			
--			if  math.random (1 , 10) ==   math.random (1 , 10)	then	table.insert(POS1, { x = x, z = z }) end		--flamegeyser
--			end
			
--adiciona na tabela POS1 multiplos de 3

--		    if math.fmod (x, 3) == 0 and math.fmod (z, 27)==0 then			
--	         if  math.random (1 , 10) ==   math.random (1 , 10)	then	table.insert(POS2, { x = x, z = z }) end		--dragoonden		
--			end			
			
--adiciona na tabela POS1 multiplos de 3

--		    if math.fmod (x, 3) == 0 and math.fmod (z, 27)==0 then			
--	         if  math.random (1 , 10) ==   math.random (1 , 10)	then	table.insert(POS3, { x = x, z = z }) end		--volcano_shrub		
--			end		

--adiciona na tabela POS1 multiplos de 3

--		    if math.fmod (x, 3) == 0 and math.fmod (z, 27)==0 then			
--	         if  math.random (1 , 10) ==   math.random (1 , 10)	then	table.insert(POS4, { x = x, z = z }) end		--skeleton		
--			end					




			
			
		end
	end
			
	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab("piso")
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end
		

	
		for _,v in pairs(POS1) do
		local part = SpawnPrefab("flamegeyser")
		if part ~= nil then
			part.Transform:SetPosition(x + v.x + math.random (-13 , 13), 0, z + v.z + math.random (-13 , 13))
			if part.components.health ~= nil then
				part.components.health:SetPercent(1)
			end
		end
	end

			for _,v in pairs(POS2) do
		local part = SpawnPrefab("dragoonden")
		if part ~= nil then
			part.Transform:SetPosition(x + v.x + math.random (-13 , 13), 0, z + v.z + math.random (-13 , 13))
			if part.components.health ~= nil then
				part.components.health:SetPercent(1)
			end
		end
	end
	
	
				for _,v in pairs(POS3) do
		local part = SpawnPrefab("volcano_shrub")
		if part ~= nil then
			part.Transform:SetPosition(x + v.x + math.random (-13 , 13), 0, z + v.z + math.random (-13 , 13))
			if part.components.health ~= nil then
				part.components.health:SetPercent(1)
			end
		end
	end
	
				for _,v in pairs(POS4) do
		local part = SpawnPrefab("skeleton")
		if part ~= nil then
			part.Transform:SetPosition(x + v.x + math.random (-13 , 13), 0, z + v.z + math.random (-13 , 13))
			if part.components.health ~= nil then
				part.components.health:SetPercent(1)
			end
		end
	end
	

if inst.caverna == nil then 
	
	local part = SpawnPrefab("woodlegs_cage")
	if part ~= nil then
	part.Transform:SetPosition(x - 200, 0, z - 200)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("woodlegs_key2")
	if part ~= nil then
	part.Transform:SetPosition(x - 197, 0, z - 200)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
	
	local part = SpawnPrefab("firetwister")
	if part ~= nil then
	part.Transform:SetPosition(x + 200, 0, z - 200)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("lavapondbig1")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
-----------------------SPAWN-----------------------------------------
if TUNING.tropical.forge == 1 then	
	local part = SpawnPrefab("lavaarena_entrance")
	if part ~= nil then
	part.Transform:SetPosition(x - 170, 0, z + 170)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

	local part = SpawnPrefab("skeleton")
	if part ~= nil then
	part.Transform:SetPosition(x - 187.1, 0, z + 196.8)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("skeleton")
	if part ~= nil then
	part.Transform:SetPosition(x - 199, 0, z + 189.8)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	
	local part = SpawnPrefab("marblepillar")
	if part ~= nil then
	part.Transform:SetPosition(x - 210.2, 0, z + 207.3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("marblepillar")
	if part ~= nil then
	part.Transform:SetPosition(x - 207.4, 0, z + 191.1)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
		local part = SpawnPrefab("marblepillar")
	if part ~= nil then
	part.Transform:SetPosition(x - 195.3, 0, z + 210.2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("marblepillar")
	if part ~= nil then
	part.Transform:SetPosition(x - 195.6, 0, z + 190)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
			local part = SpawnPrefab("skeleton")
	if part ~= nil then
	part.Transform:SetPosition(x - 211.6, 0, z + 188.2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("marblepillar")
	if part ~= nil then
	part.Transform:SetPosition(x - 189.2, 0, z + 199.9)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
---------------------------------------	
	
for i = 1, math.random (10 , 20) do
	local part = SpawnPrefab("volcanofog")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end	

---------------------------------NEW VOLCANO---------------------------------
	local obsworkx = math.random (180 , 200)
	local obsworky = math.random (180 , 200)
	local bushx = math.random (-200 , 200)
	local bushy = math.random (-200 , 200)
	-------------------------WORKB---------------------
	local part = SpawnPrefab("obsidian_workbench")
	if part ~= nil then
	part.Transform:SetPosition(x + obsworkx, 0, z + obsworky)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end	
	
	for i = 1, 2 do 
	local part = SpawnPrefab("obsidian")
if part ~= nil then
	part.Transform:SetPosition(x + obsworkx + math.random (-5 , 5), 0, z + obsworky + math.random (-5 , 5))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end	end
	-----------------------------------------------------
	
	for i = 1, math.random (100 , 140) do
	local part = SpawnPrefab("rock_obsidian")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
	for i = 1, math.random (30 , 50) do
	local part = SpawnPrefab("skeleton")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
	for i = 1, math.random (60 , 90) do
	local part = SpawnPrefab("coffeebush")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
------------------------------coffe plant----------------
	for i = 1, 15 do
	local part = SpawnPrefab("coffeebush")
	if part ~= nil then
	part.Transform:SetPosition(x + bushx + math.random (-10 , 10), 0, z + bushy + math.random (-10 , 10))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
----------------------------------------------------------

	for i = 1, math.random (15 , 30) do
	local part = SpawnPrefab("dragoonden")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
	for i = 1, math.random (45 , 65) do
	local part = SpawnPrefab("elephantcactus")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
	for i = 1, math.random (40 , 70) do
	local part = SpawnPrefab("magmarock_gold")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
	for i = 1, math.random (90 , 120) do 
	local part = SpawnPrefab("magmarock")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
	for i = 1, math.random (55 , 75) do 
	local part = SpawnPrefab("volcano_shrub")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end
	
	for i = 1, math.random (60 , 70) do 
	local part = SpawnPrefab("rock_charcoal")
	if part ~= nil then
	part.Transform:SetPosition(x + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1), 0, z + math.random (40 , 200)* (math.random() < 0.5 and 1 or -1))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end end end	

inst.caverna = 1
end
	
	
--------------------------------------------cria o piso e itens fim -------------------------------------------------------	
	
inst:DoTaskInTime(1, function(inst)
	local portaentrada = SpawnPrefab("escadadovulcao")
	local a, b, c = inst.Transform:GetWorldPosition()
	portaentrada.Transform:SetPosition(a, b, c)

	portaentrada.components.teleporter.targetTeleporter = inst.exit
	inst.exit.components.teleporter.targetTeleporter = portaentrada
	local a, b, c = inst.exit.Transform:GetWorldPosition()	
	inst.exit.Transform:SetPosition(a-200, b, c+200)
	inst:Remove()
end)	
	
	
	
	
inst.entrada = 1	
end

	inst.components.teleporter.targetTeleporter = inst.exit
	inst.exit.components.teleporter.targetTeleporter = inst
	

	
--	inst:ListenForEvent("onbuilt", OnBuilt)
--	inst:ListenForEvent("doneteleporting", OnDoneTeleporting)
	inst:ListenForEvent("starttravelsound", PlayTravelSound)
		
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	
	return inst
end

local function SpawnPiso(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
	inst.AnimState:SetBank("basement_floor")
	inst.AnimState:SetBuild("vulcano__floor")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)
	inst.AnimState:OverrideShade(BASEMENT_SHADE)

--tamanho do chao
	inst.AnimState:SetScale(8, 8)
	inst.AnimState:PlayAnimation("rocky")
	
	--inst.Transform:SetScale(2.82, 2.82, 2.82)
		
	inst:AddTag("NOCLICK")
	inst:AddTag("alt_tile")
	inst:AddTag("canbuild")
	inst:AddTag("blows_air")	
	inst:AddTag("vulcano_part")

    return inst
end

local function exit_light()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddLight()
	inst.entity:AddNetwork()
	
	inst.Light:SetRadius(1)
	inst.Light:SetIntensity(0.85)
	inst.Light:SetFalloff(0.3)
	inst.Light:SetColour(0.7, 0.75, 0.67)

	inst.AnimState:SetBank("cavelight")
	inst.AnimState:SetBuild("cave_exit_lightsource")
	inst.AnimState:PlayAnimation("idle_loop", true)
	inst.AnimState:OverrideMultColour(0.35, 0.38, 0.33, 0)
	inst.AnimState:SetLightOverride(1)
	
	inst.Transform:SetScale(1.5, 0.4, 1)

	inst:AddTag("NOCLICK")
	inst:AddTag("FX")
	inst:AddTag("daylight")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	inst.persists = false

	return inst
end


return 	Prefab("vulcano_entrance", entrance),
		Prefab("vulcano_exit_light", exit_light),
		Prefab("wall_vulcano_1", wall1),
		Prefab("wall_vulcano_2", wall2),
		Prefab("piso", SpawnPiso, assets.tile)