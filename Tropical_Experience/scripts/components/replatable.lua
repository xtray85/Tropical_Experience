local PLATES =
{
    ["plate"] =
    {
        "generic",
        "silver",
        "gold",
    },
    ["bowl"] =
    {
        "generic",
        "silver",
        "gold",
    },
}

local Replatable = Class(function(self, inst)
    self.inst = inst
    self.platetype = nil
    self.material = nil
    self.maxsanitygain = 5
end)

function Replatable:GetSanityModifier(eater, basesanity)
    if self.material == nil or self.material == "generic" then
        return 0
    end
    return self.maxsanitygain
end

function Replatable:HidePlateSymbols()
    for platetype, _ in pairs(PLATES) do
        self.inst.AnimState:OverrideSymbol("generic_" .. platetype, "preparedfood_gorge", "nothing")
    end
end

function Replatable:SetMaterial(material, food)
    food = food or self.inst.prefab
    self.material = material
    local inventoryitem = self.inst.components.inventoryitem
    local img = food .. "_" .. self.platetype .. "_" .. material
    inventoryitem.imagename = img
    inventoryitem.atlasname = "images/inventoryimages/quagmirefoods.xml"
    local plate = material .. "_"  .. self.platetype
    self:HidePlateSymbols()
    self.inst.AnimState:OverrideSymbol("generic_" .. self.platetype, "preparedfood_gorge", plate)
end


function Replatable:Replate(replater)
    local material = replater.components.replater.material
    local platetype = replater.components.replater.platetype
    if material ~= nil and platetype == self.platetype then
        self:SetMaterial(material)
    end
end

function Replatable:SetUp(name, platetype, material)
    self.platetype = platetype
    self.material = material or "generic"
    self:SetMaterial(self.material, name)
end

function Replatable:CanReplate(replater)
    local platetype = replater.components.replater.platetype
    return platetype and self.platetype == platetype
end

function Replatable:SetPlate(plate)
    self.plate = plate
end

function Replatable:OnLoad(data)
    if data and data.material and data.food then
        self:SetMaterial(data.material, data.food)
    end
end

function Replatable:OnSave()
    return
    {
        material = self.material,
        food = self.inst.prefab,
    }
end

return Replatable
