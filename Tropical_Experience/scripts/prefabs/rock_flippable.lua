
local assets =
{
	Asset("ANIM", "anim/rock_flipping.zip"),
	Asset("MINIMAP_IMAGE", "rock_flipping"),
}

local prefabs =
{
	"jellybug",
	"slugbug",
}

local total_day_time = 480
local FLIPPABLE_ROCK_REPOPULATE_TIME = total_day_time*5
local FLIPPABLE_ROCK_REPOPULATE_INCREASE = total_day_time*.5
local FLIPPABLE_ROCK_REPOPULATE_VARIANCE = total_day_time*2
local FLIPPABLE_ROCK_CYCLES = 3

local function ontransplantfn(inst)
	inst.components.pickable:MakeBarren()
end

local function makeemptyfn(inst)
end

local function makebarrenfn(inst)
end

local function wobble(inst)
	if inst.AnimState:IsCurrentAnimation("idle") then
		inst.AnimState:PlayAnimation("wobble")
		inst.AnimState:PushAnimation("idle")
	end
end

local function dowobbletest(inst)
	if math.random() < 0.5 then
		wobble(inst)
	end
end

local function onpickedfn(inst, picker)
	inst.AnimState:PlayAnimation("flip_over", false)
	local pt = Point(inst.Transform:GetWorldPosition())
	inst.components.lootdropper:DropLoot(pt)

	inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/flipping_rock/open")
	

	inst.flipped = true
end

local function getregentimefn(inst)
	if inst.components.pickable then
		local num_cycles_passed = math.min(inst.components.pickable.max_cycles - inst.components.pickable.cycles_left, 0)
		return FLIPPABLE_ROCK_REPOPULATE_TIME + FLIPPABLE_ROCK_REPOPULATE_INCREASE * num_cycles_passed + math.random() * FLIPPABLE_ROCK_REPOPULATE_VARIANCE
	else
		return FLIPPABLE_ROCK_REPOPULATE_TIME
	end
end

local function makefullfn(inst)
inst.AnimState:PlayAnimation("idle", true)
inst.flipped = false
end

local function onsave(inst, data)
	if inst.flipped then
		data.flipped = true
	end
end

local function onload(inst, data)
	-- just from world gen really
	if data and data.makebarren then
		makebarrenfn(inst)
		inst.components.pickable:MakeBarren()
	end

	if data and data.flipped then
		inst.flipped = true
		inst.AnimState:PlayAnimation("idle_flipped")
	end
end

local function setloot(inst)
    local ground = TheWorld
    local pt = Vector3(inst.Transform:GetWorldPosition())
    local tile = ground.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
    if tile == GROUND.PLAINS then
    	inst.components.lootdropper:AddRandomLoot("jellybug", 5.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("rocks", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 20.0) -- Weighted average
    elseif tile == GROUND.RAINFOREST then
	    inst.components.lootdropper:AddRandomLoot("jellybug", 10.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("slugbug", 10.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("rocks", 15.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 15.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 10.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("rabid_beetle", 0.1) -- Weighted average    	
    elseif tile == GROUND.DEEPRAINFOREST then
	    inst.components.lootdropper:AddRandomLoot("jellybug", 15.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("slugbug", 15.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("rocks", 5.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 5.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 5.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("rabid_beetle", 10) -- Weighted average    
	    inst.components.lootdropper:AddRandomLoot("snake_amphibious", 10) -- Weighted average   
	    inst.components.lootdropper:AddRandomLoot("relic_1", 1) -- Weighted average  	    
	    inst.components.lootdropper:AddRandomLoot("relic_2", 1) -- Weighted average  	    
	    inst.components.lootdropper:AddRandomLoot("relic_3", 1) -- Weighted average  	    
	else
	    inst.components.lootdropper:AddRandomLoot("rocks", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("flint", 20.0) -- Weighted average
	    inst.components.lootdropper:AddRandomLoot("cutgrass", 20.0) -- Weighted average
    end
end


local function fn(Sim)
	local inst = CreateEntity()

	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local minimap = inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
    
    inst.OnSave = onsave
	inst.OnLoad = onload

	inst:AddTag("rock")
	inst:AddTag("flippable")
	
	MakeObstaclePhysics(inst, .1)

	inst.AnimState:SetBank("flipping_rock")
	inst.AnimState:SetBuild("rock_flipping")
	inst.AnimState:PlayAnimation("idle", true)

	inst.MiniMapEntity:SetIcon("rock_flipping.png")

    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("pickable")
	inst.components.pickable:SetUp(nil,TUNING.GRASS_REGROW_TIME)	
	inst.components.pickable.getregentimefn = getregentimefn
	inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.onregenfn = makefullfn
	inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.makebarrenfn = makebarrenfn
--	inst.components.pickable.makefullfn = makefullfn
	inst.components.pickable.ontransplantfn = ontransplantfn
	inst.components.pickable.max_cycles = FLIPPABLE_ROCK_CYCLES + math.random(2)
	inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
	inst.components.pickable.quickpick = true
	inst.spawnsperd = true

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(3)

	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
	inst.components.lootdropper:SetLoot({"rocks"})
	inst.components.lootdropper:DropLoot()

				if math.random() < 0.3 then
	inst.components.lootdropper:SetLoot({"rocks"})
	inst.components.lootdropper:DropLoot()
				end

				if inst.components.pickable.canbepicked then
					inst.components.lootdropper:DropLoot()
				end

				inst:Remove()
			end
		end)

	inst:AddComponent("lootdropper")
    inst.components.lootdropper.numrandomloot = 1
    inst.components.lootdropper.chancerandomloot = 1.0 -- drop some random item X% of the time
    inst.components.lootdropper.alwaysinfront = true
    inst:DoTaskInTime(0,function() setloot(inst) end)

	inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "rock"
	inst:DoPeriodicTask(10+(math.random()*10),function() dowobbletest(inst) end)
	
	return inst
end

return Prefab("common/objects/rock_flippable", fn, assets, prefabs)
