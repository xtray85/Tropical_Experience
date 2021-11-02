local mod_rarity_colors = {					--darker
	worst = { 150/255, 150/255, 150/255, 1},--105/255, 105/255, 105/255
	bad = { 235/255, 95/255, 95/255, 1} ,--190/255, 70/255, 70/255
	good = { 173/255, 213/255, 112/255 , 1 },--145/255, 180/255, 95/255
	rare = { 133/255, 230/255, 255/255, 1 },--35/255, 200/255, 225/255
	epic = {250/255, 190/255, 55/255, 1},--230/255, 175/255, 30/255
	legendary = {145/255, 85/255, 190/255, 1},--101/255, 45/255, 145/255
	mythic = {255/255, 125/255, 0/255, 1 },--x/255, x/255, x/255
	test = {30/255, 30/255, 30/255, 1},
	boss = {255/255, 150/255, 195/255, 1},
}

AddClassPostConstruct("widgets/hoverer", function(self, owner)--coloring on hover text for dropped items
	local oldUpdate = self.OnUpdate
	function self:OnUpdate()
		oldUpdate(self)
		
		local lmb = self.owner.components and self.owner.components.playercontroller:GetLeftMouseAction()
		if lmb and lmb.target then
			local color = self.text:GetColour() or GLOBAL.NORMAL_TEXT_COLOUR
			if lmb.target:GetIsWet() then
				color = GLOBAL.WET_TEXT_COLOUR
			end
			
			if lmb.target:HasTag("modifier_boss") then
				color = mod_rarity_colors["boss"]
			end

			if not lmb.target:GetIsWet() and lmb.target.replica.modifier and lmb.target.replica.modifier:IsModified() then
				local rarity = lmb.target.replica.modifier:GetRarity()--[[lmb.invobject and lmb.invobject.components.modifier.mod_rarity or]]
				color = rarity and mod_rarity_colors[string.lower(rarity)] or GLOBAL.NORMAL_TEXT_COLOUR
			end
			
			self.text:SetColour(color)
			self.secondarytext:SetColour(color)
		else--sometimes, 2nd text is the only 1 showing, without hovering on anything(Example: Waterballoon's Toss Action)
			self.secondarytext:SetColour(GLOBAL.NORMAL_TEXT_COLOUR)
		end
	end
end)

local UIAnim = GLOBAL.require "widgets/uianim"

local function updateUI(self)
	if self.item and self.item:IsValid() and self.item.replica.modifier and self.item.replica.modifier:IsModified() then
		local rarity = self.item.replica.modifier:GetRarity()
		self.modified:Show()
		if self.spoilage then
			self.spoilage:GetAnimState():SetMultColour(1,1,1,0.6)
		end

		if self.percent then
			if self.item:HasTag("modifier_sturdy_x") or self.item:HasTag("modifier_toughness_x") or self.item:HasTag("modifier_godlike") then
				self.percent:Hide()
			else
				self.percent:Show()
			end
		end
		if rarity and not self.item:GetIsWet() then
			self:SetTooltipColour(rarity and mod_rarity_colors[string.lower(rarity)] or GLOBAL.NORMAL_TEXT_COLOUR)
		end	

		self.modified:GetAnimState():PushAnimation(rarity and string.lower(rarity) or "test", true)
		if self.item:HasTag("modifier_ghoststrike") then
			self.item.uitask = self.item:DoPeriodicTask(0.9, function(inst)
				if inst.lastchange == nil then
					inst.lastchange = inst.replica.modifier:GetRarity()
				end
				if not inst:HasTag("modifier_ghoststrike") and inst.uitask then
					inst.uitask:Cancel()
					inst.uitask = nil
					inst.lastchange = nil
					return
				end
				local rar = inst:HasTag("modifier_ghoststrike_oncooldown") and "worst" or inst.replica.modifier:GetRarity()
				if inst.lastchange ~= rar then
					self.modified:GetAnimState():PushAnimation(rar and string.lower(rar) or "test", true)
					inst.lastchange = rar		
				end		
			end)
		end

		return rarity
	else
		self.modified:Hide()
		if self.spoilage then
			self.spoilage:GetAnimState():SetMultColour(1,1,1,1)
		end
		self:SetTooltipColour(self.item:GetIsWet() and GLOBAL.WET_TEXT_COLOUR or GLOBAL.NORMAL_TEXT_COLOUR)
		return nil
	end
end

AddClassPostConstruct("widgets/itemtile", function(self, owner)--adding new UIAnim for modifiers, coloring on hover text for inventory tiles
	self.modified = self:AddChild(UIAnim())
	self.modified:MoveToBack()--Index - modified: 0, bg: 1, spoilage: 2
	if self.bg then
        self.bg:MoveToBack()--Index - bg: 0, modified: 1, spoilage: 2
    end--so ordering is perish_bg, modifier, perish_pct, wetness, recharge_bg, item, recharge_pct
    self.modified:GetAnimState():SetBank("modifier_border")
    self.modified:GetAnimState():SetBuild("modifier_border")
	--self.modified:GetAnimState():PlayAnimation("test", true)
    self.modified:Hide()
	self.modified:SetClickable(false)

	updateUI(self)
	self.item:ListenForEvent("modifier_rarity_client", function(inst)
		updateUI(self)
	end)
	
	local oldUpdate = self.UpdateTooltip
	function self:UpdateTooltip()
		oldUpdate(self)
		updateUI(self)
	end

	local oldDrag = self.StartDrag
	function self:StartDrag()
		oldDrag(self)
		self.modified:Hide()
	end
end)