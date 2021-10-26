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

local function OnAccept(inst, giver, item)
	inst.components.inventory:DropItem(item)
	inst.components.teleporter:Activate(item)
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
	
	local part = SpawnPrefab("pigman_collector_shopkeep")
	if part ~= nil then
	part.Transform:SetPosition(x -7.5, 0, z)
	part.sg:GoToState("desk_pre")
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
	
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x -2, 0, z)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.saleitem =  {"swbait","oinc",5}	
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x -5, 0, z +6)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +3, 0, z +(15/2) -5.5)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
			
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x -2, 0, z +4)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +0, 0, z +5.5)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
			
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x -5, 0, z - 6)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		

	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +3, 0, z  -(15/2) +5.5)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x -2, 0, z -4)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +0, 0, z -5.5)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.shoptype = "pig_shop_fishing"
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
	
	
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +6, 0, z -8)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.saleitem =  {"boat_item","oinc",5}
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
	
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +6, 0, z +8)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.saleitem =  {"oar","oinc",1}
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +8, 0, z +10)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.saleitem =  {"oceanfishingrod","oinc",5}
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +8, 0, z -10)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.saleitem =  {"axe","oinc",2}
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
	
	
	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +2, 0, z +10)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.saleitem =  {"machete","oinc",3}
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("shop_buyer")
	if part ~= nil then
	part.Transform:SetPosition(x +2, 0, z -10)
	part.startAnim = "idle_barrel_dome"
	part.AnimState:PlayAnimation("idle_barrel_dome")
	part.saleitem =  {"pickaxe","oinc",3}
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
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
			
	local part = SpawnPrefab("swinging_light_bank")
	if part ~= nil then
	part.Transform:SetPosition(x +3, 0, z -26/6 - 3)
	part.Transform:SetRotation(270)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
			
	local part = SpawnPrefab("swinging_light_bank")
	if part ~= nil then
	part.Transform:SetPosition(x +3, 0, z +26/6 + 3)
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


inst:DoTaskInTime(1, function(inst)
	local portaentrada = SpawnPrefab("pig_palace2")
	local a, b, c = inst.Transform:GetWorldPosition()
	portaentrada.Transform:SetPosition(a, b, c)
	portaentrada.components.teleporter.targetTeleporter = inst.exit
	inst.exit.components.teleporter.targetTeleporter = portaentrada	
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


return 	Prefab("pig_palace2_entrance", entrance)

