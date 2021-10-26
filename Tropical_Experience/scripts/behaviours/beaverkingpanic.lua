BeaverKingPanic = Class(BehaviourNode, function(self, inst)
    BehaviourNode._ctor(self, "BeaverKingPanic")
    self.inst = inst
    self.waittime = 0
end)

function BeaverKingPanic:Visit()

    if self.status == READY then
        self:PickNewDirection()
        self.status = RUNNING
    else
        if GetTime() > self.waittime then
            self:PickNewDirection()

 --           if ThePlayer then
                local Targets = self.inst.__brain:GetTargets()
                local Pigs = self.inst.__brain:GetPigs()
                if #Targets > 0 and #Pigs < 2 then

    local x1, y1, z1 = self.inst.Transform:GetWorldPosition()
    local angle = math.random() * 2 * PI    
    local x2, y2, z2 = 
        x1 + math.cos(angle)*22,
        y1,
        z1 + math.sin(angle)*22   
    if TheWorld.Pathfinder:IsClear(x1, y1, z1, x2, y2, z2, { ignorewalls = false }) then
	local minion = SpawnPrefab("wildbeaverguard")
	minion.Transform:SetPosition(x2, y2, z2)

--	local invader = GetClosestInstWithTag("character", self.inst, 50)
--	if invader then 	
--	minion.components.combat:EngageTarget(invader) end
	end

				
				
                end
 --           end
        end
        self:Sleep(self.waittime - GetTime())
    end
end


function BeaverKingPanic:PickNewDirection()
    self.inst.components.locomotor:RunInDirection(math.random()*360)
    self.waittime = GetTime() + 0.25 + math.random()*0.25
    if math.random() < 0.1 then
        self.inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingHappy")
    end
end



