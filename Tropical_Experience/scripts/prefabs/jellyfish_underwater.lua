local assets=
{
	Asset("ANIM", "anim/jellyfish.zip"),
	Asset("ANIM", "anim/jellyfishunderwater.zip"),
}

local prefabs=
{
	"jellyfish_dead",
}
local	    JELLYFISH_DAMAGE = 5
local 		JELLYFISH_HEALTH = 50
local       JELLYFISH_WALK_SPEED = 2


local function OnWorked(inst, worker)

if worker.components.inventory then
    if not worker.components.inventory:IsFull() then
        local toGive = SpawnPrefab("jellyfish")
        worker.components.inventory:GiveItem(toGive, nil, inst:GetPosition())		
        worker.SoundEmitter:PlaySound("dontstarve_DLC002/common/bugnet_inwater")
		inst:Remove()
    else
	local cai = worker.components.inventory.itemslots[1]
    if cai ~= nil then
	worker.components.inventory:DropItem(cai, true, true)	
	local toGive = SpawnPrefab("jellyfish")
    worker.components.inventory:GiveItem(toGive, nil, inst:GetPosition())		
    worker.SoundEmitter:PlaySound("dontstarve_DLC002/common/bugnet_inwater")
	inst:Remove()
	end
	end
	
	else
	local toGive = SpawnPrefab("jellyfish_dead")
	toGive.Transform:SetPosition(inst.Transform:GetWorldPosition())	
	inst:Remove()	
	end
 
end

local function onattacked(inst, data)
    if data and data.attacker.components.health then
--        if (data.weapon == nil or (not data.weapon:HasTag("projectile") and data.weapon.projectile == nil)) 
--        and (data.attacker ~= ThePlayer or (data.attacker == ThePlayer and not ThePlayer.components.inventory:IsInsulated())) then
            data.attacker.components.health:DoDelta(-JELLYFISH_DAMAGE)
            if data.attacker:HasTag("player") then
                data.attacker.sg:GoToState("electrocute")
            end
--        end
    end
end

local function ShouldSleep(inst)
 return false
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

local function fn2(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    local physics = inst.entity:AddPhysics()
    MakeCharacterPhysics(inst, 1, 0.5)
    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("jellyfishunderwater")
    inst.AnimState:SetBuild("jellyfish")  
    inst.AnimState:PlayAnimation("idle", true)
	
	inst.AnimState:OverrideSymbol("ripple2", "jellyfish", "")
	inst.AnimState:OverrideSymbol("ripple3_back", "jellyfish", "")	
	inst.AnimState:OverrideSymbol("tenticle", "jellyfishunderwater"	, "tenticle")	

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .5 )

    inst:AddTag("aquatic")	
	inst:AddTag("jellyfishrede")
	inst:AddTag("tropicalspawner")
	inst:AddTag("rainbowjellyfish")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = JELLYFISH_WALK_SPEED 

    inst:AddComponent("combat")
    inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/jellyfish/hit")
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(JELLYFISH_HEALTH)

    MakeMediumFreezableCharacter(inst, "jelly")
	inst:AddComponent("lootdropper")
    inst:ListenForEvent("attacked", onattacked)

    inst.components.lootdropper:SetLoot({"jellyfish_dead"}) 

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.NET)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(OnWorked)
		
	inst:SetStateGraph("SGjellyfishunderwater")
	local brain = require "brains/jellyfishbrainunderwater"
    inst:SetBrain(brain)		
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		
	
    return inst
end

return  Prefab( "common/inventory/jellyfish_underwater", fn2, assets, prefabs)
