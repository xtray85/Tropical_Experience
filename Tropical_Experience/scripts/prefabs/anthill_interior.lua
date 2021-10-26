require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/pisohamlet.zip"),
    Asset("ANIM", "anim/ant_cave_door.zip"),
    Asset("ANIM", "anim/wallhamletant.zip"),
	Asset("ANIM", "anim/maparuina.zip"),
}

local function getlocationoutofcenter(dist,hole,random,invert)
local pos =  (math.random()*((dist/2) - (hole/2))) + hole/2    
if invert or (random and math.random()<0.5) then
pos = pos *-1
end
return pos
end	

local function createroom(inst)
--------------------------------------------------inicio da criacao---------------------------------------

local x = 0
local y = 0
local z = 0
if TheWorld.components.contador then TheWorld.components.contador:Increment(1) end
local numerounico = TheWorld.components.contador.count

x = TheWorld.components.contador:GetX()
y = 0
z = TheWorld.components.contador:GetZ()

---------------------------cria a parede inicio------------------------------------------------------------------	
local tipodemuro = "wall_tigerpond"
---------------------------cria a parede inicio -------------------------------------
---------------------------parade dos aposento------------------------------------------------------------------	
	
	x, z = math.floor(x) + 0.5, math.floor(z) + 0.5 --matching with normal walls
	inst.Transform:SetPosition(x, 0, z)

	local POS = {}
	for x = -8.5, 9.5 do
		for z = -13.5, 13.5 do
		
			if x == -8.5 or x == 9.5 or z == -13.5 or z == 13.5 then
				table.insert(POS, { x = x, z = z })
			end
		end
	end


	local count = 0
	for _,v in pairs(POS) do
		count = count + 1
		local part = SpawnPrefab(tipodemuro)
		part.Transform:SetPosition(x + v.x, 0, z + v.z)
	end	

----------------parede do fundo---------------------------------------------
	local part = SpawnPrefab("wallinterioranthill")
	if part ~= nil then
	part.Transform:SetPosition(x -3.8, 0, z)
	part.Transform:SetRotation(0)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
------------------------piso-------------------------------------------------------------------------------
if inst.tipodesala == 2 then
	local part = SpawnPrefab("anthill_floor2")
	if part ~= nil then
	part.Transform:SetPosition(x-4, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
else	
	local part = SpawnPrefab("anthill_floor")
	if part ~= nil then
	part.Transform:SetPosition(x-4, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end
---------------------------------itens de dentro-------------------------------------------------------------------------
    local depth = 18
    local width = 26
	local saladarainha = false
	local chamber = false
	local comum = false
	local defalt = false
	local pertodarainha = false
	local entradadarainha = false	
	
if inst.tipodesala == 0 then
comum = true
defalt = true
end
if inst.tipodesala == 1 then
comum = true
defalt = true
entradadarainha = true
end	
if inst.tipodesala == 2 then
comum = true
chamber = true
pertodarainha = true
end	
if inst.tipodesala == 3 then
comum = true
saladarainha = true
end	

if inst.tipodesala == 8 then
comum = true
defalt = false
end
	
	
	
	
	
local function getlocationoutofcenter(dist, hole, valor, invert)
    local pos =  (math.random() * ((dist / 2) - (hole / 2))) + hole / 2    
    if invert or (valor and math.random() < 0.5) then
        pos = pos *-1
    end
    return pos
end	
------------------------------------adiciona para todos coisas dentro---------------------------------------------------------
local function getOffsetX()
    return (math.random() * 7) - (7 / 2)
end

local function getOffsetBackX()
    return (math.random(0, 0.3) * 7) - (7 / 2)
end

local function getOffsetFrontX()
    return (math.random(0.7, 1.0) * 7) - (7 / 2)
end

local function getOffsetZ()
    return (math.random() * 13) - (13 / 2)
end

local function getOffsetLhsZ()
    return (math.random(0, 0.3) * 13) - (13 / 2)
end

local function getOffsetRhsZ()
    return (math.random(0.7, 1.0) * 13) - (13 / 2)
end


-------------------adiciona as lanternas-----------------------------------
if not saladarainha then

if math.random(1, 2) == 1 then	
	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetLhsZ())
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end


if math.random(1, 2) == 1 then	
	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetRhsZ())
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

if math.random(1, 2) == 1 then	
	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetFrontX(), 0, z + getOffsetLhsZ())
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

