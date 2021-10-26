local assets = 
{
Asset("ANIM", "anim/volcano_altar.zip"),
    Asset("ANIM", "anim/volcano_altar_fx.zip"),
}

local prefabs = 
{
	"lavaarena_creature_teleport_small_fx",
	"lavaarena_creature_teleport_medium_fx",
	"lavarenachest",
	"quagmire_coin1",
	"quagmire_coin2",
	"quagmire_coin3",
	"quagmire_coin4",
}

local armasdotesouro =
{
		[1] = "tfwp_healing_staff",		
		[2] = "tfwp_control_book",
		[3] = "tfwp_infernal_staff",
        [4] = "tfwp_lava_hammer",		
		[5] = "tfwp_dragon_dart",	
		[6] = "tfwp_spear_lance",		
		[7] = "tfwp_lava_dart",
		[8] = "tfwp_spear_gung",	
		[9] = "tfwp_summon_book",		
		[10] = "lavaarena_armor_hpdamager",
		[11] = "lavaarena_armor_hprecharger",
		[12] = "lavaarena_armor_hppetmastery",
		[13] = "lavaarena_armor_hpextraheavy",
		[14] = "lavaarena_armorextraheavy",
		[15] = "lavaarena_armorheavy",
		[16] = "lavaarena_armormediumrecharger",
		[17] = "lavaarena_armormediumdamager",
		[18] = "lavaarena_armormedium",
		[19] = "lavaarena_armorlightspeed",
		[20] = "lavaarena_armorlight",
		[21] = "lavaarena_lightdamagerhat",
		[22] = "lavaarena_strongdamagerhat",
		[23] = "lavaarena_feathercrownhat",
		[24] = "lavaarena_rechargerhat",
		[25] = "lavaarena_healingflowerhat",
		[26] = "lavaarena_tiaraflowerpetalshat",
		[27] = "lavaarena_eyecirclethat",
		[28] = "lavaarena_crowndamagerhat",
		[29] = "lavaarena_healinggarlandhat",
		[30] = "tfwp_heavy_sword",
    }
	
local battlespider =
{
[1] = "spiderb",
[2] = "spiderb1",
[3] = "spiderb2",
[4] = "spiderb2",
}

local battlehound =
{
[1] = "houndb",
[2] = "clayhoundb",
[3] = "firehoundb",
[4] = "icehoundb",
}

local battlemerm =
{
[1] = "mermb",
[2] = "mermb1",
[3] = "mermb2",
[4] = "mermb2",
}

local battleknight =
{
[1] = "knightb",
[2] = "bishopb",
[3] = "knight_nightmareb",
[4] = "bishop_nightmareb",
[5] = "knightb",
[6] = "bishopb",
[7] = "knight_nightmareb",
[8] = "bishop_nightmareb",
}

local battleboar =
{
[1] = "hatty_piggy_tfc",
[2] = "lizardman_tfc",
[3] = "hatty_piggy_tfc",
[4] = "lizardman_tfc",
[5] = "strange_scorpion_tfc",
}

local battlelizard =
{
[1] = "lizardman_tfc",
[2] = "strange_scorpion_tfc",
[3] = "spiky_turtle_tfc",
[4] = "spiky_monkey_tfc",
[5] = "lizardman_tfc",
[6] = "strange_scorpion_tfc",
[7] = "spiky_turtle_tfc",
[8] = "spiky_monkey_tfc",
}

local battlebossboar =
{
[1] = "hatty_piggy_tfc",
[2] = "lizardman_tfc",
[3] = "strange_scorpion_tfc",
[4] = "spiky_monkey_tfc",
[5] = "lizardman_tfc",
[6] = "strange_scorpion_tfc",
[7] = "spiky_turtle_tfc",
[8] = "spiky_monkey_tfc",
[9] = "bossboarte",
}


local battlerhinocebros =
{
[1] = "hatty_piggy_tfc",
[2] = "hatty_piggy_tfc",
[3] = "hatty_piggy_tfc",
[4] = "spiky_monkey_tfc",
[5] = "hatty_piggy_tfc",
[6] = "hatty_piggy_tfc",
[7] = "hatty_piggy_tfc",
[8] = "spiky_monkey_tfc",
[9] = "rhinodrillbros",
}

