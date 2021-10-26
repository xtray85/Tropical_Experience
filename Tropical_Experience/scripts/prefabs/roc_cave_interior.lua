require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/pisohamlet.zip"),
    Asset("ANIM", "anim/wallhamletant.zip"),
    Asset("ANIM", "anim/bat_cave_door.zip"),
}


local function getlocationoutofcenter(dist,hole,random,invert)
local pos =  (math.random()*((dist/2) - (hole/2))) + hole/2    
if invert or (random and math.random()<0.5) then
pos = pos *-1
end
return pos
end	

local function createroom(inst)
--------------------------------------------------inicio da criacao---------------------------------------

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
---------------------------cria a parede inicio -------------------------------------
---------------------------parade dos aposento------------------------------------------------------------------	
local y = 0	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)

	local POS = {}
	for x = -8.5, 9.5 do
		for z = -13.5, 13.5 do
		
			if x == -8.5 or x == 9.5 or z == -13.5 or z == 13.5 then
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
	
----------------parede do fundo---------------------------------------------
	local part = SpawnPrefab("wallinteriorroc_cave")
	if part ~= nil then
	part.Transform:SetPosition(x -3.8, 0, z)
	part.Transform:SetRotation(0)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

------------------------piso--------------------------------
	local part = SpawnPrefab("roc_cave_floor")
	if part ~= nil then
	part.Transform:SetPosition(x-4.3, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
---------------------------------itens de dentro----------------------------
    local height = 18
    local width = 26
	local roomentrance1
	local roomtype = nil
	local roomtypes = {"stalacmites","stalacmites","glowplants","ferns","mushtree"}
	roomtype = roomtypes[math.random(1,#roomtypes)]
	
	local southexitopen = false
	local westexitopen = false
	local eastexitopen = false
	
if roomentrance1 then
	local part = SpawnPrefab("roc_cave_light_beam")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z -width/6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end	

----------------------------------comum---------------------------------------------
	local part = SpawnPrefab("deco_cave_cornerbeam")
	if part ~= nil then
	part.Transform:SetPosition(x -height/2, 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("deco_cave_cornerbeam")
	if part ~= nil then
	part.Transform:SetPosition(x -height/2, 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("deco_cave_pillar_side")
	if part ~= nil then
	part.Transform:SetPosition(x +height/2, 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
		
	local part = SpawnPrefab("deco_cave_pillar_side")
	if part ~= nil then
	part.Transform:SetPosition(x +height/2, 0, z + width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			
			
for i=1,math.random(1,3) do
	local part = SpawnPrefab("deco_cave_ceiling_trim")
	if part ~= nil then
	part.Transform:SetPosition(x -height/2, 0, z + getlocationoutofcenter(width*0.6, 3, true))
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

	local part = SpawnPrefab("deco_cave_floor_trim_front")
	if part ~= nil then
	part.Transform:SetPosition(x +height/2, 0, z -width/4)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end			

if southexitopen then
	local part = SpawnPrefab("deco_cave_floor_trim_front")
	if part ~= nil then
	part.Transform:SetPosition(x +height/2, 0, z)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end
			
	local part = SpawnPrefab("deco_cave_floor_trim_front")
	if part ~= nil then
	part.Transform:SetPosition(x +height/2, 0, z +width/4)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

if westexitopen and math.random()<0.7 then	
	local part = SpawnPrefab("deco_cave_floor_trim_2")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height/2*0.5, 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
end


if eastexitopen and math.random()<0.7 then
	local part = SpawnPrefab("deco_cave_floor_trim_2")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height/2*0.5, 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
	
if math.random()<0.7 then		
	local part = SpawnPrefab("deco_cave_ceiling_trim_2")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height/2*0.5, 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

if math.random()<0.7 then	
	local part = SpawnPrefab("deco_cave_ceiling_trim_2")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height/2*0.5, 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

if math.random() < 0.5 then			
	local part = SpawnPrefab("deco_cave_beam_room")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.65) - height/2*0.65, 0, z +getlocationoutofcenter(width*0.65,7,false,true))
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end	

if math.random() < 0.5 then	
	local part = SpawnPrefab("deco_cave_beam_room")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.65) - height/2*0.65, 0, z +getlocationoutofcenter(width*0.65,7))
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

	local part = SpawnPrefab("flint")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(height*0.65,3,true), 0, z +getlocationoutofcenter(width*0.65,3,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

if math.random() < 0.5 then	
	local part = SpawnPrefab("flint")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(height*0.65,3,true), 0, z +getlocationoutofcenter(width*0.65,3,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
-----------------------------stalacmites------------------------------------
if roomtype == "stalacmites" then
if math.random()<0.3 then
	local part = SpawnPrefab("stalagmite")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(height*0.65,4,true), 0, z +getlocationoutofcenter(width*0.65,4,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
end

if math.random()<0.2 then
if math.random()<0.5 then
	local part = SpawnPrefab("stalagmite")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(height*0.65,4,true), 0, z +getlocationoutofcenter(width*0.65,4,true) )
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end				
else
	local part = SpawnPrefab("stalagmite_tall")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(height*0.65,4,true), 0, z +getlocationoutofcenter(width*0.65,4,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
end

if math.random()<0.3 then			
	local part = SpawnPrefab("stalagmite_tall")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(height*0.65,3,true), 0, z +getlocationoutofcenter(width*0.65,3,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

if math.random()<0.5 then
	local part = SpawnPrefab("deco_cave_stalactite")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height*0.5/2, 0, z +getlocationoutofcenter(width,6,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

if math.random()<0.5 then
	local part = SpawnPrefab("deco_cave_stalactite")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height*0.5/2, 0, z +getlocationoutofcenter(width,6,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end
end	
--------------------------comum---------------------------------			
if math.random()<0.5 then
	local part = SpawnPrefab("deco_cave_stalactite")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height*0.5/2, 0, z +getlocationoutofcenter(width,6,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end			
			
if math.random()<0.5 then
	local part = SpawnPrefab("deco_cave_stalactite")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.5) - height*0.5/2, 0, z +getlocationoutofcenter(width,6,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end				

-------------------------------------ferns----------------------------
if roomtype == "ferns" then
for i=1,math.random(5,15) do
	local part = SpawnPrefab("cave_fern")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.7) - height*0.7/2, 0, z +(math.random()*width*0.7) - width*0.7/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end
end
-----------------------------------mushtree----------------------------
if roomtype == "mushtree" then
if math.random() < 0.3 then
for i=1,math.random(3,8) do
	local part = SpawnPrefab("mushtree_tall")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.7) - height*0.7/2, 0, z +(math.random()*width*0.7) - width*0.7/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end      	            
end
elseif math.random() < 0.5 then
for i=1,math.random(3,8) do
	local part = SpawnPrefab("mushtree_medium")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.7) - height*0.7/2, 0, z +(math.random()*width*0.7) - width*0.7/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end     	            
end	
else
for i=1,math.random(3,8) do
	local part = SpawnPrefab("mushtree_small")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.7) - height*0.7/2, 0, z +(math.random()*width*0.7) - width*0.7/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end       	            
end              
end
end

---------------------------------glowplants--------------------------------------
if roomtype == "glowplants" then
for i=1,math.random(4,12) do
	local part = SpawnPrefab("flower_cave")
	if part ~= nil then
	part.Transform:SetPosition(x +(math.random()*height*0.7) - height*0.7/2, 0, z +(math.random()*width*0.7) - width*0.7/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end       	            
end
end	
---------------------------------comum--------------------
for i=1,math.random(2,5) do
	local part = SpawnPrefab("cave_fern")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(height*0.7,3,true), 0, z +getlocationoutofcenter(width*0.7,3,true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

-----------------------------------------------------------------------------------------
inst:Remove()
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
	inst.AnimState:PlayAnimation("batcave_floor")
	inst:AddTag("caveinterior")
		
	inst:AddTag("NOCLICK")
	inst:AddTag("alt_tile")
	inst:AddTag("vulcano_part")
	inst:AddTag("terremoto")
	inst:AddTag("canbuild")	
	inst:AddTag("blows_air")	

    return inst
end

local function wall_common(build)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddNetwork()	
	inst.entity:AddAnimState()
    inst.AnimState:SetBank("wallhamletant")
    inst.AnimState:SetBuild("wallhamletant")
    inst.AnimState:PlayAnimation("batcave_wall_rock", true)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(7)      
	inst.AnimState:SetScale(4.5, 4.5, 4.5)      
			
	return inst
end

----------------------------------------------------------entrada-----------------------------------------------------------------------------
local function OnDoneTeleporting(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(5)
end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
		doer.mynetvarCameraMode:set(3)			
        --Sounds are triggered in player's stategraph
		elseif inst.SoundEmitter ~= nil then

    end
end

local function OnActivateexterior(inst, doer)
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

local function turnoff(inst, light)
    if light then    	
        light:Enable(false)
    end
end

local lights =
{
	day = {rad=3,intensity=0.75,falloff=0.5,color={1,1,1}},
	dusk = {rad=2,intensity=0.75,falloff=0.5,color={1/1.8,1/1.8,1/1.8}},
	full = {rad=2,intensity=0.75,falloff=0.5,color={0.8/1.8,0.8/1.8,1/1.8}}
}

local phasefunctions = 
{
    day = function(inst)
	    if not inst:IsInLimbo() then inst.Light:Enable(true) end
        inst.components.lighttweener:StartTween(nil, lights.day.rad, lights.day.intensity, lights.day.falloff, {lights.day.color[1],lights.day.color[2],lights.day.color[3]}, 2)
    end,

    dusk = function(inst) 
        if not inst:IsInLimbo() then inst.Light:Enable(true) end       
        inst.components.lighttweener:StartTween(nil, lights.dusk.rad, lights.dusk.intensity, lights.dusk.falloff, {lights.dusk.color[1],lights.dusk.color[2],lights.dusk.color[3]}, 2)
    end,

    night = function(inst) 
        if TheWorld.state.moonphase == "full" then
            inst.components.lighttweener:StartTween(nil, lights.full.rad, lights.full.intensity, lights.full.falloff, {lights.full.color[1],lights.full.color[2],lights.full.color[3]}, 4)
        else
            inst.components.lighttweener:StartTween(nil, 0, 0, 1, {0,0,0}, 6, turnoff)
        end    
    end,
}

local function timechange(inst)    
    if TheWorld.state.isday then
    	if inst:HasTag("timechange_anims") then
        	inst.AnimState:PlayAnimation("to_day")
       		inst.AnimState:PushAnimation("day_loop", true)
    	end
        if inst.Light then
            phasefunctions["day"](inst)
        end
    elseif TheWorld.state.isnight then
    	if inst:HasTag("timechange_anims") then
       		inst.AnimState:PlayAnimation("to_night")
        	inst.AnimState:PushAnimation("night_loop", true)
    	end
        if inst.Light then
            phasefunctions["night"](inst)
        end
    elseif TheWorld.state.isdusk then
    	if inst:HasTag("timechange_anims") then
        	inst.AnimState:PlayAnimation("to_dusk")
        	inst.AnimState:PushAnimation("dusk_loop", true)
    	end
        if inst.Light then
            phasefunctions["dusk"](inst)
        end
    end
end

local function settimechange(inst)
	inst:AddComponent("lighttweener")
	inst.components.lighttweener:StartTween(inst.entity:AddLight(), lights.day.rad, lights.day.intensity, lights.day.falloff, {lights.day.color[1],lights.day.color[2],lights.day.color[3]}, 0)
	inst.Light:Enable(true)

	inst:WatchWorldState("isday", timechange)
	inst:WatchWorldState("isdusk", timechange)
	inst:WatchWorldState("isnight", timechange)  

	inst.timechanger = true
	timechange(inst)	
end

local function opendoor(inst, instant)
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/stone_door/slide")
	if inst.prefab == "pig_ruins_door_cima" then
	inst.AnimState:PlayAnimation("north_open")
	inst.AnimState:PushAnimation("north")	
	end
	if inst.prefab == "pig_ruins_door_baixo" then
	inst.AnimState:PlayAnimation("south_open")
	inst.AnimState:PushAnimation("south")	
	end
	if inst.prefab == "pig_ruins_door_esquerda" then
	inst.AnimState:PlayAnimation("east_open")
	inst.AnimState:PushAnimation("east")	
	end
	if inst.prefab == "pig_ruins_door_direita" then
	inst.AnimState:PlayAnimation("west_open")
	inst.AnimState:PushAnimation("west")	
	end
	
	inst.dooranimclosed = nil
	inst.components.teleporter.enabled = true
end

local function closedoor(inst, instant)
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/stone_door/close")
	if inst.prefab == "pig_ruins_door_cima" then
	inst.AnimState:PlayAnimation("north_shut")
	inst.AnimState:PushAnimation("north_closed")	
	end
	if inst.prefab == "pig_ruins_door_baixo" then
	inst.AnimState:PlayAnimation("south_shut")
	inst.AnimState:PushAnimation("south_closed")	
	end
	if inst.prefab == "pig_ruins_door_esquerda" then
	inst.AnimState:PlayAnimation("east_shut")
	inst.AnimState:PushAnimation("east_closed")	
	end
	if inst.prefab == "pig_ruins_door_direita" then
	inst.AnimState:PlayAnimation("west_shut")
	inst.AnimState:PushAnimation("west_closed")	
	end
	inst.dooranimclosed = true		
	inst.components.teleporter.enabled = false
end

local function OnSave(inst, data)
	if inst.timechanger then
		data.timechanger = true
	end
    if inst:HasTag("timechange_anims") then
    	data.timechange_anims = true
    end
    if inst:HasTag("lockable_door") then
    	data.lockable_door = true    	
    end
    if inst.dooranimclosed then
    	data.dooranimclosed = true
    end
    if inst:HasTag("guard_entrance") then
    	data.guard_entrance = true
    end
    if inst:HasTag("ruins_entrance")then
    	data.ruins_entrance = true
    end 
end


local function OnLoad(inst, data)
if data == nil then return end
    if data.timechanger then 
    	settimechange(inst)
    end    	
    if data.timechange_anims then
    	inst:AddTag("timechange_anims")
    	timechange(inst)
    end
    if data.lockable_door then
    	inst:AddTag("lockable_door")
    end
    if data.dooranimclosed then
	
	if inst.prefab == "pig_ruins_door_cima" then
	inst.AnimState:PushAnimation("north_closed")	
	end
	if inst.prefab == "pig_ruins_door_baixo" then
	inst.AnimState:PushAnimation("south_closed")	
	end
	if inst.prefab == "pig_ruins_door_esquerda" then
	inst.AnimState:PushAnimation("east_closed")	
	end
	if inst.prefab == "pig_ruins_door_direita" then
	inst.AnimState:PushAnimation("west_closed")	
	end
    end
	if data.guard_entrance then
    	inst:AddTag("guard_entrance")
    end
    if data.ruins_entrance then
    	inst:AddTag("ruins_entrance")
    end
end

local function OnHaunt(inst, haunter)
inst.components.teleporter:Activate(haunter)
end

local function fnescadaentrada()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("doorway_cave")
    inst.AnimState:SetBuild("bat_cave_door")
    inst.AnimState:PlayAnimation("day_loop")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil


    settimechange(inst)

	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("timechange_anims")

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
    inst.components.teleporter.onActivate = OnActivateexterior
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad		
	
    inst:AddComponent("inventory")
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)	
    return inst
end

local function fnescadaentrada2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("exitrope")
    inst.AnimState:SetBuild("cave_exit_rope")
    inst.AnimState:PlayAnimation("idle_loop")
	inst.dooranimclosed = nil
	inst.timechanger = nil

	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("timechange_anims")

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
    inst.components.teleporter.onActivate = OnActivateexterior
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)
	
	
    inst:AddComponent("inventory")
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)	
    return inst
end

local function fnescadacima()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("doorway_cave")
    inst.AnimState:SetBuild("bat_cave_door")
    inst.AnimState:PlayAnimation("north")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil


    settimechange(inst)

	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

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

	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad		
	
    inst:AddComponent("inventory")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		
    return inst
end

local function fnescadabaixo()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("doorway_cave")
    inst.AnimState:SetBuild("bat_cave_door")
    inst.AnimState:PlayAnimation("south")
--    inst.AnimState:SetLayer(LAYER_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

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

	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad		
	
    inst:AddComponent("inventory")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		
    return inst
end

local function fnescadaesquerda()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("doorway_cave")
    inst.AnimState:SetBuild("bat_cave_door")
    inst.AnimState:PlayAnimation("east")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)	
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

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
	
	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad	

    inst:AddComponent("inventory")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		
    return inst
end

local function fnescadadireita()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("doorway_cave")
    inst.AnimState:SetBuild("bat_cave_door")
    inst.AnimState:PlayAnimation("west")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)	
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

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

    inst:AddComponent("inventory")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		
    return inst
end

local function normalroom()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
    inst.AnimState:SetBuild("palace")
    inst.AnimState:SetBank("palace")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

	inst.tipodesala = 0
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
    createroom(inst)
    return inst
end

return 	Prefab("createroccaveroom", normalroom, assets),
		Prefab("roc_cave_door_entrada", fnescadaentrada, assets),
		Prefab("roc_cave_door_rope", fnescadaentrada2, assets),
		Prefab("roc_cave_door_cima", fnescadacima, assets),
		Prefab("roc_cave_door_baixo", fnescadabaixo, assets),
		Prefab("roc_cave_door_esquerda", fnescadaesquerda, assets),
		Prefab("roc_cave_door_direita", fnescadadireita, assets),
		Prefab("roc_cave_floor", SpawnPiso1, assets),
		Prefab("wallinteriorroc_cave", wall_common, assets)