local sala1 = SpawnPrefab("mapainicioant")
local sala2 = SpawnPrefab("mapaant")
local sala3 = SpawnPrefab("mapaant")
local sala4 = SpawnPrefab("mapaant")
local sala5 = SpawnPrefab("mapaant")
local sala6 = SpawnPrefab("mapaant")
local sala7 = SpawnPrefab("mapaant")
local sala8 = SpawnPrefab("mapaant")
local sala9 = SpawnPrefab("mapaant")
local sala10 = SpawnPrefab("mapaant")
local sala11 = SpawnPrefab("mapaant")
local sala12 = SpawnPrefab("mapaant")
local sala13 = SpawnPrefab("mapaant")
local sala14 = SpawnPrefab("mapaant")
local sala15 = SpawnPrefab("mapaant")
local sala16 = SpawnPrefab("mapaant")
local sala17 = SpawnPrefab("mapaant")
local sala18 = SpawnPrefab("mapaant")
local sala19 = SpawnPrefab("mapaant")
local sala20 = SpawnPrefab("mapaant")
local sala21 = SpawnPrefab("mapaant")
local sala22 = SpawnPrefab("mapaant")
local sala23 = SpawnPrefab("mapaant")
local sala24 = SpawnPrefab("mapaant")
local sala25 = SpawnPrefab("mapaant")
local sala26 = SpawnPrefab("mapaant")
local sala27 = SpawnPrefab("mapaant")
local sala28 = SpawnPrefab("mapaant")
local sala29 = SpawnPrefab("mapaant")
local sala30 = SpawnPrefab("mapaant")


if vagner[1].nome ~= nil then 
sala1.Transform:SetPosition(TheWorld.components.contador:GetX(), 0, TheWorld.components.contador:GetZ())

---
if vagner[1].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala1.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[1].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala1.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[1].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala1.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[1].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala1.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

------------------------------------



if vagner[2].nome ~= nil then 

if vagner[2].cima == 1 or vagner[2].baixo == 1 or vagner[2].direita == 1 or vagner[2].esquerda == 1 then
if vagner[2].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 3 or vagner[2].baixo == 3 or vagner[2].direita == 3 or vagner[2].esquerda == 3 then

if vagner[2].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 4 or vagner[2].baixo == 4 or vagner[2].direita == 4 or vagner[2].esquerda == 4 then

if vagner[2].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 5 or vagner[2].baixo == 5 or vagner[2].direita == 5 or vagner[2].esquerda == 5 then

if vagner[2].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 6 or vagner[2].baixo == 6 or vagner[2].direita == 6 or vagner[2].esquerda == 6 then

if vagner[2].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 7 or vagner[2].baixo == 7 or vagner[2].direita == 7 or vagner[2].esquerda == 7 then

if vagner[2].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 8 or vagner[2].baixo == 8 or vagner[2].direita == 8 or vagner[2].esquerda == 8 then

if vagner[2].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 9 or vagner[2].baixo == 9 or vagner[2].direita == 9 or vagner[2].esquerda == 9 then

if vagner[2].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 10 or vagner[2].baixo == 10 or vagner[2].direita == 10 or vagner[2].esquerda == 10 then

if vagner[2].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 11 or vagner[2].baixo == 11 or vagner[2].direita == 11 or vagner[2].esquerda == 11 then

if vagner[2].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 12 or vagner[2].baixo == 12 or vagner[2].direita == 12 or vagner[2].esquerda == 12 then

if vagner[2].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 13 or vagner[2].baixo == 13 or vagner[2].direita == 13 or vagner[2].esquerda == 13 then

if vagner[2].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 14 or vagner[2].baixo == 14 or vagner[2].direita == 14 or vagner[2].esquerda == 14 then

if vagner[2].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 15 or vagner[2].baixo == 15 or vagner[2].direita == 15 or vagner[2].esquerda == 15 then

if vagner[2].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 16 or vagner[2].baixo == 16 or vagner[2].direita == 16 or vagner[2].esquerda == 16 then

if vagner[2].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 17 or vagner[2].baixo == 17 or vagner[2].direita == 17 or vagner[2].esquerda == 17 then

if vagner[2].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 18 or vagner[2].baixo == 18 or vagner[2].direita == 18 or vagner[2].esquerda == 18 then

if vagner[2].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 19 or vagner[2].baixo == 19 or vagner[2].direita == 19 or vagner[2].esquerda == 19 then

if vagner[2].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 20 or vagner[2].baixo == 20 or vagner[2].direita == 20 or vagner[2].esquerda == 20 then

if vagner[2].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 21 or vagner[2].baixo == 21 or vagner[2].direita == 21 or vagner[2].esquerda == 21 then

if vagner[2].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 22 or vagner[2].baixo == 22 or vagner[2].direita == 22 or vagner[2].esquerda == 22 then

if vagner[2].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 23 or vagner[2].baixo == 23 or vagner[2].direita == 23 or vagner[2].esquerda == 23 then

if vagner[2].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 24 or vagner[2].baixo == 24 or vagner[2].direita == 24 or vagner[2].esquerda == 24 then

if vagner[2].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 25 or vagner[2].baixo == 25 or vagner[2].direita == 25 or vagner[2].esquerda == 25 then

if vagner[2].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 26 or vagner[2].baixo == 26 or vagner[2].direita == 26 or vagner[2].esquerda == 26 then

if vagner[2].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 27 or vagner[2].baixo == 27 or vagner[2].direita == 27 or vagner[2].esquerda == 27 then

if vagner[2].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 28 or vagner[2].baixo == 28 or vagner[2].direita == 28 or vagner[2].esquerda == 28 then

if vagner[2].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 29 or vagner[2].baixo == 29 or vagner[2].direita == 29 or vagner[2].esquerda == 29 then

if vagner[2].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end

elseif vagner[2].cima == 30 or vagner[2].baixo == 30 or vagner[2].direita == 30 or vagner[2].esquerda == 30 then

if vagner[2].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x+2, y, z)
end
if vagner[2].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x-2, y, z)
end
if vagner[2].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z+2)
end
if vagner[2].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala2.Transform:SetPosition(x, y, z-2)
end
end


if vagner[2].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala2.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[2].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala2.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[2].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala2.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[2].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala2.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------


if vagner[3].nome ~= nil then

if vagner[3].cima == 1 or vagner[3].baixo == 1 or vagner[3].direita == 1 or vagner[3].esquerda == 1 then
 
 if vagner[3].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 2 or vagner[3].baixo == 2 or vagner[3].direita == 2 or vagner[3].esquerda == 2 then

 
if vagner[3].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 3 or vagner[3].baixo == 3 or vagner[3].direita == 3 or vagner[3].esquerda == 3 then

if vagner[3].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 4 or vagner[3].baixo == 4 or vagner[3].direita == 4 or vagner[3].esquerda == 4 then

if vagner[3].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 5 or vagner[3].baixo == 5 or vagner[3].direita == 5 or vagner[3].esquerda == 5 then

if vagner[3].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 6 or vagner[3].baixo == 6 or vagner[3].direita == 6 or vagner[3].esquerda == 6 then

if vagner[3].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 7 or vagner[3].baixo == 7 or vagner[3].direita == 7 or vagner[3].esquerda == 7 then

if vagner[3].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 8 or vagner[3].baixo == 8 or vagner[3].direita == 8 or vagner[3].esquerda == 8 then

if vagner[3].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end


elseif vagner[3].cima == 9 or vagner[3].baixo == 9 or vagner[3].direita == 9 or vagner[3].esquerda == 9 then

if vagner[3].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 10 or vagner[3].baixo == 10 or vagner[3].direita == 10 or vagner[3].esquerda == 10 then

if vagner[3].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 11 or vagner[3].baixo == 11 or vagner[3].direita == 11 or vagner[3].esquerda == 11 then

if vagner[3].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 12 or vagner[3].baixo == 12 or vagner[3].direita == 12 or vagner[3].esquerda == 12 then

if vagner[3].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 13 or vagner[3].baixo == 13 or vagner[3].direita == 13 or vagner[3].esquerda == 13 then

if vagner[3].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 14 or vagner[3].baixo == 14 or vagner[3].direita == 14 or vagner[3].esquerda == 14 then

if vagner[3].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 15 or vagner[3].baixo == 15 or vagner[3].direita == 15 or vagner[3].esquerda == 15 then

if vagner[3].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 16 or vagner[3].baixo == 16 or vagner[3].direita == 16 or vagner[3].esquerda == 16 then

if vagner[3].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 17 or vagner[3].baixo == 17 or vagner[3].direita == 17 or vagner[3].esquerda == 17 then

if vagner[3].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 18 or vagner[3].baixo == 18 or vagner[3].direita == 18 or vagner[3].esquerda == 18 then

if vagner[3].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 19 or vagner[3].baixo == 19 or vagner[3].direita == 19 or vagner[3].esquerda == 19 then

if vagner[3].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 20 or vagner[3].baixo == 20 or vagner[3].direita == 20 or vagner[3].esquerda == 20 then

if vagner[3].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 21 or vagner[3].baixo == 21 or vagner[3].direita == 21 or vagner[3].esquerda == 21 then

if vagner[3].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 22 or vagner[3].baixo == 22 or vagner[3].direita == 22 or vagner[3].esquerda == 22 then

if vagner[3].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 23 or vagner[3].baixo == 23 or vagner[3].direita == 23 or vagner[3].esquerda == 23 then

if vagner[3].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 24 or vagner[3].baixo == 24 or vagner[3].direita == 24 or vagner[3].esquerda == 24 then

if vagner[3].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 25 or vagner[3].baixo == 25 or vagner[3].direita == 25 or vagner[3].esquerda == 25 then

if vagner[3].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 26 or vagner[3].baixo == 26 or vagner[3].direita == 26 or vagner[3].esquerda == 26 then

if vagner[3].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 27 or vagner[3].baixo == 27 or vagner[3].direita == 27 or vagner[3].esquerda == 27 then

if vagner[3].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 28 or vagner[3].baixo == 28 or vagner[3].direita == 28 or vagner[3].esquerda == 28 then

if vagner[3].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 29 or vagner[3].baixo == 29 or vagner[3].direita == 29 or vagner[3].esquerda == 29 then

if vagner[3].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end

elseif vagner[3].cima == 30 or vagner[3].baixo == 30 or vagner[3].direita == 30 or vagner[3].esquerda == 30 then

if vagner[3].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x+2, y, z)
end
if vagner[3].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x-2, y, z)
end
if vagner[3].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z+2)
end
if vagner[3].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala3.Transform:SetPosition(x, y, z-2)
end
end


if vagner[3].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala3.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[3].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala3.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[3].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala3.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[3].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala3.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[4].nome ~= nil then

if vagner[4].cima == 1 or vagner[4].baixo == 1 or vagner[4].direita == 1 or vagner[4].esquerda == 1 then
 
 if vagner[4].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 2 or vagner[4].baixo == 2 or vagner[4].direita == 2 or vagner[4].esquerda == 2 then
 
if vagner[4].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 3 or vagner[4].baixo == 3 or vagner[4].direita == 3 or vagner[4].esquerda == 3 then

if vagner[4].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 4 or vagner[4].baixo == 4 or vagner[4].direita == 4 or vagner[4].esquerda == 4 then

if vagner[4].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 5 or vagner[4].baixo == 5 or vagner[4].direita == 5 or vagner[4].esquerda == 5 then

if vagner[4].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 6 or vagner[4].baixo == 6 or vagner[4].direita == 6 or vagner[4].esquerda == 6 then

if vagner[4].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 7 or vagner[4].baixo == 7 or vagner[4].direita == 7 or vagner[4].esquerda == 7 then

if vagner[4].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 8 or vagner[4].baixo == 8 or vagner[4].direita == 8 or vagner[4].esquerda == 8 then

if vagner[4].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end


elseif vagner[4].cima == 9 or vagner[4].baixo == 9 or vagner[4].direita == 9 or vagner[4].esquerda == 9 then

if vagner[4].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 10 or vagner[4].baixo == 10 or vagner[4].direita == 10 or vagner[4].esquerda == 10 then

if vagner[4].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 11 or vagner[4].baixo == 11 or vagner[4].direita == 11 or vagner[4].esquerda == 11 then

if vagner[4].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 12 or vagner[4].baixo == 12 or vagner[4].direita == 12 or vagner[4].esquerda == 12 then

if vagner[4].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 13 or vagner[4].baixo == 13 or vagner[4].direita == 13 or vagner[4].esquerda == 13 then

if vagner[4].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 14 or vagner[4].baixo == 14 or vagner[4].direita == 14 or vagner[4].esquerda == 14 then

if vagner[4].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 15 or vagner[4].baixo == 15 or vagner[4].direita == 15 or vagner[4].esquerda == 15 then

if vagner[4].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 16 or vagner[4].baixo == 16 or vagner[4].direita == 16 or vagner[4].esquerda == 16 then

if vagner[4].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 17 or vagner[4].baixo == 17 or vagner[4].direita == 17 or vagner[4].esquerda == 17 then

if vagner[4].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 18 or vagner[4].baixo == 18 or vagner[4].direita == 18 or vagner[4].esquerda == 18 then

if vagner[4].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 19 or vagner[4].baixo == 19 or vagner[4].direita == 19 or vagner[4].esquerda == 19 then

if vagner[4].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 20 or vagner[4].baixo == 20 or vagner[4].direita == 20 or vagner[4].esquerda == 20 then

if vagner[4].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 21 or vagner[4].baixo == 21 or vagner[4].direita == 21 or vagner[4].esquerda == 21 then

if vagner[4].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 22 or vagner[4].baixo == 22 or vagner[4].direita == 22 or vagner[4].esquerda == 22 then

if vagner[4].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 23 or vagner[4].baixo == 23 or vagner[4].direita == 23 or vagner[4].esquerda == 23 then

if vagner[4].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 24 or vagner[4].baixo == 24 or vagner[4].direita == 24 or vagner[4].esquerda == 24 then

if vagner[4].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 25 or vagner[4].baixo == 25 or vagner[4].direita == 25 or vagner[4].esquerda == 25 then

if vagner[4].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 26 or vagner[4].baixo == 26 or vagner[4].direita == 26 or vagner[4].esquerda == 26 then

if vagner[4].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 27 or vagner[4].baixo == 27 or vagner[4].direita == 27 or vagner[4].esquerda == 27 then

if vagner[4].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 28 or vagner[4].baixo == 28 or vagner[4].direita == 28 or vagner[4].esquerda == 28 then

if vagner[4].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 29 or vagner[4].baixo == 29 or vagner[4].direita == 29 or vagner[4].esquerda == 29 then

if vagner[4].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end

elseif vagner[4].cima == 30 or vagner[4].baixo == 30 or vagner[4].direita == 30 or vagner[4].esquerda == 30 then

if vagner[4].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x+2, y, z)
end
if vagner[4].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x-2, y, z)
end
if vagner[4].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z+2)
end
if vagner[4].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala4.Transform:SetPosition(x, y, z-2)
end
end

if vagner[4].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala4.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[4].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala4.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[4].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala4.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[4].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala4.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[5].nome ~= nil then

if vagner[5].cima == 1 or vagner[5].baixo == 1 or vagner[5].direita == 1 or vagner[5].esquerda == 1 then
 
 if vagner[5].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 2 or vagner[5].baixo == 2 or vagner[5].direita == 2 or vagner[5].esquerda == 2 then
 
if vagner[5].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 3 or vagner[5].baixo == 3 or vagner[5].direita == 3 or vagner[5].esquerda == 3 then

if vagner[5].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 4 or vagner[5].baixo == 4 or vagner[5].direita == 4 or vagner[5].esquerda == 4 then

if vagner[5].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 5 or vagner[5].baixo == 5 or vagner[5].direita == 5 or vagner[5].esquerda == 5 then

if vagner[5].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 6 or vagner[5].baixo == 6 or vagner[5].direita == 6 or vagner[5].esquerda == 6 then

if vagner[5].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 7 or vagner[5].baixo == 7 or vagner[5].direita == 7 or vagner[5].esquerda == 7 then

if vagner[5].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 8 or vagner[5].baixo == 8 or vagner[5].direita == 8 or vagner[5].esquerda == 8 then

if vagner[5].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 9 or vagner[5].baixo == 9 or vagner[5].direita == 9 or vagner[5].esquerda == 9 then

if vagner[5].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 10 or vagner[5].baixo == 10 or vagner[5].direita == 10 or vagner[5].esquerda == 10 then

if vagner[5].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 11 or vagner[5].baixo == 11 or vagner[5].direita == 11 or vagner[5].esquerda == 11 then

