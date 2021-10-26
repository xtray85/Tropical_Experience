local function Oxygen_display(self)
	if 1 == 1 then --self.owner:HasTag("musha") then
	
		local OxygenBadge = GLOBAL.require "widgets/oxygenbadge"
		self.oxygen = self:AddChild(OxygenBadge(self.owner))
		self.owner.oxygenbadge = self.oxygen
		self._custombadge = self.oxygen 
		
		local badge_brain = self.brain:GetPosition()
		local AlwaysOnStatus = false
		for k,v in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do 
			local Mod = GLOBAL.KnownModIndex:GetModInfo(v).name
			if Mod == "Combined Status" then 
				AlwaysOnStatus = true
			end
		end
		if AlwaysOnStatus then
		self.oxygen:SetPosition(-65, -50, 0)	if self.owner:HasTag("musha") then	self.oxygen:SetPosition(-115, 70, 0) end
		else
		if self.owner:HasTag("musha") then	self.oxygen:SetPosition(-100, 65, 0) else
		self.oxygen:SetPosition(-40,-50,0)		
		self.brain:SetPosition(badge_brain.x + 40, badge_brain.y - 10, 0)
		end
		end
		
		self.oxygen:SetPercent(self.owner.components.oxygen:GetPercent(), self.owner.components.oxygen.max)
		
		local function OxygenDelta(data)
			self.oxygen:SetPercent(self.owner.components.oxygen:GetPercent(), self.owner.components.oxygen.max)
		
			if data.newpercent <= 0 then
				self.oxygen:StartWarning()
			else
				self.oxygen:StopWarning()
			end

			if not data.overtime then
				if data.newpercent > data.oldpercent then
					self.oxygen:PulseGreen()
					TheFrontEnd:GetSound():PlaySound("citd/HUD/thirst_up")
				elseif data.newpercent < data.oldpercent then
					TheFrontEnd:GetSound():PlaySound("citd/HUD/thirst_down")
					self.oxygen:PulseRed()
				end
			end
		end
			
		self.owner:ListenForEvent("oxygendelta", function(inst, data) OxygenDelta(data) end, self.owner)
end
end

AddClassPostConstruct("widgets/statusdisplays", Oxygen_display)