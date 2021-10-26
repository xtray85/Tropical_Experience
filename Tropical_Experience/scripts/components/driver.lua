local Driver = Class(function(self, inst)
    self.inst = inst
	self.luzequipada = nil
	self.luzequipadatag = nil
	self.sailequipado = nil
	self.simbolo = nil
	self.simbolo1 = nil
	self.contagem = 1
	self.movimento = 0
	self.rededepesca = 0
end)

-- Only used to take care of some merging things 
-- if the character was on a boat when the merge happens
--function Driver:OnSave()
--	local data = {}
--	local refs = {}
--
--	data.driving = self.driving 
--
--	if self.vehicle then 
---		table.insert(refs, self.vehicle.GUID)
--		data.vehicle = self.vehicle.GUID
--		data.vehicle_prefab = self.vehicle.prefab
--	end
--	return data, refs
--end   
-- if TheNet:IsDedicated() then 
 

function Driver:OnUpdate(dt) --Set my entity's position and rotation to be the same as the drivable entity's
--remove o barco quebrado
local x, y, z = self.inst.Transform:GetWorldPosition()
if self.vehicle.components.finiteuses.current <= 0 or self.vehicle.components.workable.workleft <= 0 then
if self.vehicle.prefab == "surfboard" then
local resto = SpawnPrefab("flotsam_surfboard_build")
resto.Transform:SetPosition(x, y, z)	
elseif self.vehicle.prefab == "corkboat" then
local resto = SpawnPrefab("flotsam_lograft_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "raft_old" then
local resto = SpawnPrefab("flotsam_bamboo_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "lograft_old" then
local resto = SpawnPrefab("flotsam_lograft_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "rowboat" then
local resto = SpawnPrefab("flotsam_rowboat_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "cargoboat" then
local resto = SpawnPrefab("flotsam_cargo_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "armouredboat" then
local resto = SpawnPrefab("flotsam_armoured_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "encrustedboat" then
local resto = SpawnPrefab("flotsam_encrusted_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "woodlegsboat" then
local resto = SpawnPrefab("flotsam_rowboat_build")
resto.Transform:SetPosition(x, y, z)
end
self.vehicle:Remove()
self.inst:RemoveComponent("rowboatwakespawner")
self.inst:RemoveTag("sail")
self.inst:RemoveTag("surf")
self.inst:RemoveTag("aquatic")
self.inst.AnimState:SetSortOrder(0)
if self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) then self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO):Remove() end
self.inst:RemoveComponent("driver")
local fx = SpawnPrefab("collapse_small")
fx.Transform:SetPosition(x, y, z)
--self.inst.sg:GoToState("death_boat")
return 
end

--se nao tiver barco no inventario morre
if self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) == nil then
local x, y, z = self.inst.Transform:GetWorldPosition()
if self.vehicle.prefab == "surfboard" then
local resto = SpawnPrefab("flotsam_surfboard_build")
resto.Transform:SetPosition(x, y, z)	
elseif self.vehicle.prefab == "corkboat" then
local resto = SpawnPrefab("flotsam_lograft_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "raft_old" then
local resto = SpawnPrefab("flotsam_bamboo_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "lograft_old" then
local resto = SpawnPrefab("flotsam_lograft_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "rowboat" then
local resto = SpawnPrefab("flotsam_rowboat_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "cargoboat" then
local resto = SpawnPrefab("flotsam_cargo_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "armouredboat" then
local resto = SpawnPrefab("flotsam_armoured_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "encrustedboat" then
local resto = SpawnPrefab("flotsam_encrusted_build")
resto.Transform:SetPosition(x, y, z)
elseif self.vehicle.prefab == "woodlegsboat" then
local resto = SpawnPrefab("flotsam_rowboat_build")
resto.Transform:SetPosition(x, y, z)
end
self.vehicle:Remove()
self.inst:RemoveComponent("rowboatwakespawner")
self.inst:RemoveTag("sail")
self.inst:RemoveTag("surf")
self.inst:RemoveTag("aquatic")
self.inst.AnimState:SetSortOrder(0)
if self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) then self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.BARCO):Remove() end
self.inst:RemoveComponent("driver")
local fx = SpawnPrefab("collapse_small")
fx.Transform:SetPosition(x, y, z)
return 
end

local x, y, z = self.inst.Transform:GetWorldPosition()
if not TheWorld.Map:IsOceanAtPoint(x, y, z, false) and TheWorld.Map:IsValidTileAtPoint(x, y, z) then
if not self.inst.components.interactions then self.inst:AddComponent("interactions") end
self.inst.components.interactions:BoatDismount2(self.inst)
end


----------gira o barco-----------------------------
if self.vehicle then
--self.inst.components.talker:Say(""..self.inst.Transform:GetRotation().." ")

--[[
if TheCamera:GetHeading() == 0 then
if self.inst.Transform:GetRotation() >= 45 and self.inst.Transform:GetRotation() <= 135 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+270)
elseif self.inst.Transform:GetRotation() > 135 and self.inst.Transform:GetRotation() < 180 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+180)
elseif self.inst.Transform:GetRotation() >= -180 and self.inst.Transform:GetRotation() <= -135 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+180)
elseif self.inst.Transform:GetRotation() > -135 and self.inst.Transform:GetRotation() < -45 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+90)
else
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation())
end
end
]]

--[[
--print(self.inst)
if self.inst.Transform:GetRotation() >= 45 and self.inst.Transform:GetRotation() <= 135 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+270)
elseif self.inst.Transform:GetRotation() > 135 and self.inst.Transform:GetRotation() < 180 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+180)
elseif self.inst.Transform:GetRotation() >= -180 and self.inst.Transform:GetRotation() <= -135 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+180)
elseif self.inst.Transform:GetRotation() > -135 and self.inst.Transform:GetRotation() < -45 then
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation()+90)
else
self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation())
end
]]

