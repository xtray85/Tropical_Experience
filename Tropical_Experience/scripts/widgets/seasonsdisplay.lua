local function Fog_display(self)
local LeafBadge = GLOBAL.require "widgets/leafbadge"
self.leaf = self:AddChild(LeafBadge(self.owner))
self.owner.leafbadge = self.leaf
self.leaf:SetPosition(0,0,0)
self.leaf:MoveToBack()

local HayfeverBadge = GLOBAL.require "widgets/hayfeverbadge"
self.hayfever = self:AddChild(HayfeverBadge(self.owner))
self.owner.hayfeverbadge = self.hayfever
self.hayfever:SetPosition(0,0,0)
self.hayfever:MoveToBack()

--local LeafBadge2 = GLOBAL.require "widgets/leafbadge2"
--self.leaf2 = self:AddChild(LeafBadge2(self.owner))
--self.owner.leafbadge2 = self.leaf2
--self.leaf2:SetPosition(0,0,0)
--self.leaf2:MoveToBack()
end

AddClassPostConstruct("widgets/controls", Fog_display)