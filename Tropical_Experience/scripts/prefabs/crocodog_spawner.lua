local prefabs = 
{
	"crocodog",
	"poisoncrocodog",
	"watercrocodog",
}

local function oninit(inst)
local dado = math.random(1,3)

local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()

if dado == 1 then
local croco = SpawnPrefab("crocodog")
croco.Transform:SetPosition(x,y ,z)
end

if dado == 2 then
local croco = SpawnPrefab("poisoncrocodog")
croco.Transform:SetPosition(x,y ,z)
end

if dado == 1 then
local croco = SpawnPrefab("watercrocodog")
croco.Transform:SetPosition(x,y ,z)
end

inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()

	inst:AddTag("NOCLICK")
	inst:DoTaskInTime(0, oninit)

    return inst
end

return Prefab( "common/crocodog_spawner", fn, nil, prefabs)