require "behaviours/wander"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/chaseandattack"

local CHASE_TIME = 30
local CHASE_DIST = 40
local MAX_IDLE_WANDER_DIST = 10


local SwordfishBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)


function SwordfishBrain:OnInitializationComplete()
      self.inst.components.knownlocations:RememberLocation("home", Point(self.inst.Transform:GetWorldPosition()), true)
 end

local wandertimes =
{
    minwalktime = 2,
    randwalktime =  2,
    minwaittime = 0.1,
    randwaittime = 0.1,
}

local function FindFoodAction(inst)
local target = GetClosestInstWithTag("fishinghook", inst, 4)
if target and target.components.oceanfishinghook ~= nil and TheWorld.Map:IsOceanAtPoint(target.Transform:GetWorldPosition()) 
and not target.components.oceanfishinghook:HasLostInterest(inst) and target.components.oceanfishinghook:TestInterest(inst) then --and target:HasTag("swfishbait") then
if target.components.oceanfishinghook.lure_data and target.components.oceanfishinghook.lure_data.style and target.components.oceanfishinghook.lure_data.style == ("swfish")then
local x, y, z = inst.Transform:GetWorldPosition()
local part = SpawnPrefab("oceanfish_small_19")
if part ~= nil then
part.Transform:SetPosition(x, y, z)
if part.components.health ~= nil then
part.components.health:SetPercent(1)
end
end					
inst:Remove() 
end
end

end

function SwordfishBrain:OnStart()
    
    local root = PriorityNode(
    {
        ChaseAndAttack(self.inst, CHASE_TIME, CHASE_DIST),
		DoAction(self.inst, FindFoodAction, "eat food", true ),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_IDLE_WANDER_DIST, wandertimes)

    }, .25)
    self.bt = BT(self.inst, root)
end

return SwordfishBrain
