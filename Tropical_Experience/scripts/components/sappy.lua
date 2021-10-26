local BUCKET_LEVELS =
{
    "empty",
    "full",
    "overflow",
}

local Sappy = Class(function(self, inst)
    self.inst = inst
	
	self.task = nil
	
    self.stage = 0
	
	self.sap = nil
	self.sap_number = 1
	self.has_sap = nil
	self.has_bucket = nil
	
	self.saptime = 0
	self.rottentime = 0 
    self.growthtime = 0
	
	self.cycles_left = 5
	
	self.waterlevel = 480
	
    self.has_water = nil
	self.isgrowing = true
	
	self.contestmode = nil
	
	self.inst:AddTag("tappable")
end)

local function SplashOceanLoot(loot, cb)
    if loot.components.inventoryitem == nil or not loot.components.inventoryitem:IsHeld() then
        local x, y, z = loot.Transform:GetWorldPosition()
        if not loot:IsOnValidGround() or TheWorld.Map:IsPointNearHole(Vector3(x, 0, z)) then
            SpawnPrefab("splash_ocean").Transform:SetPosition(x, y, z)
            if loot:HasTag("irreplaceable") then
                loot.Transform:SetPosition(FindSafeSpawnLocation(x, y, z))
            else
                loot:Remove()
            end
            return
        end
    end
    if cb ~= nil then
        cb(loot)
    end
end

function Sappy:FlingItem(loot, pt, bouncedcb)
    if loot ~= nil then
        if pt == nil then
            pt = self.inst:GetPosition()
        end

        loot.Transform:SetPosition(pt:Get())

        if loot.Physics ~= nil then
            local angle = self.flingtargetpos ~= nil and GetRandomWithVariance(self.inst:GetAngleToPoint(self.flingtargetpos), self.flingtargetvariance or 0) * DEGREES or math.random() * 2 * PI
            local speed = math.random() * 2
            if loot:IsAsleep() then
                local radius = .5 * speed + (self.inst.Physics ~= nil and loot:GetPhysicsRadius(1) + self.inst:GetPhysicsRadius(1) or 0)
                loot.Transform:SetPosition(
                    pt.x + math.cos(angle) * radius,
                    0,
                    pt.z - math.sin(angle) * radius
                )

                SplashOceanLoot(loot, bouncedcb)
            else
                local sinangle = math.sin(angle)
                local cosangle = math.cos(angle)
                loot.Physics:SetVel(speed * cosangle, GetRandomWithVariance(8, 4), speed * -sinangle)

                if self.inst ~= nil and self.inst.Physics ~= nil then
                    local radius = loot:GetPhysicsRadius(1) + self.inst:GetPhysicsRadius(1)
                    loot.Transform:SetPosition(
                        pt.x + cosangle * radius,
                        pt.y,
                        pt.z - sinangle * radius
                    )
                end

                loot:DoTaskInTime(1, SplashOceanLoot, bouncedcb)
            end
        end
    end
end

function Sappy:OnRemoveFromEntity()
    self.inst:RemoveTag("tappable")
	self.inst:RemoveTag("tapped")
	self.inst:RemoveTag("sappy")
end

local function DoGrow(inst, self, dt)
    self:OnUpdate(dt)
end

function Sappy:Water(bucket)
    if not (TheWorld.state.iswinter and TheWorld.state.temperature <= 0) then
        if bucket.components.magicbucket ~= nil then
			local x, y, z = self.inst.Transform:GetWorldPosition()
			
			SpawnPrefab("ice_splash").Transform:SetPosition(x, y, z)
			self.inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_baitsplash")
        end
		
		if self.inst:HasTag("withered") then
			self.inst:RemoveTag("withered")
		end
		
		self:OnUpdate(0)
		
        if bucket.components.finiteuses ~= nil then
            bucket.components.finiteuses:Use()
        end
		
        return true
    end
end

function Sappy:MakeSappy(level, rotten)
	if level >=3 then
		self.inst.AnimState:Show("sap")
	end
	
	if self.has_sap == nil then
		self.inst.AnimState:PlayAnimation("sap_leak_pre")
		self.inst.AnimState:PushAnimation("sap_leak_pst")
		self.inst.AnimState:PushAnimation("sway1_loop", true)
	end
	
	if rotten then
		self.inst.AnimState:OverrideSymbol("swap_sapbucket", "quagmire_sapbucket", "swap_sapbucket_"..BUCKET_LEVELS[level].."_spoiled")
		self.sap = "sap_spoiled"	
		
		if self.inst.flies == nil then
			self.inst.flies = self.inst:SpawnChild("flies")
		end
	else
		self.inst.AnimState:OverrideSymbol("swap_sapbucket", "quagmire_sapbucket", "swap_sapbucket_"..BUCKET_LEVELS[level])
		self.sap = "sap"	
	end
	
	self.has_sap = true
	
	self.inst:AddTag("sappy")
end

function Sappy:Wither(reason)
	local x, y, z = self.inst.Transform:GetWorldPosition()
	
	self.inst.AnimState:PlayAnimation("drop_leaves_pre")
	self.inst.AnimState:PushAnimation("drop_leaves_pst")
	
	if self.has_bucket then
		self.has_bucket = nil

		local x, y, z = self.inst.Transform:GetWorldPosition()
		local loot = SpawnPrefab("quagmire_sapbucket").Transform:SetPosition(x, y, z)
		local pt = self.inst:GetPosition()
		self:FlingItem(loot, pt)
		
		if self.inst.flies then
			self.inst.flies:Remove()
			self.inst.flies = nil
		end
	end
	
	if self.inst:HasTag("withered") then
		SpawnPrefab("sugarwood_leaf_withered_fx").Transform:SetPosition(x, 1, z)
	else
		SpawnPrefab("sugarwood_leaf_fx").Transform:SetPosition(x, 1, z)
	end
	
	self.isgrowing = nil
	
	self.inst.AnimState:PushAnimation("sway1_loop", true)
	
	self.inst.SoundEmitter:PlaySound("dontstarve/forest/treeWilt")