--self.vehicle.Transform:SetPosition(0, -0.2, 0)
end
---------------------------------------consumo do barco--------------------------------------------------------------------------------
if self.inst.components.locomotor.isrunning then
if self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) ~= nil and self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD).prefab == "captainhat" then
if self.vehicle.prefab == "surfboard" then  self.vehicle.components.finiteuses:Use(0.00156) end
if self.vehicle.prefab == "raft" then  self.vehicle.components.finiteuses:Use(0.00234) end
if self.vehicle.prefab == "rowboat" then  self.vehicle.components.finiteuses:Use(0.00390) end
if self.vehicle.prefab == "cargoboat" then  self.vehicle.components.finiteuses:Use(0.00312) end
if self.vehicle.prefab == "encrustedboat" then  self.vehicle.components.finiteuses:Use(0.0050) end
if self.vehicle.prefab == "armouredboat" then  self.vehicle.components.finiteuses:Use(0.00431) end
if self.vehicle.prefab == "lograft" then  self.vehicle.components.finiteuses:Use(0.00234) end
if self.vehicle.prefab == "woodlegsboat" then  self.vehicle.components.finiteuses:Use(0.00234) end
else
if self.vehicle.prefab == "surfboard" then  self.vehicle.components.finiteuses:Use(0.00312) end
if self.vehicle.prefab == "raft" then  self.vehicle.components.finiteuses:Use(0.00468) end
if self.vehicle.prefab == "rowboat" then  self.vehicle.components.finiteuses:Use(0.00781) end
if self.vehicle.prefab == "cargoboat" then  self.vehicle.components.finiteuses:Use(0.00625) end
if self.vehicle.prefab == "encrustedboat" then  self.vehicle.components.finiteuses:Use(0.0100) end
if self.vehicle.prefab == "armouredboat" then  self.vehicle.components.finiteuses:Use(0.00862) end
if self.vehicle.prefab == "lograft" then  self.vehicle.components.finiteuses:Use(0.00468) end
if self.vehicle.prefab == "woodlegsboat" then  self.vehicle.components.finiteuses:Use(0.00468) end
end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------

local gastabarco = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
if gastabarco then
if gastabarco.components.container and not gastabarco.components.container:IsOpen() and self.inst.sg:HasStateTag("sailing") then gastabarco.components.container:Open(self.inst) end
gastabarco.components.finiteuses.current = self.vehicle.components.finiteuses.current
gastabarco.components.finiteuses:Use(0)
if self.vehicle.components.armor and gastabarco.components.armor then self.vehicle.components.armor.condition = gastabarco.components.armor.condition end
if gastabarco.components.armor and gastabarco.components.armor.condition > self.vehicle.components.finiteuses.current then gastabarco.components.armor.condition = self.vehicle.components.finiteuses.current end
if gastabarco.components.armor and gastabarco.components.armor.condition < self.vehicle.components.finiteuses.current then self.vehicle.components.finiteuses.current = gastabarco.components.armor.condition end
end

