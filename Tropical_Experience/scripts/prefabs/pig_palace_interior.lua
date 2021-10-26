require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/pisohamlet.zip"),
	Asset("ANIM", "anim/wallhamletpig.zip"),
    Asset("ANIM", "anim/palace.zip"),
    Asset("ANIM", "anim/pig_shop_doormats.zip"),
    Asset("ANIM", "anim/palace_door.zip"),
    Asset("ANIM", "anim/interior_wall_decals_palace.zip"),	
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
		doer.sg.statemem.teleportarrivestate = "idle"
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


local function OnActivate(inst, doer)
	if doer:HasTag("player") then
		if doer.components.talker ~= nil then
			doer.components.talker:ShutUp()
		end
	else
		inst.SoundEmitter:PlaySound("dontstarve/cave/rope_up")
	end
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

--    inst.AnimState:SetBuild("palace")
--    inst.AnimState:SetBank("palace")
--    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

    inst.Transform:SetEightFaced()
	
	inst.MiniMapEntity:SetIcon("minimap_volcano_entrance.tex")
	
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
	
	inst:SetDeployExtraSpacing(2.5)
	
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
local x = 0
local y = 0
local z = 0
if TheWorld.components.contador then TheWorld.components.contador:Increment(1) end
local numerounico = TheWorld.components.contador.count

x = TheWorld.components.contador:GetX()
y = 0
z = TheWorld.components.contador:GetZ()
-------------aqui é a porta de entrada-----------------------------------	
	inst.exit = SpawnPrefab("palace_door_saida")
	inst.exit.Transform:SetPosition(x+9.5, 0, z+0.5)
	

---------------------------cria a parede inicio------------------------------------------------------------------	
local tipodemuro = "wall_tigerpond"
---------------------------cria a parede inicio -------------------------------------
---------------------------cria a parede inicio------------------------------------------------------------------	
local y = 0	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)

	local POS = {}
	for x = -9, 10 do
		for z = -13.5, 13.5 do
		
			if x == -9 or x == 10 or z == -13.5 or z == 13.5 then
				table.insert(POS, { x = x, z = z })
			end
		end
	end


	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab(tipodemuro)
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end	
	


local tipo = "principal" -- gallery ou giftshop 	
if tipo == "principal" then
-----------------------wall----------------------------------
	local part = SpawnPrefab("wallpalace")
	if part ~= nil then
	part.Transform:SetPosition(x-1.5, 0, z)
	part.Transform:SetRotation(0)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
