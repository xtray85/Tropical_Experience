----------------------------------------------------------------------------------------------------
--2017.03.04
--[Class] Store Definition (base, _ctor, props)
----------------------------------------------------------------------------------------------------
local function StoreConstructor(self, inst)
    self.inst = inst
end

local Store = Class(nil, StoreConstructor, nil)
----------------------------------------------------------------------------------------------------
--[Member Functions]
----------------------------------------------------------------------------------------------------
function Store:CanOpen(doer)
    return self.CanOpenFn == nil or self.CanOpenFn(self.inst, doer)
end

function Store:OpenStore(doer)
    if self.OpenFn then self.OpenFn(self.inst, doer) end
end

return Store
