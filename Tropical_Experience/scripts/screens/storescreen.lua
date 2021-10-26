----------------------------------------------------------------------------------------------------
--2017.03.04
--[Class] StoreScreen Definition (base, _ctor, props)
----------------------------------------------------------------------------------------------------
local PopupDialogScreen = require "screens/popupdialog"
local ImageButton = require "widgets/imagebutton"
local StoreWidget = require "widgets/storewidget"
local AnimButton = require "widgets/animbutton"
local Screen = require "widgets/screen"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Text = require "widgets/text"
local Templates = require "widgets/templates"

local StoreScreen = Class(Screen, function(self, owner, build, goodsinfo)
    Screen._ctor(self, "StoreScreen")
    TheInput:ClearCachedController()
    self.owner = owner
    self.build = build
    self.active = true
    self.page = 1
    self.maxpage = 1
    self.perpage = 6
    self.perline = 1
    self.goodsinfo = goodsinfo
    self.scrnw, self.scrnh = TheSim:GetScreenSize()
    
    self.black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    self.black.image:SetVRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetHRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetVAnchor(ANCHOR_MIDDLE)
    self.black.image:SetHAnchor(ANCHOR_MIDDLE)
    self.black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black.image:SetTint(0, 0, 0, 0)-- invisible, but clickable!
    self.black:SetOnClick(function()self:Close() end)
    
    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetVAnchor(ANCHOR_MIDDLE)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetPosition(0, 0, 0)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)
-- ajusta a imagem de fundo    
    self.background = self.root:AddChild(Image("images/store.xml", "store.tex"))
    self.background:SetVAnchor(ANCHOR_MIDDLE)
    self.background:SetHAnchor(ANCHOR_MIDDLE)
    self.background:SetPosition(0, 20, 0)
    self.background:SetScaleMode(SCALEMODE_PROPORTIONAL)
	self.background:Hide()
    
    self.slots = self.root:AddChild(Widget("SLOTS"))
    self.slots:SetPosition(0, 0, 0)
    self.slots:SetVAnchor(ANCHOR_MIDDLE)
    self.slots:SetHAnchor(ANCHOR_MIDDLE)
    self.slots:SetScaleMode(SCALEMODE_PROPORTIONAL)
    
    self.pages = self.background:AddChild(Text(BUTTONFONT, 40))
    self.pages:SetPosition(0, -186, 0)
    self.pages:SetColour(255 / 255, 255 / 255, 255 / 255, 1)
    self.pages:SetString(tostring(self.page))
    self.pages:SetColour(0, 0, 0, 1)
    
    self.button_lastpage = self.background:AddChild(Templates.AnimTextButton("button",
        {idle = "idle_green", over = "up_green", disabled = "down_green"},
        1, function()self:PageLast() end,
        STRINGS.STORE.UI.LASTPAGE, 40))
    self.button_lastpage:SetPosition(-116, -186)
    self.button_lastpage:SetScale(0.7)
	self.button_lastpage:Hide()
    
    self.button_nextpage = self.background:AddChild(Templates.AnimTextButton("button",
        {idle = "idle_red", over = "up_red", disabled = "down_red"},
        1, function()self:PageNext() end,
        STRINGS.STORE.UI.NEXTPAGE, 40))
    self.button_nextpage:SetPosition(116, -186)
    self.button_nextpage:SetScale(0.7)
	self.button_nextpage:Hide()
    
    if self.build and #(self.goodsinfo) ~= 0 then self:CreatGoods() end
    
    self:StartUpdating()
    self:OnUpdate()
end, nil)

----------------------------------------------------------------------------------------------------
--[Member Functions]
----------------------------------------------------------------------------------------------------
function StoreScreen:Close()
    SendModRPCToServer(GetModRPC("ServerStore", "ShutStore"), self.build)
    
    TheInput:CacheController()
    self.active = false
    TheFrontEnd:PopScreen(self)
end

function StoreScreen:CreatGoods(goodsinfo)
    if goodsinfo then self.goodsinfo = goodsinfo end
    if #self.goodsinfo == 0 then return false end
    
    self.slots:KillAllChildren()
    self.maxpage = math.ceil(#self.goodsinfo / self.perpage)
    local startpoint = 1 + self.perpage * (self.page - 1)
    for var = startpoint, startpoint + self.perpage - 1, 1 do
        self.goodsinfo[var].start = ((var - 1) % self.perpage) + 1
        self.slots:AddChild(StoreWidget(self.owner, self.goodsinfo[var]))
    end
    --self:DebugLog()
    self:SetWidgetsPosition()
end

function StoreScreen:SetWidgetsPosition(perpage, perline, xspace, yspace)
    local perpage = perpage or self.perpage
    local perline = perline or self.perline
    local spacex = 0.118 * self.scrnw
    local spacey = 0.100 * self.scrnh	
--    local spacex = xspace or 0.118 * self.scrnw
--    local spacey = yspace or 0.100 * self.scrnh
    local lines = perpage / perline
    
    for k, widget in pairs(self.slots:GetChildren()) do
        local row = math.floor((widget.goods.start - 1) / perline) + 1
        local col = math.floor((widget.goods.start - 1) % perline) + 1
        local pos = Vector3(spacex * (col - perline / 2 - 0.5), 0.125 * self.scrnh + spacey * (lines / 2 + 0.5 - row)-140, 0)
        widget:SetPosition(pos)
    end
end

function StoreScreen:OnControl(control, down)
    if StoreScreen._base.OnControl(self, control, down) then
        return true
    elseif not down and (control == CONTROL_PAUSE or control == CONTROL_CANCEL) then
        self:Close()
        TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        return true
    end
end

function StoreScreen:PageLast()
    if self.page == 1 then return false end
    
    if self.page > 1 then self.page = self.page - 1 end
    self:CreatGoods()
    self.pages:SetString(tostring(self.page))
end

function StoreScreen:PageNext()
    if self.page == self.maxpage then return false end
    
    if self.page < self.maxpage then self.page = self.page + 1 end
    self:CreatGoods()
    self.pages:SetString(tostring(self.page))
end

function StoreScreen:OnUpdate()
    local scrnw, scrnh = TheSim:GetScreenSize()
    if self.scrnw ~= scrnw or self.scrnh ~= scrnh then
        self.scrnw = scrnw
        self.scrnh = scrnh
        self:SetWidgetsPosition()
    end
    
    if self.page == 1 then self.button_lastpage:Disable()
    else self.button_lastpage:Enable() end
    
    if self.page == self.maxpage then self.button_nextpage:Disable()
    else self.button_nextpage:Enable() end
end

function StoreScreen:DebugLog()
    for k, v in pairs(self.goodsinfo) do
        print("id = " .. tostring(k) ..
            " index = " .. tostring(v.index) ..
            " count = " .. tostring(v.count) ..
            " ratio = " .. tostring(v.ratio) ..
            " stock = " .. tostring(v.stock) ..
            " price = " .. tostring(v.price) ..
            " disct = " .. tostring(v.disct))
    end
end

function StoreScreen:OnBecomeActive()
    StoreScreen._base.OnBecomeActive(self)
    TheFrontEnd:HideTopFade()
end

return StoreScreen
