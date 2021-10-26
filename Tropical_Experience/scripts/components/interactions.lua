local Interactions = Class(function(self, inst)
    self.inst = inst
end)

local maxdist = 3.0
local mindist = 1.0
local actdist = 4.56
local clerance = 0.9
local offset = 1.35		-- wall jump: obstacle check
local offset2 = 1.30	-- wall jump: actual offset
local offset3 = 1.00	-- free jump: passable check
local pi = 3.1415926

local reach_dist = 1.5
local dist_push = 4.56
local dist_push_player = 0.45
local Bash_dmg = 10

local hiding_cost = 3
local refuge_cost = 3

local loot_chance = 0.25
local search_cost = 8


function Interactions:BoatJump(jumper)
	if jumper and jumper:HasTag('player') then
jumper.Physics:ClearCollisionMask()
jumper.Physics:CollidesWith(COLLISION.WORLD)
jumper.Physics:CollidesWith(COLLISION.OBSTACLES)
jumper.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
jumper.Physics:CollidesWith(COLLISION.CHARACTERS)
jumper.Physics:CollidesWith(COLLISION.GIANTS)		
		local x1, y1, z1 = self.inst.Transform:GetWorldPosition()
		local x2, y2, z2 = jumper.Transform:GetWorldPosition()
		local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
		jumper.Physics:SetMotorVel(dist * 1.67, 0, 0)
		jumper:AddComponent("driver")
		jumper.sg:GoToState("jumponboatstart", self.inst)

		jumper.components.driver.mountdata = self.inst
	end
end

function Interactions:BoatJumpnew(jumper)
	if jumper and jumper:HasTag('player') then
jumper.Physics:ClearCollisionMask()
jumper.Physics:CollidesWith(COLLISION.WORLD)
jumper.Physics:CollidesWith(COLLISION.OBSTACLES)
jumper.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
jumper.Physics:CollidesWith(COLLISION.CHARACTERS)
jumper.Physics:CollidesWith(COLLISION.GIANTS)		
local x1, y1, z1 = self.inst.Transform:GetWorldPosition()
local x2, y2, z2 = jumper.Transform:GetWorldPosition()
		
local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
		
jumper.Physics:SetMotorVel(dist * 1.67, 0, 0)
jumper.sg:GoToState("jumponboatstart")
	end
end

function Interactions:BoatDismount(jumper, pt)
	if jumper and jumper:HasTag('player') then
jumper.Physics:ClearCollisionMask()
jumper.Physics:CollidesWith(COLLISION.WORLD)
jumper.Physics:CollidesWith(COLLISION.OBSTACLES)
jumper.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
jumper.Physics:CollidesWith(COLLISION.CHARACTERS)
jumper.Physics:CollidesWith(COLLISION.GIANTS)	
    if jumper.components.health ~= nil then
        jumper.components.health:SetInvincible(false)
    end
    local x1, y1, z1 = pt:Get()
    local x2, y2, z2 = jumper.Transform:GetWorldPosition()
    local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))

    jumper.Physics:SetMotorVel(dist * 1.67, 0, 0)
    jumper.sg:GoToState("jumponboatdismount")


jumper:RemoveComponent("rowboatwakespawner")
if jumper.components.driver then
local barcoinv = jumper.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
if barcoinv and barcoinv.prefab == jumper.components.driver.vehicle.prefab  then 
local consumo = SpawnPrefab(jumper.components.driver.vehicle.prefab)
consumo.Transform:SetPosition(jumper.components.driver.vehicle:GetPosition():Get())
consumo.components.finiteuses.current = barcoinv.components.finiteuses.current

local x, y, z = consumo.Transform:GetWorldPosition()
if not TheWorld.Map:IsOceanAtPoint(x, y, z, false) then
local posifinal = Vector3(consumo.Transform:GetWorldPosition())
local destino = FindSwimmableOffset(posifinal, math.random() * 2 * PI, 2, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 4, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 6, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 8, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 12, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 14, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 16, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 20, 6) or				
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 18, 6)
if destino then
consumo.Transform:SetPosition(x + destino.x, y + destino.y, z + destino.z)
end
end
-------------------------transfere o conteudo do barco inventario para o barco do criado---------------------------------
if barcoinv.components.container then
local sailslot = barcoinv.components.container:GetItemInSlot(1)
if sailslot then
consumo.components.container:GiveItem(sailslot, 1)
end

