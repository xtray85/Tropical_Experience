local assets =
{
	Asset("ANIM", "anim/crates.zip"),
}

local prefabs =
{
	 "collapse_small",
	 "boards",
	 "rope",
	 "bluegem",
	 "carrat",
	 "winterhat",
	 "lantern",
	 "yotc_seedpacket",
	 "yotc_seedpacket_rare",
}

local function setanim(inst, anim)
	inst.anim = anim
	inst.AnimState:PlayAnimation("idle" .. anim)
end

local function onsave(inst, data)
	data.anim = inst.anim
end

local function onload(inst, data)
	if data and data.anim then
		setanim(inst, data.anim)
	end
end

local function onhammered(inst)
	if inst:HasTag("fire") and inst.components.burnable then
		inst.components.burnable:Extinguish()
	end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	
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

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local minimap = inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	MakeObstaclePhysics(inst, 0.1)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)

	anim:SetBank("crates")
	anim:SetBuild("crates")
	setanim(inst, math.random(1, 10))

	minimap:SetIcon("crate.png")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(1)
	inst.components.workable:SetOnFinishCallback(onhammered)

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"boards"})
	inst.components.lootdropper:AddRandomLoot("rope", 10)
	inst.components.lootdropper:AddRandomLoot("rope",10)
	inst.components.lootdropper:AddRandomLoot("fish",10)
	inst.components.lootdropper:AddRandomLoot("flint",5)
	inst.components.lootdropper:AddRandomLoot("goldnugget",5)
	inst.components.lootdropper:AddRandomLoot("papyrus",5)
	inst.components.lootdropper:AddRandomLoot("gears",1)
	inst.components.lootdropper:AddRandomLoot("gunpowder",1)
	inst.components.lootdropper:AddRandomLoot("pigskin",1)
	inst.components.lootdropper:AddRandomLoot("bluegem",1)
	inst.components.lootdropper:AddRandomLoot("carrat",1)
	inst.components.lootdropper:AddRandomLoot("winterhat",1)	
	inst.components.lootdropper:AddRandomLoot("lantern",1)
	inst.components.lootdropper:AddRandomLoot("yotc_seedpacket",1)
	inst.components.lootdropper:AddRandomLoot("yotc_seedpacket_rare",1)
	
	inst.components.lootdropper.numrandomloot = 1

	inst:AddComponent("inspectable")

	inst.OnSave = onsave
	inst.OnLoad = onload

	return inst
end

return Prefab("cratesnow", fn, assets, prefabs)