local Snackrificable = Class(function(self, inst)
    self.inst = inst
    self.value = 1
    self.cravings = {}
end)

function Snackrificable:SetUp(value, cravings)
    self.value = value
    self.cravings = cravings
end

function Snackrificable:GetValue()
    return self.value
end

function Snackrificable:SatisfiesCraving(targetcraving)
    for _, craving in ipairs(self.cravings) do
        if craving == targetcraving then
            return true
        end
    end
    return false
end

return Snackrificable
