local cooking = require("cooking")

local function ondone(self, done)
    if done then
        self.inst:AddTag("donecooking")
    else
        self.inst:RemoveTag("donecooking")
    end
end

local function oncheckready(inst)
    if inst.components.container ~= nil and inst.components.container:IsFull() then
        inst.components.specialstewer:StartWorking()
    end
end

local function onnotready(inst)
    inst:RemoveTag("readytocook")
    if inst.components.specialstewer.isdone then
        inst:RemoveTag("takeonly")
        inst.components.specialstewer.isdone = false
    end
end

local SpecialStewer = Class(function(self, inst)
    self.inst = inst

    self.done = nil
    self.targettime = nil
    self.task = nil
    self.product = nil
    self.product_spoilage = nil
    self.spoiledproduct = "spoiled_food"
    self.spoiltime = nil
    self.cookertype = nil
    self.iscooking = false
    self.cooktime = 99999
    self.intervalcheck = 1
    self.containerfn = nil
    self.oncompletefn = nil
    self.oncookingstepfn = nil
    self.burnthreshold = -20
    self.isdone = false

    --"readytocook" means it's CLOSED and FULL
    --This tag is used for gathering scene actions only
    --The widget cook button doesn't check this tag,
    --and obviously has to work when the pot is open

--    inst:ListenForEvent("itemget", oncheckready)
    inst:ListenForEvent("onclose", oncheckready)

--    inst:ListenForEvent("itemlose", onnotready)
--    inst:ListenForEvent("onopen", onnotready)

    self.inst:AddTag("stewer")
    self.inst:RemoveTag("cooker")
end,
nil,
{
    done = ondone,
})

function SpecialStewer:OnRemoveFromEntity()
    self.inst:RemoveTag("donecooking")
    self.inst:RemoveTag("readytocook")
end

function SpecialStewer:GetContainer()
    if self.containerfn then
        return self.containerfn(self.inst)
    end
    return self.inst.components.container
end

local function dospoil(inst, self)
    self.task = nil
    self.targettime = nil
    self.spoiltime = nil

    if self.onspoil ~= nil then
        self.onspoil(inst)
    end
end

function SpecialStewer:GetFireMultiplier()
    local fueled = self.inst.components.fueled
    local section = fueled:GetCurrentSection()
    local maxsection = fueled.sections
    local multiplier = (section / maxsection) * 2
    return multiplier
end

function SpecialStewer:BurnProduct()
    self:GetContainer():DestroyContents()
    self:GetContainer():GiveItem(SpawnPrefab("ash"))
end

function SpecialStewer:IsWorking()
    return self:GetContainer() ~= nil and self:GetContainer():IsFull() and not self:GetContainer():IsOpen()
end

function SpecialStewer:IsDone()
    return self.isdone
end

local function dostewstep(inst, self)
    self.task = nil
    if self:IsWorking() then
	print(self.inst.components.fueled.currentfuel)
		if self.inst.components.container  and not self.inst.components.shelf  then self.inst.components.container.canbeopened = false end	
        if not self.iscooking then --and not self.isdone then
            self:StartCooking()
        end
        local multiplier = self:GetFireMultiplier()
        if self.oncookingstepfn then
            self.oncookingstepfn(self.inst, multiplier)
        end
        local cookedtime = self.intervalcheck * multiplier
        self.cooktime = self.cooktime - cookedtime
        if self.cooktime <= 0 then
            if self.product ~= nil then
                self:CompleteCooking()
            -- TODO
            -- elseif self.cooktime < self.burnthreshold then
            --     self:BurnProduct()
            end
        end
    end
if self.inst.components.fueled and self.inst.components.fueled.currentfuel <= 0 then
self:StopCooking("fire")
end
	
	if self.iscooking then
    self.task = inst:DoTaskInTime(self.intervalcheck, dostewstep, self)
	end
end

function SpecialStewer:StartWorking()
    self.task = self.inst:DoTaskInTime(self.intervalcheck, dostewstep, self)
end

local function dostew(inst, self)
    self.task = nil
    self.targettime = nil
    self.spoiltime = nil

    if self.ondonecooking ~= nil then
        self.ondonecooking(inst)
    end

    if self.product == self.spoiledproduct then
        if self.onspoil ~= nil then
            self.onspoil(inst)
        end
    elseif self.product ~= nil then
        local prep_perishtime = cooking.GetRecipe(inst.prefab, self.product).perishtime or 0
        if prep_perishtime > 0 then
			local prod_spoil = self.product_spoilage or 1
			self.spoiltime = prep_perishtime * prod_spoil
			self.targettime =  GetTime() + self.spoiltime
			self.task = self.inst:DoTaskInTime(self.spoiltime, dospoil, self)
		end
    end
    self.done = true
end

function SpecialStewer:IsDone()
    return self.done
