local assets =
{
	Asset("ANIM", "anim/lotus.zip"),
	Asset("SOUND", "sound/common.fsb"),
    Asset("MINIMAP_IMAGE", "lotus"),    
}

local prefabs =
{
  "bill"
}    

local LOTUS_REGROW_TIME = 480*5

local function IsWater(tile)
	return tile == GROUND.OCEAN_COASTAL or 
		tile == GROUND.OCEAN_COASTAL_SHORE or 
		tile == GROUND.OCEAN_SWELL or
		tile == GROUND.OCEAN_ROUGH or 
		tile == GROUND.OCEAN_BRINEPOOL or 
		tile == GROUND.OCEAN_BRINEPOOL_SHORE or 
		tile == GROUND.OCEAN_WATERLOG or
		tile == GROUND.OCEAN_HAZARDOUS	
end

local BILL_SPAWN_CHANCE = 0.2

local function groundtest(inst)
local map = TheWorld.Map
local ex, ey, ez = inst.Transform:GetWorldPosition()
local posicao1 = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez+4))
local posicao2 = map:GetTile(map:GetTileCoordsAtPoint(ex, ey, ez-4))
local posicao3 = map:GetTile(map:GetTileCoordsAtPoint(ex+4, ey, ez))
local posicao4 = map:GetTile(map:GetTileCoordsAtPoint(ex-4, ey, ez))

if posicao1 ~= (GROUND.OCEAN_SWELL) and posicao1 ~= (GROUND.OCEAN_WATERLOG) and posicao1 ~= (GROUND.OCEAN_BRINEPOOL) and posicao1 ~= (GROUND.OCEAN_BRINEPOOL_SHORE) and posicao1 ~= (GROUND.OCEAN_HAZARDOUS) and posicao1 ~= (GROUND.OCEAN_ROUGH) and posicao1 ~= (GROUND.OCEAN_COASTAL) and posicao1 ~= (GROUND.OCEAN_COASTAL_SHORE)
or posicao2 ~= (GROUND.OCEAN_SWELL) and posicao2 ~= (GROUND.OCEAN_WATERLOG) and posicao2 ~= (GROUND.OCEAN_BRINEPOOL) and posicao2 ~= (GROUND.OCEAN_BRINEPOOL_SHORE) and posicao2 ~= (GROUND.OCEAN_HAZARDOUS) and posicao2 ~= (GROUND.OCEAN_ROUGH) and posicao2 ~= (GROUND.OCEAN_COASTAL) and posicao2 ~= (GROUND.OCEAN_COASTAL_SHORE)
or posicao3 ~= (GROUND.OCEAN_SWELL) and posicao3 ~= (GROUND.OCEAN_WATERLOG) and posicao3 ~= (GROUND.OCEAN_BRINEPOOL) and posicao3 ~= (GROUND.OCEAN_BRINEPOOL_SHORE) and posicao3 ~= (GROUND.OCEAN_HAZARDOUS) and posicao3 ~= (GROUND.OCEAN_ROUGH) and posicao3 ~= (GROUND.OCEAN_COASTAL) and posicao3 ~= (GROUND.OCEAN_COASTAL_SHORE)
or posicao4 ~= (GROUND.OCEAN_SWELL) and posicao4 ~= (GROUND.OCEAN_WATERLOG) and posicao4 ~= (GROUND.OCEAN_BRINEPOOL) and posicao4 ~= (GROUND.OCEAN_BRINEPOOL_SHORE) and posicao4 ~= (GROUND.OCEAN_HAZARDOUS) and posicao4 ~= (GROUND.OCEAN_ROUGH) and posicao4 ~= (GROUND.OCEAN_COASTAL) and posicao4 ~= (GROUND.OCEAN_COASTAL_SHORE) then

inst:Remove()
end
end


