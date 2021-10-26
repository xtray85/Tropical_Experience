local function onatlasname(self, atlasname)   ----adicionei shelf em varios lugares------------mudei na linha 434 e adicionei a linha 59-----------------
    self.inst.replica.inventoryitem:SetAtlas(atlasname)
end

local function onimagename(self, imagename)
    self.inst.replica.inventoryitem:SetImage(imagename)
end

local function onowner(self, owner)
	if self.inst.replica.inventoryitem then self.inst.replica.inventoryitem:SetOwner(owner)	end
end

local function oncanbepickedup(self, canbepickedup)
    self.inst.replica.inventoryitem:SetCanBePickedUp(canbepickedup)
end

local function oncangoincontainer(self, cangoincontainer)
    self.inst.replica.inventoryitem:SetCanGoInContainer(cangoincontainer)
end

local function oncanonlygoinpocket(self, canonlygoinpocket)
    self.inst.replica.inventoryitem:SetCanOnlyGoInPocket(canonlygoinpocket)
end

local function OnStackSizeChange(inst, data)
    local self = inst.components.inventoryitem
    if self.owner ~= nil then
        self.owner:PushEvent("stacksizechange", { item = inst, src_pos = data.src_pos, stacksize = data.stacksize, oldstacksize = data.oldstacksize })
    end
end

local function OnEnterLimbo(inst, data)
    local self = inst.components.inventoryitem
    self:SetLanded(false, false)
end

local function OnExitLimbo(inst, data)
    local self = inst.components.inventoryitem
    self:SetLanded(false, true)    
end

local InventoryItem = Class(function(self, inst)
    self.inst = inst

    self.owner = nil
    self.canbepickedup = true
    self.canbepickedupalive = false --added for minion pickup behaviour, e.g. eyeplants
    self.onpickupfn = nil
    self.isnew = true
    self.nobounce = false
    self.cangoincontainer = true
    self.canonlygoinpocket = false
    self.keepondeath = false
    self.atlasname = nil
    self.imagename = nil
    self.onactiveitemfn = nil
    self.trappable = true
    self.sinks = false
    self.droprandomdir = false	
	self.inst:AddTag("isinventoryitem")
    self.pushlandedevents = true	
    self:SetLanded(false, true)

    self.inst:ListenForEvent("stacksizechange", OnStackSizeChange)
    self.inst:ListenForEvent("enterlimbo", OnEnterLimbo)
    self.inst:ListenForEvent("exitlimbo", OnExitLimbo)

    if self.inst.components.waterproofer == nil then
        self:EnableMoisture(true)
    end
	
    self.inst:ListenForEvent("onremove", function() 
        if self.inst.onshelf then
            local shelf = self.inst.onshelf               
            local item = shelf.components.shelfer:GetGift()
            -- doing this check to save players from a bug that was fixed, but some items may still suffer from it
            if item and item.GUID == self.inst.GUID then
                shelf.components.shelfer:GiveGift()
            end
        end
    end)	

end,
nil,
{
    atlasname = onatlasname,
    imagename = onimagename,
    owner = onowner,
    canbepickedup = oncanbepickedup,
    cangoincontainer = oncangoincontainer,
    canonlygoinpocket = oncanonlygoinpocket,
})

function InventoryItem:OnRemoveFromEntity()
    self:EnableMoisture(false)
    self.inst:RemoveEventCallback("stacksizechange", OnStackSizeChange)
end

--Provided specifically for waterproofer component
function InventoryItem:EnableMoisture(enable)
    if enable == false then
        if self.inst.components.inventoryitemmoisture ~= nil then
            self.inst:RemoveComponent("inventoryitemmoisture")
        end
    elseif self.inst.components.inventoryitemmoisture == nil then
        self.inst:AddComponent("inventoryitemmoisture")
        self.inst.components.inventoryitemmoisture:AttachReplica(self.inst.replica.inventoryitem)
    end
end

function InventoryItem:GetMoisture()
    return self.inst.components.inventoryitemmoisture ~= nil and self.inst.components.inventoryitemmoisture.moisture or 0
