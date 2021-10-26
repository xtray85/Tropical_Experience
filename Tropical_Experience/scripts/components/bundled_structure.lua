local function onname(self,name)
	self.inst._name:set(tostring(name))
end
local Bundled_Structure = Class(function(self, inst)
	self.inst = inst
	self.canpackfn = nil
	self.package = nil
	self.name = nil
end,
nil,
{
    name = onname,
})

function Bundled_Structure:HasPackage()
	return self.package ~= nil
end

local function get_name(target)
	local name = target:GetDisplayName() or (target.components.named and target.components.named.name)
	if not name or name == "MISSING NAME" then return end
	local adj = target:GetAdjective()
	if adj then
		name = adj.." "..name
	end
	if target.components.stackable then
		local size = target.components.stackable:StackSize()
		if size > 1 then
			name = name.." x"..tostring(size)
		end
	end
	return name
end

function Bundled_Structure:Pack(target)
	self.package = {
		prefab1 = target:GetSaveRecord(),
	}
    if target.components.teleporter and target.components.teleporter.targetTeleporter then
        self.package.prefab2 = target.components.teleporter.targetTeleporter:GetSaveRecord()
        target.components.teleporter.targetTeleporter:Remove()
    end
	self.name = get_name(target)
	target:Remove()
	return true
end

function Bundled_Structure:Unpack(pos)
	inGamePlay = false
	if self.package ~= nil and self.package.prefab1 ~= nil  then
		local target = SpawnSaveRecord(self.package.prefab1)
		if target ~= nil and target:IsValid() then
			if target.Physics ~= nil then
				target.Physics:Teleport(pos:Get())
			else
				target.Transform:SetPosition(pos:Get())
			end
			if target.components.inventoryitem ~= nil then
				target.components.inventoryitem:OnDropped(true, .5)
			end
		end
        if self.package.prefab2 then
            local prefab2 = SpawnSaveRecord(self.package.prefab2)
            if prefab2 and target.components.teleporter and prefab2.components.teleporter then
                prefab2.components.teleporter:Target(target)
                target.components.teleporter:Target(prefab2)
            end
        end
	else
		--self
	end
	inGamePlay = true
end

function Bundled_Structure:OnSave()
	if self.package then
		return {package = self.package,name = self.name }
	end
end

function Bundled_Structure:OnLoad(data)
	if data then
		if  data.package then
			self.package = data.package
		end
		if  data.name then
			self.name = data.name
		end
	end
end

return Bundled_Structure
