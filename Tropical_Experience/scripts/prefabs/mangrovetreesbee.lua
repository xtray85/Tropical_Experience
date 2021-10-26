local assets =
{
	Asset("ANIM", "anim/tree_mangrove_build.zip"),
	Asset("ANIM", "anim/tree_mangrove_normal.zip"),
	Asset("ANIM", "anim/tree_mangrove_short.zip"),
	Asset("ANIM", "anim/tree_mangrove_tall.zip"),
	Asset("ANIM", "anim/tree_mangrovebee_build.zip"),
}

local prefabs =
{
	
}


local function dig_up_stump(inst, chopper)
	inst.components.lootdropper:SpawnLootPrefab("log")
	inst:Remove()
end

local function attack(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren()
    end
end

local function chop_down_burnt_tree(inst, chopper)
	inst:RemoveComponent("workable")
	inst:RemoveComponent("childspawner")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
	inst.AnimState:PlayAnimation("burnt_tall")
	RemovePhysicsColliders(inst)
	inst:ListenForEvent("animover", function() inst:Remove() end)
	inst.components.lootdropper:SpawnLootPrefab("charcoal")
	inst.components.lootdropper:DropLoot()
end

local burnt_highlight_override = {.5,.5,.5}
local function OnBurnt(inst, imm)
	local function changes()
		if inst.components.burnable then
			inst.components.burnable:Extinguish()
		end
		inst:RemoveComponent("burnable")
		inst:RemoveComponent("propagator")
		inst:RemoveTag("shelter")
		inst:RemoveTag("dragonflybait_lowprio")
		inst:RemoveTag("fire")

		inst.components.lootdropper:SetLoot({})

		if inst.components.workable then
			inst.components.workable:SetWorkLeft(1)
			inst.components.workable:SetOnWorkCallback(nil)
			inst.components.workable:SetOnFinishCallback(chop_down_burnt_tree)
		end
	end

	if imm then
		changes()
	else
		inst:DoTaskInTime( 0.5, changes)
	end
	inst.AnimState:PlayAnimation("burnt_tall", true)
	--inst.AnimState:SetRayTestOnBB(true);
	inst:AddTag("burnt")

	inst.highlight_override = burnt_highlight_override
end

local function PushSway(inst)
	if math.random() > .5 then
		inst.AnimState:PushAnimation("sway1_loop_tall", true)
	else
		inst.AnimState:PushAnimation("sway2_loop_tall", true)
	end
end


local function inspect_tree(inst)
	if inst:HasTag("burnt") then
		return "BURNT"
	elseif inst:HasTag("stump") then
		return "CHOPPED"
	end
end

local function OnIgnite(inst)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren()
    end
end

local function chop_tree(inst, chopper, chops)
    if inst.components.childspawner ~= nil then
        inst.components.childspawner:ReleaseAllChildren(chopper, "killerbee")
    end

	if chopper and chopper.components.beaverness and chopper.isbeavermode and chopper.isbeavermode:value() then
		inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/beaver_chop_tree")
	else
		inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
	end

	inst.AnimState:PlayAnimation("chop_tall")
	inst.AnimState:PushAnimation("sway1_loop_tall", true)
end

local function chop_down_tree(inst, chopper)
	inst:RemoveComponent("burnable")
	MakeSmallBurnable(inst)
	inst:RemoveComponent("propagator")
	MakeSmallPropagator(inst)
	inst:RemoveComponent("workable")
    inst:RemoveComponent("childspawner")	
	inst:RemoveTag("shelter")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
	local pt = Vector3(inst.Transform:GetWorldPosition())
	local hispos = Vector3(chopper.Transform:GetWorldPosition())

	local he_right = (hispos - pt):Dot(TheCamera:GetRightVec()) > 0

	if he_right then
		inst.AnimState:PlayAnimation("fallleft_tall")
		inst.components.lootdropper:DropLoot(pt - TheCamera:GetRightVec())
	else
		inst.AnimState:PlayAnimation("fallright_tall")
		inst.components.lootdropper:DropLoot(pt + TheCamera:GetRightVec())
	end


	RemovePhysicsColliders(inst)
	inst.AnimState:PushAnimation("stump_tall")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig_up_stump)
	inst.components.workable:SetWorkLeft(1)

	inst:AddTag("stump")

	inst:AddTag("NOCLICK")
	inst:DoTaskInTime(2, function() inst:RemoveTag("NOCLICK") end)
end

local function chop_down_tree_leif(inst, chopper)
	chop_down_tree(inst, chopper)
end

local function tree_burnt(inst)
	OnBurnt(inst)
end


local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
		data.burnt = true
	end

	if inst:HasTag("stump") then
		data.stump = true
	end

end

local function onload(inst, data)
	if data then
		if data.burnt then
			inst:AddTag("fire") -- Add the fire tag here: OnEntityWake will handle it actually doing burnt logic
		elseif data.stump then
			inst:RemoveComponent("burnable")
			MakeSmallBurnable(inst)
			inst:RemoveComponent("workable")
			inst:RemoveComponent("childspawner")
			inst:RemoveComponent("propagator")
			MakeSmallPropagator(inst)
			RemovePhysicsColliders(inst)
			inst.AnimState:PlayAnimation("stump_tall")
			inst:AddTag("stump")
			inst:RemoveTag("shelter")
		end
	end
end

local function OnEntitySleep(inst)
	local fire = false
	if inst:HasTag("fire") then
		fire = true
	end
	inst:RemoveComponent("burnable")
	inst:RemoveComponent("propagator")
	inst:RemoveComponent("inspectable")
	if fire then
		inst:AddTag("fire")
	end
end

