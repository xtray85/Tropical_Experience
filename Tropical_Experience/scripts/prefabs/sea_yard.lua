require "prefabutil"

local assets = 
{
	Asset("ANIM", "anim/sea_yard.zip"),
	Asset("MINIMAP_IMAGE", "sea_yard"),	
	Asset("ANIM", "anim/sea_yard_meter.zip"),	
}

local prefabs =
{
	"collapse_small",
	"sea_yard_arms_fx"
}

local SEA_YARD_MAX_FUEL_TIME = 30*6

local function onturnon(inst)
	if not inst:HasTag("burnt") then
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seagull/chirp_seagull")
		inst:DoTaskInTime(18/30,function() inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seagull/chirp_seagull") end)
		inst.AnimState:PlayAnimation("enter")
		inst.AnimState:PushAnimation("idle", true)
	end
end

local function onturnoff(inst)
	if not inst:HasTag("burnt") then
	    inst.AnimState:PushAnimation("idle", true)
		--inst.SoundEmitter:KillSound("idlesound")
	end
end

local function startTimer(inst, user)
local user = GetClosestInstWithTag("player", inst, 5)
if not user then return end
	inst.task_fix = inst:DoTaskInTime(1,function() 
		if user.armsfx then
			inst.fixfn(inst, user) 
		end
	end)
end

local function startFixingFn(inst, user)
local user = GetClosestInstWithTag("player", inst, 5)
if not user then return end

	if user.components.driver and user.components.driver.vehicle and user.components.driver.vehicle.components.finiteuses and user.components.driver.vehicle.components.finiteuses.current < user.components.driver.vehicle.components.finiteuses.total - 1 then
		if not user.armsfx then		
			local arms = SpawnPrefab("sea_yard_arms_fx")
			arms.entity:SetParent(user.entity)
			arms.Transform:SetPosition(0, 0, 0)	
			arms.AnimState:SetFinalOffset(5)
			
			user.armsfx = arms																	
			inst.components.fueled:StartConsuming()
			onturnon(inst)
			inst.user = user			 
		end
	end	
	startTimer(inst, user)
end

local function stopFixingFn(inst, user)
	local pt = inst:GetPosition()
	local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 10, {"player"}) 
	for k,user in pairs(ents) do
		if not user and inst.user then
			user = inst.user
			inst.user = nil
		end
		inst.components.fueled:StopConsuming()
		if inst.task_fix then
			inst.task_fix:Cancel()
		end
		if user and user.armsfx then
			onturnoff(inst)
			user.armsfx.stopfx(user.armsfx,user)		
		end
	end
end

local function fixfn(inst, user)
local user = GetClosestInstWithTag("player", inst, 5)
if not user then return end
if not user.components.driver then return end
if user and user.components.driver and user.components.driver.vehicle and user.components.driver.vehicle.components.finiteuses then
if user.components.driver.vehicle.components.finiteuses.current >= user.components.driver.vehicle.components.finiteuses.total - 0.4 then stopFixingFn(inst) end
	if user.components.driver and user.components.driver.vehicle and user.components.driver.vehicle.components.finiteuses ~= nil then
	local boat = user.components.driver.vehicle
	boat.components.finiteuses.current = boat.components.finiteuses.current + 0.7
	local gastabarco = user.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)---------armadura
	if gastabarco then gastabarco.components.armor.condition = boat.components.finiteuses.current end---------armadura		
	end
end end

local function onhammered(inst, worker)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")

		inst.AnimState:PushAnimation("idle", true)
				
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seagull/chirp_seagull")
	end
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
end

local function onload(inst, data)
	if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
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
if inst then inst.AnimState:OverrideSymbol("swap_meter", "sea_yard_meter", fuelAnim) end
end

local function OnFuelEmpty(inst)
	stopFixingFn(inst)
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
if inst then inst.AnimState:OverrideSymbol("swap_meter", "sea_yard_meter", fuelAnim) end
end

local function onplaced(inst)
	inst:RemoveEventCallback("animover", onplaced)
end

local function getstatus(inst, viewer)
	if inst.components.fueled and inst.components.fueled.currentfuel <= 0 then
		return "OFF"
	elseif inst.components.fueled and (inst.components.fueled.currentfuel / inst.components.fueled.maxfuel) <= .25 then
		return "LOWFUEL"
	else
		return "ON"
	end
end


local function reparo(inst)
local user = GetClosestInstWithTag("player", inst, 5)
if user and inst.components.fueled.currentfuel > 0 then
startFixingFn(inst)
else 
stopFixingFn(inst)
end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local minimap = inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
	minimap:SetPriority( 5 )
	minimap:SetIcon( "sea_yard.png" )

    inst:SetPhysicsRadiusOverride(1.5)    
	MakeWaterObstaclePhysics(inst, 0.4, 2, 1.25)	
    
	anim:SetBank("sea_yard")
	anim:SetBuild("sea_yard")
	anim:PlayAnimation("idle",true)

    inst:AddTag("structure")
    inst:AddTag("nowaves")
    inst:AddTag("seayard")
	inst:AddTag("ignorewalkableplatforms")	
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    

	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus

	inst:AddComponent("fueled")
	inst.components.fueled:SetDepletedFn(OnFuelEmpty)
	inst.components.fueled.accepting = true
	inst.components.fueled:SetSections(10)
	inst.components.fueled.ontakefuelfn = ontakefuelfn
	inst.components.fueled:SetSectionCallback(OnFuelSectionChange)
	inst.components.fueled:InitializeFuelLevel(SEA_YARD_MAX_FUEL_TIME)
	inst.components.fueled.bonusmult = 5
	inst.components.fueled.fueltype = "TAR"
	
--	inst:AddComponent("machine")
--	inst.components.machine.turnonfn = startFixingFn
--	inst.components.machine.turnofffn = stopFixingFn
--	inst.components.machine.caninteractfn = CanInteract
--	inst.components.machine.cooldowntime = 0.5

	inst.AnimState:OverrideSymbol("swap_meter", "sea_yard_meter", 10)

	
	inst:ListenForEvent( "onbuilt", function()		
	anim:PlayAnimation("place")
	anim:PushAnimation("idle", true)
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/shipyard/craft")	

	inst:ListenForEvent("animover",  onplaced )   
	end)
			

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)		
	MakeSnowCovered(inst, .01)

	inst.OnSave = onsave 
    inst.OnLoad = onload
    inst.fixfn = fixfn
	inst:DoTaskInTime(0, ontakefuelfn)
	inst:DoPeriodicTask(0.5, reparo)
	
	return inst
end

--Using old prefab names
return Prefab( "shipwrecked/sea_yard", fn, assets, prefabs),
	MakePlacer( "shipwrecked/sea_yard_placer", "sea_yard", "sea_yard", "placer" )