if math.random(1, 2) == 1 then	
	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetFrontX(), 0, z +getOffsetRhsZ())
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		
end

end
----------------------------------------------------------------------

local salaaleatoria = math.random(1, 4)

----------------------entrada da chamber da rainha---------------------------------------------------
if entradadarainha == true then
salaaleatoria = 4
pertodarainha = true
	local part = SpawnPrefab("maze_anthill_queen")
	if part ~= nil then
	part.Transform:SetPosition(x +3, 0, z +3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

if inst.tipodesala == 8 then
salaaleatoria = 2
end

if salaaleatoria == 1 then
	local part = SpawnPrefab("antcombhome")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetLhsZ())
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("antcombhome")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetRhsZ())
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

--[[	
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
]]	
	
end
	
if salaaleatoria == 2 then	

--[[
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
]]	
end	

if salaaleatoria == 3 then	
	local part = SpawnPrefab("antcombhome")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetLhsZ())
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("antcombhome")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetLhsZ())
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end


--[[	
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
]]	
	
	local part = SpawnPrefab("antchest")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetLhsZ())
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("antchest")
	if part ~= nil then
	part.Transform:SetPosition(x + getOffsetBackX(), 0, z +getOffsetRhsZ())
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end
-------------------------------------adiciona soldados e lanterna na sala da rainha-------------------
if saladarainha then

--[[
for i=1,math.random(2, 4) do
	local part = SpawnPrefab("antman_warrior")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end	
]]