local battlebeetletaur =
{
[1] = "lizardman_tfc",
[2] = "lizardman_tfc",
[3] = "strange_scorpion_tfc",
[4] = "spiky_monkey_tfc",
[5] = "lizardman_tfc",
[6] = "strange_scorpion_tfc",
[7] = "strange_scorpion_tfc",
[8] = "spiky_monkey_tfc",
[9] = "beetletaur",
}

local function SpawnChest(inst)   
local chest = SpawnPrefab("lavarenachest")

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)

for i = 1, 2 do
local single = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single)

local single1 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single1)

local single2 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single2)

local single3 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single3)

if math.random() > 0.5 then
local single4 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single7)
end


if math.random() > 0.8 then
local single8 = SpawnPrefab("silk")
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab("spidergland")
chest.components.container:GiveItem(single8)
end

if math.random() > 0.8 then
local single9 = SpawnPrefab("silk")
chest.components.container:GiveItem(single9)
else
local single9 = SpawnPrefab("spidergland")
chest.components.container:GiveItem(single9)
end

end		
local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x+3, 0, pos.z+3)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
efeito.Transform:SetPosition(pos.x+3, 0, pos.z+3)

inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")



if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end

local function SpawnChest1(inst)   
local chest = SpawnPrefab("lavarenachest")

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)

--if inst.max1 == nil then
--inst.max1 = 1
--local parte = SpawnPrefab("quagmire_key_park")
--chest.components.container:GiveItem(parte)
--end

for i = 1, 2 do
local single = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single)

local single1 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single1)

local single2 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single2)

local single3 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single3)

if math.random() > 0.5 then
local single4 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single7)
end


if math.random() > 0.8 then
local single8 = SpawnPrefab("houndstooth")
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab("houndstooth")
chest.components.container:GiveItem(single8)
end

if math.random() > 0.8 then
local single9 = SpawnPrefab("houndstooth")
chest.components.container:GiveItem(single9)
else
local single9 = SpawnPrefab("houndstooth")
chest.components.container:GiveItem(single9)
end
end
		
local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x+3, 0, pos.z+3)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
efeito.Transform:SetPosition(pos.x+3, 0, pos.z+3)

inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")



if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end

local function SpawnChest2(inst)   
local chest = SpawnPrefab("lavarenachest")

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)

if inst.max2 == nil then
inst.max2 = 1
local parte = SpawnPrefab("teleportato_sw_ring")
chest.components.container:GiveItem(parte)
end

for i = 1, 2 do
local single = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single)

local single1 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single1)

local single2 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single2)

local single3 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single3)

if math.random() > 0.5 then
local single4 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single7)
end


if math.random() > 0.8 then
local single8 = SpawnPrefab("fish")
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab("fish")
chest.components.container:GiveItem(single8)
end

if math.random() > 0.8 then
local single9 = SpawnPrefab("fish")
chest.components.container:GiveItem(single9)
else
local single9 = SpawnPrefab("fish")
chest.components.container:GiveItem(single9)
end
end

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)
	
local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x+3, 0, pos.z+3)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
efeito.Transform:SetPosition(pos.x+3, 0, pos.z+3)

inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")



if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end

local function SpawnChest3(inst)   
local chest = SpawnPrefab("lavarenachest")

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)

if inst.max3 == nil then
inst.max3 = 1
local parte = SpawnPrefab("teleportato_sw_box")
chest.components.container:GiveItem(parte)
end

for i = 1, 2 do
local single = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single)

local single1 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single1)

local single2 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single2)

local single3 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single3)

if math.random() > 0.5 then
local single4 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single7)
end


if math.random() > 0.8 then
local single8 = SpawnPrefab("gears")
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab("gears")
chest.components.container:GiveItem(single8)
end

if math.random() > 0.8 then
local single9 = SpawnPrefab("gears")
chest.components.container:GiveItem(single9)
else
local single9 = SpawnPrefab("gears")
chest.components.container:GiveItem(single9)
end

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)
end

local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x+3, 0, pos.z+3)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
efeito.Transform:SetPosition(pos.x+3, 0, pos.z+3)

inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")



if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end


local function SpawnChest4(inst)   
local chest = SpawnPrefab("lavarenachest")

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)

