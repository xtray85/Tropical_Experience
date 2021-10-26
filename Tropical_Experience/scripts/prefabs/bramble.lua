local assets=
{
	Asset("ANIM", "anim/bramble.zip"),
	Asset("ANIM", "anim/bramble1_build.zip"),
	Asset("ANIM","anim/bramble_core.zip"),
}

local prefabs =
{
	"bramble_bulb",
}

SetSharedLootTable( 'bramble',
{
    {'bramble_bulb',    1.00},
    {'vine',            1.00},
    {'vine',            1.00},
    {'vine',            0.25},
    {'vine',            0.25}, 
})

local BRAMBLE_THORN_DAMAGE = 3

local function managerotdist(inst,rotdist)

	if math.random()<0.4 then
		rotdist = rotdist -1
	end

	if inst.rotdistance < rotdist then
		inst.rotdistance = rotdist
	end

	if inst.rotdistance > 0 then
		inst:DoTaskInTime(0.2,function(inst)   --0.5
				inst.natrualdecay= true 
--				inst.components.health:SetVal(0)
			end)
	end
end

local function OnDeath(inst)
	inst.AnimState:PlayAnimation("wither")
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/bramble/wilther")
--[[
	RemovePhysicsColliders(inst)
	if not inst.natrualdecay then
		inst.rotdistance = 3 -- sets a min of 3. But can go much further due to the 30% chance to recude the rot number.
	end
	if inst.core then
		inst.core.sustainablehedges = inst.core.sustainablehedges + 1
	end
	if inst.childhedge then
		for i,child in ipairs(inst.childhedge) do
			child.OnParentDeath(child, inst.rotdistance)
		end
	end
	if inst.parenthedge then
		inst.parenthedge.OnChildDeath(inst.parenthedge, inst.rotdistance)
	end
	]]
	local jogador = GetClosestInstWithTag("player", inst, 20)
	if jogador and inst.components.lootdropper then
		inst.components.lootdropper:DropLoot()
	end	
end

local function OnParentDeath(inst, rotdist)
	managerotdist(inst,rotdist)
end

local function OnChildDeath(inst, rotdist)
	managerotdist(inst,rotdist)	
end

local function testlocation(inst, pt)
	local testTile = TheWorld.Map:GetTileAtPoint(pt.x , pt.y, pt.z) 
		
	if testTile == GROUND.OCEAN_SWELL or testTile == GROUND.OCEAN_WATERLOG or testTile == GROUND.OCEAN_BRINEPOOL or testTile == GROUND.OCEAN_BRINEPOOL_SHORE or testTile == GROUND.OCEAN_HAZARDOUS or testTile == GROUND.OCEAN_ROUGH or testTile == GROUND.IMPASSABLE or testTile == GROUND.OCEAN_COASTAL_SHORE or testTile == GROUND.OCEAN_COASTAL then
		return false
	end	

	local result = true
	local ents = TheSim:FindEntities(pt.x,pt.y,pt.z,1,{"blocker"})	
	local brambleblocked = false
	for i,ent in ipairs(ents)do
		if ent:HasTag("bramble") then
			brambleblocked = true
		end
	end
	if #ents > 0 then
		result = false
	end
	return result, brambleblocked
end

local function spawnhedge(inst,pt,rotation)
	local newhedge = SpawnPrefab("bramblespike")
	newhedge.Transform:SetPosition(pt.x,pt.y,pt.z)
	newhedge.Transform:SetRotation(rotation)
	newhedge.parenthedge = inst

	newhedge.coredistance = inst.coredistance + 1
	if not inst.childhedge then
		inst.childhedge = {}
	end
	table.insert(inst.childhedge,newhedge)
	newhedge.core = inst.core
	inst.core.sustainablehedges = inst.core.sustainablehedges -1
	return newhedge
end

local function testforspawning(inst,angle)

	local pt = inst:GetPosition()
	local dist = 1.5
	pt.x = pt.x + dist*math.cos(angle)
	pt.z = pt.z + dist*math.sin(angle)
		
	local deviation = 0

	local newhedge = nil
	local flip = true
	while deviation < PI/1.5 and not newhedge do		
		local test, brambleblocked = testlocation(inst,pt)
		if test then
			local deflection = .6
			local rotation = angle +  deflection - (math.random()*deflection*2)
			newhedge = spawnhedge(inst,pt,rotation)
		elseif brambleblocked then 
			-- if bramble blocked.. end.
			deviation = PI/1.5
		else
			deviation = deviation * -1							
			if flip then
				flip = false
				if deviation < 0 then
					deviation = deviation - PI/10
				else
					deviation = deviation + PI/10
				end
			else
				flip = true
			end					
			pt = inst:GetPosition()
			angle = inst.Transform:GetRotation() + deviation
			dist = 1.5
			pt.x = pt.x + dist*math.cos(angle)
			pt.z = pt.z + dist*math.sin(angle)
		end
	end	
