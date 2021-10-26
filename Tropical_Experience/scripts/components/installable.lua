local Installable = Class(function(self, inst)
    self.inst = inst
    self.prefab = nil
    self.componenttype = nil
    self.oninstallfn = nil
end)

function Installable:SetUp(prefab, componenttype, oninstallfn)
    self.prefab = prefab
    self.componenttype = componenttype
    self.oninstallfn = oninstallfn
end

function Installable:DoInstall(target)
    if target and target.components.installations then
        local obj = target.components.installations:Install(self.prefab)
        if obj and self.oninstallfn then
            self.oninstallfn(obj, target)
        end
    end
    return true
end

return Installable
