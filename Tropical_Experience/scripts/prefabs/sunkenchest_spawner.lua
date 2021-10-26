

local prefabs =
{
	"luggagechest",
}

local tesouroescondido =
{
		[1] = "coral",		
		[2] = "purplegem",	
		[3] = "orangegem",	
		[4] = "yellowgem",	
		[5] = "greengem",	
		[6] = "redgem",	
		[7] = "bluegem",	
		[8] = "gears",	
		[9] = "rope",	
		[10] = "minerhat",	
		[11] = "footballhat",	
		[12] = "spear",	
		[13] = "goldenaxe",	
		[14] = "goldenshovel",	
		[15] = "goldenpickaxe",	
		[16] = "compass",	
		[17] = "transistor",	
		[18] = "gunpowder",	
		[19] = "heatrock",	
		[20] = "healingsalve",	
		[21] = "amulet",	
		[22] = "boomerang",	
		[23] = "nightmarefuel",	
		[24] = "armorruins",	
		[25] = "ruins_bat",	
		[26] = "ruinshat",	
		[27] = "hammer",	
		[28] = "shovel",	
		[29] = "bugnet",	
		[30] = "fishingrod",	
		[31] = "spidergland",	
		[32] = "silk",	
		[33] = "flint",
		[34] = "sponge_piece",
		[35] = "iron_ore",
		[36] = "goldnugget",
		[37] = "snorkel",
}


local function oninit(inst)
 
local chest = SpawnPrefab("sunkenchest")
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
chest.Transform:SetPosition(x,y ,z)


-----pode vir até 9 tesouros----------------------
for i = 1, 9 do
if math.random() > 0.5 then
local single = SpawnPrefab(tesouroescondido[math.random(1, 37)])
chest.components.container:GiveItem(single)
end
end

inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	MakeWaterObstaclePhysics(inst, 1, 1, 1)
	inst:AddTag("NOCLICK")
	inst:DoTaskInTime(0, oninit)

    return inst
end

return Prefab( "common/sunkenchest_spawner", fn, nil, prefabs)