if inst.max4 == nil then
inst.max4 = 1
local parte = SpawnPrefab("teleportato_sw_crank")
chest.components.container:GiveItem(parte)
end

for i = 1, 2 do
local single = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single)

local single1 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single1)

local single2 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single2)

local single3 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single3)

if math.random() > 0.5 then
local single4 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single7)
end


if math.random() > 0.8 then
local single8 = SpawnPrefab("honeycomb")
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab("honey")
chest.components.container:GiveItem(single8)
end

if math.random() > 0.8 then
local single9 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single9)
else
local single9 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single9)
end

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)	
end

local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x+3, 0, pos.z+3)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
efeito.Transform:SetPosition(pos.x+3, 0, pos.z+3)

inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")



if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end

local function SpawnChest5(inst)   
local chest = SpawnPrefab("lavarenachest")

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)

if inst.max5 == nil then
inst.max5 = 1
local parte = SpawnPrefab("teleportato_sw_potato")
chest.components.container:GiveItem(parte)
end

for i = 1, 2 do
local single = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single)

local single1 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single1)

local single2 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single2)

local single3 = SpawnPrefab("quagmire_coin1")
chest.components.container:GiveItem(single3)

if math.random() > 0.5 then
local single4 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab("quagmire_coin2")
chest.components.container:GiveItem(single7)
end


if math.random() > 0.8 then
local single8 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single8)
end

if math.random() > 0.8 then
local single9 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single9)
else
local single9 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single9)
end
end

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)


	
local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x+3, 0, pos.z+3)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
efeito.Transform:SetPosition(pos.x+3, 0, pos.z+3)

inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")



if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end


local function SpawnChest6(inst)   
local chest = SpawnPrefab("lavarenachest")

for i = 1, 2 do
local single = SpawnPrefab("tfwp_spear_gung")
chest.components.container:GiveItem(single)

local single1 = SpawnPrefab("tfwp_infernal_staff")
chest.components.container:GiveItem(single1)

local single2 = SpawnPrefab("tfwp_healing_staff")
chest.components.container:GiveItem(single2)

local single3 = SpawnPrefab("riledlucy")
chest.components.container:GiveItem(single3)

if math.random() > 0.5 then
local single4 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single7)
end


if math.random() > 0.8 then
local single8 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single8)
end

if math.random() > 0.8 then
local single9 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single9)
else
local single9 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single9)
end
end

local single10 = SpawnPrefab(armasdotesouro[math.random(1, 30)])
chest.components.container:GiveItem(single10)


	
local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x+3, 0, pos.z+3)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
efeito.Transform:SetPosition(pos.x+3, 0, pos.z+3)

inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")



if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end

--------------acaba o combate se jogadores morreram-----------------
local function fimdocombate(inst)   
inst.spider = 0 
inst.hound = 0 
inst.merm = 0 
inst.knight = 0 
inst.boar = 0 
inst.lizard = 0 
inst.bossboar = 0
inst.rhinocebros = 0
inst.beetletaur = 0
inst.arenaativa = 0
local porcao = GetClosestInstWithTag("porcao", inst, 60)
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")

if porcao then 
local a, b, c = porcao.Transform:GetWorldPosition()
porcao:Remove() 
efeito.Transform:SetPosition(a, b, c)
end

local pt = inst:GetPosition()
local procurainimigos = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"Arena"})
for k,achei in pairs(procurainimigos) do
if achei then
local a, b, c = achei.Transform:GetWorldPosition()
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
achei:Remove() 
efeito.Transform:SetPosition(a, b, c)
end
end


end

local function ItemTradeTest(inst, item)
if item.prefab == "spiderbattle" then return true end
if item.prefab == "houndbattle" then return true end
if item.prefab == "mermbattle" then return true end
if item.prefab == "boarbattle" then return true end
if item.prefab == "knightbattle" then return true end
if item.prefab == "lizardbattle" then return true end
if item.prefab == "bossboarbattle" then return true end
if item.prefab == "rhinocebrosbattle" then return true end
if item.prefab == "swineclopsbattle" then return true end
return false
end

