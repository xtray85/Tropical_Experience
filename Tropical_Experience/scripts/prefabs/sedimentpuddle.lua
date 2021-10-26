local assets =
{
	Asset("ANIM", "anim/gold_puddle.zip"),
    Asset("MINIMAP_IMAGE", "gold_puddle"),
	Asset("ANIM", "anim/water_ring_fx.zip"),
	Asset("ANIM", "anim/bamboo.zip"),	
    
}

local prefabs =
{
	"goldnugget",
}

local SAFE_EDGE_RANGE = 7
local SAFE_PUDDLE_RANGE = 7

local function getanim(inst, state)
	local size = "big"
	if inst.stage == 1 then
		size = "small"
	elseif inst.stage == 2 then
		size = "med"
	end
	return size .."_" .. state
end

local function setstage0(inst, preanim)
--	print("SET STAGE 0")
	local anim = inst.AnimState
	
	inst.stage = 0
	inst.components.workable:SetWorkLeft(0)
	inst.components.workable:SetWorkable(false)
	inst.components.ripplespawner:SetRange(0)


	inst.MiniMapEntity:SetEnabled(false)
    
	if preanim then
		anim:PlayAnimation( preanim )
		inst:DoTaskInTime(1, function() inst:Hide() end)
		--anim:PushAnimation("small_idle", true )
	else		
		anim:PlayAnimation("small_idle", true )
		inst:Hide()
	end	
end

local function setstage1(inst, preanim)
--	print("SET STAGE 1")
	local anim = inst.AnimState
	inst:Show()
	inst.stage = 1		
	inst.components.workable:SetWorkLeft(1)	
	inst.components.ripplespawner:SetRange(1.6)
	
	inst.MiniMapEntity:SetEnabled(true)

	if preanim then
		anim:PlayAnimation( preanim )
		--anim:PlayAnimation("small_idle", true )
	else		
		anim:PlayAnimation("small_idle", true )
	end		
end

local function setstage2(inst, preanim)
--	print("SET STAGE 2")
	local anim = inst.AnimState
	inst:Show()
	inst.stage = 2			
	inst.components.workable:SetWorkLeft(2)		
	inst.components.ripplespawner:SetRange(2.6)

	inst.MiniMapEntity:SetEnabled(true)

	if preanim then
		anim:PlayAnimation( preanim )
		anim:PlayAnimation("med_idle", true )
	else		
		anim:PlayAnimation("small_idle", true )
	end	
end

local function setstage3(inst, preanim)
--	print("SET STAGE 3")
	local anim = inst.AnimState
	inst:Show()
	inst.stage = 3
	inst.components.workable:SetWorkLeft(3)
	inst.components.ripplespawner:SetRange(3.5)
	
	inst.MiniMapEntity:SetEnabled(true)

	if preanim then
		anim:PlayAnimation( preanim )
		anim:PlayAnimation("big_idle", true )
	else		
		anim:PlayAnimation("big_idle", true )
	end	
end

local function grow(inst)
	local anim = inst.AnimState
	if inst.stage == 0 then		
		inst.watercollected = 0
		setstage1(inst, "appear")		
	elseif inst.stage == 1 then
		setstage2(inst, "small_to_med")		
	elseif inst.stage == 2 then
		setstage3(inst, "med_to_big")		
	end
end

local function shrink(inst)
	local anim = inst.AnimState
	if inst.stage == 3 then
		setstage2(inst, "big_to_med")		
	elseif inst.stage == 2 then
		setstage1(inst, "med_to_small")		
	elseif inst.stage == 1 then
		inst.watercollected = 0		
		setstage0(inst, "disappear")				
	end	
end

local function initialsetup(inst)
if not inst.stage then
inst.stage = math.random(0,3)
end	
if inst.stage == 0 then
	setstage0(inst)
elseif inst.stage == 1 then
	setstage1(inst)
elseif inst.stage == 2 then
	setstage2(inst)
elseif inst.stage == 3 then
	setstage3(inst)
end
end

local function getnewwaterlimit(inst)
	return 36 + (math.random() * 8)  -- 36 * 5 = 180 seconds to go up one level .. 3 minutes of rain. 