end

function SpecialStewer:IsSpoiling()
    return self.done and self.targettime ~= nil
end

function SpecialStewer:IsCooking()
    return not self.done and self.targettime ~= nil
end

function SpecialStewer:GetTimeToCook()
    return not self.done and self.targettime ~= nil and self.targettime - GetTime() or 0
end

function SpecialStewer:GetTimeToSpoil()
    return self.done and self.targettime ~= nil and self.targettime - GetTime() or 0
end

function SpecialStewer:CanCook()
    return self.inst.components.container ~= nil and self.inst.components.container:IsFull() and not self:GetContainer():Has("ash")
end

function SpecialStewer:OverrideProduct()
    if self.product == "syrup" and self.inst.dish and self.inst.dish.prefab ~= "pot_syrup" then
        self.product = "wetgoop"
    end
end

function SpecialStewer:StartCooking()
    if self.targettime == nil and self:GetContainer() ~= nil then
        self.done = nil
        self.spoiltime = nil
        self.iscooking = true

        if self.onstartcooking ~= nil then
            self.onstartcooking(self.inst)
        end

		local ings = {}
		for k, v in pairs (self:GetContainer().slots) do
			table.insert(ings, v.prefab)
		end

        local cooktime = 1
        self.product, cooktime = cooking.CalculateRecipe(self.cookertype or self.inst.prefab, ings)
        self:OverrideProduct()
        local recipe = cooking.GetRecipe(self.cookertype or self.inst.prefab, self.product)
        local productperishtime = recipe.perishtime or 0

        if productperishtime > 0 then
			local spoilage_total = 0
			local spoilage_n = 0
			for k, v in pairs (self:GetContainer().slots) do
				if v.components.perishable ~= nil then
					spoilage_n = spoilage_n + 1
					spoilage_total = spoilage_total + v.components.perishable:GetPercent()
				end
			end
			self.product_spoilage = 1
			if spoilage_total > 0 then
				self.product_spoilage = spoilage_total / spoilage_n
				self.product_spoilage = 1 - (1 - self.product_spoilage) * .5
			end
		else
			self.product_spoilage = nil
		end

        self.cooktime = cooktime * TUNING.BASE_COOK_TIME

        -- self.targettime = GetTime() + cooktime
        -- if self.task ~= nil then
        --     self.task:Cancel()
        -- end
        -- self.task = self.inst:DoTaskInTime(cooktime, dostew, self)
        -- self.task = self.inst:DoTaskInTime(self.intervalcheck, dostewstep, self)

        -- self.inst.components.container:Close()
        -- self.inst.components.container:DestroyContents()
        -- self.inst.components.coinstallationsntainer.canbeopened = false
    end
end

local function StopProductPhysics(prod)
    prod.Physics:Stop()
end

function SpecialStewer:CompleteCooking(reason)
    if self.product ~= nil and self:GetContainer() ~= nil then
        local prod = SpawnPrefab(self.product)
        if prod ~= nil then
            -- prod.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
            -- prod:DoTaskInTime(0, StopProductPhysics)
            self:GetContainer():DestroyContents()
            self:GetContainer():GiveItem(prod)
            -- table.insert(self:GetContainer().slots, prod)
            self.inst:AddTag("takeonly")
            if self.oncompletefn then
                self.oncompletefn(self.inst)
            end
        end
    end
    self.product = nil
    self.product_spoilage = nil
    self.spoiltime = nil
    self.targettime = nil
    self.done = nil
    self.iscooking = false
    self.isdone = true
    if self.inst.components.container and not self.inst.components.shelf then self.inst.components.container.canbeopened = true end	
end

function SpecialStewer:StopCooking(reason)
    if self.task ~= nil then
        self.task:Cancel()
        self.task = nil
    end
    if self.product ~= nil and reason == "fire" then
--        local prod = SpawnPrefab(self.product)
--        if prod ~= nil then
--            prod.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
--            prod:DoTaskInTime(0, StopProductPhysics)
--        end
    end
    self.product = nil
    self.product_spoilage = nil
    self.spoiltime = nil
    self.targettime = nil
    self.done = nil
    self.iscooking = false

    if self.inst.components.container and not self.inst.components.shelf then self.inst.components.container.canbeopened = true end	
end

function SpecialStewer:OnSave()
    local remainingtime = self.targettime ~= nil and self.targettime - GetTime() or 0
    return
    {
        done = self.done,
        product = self.product,
        product_spoilage = self.product_spoilage,
        spoiltime = self.spoiltime,
        remainingtime = remainingtime > 0 and remainingtime or nil,
        cookertype = self.cookertype,
        -- firepit = self.firepit and self.firepit:GetSaveRecord() or nil,
        cooktime = self.cooktime,
        isdone = self.isdone,
        iscooking = self.iscooking,
    }