if vagner[5].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 12 or vagner[5].baixo == 12 or vagner[5].direita == 12 or vagner[5].esquerda == 12 then

if vagner[5].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 13 or vagner[5].baixo == 13 or vagner[5].direita == 13 or vagner[5].esquerda == 13 then

if vagner[5].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 14 or vagner[5].baixo == 14 or vagner[5].direita == 14 or vagner[5].esquerda == 14 then

if vagner[5].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 15 or vagner[5].baixo == 15 or vagner[5].direita == 15 or vagner[5].esquerda == 15 then

if vagner[5].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 16 or vagner[5].baixo == 16 or vagner[5].direita == 16 or vagner[5].esquerda == 16 then

if vagner[5].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 17 or vagner[5].baixo == 17 or vagner[5].direita == 17 or vagner[5].esquerda == 17 then

if vagner[5].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 18 or vagner[5].baixo == 18 or vagner[5].direita == 18 or vagner[5].esquerda == 18 then

if vagner[5].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 19 or vagner[5].baixo == 19 or vagner[5].direita == 19 or vagner[5].esquerda == 19 then

if vagner[5].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 20 or vagner[5].baixo == 20 or vagner[5].direita == 20 or vagner[5].esquerda == 20 then

if vagner[5].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 21 or vagner[5].baixo == 21 or vagner[5].direita == 21 or vagner[5].esquerda == 21 then

if vagner[5].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 22 or vagner[5].baixo == 22 or vagner[5].direita == 22 or vagner[5].esquerda == 22 then

if vagner[5].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 23 or vagner[5].baixo == 23 or vagner[5].direita == 23 or vagner[5].esquerda == 23 then

if vagner[5].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 24 or vagner[5].baixo == 24 or vagner[5].direita == 24 or vagner[5].esquerda == 24 then

if vagner[5].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 25 or vagner[5].baixo == 25 or vagner[5].direita == 25 or vagner[5].esquerda == 25 then

if vagner[5].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 26 or vagner[5].baixo == 26 or vagner[5].direita == 26 or vagner[5].esquerda == 26 then

if vagner[5].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 27 or vagner[5].baixo == 27 or vagner[5].direita == 27 or vagner[5].esquerda == 27 then

if vagner[5].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 28 or vagner[5].baixo == 28 or vagner[5].direita == 28 or vagner[5].esquerda == 28 then

if vagner[5].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 29 or vagner[5].baixo == 29 or vagner[5].direita == 29 or vagner[5].esquerda == 29 then

if vagner[5].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end

elseif vagner[5].cima == 30 or vagner[5].baixo == 30 or vagner[5].direita == 30 or vagner[5].esquerda == 30 then

if vagner[5].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x+2, y, z)
end
if vagner[5].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x-2, y, z)
end
if vagner[5].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z+2)
end
if vagner[5].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala5.Transform:SetPosition(x, y, z-2)
end
end

if vagner[5].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala5.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[5].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala5.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[5].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala5.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[5].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala5.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[6].nome ~= nil then

if vagner[6].cima == 1 or vagner[6].baixo == 1 or vagner[6].direita == 1 or vagner[6].esquerda == 1 then
 
 if vagner[6].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 2 or vagner[6].baixo == 2 or vagner[6].direita == 2 or vagner[6].esquerda == 2 then
 
if vagner[6].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 3 or vagner[6].baixo == 3 or vagner[6].direita == 3 or vagner[6].esquerda == 3 then

if vagner[6].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 4 or vagner[6].baixo == 4 or vagner[6].direita == 4 or vagner[6].esquerda == 4 then

if vagner[6].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 5 or vagner[6].baixo == 5 or vagner[6].direita == 5 or vagner[6].esquerda == 5 then

if vagner[6].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 6 or vagner[6].baixo == 6 or vagner[6].direita == 6 or vagner[6].esquerda == 6 then

if vagner[6].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 7 or vagner[6].baixo == 7 or vagner[6].direita == 7 or vagner[6].esquerda == 7 then

if vagner[6].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 8 or vagner[6].baixo == 8 or vagner[6].direita == 8 or vagner[6].esquerda == 8 then

if vagner[6].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 9 or vagner[6].baixo == 9 or vagner[6].direita == 9 or vagner[6].esquerda == 9 then

if vagner[6].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 10 or vagner[6].baixo == 10 or vagner[6].direita == 10 or vagner[6].esquerda == 10 then

if vagner[6].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 11 or vagner[6].baixo == 11 or vagner[6].direita == 11 or vagner[6].esquerda == 11 then

if vagner[6].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 12 or vagner[6].baixo == 12 or vagner[6].direita == 12 or vagner[6].esquerda == 12 then

if vagner[6].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 13 or vagner[6].baixo == 13 or vagner[6].direita == 13 or vagner[6].esquerda == 13 then

if vagner[6].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 14 or vagner[6].baixo == 14 or vagner[6].direita == 14 or vagner[6].esquerda == 14 then

if vagner[6].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 15 or vagner[6].baixo == 15 or vagner[6].direita == 15 or vagner[6].esquerda == 15 then

if vagner[6].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 16 or vagner[6].baixo == 16 or vagner[6].direita == 16 or vagner[6].esquerda == 16 then

if vagner[6].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 17 or vagner[6].baixo == 17 or vagner[6].direita == 17 or vagner[6].esquerda == 17 then

if vagner[6].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 18 or vagner[6].baixo == 18 or vagner[6].direita == 18 or vagner[6].esquerda == 18 then

if vagner[6].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 19 or vagner[6].baixo == 19 or vagner[6].direita == 19 or vagner[6].esquerda == 19 then

if vagner[6].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 20 or vagner[6].baixo == 20 or vagner[6].direita == 20 or vagner[6].esquerda == 20 then

if vagner[6].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 21 or vagner[6].baixo == 21 or vagner[6].direita == 21 or vagner[6].esquerda == 21 then

if vagner[6].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 22 or vagner[6].baixo == 22 or vagner[6].direita == 22 or vagner[6].esquerda == 22 then

if vagner[6].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 23 or vagner[6].baixo == 23 or vagner[6].direita == 23 or vagner[6].esquerda == 23 then

if vagner[6].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 24 or vagner[6].baixo == 24 or vagner[6].direita == 24 or vagner[6].esquerda == 24 then

if vagner[6].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 25 or vagner[6].baixo == 25 or vagner[6].direita == 25 or vagner[6].esquerda == 25 then

if vagner[6].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 26 or vagner[6].baixo == 26 or vagner[6].direita == 26 or vagner[6].esquerda == 26 then

if vagner[6].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 27 or vagner[6].baixo == 27 or vagner[6].direita == 27 or vagner[6].esquerda == 27 then

if vagner[6].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 28 or vagner[6].baixo == 28 or vagner[6].direita == 28 or vagner[6].esquerda == 28 then

if vagner[6].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 29 or vagner[6].baixo == 29 or vagner[6].direita == 29 or vagner[6].esquerda == 29 then

if vagner[6].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end

elseif vagner[6].cima == 30 or vagner[6].baixo == 30 or vagner[6].direita == 30 or vagner[6].esquerda == 30 then

if vagner[6].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x+2, y, z)
end
if vagner[6].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x-2, y, z)
end
if vagner[6].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z+2)
end
if vagner[6].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala6.Transform:SetPosition(x, y, z-2)
end
end

if vagner[6].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala6.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[6].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala6.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[6].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala6.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[6].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala6.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[7].nome ~= nil then

if vagner[7].cima == 1 or vagner[7].baixo == 1 or vagner[7].direita == 1 or vagner[7].esquerda == 1 then
 
 if vagner[7].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 2 or vagner[7].baixo == 2 or vagner[7].direita == 2 or vagner[7].esquerda == 2 then
 
if vagner[7].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 3 or vagner[7].baixo == 3 or vagner[7].direita == 3 or vagner[7].esquerda == 3 then

if vagner[7].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 4 or vagner[7].baixo == 4 or vagner[7].direita == 4 or vagner[7].esquerda == 4 then

if vagner[7].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 5 or vagner[7].baixo == 5 or vagner[7].direita == 5 or vagner[7].esquerda == 5 then

if vagner[7].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 6 or vagner[7].baixo == 6 or vagner[7].direita == 6 or vagner[7].esquerda == 6 then

if vagner[7].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end


elseif vagner[7].cima == 8 or vagner[7].baixo == 8 or vagner[7].direita == 8 or vagner[7].esquerda == 8 then

if vagner[7].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 9 or vagner[7].baixo == 9 or vagner[7].direita == 9 or vagner[7].esquerda == 9 then

if vagner[7].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 10 or vagner[7].baixo == 10 or vagner[7].direita == 10 or vagner[7].esquerda == 10 then

if vagner[7].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 11 or vagner[7].baixo == 11 or vagner[7].direita == 11 or vagner[7].esquerda == 11 then

if vagner[7].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 12 or vagner[7].baixo == 12 or vagner[7].direita == 12 or vagner[7].esquerda == 12 then

if vagner[7].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 13 or vagner[7].baixo == 13 or vagner[7].direita == 13 or vagner[7].esquerda == 13 then

if vagner[7].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 14 or vagner[7].baixo == 14 or vagner[7].direita == 14 or vagner[7].esquerda == 14 then

if vagner[7].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 15 or vagner[7].baixo == 15 or vagner[7].direita == 15 or vagner[7].esquerda == 15 then

if vagner[7].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 16 or vagner[7].baixo == 16 or vagner[7].direita == 16 or vagner[7].esquerda == 16 then

if vagner[7].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 17 or vagner[7].baixo == 17 or vagner[7].direita == 17 or vagner[7].esquerda == 17 then

if vagner[7].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end
elseif vagner[7].cima == 18 or vagner[7].baixo == 18 or vagner[7].direita == 18 or vagner[7].esquerda == 18 then

if vagner[7].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 19 or vagner[7].baixo == 19 or vagner[7].direita == 19 or vagner[7].esquerda == 19 then

if vagner[7].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 20 or vagner[7].baixo == 20 or vagner[7].direita == 20 or vagner[7].esquerda == 20 then

if vagner[7].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 21 or vagner[7].baixo == 21 or vagner[7].direita == 21 or vagner[7].esquerda == 21 then

if vagner[7].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 22 or vagner[7].baixo == 22 or vagner[7].direita == 22 or vagner[7].esquerda == 22 then

if vagner[7].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 23 or vagner[7].baixo == 23 or vagner[7].direita == 23 or vagner[7].esquerda == 23 then

if vagner[7].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 24 or vagner[7].baixo == 24 or vagner[7].direita == 24 or vagner[7].esquerda == 24 then

if vagner[7].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 25 or vagner[7].baixo == 25 or vagner[7].direita == 25 or vagner[7].esquerda == 25 then

if vagner[7].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 26 or vagner[7].baixo == 26 or vagner[7].direita == 26 or vagner[7].esquerda == 26 then

if vagner[7].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 27 or vagner[7].baixo == 27 or vagner[7].direita == 27 or vagner[7].esquerda == 27 then

if vagner[7].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 28 or vagner[7].baixo == 28 or vagner[7].direita == 28 or vagner[7].esquerda == 28 then

if vagner[7].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 29 or vagner[7].baixo == 29 or vagner[7].direita == 29 or vagner[7].esquerda == 29 then

if vagner[7].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end

elseif vagner[7].cima == 30 or vagner[7].baixo == 30 or vagner[7].direita == 30 or vagner[7].esquerda == 30 then

if vagner[7].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x+2, y, z)
end
if vagner[7].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x-2, y, z)
end
if vagner[7].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z+2)
end
if vagner[7].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala7.Transform:SetPosition(x, y, z-2)
end
end

if vagner[7].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala7.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[7].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala7.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[7].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala7.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[7].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala7.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[8].nome ~= nil then

if vagner[8].cima == 1 or vagner[8].baixo == 1 or vagner[8].direita == 1 or vagner[8].esquerda == 1 then
 
 if vagner[8].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 2 or vagner[8].baixo == 2 or vagner[8].direita == 2 or vagner[8].esquerda == 2 then
 
if vagner[8].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 3 or vagner[8].baixo == 3 or vagner[8].direita == 3 or vagner[8].esquerda == 3 then

if vagner[8].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 4 or vagner[8].baixo == 4 or vagner[8].direita == 4 or vagner[8].esquerda == 4 then

if vagner[8].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 5 or vagner[8].baixo == 5 or vagner[8].direita == 5 or vagner[8].esquerda == 5 then

if vagner[8].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 6 or vagner[8].baixo == 6 or vagner[8].direita == 6 or vagner[8].esquerda == 6 then

if vagner[8].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 7 or vagner[8].baixo == 7 or vagner[8].direita == 7 or vagner[8].esquerda == 7 then

if vagner[8].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 8 or vagner[8].baixo == 8 or vagner[8].direita == 8 or vagner[8].esquerda == 8 then

if vagner[8].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 9 or vagner[8].baixo == 9 or vagner[8].direita == 9 or vagner[8].esquerda == 9 then

if vagner[8].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 10 or vagner[8].baixo == 10 or vagner[8].direita == 10 or vagner[8].esquerda == 10 then

if vagner[8].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 11 or vagner[8].baixo == 11 or vagner[8].direita == 11 or vagner[8].esquerda == 11 then

if vagner[8].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 12 or vagner[8].baixo == 12 or vagner[8].direita == 12 or vagner[8].esquerda == 12 then

if vagner[8].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 13 or vagner[8].baixo == 13 or vagner[8].direita == 13 or vagner[8].esquerda == 13 then

if vagner[8].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 14 or vagner[8].baixo == 14 or vagner[8].direita == 14 or vagner[8].esquerda == 14 then

if vagner[8].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 15 or vagner[8].baixo == 15 or vagner[8].direita == 15 or vagner[8].esquerda == 15 then

if vagner[8].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 16 or vagner[8].baixo == 16 or vagner[8].direita == 16 or vagner[8].esquerda == 16 then

if vagner[8].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end
elseif vagner[8].cima == 17 or vagner[8].baixo == 17 or vagner[8].direita == 17 or vagner[8].esquerda == 17 then

if vagner[8].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 18 or vagner[8].baixo == 18 or vagner[8].direita == 18 or vagner[8].esquerda == 18 then

if vagner[8].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 19 or vagner[8].baixo == 19 or vagner[8].direita == 19 or vagner[8].esquerda == 19 then

if vagner[8].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 20 or vagner[8].baixo == 20 or vagner[8].direita == 20 or vagner[8].esquerda == 20 then

if vagner[8].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 21 or vagner[8].baixo == 21 or vagner[8].direita == 21 or vagner[8].esquerda == 21 then

if vagner[8].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 22 or vagner[8].baixo == 22 or vagner[8].direita == 22 or vagner[8].esquerda == 22 then

if vagner[8].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 23 or vagner[8].baixo == 23 or vagner[8].direita == 23 or vagner[8].esquerda == 23 then

if vagner[8].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 24 or vagner[8].baixo == 24 or vagner[8].direita == 24 or vagner[8].esquerda == 24 then

if vagner[8].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 25 or vagner[8].baixo == 25 or vagner[8].direita == 25 or vagner[8].esquerda == 25 then

if vagner[8].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 26 or vagner[8].baixo == 26 or vagner[8].direita == 26 or vagner[8].esquerda == 26 then

if vagner[8].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 27 or vagner[8].baixo == 27 or vagner[8].direita == 27 or vagner[8].esquerda == 27 then

if vagner[8].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 28 or vagner[8].baixo == 28 or vagner[8].direita == 28 or vagner[8].esquerda == 28 then

if vagner[8].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 29 or vagner[8].baixo == 29 or vagner[8].direita == 29 or vagner[8].esquerda == 29 then

if vagner[8].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end

elseif vagner[8].cima == 30 or vagner[8].baixo == 30 or vagner[8].direita == 30 or vagner[8].esquerda == 30 then

if vagner[8].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x+2, y, z)
end
if vagner[8].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x-2, y, z)
end
if vagner[8].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z+2)
end
if vagner[8].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala8.Transform:SetPosition(x, y, z-2)
end
end

if vagner[8].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala8.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[8].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala8.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[8].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala8.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[8].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala8.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[9].nome ~= nil then

if vagner[9].cima == 1 or vagner[9].baixo == 1 or vagner[9].direita == 1 or vagner[9].esquerda == 1 then
 
 if vagner[9].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 2 or vagner[9].baixo == 2 or vagner[9].direita == 2 or vagner[9].esquerda == 2 then
 
