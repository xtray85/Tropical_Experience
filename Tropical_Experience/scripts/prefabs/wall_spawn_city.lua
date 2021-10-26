local assets =
{	
}

local prefabs =
{
    "wall_limestone",
}

local function walls(inst)

local tipodemuro = "wall_limestone"
local tipodegate = "log"
local x, y, z = inst.Transform:GetWorldPosition()
local POS = {}
local POS2 = {}
for x = -42, 42 do
for z = -42, 42 do
if x == -42 or x == 42 or z == -42 or z == 42 then

if x ~= -2 and x ~= -1 and x ~= 0 and x ~= 1 and x ~= 2 then 
if z ~= -2 and z ~= -1 and z ~= 0 and z ~= 1 and z ~= 2 then 
table.insert(POS, { x = x, z = z })
end

end



if x == -2 or x == -1 or x == 0 or x == 1 or x == 2 
or z == -2 or z == -1 or z == 0 or z == 1 or z == 2 then 
table.insert(POS2, { x = x, z = z })
end


end
end
end

local count = 0
for _,v in pairs(POS) do
count = count + 1
local part = SpawnPrefab(tipodemuro)
part.Transform:SetPosition(x + v.x, 0, z + v.z)
end	

local count2 = 0
for _,v in pairs(POS2) do
count2 = count2 + 1
--local part = SpawnPrefab(tipodegate)
--part.Transform:SetPosition(x + v.x, 0, z + v.z)
end	
	
	
	inst:Remove()
end

local function spawner()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst:AddTag("DECOR")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	inst:DoTaskInTime(0, walls)
	
    return inst
end

return Prefab("hedge_spawner", spawner, assets, prefabs)