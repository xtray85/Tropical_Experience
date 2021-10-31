local _G = GLOBAL

local SERVER_SIDE = nil
local DEDICATED_SIDE = nil
local CLIENT_SIDE = nil
local ONLY_CLIENT_SIDE = nil
-- code from star:
-- Also notice that if SERVER_SIDE is nil and CLIENT_SIDE is nil too, that means the mod is force enabled and it's working on main screen. I guess. 
if GLOBAL.TheNet:GetIsServer() then
	SERVER_SIDE = true
	if GLOBAL.TheNet:IsDedicated() then
		--Нельзя использовать GetServerIsDedicated, т.к. это лишь сообщает о сервере, а не о текущей машине.
		--Хотя... Не суть. Все равно же проходим через GetIsServer.
		DEDICATED_SIDE = true
	else
		CLIENT_SIDE = true --А это оригинальное решение вечной проблемы "ismastersim".
		--Следует использовать только для инициализации сетевых переменных, не совмещая с "return" выходом из префаба!!
	end
elseif GLOBAL.TheNet:GetIsClient() then
	SERVER_SIDE = false
	CLIENT_SIDE = true
	ONLY_CLIENT_SIDE = true
end



local client_option = GetModConfigData("FINDER_ACTIVE", true) -- to allow clients to disable highlighting

local isDST = _G.TheSim:GetGameID() == 'DST'

--[ highlighting when active item is changed

local Highlight = _G.require 'components/highlight'
local __Highlight_ApplyColour = Highlight.ApplyColour
local __Highlight_UnHighlight = Highlight.UnHighlight

-- additional highlight of found container objects
local c = {r = 0, g = .25, b = 0}

-- this maintains colour when the game unhighlights our object
local function custom_ApplyColour(self, ...)
  local r, g, b =
  (self.base_add_colour_red   or 0),
  (self.base_add_colour_green or 0),
  (self.base_add_colour_blue  or 0)

  self.base_add_colour_red,
  self.base_add_colour_green,
  self.base_add_colour_blue =
  r + c.r, g + c.g, b + c.b

  local result = __Highlight_ApplyColour(self, ...)

  self.base_add_colour_red,
  self.base_add_colour_green,
  self.base_add_colour_blue = r, g, b

  return result
end

-- prevents removal of the whole component on UnHighlight
local function custom_UnHighlight(self, ...)
  local flashing = self.flashing
  self.flashing = true
  local result = __Highlight_UnHighlight(self, ...)
  self.flashing = flashing

  if isDST and not self.flashing then
    local r, g, b =
    (self.highlight_add_colour_red   or 0),
    (self.highlight_add_colour_green or 0),
    (self.highlight_add_colour_blue  or 0)

    self.highlight_add_colour_red,
    self.highlight_add_colour_green,
    self.highlight_add_colour_blue =
    0, 0, 0

    self:ApplyColour()

    self.highlight_add_colour_red,
    self.highlight_add_colour_green,
    self.highlight_add_colour_blue = r, g, b
  end

  return result
end

local function filter(chest, item)
  return chest.components.container and item and
         chest.components.container:Has(item, 1)
end

-- because of server client communication delay, everything has to be done in a row, in this order:
-- unhighlight at client -> unhighlight at server (set nil) -> server highlight (:set()) -> client highlighted with OnDirtyEventSearchedChest

local function ServerRPCFunction(owner,prefab,source,unhighlighten,highlighten)
    -- print("serverfkt called")
    if unhighlighten then
        local v = nil
        for i=1,50 do
            v = owner["mynetvarSearchedChest"..tostring(i)]:value()
            if v~=nil and not (not v:HasTag("HighlightSourceCraftPot") and source=="CraftPotClose") then
                -- print("server unhighlight "..tostring(v).." hattag: "..tostring(v:HasTag("HighlightSourceCraftPot")).." source: "..tostring(source))
                v:RemoveTag("HighlightSourceCraftPot")
                owner["mynetvarSearchedChest"..tostring(i)]:set(nil) -- remove tag and set nil at serverside
            end
        end
    end
    if highlighten then
        if owner and prefab then -- if no prefab is given, nothing will be highlighted :)
            local x, y, z = owner.Transform:GetWorldPosition()
            local e = TheSim:FindEntities(x, y, z, 20, {"_container"}, {"player", "DECOR", "FX", "NOCLICK" , "INLIMBO", "outofreach"}) or {}
            for k, v in pairs(e) do
                if v and v:IsValid() and v.entity:IsVisible() and filter(v,prefab) then
                    -- print("server highlight "..tostring(v))
                    if source=="CraftPot" then
                        v:AddTag("HighlightSourceCraftPot") -- when craft pot closes, it should unhighlight everything that was previously highlighted by craftpot. That's why we use this Tag and all the source stuff
                    end
                    for i=1,50 do
                        if owner["mynetvarSearchedChest"..tostring(i)]:value()==nil then -- look for empty slot
                           v.highlightsource = source -- add this temporary info
                           owner["mynetvarSearchedChest"..tostring(i)]:set(v)
                           break
                       end
                   end
               end
            end
        end
    end
