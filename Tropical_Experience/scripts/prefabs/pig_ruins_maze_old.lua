require "prefabutil"

local assets =
{
Asset("ANIM", "anim/pisohamlet.zip"),
    Asset("ANIM", "anim/palace.zip"),
    Asset("ANIM", "anim/pig_shop_doormats.zip"),
    Asset("ANIM", "anim/palace_door.zip"),
    Asset("ANIM", "anim/interior_wall_decals_palace.zip"),
	Asset("SOUND", "sound/hound.fsb"),
    Asset("MINIMAP_IMAGE", "vamp_bat_cave"),
}

local vagner = {}
local trapdoortag = false
local function createmaze(inst)
vagner = {}
local function exitNumbers(room)
    local exits = room.exits
    local total = 0
    for i,exit in pairs(exits) do
        total = total + 1
    end
    if room.entrance1 or room.entrance2 then
        total = total + 1
    end
    return total
end

local interior_spawner = TheWorld.components.contador
interior_spawner:ResetID()
local nosecondexit = true
local rooms_to_make = inst.rooms_to_make
local entranceRoom = nil
local exitRoom = nil
local rooms = {}

local novo1 = 
{
nome = 1,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo1)

local novo2 = 
{
nome = 2,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo2)

local novo3 = 
{
nome = 3,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo3)

local novo4 = 
{
nome = 4,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo4)

local novo5 = 
{
nome = 5,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo5)

local novo6 = 
{
nome = 6,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo6)

local novo7 = 
{
nome = 7,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo7)

local novo8 = 
{
nome = 8,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo8)

local novo9 = 
{
nome = 9,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo9)

local novo10 = 
{
nome = 10,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo10)

local novo11 = 
{
nome = 11,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo11)

local novo12 = 
{
nome = 12,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo12)

local novo13 = 
{
nome = 13,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo13)

local novo14 = 
{
nome = 14,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo14)

local novo15 = 
{
nome = 15,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo15)

local novo16 = 
{
nome = 16,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo16)

local novo17 = 
{
nome = 17,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo17)

local novo18 = 
{
nome = 18,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo18)

local novo19 = 
{
nome = 19,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo19)

local novo20 = 
{
nome = 20,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo20)

local novo21 = 
{
nome = 21,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo21)

local novo22 = 
{
nome = 22,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo22)

local novo23 = 
{
nome = 23,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo23)

local novo24 = 
{
nome = 24,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo24)

local novo25 = 
{
nome = 25,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo25)

local novo26 = 
{
nome = 26,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo26)

local novo27 = 
{
nome = 27,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo27)

local novo28 = 
{
nome = 28,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo28)

local novo29 = 
{
nome = 29,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}
table.insert(vagner,novo29)

local novo30 = 
{
nome = 30,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}

table.insert(vagner,novo30)

local room = {
        x=0,
        y=0,
        idx = interior_spawner:GetNewID(),
        exits = {},
        blocked_exits = {interior_spawner:GetNorth()}, -- 3 == NORTH
        entrance1 = true,
    }   
	
local rooms_by_id = {}
rooms_by_id[room.idx] = room
table.insert(rooms,room)

