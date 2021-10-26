local assets =
{
    Asset("SOUND", "sound/forest.fsb"),
}

local prefabs = 
{
	"windtrail",
}



local function OnInit(inst)

----------------bloco 1-----------------------------
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local barco = SpawnPrefab("lilypad")
if barco then
barco.Transform:SetPosition(x, 0, z)
end
local colocaitem = SpawnPrefab("beequeenhivegrown")
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0
----------------bloco 2-----------------------------
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then
local barco = SpawnPrefab("lilypad")
if barco then
barco.Transform:SetPosition(x, 0, z)
end
local colocaitem = SpawnPrefab("pigking") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end
local tocha = SpawnPrefab("pigtorch")
if tocha then
tocha.Transform:SetPosition(x+2, 0, z)
end
local tocha = SpawnPrefab("pigtorch")
if tocha then
tocha.Transform:SetPosition(x-2, 0, z)
end
local tocha = SpawnPrefab("pigtorch")
if tocha then
tocha.Transform:SetPosition(x, 0, z+2)
end
local tocha = SpawnPrefab("pigtorch")
if tocha then
tocha.Transform:SetPosition(x, 0, z-2)
end

numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0
----------------bloco 3-----------------------------
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local barco = SpawnPrefab("lilypad")
if barco then
barco.Transform:SetPosition(x, 0, z)
end
local colocaitem = SpawnPrefab("klaus_sack") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end

numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0
----------------bloco 4-----------------------------
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 10

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local barco = SpawnPrefab("boat")
if barco then
barco.Transform:SetPosition(x, 0, z)
end
local colocaitem = SpawnPrefab("pighouse") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end

numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

----------------bloco 5-----------------------------
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 10

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local barco = SpawnPrefab("boat")
if barco then
barco.Transform:SetPosition(x, 0, z)
end
local colocaitem = SpawnPrefab("rabbithouse") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end

numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

----------------bloco 7-----------------------------
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local colocaitem = SpawnPrefab("tigershark") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end

numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

----------------bloco 8-----------------------------
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 11

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local colocaitem = SpawnPrefab("whale_bluefinal") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end

numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

inst:Remove()
end


local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()

	inst:AddTag("NOCLICK")

	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end

    inst:DoTaskInTime(0.1, OnInit)

    return inst
end

return Prefab( "vidanomarseaworld", fn, assets, prefabs)
