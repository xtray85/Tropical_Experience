

local prefabs =
{
	"luggagechest",
}

local tesouroescondido =
{
		[1] = "tfwp_healing_staff",		
		[2] = "purplegem",	
		[3] = "orangegem",	
		[4] = "yellowgem",	
		[5] = "greengem",	
		[6] = "redgem",	
		[7] = "bluegem",	
		[8] = "supertelescope",	
		[9] = "spear_poison",	
		[10] = "boat_lantern",	
		[11] = "papyrus",	
		[12] = "tunacan",	
		[13] = "goldnugget",	
		[14] = "gears",	
		[15] = "rope",	
		[16] = "minerhat",	
		[17] = "dubloon",	
		[18] = "axeobsidian",	
		[19] = "telescope",	
		[20] = "captainhat",	
		[21] = "peg_leg",	
		[22] = "volcanostaff",	
		[23] = "footballhat",	
		[24] = "spear",	
		[25] = "goldenaxe",	
		[26] = "goldenshovel",	
		[27] = "goldenpickaxe",	
		[28] = "seatrap",	
		[29] = "compass",	
		[30] = "boneshard",	
		[31] = "transistor",	
		[32] = "gunpowder",	
		[33] = "heatrock",	
		[34] = "antidote",	
		[35] = "healingsalve",	
		[36] = "blowdart_sleep",	
		[37] = "nightsword",	
		[38] = "amulet",	
		[39] = "clothsail",	
		[40] = "boatrepairkit",	
		[41] = "coconade",	
		[42] = "boatcannon",	
		[43] = "snakeskinhat",	
		[44] = "armor_snakeskin",	
		[45] = "spear_launcher",	
		[46] = "piratehat",	
		[47] = "boomerang",	
		[48] = "snakeskin",	
		[49] = "strawhat",	
		[50] = "blubbersuit",	
		[51] = "nightmarefuel",	
		[52] = "obsidianmachete",	
		[53] = "trap_teeth",	
		[54] = "spear_obsidian",	
		[55] = "armorobsidian",	
		[56] = "goldenmachete",	
		[57] = "obsidianbomb",	
		[58] = "fabric",	
		[59] = "harpoon",	
		[60] = "umbrella",	
		[61] = "birdtrap",	
		[62] = "featherhat",	
		[63] = "beehat",	
		[64] = "bandage",	
		[65] = "armorwood",	
		[66] = "armormarble",	
		[67] = "blowdart_pipe",	
		[68] = "armorgrass",	
		[69] = "armor_seashell",	
		[70] = "cane",	
		[71] = "icestaff",	
		[72] = "firestaff",	
		[73] = "blowdart_fire",	
		[74] = "yellowamulet",	
		[75] = "armorruins",	
		[76] = "ruins_bat",	
		[77] = "ruinshat",	
		[78] = "cutgrass",	
		[79] = "charcoal",	
		[80] = "axe",	
		[81] = "hammer",	
		[82] = "shovel",	
		[83] = "bugnet",	
		[84] = "fishingrod",	
		[85] = "spidergland",	
		[86] = "silk",	
		[87] = "flint",
		[88] = "coral",
}


local function oninit(inst)
 
local chest = SpawnPrefab("luggagechest")
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
chest.Transform:SetPosition(x,y ,z)


-----pode vir até 9 moedas----------------------
for i = 1, 5 do
if math.random() > 0.5 then
local single = SpawnPrefab("dubloon")
chest.components.container:GiveItem(single)
end
end

for i = 1, 4 do
if math.random() > 0.5 then
local single = SpawnPrefab("coral")
chest.components.container:GiveItem(single)
end
end

-----pode vir até 8 tesouros----------------------
for i = 1, 8 do
if math.random() > 0.5 then
local single = SpawnPrefab(tesouroescondido[math.random(1, 88)])
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

return Prefab( "common/luggagechest_spawner", fn, nil, prefabs)
