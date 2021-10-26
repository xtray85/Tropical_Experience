local Whirlpool = Class(function(self, inst)
    self.inst = inst
    self.whirlpoolradius = 7
    self.whirlpoolspeed = 0.50 
    self.consumeradius = 1
    self.noTags = {"FX", "NOCLICK", "DECOR", "INLIMBO", "STUMP", "BIRD", "NOVACUUM"}
    self.ignoreplayer = false
    self.playerwhirlpooldamage = 50
    self.playerwhirlpoolsanityhit = 0
    self.playerwhirlpoolradius = 25
    self.player_hold_distance = 1
    self.holdingplayertimer = 0
    self.holdplayertime = 2
    self.whirlpooling_player = false 
    self.spitplayer = false
end)
function CheckLOSFromPoint(pos, target_pos)
--[[
    local dist = target_pos:Dist(pos)
    local vec = (target_pos - pos):GetNormalized()

    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, dist, {"blocker"})

    for k,v in pairs(ents) do
        local blocker_pos = v:GetPosition()
        local blocker_vec = (blocker_pos - pos):GetNormalized()
        local blocker_perp = Vector3(-blocker_vec.z, 0, blocker_vec.x)
        local blocker_radius = v.Physics:GetRadius()
        blocker_radius = math.max(0.75, blocker_radius)

        local blocker_edge1 = blocker_pos + Vector3(blocker_perp.x * blocker_radius, 0, blocker_perp.z * blocker_radius)
        local blocker_edge2 = blocker_pos - Vector3(blocker_perp.x * blocker_radius, 0, blocker_perp.z * blocker_radius)

        local blocker_vec1 = (blocker_edge1 - pos):GetNormalized()
        local blocker_vec2 = (blocker_edge2 - pos):GetNormalized()

--        if isbetween(vec, blocker_vec1, blocker_vec2) then
            -- print(v, "blocks LoS.")
            -- print("-----------")
--            return false
--        end
    end
    -- print("Nothing blocked LoS.")
    -- print("-----------")
]]
    return true
end


function Whirlpool:TurnOn()
	self.inst:StartUpdatingComponent(self)
end 

function Whirlpool:TurnOff()
	self.inst:StopUpdatingComponent(self)
end

function Whirlpool:SpitItem(item)
	if not item then
		local slot = math.random(1,self.inst.components.inventory:GetNumSlots())
		item = self.inst.components.inventory:DropItem()
	end

	if item and item.Physics then
        local x, y, z = self.inst:GetPosition():Get()
        y = 2
        item.Physics:Teleport(x,y,z)
        item:AddTag("NOVACUUM")
		item:DoTaskInTime(2, function() item:RemoveTag("NOVACUUM") end)
        
        local speed = 8 + (math.random() * 4)
        local angle =  (math.random() * 360) * DEGREES
        item.Physics:SetVel(math.cos(angle) * speed, 10, math.sin(angle) * speed)
    end
end 

function Whirlpool:OnUpdate(dt)
	-- find entities within radius and whirlpool them towards my location  
	local pt = self.inst:GetPosition()
 	local ents = TheSim:FindEntities(pt.x, 0, pt.z, self.consumeradius, nil, self.noTags)

--    for k,v in pairs(ents) do
--    	if v and v.components.inventoryitem and not v.components.inventoryitem:IsHeld() then
--			if not self.inst.components.inventory:GiveItem(v) then
--				self:SpitItem(v)
--			end 
--		end 
--	end

	ents = TheSim:FindEntities(pt.x, pt.y, pt.z, self.whirlpoolradius, nil, self.noTags)

	for k,v in pairs(ents) do
    	if v and v.Physics and v.components.floater and v.components.floater.showing_effect == true and CheckLOSFromPoint(self.inst:GetPosition(), v:GetPosition()) then
		
			local x, y, z = v:GetPosition():Get()
		    y = .1
		    v.Physics:Teleport(x,y,z)
			local dir =  v:GetPosition() - self.inst:GetPosition()
			local angle = math.atan2(-dir.z, -dir.x) 
        	v.Physics:SetVel(math.cos(angle) * self.whirlpoolspeed, 0, math.sin(angle) * self.whirlpoolspeed)
			
			
			elseif v and v:HasTag("walkableplatform") and not v:HasTag("anchor_lowered") then			
			if v.components.boatphysics then
			local boat_physics = v.components.boatphysics
			
			
			local dir =  v:GetPosition() - self.inst:GetPosition()
			local angle = math.atan2(-dir.z, -dir.x) 
			boat_physics:ApplyForce(math.cos(angle), math.sin(angle), self.whirlpoolspeed/math.random(40,100))
			end

			
			
--[[			
		elseif v and v:HasTag("player") and v:HasTag("aquatic") then	
		
		local player = v
		if player and not self.ignoreplayer or self.whirlpooling_player then
		player:RemoveTag("NOVACUUM")
  		local playerpos = player:GetPosition()
  		local displacement = playerpos - self.inst:GetPosition()  
  		local dist = displacement:Length()
  		local angle = math.atan2(-displacement.z, -displacement.x) 
  		local playerDistanceMultiplier =  1
	    if dist < self.player_hold_distance or self.spitplayer then
    	self.holdingplayertimer = self.holdingplayertimer + dt
		if not self.spitplayer then 
	    player.Transform:SetRotation(0) 
	  	player.Physics:SetMotorVelOverride(0, 0, 0)
	  	player:PushEvent("whirlpool_held")
	    else 
	    local mult = self.playerwhirlpooldamage / self.inst.components.combat.defaultdamage
		self.inst.components.combat:DoAttack(player, nil, nil, nil, mult)
		player.components.sanity:DoDelta(self.playerwhirlpoolsanityhit )
		player:AddTag("NOVACUUM") --Shoot player out 
		player:PushEvent("whirlpool_out", {angle = angle, speed = -self.whirlpoolspeed})
		player.Transform:SetRotation(0) 
	  	self.holdingplayertimer = 0
	  	self.whirlpooling_player = false 
	  	end 	    
  		elseif not player:HasTag("NOVACUUM") and (self.whirlpooling_player or (dist < (self.playerwhirlpoolradius * playerDistanceMultiplier) and CheckLOSFromPoint(self.inst:GetPosition(), player:GetPosition()))) then
  			player.Transform:SetRotation(0) 
  			player.Physics:SetMotorVelOverride(math.cos(angle) * self.whirlpoolspeed, 0, math.sin(angle) * self.whirlpoolspeed)
  			player.components.locomotor:Clear()
  			player:PushEvent("whirlpool_in")
  			self.holdingplayertimer = 0
  			self.whirlpooling_player = true
  		end 
		end		
]]		
		
		else
	        v:AddTag("NOVACUUM")
			v:DoTaskInTime(1, function() v:RemoveTag("NOVACUUM") end)
		end
	end 
end

return Whirlpool