end

local function propegateHedge(inst)	
	if TheWorld.state.issummer then

		inst.hedgepropegated = true
		if inst.core then
			if inst.core.sustainablehedges > 0 then
				--if inst.growthpotential%11 == 0 then
				if inst.coredistance%20 == 0 then --11
					testforspawning(inst,inst.Transform:GetRotation()+ (PI/3))
					testforspawning(inst,inst.Transform:GetRotation()- (PI/3))
				else
					testforspawning(inst,inst.Transform:GetRotation())
				end
			else
				inst:DoTaskInTime(5,function() inst.propegateHedge(inst) end)
			end
		end
	end
end

local function killhedge(inst)
	inst.components.health:Kill()
	inst:DoTaskInTime(3,function() 
			if not TheWorld.state.issummer then
	    		inst:Remove()
			end 
		end)
end

local function testForDeath(inst)
	if not TheWorld.state.issummer then
--		if not inst.taskkill then 		
--			inst.taskkill, inst.taskkillinfo = inst:ResumeTask( math.random()* TUNING.TOTAL_DAY_TIME*2,function()
		        killhedge(inst)
--		    end)
--		end
	end
end

local function OnSave(inst, data)
    if inst.taskkillinfo then
        data.taskkill = inst:TimeRemainingInTask(inst.taskkillinfo)
    end
    data.rotdistance = inst.rotdistance

    if inst.coredistance then
		data.coredistance = inst.coredistance	
	end

	if inst.hedgepropegated then
		data.hedgepropegated = inst.hedgepropegated	
	end	

	data.children = {}
    if inst.core then
    	table.insert(data.children,inst.core.GUID)
    	data.core = #data.children
    end
    
    if inst.parenthedge then
    	table.insert(data.children,inst.parenthedge.GUID)
    	data.parenthedge = #data.children
    end
   
    if inst.childhedge then    	
    	for i, child in ipairs(inst.childhedge)do
    		table.insert(data.children,child.GUID)
    	end
    end

    if data.children and #data.children > 0 then
        return data.children
    end  
end

local function OnLoad(inst, data)
    if data and data.taskkill then
        if inst.taskkill then inst.taskkill:Cancel() inst.taskkill = nil end
        inst.taskkillinfo = nil
        inst.taskkill, inst.taskkillinfo = inst:ResumeTask(data.taskkill, function() killhedge(inst)  end)
    end  
    if data and data.rotdistance then
    	inst.rotdistance = data.rotdistance
    end
    if data and data.coredistance then
		inst.coredistance = data.coredistance	
	end  
	if data.hedgepropegated then
		inst.hedgepropegated = data.hedgepropegated	
	end		  
end

local function onloadpostpass(inst, ents, data)       
    if data and data.children then

    	for i,v in ipairs(data.children) do	 
    	 	if ents[v] then
		        local hedge = ents[v].entity
		        if hedge then
		        	if i == data.core then
		        		inst.core = hedge
		        	elseif i == data.parenthedge then
		            	inst.parenthedge = hedge
		            else
		            	if not inst.childhedge then
		            		inst.childhedge = {}
		            	end
		            	table.insert(inst.childhedge,hedge)
		        	end
		        end
	    	end
    	end
	end  
end  

local function hedgefn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeObstaclePhysics(inst, .5)   

    anim:SetBank("bramble_"..math.random(1,3))
    anim:SetBuild("bramble1_build")
    anim:PlayAnimation("grow")
--[[    
    inst:DoTaskInTime(7/30, function()
                if inst.AnimState:IsCurrentAnimation("grow") then
                   inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/bramble/grow")
               end
           end )
    inst:DoTaskInTime(14/30, function()
                if inst.AnimState:IsCurrentAnimation("grow") then
                   inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/bramble/grow")
               end
           end )
    inst:DoTaskInTime(21/30, function()
                if inst.AnimState:IsCurrentAnimation("grow") then
                   inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/bramble/grow")
               end
           end )
    inst:DoTaskInTime(28/30, function()
                if inst.AnimState:IsCurrentAnimation("grow") then
                   inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/bramble/grow")
               end
           end )
]]		   
    anim:PushAnimation("idle")

    local rotation = math.random()*360
    inst.Transform:SetRotation(rotation)

	inst.Transform:SetTwoFaced()

	inst:AddTag("hostile")
	inst:AddTag("bramble")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "hedge_segment"

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(40)

    inst:AddComponent("lootdropper")
    
    inst:AddComponent("inspectable")
    

    inst:ListenForEvent("attacked", function(owner, data) 
    		inst.AnimState:PlayAnimation("hit",false)
    		if inst.components.health:IsDead() then
				inst.AnimState:PushAnimation("wither",false)
				inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/bramble/attack")	
			else
				inst.AnimState:PushAnimation("idle",false)	
			end

			if (data.weapon == nil or (not data.weapon:HasTag("projectile") and data.weapon.projectile == nil))
				and data.attacker and data.attacker.components.combat and data.stimuli ~= "thorns" and not data.attacker:HasTag("thorny")
				and (data.attacker.components.combat == nil or (data.attacker.components.combat.defaultdamage > 0)) then
				
				data.attacker.components.combat:GetAttacked(owner, BRAMBLE_THORN_DAMAGE, nil, "thorns")
				owner.SoundEmitter:PlaySound("dontstarve_DLC002/common/armour/cactus")
			end
		end)

    inst:DoTaskInTime((math.random()*0.5)+0.3,function() if not inst.hedgepropegated then propegateHedge(inst) end end)  --  2

    inst:ListenForEvent("death", OnDeath)

    inst.OnParentDeath = OnParentDeath
    inst.OnChildDeath = OnChildDeath
    inst.propegateHedge = propegateHedge

    inst:DoTaskInTime(0,function() testForDeath(inst)end)

