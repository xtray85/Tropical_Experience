local Installations = Class(function(self, inst)
    self.inst = inst
    self.caninstallfn = nil
    self.installation = nil
    self.oninstallfn = nil
    inst:AddTag("installations")
end)

function Installations:SetUp(caninstallfn, oninstallfn)
    self.caninstallfn = caninstallfn
    self.oninstallfn = oninstallfn
end

function Installations:CanInstall(installable)
    return self.caninstallfn and self.caninstallfn(installable) and self.installation == nil
end

function Installations:IsInstalled()
    return self.installation ~= nil
end

function Installations:SetInstallation(installation)
    self.installation = installation
    if installation ~= nil then
        self.inst:AddTag("installations_occupied")
    else
        self.inst:RemoveTag("installations_occupied")
    end
end

function Installations:Install(prefab)
    local obj = SpawnPrefab(prefab)
    if obj then
        obj.entity:SetParent(self.inst.entity)
		obj.Transform:SetPosition(0, 0.03, 0)		
        self:SetInstallation(obj)
        if self.oninstallfn then
            self.oninstallfn(obj, self.inst)
        end
        return obj
    end
end

-- function Installations:OnLoad(data)
--     if data.installation then
--         self:SetInstallation(SpawnSaveRecord(data.installation))
--     end
-- end
--
-- function Installations:OnSave()
--     return {
--         installation = self.installation and self.installation:GetSaveRecord() or nil,
--     }
-- end

return Installations
