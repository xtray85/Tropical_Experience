local CANOPY_SHADOW_DATA = require("prefabs/canopyshadows")

local assets =
{
    Asset("ANIM", "anim/pillar_tree.zip"),
    Asset("SOUND", "sound/tentacle.fsb"),
    Asset("MINIMAP_IMAGE", "pillar_tree"),
	Asset("SCRIPT", "scripts/prefabs/canopyshadows.lua"),
}

local prefabs = 
{
    "glowfly",
}


local small_ram_products =
{
    "vine",
    "nectar_pod",
    "snakefall",
    "oceantree_leaf_fx_fall",
    "oceantree_leaf_fx_fall",
}

local ram_products_to_refabs = {}
for _, v in ipairs(small_ram_products) do
    ram_products_to_refabs[v] = true
end
for k, v in pairs(ram_products_to_refabs) do
    table.insert(prefabs, k)
end


local DROP_ITEMS_DIST_MIN = 8
local DROP_ITEMS_DIST_VARIANCE = 12

local NUM_DROP_SMALL_ITEMS_MIN = 10
local NUM_DROP_SMALL_ITEMS_MAX = 14

local DROPPED_ITEMS_SPAWN_HEIGHT = 10

local NEW_VINES_SPAWN_RADIUS_MIN = 6

local ATTEMPT_DROP_OCEANTREENUT_MAX_ATTEMPTS = 5
local ATTEMPT_DROP_OCEANTREENUT_RADIUS = 6


local MIN = TUNING.SHADE_CANOPY_RANGE_SMALL
local MAX = MIN + TUNING.WATERTREE_PILLAR_CANOPY_BUFFER

local function OnFar(inst)
    if inst.players then
        local x, y, z = inst.Transform:GetWorldPosition()
        local testset = {}
        for player,i in pairs(inst.players)do
            testset[player] = true        
        end

        for i,player in ipairs(FindPlayersInRangeSq(x, y, z, MAX*MAX))do
            if testset[player] then
                testset[player] = false
            end
        end

        for player,i in pairs(testset)do
            if i == true then
                if player.treepillar then
                   player.treepillar = player.treepillar - 1
                   if player.treepillar == 0 then
--                       player:PushEvent("onchangecanopyzone", false)
					   player:RemoveTag("mostraselva") 
                   end
                end
                inst.players[player] = nil
            end
        end
    end
end

local function OnNear(inst,player)
    if not inst.players then
        inst.players = {}
    end

    inst.players[player] = true

    if not player.treepillar then
        player.treepillar = 0
    end
    player.treepillar = player.treepillar + 1
    if player.treepillar == 1 then
--        player:PushEvent("onchangecanopyzone", true)
		player:AddTag("mostraselva") 
    end
end

local function removecanopyshadow(inst)
    if inst.canopy_data ~= nil then
        for _, shadetile_key in ipairs(inst.canopy_data.shadetile_keys) do
            if TheWorld.shadetiles[shadetile_key] ~= nil then
                TheWorld.shadetiles[shadetile_key] = TheWorld.shadetiles[shadetile_key] - 1

                if TheWorld.shadetiles[shadetile_key] <= 0 then
                    if TheWorld.shadetile_key_to_leaf_canopy_id[shadetile_key] ~= nil then
                        DespawnLeafCanopy(TheWorld.shadetile_key_to_leaf_canopy_id[shadetile_key])
                        TheWorld.shadetile_key_to_leaf_canopy_id[shadetile_key] = nil
                    end
                end
            end
        end

        for _, ray in ipairs(inst.canopy_data.lightrays) do
            ray:Remove()
        end
    end
end

local function removecanopy(inst)
    print("REMOVING CANOPU")
    if inst.roots then
        inst.roots:Remove()
    end
    if inst._ripples then
        inst._ripples:Remove()
    end

    if inst.players ~= nil then
        for k, v in pairs(inst.players) do
            if k:IsValid() then
                if k.canopytrees ~= nil then
                    k.canopytrees = k.canopytrees - 1
                    if k.canopytrees <= 0 then
                        k:PushEvent("onchangecanopyzone", false)
                    end
                end
            end
        end
    end
    inst._hascanopy:set(false)    
end