local luzslot = barcoinv.components.container:GetItemInSlot(2)
if luzslot and luzslot.prefab == "quackeringram" then luzslot.navio1 = nil end
if luzslot then
consumo.components.container:GiveItem(luzslot, 2)
end

local cargoslot1 = barcoinv.components.container:GetItemInSlot(3)
if cargoslot1 then
consumo.components.container:GiveItem(cargoslot1, 3)
end

local cargoslot2 = barcoinv.components.container:GetItemInSlot(4)
if cargoslot2 then
consumo.components.container:GiveItem(cargoslot2, 4)
end

local cargoslot3 = barcoinv.components.container:GetItemInSlot(5)
if cargoslot3 then
consumo.components.container:GiveItem(cargoslot3, 5)
end

local cargoslot4 = barcoinv.components.container:GetItemInSlot(6)
if cargoslot4 then
consumo.components.container:GiveItem(cargoslot4, 6)
end

local cargoslot5 = barcoinv.components.container:GetItemInSlot(7)
if cargoslot5 then
consumo.components.container:GiveItem(cargoslot5, 7)
end

local cargoslot6 = barcoinv.components.container:GetItemInSlot(8)
if cargoslot6 then
consumo.components.container:GiveItem(cargoslot6, 8)
end end
----------------------------------------------------------------------------------------------------------------------
barcoinv:Remove()
end
--if jumper.components.driver.simbolo then jumper.AnimState:ClearOverrideSymbol(jumper.components.driver.simbolo) end
--if jumper.components.driver.simbolo1 then jumper.AnimState:ClearOverrideSymbol(jumper.components.driver.simbolo1) end
jumper.components.driver.vehicle:Remove()
jumper:RemoveComponent("driver")
jumper:RemoveTag("sail")
jumper:RemoveTag("surf")
jumper:RemoveTag("aquatic")
end
	
	end
end

function Interactions:BoatDismount2(jumper)
if jumper and jumper:HasTag('player') then
jumper:RemoveComponent("rowboatwakespawner")
if jumper.components.driver then
local barcoinv = jumper.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
if barcoinv and barcoinv.prefab == jumper.components.driver.vehicle.prefab  then 
local consumo = SpawnPrefab(jumper.components.driver.vehicle.prefab)
consumo.Transform:SetPosition(jumper.components.driver.vehicle:GetPosition():Get())
consumo.components.finiteuses.current = barcoinv.components.finiteuses.current

local x, y, z = consumo.Transform:GetWorldPosition()
if not TheWorld.Map:IsOceanAtPoint(x, y, z, false) then
local posifinal = Vector3(consumo.Transform:GetWorldPosition())
local destino = FindSwimmableOffset(posifinal, math.random() * 2 * PI, 2, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 4, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 6, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 8, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 12, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 14, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 16, 6) or
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 20, 6) or				
				FindSwimmableOffset(posifinal, math.random() * 2 * PI, 18, 6)
if destino then
consumo.Transform:SetPosition(x + destino.x, y + destino.y, z + destino.z)
end
end
-------------------------transfere o conteudo do barco inventario para o barco do criado---------------------------------
if barcoinv.components.container then
local sailslot = barcoinv.components.container:GetItemInSlot(1)
if sailslot then
consumo.components.container:GiveItem(sailslot, 1)
end

local luzslot = barcoinv.components.container:GetItemInSlot(2)
if luzslot and luzslot.prefab == "quackeringram" then luzslot.navio1 = nil end
if luzslot then
consumo.components.container:GiveItem(luzslot, 2)
end

local cargoslot1 = barcoinv.components.container:GetItemInSlot(3)
if cargoslot1 then
consumo.components.container:GiveItem(cargoslot1, 3)
end

