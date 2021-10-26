local assets=
{
	Asset("ANIM", "anim/rainbowjellyfish.zip"),
	Asset("ANIM", "anim/rainbowjellyfishunderwater.zip"),
}

local prefabs=
{
	"rainbowjellyfish_dead",
}

local INTENSITY = 0.65
local RAINBOWJELLYFISH_WALKSPEED = 3
local JELLYFISH_WALK_SPEED = 2
local JELLYFISH_DAMAGE = 5
local JELLYFISH_HEALTH = 50

local function swapColor(inst, light)
	if inst.ispink then
--		inst.ispink = false
--		inst.isgreen = true
--		inst.components.lighttweener:StartTween(light, nil, nil, nil, {0/255, 180/255, 255/255}, 4, swapColor)
	elseif inst.isgreen then
--		inst.isgreen = false
--		inst.components.lighttweener:StartTween(light, nil, nil, nil, {240/255, 230/255, 100/255}, 4, swapColor)
	else
--		inst.ispink = true
--		inst.components.lighttweener:StartTween(light, nil, nil, nil, {251/255, 30/255, 30/255}, 4, swapColor)
	end
end

local function turnon(inst)
	
	if inst.Light and not inst.hidden then	
		inst.Light:Enable(true)
		local secs = 1+math.random()
--		inst.components.lighttweener:StartTween(inst.Light, 0, nil, nil, nil, 0)
--		inst.components.lighttweener:StartTween(inst.Light, INTENSITY, nil, nil, nil, secs, swapColor)		
	end
end


local function turnoff(inst)
	if inst.Light then
		inst.Light:Enable(false)
		-- clear out the callback or we'll keep looping
--		inst.components.lighttweener.callback = nil
--		inst.components.lighttweener:EndTween()
	end
end


local function fadein(inst)
	inst.hidden = false
	inst.AnimState:PlayAnimation("idle")
	inst:Show()
	inst:RemoveTag("NOCLICK")	
end

local function fadeout(inst)	
	inst.hidden = true
	inst:AddTag("NOCLICK")
	inst:Hide()
end


local function onwake(inst)
	if not TheWorld.state.isday then
		fadein(inst)
		turnon(inst)		
	else
		turnoff(inst)
	end
end

local function onsleep(inst)
	if TheWorld.state.isday then
		fadeout(inst)
		turnoff(inst)
	else
		turnoff(inst)
	end
end


local function OnWorked(inst, worker)

if worker.components.inventory then
    if not worker.components.inventory:IsFull() then
        local toGive = SpawnPrefab("rainbowjellyfish")
        worker.components.inventory:GiveItem(toGive, nil, inst:GetPosition())		
        worker.SoundEmitter:PlaySound("dontstarve_DLC002/common/bugnet_inwater")
		inst:Remove()
    else
	local cai = worker.components.inventory.itemslots[1]
    if cai ~= nil then
	worker.components.inventory:DropItem(cai, true, true)	
	local toGive = SpawnPrefab("rainbowjellyfish")
    worker.components.inventory:GiveItem(toGive, nil, inst:GetPosition())		
    worker.SoundEmitter:PlaySound("dontstarve_DLC002/common/bugnet_inwater")
	inst:Remove()
	end
	end
	
	else
	local toGive = SpawnPrefab("rainbowjellyfish_dead")
	toGive.Transform:SetPosition(inst.Transform:GetWorldPosition())	
	inst:Remove()	
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
	inst.no_wet_prefix = true	

    inst:AddTag("aquatic")
	inst:AddTag("rainbowjellyfish")
	inst.entity:AddTransform()
	inst.Transform:SetScale(0.8, 0.8, 0.8)
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeCharacterPhysics(inst, 1, 0.5)
    inst.Transform:SetFourFaced()
 	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .5 )	

    inst.AnimState:SetBank("rainbowjellyfishunderwater")
    inst.AnimState:SetBuild("rainbowjellyfish")
    inst.AnimState:PlayAnimation("idle", true)
	
	inst.AnimState:OverrideSymbol("ripple2", "rainbowjellyfish", "")
	inst.AnimState:OverrideSymbol("ripple3_back", "rainbowjellyfish", "")		

	inst:AddTag("rainbowjellyfishrede")
	inst:AddTag("tropicalspawner")
	
	inst.entity:SetPristine()
	
	inst.entity:AddLight()
	inst.Light:Enable(true)
	inst.Light:SetIntensity(.65)
	inst.Light:SetColour(251/255, 30/255, 30/255)
	inst.Light:SetFalloff( 0.45 )
	inst.Light:SetRadius( 1.5)
	
    if not TheWorld.ismastersim then
        return inst
    end		
	
	-- locomotor must be constructed before the stategraph
    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = RAINBOWJELLYFISH_WALKSPEED

    inst:SetStateGraph("SGrainbowjellyfishunderwater")

    inst:AddComponent("combat")
    inst.components.combat:SetHurtSound("dontstarve_DLC002/creatures/jellyfish/hit")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(JELLYFISH_HEALTH)

    MakeMediumFreezableCharacter(inst, "jelly")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"rainbowjellyfish_dead"})

    inst:AddComponent("inspectable")
    inst:AddComponent("knownlocations")
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetSleepTest(ShouldSleep)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.NET)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(OnWorked)

	inst:AddComponent("fader")

	local brain = require "brains/rainbowjellyfishbrainunderwater"
    inst:SetBrain(brain)

	inst.ispink = true
--	inst.components.lighttweener:StartTween(light, nil, nil, nil, {0/255, 180/255, 255/255}, 4, swapColor)

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 480)	

    return inst
end

return Prefab( "common/inventory/rainbowjellyfish_underwater", fn2, assets, prefabs)
