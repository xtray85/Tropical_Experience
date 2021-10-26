local Driver2 = Class(function(self, inst)
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



function Driver2:OnUpdate(dt) --Set my entity's position and rotation to be the same as the drivable entity's
if self.inst.components.health:IsDead() then return end
-- remove colisao com ilhas aquaticas
local map = TheWorld.Map
local ex, ey, ez = self.inst.Transform:GetWorldPosition()


if self.vehicle then
--if self.vehicle.Follower then
--self.vehicle.Follower:FollowSymbol(self.inst.GUID,"torso",0,50,0)
end --end

--gira o barco
if self.vehicle then
--self.vehicle.Transform:SetRotation(self.inst.Transform:GetRotation())
--self.vehicle.Transform:SetPosition(0, -0.2, 0)
end

end

function Driver2:OnMount(vehicle)
self.vehicle = vehicle
self.vehicle.AnimState:AddOverrideBuild("player_actions_paddle")	
--self.vehicle.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
self.inst:AddTag("aquatic")
self.inst:AddComponent("rowboatwakespawner")
vehicle:AddTag("ocupado")
vehicle.entity:SetParent(self.inst.entity)
vehicle.Transform:SetPosition(0, -0.2, 0)
self.inst:StartUpdatingComponent(self)
end


return Driver2