end

function SpecialStewer:OnLoad(data)
    if data.cookertype then
        self.cookertype = data.cookertype
        self.isdone = data.isdone or false
        self.iscooking = data.iscooking or false
        self.cooktime = data.cooktime
    end
    -- if data.firepit then
    --     self.firepit = SpawnSaveRecord(data.firepit)
    -- end
    if data.product ~= nil then
        self.done = data.done or nil
        self.product = data.product
        self.product_spoilage = data.product_spoilage
        self.spoiltime = data.spoiltime

        if self.task ~= nil then
            self.task:Cancel()
            self.task = nil
        end
        self.targettime = nil

        if data.remainingtime ~= nil then
            self.targettime = GetTime() + math.max(0, data.remainingtime)
            if self.done then
                self.task = self.inst:DoTaskInTime(self.intervalcheck, dostewstep, self)
                if self.oncontinuedone ~= nil then
                    self.oncontinuedone(self.inst)
                end
            else
                self.task = self.inst:DoTaskInTime(self.intervalcheck, dostewstep, self)
                if self.oncontinuecooking ~= nil then
                    self.oncontinuecooking(self.inst)
                end
            end
        elseif self.product ~= self.spoiledproduct and data.product_spoilage ~= nil then
            self.targettime = GetTime()
            self.task = self.inst:DoTaskInTime(0, dostewstep, self)
            if self.oncontinuecooking ~= nil then
                self.oncontinuecooking(self.inst)
            end
        elseif self.oncontinuedone ~= nil then
            self.oncontinuedone(self.inst)
        end

        if self.inst.components.container ~= nil  and not self.inst.components.shelf then
            self.inst.components.container.canbeopened = false
        end
    end
end

function SpecialStewer:GetDebugString()
    local status = (self:IsCooking() and "COOKING")
                or (self:IsDone() and "FULL")
                or "EMPTY"

    return string.format("%s %s timetocook: %.2f timetospoil: %.2f productspoilage: %.2f",
            self.product or "<none>",
            status,
            self:GetTimeToCook(),
            self:GetTimeToSpoil(),
            self.product_spoilage or -1)
end

function SpecialStewer:Harvest(harvester)
    if self.done then
        if self.onharvest ~= nil then
            self.onharvest(self.inst)
        end

        if self.product ~= nil then
            local loot = SpawnPrefab(self.product)
            if loot ~= nil then
				local recipe = cooking.GetRecipe(self.inst.prefab, self.product)
				local stacksize = recipe and recipe.stacksize or 1
				if stacksize > 1 then
					loot.components.stackable:SetStackSize(stacksize)
				end

                if self.spoiltime ~= nil and loot.components.perishable ~= nil then
                    local spoilpercent = self:GetTimeToSpoil() / self.spoiltime
                    loot.components.perishable:SetPercent(self.product_spoilage * spoilpercent)
                    loot.components.perishable:StartPerishing()
                end
                if harvester ~= nil and harvester.components.inventory ~= nil then
                    harvester.components.inventory:GiveItem(loot, nil, self.inst:GetPosition())
                else
                    LaunchAt(loot, self.inst, nil, 1, 1)
                end
            end
            self.product = nil
        end

        if self.task ~= nil then
            self.task:Cancel()
            self.task = nil
        end
        self.targettime = nil
        self.done = nil
        self.spoiltime = nil
        self.product_spoilage = nil

        if self.inst.components.container ~= nil  and not self.inst.components.shelf then
            self.inst.components.container.canbeopened = true
        end

        return true
    end
end

function SpecialStewer:LongUpdate(dt)
    if self:IsCooking() then
        if self.task ~= nil then
            self.task:Cancel()
        end
        if self.targettime - dt > GetTime() then
            self.targettime = self.targettime - dt
            self.task = self.inst:DoTaskInTime(self.targettime - GetTime(), dostew, self)
            dt = 0
        else
            dt = dt - self.targettime + GetTime()
            dostew(self.inst, self)
        end
    end

    if dt > 0 and self:IsSpoiling() then
        if self.task ~= nil then
            self.task:Cancel()
        end
        if self.targettime - dt > GetTime() then
            self.targettime = self.targettime - dt
            self.task = self.inst:DoTaskInTime(self.targettime - GetTime(), dospoil, self)
        else
            dospoil(self.inst, self)
        end
    end
end

function SpecialStewer:ResetWork()
    if self.task ~= nil then 
	self.task:Cancel()
    self.task = nil
	end
    self.isdone = false
    self.iscooking = false
    self.product = nil
    self.cooktime = 9999
    self.targettime = nil
    self.done = nil
    self.spoiltime = nil
    self.product_spoilage = nil
end

function SpecialStewer:Bind(target)
    self.firepit = target
end

return SpecialStewer
