require "prefabutil"

local assets =
{
Asset("ANIM", "anim/pisolavarena.zip"),
Asset("ANIM", "anim/quagmire_park_fence.zip"),
}

local BASEMENT_SHADE = 0.5
local TAMANHODOMAPA = 1

local function OnSave(inst, data)
	data.entrada = inst.entrada
end


local function OnLoad(inst, data)
if data == nil then return end
	if data.entrada then inst.entrada = data.entrada end

end

local function DoShineFlick(inst)
	Waffles1.DoHauntFlick(inst, math.random() * 0.65)
	inst:DoTaskInTime(math.random(3), DoShineFlick)
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

local function IsNearBasement(x, y, z)
	return #TheSim:FindEntities(x, 0, z, 100, { "alt_tile" }) > 0
end

local function entrance()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()

    inst.AnimState:SetBuild("quagmire_portal")
    inst.AnimState:SetBank("quagmire_portal")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

    inst.Transform:SetEightFaced()
	
	inst.MiniMapEntity:SetIcon("minimap_volcano_entrance.tex")
	
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
	
	inst:SetDeployExtraSpacing(2.5)
			
	if not TheNet:IsDedicated() then
		inst:ListenForEvent("mouseover", OnMouseOver)
	end
	
	inst.entity:SetPristine()
		
	if not TheWorld.ismastersim then
		DoShineFlick(inst)
		
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
		local x = - 1800
		local z = - 1800
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
	
	inst.exit = SpawnPrefab("maxwellescada")
	inst.exit.Transform:SetPosition(unpack(basement_position))

---------------------------cria a parede inicio------------------------------------------------------------------	
local y = 0	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)

--tamanho do mapa	
	local POS = {}
--multiplo de 27 + metade dele	
	for x = -50, 5 do
		for z = -7, 7 do
		
			if x == 5 or z == -7 or z == 7 then
				table.insert(POS, { x = x, z = z })
			end
		end
	end


	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab("grade")
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end	
	


--tamanho do mapa	
	local POS = {}
--multiplo de 27 + metade dele	
	for x = -90, -50 do
		for z = -34, 34 do
		
			if x == -90 or z == -34 or z == 34 then
				table.insert(POS, { x = x, z = z })
			end
			
			if x == -50 and z > 6 or x == -50 and z < -6 then
				table.insert(POS, { x = x, z = z })
			end			
		end
	end

-- falta x = -50 para y > 5 e < 5
	
	
	
	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab("grade")
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end
-----------------------------------cercados internos---------------------------------------------------------------
---------------------------cria a parede inicio------------------------------------------------------------------	
local y = 0	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)
	
--tamanho do mapa	
	local POS = {}
--multiplo de 27 + metade dele	
	for x = -27*TAMANHODOMAPA-13, 27*TAMANHODOMAPA+13 do
		for z = -27*TAMANHODOMAPA-13, 27*TAMANHODOMAPA+13 do
--[[
			if x == -10 and z ~= 0 and z ~= -2 and z ~= 2 and z ~= -1 and z ~= 1 then
				table.insert(POS, { x = x, z = z })
			end
]]		
	
		end
	end

	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab("grade")
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end
	
------------------------portoes trancados--------------------------------
	local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-2 , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-15.5 , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-29 , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-42.5 , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-56 , 0, z-13.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-56 , 0, z-27)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-56 , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-56 , 0, z+13.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-56 , 0, z+27)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-69.5 , 0, z-13.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-69.5 , 0, z-27)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-69.5 , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-69.5 , 0, z+13.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-69.5 , 0, z+27)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end


		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-83 , 0, z-13.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-83 , 0, z-27)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-83 , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-83 , 0, z+13.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

		local part = SpawnPrefab("pisogorge1")
	if part ~= nil then
	part.Transform:SetPosition(x-83 , 0, z+27)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

------------walls------------------------	
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 69, 0, z-6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(0.25)
	end
	end		
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 70, 0, z-5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(0.5)
	end
	end	
	
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 71, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 72, 0, z-3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 73, 0, z-2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 74, 0, z-1)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end


	local part = SpawnPrefab("maxwelllock")
	if part ~= nil then
	part.Transform:SetPosition(x-69, 0, z-3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("maxwellthrone")
	if part ~= nil then
	part.Transform:SetPosition(x-71, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
	
	local part = SpawnPrefab("maxwellestatua")
	if part ~= nil then
	part.Transform:SetPosition(x-65, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("maxwellstatuecorpo")
	if part ~= nil then
	part.Transform:SetPosition(x-63, 0, z+9)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("maxwellstatuebracoe")
	if part ~= nil then
	part.Transform:SetPosition(x-60, 0, z-12)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("maxwellstatuebracod")
	if part ~= nil then
	part.Transform:SetPosition(x-71, 0, z-7)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwellstatuecabeca")
	if part ~= nil then
	part.Transform:SetPosition(x-75, 0, z+10)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("maxwellshadowheart")
	if part ~= nil then
	part.Transform:SetPosition(x-55, 0, z-14)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
		
	local part = SpawnPrefab("maxwellphonograph")
	if part ~= nil then
	part.Transform:SetPosition(x-69, 0, z+3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 75, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 74, 0, z+1)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 73, 0, z+2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 72, 0, z+3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 71, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 70, 0, z+5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(0.5)
	end
	end		
	
	local part = SpawnPrefab("wall_stone")
	if part ~= nil then
	part.Transform:SetPosition(x - 69, 0, z+6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(0.25)
	end
	end	

	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x - 67, 0, z+6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(0.25)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x - 67, 0, z-6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(0.25)
	end
	end	

------------------torch-------------------------------	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-5, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-5, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-12, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-12, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	



	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-19, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-19, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	


	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-26, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-26, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	


	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-33, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-33, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-40, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-40, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end


	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-47, 0, z-4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("maxwelllight_area")
	if part ~= nil then
	part.Transform:SetPosition(x-47, 0, z+4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
----------------------------criature dentro das jaulas-------------------------------------------------------------

if inst.caverna == nil then 

	
inst.caverna = 1
end
	
	
--------------------------------------------cria o piso e itens fim -------------------------------------------------------	
	
	
	
	
	
	
	
	
	
	
inst:DoTaskInTime(1, function(inst)
	local portaentrada = SpawnPrefab("maxwellescada")
	local a, b, c = inst.Transform:GetWorldPosition()
	portaentrada.Transform:SetPosition(a, b, c)
	portaentrada.components.teleporter.targetTeleporter = inst.exit
	inst.exit.components.teleporter.targetTeleporter = portaentrada
	
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





return 	Prefab("maxwell_entrance", entrance)