local function onpickedfn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
    inst.AnimState:PlayAnimation("picking")
    inst.AnimState:PushAnimation("picked")

    local target = FindEntity(inst, 50, function(item) return item:HasTag("platapine") end)
    print("BILL_SPAWN_CHANCE",BILL_SPAWN_CHANCE)
    if not target and math.random() < BILL_SPAWN_CHANCE then 
        local x, y, z = inst.Transform:GetWorldPosition()
        local bill = SpawnPrefab("bill")
        bill.components.combat.target = nil
        local spawnDistFromLotus = 12
        local nearbyPositions = {{x, z + spawnDistFromLotus}, {x, z - spawnDistFromLotus}, {x + spawnDistFromLotus, z}, {x - spawnDistFromLotus, z}}

        for posIndex = 1, 4 do
            local nearbyPosition = nearbyPositions[posIndex]
            local tile = TheWorld.Map:GetTileAtPoint(nearbyPosition[1], y, nearbyPosition[2])

            if IsWater(tile) then
                bill.Transform:SetPosition(nearbyPosition[1], y, nearbyPosition[2])
                bill.sg:GoToState("surface")
                break
            end
        end
    end
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle_plant", true)
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("picked")
end

local function ongustpick(inst)
    if inst.components.pickable and inst.components.pickable:CanBePicked() then
        inst.components.pickable:MakeEmpty()
        local x, y, z = inst.Transform:GetWorldPosition()
        local reeds = SpawnPrefab(inst.components.pickable.product)
        reeds.Transform:SetPosition(x, y, z)
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
	local minimap = inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, .25)

    anim:SetBank("lotus")
    anim:SetBuild("lotus")
    anim:PlayAnimation("idle_plant",true)
    anim:SetTime(math.random()*2)
    local color = 0.75 + math.random() * 0.25
    anim:SetMultColour(color, color, color, 1)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "lotus.png" )    

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("lotus_flower", LOTUS_REGROW_TIME)
	inst.components.pickable.onregenfn = onregenfn
	inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.product = "lotus_flower"

    inst.components.pickable.SetRegenTime = 120

    inst:AddComponent("inspectable")
--[[
    inst:AddComponent("blowinwindgust")
    inst.components.blowinwindgust:SetWindSpeedThreshold(TUNING.REEDS_WINDBLOWN_SPEED)
    inst.components.blowinwindgust:SetDestroyChance(TUNING.REEDS_WINDBLOWN_FALL_CHANCE)
    inst.components.blowinwindgust:SetDestroyFn(ongustpick)
    inst.components.blowinwindgust:Start()
    
    ]]
    ---------------------        
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

--    inst:AddComponent("appeasement")
--    inst.components.appeasement.appeasementvalue = TUNING.WRATH_SMALL
    
	--MakeSmallBurnable(inst, TUNING.SMALL_FUEL)
    --MakeSmallPropagator(inst)
	MakeNoGrowInWinter(inst)    
    ---------------------   

    inst:WatchWorldState("stopday", function()
        inst:DoTaskInTime(math.random()*10, function(inst) 
            if inst.components.pickable and inst.components.pickable.canbepicked then
                anim:PlayAnimation("close")
                anim:PushAnimation("idle_plant_close")
                inst.closed = true
            end
        end)
    end)

    inst:WatchWorldState("startday", function()
        inst:DoTaskInTime(math.random()*10, function(inst) 
            if inst.components.pickable and inst.components.pickable.canbepicked and inst.closed then
                inst.closed = nil
                anim:PlayAnimation("open")
                anim:PushAnimation("idle_plant", true)
            end
        end)
    end) 

    inst.OnLoad = function(inst)
        if TheWorld.state.isday and inst.components.pickable and inst.components.pickable.canbepicked then
            anim:PlayAnimation("idle_plant", true)
        elseif inst.components.pickable and inst.components.pickable.canbepicked  then
            anim:PlayAnimation("idle_plant_close", true)
        end
    end
	
	
	
	inst:DoTaskInTime(0, groundtest)	

    return inst
end

return Prefab( "forest/objects/lotus", fn, assets, prefabs)
