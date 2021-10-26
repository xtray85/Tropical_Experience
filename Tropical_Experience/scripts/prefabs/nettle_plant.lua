local assets =
{
	Asset("ANIM", "anim/nettle.zip"),
	Asset("SOUND", "sound/common.fsb"),
	Asset("MINIMAP_IMAGE", "nettle"),
}

local VINE_REGROW_TIME = 480*3

local prefabs =
{
    "cutnettle",    
}

local function onregenfn(inst)
	inst.AnimState:PlayAnimation("grow") 
	inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("picked", true)	
end

local function makebarrenfn(inst)
	inst.AnimState:PlayAnimation("picked", true)
end

local function onpickedfn(inst)
	inst.AnimState:PlayAnimation("picking") 
	inst.AnimState:PushAnimation("picked", false) 
end

local function testForGrowth(inst)
	local pt = Vector3(inst.Transform:GetWorldPosition())
	local tile = TheWorld.Map:GetTileAtPoint(pt.x, pt.y, pt.z)

	if not TheWorld.state.iswinter and (tile == GROUND.DEEPRAINFOREST or tile == GROUND.RAINFOREST) then
		inst.components.pickable:Regen()	
	else
		inst.components.pickable:MakeBarren()
	end
end

local function getstatus(inst)
   if not inst.components.pickable.canbepicked then
   		return "EMPTY"
   end    
end

local function ontransplantfn(inst)
	inst.components.pickable:MakeBarren()
end

local function makefn(stage)

	local function dig_up(inst, digger)
		if inst.components.pickable and inst.components.pickable:CanBePicked() then
			inst.components.lootdropper:SpawnLootPrefab("cutnettle")
		end		
		local bush = inst.components.lootdropper:SpawnLootPrefab("dug_nettle")
		print(inst.prefab)
		inst:Remove()
	end

		local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    local sound = inst.entity:AddSoundEmitter()
		local minimap = inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

		inst.MiniMapEntity:SetIcon("nettle.png")
		inst.AnimState:SetBank("nettle")	
		inst.AnimState:SetBuild("nettle")

	    anim:PlayAnimation("idle", true)
	    anim:SetTime(math.random()*2)

	    inst:AddTag("gustable")
	    inst:AddTag("nettle_plant")
		inst:AddTag("plant")	

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end		
		
	    inst:AddComponent("pickable")
	    inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"

	    inst.components.pickable:SetUp("cutnettle", VINE_REGROW_TIME)
		inst.components.pickable.onregenfn = onregenfn
		inst.components.pickable.onpickedfn = onpickedfn
	    inst.components.pickable.makeemptyfn = makeemptyfn
		inst.components.pickable.makebarrenfn = makebarrenfn
		inst.components.pickable.ontransplantfn = ontransplantfn

	    inst:AddComponent("inspectable") 
  
		inst:AddComponent("lootdropper")
	    inst.components.inspectable.getstatus = getstatus	
		
		inst:AddComponent("workable")
	    inst.components.workable:SetWorkAction(ACTIONS.DIG)
	    inst.components.workable:SetOnFinishCallback(dig_up)
	    inst.components.workable:SetWorkLeft(1)
--	    MakePickableBlowInWindGust(inst, TUNING.GRASS_WINDBLOWN_SPEED, TUNING.GRASS_WINDBLOWN_FALL_CHANCE)

	    ---------------------
	    MakeMediumBurnable(inst)
	    MakeSmallPropagator(inst)
	    --inst.components.burnable:MakeDragonflyBait(1)
		MakeNoGrowInWinter(inst)  

		inst:WatchWorldState("season", testForGrowth)
--		inst:ListenForEvent("seasonChange", function(it, data) testForGrowth(inst) end, TheWorld)

	    return inst
	end

    return fn
end

return Prefab("forest/objects/nettle", makefn(0), assets, prefabs)	  
