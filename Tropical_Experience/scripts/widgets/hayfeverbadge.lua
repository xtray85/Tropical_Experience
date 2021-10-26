local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local HayfeverBadge = Class(UIAnim, function(self, owner)
    self.owner = owner
    UIAnim._ctor(self)

    self:SetClickable(false)

    self:SetHAnchor(ANCHOR_MIDDLE)
    self:SetVAnchor(ANCHOR_MIDDLE)
    self:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)
	
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("polenfraco", true)		
	
	self:StartUpdating()
	self:Hide()
	self.speed = false
	self.hayfever = 0
	self.neblina = 0	
	self.ash = false
end)

function HayfeverBadge:OnUpdate(dt)
--print(TheWorld.state.wetness)
-------------------------------------fog---------------------------------------------
local fanlimpador = GetClosestInstWithTag("prevents_hayfever", self.owner, 15)
if (TheWorld.state.iswinter and TheWorld.state.precipitationrate > 0 and self.owner and self.owner.components.areaaware and self.owner.components.areaaware:CurrentlyInTag("hamlet") and TUNING.tropical.fog == 10) or
   (TheWorld.state.iswinter and TheWorld.state.precipitationrate > 0 and self.owner and self.owner.components.areaaware and self.owner.components.areaaware:GetCurrentArea() ~= nil and TUNING.tropical.fog == 20) then

if fanlimpador then 
if self.neblina and self.neblina > 0 then self.neblina = self.neblina - 2 end 
else self.neblina = self.neblina + 1 end
if self.neblina and self.neblina < 1000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop8", true)
	self:Hide()	
elseif self.neblina and self.neblina < 2000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop8", true)
	self:Show()	
elseif self.neblina and self.neblina < 3000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop7", true)
	self:Show()	
elseif self.neblina and self.neblina < 4000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop6", true)
	self:Show()	
elseif self.neblina and self.neblina < 5000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop5", true)
	self:Show()		
elseif self.neblina and self.neblina < 6000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop4", true)
	self:Show()		
elseif self.neblina and self.neblina < 7000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop3", true)
	self:Show()	
elseif self.neblina and self.neblina < 8000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop2", true)
	self:Show()		
elseif self.neblina and self.neblina < 9000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop1", true)
	self:Show()
elseif self.neblina and self.neblina >= 9000 then
    self:GetAnimState():SetBank("vagner_over")
    self:GetAnimState():SetBuild("vagner_over")
    self:GetAnimState():PlayAnimation("foog_loop", true)
	self:Show()	
end	
local corpo = self.owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
local cabeca = self.owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)

if corpo or cabeca then
self.speed = true
end

if not corpo and not cabeca then
self.speed = false
end

if corpo and corpo:HasTag("velocidadenormal") then
self.speed = false
end

if cabeca and cabeca:HasTag("velocidadenormal") then
self.speed = false
end

if self.speed and self.speed == true then
if not self.owner:HasTag("hamfogspeed") then self.owner:AddTag("hamfogspeed") end
else
if self.owner:HasTag("hamfogspeed") then self.owner:RemoveTag("hamfogspeed") end
end	

-------------------------------------hay fever--------------
elseif self.owner and self.owner:HasTag("hayfever1") then
self.neblina = 0
if self.owner:HasTag("hamfogspeed") then self.owner:RemoveTag("hamfogspeed") end
self:GetAnimState():SetBank("vagner_over")
self:GetAnimState():SetBuild("vagner_over")
self:GetAnimState():PlayAnimation("polenfraco", true)
self:Show()	

elseif self.owner and self.owner:HasTag("hayfever2") then
self.neblina = 0
if self.owner:HasTag("hamfogspeed") then self.owner:RemoveTag("hamfogspeed") end
self:GetAnimState():SetBank("vagner_over")
self:GetAnimState():SetBuild("vagner_over")
self:GetAnimState():PlayAnimation("polenfraco1", true)
self:Show()

elseif self.owner and self.owner:HasTag("hayfever3") then
self.neblina = 0
if self.owner:HasTag("hamfogspeed") then self.owner:RemoveTag("hamfogspeed") end
self:GetAnimState():SetBank("vagner_over")
self:GetAnimState():SetBuild("vagner_over")
self:GetAnimState():PlayAnimation("polenfraco2", true)
self:Show()	

elseif self.owner and self.owner:HasTag("hayfever4") then
self.neblina = 0
if self.owner:HasTag("hamfogspeed") then self.owner:RemoveTag("hamfogspeed") end
self:GetAnimState():SetBank("vagner_over")
self:GetAnimState():SetBuild("vagner_over")
self:GetAnimState():PlayAnimation("polenforte", true)
self:Show()	
	
else
-----------------------------------desativa-----------------------
if self.owner:HasTag("hamfogspeed") then self.owner:RemoveTag("hamfogspeed") end
if TheWorld.state.precipitationrate <= 0 and self.neblina and self.neblina > 0 then self.neblina = self.neblina - 2 end 
self:Hide()
end
---------------------------------leaf--------------------------------------------------
local x, y, z = self.owner.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x, y, z))
if self.owner and self.owner:HasTag("mostraselva") then --    ground == GROUND.DEEPRAINFOREST or ground == GROUND.GASJUNGLE then		
	if self.owner and self.owner.leafbadge then
	self.owner.leafbadge:StartUpdating()
	self.owner.leafbadge:Show()
	end
else
	if self.owner and self.owner.leafbadge then
	self.owner.leafbadge:StopUpdating()
	self.owner.leafbadge:Hide()	
--	if self.owner.leafbadge.sound then
--	self.owner.leafbadge.sound = nil
--	self.owner.SoundEmitter:KillSound("hamletjungle")
--	end	
	end	
end
------------------------------------------------------------------------------------------
end	


return HayfeverBadge