while #rooms < rooms_to_make do
local dir = interior_spawner:GetDir()
local dir_opposite = interior_spawner:GetDirOpposite()
local dir_choice = math.random(#dir)
local fromroom = rooms[math.random(#rooms)]

local fail = false
        -- fail if this direction from the chosen room is blocked
for i,exit in ipairs(fromroom.blocked_exits) do
if interior_spawner:GetDir()[dir_choice] == exit then
    fail = true 
    end
end
        -- fail if this room of the maze is already set up.
if not fail then
    for i,checkroom in ipairs(rooms)do 
        if checkroom.x == fromroom.x + dir[dir_choice].x and checkroom.y == fromroom.y + dir[dir_choice].y then
            fail = true
            break
        end
    end
end

if not fail then

local newroom = {
x= fromroom.x + dir[dir_choice].x,
y= fromroom.y + dir[dir_choice].y,
idx = interior_spawner:GetNewID(),
exits = {},
blocked_exits = {},
}

fromroom.exits[dir[dir_choice]] = {
target_room = newroom.idx,
bank =  "doorway_ruins",
build = "pig_ruins_door",
room = fromroom.idx,
}

newroom.exits[dir_opposite[dir_choice]] = {
target_room = fromroom.idx,
bank =  "doorway_ruins",
build = "pig_ruins_door",
room = newroom.idx,
}

--if GetWorld().getworldgenoptions(GetWorld())["door_vines"] and GetWorld().getworldgenoptions(GetWorld())["door_vines"] == "never" then
--dungeondef.doorvines = nil
--end

--if dungeondef.doorvines and math.random() < dungeondef.doorvines then
--fromroom.exits[dir[dir_choice]].vined = true
--newroom.exits[dir_opposite[dir_choice]].vined = true
--end

rooms_by_id[newroom.idx] = newroom
table.insert(rooms, newroom)


--print("Da "..fromroom.idx.." para "..newroom.idx.." "..newroom.x.." "..newroom.y.." ")

local origem = 
{
nome = fromroom.idx,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}

local destino = 
{
nome = newroom.idx,
cima = nil,
baixo = nil,
esquerda = nil,
direita = nil,
saidacima = nil,
saidabaixo = nil,
saidaesquerda = nil,
saidadireita = nil,
numexits = nil,
trapdor = nil,
valorx = nil,
valorz = nil,
}

if fromroom.x == newroom.x and fromroom.y < newroom.y then
origem.cima = newroom.idx
destino.baixo = fromroom.idx
end

if fromroom.x == newroom.x and fromroom.y > newroom.y then
origem.baixo = newroom.idx
destino.cima = fromroom.idx
end

if fromroom.y == newroom.y and fromroom.x < newroom.x then
origem.direita = newroom.idx
destino.esquerda = fromroom.idx
end

if fromroom.y == newroom.y and fromroom.x > newroom.x then
origem.esquerda = newroom.idx
destino.direita = fromroom.idx
end

if vagner[1].nome == origem.nome then
if vagner[1].cima == nil then vagner[1].cima = origem.cima end
if vagner[1].baixo == nil then vagner[1].baixo = origem.baixo end
if vagner[1].esquerda == nil then vagner[1].esquerda = origem.esquerda end
if vagner[1].direita == nil then vagner[1].direita = origem.direita end
elseif vagner[1].nome == destino.nome then
if vagner[1].cima == nil then vagner[1].cima = destino.cima end
if vagner[1].baixo == nil then vagner[1].baixo = destino.baixo end
if vagner[1].esquerda == nil then vagner[1].esquerda = destino.esquerda end
if vagner[1].direita == nil then vagner[1].direita = destino.direita end
end

if vagner[2].nome == origem.nome then
if vagner[2].cima == nil then vagner[2].cima = origem.cima end
if vagner[2].baixo == nil then vagner[2].baixo = origem.baixo end
if vagner[2].esquerda == nil then vagner[2].esquerda = origem.esquerda end
if vagner[2].direita == nil then vagner[2].direita = origem.direita end
elseif vagner[2].nome == destino.nome then
if vagner[2].cima == nil then vagner[2].cima = destino.cima end
if vagner[2].baixo == nil then vagner[2].baixo = destino.baixo end
if vagner[2].esquerda == nil then vagner[2].esquerda = destino.esquerda end
if vagner[2].direita == nil then vagner[2].direita = destino.direita end
end

if vagner[3].nome == origem.nome then
if vagner[3].cima == nil then vagner[3].cima = origem.cima end
if vagner[3].baixo == nil then vagner[3].baixo = origem.baixo end
if vagner[3].esquerda == nil then vagner[3].esquerda = origem.esquerda end
if vagner[3].direita == nil then vagner[3].direita = origem.direita end
elseif vagner[3].nome == destino.nome then
if vagner[3].cima == nil then vagner[3].cima = destino.cima end
if vagner[3].baixo == nil then vagner[3].baixo = destino.baixo end
if vagner[3].esquerda == nil then vagner[3].esquerda = destino.esquerda end
if vagner[3].direita == nil then vagner[3].direita = destino.direita end
end

if vagner[4].nome == origem.nome then
if vagner[4].cima == nil then vagner[4].cima = origem.cima end
if vagner[4].baixo == nil then vagner[4].baixo = origem.baixo end
if vagner[4].esquerda == nil then vagner[4].esquerda = origem.esquerda end
if vagner[4].direita == nil then vagner[4].direita = origem.direita end
elseif vagner[4].nome == destino.nome then
if vagner[4].cima == nil then vagner[4].cima = destino.cima end
if vagner[4].baixo == nil then vagner[4].baixo = destino.baixo end
if vagner[4].esquerda == nil then vagner[4].esquerda = destino.esquerda end
if vagner[4].direita == nil then vagner[4].direita = destino.direita end
end

if vagner[5].nome == origem.nome then
if vagner[5].cima == nil then vagner[5].cima = origem.cima end
if vagner[5].baixo == nil then vagner[5].baixo = origem.baixo end
if vagner[5].esquerda == nil then vagner[5].esquerda = origem.esquerda end
if vagner[5].direita == nil then vagner[5].direita = origem.direita end
elseif vagner[5].nome == destino.nome then
if vagner[5].cima == nil then vagner[5].cima = destino.cima end
if vagner[5].baixo == nil then vagner[5].baixo = destino.baixo end
if vagner[5].esquerda == nil then vagner[5].esquerda = destino.esquerda end
if vagner[5].direita == nil then vagner[5].direita = destino.direita end
end

if vagner[6].nome == origem.nome then
if vagner[6].cima == nil then vagner[6].cima = origem.cima end
if vagner[6].baixo == nil then vagner[6].baixo = origem.baixo end
if vagner[6].esquerda == nil then vagner[6].esquerda = origem.esquerda end
if vagner[6].direita == nil then vagner[6].direita = origem.direita end
elseif vagner[6].nome == destino.nome then
if vagner[6].cima == nil then vagner[6].cima = destino.cima end
if vagner[6].baixo == nil then vagner[6].baixo = destino.baixo end
if vagner[6].esquerda == nil then vagner[6].esquerda = destino.esquerda end
if vagner[6].direita == nil then vagner[6].direita = destino.direita end
end

if vagner[7].nome == origem.nome then
if vagner[7].cima == nil then vagner[7].cima = origem.cima end
if vagner[7].baixo == nil then vagner[7].baixo = origem.baixo end
if vagner[7].esquerda == nil then vagner[7].esquerda = origem.esquerda end
if vagner[7].direita == nil then vagner[7].direita = origem.direita end
elseif vagner[7].nome == destino.nome then
if vagner[7].cima == nil then vagner[7].cima = destino.cima end
if vagner[7].baixo == nil then vagner[7].baixo = destino.baixo end
if vagner[7].esquerda == nil then vagner[7].esquerda = destino.esquerda end
if vagner[7].direita == nil then vagner[7].direita = destino.direita end
end

if vagner[8].nome == origem.nome then
if vagner[8].cima == nil then vagner[8].cima = origem.cima end
if vagner[8].baixo == nil then vagner[8].baixo = origem.baixo end
if vagner[8].esquerda == nil then vagner[8].esquerda = origem.esquerda end
if vagner[8].direita == nil then vagner[8].direita = origem.direita end
elseif vagner[8].nome == destino.nome then
if vagner[8].cima == nil then vagner[8].cima = destino.cima end
if vagner[8].baixo == nil then vagner[8].baixo = destino.baixo end
if vagner[8].esquerda == nil then vagner[8].esquerda = destino.esquerda end
if vagner[8].direita == nil then vagner[8].direita = destino.direita end
end

if vagner[9].nome == origem.nome then
if vagner[9].cima == nil then vagner[9].cima = origem.cima end
if vagner[9].baixo == nil then vagner[9].baixo = origem.baixo end
if vagner[9].esquerda == nil then vagner[9].esquerda = origem.esquerda end
if vagner[9].direita == nil then vagner[9].direita = origem.direita end
elseif vagner[9].nome == destino.nome then
if vagner[9].cima == nil then vagner[9].cima = destino.cima end
if vagner[9].baixo == nil then vagner[9].baixo = destino.baixo end
if vagner[9].esquerda == nil then vagner[9].esquerda = destino.esquerda end
if vagner[9].direita == nil then vagner[9].direita = destino.direita end
end

if vagner[10].nome == origem.nome then
if vagner[10].cima == nil then vagner[10].cima = origem.cima end
if vagner[10].baixo == nil then vagner[10].baixo = origem.baixo end
if vagner[10].esquerda == nil then vagner[10].esquerda = origem.esquerda end
if vagner[10].direita == nil then vagner[10].direita = origem.direita end
elseif vagner[10].nome == destino.nome then
if vagner[10].cima == nil then vagner[10].cima = destino.cima end
if vagner[10].baixo == nil then vagner[10].baixo = destino.baixo end
if vagner[10].esquerda == nil then vagner[10].esquerda = destino.esquerda end
if vagner[10].direita == nil then vagner[10].direita = destino.direita end
end

if vagner[11].nome == origem.nome then
if vagner[11].cima == nil then vagner[11].cima = origem.cima end
if vagner[11].baixo == nil then vagner[11].baixo = origem.baixo end
if vagner[11].esquerda == nil then vagner[11].esquerda = origem.esquerda end
if vagner[11].direita == nil then vagner[11].direita = origem.direita end
elseif vagner[11].nome == destino.nome then
if vagner[11].cima == nil then vagner[11].cima = destino.cima end
if vagner[11].baixo == nil then vagner[11].baixo = destino.baixo end
if vagner[11].esquerda == nil then vagner[11].esquerda = destino.esquerda end
if vagner[11].direita == nil then vagner[11].direita = destino.direita end
end

if vagner[12].nome == origem.nome then
if vagner[12].cima == nil then vagner[12].cima = origem.cima end
if vagner[12].baixo == nil then vagner[12].baixo = origem.baixo end
if vagner[12].esquerda == nil then vagner[12].esquerda = origem.esquerda end
if vagner[12].direita == nil then vagner[12].direita = origem.direita end
elseif vagner[12].nome == destino.nome then
if vagner[12].cima == nil then vagner[12].cima = destino.cima end
if vagner[12].baixo == nil then vagner[12].baixo = destino.baixo end
if vagner[12].esquerda == nil then vagner[12].esquerda = destino.esquerda end
if vagner[12].direita == nil then vagner[12].direita = destino.direita end
end

if vagner[13].nome == origem.nome then
if vagner[13].cima == nil then vagner[13].cima = origem.cima end
if vagner[13].baixo == nil then vagner[13].baixo = origem.baixo end
if vagner[13].esquerda == nil then vagner[13].esquerda = origem.esquerda end
if vagner[13].direita == nil then vagner[13].direita = origem.direita end
elseif vagner[13].nome == destino.nome then
if vagner[13].cima == nil then vagner[13].cima = destino.cima end
if vagner[13].baixo == nil then vagner[13].baixo = destino.baixo end
if vagner[13].esquerda == nil then vagner[13].esquerda = destino.esquerda end
if vagner[13].direita == nil then vagner[13].direita = destino.direita end
end

if vagner[14].nome == origem.nome then
if vagner[14].cima == nil then vagner[14].cima = origem.cima end
if vagner[14].baixo == nil then vagner[14].baixo = origem.baixo end
if vagner[14].esquerda == nil then vagner[14].esquerda = origem.esquerda end
if vagner[14].direita == nil then vagner[14].direita = origem.direita end
elseif vagner[14].nome == destino.nome then
if vagner[14].cima == nil then vagner[14].cima = destino.cima end
if vagner[14].baixo == nil then vagner[14].baixo = destino.baixo end
if vagner[14].esquerda == nil then vagner[14].esquerda = destino.esquerda end
if vagner[14].direita == nil then vagner[14].direita = destino.direita end
end

if vagner[15].nome == origem.nome then
if vagner[15].cima == nil then vagner[15].cima = origem.cima end
if vagner[15].baixo == nil then vagner[15].baixo = origem.baixo end
if vagner[15].esquerda == nil then vagner[15].esquerda = origem.esquerda end
if vagner[15].direita == nil then vagner[15].direita = origem.direita end
elseif vagner[15].nome == destino.nome then
if vagner[15].cima == nil then vagner[15].cima = destino.cima end
if vagner[15].baixo == nil then vagner[15].baixo = destino.baixo end
if vagner[15].esquerda == nil then vagner[15].esquerda = destino.esquerda end
if vagner[15].direita == nil then vagner[15].direita = destino.direita end
end

if vagner[16].nome == origem.nome then
if vagner[16].cima == nil then vagner[16].cima = origem.cima end
if vagner[16].baixo == nil then vagner[16].baixo = origem.baixo end
if vagner[16].esquerda == nil then vagner[16].esquerda = origem.esquerda end
if vagner[16].direita == nil then vagner[16].direita = origem.direita end
elseif vagner[16].nome == destino.nome then
if vagner[16].cima == nil then vagner[16].cima = destino.cima end
if vagner[16].baixo == nil then vagner[16].baixo = destino.baixo end
if vagner[16].esquerda == nil then vagner[16].esquerda = destino.esquerda end
if vagner[16].direita == nil then vagner[16].direita = destino.direita end
end


if vagner[17].nome == origem.nome then
if vagner[17].cima == nil then vagner[17].cima = origem.cima end
if vagner[17].baixo == nil then vagner[17].baixo = origem.baixo end
if vagner[17].esquerda == nil then vagner[17].esquerda = origem.esquerda end
if vagner[17].direita == nil then vagner[17].direita = origem.direita end
elseif vagner[17].nome == destino.nome then
if vagner[17].cima == nil then vagner[17].cima = destino.cima end
if vagner[17].baixo == nil then vagner[17].baixo = destino.baixo end
if vagner[17].esquerda == nil then vagner[17].esquerda = destino.esquerda end
if vagner[17].direita == nil then vagner[17].direita = destino.direita end
end

if vagner[18].nome == origem.nome then
if vagner[18].cima == nil then vagner[18].cima = origem.cima end
if vagner[18].baixo == nil then vagner[18].baixo = origem.baixo end
if vagner[18].esquerda == nil then vagner[18].esquerda = origem.esquerda end
if vagner[18].direita == nil then vagner[18].direita = origem.direita end
elseif vagner[18].nome == destino.nome then
if vagner[18].cima == nil then vagner[18].cima = destino.cima end
if vagner[18].baixo == nil then vagner[18].baixo = destino.baixo end
if vagner[18].esquerda == nil then vagner[18].esquerda = destino.esquerda end
if vagner[18].direita == nil then vagner[18].direita = destino.direita end
end


if vagner[19].nome == origem.nome then
if vagner[19].cima == nil then vagner[19].cima = origem.cima end
if vagner[19].baixo == nil then vagner[19].baixo = origem.baixo end
if vagner[19].esquerda == nil then vagner[19].esquerda = origem.esquerda end
if vagner[19].direita == nil then vagner[19].direita = origem.direita end
elseif vagner[19].nome == destino.nome then
if vagner[19].cima == nil then vagner[19].cima = destino.cima end
if vagner[19].baixo == nil then vagner[19].baixo = destino.baixo end
if vagner[19].esquerda == nil then vagner[19].esquerda = destino.esquerda end
if vagner[19].direita == nil then vagner[19].direita = destino.direita end
end


if vagner[20].nome == origem.nome then
if vagner[20].cima == nil then vagner[20].cima = origem.cima end
if vagner[20].baixo == nil then vagner[20].baixo = origem.baixo end
if vagner[20].esquerda == nil then vagner[20].esquerda = origem.esquerda end
if vagner[20].direita == nil then vagner[20].direita = origem.direita end
elseif vagner[20].nome == destino.nome then
if vagner[20].cima == nil then vagner[20].cima = destino.cima end
if vagner[20].baixo == nil then vagner[20].baixo = destino.baixo end
if vagner[20].esquerda == nil then vagner[20].esquerda = destino.esquerda end
if vagner[20].direita == nil then vagner[20].direita = destino.direita end
end


if vagner[21].nome == origem.nome then
if vagner[21].cima == nil then vagner[21].cima = origem.cima end
if vagner[21].baixo == nil then vagner[21].baixo = origem.baixo end
if vagner[21].esquerda == nil then vagner[21].esquerda = origem.esquerda end
if vagner[21].direita == nil then vagner[21].direita = origem.direita end
elseif vagner[21].nome == destino.nome then
if vagner[21].cima == nil then vagner[21].cima = destino.cima end
if vagner[21].baixo == nil then vagner[21].baixo = destino.baixo end
if vagner[21].esquerda == nil then vagner[21].esquerda = destino.esquerda end
if vagner[21].direita == nil then vagner[21].direita = destino.direita end
end


if vagner[22].nome == origem.nome then
if vagner[22].cima == nil then vagner[22].cima = origem.cima end
if vagner[22].baixo == nil then vagner[22].baixo = origem.baixo end
if vagner[22].esquerda == nil then vagner[22].esquerda = origem.esquerda end
if vagner[22].direita == nil then vagner[22].direita = origem.direita end
elseif vagner[22].nome == destino.nome then
if vagner[22].cima == nil then vagner[22].cima = destino.cima end
if vagner[22].baixo == nil then vagner[22].baixo = destino.baixo end
if vagner[22].esquerda == nil then vagner[22].esquerda = destino.esquerda end
if vagner[22].direita == nil then vagner[22].direita = destino.direita end
end


if vagner[23].nome == origem.nome then
if vagner[23].cima == nil then vagner[23].cima = origem.cima end
if vagner[23].baixo == nil then vagner[23].baixo = origem.baixo end
if vagner[23].esquerda == nil then vagner[23].esquerda = origem.esquerda end
if vagner[23].direita == nil then vagner[23].direita = origem.direita end
elseif vagner[23].nome == destino.nome then
if vagner[23].cima == nil then vagner[23].cima = destino.cima end
if vagner[23].baixo == nil then vagner[23].baixo = destino.baixo end
if vagner[23].esquerda == nil then vagner[23].esquerda = destino.esquerda end
if vagner[23].direita == nil then vagner[23].direita = destino.direita end
end


if vagner[24].nome == origem.nome then
if vagner[24].cima == nil then vagner[24].cima = origem.cima end
if vagner[24].baixo == nil then vagner[24].baixo = origem.baixo end
if vagner[24].esquerda == nil then vagner[24].esquerda = origem.esquerda end
if vagner[24].direita == nil then vagner[24].direita = origem.direita end
elseif vagner[24].nome == destino.nome then
if vagner[24].cima == nil then vagner[24].cima = destino.cima end
if vagner[24].baixo == nil then vagner[24].baixo = destino.baixo end
if vagner[24].esquerda == nil then vagner[24].esquerda = destino.esquerda end
if vagner[24].direita == nil then vagner[24].direita = destino.direita end
end

if vagner[25].nome == origem.nome then
if vagner[25].cima == nil then vagner[25].cima = origem.cima end
if vagner[25].baixo == nil then vagner[25].baixo = origem.baixo end
if vagner[25].esquerda == nil then vagner[25].esquerda = origem.esquerda end
if vagner[25].direita == nil then vagner[25].direita = origem.direita end
elseif vagner[25].nome == destino.nome then
if vagner[25].cima == nil then vagner[25].cima = destino.cima end
if vagner[25].baixo == nil then vagner[25].baixo = destino.baixo end
if vagner[25].esquerda == nil then vagner[25].esquerda = destino.esquerda end
if vagner[25].direita == nil then vagner[25].direita = destino.direita end
end

if vagner[26].nome == origem.nome then
if vagner[26].cima == nil then vagner[26].cima = origem.cima end
if vagner[26].baixo == nil then vagner[26].baixo = origem.baixo end
if vagner[26].esquerda == nil then vagner[26].esquerda = origem.esquerda end
if vagner[26].direita == nil then vagner[26].direita = origem.direita end
elseif vagner[26].nome == destino.nome then
if vagner[26].cima == nil then vagner[26].cima = destino.cima end
if vagner[26].baixo == nil then vagner[26].baixo = destino.baixo end
if vagner[26].esquerda == nil then vagner[26].esquerda = destino.esquerda end
if vagner[26].direita == nil then vagner[26].direita = destino.direita end
end

if vagner[27].nome == origem.nome then
if vagner[27].cima == nil then vagner[27].cima = origem.cima end
if vagner[27].baixo == nil then vagner[27].baixo = origem.baixo end
if vagner[27].esquerda == nil then vagner[27].esquerda = origem.esquerda end
if vagner[27].direita == nil then vagner[27].direita = origem.direita end
elseif vagner[27].nome == destino.nome then
if vagner[27].cima == nil then vagner[27].cima = destino.cima end
if vagner[27].baixo == nil then vagner[27].baixo = destino.baixo end
if vagner[27].esquerda == nil then vagner[27].esquerda = destino.esquerda end
if vagner[27].direita == nil then vagner[27].direita = destino.direita end
end

if vagner[28].nome == origem.nome then
if vagner[28].cima == nil then vagner[28].cima = origem.cima end
if vagner[28].baixo == nil then vagner[28].baixo = origem.baixo end
if vagner[28].esquerda == nil then vagner[28].esquerda = origem.esquerda end
if vagner[28].direita == nil then vagner[28].direita = origem.direita end
elseif vagner[28].nome == destino.nome then
if vagner[28].cima == nil then vagner[28].cima = destino.cima end
if vagner[28].baixo == nil then vagner[28].baixo = destino.baixo end
if vagner[28].esquerda == nil then vagner[28].esquerda = destino.esquerda end
if vagner[28].direita == nil then vagner[28].direita = destino.direita end
end

if vagner[29].nome == origem.nome then
if vagner[29].cima == nil then vagner[29].cima = origem.cima end
if vagner[29].baixo == nil then vagner[29].baixo = origem.baixo end
if vagner[29].esquerda == nil then vagner[29].esquerda = origem.esquerda end
if vagner[29].direita == nil then vagner[29].direita = origem.direita end
elseif vagner[29].nome == destino.nome then
if vagner[29].cima == nil then vagner[29].cima = destino.cima end
if vagner[29].baixo == nil then vagner[29].baixo = destino.baixo end
if vagner[29].esquerda == nil then vagner[29].esquerda = destino.esquerda end
if vagner[29].direita == nil then vagner[29].direita = destino.direita end
end

if vagner[30].nome == origem.nome then
if vagner[30].cima == nil then vagner[30].cima = origem.cima end
if vagner[30].baixo == nil then vagner[30].baixo = origem.baixo end
if vagner[30].esquerda == nil then vagner[30].esquerda = origem.esquerda end
if vagner[30].direita == nil then vagner[30].direita = origem.direita end
elseif vagner[30].nome == destino.nome then
if vagner[30].cima == nil then vagner[30].cima = destino.cima end
if vagner[30].baixo == nil then vagner[30].baixo = destino.baixo end
if vagner[30].esquerda == nil then vagner[30].esquerda = destino.esquerda end
if vagner[30].direita == nil then vagner[30].direita = destino.direita end
end

end
end



    local choices = {}
    local dist = 0
    for i,room in ipairs(rooms) do
       -- local dir = interior_spawner:GetDir()
        local north_exit_open = not room.exits[interior_spawner:GetNorth()]

        if not north_exit_open then
--            print("THIS ROOM'S NORTH EXIT IS USED")
        end

        if math.abs(room.x)+math.abs(room.y) > dist and north_exit_open then
            choices = {}
        end
        if math.abs(room.x)+math.abs(room.y) >= dist and north_exit_open then
            table.insert(choices,room)
            dist = math.abs(room.x)+math.abs(room.y)
        end
    end
--    print("FOUND THIS MANY PLACES FOR THE EXIT",#choices)

    if not nosecondexit then
        if #choices > 0 then
            choices[math.random(#choices)].entrance2 = true
        end
    end

    choices = {}
    for i,room in ipairs(rooms) do
        if exitNumbers(room) == 1 then
            table.insert(choices,room)
        end
    end

--    if dungeondef.name == "RUINS_3" then
--        choices[math.random(#choices)].pheromonestone = true
--    else
        choices[math.random(#choices)].treasure = true
--    end

--local room = {
--        x=0,
--        y=0,
--        idx = "Sala"..interior_spawner:GetNewID(),
--        exits = {},
--        blocked_exits = {interior_spawner:GetNorth()}, -- 3 == NORTH
--        entrance1 = true,
--    }

if vagner[1].nome ~= nil then
local numexits = 0
if vagner[1].cima ~= nil then numexits = numexits + 1 end
if vagner[1].baixo ~= nil then numexits = numexits + 1 end
if vagner[1].esquerda ~= nil then numexits = numexits + 1 end
if vagner[1].direita ~= nil then numexits = numexits + 1 end
vagner[1].numexits = numexits
end

if vagner[2].nome ~= nil then
local numexits = 0
if vagner[2].cima ~= nil then numexits = numexits + 1 end
if vagner[2].baixo ~= nil then numexits = numexits + 1 end
if vagner[2].esquerda ~= nil then numexits = numexits + 1 end
if vagner[2].direita ~= nil then numexits = numexits + 1 end
vagner[2].numexits = numexits
end

if vagner[3].nome ~= nil then
local numexits = 0
if vagner[3].cima ~= nil then numexits = numexits + 1 end
if vagner[3].baixo ~= nil then numexits = numexits + 1 end
if vagner[3].esquerda ~= nil then numexits = numexits + 1 end
if vagner[3].direita ~= nil then numexits = numexits + 1 end
vagner[3].numexits = numexits
end

if vagner[4].nome ~= nil then
local numexits = 0
if vagner[4].cima ~= nil then numexits = numexits + 1 end
if vagner[4].baixo ~= nil then numexits = numexits + 1 end
if vagner[4].esquerda ~= nil then numexits = numexits + 1 end
if vagner[4].direita ~= nil then numexits = numexits + 1 end
vagner[4].numexits = numexits
end

if vagner[5].nome ~= nil then
local numexits = 0
if vagner[5].cima ~= nil then numexits = numexits + 1 end
if vagner[5].baixo ~= nil then numexits = numexits + 1 end
if vagner[5].esquerda ~= nil then numexits = numexits + 1 end
if vagner[5].direita ~= nil then numexits = numexits + 1 end
vagner[5].numexits = numexits
end

if vagner[6].nome ~= nil then
local numexits = 0
if vagner[6].cima ~= nil then numexits = numexits + 1 end
if vagner[6].baixo ~= nil then numexits = numexits + 1 end
if vagner[6].esquerda ~= nil then numexits = numexits + 1 end
if vagner[6].direita ~= nil then numexits = numexits + 1 end
vagner[6].numexits = numexits
end

if vagner[7].nome ~= nil then
local numexits = 0
if vagner[7].cima ~= nil then numexits = numexits + 1 end
if vagner[7].baixo ~= nil then numexits = numexits + 1 end
if vagner[7].esquerda ~= nil then numexits = numexits + 1 end
if vagner[7].direita ~= nil then numexits = numexits + 1 end
vagner[7].numexits = numexits
end

if vagner[8].nome ~= nil then
local numexits = 0
if vagner[8].cima ~= nil then numexits = numexits + 1 end
if vagner[8].baixo ~= nil then numexits = numexits + 1 end
if vagner[8].esquerda ~= nil then numexits = numexits + 1 end
if vagner[8].direita ~= nil then numexits = numexits + 1 end
vagner[8].numexits = numexits
end

if vagner[9].nome ~= nil then
local numexits = 0
if vagner[9].cima ~= nil then numexits = numexits + 1 end
if vagner[9].baixo ~= nil then numexits = numexits + 1 end
if vagner[9].esquerda ~= nil then numexits = numexits + 1 end
if vagner[9].direita ~= nil then numexits = numexits + 1 end
vagner[9].numexits = numexits
end

if vagner[10].nome ~= nil then
local numexits = 0
if vagner[10].cima ~= nil then numexits = numexits + 1 end
if vagner[10].baixo ~= nil then numexits = numexits + 1 end
if vagner[10].esquerda ~= nil then numexits = numexits + 1 end
if vagner[10].direita ~= nil then numexits = numexits + 1 end
vagner[10].numexits = numexits
end

if vagner[11].nome ~= nil then
local numexits = 0
if vagner[11].cima ~= nil then numexits = numexits + 1 end
if vagner[11].baixo ~= nil then numexits = numexits + 1 end
if vagner[11].esquerda ~= nil then numexits = numexits + 1 end
if vagner[11].direita ~= nil then numexits = numexits + 1 end
vagner[11].numexits = numexits
end

if vagner[12].nome ~= nil then
local numexits = 0
if vagner[12].cima ~= nil then numexits = numexits + 1 end
if vagner[12].baixo ~= nil then numexits = numexits + 1 end
if vagner[12].esquerda ~= nil then numexits = numexits + 1 end
if vagner[12].direita ~= nil then numexits = numexits + 1 end
vagner[12].numexits = numexits
end

if vagner[13].nome ~= nil then
local numexits = 0
if vagner[13].cima ~= nil then numexits = numexits + 1 end
if vagner[13].baixo ~= nil then numexits = numexits + 1 end
if vagner[13].esquerda ~= nil then numexits = numexits + 1 end
if vagner[13].direita ~= nil then numexits = numexits + 1 end
vagner[13].numexits = numexits
end

if vagner[14].nome ~= nil then
local numexits = 0
if vagner[14].cima ~= nil then numexits = numexits + 1 end
if vagner[14].baixo ~= nil then numexits = numexits + 1 end
if vagner[14].esquerda ~= nil then numexits = numexits + 1 end
if vagner[14].direita ~= nil then numexits = numexits + 1 end
vagner[14].numexits = numexits
end

if vagner[15].nome ~= nil then
local numexits = 0
if vagner[15].cima ~= nil then numexits = numexits + 1 end
if vagner[15].baixo ~= nil then numexits = numexits + 1 end
if vagner[15].esquerda ~= nil then numexits = numexits + 1 end
if vagner[15].direita ~= nil then numexits = numexits + 1 end
vagner[15].numexits = numexits
end

if vagner[16].nome ~= nil then
local numexits = 0
if vagner[16].cima ~= nil then numexits = numexits + 1 end
if vagner[16].baixo ~= nil then numexits = numexits + 1 end
if vagner[16].esquerda ~= nil then numexits = numexits + 1 end
if vagner[16].direita ~= nil then numexits = numexits + 1 end
vagner[16].numexits = numexits
end

if vagner[17].nome ~= nil then
local numexits = 0
if vagner[17].cima ~= nil then numexits = numexits + 1 end
if vagner[17].baixo ~= nil then numexits = numexits + 1 end
if vagner[17].esquerda ~= nil then numexits = numexits + 1 end
if vagner[17].direita ~= nil then numexits = numexits + 1 end
vagner[17].numexits = numexits
end

if vagner[18].nome ~= nil then
local numexits = 0
if vagner[18].cima ~= nil then numexits = numexits + 1 end
if vagner[18].baixo ~= nil then numexits = numexits + 1 end
if vagner[18].esquerda ~= nil then numexits = numexits + 1 end
if vagner[18].direita ~= nil then numexits = numexits + 1 end
vagner[18].numexits = numexits
end

if vagner[19].nome ~= nil then
local numexits = 0
if vagner[19].cima ~= nil then numexits = numexits + 1 end
if vagner[19].baixo ~= nil then numexits = numexits + 1 end
if vagner[19].esquerda ~= nil then numexits = numexits + 1 end
if vagner[19].direita ~= nil then numexits = numexits + 1 end
vagner[19].numexits = numexits
end

if vagner[20].nome ~= nil then
local numexits = 0
if vagner[20].cima ~= nil then numexits = numexits + 1 end
if vagner[20].baixo ~= nil then numexits = numexits + 1 end
if vagner[20].esquerda ~= nil then numexits = numexits + 1 end
if vagner[20].direita ~= nil then numexits = numexits + 1 end
vagner[20].numexits = numexits
end

if vagner[21].nome ~= nil then
local numexits = 0
if vagner[21].cima ~= nil then numexits = numexits + 1 end
if vagner[21].baixo ~= nil then numexits = numexits + 1 end
if vagner[21].esquerda ~= nil then numexits = numexits + 1 end
if vagner[21].direita ~= nil then numexits = numexits + 1 end
vagner[21].numexits = numexits
end

if vagner[22].nome ~= nil then
local numexits = 0
if vagner[22].cima ~= nil then numexits = numexits + 1 end
if vagner[22].baixo ~= nil then numexits = numexits + 1 end
if vagner[22].esquerda ~= nil then numexits = numexits + 1 end
if vagner[22].direita ~= nil then numexits = numexits + 1 end
vagner[22].numexits = numexits
end

if vagner[23].nome ~= nil then
local numexits = 0
if vagner[23].cima ~= nil then numexits = numexits + 1 end
if vagner[23].baixo ~= nil then numexits = numexits + 1 end
if vagner[23].esquerda ~= nil then numexits = numexits + 1 end
if vagner[23].direita ~= nil then numexits = numexits + 1 end
vagner[23].numexits = numexits
end

if vagner[24].nome ~= nil then
local numexits = 0
if vagner[24].cima ~= nil then numexits = numexits + 1 end
if vagner[24].baixo ~= nil then numexits = numexits + 1 end
if vagner[24].esquerda ~= nil then numexits = numexits + 1 end
if vagner[24].direita ~= nil then numexits = numexits + 1 end
vagner[24].numexits = numexits
end

if vagner[25].nome ~= nil then
local numexits = 0
if vagner[25].cima ~= nil then numexits = numexits + 1 end
if vagner[25].baixo ~= nil then numexits = numexits + 1 end
if vagner[25].esquerda ~= nil then numexits = numexits + 1 end
if vagner[25].direita ~= nil then numexits = numexits + 1 end
vagner[25].numexits = numexits
end

if vagner[26].nome ~= nil then
local numexits = 0
if vagner[26].cima ~= nil then numexits = numexits + 1 end
if vagner[26].baixo ~= nil then numexits = numexits + 1 end
if vagner[26].esquerda ~= nil then numexits = numexits + 1 end
if vagner[26].direita ~= nil then numexits = numexits + 1 end
vagner[26].numexits = numexits
end

if vagner[27].nome ~= nil then
local numexits = 0
if vagner[27].cima ~= nil then numexits = numexits + 1 end
if vagner[27].baixo ~= nil then numexits = numexits + 1 end
if vagner[27].esquerda ~= nil then numexits = numexits + 1 end
if vagner[27].direita ~= nil then numexits = numexits + 1 end
vagner[27].numexits = numexits
end

if vagner[28].nome ~= nil then
local numexits = 0
if vagner[28].cima ~= nil then numexits = numexits + 1 end
if vagner[28].baixo ~= nil then numexits = numexits + 1 end
if vagner[28].esquerda ~= nil then numexits = numexits + 1 end
if vagner[28].direita ~= nil then numexits = numexits + 1 end
vagner[28].numexits = numexits
end

if vagner[29].nome ~= nil then
local numexits = 0
if vagner[29].cima ~= nil then numexits = numexits + 1 end
if vagner[29].baixo ~= nil then numexits = numexits + 1 end
if vagner[29].esquerda ~= nil then numexits = numexits + 1 end
if vagner[29].direita ~= nil then numexits = numexits + 1 end
vagner[29].numexits = numexits
end

if vagner[30].nome ~= nil then
local numexits = 0
if vagner[30].cima ~= nil then numexits = numexits + 1 end
if vagner[30].baixo ~= nil then numexits = numexits + 1 end
if vagner[30].esquerda ~= nil then numexits = numexits + 1 end
if vagner[30].direita ~= nil then numexits = numexits + 1 end
vagner[30].numexits = numexits
end

end



----------------------------------------------------------entrada-----------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()

    inst.AnimState:SetBuild("pig_ruins_entrance_build")
    inst.AnimState:SetBank("pig_ruins_entrance")
    inst.AnimState:PlayAnimation("idle", true)
		
	inst:AddTag("vulcano_part")
	inst:AddTag("antlion_sinkhole_blocker")


	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	

	
inst:DoTaskInTime(math.random(1,20)/10, function(inst)	
createmaze(inst)
--[[
print("----------")
print(vagner[1].nome)
print(vagner[1].cima)
print(vagner[1].baixo)
print(vagner[1].esquerda)
print(vagner[1].direita)
print(vagner[1].numexits)

print("----------")
print(vagner[2].nome)
print(vagner[2].cima)
print(vagner[2].baixo)
print(vagner[2].esquerda)
print(vagner[2].direita)
print(vagner[2].numexits)

print("----------")
print(vagner[3].nome)
print(vagner[3].cima)
print(vagner[3].baixo)
print(vagner[3].esquerda)
print(vagner[3].direita)
print(vagner[3].numexits)

print("----------")
print(vagner[4].nome)
print(vagner[4].cima)
print(vagner[4].baixo)
print(vagner[4].esquerda)
print(vagner[4].direita)
print(vagner[4].numexits)

print("----------")
print(vagner[5].nome)
print(vagner[5].cima)
print(vagner[5].baixo)
print(vagner[5].esquerda)
print(vagner[5].direita)
print(vagner[5].numexits)

print("----------")
print(vagner[6].nome)
print(vagner[6].cima)
print(vagner[6].baixo)
print(vagner[6].esquerda)
print(vagner[6].direita)
print(vagner[6].numexits)

print("----------")
print(vagner[7].nome)
print(vagner[7].cima)
print(vagner[7].baixo)
print(vagner[7].esquerda)
print(vagner[7].direita)
print(vagner[7].numexits)

print("----------")
print(vagner[8].nome)
print(vagner[8].cima)
print(vagner[8].baixo)
print(vagner[8].esquerda)
print(vagner[8].direita)
print(vagner[8].numexits)

print("----------")
print(vagner[9].nome)
print(vagner[9].cima)
print(vagner[9].baixo)
print(vagner[9].esquerda)
print(vagner[9].direita)
print(vagner[9].numexits)

print("----------")
print(vagner[10].nome)
print(vagner[10].cima)
print(vagner[10].baixo)
print(vagner[10].esquerda)
print(vagner[10].direita)
print(vagner[10].numexits)

print("----------")
print(vagner[11].nome)
print(vagner[11].cima)
print(vagner[11].baixo)
print(vagner[11].esquerda)
print(vagner[11].direita)
print(vagner[11].numexits)

print("----------")
print(vagner[12].nome)
print(vagner[12].cima)
print(vagner[12].baixo)
print(vagner[12].esquerda)
print(vagner[12].direita)
print(vagner[12].numexits)

print("----------")
print(vagner[13].nome)
print(vagner[13].cima)
print(vagner[13].baixo)
print(vagner[13].esquerda)
print(vagner[13].direita)
print(vagner[13].numexits)

print("----------")
print(vagner[14].nome)
print(vagner[14].cima)
print(vagner[14].baixo)
print(vagner[14].esquerda)
print(vagner[14].direita)
print(vagner[14].numexits)

print("----------")
print(vagner[15].nome)
print(vagner[15].cima)
print(vagner[15].baixo)
print(vagner[15].esquerda)
print(vagner[15].direita)
print(vagner[15].numexits)

print("----------")
print(vagner[15].nome)
print(vagner[15].cima)
print(vagner[15].baixo)
print(vagner[15].esquerda)
print(vagner[15].direita)
print(vagner[16].numexits)

print("----------")
print(vagner[15].nome)
print(vagner[15].cima)
print(vagner[15].baixo)
print(vagner[15].esquerda)
print(vagner[15].direita)
print(vagner[17].numexits)

print("----------")
print(vagner[15].nome)
print(vagner[15].cima)
print(vagner[15].baixo)
print(vagner[15].esquerda)
print(vagner[15].direita)
print(vagner[18].numexits)
]]
local distportacima = -7
local distportabaixo = 8.8
local distportaesquerda = -11.5
local distportadireita = 12.5

---------------------------------------------caveroc------------------------------------------------
if inst.tipodemaze == 5 then
local distportacima = -7
local distportabaixo = 9.3
local distportaesquerda = -12.5
local distportadireita = 13.5

SpawnPrefab("createroccaveroom")
vagner[1].valorx = TheWorld.components.contador:GetX()
vagner[1].valorz = TheWorld.components.contador:GetZ()


if vagner[1].numexits > 0 then
vagner[1].saidacima = SpawnPrefab("roc_cave_door_rope")
vagner[1].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima + 7, 0, TheWorld.components.contador:GetZ())
---------
if vagner[1].baixo ~= nil then 
vagner[1].saidabaixo = SpawnPrefab("roc_cave_door_baixo")
vagner[1].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())
end
--------------
if vagner[1].esquerda ~= nil then 
vagner[1].saidaesquerda = SpawnPrefab("roc_cave_door_esquerda")
vagner[1].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)
end
--------------------
if vagner[1].direita ~= nil then 
vagner[1].saidadireita = SpawnPrefab("roc_cave_door_direita")
vagner[1].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)
end

local portaentrada = SpawnPrefab("cave_entrance_roc")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada

end 



if vagner[2].numexits > 0 then
SpawnPrefab("createroccaveroom")

vagner[2].valorx = TheWorld.components.contador:GetX()
vagner[2].valorz = TheWorld.components.contador:GetZ()

if vagner[2].cima ~= nil then
vagner[2].saidacima = SpawnPrefab("roc_cave_door_cima")
if vagner[2].trapdor then vagner[2].saidacima:AddTag("lockable_door") end
vagner[2].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[2].cima < 2 then
vagner[2].saidacima.components.teleporter.targetTeleporter = vagner[vagner[2].cima].saidabaixo
vagner[vagner[2].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[2].saidacima
end
end

if vagner[2].baixo ~= nil then 
vagner[2].saidabaixo = SpawnPrefab("roc_cave_door_baixo")
if vagner[2].trapdor then vagner[2].saidabaixo:AddTag("lockable_door") end
vagner[2].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[2].baixo < 2 then
vagner[2].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[2].baixo].saidacima
vagner[vagner[2].baixo].saidacima.components.teleporter.targetTeleporter = vagner[2].saidabaixo
end
end

if vagner[2].esquerda ~= nil then
vagner[2].saidaesquerda = SpawnPrefab("roc_cave_door_esquerda")
if vagner[2].trapdor then vagner[2].saidaesquerda:AddTag("lockable_door") end
vagner[2].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[2].esquerda < 2 then
vagner[2].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[2].esquerda].saidadireita
vagner[vagner[2].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[2].saidaesquerda
end
end

if vagner[2].direita ~= nil then
vagner[2].saidadireita = SpawnPrefab("roc_cave_door_direita")
if vagner[2].trapdor then vagner[2].saidadireita:AddTag("lockable_door") end
vagner[2].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[2].direita  < 2 then
vagner[2].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[2].direita].saidaesquerda
vagner[vagner[2].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[2].saidadireita
end
end
end

if vagner[3].numexits > 0 then
SpawnPrefab("createroccaveroom")

vagner[3].valorx = TheWorld.components.contador:GetX()
vagner[3].valorz = TheWorld.components.contador:GetZ()

if vagner[3].cima ~= nil then 
vagner[3].saidacima = SpawnPrefab("roc_cave_door_cima")
if vagner[3].trapdor then vagner[3].saidacima:AddTag("lockable_door") end
vagner[3].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[3].cima < 3 then
vagner[3].saidacima.components.teleporter.targetTeleporter = vagner[vagner[3].cima].saidabaixo
vagner[vagner[3].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[3].saidacima
end
end

if vagner[3].baixo ~= nil then 
vagner[3].saidabaixo = SpawnPrefab("roc_cave_door_baixo")
if vagner[3].trapdor then vagner[3].saidabaixo:AddTag("lockable_door") end
vagner[3].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[3].baixo < 3 then
vagner[3].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[3].baixo].saidacima
vagner[vagner[3].baixo].saidacima.components.teleporter.targetTeleporter = vagner[3].saidabaixo
end
end

if vagner[3].esquerda ~= nil then
vagner[3].saidaesquerda = SpawnPrefab("roc_cave_door_esquerda")
if vagner[3].trapdor then vagner[3].saidaesquerda:AddTag("lockable_door") end
vagner[3].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[3].esquerda < 3 then
vagner[3].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[3].esquerda].saidadireita
vagner[vagner[3].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[3].saidaesquerda
end
end

if vagner[3].direita ~= nil then
vagner[3].saidadireita = SpawnPrefab("roc_cave_door_direita")
if vagner[3].trapdor then vagner[3].saidadireita:AddTag("lockable_door") end
vagner[3].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[3].direita  < 3 then
vagner[3].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[3].direita].saidaesquerda
vagner[vagner[3].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[3].saidadireita
end
end
end

if vagner[4].numexits > 0 then
SpawnPrefab("createroccaveroom")

vagner[4].valorx = TheWorld.components.contador:GetX()
vagner[4].valorz = TheWorld.components.contador:GetZ()

if vagner[4].cima ~= nil then 
vagner[4].saidacima = SpawnPrefab("roc_cave_door_cima")
if vagner[4].trapdor then vagner[4].saidacima:AddTag("lockable_door") end
vagner[4].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[4].cima < 4 then
vagner[4].saidacima.components.teleporter.targetTeleporter = vagner[vagner[4].cima].saidabaixo
vagner[vagner[4].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[4].saidacima
end
end

if vagner[4].baixo ~= nil then 
vagner[4].saidabaixo = SpawnPrefab("roc_cave_door_baixo")
if vagner[4].trapdor then vagner[4].saidabaixo:AddTag("lockable_door") end
vagner[4].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[4].baixo < 4 then
vagner[4].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[4].baixo].saidacima
vagner[vagner[4].baixo].saidacima.components.teleporter.targetTeleporter = vagner[4].saidabaixo
end
end

if vagner[4].esquerda ~= nil then
vagner[4].saidaesquerda = SpawnPrefab("roc_cave_door_esquerda")
if vagner[4].trapdor then vagner[4].saidaesquerda:AddTag("lockable_door") end
vagner[4].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[4].esquerda < 4 then
vagner[4].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[4].esquerda].saidadireita
vagner[vagner[4].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[4].saidaesquerda
end
end

if vagner[4].direita ~= nil then
vagner[4].saidadireita = SpawnPrefab("roc_cave_door_direita")
if vagner[4].trapdor then vagner[4].saidadireita:AddTag("lockable_door") end
vagner[4].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[4].direita  < 4 then
vagner[4].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[4].direita].saidaesquerda
vagner[vagner[4].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[4].saidadireita
end
end
end

if vagner[5].numexits > 0 then
SpawnPrefab("createroccaveroom")

vagner[5].valorx = TheWorld.components.contador:GetX()
vagner[5].valorz = TheWorld.components.contador:GetZ()

if vagner[5].cima ~= nil then 
vagner[5].saidacima = SpawnPrefab("roc_cave_door_cima")
if vagner[5].trapdor then vagner[5].saidacima:AddTag("lockable_door") end
vagner[5].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[5].cima < 5 then
vagner[5].saidacima.components.teleporter.targetTeleporter = vagner[vagner[5].cima].saidabaixo
vagner[vagner[5].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[5].saidacima
end
end

if vagner[5].baixo ~= nil then 
vagner[5].saidabaixo = SpawnPrefab("roc_cave_door_baixo")
if vagner[5].trapdor then vagner[5].saidabaixo:AddTag("lockable_door") end
vagner[5].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[5].baixo < 5 then
vagner[5].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[5].baixo].saidacima
vagner[vagner[5].baixo].saidacima.components.teleporter.targetTeleporter = vagner[5].saidabaixo
end
end

if vagner[5].esquerda ~= nil then
vagner[5].saidaesquerda = SpawnPrefab("roc_cave_door_esquerda")
if vagner[5].trapdor then vagner[5].saidaesquerda:AddTag("lockable_door") end
vagner[5].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[5].esquerda < 5 then
vagner[5].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[5].esquerda].saidadireita
vagner[vagner[5].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[5].saidaesquerda
end
end

if vagner[5].direita ~= nil then
vagner[5].saidadireita = SpawnPrefab("roc_cave_door_direita")
if vagner[5].trapdor then vagner[5].saidadireita:AddTag("lockable_door") end
vagner[5].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[5].direita  < 5 then
vagner[5].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[5].direita].saidaesquerda
vagner[vagner[5].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[5].saidadireita
end
end
end

if vagner[6].numexits > 0 then
SpawnPrefab("createroccaveroom")

vagner[6].valorx = TheWorld.components.contador:GetX()
vagner[6].valorz = TheWorld.components.contador:GetZ()

if vagner[6].cima ~= nil then 
vagner[6].saidacima = SpawnPrefab("roc_cave_door_cima")
if vagner[6].trapdor then vagner[6].saidacima:AddTag("lockable_door") end
vagner[6].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[6].cima < 6 then
vagner[6].saidacima.components.teleporter.targetTeleporter = vagner[vagner[6].cima].saidabaixo
vagner[vagner[6].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[6].saidacima
end
end

if vagner[6].baixo ~= nil then 
vagner[6].saidabaixo = SpawnPrefab("roc_cave_door_baixo")
if vagner[6].trapdor then vagner[6].saidabaixo:AddTag("lockable_door") end
vagner[6].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[6].baixo < 6 then
vagner[6].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[6].baixo].saidacima
vagner[vagner[6].baixo].saidacima.components.teleporter.targetTeleporter = vagner[6].saidabaixo
end
end

if vagner[6].esquerda ~= nil then
vagner[6].saidaesquerda = SpawnPrefab("roc_cave_door_esquerda")
if vagner[6].trapdor then vagner[6].saidaesquerda:AddTag("lockable_door") end
vagner[6].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[6].esquerda < 6 then
vagner[6].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[6].esquerda].saidadireita
vagner[vagner[6].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[6].saidaesquerda
end
end

if vagner[6].direita ~= nil then
vagner[6].saidadireita = SpawnPrefab("roc_cave_door_direita")
if vagner[6].trapdor then vagner[6].saidadireita:AddTag("lockable_door") end
vagner[6].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[6].direita  < 6 then
vagner[6].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[6].direita].saidaesquerda
vagner[vagner[6].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[6].saidadireita
end
end
end

end
---------------------------------------------------------anthill--------------------------------------------------------------------------
if inst.tipodemaze == 6 then
local distportacima = -7
local distportabaixo = 8.5
local distportaesquerda = -12.5
local distportadireita = 13.5
SpawnPrefab("createanthilldefaltroominicio")
vagner[1].valorx = TheWorld.components.contador:GetX()
vagner[1].valorz = TheWorld.components.contador:GetZ()


if vagner[1].numexits > 0 then
vagner[1].saidacima = SpawnPrefab("anthill_door_entrada")
vagner[1].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())
---------
if vagner[1].baixo ~= nil then 
vagner[1].saidabaixo = SpawnPrefab("anthill_door_baixo")
vagner[1].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())
end
--------------
if vagner[1].esquerda ~= nil then 
vagner[1].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
vagner[1].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)
end
--------------------
if vagner[1].direita ~= nil then 
vagner[1].saidadireita = SpawnPrefab("anthill_door_direita")
vagner[1].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)
end

local portaentrada = SpawnPrefab("anthill")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada

end 



if vagner[2].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[2].valorx = TheWorld.components.contador:GetX()
vagner[2].valorz = TheWorld.components.contador:GetZ()

if vagner[2].cima ~= nil then
vagner[2].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[2].trapdor then vagner[2].saidacima:AddTag("lockable_door") end
vagner[2].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[2].cima < 2 then
vagner[2].saidacima.components.teleporter.targetTeleporter = vagner[vagner[2].cima].saidabaixo
vagner[vagner[2].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[2].saidacima
end
end

if vagner[2].baixo ~= nil then 
vagner[2].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[2].trapdor then vagner[2].saidabaixo:AddTag("lockable_door") end
vagner[2].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[2].baixo < 2 then
vagner[2].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[2].baixo].saidacima
vagner[vagner[2].baixo].saidacima.components.teleporter.targetTeleporter = vagner[2].saidabaixo
end
end

if vagner[2].esquerda ~= nil then
vagner[2].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[2].trapdor then vagner[2].saidaesquerda:AddTag("lockable_door") end
vagner[2].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[2].esquerda < 2 then
vagner[2].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[2].esquerda].saidadireita
vagner[vagner[2].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[2].saidaesquerda
end
end

if vagner[2].direita ~= nil then
vagner[2].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[2].trapdor then vagner[2].saidadireita:AddTag("lockable_door") end
vagner[2].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[2].direita  < 2 then
vagner[2].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[2].direita].saidaesquerda
vagner[vagner[2].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[2].saidadireita
end
end
end

if vagner[3].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[3].valorx = TheWorld.components.contador:GetX()
vagner[3].valorz = TheWorld.components.contador:GetZ()

if vagner[3].cima ~= nil then 
vagner[3].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[3].trapdor then vagner[3].saidacima:AddTag("lockable_door") end
vagner[3].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[3].cima < 3 then
vagner[3].saidacima.components.teleporter.targetTeleporter = vagner[vagner[3].cima].saidabaixo
vagner[vagner[3].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[3].saidacima
end
end

if vagner[3].baixo ~= nil then 
vagner[3].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[3].trapdor then vagner[3].saidabaixo:AddTag("lockable_door") end
vagner[3].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[3].baixo < 3 then
vagner[3].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[3].baixo].saidacima
vagner[vagner[3].baixo].saidacima.components.teleporter.targetTeleporter = vagner[3].saidabaixo
end
end

if vagner[3].esquerda ~= nil then
vagner[3].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[3].trapdor then vagner[3].saidaesquerda:AddTag("lockable_door") end
vagner[3].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[3].esquerda < 3 then
vagner[3].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[3].esquerda].saidadireita
vagner[vagner[3].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[3].saidaesquerda
end
end

if vagner[3].direita ~= nil then
vagner[3].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[3].trapdor then vagner[3].saidadireita:AddTag("lockable_door") end
vagner[3].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[3].direita  < 3 then
vagner[3].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[3].direita].saidaesquerda
vagner[vagner[3].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[3].saidadireita
end
end
end

if vagner[4].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[4].valorx = TheWorld.components.contador:GetX()
vagner[4].valorz = TheWorld.components.contador:GetZ()

if vagner[4].cima ~= nil then 
vagner[4].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[4].trapdor then vagner[4].saidacima:AddTag("lockable_door") end
vagner[4].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[4].cima < 4 then
vagner[4].saidacima.components.teleporter.targetTeleporter = vagner[vagner[4].cima].saidabaixo
vagner[vagner[4].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[4].saidacima
end
end

if vagner[4].baixo ~= nil then 
vagner[4].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[4].trapdor then vagner[4].saidabaixo:AddTag("lockable_door") end
vagner[4].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[4].baixo < 4 then
vagner[4].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[4].baixo].saidacima
vagner[vagner[4].baixo].saidacima.components.teleporter.targetTeleporter = vagner[4].saidabaixo
end
end

if vagner[4].esquerda ~= nil then
vagner[4].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[4].trapdor then vagner[4].saidaesquerda:AddTag("lockable_door") end
vagner[4].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[4].esquerda < 4 then
vagner[4].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[4].esquerda].saidadireita
vagner[vagner[4].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[4].saidaesquerda
end
end

if vagner[4].direita ~= nil then
vagner[4].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[4].trapdor then vagner[4].saidadireita:AddTag("lockable_door") end
vagner[4].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[4].direita  < 4 then
vagner[4].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[4].direita].saidaesquerda
vagner[vagner[4].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[4].saidadireita
end
end
end

if vagner[5].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[5].valorx = TheWorld.components.contador:GetX()
vagner[5].valorz = TheWorld.components.contador:GetZ()

if vagner[5].cima ~= nil then 
vagner[5].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[5].trapdor then vagner[5].saidacima:AddTag("lockable_door") end
vagner[5].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[5].cima < 5 then
vagner[5].saidacima.components.teleporter.targetTeleporter = vagner[vagner[5].cima].saidabaixo
vagner[vagner[5].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[5].saidacima
end
end

if vagner[5].baixo ~= nil then 
vagner[5].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[5].trapdor then vagner[5].saidabaixo:AddTag("lockable_door") end
vagner[5].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[5].baixo < 5 then
vagner[5].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[5].baixo].saidacima
vagner[vagner[5].baixo].saidacima.components.teleporter.targetTeleporter = vagner[5].saidabaixo
end
end

if vagner[5].esquerda ~= nil then
vagner[5].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[5].trapdor then vagner[5].saidaesquerda:AddTag("lockable_door") end
vagner[5].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[5].esquerda < 5 then
vagner[5].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[5].esquerda].saidadireita
vagner[vagner[5].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[5].saidaesquerda
end
end

if vagner[5].direita ~= nil then
vagner[5].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[5].trapdor then vagner[5].saidadireita:AddTag("lockable_door") end
vagner[5].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[5].direita  < 5 then
vagner[5].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[5].direita].saidaesquerda
vagner[vagner[5].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[5].saidadireita
end
end
end

if vagner[6].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[6].valorx = TheWorld.components.contador:GetX()
vagner[6].valorz = TheWorld.components.contador:GetZ()

if vagner[6].cima ~= nil then 
vagner[6].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[6].trapdor then vagner[6].saidacima:AddTag("lockable_door") end
vagner[6].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[6].cima < 6 then
vagner[6].saidacima.components.teleporter.targetTeleporter = vagner[vagner[6].cima].saidabaixo
vagner[vagner[6].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[6].saidacima
end
end

if vagner[6].baixo ~= nil then 
vagner[6].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[6].trapdor then vagner[6].saidabaixo:AddTag("lockable_door") end
vagner[6].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[6].baixo < 6 then
vagner[6].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[6].baixo].saidacima
vagner[vagner[6].baixo].saidacima.components.teleporter.targetTeleporter = vagner[6].saidabaixo
end
end

if vagner[6].esquerda ~= nil then
vagner[6].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[6].trapdor then vagner[6].saidaesquerda:AddTag("lockable_door") end
vagner[6].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[6].esquerda < 6 then
vagner[6].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[6].esquerda].saidadireita
vagner[vagner[6].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[6].saidaesquerda
end
end

if vagner[6].direita ~= nil then
vagner[6].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[6].trapdor then vagner[6].saidadireita:AddTag("lockable_door") end
vagner[6].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[6].direita  < 6 then
vagner[6].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[6].direita].saidaesquerda
vagner[vagner[6].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[6].saidadireita
end
end
end

if vagner[7].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[7].valorx = TheWorld.components.contador:GetX()
vagner[7].valorz = TheWorld.components.contador:GetZ()

if vagner[7].cima ~= nil then 
vagner[7].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[7].trapdor then vagner[7].saidacima:AddTag("lockable_door") end
vagner[7].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[7].cima < 7 then
vagner[7].saidacima.components.teleporter.targetTeleporter = vagner[vagner[7].cima].saidabaixo
vagner[vagner[7].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[7].saidacima
end
end

if vagner[7].baixo ~= nil then 
vagner[7].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[7].trapdor then vagner[7].saidabaixo:AddTag("lockable_door") end
vagner[7].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[7].baixo < 7 then
vagner[7].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[7].baixo].saidacima
vagner[vagner[7].baixo].saidacima.components.teleporter.targetTeleporter = vagner[7].saidabaixo
end
end

if vagner[7].esquerda ~= nil then
vagner[7].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[7].trapdor then vagner[7].saidaesquerda:AddTag("lockable_door") end
vagner[7].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[7].esquerda < 7 then
vagner[7].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[7].esquerda].saidadireita
vagner[vagner[7].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[7].saidaesquerda
end
end

if vagner[7].direita ~= nil then
vagner[7].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[7].trapdor then vagner[7].saidadireita:AddTag("lockable_door") end
vagner[7].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[7].direita  < 7 then
vagner[7].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[7].direita].saidaesquerda
vagner[vagner[7].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[7].saidadireita
end
end
end

if vagner[8].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[8].valorx = TheWorld.components.contador:GetX()
vagner[8].valorz = TheWorld.components.contador:GetZ()

if vagner[8].cima ~= nil then 
vagner[8].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[8].trapdor then vagner[8].saidacima:AddTag("lockable_door") end
vagner[8].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[8].cima < 8 then
vagner[8].saidacima.components.teleporter.targetTeleporter = vagner[vagner[8].cima].saidabaixo
vagner[vagner[8].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[8].saidacima
end
end

if vagner[8].baixo ~= nil then 
vagner[8].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[8].trapdor then vagner[8].saidabaixo:AddTag("lockable_door") end
vagner[8].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[8].baixo < 8 then
vagner[8].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[8].baixo].saidacima
vagner[vagner[8].baixo].saidacima.components.teleporter.targetTeleporter = vagner[8].saidabaixo
end
end

if vagner[8].esquerda ~= nil then
vagner[8].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[8].trapdor then vagner[8].saidaesquerda:AddTag("lockable_door") end
vagner[8].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[8].esquerda < 8 then
vagner[8].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[8].esquerda].saidadireita
vagner[vagner[8].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[8].saidaesquerda
end
end

if vagner[8].direita ~= nil then
vagner[8].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[8].trapdor then vagner[8].saidadireita:AddTag("lockable_door") end
vagner[8].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[8].direita  < 8 then
vagner[8].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[8].direita].saidaesquerda
vagner[vagner[8].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[8].saidadireita
end
end
end

if vagner[9].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[9].valorx = TheWorld.components.contador:GetX()
vagner[9].valorz = TheWorld.components.contador:GetZ()

if vagner[9].cima ~= nil then 
vagner[9].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[9].trapdor then vagner[9].saidacima:AddTag("lockable_door") end
vagner[9].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[9].cima < 9 then
vagner[9].saidacima.components.teleporter.targetTeleporter = vagner[vagner[9].cima].saidabaixo
vagner[vagner[9].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[9].saidacima
end
end

if vagner[9].baixo ~= nil then 
vagner[9].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[9].trapdor then vagner[9].saidabaixo:AddTag("lockable_door") end
vagner[9].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[9].baixo < 9 then
vagner[9].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[9].baixo].saidacima
vagner[vagner[9].baixo].saidacima.components.teleporter.targetTeleporter = vagner[9].saidabaixo
end
end

if vagner[9].esquerda ~= nil then
vagner[9].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[9].trapdor then vagner[9].saidaesquerda:AddTag("lockable_door") end
vagner[9].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[9].esquerda < 9 then
vagner[9].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[9].esquerda].saidadireita
vagner[vagner[9].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[9].saidaesquerda
end
end

if vagner[9].direita ~= nil then
vagner[9].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[9].trapdor then vagner[9].saidadireita:AddTag("lockable_door") end
vagner[9].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[9].direita  < 9 then
vagner[9].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[9].direita].saidaesquerda
vagner[vagner[9].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[9].saidadireita
end
end
end

if vagner[10].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[10].valorx = TheWorld.components.contador:GetX()
vagner[10].valorz = TheWorld.components.contador:GetZ()

if vagner[10].cima ~= nil then 
vagner[10].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[10].trapdor then vagner[10].saidacima:AddTag("lockable_door") end
vagner[10].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[10].cima < 10 then
vagner[10].saidacima.components.teleporter.targetTeleporter = vagner[vagner[10].cima].saidabaixo
vagner[vagner[10].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[10].saidacima
end
end

if vagner[10].baixo ~= nil then 
vagner[10].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[10].trapdor then vagner[10].saidabaixo:AddTag("lockable_door") end
vagner[10].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[10].baixo < 10 then
vagner[10].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[10].baixo].saidacima
vagner[vagner[10].baixo].saidacima.components.teleporter.targetTeleporter = vagner[10].saidabaixo
end
end

if vagner[10].esquerda ~= nil then
vagner[10].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[10].trapdor then vagner[10].saidaesquerda:AddTag("lockable_door") end
vagner[10].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[10].esquerda < 10 then
vagner[10].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[10].esquerda].saidadireita
vagner[vagner[10].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[10].saidaesquerda
end
end

if vagner[10].direita ~= nil then
vagner[10].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[10].trapdor then vagner[10].saidadireita:AddTag("lockable_door") end
vagner[10].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[10].direita  < 10 then
vagner[10].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[10].direita].saidaesquerda
vagner[vagner[10].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[10].saidadireita
end
end
end

if vagner[11].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[11].valorx = TheWorld.components.contador:GetX()
vagner[11].valorz = TheWorld.components.contador:GetZ()

if vagner[11].cima ~= nil then 
vagner[11].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[11].trapdor then vagner[11].saidacima:AddTag("lockable_door") end
vagner[11].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[11].cima < 11 then
vagner[11].saidacima.components.teleporter.targetTeleporter = vagner[vagner[11].cima].saidabaixo
vagner[vagner[11].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[11].saidacima
end
end

if vagner[11].baixo ~= nil then 
vagner[11].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[11].trapdor then vagner[11].saidabaixo:AddTag("lockable_door") end
vagner[11].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[11].baixo < 11 then
vagner[11].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[11].baixo].saidacima
vagner[vagner[11].baixo].saidacima.components.teleporter.targetTeleporter = vagner[11].saidabaixo
end
end

if vagner[11].esquerda ~= nil then
vagner[11].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[11].trapdor then vagner[11].saidaesquerda:AddTag("lockable_door") end
vagner[11].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[11].esquerda < 11 then
vagner[11].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[11].esquerda].saidadireita
vagner[vagner[11].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[11].saidaesquerda
end
end

if vagner[11].direita ~= nil then
vagner[11].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[11].trapdor then vagner[11].saidadireita:AddTag("lockable_door") end
vagner[11].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[11].direita  < 11 then
vagner[11].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[11].direita].saidaesquerda
vagner[vagner[11].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[11].saidadireita
end
end
end

if vagner[12].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[12].valorx = TheWorld.components.contador:GetX()
vagner[12].valorz = TheWorld.components.contador:GetZ()

if vagner[12].cima ~= nil then 
vagner[12].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[12].trapdor then vagner[12].saidacima:AddTag("lockable_door") end
vagner[12].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[12].cima < 12 then
vagner[12].saidacima.components.teleporter.targetTeleporter = vagner[vagner[12].cima].saidabaixo
vagner[vagner[12].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[12].saidacima
end
end

if vagner[12].baixo ~= nil then 
vagner[12].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[12].trapdor then vagner[12].saidabaixo:AddTag("lockable_door") end
vagner[12].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[12].baixo < 12 then
vagner[12].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[12].baixo].saidacima
vagner[vagner[12].baixo].saidacima.components.teleporter.targetTeleporter = vagner[12].saidabaixo
end
end

if vagner[12].esquerda ~= nil then
vagner[12].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[12].trapdor then vagner[12].saidaesquerda:AddTag("lockable_door") end
vagner[12].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[12].esquerda < 12 then
vagner[12].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[12].esquerda].saidadireita
vagner[vagner[12].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[12].saidaesquerda
end
end

if vagner[12].direita ~= nil then
vagner[12].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[12].trapdor then vagner[12].saidadireita:AddTag("lockable_door") end
vagner[12].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[12].direita  < 12 then
vagner[12].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[12].direita].saidaesquerda
vagner[vagner[12].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[12].saidadireita
end
end
end

if vagner[13].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[13].valorx = TheWorld.components.contador:GetX()
vagner[13].valorz = TheWorld.components.contador:GetZ()

if vagner[13].cima ~= nil then 
vagner[13].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[13].trapdor then vagner[13].saidacima:AddTag("lockable_door") end
vagner[13].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[13].cima < 13 then
vagner[13].saidacima.components.teleporter.targetTeleporter = vagner[vagner[13].cima].saidabaixo
vagner[vagner[13].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[13].saidacima
end
end

if vagner[13].baixo ~= nil then 
vagner[13].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[13].trapdor then vagner[13].saidabaixo:AddTag("lockable_door") end
vagner[13].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[13].baixo < 13 then
vagner[13].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[13].baixo].saidacima
vagner[vagner[13].baixo].saidacima.components.teleporter.targetTeleporter = vagner[13].saidabaixo
end
end

if vagner[13].esquerda ~= nil then
vagner[13].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[13].trapdor then vagner[13].saidaesquerda:AddTag("lockable_door") end
vagner[13].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[13].esquerda < 13 then
vagner[13].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[13].esquerda].saidadireita
vagner[vagner[13].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[13].saidaesquerda
end
end

if vagner[13].direita ~= nil then
vagner[13].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[13].trapdor then vagner[13].saidadireita:AddTag("lockable_door") end
vagner[13].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[13].direita  < 13 then
vagner[13].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[13].direita].saidaesquerda
vagner[vagner[13].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[13].saidadireita
end
end
end

if vagner[14].numexits > 0 then
SpawnPrefab("createanthillcomumroom")

vagner[14].valorx = TheWorld.components.contador:GetX()
vagner[14].valorz = TheWorld.components.contador:GetZ()

if vagner[14].cima ~= nil then 
vagner[14].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[14].trapdor then vagner[14].saidacima:AddTag("lockable_door") end
vagner[14].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[14].cima < 14 then
vagner[14].saidacima.components.teleporter.targetTeleporter = vagner[vagner[14].cima].saidabaixo
vagner[vagner[14].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[14].saidacima
end
end

if vagner[14].baixo ~= nil then 
vagner[14].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[14].trapdor then vagner[14].saidabaixo:AddTag("lockable_door") end
vagner[14].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[14].baixo < 14 then
vagner[14].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[14].baixo].saidacima
vagner[vagner[14].baixo].saidacima.components.teleporter.targetTeleporter = vagner[14].saidabaixo
end
end

if vagner[14].esquerda ~= nil then
vagner[14].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[14].trapdor then vagner[14].saidaesquerda:AddTag("lockable_door") end
vagner[14].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[14].esquerda < 14 then
vagner[14].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[14].esquerda].saidadireita
vagner[vagner[14].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[14].saidaesquerda
end
end

if vagner[14].direita ~= nil then
vagner[14].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[14].trapdor then vagner[14].saidadireita:AddTag("lockable_door") end
vagner[14].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[14].direita  < 14 then
vagner[14].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[14].direita].saidaesquerda
vagner[vagner[14].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[14].saidadireita
end
end
end

if vagner[15].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[15].valorx = TheWorld.components.contador:GetX()
vagner[15].valorz = TheWorld.components.contador:GetZ()

if vagner[15].cima ~= nil then 
vagner[15].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[15].trapdor then vagner[15].saidacima:AddTag("lockable_door") end
vagner[15].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[15].cima < 15 then
vagner[15].saidacima.components.teleporter.targetTeleporter = vagner[vagner[15].cima].saidabaixo
vagner[vagner[15].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[15].saidacima
end
end

if vagner[15].baixo ~= nil then 
vagner[15].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[15].trapdor then vagner[15].saidabaixo:AddTag("lockable_door") end
vagner[15].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[15].baixo < 15 then
vagner[15].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[15].baixo].saidacima
vagner[vagner[15].baixo].saidacima.components.teleporter.targetTeleporter = vagner[15].saidabaixo
end
end

if vagner[15].esquerda ~= nil then
vagner[15].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[15].trapdor then vagner[15].saidaesquerda:AddTag("lockable_door") end
vagner[15].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[15].esquerda < 15 then
vagner[15].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[15].esquerda].saidadireita
vagner[vagner[15].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[15].saidaesquerda
end
end

if vagner[15].direita ~= nil then
vagner[15].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[15].trapdor then vagner[15].saidadireita:AddTag("lockable_door") end
vagner[15].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[15].direita  < 15 then
vagner[15].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[15].direita].saidaesquerda
vagner[vagner[15].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[15].saidadireita
end
end
end

if vagner[16].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[16].valorx = TheWorld.components.contador:GetX()
vagner[16].valorz = TheWorld.components.contador:GetZ()

if vagner[16].cima ~= nil then 
vagner[16].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[16].trapdor then vagner[16].saidacima:AddTag("lockable_door") end
vagner[16].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[16].cima < 16 then
vagner[16].saidacima.components.teleporter.targetTeleporter = vagner[vagner[16].cima].saidabaixo
vagner[vagner[16].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[16].saidacima
end
end

if vagner[16].baixo ~= nil then 
vagner[16].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[16].trapdor then vagner[16].saidabaixo:AddTag("lockable_door") end
vagner[16].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[16].baixo < 16 then
vagner[16].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[16].baixo].saidacima
vagner[vagner[16].baixo].saidacima.components.teleporter.targetTeleporter = vagner[16].saidabaixo
end
end

if vagner[16].esquerda ~= nil then
vagner[16].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[16].trapdor then vagner[16].saidaesquerda:AddTag("lockable_door") end
vagner[16].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[16].esquerda < 16 then
vagner[16].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[16].esquerda].saidadireita
vagner[vagner[16].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[16].saidaesquerda
end
end

if vagner[16].direita ~= nil then
vagner[16].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[16].trapdor then vagner[16].saidadireita:AddTag("lockable_door") end
vagner[16].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[16].direita  < 16 then
vagner[16].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[16].direita].saidaesquerda
vagner[vagner[16].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[16].saidadireita
end
end
end

if vagner[17].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[17].valorx = TheWorld.components.contador:GetX()
vagner[17].valorz = TheWorld.components.contador:GetZ()

if vagner[17].cima ~= nil then 
vagner[17].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[17].trapdor then vagner[17].saidacima:AddTag("lockable_door") end
vagner[17].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[17].cima < 17 then
vagner[17].saidacima.components.teleporter.targetTeleporter = vagner[vagner[17].cima].saidabaixo
vagner[vagner[17].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[17].saidacima
end
end

if vagner[17].baixo ~= nil then 
vagner[17].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[17].trapdor then vagner[17].saidabaixo:AddTag("lockable_door") end
vagner[17].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[17].baixo < 17 then
vagner[17].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[17].baixo].saidacima
vagner[vagner[17].baixo].saidacima.components.teleporter.targetTeleporter = vagner[17].saidabaixo
end
end

if vagner[17].esquerda ~= nil then
vagner[17].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[17].trapdor then vagner[17].saidaesquerda:AddTag("lockable_door") end
vagner[17].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[17].esquerda < 17 then
vagner[17].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[17].esquerda].saidadireita
vagner[vagner[17].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[17].saidaesquerda
end
end

if vagner[17].direita ~= nil then
vagner[17].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[17].trapdor then vagner[17].saidadireita:AddTag("lockable_door") end
vagner[17].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[17].direita  < 17 then
vagner[17].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[17].direita].saidaesquerda
vagner[vagner[17].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[17].saidadireita
end
end
end

if vagner[18].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[18].valorx = TheWorld.components.contador:GetX()
vagner[18].valorz = TheWorld.components.contador:GetZ()

if vagner[18].cima ~= nil then 
vagner[18].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[18].trapdor then vagner[18].saidacima:AddTag("lockable_door") end
vagner[18].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[18].cima < 18 then
vagner[18].saidacima.components.teleporter.targetTeleporter = vagner[vagner[18].cima].saidabaixo
vagner[vagner[18].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[18].saidacima
end
end

if vagner[18].baixo ~= nil then 
vagner[18].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[18].trapdor then vagner[18].saidabaixo:AddTag("lockable_door") end
vagner[18].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[18].baixo < 18 then
vagner[18].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[18].baixo].saidacima
vagner[vagner[18].baixo].saidacima.components.teleporter.targetTeleporter = vagner[18].saidabaixo
end
end

if vagner[18].esquerda ~= nil then
vagner[18].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[18].trapdor then vagner[18].saidaesquerda:AddTag("lockable_door") end
vagner[18].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[18].esquerda < 18 then
vagner[18].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[18].esquerda].saidadireita
vagner[vagner[18].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[18].saidaesquerda
end
end

if vagner[18].direita ~= nil then
vagner[18].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[18].trapdor then vagner[18].saidadireita:AddTag("lockable_door") end
vagner[18].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[18].direita  < 18 then
vagner[18].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[18].direita].saidaesquerda
vagner[vagner[18].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[18].saidadireita
end
end
end

if vagner[19].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[19].valorx = TheWorld.components.contador:GetX()
vagner[19].valorz = TheWorld.components.contador:GetZ()

if vagner[19].cima ~= nil then 
vagner[19].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[19].trapdor then vagner[19].saidacima:AddTag("lockable_door") end
vagner[19].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[19].cima < 19 then
vagner[19].saidacima.components.teleporter.targetTeleporter = vagner[vagner[19].cima].saidabaixo
vagner[vagner[19].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[19].saidacima
end
end

if vagner[19].baixo ~= nil then 
vagner[19].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[19].trapdor then vagner[19].saidabaixo:AddTag("lockable_door") end
vagner[19].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[19].baixo < 19 then
vagner[19].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[19].baixo].saidacima
vagner[vagner[19].baixo].saidacima.components.teleporter.targetTeleporter = vagner[19].saidabaixo
end
end

if vagner[19].esquerda ~= nil then
vagner[19].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[19].trapdor then vagner[19].saidaesquerda:AddTag("lockable_door") end
vagner[19].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[19].esquerda < 19 then
vagner[19].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[19].esquerda].saidadireita
vagner[vagner[19].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[19].saidaesquerda
end
end

if vagner[19].direita ~= nil then
vagner[19].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[19].trapdor then vagner[19].saidadireita:AddTag("lockable_door") end
vagner[19].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[19].direita  < 19 then
vagner[19].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[19].direita].saidaesquerda
vagner[vagner[19].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[19].saidadireita
end
end
end

if vagner[20].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[20].valorx = TheWorld.components.contador:GetX()
vagner[20].valorz = TheWorld.components.contador:GetZ()

if vagner[20].cima ~= nil then 
vagner[20].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[20].trapdor then vagner[20].saidacima:AddTag("lockable_door") end
vagner[20].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[20].cima < 20 then
vagner[20].saidacima.components.teleporter.targetTeleporter = vagner[vagner[20].cima].saidabaixo
vagner[vagner[20].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[20].saidacima
end
end

if vagner[20].baixo ~= nil then 
vagner[20].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[20].trapdor then vagner[20].saidabaixo:AddTag("lockable_door") end
vagner[20].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[20].baixo < 20 then
vagner[20].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[20].baixo].saidacima
vagner[vagner[20].baixo].saidacima.components.teleporter.targetTeleporter = vagner[20].saidabaixo
end
end

if vagner[20].esquerda ~= nil then
vagner[20].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[20].trapdor then vagner[20].saidaesquerda:AddTag("lockable_door") end
vagner[20].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[20].esquerda < 20 then
vagner[20].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[20].esquerda].saidadireita
vagner[vagner[20].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[20].saidaesquerda
end
end

if vagner[20].direita ~= nil then
vagner[20].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[20].trapdor then vagner[20].saidadireita:AddTag("lockable_door") end
vagner[20].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[20].direita  < 20 then
vagner[20].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[20].direita].saidaesquerda
vagner[vagner[20].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[20].saidadireita
end
end
end

if vagner[21].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[21].valorx = TheWorld.components.contador:GetX()
vagner[21].valorz = TheWorld.components.contador:GetZ()

if vagner[21].cima ~= nil then 
vagner[21].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[21].trapdor then vagner[21].saidacima:AddTag("lockable_door") end
vagner[21].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[21].cima < 21 then
vagner[21].saidacima.components.teleporter.targetTeleporter = vagner[vagner[21].cima].saidabaixo
vagner[vagner[21].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[21].saidacima
end
end

if vagner[21].baixo ~= nil then 
vagner[21].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[21].trapdor then vagner[21].saidabaixo:AddTag("lockable_door") end
vagner[21].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[21].baixo < 21 then
vagner[21].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[21].baixo].saidacima
vagner[vagner[21].baixo].saidacima.components.teleporter.targetTeleporter = vagner[21].saidabaixo
end
end

if vagner[21].esquerda ~= nil then
vagner[21].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[21].trapdor then vagner[21].saidaesquerda:AddTag("lockable_door") end
vagner[21].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[21].esquerda < 21 then
vagner[21].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[21].esquerda].saidadireita
vagner[vagner[21].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[21].saidaesquerda
end
end

if vagner[21].direita ~= nil then
vagner[21].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[21].trapdor then vagner[21].saidadireita:AddTag("lockable_door") end
vagner[21].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[21].direita  < 21 then
vagner[21].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[21].direita].saidaesquerda
vagner[vagner[21].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[21].saidadireita
end
end
end

if vagner[22].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[22].valorx = TheWorld.components.contador:GetX()
vagner[22].valorz = TheWorld.components.contador:GetZ()

if vagner[22].cima ~= nil then 
vagner[22].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[22].trapdor then vagner[22].saidacima:AddTag("lockable_door") end
vagner[22].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[22].cima < 22 then
vagner[22].saidacima.components.teleporter.targetTeleporter = vagner[vagner[22].cima].saidabaixo
vagner[vagner[22].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[22].saidacima
end
end

if vagner[22].baixo ~= nil then 
vagner[22].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[22].trapdor then vagner[22].saidabaixo:AddTag("lockable_door") end
vagner[22].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[22].baixo < 22 then
vagner[22].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[22].baixo].saidacima
vagner[vagner[22].baixo].saidacima.components.teleporter.targetTeleporter = vagner[22].saidabaixo
end
end

if vagner[22].esquerda ~= nil then
vagner[22].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[22].trapdor then vagner[22].saidaesquerda:AddTag("lockable_door") end
vagner[22].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[22].esquerda < 22 then
vagner[22].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[22].esquerda].saidadireita
vagner[vagner[22].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[22].saidaesquerda
end
end

if vagner[22].direita ~= nil then
vagner[22].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[22].trapdor then vagner[22].saidadireita:AddTag("lockable_door") end
vagner[22].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[22].direita  < 22 then
vagner[22].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[22].direita].saidaesquerda
vagner[vagner[22].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[22].saidadireita
end
end
end

if vagner[23].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[23].valorx = TheWorld.components.contador:GetX()
vagner[23].valorz = TheWorld.components.contador:GetZ()

if vagner[23].cima ~= nil then 
vagner[23].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[23].trapdor then vagner[23].saidacima:AddTag("lockable_door") end
vagner[23].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[23].cima < 23 then
vagner[23].saidacima.components.teleporter.targetTeleporter = vagner[vagner[23].cima].saidabaixo
vagner[vagner[23].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[23].saidacima
end
end

if vagner[23].baixo ~= nil then 
vagner[23].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[23].trapdor then vagner[23].saidabaixo:AddTag("lockable_door") end
vagner[23].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[23].baixo < 23 then
vagner[23].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[23].baixo].saidacima
vagner[vagner[23].baixo].saidacima.components.teleporter.targetTeleporter = vagner[23].saidabaixo
end
end

if vagner[23].esquerda ~= nil then
vagner[23].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[23].trapdor then vagner[23].saidaesquerda:AddTag("lockable_door") end
vagner[23].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[23].esquerda < 23 then
vagner[23].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[23].esquerda].saidadireita
vagner[vagner[23].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[23].saidaesquerda
end
end

if vagner[23].direita ~= nil then
vagner[23].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[23].trapdor then vagner[23].saidadireita:AddTag("lockable_door") end
vagner[23].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[23].direita  < 23 then
vagner[23].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[23].direita].saidaesquerda
vagner[vagner[23].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[23].saidadireita
end
end
end

if vagner[24].numexits > 0 then
SpawnPrefab("createanthilldefaltroom")

vagner[24].valorx = TheWorld.components.contador:GetX()
vagner[24].valorz = TheWorld.components.contador:GetZ()

if vagner[24].cima ~= nil then 
vagner[24].saidacima = SpawnPrefab("anthill_door_cima")
if vagner[24].trapdor then vagner[24].saidacima:AddTag("lockable_door") end
vagner[24].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[24].cima < 24 then
vagner[24].saidacima.components.teleporter.targetTeleporter = vagner[vagner[24].cima].saidabaixo
vagner[vagner[24].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[24].saidacima
end
end

if vagner[24].baixo ~= nil then 
vagner[24].saidabaixo = SpawnPrefab("anthill_door_baixo")
if vagner[24].trapdor then vagner[24].saidabaixo:AddTag("lockable_door") end
vagner[24].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[24].baixo < 24 then
vagner[24].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[24].baixo].saidacima
vagner[vagner[24].baixo].saidacima.components.teleporter.targetTeleporter = vagner[24].saidabaixo
end
end

if vagner[24].esquerda ~= nil then
vagner[24].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[24].trapdor then vagner[24].saidaesquerda:AddTag("lockable_door") end
vagner[24].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[24].esquerda < 24 then
vagner[24].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[24].esquerda].saidadireita
vagner[vagner[24].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[24].saidaesquerda
end
end

if vagner[24].direita ~= nil then
vagner[24].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[24].trapdor then vagner[24].saidadireita:AddTag("lockable_door") end
vagner[24].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[24].direita  < 24 then
vagner[24].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[24].direita].saidaesquerda
vagner[vagner[24].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[24].saidadireita
end
end
end



end
---------------------------------------------------------anthill Queen--------------------------------------------------------------------------
if inst.tipodemaze == 7 then
local distportacima = 9.3
local distportabaixo = -7
local distportaesquerda = -12.5
local distportadireita = 13.5

SpawnPrefab("createanthillchamberroom")
vagner[1].valorx = TheWorld.components.contador:GetX()
vagner[1].valorz = TheWorld.components.contador:GetZ()


if vagner[1].numexits > 0 then
vagner[1].saidacima = SpawnPrefab("anthill_door_baixo")
vagner[1].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())
---------
if vagner[1].baixo ~= nil then 
vagner[1].saidabaixo = SpawnPrefab("anthill_door_cima")
vagner[1].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())
end
--------------
if vagner[1].esquerda ~= nil then 
vagner[1].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
vagner[1].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)
end
--------------------
if vagner[1].direita ~= nil then 
vagner[1].saidadireita = SpawnPrefab("anthill_door_direita")
vagner[1].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)
end