end

function Sappy:RemoveTapper()
	if self.has_bucket then
		self.has_bucket = nil

		local loot = SpawnPrefab("quagmire_sapbucket")
		local pt = self.inst:GetPosition()
		self:FlingItem(loot, pt)
		
		if self.saptime >= 120 and self.sap then
		local product = SpawnPrefab(self.sap)
		self:FlingItem(product, pt)
		end		
		

		if self.inst.flies then
			self.inst.flies:Remove()
			self.inst.flies = nil
		end
		
		self.inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/craft/sap_extractor")
		self.inst.AnimState:Hide("swap_tapper")
		self.inst.AnimState:Hide("sap")
		
		self.inst:RemoveTag("tapped")
		self.inst:RemoveTag("sappy")

		self.saptime = 0
		self.rottentime = 0
		self.has_bucket = nil
		self.has_sap = nil
		self.sap = nil
		self:MakeSappy(1)
	end
end

------------------------------------------------------------------------------------------------------
-- Growing and Withering

function Sappy:OnUpdate(dt)
--	if self.contestmode then
		if self.has_bucket then
			self.saptime = self.saptime + dt
			
			if self.saptime >= 120 then
				self:MakeSappy(3)
				
				self.rottentime = self.rottentime + dt
				
				if self.rottentime >= 90 then
					self:MakeSappy(3, true)
				end
			end
--		end
--	else
--		local pt = self.inst:GetPosition()
--		local tiletype = TheWorld.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
--		
--		if tiletype ~= GROUND.QUAGMIRE_PARKFIELD or self.cycles_left <= 0 then
--			self:Wither("dead")
--		elseif TheWorld.state.iswinter then
--			self:Wither("winter")
--		elseif TheWorld.state.temperature <= 0 or TheWorld.state.temperature >= 50 then
--			self:Wither("temp")
--		end
	end
	
	if self.task == nil then
		self.task = self.inst:DoPeriodicTask(1, DoGrow, nil, self, 1)
	end
end

------------------------------------------------------------------------------------------------------
-- Tapper Setup

function Sappy:Tap(bucket)
	if bucket and bucket.components.stackable then
		bucket.components.stackable:Get(1):Remove()
		
		self.inst.AnimState:PlayAnimation("install")
		self.inst.AnimState:PushAnimation("sway1_loop", true)
		
		self.inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/craft/sap_extractor")
		
		self.inst:AddTag("tapped")
		
		self.has_bucket = true
	end
	
	self.inst.AnimState:Show("swap_tapper")

	self:OnUpdate(0)
end

------------------------------------------------------------------------------------------------------
-- Collect Sap

function Sappy:CollectSap(collector)
    if self.sap and self.has_sap then
		local product = SpawnPrefab(self.sap)  
		local bucket = SpawnPrefab("quagmire_sapbucket") 		
		
		if product and bucket then
            if product.components.inventoryitem ~= nil then
                product.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
            end

			if bucket.components.inventoryitem ~= nil then
                bucket.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
            end
			
            if collector ~= nil then
				product.components.stackable:SetStackSize(self.contestmode and 1 or self.sap_number)
				collector.components.inventory:GiveItem(product)
				collector.components.inventory:GiveItem(bucket)
            else
                product.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
				bucket.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
            end
			
			self.inst.AnimState:Hide("swap_tapper")
			self.inst.AnimState:Hide("sap")
			
			self.inst:RemoveTag("tapped")
			self.inst:RemoveTag("sappy")
			
			self.inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/craft/sap_extractor")
			
			self.cycles_left = math.max(self.cycles_left - 1, 0)
			self.saptime = 0
			self.rottentime = 0
			self.has_bucket = nil
			self.has_sap = nil
			self.sap = nil	
			self:MakeSappy(1)			
			
			if self.inst.flies then
				self.inst.flies:Remove()
				self.inst.flies = nil
			end
			
			self:OnUpdate(0)
        end
	end
end

function Sappy:IsReadyForHarvest()
    return self.has_sap
end

------------------------------------------------------------------------------------------------------
-- Saving and Loading Functions

function Sappy:OnSave()
    return
    {
		stage = self.stage or 0,
		
		sap = self.sap or nil,
		sap_number = self.sap_number or 1,
		has_sap = self.has_sap or nil,
		has_bucket = self.has_bucket or nil,
		
		saptime = self.saptime or 0,
		rottentime = self.rottentime or 0,
		growthtime = self.growthtime or 0,
		
		cycles_left = self.cycles_left or 0,
		
		waterlevel = self.waterlevel or 0,
		
		has_water = self.has_water or nil,
		isgrowing = self.isgrowing or nil,
		
		contestmode = self.contestmode or nil,
    }
end

function Sappy:OnLoad(data)
    if data ~= nil then
		self.stage = data.stage
		
		self.sap = data.sap
		self.sap_number = data.sap_number
		self.has_sap = data.has_sap
		self.has_bucket = data.has_bucket
		
		self.saptime = data.saptime
		self.rottentime = data.rottentime 
		self.growthtime = data.growthtime
		
		self.cycles_left = data.cycles_left
		
		self.waterlevel = data.waterlevel
		
		self.has_water = data.has_water
		self.isgrowing = data.isgrowing
		
		self.contestmode = data.contestmode
    end
	if self.has_bucket then
		self:Tap()
	end
	self:OnUpdate(0)
end

return Sappy