if vagner[9].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 3 or vagner[9].baixo == 3 or vagner[9].direita == 3 or vagner[9].esquerda == 3 then

if vagner[9].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 4 or vagner[9].baixo == 4 or vagner[9].direita == 4 or vagner[9].esquerda == 4 then

if vagner[9].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 5 or vagner[9].baixo == 5 or vagner[9].direita == 5 or vagner[9].esquerda == 5 then

if vagner[9].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 6 or vagner[9].baixo == 6 or vagner[9].direita == 6 or vagner[9].esquerda == 6 then

if vagner[9].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 7 or vagner[9].baixo == 7 or vagner[9].direita == 7 or vagner[9].esquerda == 7 then

if vagner[9].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 8 or vagner[9].baixo == 8 or vagner[9].direita == 8 or vagner[9].esquerda == 8 then

if vagner[9].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 9 or vagner[9].baixo == 9 or vagner[9].direita == 9 or vagner[9].esquerda == 9 then

if vagner[9].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 10 or vagner[9].baixo == 10 or vagner[9].direita == 10 or vagner[9].esquerda == 10 then

if vagner[9].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 11 or vagner[9].baixo == 11 or vagner[9].direita == 11 or vagner[9].esquerda == 11 then

if vagner[9].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 12 or vagner[9].baixo == 12 or vagner[9].direita == 12 or vagner[9].esquerda == 12 then

if vagner[9].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 13 or vagner[9].baixo == 13 or vagner[9].direita == 13 or vagner[9].esquerda == 13 then

if vagner[9].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 14 or vagner[9].baixo == 14 or vagner[9].direita == 14 or vagner[9].esquerda == 14 then

if vagner[9].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 15 or vagner[9].baixo == 15 or vagner[9].direita == 15 or vagner[9].esquerda == 15 then

if vagner[9].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 16 or vagner[9].baixo == 16 or vagner[9].direita == 16 or vagner[9].esquerda == 16 then

if vagner[9].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 17 or vagner[9].baixo == 17 or vagner[9].direita == 17 or vagner[9].esquerda == 17 then

if vagner[9].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 18 or vagner[9].baixo == 18 or vagner[9].direita == 18 or vagner[9].esquerda == 18 then

if vagner[9].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 19 or vagner[9].baixo == 19 or vagner[9].direita == 19 or vagner[9].esquerda == 19 then

if vagner[9].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 20 or vagner[9].baixo == 20 or vagner[9].direita == 20 or vagner[9].esquerda == 20 then

if vagner[9].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 21 or vagner[9].baixo == 21 or vagner[9].direita == 21 or vagner[9].esquerda == 21 then

if vagner[9].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 22 or vagner[9].baixo == 22 or vagner[9].direita == 22 or vagner[9].esquerda == 22 then

if vagner[9].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 23 or vagner[9].baixo == 23 or vagner[9].direita == 23 or vagner[9].esquerda == 23 then

if vagner[9].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 24 or vagner[9].baixo == 24 or vagner[9].direita == 24 or vagner[9].esquerda == 24 then

if vagner[9].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 25 or vagner[9].baixo == 25 or vagner[9].direita == 25 or vagner[9].esquerda == 25 then

if vagner[9].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 26 or vagner[9].baixo == 26 or vagner[9].direita == 26 or vagner[9].esquerda == 26 then

if vagner[9].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 27 or vagner[9].baixo == 27 or vagner[9].direita == 27 or vagner[9].esquerda == 27 then

if vagner[9].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 28 or vagner[9].baixo == 28 or vagner[9].direita == 28 or vagner[9].esquerda == 28 then

if vagner[9].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 29 or vagner[9].baixo == 29 or vagner[9].direita == 29 or vagner[9].esquerda == 29 then

if vagner[9].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end

elseif vagner[9].cima == 30 or vagner[9].baixo == 30 or vagner[9].direita == 30 or vagner[9].esquerda == 30 then

if vagner[9].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x+2, y, z)
end
if vagner[9].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x-2, y, z)
end
if vagner[9].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z+2)
end
if vagner[9].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala9.Transform:SetPosition(x, y, z-2)
end
end

if vagner[9].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala9.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[9].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala9.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[9].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala9.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[9].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala9.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[10].nome ~= nil then

if vagner[10].cima == 1 or vagner[10].baixo == 1 or vagner[10].direita == 1 or vagner[10].esquerda == 1 then
 
 if vagner[10].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 2 or vagner[10].baixo == 2 or vagner[10].direita == 2 or vagner[10].esquerda == 2 then
 
if vagner[10].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 3 or vagner[10].baixo == 3 or vagner[10].direita == 3 or vagner[10].esquerda == 3 then

if vagner[10].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 4 or vagner[10].baixo == 4 or vagner[10].direita == 4 or vagner[10].esquerda == 4 then

if vagner[10].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 5 or vagner[10].baixo == 5 or vagner[10].direita == 5 or vagner[10].esquerda == 5 then

if vagner[10].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 6 or vagner[10].baixo == 6 or vagner[10].direita == 6 or vagner[10].esquerda == 6 then

if vagner[10].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 7 or vagner[10].baixo == 7 or vagner[10].direita == 7 or vagner[10].esquerda == 7 then

if vagner[10].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 8 or vagner[10].baixo == 8 or vagner[10].direita == 8 or vagner[10].esquerda == 8 then

if vagner[10].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 9 or vagner[10].baixo == 9 or vagner[10].direita == 9 or vagner[10].esquerda == 9 then

if vagner[10].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 10 or vagner[10].baixo == 10 or vagner[10].direita == 10 or vagner[10].esquerda == 10 then

if vagner[10].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 11 or vagner[10].baixo == 11 or vagner[10].direita == 11 or vagner[10].esquerda == 11 then

if vagner[10].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 12 or vagner[10].baixo == 12 or vagner[10].direita == 12 or vagner[10].esquerda == 12 then

if vagner[10].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 13 or vagner[10].baixo == 13 or vagner[10].direita == 13 or vagner[10].esquerda == 13 then

if vagner[10].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 14 or vagner[10].baixo == 14 or vagner[10].direita == 14 or vagner[10].esquerda == 14 then

if vagner[10].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 15 or vagner[10].baixo == 15 or vagner[10].direita == 15 or vagner[10].esquerda == 15 then

if vagner[10].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 16 or vagner[10].baixo == 16 or vagner[10].direita == 16 or vagner[10].esquerda == 16 then

if vagner[10].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 17 or vagner[10].baixo == 17 or vagner[10].direita == 17 or vagner[10].esquerda == 17 then

if vagner[10].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 18 or vagner[10].baixo == 18 or vagner[10].direita == 18 or vagner[10].esquerda == 18 then

if vagner[10].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 19 or vagner[10].baixo == 19 or vagner[10].direita == 19 or vagner[10].esquerda == 19 then

if vagner[10].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 20 or vagner[10].baixo == 20 or vagner[10].direita == 20 or vagner[10].esquerda == 20 then

if vagner[10].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 21 or vagner[10].baixo == 21 or vagner[10].direita == 21 or vagner[10].esquerda == 21 then

if vagner[10].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end


elseif vagner[10].cima == 22 or vagner[10].baixo == 22 or vagner[10].direita == 22 or vagner[10].esquerda == 22 then

if vagner[10].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 23 or vagner[10].baixo == 23 or vagner[10].direita == 23 or vagner[10].esquerda == 23 then

if vagner[10].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 24 or vagner[10].baixo == 24 or vagner[10].direita == 24 or vagner[10].esquerda == 24 then

if vagner[10].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 25 or vagner[10].baixo == 25 or vagner[10].direita == 25 or vagner[10].esquerda == 25 then

if vagner[10].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 26 or vagner[10].baixo == 26 or vagner[10].direita == 26 or vagner[10].esquerda == 26 then

if vagner[10].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 27 or vagner[10].baixo == 27 or vagner[10].direita == 27 or vagner[10].esquerda == 27 then

if vagner[10].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 28 or vagner[10].baixo == 28 or vagner[10].direita == 28 or vagner[10].esquerda == 28 then

if vagner[10].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 29 or vagner[10].baixo == 29 or vagner[10].direita == 29 or vagner[10].esquerda == 29 then

if vagner[10].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end

elseif vagner[10].cima == 30 or vagner[10].baixo == 30 or vagner[10].direita == 30 or vagner[10].esquerda == 30 then

if vagner[10].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x+2, y, z)
end
if vagner[10].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x-2, y, z)
end
if vagner[10].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z+2)
end
if vagner[10].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala10.Transform:SetPosition(x, y, z-2)
end
end

if vagner[10].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala10.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[10].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala10.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[10].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala10.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[10].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala10.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[11].nome ~= nil then

if vagner[11].cima == 1 or vagner[11].baixo == 1 or vagner[11].direita == 1 or vagner[11].esquerda == 1 then
 
 if vagner[11].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 2 or vagner[11].baixo == 2 or vagner[11].direita == 2 or vagner[11].esquerda == 2 then
 
if vagner[11].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 3 or vagner[11].baixo == 3 or vagner[11].direita == 3 or vagner[11].esquerda == 3 then

if vagner[11].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 4 or vagner[11].baixo == 4 or vagner[11].direita == 4 or vagner[11].esquerda == 4 then

if vagner[11].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 5 or vagner[11].baixo == 5 or vagner[11].direita == 5 or vagner[11].esquerda == 5 then

if vagner[11].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 6 or vagner[11].baixo == 6 or vagner[11].direita == 6 or vagner[11].esquerda == 6 then

if vagner[11].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 7 or vagner[11].baixo == 7 or vagner[11].direita == 7 or vagner[11].esquerda == 7 then

if vagner[11].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 8 or vagner[11].baixo == 8 or vagner[11].direita == 8 or vagner[11].esquerda == 8 then

if vagner[11].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 9 or vagner[11].baixo == 9 or vagner[11].direita == 9 or vagner[11].esquerda == 9 then

if vagner[11].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 10 or vagner[11].baixo == 10 or vagner[11].direita == 10 or vagner[11].esquerda == 10 then

if vagner[11].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 11 or vagner[11].baixo == 11 or vagner[11].direita == 11 or vagner[11].esquerda == 11 then

if vagner[11].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 12 or vagner[11].baixo == 12 or vagner[11].direita == 12 or vagner[11].esquerda == 12 then

if vagner[11].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 13 or vagner[11].baixo == 13 or vagner[11].direita == 13 or vagner[11].esquerda == 13 then

if vagner[11].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 14 or vagner[11].baixo == 14 or vagner[11].direita == 14 or vagner[11].esquerda == 14 then

if vagner[11].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 15 or vagner[11].baixo == 15 or vagner[11].direita == 15 or vagner[11].esquerda == 15 then

if vagner[11].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 16 or vagner[11].baixo == 16 or vagner[11].direita == 16 or vagner[11].esquerda == 16 then

if vagner[11].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 17 or vagner[11].baixo == 17 or vagner[11].direita == 17 or vagner[11].esquerda == 17 then

if vagner[11].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 18 or vagner[11].baixo == 18 or vagner[11].direita == 18 or vagner[11].esquerda == 18 then

if vagner[11].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 19 or vagner[11].baixo == 19 or vagner[11].direita == 19 or vagner[11].esquerda == 19 then

if vagner[11].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 20 or vagner[11].baixo == 20 or vagner[11].direita == 20 or vagner[11].esquerda == 20 then

if vagner[11].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 21 or vagner[11].baixo == 21 or vagner[11].direita == 21 or vagner[11].esquerda == 21 then

if vagner[11].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 22 or vagner[11].baixo == 22 or vagner[11].direita == 22 or vagner[11].esquerda == 22 then

if vagner[11].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 23 or vagner[11].baixo == 23 or vagner[11].direita == 23 or vagner[11].esquerda == 23 then

if vagner[11].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 24 or vagner[11].baixo == 24 or vagner[11].direita == 24 or vagner[11].esquerda == 24 then

if vagner[11].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 25 or vagner[11].baixo == 25 or vagner[11].direita == 25 or vagner[11].esquerda == 25 then

if vagner[11].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 26 or vagner[11].baixo == 26 or vagner[11].direita == 26 or vagner[11].esquerda == 26 then

if vagner[11].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 27 or vagner[11].baixo == 27 or vagner[11].direita == 27 or vagner[11].esquerda == 27 then

if vagner[11].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 28 or vagner[11].baixo == 28 or vagner[11].direita == 28 or vagner[11].esquerda == 28 then

if vagner[11].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 29 or vagner[11].baixo == 29 or vagner[11].direita == 29 or vagner[11].esquerda == 29 then

if vagner[11].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end

elseif vagner[11].cima == 30 or vagner[11].baixo == 30 or vagner[11].direita == 30 or vagner[11].esquerda == 30 then

if vagner[11].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x+2, y, z)
end
if vagner[11].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x-2, y, z)
end
if vagner[11].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z+2)
end
if vagner[11].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala11.Transform:SetPosition(x, y, z-2)
end
end

if vagner[11].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala11.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[11].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala11.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[11].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala11.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[11].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala11.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[12].nome ~= nil then

if vagner[12].cima == 1 or vagner[12].baixo == 1 or vagner[12].direita == 1 or vagner[12].esquerda == 1 then
 
 if vagner[12].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 2 or vagner[12].baixo == 2 or vagner[12].direita == 2 or vagner[12].esquerda == 2 then
 
if vagner[12].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 3 or vagner[12].baixo == 3 or vagner[12].direita == 3 or vagner[12].esquerda == 3 then

if vagner[12].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 4 or vagner[12].baixo == 4 or vagner[12].direita == 4 or vagner[12].esquerda == 4 then

if vagner[12].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 5 or vagner[12].baixo == 5 or vagner[12].direita == 5 or vagner[12].esquerda == 5 then

if vagner[12].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 6 or vagner[12].baixo == 6 or vagner[12].direita == 6 or vagner[12].esquerda == 6 then

if vagner[12].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 7 or vagner[12].baixo == 7 or vagner[12].direita == 7 or vagner[12].esquerda == 7 then

if vagner[12].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 8 or vagner[12].baixo == 8 or vagner[12].direita == 8 or vagner[12].esquerda == 8 then

if vagner[12].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 9 or vagner[12].baixo == 9 or vagner[12].direita == 9 or vagner[12].esquerda == 9 then

if vagner[12].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 10 or vagner[12].baixo == 10 or vagner[12].direita == 10 or vagner[12].esquerda == 10 then

if vagner[12].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 11 or vagner[12].baixo == 11 or vagner[12].direita == 11 or vagner[12].esquerda == 11 then

if vagner[12].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 12 or vagner[12].baixo == 12 or vagner[12].direita == 12 or vagner[12].esquerda == 12 then

if vagner[12].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 13 or vagner[12].baixo == 13 or vagner[12].direita == 13 or vagner[12].esquerda == 13 then

if vagner[12].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 14 or vagner[12].baixo == 14 or vagner[12].direita == 14 or vagner[12].esquerda == 14 then

if vagner[12].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 15 or vagner[12].baixo == 15 or vagner[12].direita == 15 or vagner[12].esquerda == 15 then

if vagner[12].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end


elseif vagner[12].cima == 16 or vagner[12].baixo == 16 or vagner[12].direita == 16 or vagner[12].esquerda == 16 then

if vagner[12].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 17 or vagner[12].baixo == 17 or vagner[12].direita == 17 or vagner[12].esquerda == 17 then

if vagner[12].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 18 or vagner[12].baixo == 18 or vagner[12].direita == 18 or vagner[12].esquerda == 18 then

if vagner[12].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 19 or vagner[12].baixo == 19 or vagner[12].direita == 19 or vagner[12].esquerda == 19 then

if vagner[12].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 20 or vagner[12].baixo == 20 or vagner[12].direita == 20 or vagner[12].esquerda == 20 then

if vagner[12].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 21 or vagner[12].baixo == 21 or vagner[12].direita == 21 or vagner[12].esquerda == 21 then

if vagner[12].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 22 or vagner[12].baixo == 22 or vagner[12].direita == 22 or vagner[12].esquerda == 22 then

if vagner[12].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 23 or vagner[12].baixo == 23 or vagner[12].direita == 23 or vagner[12].esquerda == 23 then

if vagner[12].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 24 or vagner[12].baixo == 24 or vagner[12].direita == 24 or vagner[12].esquerda == 24 then

if vagner[12].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 25 or vagner[12].baixo == 25 or vagner[12].direita == 25 or vagner[12].esquerda == 25 then

if vagner[12].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 26 or vagner[12].baixo == 26 or vagner[12].direita == 26 or vagner[12].esquerda == 26 then