local portaentrada = SpawnPrefab("anthill_door_queen")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada

end 



if vagner[2].numexits > 0 then
SpawnPrefab("createanthillchamberroom")

vagner[2].valorx = TheWorld.components.contador:GetX()
vagner[2].valorz = TheWorld.components.contador:GetZ()

if vagner[2].cima ~= nil then
vagner[2].saidacima = SpawnPrefab("anthill_door_baixo")
if vagner[2].trapdor then vagner[2].saidacima:AddTag("lockable_door") end
vagner[2].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[2].cima < 2 then
vagner[2].saidacima.components.teleporter.targetTeleporter = vagner[vagner[2].cima].saidabaixo
vagner[vagner[2].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[2].saidacima
end
end

if vagner[2].baixo ~= nil then 
vagner[2].saidabaixo = SpawnPrefab("anthill_door_cima")
if vagner[2].trapdor then vagner[2].saidabaixo:AddTag("lockable_door") end
vagner[2].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[2].baixo < 2 then
vagner[2].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[2].baixo].saidacima
vagner[vagner[2].baixo].saidacima.components.teleporter.targetTeleporter = vagner[2].saidabaixo
end
end

if vagner[2].esquerda ~= nil then
vagner[2].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[2].trapdor then vagner[2].saidaesquerda:AddTag("lockable_door") end
vagner[2].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[2].esquerda < 2 then
vagner[2].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[2].esquerda].saidadireita
vagner[vagner[2].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[2].saidaesquerda
end
end

if vagner[2].direita ~= nil then
vagner[2].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[2].trapdor then vagner[2].saidadireita:AddTag("lockable_door") end
vagner[2].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[2].direita  < 2 then
vagner[2].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[2].direita].saidaesquerda
vagner[vagner[2].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[2].saidadireita
end
end
end

if vagner[3].numexits > 0 then
SpawnPrefab("createanthillchamberroom")

vagner[3].valorx = TheWorld.components.contador:GetX()
vagner[3].valorz = TheWorld.components.contador:GetZ()

if vagner[3].cima ~= nil then 
vagner[3].saidacima = SpawnPrefab("anthill_door_baixo")
if vagner[3].trapdor then vagner[3].saidacima:AddTag("lockable_door") end
vagner[3].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[3].cima < 3 then
vagner[3].saidacima.components.teleporter.targetTeleporter = vagner[vagner[3].cima].saidabaixo
vagner[vagner[3].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[3].saidacima
end
end

if vagner[3].baixo ~= nil then 
vagner[3].saidabaixo = SpawnPrefab("anthill_door_cima")
if vagner[3].trapdor then vagner[3].saidabaixo:AddTag("lockable_door") end
vagner[3].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[3].baixo < 3 then
vagner[3].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[3].baixo].saidacima
vagner[vagner[3].baixo].saidacima.components.teleporter.targetTeleporter = vagner[3].saidabaixo
end
end

if vagner[3].esquerda ~= nil then
vagner[3].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[3].trapdor then vagner[3].saidaesquerda:AddTag("lockable_door") end
vagner[3].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[3].esquerda < 3 then
vagner[3].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[3].esquerda].saidadireita
vagner[vagner[3].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[3].saidaesquerda
end
end

if vagner[3].direita ~= nil then
vagner[3].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[3].trapdor then vagner[3].saidadireita:AddTag("lockable_door") end
vagner[3].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[3].direita  < 3 then
vagner[3].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[3].direita].saidaesquerda
vagner[vagner[3].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[3].saidadireita
end
end
end

if vagner[4].numexits > 0 then
SpawnPrefab("createanthillchamberroom")

vagner[4].valorx = TheWorld.components.contador:GetX()
vagner[4].valorz = TheWorld.components.contador:GetZ()

if vagner[4].cima ~= nil then 
vagner[4].saidacima = SpawnPrefab("anthill_door_baixo")
if vagner[4].trapdor then vagner[4].saidacima:AddTag("lockable_door") end
vagner[4].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[4].cima < 4 then
vagner[4].saidacima.components.teleporter.targetTeleporter = vagner[vagner[4].cima].saidabaixo
vagner[vagner[4].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[4].saidacima
end
end

if vagner[4].baixo ~= nil then 
vagner[4].saidabaixo = SpawnPrefab("anthill_door_cima")
if vagner[4].trapdor then vagner[4].saidabaixo:AddTag("lockable_door") end
vagner[4].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[4].baixo < 4 then
vagner[4].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[4].baixo].saidacima
vagner[vagner[4].baixo].saidacima.components.teleporter.targetTeleporter = vagner[4].saidabaixo
end
end

if vagner[4].esquerda ~= nil then
vagner[4].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[4].trapdor then vagner[4].saidaesquerda:AddTag("lockable_door") end
vagner[4].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[4].esquerda < 4 then
vagner[4].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[4].esquerda].saidadireita
vagner[vagner[4].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[4].saidaesquerda
end
end

if vagner[4].direita ~= nil then
vagner[4].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[4].trapdor then vagner[4].saidadireita:AddTag("lockable_door") end
vagner[4].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[4].direita  < 4 then
vagner[4].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[4].direita].saidaesquerda
vagner[vagner[4].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[4].saidadireita
end
end
end

if vagner[5].numexits > 0 then
SpawnPrefab("createanthillqueenroom")

vagner[5].valorx = TheWorld.components.contador:GetX()
vagner[5].valorz = TheWorld.components.contador:GetZ()

if vagner[5].cima ~= nil then 
vagner[5].saidacima = SpawnPrefab("anthill_door_baixo")
if vagner[5].trapdor then vagner[5].saidacima:AddTag("lockable_door") end
vagner[5].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[5].cima < 5 then
vagner[5].saidacima.components.teleporter.targetTeleporter = vagner[vagner[5].cima].saidabaixo
vagner[vagner[5].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[5].saidacima
end
end

if vagner[5].baixo ~= nil then 
vagner[5].saidabaixo = SpawnPrefab("anthill_door_cima")
if vagner[5].trapdor then vagner[5].saidabaixo:AddTag("lockable_door") end
vagner[5].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[5].baixo < 5 then
vagner[5].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[5].baixo].saidacima
vagner[vagner[5].baixo].saidacima.components.teleporter.targetTeleporter = vagner[5].saidabaixo
end
end

if vagner[5].esquerda ~= nil then
vagner[5].saidaesquerda = SpawnPrefab("anthill_door_esquerda")
if vagner[5].trapdor then vagner[5].saidaesquerda:AddTag("lockable_door") end
vagner[5].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[5].esquerda < 5 then
vagner[5].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[5].esquerda].saidadireita
vagner[vagner[5].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[5].saidaesquerda
end
end

if vagner[5].direita ~= nil then
vagner[5].saidadireita = SpawnPrefab("anthill_door_direita")
if vagner[5].trapdor then vagner[5].saidadireita:AddTag("lockable_door") end
vagner[5].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[5].direita  < 5 then
vagner[5].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[5].direita].saidaesquerda
vagner[vagner[5].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[5].saidadireita
end
end
end

end
---------------------------------------------------------pig ruins------------------------------------------------------------------------
--Prefab("pig_ruins_door_cimaescondida", fnescadacimaescondida, assets),
--Prefab("pig_ruins_door_baixoescondida", fnescadabaixoescondida, assets),
--Prefab("pig_ruins_door_esquerdaescondida", fnescadaesquerdaescondida, assets),
--Prefab("pig_ruins_door_direitaescondida", fnescadadireitaescondida, assets),	

local function portacomvinhacima(inst, trap)
if trap == true then return "pig_ruins_door_cima" end
if math.random() < 0.2 then return "pig_ruins_door_cimaescondida" end
if inst.entradadaruina == 0 then return "pig_ruins_door_cima" end
if inst.entradadaruina == 1 then if math.random() < 0.3 then return "pig_ruins_door_cimavine" else return "pig_ruins_door_cima" end end
if inst.entradadaruina == 2 then if math.random() < 0.6 then return "pig_ruins_door_cimavine" else return "pig_ruins_door_cima" end end
if inst.entradadaruina == 3 then if math.random() < 0.3 then return "pig_ruins_door_cimavine" else return "pig_ruins_door_cima" end end
if inst.entradadaruina == 4 then if math.random() < 0.4 then return "pig_ruins_door_cimavine" else return "pig_ruins_door_cima" end end
if inst.entradadaruina == 5 then if math.random() < 0.6 then return "pig_ruins_door_cimavine" else return "pig_ruins_door_cima" end end
if inst.entradadaruina == 6 then if math.random() < 0.5 then return "pig_ruins_door_cimavine" else return "pig_ruins_door_cima" end end
end

local function portacomvinhabaixo(inst, trap)
if trap == true then return "pig_ruins_door_baixo" end
if math.random() < 0.2 then return "pig_ruins_door_baixoescondida" end
if inst.entradadaruina == 0 then return "pig_ruins_door_baixo" end
if inst.entradadaruina == 1 then if math.random() < 0.3 then return "pig_ruins_door_baixovine" else return "pig_ruins_door_baixo" end end
if inst.entradadaruina == 2 then if math.random() < 0.6 then return "pig_ruins_door_baixovine" else return "pig_ruins_door_baixo" end end
if inst.entradadaruina == 3 then if math.random() < 0.3 then return "pig_ruins_door_baixovine" else return "pig_ruins_door_baixo" end end
if inst.entradadaruina == 4 then if math.random() < 0.4 then return "pig_ruins_door_baixovine" else return "pig_ruins_door_baixo" end end
if inst.entradadaruina == 5 then if math.random() < 0.6 then return "pig_ruins_door_baixovine" else return "pig_ruins_door_baixo" end end
if inst.entradadaruina == 6 then if math.random() < 0.5 then return "pig_ruins_door_baixovine" else return "pig_ruins_door_baixo" end end
end

local function portacomvinhaesquerda(inst, trap)
if trap == true then return "pig_ruins_door_esquerda" end
if math.random() < 0.2 then return "pig_ruins_door_esquerdaescondida" end
if inst.entradadaruina == 0 then return "pig_ruins_door_esquerda" end
if inst.entradadaruina == 1 then if math.random() < 0.3 then return "pig_ruins_door_esquerdavine" else return "pig_ruins_door_esquerda" end end
if inst.entradadaruina == 2 then if math.random() < 0.6 then return "pig_ruins_door_esquerdavine" else return "pig_ruins_door_esquerda" end end
if inst.entradadaruina == 3 then if math.random() < 0.3 then return "pig_ruins_door_esquerdavine" else return "pig_ruins_door_esquerda" end end
if inst.entradadaruina == 4 then if math.random() < 0.4 then return "pig_ruins_door_esquerdavine" else return "pig_ruins_door_esquerda" end end
if inst.entradadaruina == 5 then if math.random() < 0.6 then return "pig_ruins_door_esquerdavine" else return "pig_ruins_door_esquerda" end end
if inst.entradadaruina == 6 then if math.random() < 0.5 then return "pig_ruins_door_esquerdavine" else return "pig_ruins_door_esquerda" end end
end

local function portacomvinhadireita(inst, trap)
if trap == true then return "pig_ruins_door_direita" end
if math.random() < 0.2 then return "pig_ruins_door_direitaescondida" end
if inst.entradadaruina == 0 then return "pig_ruins_door_direita" end
if inst.entradadaruina == 1 then if math.random() < 0.3 then return "pig_ruins_door_direitavine" else return "pig_ruins_door_direita" end end
if inst.entradadaruina == 2 then if math.random() < 0.6 then return "pig_ruins_door_direitavine" else return "pig_ruins_door_direita" end end
if inst.entradadaruina == 3 then if math.random() < 0.3 then return "pig_ruins_door_direitavine" else return "pig_ruins_door_direita" end end
if inst.entradadaruina == 4 then if math.random() < 0.4 then return "pig_ruins_door_direitavine" else return "pig_ruins_door_direita" end end
if inst.entradadaruina == 5 then if math.random() < 0.6 then return "pig_ruins_door_direitavine" else return "pig_ruins_door_direita" end end
if inst.entradadaruina == 6 then if math.random() < 0.5 then return "pig_ruins_door_direitavine" else return "pig_ruins_door_direita" end end
end


if inst.tipodemaze < 5 or inst.tipodemaze == 8 or inst.tipodemaze == 9 then
SpawnPrefab("createroominicio")
vagner[1].valorx = TheWorld.components.contador:GetX()
vagner[1].valorz = TheWorld.components.contador:GetZ()

if vagner[1].numexits > 0 then
vagner[1].saidacima = SpawnPrefab("pig_ruins_door_entrada")
vagner[1].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())
---------
if vagner[1].baixo ~= nil then 
vagner[1].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst))
vagner[1].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())
end
--------------
if vagner[1].esquerda ~= nil then 
vagner[1].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst))
vagner[1].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)
end
--------------------
if vagner[1].direita ~= nil then 
vagner[1].saidadireita = SpawnPrefab(portacomvinhadireita(inst))
vagner[1].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)
end