------------------------------------------------verifica se tem sail instalado-------------------------------------------------------------------------------------------------

  if gastabarco and gastabarco.components.container then 
------------------------------------remove o simbolo quando remove o item do container------------------------
     local sailslot = gastabarco.components.container:GetItemInSlot(1)
	 
if sailslot and sailslot.prefab == ("trawlnet") and not sailslot:HasTag("usada") then sailslot:AddTag("usada") end
     if sailslot == nil and self.sailequipado ~= nil then
     self.sailequipado = nil
	 if self.simbolo then 
--	 self.inst.AnimState:ClearOverrideSymbol(self.simbolo)
	 self.vehicle.AnimState:ClearOverrideSymbol(self.simbolo)
	 self.vehicle:RemoveTag("sail") gastabarco:RemoveTag("sail") self.inst:RemoveTag("sail")
	 end
     end
--------------------------------------aplica o simbolo quando adiciona o item no container-----------------------------------
     if sailslot ~= nil and self.sailequipado == nil then
--     self.inst.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol)
	 self.vehicle.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol)
	 if sailslot.prefab ~= "trawlnet" then self.vehicle:AddTag("sail") gastabarco:AddTag("sail") self.inst:AddTag("sail") end
	 self.simbolo = sailslot.symboltooverride
     self.sailequipado = sailslot
	 
if self.inst.sg:HasStateTag("sailing") then
if sailslot and sailslot.prefab ~= "trawlnet" then 
self.vehicle.AnimState:SetBank("wilson")
self.vehicle.AnimState:AddOverrideBuild("player_actions_paddle")
self.vehicle.AnimState:PlayAnimation("sail_loop", true)	 
end end	 
	 
     end
---------------------------------------aplica o simbolo na troca de itens no container--------------------------------	 
	 if sailslot ~= nil and self.sailequipado ~= nil and sailslot.prefab ~= self.sailequipado.prefab then
	 if self.simbolo then 
--	 self.inst.AnimState:ClearOverrideSymbol(self.simbolo) 
	 self.vehicle.AnimState:ClearOverrideSymbol(self.simbolo)
	 self.vehicle:RemoveTag("sail") gastabarco:RemoveTag("sail") self.inst:RemoveTag("sail")	 
	 end
--     self.inst.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol)
	 self.vehicle.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol)
	 if sailslot.prefab ~= "trawlnet" then self.vehicle:AddTag("sail") gastabarco:AddTag("sail") self.inst:AddTag("sail") end
	 self.simbolo = sailslot.symboltooverride
     self.sailequipado = sailslot
	 
if self.inst.sg:HasStateTag("sailing") then
if sailslot and sailslot.prefab ~= "trawlnet" then 
self.vehicle.AnimState:SetBank("wilson")
self.vehicle.AnimState:AddOverrideBuild("player_actions_paddle")
self.vehicle.AnimState:PlayAnimation("sail_loop", true)	 
end end		 
	 
     end
	 

------------------------------------remove o simbolo1 quando remove o item do container------------------------
     local luzslot = gastabarco.components.container:GetItemInSlot(2)
     if luzslot == nil and self.luzequipada ~= nil then
     self.luzequipada = nil
	 if self.simbolo1 then 
--	 self.inst.AnimState:ClearOverrideSymbol(self.simbolo1)
	 self.vehicle.AnimState:ClearOverrideSymbol(self.simbolo1)
	 end
     end
--------------------------------------aplica o simbolo1 quando adiciona o item no container-----------------------------------
     if luzslot ~= nil and self.luzequipada == nil then
--     self.inst.AnimState:OverrideSymbol(luzslot.symboltooverride, luzslot.build, luzslot.symbol)
	 self.vehicle.AnimState:OverrideSymbol(luzslot.symboltooverride, luzslot.build, luzslot.symbol)
	 self.simbolo1 = luzslot.symboltooverride
     self.luzequipada = luzslot
	 
if self.inst.sg:HasStateTag("sailing") then
if sailslot and sailslot.prefab ~= "trawlnet" then 
self.vehicle.AnimState:SetBank("wilson")
self.vehicle.AnimState:AddOverrideBuild("player_actions_paddle")
self.vehicle.AnimState:PlayAnimation("sail_loop", true)	 
end end	

     end