if vagner[12].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 27 or vagner[12].baixo == 27 or vagner[12].direita == 27 or vagner[12].esquerda == 27 then

if vagner[12].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 28 or vagner[12].baixo == 28 or vagner[12].direita == 28 or vagner[12].esquerda == 28 then

if vagner[12].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 29 or vagner[12].baixo == 29 or vagner[12].direita == 29 or vagner[12].esquerda == 29 then

if vagner[12].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end

elseif vagner[12].cima == 30 or vagner[12].baixo == 30 or vagner[12].direita == 30 or vagner[12].esquerda == 30 then

if vagner[12].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x+2, y, z)
end
if vagner[12].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x-2, y, z)
end
if vagner[12].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z+2)
end
if vagner[12].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala12.Transform:SetPosition(x, y, z-2)
end
end

if vagner[12].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala12.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[12].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala12.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[12].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala12.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[12].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala12.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[13].nome ~= nil then

if vagner[13].cima == 1 or vagner[13].baixo == 1 or vagner[13].direita == 1 or vagner[13].esquerda == 1 then
 
 if vagner[13].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 2 or vagner[13].baixo == 2 or vagner[13].direita == 2 or vagner[13].esquerda == 2 then
 
if vagner[13].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 3 or vagner[13].baixo == 3 or vagner[13].direita == 3 or vagner[13].esquerda == 3 then

if vagner[13].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 4 or vagner[13].baixo == 4 or vagner[13].direita == 4 or vagner[13].esquerda == 4 then

if vagner[13].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 5 or vagner[13].baixo == 5 or vagner[13].direita == 5 or vagner[13].esquerda == 5 then

if vagner[13].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 6 or vagner[13].baixo == 6 or vagner[13].direita == 6 or vagner[13].esquerda == 6 then

if vagner[13].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 7 or vagner[13].baixo == 7 or vagner[13].direita == 7 or vagner[13].esquerda == 7 then

if vagner[13].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 8 or vagner[13].baixo == 8 or vagner[13].direita == 8 or vagner[13].esquerda == 8 then

if vagner[13].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 9 or vagner[13].baixo == 9 or vagner[13].direita == 9 or vagner[13].esquerda == 9 then

if vagner[13].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 10 or vagner[13].baixo == 10 or vagner[13].direita == 10 or vagner[13].esquerda == 10 then

if vagner[13].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 11 or vagner[13].baixo == 11 or vagner[13].direita == 11 or vagner[13].esquerda == 11 then

if vagner[13].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 12 or vagner[13].baixo == 12 or vagner[13].direita == 12 or vagner[13].esquerda == 12 then

if vagner[13].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 13 or vagner[13].baixo == 13 or vagner[13].direita == 13 or vagner[13].esquerda == 13 then

if vagner[13].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 14 or vagner[13].baixo == 14 or vagner[13].direita == 14 or vagner[13].esquerda == 14 then

if vagner[13].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 15 or vagner[13].baixo == 15 or vagner[13].direita == 15 or vagner[13].esquerda == 15 then

if vagner[13].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 16 or vagner[13].baixo == 16 or vagner[13].direita == 16 or vagner[13].esquerda == 16 then

if vagner[13].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 17 or vagner[13].baixo == 17 or vagner[13].direita == 17 or vagner[13].esquerda == 17 then

if vagner[13].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 18 or vagner[13].baixo == 18 or vagner[13].direita == 18 or vagner[13].esquerda == 18 then

if vagner[13].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 19 or vagner[13].baixo == 19 or vagner[13].direita == 19 or vagner[13].esquerda == 19 then

if vagner[13].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 20 or vagner[13].baixo == 20 or vagner[13].direita == 20 or vagner[13].esquerda == 20 then

if vagner[13].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 21 or vagner[13].baixo == 21 or vagner[13].direita == 21 or vagner[13].esquerda == 21 then

if vagner[13].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 22 or vagner[13].baixo == 22 or vagner[13].direita == 22 or vagner[13].esquerda == 22 then

if vagner[13].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 23 or vagner[13].baixo == 23 or vagner[13].direita == 23 or vagner[13].esquerda == 23 then

if vagner[13].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 24 or vagner[13].baixo == 24 or vagner[13].direita == 24 or vagner[13].esquerda == 24 then

if vagner[13].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 25 or vagner[13].baixo == 25 or vagner[13].direita == 25 or vagner[13].esquerda == 25 then

if vagner[13].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 26 or vagner[13].baixo == 26 or vagner[13].direita == 26 or vagner[13].esquerda == 26 then

if vagner[13].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 27 or vagner[13].baixo == 27 or vagner[13].direita == 27 or vagner[13].esquerda == 27 then

if vagner[13].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 28 or vagner[13].baixo == 28 or vagner[13].direita == 28 or vagner[13].esquerda == 28 then

if vagner[13].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 29 or vagner[13].baixo == 29 or vagner[13].direita == 29 or vagner[13].esquerda == 29 then

if vagner[13].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end

elseif vagner[13].cima == 30 or vagner[13].baixo == 30 or vagner[13].direita == 30 or vagner[13].esquerda == 30 then

if vagner[13].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x+2, y, z)
end
if vagner[13].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x-2, y, z)
end
if vagner[13].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z+2)
end
if vagner[13].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala13.Transform:SetPosition(x, y, z-2)
end
end

if vagner[13].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala13.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[13].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala13.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[13].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala13.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[13].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala13.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[14].nome ~= nil then

if vagner[14].cima == 1 or vagner[14].baixo == 1 or vagner[14].direita == 1 or vagner[14].esquerda == 1 then
 
 if vagner[14].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 2 or vagner[14].baixo == 2 or vagner[14].direita == 2 or vagner[14].esquerda == 2 then
 
if vagner[14].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 3 or vagner[14].baixo == 3 or vagner[14].direita == 3 or vagner[14].esquerda == 3 then

if vagner[14].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 4 or vagner[14].baixo == 4 or vagner[14].direita == 4 or vagner[14].esquerda == 4 then

if vagner[14].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 5 or vagner[14].baixo == 5 or vagner[14].direita == 5 or vagner[14].esquerda == 5 then

if vagner[14].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 6 or vagner[14].baixo == 6 or vagner[14].direita == 6 or vagner[14].esquerda == 6 then

if vagner[14].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 7 or vagner[14].baixo == 7 or vagner[14].direita == 7 or vagner[14].esquerda == 7 then

if vagner[14].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 8 or vagner[14].baixo == 8 or vagner[14].direita == 8 or vagner[14].esquerda == 8 then

if vagner[14].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 9 or vagner[14].baixo == 9 or vagner[14].direita == 9 or vagner[14].esquerda == 9 then

if vagner[14].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 10 or vagner[14].baixo == 10 or vagner[14].direita == 10 or vagner[14].esquerda == 10 then

if vagner[14].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 11 or vagner[14].baixo == 11 or vagner[14].direita == 11 or vagner[14].esquerda == 11 then

if vagner[14].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 12 or vagner[14].baixo == 12 or vagner[14].direita == 12 or vagner[14].esquerda == 12 then

if vagner[14].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 13 or vagner[14].baixo == 13 or vagner[14].direita == 13 or vagner[14].esquerda == 13 then

if vagner[14].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 14 or vagner[14].baixo == 14 or vagner[14].direita == 14 or vagner[14].esquerda == 14 then

if vagner[14].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 15 or vagner[14].baixo == 15 or vagner[14].direita == 15 or vagner[14].esquerda == 15 then

if vagner[14].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 16 or vagner[14].baixo == 16 or vagner[14].direita == 16 or vagner[14].esquerda == 16 then

if vagner[14].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 17 or vagner[14].baixo == 17 or vagner[14].direita == 17 or vagner[14].esquerda == 17 then

if vagner[14].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 18 or vagner[14].baixo == 18 or vagner[14].direita == 18 or vagner[14].esquerda == 18 then

if vagner[14].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 19 or vagner[14].baixo == 19 or vagner[14].direita == 19 or vagner[14].esquerda == 19 then

if vagner[14].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 20 or vagner[14].baixo == 20 or vagner[14].direita == 20 or vagner[14].esquerda == 20 then

if vagner[14].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 21 or vagner[14].baixo == 21 or vagner[14].direita == 21 or vagner[14].esquerda == 21 then

if vagner[14].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 22 or vagner[14].baixo == 22 or vagner[14].direita == 22 or vagner[14].esquerda == 22 then

if vagner[14].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 23 or vagner[14].baixo == 23 or vagner[14].direita == 23 or vagner[14].esquerda == 23 then

if vagner[14].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 24 or vagner[14].baixo == 24 or vagner[14].direita == 24 or vagner[14].esquerda == 24 then

if vagner[14].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 25 or vagner[14].baixo == 25 or vagner[14].direita == 25 or vagner[14].esquerda == 25 then

if vagner[14].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 26 or vagner[14].baixo == 26 or vagner[14].direita == 26 or vagner[14].esquerda == 26 then

if vagner[14].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 27 or vagner[14].baixo == 27 or vagner[14].direita == 27 or vagner[14].esquerda == 27 then

if vagner[14].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 28 or vagner[14].baixo == 28 or vagner[14].direita == 28 or vagner[14].esquerda == 28 then

if vagner[14].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 29 or vagner[14].baixo == 29 or vagner[14].direita == 29 or vagner[14].esquerda == 29 then

if vagner[14].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end

elseif vagner[14].cima == 30 or vagner[14].baixo == 30 or vagner[14].direita == 30 or vagner[14].esquerda == 30 then

if vagner[14].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x+2, y, z)
end
if vagner[14].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x-2, y, z)
end
if vagner[14].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z+2)
end
if vagner[14].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala14.Transform:SetPosition(x, y, z-2)
end
end

if vagner[14].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala14.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[14].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala14.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[14].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala14.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[14].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala14.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[15].nome ~= nil then

if vagner[15].cima == 1 or vagner[15].baixo == 1 or vagner[15].direita == 1 or vagner[15].esquerda == 1 then
 
 if vagner[15].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 2 or vagner[15].baixo == 2 or vagner[15].direita == 2 or vagner[15].esquerda == 2 then
 
if vagner[15].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 3 or vagner[15].baixo == 3 or vagner[15].direita == 3 or vagner[15].esquerda == 3 then

if vagner[15].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 4 or vagner[15].baixo == 4 or vagner[15].direita == 4 or vagner[15].esquerda == 4 then

if vagner[15].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 5 or vagner[15].baixo == 5 or vagner[15].direita == 5 or vagner[15].esquerda == 5 then

if vagner[15].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 6 or vagner[15].baixo == 6 or vagner[15].direita == 6 or vagner[15].esquerda == 6 then

if vagner[15].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 7 or vagner[15].baixo == 7 or vagner[15].direita == 7 or vagner[15].esquerda == 7 then

if vagner[15].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 8 or vagner[15].baixo == 8 or vagner[15].direita == 8 or vagner[15].esquerda == 8 then

if vagner[15].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 9 or vagner[15].baixo == 9 or vagner[15].direita == 9 or vagner[15].esquerda == 9 then

if vagner[15].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 10 or vagner[15].baixo == 10 or vagner[15].direita == 10 or vagner[15].esquerda == 10 then

if vagner[15].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 11 or vagner[15].baixo == 11 or vagner[15].direita == 11 or vagner[15].esquerda == 11 then

if vagner[15].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 12 or vagner[15].baixo == 12 or vagner[15].direita == 12 or vagner[15].esquerda == 12 then

if vagner[15].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 13 or vagner[15].baixo == 13 or vagner[15].direita == 13 or vagner[15].esquerda == 13 then

if vagner[15].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 14 or vagner[15].baixo == 14 or vagner[15].direita == 14 or vagner[15].esquerda == 14 then

if vagner[15].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 15 or vagner[15].baixo == 15 or vagner[15].direita == 15 or vagner[15].esquerda == 15 then

if vagner[15].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 16 or vagner[15].baixo == 16 or vagner[15].direita == 16 or vagner[15].esquerda == 16 then

if vagner[15].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 17 or vagner[15].baixo == 17 or vagner[15].direita == 17 or vagner[15].esquerda == 17 then

if vagner[15].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 18 or vagner[15].baixo == 18 or vagner[15].direita == 18 or vagner[15].esquerda == 18 then

if vagner[15].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 19 or vagner[15].baixo == 19 or vagner[15].direita == 19 or vagner[15].esquerda == 19 then

if vagner[15].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 20 or vagner[15].baixo == 20 or vagner[15].direita == 20 or vagner[15].esquerda == 20 then

if vagner[15].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 21 or vagner[15].baixo == 21 or vagner[15].direita == 21 or vagner[15].esquerda == 21 then

if vagner[15].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 22 or vagner[15].baixo == 22 or vagner[15].direita == 22 or vagner[15].esquerda == 22 then

if vagner[15].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 23 or vagner[15].baixo == 23 or vagner[15].direita == 23 or vagner[15].esquerda == 23 then

if vagner[15].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 24 or vagner[15].baixo == 24 or vagner[15].direita == 24 or vagner[15].esquerda == 24 then

if vagner[15].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 25 or vagner[15].baixo == 25 or vagner[15].direita == 25 or vagner[15].esquerda == 25 then

if vagner[15].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 26 or vagner[15].baixo == 26 or vagner[15].direita == 26 or vagner[15].esquerda == 26 then

if vagner[15].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 27 or vagner[15].baixo == 27 or vagner[15].direita == 27 or vagner[15].esquerda == 27 then

if vagner[15].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 28 or vagner[15].baixo == 28 or vagner[15].direita == 28 or vagner[15].esquerda == 28 then

if vagner[15].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 29 or vagner[15].baixo == 29 or vagner[15].direita == 29 or vagner[15].esquerda == 29 then

if vagner[15].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end

elseif vagner[15].cima == 30 or vagner[15].baixo == 30 or vagner[15].direita == 30 or vagner[15].esquerda == 30 then

if vagner[15].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x+2, y, z)
end
if vagner[15].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x-2, y, z)
end
if vagner[15].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z+2)
end
if vagner[15].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala15.Transform:SetPosition(x, y, z-2)
end
end

if vagner[15].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala15.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[15].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala15.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[15].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala15.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[15].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala15.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[16].nome ~= nil then

if vagner[16].cima == 1 or vagner[16].baixo == 1 or vagner[16].direita == 1 or vagner[16].esquerda == 1 then
 
 if vagner[16].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 2 or vagner[16].baixo == 2 or vagner[16].direita == 2 or vagner[16].esquerda == 2 then
 
if vagner[16].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 3 or vagner[16].baixo == 3 or vagner[16].direita == 3 or vagner[16].esquerda == 3 then

if vagner[16].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 4 or vagner[16].baixo == 4 or vagner[16].direita == 4 or vagner[16].esquerda == 4 then

if vagner[16].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 5 or vagner[16].baixo == 5 or vagner[16].direita == 5 or vagner[16].esquerda == 5 then

if vagner[16].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 6 or vagner[16].baixo == 6 or vagner[16].direita == 6 or vagner[16].esquerda == 6 then

if vagner[16].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 7 or vagner[16].baixo == 7 or vagner[16].direita == 7 or vagner[16].esquerda == 7 then

if vagner[16].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 8 or vagner[16].baixo == 8 or vagner[16].direita == 8 or vagner[16].esquerda == 8 then

if vagner[16].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 9 or vagner[16].baixo == 9 or vagner[16].direita == 9 or vagner[16].esquerda == 9 then

if vagner[16].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 10 or vagner[16].baixo == 10 or vagner[16].direita == 10 or vagner[16].esquerda == 10 then

if vagner[16].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 11 or vagner[16].baixo == 11 or vagner[16].direita == 11 or vagner[16].esquerda == 11 then

if vagner[16].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 12 or vagner[16].baixo == 12 or vagner[16].direita == 12 or vagner[16].esquerda == 12 then

if vagner[16].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 13 or vagner[16].baixo == 13 or vagner[16].direita == 13 or vagner[16].esquerda == 13 then

if vagner[16].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 14 or vagner[16].baixo == 14 or vagner[16].direita == 14 or vagner[16].esquerda == 14 then

if vagner[16].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 15 or vagner[16].baixo == 15 or vagner[16].direita == 15 or vagner[16].esquerda == 15 then

if vagner[16].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 16 or vagner[16].baixo == 16 or vagner[16].direita == 16 or vagner[16].esquerda == 16 then

if vagner[16].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 17 or vagner[16].baixo == 17 or vagner[16].direita == 17 or vagner[16].esquerda == 17 then