if inst.entradadaruina == 0 then
local portaentrada = SpawnPrefab("pig_ruins_entrance_small")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada
end
if inst.entradadaruina == 1 then
local portaentrada = SpawnPrefab("pig_ruins_entrance")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada
end
if inst.entradadaruina == 2 then
local portaentrada = SpawnPrefab("pig_ruins_entrance2")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada
end
if inst.entradadaruina == 3 then
local portaentrada = SpawnPrefab("pig_ruins_entrance3")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada
end
if inst.entradadaruina == 4 then
local portaentrada = SpawnPrefab("pig_ruins_entrance4")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada
end
if inst.entradadaruina == 5 then
local portaentrada = SpawnPrefab("pig_ruins_entrance5")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada
end

if inst.entradadaruina == 6 then
local portaentrada = SpawnPrefab("pig_ruins_entrance6")
local x, y, z = inst.Transform:GetWorldPosition()
portaentrada.Transform:SetPosition(x, y, z)
portaentrada.components.teleporter.targetTeleporter = vagner[1].saidacima
vagner[1].saidacima.components.teleporter.targetTeleporter = portaentrada
end

end 



if vagner[2].numexits > 0 then
if inst.saladotesouso == vagner[2].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[2].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[2].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[2].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[2].valorx = TheWorld.components.contador:GetX()
vagner[2].valorz = TheWorld.components.contador:GetZ()