for i=1,math.random(2, 4) do
	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 5, true), 0, z +getlocationoutofcenter(width*0.65, 5, true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

end
-------------------------------------adiciona decoração do chamber-------------------
if chamber then

for i=1, math.random(8, 16) do
	local part = SpawnPrefab("rock_antcave")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z +getlocationoutofcenter(width*0.65, 3, true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
  
if math.random() < 0.3 then
	local part = SpawnPrefab("deco_hive_debris")
	if part ~= nil then
	part.Transform:SetPosition(x +depth*0.65 * math.random() - depth*0.65/2, 0, z +width*0.65 * math.random() - width*0.65/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

if math.random() < 0.3 then
	local part = SpawnPrefab("deco_hive_debris")
	if part ~= nil then
	part.Transform:SetPosition(x +depth*0.65 * math.random() - depth*0.65/2, 0, z +width*0.65 * math.random() - width*0.65/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end

local drips = math.random(1, 6) - 1
while drips > 0 do

local choice = math.random(1, 4)
if choice == 1 then
	local part = SpawnPrefab("deco_cave_honey_drip_1")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z +getlocationoutofcenter(width*0.65, 3, true))
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
elseif choice == 2 then
	local part = SpawnPrefab("deco_cave_ceiling_drip_2")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z +getlocationoutofcenter(width*0.65, 3, true))
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
elseif choice == 3 then
if math.random() < 0.5 then
	local part = SpawnPrefab("deco_cave_honey_drip_side_1")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
else
	local part = SpawnPrefab("deco_cave_honey_drip_side_1")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
elseif choice == 4 then
if math.random() < 0.5 then
	local part = SpawnPrefab("deco_cave_honey_drip_side_2")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
else
	local part = SpawnPrefab("deco_cave_honey_drip_side_2")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
end

drips = drips -1
end

end
--------------adiciona decoração comum-------------------------
if comum then
	local part = SpawnPrefab("deco_hive_cornerbeam")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("deco_hive_cornerbeam")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("deco_hive_pillar_side")
	if part ~= nil then
	part.Transform:SetPosition(x +depth/2, 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("deco_hive_pillar_side")
	if part ~= nil then
	part.Transform:SetPosition(x +depth/2, 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("deco_hive_floor_trim")
	if part ~= nil then
	part.Transform:SetPosition(x +depth/2, 0, z -width/4)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("deco_hive_floor_trim")
	if part ~= nil then
	part.Transform:SetPosition(x +depth/2, 0, z)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("deco_hive_floor_trim")
	if part ~= nil then
	part.Transform:SetPosition(x +depth/2, 0, z +width/4)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

----------------------------------------decoração normalmente habilitado com a comum-------------------------    
if defalt then
if math.random() < 0.5 then
	local part = SpawnPrefab("rock_antcave")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2*0.65 * math.random(), 0, z +getlocationoutofcenter(width*0.65, 3, true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

if math.random() < 0.5 then
	local part = SpawnPrefab("rock_antcave")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2*0.65 * math.random(), 0, z +getlocationoutofcenter(width*0.65, 3, true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

if math.random() < 0.5 then
	local part = SpawnPrefab("rock_antcave")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2*0.65 * math.random(), 0, z +getlocationoutofcenter(width*0.65, 3, true))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
  
if math.random() < 0.3 then
	local part = SpawnPrefab("deco_hive_debris")
	if part ~= nil then
	part.Transform:SetPosition(x +depth*0.65 * math.random() - depth*0.65/2, 0, z +width*0.65 * math.random() - width*0.65/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

if math.random() < 0.3 then
	local part = SpawnPrefab("deco_hive_debris")
	if part ~= nil then
	part.Transform:SetPosition(x +depth*0.65 * math.random() - depth*0.65/2, 0, z +width*0.65 * math.random() - width*0.65/2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end

local drips = math.random(1, 6) - 1
while drips > 0 do

local choice = math.random(1, 4)
if choice == 1 then
	local part = SpawnPrefab("deco_cave_honey_drip_1")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z +getlocationoutofcenter(width*0.65, 3, true))
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
elseif choice == 2 then
	local part = SpawnPrefab("deco_cave_ceiling_drip_2")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z +getlocationoutofcenter(width*0.65, 3, true))
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
elseif choice == 3 then
if math.random() < 0.5 then
	local part = SpawnPrefab("deco_cave_honey_drip_side_1")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
else
	local part = SpawnPrefab("deco_cave_honey_drip_side_1")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
elseif choice == 4 then
if math.random() < 0.5 then
	local part = SpawnPrefab("deco_cave_honey_drip_side_2")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z -width/2)
	part.Transform:SetRotation(-90)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
else
	local part = SpawnPrefab("deco_cave_honey_drip_side_2")
	if part ~= nil then
	part.Transform:SetPosition(x +getlocationoutofcenter(depth*0.65, 3, true), 0, z +width/2)
	part.Transform:SetRotation(180)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
end
end

drips = drips -1
end

end
----------------------------------------Adiciona sala da rainha------
if pertodarainha then
--[[
	for i=1,math.random(2, 5) do
	local part = SpawnPrefab("antman_warrior")
	if part ~= nil then
	part.Transform:SetPosition(x , 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	end	
]]
end

if saladarainha then
comum = true

	local part = SpawnPrefab("antqueen")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z +(depth/2) - 2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x -depth/2, 0, z +(-depth/2) + 2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z + (depth/2) + 1)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("ant_cave_lantern")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z +(-depth/2) - 1)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end		

-- Gross            
	local part = SpawnPrefab("throne_wall_large")
	if part ~= nil then
	part.Transform:SetPosition(x +1, 0, z +2.25)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +2.2, 0, z +2.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1.9, 0, z +3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1.6, 0, z +3.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1.3, 0, z +4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1, 0, z +4.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +0.7, 0, z +5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +0.4, 0, z +5.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +0.1, 0, z +6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -0.4, 0, z +6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3.25, 0, z +1.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3, 0, z +2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2.75, 0, z +2.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2.5, 0, z +3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2.25, 0, z +3.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2, 0, z +4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1.75, 0, z +4.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1.5, 0, z +5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1.25, 0, z +5.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1, 0, z +6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	
	
	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3.25, 0, z +1)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3.25, 0, z +0.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3.25, 0, z)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3.25, 0, z -0.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3.25, 0, z -1)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3.25, 0, z -1.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -3, 0, z -2)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2.75, 0, z -2.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2.5, 0, z -3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2.25, 0, z -3.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -2, 0, z -4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1.75, 0, z -4.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1.5, 0, z -5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1.25, 0, z -5.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -1, 0, z -6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall_large")
	if part ~= nil then
	part.Transform:SetPosition(x +1.5, 0, z -2.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +2, 0, z -3)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1.75, 0, z -3.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1.5, 0, z -4)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1.25, 0, z -4.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +1, 0, z -5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x +0.75, 0, z -5.5)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x, 0, z -6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end	

	local part = SpawnPrefab("throne_wall")
	if part ~= nil then
	part.Transform:SetPosition(x -0.5, 0, z -6)
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
end
			
	inst:Remove()
end


local function maintainantpop(inst)
        local pt = inst:GetPosition()
        local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 60, {"giantgrub"})
		local invader = GetClosestInstWithTag("player", inst, 20) 