if vagner[16].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 18 or vagner[16].baixo == 18 or vagner[16].direita == 18 or vagner[16].esquerda == 18 then

if vagner[16].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 19 or vagner[16].baixo == 19 or vagner[16].direita == 19 or vagner[16].esquerda == 19 then

if vagner[16].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 20 or vagner[16].baixo == 20 or vagner[16].direita == 20 or vagner[16].esquerda == 20 then

if vagner[16].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 21 or vagner[16].baixo == 21 or vagner[16].direita == 21 or vagner[16].esquerda == 21 then

if vagner[16].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 22 or vagner[16].baixo == 22 or vagner[16].direita == 22 or vagner[16].esquerda == 22 then

if vagner[16].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 23 or vagner[16].baixo == 23 or vagner[16].direita == 23 or vagner[16].esquerda == 23 then

if vagner[16].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 24 or vagner[16].baixo == 24 or vagner[16].direita == 24 or vagner[16].esquerda == 24 then

if vagner[16].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 25 or vagner[16].baixo == 25 or vagner[16].direita == 25 or vagner[16].esquerda == 25 then

if vagner[16].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 26 or vagner[16].baixo == 26 or vagner[16].direita == 26 or vagner[16].esquerda == 26 then

if vagner[16].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 27 or vagner[16].baixo == 27 or vagner[16].direita == 27 or vagner[16].esquerda == 27 then

if vagner[16].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 28 or vagner[16].baixo == 28 or vagner[16].direita == 28 or vagner[16].esquerda == 28 then

if vagner[16].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 29 or vagner[16].baixo == 29 or vagner[16].direita == 29 or vagner[16].esquerda == 29 then

if vagner[16].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end

elseif vagner[16].cima == 30 or vagner[16].baixo == 30 or vagner[16].direita == 30 or vagner[16].esquerda == 30 then

if vagner[16].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x+2, y, z)
end
if vagner[16].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x-2, y, z)
end
if vagner[16].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z+2)
end
if vagner[16].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala16.Transform:SetPosition(x, y, z-2)
end
end

if vagner[16].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala16.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[16].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala16.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[16].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala16.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[16].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala16.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[17].nome ~= nil then

if vagner[17].cima == 1 or vagner[17].baixo == 1 or vagner[17].direita == 1 or vagner[17].esquerda == 1 then
 
 if vagner[17].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 2 or vagner[17].baixo == 2 or vagner[17].direita == 2 or vagner[17].esquerda == 2 then
 
if vagner[17].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 3 or vagner[17].baixo == 3 or vagner[17].direita == 3 or vagner[17].esquerda == 3 then

if vagner[17].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 4 or vagner[17].baixo == 4 or vagner[17].direita == 4 or vagner[17].esquerda == 4 then

if vagner[17].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 5 or vagner[17].baixo == 5 or vagner[17].direita == 5 or vagner[17].esquerda == 5 then

if vagner[17].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 6 or vagner[17].baixo == 6 or vagner[17].direita == 6 or vagner[17].esquerda == 6 then

if vagner[17].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 7 or vagner[17].baixo == 7 or vagner[17].direita == 7 or vagner[17].esquerda == 7 then

if vagner[17].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 8 or vagner[17].baixo == 8 or vagner[17].direita == 8 or vagner[17].esquerda == 8 then

if vagner[17].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 9 or vagner[17].baixo == 9 or vagner[17].direita == 9 or vagner[17].esquerda == 9 then

if vagner[17].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 10 or vagner[17].baixo == 10 or vagner[17].direita == 10 or vagner[17].esquerda == 10 then

if vagner[17].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 11 or vagner[17].baixo == 11 or vagner[17].direita == 11 or vagner[17].esquerda == 11 then

if vagner[17].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 12 or vagner[17].baixo == 12 or vagner[17].direita == 12 or vagner[17].esquerda == 12 then

if vagner[17].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 13 or vagner[17].baixo == 13 or vagner[17].direita == 13 or vagner[17].esquerda == 13 then

if vagner[17].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 14 or vagner[17].baixo == 14 or vagner[17].direita == 14 or vagner[17].esquerda == 14 then

if vagner[17].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 15 or vagner[17].baixo == 15 or vagner[17].direita == 15 or vagner[17].esquerda == 15 then

if vagner[17].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 16 or vagner[17].baixo == 16 or vagner[17].direita == 16 or vagner[17].esquerda == 16 then

if vagner[17].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 17 or vagner[17].baixo == 17 or vagner[17].direita == 17 or vagner[17].esquerda == 17 then

if vagner[17].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 18 or vagner[17].baixo == 18 or vagner[17].direita == 18 or vagner[17].esquerda == 18 then

if vagner[17].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 19 or vagner[17].baixo == 19 or vagner[17].direita == 19 or vagner[17].esquerda == 19 then

if vagner[17].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 20 or vagner[17].baixo == 20 or vagner[17].direita == 20 or vagner[17].esquerda == 20 then

if vagner[17].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 21 or vagner[17].baixo == 21 or vagner[17].direita == 21 or vagner[17].esquerda == 21 then

if vagner[17].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 22 or vagner[17].baixo == 22 or vagner[17].direita == 22 or vagner[17].esquerda == 22 then

if vagner[17].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 23 or vagner[17].baixo == 23 or vagner[17].direita == 23 or vagner[17].esquerda == 23 then

if vagner[17].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 24 or vagner[17].baixo == 24 or vagner[17].direita == 24 or vagner[17].esquerda == 24 then

if vagner[17].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 25 or vagner[17].baixo == 25 or vagner[17].direita == 25 or vagner[17].esquerda == 25 then

if vagner[17].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 26 or vagner[17].baixo == 26 or vagner[17].direita == 26 or vagner[17].esquerda == 26 then

if vagner[17].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 27 or vagner[17].baixo == 27 or vagner[17].direita == 27 or vagner[17].esquerda == 27 then

if vagner[17].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 28 or vagner[17].baixo == 28 or vagner[17].direita == 28 or vagner[17].esquerda == 28 then

if vagner[17].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 29 or vagner[17].baixo == 29 or vagner[17].direita == 29 or vagner[17].esquerda == 29 then

if vagner[17].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end

elseif vagner[17].cima == 30 or vagner[17].baixo == 30 or vagner[17].direita == 30 or vagner[17].esquerda == 30 then

if vagner[17].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x+2, y, z)
end
if vagner[17].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x-2, y, z)
end
if vagner[17].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z+2)
end
if vagner[17].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala17.Transform:SetPosition(x, y, z-2)
end
end

if vagner[17].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala17.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[17].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala17.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[17].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala17.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[17].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala17.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[18].nome ~= nil then

if vagner[18].cima == 1 or vagner[18].baixo == 1 or vagner[18].direita == 1 or vagner[18].esquerda == 1 then
 
 if vagner[18].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 2 or vagner[18].baixo == 2 or vagner[18].direita == 2 or vagner[18].esquerda == 2 then
 
if vagner[18].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 3 or vagner[18].baixo == 3 or vagner[18].direita == 3 or vagner[18].esquerda == 3 then

if vagner[18].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 4 or vagner[18].baixo == 4 or vagner[18].direita == 4 or vagner[18].esquerda == 4 then

if vagner[18].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 5 or vagner[18].baixo == 5 or vagner[18].direita == 5 or vagner[18].esquerda == 5 then

if vagner[18].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 6 or vagner[18].baixo == 6 or vagner[18].direita == 6 or vagner[18].esquerda == 6 then

if vagner[18].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 7 or vagner[18].baixo == 7 or vagner[18].direita == 7 or vagner[18].esquerda == 7 then

if vagner[18].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 8 or vagner[18].baixo == 8 or vagner[18].direita == 8 or vagner[18].esquerda == 8 then

if vagner[18].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 9 or vagner[18].baixo == 9 or vagner[18].direita == 9 or vagner[18].esquerda == 9 then

if vagner[18].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 10 or vagner[18].baixo == 10 or vagner[18].direita == 10 or vagner[18].esquerda == 10 then

if vagner[18].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 11 or vagner[18].baixo == 11 or vagner[18].direita == 11 or vagner[18].esquerda == 11 then

if vagner[18].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 12 or vagner[18].baixo == 12 or vagner[18].direita == 12 or vagner[18].esquerda == 12 then

if vagner[18].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 13 or vagner[18].baixo == 13 or vagner[18].direita == 13 or vagner[18].esquerda == 13 then

if vagner[18].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 14 or vagner[18].baixo == 14 or vagner[18].direita == 14 or vagner[18].esquerda == 14 then

if vagner[18].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 15 or vagner[18].baixo == 15 or vagner[18].direita == 15 or vagner[18].esquerda == 15 then

if vagner[18].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 16 or vagner[18].baixo == 16 or vagner[18].direita == 16 or vagner[18].esquerda == 16 then

if vagner[18].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 17 or vagner[18].baixo == 17 or vagner[18].direita == 17 or vagner[18].esquerda == 17 then

if vagner[18].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 18 or vagner[18].baixo == 18 or vagner[18].direita == 18 or vagner[18].esquerda == 18 then

if vagner[18].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 19 or vagner[18].baixo == 19 or vagner[18].direita == 19 or vagner[18].esquerda == 19 then

if vagner[18].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 20 or vagner[18].baixo == 20 or vagner[18].direita == 20 or vagner[18].esquerda == 20 then

if vagner[18].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 21 or vagner[18].baixo == 21 or vagner[18].direita == 21 or vagner[18].esquerda == 21 then

if vagner[18].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 22 or vagner[18].baixo == 22 or vagner[18].direita == 22 or vagner[18].esquerda == 22 then

if vagner[18].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 23 or vagner[18].baixo == 23 or vagner[18].direita == 23 or vagner[18].esquerda == 23 then

if vagner[18].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 24 or vagner[18].baixo == 24 or vagner[18].direita == 24 or vagner[18].esquerda == 24 then

if vagner[18].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 25 or vagner[18].baixo == 25 or vagner[18].direita == 25 or vagner[18].esquerda == 25 then

if vagner[18].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 26 or vagner[18].baixo == 26 or vagner[18].direita == 26 or vagner[18].esquerda == 26 then

if vagner[18].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 27 or vagner[18].baixo == 27 or vagner[18].direita == 27 or vagner[18].esquerda == 27 then

if vagner[18].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 28 or vagner[18].baixo == 28 or vagner[18].direita == 28 or vagner[18].esquerda == 28 then

if vagner[18].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 29 or vagner[18].baixo == 29 or vagner[18].direita == 29 or vagner[18].esquerda == 29 then

if vagner[18].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end

elseif vagner[18].cima == 30 or vagner[18].baixo == 30 or vagner[18].direita == 30 or vagner[18].esquerda == 30 then

if vagner[18].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x+2, y, z)
end
if vagner[18].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x-2, y, z)
end
if vagner[18].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z+2)
end
if vagner[18].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala18.Transform:SetPosition(x, y, z-2)
end
end

if vagner[18].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala18.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[18].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala18.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[18].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala18.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[18].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala18.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[19].nome ~= nil then

if vagner[19].cima == 1 or vagner[19].baixo == 1 or vagner[19].direita == 1 or vagner[19].esquerda == 1 then
 
 if vagner[19].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 2 or vagner[19].baixo == 2 or vagner[19].direita == 2 or vagner[19].esquerda == 2 then
 
if vagner[19].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 3 or vagner[19].baixo == 3 or vagner[19].direita == 3 or vagner[19].esquerda == 3 then

if vagner[19].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 4 or vagner[19].baixo == 4 or vagner[19].direita == 4 or vagner[19].esquerda == 4 then

if vagner[19].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 5 or vagner[19].baixo == 5 or vagner[19].direita == 5 or vagner[19].esquerda == 5 then

if vagner[19].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 6 or vagner[19].baixo == 6 or vagner[19].direita == 6 or vagner[19].esquerda == 6 then

if vagner[19].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 7 or vagner[19].baixo == 7 or vagner[19].direita == 7 or vagner[19].esquerda == 7 then

if vagner[19].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 8 or vagner[19].baixo == 8 or vagner[19].direita == 8 or vagner[19].esquerda == 8 then

if vagner[19].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 9 or vagner[19].baixo == 9 or vagner[19].direita == 9 or vagner[19].esquerda == 9 then

if vagner[19].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 10 or vagner[19].baixo == 10 or vagner[19].direita == 10 or vagner[19].esquerda == 10 then

if vagner[19].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 11 or vagner[19].baixo == 11 or vagner[19].direita == 11 or vagner[19].esquerda == 11 then

if vagner[19].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 12 or vagner[19].baixo == 12 or vagner[19].direita == 12 or vagner[19].esquerda == 12 then

if vagner[19].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 13 or vagner[19].baixo == 13 or vagner[19].direita == 13 or vagner[19].esquerda == 13 then

if vagner[19].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 14 or vagner[19].baixo == 14 or vagner[19].direita == 14 or vagner[19].esquerda == 14 then

if vagner[19].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 15 or vagner[19].baixo == 15 or vagner[19].direita == 15 or vagner[19].esquerda == 15 then

if vagner[19].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 16 or vagner[19].baixo == 16 or vagner[19].direita == 16 or vagner[19].esquerda == 16 then

if vagner[19].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 17 or vagner[19].baixo == 17 or vagner[19].direita == 17 or vagner[19].esquerda == 17 then

if vagner[19].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 18 or vagner[19].baixo == 18 or vagner[19].direita == 18 or vagner[19].esquerda == 18 then

if vagner[19].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 19 or vagner[19].baixo == 19 or vagner[19].direita == 19 or vagner[19].esquerda == 19 then

if vagner[19].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 20 or vagner[19].baixo == 20 or vagner[19].direita == 20 or vagner[19].esquerda == 20 then

if vagner[19].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 21 or vagner[19].baixo == 21 or vagner[19].direita == 21 or vagner[19].esquerda == 21 then

if vagner[19].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 22 or vagner[19].baixo == 22 or vagner[19].direita == 22 or vagner[19].esquerda == 22 then

if vagner[19].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 23 or vagner[19].baixo == 23 or vagner[19].direita == 23 or vagner[19].esquerda == 23 then

if vagner[19].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 24 or vagner[19].baixo == 24 or vagner[19].direita == 24 or vagner[19].esquerda == 24 then

if vagner[19].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 25 or vagner[19].baixo == 25 or vagner[19].direita == 25 or vagner[19].esquerda == 25 then

if vagner[19].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 26 or vagner[19].baixo == 26 or vagner[19].direita == 26 or vagner[19].esquerda == 26 then

if vagner[19].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 27 or vagner[19].baixo == 27 or vagner[19].direita == 27 or vagner[19].esquerda == 27 then

if vagner[19].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 28 or vagner[19].baixo == 28 or vagner[19].direita == 28 or vagner[19].esquerda == 28 then

if vagner[19].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 29 or vagner[19].baixo == 29 or vagner[19].direita == 29 or vagner[19].esquerda == 29 then

if vagner[19].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end

elseif vagner[19].cima == 30 or vagner[19].baixo == 30 or vagner[19].direita == 30 or vagner[19].esquerda == 30 then

if vagner[19].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x+2, y, z)
end
if vagner[19].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x-2, y, z)
end
if vagner[19].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z+2)
end
if vagner[19].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala19.Transform:SetPosition(x, y, z-2)
end
end

if vagner[19].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala19.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[19].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala19.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[19].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala19.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[19].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala19.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[20].nome ~= nil then

if vagner[20].cima == 1 or vagner[20].baixo == 1 or vagner[20].direita == 1 or vagner[20].esquerda == 1 then
 
 if vagner[20].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 2 or vagner[20].baixo == 2 or vagner[20].direita == 2 or vagner[20].esquerda == 2 then
 
if vagner[20].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 3 or vagner[20].baixo == 3 or vagner[20].direita == 3 or vagner[20].esquerda == 3 then

if vagner[20].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 4 or vagner[20].baixo == 4 or vagner[20].direita == 4 or vagner[20].esquerda == 4 then

if vagner[20].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 5 or vagner[20].baixo == 5 or vagner[20].direita == 5 or vagner[20].esquerda == 5 then

if vagner[20].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 6 or vagner[20].baixo == 6 or vagner[20].direita == 6 or vagner[20].esquerda == 6 then

if vagner[20].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 7 or vagner[20].baixo == 7 or vagner[20].direita == 7 or vagner[20].esquerda == 7 then

if vagner[20].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 8 or vagner[20].baixo == 8 or vagner[20].direita == 8 or vagner[20].esquerda == 8 then

if vagner[20].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 9 or vagner[20].baixo == 9 or vagner[20].direita == 9 or vagner[20].esquerda == 9 then