if vagner[2].cima ~= nil then
vagner[2].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[2].trapdor))
if vagner[2].trapdor then vagner[2].saidacima:AddTag("lockable_door") end
vagner[2].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[2].cima < 2 then
vagner[2].saidacima.components.teleporter.targetTeleporter = vagner[vagner[2].cima].saidabaixo
vagner[vagner[2].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[2].saidacima
end
end

if vagner[2].baixo ~= nil then 
vagner[2].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[2].trapdor))
if vagner[2].trapdor then vagner[2].saidabaixo:AddTag("lockable_door") end
vagner[2].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[2].baixo < 2 then
vagner[2].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[2].baixo].saidacima
vagner[vagner[2].baixo].saidacima.components.teleporter.targetTeleporter = vagner[2].saidabaixo
end
end

if vagner[2].esquerda ~= nil then
vagner[2].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[2].trapdor))
if vagner[2].trapdor then vagner[2].saidaesquerda:AddTag("lockable_door") end
vagner[2].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[2].esquerda < 2 then
vagner[2].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[2].esquerda].saidadireita
vagner[vagner[2].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[2].saidaesquerda
end
end

if vagner[2].direita ~= nil then
vagner[2].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[2].trapdor))
if vagner[2].trapdor then vagner[2].saidadireita:AddTag("lockable_door") end
vagner[2].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[2].direita  < 2 then
vagner[2].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[2].direita].saidaesquerda
vagner[vagner[2].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[2].saidadireita
end
end
end

if vagner[3].numexits > 0 then
if inst.saladotesouso == vagner[3].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[3].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[3].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[3].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[3].valorx = TheWorld.components.contador:GetX()
vagner[3].valorz = TheWorld.components.contador:GetZ()

if vagner[3].cima ~= nil then 
vagner[3].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[3].trapdor))
if vagner[3].trapdor then vagner[3].saidacima:AddTag("lockable_door") end
vagner[3].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[3].cima < 3 then
vagner[3].saidacima.components.teleporter.targetTeleporter = vagner[vagner[3].cima].saidabaixo
vagner[vagner[3].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[3].saidacima
end
end

if vagner[3].baixo ~= nil then 
vagner[3].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[3].trapdor))
if vagner[3].trapdor then vagner[3].saidabaixo:AddTag("lockable_door") end
vagner[3].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[3].baixo < 3 then
vagner[3].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[3].baixo].saidacima
vagner[vagner[3].baixo].saidacima.components.teleporter.targetTeleporter = vagner[3].saidabaixo
end
end

