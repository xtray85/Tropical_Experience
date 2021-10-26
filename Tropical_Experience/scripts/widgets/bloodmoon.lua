local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"

local BloodmoonBadge = Class(Badge, function(self, owner)
	Badge._ctor(self, "bloodmoon", owner)
	
    self._moonanim = self:AddChild(UIAnim())
    self._moonanim:GetAnimState():SetBank("moon_phases_clock")
    self._moonanim:GetAnimState():SetBuild("moon_phases_clock")
    self._moonanim:GetAnimState():PlayAnimation("idle")
	self._moonanim:GetAnimState():OverrideSymbol("swap_moon", "moon_phases", "moon_full")
	
    self._rim = self:AddChild(UIAnim())
    self._rim:GetAnimState():SetBank("clock01")
    self._rim:GetAnimState():SetBuild("cave_clock")
    self._rim:GetAnimState():PlayAnimation("on")
	self._rim:SetScale(1.1)	

--    self._anim = self:AddChild(UIAnim())
--    self._anim:GetAnimState():SetBank("clock01")
--    self._anim:GetAnimState():SetBuild("clock_transitions")
--    self._anim:GetAnimState():PlayAnimation("idle_day", true)	
	
    self._face = self:AddChild(Image("images/hud.xml", "clock_NIGHT.tex"))
    self._face:SetClickable(false)	
    self._face:SetScale(1.1)
	
    self._text = self:AddChild(Text(BODYTEXTFONT, 33 / 1))
    self._text:SetPosition(5, 16, 0)	
	self._text:SetString("Red")
	
    self._text = self:AddChild(Text(BODYTEXTFONT, 33 / 1))
    self._text:SetPosition(5, -16 , 0)	
	self._text:SetString("Moon")	
	
	self:Hide()
	self:SetScale(1)
	
	self.contador = 0	
	self.aporkalypse = false

	self:StartUpdating()	
end)

function BloodmoonBadge:OnUpdate(dt)
self.contador = self.contador + 1
if self.contador > 50 then
self.contador = 0
for k,jogador in pairs(AllPlayers) do 
if jogador:HasTag("aporkalypse") and self.aporkalypse == false then
self.aporkalypse = true
self:Show()
end

if self.aporkalypse == true and not jogador:HasTag("aporkalypse") then
self.aporkalypse = false
self:Hide()
end


end
end 
end

return BloodmoonBadge