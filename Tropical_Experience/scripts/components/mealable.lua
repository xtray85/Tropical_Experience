local Mealable = Class(function(self, inst)
    self.inst = inst

    self.mealtype = nil
    self.mealtime = nil

    --V2C: Recommended to explicitly add tag to prefab pristine state
    inst:AddTag("mealable")
end)

function Mealable:OnRemoveFromEntity()
    self.inst:RemoveTag("mealable")
end

function Mealable:SetType(mealtype)
    self.mealtype = mealtype
end

function Mealable:GetType()
    return self.mealtype
end

function Mealable:SetMealTime(time)
    self.mealtime = time
end

function Mealable:GetMealTime()
    return self.mealtime
end

return Mealable