if vagner[3].esquerda ~= nil then
vagner[3].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[3].trapdor))
if vagner[3].trapdor then vagner[3].saidaesquerda:AddTag("lockable_door") end
vagner[3].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[3].esquerda < 3 then
vagner[3].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[3].esquerda].saidadireita
vagner[vagner[3].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[3].saidaesquerda
end
end

if vagner[3].direita ~= nil then
vagner[3].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[3].trapdor))
if vagner[3].trapdor then vagner[3].saidadireita:AddTag("lockable_door") end
vagner[3].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[3].direita  < 3 then
vagner[3].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[3].direita].saidaesquerda
vagner[vagner[3].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[3].saidadireita
end
end
end

if vagner[4].numexits > 0 then
if inst.saladotesouso == vagner[4].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[4].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[4].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[4].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[4].valorx = TheWorld.components.contador:GetX()
vagner[4].valorz = TheWorld.components.contador:GetZ()

if vagner[4].cima ~= nil then 
vagner[4].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[4].trapdor))
if vagner[4].trapdor then vagner[4].saidacima:AddTag("lockable_door") end
vagner[4].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[4].cima < 4 then
vagner[4].saidacima.components.teleporter.targetTeleporter = vagner[vagner[4].cima].saidabaixo
vagner[vagner[4].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[4].saidacima
end
end

if vagner[4].baixo ~= nil then 
vagner[4].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[4].trapdor))
if vagner[4].trapdor then vagner[4].saidabaixo:AddTag("lockable_door") end
vagner[4].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[4].baixo < 4 then
vagner[4].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[4].baixo].saidacima
vagner[vagner[4].baixo].saidacima.components.teleporter.targetTeleporter = vagner[4].saidabaixo
end
end

if vagner[4].esquerda ~= nil then
vagner[4].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[4].trapdor))
if vagner[4].trapdor then vagner[4].saidaesquerda:AddTag("lockable_door") end
vagner[4].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[4].esquerda < 4 then
vagner[4].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[4].esquerda].saidadireita
vagner[vagner[4].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[4].saidaesquerda
end
end

if vagner[4].direita ~= nil then
vagner[4].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[4].trapdor))
if vagner[4].trapdor then vagner[4].saidadireita:AddTag("lockable_door") end
vagner[4].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[4].direita  < 4 then
vagner[4].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[4].direita].saidaesquerda
vagner[vagner[4].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[4].saidadireita
end
end
end

if vagner[5].numexits > 0 then
if inst.saladotesouso == vagner[5].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[5].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[5].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[5].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[5].valorx = TheWorld.components.contador:GetX()
vagner[5].valorz = TheWorld.components.contador:GetZ()

if vagner[5].cima ~= nil then 
vagner[5].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[5].trapdor))
if vagner[5].trapdor then vagner[5].saidacima:AddTag("lockable_door") end
vagner[5].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[5].cima < 5 then
vagner[5].saidacima.components.teleporter.targetTeleporter = vagner[vagner[5].cima].saidabaixo
vagner[vagner[5].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[5].saidacima
end
end

if vagner[5].baixo ~= nil then 
vagner[5].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[5].trapdor))
if vagner[5].trapdor then vagner[5].saidabaixo:AddTag("lockable_door") end
vagner[5].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[5].baixo < 5 then
vagner[5].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[5].baixo].saidacima
vagner[vagner[5].baixo].saidacima.components.teleporter.targetTeleporter = vagner[5].saidabaixo
end
end

if vagner[5].esquerda ~= nil then
vagner[5].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[5].trapdor))
if vagner[5].trapdor then vagner[5].saidaesquerda:AddTag("lockable_door") end
vagner[5].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[5].esquerda < 5 then
vagner[5].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[5].esquerda].saidadireita
vagner[vagner[5].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[5].saidaesquerda
end
end

if vagner[5].direita ~= nil then
vagner[5].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[5].trapdor))
if vagner[5].trapdor then vagner[5].saidadireita:AddTag("lockable_door") end
vagner[5].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[5].direita  < 5 then
vagner[5].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[5].direita].saidaesquerda
vagner[vagner[5].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[5].saidadireita
end
end
end

if vagner[6].numexits > 0 then
if inst.saladotesouso == vagner[6].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[6].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[6].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[6].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[6].valorx = TheWorld.components.contador:GetX()
vagner[6].valorz = TheWorld.components.contador:GetZ()

if vagner[6].cima ~= nil then 
vagner[6].saidacima = SpawnPrefab(portacomvinhacima(inst))
if vagner[6].trapdor then vagner[6].saidacima:AddTag("lockable_door") end
vagner[6].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[6].cima < 6 then
vagner[6].saidacima.components.teleporter.targetTeleporter = vagner[vagner[6].cima].saidabaixo
vagner[vagner[6].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[6].saidacima
end
end

if vagner[6].baixo ~= nil then 
vagner[6].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[6].trapdor))
if vagner[6].trapdor then vagner[6].saidabaixo:AddTag("lockable_door") end
vagner[6].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[6].baixo < 6 then
vagner[6].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[6].baixo].saidacima
vagner[vagner[6].baixo].saidacima.components.teleporter.targetTeleporter = vagner[6].saidabaixo
end
end

if vagner[6].esquerda ~= nil then
vagner[6].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[6].trapdor))
if vagner[6].trapdor then vagner[6].saidaesquerda:AddTag("lockable_door") end
vagner[6].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[6].esquerda < 6 then
vagner[6].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[6].esquerda].saidadireita
vagner[vagner[6].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[6].saidaesquerda
end
end

if vagner[6].direita ~= nil then
vagner[6].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[6].trapdor))
if vagner[6].trapdor then vagner[6].saidadireita:AddTag("lockable_door") end
vagner[6].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[6].direita  < 6 then
vagner[6].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[6].direita].saidaesquerda
vagner[vagner[6].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[6].saidadireita
end
end
end

-----------------------------------------------------------------------------------------------------------------------------------------
if vagner[7].numexits > 0 then
if inst.saladotesouso == vagner[7].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[7].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[7].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[7].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[7].valorx = TheWorld.components.contador:GetX()
vagner[7].valorz = TheWorld.components.contador:GetZ()

if vagner[7].cima ~= nil then 
vagner[7].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[7].trapdor))
if vagner[7].trapdor then vagner[7].saidacima:AddTag("lockable_door") end
vagner[7].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[7].cima < 7 then
vagner[7].saidacima.components.teleporter.targetTeleporter = vagner[vagner[7].cima].saidabaixo
vagner[vagner[7].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[7].saidacima
end
end

if vagner[7].baixo ~= nil then 
vagner[7].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[7].trapdor))
if vagner[7].trapdor then vagner[7].saidabaixo:AddTag("lockable_door") end
vagner[7].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[7].baixo < 7 then
vagner[7].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[7].baixo].saidacima
vagner[vagner[7].baixo].saidacima.components.teleporter.targetTeleporter = vagner[7].saidabaixo
end
end

if vagner[7].esquerda ~= nil then
vagner[7].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[7].trapdor))
if vagner[7].trapdor then vagner[7].saidaesquerda:AddTag("lockable_door") end
vagner[7].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[7].esquerda < 7 then
vagner[7].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[7].esquerda].saidadireita
vagner[vagner[7].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[7].saidaesquerda
end
end

if vagner[7].direita ~= nil then
vagner[7].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[7].trapdor))
if vagner[7].trapdor then vagner[7].saidadireita:AddTag("lockable_door") end
vagner[7].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[7].direita  < 7 then
vagner[7].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[7].direita].saidaesquerda
vagner[vagner[7].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[7].saidadireita
end
end
end

if vagner[8].numexits > 0 then
if inst.saladotesouso == vagner[8].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[8].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[8].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[8].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[8].valorx = TheWorld.components.contador:GetX()
vagner[8].valorz = TheWorld.components.contador:GetZ()

if vagner[8].cima ~= nil then 
vagner[8].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[8].trapdor))
if vagner[8].trapdor then vagner[8].saidacima:AddTag("lockable_door") end
vagner[8].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[8].cima < 8 then
vagner[8].saidacima.components.teleporter.targetTeleporter = vagner[vagner[8].cima].saidabaixo
vagner[vagner[8].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[8].saidacima
end
end

if vagner[8].baixo ~= nil then 
vagner[8].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[8].trapdor))
if vagner[8].trapdor then vagner[8].saidabaixo:AddTag("lockable_door") end
vagner[8].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[8].baixo < 8 then
vagner[8].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[8].baixo].saidacima
vagner[vagner[8].baixo].saidacima.components.teleporter.targetTeleporter = vagner[8].saidabaixo
end
end

if vagner[8].esquerda ~= nil then
vagner[8].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[8].trapdor))
if vagner[8].trapdor then vagner[8].saidaesquerda:AddTag("lockable_door") end
vagner[8].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[8].esquerda < 8 then
vagner[8].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[8].esquerda].saidadireita
vagner[vagner[8].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[8].saidaesquerda
end
end

if vagner[8].direita ~= nil then
vagner[8].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[8].trapdor))
if vagner[8].trapdor then vagner[8].saidadireita:AddTag("lockable_door") end
vagner[8].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[8].direita  < 8 then
vagner[8].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[8].direita].saidaesquerda
vagner[vagner[8].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[8].saidadireita
end
end
end

if vagner[9].numexits > 0 then
if inst.saladotesouso == vagner[9].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[9].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[9].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[9].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[9].valorx = TheWorld.components.contador:GetX()
vagner[9].valorz = TheWorld.components.contador:GetZ()

if vagner[9].cima ~= nil then 
vagner[9].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[9].trapdor))
if vagner[9].trapdor then vagner[9].saidacima:AddTag("lockable_door") end
vagner[9].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[9].cima < 9 then
vagner[9].saidacima.components.teleporter.targetTeleporter = vagner[vagner[9].cima].saidabaixo
vagner[vagner[9].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[9].saidacima
end
end

if vagner[9].baixo ~= nil then 
vagner[9].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[9].trapdor))
if vagner[9].trapdor then vagner[9].saidabaixo:AddTag("lockable_door") end
vagner[9].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[9].baixo < 9 then
vagner[9].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[9].baixo].saidacima
vagner[vagner[9].baixo].saidacima.components.teleporter.targetTeleporter = vagner[9].saidabaixo
end
end

if vagner[9].esquerda ~= nil then
vagner[9].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[9].trapdor))
if vagner[9].trapdor then vagner[9].saidaesquerda:AddTag("lockable_door") end
vagner[9].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[9].esquerda < 9 then
vagner[9].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[9].esquerda].saidadireita
vagner[vagner[9].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[9].saidaesquerda
end
end

if vagner[9].direita ~= nil then
vagner[9].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[9].trapdor))
if vagner[9].trapdor then vagner[9].saidadireita:AddTag("lockable_door") end
vagner[9].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[9].direita  < 9 then
vagner[9].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[9].direita].saidaesquerda
vagner[vagner[9].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[9].saidadireita
end
end
end

if vagner[10].numexits > 0 then
if inst.saladotesouso == vagner[10].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[10].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[10].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[10].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[10].valorx = TheWorld.components.contador:GetX()
vagner[10].valorz = TheWorld.components.contador:GetZ()

if vagner[10].cima ~= nil then 
vagner[10].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[10].trapdor))
if vagner[10].trapdor then vagner[10].saidacima:AddTag("lockable_door") end
vagner[10].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[10].cima < 10 then
vagner[10].saidacima.components.teleporter.targetTeleporter = vagner[vagner[10].cima].saidabaixo
vagner[vagner[10].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[10].saidacima
end
end

if vagner[10].baixo ~= nil then 
vagner[10].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[10].trapdor))
if vagner[10].trapdor then vagner[10].saidabaixo:AddTag("lockable_door") end
vagner[10].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[10].baixo < 10 then
vagner[10].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[10].baixo].saidacima
vagner[vagner[10].baixo].saidacima.components.teleporter.targetTeleporter = vagner[10].saidabaixo
end
end

if vagner[10].esquerda ~= nil then
vagner[10].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[10].trapdor))
if vagner[10].trapdor then vagner[10].saidaesquerda:AddTag("lockable_door") end
vagner[10].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[10].esquerda < 10 then
vagner[10].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[10].esquerda].saidadireita
vagner[vagner[10].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[10].saidaesquerda
end
end

if vagner[10].direita ~= nil then
vagner[10].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[10].trapdor))
if vagner[10].trapdor then vagner[10].saidadireita:AddTag("lockable_door") end
vagner[10].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[10].direita  < 10 then
vagner[10].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[10].direita].saidaesquerda
vagner[vagner[10].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[10].saidadireita
end
end
end

if vagner[11].numexits > 0 then
if inst.saladotesouso == vagner[11].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[11].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[11].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[11].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[11].valorx = TheWorld.components.contador:GetX()
vagner[11].valorz = TheWorld.components.contador:GetZ()

if vagner[11].cima ~= nil then 
vagner[11].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[11].trapdor))
if vagner[11].trapdor then vagner[11].saidacima:AddTag("lockable_door") end
vagner[11].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[11].cima < 11 then
vagner[11].saidacima.components.teleporter.targetTeleporter = vagner[vagner[11].cima].saidabaixo
vagner[vagner[11].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[11].saidacima
end
end

if vagner[11].baixo ~= nil then 
vagner[11].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[11].trapdor))
if vagner[11].trapdor then vagner[11].saidabaixo:AddTag("lockable_door") end
vagner[11].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[11].baixo < 11 then
vagner[11].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[11].baixo].saidacima
vagner[vagner[11].baixo].saidacima.components.teleporter.targetTeleporter = vagner[11].saidabaixo
end
end

if vagner[11].esquerda ~= nil then
vagner[11].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[11].trapdor))
if vagner[11].trapdor then vagner[11].saidaesquerda:AddTag("lockable_door") end
vagner[11].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[11].esquerda < 11 then
vagner[11].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[11].esquerda].saidadireita
vagner[vagner[11].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[11].saidaesquerda
end
end

if vagner[11].direita ~= nil then
vagner[11].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[11].trapdor))
if vagner[11].trapdor then vagner[11].saidadireita:AddTag("lockable_door") end
vagner[11].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[11].direita  < 11 then
vagner[11].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[11].direita].saidaesquerda
vagner[vagner[11].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[11].saidadireita
end
end
end

if vagner[12].numexits > 0 then
if inst.saladotesouso == vagner[12].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[12].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[12].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[12].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[12].valorx = TheWorld.components.contador:GetX()
vagner[12].valorz = TheWorld.components.contador:GetZ()

if vagner[12].cima ~= nil then 
vagner[12].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[12].trapdor))
if vagner[12].trapdor then vagner[12].saidacima:AddTag("lockable_door") end
vagner[12].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[12].cima < 12 then
vagner[12].saidacima.components.teleporter.targetTeleporter = vagner[vagner[12].cima].saidabaixo
vagner[vagner[12].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[12].saidacima
end
end

if vagner[12].baixo ~= nil then 
vagner[12].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[12].trapdor))
if vagner[12].trapdor then vagner[12].saidabaixo:AddTag("lockable_door") end
vagner[12].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[12].baixo < 12 then
vagner[12].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[12].baixo].saidacima
vagner[vagner[12].baixo].saidacima.components.teleporter.targetTeleporter = vagner[12].saidabaixo
end
end

if vagner[12].esquerda ~= nil then
vagner[12].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[12].trapdor))
if vagner[12].trapdor then vagner[12].saidaesquerda:AddTag("lockable_door") end
vagner[12].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[12].esquerda < 12 then
vagner[12].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[12].esquerda].saidadireita
vagner[vagner[12].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[12].saidaesquerda
end
end

if vagner[12].direita ~= nil then
vagner[12].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[12].trapdor))
if vagner[12].trapdor then vagner[12].saidadireita:AddTag("lockable_door") end
vagner[12].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[12].direita  < 12 then
vagner[12].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[12].direita].saidaesquerda
vagner[vagner[12].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[12].saidadireita
end
end
end

if vagner[13].numexits > 0 then
if inst.saladotesouso == vagner[13].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[13].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[13].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[13].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[13].valorx = TheWorld.components.contador:GetX()
vagner[13].valorz = TheWorld.components.contador:GetZ()

if vagner[13].cima ~= nil then 
vagner[13].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[13].trapdor))
if vagner[13].trapdor then vagner[13].saidacima:AddTag("lockable_door") end
vagner[13].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[13].cima < 13 then
vagner[13].saidacima.components.teleporter.targetTeleporter = vagner[vagner[13].cima].saidabaixo
vagner[vagner[13].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[13].saidacima
end
end

if vagner[13].baixo ~= nil then 
vagner[13].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[13].trapdor))
if vagner[13].trapdor then vagner[13].saidabaixo:AddTag("lockable_door") end
vagner[13].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[13].baixo < 13 then
vagner[13].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[13].baixo].saidacima
vagner[vagner[13].baixo].saidacima.components.teleporter.targetTeleporter = vagner[13].saidabaixo
end
end

if vagner[13].esquerda ~= nil then
vagner[13].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[13].trapdor))
if vagner[13].trapdor then vagner[13].saidaesquerda:AddTag("lockable_door") end
vagner[13].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[13].esquerda < 13 then
vagner[13].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[13].esquerda].saidadireita
vagner[vagner[13].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[13].saidaesquerda
end
end

if vagner[13].direita ~= nil then
vagner[13].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[13].trapdor))
if vagner[13].trapdor then vagner[13].saidadireita:AddTag("lockable_door") end
vagner[13].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[13].direita  < 13 then
vagner[13].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[13].direita].saidaesquerda
vagner[vagner[13].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[13].saidadireita
end
end
end

if vagner[14].numexits > 0 then
if inst.saladotesouso == vagner[14].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[14].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[14].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[14].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[14].valorx = TheWorld.components.contador:GetX()
vagner[14].valorz = TheWorld.components.contador:GetZ()

if vagner[14].cima ~= nil then 
vagner[14].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[14].trapdor))
if vagner[14].trapdor then vagner[14].saidacima:AddTag("lockable_door") end
vagner[14].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[14].cima < 14 then
vagner[14].saidacima.components.teleporter.targetTeleporter = vagner[vagner[14].cima].saidabaixo
vagner[vagner[14].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[14].saidacima
end
end

if vagner[14].baixo ~= nil then 
vagner[14].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[14].trapdor))
if vagner[14].trapdor then vagner[14].saidabaixo:AddTag("lockable_door") end
vagner[14].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[14].baixo < 14 then
vagner[14].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[14].baixo].saidacima
vagner[vagner[14].baixo].saidacima.components.teleporter.targetTeleporter = vagner[14].saidabaixo
end
end

