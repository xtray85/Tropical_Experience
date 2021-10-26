local Poisonous = Class(function(self, inst)
	self.inst = inst
	self.poisontestfn = function(x, target)
		return math.random() < 1
	end
	self.dmg = nil
	self.interval = nil
	self.duration = nil
end)

function Poisonous:OnAttack(target, dmg)
	if target and target.components.poisonable and self.poisontestfn and self.poisontestfn(self.inst, target) then
if	target and target:HasTag("player") then
local corpo = target.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
local cabeca = target.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
	if target and target.prefab == "wx78" then return end
	if corpo and corpo.prefab == "armor_seashell" then return end
	if cabeca and cabeca.prefab == "oxhat" then return end
	if cabeca and cabeca.prefab == "gasmaskhat" and self.inst.prefab == "stungray" then return end
	if cabeca and cabeca.prefab == "gashat" and self.inst.prefab == "stungray" then return end		
end	
	

		target.components.poisonable:SetPoison(self.dmg, self.interval, self.duration)
	end
end

function Poisonous:SetPoisonTestFn(fn)
	self.poisontestfn = fn
end

return Poisonous