if vagner[20].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 10 or vagner[20].baixo == 10 or vagner[20].direita == 10 or vagner[20].esquerda == 10 then

if vagner[20].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 11 or vagner[20].baixo == 11 or vagner[20].direita == 11 or vagner[20].esquerda == 11 then

if vagner[20].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 12 or vagner[20].baixo == 12 or vagner[20].direita == 12 or vagner[20].esquerda == 12 then

if vagner[20].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 13 or vagner[20].baixo == 13 or vagner[20].direita == 13 or vagner[20].esquerda == 13 then

if vagner[20].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 14 or vagner[20].baixo == 14 or vagner[20].direita == 14 or vagner[20].esquerda == 14 then

if vagner[20].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 15 or vagner[20].baixo == 15 or vagner[20].direita == 15 or vagner[20].esquerda == 15 then

if vagner[20].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 16 or vagner[20].baixo == 16 or vagner[20].direita == 16 or vagner[20].esquerda == 16 then

if vagner[20].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 17 or vagner[20].baixo == 17 or vagner[20].direita == 17 or vagner[20].esquerda == 17 then

if vagner[20].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 18 or vagner[20].baixo == 18 or vagner[20].direita == 18 or vagner[20].esquerda == 18 then

if vagner[20].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 19 or vagner[20].baixo == 19 or vagner[20].direita == 19 or vagner[20].esquerda == 19 then

if vagner[20].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 20 or vagner[20].baixo == 20 or vagner[20].direita == 20 or vagner[20].esquerda == 20 then

if vagner[20].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 21 or vagner[20].baixo == 21 or vagner[20].direita == 21 or vagner[20].esquerda == 21 then

if vagner[20].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 22 or vagner[20].baixo == 22 or vagner[20].direita == 22 or vagner[20].esquerda == 22 then

if vagner[20].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 23 or vagner[20].baixo == 23 or vagner[20].direita == 23 or vagner[20].esquerda == 23 then

if vagner[20].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 24 or vagner[20].baixo == 24 or vagner[20].direita == 24 or vagner[20].esquerda == 24 then

if vagner[20].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 25 or vagner[20].baixo == 25 or vagner[20].direita == 25 or vagner[20].esquerda == 25 then

if vagner[20].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 26 or vagner[20].baixo == 26 or vagner[20].direita == 26 or vagner[20].esquerda == 26 then

if vagner[20].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 27 or vagner[20].baixo == 27 or vagner[20].direita == 27 or vagner[20].esquerda == 27 then

if vagner[20].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 28 or vagner[20].baixo == 28 or vagner[20].direita == 28 or vagner[20].esquerda == 28 then

if vagner[20].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 29 or vagner[20].baixo == 29 or vagner[20].direita == 29 or vagner[20].esquerda == 29 then

if vagner[20].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end

elseif vagner[20].cima == 30 or vagner[20].baixo == 30 or vagner[20].direita == 30 or vagner[20].esquerda == 30 then

if vagner[20].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x+2, y, z)
end
if vagner[20].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x-2, y, z)
end
if vagner[20].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z+2)
end
if vagner[20].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala20.Transform:SetPosition(x, y, z-2)
end
end

if vagner[20].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala20.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[20].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala20.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[20].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala20.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[20].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala20.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[21].nome ~= nil then

if vagner[21].cima == 1 or vagner[21].baixo == 1 or vagner[21].direita == 1 or vagner[21].esquerda == 1 then
 
 if vagner[21].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 2 or vagner[21].baixo == 2 or vagner[21].direita == 2 or vagner[21].esquerda == 2 then
 
if vagner[21].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 3 or vagner[21].baixo == 3 or vagner[21].direita == 3 or vagner[21].esquerda == 3 then

if vagner[21].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 4 or vagner[21].baixo == 4 or vagner[21].direita == 4 or vagner[21].esquerda == 4 then

if vagner[21].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 5 or vagner[21].baixo == 5 or vagner[21].direita == 5 or vagner[21].esquerda == 5 then

if vagner[21].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 6 or vagner[21].baixo == 6 or vagner[21].direita == 6 or vagner[21].esquerda == 6 then

if vagner[21].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 7 or vagner[21].baixo == 7 or vagner[21].direita == 7 or vagner[21].esquerda == 7 then

if vagner[21].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 8 or vagner[21].baixo == 8 or vagner[21].direita == 8 or vagner[21].esquerda == 8 then

if vagner[21].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 9 or vagner[21].baixo == 9 or vagner[21].direita == 9 or vagner[21].esquerda == 9 then

if vagner[21].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 10 or vagner[21].baixo == 10 or vagner[21].direita == 10 or vagner[21].esquerda == 10 then

if vagner[21].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 11 or vagner[21].baixo == 11 or vagner[21].direita == 11 or vagner[21].esquerda == 11 then

if vagner[21].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 12 or vagner[21].baixo == 12 or vagner[21].direita == 12 or vagner[21].esquerda == 12 then

if vagner[21].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 13 or vagner[21].baixo == 13 or vagner[21].direita == 13 or vagner[21].esquerda == 13 then

if vagner[21].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 14 or vagner[21].baixo == 14 or vagner[21].direita == 14 or vagner[21].esquerda == 14 then

if vagner[21].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 15 or vagner[21].baixo == 15 or vagner[21].direita == 15 or vagner[21].esquerda == 15 then

if vagner[21].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 16 or vagner[21].baixo == 16 or vagner[21].direita == 16 or vagner[21].esquerda == 16 then

if vagner[21].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 17 or vagner[21].baixo == 17 or vagner[21].direita == 17 or vagner[21].esquerda == 17 then

if vagner[21].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 18 or vagner[21].baixo == 18 or vagner[21].direita == 18 or vagner[21].esquerda == 18 then

if vagner[21].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 19 or vagner[21].baixo == 19 or vagner[21].direita == 19 or vagner[21].esquerda == 19 then

if vagner[21].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 20 or vagner[21].baixo == 20 or vagner[21].direita == 20 or vagner[21].esquerda == 20 then

if vagner[21].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 21 or vagner[21].baixo == 21 or vagner[21].direita == 21 or vagner[21].esquerda == 21 then

if vagner[21].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 22 or vagner[21].baixo == 22 or vagner[21].direita == 22 or vagner[21].esquerda == 22 then

if vagner[21].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 23 or vagner[21].baixo == 23 or vagner[21].direita == 23 or vagner[21].esquerda == 23 then

if vagner[21].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 24 or vagner[21].baixo == 24 or vagner[21].direita == 24 or vagner[21].esquerda == 24 then

if vagner[21].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 25 or vagner[21].baixo == 25 or vagner[21].direita == 25 or vagner[21].esquerda == 25 then

if vagner[21].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 26 or vagner[21].baixo == 26 or vagner[21].direita == 26 or vagner[21].esquerda == 26 then

if vagner[21].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 27 or vagner[21].baixo == 27 or vagner[21].direita == 27 or vagner[21].esquerda == 27 then

if vagner[21].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 28 or vagner[21].baixo == 28 or vagner[21].direita == 28 or vagner[21].esquerda == 28 then

if vagner[21].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 29 or vagner[21].baixo == 29 or vagner[21].direita == 29 or vagner[21].esquerda == 29 then

if vagner[21].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end

elseif vagner[21].cima == 30 or vagner[21].baixo == 30 or vagner[21].direita == 30 or vagner[21].esquerda == 30 then

if vagner[21].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x+2, y, z)
end
if vagner[21].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x-2, y, z)
end
if vagner[21].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z+2)
end
if vagner[21].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala21.Transform:SetPosition(x, y, z-2)
end
end

if vagner[21].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala21.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[21].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala21.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[21].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala21.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[21].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala21.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[22].nome ~= nil then

if vagner[22].cima == 1 or vagner[22].baixo == 1 or vagner[22].direita == 1 or vagner[22].esquerda == 1 then
 
 if vagner[22].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 2 or vagner[22].baixo == 2 or vagner[22].direita == 2 or vagner[22].esquerda == 2 then
 
if vagner[22].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 3 or vagner[22].baixo == 3 or vagner[22].direita == 3 or vagner[22].esquerda == 3 then

if vagner[22].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 4 or vagner[22].baixo == 4 or vagner[22].direita == 4 or vagner[22].esquerda == 4 then

if vagner[22].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 5 or vagner[22].baixo == 5 or vagner[22].direita == 5 or vagner[22].esquerda == 5 then

if vagner[22].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 6 or vagner[22].baixo == 6 or vagner[22].direita == 6 or vagner[22].esquerda == 6 then

if vagner[22].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 7 or vagner[22].baixo == 7 or vagner[22].direita == 7 or vagner[22].esquerda == 7 then

if vagner[22].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 8 or vagner[22].baixo == 8 or vagner[22].direita == 8 or vagner[22].esquerda == 8 then

if vagner[22].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 9 or vagner[22].baixo == 9 or vagner[22].direita == 9 or vagner[22].esquerda == 9 then

if vagner[22].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 10 or vagner[22].baixo == 10 or vagner[22].direita == 10 or vagner[22].esquerda == 10 then

if vagner[22].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 11 or vagner[22].baixo == 11 or vagner[22].direita == 11 or vagner[22].esquerda == 11 then

if vagner[22].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 12 or vagner[22].baixo == 12 or vagner[22].direita == 12 or vagner[22].esquerda == 12 then

if vagner[22].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 13 or vagner[22].baixo == 13 or vagner[22].direita == 13 or vagner[22].esquerda == 13 then

if vagner[22].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 14 or vagner[22].baixo == 14 or vagner[22].direita == 14 or vagner[22].esquerda == 14 then

if vagner[22].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 15 or vagner[22].baixo == 15 or vagner[22].direita == 15 or vagner[22].esquerda == 15 then

if vagner[22].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 16 or vagner[22].baixo == 16 or vagner[22].direita == 16 or vagner[22].esquerda == 16 then

if vagner[22].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 17 or vagner[22].baixo == 17 or vagner[22].direita == 17 or vagner[22].esquerda == 17 then

if vagner[22].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 18 or vagner[22].baixo == 18 or vagner[22].direita == 18 or vagner[22].esquerda == 18 then

if vagner[22].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 19 or vagner[22].baixo == 19 or vagner[22].direita == 19 or vagner[22].esquerda == 19 then

if vagner[22].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 20 or vagner[22].baixo == 20 or vagner[22].direita == 20 or vagner[22].esquerda == 20 then

if vagner[22].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 21 or vagner[22].baixo == 21 or vagner[22].direita == 21 or vagner[22].esquerda == 21 then

if vagner[22].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 22 or vagner[22].baixo == 22 or vagner[22].direita == 22 or vagner[22].esquerda == 22 then

if vagner[22].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 23 or vagner[22].baixo == 23 or vagner[22].direita == 23 or vagner[22].esquerda == 23 then

if vagner[22].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 24 or vagner[22].baixo == 24 or vagner[22].direita == 24 or vagner[22].esquerda == 24 then

if vagner[22].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 25 or vagner[22].baixo == 25 or vagner[22].direita == 25 or vagner[22].esquerda == 25 then

if vagner[22].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 26 or vagner[22].baixo == 26 or vagner[22].direita == 26 or vagner[22].esquerda == 26 then

if vagner[22].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 27 or vagner[22].baixo == 27 or vagner[22].direita == 27 or vagner[22].esquerda == 27 then

if vagner[22].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 28 or vagner[22].baixo == 28 or vagner[22].direita == 28 or vagner[22].esquerda == 28 then

if vagner[22].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 29 or vagner[22].baixo == 29 or vagner[22].direita == 29 or vagner[22].esquerda == 29 then

if vagner[22].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end

elseif vagner[22].cima == 30 or vagner[22].baixo == 30 or vagner[22].direita == 30 or vagner[22].esquerda == 30 then

if vagner[22].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x+2, y, z)
end
if vagner[22].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x-2, y, z)
end
if vagner[22].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z+2)
end
if vagner[22].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala22.Transform:SetPosition(x, y, z-2)
end
end

if vagner[22].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala22.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[22].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala22.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[22].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala22.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[22].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala22.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[23].nome ~= nil then

if vagner[23].cima == 1 or vagner[23].baixo == 1 or vagner[23].direita == 1 or vagner[23].esquerda == 1 then
 
 if vagner[23].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 2 or vagner[23].baixo == 2 or vagner[23].direita == 2 or vagner[23].esquerda == 2 then
 
if vagner[23].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 3 or vagner[23].baixo == 3 or vagner[23].direita == 3 or vagner[23].esquerda == 3 then

if vagner[23].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 4 or vagner[23].baixo == 4 or vagner[23].direita == 4 or vagner[23].esquerda == 4 then

if vagner[23].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 5 or vagner[23].baixo == 5 or vagner[23].direita == 5 or vagner[23].esquerda == 5 then

if vagner[23].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 6 or vagner[23].baixo == 6 or vagner[23].direita == 6 or vagner[23].esquerda == 6 then

if vagner[23].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 7 or vagner[23].baixo == 7 or vagner[23].direita == 7 or vagner[23].esquerda == 7 then

if vagner[23].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 8 or vagner[23].baixo == 8 or vagner[23].direita == 8 or vagner[23].esquerda == 8 then

if vagner[23].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 9 or vagner[23].baixo == 9 or vagner[23].direita == 9 or vagner[23].esquerda == 9 then

if vagner[23].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 10 or vagner[23].baixo == 10 or vagner[23].direita == 10 or vagner[23].esquerda == 10 then

if vagner[23].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 11 or vagner[23].baixo == 11 or vagner[23].direita == 11 or vagner[23].esquerda == 11 then

if vagner[23].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 12 or vagner[23].baixo == 12 or vagner[23].direita == 12 or vagner[23].esquerda == 12 then

if vagner[23].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 13 or vagner[23].baixo == 13 or vagner[23].direita == 13 or vagner[23].esquerda == 13 then

if vagner[23].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 14 or vagner[23].baixo == 14 or vagner[23].direita == 14 or vagner[23].esquerda == 14 then

if vagner[23].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 15 or vagner[23].baixo == 15 or vagner[23].direita == 15 or vagner[23].esquerda == 15 then

if vagner[23].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 16 or vagner[23].baixo == 16 or vagner[23].direita == 16 or vagner[23].esquerda == 16 then

if vagner[23].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 17 or vagner[23].baixo == 17 or vagner[23].direita == 17 or vagner[23].esquerda == 17 then

if vagner[23].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 18 or vagner[23].baixo == 18 or vagner[23].direita == 18 or vagner[23].esquerda == 18 then

if vagner[23].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 19 or vagner[23].baixo == 19 or vagner[23].direita == 19 or vagner[23].esquerda == 19 then

if vagner[23].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 20 or vagner[23].baixo == 20 or vagner[23].direita == 20 or vagner[23].esquerda == 20 then

if vagner[23].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 21 or vagner[23].baixo == 21 or vagner[23].direita == 21 or vagner[23].esquerda == 21 then

if vagner[23].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 22 or vagner[23].baixo == 22 or vagner[23].direita == 22 or vagner[23].esquerda == 22 then

if vagner[23].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 23 or vagner[23].baixo == 23 or vagner[23].direita == 23 or vagner[23].esquerda == 23 then

if vagner[23].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 24 or vagner[23].baixo == 24 or vagner[23].direita == 24 or vagner[23].esquerda == 24 then

if vagner[23].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 25 or vagner[23].baixo == 25 or vagner[23].direita == 25 or vagner[23].esquerda == 25 then

if vagner[23].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 26 or vagner[23].baixo == 26 or vagner[23].direita == 26 or vagner[23].esquerda == 26 then

if vagner[23].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 27 or vagner[23].baixo == 27 or vagner[23].direita == 27 or vagner[23].esquerda == 27 then

if vagner[23].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 28 or vagner[23].baixo == 28 or vagner[23].direita == 28 or vagner[23].esquerda == 28 then

if vagner[23].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 29 or vagner[23].baixo == 29 or vagner[23].direita == 29 or vagner[23].esquerda == 29 then

if vagner[23].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end

elseif vagner[23].cima == 30 or vagner[23].baixo == 30 or vagner[23].direita == 30 or vagner[23].esquerda == 30 then

if vagner[23].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x+2, y, z)
end
if vagner[23].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x-2, y, z)
end
if vagner[23].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z+2)
end
if vagner[23].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala23.Transform:SetPosition(x, y, z-2)
end
end

if vagner[23].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala23.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[23].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala23.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[23].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala23.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[23].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala23.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[24].nome ~= nil then