--		print (#ents)
        if #ents < 1 and invader then
		
	local x, y, z = inst.Transform:GetWorldPosition()
    local projectile = SpawnPrefab("giantgrub")
    projectile.Transform:SetPosition(x+4, y, z)
--	projectile.sg:GoToState("walk")		
    end
end


---------------------------------pisos---------------------------------------------------------------------------
local function SpawnPiso1(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
	inst.AnimState:SetBank("pisohamlet")
	inst.AnimState:SetBuild("pisohamlet")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)
	inst.AnimState:SetScale(3.8, 3.8, 3.8)
	inst.AnimState:PlayAnimation("antcave_floor")
		
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")	
	inst:AddTag("alt_tile")
	inst:AddTag("vulcano_part")
	inst:AddTag("caveinterior")
	inst:AddTag("pisoanthill")		
	inst:AddTag("terremoto")
	inst:AddTag("canbuild")	
	inst:AddTag("blows_air")
	
--    inst:DoPeriodicTask( math.random(20, 40), function(inst) maintainantpop(inst) end )
    return inst
end

local function SpawnPiso2(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
	inst.AnimState:SetBank("pisohamlet")
	inst.AnimState:SetBuild("pisohamlet")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)
	inst.AnimState:SetScale(3.8, 3.8, 3.8)
	inst.AnimState:PlayAnimation("antcave_floor")
		
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")	
	inst:AddTag("alt_tile")
	inst:AddTag("vulcano_part")
	inst:AddTag("caveinterior")
	inst:AddTag("pisoanthillrainha")		
	inst:AddTag("terremoto")
	inst:AddTag("canbuild")	
	inst:AddTag("blows_air")
	
--    inst:DoPeriodicTask( math.random(20, 40), function(inst) maintainantpop(inst) end )
    return inst
end

local function SpawnPiso6(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	   
	inst.AnimState:SetBank("maparuina")
	inst.AnimState:SetBuild("maparuina")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
	inst.AnimState:SetSortOrder(10)
	inst.AnimState:SetScale(1.2, 1.2, 1.2)
	inst.AnimState:PlayAnimation("idleant") -- or ground_ruins_slab_blue
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")	
	
	inst:DoTaskInTime(0.5, function(inst)
	local piso = GetClosestInstWithTag("pisoanthill", inst, 25)
	if not piso then inst:Remove() end
	end)	
	
	

    return inst
end

local function SpawnPiso6a(inst)	
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	   
	inst.AnimState:SetBank("maparuina")
	inst.AnimState:SetBuild("maparuina")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
	inst.AnimState:SetSortOrder(10)
	inst.AnimState:SetScale(1.2, 1.2, 1.2)
	inst.AnimState:PlayAnimation("idleinicioant")
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")
    return inst
end

local function wall_common(build)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddNetwork()	
	inst.entity:AddAnimState()
    inst.AnimState:SetBank("wallhamletant")
    inst.AnimState:SetBuild("wallhamletant")
    inst.AnimState:PlayAnimation("antcave_wall_rock", true)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(7)      
	inst.AnimState:SetScale(4.5, 4.5, 4.5)      
			
	return inst
end

----------------------------------------------------------entrada-----------------------------------------------------------------------------
local function OnDoneTeleporting(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(5)
end
end

local function OnDoneTeleportingexit(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(5)
end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
		doer.mynetvarCameraMode:set(3)
		
local alvo = inst.components.teleporter.targetTeleporter
if alvo then
local piso = GetClosestInstWithTag("pisoanthill", alvo, 20)
local piso2 = GetClosestInstWithTag("pisoanthillrainha", alvo, 20)




if piso then
if inst.diadomonstro and inst.diadomonstro ~= TheWorld.state.cycles or not inst.diadomonstro then
inst.diadomonstro = TheWorld.state.cycles

	local x, y, z = piso.Transform:GetWorldPosition()
	
	
	
local bicho = math.random(1,9)

if bicho < 6 then		
	for i=1,math.random(2,3) do
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x+math.random(0,7), y, z+math.random(-4,4))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	end	
end	


if bicho == 6 then		
	for i=1,math.random(1,2) do
	local part = SpawnPrefab("giantgrub")
	if part ~= nil then
	part.Transform:SetPosition(x+math.random(0,7), y, z+math.random(-4,4))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	end	
end	
	

if bicho == 7 or bicho == 8 then
	for i=1,math.random(2,3) do
	local part = SpawnPrefab("antman")
	if part ~= nil then
	part.Transform:SetPosition(x+math.random(0,7), y, z+math.random(-4,4))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	end	

	
	for i=1,math.random(1,1) do
	local part = SpawnPrefab("giantgrub")
	if part ~= nil then
	part.Transform:SetPosition(x+math.random(0,7), y, z+math.random(-4,4))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	end	
end	
	
end	
end

if piso2 then
if inst.diadomonstro and inst.diadomonstro ~= TheWorld.state.cycles or not inst.diadomonstro then
inst.diadomonstro = TheWorld.state.cycles

	local x, y, z = piso2.Transform:GetWorldPosition()

	for i=1,math.random(2,5) do
	local part = SpawnPrefab("antman_warrior")
	if part ~= nil then
	part.Transform:SetPosition(x+math.random(0,7), y, z+math.random(-4,4))
	if part.components.health ~= nil then
	part.components.health:SetPercent(1)
	end
	end
	end	

end	
end
		
		
	end
		
		

		elseif inst.SoundEmitter ~= nil then
    end
end

local function OnActivateexterior(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)
		doer.mynetvarCameraMode:set(6)
        local other = inst.components.teleporter.targetTeleporter
        if other ~= nil then
            DeleteCloseEntsWithTag("WORM_DANGER", other, 15)
        end

        if doer.components.talker ~= nil then
            doer.components.talker:ShutUp()
        end
        --Sounds are triggered in player's stategraph
		elseif inst.SoundEmitter ~= nil then

    end
end



local function OnActivateByOther(inst, source, doer)
--    if not inst.sg:HasStateTag("open") then
--        inst.sg:GoToState("opening")
--    end
end

local function onaccept(inst, giver, item)
    inst.components.inventory:DropItem(item)
    inst.components.teleporter:Activate(item)
end

local function StartTravelSound(inst, doer)

end

local function turnoff(inst, light)
    if light then    	
        light:Enable(false)
    end
end

local lights =
{
	day = {rad=3,intensity=0.75,falloff=0.5,color={1,1,1}},
	dusk = {rad=2,intensity=0.75,falloff=0.5,color={1/1.8,1/1.8,1/1.8}},
	full = {rad=2,intensity=0.75,falloff=0.5,color={0.8/1.8,0.8/1.8,1/1.8}}
}

local phasefunctions = 
{
    day = function(inst)
	    if not inst:IsInLimbo() then inst.Light:Enable(true) end
        inst.components.lighttweener:StartTween(nil, lights.day.rad, lights.day.intensity, lights.day.falloff, {lights.day.color[1],lights.day.color[2],lights.day.color[3]}, 2)
    end,

    dusk = function(inst) 
        if not inst:IsInLimbo() then inst.Light:Enable(true) end       
        inst.components.lighttweener:StartTween(nil, lights.dusk.rad, lights.dusk.intensity, lights.dusk.falloff, {lights.dusk.color[1],lights.dusk.color[2],lights.dusk.color[3]}, 2)
    end,

    night = function(inst) 
        if TheWorld.state.moonphase == "full" then
            inst.components.lighttweener:StartTween(nil, lights.full.rad, lights.full.intensity, lights.full.falloff, {lights.full.color[1],lights.full.color[2],lights.full.color[3]}, 4)
        else
            inst.components.lighttweener:StartTween(nil, 0, 0, 1, {0,0,0}, 6, turnoff)
        end    
    end,
}

local function timechange(inst)    
    if TheWorld.state.isday then
    	if inst:HasTag("timechange_anims") then
        	inst.AnimState:PlayAnimation("to_day")
       		inst.AnimState:PushAnimation("day_loop", true)
    	end
        if inst.Light then
            phasefunctions["day"](inst)
        end
    elseif TheWorld.state.isnight then
    	if inst:HasTag("timechange_anims") then
       		inst.AnimState:PlayAnimation("to_night")
        	inst.AnimState:PushAnimation("night_loop", true)
    	end
        if inst.Light then
            phasefunctions["night"](inst)
        end
    elseif TheWorld.state.isdusk then
    	if inst:HasTag("timechange_anims") then
        	inst.AnimState:PlayAnimation("to_dusk")
        	inst.AnimState:PushAnimation("dusk_loop", true)
    	end
        if inst.Light then
            phasefunctions["dusk"](inst)
        end
    end
end

local function settimechange(inst)
	inst:AddComponent("lighttweener")
	inst.components.lighttweener:StartTween(inst.entity:AddLight(), lights.day.rad, lights.day.intensity, lights.day.falloff, {lights.day.color[1],lights.day.color[2],lights.day.color[3]}, 0)
	inst.Light:Enable(true)

	inst:WatchWorldState("isday", timechange)
	inst:WatchWorldState("isdusk", timechange)
	inst:WatchWorldState("isnight", timechange)  

	inst.timechanger = true
	timechange(inst)	
end

local function opendoor(inst, instant)
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/stone_door/slide")
	if inst.prefab == "pig_ruins_door_cima" then
	inst.AnimState:PlayAnimation("north_open")
	inst.AnimState:PushAnimation("north")	
	end
	if inst.prefab == "pig_ruins_door_baixo" then
	inst.AnimState:PlayAnimation("south_open")
	inst.AnimState:PushAnimation("south")	
	end
	if inst.prefab == "pig_ruins_door_esquerda" then
	inst.AnimState:PlayAnimation("east_open")
	inst.AnimState:PushAnimation("east")	
	end
	if inst.prefab == "pig_ruins_door_direita" then
	inst.AnimState:PlayAnimation("west_open")
	inst.AnimState:PushAnimation("west")	
	end
	
	inst.dooranimclosed = nil
	inst.components.teleporter.enabled = true
end

local function closedoor(inst, instant)
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/stone_door/close")
	if inst.prefab == "pig_ruins_door_cima" then
	inst.AnimState:PlayAnimation("north_shut")
	inst.AnimState:PushAnimation("north_closed")	
	end
	if inst.prefab == "pig_ruins_door_baixo" then
	inst.AnimState:PlayAnimation("south_shut")
	inst.AnimState:PushAnimation("south_closed")	
	end
	if inst.prefab == "pig_ruins_door_esquerda" then
	inst.AnimState:PlayAnimation("east_shut")
	inst.AnimState:PushAnimation("east_closed")	
	end
	if inst.prefab == "pig_ruins_door_direita" then
	inst.AnimState:PlayAnimation("west_shut")
	inst.AnimState:PushAnimation("west_closed")	
	end
	inst.dooranimclosed = true		
	inst.components.teleporter.enabled = false
end

local function OnSave(inst, data)
	if inst.timechanger then
		data.timechanger = true
	end
    if inst:HasTag("timechange_anims") then
    	data.timechange_anims = true
    end
    if inst:HasTag("lockable_door") then
    	data.lockable_door = true    	
    end
    if inst.dooranimclosed then
    	data.dooranimclosed = true
    end
    if inst:HasTag("guard_entrance") then
    	data.guard_entrance = true
    end
    if inst:HasTag("ruins_entrance")then
    	data.ruins_entrance = true
    end 
end


local function OnLoad(inst, data)
if data == nil then return end
    if data.timechanger then 
    	settimechange(inst)
    end    	
    if data.timechange_anims then
    	inst:AddTag("timechange_anims")
    	timechange(inst)
    end
    if data.lockable_door then
    	inst:AddTag("lockable_door")
    end
    if data.dooranimclosed then
	
	if inst.prefab == "pig_ruins_door_cima" then
	inst.AnimState:PushAnimation("north_closed")	
	end
	if inst.prefab == "pig_ruins_door_baixo" then
	inst.AnimState:PushAnimation("south_closed")	
	end
	if inst.prefab == "pig_ruins_door_esquerda" then
	inst.AnimState:PushAnimation("east_closed")	
	end
	if inst.prefab == "pig_ruins_door_direita" then
	inst.AnimState:PushAnimation("west_closed")	
	end
    end
	if data.guard_entrance then
    	inst:AddTag("guard_entrance")
    end
    if data.ruins_entrance then
    	inst:AddTag("ruins_entrance")
    end
end

local function OnHaunt(inst, haunter)
inst.components.teleporter:Activate(haunter)
end


local function fnescadaentrada()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("ant_cave_door")
    inst.AnimState:SetBuild("ant_cave_door")
    inst.AnimState:PlayAnimation("day_loop")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil


    settimechange(inst)

	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")
	inst:AddTag("timechange_anims")

    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false		
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivateexterior
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleportingexit)

	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad		
	
    inst:AddComponent("inventory")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)		
	
	inst:DoTaskInTime(10,	function(inst) if inst.components.teleporter.targetTeleporter == nil then  
for k,v in pairs(Ents) do
if v.prefab == "anthill" then
inst.components.teleporter.targetTeleporter = v
end
end	
	
	end end)

    return inst
end

local function fnescadacima()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("ant_cave_door")
    inst.AnimState:SetBuild("ant_cave_door")
    inst.AnimState:PlayAnimation("north")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil


    settimechange(inst)

	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false	
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad		
	
    inst:AddComponent("inventory")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)			
    return inst
