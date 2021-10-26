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
local numerodeitens = 50

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local colocaitem = SpawnPrefab("reeds_water")
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
local numerodeitens = 50

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then
local colocaitem = SpawnPrefab("lotus") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
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
local numerodeitens = 20

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local colocaitem = SpawnPrefab("lilypad") 
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
local numerodeitens = 20

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
if TheWorld.Map:IsOceanTileAtPoint(x, 0, z) then 
local colocaitem = SpawnPrefab("hippopotamoose") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

----------------bloco 5-----------------------------
--[[
for k,v in pairs(Ents) do
if v.prefab == "crabking" then
v:Remove()
end
end

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
local colocaitem = SpawnPrefab("crabking") 
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0
]]

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

return Prefab( "vidanomar", fn, assets, prefabs)
