local assets =
{
	Asset("ANIM", "anim/sand_castle.zip"),
	Asset("ANIM", "anim/snow_castle.zip"),
}

local prefabs =
{
	-- "sand",
	-- "sandhill",
	-- "seashell"
}

local SANDCASTLE_PERISHTIME = 480
local SANDCASTLE_RAIN_PERISH_RATE = 2
local SANDCASTLE_WIND_PERISH_RATE = 2

-- these should match the animation names to the workleft
local anims = {"low", "med", "full"}

local function setanim(inst)
	if inst.components.workable.workleft < 1 then
		inst.AnimState:PlayAnimation(anims[1])
	else
		inst.AnimState:PlayAnimation(anims[inst.components.workable.workleft])
	end
end

local function workcallback(inst, worker, workleft)
local pt = Vector3(inst.Transform:GetWorldPosition())
	if workleft <= 0 then
		-- figure out which side to drop the loot
		local hispos = Vector3(worker.Transform:GetWorldPosition())

		local he_right = ((hispos - pt):Dot(TheCamera:GetRightVec()) > 0)

		if he_right then
			inst.components.lootdropper:DropLoot(pt - (TheCamera:GetRightVec()*2))
		else
			inst.components.lootdropper:DropLoot(pt + (TheCamera:GetRightVec()*2))
		end
		
		
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local contagem = 0
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
local curr = map:GetTile(map:GetTileCoordsAtPoint(x,0,z))
local curr1 = map:GetTile(map:GetTileCoordsAtPoint(x-4,0,z))
local curr2 = map:GetTile(map:GetTileCoordsAtPoint(x+4,0,z))
local curr3 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z-4))
local curr4 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z+4))
contagem = contagem + 1
-------------------coloca os itens------------------------
if (curr == GROUND.WATER_MANGROVE and curr1 == GROUND.WATER_MANGROVE and curr2 == GROUND.WATER_MANGROVE and curr3 == GROUND.WATER_MANGROVE and curr4 == GROUND.WATER_MANGROVE) then 
local colocaitem = SpawnPrefab(inst.prefab) 
colocaitem.Transform:SetPosition(x, 0, z)
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0 or contagem == 500		
		inst:Remove()
	else
		inst.components.fueled:ChangeSection(-1)
		inst.components.lootdropper:DropLoot(pt - (TheCamera:GetRightVec()*(.5+math.random())))
	end
	setanim(inst)
end

local function sectioncallback(newsection, oldsection, inst)
	inst.components.workable:SetWorkLeft(newsection)
	setanim(inst)
end

local function onperish(inst)
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local contagem = 0
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
local curr = map:GetTile(map:GetTileCoordsAtPoint(x,0,z))
local curr1 = map:GetTile(map:GetTileCoordsAtPoint(x-4,0,z))
local curr2 = map:GetTile(map:GetTileCoordsAtPoint(x+4,0,z))
local curr3 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z-4))
local curr4 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z+4))
contagem = contagem + 1
-------------------coloca os itens------------------------
if (curr == GROUND.WATER_MANGROVE and curr1 == GROUND.WATER_MANGROVE and curr2 == GROUND.WATER_MANGROVE and curr3 == GROUND.WATER_MANGROVE and curr4 == GROUND.WATER_MANGROVE) then 
local colocaitem = SpawnPrefab(inst.prefab) 
colocaitem.Transform:SetPosition(x, 0, z)
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0 or contagem == 500
	inst:Remove()
end

local function onupdate(inst)
	-- local sm = GetSeasonManager()
	local rain = Remap(math.max(TheWorld.state.precipitationrate, 0.5), 0.5, 1.0, 0.0, 1.0)
	-- local wind = sm:GetHurricaneWindSpeed()
	local wind = 1
	inst.components.fueled.rate = 1 + SANDCASTLE_RAIN_PERISH_RATE * 
		rain + SANDCASTLE_WIND_PERISH_RATE * wind
end

local function sandcastlefn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	anim:SetBuild("snow_castle")
	anim:SetBank("sand_castle")
	anim:PlayAnimation(anims[#anims])
	local tamanho = math.random()/1.5
	inst.Transform:SetScale(1+tamanho, 1+tamanho, 1+tamanho)		

	MakeObstaclePhysics(inst, .4)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aura = TUNING.SANITYAURA_SMALL

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "NONE"
    inst.components.fueled.accepting = false
    inst.components.fueled:InitializeFuelLevel(SANDCASTLE_PERISHTIME)
    inst.components.fueled:SetDepletedFn(onperish)
    inst.components.fueled:SetSections(#anims)
    inst.components.fueled:SetSectionCallback(sectioncallback)
    inst.components.fueled:SetUpdateFn(onupdate)
    inst.components.fueled:StartConsuming()

	----------------------
	inst:AddComponent("inspectable")
	----------------------
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"snowitem"})

	--full, med, low
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetWorkLeft(#anims)
	inst.components.workable:SetOnWorkCallback(workcallback)

	return inst
end

return Prefab( "snow_castle", sandcastlefn, assets, prefabs)