end

local function fnescadabaixo()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("ant_cave_door")
    inst.AnimState:SetBuild("ant_cave_door")
    inst.AnimState:PlayAnimation("south")
--    inst.AnimState:SetLayer(LAYER_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false		
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad		
	
    inst:AddComponent("inventory")	
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)			
    return inst
end

local function fnescadaesquerda()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("ant_cave_door")
    inst.AnimState:SetBuild("ant_cave_door")
    inst.AnimState:PlayAnimation("east")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false		
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)
	
	inst:ListenForEvent("open", function() opendoor(inst) end)
	inst:ListenForEvent("close", function() closedoor(inst) end)	
    inst.OnSave = OnSave 
    inst.OnLoad = OnLoad	

    inst:AddComponent("inventory")
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)			
    return inst
end

local function fnescadadireita()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("ant_cave_door")
    inst.AnimState:SetBuild("ant_cave_door")
    inst.AnimState:PlayAnimation("west")
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--    inst.AnimState:SetSortOrder(3)
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

    inst:AddTag("antlion_sinkhole_blocker")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false		
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

    inst:AddComponent("inventory")	
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)			
    return inst
end

local function fnescadaqueen()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	
    inst.AnimState:SetBank("entrance")
    inst.AnimState:SetBuild("ant_queen_entrance")
    inst.AnimState:PlayAnimation("idle")
	inst.dooranimclosed = nil
	inst.timechanger = nil
	
    inst:AddTag("trader")
    inst:AddTag("alltrader")
	inst:AddTag("hamletteleport")

    inst:AddTag("antlion_sinkhole_blocker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader.onaccept = onaccept
    inst.components.trader.deleteitemonaccept = false	
	
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)

    inst:AddComponent("inventory")	
	
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(OnHaunt)			
    return inst