---------------------------------------aplica o simbolo1 na troca de itens no container--------------------------------	 
	 if luzslot ~= nil and self.luzequipada ~= nil and luzslot.prefab ~= self.luzequipada.prefab then
	 if self.simbolo1 then self.inst.AnimState:ClearOverrideSymbol(self.simbolo1) end
--     self.inst.AnimState:OverrideSymbol(luzslot.symboltooverride, luzslot.build, luzslot.symbol)
	 self.vehicle.AnimState:OverrideSymbol(luzslot.symboltooverride, luzslot.build, luzslot.symbol)
	 self.simbolo1 = luzslot.symboltooverride
     self.luzequipada = luzslot

if self.inst.sg:HasStateTag("sailing") then
if sailslot and sailslot.prefab ~= "trawlnet" then 
self.vehicle.AnimState:SetBank("wilson")
self.vehicle.AnimState:AddOverrideBuild("player_actions_paddle")
self.vehicle.AnimState:PlayAnimation("sail_loop", true)	 
end end	
	 
     end	 
-----------------------------------------animacao fixa e removida quando se movimenta para os 2 slots--------------------------------------------------------------------------------------
	
        
	      -------gasta sail pois se movimentou










------------------mostra simbolo do barco e tira do player para os 2 slots------------------------------------------------------
if not self.inst.sg:HasStateTag("sailing") and self.movimento == 1 then
self.movimento = 0
self.vehicle.AnimState:SetBank(self.vehicle.banc)
self.vehicle.AnimState:ClearOverrideBuild("player_actions_paddle")
self.vehicle.AnimState:PlayAnimation("run_loop", true)
if sailslot and sailslot.components.fueled then sailslot.components.fueled:StopConsuming() end 
--if self.inst.sg:HasStateTag("aparece") then self.vehicle:Show() end
--self.vehicle:Show()
--if sailslot and self.simbolo then 
--self.vehicle.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol)
--self.inst.AnimState:ClearOverrideSymbol(self.simbolo)
--end
--if luzslot and self.simbolo1 then 
--self.vehicle.AnimState:OverrideSymbol(luzslot.symboltooverride, luzslot.build, luzslot.symbol)
--self.inst.AnimState:ClearOverrideSymbol(self.simbolo1)
--end

end
-----------------mostra simbolo do player e tira o do barco para os 2 slots------------------------------------------------------
if self.inst.sg:HasStateTag("sailing") and self.movimento == 0 then
self.movimento = 1

if sailslot and sailslot.prefab ~= "trawlnet" then 
self.vehicle.AnimState:SetBank("wilson")
self.vehicle.AnimState:AddOverrideBuild("player_actions_paddle")
self.vehicle.AnimState:PlayAnimation("sail_loop", true)
if sailslot and sailslot.components.fueled then sailslot.components.fueled:StartConsuming() end
end
--self.vehicle:Hide()
--if luzslot and self.simbolo1 then 
--self.vehicle.AnimState:ClearOverrideSymbol(self.simbolo1)
--self.inst.AnimState:OverrideSymbol(luzslot.symboltooverride, luzslot.build, luzslot.symbol)
--end
--if sailslot and self.simbolo then
--self.vehicle.AnimState:ClearOverrideSymbol(self.simbolo)
--self.inst.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol)
--end 
     ------nao gasta sail pq parou 
end
-----------------------------------------------------------------------------------------------------------------------------------
--if self.inst.AnimState:GetCurrentAnimationTime() > 5 * FRAMES thenself.vehicle:Show()
-------------------------------------------------------------identificar o jogador dentro do prefab desses itens--------------------------------------------------------------------------------------------------------------------
	if luzslot ~= nil and self.vehicle ~= nil and luzslot.prefab == "quackeringram" then luzslot.navio1 = self.inst end
	if luzslot ~= nil and self.vehicle ~= nil and luzslot:HasTag("boatlight") then luzslot.navio = self.vehicle end 



