local Setupable = Class(function(self, inst) 
    self.inst = inst
	
	self.setupfn = nil
	self.issetup = nil
	self.setupitem = nil
	self.item = nil
	self.unsetupfn = nil
end)

function Setupable:IsSetup()
	return self.issetup
end

function Setupable:Setup(item) 
	if item.prefab == self.setupitem or item:HasTag(self.setupitem) then
		self.issetup = true
		
		if self.setupfn then
			self.setupfn(self.inst, item)
		end
		
		if item.components.finiteuses then
			self.uses = math.max(item.components.finiteuses.current - 1, 0)
		end
		
		self.item = item.prefab
		
		if item.components.stackable then
            item.components.stackable:Get():Remove()
        else
            item:Remove()
        end
	else
		return false
	end
end

function Setupable:Unsetup()
	self.issetup = nil
	
	if self.unsetupfn then
		self.unsetupfn(self.inst, self.item)
	end
end

function Setupable:OnSave()
	return { 
	
		issetup = self.issetup,
		uses = self.uses,
		item = self.item
	}
end

function Setupable:OnLoad(data)
	if data then
		self.issetup = data.issetup
		self.uses = data.uses
		self.item = data.item
	end
	if self.issetup and self.setupfn then
		self.setupfn(self.inst)
	end
end

return Setupable