end

local function normalroom()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
    inst.AnimState:SetBuild("palace")
    inst.AnimState:SetBank("palace")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

	inst.tipodesala = 0
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
    createroom(inst)
    return inst
end

local function normalroominicio()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
    inst.AnimState:SetBuild("palace")
    inst.AnimState:SetBank("palace")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

	inst.tipodesala = 8
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
    createroom(inst)
    return inst
end

local function comumroom()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
    inst.AnimState:SetBuild("palace")
    inst.AnimState:SetBank("palace")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

	inst.tipodesala = 1
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
    createroom(inst)
    return inst
end

local function chamberroom()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
    inst.AnimState:SetBuild("palace")
    inst.AnimState:SetBank("palace")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

	inst.tipodesala = 2
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
    createroom(inst)
    return inst
end

local function saladarainharoom()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
    inst.AnimState:SetBuild("palace")
    inst.AnimState:SetBank("palace")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(2)

	inst.tipodesala = 3
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")
    createroom(inst)
    return inst
end

return 	Prefab("createanthilldefaltroom", normalroom, assets),
		Prefab("createanthilldefaltroominicio", normalroominicio, assets),
		Prefab("createanthillchamberroom", chamberroom, assets),
		Prefab("createanthillcomumroom", comumroom, assets),
		Prefab("createanthillqueenroom", saladarainharoom, assets),

		Prefab("anthill_floor", SpawnPiso1, assets),
		Prefab("anthill_floor2", SpawnPiso2, assets),		
		Prefab("wallinterioranthill", wall_common, assets),
		Prefab("mapaant", SpawnPiso6, assets),	
		Prefab("mapainicioant", SpawnPiso6a, assets),
		
		Prefab("anthill_door_entrada", fnescadaentrada, assets),
		Prefab("anthill_door_cima", fnescadacima, assets),
		Prefab("anthill_door_baixo", fnescadabaixo, assets),
		Prefab("anthill_door_esquerda", fnescadaesquerda, assets),
		Prefab("anthill_door_direita", fnescadadireita, assets),
		
		Prefab("anthill_door_queen", fnescadaqueen, assets)
		