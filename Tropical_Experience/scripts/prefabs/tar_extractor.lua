require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/tar_extractor.zip"),
	--Asset("MINIMAP_IMAGE", "tar_extractor"),
	Asset("ANIM", "anim/tar_extractor_meter.zip"),	
}

local prefabs=
{
	"tar",
}

local SEG_TIME = 30
local TOTAL_DAY_TIME = SEG_TIME*16
local TAR_EXTRACTOR_MAX_FUEL_TIME = TOTAL_DAY_TIME*2
local TAR_TRAP_TIME = SEG_TIME
local RESOURSE_TIME = SEG_TIME*4
local POOP_ANIMATION_LENGTH = 70

local function spawnTarProp(inst)
	inst.task_spawn = nil
	local tar = SpawnPrefab("tar")

 	local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0,4.5,0)

	local right = TheCamera:GetRightVec()
	local offset = 1.3
	local variation = 0.2
	tar.Transform:SetPosition(pt.x + (right.x*offset) +(math.random()*variation),0, pt.z + (right.z*offset)+(math.random()*variation) )

	tar.AnimState:PlayAnimation("drop") 
	tar.AnimState:PushAnimation("idle_water",true)	
	--inst:RemoveEventCallback("animover", spawnTarProp )
	if inst.components.machine:IsOn() and not inst.components.fueled:IsEmpty() then
		inst.startTar(inst)
		inst.AnimState:PlayAnimation("active",true)
	else
		inst.AnimState:PlayAnimation("idle", true)
	end
end

local function makeTar(inst)	
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/tar_extractor/poop")
	inst.AnimState:PlayAnimation("poop")	
	inst.task_spawn = inst:DoTaskInTime(POOP_ANIMATION_LENGTH/30,spawnTarProp)
	inst.task_spawn_time = GetTime()
	inst.task_tar = nil
--	inst:ListenForEvent("animover", spawnTarProp )
end

local function startTar(inst)
	inst.task_tar = inst:DoTaskInTime(RESOURSE_TIME, makeTar )
	inst.task_tar_time = GetTime()
end