end

local function ClientUnhighlightChests(owner,prefab,source,unhighlighten,highlighten)
    if CLIENT_SIDE then -- only client pass
        if unhighlighten then
            -- print("client unhighlight start")
            for i=1,50 do -- alle bekannten Chests unhighlighten
                local chest = owner["mynetvarSearchedChest"..tostring(i)]:value()
                if chest and chest.components.highlight then
                  -- print("client unhighlight "..tostring(chest).." hattag: "..tostring(chest:HasTag("HighlightSourceCraftPot")).." source: "..tostring(source))
                  if not (not chest:HasTag("HighlightSourceCraftPot") and source=="CraftPotClose") then

                      if chest.components.highlight.ApplyColour == custom_ApplyColour then
                        chest.components.highlight.ApplyColour = nil
                      end

                      if chest.components.highlight.UnHighlight == custom_UnHighlight then
                        chest.components.highlight.UnHighlight = nil
                      end

                      chest.components.highlight:UnHighlight()
                    end
                end
            end
        end
        if SERVER_SIDE then -- can be both client and server for player 1
            ServerRPCFunction(owner,prefab,source,unhighlighten,highlighten) -- call it directly without rpc, if we are also server
        else
            local rpc = GetModRPC("FinderMod", "CheckContainersItem") 
            SendModRPCToServer(rpc,prefab,source,unhighlighten,highlighten) 
        end
    end
end

local function DoHighlightStuff(owner,prefab,source,unhighlighten,highlighten)
    if CLIENT_SIDE and owner==GLOBAL.ThePlayer then
        ClientUnhighlightChests(owner,prefab,source,unhighlighten,highlighten)
    end
end

local function onactiveitem(owner,data)
    local prefab = data.item and data.item.prefab or nil
    local source = "newactiveitem"
    if owner and prefab then -- unhighlight + highlight
        DoHighlightStuff(owner,prefab,source,true,true)
    else -- only unhighlight
        DoHighlightStuff(owner,prefab,source,true,false)
    end
end 

local function OnDirtyEventSearchedChest(inst,i) -- this is called on client, if the server does inst.mynetvarTitleStufff:set(...)
    -- print("OnDirtyEventSearchedChest i "..tostring(i))
    if CLIENT_SIDE and inst==GLOBAL.ThePlayer then -- only this specific client pass
        if client_option then
            local chest = inst["mynetvarSearchedChest"..tostring(i)]:value()
            if chest then
                -- print("client highlight event number "..tostring(i).." chest: "..tostring(chest))
                if not chest.components.highlight then
                    chest:AddComponent('highlight')
                end

                if chest.components.highlight then
                    chest.components.highlight.ApplyColour = custom_ApplyColour
                    chest.components.highlight.UnHighlight = custom_UnHighlight
                    chest.components.highlight:Highlight(0, 0, 0)
                end
            end
        end
    end
end


local function RegisterListeners(inst)
    for i=1,50 do
        inst:ListenForEvent("DirtyEventSearchedChest"..tostring(i), function(inst) inst:DoTaskInTime(0,OnDirtyEventSearchedChest(inst,i)) end)
    end
end

