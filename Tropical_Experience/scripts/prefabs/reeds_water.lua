local assets =
{
    Asset("ANIM", "anim/grass_inwater.zip"),
    Asset("ANIM", "anim/reeds_water_build.zip"),
    Asset("SOUND", "sound/common.fsb")
}

local prefabs =
{
    "cutreeds",
}

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
end

local function onregenfn(inst)
    inst.AnimState:PlayAnimation("grow")
    inst.AnimState:PushAnimation("idle", true)
end

local function makeemptyfn(inst)
    inst.AnimState:PlayAnimation("picked")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst, nil, 0.7)
    inst.MiniMapEntity:SetIcon("reeds.png")

    inst:AddTag("plant")

    inst.AnimState:SetBank("grass_inwater")
    inst.AnimState:SetBuild("reeds_water_build")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

--    inst.AnimState:SetTime(math.random() * 2)
--    local color = 0.75 + math.random() * 0.25
--    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
    inst.components.pickable:SetUp("cutreeds", TUNING.REEDS_REGROW_TIME)
    inst.components.pickable.onregenfn = onregenfn
    inst.components.pickable.onpickedfn = onpickedfn
    inst.components.pickable.makeemptyfn = makeemptyfn
    inst.components.pickable.SetRegenTime = 120

    inst:AddComponent("inspectable")

    ---------------------        
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_FUEL)
    MakeSmallPropagator(inst)
    MakeNoGrowInWinter(inst)
    MakeHauntableIgnite(inst)
    ---------------------   
	inst:DoTaskInTime(0, groundtest)
	
    return inst
end

return Prefab( "reeds_water", fn, assets, prefabs)
