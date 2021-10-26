require("worldsettingsutil")

local assets =
{
    Asset("ANIM", "anim/spider_mound.zip"),
    Asset("ANIM", "anim/uderwater_spider_mound.zip"),
}

local prefabs =
{
    "spider_hider",
    "spider_spitter",

    --loot
    "rocks",
    "silk",
    "spidergland",
    "silk",
    "fossil_piece",

    --fx
    "rock_break_fx",
}

SetSharedLootTable( 'spidercoralhole',
{
    {'rocks',       1.00},
    {'rocks',       1.00},
    {'silk',        1.00},
    {'fossil_piece',1.00},
    {'fossil_piece',0.50},
    {'spidergland', 0.25},
    {'silk',        0.50},
})

local function updateart(inst)
    local workleft = inst.components.workable.workleft
    inst.AnimState:PlayAnimation(
        (workleft > 6 and "full") or
        (workleft > 3 and "med") or "low"
    )
end

local function OnWork(inst, worker, workleft)
local workleft = inst.components.workable.workleft
if workleft == 7 or workleft == 4 or workleft == 1 then
local aranha = SpawnPrefab("spider_water")
if aranha then
aranha.Transform:SetPosition(inst.Transform:GetWorldPosition())
aranha.components.combat:SetTarget(worker)
end
end 


    if workleft <= 0 then
        local pt = inst:GetPosition()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pt:Get())

        local loot_dropper = inst.components.lootdropper

        inst:SetPhysicsRadiusOverride(nil)

        loot_dropper:DropLoot(pt)

        inst:Remove()
    else
        updateart(inst)
    end
end

local DAMAGE_SCALE = 0.5
local function OnCollide(inst, data)
    local boat_physics = data.other.components.boatphysics
    if boat_physics ~= nil then
        local hit_velocity = math.floor(math.abs(boat_physics:GetVelocity() * data.hit_dot_velocity) * DAMAGE_SCALE / boat_physics.max_velocity + 0.5)
        inst.components.workable:WorkedBy(data.other, hit_velocity * TUNING.SEASTACK_MINE)
    end
end

local function onsave(inst, data)
    data.stackid = inst.stackid
end

local NUM_STACK_TYPES = 5
local function onload(inst, data)
    inst.stackid = (data and data.stackid) or inst.stackid or math.random(NUM_STACK_TYPES)
    updateart(inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("spidercoralhole.png")

    inst:SetPhysicsRadiusOverride(2.35)

    MakeWaterObstaclePhysics(inst, 0.80, 2, 1.25)

    inst:AddTag("ignorewalkableplatforms")
--    inst:AddTag("seastack")

    inst.AnimState:SetBank("spider_mound")
    inst.AnimState:SetBuild("uderwater_spider_mound")
    inst.AnimState:PlayAnimation("full")	

    MakeInventoryFloatable(inst, "large", 0.1, {1.2, 0.9, 1.2})
    inst.components.floater.bob_percent = 0

    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)
	
	inst:SetPrefabNameOverride("spiderden")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('spidercoralhole')
    inst.components.lootdropper.max_speed = 2
    inst.components.lootdropper.min_speed = 0.3
    inst.components.lootdropper.y_speed = 14
    inst.components.lootdropper.y_speed_variance = 4
    inst.components.lootdropper.spawn_loot_inside_prefab = true

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.SEASTACK_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork)
    inst.components.workable.savestate = true

    inst:AddComponent("inspectable")

    MakeHauntableWork(inst)

    inst:ListenForEvent("on_collide", OnCollide)

    if not POPULATING then
        inst.stackid = math.random(NUM_STACK_TYPES)
        updateart(inst)
    end

    --------SaveLoad
    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("spidercoralhole", fn, assets, prefabs)
