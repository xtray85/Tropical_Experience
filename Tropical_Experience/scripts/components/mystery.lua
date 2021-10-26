local NUM_RELICS = 5

local Mystery = Class(function(self, inst)
    self.inst = inst

    self:RollForMystery()                   
end)

function Mystery:GenerateReward()
	local mid_tier = {"flint", "goldnugget", "oinc", "oinc10"}
	for i=1,NUM_TRINKETS do
		table.insert(mid_tier, "trinket_" .. tostring(i))
	end

	local high_tier = {}
	for i=1,NUM_RELICS do
		table.insert(high_tier, "relic_" .. tostring(i))
	end

	if math.random() < 0.4 then
		return nil
	elseif math.random() < 0.7 then
		return mid_tier[math.random(#mid_tier)]
	else
		return high_tier[math.random(#high_tier)]
	end
end

function Mystery:AddReward()
	local color = 0.5 + math.random() * 0.5
    self.inst.AnimState:SetMultColour(color-0.15, color-0.15, color, 1)

	self.inst:AddTag("mystery")
	self.reward = self:GenerateReward()
end

function Mystery:RollForMystery()
	if math.random() <= 0.05 then
		self:AddReward()
	end
end

function Mystery:OnLoad(data)
	if data.has_mystery then
		self:AddReward()
	end
end

function Mystery:OnSave()
	local data = {}
	if self.inst:HasTag("mystery") then
		data.has_mystery = true
	end

	return data
end

function Mystery:IsActionValid(action, right)
    return self.inst:HasTag("mystery") and action == ACTIONS.INVESTIGATE
end

function Mystery:Investigate(doer)
	if self.reward then
		doer.components.talker:Say(GetString(doer.prefab, "ANNOUNCE_MYSTERY_FOUND"))
		self.investigated = true
	else
		doer.components.talker:Say(GetString(doer.prefab, "ANNOUNCE_MYSTERY_NOREWARD"))
		self.inst:RemoveTag("mystery")
	end
end

return Mystery