local OCEANTREENUT_BLOCKER_TAGS = { "tree" }
local function DropItems(inst)
    local ind = math.random(1, #inst.items_to_drop)
    local item_to_spawn = inst.items_to_drop[ind]

    local x, _, z = inst.Transform:GetWorldPosition()

    local item = SpawnPrefab(item_to_spawn)

    local dist = DROP_ITEMS_DIST_MIN + DROP_ITEMS_DIST_VARIANCE * math.random()
    local theta = math.random() * 2 * PI

    local spawn_x, spawn_z

        spawn_x, spawn_z = x + math.cos(theta) * dist, z + math.sin(theta) * dist
    
    item.Transform:SetPosition(spawn_x, DROPPED_ITEMS_SPAWN_HEIGHT, spawn_z)

    if #inst.items_to_drop <= 1 then
        inst.items_to_drop = nil
        inst.drop_items_task = nil
    else
        table.remove(inst.items_to_drop, ind)
        inst:DoTaskInTime(0.1, DropItems)
    end
end

local function generate_items_to_drop(inst)
    inst.items_to_drop = {}

    local num_small_items = math.random(NUM_DROP_SMALL_ITEMS_MIN, NUM_DROP_SMALL_ITEMS_MAX)
    for i = 1, num_small_items do
        table.insert(inst.items_to_drop, small_ram_products[math.random(1, #small_ram_products)])
    end
end

---------------------------------------------------------------------------------------------------

local VINE_TAGS = { "hangingvine" }
local function SpawnMissingVines(inst)
    local x, _, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, 0, z, MAX, VINE_TAGS)
    local num_existing_vines = ents ~= nil and #ents or 0

--    print("FOUND VINES", num_existing_vines)
    if num_existing_vines < TUNING.OCEANTREE_VINE_DROP_MAX+ math.random(1,2)-1  then 

        local num_new_vines = math.random(1,2)
        local radius_variance = MAX - NEW_VINES_SPAWN_RADIUS_MIN
		local tipo = 
		     {
		     [1] = "hanging_vinefixo",
		     [2] = "grabbing_vinefixo",
		     }
        for i=1,num_new_vines do
            local vine = SpawnPrefab(tipo[math.random(1, 2)])
            local theta = math.random() * PI * 2
            local offset = NEW_VINES_SPAWN_RADIUS_MIN - 3 + radius_variance * math.random()
			if vine then
            vine.Transform:SetPosition(x + math.cos(theta) * offset, 0, z + math.sin(theta) * offset)
			end
        end
    end
end

local function OnCollide(inst, data)
    local boat_physics = data.other.components.boatphysics
    if boat_physics ~= nil then
        local hit_velocity = math.floor(math.abs(boat_physics:GetVelocity() * data.hit_dot_velocity) / boat_physics.max_velocity + 0.5)

        if hit_velocity > 0.8 then
            inst:DoTaskInTime(0, function()
                -- Delayed so that it is called after the inherent camera shake of boatphysics
                ShakeAllCamerasOnPlatform(CAMERASHAKE.SIDE, 2.8, .025, .3, data.other)
            end)

            if inst.drop_items_task == nil or next(inst.items_to_drop) == nil then

                local time = TheWorld.state.cycles + TheWorld.state.time
                if inst.last_ram_time == nil or time - inst.last_ram_time >= TUNING.WATERTREE_PILLAR_RAM_RECHARGE_TIME then
                    inst.last_ram_time = time

                    inst:DoTaskInTime(0.65, SpawnMissingVines)

                    generate_items_to_drop(inst)
                    inst:DoTaskInTime(0.5, DropItems)
                end
            end
        end
    end
end

local function OnPhaseChanged(inst, phase)
inst:DoTaskInTime(0.65, SpawnMissingVines)
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst:SetPrefabNameOverride("tree_pillar")
	MakeWaterObstaclePhysics(inst, 3, 2, 0.75)

    -- THIS WAS COMMENTED OUT BECAUSE THE ROC WAS BUMPING INTO IT. BUT I'M NOT SURE WHY IT WAS SET THAT WAY TO BEGIN WITH.
    --inst.Physics:SetCollisionGroup(COLLISION.GROUND)
    trans:SetScale(1,1,1)
    inst:AddTag("tree_pillar")    

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "pillar_tree.png" )

	anim:SetBank("pillar_tree")-- flash animation .fla 
	anim:SetBuild("pillar_tree")   -- art files

    anim:PlayAnimation("idle",true)
	inst.Transform:SetScale(0.8, 0.8, 0.8)	
	
    MakeInventoryFloatable(inst, "large", 0.8, {2, 1.5, 2})
    inst.components.floater.bob_percent = 0	
	
    local land_time = (POPULATING and math.random()*5*FRAMES) or 0
    inst:DoTaskInTime(land_time, function(inst)
        inst.components.floater:OnLandedServer()
    end)	
	
    if not TheNet:IsDedicated() then
        inst:AddComponent("distancefade")
        inst.components.distancefade:Setup(15,25)
    end
    
    inst._hascanopy = net_bool(inst.GUID, "oceantree_pillar._hascanopy", "hascanopydirty")
    inst._hascanopy:set(true)    
    inst:DoTaskInTime(0, function()    
        inst.canopy_data = CANOPY_SHADOW_DATA.spawnshadow(inst, math.floor(TUNING.SHADE_CANOPY_RANGE_SMALL/4), true)
    end)

    inst:ListenForEvent("hascanopydirty", function()
                if not inst._hascanopy:value() then 
                    removecanopyshadow(inst) 
                end
        end)	
	

	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
		return inst
	end 	
	
    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "glowfly"
    inst.components.childspawner:SetRegenPeriod(60)  
    inst.components.childspawner:SetSpawnPeriod(30)
    inst.components.childspawner:SetMaxChildren(2)
	inst.components.childspawner.wateronly = true
    inst.components.childspawner:StartSpawning()
	

	
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(MIN, MAX)
    inst.components.playerprox:SetOnPlayerFar(OnFar)
    inst.components.playerprox:SetOnPlayerNear(OnNear)	

    inst:ListenForEvent("on_collide", OnCollide)
    inst:ListenForEvent("phasechanged", function(src, phase) OnPhaseChanged(inst,phase) end, TheWorld)	
	
    
   return inst
end

local function fn2(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()
	inst.entity:AddTransform()  
	inst.persists = false
    return inst
end

return Prefab("watertree_pillar3", fn, assets, prefabs),
	   Prefab("common/inventory/pigbanditexit", fn2, assets, prefabs)
