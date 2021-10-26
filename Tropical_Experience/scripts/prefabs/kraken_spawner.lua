local prefabs =
{
    "slipstor",
}

local respawndays = 20  --revive em 8 dias

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then

local map = TheWorld.Map
local x
local z

repeat
x = math.random(-800,800)
z = math.random(-800,800)
local curr = map:GetTile(map:GetTileCoordsAtPoint(x,0,z))
until
curr == GROUND.OCEAN_COASTAL
local tesouro = SpawnPrefab("kraken").Transform:SetPosition(x, 0, z)
inst:Remove()
    end
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    --[[Non-networked entity]]

    inst:AddTag("CLASSIFIED")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
	inst.components.timer:StartTimer("spawndelay", 60*8*respawndays)

    return inst
end

return Prefab("kraken_spawner", fn, nil, prefabs)
