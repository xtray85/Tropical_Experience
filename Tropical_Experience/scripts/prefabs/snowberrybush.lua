local assets =
{
    Asset("ANIM", "anim/frostbush.zip"),
}

local prefabs =
{
    "blueberries",
}

local function shake(inst)
        inst.AnimState:PlayAnimation("shake")
        inst.AnimState:PushAnimation("idle")
end

local function spawnperd(inst)
    if inst:IsValid() then
        local perd = SpawnPrefab("snowperd")
        local x, y, z = inst.Transform:GetWorldPosition()
        local angle = math.random() * 2 * PI
        perd.Transform:SetPosition(x + math.cos(angle), 0, z + math.sin(angle))
        perd.sg:GoToState("appear")
        perd.components.homeseeker:SetHome(inst)
        shake(inst)
    end
end


local function onpickedfn(inst, picker)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
        inst.AnimState:PushAnimation("picked", false)
		inst.AnimState:OverrideSymbol("berries", "frostbush", "")
    if not (picker:HasTag("berrythief") or inst._noperd) and math.random() < 0.3 then
        inst:DoTaskInTime(3 + math.random() * 3, spawnperd)
    end			
end

local function onregenfn(inst)
	inst.AnimState:OverrideSymbol("berries", "frostbush", "berries")
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle", true)		
end

local function makeemptyfn(inst)
        inst.AnimState:PlayAnimation("picked")
end

local function dig_up(inst, worker)
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
        end

        inst.components.lootdropper:SpawnLootPrefab(
            withered and
            "quagmire_spotspice_sprig" or
            "dug_grass"
        )
    end
    inst:Remove()
end

local function shrub_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst.MiniMapEntity:SetIcon("quagmire_spotspice_shrub.png")

    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetBuild("frostbush")
    inst.AnimState:SetBank("berrybush")
    inst.AnimState:PlayAnimation("idle", true)
	MakeObstaclePhysics(inst, 0.35)
	MakeSnowCoveredPristine(inst)

        inst:AddTag("renewable")
        inst:AddTag("witherable")

    inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.AnimState:SetTime(math.random() * 2)
        local color = 0.75 + math.random() * 0.25
        inst.AnimState:SetMultColour(color, color, color, 1)

        inst:AddComponent("pickable")
        inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"

        inst.components.pickable:SetUp("blueberries", TUNING.GRASS_REGROW_TIME)
        inst.components.pickable.onregenfn = onregenfn
        inst.components.pickable.onpickedfn = onpickedfn
        inst.components.pickable.makeemptyfn = makeemptyfn
--        inst.components.pickable.makebarrenfn = makebarrenfn
        inst.components.pickable.max_cycles = 20
        inst.components.pickable.cycles_left = 20
--        inst.components.pickable.ontransplantfn = ontransplantfn

        inst:AddComponent("witherable")

        inst:AddComponent("lootdropper")
        inst:AddComponent("inspectable")
		
	    MakeSnowCovered(inst)	

--		if not GetGameModeProperty("disable_transplanting") then
--			inst:AddComponent("workable")
--			inst.components.workable:SetWorkAction(ACTIONS.DIG)
--			inst.components.workable:SetOnFinishCallback(dig_up)
--			inst.components.workable:SetWorkLeft(1)
--		end
        ---------------------

        MakeMediumBurnable(inst)
        MakeSmallPropagator(inst)
        MakeNoGrowInWinter(inst)
        MakeHauntableIgnite(inst)
		MakeSnowCovered(inst, .01)		
        ---------------------

    return inst
end


return Prefab("snowberrybush", shrub_fn, assets, prefabs)