end

function InventoryItem:IsWet()
    return self.inst.components.inventoryitemmoisture ~= nil and self.inst.components.inventoryitemmoisture.iswet
end

function InventoryItem:InheritMoisture(moisture, iswet)
    if self.inst.components.inventoryitemmoisture ~= nil then
        self.inst.components.inventoryitemmoisture:InheritMoisture(moisture, iswet)
    end
end

function InventoryItem:DiluteMoisture(item, count)
    if self.inst.components.inventoryitemmoisture ~= nil then
        self.inst.components.inventoryitemmoisture:DiluteMoisture(item, count)
    end
end

function InventoryItem:AddMoisture(delta)
    if self.inst.components.inventoryitemmoisture ~= nil then
        self.inst.components.inventoryitemmoisture:DoDelta(delta)
    end
end

function InventoryItem:SetOwner(owner)
    self.owner = owner
end

function InventoryItem:ClearOwner(owner)
    self.owner = nil
end

function InventoryItem:SetOnDroppedFn(fn)
    self.ondropfn = fn
end

function InventoryItem:SetOnActiveItemFn(fn)
    self.onactiveitemfn = fn 
end

function InventoryItem:SetOnPickupFn(fn)
    self.onpickupfn = fn
end

function InventoryItem:SetOnPutInInventoryFn(fn)
    self.onputininventoryfn = fn
end

function InventoryItem:SetSinks(should_sink)
    self.sinks = should_sink

    -- If we've already landed, check to see if the new value should make us sink.
    if self.is_landed then
        self:TryToSink()
    end
end

function InventoryItem:GetSlotNum()
    if self.owner ~= nil then
        local ct = self.owner.components.container or self.owner.components.inventory
        return ct ~= nil and ct:GetItemSlot(self.inst) or nil
    end
end

function InventoryItem:GetContainer()
    if self.owner then
        return self.owner.components.container or self.owner.components.inventory
    end
end

function InventoryItem:HibernateLivingItem()
    if self.inst.components.brain then
        BrainManager:Hibernate(self.inst)
    end

    if self.inst.SoundEmitter then
        self.inst.SoundEmitter:KillAllSounds()
    end
end

function InventoryItem:WakeLivingItem()
    if self.inst.components.brain then
        BrainManager:Wake(self.inst)
    end
end

function InventoryItem:OnPutInInventory(owner)
--    print(string.format("InventoryItem:OnPutInInventory[%s]", self.inst.prefab))
--    print("   transform=", Point(self.inst.Transform:GetWorldPosition()))
    self:SetOwner(owner)
    owner:AddChild(self.inst)
    self.inst:RemoveFromScene()
    self.inst.Transform:SetPosition(0,0,0) -- transform is now local?
--    print("   updated transform=", Point(self.inst.Transform:GetWorldPosition()))
    self:HibernateLivingItem()
    if self.onputininventoryfn then
        self.onputininventoryfn(self.inst, owner)
    end
    self.inst:PushEvent("onputininventory", owner)

	if self.inst.components.container ~= nil then
		for _, item in pairs(self.inst.components.container.slots) do
			item:PushEvent("onownerputininventory", owner)
		end
	end
end

function InventoryItem:OnRemoved()
    if self.owner then
        self.owner:RemoveChild(self.inst)
    end
    self:ClearOwner()
    self.inst:ReturnToScene()
    self:WakeLivingItem()
end

function InventoryItem:OnDropped(randomdir, speedmult)
    if not self.inst:IsValid() then
        return
    end

    local x, y, z = (self.owner or self.inst).Transform:GetWorldPosition()

    self:OnRemoved()
    self:DoDropPhysics(x, y, z, randomdir, speedmult)

    if self.ondropfn ~= nil then
        self.ondropfn(self.inst)
    end
    self.inst:PushEvent("ondropped")

	if self.inst.components.container ~= nil then
		for _, item in pairs(self.inst.components.container.slots) do
			item:PushEvent("onownerdropped")
		end
	end

    if self.inst.components.propagator ~= nil then
        self.inst.components.propagator:Delay(5)
    end
