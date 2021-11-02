local Modifier = Class(function(self, inst)
    self.inst = inst
    self.mod_name = net_string(inst.GUID, "mod.name", "modifier_name_client")
    self.mod_rarity = net_string(inst.GUID, "mod.rarity", "modifier_rarity_client")

    self.inst:ListenForEvent("modifier_name_client", function(inst)
        local actualname = self:GetModifier()
        if not self.ranonce then
            self.inst.oldDisplayFn = self.inst.displaynamefn
            self.ranonce = true
        end
        self.inst.displaynamefn = function(inst)
            if actualname == nil then
                return self.inst.oldDisplayFn and self.inst.oldDisplayFn() or STRINGS.NAMES[string.upper(self.inst.prefab)]
            else
                return (STRINGS.MODIFIERS[string.upper(actualname)] and STRINGS.MODIFIERS[string.upper(actualname)].PREFIX or STRINGS.MODIFIERS.GENERIC.PREFIX) .. " " .. (self.inst.oldDisplayFn and self.inst:oldDisplayFn() or STRINGS.NAMES[string.upper(self.inst.prefab)])
            end
        end
    end)
end)

function Modifier:GetModifier()
    if self.inst.components and self.inst.components.modifier ~= nil then
        return self.inst.components.modifier:GetModifier()
    else
        return self.mod_name:value() ~= "" and self.mod_name:value() or nil
    end
end

function Modifier:GetRarity()
    if self.inst.components and self.inst.components.modifier ~= nil then
        return self.inst.components.modifier:GetRarity()
    else
        return self.mod_rarity:value() ~= "" and self.mod_rarity:value() or nil
    end
end

function Modifier:IsModified()
    if self.inst.components and self.inst.components.modifier ~= nil then
        return self.inst.components.modifier:IsModified()
    else
        return self.mod_name:value() ~= "" or self.inst:HasTag("modifier")
    end
end

return Modifier
