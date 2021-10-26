local assets =
{
	Asset("ANIM", "anim/gunpowder_barrel.zip"),
	Asset("ANIM", "anim/explode.zip"),
--	Asset("MINIMAP_IMAGE", "gunpowder_barrel"),
}

local prefabs =
{
    "explode_small",
}

function SpawnWavesSW(inst, numWaves, totalAngle, waveSpeed, wavePrefab, initialOffset, idleTime, instantActive, random_angle)
	wavePrefab = wavePrefab or "rogue_wave"
	totalAngle = math.clamp(totalAngle, 1, 360)

    local pos = inst:GetPosition()
    local startAngle = (random_angle and math.random(-180, 180)) or inst.Transform:GetRotation()
    local anglePerWave = totalAngle/(numWaves - 1)

	if totalAngle == 360 then
		anglePerWave = totalAngle/numWaves
	end

    --[[
    local debug_offset = Vector3(2 * math.cos(startAngle*DEGREES), 0, -2 * math.sin(startAngle*DEGREES)):Normalize()
    inst.components.debugger:SetOrigin("debugy", pos.x, pos.z)
    local debugpos = pos + (debug_offset * 2)
    inst.components.debugger:SetTarget("debugy", debugpos.x, debugpos.z)
    inst.components.debugger:SetColour("debugy", 1, 0, 0, 1)
	--]]

    for i = 0, numWaves - 1 do
        local wave = SpawnPrefab(wavePrefab)

        local angle = (startAngle - (totalAngle/2)) + (i * anglePerWave)
        local rad = initialOffset or (inst.Physics and inst.Physics:GetRadius()) or 0.0
        local total_rad = rad + wave.Physics:GetRadius() + 0.1
        local offset = Vector3(math.cos(angle*DEGREES),0, -math.sin(angle*DEGREES)):Normalize()
        local wavepos = pos + (offset * total_rad)

--        if inst:GetIsOnWater(wavepos:Get()) then
	        wave.Transform:SetPosition(wavepos:Get())

	        local speed = waveSpeed or 6
	        wave.Transform:SetRotation(angle)
	        wave.Physics:SetMotorVel(speed, 0, 0)
	        wave.idle_time = idleTime or 5

	        if instantActive then
	        	wave.sg:GoToState("idle")
	        end

	        if wave.soundtidal then
	        	wave.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/rogue_waves/"..wave.soundtidal)
	        end
--        else
--        	wave:Remove()
--        end
    end
end


local function OnIgniteFn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
    DefaultBurnFn(inst)
end

local function OnExtinguishFn(inst)
    inst.SoundEmitter:KillSound("hiss")
    DefaultExtinguishFn(inst)
end

local function OnExplodeFn(inst)
    inst.SoundEmitter:KillSound("hiss")
    SpawnPrefab("explode_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnWavesSW(inst, 6, 360, 5)	
	SpawnPrefab("bombsplash").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/splash_large")	
end

local function OnExplodeFn2(inst)
    inst.SoundEmitter:KillSound("hiss")
    SpawnPrefab("explode_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function OnPutInInv(inst, owner)
    if owner.prefab == "mole" then
        inst.components.explosive:OnBurnt()
    end
end

local function OnHitFn(inst)
	if inst.components.burnable then
		inst.components.burnable:Ignite()
	end
	if inst.components.freezable then
		inst.components.freezable:Unfreeze()
	end
	if inst.components.health then
		inst.components.health:DoFireDamage(0)
	end
end


local function onhammered2(inst, player)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	if player and player.components.inventory then
	local gunpowder = SpawnPrefab("gunpowder")	
	player.components.inventory:GiveItem(gunpowder)
	end
--	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhammered(inst, player)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("gunpowder_barrel.png")

    MakeInventoryPhysics(inst)
	inst:SetPhysicsRadiusOverride(1.8)
	MakeWaterObstaclePhysics(inst, 0.5, 0.5, 0.5)

	inst.AnimState:SetBank("gunpowder_barrel")
	inst.AnimState:SetBuild("gunpowder_barrel")
	inst.AnimState:PlayAnimation("idle_water", true)

    inst:AddTag("molebait")
    inst:AddTag("explosive")
    inst:AddTag("redbarrel")
	inst:AddTag("ignorewalkableplatforms")	
	inst:AddTag("tropicalspawner")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, 3 + math.random() * 3)
    MakeSmallPropagator(inst)
    --V2C: Remove default OnBurnt handler, as it conflicts with
    --explosive component's OnBurnt handler for removing itself
    inst.components.burnable:SetOnBurntFn(nil)
    inst.components.burnable:SetOnIgniteFn(OnIgniteFn)
    inst.components.burnable:SetOnExtinguishFn(OnExtinguishFn)

    inst:AddComponent("explosive")
    inst.components.explosive:SetOnExplodeFn(OnExplodeFn)
	inst.components.explosive.explosiverange = 6
    inst.components.explosive.explosivedamage = 500
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered2)	

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(800)

	inst:AddComponent("combat")
	inst.components.combat:SetOnHit(OnHitFn)	
	
    inst:AddComponent("bait")
	
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"gunpowder"}) 	
	
    inst:ListenForEvent("hit_boat", function(inst) 
        OnHitFn(inst) 
    end)	
	
    local ondas = SpawnPrefab("float_fx_front")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_front_small", true)
	ondas.Transform:SetScale(1.5, 1.5, 1.5)
	
    local ondas = SpawnPrefab("float_fx_back")
	ondas.entity:SetParent(inst.entity)
	ondas.Transform:SetPosition(0, 0, 0)
    ondas.AnimState:PlayAnimation("idle_back_small", true)	
	ondas.Transform:SetScale(1.5, 1.5, 1.5)
	
	
    inst.AnimState:SetFloatParams(-0.05, 1.0, 1)		

    MakeHauntableLaunchAndIgnite(inst)
    return inst
end

local function fn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("gunpowder_barrel.png")

    MakeInventoryPhysics(inst)
	MakeWaterObstaclePhysics(inst, 0.5, 0.5, 0.5)

	inst.AnimState:SetBank("gunpowder_barrel")
	inst.AnimState:SetBuild("gunpowder_barrel")
	inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("molebait")
    inst:AddTag("explosive")
    inst:AddTag("redbarrel")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, 3 + math.random() * 3)
    MakeSmallPropagator(inst)
    inst.components.burnable:SetOnBurntFn(nil)
    inst.components.burnable:SetOnIgniteFn(OnIgniteFn)
    inst.components.burnable:SetOnExtinguishFn(OnExtinguishFn)

    inst:AddComponent("explosive")
    inst.components.explosive:SetOnExplodeFn(OnExplodeFn2)
	inst.components.explosive.explosiverange = 6
    inst.components.explosive.explosivedamage = 500
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)

	inst:AddComponent("combat")
	inst.components.combat:SetOnHit(OnHitFn)	
	
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"gunpowder"}) 	
	
	
    inst:AddComponent("bait")
	
    inst:ListenForEvent("hit_boat", function(inst) 
        OnHitFn(inst) 
    end)	
			

    MakeHauntableLaunchAndIgnite(inst)
    return inst
end

return Prefab( "common/inventory/redbarrel", fn, assets, prefabs),
	   Prefab( "common/inventory/redbarrelunderwater", fn2, assets, prefabs)
