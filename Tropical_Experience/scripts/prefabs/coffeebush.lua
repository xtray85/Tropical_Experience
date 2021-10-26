local function makeemptyfn(inst)
    if inst.components.pickable and inst.components.pickable.withered then
		inst.AnimState:PlayAnimation("dead_to_empty")
		inst.AnimState:PushAnimation("empty")
	else
		inst.AnimState:PlayAnimation("empty")
	end
end

local function makebarrenfn(inst)--, wasempty)
    if inst.components.pickable and inst.components.pickable.withered then
		if not inst.components.pickable.hasbeenpicked then
			inst.AnimState:PlayAnimation("full_to_dead")
		else
			inst.AnimState:PlayAnimation("empty_to_dead")
		end
		inst.AnimState:PushAnimation("idle_dead")
	else
		inst.AnimState:PlayAnimation("idle_dead")
	end
end

local function pickanim(inst)
	if inst.components.pickable then
		if inst.components.pickable:CanBePicked() then
			local percent = 0
			if inst.components.pickable then
				percent = inst.components.pickable.cycles_left / inst.components.pickable.max_cycles
			end
			if percent >= .9 then
				return "berriesmost"
			elseif percent >= .33 then
				return "berriesmore"
			else
				return "berries"
			end
		else
			if inst.components.pickable:IsBarren() then
				return "idle_dead"
			else
				return "idle"
			end
		end
	end

	return "idle"
end

local function shake(inst)
    if inst.components.pickable and inst.components.pickable:CanBePicked() then
		inst.AnimState:PlayAnimation("shake")
	else
		inst.AnimState:PlayAnimation("shake_empty")
	end
	inst.AnimState:PushAnimation(pickanim(inst), false)
end

local function spawnperd(inst)
    if inst:IsValid() then
        local perd = SpawnPrefab("perd")
        local x, y, z = inst.Transform:GetWorldPosition()
        local angle = math.random() * 2 * PI
        perd.Transform:SetPosition(x + math.cos(angle), 0, z + math.sin(angle))
        perd.sg:GoToState("appear")
        perd.components.homeseeker:SetHome(inst)
        shake(inst)
    end
end

local function pickberries(inst)
	if inst.components.pickable then
		local old_percent = (inst.components.pickable.cycles_left+1) / inst.components.pickable.max_cycles

		if old_percent >= .9 then
			inst.AnimState:PlayAnimation("berriesmost_picked")
		elseif old_percent >= .33 then
			inst.AnimState:PlayAnimation("berriesmore_picked")
		else
			inst.AnimState:PlayAnimation("berries_picked")
		end

		if inst.components.pickable:IsBarren() then
			inst.AnimState:PushAnimation("idle_dead")
		else
			inst.AnimState:PushAnimation("idle")
		end
	end	
end

local function onpickedfn(inst, picker)
    pickberries(inst)
	 
	 if inst.spawnsperd and picker and not picker:HasTag("berrythief") and math.random() < TUNING.PERD_SPAWNCHANCE then
	 	inst:DoTaskInTime(3+math.random()*3, spawnperd)
	 end
end

local function getregentimefn_normal(inst)
    if inst.components.pickable == nil then
        return TUNING.BERRY_REGROW_TIME
    end
    --V2C: nil cycles_left means unlimited picks, so use max value for math
    local max_cycles = inst.components.pickable.max_cycles
    local cycles_left = inst.components.pickable.cycles_left or max_cycles
    local num_cycles_passed = math.max(0, max_cycles - cycles_left)
    return TUNING.BERRY_REGROW_TIME
        + TUNING.BERRY_REGROW_INCREASE * num_cycles_passed
        + TUNING.BERRY_REGROW_VARIANCE * math.random()
end

local function makefullfn(inst)
    inst.AnimState:PlayAnimation(pickanim(inst))
end

local function dig_up_common(inst, worker, numberries)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then

        if inst.components.pickable:IsBarren() then
            inst.components.lootdropper:SpawnLootPrefab("twigs")
            inst.components.lootdropper:SpawnLootPrefab("twigs")
        else
            if inst.components.pickable:CanBePicked() then
                local pt = inst:GetPosition()
                pt.y = pt.y + (inst.components.pickable.dropheight or 0)
                for i = 1, numberries do
                    inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product, pt)
                end
            end

			inst.components.lootdropper:SpawnLootPrefab("dug_"..inst.prefab)
        end
    end
    inst:Remove()
end

local function dig_up_normal(inst, worker)
    dig_up_common(inst, worker, 1)
end

local function ontransplantfn(inst)
    inst.AnimState:PlayAnimation("idle_dead")
    inst.components.pickable:MakeBarren()
end

local function OnHaunt(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
        shake(inst)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_COOLDOWN_TINY
        return true
    end
    return false
end

local function createbush(name, inspectname, berryname, master_postinit)
    local assets =
    {
		Asset("ANIM", "anim/coffeebush.zip")
    }

    local prefabs =
    {
        berryname,
        "dug_"..name,
        "perd",
        "twigs",
		"coffeebeans",
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        local minimap = inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeSmallObstaclePhysics(inst, .1)

        inst:AddTag("cofeebush")
        inst:AddTag("renewable")
		inst:AddTag("plant")	
		inst:AddTag("notreadyforharvest")

		minimap:SetIcon("coffeebush.png")

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("berriesmost", false)

        MakeSnowCoveredPristine(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.AnimState:SetTime(math.random() * inst.AnimState:GetCurrentAnimationLength())

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
        inst.components.pickable.makebarrenfn = makebarrenfn
        inst.components.pickable.makefullfn = makefullfn
        inst.components.pickable.ontransplantfn = ontransplantfn

--        MakeLargeBurnable(inst)
--        MakeMediumPropagator(inst)

        MakeHauntableIgnite(inst)
        AddHauntableCustomReaction(inst, OnHaunt, false, false, true)

        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.DIG)
        inst.components.workable:SetWorkLeft(1)

        inst:AddComponent("inspectable")
        if name ~= inspectname then
            inst.components.inspectable.nameoverride = inspectname
        end

        inst:ListenForEvent("onwenthome", shake)
        MakeSnowCovered(inst)
        MakeNoGrowInWinter(inst)

        master_postinit(inst)

        if IsSpecialEventActive(SPECIAL_EVENTS.YOTG) then
            inst:ListenForEvent("spawnperd", spawnperd)
        end
		
        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

local function normal_postinit(inst)
    inst.components.pickable:SetUp("coffeebeans", TUNING.BERRY_REGROW_TIME)
    inst.components.pickable.getregentimefn = getregentimefn_normal
    inst.components.pickable.max_cycles = 1
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles

    inst.components.workable:SetOnFinishCallback(dig_up_normal)
end

return createbush("coffeebush", "coffeebush", "coffeebeans", normal_postinit)