--------------------------------------------procedimentos da rede de pesca--------------------------------------------------
local map = TheWorld.Map
local ex, ey, ez = self.inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez))

	if sailslot ~= nil and self.vehicle ~= nil and sailslot.prefab == "trawlnet" then 
	sailslot.navio = self.vehicle	
	if ground and self.inst.components.locomotor.isrunning and (ground == GROUND.OCEAN_WATERLOG or ground == GROUND.OCEAN_COASTAL_SHORE or ground == GROUND.OCEAN_SWELL or ground == GROUND.OCEAN_BRINEPOOL or ground == GROUND.OCEAN_COASTAL) then sailslot.raso = sailslot.raso + 0.003 end
	if ground and ground == GROUND.OCEAN_ROUGH and self.inst.components.locomotor.isrunning then  sailslot.medio = sailslot.medio + 0.003 end
	if ground and ground == GROUND.OCEAN_HAZARDOUS and self.inst.components.locomotor.isrunning then  sailslot.fundo = sailslot.fundo + 0.003 end
	if sailslot.apaga ~= nil then sailslot:Remove() end

	self.vehicle.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol)
--if self.rededepesca == 0 and (sailslot.medio + sailslot.fundo + sailslot.raso) > 3 then self.rededepesca = 1 end
--if self.rededepesca == 2 and (sailslot.medio + sailslot.fundo + sailslot.raso) > 6 then self.rededepesca = 3 end
--if self.rededepesca == 1 then self.vehicle.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol) self.rededepesca = 2 end
--if self.rededepesca == 3 then self.vehicle.AnimState:OverrideSymbol(sailslot.symboltooverride, sailslot.build, sailslot.symbol) self.rededepesca = 4 end 	
--print(""..sailslot.raso.."")

local planta = GetClosestInstWithTag("seaweednarede", self.inst, 3)
if planta then
local angle = self.inst:GetRotation()
local dist = -3
local offset = Vector3(dist * math.cos(angle*DEGREES), 0, -dist*math.sin(angle*DEGREES))
local x, y, z = self.inst.Transform:GetWorldPosition()
local pt = Vector3(x,y,z)
local chestpos = pt + offset
local cx, cy, cz = chestpos:Get()
local dx, dy, dz = planta.Transform:GetWorldPosition()
local result = cx - dx
local result2 = cz - dz
if result > -1.5 and result < 1.5 and result2 > -1.5 and result2 < 1.5 then
planta:Remove()
self.inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_plants")
sailslot.seawed = sailslot.seawed + 1
end
end


local planta = GetClosestInstWithTag("lobsterrede", self.inst, 3)
if planta then
local angle = self.inst:GetRotation()
local dist = -3
local offset = Vector3(dist * math.cos(angle*DEGREES), 0, -dist*math.sin(angle*DEGREES))
local x, y, z = self.inst.Transform:GetWorldPosition()
local pt = Vector3(x,y,z)
local chestpos = pt + offset
local cx, cy, cz = chestpos:Get()
local dx, dy, dz = planta.Transform:GetWorldPosition()
local result = cx - dx
local result2 = cz - dz
if result > -1.5 and result < 1.5 and result2 > -1.5 and result2 < 1.5 then
planta:Remove()
self.inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_plants")
sailslot.lobster = sailslot.lobster + 1
end
end

local planta = GetClosestInstWithTag("rainbowjellyfishrede", self.inst, 3)
if planta then
local angle = self.inst:GetRotation()
local dist = -3
local offset = Vector3(dist * math.cos(angle*DEGREES), 0, -dist*math.sin(angle*DEGREES))
local x, y, z = self.inst.Transform:GetWorldPosition()
local pt = Vector3(x,y,z)
local chestpos = pt + offset
local cx, cy, cz = chestpos:Get()
local dx, dy, dz = planta.Transform:GetWorldPosition()
local result = cx - dx
local result2 = cz - dz
if result > -1.5 and result < 1.5 and result2 > -1.5 and result2 < 1.5 then
planta:Remove()
self.inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_plants")
sailslot.rainbowjellyfish = sailslot.rainbowjellyfish + 1
end
end


local planta = GetClosestInstWithTag("musselrede", self.inst, 3)
if planta and planta.components.growable and planta.components.growable.stage >= 2 then
local angle = self.inst:GetRotation()
local dist = -3
local offset = Vector3(dist * math.cos(angle*DEGREES), 0, -dist*math.sin(angle*DEGREES))
local x, y, z = self.inst.Transform:GetWorldPosition()
local pt = Vector3(x,y,z)
local chestpos = pt + offset
local cx, cy, cz = chestpos:Get()
local dx, dy, dz = planta.Transform:GetWorldPosition()
local result = cx - dx
local result2 = cz - dz
if result > -1.5 and result < 1.5 and result2 > -1.5 and result2 < 1.5 then
planta.components.growable:SetStage(1)
self.inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_plants")
sailslot.mussel = sailslot.mussel + 1
end
end