local cargoslot2 = barcoinv.components.container:GetItemInSlot(4)
if cargoslot2 then
consumo.components.container:GiveItem(cargoslot2, 4)
end

local cargoslot3 = barcoinv.components.container:GetItemInSlot(5)
if cargoslot3 then
consumo.components.container:GiveItem(cargoslot3, 5)
end

local cargoslot4 = barcoinv.components.container:GetItemInSlot(6)
if cargoslot4 then
consumo.components.container:GiveItem(cargoslot4, 6)
end

local cargoslot5 = barcoinv.components.container:GetItemInSlot(7)
if cargoslot5 then
consumo.components.container:GiveItem(cargoslot5, 7)
end

local cargoslot6 = barcoinv.components.container:GetItemInSlot(8)
if cargoslot6 then
consumo.components.container:GiveItem(cargoslot6, 8)
end end
----------------------------------------------------------------------------------------------------------------------
barcoinv:Remove()
end
--if jumper.components.driver.simbolo then jumper.AnimState:ClearOverrideSymbol(jumper.components.driver.simbolo) end
--if jumper.components.driver.simbolo1 then jumper.AnimState:ClearOverrideSymbol(jumper.components.driver.simbolo1) end
jumper.components.driver.vehicle:Remove()
jumper:RemoveComponent("driver")
jumper:RemoveTag("sail")
jumper:RemoveTag("surf")
jumper:RemoveTag("aquatic")
end
	
	end
end

function Interactions:WallJump(jumper)
	if jumper and jumper:HasTag('player') then
		local x1, y1, z1 = self.inst.Transform:GetWorldPosition()
		local x2, y2, z2 = jumper.Transform:GetWorldPosition()
		local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
		local x3 = (x1 - x2) * offset + x1
		local z3 = (z1 - z2) * offset + z1
		local x4 = (x1 - x2) * offset2 + x1
		local z4 = (z1 - z2) * offset2 + z1
		
		if dist <= mindist and dist > 0 then
			x3 = (x1 - x2)/dist*mindist + x1
			z3 = (z1 - z2)/dist*mindist + z1
			x4 = (x1 - x2)/dist*mindist + x1
			z4 = (z1 - z2)/dist*mindist + z1
		elseif dist <= 0 then
			return
		end
		
		local ents = TheSim:FindEntities(x3, y2, z3,clerance,nil,{"player"})
		local obstacle = false
		for k, ent in pairs(ents) do
			if ent.Physics and ent.components.inventoryitem == nil then
				obstacle = true
				break
			end
		end
		local local_passable = TheWorld.Map:IsPassableAtPoint(x4, 0, z4)
		
		if dist <= maxdist and not obstacle and local_passable then
			if jumper.Physics ~= nil then
				jumper.Physics:Teleport(x4, 0, z4)
			else
				jumper.Transform:SetPosition(x4, 0, z4)
			end
		else
			if jumper.components.talker then
				jumper.components.talker:Say("I can't jump that far.")
			end
		end
	end
end

