local Cleaner = Class(function(self, inst)
    self.inst = inst
    self.type = "positive"

    self.inst:AddTag("mod_disenchanter")
end)

function Cleaner:Clean(mod_item, cleaner)
    if mod_item and mod_item:HasTag("modified") and mod_item.components.modifier then
        local mod_item_rarity = mod_item.components.modifier:GetRarity()
        if mod_item_rarity == "bad" or mod_item_rarity == "worst" then
            mod_item_rarity = math.random() < 0.3 and "rare" or "good"
        end
        mod_item.components.modifier:Remove()
        if self.inst:HasTag("modifier_repairer") then
            local components = { "finiteuses", "perishable", "armor", "fueled"}
            for each, component in pairs(components) do
                if mod_item.components[component] then
                    if mod_item.components.inventoryitem and mod_item.components.inventoryitem.owner then
                        local owner = mod_item.components.inventoryitem:GetGrandOwner()
                        if owner and owner.components.talker and not owner:HasTag("mime") then
                            owner.components.talker:Say("Good as new!")
                        end
                    end
                    mod_item.components[component]:SetPercent(1)
                end
            end
        end
        if self.inst:HasTag("modifier_preserver") and mod_item_rarity then
            local mod_drop = SpawnPrefab("modifierfx")
            mod_drop.Transform:SetPosition(cleaner.Transform:GetWorldPosition())
            mod_drop:OnSpawn(cleaner, mod_item_rarity)
        end
        if not self.inst:HasTag("modified") or not self.inst:HasTag("modifier_infinite") then
            self.inst:Remove()
        end
        return true
    end
end

return Cleaner