local function ItemGet(inst, giver, item)
local pt = inst:GetPosition()
local jogadores = TheSim:FindEntities(pt.x, pt.y, pt.z, 70, {"player"})
for k,player in pairs(jogadores) do
if player.components.hunger then
player.components.hunger:DoDelta(500)
end
if player.components.sanity then
player.components.sanity:DoDelta(500)
end

if player.components.health then
player.components.health:DoDelta(500)
end
end


if item.prefab == "spiderbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.spider = 27
inst.arenaativa = 1
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "houndbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.hound = 28
inst.arenaativa = 2
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "mermbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.merm = 18
inst.arenaativa = 3
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "boarbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.boar = 24
inst.arenaativa = 4
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "knightbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.knight = 24
inst.arenaativa = 5
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "lizardbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.lizard = 24
inst.arenaativa = 6
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "bossboarbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.bossboar = 24
inst.arenaativa = 7
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "rhinocebrosbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.rhinocebros = 24
inst.arenaativa = 8
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

if item.prefab == "swineclopsbattle" then
inst.AnimState:PlayAnimation("unappeased", false)
inst.AnimState:PushAnimation("close", false)
inst.AnimState:PushAnimation("idle_close", false)
inst.beetletaur = 24
inst.arenaativa = 9
local efeito = SpawnPrefab("lavaarena_spectator")
local efeito2 = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+10, b, c)
efeito2.Transform:SetPosition(a+10, b, c)
end

inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_addpart", "teleportato_addpart")
end


local function ItemTest(inst, item, slot)
	return not item:HasTag("nonpotatable")
end

local function statusdabatalha(inst)
-- so aceita item se a arena nao estiver ativa 
if inst.spider + inst.hound + inst.merm + inst.knight + inst.boar + inst.lizard + inst.bossboar + inst.rhinocebros + inst.beetletaur > 0 then inst.components.trader:Disable() else inst.components.trader:Enable() end

if inst.arenaativa == 1 then
----------------exibe a contagem de aranhas-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"spider"}) 
local aranhas = tostring(GetTableSize(ents)) + inst.spider or 0
inst.components.talker:Say("Enemies Left "..aranhas.."")
-------------------libera a trava de entrada-----------------------
if inst.spider > 16 then inst.spiderwave = 1 elseif inst.spider > 7 then inst.spiderwave = 2 elseif inst.spider > 1 then inst.spiderwave = 3 else inst.spiderwave = 4 end