end

function InventoryItem:DoDropPhysics(x, y, z, randomdir, speedmult)
    
    self:SetLanded(false, true)

    if self.inst.Physics ~= nil then
        local heavy = self.inst:HasTag("heavy")
        if not self.nobounce then
            y = y + (heavy and .5 or 1)
        end
        self.inst.Physics:Teleport(x, y, z)

        -- convert x, y, z to velocity
        if randomdir then
            local speed = ((heavy and 1 or 2) + math.random()) * (speedmult or 1)
            local angle = math.random() * 2 * PI
            x = speed * math.cos(angle)
            y = self.nobounce and 0 or speed * 3
            z = -speed * math.sin(angle)
        else
            x = 0
            y = (self.nobounce and 0) or (heavy and 2.5) or 5
            z = 0
        end
        self.inst.Physics:SetVel(x, y, z)
    else
        self.inst.Transform:SetPosition(x, y, z)
    end
end

-- If this function retrns true then it has destroyed itself and you shouldnt give it to the player
function InventoryItem:OnPickup(pickupguy, src_pos)
-- not only the player can have inventory!   

    self:SetLanded(false, false)    

    if self.isnew and self.inst.prefab and pickupguy:HasTag("player") then
        ProfileStatsAdd("collect_"..self.inst.prefab)
        self.isnew = false
    end

    if self.inst.components.burnable and self.inst.components.burnable:IsSmoldering() then
        self.inst.components.burnable:StopSmoldering()
        if pickupguy.components.health ~= nil then
            pickupguy.components.health:DoFireDamage(TUNING.SMOTHER_DAMAGE, nil, true)
            pickupguy:PushEvent("burnt")
        end
    end

    if self.inst.bookshelf then
        self:TakeOffShelf()
    end		
	
    self.inst:PushEvent("onpickup", { owner = pickupguy })
    return self.onpickupfn and self.onpickupfn(self.inst, pickupguy, src_pos)
end

function InventoryItem:IsHeld()
    return self.owner ~= nil
end

function InventoryItem:IsHeldBy(guy)
    return self.owner == guy
end

function InventoryItem:ChangeImageName(newname)
    self.imagename = newname
    self.inst:PushEvent("imagechange")
end

function InventoryItem:RemoveFromOwner(wholestack)
    if self.owner == nil then
        return
    elseif self.owner.components.inventory ~= nil then
        return self.owner.components.inventory:RemoveItem(self.inst, wholestack)
    elseif self.owner.components.container ~= nil then
        return self.owner.components.container:RemoveItem(self.inst, wholestack)
    end
end

function InventoryItem:OnRemoveEntity()
    self:RemoveFromOwner(true)
    TheWorld:PushEvent("forgetinventoryitem", self.inst)
end

function InventoryItem:GetGrandOwner()
    if self.owner then
        if self.owner.components.inventoryitem then
            return self.owner.components.inventoryitem:GetGrandOwner()
        else
            return self.owner
        end
    end
end

function InventoryItem:TakeOffShelf()

    local shelf_slot = SpawnPrefab("shelf_slot")
    shelf_slot.components.inventoryitem:PutOnShelf(self.inst.bookshelf, self.inst.bookshelfslot)
    shelf_slot.components.shelfer:SetShelf( self.inst.bookshelf, self.inst.bookshelfslot )

    self.inst:RemoveTag("bookshelfed")
    self.inst.bookshelfslot = nil
    self.inst.bookshelf = nil 
    self.inst.follower:FollowSymbol( 0,"dumb",0,0,0)       
    if self.inst.Physics then
        self.inst.Physics:SetActive(true)
    end
end