if vagner[14].esquerda ~= nil then
vagner[14].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[14].trapdor))
if vagner[14].trapdor then vagner[14].saidaesquerda:AddTag("lockable_door") end
vagner[14].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[14].esquerda < 14 then
vagner[14].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[14].esquerda].saidadireita
vagner[vagner[14].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[14].saidaesquerda
end
end

if vagner[14].direita ~= nil then
vagner[14].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[14].trapdor))
if vagner[14].trapdor then vagner[14].saidadireita:AddTag("lockable_door") end
vagner[14].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[14].direita  < 14 then
vagner[14].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[14].direita].saidaesquerda
vagner[vagner[14].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[14].saidadireita
end
end
end

if vagner[15].numexits > 0 then
if inst.saladotesouso == vagner[15].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[15].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[15].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[15].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[15].valorx = TheWorld.components.contador:GetX()
vagner[15].valorz = TheWorld.components.contador:GetZ()

if vagner[15].cima ~= nil then 
vagner[15].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[15].trapdor))
if vagner[15].trapdor then vagner[15].saidacima:AddTag("lockable_door") end
vagner[15].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[15].cima < 15 then
vagner[15].saidacima.components.teleporter.targetTeleporter = vagner[vagner[15].cima].saidabaixo
vagner[vagner[15].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[15].saidacima
end
end

if vagner[15].baixo ~= nil then 
vagner[15].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[15].trapdor))
if vagner[15].trapdor then vagner[15].saidabaixo:AddTag("lockable_door") end
vagner[15].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[15].baixo < 15 then
vagner[15].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[15].baixo].saidacima
vagner[vagner[15].baixo].saidacima.components.teleporter.targetTeleporter = vagner[15].saidabaixo
end
end

if vagner[15].esquerda ~= nil then
vagner[15].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[15].trapdor))
if vagner[15].trapdor then vagner[15].saidaesquerda:AddTag("lockable_door") end
vagner[15].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[15].esquerda < 15 then
vagner[15].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[15].esquerda].saidadireita
vagner[vagner[15].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[15].saidaesquerda
end
end

if vagner[15].direita ~= nil then
vagner[15].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[15].trapdor))
if vagner[15].trapdor then vagner[15].saidadireita:AddTag("lockable_door") end
vagner[15].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[15].direita  < 15 then
vagner[15].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[15].direita].saidaesquerda
vagner[vagner[15].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[15].saidadireita
end
end
end

if vagner[16].numexits > 0 then
if inst.saladotesouso == vagner[16].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[16].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[16].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[16].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[16].valorx = TheWorld.components.contador:GetX()
vagner[16].valorz = TheWorld.components.contador:GetZ()

if vagner[16].cima ~= nil then 
vagner[16].saidacima = SpawnPrefab(portacomvinhacima(inst))
if vagner[16].trapdor then vagner[16].saidacima:AddTag("lockable_door") end
vagner[16].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[16].cima < 16 then
vagner[16].saidacima.components.teleporter.targetTeleporter = vagner[vagner[16].cima].saidabaixo
vagner[vagner[16].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[16].saidacima
end
end

if vagner[16].baixo ~= nil then 
vagner[16].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[16].trapdor))
if vagner[16].trapdor then vagner[16].saidabaixo:AddTag("lockable_door") end
vagner[16].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[16].baixo < 16 then
vagner[16].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[16].baixo].saidacima
vagner[vagner[16].baixo].saidacima.components.teleporter.targetTeleporter = vagner[16].saidabaixo
end
end

if vagner[16].esquerda ~= nil then
vagner[16].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[16].trapdor))
if vagner[16].trapdor then vagner[16].saidaesquerda:AddTag("lockable_door") end
vagner[16].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[16].esquerda < 16 then
vagner[16].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[16].esquerda].saidadireita
vagner[vagner[16].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[16].saidaesquerda
end
end

if vagner[16].direita ~= nil then
vagner[16].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[16].trapdor))
if vagner[16].trapdor then vagner[16].saidadireita:AddTag("lockable_door") end
vagner[16].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[16].direita  < 16 then
vagner[16].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[16].direita].saidaesquerda
vagner[vagner[16].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[16].saidadireita
end
end
end

if vagner[17].numexits > 0 then
if inst.saladotesouso == vagner[17].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[17].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[17].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[17].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[17].valorx = TheWorld.components.contador:GetX()
vagner[17].valorz = TheWorld.components.contador:GetZ()

if vagner[17].cima ~= nil then 
vagner[17].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[17].trapdor))
if vagner[17].trapdor then vagner[17].saidacima:AddTag("lockable_door") end
vagner[17].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[17].cima < 17 then
vagner[17].saidacima.components.teleporter.targetTeleporter = vagner[vagner[17].cima].saidabaixo
vagner[vagner[17].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[17].saidacima
end
end

if vagner[17].baixo ~= nil then 
vagner[17].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[17].trapdor))
if vagner[17].trapdor then vagner[17].saidabaixo:AddTag("lockable_door") end
vagner[17].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[17].baixo < 17 then
vagner[17].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[17].baixo].saidacima
vagner[vagner[17].baixo].saidacima.components.teleporter.targetTeleporter = vagner[17].saidabaixo
end
end

if vagner[17].esquerda ~= nil then
vagner[17].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[17].trapdor))
if vagner[17].trapdor then vagner[17].saidaesquerda:AddTag("lockable_door") end
vagner[17].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[17].esquerda < 17 then
vagner[17].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[17].esquerda].saidadireita
vagner[vagner[17].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[17].saidaesquerda
end
end

if vagner[17].direita ~= nil then
vagner[17].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[17].trapdor))
if vagner[17].trapdor then vagner[17].saidadireita:AddTag("lockable_door") end
vagner[17].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[17].direita  < 17 then
vagner[17].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[17].direita].saidaesquerda
vagner[vagner[17].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[17].saidadireita
end
end
end

if vagner[18].numexits > 0 then
if inst.saladotesouso == vagner[18].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[18].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[18].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[18].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[18].valorx = TheWorld.components.contador:GetX()
vagner[18].valorz = TheWorld.components.contador:GetZ()

if vagner[18].cima ~= nil then 
vagner[18].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[18].trapdor))
if vagner[18].trapdor then vagner[18].saidacima:AddTag("lockable_door") end
vagner[18].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[18].cima < 18 then
vagner[18].saidacima.components.teleporter.targetTeleporter = vagner[vagner[18].cima].saidabaixo
vagner[vagner[18].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[18].saidacima
end
end

if vagner[18].baixo ~= nil then 
vagner[18].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[18].trapdor))
if vagner[18].trapdor then vagner[18].saidabaixo:AddTag("lockable_door") end
vagner[18].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[18].baixo < 18 then
vagner[18].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[18].baixo].saidacima
vagner[vagner[18].baixo].saidacima.components.teleporter.targetTeleporter = vagner[18].saidabaixo
end
end

if vagner[18].esquerda ~= nil then
vagner[18].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[18].trapdor))
if vagner[18].trapdor then vagner[18].saidaesquerda:AddTag("lockable_door") end
vagner[18].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[18].esquerda < 18 then
vagner[18].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[18].esquerda].saidadireita
vagner[vagner[18].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[18].saidaesquerda
end
end

if vagner[18].direita ~= nil then
vagner[18].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[18].trapdor))
if vagner[18].trapdor then vagner[18].saidadireita:AddTag("lockable_door") end
vagner[18].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[18].direita  < 18 then
vagner[18].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[18].direita].saidaesquerda
vagner[vagner[18].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[18].saidadireita
end
end
end

if vagner[19].numexits > 0 then
if inst.saladotesouso == vagner[19].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[19].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[19].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[19].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[19].valorx = TheWorld.components.contador:GetX()
vagner[19].valorz = TheWorld.components.contador:GetZ()

if vagner[19].cima ~= nil then 
vagner[19].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[19].trapdor))
if vagner[19].trapdor then vagner[19].saidacima:AddTag("lockable_door") end
vagner[19].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[19].cima < 19 then
vagner[19].saidacima.components.teleporter.targetTeleporter = vagner[vagner[19].cima].saidabaixo
vagner[vagner[19].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[19].saidacima
end
end

if vagner[19].baixo ~= nil then 
vagner[19].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[19].trapdor))
if vagner[19].trapdor then vagner[19].saidabaixo:AddTag("lockable_door") end
vagner[19].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[19].baixo < 19 then
vagner[19].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[19].baixo].saidacima
vagner[vagner[19].baixo].saidacima.components.teleporter.targetTeleporter = vagner[19].saidabaixo
end
end

if vagner[19].esquerda ~= nil then
vagner[19].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[19].trapdor))
if vagner[19].trapdor then vagner[19].saidaesquerda:AddTag("lockable_door") end
vagner[19].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[19].esquerda < 19 then
vagner[19].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[19].esquerda].saidadireita
vagner[vagner[19].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[19].saidaesquerda
end
end

if vagner[19].direita ~= nil then
vagner[19].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[19].trapdor))
if vagner[19].trapdor then vagner[19].saidadireita:AddTag("lockable_door") end
vagner[19].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[19].direita  < 19 then
vagner[19].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[19].direita].saidaesquerda
vagner[vagner[19].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[19].saidadireita
end
end
end

if vagner[20].numexits > 0 then
if inst.saladotesouso == vagner[20].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[20].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[20].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[20].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[20].valorx = TheWorld.components.contador:GetX()
vagner[20].valorz = TheWorld.components.contador:GetZ()

if vagner[20].cima ~= nil then 
vagner[20].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[20].trapdor))
if vagner[20].trapdor then vagner[20].saidacima:AddTag("lockable_door") end
vagner[20].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[20].cima < 20 then
vagner[20].saidacima.components.teleporter.targetTeleporter = vagner[vagner[20].cima].saidabaixo
vagner[vagner[20].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[20].saidacima
end
end

if vagner[20].baixo ~= nil then 
vagner[20].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[20].trapdor))
if vagner[20].trapdor then vagner[20].saidabaixo:AddTag("lockable_door") end
vagner[20].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[20].baixo < 20 then
vagner[20].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[20].baixo].saidacima
vagner[vagner[20].baixo].saidacima.components.teleporter.targetTeleporter = vagner[20].saidabaixo
end
end

if vagner[20].esquerda ~= nil then
vagner[20].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[20].trapdor))
if vagner[20].trapdor then vagner[20].saidaesquerda:AddTag("lockable_door") end
vagner[20].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[20].esquerda < 20 then
vagner[20].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[20].esquerda].saidadireita
vagner[vagner[20].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[20].saidaesquerda
end
end

if vagner[20].direita ~= nil then
vagner[20].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[20].trapdor))
if vagner[20].trapdor then vagner[20].saidadireita:AddTag("lockable_door") end
vagner[20].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[20].direita  < 20 then
vagner[20].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[20].direita].saidaesquerda
vagner[vagner[20].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[20].saidadireita
end
end
end

if vagner[21].numexits > 0 then
if inst.saladotesouso == vagner[21].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[21].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[21].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[21].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[21].valorx = TheWorld.components.contador:GetX()
vagner[21].valorz = TheWorld.components.contador:GetZ()

if vagner[21].cima ~= nil then 
vagner[21].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[21].trapdor))
if vagner[21].trapdor then vagner[21].saidacima:AddTag("lockable_door") end
vagner[21].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[21].cima < 21 then
vagner[21].saidacima.components.teleporter.targetTeleporter = vagner[vagner[21].cima].saidabaixo
vagner[vagner[21].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[21].saidacima
end
end

if vagner[21].baixo ~= nil then 
vagner[21].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[21].trapdor))
if vagner[21].trapdor then vagner[21].saidabaixo:AddTag("lockable_door") end
vagner[21].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[21].baixo < 21 then
vagner[21].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[21].baixo].saidacima
vagner[vagner[21].baixo].saidacima.components.teleporter.targetTeleporter = vagner[21].saidabaixo
end
end

if vagner[21].esquerda ~= nil then
vagner[21].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[21].trapdor))
if vagner[21].trapdor then vagner[21].saidaesquerda:AddTag("lockable_door") end
vagner[21].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[21].esquerda < 21 then
vagner[21].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[21].esquerda].saidadireita
vagner[vagner[21].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[21].saidaesquerda
end
end

if vagner[21].direita ~= nil then
vagner[21].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[21].trapdor))
if vagner[21].trapdor then vagner[21].saidadireita:AddTag("lockable_door") end
vagner[21].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[21].direita  < 21 then
vagner[21].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[21].direita].saidaesquerda
vagner[vagner[21].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[21].saidadireita
end
end
end

if vagner[22].numexits > 0 then
if inst.saladotesouso == vagner[22].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[22].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[22].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[22].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[22].valorx = TheWorld.components.contador:GetX()
vagner[22].valorz = TheWorld.components.contador:GetZ()

if vagner[22].cima ~= nil then 
vagner[22].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[22].trapdor))
if vagner[22].trapdor then vagner[22].saidacima:AddTag("lockable_door") end
vagner[22].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[22].cima < 22 then
vagner[22].saidacima.components.teleporter.targetTeleporter = vagner[vagner[22].cima].saidabaixo
vagner[vagner[22].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[22].saidacima
end
end

if vagner[22].baixo ~= nil then 
vagner[22].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[22].trapdor))
if vagner[22].trapdor then vagner[22].saidabaixo:AddTag("lockable_door") end
vagner[22].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[22].baixo < 22 then
vagner[22].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[22].baixo].saidacima
vagner[vagner[22].baixo].saidacima.components.teleporter.targetTeleporter = vagner[22].saidabaixo
end
end

if vagner[22].esquerda ~= nil then
vagner[22].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[22].trapdor))
if vagner[22].trapdor then vagner[22].saidaesquerda:AddTag("lockable_door") end
vagner[22].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[22].esquerda < 22 then
vagner[22].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[22].esquerda].saidadireita
vagner[vagner[22].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[22].saidaesquerda
end
end

if vagner[22].direita ~= nil then
vagner[22].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[22].trapdor))
if vagner[22].trapdor then vagner[22].saidadireita:AddTag("lockable_door") end
vagner[22].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[22].direita  < 22 then
vagner[22].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[22].direita].saidaesquerda
vagner[vagner[22].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[22].saidadireita
end
end
end

if vagner[23].numexits > 0 then
if inst.saladotesouso == vagner[23].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[23].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[23].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[23].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[23].valorx = TheWorld.components.contador:GetX()
vagner[23].valorz = TheWorld.components.contador:GetZ()

if vagner[23].cima ~= nil then 
vagner[23].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[23].trapdor))
if vagner[23].trapdor then vagner[23].saidacima:AddTag("lockable_door") end
vagner[23].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[23].cima < 23 then
vagner[23].saidacima.components.teleporter.targetTeleporter = vagner[vagner[23].cima].saidabaixo
vagner[vagner[23].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[23].saidacima
end
end

if vagner[23].baixo ~= nil then 
vagner[23].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[23].trapdor))
if vagner[23].trapdor then vagner[23].saidabaixo:AddTag("lockable_door") end
vagner[23].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[23].baixo < 23 then
vagner[23].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[23].baixo].saidacima
vagner[vagner[23].baixo].saidacima.components.teleporter.targetTeleporter = vagner[23].saidabaixo
end
end

if vagner[23].esquerda ~= nil then
vagner[23].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[23].trapdor))
if vagner[23].trapdor then vagner[23].saidaesquerda:AddTag("lockable_door") end
vagner[23].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[23].esquerda < 23 then
vagner[23].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[23].esquerda].saidadireita
vagner[vagner[23].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[23].saidaesquerda
end
end

if vagner[23].direita ~= nil then
vagner[23].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[23].trapdor))
if vagner[23].trapdor then vagner[23].saidadireita:AddTag("lockable_door") end
vagner[23].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[23].direita  < 23 then
vagner[23].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[23].direita].saidaesquerda
vagner[vagner[23].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[23].saidadireita
end
end
end

if vagner[24].numexits > 0 then
if inst.saladotesouso == vagner[24].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[24].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[24].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[24].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[24].valorx = TheWorld.components.contador:GetX()
vagner[24].valorz = TheWorld.components.contador:GetZ()

if vagner[24].cima ~= nil then 
vagner[24].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[24].trapdor))
if vagner[24].trapdor then vagner[24].saidacima:AddTag("lockable_door") end
vagner[24].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[24].cima < 24 then
vagner[24].saidacima.components.teleporter.targetTeleporter = vagner[vagner[24].cima].saidabaixo
vagner[vagner[24].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[24].saidacima
end
end

if vagner[24].baixo ~= nil then 
vagner[24].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[24].trapdor))
if vagner[24].trapdor then vagner[24].saidabaixo:AddTag("lockable_door") end
vagner[24].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[24].baixo < 24 then
vagner[24].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[24].baixo].saidacima
vagner[vagner[24].baixo].saidacima.components.teleporter.targetTeleporter = vagner[24].saidabaixo
end
end

if vagner[24].esquerda ~= nil then
vagner[24].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[24].trapdor))
if vagner[24].trapdor then vagner[24].saidaesquerda:AddTag("lockable_door") end
vagner[24].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[24].esquerda < 24 then
vagner[24].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[24].esquerda].saidadireita
vagner[vagner[24].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[24].saidaesquerda
end
end

if vagner[24].direita ~= nil then
vagner[24].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[24].trapdor))
if vagner[24].trapdor then vagner[24].saidadireita:AddTag("lockable_door") end
vagner[24].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[24].direita  < 24 then
vagner[24].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[24].direita].saidaesquerda
vagner[vagner[24].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[24].saidadireita
end
end
end

if vagner[25].numexits > 0 then
if inst.saladotesouso == vagner[25].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[25].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[25].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[25].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[25].valorx = TheWorld.components.contador:GetX()
vagner[25].valorz = TheWorld.components.contador:GetZ()

if vagner[25].cima ~= nil then 
vagner[25].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[25].trapdor))
if vagner[25].trapdor then vagner[25].saidacima:AddTag("lockable_door") end
vagner[25].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[25].cima < 25 then
vagner[25].saidacima.components.teleporter.targetTeleporter = vagner[vagner[25].cima].saidabaixo
vagner[vagner[25].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[25].saidacima
end
end

if vagner[25].baixo ~= nil then 
vagner[25].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[25].trapdor))
if vagner[25].trapdor then vagner[25].saidabaixo:AddTag("lockable_door") end
vagner[25].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[25].baixo < 25 then
vagner[25].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[25].baixo].saidacima
vagner[vagner[25].baixo].saidacima.components.teleporter.targetTeleporter = vagner[25].saidabaixo
end
end

if vagner[25].esquerda ~= nil then
vagner[25].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[25].trapdor))
if vagner[25].trapdor then vagner[25].saidaesquerda:AddTag("lockable_door") end
vagner[25].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[25].esquerda < 25 then
vagner[25].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[25].esquerda].saidadireita
vagner[vagner[25].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[25].saidaesquerda
end
end

if vagner[25].direita ~= nil then
vagner[25].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[25].trapdor))
if vagner[25].trapdor then vagner[25].saidadireita:AddTag("lockable_door") end
vagner[25].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[25].direita  < 25 then
vagner[25].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[25].direita].saidaesquerda
vagner[vagner[25].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[25].saidadireita
end
end
end

if vagner[26].numexits > 0 then
if inst.saladotesouso == vagner[26].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[26].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[26].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[26].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[26].valorx = TheWorld.components.contador:GetX()
vagner[26].valorz = TheWorld.components.contador:GetZ()

if vagner[26].cima ~= nil then 
vagner[26].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[26].trapdor))
if vagner[26].trapdor then vagner[26].saidacima:AddTag("lockable_door") end
vagner[26].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[26].cima < 26 then
vagner[26].saidacima.components.teleporter.targetTeleporter = vagner[vagner[26].cima].saidabaixo
vagner[vagner[26].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[26].saidacima
end
end

if vagner[26].baixo ~= nil then 
vagner[26].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[26].trapdor))
if vagner[26].trapdor then vagner[26].saidabaixo:AddTag("lockable_door") end
vagner[26].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[26].baixo < 26 then
vagner[26].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[26].baixo].saidacima
vagner[vagner[26].baixo].saidacima.components.teleporter.targetTeleporter = vagner[26].saidabaixo
end
end