if vagner[24].cima == 1 or vagner[24].baixo == 1 or vagner[24].direita == 1 or vagner[24].esquerda == 1 then
 
 if vagner[24].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 2 or vagner[24].baixo == 2 or vagner[24].direita == 2 or vagner[24].esquerda == 2 then
 
if vagner[24].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 3 or vagner[24].baixo == 3 or vagner[24].direita == 3 or vagner[24].esquerda == 3 then

if vagner[24].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 4 or vagner[24].baixo == 4 or vagner[24].direita == 4 or vagner[24].esquerda == 4 then

if vagner[24].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 5 or vagner[24].baixo == 5 or vagner[24].direita == 5 or vagner[24].esquerda == 5 then

if vagner[24].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 6 or vagner[24].baixo == 6 or vagner[24].direita == 6 or vagner[24].esquerda == 6 then

if vagner[24].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 7 or vagner[24].baixo == 7 or vagner[24].direita == 7 or vagner[24].esquerda == 7 then

if vagner[24].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 8 or vagner[24].baixo == 8 or vagner[24].direita == 8 or vagner[24].esquerda == 8 then

if vagner[24].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 9 or vagner[24].baixo == 9 or vagner[24].direita == 9 or vagner[24].esquerda == 9 then

if vagner[24].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 10 or vagner[24].baixo == 10 or vagner[24].direita == 10 or vagner[24].esquerda == 10 then

if vagner[24].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 11 or vagner[24].baixo == 11 or vagner[24].direita == 11 or vagner[24].esquerda == 11 then

if vagner[24].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 12 or vagner[24].baixo == 12 or vagner[24].direita == 12 or vagner[24].esquerda == 12 then

if vagner[24].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 13 or vagner[24].baixo == 13 or vagner[24].direita == 13 or vagner[24].esquerda == 13 then

if vagner[24].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 14 or vagner[24].baixo == 14 or vagner[24].direita == 14 or vagner[24].esquerda == 14 then

if vagner[24].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 15 or vagner[24].baixo == 15 or vagner[24].direita == 15 or vagner[24].esquerda == 15 then

if vagner[24].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 16 or vagner[24].baixo == 16 or vagner[24].direita == 16 or vagner[24].esquerda == 16 then

if vagner[24].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 17 or vagner[24].baixo == 17 or vagner[24].direita == 17 or vagner[24].esquerda == 17 then

if vagner[24].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 18 or vagner[24].baixo == 18 or vagner[24].direita == 18 or vagner[24].esquerda == 18 then

if vagner[24].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 19 or vagner[24].baixo == 19 or vagner[24].direita == 19 or vagner[24].esquerda == 19 then

if vagner[24].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 24 or vagner[24].baixo == 24 or vagner[24].direita == 24 or vagner[24].esquerda == 20 then

if vagner[24].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 21 or vagner[24].baixo == 21 or vagner[24].direita == 21 or vagner[24].esquerda == 21 then

if vagner[24].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 22 or vagner[24].baixo == 22 or vagner[24].direita == 22 or vagner[24].esquerda == 22 then

if vagner[24].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 23 or vagner[24].baixo == 23 or vagner[24].direita == 23 or vagner[24].esquerda == 23 then

if vagner[24].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 24 or vagner[24].baixo == 24 or vagner[24].direita == 24 or vagner[24].esquerda == 24 then

if vagner[24].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 25 or vagner[24].baixo == 25 or vagner[24].direita == 25 or vagner[24].esquerda == 25 then

if vagner[24].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 26 or vagner[24].baixo == 26 or vagner[24].direita == 26 or vagner[24].esquerda == 26 then

if vagner[24].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 27 or vagner[24].baixo == 27 or vagner[24].direita == 27 or vagner[24].esquerda == 27 then

if vagner[24].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 28 or vagner[24].baixo == 28 or vagner[24].direita == 28 or vagner[24].esquerda == 28 then

if vagner[24].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 29 or vagner[24].baixo == 29 or vagner[24].direita == 29 or vagner[24].esquerda == 29 then

if vagner[24].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end

elseif vagner[24].cima == 30 or vagner[24].baixo == 30 or vagner[24].direita == 30 or vagner[24].esquerda == 30 then

if vagner[24].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x+2, y, z)
end
if vagner[24].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x-2, y, z)
end
if vagner[24].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z+2)
end
if vagner[24].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala24.Transform:SetPosition(x, y, z-2)
end
end

if vagner[24].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala24.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[24].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala24.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[24].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala24.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[24].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala24.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end


----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[25].nome ~= nil then

if vagner[25].cima == 1 or vagner[25].baixo == 1 or vagner[25].direita == 1 or vagner[25].esquerda == 1 then
 
 if vagner[25].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 2 or vagner[25].baixo == 2 or vagner[25].direita == 2 or vagner[25].esquerda == 2 then
 
if vagner[25].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 3 or vagner[25].baixo == 3 or vagner[25].direita == 3 or vagner[25].esquerda == 3 then

if vagner[25].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 4 or vagner[25].baixo == 4 or vagner[25].direita == 4 or vagner[25].esquerda == 4 then

if vagner[25].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 5 or vagner[25].baixo == 5 or vagner[25].direita == 5 or vagner[25].esquerda == 5 then

if vagner[25].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 6 or vagner[25].baixo == 6 or vagner[25].direita == 6 or vagner[25].esquerda == 6 then

if vagner[25].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 7 or vagner[25].baixo == 7 or vagner[25].direita == 7 or vagner[25].esquerda == 7 then

if vagner[25].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 8 or vagner[25].baixo == 8 or vagner[25].direita == 8 or vagner[25].esquerda == 8 then

if vagner[25].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 9 or vagner[25].baixo == 9 or vagner[25].direita == 9 or vagner[25].esquerda == 9 then

if vagner[25].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 10 or vagner[25].baixo == 10 or vagner[25].direita == 10 or vagner[25].esquerda == 10 then

if vagner[25].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 11 or vagner[25].baixo == 11 or vagner[25].direita == 11 or vagner[25].esquerda == 11 then

if vagner[25].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 12 or vagner[25].baixo == 12 or vagner[25].direita == 12 or vagner[25].esquerda == 12 then

if vagner[25].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 13 or vagner[25].baixo == 13 or vagner[25].direita == 13 or vagner[25].esquerda == 13 then

if vagner[25].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 14 or vagner[25].baixo == 14 or vagner[25].direita == 14 or vagner[25].esquerda == 14 then

if vagner[25].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 15 or vagner[25].baixo == 15 or vagner[25].direita == 15 or vagner[25].esquerda == 15 then

if vagner[25].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 16 or vagner[25].baixo == 16 or vagner[25].direita == 16 or vagner[25].esquerda == 16 then

if vagner[25].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 17 or vagner[25].baixo == 17 or vagner[25].direita == 17 or vagner[25].esquerda == 17 then

if vagner[25].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 18 or vagner[25].baixo == 18 or vagner[25].direita == 18 or vagner[25].esquerda == 18 then

if vagner[25].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 19 or vagner[25].baixo == 19 or vagner[25].direita == 19 or vagner[25].esquerda == 19 then

if vagner[25].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 20 or vagner[25].baixo == 20 or vagner[25].direita == 20 or vagner[25].esquerda == 20 then

if vagner[25].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 21 or vagner[25].baixo == 21 or vagner[25].direita == 21 or vagner[25].esquerda == 21 then

if vagner[25].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 22 or vagner[25].baixo == 22 or vagner[25].direita == 22 or vagner[25].esquerda == 22 then

if vagner[25].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 23 or vagner[25].baixo == 23 or vagner[25].direita == 23 or vagner[25].esquerda == 23 then

if vagner[25].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 24 or vagner[25].baixo == 24 or vagner[25].direita == 24 or vagner[25].esquerda == 24 then

if vagner[25].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 25 or vagner[25].baixo == 25 or vagner[25].direita == 25 or vagner[25].esquerda == 25 then

if vagner[25].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 26 or vagner[25].baixo == 26 or vagner[25].direita == 26 or vagner[25].esquerda == 26 then

if vagner[25].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 27 or vagner[25].baixo == 27 or vagner[25].direita == 27 or vagner[25].esquerda == 27 then

if vagner[25].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 28 or vagner[25].baixo == 28 or vagner[25].direita == 28 or vagner[25].esquerda == 28 then

if vagner[25].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 29 or vagner[25].baixo == 29 or vagner[25].direita == 29 or vagner[25].esquerda == 29 then

if vagner[25].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end

elseif vagner[25].cima == 30 or vagner[25].baixo == 30 or vagner[25].direita == 30 or vagner[25].esquerda == 30 then

if vagner[25].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x+2, y, z)
end
if vagner[25].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x-2, y, z)
end
if vagner[25].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z+2)
end
if vagner[25].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala25.Transform:SetPosition(x, y, z-2)
end
end

if vagner[25].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala25.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[25].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala25.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[25].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala25.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[25].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala25.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[26].nome ~= nil then

if vagner[26].cima == 1 or vagner[26].baixo == 1 or vagner[26].direita == 1 or vagner[26].esquerda == 1 then
 
 if vagner[26].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 2 or vagner[26].baixo == 2 or vagner[26].direita == 2 or vagner[26].esquerda == 2 then
 
if vagner[26].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 3 or vagner[26].baixo == 3 or vagner[26].direita == 3 or vagner[26].esquerda == 3 then

if vagner[26].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 4 or vagner[26].baixo == 4 or vagner[26].direita == 4 or vagner[26].esquerda == 4 then

if vagner[26].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 5 or vagner[26].baixo == 5 or vagner[26].direita == 5 or vagner[26].esquerda == 5 then

if vagner[26].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 6 or vagner[26].baixo == 6 or vagner[26].direita == 6 or vagner[26].esquerda == 6 then

if vagner[26].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 7 or vagner[26].baixo == 7 or vagner[26].direita == 7 or vagner[26].esquerda == 7 then

if vagner[26].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 8 or vagner[26].baixo == 8 or vagner[26].direita == 8 or vagner[26].esquerda == 8 then

if vagner[26].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 9 or vagner[26].baixo == 9 or vagner[26].direita == 9 or vagner[26].esquerda == 9 then

if vagner[26].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 10 or vagner[26].baixo == 10 or vagner[26].direita == 10 or vagner[26].esquerda == 10 then

if vagner[26].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 11 or vagner[26].baixo == 11 or vagner[26].direita == 11 or vagner[26].esquerda == 11 then

if vagner[26].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 12 or vagner[26].baixo == 12 or vagner[26].direita == 12 or vagner[26].esquerda == 12 then

if vagner[26].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 13 or vagner[26].baixo == 13 or vagner[26].direita == 13 or vagner[26].esquerda == 13 then

if vagner[26].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 14 or vagner[26].baixo == 14 or vagner[26].direita == 14 or vagner[26].esquerda == 14 then

if vagner[26].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 15 or vagner[26].baixo == 15 or vagner[26].direita == 15 or vagner[26].esquerda == 15 then

if vagner[26].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 16 or vagner[26].baixo == 16 or vagner[26].direita == 16 or vagner[26].esquerda == 16 then

if vagner[26].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 17 or vagner[26].baixo == 17 or vagner[26].direita == 17 or vagner[26].esquerda == 17 then

if vagner[26].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 18 or vagner[26].baixo == 18 or vagner[26].direita == 18 or vagner[26].esquerda == 18 then

if vagner[26].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 19 or vagner[26].baixo == 19 or vagner[26].direita == 19 or vagner[26].esquerda == 19 then

if vagner[26].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 20 or vagner[26].baixo == 20 or vagner[26].direita == 20 or vagner[26].esquerda == 20 then

if vagner[26].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 21 or vagner[26].baixo == 21 or vagner[26].direita == 21 or vagner[26].esquerda == 21 then

if vagner[26].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 22 or vagner[26].baixo == 22 or vagner[26].direita == 22 or vagner[26].esquerda == 22 then

if vagner[26].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 23 or vagner[26].baixo == 23 or vagner[26].direita == 23 or vagner[26].esquerda == 23 then

if vagner[26].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 24 or vagner[26].baixo == 24 or vagner[26].direita == 24 or vagner[26].esquerda == 24 then

if vagner[26].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 25 or vagner[26].baixo == 25 or vagner[26].direita == 25 or vagner[26].esquerda == 25 then

if vagner[26].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 26 or vagner[26].baixo == 26 or vagner[26].direita == 26 or vagner[26].esquerda == 26 then

if vagner[26].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 27 or vagner[26].baixo == 27 or vagner[26].direita == 27 or vagner[26].esquerda == 27 then

if vagner[26].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 28 or vagner[26].baixo == 28 or vagner[26].direita == 28 or vagner[26].esquerda == 28 then

if vagner[26].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 29 or vagner[26].baixo == 29 or vagner[26].direita == 29 or vagner[26].esquerda == 29 then

if vagner[26].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end

elseif vagner[26].cima == 30 or vagner[26].baixo == 30 or vagner[26].direita == 30 or vagner[26].esquerda == 30 then

if vagner[26].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x+2, y, z)
end
if vagner[26].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x-2, y, z)
end
if vagner[26].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z+2)
end
if vagner[26].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala26.Transform:SetPosition(x, y, z-2)
end
end

if vagner[26].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala26.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[26].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala26.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[26].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala26.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[26].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala26.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[27].nome ~= nil then

if vagner[27].cima == 1 or vagner[27].baixo == 1 or vagner[27].direita == 1 or vagner[27].esquerda == 1 then
 
 if vagner[27].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 2 or vagner[27].baixo == 2 or vagner[27].direita == 2 or vagner[27].esquerda == 2 then
 
if vagner[27].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 3 or vagner[27].baixo == 3 or vagner[27].direita == 3 or vagner[27].esquerda == 3 then

if vagner[27].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 4 or vagner[27].baixo == 4 or vagner[27].direita == 4 or vagner[27].esquerda == 4 then

if vagner[27].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 5 or vagner[27].baixo == 5 or vagner[27].direita == 5 or vagner[27].esquerda == 5 then

if vagner[27].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 6 or vagner[27].baixo == 6 or vagner[27].direita == 6 or vagner[27].esquerda == 6 then

if vagner[27].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 7 or vagner[27].baixo == 7 or vagner[27].direita == 7 or vagner[27].esquerda == 7 then

if vagner[27].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 8 or vagner[27].baixo == 8 or vagner[27].direita == 8 or vagner[27].esquerda == 8 then

if vagner[27].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 9 or vagner[27].baixo == 9 or vagner[27].direita == 9 or vagner[27].esquerda == 9 then

if vagner[27].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 10 or vagner[27].baixo == 10 or vagner[27].direita == 10 or vagner[27].esquerda == 10 then

if vagner[27].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 11 or vagner[27].baixo == 11 or vagner[27].direita == 11 or vagner[27].esquerda == 11 then

if vagner[27].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 12 or vagner[27].baixo == 12 or vagner[27].direita == 12 or vagner[27].esquerda == 12 then

if vagner[27].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 13 or vagner[27].baixo == 13 or vagner[27].direita == 13 or vagner[27].esquerda == 13 then

if vagner[27].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 14 or vagner[27].baixo == 14 or vagner[27].direita == 14 or vagner[27].esquerda == 14 then

if vagner[27].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 15 or vagner[27].baixo == 15 or vagner[27].direita == 15 or vagner[27].esquerda == 15 then

if vagner[27].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 16 or vagner[27].baixo == 16 or vagner[27].direita == 16 or vagner[27].esquerda == 16 then

if vagner[27].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 17 or vagner[27].baixo == 17 or vagner[27].direita == 17 or vagner[27].esquerda == 17 then

if vagner[27].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 18 or vagner[27].baixo == 18 or vagner[27].direita == 18 or vagner[27].esquerda == 18 then

if vagner[27].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 19 or vagner[27].baixo == 19 or vagner[27].direita == 19 or vagner[27].esquerda == 19 then

if vagner[27].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 20 or vagner[27].baixo == 20 or vagner[27].direita == 20 or vagner[27].esquerda == 20 then

if vagner[27].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 21 or vagner[27].baixo == 21 or vagner[27].direita == 21 or vagner[27].esquerda == 21 then

if vagner[27].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 22 or vagner[27].baixo == 22 or vagner[27].direita == 22 or vagner[27].esquerda == 22 then

if vagner[27].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 23 or vagner[27].baixo == 23 or vagner[27].direita == 23 or vagner[27].esquerda == 23 then

if vagner[27].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 24 or vagner[27].baixo == 24 or vagner[27].direita == 24 or vagner[27].esquerda == 24 then