local function init(inst)
    if not inst then return end
    for i=1,50 do -- allow up to 50 containers (cause we can't use an array of entities, we use 50 entity netvars)
        inst["mynetvarSearchedChest"..tostring(i)] = GLOBAL.net_entity(inst.GUID, "SearchedChest"..tostring(i).."NetStuff", "DirtyEventSearchedChest"..tostring(i))
        inst["mynetvarSearchedChest"..tostring(i)]:set(nil)
    end
    inst:DoTaskInTime(0, RegisterListeners)
    inst:ListenForEvent('newactiveitem', onactiveitem)
end

AddPlayerPostInit(function (owner)
    init(owner)
end)

AddModRPCHandler("FinderMod", "CheckContainersItem", ServerRPCFunction)

-- ######################

--[ highlighting when ingredient in recipepopup is hovered
AddClassPostConstruct("widgets/ingredientui", function(self)
    local __IngredientUI_OnGainFocus = self.OnGainFocus

    function self:OnGainFocus (...)
      local tex   = self.ing and self.ing.texture and self.ing.texture:match('[^/]+$'):gsub('%.tex$', '')
      local owner = self.parent and self.parent.parent and self.parent.parent.owner
      if tex and owner then
        DoHighlightStuff(owner,tex,"Crafting",true,true)
      end
      if __IngredientUI_OnGainFocus then
        return __IngredientUI_OnGainFocus(self, ...)
      end
    end

    local __IngredientUI_OnLoseFocus = self.OnLoseFocus
    function self:OnLoseFocus(...)
        local owner = self.parent and self.parent.parent and self.parent.parent.owner
        DoHighlightStuff(owner,nil,"Crafting",true,false)
        if __IngredientUI_OnLoseFocus then
            return __IngredientUI_OnLoseFocus(self,...)
        end
    end
end)


-- ### Compatible to Craft Pot Mod, to find food with the searched tags
local function testCraftPot()
    local FoodIngredientUI = _G.require 'widgets/foodingredientui'
end
if GLOBAL.pcall(testCraftPot) then
    local cooking = _G.require("cooking")
    local ing = cooking.ingredients    
    
    AddClassPostConstruct("widgets/foodingredientui", function(self)
        local __FoodIngredientUI_OnGainFocus = self.OnGainFocus
        function self:OnGainFocus(...)
            local searchtag = self.prefab -- tag or name
            local isname = self.is_name
            local owner = self.owner
            local prefabs = {} -- find all the prefabs with that cooking tag
            
            if not isname then
                for prefab,xyz in pairs(ing) do
                    for tag,number in pairs(xyz.tags) do
                        if tag==searchtag then
                            table.insert(prefabs,prefab)
                        end
                    end
                end
            elseif isname and GLOBAL.PREFABDEFINITIONS[searchtag] then
                table.insert(prefabs,GLOBAL.PREFABDEFINITIONS[searchtag].name)
            end
            DoHighlightStuff(owner,nil,"CraftPot",true,false) -- to unhighlight everything
            for k,prefab in pairs(prefabs) do -- send one prefab after the other, cause sedning an array via rpc does not work..
                if prefab and owner then
                  DoHighlightStuff(owner,prefab,"CraftPot",false,true) -- highlight every prefab, without unhighlighting in between
                end
            end
            if __FoodIngredientUI_OnGainFocus then
                return __FoodIngredientUI_OnGainFocus(self,...)
            end
        end
        
        -- local __FoodIngredientUI_OnLoseFocus = self.OnLoseFocus -- not needed, we use the FoodCrafting Focus instead
        -- function self:OnLoseFocus(...)
            -- local owner = self.owner
            -- onactiveitem(owner,nil,"CraftPot") -- to unhighlight
            -- if __FoodIngredientUI_OnLoseFocus then
                -- return __FoodIngredientUI_OnLoseFocus(self,...)
            -- end
        -- end
    end)

    AddClassPostConstruct("widgets/foodcrafting", function(self)
        local _OnLoseFocus = self.OnLoseFocus
        self.OnLoseFocus = function(...)
            local owner = self.owner
            DoHighlightStuff(owner,nil,"CraftPot",true,false) -- to unhighlight
            if _OnLoseFocus then
                return _OnLoseFocus(self, ...) 
            end
        end
        
        local _Close = self.Close
        self.Close = function(...)
            local owner = self.owner
            DoHighlightStuff(owner,nil,"CraftPotClose",true,false) -- this unhighlight ony should work for highlights made with craft pot
            if _Close then 
                return _Close(self, ...) 
            end
        end
    end)    
end


AddClassPostConstruct("widgets/tabgroup", function(self)
    local __TabGroup_DeselectAll = self.DeselectAll
    function self:DeselectAll(...)
      DoHighlightStuff(GLOBAL.ThePlayer,nil,"CraftingClose",true,false)
      return __TabGroup_DeselectAll(self, ...)
    end
end)

