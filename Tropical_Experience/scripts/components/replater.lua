local Replater = Class(function(self, inst)
    self.inst = inst
    self.platetype = nil
    self.material = nil
end)

function Replater:SetUp(platetype, material)
    self.platetype = platetype
    self.material = material
end

return Replater