if vagner[26].esquerda ~= nil then
vagner[26].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[26].trapdor))
if vagner[26].trapdor then vagner[26].saidaesquerda:AddTag("lockable_door") end
vagner[26].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[26].esquerda < 26 then
vagner[26].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[26].esquerda].saidadireita
vagner[vagner[26].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[26].saidaesquerda
end
end

if vagner[26].direita ~= nil then
vagner[26].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[26].trapdor))
if vagner[26].trapdor then vagner[26].saidadireita:AddTag("lockable_door") end
vagner[26].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[26].direita  < 26 then
vagner[26].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[26].direita].saidaesquerda
vagner[vagner[26].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[26].saidadireita
end
end
end

if vagner[27].numexits > 0 then
if inst.saladotesouso == vagner[27].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[27].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[27].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[27].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[27].valorx = TheWorld.components.contador:GetX()
vagner[27].valorz = TheWorld.components.contador:GetZ()

if vagner[27].cima ~= nil then 
vagner[27].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[27].trapdor))
if vagner[27].trapdor then vagner[27].saidacima:AddTag("lockable_door") end
vagner[27].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[27].cima < 27 then
vagner[27].saidacima.components.teleporter.targetTeleporter = vagner[vagner[27].cima].saidabaixo
vagner[vagner[27].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[27].saidacima
end
end

if vagner[27].baixo ~= nil then 
vagner[27].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[27].trapdor))
if vagner[27].trapdor then vagner[27].saidabaixo:AddTag("lockable_door") end
vagner[27].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[27].baixo < 27 then
vagner[27].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[27].baixo].saidacima
vagner[vagner[27].baixo].saidacima.components.teleporter.targetTeleporter = vagner[27].saidabaixo
end
end

if vagner[27].esquerda ~= nil then
vagner[27].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[27].trapdor))
if vagner[27].trapdor then vagner[27].saidaesquerda:AddTag("lockable_door") end
vagner[27].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[27].esquerda < 27 then
vagner[27].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[27].esquerda].saidadireita
vagner[vagner[27].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[27].saidaesquerda
end
end

if vagner[27].direita ~= nil then
vagner[27].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[27].trapdor))
if vagner[27].trapdor then vagner[27].saidadireita:AddTag("lockable_door") end
vagner[27].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[27].direita  < 27 then
vagner[27].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[27].direita].saidaesquerda
vagner[vagner[27].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[27].saidadireita
end
end
end

if vagner[28].numexits > 0 then
if inst.saladotesouso == vagner[28].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[28].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[28].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[28].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[28].valorx = TheWorld.components.contador:GetX()
vagner[28].valorz = TheWorld.components.contador:GetZ()

if vagner[28].cima ~= nil then 
vagner[28].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[28].trapdor))
if vagner[28].trapdor then vagner[28].saidacima:AddTag("lockable_door") end
vagner[28].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[28].cima < 28 then
vagner[28].saidacima.components.teleporter.targetTeleporter = vagner[vagner[28].cima].saidabaixo
vagner[vagner[28].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[28].saidacima
end
end

if vagner[28].baixo ~= nil then 
vagner[28].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[28].trapdor))
if vagner[28].trapdor then vagner[28].saidabaixo:AddTag("lockable_door") end
vagner[28].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[28].baixo < 28 then
vagner[28].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[28].baixo].saidacima
vagner[vagner[28].baixo].saidacima.components.teleporter.targetTeleporter = vagner[28].saidabaixo
end
end

if vagner[28].esquerda ~= nil then
vagner[28].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[28].trapdor))
if vagner[28].trapdor then vagner[28].saidaesquerda:AddTag("lockable_door") end
vagner[28].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[28].esquerda < 28 then
vagner[28].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[28].esquerda].saidadireita
vagner[vagner[28].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[28].saidaesquerda
end
end

if vagner[28].direita ~= nil then
vagner[28].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[28].trapdor))
if vagner[28].trapdor then vagner[28].saidadireita:AddTag("lockable_door") end
vagner[28].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[28].direita  < 28 then
vagner[28].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[28].direita].saidaesquerda
vagner[vagner[28].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[28].saidadireita
end
end
end

if vagner[29].numexits > 0 then
if inst.saladotesouso == vagner[29].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[29].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[29].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[29].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[29].valorx = TheWorld.components.contador:GetX()
vagner[29].valorz = TheWorld.components.contador:GetZ()

if vagner[29].cima ~= nil then 
vagner[29].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[29].trapdor))
if vagner[29].trapdor then vagner[29].saidacima:AddTag("lockable_door") end
vagner[29].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[29].cima < 29 then
vagner[29].saidacima.components.teleporter.targetTeleporter = vagner[vagner[29].cima].saidabaixo
vagner[vagner[29].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[29].saidacima
end
end

if vagner[29].baixo ~= nil then 
vagner[29].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[29].trapdor))
if vagner[29].trapdor then vagner[29].saidabaixo:AddTag("lockable_door") end
vagner[29].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[29].baixo < 29 then
vagner[29].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[29].baixo].saidacima
vagner[vagner[29].baixo].saidacima.components.teleporter.targetTeleporter = vagner[29].saidabaixo
end
end

if vagner[29].esquerda ~= nil then
vagner[29].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[29].trapdor))
if vagner[29].trapdor then vagner[29].saidaesquerda:AddTag("lockable_door") end
vagner[29].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[29].esquerda < 29 then
vagner[29].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[29].esquerda].saidadireita
vagner[vagner[29].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[29].saidaesquerda
end
end

if vagner[29].direita ~= nil then
vagner[29].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[29].trapdor))
if vagner[29].trapdor then vagner[29].saidadireita:AddTag("lockable_door") end
vagner[29].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[29].direita  < 29 then
vagner[29].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[29].direita].saidaesquerda
vagner[vagner[29].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[29].saidadireita
end
end
end

if vagner[30].numexits > 0 then
if inst.saladotesouso == vagner[30].nome then
if inst.prefab == "maze_pig_ruins_entrance" then SpawnPrefab("createtreasurerelictruffle")
elseif inst.prefab == "maze_pig_ruins_entrance2" then SpawnPrefab("createtreasurerelicsow") 
elseif inst.prefab == "maze_pig_ruins_entrance3" then SpawnPrefab("createpheromonestoneroom") 
elseif inst.prefab == "maze_pig_ruins_entrance6" then SpawnPrefab("createoincpileroom")
elseif inst.prefab == "maze_pig_ruins_entrance4" then if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end
elseif inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureaporkalypse") 
end

elseif inst.saladotesouso2 == vagner[30].nome then
if inst.prefab == "maze_pig_ruins_entrance5" then SpawnPrefab("createtreasureendswell") 
else if math.random(1 , 2) == 1 then SpawnPrefab("createtreasureroom") else SpawnPrefab("createtreasuresecret") end end

elseif vagner[30].numexits > 1 and math.random(1 , 8) < 3 then
SpawnPrefab("createdoortraproom")
vagner[30].trapdor = true
else
SpawnPrefab("createroom")
end

vagner[30].valorx = TheWorld.components.contador:GetX()
vagner[30].valorz = TheWorld.components.contador:GetZ()

if vagner[30].cima ~= nil then 
vagner[30].saidacima = SpawnPrefab(portacomvinhacima(inst,vagner[30].trapdor))
if vagner[30].trapdor then vagner[30].saidacima:AddTag("lockable_door") end
vagner[30].saidacima.Transform:SetPosition(TheWorld.components.contador:GetX() + distportacima, 0, TheWorld.components.contador:GetZ())

if vagner[30].cima < 30 then
vagner[30].saidacima.components.teleporter.targetTeleporter = vagner[vagner[30].cima].saidabaixo
vagner[vagner[30].cima].saidabaixo.components.teleporter.targetTeleporter = vagner[30].saidacima
end
end

if vagner[30].baixo ~= nil then 
vagner[30].saidabaixo = SpawnPrefab(portacomvinhabaixo(inst,vagner[30].trapdor))
if vagner[30].trapdor then vagner[30].saidabaixo:AddTag("lockable_door") end
vagner[30].saidabaixo.Transform:SetPosition(TheWorld.components.contador:GetX() + distportabaixo, 0, TheWorld.components.contador:GetZ())

if vagner[30].baixo < 30 then
vagner[30].saidabaixo.components.teleporter.targetTeleporter = vagner[vagner[30].baixo].saidacima
vagner[vagner[30].baixo].saidacima.components.teleporter.targetTeleporter = vagner[30].saidabaixo
end
end

if vagner[30].esquerda ~= nil then
vagner[30].saidaesquerda = SpawnPrefab(portacomvinhaesquerda(inst,vagner[30].trapdor))
if vagner[30].trapdor then vagner[30].saidaesquerda:AddTag("lockable_door") end
vagner[30].saidaesquerda.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportaesquerda)

if vagner[30].esquerda < 30 then
vagner[30].saidaesquerda.components.teleporter.targetTeleporter = vagner[vagner[30].esquerda].saidadireita
vagner[vagner[30].esquerda].saidadireita.components.teleporter.targetTeleporter = vagner[30].saidaesquerda
end
end

if vagner[30].direita ~= nil then
vagner[30].saidadireita = SpawnPrefab(portacomvinhadireita(inst,vagner[30].trapdor))
if vagner[30].trapdor then vagner[30].saidadireita:AddTag("lockable_door") end
vagner[30].saidadireita.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ() + distportadireita)

if vagner[30].direita  < 30 then
vagner[30].saidadireita.components.teleporter.targetTeleporter = vagner[vagner[30].direita].saidaesquerda
vagner[vagner[30].direita].saidaesquerda.components.teleporter.targetTeleporter = vagner[30].saidadireita
end
end
end

end
----------------------------------escolha da porta de saída--------------------------------
local portadesaida = {}
if vagner[2].numexits > 0 then
if vagner[2].cima == nil then
table.insert(portadesaida,vagner[2].nome)
end
end

if vagner[3].numexits > 0 then
if vagner[3].cima == nil then
table.insert(portadesaida,vagner[3].nome)
end
end

if vagner[4].numexits > 0 then
if vagner[4].cima == nil then
table.insert(portadesaida,vagner[4].nome)
end
end

if vagner[5].numexits > 0 then
if vagner[5].cima == nil then
table.insert(portadesaida,vagner[5].nome)
end
end

if vagner[6].numexits > 0 then
if vagner[6].cima == nil then
table.insert(portadesaida,vagner[6].nome)
end
end

if vagner[7].numexits > 0 then
if vagner[7].cima == nil then
table.insert(portadesaida,vagner[7].nome)
end
end

if vagner[8].numexits > 0 then
if vagner[8].cima == nil then
table.insert(portadesaida,vagner[8].nome)
end
end

if vagner[9].numexits > 0 then
if vagner[9].cima == nil then
table.insert(portadesaida,vagner[9].nome)
end
end

if vagner[10].numexits > 0 then
if vagner[10].cima == nil then
table.insert(portadesaida,vagner[10].nome)
end
end

if vagner[11].numexits > 0 then
if vagner[11].cima == nil then
table.insert(portadesaida,vagner[11].nome)
end
end

if vagner[12].numexits > 0 then
if vagner[12].cima == nil then
table.insert(portadesaida,vagner[12].nome)
end
end

if vagner[13].numexits > 0 then
if vagner[13].cima == nil then
table.insert(portadesaida,vagner[13].nome)
end
end

if vagner[14].numexits > 0 then
if vagner[14].cima == nil then
table.insert(portadesaida,vagner[14].nome)
end
end

if vagner[15].numexits > 0 then
if vagner[15].cima == nil then
table.insert(portadesaida,vagner[15].nome)
end
end

if vagner[16].numexits > 0 then
if vagner[16].cima == nil then
table.insert(portadesaida,vagner[16].nome)
end
end

if vagner[17].numexits > 0 then
if vagner[17].cima == nil then
table.insert(portadesaida,vagner[17].nome)
end
end

if vagner[18].numexits > 0 then
if vagner[18].cima == nil then
table.insert(portadesaida,vagner[18].nome)
end
end

if vagner[19].numexits > 0 then
if vagner[19].cima == nil then
table.insert(portadesaida,vagner[19].nome)
end
end

if vagner[20].numexits > 0 then
if vagner[20].cima == nil then
table.insert(portadesaida,vagner[20].nome)
end
end

if vagner[21].numexits > 0 then
if vagner[21].cima == nil then
table.insert(portadesaida,vagner[21].nome)
end
end

if vagner[22].numexits > 0 then
if vagner[22].cima == nil then
table.insert(portadesaida,vagner[22].nome)
end
end

if vagner[23].numexits > 0 then
if vagner[23].cima == nil then
table.insert(portadesaida,vagner[23].nome)
end
end

if vagner[24].numexits > 0 then
if vagner[24].cima == nil then
table.insert(portadesaida,vagner[24].nome)
end
end

if vagner[25].numexits > 0 then
if vagner[25].cima == nil then
table.insert(portadesaida,vagner[25].nome)
end
end

if vagner[26].numexits > 0 then
if vagner[26].cima == nil then
table.insert(portadesaida,vagner[26].nome)
end
end

if vagner[27].numexits > 0 then
if vagner[27].cima == nil then
table.insert(portadesaida,vagner[27].nome)
end
end

if vagner[28].numexits > 0 then
if vagner[28].cima == nil then
table.insert(portadesaida,vagner[28].nome)
end
end

if vagner[29].numexits > 0 then
if vagner[29].cima == nil then
table.insert(portadesaida,vagner[29].nome)
end
end

if vagner[30].numexits > 0 then
if vagner[30].cima == nil then
table.insert(portadesaida,vagner[30].nome)
end
end


if inst.tipodemaze == 1 then
local saidadolabirinto = portadesaida[math.random(1,#portadesaida)]
vagner[saidadolabirinto].saidacima = SpawnPrefab("pig_ruins_door_entrada")
vagner[saidadolabirinto].saidacima.Transform:SetPosition(vagner[saidadolabirinto].valorx + distportacima, 0, vagner[saidadolabirinto].valorz)
----------------liga saida a segunda ilha-------------

for k,v in pairs(Ents) do
if v.prefab == "pig_ruins_exit" then
vagner[saidadolabirinto].saidacima.components.teleporter.targetTeleporter = v
v.components.teleporter.targetTeleporter = vagner[saidadolabirinto].saidacima
end
end
end
----------------liga saida a terceira ilha-------------
if inst.tipodemaze == 2 then
local saidadolabirinto = portadesaida[math.random(1,#portadesaida)]
vagner[saidadolabirinto].saidacima = SpawnPrefab("pig_ruins_door_entrada")
vagner[saidadolabirinto].saidacima.Transform:SetPosition(vagner[saidadolabirinto].valorx + distportacima, 0, vagner[saidadolabirinto].valorz)


for k,v in pairs(Ents) do
if v.prefab == "pig_ruins_exit2" then
vagner[saidadolabirinto].saidacima.components.teleporter.targetTeleporter = v
v.components.teleporter.targetTeleporter = vagner[saidadolabirinto].saidacima
end
end
end
----------------liga saida a quarta ilha-------------
if inst.tipodemaze == 8 then
local saidadolabirinto = portadesaida[math.random(1,#portadesaida)]
vagner[saidadolabirinto].saidacima = SpawnPrefab("pig_ruins_door_entrada")
vagner[saidadolabirinto].saidacima.Transform:SetPosition(vagner[saidadolabirinto].valorx + distportacima, 0, vagner[saidadolabirinto].valorz)


for k,v in pairs(Ents) do
if v.prefab == "pig_ruins_exit4" then
vagner[saidadolabirinto].saidacima.components.teleporter.targetTeleporter = v
v.components.teleporter.targetTeleporter = vagner[saidadolabirinto].saidacima
end
end
end
----------------liga roc cave com bat cave-------------
if inst.tipodemaze == 5 then
local saidadolabirinto = portadesaida[math.random(1,#portadesaida)]
vagner[saidadolabirinto].saidacima = SpawnPrefab("cave_exit_roc")
vagner[saidadolabirinto].saidacima.Transform:SetPosition(vagner[saidadolabirinto].valorx + distportacima, 0, vagner[saidadolabirinto].valorz)

for k,v in pairs(Ents) do
if v.prefab == "vampirebatcave_entrance_roc" then
vagner[saidadolabirinto].saidacima.components.teleporter.targetTeleporter = v
v.components.teleporter.targetTeleporter = vagner[saidadolabirinto].saidacima
end
end
end
----------------liga anthill as 2 saidas-------------

if inst.tipodemaze == 6 then
local divisor = #portadesaida
if math.fmod(#portadesaida, 2) ~= 0 then divisor = #portadesaida - 1 end

local saidadolabirinto = portadesaida[math.random(1,divisor/2)]
vagner[saidadolabirinto].saidacima = SpawnPrefab("anthill_door_entrada")
vagner[saidadolabirinto].saidacima.Transform:SetPosition(vagner[saidadolabirinto].valorx + distportacima, 0, vagner[saidadolabirinto].valorz)

for k,v in pairs(Ents) do
if v.prefab == "anthill_exit_1" then
vagner[saidadolabirinto].saidacima.components.teleporter.targetTeleporter = v
v.components.teleporter.targetTeleporter = vagner[saidadolabirinto].saidacima
end
end


local saidadolabirinto1 = portadesaida[math.random((divisor/2)+1,divisor)]
vagner[saidadolabirinto1].saidacima = SpawnPrefab("anthill_door_entrada")
vagner[saidadolabirinto1].saidacima.Transform:SetPosition(vagner[saidadolabirinto1].valorx + distportacima, 0, vagner[saidadolabirinto1].valorz)

for k,v in pairs(Ents) do
if v.prefab == "anthill_exit_2" then
vagner[saidadolabirinto1].saidacima.components.teleporter.targetTeleporter = v
v.components.teleporter.targetTeleporter = vagner[saidadolabirinto1].saidacima
end
end


end

----------------------------



inst:Remove()
end)

	return inst
end

local function entrance()
    local inst = fn()
	inst.rooms_to_make = 24
	inst.saladotesouso2 = math.random(2,12)
	inst.saladotesouso = math.random(13,24)
	inst.entradadaruina = 1
	inst.tipodemaze = 1
    return inst
end

local function entrance2()
    local inst = fn()
	inst.rooms_to_make = 15
	inst.saladotesouso2 = math.random(2,8)
	inst.saladotesouso = math.random(9,15)
	inst.entradadaruina = 2
	inst.tipodemaze = 2
    return inst
end

local function entrance3()
    local inst = fn()
	inst.rooms_to_make = 15
	inst.saladotesouso2 = math.random(2,8)
	inst.saladotesouso = math.random(9,15)
	inst.entradadaruina = 3
	inst.tipodemaze = 3
    return inst
end

local function entrance4()
    local inst = fn()
	inst.entradadaruina = 4
	inst.rooms_to_make = 20
	inst.saladotesouso2 = math.random(2,10)
	inst.saladotesouso = math.random(11,20)
	inst.tipodemaze = 8
    return inst
end

local function entrance5()
    local inst = fn()
	inst.entradadaruina = 5
	inst.rooms_to_make = 30
	inst.saladotesouso2 = math.random(2,15)
	inst.saladotesouso = math.random(16,30)
	inst.tipodemaze = 9
    return inst
end

local function entrance6()
    local inst = fn()
	inst.rooms_to_make = 20
	inst.saladotesouso2 = math.random(2,8)
	inst.saladotesouso = math.random(9,15)
	inst.entradadaruina = 6
	inst.tipodemaze = 3
    return inst
end

local function small()
    local inst = fn()
	inst.entradadaruina = 0
	inst.rooms_to_make = math.random(6,8)
	inst.saladotesouso = 0
	inst.tipodemaze = 4
    return inst
end

local function caveroc()
    local inst = fn()
	inst.entradadaruina = 0
	inst.rooms_to_make = 6
	inst.tipodemaze = 5
    return inst
end

local function anthill()
    local inst = fn()
	inst.entradadaruina = 0
	inst.rooms_to_make = 24
	inst.tipodemaze = 6
    return inst
end

local function anthill2()
    local inst = fn()
	inst.entradadaruina = 0
	inst.rooms_to_make = 15
	inst.tipodemaze = 6
    return inst
end

local function anthill_queen()
    local inst = fn()
	inst.entradadaruina = 0
	inst.rooms_to_make = 5
	inst.tipodemaze = 7
    return inst
end





return Prefab( "common/inventory/maze_pig_ruins_entrance", entrance),
 	   Prefab( "common/inventory/maze_pig_ruins_entrance2", entrance2),
	   Prefab( "common/inventory/maze_pig_ruins_entrance3", entrance3),
	   Prefab( "common/inventory/maze_pig_ruins_entrance4", entrance4),
	   Prefab( "common/inventory/maze_pig_ruins_entrance5", entrance5),
	   Prefab( "common/inventory/maze_pig_ruins_entrance6", entrance6),
	   Prefab( "common/inventory/maze_pig_ruins_entrance_small", small),
	   Prefab( "common/inventory/maze_cave_roc_entrance", caveroc),
	   Prefab( "common/inventory/maze_anthill", anthill),
	   Prefab( "common/inventory/maze_anthillentradarainha", anthill2),
	   Prefab( "common/inventory/maze_anthill_queen", anthill_queen)