if aranhas == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest(inst)
return end
------------------------------gerador de aranhas------------------------------------------
if inst.spider  > 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 20 and aranhas - inst.spider < 6 then 
for i = 1, 3 do
local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battlespider[inst.spiderwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battlespider[inst.spiderwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battlespider[inst.spiderwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battlespider[inst.spiderwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battlespider[inst.spiderwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.spider = inst.spider-1
inst.contadorspider = 0 
end
end
end
end


if  inst.arenaativa == 2 then
----------------exibe a contagem de cachorros-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"hound"}) 
local cachorros = tostring(GetTableSize(ents)) + inst.hound or 0
inst.components.talker:Say("Enemies Left "..cachorros.."")
-------------------libera a trava de entrada-----------------------
if inst.hound > 21 then inst.houndwave = 1 elseif inst.hound > 14 then inst.houndwave = 2 elseif inst.hound > 7 then inst.houndwave = 3 else inst.houndwave = 4 end

if cachorros == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest1(inst)
return end
------------------------------gerador de cachorros------------------------------------------
if inst.hound > 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 20 and cachorros - inst.hound < 6 then 
for i = 1, 3 do
local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battlehound[inst.houndwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battlehound[inst.houndwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battlehound[inst.houndwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battlehound[inst.houndwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battlehound[inst.houndwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.hound = inst.hound - 1
inst.contadorspider = 0 
end
end
end
end

if  inst.arenaativa == 3 then
----------------exibe a contagem de mutantes-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"merm"}) 
local mutantes = tostring(GetTableSize(ents)) + inst.merm or 0
inst.components.talker:Say("Enemies Left "..mutantes.."")
-------------------libera a trava de entrada-----------------------
if inst.merm > 11 then inst.mermwave = 1 elseif inst.merm > 5 then inst.mermwave = 2 elseif inst.merm > 1 then inst.mermwave = 3 else inst.mermwave = 4 end


if mutantes == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest2(inst)
return end
------------------------------gerador de mutantes------------------------------------------
if inst.merm  > 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 20 and mutantes - inst.merm < 6 then 

for i = 1, 3 do
local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battlemerm[inst.mermwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battlemerm[inst.mermwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battlemerm[inst.mermwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battlemerm[inst.mermwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battlemerm[inst.mermwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.merm = inst.merm - 1
inst.contadorspider = 0 
end
end
end
end

if  inst.arenaativa == 4 then
----------------exibe a contagem de porcodomato-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"Arena"}) 
local porcodomato = tostring(GetTableSize(ents)) + inst.boar or 0
inst.components.talker:Say("Enemies Left "..porcodomato.."")
-------------------libera a trava de entrada-----------------------
if inst.boar > 16 then inst.boarwave = 1 elseif inst.boar > 14 then inst.boarwave = 2 elseif inst.boar > 6 then inst.boarwave = 3 elseif inst.boar > 2 then inst.boarwave = 4 else inst.boarwave = 5 end

if porcodomato == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest4(inst)
return end
------------------------------gerador de porcodomato------------------------------------------
if inst.boar ~= 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 10 and porcodomato - inst.boar < 6  then 

local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battleboar[inst.boarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battleboar[inst.boarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battleboar[inst.boarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battleboar[inst.boarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battleboar[inst.boarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.boar = inst.boar - 1
inst.contadorspider = 0 
end
end
end



if  inst.arenaativa == 5 then
----------------exibe a contagem de cavalos-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"Arena"}) 
local cavalos = tostring(GetTableSize(ents)) + inst.knight or 0
inst.components.talker:Say("Enemies Left "..cavalos.."")
-------------------libera a trava de entrada-----------------------
if inst.knight > 20 then inst.knightwave = 1 elseif inst.knight > 18 then inst.knightwave = 2 elseif inst.knight > 14 then inst.knightwave = 3 elseif inst.knight > 12 then inst.knightwave = 4 elseif inst.knight > 8 then inst.knightwave = 5 elseif inst.knight > 6 then inst.knightwave = 6 elseif inst.knight > 2 then inst.knightwave = 7 else inst.knightwave = 8 end

if cavalos == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest3(inst)
return end
------------------------------gerador de cavalos------------------------------------------
if inst.knight ~= 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 10 and cavalos - inst.knight < 6  then
local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battleknight[inst.knightwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battleknight[inst.knightwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battleknight[inst.knightwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battleknight[inst.knightwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battleknight[inst.knightwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.knight = inst.knight - 1
inst.contadorspider = 0 
end
end
end

if  inst.arenaativa == 6 then
----------------exibe a contagem de lagarto-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"Arena"}) 
local lagarto = tostring(GetTableSize(ents)) + inst.lizard or 0
inst.components.talker:Say("Enemies Left "..lagarto.."")
-------------------libera a trava de entrada-----------------------
if inst.lizard > 20 then inst.lizardwave = 1 elseif inst.lizard > 18 then inst.lizardwave = 2 elseif inst.lizard > 14 then inst.lizardwave = 3 elseif inst.lizard > 13 then inst.lizardwave = 4 elseif inst.lizard > 8 then inst.lizardwave = 5 elseif inst.lizard > 6 then inst.lizardwave = 6 elseif inst.lizard > 1 then inst.lizardwave = 7 else inst.lizardwave = 8 end

if lagarto == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest5(inst)
return end
------------------------------gerador de lagarto------------------------------------------
if inst.lizard ~= 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 20 and lagarto - inst.lizard < 6  then 

local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battlelizard[inst.lizardwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battlelizard[inst.lizardwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battlelizard[inst.lizardwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battlelizard[inst.lizardwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battlelizard[inst.lizardwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.lizard = inst.lizard - 1
inst.contadorspider = 0 
end
end
end



--------------------------bossboar battle-------------------------------------------------------------
if  inst.arenaativa == 7 then
----------------exibe a contagem de bossboarunit-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"Arena"}) 
local bossboarunit = tostring(GetTableSize(ents)) + inst.bossboar or 0
inst.components.talker:Say("Enemies Left "..bossboarunit.."")
-------------------libera a trava de entrada-----------------------
if inst.bossboar > 20 then inst.bossboarwave = 1 elseif inst.bossboar > 18 then inst.bossboarwave = 2 elseif inst.bossboar > 14 then inst.bossboarwave = 3 elseif inst.bossboar > 13 then inst.bossboarwave = 4 elseif inst.bossboar > 8 then inst.bossboarwave = 5 elseif inst.bossboar > 6 then inst.bossboarwave = 6 elseif inst.bossboar > 2 then inst.bossboarwave = 7 elseif inst.bossboar > 1 then inst.bossboarwave = 8 else inst.bossboarwave = 9 end

if bossboarunit == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest6(inst)
return end
------------------------------gerador de bossboarunit------------------------------------------
if inst.bossboar ~= 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 20 and bossboarunit - inst.bossboar < 6  then 

local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battlebossboar[inst.bossboarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battlebossboar[inst.bossboarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battlebossboar[inst.bossboarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battlebossboar[inst.bossboarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battlebossboar[inst.bossboarwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.bossboar = inst.bossboar - 1
inst.contadorspider = 0 
end
end
end



--------------------------rhinocebros battle-------------------------------------------------------------
if  inst.arenaativa == 8 then
----------------exibe a contagem de rhinocebrosunit-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"Arena"}) 
local rhinocebrosunit = tostring(GetTableSize(ents)) + inst.rhinocebros or 0
inst.components.talker:Say("Enemies Left "..rhinocebrosunit.."")
-------------------libera a trava de entrada-----------------------
if inst.rhinocebros > 20 then inst.rhinocebroswave = 1 elseif inst.rhinocebros > 18 then inst.rhinocebroswave = 2 elseif inst.rhinocebros > 14 then inst.rhinocebroswave = 3 elseif inst.rhinocebros > 13 then inst.rhinocebroswave = 4 elseif inst.rhinocebros > 8 then inst.rhinocebroswave = 5 elseif inst.rhinocebros > 6 then inst.rhinocebroswave = 6 elseif inst.rhinocebros > 2 then inst.rhinocebroswave = 7 elseif inst.rhinocebros > 1 then inst.rhinocebroswave = 8 else inst.rhinocebroswave = 9 end

if rhinocebrosunit == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest6(inst)
return end
------------------------------gerador de rhinocebrosunit------------------------------------------
if inst.rhinocebros ~= 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 10 and rhinocebrosunit - inst.rhinocebros < 6  then 

local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battlerhinocebros[inst.rhinocebroswave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battlerhinocebros[inst.rhinocebroswave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battlerhinocebros[inst.rhinocebroswave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battlerhinocebros[inst.rhinocebroswave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battlerhinocebros[inst.rhinocebroswave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.rhinocebros = inst.rhinocebros - 1
inst.contadorspider = 0 
end
end
end




--------------------------beetletaur battle-------------------------------------------------------------
if  inst.arenaativa == 9 then
----------------exibe a contagem de beetletaurunit-----------------------------
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"Arena"}) 
local beetletaurunit = tostring(GetTableSize(ents)) + inst.beetletaur or 0
inst.components.talker:Say("Enemies Left "..beetletaurunit.."")
-------------------libera a trava de entrada-----------------------
if inst.beetletaur > 20 then inst.beetletaurwave = 1 elseif inst.beetletaur > 18 then inst.beetletaurwave = 2 elseif inst.beetletaur > 14 then inst.beetletaurwave = 3 elseif inst.beetletaur > 13 then inst.beetletaurwave = 4 elseif inst.beetletaur > 8 then inst.beetletaurwave = 5 elseif inst.beetletaur > 6 then inst.beetletaurwave = 6 elseif inst.beetletaur > 2 then inst.beetletaurwave = 7 elseif inst.beetletaur > 1 then inst.beetletaurwave = 8 else inst.beetletaurwave = 9 end

if beetletaurunit == 0 then
inst.AnimState:PlayAnimation("open", false)
inst.AnimState:PushAnimation("idle_open", true)
SpawnChest6(inst)
return end
------------------------------gerador de beetletaurunit------------------------------------------
if inst.beetletaur ~= 0 then
inst.contadorspider = inst.contadorspider + 1
if inst.contadorspider > 10 and beetletaurunit - inst.beetletaur < 6  then 

local aparece = math.random(1, 5)

if aparece == 1 then
local portalinvoca1 = SpawnPrefab(battlebeetletaur[inst.beetletaurwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c)
end

if aparece == 2 then
local portalinvoca1 = SpawnPrefab(battlebeetletaur[inst.beetletaurwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c+35) 

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c+35) 
end

if aparece == 3 then
local portalinvoca1 = SpawnPrefab(battlebeetletaur[inst.beetletaurwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a-15, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a-15, b, c-35)
end

if aparece == 4 then
local portalinvoca1 = SpawnPrefab(battlebeetletaur[inst.beetletaurwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c+35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c+35)
end

if aparece == 5 then
local portalinvoca1 = SpawnPrefab(battlebeetletaur[inst.beetletaurwave])
portalinvoca1:AddTag("Arena")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+5, b, c-35)

local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
efeito.Transform:SetPosition(a+5, b, c-35)
end

inst.beetletaur = inst.beetletaur - 1
inst.contadorspider = 0 
end
end
end


end


local function OnActivate(inst, doer)
fimdocombate(inst)
return true
end

local function onsave(inst, data)
data.max1 = inst.max1
data.max2 = inst.max2
data.max3 = inst.max3
data.max4 = inst.max4
data.max5 = inst.max5
end

local function onload(inst, data)
if data ~= nil then
if data.max1 then inst.max1 = data.max1 end
if data.max2 then inst.max1 = data.max2 end
if data.max3 then inst.max1 = data.max3 end
if data.max4 then inst.max1 = data.max4 end
if data.max5 then inst.max1 = data.max5 end
end

fimdocombate(inst)	
end

 

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

inst.spider = 0
inst.spiderwave = 0
inst.hound = 0
inst.houndwave = 0
inst.merm = 0
inst.mermwave = 0
inst.knight = 0
inst.knightwave = 0
inst.boar = 0
inst.boarwave = 0
inst.lizard = 0
inst.lizardwave = 0
inst.bossboar = 0
inst.bossboarwave = 0
inst.rhinocebros = 0
inst.rhinocebroswave = 0
inst.beetletaur = 0
inst.beetletaurwave = 0
inst.contadorspider = 0
inst.arenaativa = 0


	anim:SetBank("volcano_altar_fx")
	anim:SetBuild("volcano_altar_fx")
	anim:PlayAnimation("idle_open", true)

	MakeObstaclePhysics(inst, 1.1)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetPriority( 5 )
	minimap:SetIcon("teleportato_base.png")
	minimap:SetPriority( 1 )
	
	inst.entity:AddSoundEmitter()

    inst.entity:AddLight()
    inst.Light:SetFalloff(0.4)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(10)
    inst.Light:SetColour(249/255, 130/255, 117/255)
    inst.Light:Enable(true)

    inst:AddComponent("talker")

	inst:AddTag("recipientedosmobs")
	inst:AddTag("resurrector")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ItemTradeTest)
	inst.components.trader.onaccept = ItemGet	

	inst:AddComponent("inspectable")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnActivate)

	inst:DoPeriodicTask(0.5, statusdabatalha)

--[[
local function oninit(inst)

local x, y, z = inst.Transform:GetLocalPosition()
local fx = SpawnPrefab("log")
if fx then fx.Transform:SetPosition(x+29, y, z+2) end

local x, y, z = inst.Transform:GetLocalPosition()
local fx = SpawnPrefab("log")
if fx then fx.Transform:SetPosition(x-29, y, z+2) end


local x, y, z = inst.Transform:GetLocalPosition()
local fx = SpawnPrefab("log")
if fx then fx.Transform:SetPosition(x, y, z+28) end

local x, y, z = inst.Transform:GetLocalPosition()
local fx = SpawnPrefab("log")
if fx then fx.Transform:SetPosition(x, y, z-25) end

local x, y, z = inst.Transform:GetLocalPosition()
local fx = SpawnPrefab("log")
if fx then fx.Transform:SetPosition(x, y, z-32) end


end

inst:DoTaskInTime(0, oninit)
]]	
	inst.OnSave = onsave
	inst.OnLoad = onload

	return inst
end

return Prefab( "common/objects/teleportato2", fn, assets, prefabs ) 