--    inst:ListenForEvent("seasontick", function(it, data) testForDeath(inst) end, TheWorld)    
	inst:WatchWorldState("startday", testForDeath)	
	
	
	
    inst.rotdistance = 0
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    inst.OnLoadPostPass = onloadpostpass

    return inst
end

local function acabou(inst)
--if not TheWorld.state.issummer then	inst:Remove() end
inst:Remove()
end

local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()

	inst.sustainablehedges = 20

	inst:DoTaskInTime(0,function()
			
			local pt = inst:GetPosition()
			local angle = 0
			for i=1,4 do
				local newhedge = SpawnPrefab("bramblespike")
				local dist = 2
				local pt2 = {}
				pt2.x = pt.x + dist*math.cos(angle)
				pt2.z = pt.z + dist*math.sin(angle)
				pt2.y = 0
				newhedge.Transform:SetRotation(angle)
				newhedge.Transform:SetPosition(pt2.x,pt2.y,pt2.z)
				angle = angle + PI/2				
				newhedge.coredistance = 0
				newhedge.core = inst
			end
			
			local core = SpawnPrefab("bramble_core")
			core.Transform:SetPosition(pt.x,pt.y,pt.z)
			core.AnimState:PlayAnimation("grow")
			core.AnimState:PushAnimation("idle")			

			local newhedge = SpawnPrefab("bramblespike")
			newhedge.Transform:SetPosition(pt.x,pt.y,pt.z)
			newhedge.coredistance = 0
			newhedge.core = inst
		inst:DoTaskInTime(3, acabou(inst))
		end)

			
--	inst:WatchWorldState("startday", acabou)    

    return inst
end
--[[
local function sitefn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    inst.entity:AddNetwork()	

	local bm = TheWorld.components.bramblemanager
	inst:DoTaskInTime(0,function() bm:RegisterBramble(inst) end)

	return inst
end
]]

local function corefn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()

	MakeObstaclePhysics(inst, .5)   

    anim:SetBank("bramble_core")
    anim:SetBuild("bramble_core")
    anim:PlayAnimation("idle", true)
    
	inst:AddTag("hostile")
	inst:AddTag("bramble")
	inst:AddTag("bramble_core")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	

    inst:AddComponent("combat")
--    inst.components.combat.hiteffectsymbol = "stalk01"
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(200)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('bramble')    
    
    inst:AddComponent("inspectable")
    
    inst:ListenForEvent("attacked", function(owner, data) 
    		inst.AnimState:PlayAnimation("hit",false)
    		if inst.components.health:IsDead() then
				inst.AnimState:PushAnimation("wither",false)
				inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/bramble/attack")	
			else
				inst.AnimState:PushAnimation("idle",false)	
			end

			if (data.weapon == nil or (not data.weapon:HasTag("projectile") and data.weapon.projectile == nil))
				and data.attacker and data.attacker.components.combat and data.stimuli ~= "thorns" and not data.attacker:HasTag("thorny")
				and (data.attacker.components.combat == nil or (data.attacker.components.combat.defaultdamage > 0)) then
				
				data.attacker.components.combat:GetAttacked(owner, BRAMBLE_THORN_DAMAGE, nil, "thorns")
				owner.SoundEmitter:PlaySound("dontstarve_DLC002/common/armour/cactus")
			end
		end) 
       
    inst:ListenForEvent("death", OnDeath)

    --inst.OnParentDeath = OnParentDeath
    --inst.OnChildDeath = OnChildDeath
    --inst.propegateHedge = propegateHedge

    inst:DoTaskInTime(0,function() testForDeath(inst)end)  
	inst:WatchWorldState("startday", testForDeath)	 
    inst.rotdistance = 0
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    inst.OnLoadPostPass = onloadpostpass

    return inst
end

return 	Prefab("bramblespike", hedgefn, assets, prefabs),
		Prefab("bramble", fn, assets, prefabs),
		Prefab("bramble_core", corefn, assets, prefabs)
--		Prefab("bramblesite", sitefn, assets, prefabs) 