local planta = GetClosestInstWithTag("jellyfishrede", self.inst, 3)
if planta then
local angle = self.inst:GetRotation()
local dist = -3
local offset = Vector3(dist * math.cos(angle*DEGREES), 0, -dist*math.sin(angle*DEGREES))
local x, y, z = self.inst.Transform:GetWorldPosition()
local pt = Vector3(x,y,z)
local chestpos = pt + offset
local cx, cy, cz = chestpos:Get()
local dx, dy, dz = planta.Transform:GetWorldPosition()
local result = cx - dx
local result2 = cz - dz
if result > -1.5 and result < 1.5 and result2 > -1.5 and result2 < 1.5 then
planta:Remove()
self.inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_plants")
sailslot.jellyfish = sailslot.jellyfish + 1
end
end


end 
-------------------------------------------------------------------------------------------------------------------



end
end

function Driver:OnMount(vehicle)
	self.vehicle = vehicle
	if self.vehicle:HasTag("ocupado") then self.inst.components.talker:Say(STRINGS.SEMBARCO) self.inst:RemoveComponent("driver") return end
	vehicle:AddTag("ocupado")
    self.vehicle.AnimState:AddOverrideBuild("player_actions_paddle")	
	
--self.vehicle.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--self.vehicle.AnimState:SetSortOrder(2)
	self.inst:AddTag("aquatic")
	if self.vehicle.prefab == ("surfboard") then self.inst:AddTag("surf") end
	self.inst:AddComponent("rowboatwakespawner")
--	vehicle.entity:AddFollower()

local x, y, z = self.inst.Transform:GetWorldPosition()
vehicle.entity:SetParent(self.inst.entity)
vehicle.Transform:SetPosition(0, -0.2, 0)
--vehicle.Transform:SetRotation(self.inst.Transform:GetRotation())

--	vehicle.AnimState:SetFinalOffset(5)	
	
	
	
--	self.inst.AnimState:AddOverrideBuild(self.vehicle.overridebuild)
if self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) and 
self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) == vehicle.prefab  then return end

local pegabarco = SpawnPrefab(vehicle.prefab)
pegabarco.components.finiteuses.current = vehicle.components.finiteuses.current	
self.inst.components.inventory:Equip(pegabarco)
self.inst:StartUpdatingComponent(self)

-------------------------transfere o conteudo do barco simbolo para o barco do inventario----------------------------------
if self.vehicle.components.container then

local sailslot = self.vehicle.components.container:GetItemInSlot(1)
if sailslot then
pegabarco.components.container:GiveItem(sailslot, 1)
end

local luzslot = self.vehicle.components.container:GetItemInSlot(2)
if luzslot then
pegabarco.components.container:GiveItem(luzslot, 2)
end

local cargoslot1 = self.vehicle.components.container:GetItemInSlot(3)
if cargoslot1 then
pegabarco.components.container:GiveItem(cargoslot1, 3)
end

local cargoslot2 = self.vehicle.components.container:GetItemInSlot(4)
if cargoslot2 then
pegabarco.components.container:GiveItem(cargoslot2, 4)
end

local cargoslot3 = self.vehicle.components.container:GetItemInSlot(5)
if cargoslot3 then
pegabarco.components.container:GiveItem(cargoslot3, 5)
end

local cargoslot4 = self.vehicle.components.container:GetItemInSlot(6)
if cargoslot4 then
pegabarco.components.container:GiveItem(cargoslot4, 6)
end

local cargoslot5 = self.vehicle.components.container:GetItemInSlot(7)
if cargoslot5 then
pegabarco.components.container:GiveItem(cargoslot5, 7)
end

local cargoslot6 = self.vehicle.components.container:GetItemInSlot(8)
if cargoslot6 then
pegabarco.components.container:GiveItem(cargoslot6, 8)
end

pegabarco.components.container:Open(self.inst)
self.vehicle:RemoveComponent("container")
self.vehicle.components.workable.workable = false
if self.vehicle.prefab == "surfboard" and self.inst.components.inventoryitem then self.inst.components.inventoryitem.canbepickedup = false end

end
self.inst:RemoveTag("pulando")
end

return Driver
