local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local LeafBadge = Class(UIAnim, function(self, owner)
    self.owner = owner
    UIAnim._ctor(self)

    self:SetClickable(false)

    self:SetHAnchor(ANCHOR_MIDDLE)
    self:SetVAnchor(ANCHOR_TOP)
    self:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)	
    self:GetAnimState():SetMultColour(1,1,1,1) 
    self:GetAnimState():SetBank("leaves_canopy2")
    self:GetAnimState():SetBuild("leaves_canopy2")
    self:GetAnimState():PlayAnimation("idle", true)
	
    self.leavesmoving = nil
    self.leavestop_intensity = 0
--	self.sound = nil
	self:Hide()	
end)

function LeafBadge:OnUpdate(dt)
--	if not self.sound then
--	self.sound = true
--	self.owner.SoundEmitter:PlaySound("dontstarve_DLC003/amb/inside/jungle", "hamletjungle")
--	end
if self.owner and self.owner.sg and self.owner.sg:HasStateTag("moving") then
	if not self.leavesmoving then
	self.leavesmoving = true
	self:GetAnimState():PlayAnimation("run_pre")	
	self:GetAnimState():PushAnimation("run_loop", true) 	
	end
	else
	if self.leavesmoving then
	self.leavesmoving = nil
	self:GetAnimState():PlayAnimation("run_pst")	
	self:GetAnimState():PushAnimation("idle", true)
	end
end	


if TheWorld.state.isdusk then
self:GetAnimState():SetMultColour(0.6, 0.6, 0.6,1) 
elseif TheWorld.state.isnight then
self:GetAnimState():SetMultColour(0.2, 0.2, 0.2,1) 
else
self:GetAnimState():SetMultColour(1,1,1,1)
end	
end	


return LeafBadge