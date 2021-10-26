local SpecialStewerDish = Class(function(self, inst)
    self.inst = inst
    self.dishtype = nil
end)

function SpecialStewerDish:SetDishType(dishtype)
    self.dishtype = dishtype
end

function SpecialStewerDish:IsDishType(dishtype)
    return self.dishtype == dishtype
end

return SpecialStewerDish