------------------------tipo de chão--------------------------------
	local part = SpawnPrefab("pig_palace_floor")
	if part ~= nil then
	part.Transform:SetPosition(x-3.5, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
---------------------------------------------------------------------------

	local part = SpawnPrefab("prop_door_shadowpalace")
	if part ~= nil then
	part.Transform:SetPosition(x + 8.5, 0, z)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("deco_roomglow_large")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	part.Transform:SetRotation(0)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

--------------porta para ser trabalhada-----------------------	
	local portaesquerdapalacio = SpawnPrefab("palace_door_west")
	if portaesquerdapalacio ~= nil then
	portaesquerdapalacio.Transform:SetPosition(x, 0, z -26/2)
	if portaesquerdapalacio.components.health ~= nil then
	portaesquerdapalacio.components.health:SetPercent(1)
	end
	end		
-------------------------------------------------------		
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
			
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				

	local part = SpawnPrefab("deco_palace_beam_room_tall_corner_front")
	if part ~= nil then
	part.Transform:SetPosition(x +18/2, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			

	local part = SpawnPrefab("deco_palace_beam_room_tall_corner_front")
	if part ~= nil then
	part.Transform:SetPosition(x +18/2, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
			
	local part = SpawnPrefab("deco_palace_beam_room_tall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/6 - 1)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_beam_room_tall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/6 + 1)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		

	local part = SpawnPrefab("deco_palace_beam_room_tall_lights")
	if part ~= nil then
	part.Transform:SetPosition(x -18/6, 0, z -26/6 - 1)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_beam_room_tall_lights")
	if part ~= nil then
	part.Transform:SetPosition(x -18/6, 0, z +26/6 + 1)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_beam_room_tall_lights")
	if part ~= nil then
	part.Transform:SetPosition(x +18/6, 0, z -26/6 - 1)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
			
	local part = SpawnPrefab("deco_palace_beam_room_tall_lights")
	if part ~= nil then
	part.Transform:SetPosition(x +18/6, 0, z +26/6 + 1)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_big_front")
	if part ~= nil then
	part.Transform:SetPosition(x -18/6, 0, z -26/3 - 0.5)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_banner_big_front")
	if part ~= nil then
	part.Transform:SetPosition(x -18/6, 0, z +26/3 + 0.5)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_banner_big_front")
	if part ~= nil then
	part.Transform:SetPosition(x +18/6, 0, z -26/3 - 0.5)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
			
	local part = SpawnPrefab("deco_palace_banner_big_front")
	if part ~= nil then
	part.Transform:SetPosition(x +18/6, 0, z +26/3 + 0.5)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
			
	local part = SpawnPrefab("deco_palace_banner_small_front")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/18 - 3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_banner_small_front")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/18 +3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_banner_small_front")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/18 - 26/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
			
	local part = SpawnPrefab("deco_palace_banner_small_front")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/18 - 26/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/14, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/14, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x +18/14, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x +18/14, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				

	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/14*3, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/14*3, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x +18/14*3, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x +18/14*3, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/14*5, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/14*5, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x +18/14*5, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_banner_small_sidewall")
	if part ~= nil then
	part.Transform:SetPosition(x +18/14*5, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x -18/6, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
			
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x +18/6, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
			
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x -18/6, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
			
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x +18/6, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
			
	local part = SpawnPrefab("deco_palace_plant")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2+0.3, 0, z -26/6.5)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_palace_plant")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2+0.3, 0, z +26/6.5)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				

	local part = SpawnPrefab("wall_mirror")
	if part ~= nil then
	part.Transform:SetPosition(x +18/3, 0, z -26/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
			
	local part = SpawnPrefab("wall_mirror")
	if part ~= nil then
	part.Transform:SetPosition(x -18/3, 0, z -26/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			

	local part = SpawnPrefab("deco_cityhall_picture1")
	if part ~= nil then
	part.Transform:SetPosition(x +18/3, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("deco_cityhall_picture2")
	if part ~= nil then
	part.Transform:SetPosition(x -0.5, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
          
	local part = SpawnPrefab("deco_cityhall_picture1")
	if part ~= nil then
	part.Transform:SetPosition(x -18/3, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
			
	local part = SpawnPrefab("pigman_queen")
	if part ~= nil then
	part.Transform:SetPosition(x -3, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_throne")
	if part ~= nil then
	part.Transform:SetPosition(x -6, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
			
            -- floor corner pieces
	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x +18/2+0.5, 0, z +26/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x +18/2+0.5, 0, z -26/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/2)
	part.Transform:SetRotation(0)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
            -- front wall floor lights
	local part = SpawnPrefab("swinglightobject")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/3)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("swinglightobject")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/3)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
			
    -- back wall lights and floor lights
	local part = SpawnPrefab("window_round_light_backwall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/3)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("window_palace")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z -26/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
			
	local part = SpawnPrefab("window_round_light_backwall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/3)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
			
	local part = SpawnPrefab("window_palace")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("window_round_light_backwall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("window_palace_stainglass")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
-- aisle rug			
	local part = SpawnPrefab("rug_palace_runner")
	if part ~= nil then
	part.Transform:SetPosition(x -3.38, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("rug_palace_runner")
	if part ~= nil then
	part.Transform:SetPosition(x -3.38*2, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("rug_palace_runner")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("rug_palace_runner")
	if part ~= nil then
	part.Transform:SetPosition(x +3.38, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("rug_palace_runner")
	if part ~= nil then
	part.Transform:SetPosition(x +3.38*2, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

----------------------------------segundo pavimento do palacio-------------------------------------------------------
local x = 0
local y = 0
local z = 0
if TheWorld.components.contador then TheWorld.components.contador:Increment(1) end
local numerounico = TheWorld.components.contador.count

x = TheWorld.components.contador:GetX()
y = 0
z = TheWorld.components.contador:GetZ()


---------------------------cria a parede inicio------------------------------------------------------------------	
local tipodemuro = "wall_tigerpond"
---------------------------parade dos aposento------------------------------------------------------------------	
local y = 0	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)

	local POS = {}
	for x = -7, 7 do
		for z = -9.5, 9.5 do
		
			if x == -7 or x == 7 or z == -9.5 or z == 9.5 then
				table.insert(POS, { x = x, z = z })
			end
		end
	end


	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab(tipodemuro)
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end	
	


----------------parede---------------------------------------------
	local part = SpawnPrefab("wallgallery")
	if part ~= nil then
	part.Transform:SetPosition(x -1, 0, z)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
------------------------tipo de chão--------------------------------
	local part = SpawnPrefab("pig_palace_gallery_floor") --"pig_palace_floor"
	if part ~= nil then
	part.Transform:SetPosition(x-2.9, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
--------------------------------------------------------------------------------------
	local part = SpawnPrefab("deco_roomglow")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local portaesquerdagaleria = SpawnPrefab("gallery_door_west")
	if portaesquerdagaleria ~= nil then
	portaesquerdagaleria.Transform:SetPosition(x, 0, z -9)
	if portaesquerdagaleria.components.health ~= nil then
	portaesquerdagaleria.components.health:SetPercent(1)
	end
	end


	local portadireitagaleria = SpawnPrefab("gallery_door_east")
	if portadireitagaleria ~= nil then
	portadireitagaleria.Transform:SetPosition(x, 0, z +9)
	if portadireitagaleria.components.health ~= nil then
	portadireitagaleria.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x -6.5, 0, z + 18/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x +6.5, 0, z + 18/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x +6.5, 0, z - 18/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x -6.5, 0, z - 18/2)
	part.Transform:SetRotation(0)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
	
	local part = SpawnPrefab("window_round_light_backwall")
	if part ~= nil then
	part.Transform:SetPosition(x -12/2, 0, z -18/3)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("window_palace")
	if part ~= nil then
	part.Transform:SetPosition(x -12/2, 0, z -18/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("window_round_light_backwall")
	if part ~= nil then
	part.Transform:SetPosition(x -18/2, 0, z +26/3)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("window_palace")
	if part ~= nil then
	part.Transform:SetPosition(x -12/2, 0, z +18/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x -12/2, 0, z -18/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_beam_room_tall_corner")
	if part ~= nil then
	part.Transform:SetPosition(x -12/2, 0, z +18/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("deco_palace_beam_room_tall_corner_front")
	if part ~= nil then
	part.Transform:SetPosition(x +12/2, 0, z -18/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_beam_room_tall_corner_front")
	if part ~= nil then
	part.Transform:SetPosition(x +12/2, 0, z +18/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("deco_palace_beam_room_tall")
	if part ~= nil then
	part.Transform:SetPosition(x -12/6, 0, z -18/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_beam_room_tall")
	if part ~= nil then
	part.Transform:SetPosition(x -12/6, 0, z +18/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("deco_palace_beam_room_tall")
	if part ~= nil then
	part.Transform:SetPosition(x +12/6, 0, z -18/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_beam_room_tall")
	if part ~= nil then
	part.Transform:SetPosition(x +12/6, 0, z +18/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("shelves_queen_display_1")
	if part ~= nil then
	part.Transform:SetPosition(x -12/4, 0, z -18/3)
	part.Transform:SetRotation(90)
	
	
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("shelves_queen_display_2")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
		
	local part = SpawnPrefab("deco_palace_banner_small_sidewal")
	if part ~= nil then
	part.Transform:SetPosition(x -12/14 * 3, 0, z -18/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_banner_small_sidewal")
	if part ~= nil then
	part.Transform:SetPosition(x -12/14 * 3, 0, z +18/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("deco_palace_banner_small_sidewal")
	if part ~= nil then
	part.Transform:SetPosition(x +12/14 * 3, 0, z -18/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_banner_small_sidewal")
	if part ~= nil then
	part.Transform:SetPosition(x +12/14 * 3, 0, z +18/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		

	local part = SpawnPrefab("shelves_marble2")
	if part ~= nil then
	part.Transform:SetPosition(x -12/2, 0, z)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
portaesquerdapalacio.components.teleporter.targetTeleporter = portadireitagaleria
portadireitagaleria.components.teleporter.targetTeleporter = portaesquerdapalacio	

------------------------------------parte 3----------------------------------
local x = 0
local y = 0
local z = 0
if TheWorld.components.contador then TheWorld.components.contador:Increment(1) end
local numerounico = TheWorld.components.contador.count

x = TheWorld.components.contador:GetX()
y = 0
z = TheWorld.components.contador:GetZ()

---------------------------cria a parede inicio------------------------------------------------------------------	
local tipodemuro = "wall_tigerpond"
---------------------------parade dos aposento------------------------------------------------------------------	
local y = 0	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)

	local POS = {}
	for x = -7, 6 do
		for z = -8.5, 8.5 do
		
			if x == -7 or x == 6 or z == -8.5 or z == 8.5 then
				table.insert(POS, { x = x, z = z })
			end
		end
	end


	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab(tipodemuro)
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end	
	
-----------------------wall----------------------------------
	local part = SpawnPrefab("wallshop")
	if part ~= nil then
	part.Transform:SetPosition(x-1.8, 0, z)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
------------------------tipo de chão--------------------------------
	local part = SpawnPrefab("pig_palace_shop_floor") --"pig_palace_floor"
	if part ~= nil then
	part.Transform:SetPosition(x-2.2, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
--------------------------------------------------------------------


	local part = SpawnPrefab("deco_roomglow")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local portasulgiftshop = SpawnPrefab("giftshop_door_south")
	if portasulgiftshop ~= nil then
	portasulgiftshop.Transform:SetPosition(x +10/2, 0, z)
	if portasulgiftshop.components.health ~= nil then
	portasulgiftshop.components.health:SetPercent(1)
	end
	end	
	
	local portadireitagiftshop = SpawnPrefab("giftshop_door_east")
	if portadireitagiftshop ~= nil then
	portadireitagiftshop.Transform:SetPosition(x, 0, z +15/2)
	if portadireitagiftshop.components.health ~= nil then
	portadireitagiftshop.components.health:SetPercent(1)
	end
	end		

	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x -5.5, 0, z + 15/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x +5.5, 0, z + 15/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x +5.5, 0, z - 15/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("rug_palace_corners")
	if part ~= nil then
	part.Transform:SetPosition(x -5.5, 0, z - 15/2)
	part.Transform:SetRotation(0)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("deco_palace_beam_room_short_corner_lights")
	if part ~= nil then
	part.Transform:SetPosition(x -10/2, 0, z - 15/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_beam_room_short_corner_lights")
	if part ~= nil then
	part.Transform:SetPosition(x -10/2, 0, z + 15/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("deco_palace_beam_room_short_corner_front_lights")
	if part ~= nil then
	part.Transform:SetPosition(x +10/2, 0, z - 15/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_palace_beam_room_short_corner_front_lights")
	if part ~= nil then
	part.Transform:SetPosition(x +10/2, 0, z + 15/2)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	
	local part = SpawnPrefab("deco_cityhall_picture2")
	if part ~= nil then
	part.Transform:SetPosition(x -10/2, 0, z - 15/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_cityhall_picture1")
	if part ~= nil then
	part.Transform:SetPosition(x -10/2, 0, z - 15/2)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("shelves_woodpalace")
	if part ~= nil then
	part.Transform:SetPosition(x -10/2, 0, z - 15/5)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("shelves_woodpalace")
	if part ~= nil then
	part.Transform:SetPosition(x -10/2, 0, z + 15/5)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("swinging_light_floral_bloomer")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("shelves_displaycase")
	if part ~= nil then
	part.Transform:SetPosition(x -10/5, 0, z - 15/3)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("shelves_displaycase")
	if part ~= nil then
	part.Transform:SetPosition(x +10/5, 0, z + 15/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("shelves_displaycase")
	if part ~= nil then
	part.Transform:SetPosition(x +10/5, 0, z - 15/3)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("shelves_displaycase")
	if part ~= nil then
	part.Transform:SetPosition(x -10/5, 0, z + 15/3)
	part.Transform:SetRotation(90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	
	
inst:DoTaskInTime(1, function(inst)
	local portaentrada = SpawnPrefab("pig_palace")
	local a, b, c = inst.Transform:GetWorldPosition()
	portaentrada.Transform:SetPosition(a, b, c)
	portaentrada.components.teleporter.targetTeleporter = inst.exit
	inst.exit.components.teleporter.targetTeleporter = portaentrada

portaesquerdapalacio.components.teleporter.targetTeleporter = portadireitagaleria
portadireitagaleria.components.teleporter.targetTeleporter = portaesquerdapalacio		

portaesquerdagaleria.components.teleporter.targetTeleporter = portadireitagiftshop
portadireitagiftshop.components.teleporter.targetTeleporter = portaesquerdagaleria

portasulgiftshop.components.teleporter.targetTeleporter = portaentrada
	
	inst:Remove()
end)	

end




	
--------------------------------------------cria o piso e itens fim -------------------------------------------------------		
	
inst.entrada = 1	
end
		
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	
	return inst
end

---------------------------------pisos---------------------------------------------------------------------------
local function SpawnPiso1(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
	inst.AnimState:SetBank("pisohamlet")
	inst.AnimState:SetBuild("pisohamlet")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)
	inst.AnimState:SetScale(3.8, 3.8, 3.8)
	inst.AnimState:PlayAnimation("floor_marble_royal")
	inst:AddTag("NOCLICK")
	inst:AddTag("alt_tile")
	inst:AddTag("vulcano_part")
	inst:AddTag("pisointeriorpalace")
	inst:AddTag("terremoto")
	inst:AddTag("blows_air")	

    return inst
end


local function SpawnPiso2(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
	inst.AnimState:SetBank("pisohamlet")
	inst.AnimState:SetBuild("pisohamlet")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)
	inst.AnimState:SetScale(5.5, 5.5, 5.5)
	inst.AnimState:PlayAnimation("floor_marble_royal_small")
	inst:AddTag("NOCLICK")
	inst:AddTag("alt_tile")
	inst:AddTag("vulcano_part")
	inst:AddTag("pisogalleryinteriorpalace")
	inst:AddTag("caveinterior")	
	inst:AddTag("terremoto")
	inst:AddTag("blows_air")	

    return inst
end

local function SpawnPiso3(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
	inst.AnimState:SetBank("pisohamlet")
	inst.AnimState:SetBuild("pisohamlet")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)
	inst.AnimState:SetScale(4.5, 4.5, 4.5)
	inst.AnimState:PlayAnimation("floor_marble_royal_small")
	inst:AddTag("NOCLICK")
	inst:AddTag("alt_tile")
	inst:AddTag("vulcano_part")
	inst:AddTag("shopinterior")
	inst:AddTag("blows_air")	

    return inst
end


local function wall_common1(build)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddNetwork()	
	inst.entity:AddAnimState()
    inst.AnimState:SetBank("wallhamletpig")
    inst.AnimState:SetBuild("wallhamletpig")
    inst.AnimState:PlayAnimation("wall_royal_high", true)
--	inst.AnimState:PlayAnimation("wall_royal_high",true)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(7)      
	inst.AnimState:SetScale(4.3, 4.8, 4.8)     
			
	return inst
end

local function wall_common2(build)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddNetwork()	
	inst.entity:AddAnimState()
    inst.AnimState:SetBank("wallhamletpig")
    inst.AnimState:SetBuild("wallhamletpig")
    inst.AnimState:PlayAnimation("wall_royal_high",true)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)   
    inst.AnimState:SetScale(2.5,3,3 )     			
	return inst
end

local function wall_common3(build)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddNetwork()	
	inst.entity:AddAnimState()
    inst.AnimState:SetBank("wallhamletpig")
    inst.AnimState:SetBuild("wallhamletpig")
    inst.AnimState:PlayAnimation("wall_royal_high",true)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)   
    inst.AnimState:SetScale(3.1,3.2,3.2 )   		
	return inst
end

----------------------------------------------------------entrada-----------------------------------------------------------------------------
local function OnDoneTeleporting(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(7)
end
end

local function OnDoneTeleportinggallery(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(5)
end
end

local function OnDoneTeleportinggalleryesquerda(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(4)
end
end

local function OnDoneTeleportingshop(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(4)
end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)
		doer.mynetvarCameraMode:set(6)
        local other = inst.components.teleporter.targetTeleporter
        if other ~= nil then
            DeleteCloseEntsWithTag("WORM_DANGER", other, 15)
        end

        if doer.components.talker ~= nil then
            doer.components.talker:ShutUp()
        end			
			
        --Sounds are triggered in player's stategraph
    elseif inst.SoundEmitter ~= nil then

    end
end

local function OnActivateByOther(inst, source, doer)
--    if not inst.sg:HasStateTag("open") then
--        inst.sg:GoToState("opening")
--    end
end

local function onaccept(inst, giver, item)
    inst.components.inventory:DropItem(item)
    inst.components.teleporter:Activate(item)
end

local function StartTravelSound(inst, doer)

end

local function OnHaunt(inst, haunter)
inst.components.teleporter:Activate(haunter)
end

local function fnescada()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "vamp_bat_cave.png" )	

    inst.AnimState:SetBank("palace_door")
    inst.AnimState:SetBuild("palace_door")
    inst.AnimState:PlayAnimation("south")

    inst:AddTag("trader")
	inst:AddTag("hamletteleport")	
    inst:AddTag("alltrader")
	inst:AddTag("guard_entrance")
    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
	inst.components.teleporter.hamlet = true	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

    inst:AddComponent("inventory")
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)	
	
    return inst
end

local function fnpalaceesquerda()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("wall_decals_palace")
    inst.AnimState:SetBuild("interior_wall_decals_palace")
    inst.AnimState:PlayAnimation("door_sidewall")
	inst.Transform:SetRotation(270)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)	
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("lockable_door")
	inst:AddTag("door_east")
    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false	
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)
		
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad	

    inst:AddComponent("inventory")

    return inst
end

local function fngaleriaesquerda()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("wall_decals_palace")
    inst.AnimState:SetBuild("interior_wall_decals_palace")
    inst.AnimState:PlayAnimation("door_sidewall")
--    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.Transform:SetRotation(270)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("lockable_door")
	inst:AddTag("door_west")
    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false	
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleportinggallery)
		
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad	

    inst:AddComponent("inventory")

    return inst
end

local function fngaleriadireita()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("wall_decals_palace")
    inst.AnimState:SetBuild("interior_wall_decals_palace")
    inst.AnimState:PlayAnimation("door_sidewall")
--    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.Transform:SetTwoFaced()
	inst.Transform:SetRotation(180)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("lockable_door")
	inst:AddTag("door_east")
    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false		
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleportinggallery)
		
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad	

    inst:AddComponent("inventory")

    return inst
end

local function fnshopsul()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("pig_shop_doormats")
    inst.AnimState:SetBuild("pig_shop_doormats")
    inst.AnimState:PlayAnimation("idle_giftshop")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.Transform:SetRotation(-90)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("guard_entrance")
    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false			
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleportingshop)
		
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad	

    inst:AddComponent("inventory")

    return inst
end

local function fnshopdireita()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("wall_decals_palace")
    inst.AnimState:SetBuild("interior_wall_decals_palace")
    inst.AnimState:PlayAnimation("door_sidewall")
--    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.Transform:SetTwoFaced()
	inst.Transform:SetRotation(180)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("lockable_door")
	inst:AddTag("door_east")
    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false		
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleportinggalleryesquerda)
		
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad	

    inst:AddComponent("inventory")

    return inst
end

local function shadowfnsouth()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("palace_door")
    inst.AnimState:SetBuild("palace_door")
    inst.AnimState:PlayAnimation("south_floor")
    inst:AddTag("NOCLICK")  -- Note for future self: Was commented out, but not sure why.. if it's not there, the shadow eats the click on the door.
    inst:AddTag("NOBLOCK")
--	inst.initInteriorPrefab = InitInteriorPrefab_shadow

    inst:AddTag("SELECT_ME")

    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )  
    return inst
end

return 	Prefab("pig_palace_entrance", entrance),
		Prefab("pig_palace_floor", SpawnPiso1, assets),
		Prefab("pig_palace_gallery_floor", SpawnPiso2, assets),
		Prefab("pig_palace_shop_floor", SpawnPiso3, assets),
		Prefab("wallpalace", wall_common1, assets),
		Prefab("wallshop", wall_common2, assets),
		Prefab("wallgallery", wall_common3, assets),

		Prefab("palace_door_saida", fnescada, assets),		
		Prefab("palace_door_west", fnpalaceesquerda, assets),		
		Prefab("gallery_door_west", fngaleriaesquerda, assets),
		Prefab("gallery_door_east", fngaleriadireita, assets),
		Prefab("giftshop_door_south", fnshopsul, assets),
		Prefab("giftshop_door_east", fnshopdireita, assets),
		
		Prefab("prop_door_shadowpalace", shadowfnsouth, assets, prefabs)	