local function onBuilt(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/tar_extractor/craft")
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/splash_large")
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle",true)	

	local range = 1
	local pt = Vector3(inst.Transform:GetWorldPosition())
	local tarpits = TheSim:FindEntities(pt.x, pt.y, pt.z, range, {"tar source"}, nil)
	for i,tarpit in ipairs(tarpits)do
		if tarpit.components.inspectable then
			tarpit.components.inspectable.inspectdisabled = true			
		end		
	end
end

local function placeTestFn(inst, pt)
	local range = 1
	local canbuild = false
	
	local tarpits = TheSim:FindEntities(pt.x, pt.y, pt.z, range, {"tar source"}, nil)

	if #tarpits > 0 then
		local pt2 = Vector3(tarpits[1].Transform:GetWorldPosition())
		local structures = TheSim:FindEntities(pt2.x, pt2.y, pt2.z, range, {"structure"}, nil)
		if #structures == 0 then
			if inst.parent then
				inst.parent:RemoveChild(inst)
			end
			canbuild = true
			inst.Transform:SetPosition(tarpits[1].Transform:GetWorldPosition())			
		end
	end
	return canbuild
end

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")

	inst:Remove()
end


local function onRemove(inst, worker)
	local range = 1
	local pt = Vector3(inst.Transform:GetWorldPosition())
	local tarpits = TheSim:FindEntities(pt.x, pt.y, pt.z, range, {"tar source"}, nil)
	for i,tarpit in ipairs(tarpits)do
		if tarpit.components.inspectable and tarpit.components.inspectable.inspectdisabled == true then
			tarpit.components.inspectable.inspectdisabled = false			
		end		
	end
end


local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")
		if inst.components.machine:IsOn() then 
			inst.AnimState:PushAnimation("active",true)
		else
			inst.AnimState:PushAnimation("idle", true)
		end
	end
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end 

    local nowTime = GetTime()     

    if inst.task_tar then
		data.task_tar_time = RESOURSE_TIME - (nowTime - inst.task_tar_time)
    end
	if inst.task_spawn then
		data.task_spawn_time = (POOP_ANIMATION_LENGTH/30) - (nowTime - inst.task_spawn_time)
    end    
end

local function onload(inst, data)
	if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end

    inst:DoTaskInTime(0, function()
	    if data.task_tar_time then
	    	if inst.task_tar then
	    		inst.task_tar:Cancel()
	    		inst.task_tar = nil
	    	end
			inst.task_tar = inst:DoTaskInTime(data.task_tar_time, makeTar )
			inst.task_tar_time = GetTime()    	
	    end
	    if data.task_spawn_time then
	    	if inst.task_spawn then
	    		inst.task_spawn:Cancel()
	    		inst.task_spawn = nil
	    	end
	    	inst.task_spawn = inst:DoTaskInTime(data.task_spawn_time,spawnTarProp)
			inst.task_spawn_time = GetTime()
	    end
	end)
end 

local function OnFuelEmpty(inst)
	print("OnFuelEmpty")
	inst.components.machine:TurnOff()
end

local function TurnOff(inst)
	inst.on = false
	if inst.task_tar then
		inst.task_tar:Cancel()
		inst.task_tar = nil
	end
	inst.components.fueled:StopConsuming()
	inst.AnimState:PlayAnimation("idle")
	inst.SoundEmitter:KillSound("suck")  
end

local function TurnOn(inst, instant)
	inst.on = true
	local randomizedStartTime = POPULATING
	inst.startTar(inst)
	inst.components.fueled:StartConsuming()
	inst.AnimState:PlayAnimation("active",true)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/tar_extractor/active_LP", "suck")  
end

local function CanInteract(inst)	
	return  not inst.components.fueled:IsEmpty()
end


local function OnFuelSectionChange(old, new, inst)
local fuelAnim = 0
if inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.01 then fuelAnim = "0"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.1 then fuelAnim = "1"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.2 then fuelAnim = "2"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.3 then fuelAnim = "3" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.4 then fuelAnim = "4" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.5 then fuelAnim = "5" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.6 then fuelAnim = "6" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.7 then fuelAnim = "7" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.8 then fuelAnim = "8" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.9 then fuelAnim = "9" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 1 then fuelAnim = "10" end 
if inst then inst.AnimState:OverrideSymbol("swap_meter", "tar_extractor_meter", fuelAnim) end
end

local function ontakefuelfn(inst)
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/machine_fuel")
local fuelAnim = 0
if inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.01 then fuelAnim = "0"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.1 then fuelAnim = "1"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.2 then fuelAnim = "2"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.3 then fuelAnim = "3" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.4 then fuelAnim = "4" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.5 then fuelAnim = "5" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.6 then fuelAnim = "6" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.7 then fuelAnim = "7" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.8 then fuelAnim = "8" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.9 then fuelAnim = "9" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 1 then fuelAnim = "10" end 
if inst then inst.AnimState:OverrideSymbol("swap_meter", "tar_extractor_meter", fuelAnim) end
end

local function getstatus(inst, viewer)
	if inst.on then
		if inst.components.fueled and (inst.components.fueled.currentfuel / inst.components.fueled.maxfuel) <= .25 then
			return "LOWFUEL"
		else
			return "ON"
		end
	else
		return "OFF"
	end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

	MakeWaterObstaclePhysics(inst, 0.4, 2, 1.25)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetPriority( 5 )
	minimap:SetIcon( "tar_extractor.png" )
    
	anim:SetBank("tar_extractor")
	anim:SetBuild("tar_extractor")
	anim:PlayAnimation("idle",true)
--	inst.AnimState:OverrideSymbol("swap_meter", "tar_extractor_meter", 10)
	inst:AddTag("structure")
	inst:AddTag("tar_extractor")
	inst:AddTag("ignorewalkableplatforms")	

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end
   
	inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)		
	MakeSnowCovered(inst, .01)


	inst:AddComponent("machine")
	inst.components.machine.turnonfn = TurnOn
	inst.components.machine.turnofffn = TurnOff
	inst.components.machine.caninteractfn = CanInteract
	inst.components.machine.cooldowntime = 0.5

	inst:AddComponent("fueled")
	inst.components.fueled:SetDepletedFn(OnFuelEmpty)
	inst.components.fueled.accepting = true
	inst.components.fueled:SetSections(10)
	inst.components.fueled.ontakefuelfn = ontakefuelfn
	inst.components.fueled:SetSectionCallback(OnFuelSectionChange)
	inst.components.fueled:InitializeFuelLevel(TAR_EXTRACTOR_MAX_FUEL_TIME)
	inst.components.fueled.bonusmult = 5
	inst.components.fueled.secondaryfueltype = "CHEMICAL"

	--MakeLargeBurnable(inst, nil, nil, true)
	--MakeLargePropagator(inst)
	inst.OnSave = onsave 
    inst.OnLoad = onload
	
	inst:ListenForEvent( "onbuilt", function()
		onBuilt(inst)
	end)

	inst.startTar = startTar
	inst.OnRemoveEntity = onRemove
	inst:DoTaskInTime(0,OnFuelSectionChange)
	return inst
end

return Prefab( "tar_extractor", fn, assets, prefabs ),
	   MakePlacer( "tar_extractor_placer", "tar_extractor", "tar_extractor", "idle", nil, nil, nil, nil, nil, nil, nil, nil, nil, placeTestFn)