local function OnEntityWake(inst)

	if not inst:HasTag("burnt") and not inst:HasTag("fire") then
		if not inst.components.burnable then
			if inst:HasTag("stump") then
				MakeSmallBurnable(inst)
			else
				MakeLargeBurnable(inst)
				inst.components.burnable:SetFXLevel(5)
				inst.components.burnable:SetOnBurntFn(tree_burnt)
			end
		end

		if not inst.components.propagator then
			if inst:HasTag("stump") then
				MakeSmallPropagator(inst)
			else
				MakeLargePropagator(inst)
			end
		end
	elseif not inst:HasTag("burnt") and inst:HasTag("fire") then
		OnBurnt(inst, true)
	end

	if not inst.components.inspectable then
		inst:AddComponent("inspectable")
		inst.components.inspectable.getstatus = inspect_tree
	end
end

local function SeasonalSpawnChanges(inst, season)
    if inst.components.childspawner ~= nil then
        if season == SEASONS.SPRING then
            inst.components.childspawner:SetRegenPeriod(TUNING.BEEHIVE_REGEN_TIME / TUNING.SPRING_COMBAT_MOD)
            inst.components.childspawner:SetSpawnPeriod(TUNING.BEEHIVE_RELEASE_TIME / TUNING.SPRING_COMBAT_MOD)
            inst.components.childspawner:SetMaxChildren(TUNING.BEEHIVE_BEES * TUNING.SPRING_COMBAT_MOD)
        else
            inst.components.childspawner:SetRegenPeriod(TUNING.BEEHIVE_REGEN_TIME)
            inst.components.childspawner:SetSpawnPeriod(TUNING.BEEHIVE_RELEASE_TIME)
            inst.components.childspawner:SetMaxChildren(TUNING.BEEHIVE_BEES)
        end
    end
end

local function makefn(build, stage, data)
	local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()

		local sound = inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

		inst:SetPhysicsRadiusOverride(2.35)

		MakeWaterObstaclePhysics(inst, 1.2, 2, 1.25)		

		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetIcon("tree_mangrovebee.png")

		minimap:SetPriority(-1)

		inst:AddTag("tree")
		inst:AddTag("workable")
		inst:AddTag("shelter")
		inst:AddTag("gustable")
		inst:AddTag("mudacamada")
		inst:AddTag("ignorewalkableplatforms")	
		inst:AddTag("plant")		

		anim:SetBuild("tree_mangrove_build")
		inst.AnimState:OverrideSymbol("leaves", "tree_mangrovebee_build", "leaves")	
		anim:SetBank("tree_mangrove")
		local color = 0.5 + math.random() * 0.5
		anim:SetMultColour(color, color, color, 1)
		
        inst:SetPrefabNameOverride("tree_mangrove")		
		
		PushSway(inst)		
		
		inst.entity:SetPristine()

   		if not TheWorld.ismastersim then
        	return inst
    	end

		-------------------
		MakeLargeBurnable(inst)
		inst.components.burnable:SetFXLevel(5)
		inst.components.burnable:SetOnBurntFn(tree_burnt)
		inst.components.burnable:SetOnIgniteFn(OnIgnite)		

		MakeLargePropagator(inst)

		-------------------
		inst:AddComponent("inspectable")
		inst.components.inspectable.getstatus = inspect_tree


		-------------------
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.CHOP)
		inst.components.workable:SetOnWorkCallback(chop_tree)
		inst.components.workable:SetOnFinishCallback(chop_down_tree_leif)
		inst.components.workable:SetWorkLeft(TUNING.EVERGREEN_CHOPS_TALL)		









    inst:AddComponent("childspawner")
    inst.components.childspawner:SetRegenPeriod(TUNING.BEEHIVE_REGEN_TIME)
    inst.components.childspawner:SetSpawnPeriod(TUNING.BEEHIVE_RELEASE_TIME)	
    inst.components.childspawner.childname = "bee"
    SeasonalSpawnChanges(inst, TheWorld.state.season)
    inst:WatchWorldState("season", SeasonalSpawnChanges)
    inst.components.childspawner.emergencychildname = "bee"
	inst.components.childspawner.wateronly = true	
    inst.components.childspawner.emergencychildrenperplayer = 1
    inst.components.childspawner:SetMaxEmergencyChildren(TUNING.BEEHIVE_EMERGENCY_BEES)
    inst.components.childspawner:SetEmergencyRadius(TUNING.BEEHIVE_EMERGENCY_RADIUS)

		-------------------
		inst:AddComponent("lootdropper")
		inst.components.lootdropper:SetLoot({"log","log", "twigs", "honey", "honey", "honey", "honeycomb" })
		---------------------
		--PushSway(inst)
		inst.AnimState:SetTime(math.random()*2)

		---------------------

		inst.OnSave = onsave
		inst.OnLoad = onload

		MakeSnowCovered(inst, .01)


		if data =="burnt"  then
			OnBurnt(inst)
		end

		if data =="stump"  then
			inst:RemoveComponent("burnable")
			MakeSmallBurnable(inst)
			inst:RemoveComponent("workable")
			inst:RemoveComponent("childspawner")
			inst:RemoveComponent("propagator")
			MakeSmallPropagator(inst)
			RemovePhysicsColliders(inst)
			inst.AnimState:PlayAnimation("stump_tall")
			inst:AddTag("stump")
		end
		
		
		inst.OnEntitySleep = OnEntitySleep
		inst.OnEntityWake = OnEntityWake


		return inst
	end
	return fn
end

local function tree(name, build, stage, data)
	return Prefab(name, makefn(build, stage, data), assets, prefabs)
end

return tree("tree_mangrovebee", "normal", 0),
		tree("mangrovetreebee_burnt", "normal", 0, "burnt"),
		tree("mangrovetreebee_stump", "normal", 0, "stump")