function Interactions:Jump(jumper)
	if jumper and jumper:HasTag('player') then
		local x1, y1, z1 = self.inst.Transform:GetWorldPosition()
		local x2, y2, z2 = jumper.Transform:GetWorldPosition()
		local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
		local angle = jumper.old_rotation or jumper.Transform:GetRotation()
		angle = angle * DEGREES
		
		if jumper == self.inst and jumper.old_rotation then
			jumper.Transform:SetRotation(jumper.old_rotation)
		end
		
		local x3 = math.cos(angle) * actdist + x2  -- destination
		local z3 = -math.sin(angle) * actdist + z2  -- destination
		local x4 = math.cos(angle) * (actdist/2) + x2  -- midpoint
		local z4 = -math.sin(angle) * (actdist/2) + z2  -- midpoint
		
		-- destination offsets:
		local x5 =  math.cos(angle) * (actdist+offset3) + x2
		local z5 = -math.sin(angle) * (actdist+offset3) + z2
		local x6 =  math.cos(angle + pi/24) * (actdist+offset3) + x2
		local z6 = -math.sin(angle + pi/24) * (actdist+offset3) + z2
		local x7 =  math.cos(angle - pi/24) * (actdist+offset3) + x2
		local z7 = -math.sin(angle - pi/24) * (actdist+offset3) + z2
		
		local vx = 1
		local vz = 0
		
		if jumper ~= self.inst and dist > 0 then
			vx = (x1 - x2) / dist  -- normal x
			vz = (z1 - z2) / dist  -- normal z
		
			x3 = vx * actdist + x2  -- destination
			z3 = vz * actdist + z2  -- destination
			x4 = vx * (actdist/2) + x2  -- midpoint
			z4 = vz * (actdist/2) + z2  -- midpoint
		
		-- destination offsets:
			x5 = vx * (actdist+offset3) + x2
			z5 = vz * (actdist+offset3) + z2
			x6 = vx * (actdist+offset3*0.33) + x2
			z6 = vz * (actdist+offset3*0.33) + z2
			x7 = vx * (actdist+offset3*0.66) + x2
			z7 = vz * (actdist+offset3*0.66) + z2
		end
		
		local ents = TheSim:FindEntities(x3, y2, z3,clerance*1.5,nil,{"player"})
		local obstacle = false
		for k, ent in pairs(ents) do
			if ent.Physics and ent.components.inventoryitem == nil then
				obstacle = true
				break
			end
		end
		
		local ents2 = {}
		if jumper == self.inst then  -- check middle
			ents2 = TheSim:FindEntities(x4, y2, z4,(actdist/2 - clerance),nil,{"player"},{"tree","structure","wall"})
			for k, ent2 in pairs(ents2) do
				if ent2.components.inventoryitem == nil and not ent2:HasTag("wall") then
					obstacle = true
					break
				end
			end
			if #ents2 > 3 then
				obstacle = true
			end
		end
		
		local local_passable = TheWorld.Map:IsPassableAtPoint(x3, 0, z3) and TheWorld.Map:IsPassableAtPoint(x5, 0, z5) and TheWorld.Map:IsPassableAtPoint(x6, 0, z6) and TheWorld.Map:IsPassableAtPoint(x7, 0, z7)
		
		if obstacle then
			if jumper.components.talker then
				jumper.components.talker:Say("I can't land there.")
			end
			jumper.sg:GoToState("idle")
		elseif not local_passable then
			if jumper.components.talker then
				jumper.components.talker:Say("I'm not a great swimmer.")
			end
			jumper.sg:GoToState("idle")
		end
	end
end

function Interactions:Hide(hider)
	if hider and hider:HasTag('player') and hider.components.hunger then
		hider.components.hunger:DoDelta(-hiding_cost)
	end
end

function Interactions:TakeRefuge(refugee)
	if self.inst.prefab and refugee and ((self.inst.prefab == "spiderden" and not refugee:HasTag('monster')) or ((self.inst.prefab == "pighouse" or self.inst.prefab == "rabbithouse") and refugee:HasTag("monster")) ) then
		if refugee.components.talker then
			refugee.components.talker:Say("They will kill me!")
		end
		refugee.AnimState:PlayAnimation("run_pst")
		refugee.sg:GoToState("idle")
		return
		
	elseif refugee and refugee:HasTag('player') then
		if refugee.components.hunger then
			refugee.components.hunger:DoDelta(-refuge_cost)
		end
		if refugee.components.health then
			refugee:DoTaskInTime(1 * FRAMES, function(refugee)
				refugee.components.health:SetInvincible(true)
			end)
			refugee:DoTaskInTime(13, function(refugee)
				refugee.components.health:SetInvincible(false)
			end)
		end
	end
end

