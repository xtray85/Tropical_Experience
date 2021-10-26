require "stategraphs/SGcommonfish"

local MAX_CHASEAWAY_DIST = 25

local assets =
{
	Asset("ANIM", "anim/oceanfish_small_underwater.zip"),
	Asset("ANIM", "anim/oceanfish_small_1.zip"),
	Asset("ANIM", "anim/oceanfish_small_2.zip"),
	Asset("ANIM", "anim/oceanfish_small_3.zip"),
	Asset("ANIM", "anim/oceanfish_small_4.zip"),
	Asset("ANIM", "anim/oceanfish_small_5.zip"),
	Asset("ANIM", "anim/oceanfish_small_6.zip"),
	Asset("ANIM", "anim/oceanfish_small_7.zip"),
	Asset("ANIM", "anim/oceanfish_small_8.zip"),	
	Asset("ANIM", "anim/oceanfish_small_9.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_underwater1.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_underwater2.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_underwater3.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_underwater4.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_underwater5.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_underwater6.zip"),	
	Asset("ANIM", "anim/oceanfish_medium_underwater7.zip"),		
	Asset("ANIM", "anim/oceanfish_medium_underwater8.zip"),		
}

local prefabs =
{
	"fishmeat_small",
	"fishmeat",	
}

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 20, function(dude)
        return dude:HasTag("commonfish") and not dude.components.health:IsDead()
    end, 5)
end

local function KeepTarget(inst, target)
    local homePos = inst.components.knownlocations:GetLocation("herd")
    local targetPos = Vector3(target.Transform:GetWorldPosition() )
    return homePos and distsq(homePos, targetPos) < MAX_CHASEAWAY_DIST*MAX_CHASEAWAY_DIST
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
end
 
local function OnWorkedm1(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_1_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorkedm2(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_2_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorkedm3(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_3_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorkedm4(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_4_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorkedm5(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_5_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorkedm6(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_6_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorkedm7(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_7_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorkedm8(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_medium_8_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

 
local function OnWorked1(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_1_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked2(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_2_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked3(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_3_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked4(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_4_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked5(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_5_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked6(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_6_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked7(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_7_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked8(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_8_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked9(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_9_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 
 
 local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end
 
local function fnmedio1()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater1")
    anim:SetBuild("oceanfish_medium_underwater1")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm1)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)	

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

local function fnmedio2()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater1")
    anim:SetBuild("oceanfish_medium_underwater2")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm2)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)	

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

local function fnmedio3()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater1")
    anim:SetBuild("oceanfish_medium_underwater3")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm3)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)	

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

local function fnmedio4()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater1")
    anim:SetBuild("oceanfish_medium_underwater4")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm4)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)	

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

local function fnmedio5()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater2")
    anim:SetBuild("oceanfish_medium_underwater5")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm5)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

local function fnmedio6()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater1")
    anim:SetBuild("oceanfish_medium_underwater6")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm6)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fnmedio7()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater1")
    anim:SetBuild("oceanfish_medium_underwater7")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm7)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fnmedio8()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_medium_underwater2")
    anim:SetBuild("oceanfish_medium_underwater8")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("mediopodecomer")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorkedm8)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGcommonfish")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn1(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_1")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")		

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked1)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn2(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_2")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked2)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn3(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_3")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked3)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn4(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_4")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked4)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn5(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_5")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked5)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn6(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_6")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked6)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn7(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_7")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked7)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn8(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_8")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked8)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

local function fn9(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetFourFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("oceanfish_small_underwater")
    anim:SetBuild("oceanfish_small_9")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	inst:AddTag("naocome")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked9)	

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fishmeat_small"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
	
    inst:SetStateGraph("SGfishsmallunderwater")
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)			

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)	

    return inst
end

return Prefab( "oceanfish_small_underwater_1", fn1, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_2", fn2, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_3", fn3, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_4", fn4, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_5", fn5, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_6", fn6, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_7", fn7, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_8", fn8, assets, prefabs),
	   Prefab( "oceanfish_small_underwater_9", fn9, assets, prefabs),	   
	   Prefab( "oceanfish_medium_underwater_1", fnmedio1, assets, prefabs), 
	   Prefab( "oceanfish_medium_underwater_2", fnmedio2, assets, prefabs),  
	   Prefab( "oceanfish_medium_underwater_3", fnmedio3, assets, prefabs),  
	   Prefab( "oceanfish_medium_underwater_4", fnmedio4, assets, prefabs),  
	   Prefab( "oceanfish_medium_underwater_5", fnmedio5, assets, prefabs),  
	   Prefab( "oceanfish_medium_underwater_6", fnmedio6, assets, prefabs),  
	   Prefab( "oceanfish_medium_underwater_7", fnmedio7, assets, prefabs),
	   Prefab( "oceanfish_medium_underwater_8", fnmedio8, assets, prefabs)	   