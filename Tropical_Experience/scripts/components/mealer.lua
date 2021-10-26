local function onnotready(inst)
	if inst.replica.container ~= nil and inst.replica.container:IsEmpty() or inst.components.container:IsEmpty() then
		inst:RemoveTag("pleasetakeitem")
	end
end

local Mealer = Class(function(self, inst)
    self.inst = inst
	
	self.ismealing = nil
	
	self.wheat = 0
	self.salt = 0
	self.spice = 0
	
	self.prize = nil
	
	self.startmealingfn = nil
	self.donemealingfn = nil
	
	inst:ListenForEvent("itemlose", onnotready)
end)

function Mealer:Preserve()
    for k = 1,self.inst.components.container.numslots do
        local v = self.inst.components.container:GetItemInSlot(k)
        if v and v.components.perishable then
            v.components.perishable:StopPerishing()
        end
    end
end

function Mealer:Perish()
    for k = 1,self.inst.components.container.numslots do
        local v = self.inst.components.container:GetItemInSlot(k)
        if v and v.components.perishable then
            v.components.perishable:StartPerishing()
        end
    end
end

function Mealer:IsMealing()
    return self.ismealing
end

function Mealer:SetStartMealingFn(fn)
	self.startmealingfn = fn
end

function Mealer:CheckMeal()
    for k = 1,self.inst.components.container.numslots do
        local v = self.inst.components.container:GetItemInSlot(k)
        if v and v.components.mealable then
			if v.components.mealable:GetType() == "wheat" then
				self.wheat = self.wheat + 1	
				v:Remove()
			elseif v.components.mealable:GetType() == "salt" then
				self.salt = self.salt + 1	
				v:Remove()
			elseif v.components.mealable:GetType() == "spice" then
				self.spice = self.spice + 1	
				v:Remove()				
			end			
        end
    end
	
	if self.wheat >= 2 then
		self.prize = "quagmire_flour"
		self.wheat = 0
		self.salt = 0
		self.spice = 0		
	elseif self.salt >= 1 then
		self.prize = "spice_salt"
		self.wheat = 0
		self.salt = 0
		self.spice = 0
	elseif self.spice >= 3 then
		self.prize = "quagmire_spotspice_ground"
		self.wheat = 0
		self.salt = 0
		self.spice = 0		
	else
		self.prize = "ash"
		self.wheat = 0
		self.salt = 0
		self.spice = 0
	end
end

function Mealer:StartMealing()
	self.ismealing = true
	self.prize = nil
	
	self:CheckMeal()
	
	if self.startmealingfn then
		self.startmealingfn(self.inst)
	end
	
	self.inst.components.container:Close()
    self.inst.components.container.canbeopened = false
end

function Mealer:ResumeMealing()
	if self.startmealingfn then
		self.startmealingfn(self.inst)
	end
	
	self.inst.components.container:Close()
    self.inst.components.container.canbeopened = false
end

function Mealer:DoneMealing()
	self.ismealing = nil
	
	if self.donemealingfn then
		self.donemealingfn(self.inst)
	end
	
	local prize = SpawnPrefab(self.prize)
	
	self.inst:AddTag("pleasetakeitem")
	if self.prize == "spice_salt" then
	local prize1 = SpawnPrefab(self.prize)
	self.inst.components.container:GiveItem(prize1)
	local prize2 = SpawnPrefab(self.prize)
	self.inst.components.container:GiveItem(prize2)	
	end
	self.inst.components.container:GiveItem(prize)

	self.inst.components.container.canbeopened = true
end


return Mealer