function Interactions:Push(victim)
	if victim and self.inst:HasTag('player') and (victim.components.health and not victim.components.health:IsDead()) then
		local x1, y1, z1 = victim.Transform:GetWorldPosition()
		local x2, y2, z2 = self.inst.Transform:GetWorldPosition()
		local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
		local x3 = (x1 - x2)/dist *dist_push_player + x1
		local z3 = (z1 - z2)/dist *dist_push_player + z1
		
		if dist > 0 and not victim:HasTag('player') and not victim:HasTag('companion') then
			x3 = (x1 - x2)/dist *dist_push + x1
			z3 = (z1 - z2)/dist *dist_push + z1
		elseif dist <= 0 then
			return
		end
		
		if dist <= reach_dist then
			local ents = TheSim:FindEntities(x3, 0, z3,1,{"lava"})
			if victim.Physics ~= nil then
				victim.Physics:Teleport(x3, 0, z3)
			else
				victim.Transform:SetPosition(x3, 0, z3)
			end
			
			if victim.sg.sg.states.hit then
				victim.AnimState:PlayAnimation("hit")
				victim.AnimState:PlayAnimation("hit")
			end
			
			if not victim:HasTag('player') and victim.components.health and victim.components.combat then
				local basher = self.inst.components.combat
				local leader = self.inst.components.leader
				local melee_dmg = basher and basher.defaultdamage or Bash_dmg
				melee_dmg = melee_dmg * 0.7
				
				victim.components.health:DoDelta(-melee_dmg)
				victim.components.combat:SetTarget(self.inst)
				victim.components.combat:ShareTarget(self.inst, 15, function(dude)
					return dude.prefab and victim.prefab and dude.prefab == victim.prefab and not (dude.components.follower and dude.components.follower.leader == self.inst) end, 1)
				
				if leader and leader.followers then
				    for k,v in pairs(leader.followers) do
						if k.components.combat and k.components.follower and k.components.follower.canaccepttarget then
							k.components.combat:SuggestTarget(victim)
						end
					end
				end
			end
			
			if not victim:HasTag('player') and (not victim:IsOnValidGround() or ents[1] ~= nil) then
				victim:DoTaskInTime(0.07,function(victim) victim:Remove() end)
				if ents[1] ~= nil then --lava
					SpawnPrefab("explode_small").Transform:SetPosition(x3, 0, z3)
					SpawnPrefab("splash_ocean").Transform:SetPosition(x3, 0, z3)
					SpawnPrefab("goldnugget").Transform:SetPosition(x3, 0, z3)
				else
					SpawnPrefab("splash_ocean").Transform:SetPosition(x3, 0, z3)
				end
			end
			
			if victim:HasTag('player') then
				victim:DoTaskInTime(2,function(victim)
					if not victim:IsOnValidGround() then
						if victim.Physics ~= nil then
							victim.Physics:Teleport(x1, 0, z1)
						else
							victim.Transform:SetPosition(x1, 0, z1)
						end
					end
				end)
			end
		end
	end
end

function Interactions:Search(searcher)
	local islootdropper = self.inst.components.lootdropper
	local isworkable = self.inst.components.workable
	local isspawner = self.inst.components.spawner
	local searchable = islootdropper ~= nil and isworkable ~= nil
	
	if searchable and searcher and searcher:HasTag('player') then
		if self.inst.prefab and self.inst.prefab == "molehill" and searcher.components.hunger then
			searcher.components.hunger:DoDelta(-search_cost*loot_chance, nil, false)
		elseif searcher.components.sanity then
			searcher.components.sanity:DoDelta(-search_cost*loot_chance)
		end
		
		if math.random() < loot_chance then
			if isspawner and isspawner.child ~= nil then
				isspawner.child.needs_home_time = GetTime()
				if isspawner:IsOccupied() then
					isspawner:ReleaseChild()
				end
			end
			
			if self.inst.prefab and (self.inst.prefab == "skeleton" or self.inst.prefab == "skeleton_player") then
				islootdropper:SpawnLootPrefab("goldnugget")
			end
			isworkable:WorkedBy(searcher, 3)
			return
		elseif searcher.components.talker then
			searcher.components.talker:Say("I found nothing.")
		end
	else
		if searcher.components.talker then
			searcher.components.talker:Say("It's empty.")
		end
	end
end

return Interactions