end

local function OnSave(inst,data)
 	data.stage = inst.stage
 	data.watercollected = inst.watercollected
 	data.waterlimit = inst.waterlimit

 	data.rot = inst.Transform:GetRotation()
end

local function OnLoad(inst,data)
	if data then
	   	inst.stage = data.stage   
		if inst.stage == 0 then
			setstage0(inst)
		elseif inst.stage == 1 then
			setstage1(inst)
		elseif inst.stage == 2 then
			setstage2(inst)
		elseif inst.stage == 3 then
			setstage3(inst)
		end
		
		inst.watercollected = data.watercollected
		inst.waterlimit = data.waterlimit

	   	if data.rot then
	   		inst.Transform:SetRotation(data.rot)
	   	end
   	end
end



local function floodstart(inst)
if TheWorld.state.israining then
inst.watercollected = inst.watercollected + 4
if inst.watercollected > inst.waterlimit then
inst.watercollected = 0
grow(inst)
inst.waterlimit = getnewwaterlimit(inst)
end
end	
end

local function OnEntityWake(inst)
inst.components.ripplespawner:Start()	
if inst.updatetask then
inst.updatetask:Cancel()
inst.updatetask = nil
end
inst.updatetask = inst:DoPeriodicTask(10, floodstart)
end

local function OnEntitySleep(inst)
inst.components.ripplespawner:Stop()
if inst.updatetask then
inst.updatetask:Cancel()
inst.updatetask = nil
end
end

local function commonfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("sedimentpuddle")
    inst:AddTag("alagamentopraremover")		

    anim:SetBuild("gold_puddle")
    anim:SetBank("gold_puddle")
	anim:PlayAnimation("small_idle", true )
	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
	anim:SetLayer( LAYER_BACKGROUND )
	anim:SetSortOrder( 2 )

	inst.Transform:SetRotation(math.random()*360)
	inst.watercollected = 0
	inst.waterlimit  =  getnewwaterlimit(inst)

	inst.shrink = shrink
	inst.grow = grow	

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("lootdropper")

	inst:AddComponent("ripplespawner")
	inst.components.ripplespawner.permanente = true

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.PAN)
	inst.components.workable:SetWorkLeft(3)	
	inst.components.workable:SetOnWorkCallback(
	function(inst, worker, workleft)
			inst.components.lootdropper:SpawnLootPrefab("gold_dust")
			shrink(inst)			
	end)	

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "gold_puddle.png" )
	
--    inst:AddComponent("inspectable")
    inst.no_wet_prefix = true

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

	inst:DoTaskInTime(0,function() initialsetup(inst) end) 	
	
	inst.OnEntitySleep = OnEntitySleep
	inst.OnEntityWake = OnEntityWake	

	return inst
end

local function testpararemover(inst)
local lago = GetClosestInstWithTag("alagamentopraremover", inst, 3)
local lagogrande = GetClosestInstWithTag("alagamentopraremovergrande", inst, 8)	
if not lago then
if not lagogrande then
if inst.controlador then 
inst.controlador.lagonope = nil
inst.controlador = nil 
end
inst:Remove()
end
end
end

local function makeripple(speed)

	local function ripplefn()
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
	
--	    anim:SetBuild("water_ring_fx")
--	    anim:SetBank("water_ring_fx")
--	    anim:PlayAnimation( speed )
		
		anim:SetBuild("ripple_build")
		anim:SetBank( "bamboo" )		
		anim:PlayAnimation( "idle_water", true)			
		
		anim:SetLayer( LAYER_BACKGROUND )
		anim:SetSortOrder( 3 )

		anim:SetMultColour(1, 1, 1, 1)
    	
    	inst.persists = false
	
		inst:DoPeriodicTask(0.4, testpararemover)

		return inst
	end

	return ripplefn
end

return Prefab( "marsh/objects/sedimentpuddle", commonfn, assets, prefabs),
	   Prefab( "marsh/objects/puddle_ripple_slow_fx", makeripple("slow"), assets, prefabs)
