----------------------------------------------------------------------------------------------------
--2017.03.04
--[Class] StoreWidget Definition (base, _ctor, props)
----------------------------------------------------------------------------------------------------
local Widget = require "widgets/widget"
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Image = require "widgets/image"
local ItemSlot = require "widgets/itemslot"
local ImageButton = require "widgets/imagebutton"
local PopupDialogScreen = require "screens/popupdialog"

local StoreWidget = Class(Widget, function(self, owner, goods)
    Widget._ctor(self, "StoreWidget")
    
    self.owner = owner
    self.goods = goods or {}
    self:SetVAnchor(ANCHOR_MIDDLE)
    self:SetHAnchor(ANCHOR_MIDDLE)
    self:SetScaleMode(SCALEMODE_PROPORTIONAL)
    
    --------------------[Creat Widget Root]--------------------
    self.bgnormal = self:AddChild(Image())
    self.bgnormal:SetTexture("images/hud.xml", "inv_slot.tex")
    self.bgnormal:Show()
    self.bgnormal:SetClickable(false)
    
    self.bgspoilage = self:AddChild(Image())
    self.bgspoilage:SetTexture("images/hud.xml", "inv_slot_spoiled.tex")
    self.bgspoilage:Hide()
    self.bgspoilage:SetClickable(false)
    
    self.spoilage = self:AddChild(UIAnim())
    self.spoilage:GetAnimState():SetBank("spoiled_meter")
    self.spoilage:GetAnimState():SetBuild("spoiled_meter")
    self.spoilage:Hide()
    self.spoilage:SetClickable(false)
    
    self.wetness = self:AddChild(UIAnim())
    self.wetness:GetAnimState():SetBank("wet_meter")
    self.wetness:GetAnimState():SetBuild("wet_meter")
    self.wetness:GetAnimState():PlayAnimation("idle")
    self.wetness:Hide()
    self.wetness:SetClickable(false)
    
    local prefabname = "log"
    if type(goods.goodsprefab) == "string" then prefabname = goods.goodsprefab end
    if type(goods.goodsprefab) == "table" and goods.goodsprefab.Prefab then prefabname = goods.goodsprefab.Prefab end
	
	if prefabname == "pot_syrup" then prefabname = "quagmire_pot_syrup" end
	if prefabname == "pot" then prefabname = "quagmire_pot" end
	if prefabname == "casseroledish" then prefabname = "quagmire_casseroledish" end
	if prefabname == "crate_grill" then prefabname = "quagmire_crate_grill" end

	if prefabname == "crate_pot_hanger" then prefabname = "quagmire_crate_pot_hanger" end
	if prefabname == "crate_oven" then prefabname = "quagmire_crate_oven" end
	if prefabname == "crate_grill_small" then prefabname = "quagmire_crate_grill_small" end

    self.image = self:AddChild(Image("images/inventoryimages.xml", prefabname .. ".tex", "default.tex")) and self:AddChild(Image("images/inventoryimages/hamletinventory.xml", prefabname .. ".tex", "default.tex")) and self:AddChild(Image("images/quagmire_food_common_inv_images.xml", prefabname .. ".tex", "default.tex")) and self:AddChild(Image("images/inventoryimages1.xml", prefabname .. ".tex", "default.tex")) and self:AddChild(Image("images/inventoryimages2.xml", prefabname .. ".tex", "default.tex")) and self:AddChild(Image("images/tfwp_inventoryimgs.xml", prefabname .. ".tex", "default.tex")) and self:AddChild(Image("images/inventoryimages/volcanoinventory.xml", prefabname .. ".tex", "default.tex"))
	
   
    if self.goods.spoil ~= 255 then
        self.bgspoilage:Show()
        self.spoilage:Show()
        self.spoilage:GetAnimState():SetPercent("anim", 1 - self.goods.spoil / 100)
    end
    
    if self.goods.count ~= 255 then
        self.count = self:AddChild(Text(NUMBERFONT, 26))
        self.count:SetPosition(2, 16, 0)
        self.count:SetString(tostring(self.goods.count))
    end
    
    if self.goods.ratio ~= 255 then
        self.ratio = self:AddChild(Text(NUMBERFONT, 26))
        self.ratio:SetPosition(5, -32 + 15, 0)
        self.ratio:SetString(string.format("%2.0f%%", self.goods.ratio))
    end
----botao--------------------------    
    self.button = self:AddChild(ImageButton())
    self.button:SetPosition(116, 0, 0)
    self.button:SetScale(0.5, 0.5, 0.5)
    self.button:SetOnClick(function()self:SendPurchaseCommand() end)
	self.button:SetTextures("images/buttongorge.xml", "buttongorge.tex")
------------preco--------------------------    
    if self.goods.price then
        self.price = self:AddChild(Text(NUMBERFONT, 18))
        self.price:SetPosition(135, -10, 0)
        self.price:SetColour(255 / 255, 255 / 255, 255 / 255, 1)
        self.price:SetString(self.goods.price)
    end
----------------------------------------------desconto-----------    
--[[    if self.goods.disct and self.goods.disct < 100 then
        self.disct = self:AddChild(Text(NUMBERFONT, 16))
        self.disct:SetPosition(-20, 26, 0)
        self.disct:SetColour(0 / 255, 255 / 255, 0 / 255, 1)
        self.disct:SetRotation(-45)
        self.disct:SetString(tostring(100 - self.goods.disct) .. "%OFF!")
        
        self.price:SetColour(0 / 255, 255 / 255, 0 / 255, 1)
        self.price:SetString(math.ceil(self.goods.price * self.goods.disct / 100))
    end]]
----------------------moeda--------------------------------------   
    self.money = self:AddChild(Image())
    self.money:SetPosition(115, -10, 0)
    self.money:SetScale(0.4, 0.4, 0)
    self.money:Show()
    self.money:SetClickable(false)
-------------------------------esgotado------------------------    
    self.soldout = self:AddChild(Image())
    self.soldout:SetTexture("images/store_soldout.xml", "store_soldout.tex")
    self.soldout:SetPosition(0, -16, 0)
    self.soldout:SetScale(0.8, 0.8, 0)
    self.soldout:Hide()
    self.soldout:SetClickable(false)
    
    self.soldouttext = self:AddChild(Text(NUMBERFONT, 32))
    self.soldouttext:SetPosition(0, -22, 0)
    self.soldouttext:SetRotation(-16)
    self.soldouttext:SetString(STRINGS.STORE.UI.SOLDOUT)
    self.soldouttext:Hide()
 -----------comprar texto------------   
    self.stock = self:AddChild(Text(NUMBERFONT, 26))
    self.stock:SetPosition(127, 15, 0)
--    self.stock:SetColour(100 / 255, 100 / 255, 225 / 255, 1)
    self.stock:SetString(STRINGS.NAMES.ESTOQUE)
-------------quantidade em estoque texto------------------	
--	self.stock = self:AddChild(Text(NUMBERFONT, 24))
--    self.stock:SetPosition(100, 25, 0)
--  self.stock:SetColour(100 / 255, 100 / 255, 225 / 255, 1)
--    self.stock:SetString("".. tostring(self.goods.stock) .. "")
    
    if self.goods.stock == 0 then
        self.stock:Hide()
        self.soldout:Show()
        self.soldouttext:Show()
        self.button:Disable()
    end
    self:SetMoney()
end, nil)

function StoreWidget:OnControl(control, down)
    if StoreWidget._base.OnControl(self, control, down) then return true end
    if down and control == CONTROL_SECONDARY then return true end
    return false
end

function StoreWidget:SetGoods(goods)
    self.goods = goods
end

function StoreWidget:SetMoney()
    self.money:SetTexture(self.goods.atlas, self.goods.moneyprefab .. ".tex")
end

function StoreWidget:SendPurchaseCommand()
    SendModRPCToServer(GetModRPC("ServerStore", "Purchased"), self.goods.index, self.goods.locat)
end

function StoreWidget:ShowConfirmWindow(index, info)
    local confirm = PopupDialogScreen("title", info,
        {
            {text = "button1", cb = self:SendPurchaseCommand()},
            {text = "button2", cb = function()TheFrontEnd:PopScreen() end}
        })
    TheFrontEnd:PushScreen(confirm)
end

return StoreWidget
