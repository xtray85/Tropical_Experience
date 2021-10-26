local assets =
{
    Asset("ANIM", "anim/snowman.zip"),
}

local prefabs =
{
    --loot
    "snowitem",
    "bottlelantern",
    "lanternlightbottle",
}

local loot =
{
    "snowitem",
    "snowitem",
    "snowitem",
    "bottlelantern",
}

local function onhammered(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
	inst._light:Remove()
	
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local contagem = 0
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
local curr = map:GetTile(map:GetTileCoordsAtPoint(x,0,z))
local curr1 = map:GetTile(map:GetTileCoordsAtPoint(x-4,0,z))
local curr2 = map:GetTile(map:GetTileCoordsAtPoint(x+4,0,z))
local curr3 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z-4))
local curr4 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z+4))
contagem = contagem + 1
-------------------coloca os itens------------------------
if (curr == GROUND.WATER_MANGROVE and curr1 == GROUND.WATER_MANGROVE and curr2 == GROUND.WATER_MANGROVE and curr3 == GROUND.WATER_MANGROVE and curr4 == GROUND.WATER_MANGROVE) then 
local colocaitem = SpawnPrefab(inst.prefab) 
colocaitem.Transform:SetPosition(x, 0, z)
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0 or contagem == 500		
	inst:Remove()
end

local function onhit(inst,worker)
--    if inst.components.spawner.child ~= nil and inst.components.spawner.child.components.combat ~= nil then
--        inst.components.spawner.child.components.combat:SuggestTarget(worker)
--    end
    inst.AnimState:PlayAnimation("attack")
    inst.AnimState:PushAnimation("attack")
end


local function OnVacate(inst)
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function onremovelight(light)
    light._lantern._light = nil
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 0.33)

    inst.AnimState:SetBank("snowman")
    inst.AnimState:SetBuild("snowman")
    inst.AnimState:PlayAnimation("attack", true)

    inst:AddTag("structure")
    inst:AddTag("wildfireprotected")

    --MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")


    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

--    inst:AddComponent("spawner")
--    inst.components.spawner:Configure("pigguard", TUNING.TOTAL_DAY_TIME * 4)
--    inst.components.spawner:SetOnlySpawnOffscreen(true)
--    inst.components.spawner:SetOnVacateFn(OnVacate)
	
	inst._light = nil

	inst:DoTaskInTime(0, function() 
	if inst._light == nil then
    inst._light = SpawnPrefab("lanternlightbottle")
    inst._light._lantern = inst
    inst:ListenForEvent("onremove", onremovelight, inst._light)
	inst._light.Light:SetIntensity(Lerp(.4, .6, 1))
    inst._light.Light:SetRadius(Lerp(3, 5, 1))
    inst._light.Light:SetFalloff(.9)	
    end
    inst._light.entity:SetParent((inst).entity)
	end)	

    return inst
end

return Prefab("snowman", fn, assets, prefabs)
