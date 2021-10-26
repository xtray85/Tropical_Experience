require "stategraphs/SGfishunderwater"
require "stategraphs/SGcommonfish"

local MAX_CHASEAWAY_DIST = 25

local assets =
{
	Asset("ANIM", "anim/fish2.zip"),
	Asset("ANIM", "anim/fish3.zip"),	
	Asset("ANIM", "anim/fish4.zip"),	
	Asset("ANIM", "anim/fish5.zip"),
	Asset("ANIM", "anim/fish5.zip"),	
	Asset("ANIM", "anim/fish6.zip"),	
	Asset("ANIM", "anim/fish7.zip"),		
	Asset("ANIM", "anim/quagmire_salmon.zip"),
	Asset("ANIM", "anim/fish2underwater.zip"),
	Asset("ANIM", "anim/fish3underwater.zip"),	
	Asset("ANIM", "anim/fish4underwater.zip"),	
	Asset("ANIM", "anim/fish5underwater.zip"),
	Asset("ANIM", "anim/mecfish.zip"),
	Asset("ANIM", "anim/underwater_goldfish.zip"),
	Asset("ANIM", "anim/quagmire_salmonunderwater.zip"),	
	
}

local prefabs =
{
	"fish2",
	"fish3",
	"fish4",
	"fish5",	
	"fish6",	
	"fish7",	
	"goldnugget",
	"gears",
	"salmom",	
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
 
local function OnWorked2(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_61_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked3(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_71_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked4(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_81_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked5(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_91_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked6(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_11_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked7(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_13_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked8(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_14_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end 

local function OnWorked9(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_18_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end

local function OnWorked10(inst, worker)
    if worker.components.inventory ~= nil then
	local item = SpawnPrefab("oceanfish_small_17_inv") 
        worker.components.inventory:GiveItem(item, nil, inst:GetPosition())
    end
	inst:Remove()
end
 
local function fn2(Sim)
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
    
    anim:SetBank("fish2underwater")
    anim:SetBuild("fish2")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fish2"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked2)	
	
    inst:SetStateGraph("SGfishunderwater")	
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
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("fish3underwater")
    anim:SetBuild("fish3")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fish3"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked3)	
	
    inst:SetStateGraph("SGfishunderwater")	
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
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("fish4underwater")
    anim:SetBuild("fish4")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fish4"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked4)	
	
    inst:SetStateGraph("SGfishunderwater")	
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
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("fish5underwater")
    anim:SetBuild("fish5")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fish5"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked5)	
	
    inst:SetStateGraph("SGfishunderwater")	
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
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("quagmire_salmonunderwater")
    anim:SetBuild("quagmire_salmon")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }

    inst:AddComponent("inspectable")
	
	inst:AddComponent("combat")
    inst.components.combat.defaultdamage = 8
    inst:ListenForEvent("attacked", OnAttacked)
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(120)
	inst.components.health.nofadeout = true
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"salmon"})
	
	inst:AddComponent("knownlocations")
	
	inst:AddComponent("herdmember")
    inst.components.herdmember.herdprefab = "salmomfishschool"
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked6)	
	
    inst:SetStateGraph("SGcommonfish")	
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
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("fish3underwater")
    anim:SetBuild("mecfish")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"gears"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked7)	
	
    inst:SetStateGraph("SGfishunderwater")	
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
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("fish3underwater")
    anim:SetBuild("underwater_goldfish")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"goldnugget"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked8)	
	
    inst:SetStateGraph("SGfishunderwater")	
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
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1, .5 )
	
	inst.Transform:SetScale(1,1,1)
    
    anim:SetBank("fish4underwater")
    anim:SetBuild("fish6")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fish6"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked9)	
	
    inst:SetStateGraph("SGfishunderwater")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)	

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

local function fn10(Sim)
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
    
    anim:SetBank("fish4underwater")
    anim:SetBuild("fish7")
    
	inst:AddTag("prey")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.6667
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED*1.3333

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(UW_TUNING.SEA_EEL_HEALTH)

	inst:AddComponent("combat")
--	inst.components.combat:SetRange(3.5)
--	inst.components.combat:SetAttackPeriod(UW_TUNING.SEA_EEL_ATTACK_PERIOD)
--	inst.components.combat:SetDefaultDamage(UW_TUNING.SEA_EEL_DAMAGE)
--    inst.components.combat:SetRetargetFunction(3, Retarget)
--	inst.components.combat:SetKeepTargetFunction(KeepTarget)
    
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"fish7"})
	
	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.NET)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(OnWorked10)	
	
    inst:SetStateGraph("SGfishunderwater")	
    local brain = require "brains/commonfishbrain"
    inst:SetBrain(brain)	

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

return Prefab( "fish2_alive", fn2, assets, prefabs),
	   Prefab( "fish3_alive", fn3, assets, prefabs),
	   Prefab( "fish4_alive", fn4, assets, prefabs),
	   Prefab( "fish5_alive", fn5, assets, prefabs),
	   Prefab( "quagmire_salmom_alive", fn6, assets, prefabs),
	   Prefab( "mecfish_alive", fn7, assets, prefabs),
	   Prefab( "goldfish_alive", fn8, assets, prefabs),
	   Prefab( "fish6_alive", fn9, assets, prefabs),
	   Prefab( "fish7_alive", fn10, assets, prefabs)