if vagner[27].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 25 or vagner[27].baixo == 25 or vagner[27].direita == 25 or vagner[27].esquerda == 25 then

if vagner[27].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 26 or vagner[27].baixo == 26 or vagner[27].direita == 26 or vagner[27].esquerda == 26 then

if vagner[27].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 27 or vagner[27].baixo == 27 or vagner[27].direita == 27 or vagner[27].esquerda == 27 then

if vagner[27].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 28 or vagner[27].baixo == 28 or vagner[27].direita == 28 or vagner[27].esquerda == 28 then

if vagner[27].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 29 or vagner[27].baixo == 29 or vagner[27].direita == 29 or vagner[27].esquerda == 29 then

if vagner[27].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end

elseif vagner[27].cima == 30 or vagner[27].baixo == 30 or vagner[27].direita == 30 or vagner[27].esquerda == 30 then

if vagner[27].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x+2, y, z)
end
if vagner[27].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x-2, y, z)
end
if vagner[27].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z+2)
end
if vagner[27].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala27.Transform:SetPosition(x, y, z-2)
end
end

if vagner[27].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala27.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[27].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala27.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[27].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala27.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[27].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala27.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[28].nome ~= nil then

if vagner[28].cima == 1 or vagner[28].baixo == 1 or vagner[28].direita == 1 or vagner[28].esquerda == 1 then
 
 if vagner[28].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 2 or vagner[28].baixo == 2 or vagner[28].direita == 2 or vagner[28].esquerda == 2 then
 
if vagner[28].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 3 or vagner[28].baixo == 3 or vagner[28].direita == 3 or vagner[28].esquerda == 3 then

if vagner[28].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 4 or vagner[28].baixo == 4 or vagner[28].direita == 4 or vagner[28].esquerda == 4 then

if vagner[28].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 5 or vagner[28].baixo == 5 or vagner[28].direita == 5 or vagner[28].esquerda == 5 then

if vagner[28].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 6 or vagner[28].baixo == 6 or vagner[28].direita == 6 or vagner[28].esquerda == 6 then

if vagner[28].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 7 or vagner[28].baixo == 7 or vagner[28].direita == 7 or vagner[28].esquerda == 7 then

if vagner[28].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 8 or vagner[28].baixo == 8 or vagner[28].direita == 8 or vagner[28].esquerda == 8 then

if vagner[28].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 9 or vagner[28].baixo == 9 or vagner[28].direita == 9 or vagner[28].esquerda == 9 then

if vagner[28].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 10 or vagner[28].baixo == 10 or vagner[28].direita == 10 or vagner[28].esquerda == 10 then

if vagner[28].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 11 or vagner[28].baixo == 11 or vagner[28].direita == 11 or vagner[28].esquerda == 11 then

if vagner[28].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 12 or vagner[28].baixo == 12 or vagner[28].direita == 12 or vagner[28].esquerda == 12 then

if vagner[28].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 13 or vagner[28].baixo == 13 or vagner[28].direita == 13 or vagner[28].esquerda == 13 then

if vagner[28].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 14 or vagner[28].baixo == 14 or vagner[28].direita == 14 or vagner[28].esquerda == 14 then

if vagner[28].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 15 or vagner[28].baixo == 15 or vagner[28].direita == 15 or vagner[28].esquerda == 15 then

if vagner[28].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 16 or vagner[28].baixo == 16 or vagner[28].direita == 16 or vagner[28].esquerda == 16 then

if vagner[28].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 17 or vagner[28].baixo == 17 or vagner[28].direita == 17 or vagner[28].esquerda == 17 then

if vagner[28].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 18 or vagner[28].baixo == 18 or vagner[28].direita == 18 or vagner[28].esquerda == 18 then

if vagner[28].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 19 or vagner[28].baixo == 19 or vagner[28].direita == 19 or vagner[28].esquerda == 19 then

if vagner[28].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 20 or vagner[28].baixo == 20 or vagner[28].direita == 20 or vagner[28].esquerda == 20 then

if vagner[28].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 21 or vagner[28].baixo == 21 or vagner[28].direita == 21 or vagner[28].esquerda == 21 then

if vagner[28].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 22 or vagner[28].baixo == 22 or vagner[28].direita == 22 or vagner[28].esquerda == 22 then

if vagner[28].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 23 or vagner[28].baixo == 23 or vagner[28].direita == 23 or vagner[28].esquerda == 23 then

if vagner[28].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 24 or vagner[28].baixo == 24 or vagner[28].direita == 24 or vagner[28].esquerda == 24 then

if vagner[28].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 25 or vagner[28].baixo == 25 or vagner[28].direita == 25 or vagner[28].esquerda == 25 then

if vagner[28].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 26 or vagner[28].baixo == 26 or vagner[28].direita == 26 or vagner[28].esquerda == 26 then

if vagner[28].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 27 or vagner[28].baixo == 27 or vagner[28].direita == 27 or vagner[28].esquerda == 27 then

if vagner[28].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 28 or vagner[28].baixo == 28 or vagner[28].direita == 28 or vagner[28].esquerda == 28 then

if vagner[28].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 29 or vagner[28].baixo == 29 or vagner[28].direita == 29 or vagner[28].esquerda == 29 then

if vagner[28].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end

elseif vagner[28].cima == 30 or vagner[28].baixo == 30 or vagner[28].direita == 30 or vagner[28].esquerda == 30 then

if vagner[28].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x+2, y, z)
end
if vagner[28].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x-2, y, z)
end
if vagner[28].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z+2)
end
if vagner[28].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala28.Transform:SetPosition(x, y, z-2)
end
end

if vagner[28].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala28.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[28].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala28.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[28].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala28.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[28].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala28.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[29].nome ~= nil then

if vagner[29].cima == 1 or vagner[29].baixo == 1 or vagner[29].direita == 1 or vagner[29].esquerda == 1 then
 
 if vagner[29].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 2 or vagner[29].baixo == 2 or vagner[29].direita == 2 or vagner[29].esquerda == 2 then
 
if vagner[29].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 3 or vagner[29].baixo == 3 or vagner[29].direita == 3 or vagner[29].esquerda == 3 then

if vagner[29].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 4 or vagner[29].baixo == 4 or vagner[29].direita == 4 or vagner[29].esquerda == 4 then

if vagner[29].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 5 or vagner[29].baixo == 5 or vagner[29].direita == 5 or vagner[29].esquerda == 5 then

if vagner[29].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 6 or vagner[29].baixo == 6 or vagner[29].direita == 6 or vagner[29].esquerda == 6 then

if vagner[29].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 7 or vagner[29].baixo == 7 or vagner[29].direita == 7 or vagner[29].esquerda == 7 then

if vagner[29].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 8 or vagner[29].baixo == 8 or vagner[29].direita == 8 or vagner[29].esquerda == 8 then

if vagner[29].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 9 or vagner[29].baixo == 9 or vagner[29].direita == 9 or vagner[29].esquerda == 9 then

if vagner[29].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 10 or vagner[29].baixo == 10 or vagner[29].direita == 10 or vagner[29].esquerda == 10 then

if vagner[29].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 11 or vagner[29].baixo == 11 or vagner[29].direita == 11 or vagner[29].esquerda == 11 then

if vagner[29].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 12 or vagner[29].baixo == 12 or vagner[29].direita == 12 or vagner[29].esquerda == 12 then

if vagner[29].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 13 or vagner[29].baixo == 13 or vagner[29].direita == 13 or vagner[29].esquerda == 13 then

if vagner[29].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 14 or vagner[29].baixo == 14 or vagner[29].direita == 14 or vagner[29].esquerda == 14 then

if vagner[29].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 15 or vagner[29].baixo == 15 or vagner[29].direita == 15 or vagner[29].esquerda == 15 then

if vagner[29].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 16 or vagner[29].baixo == 16 or vagner[29].direita == 16 or vagner[29].esquerda == 16 then

if vagner[29].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 17 or vagner[29].baixo == 17 or vagner[29].direita == 17 or vagner[29].esquerda == 17 then

if vagner[29].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 18 or vagner[29].baixo == 18 or vagner[29].direita == 18 or vagner[29].esquerda == 18 then

if vagner[29].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 19 or vagner[29].baixo == 19 or vagner[29].direita == 19 or vagner[29].esquerda == 19 then

if vagner[29].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 20 or vagner[29].baixo == 20 or vagner[29].direita == 20 or vagner[29].esquerda == 20 then

if vagner[29].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 21 or vagner[29].baixo == 21 or vagner[29].direita == 21 or vagner[29].esquerda == 21 then

if vagner[29].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 22 or vagner[29].baixo == 22 or vagner[29].direita == 22 or vagner[29].esquerda == 22 then

if vagner[29].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 23 or vagner[29].baixo == 23 or vagner[29].direita == 23 or vagner[29].esquerda == 23 then

if vagner[29].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 24 or vagner[29].baixo == 24 or vagner[29].direita == 24 or vagner[29].esquerda == 24 then

if vagner[29].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 25 or vagner[29].baixo == 25 or vagner[29].direita == 25 or vagner[29].esquerda == 25 then

if vagner[29].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 26 or vagner[29].baixo == 26 or vagner[29].direita == 26 or vagner[29].esquerda == 26 then

if vagner[29].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 27 or vagner[29].baixo == 27 or vagner[29].direita == 27 or vagner[29].esquerda == 27 then

if vagner[29].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 28 or vagner[29].baixo == 28 or vagner[29].direita == 28 or vagner[29].esquerda == 28 then

if vagner[29].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 29 or vagner[29].baixo == 29 or vagner[29].direita == 29 or vagner[29].esquerda == 29 then

if vagner[29].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end

elseif vagner[29].cima == 30 or vagner[29].baixo == 30 or vagner[29].direita == 30 or vagner[29].esquerda == 30 then

if vagner[29].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x+2, y, z)
end
if vagner[29].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x-2, y, z)
end
if vagner[29].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z+2)
end
if vagner[29].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala29.Transform:SetPosition(x, y, z-2)
end
end

if vagner[29].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala29.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[29].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala29.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[29].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala29.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[29].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala29.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

if vagner[30].nome ~= nil then

if vagner[30].cima == 1 or vagner[30].baixo == 1 or vagner[30].direita == 1 or vagner[30].esquerda == 1 then
 
 if vagner[30].cima == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 1 then
local x, y, z = sala1.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 2 or vagner[30].baixo == 2 or vagner[30].direita == 2 or vagner[30].esquerda == 2 then
 
if vagner[30].cima == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 2 then
local x, y, z = sala2.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 3 or vagner[30].baixo == 3 or vagner[30].direita == 3 or vagner[30].esquerda == 3 then

if vagner[30].cima == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 3 then
local x, y, z = sala3.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 4 or vagner[30].baixo == 4 or vagner[30].direita == 4 or vagner[30].esquerda == 4 then

if vagner[30].cima == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 4 then
local x, y, z = sala4.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 5 or vagner[30].baixo == 5 or vagner[30].direita == 5 or vagner[30].esquerda == 5 then

if vagner[30].cima == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 5 then
local x, y, z = sala5.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 6 or vagner[30].baixo == 6 or vagner[30].direita == 6 or vagner[30].esquerda == 6 then

if vagner[30].cima == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 6 then
local x, y, z = sala6.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 7 or vagner[30].baixo == 7 or vagner[30].direita == 7 or vagner[30].esquerda == 7 then

if vagner[30].cima == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 7 then
local x, y, z = sala7.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 8 or vagner[30].baixo == 8 or vagner[30].direita == 8 or vagner[30].esquerda == 8 then

if vagner[30].cima == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 8 then
local x, y, z = sala8.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 9 or vagner[30].baixo == 9 or vagner[30].direita == 9 or vagner[30].esquerda == 9 then

if vagner[30].cima == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 9 then
local x, y, z = sala9.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 10 or vagner[30].baixo == 10 or vagner[30].direita == 10 or vagner[30].esquerda == 10 then

if vagner[30].cima == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 10 then
local x, y, z = sala10.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 11 or vagner[30].baixo == 11 or vagner[30].direita == 11 or vagner[30].esquerda == 11 then

if vagner[30].cima == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 11 then
local x, y, z = sala11.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 12 or vagner[30].baixo == 12 or vagner[30].direita == 12 or vagner[30].esquerda == 12 then

if vagner[30].cima == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 12 then
local x, y, z = sala12.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 13 or vagner[30].baixo == 13 or vagner[30].direita == 13 or vagner[30].esquerda == 13 then

if vagner[30].cima == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 13 then
local x, y, z = sala13.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 14 or vagner[30].baixo == 14 or vagner[30].direita == 14 or vagner[30].esquerda == 14 then

if vagner[30].cima == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 14 then
local x, y, z = sala14.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 15 or vagner[30].baixo == 15 or vagner[30].direita == 15 or vagner[30].esquerda == 15 then

if vagner[30].cima == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 15 then
local x, y, z = sala15.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 16 or vagner[30].baixo == 16 or vagner[30].direita == 16 or vagner[30].esquerda == 16 then

if vagner[30].cima == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 16 then
local x, y, z = sala16.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 17 or vagner[30].baixo == 17 or vagner[30].direita == 17 or vagner[30].esquerda == 17 then

if vagner[30].cima == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 17 then
local x, y, z = sala17.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 18 or vagner[30].baixo == 18 or vagner[30].direita == 18 or vagner[30].esquerda == 18 then

if vagner[30].cima == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 18 then
local x, y, z = sala18.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 19 or vagner[30].baixo == 19 or vagner[30].direita == 19 or vagner[30].esquerda == 19 then

if vagner[30].cima == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 19 then
local x, y, z = sala19.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 20 or vagner[30].baixo == 20 or vagner[30].direita == 20 or vagner[30].esquerda == 20 then

if vagner[30].cima == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 20 then
local x, y, z = sala20.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 21 or vagner[30].baixo == 21 or vagner[30].direita == 21 or vagner[30].esquerda == 21 then

if vagner[30].cima == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 21 then
local x, y, z = sala21.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 22 or vagner[30].baixo == 22 or vagner[30].direita == 22 or vagner[30].esquerda == 22 then

if vagner[30].cima == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 22 then
local x, y, z = sala22.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 23 or vagner[30].baixo == 23 or vagner[30].direita == 23 or vagner[30].esquerda == 23 then

if vagner[30].cima == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 23 then
local x, y, z = sala23.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 24 or vagner[30].baixo == 24 or vagner[30].direita == 24 or vagner[30].esquerda == 24 then

if vagner[30].cima == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 24 then
local x, y, z = sala24.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 25 or vagner[30].baixo == 30 or vagner[30].direita == 25 or vagner[30].esquerda == 25 then

if vagner[30].cima == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 25 then
local x, y, z = sala25.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 26 or vagner[30].baixo == 26 or vagner[30].direita == 26 or vagner[30].esquerda == 26 then

if vagner[30].cima == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 26 then
local x, y, z = sala26.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 27 or vagner[30].baixo == 27 or vagner[30].direita == 27 or vagner[30].esquerda == 27 then

if vagner[30].cima == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 27 then
local x, y, z = sala27.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 28 or vagner[30].baixo == 28 or vagner[30].direita == 28 or vagner[30].esquerda == 28 then

if vagner[30].cima == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 28 then
local x, y, z = sala28.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 29 or vagner[30].baixo == 29 or vagner[30].direita == 29 or vagner[30].esquerda == 29 then

if vagner[30].cima == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 29 then
local x, y, z = sala29.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end

elseif vagner[30].cima == 30 or vagner[30].baixo == 30 or vagner[30].direita == 30 or vagner[30].esquerda == 30 then

if vagner[30].cima == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x+2, y, z)
end
if vagner[30].baixo == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x-2, y, z)
end
if vagner[30].esquerda == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z+2)
end
if vagner[30].direita == 30 then
local x, y, z = sala30.Transform:GetWorldPosition()
sala30.Transform:SetPosition(x, y, z-2)
end
end

if vagner[30].cima ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala30.Transform:GetWorldPosition()
porta.Transform:SetPosition(x - 1, y, z)
end
---
if vagner[30].baixo ~= nil then 
local porta = SpawnPrefab("setacima")
local x, y, z = sala30.Transform:GetWorldPosition()
porta.Transform:SetPosition(x + 1, y, z)
end
---
if vagner[30].esquerda ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala30.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z-1)
end
---
if vagner[30].direita ~= nil then 
local porta = SpawnPrefab("setalado")
local x, y, z = sala30.Transform:GetWorldPosition()
porta.Transform:SetPosition(x, y, z+1)
end
end
