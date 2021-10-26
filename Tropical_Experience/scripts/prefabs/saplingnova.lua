local assets =
{
    Asset("ANIM", "anim/sapling.zip"),
    Asset("ANIM", "anim/sapling_diseased_build.zip"),
    Asset("SOUND", "sound/common.fsb"),
}

local prefabs =
{
    "twigs",
    "dug_sapling",
    "spoiled_food",
}

local function ontransplantfn(inst)
    inst.components.pickable:MakeEmpty()
end

local function dig_up(inst, worker)
local pt = inst:GetPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
if tiletype == GROUND.SUBURB or tiletype == GROUND.FOUNDATION or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.LAWN or tiletype == GROUND.FIELDS  or tiletype == GROUND.CHECKEREDLAWN then
if worker and worker:HasTag("player") and not worker:HasTag("sneaky") then
local x, y, z = inst.Transform:GetWorldPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
local eles = TheSim:FindEntities(x,y,z, 40,{"guard"})
for k,guardas in pairs(eles) do 
if guardas.components.combat and guardas.components.combat.target == nil then guardas.components.combat:SetTarget(worker) end
end 
end
end
    if inst.components.pickable ~= nil and inst.components.lootdropper ~= nil then
        local withered = inst.components.witherable ~= nil and inst.components.witherable:IsWithered()

        if inst.components.pickable:CanBePicked() then
            inst.components.lootdropper:SpawnLootPrefab(inst.components.pickable.product)
        end

        inst.components.lootdropper:SpawnLootPrefab(
            (withered and "twigs")
            or "dug_sapling"
        )
    end
    inst:Remove()
end

local function onpickedfn(inst, picker)
local pt = inst:GetPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
if tiletype == GROUND.SUBURB or tiletype == GROUND.FOUNDATION or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.LAWN or tiletype == GROUND.FIELDS then
if  picker and  picker:HasTag("player") and not picker:HasTag("sneaky") then
local x, y, z = inst.Transform:GetWorldPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
local eles = TheSim:FindEntities(x,y,z, 40,{"guard"})
for k,guardas in pairs(eles) do 
if guardas.components.combat and guardas.components.combat.target == nil then guardas.components.combat:SetTarget( picker) end
end 
end
end
    inst.AnimState:PlayAnimation("rustle")
    inst.AnimState:PushAnimation("picked", false)
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("sway", true)
end

local function makeemptyfn(inst)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered() or
            inst.AnimState:IsCurrentAnimation("idle_dead")
        ) then
        inst.AnimState:PlayAnimation("dead_to_empty")
        inst.AnimState:PushAnimation("empty", false)
    else
        inst.AnimState:PlayAnimation("empty")
    end
end

local function makebarrenfn(inst, wasempty)
    if not POPULATING and
        (   inst.components.witherable ~= nil and
            inst.components.witherable:IsWithered()
        ) then
        inst.AnimState:PlayAnimation(wasempty and "empty_to_dead" or "full_to_dead")
        inst.AnimState:PushAnimation("idle_dead", false)
    else
        inst.AnimState:PlayAnimation("idle_dead")
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    inst.MiniMapEntity:SetIcon("sapling.png")

    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetBank("sapling")
    inst.AnimState:SetBuild("sapling")
    inst.AnimState:PlayAnimation("sway", true)

    inst:AddTag("renewable")
	inst:AddTag("silviculture") -- for silviculture book	
    inst:AddTag("saplingsw")	
	inst:AddTag("plant")	

    --witherable (from witherable component) added to pristine state for optimization
    inst:AddTag("witherable")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_sticks"

    inst.components.pickable:SetUp("twigs", TUNING.SAPLING_REGROW_TIME)
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.ontransplantfn = ontransplantfn
    inst.components.pickable.makebarrenfn = makebarrenfn

    inst:AddComponent("witherable")

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    if not GetGameModeProperty("disable_transplanting") then
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.DIG)
        inst.components.workable:SetOnFinishCallback(dig_up)
        inst.components.workable:SetWorkLeft(1)
    end

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    MakeNoGrowInWinter(inst)
    MakeHauntableIgnite(inst)
    ---------------------

    if TheNet:GetServerGameMode() == "quagmire" then
        event_server_data("quagmire", "prefabs/sapling").master_postinit(inst)
    end

    return inst
end

local DAMAGE_SCALE = 0.5
local function OnCollide(inst, data)
    local boat_physics = data.other.components.boatphysics
    if boat_physics ~= nil then
        local hit_velocity = math.floor(math.abs(boat_physics:GetVelocity() * data.hit_dot_velocity) * DAMAGE_SCALE / boat_physics.max_velocity + 0.5)
        inst.components.workable:WorkedBy(data.other, hit_velocity * TUNING.SEASTACK_MINE)
    end
end

local function fn1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    inst.MiniMapEntity:SetIcon("sapling.png")

    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:SetBank("sapling")
    inst.AnimState:SetBuild("sapling")
    inst.AnimState:PlayAnimation("sway", true)

    inst:AddTag("renewable")
	inst:AddTag("silviculture") -- for silviculture book	
    inst:AddTag("saplingsw")	
	inst:AddTag("plant")	

    --witherable (from witherable component) added to pristine state for optimization
    inst:AddTag("witherable")
    inst:AddTag("ignorewalkableplatforms")	
	
    inst:SetPhysicsRadiusOverride(1.8)
    MakeWaterObstaclePhysics(inst, 0.35, 2, 1.25)
	inst:SetPrefabNameOverride("sapling")
	
    MakeInventoryFloatable(inst, "med",  0, {1.1, 0.6, 1.1})
    inst.components.floater.bob_percent = 0

    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)		

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * 2)

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_sticks"

    inst.components.pickable:SetUp("twigs", TUNING.SAPLING_REGROW_TIME)
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.ontransplantfn = ontransplantfn
    inst.components.pickable.makebarrenfn = makebarrenfn

    inst:AddComponent("witherable")

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(dig_up)
    inst.components.workable:SetWorkLeft(1)

    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    MakeNoGrowInWinter(inst)
    MakeHauntableIgnite(inst)
    ---------------------
    inst:ListenForEvent("on_collide", OnCollide)
    return inst
end

return Prefab("saplingnova", fn, assets, prefabs),
	   Prefab("oceansapling", fn1, assets, prefabs)