function InventoryItem:PutOnShelf(shelf, slot)
   self.inst:AddTag("bookshelfed")
   self.inst.bookshelfslot = slot
   self.inst.bookshelf = shelf 
   if self.inst.Physics then
       self.inst.Physics:SetActive(false)
   end
   local follower = self.inst.entity:AddFollower()          
   follower:FollowSymbol( shelf.GUID, slot, 10, 0, 0.6 )    
   self.inst.follower = follower
end

function InventoryItem:OnSave()
    local data = {}
    local refs = {}

    if self.inst:HasTag("bookshelfed") and self.inst.bookshelf then
        data.bookshelfGUID = self.inst.bookshelf.GUID
        data.bookshelfslot = self.inst.bookshelfslot
        table.insert(refs,self.inst.bookshelf.GUID)
    end

    if self.canbepickedup then
        data.canbepickedup = self.canbepickedup
    end

    if self.inst.onshelf then
        data.onshelf = self.inst.onshelf.GUID     
        table.insert(refs, self.inst.onshelf.GUID)   
    end

    return data,refs
end

function InventoryItem:OnLoad(data)
    if data.canbepickedup then
        self.canbepickedup = data.canbepickedup
    end    
end

function InventoryItem:LoadPostPass(newents, data)
    if data and data.bookshelfGUID then
        if newents[data.bookshelfGUID] then
            local bookshelf =  newents[data.bookshelfGUID].entity
            self:PutOnShelf(bookshelf,data.bookshelfslot)
        end
    end
    if data and data.onshelf then
        if newents[data.onshelf] and newents[data.onshelf].entity:IsValid() then
            self.inst.onshelf = newents[data.onshelf].entity
			-- fixup for items that misremembered they were on a shelf. 
				self.inst:DoTaskInTime(1, function()
					if self.inst.onshelf then
						local shelfitem = self.inst.onshelf and self.inst.onshelf.components and self.inst.onshelf.components.shelfer and self.inst.onshelf.components.shelfer:GetGift()
						if self.inst ~= shelfitem then
							-- we thought we were on a shelf. Alas, we were not
							self.inst.onshelf = nil
						end
					end
				end)
        end
    end
end

function InventoryItem:IsSheltered()
    return self:IsHeld() and 
    ((self.owner.components.container) or (self.owner.components.inventory and self.owner.components.inventory:IsWaterproof()))
end

function InventoryItem:SetLanded(is_landed, should_poll_for_landing)
    if not is_landed then
        if should_poll_for_landing then
            self.inst:StartUpdatingComponent(self)
        else
            self.inst:StopUpdatingComponent(self)
        end

        -- If we're going from landed to not landed
        if self.pushlandedevents and self.is_landed then
            self.inst:PushEvent("on_no_longer_landed")
        end
    else
        self.inst:StopUpdatingComponent(self)

        -- If we're going from not landed to landed
        if self.pushlandedevents and not self.is_landed then
            self.inst:PushEvent("on_landed")
            self:TryToSink()
        end
    end

    self.is_landed = is_landed
end

function InventoryItem:ShouldSink()
    if not self:IsHeld() and not self.inst:IsInLimbo() then
        local px, _, pz = self.inst.Transform:GetWorldPosition()
        return not TheWorld.Map:IsPassableAtPoint(px, 0, pz, not self.sinks)
    end
end

function InventoryItem:TryToSink()
    if ShouldEntitySink(self.inst, self.sinks) then
        self.inst:DoTaskInTime(0, SinkEntity)
    end
end

function InventoryItem:OnUpdate(dt)    
    local x,y,z = self.inst.Transform:GetWorldPosition()

    if x and y and z then 
        local vely = 0 
        if self.inst.Physics then 
            local vx, vy, vz = self.inst.Physics:GetVelocity()
            vely = vy or 0

            if (not vx) or (not vy) or (not vz) then
                self:SetLanded(true, false)
            elseif (vx == 0) and (vy == 0) and (vz == 0) then
                self:SetLanded(true, false)
            end
        end

        if y + vely * dt * 1.5 < 0.01 and vely <= 0 then
            self:SetLanded(true, false)
        end        
    else     
        self:SetLanded(true, false)
    end 
end 

return InventoryItem
