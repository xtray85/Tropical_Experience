local assets =
{
	Asset("ANIM", "anim/permit_demolition.zip"),
}

local function onfinished(inst)
	inst:Remove()
end

local function paintwall(inst)
local wall = GetClosestInstWithTag("wallhousehamlet", inst, 25)

if wall then
wall.AnimState:SetBank("wallhamletcity1")
wall.AnimState:SetBuild("wallhamletcity1")
wall.AnimState:PlayAnimation(inst.textura, true)
wall.wallpaper = inst.textura
end

inst:Remove()
end

local function paintwall2(inst)
local wall = GetClosestInstWithTag("wallhousehamlet", inst, 25)

if wall then
wall.AnimState:SetBank("wallhamletcity2")
wall.AnimState:SetBuild("wallhamletcity2")
wall.AnimState:PlayAnimation(inst.textura, true)
wall.wallpaper = inst.textura
end

inst:Remove()
end

local function paintfloor(inst)
local piso = GetClosestInstWithTag("pisohousehamlet", inst, 25)

if piso then
piso.AnimState:PlayAnimation(inst.textura, true)
piso.floorpaper = inst.textura
end

inst:Remove()
end

local function paintquadro(inst)
local quadro = GetClosestInstWithTag("quadro", inst, 25)

if quadro then
quadro.AnimState:SetBank("interior_wallornament")
quadro.AnimState:SetBuild("interior_wallornament")
quadro.AnimState:PlayAnimation(inst.textura, true)
quadro.textura = inst.textura
end

inst:Remove()
end

local function paintquadro2(inst)
local quadro = GetClosestInstWithTag("quadro", inst, 25)

if quadro then
quadro.AnimState:SetBank("wall_decals_antiquities")
quadro.AnimState:SetBuild("interior_wall_decals_antiquities")
quadro.AnimState:PlayAnimation(inst.textura, true)
quadro.textura = inst.textura
end

inst:Remove()
end

local function paintwindow(inst)
local janela = GetClosestInstWithTag("janela", inst, 25)

if janela then
local x, y, z = janela.Transform:GetWorldPosition()
local troca = SpawnPrefab(inst.textura)
if troca then
troca.Transform:SetPosition(x ,y, z)
troca.Transform:SetRotation(90)	
janela:Remove()
end
end

inst:Remove()
end

local function paintluz(inst)
local luz = GetClosestInstWithTag("centerlight", inst, 25)

if luz then

local x, y, z = luz.Transform:GetWorldPosition()
local troca = SpawnPrefab(inst.textura)
if troca then
troca.Transform:SetPosition(x ,y, z)
luz:Remove()
end
end

inst:Remove()
end

local function paintposte(inst)
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"poste"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_accademia")
item.AnimState:SetBuild("interior_wall_decals_accademia")
item.AnimState:PlayAnimation(inst.textura, true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura = inst.textura
end
end

local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"postef"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_accademia")
item.AnimState:SetBuild("interior_wall_decals_accademia")
item.AnimState:PlayAnimation(inst.textura2, true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura2 = inst.textura2
end
end

inst:Remove()
end

local function paintposte2(inst)
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"poste"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_millinery")
item.AnimState:SetBuild("interior_wall_decals_millinery")
item.AnimState:PlayAnimation(inst.textura, true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura = inst.textura
end
end

local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"postef"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_millinery")
item.AnimState:SetBuild("interior_wall_decals_millinery")
item.AnimState:PlayAnimation(inst.textura2, true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura2 = inst.textura2
end
end

inst:Remove()
end

local function paintposte3(inst)
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"poste"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_accademia")
item.AnimState:SetBuild("interior_wall_decals_accademia")
item.AnimState:PlayAnimation(inst.textura, true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura = inst.textura
end
end

local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"postef"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_accademia")
item.AnimState:SetBuild("interior_wall_decals_accademia")
item.AnimState:PlayAnimation(inst.textura2, true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura2 = inst.textura2
end
end

inst:Remove()
end

local function paintposte4(inst)
local pt = inst:GetPosition()
local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"poste"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_hoofspa")
item.AnimState:SetBuild("interior_wall_decals_hoofspa")
item.AnimState:PlayAnimation("pillar_corner", true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura = inst.textura
end
end

local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 25, {"postef"}) 
for k,item in pairs(ents) do
if item then
item.AnimState:SetBank("wall_decals_hoofspa")
item.AnimState:SetBuild("interior_wall_decals_hoofspa")
item.AnimState:PlayAnimation(inst.textura2, true)
    item.Light:SetIntensity(0.75)
    item.Light:SetRadius(2)
item.textura2 = inst.textura2
end
end

inst:Remove()
end

local function paintporta(inst)

local quadro = GetClosestInstWithTag("quadro", inst, 25)

if quadro then
local x, y, z = quadro.Transform:GetWorldPosition()
local troca = SpawnPrefab(inst.porta)
if troca then
troca.Transform:SetPosition(x ,y, z)
quadro:Remove()
end

else


local portadacasa = GetClosestInstWithTag("portadacasa", inst, 25)
if portadacasa then
local x, y, z = portadacasa.Transform:GetWorldPosition()
local troca = SpawnPrefab(inst.porta2)
if troca then
troca.Transform:SetPosition(x ,y, z)
local alvo = portadacasa.components.teleporter.targetTeleporter
troca.components.teleporter.targetTeleporter = alvo
alvo.components.teleporter.targetTeleporter = troca

portadacasa:Remove()
end
end

end

inst:Remove()
end

local function paintshelf(inst)
local quadro = GetClosestInstWithTag("estante", inst, 25)

if quadro then
--quadro.AnimState:SetBank("room_shelves")
--quadro.AnimState:SetBuild("bookcase")
quadro.AnimState:PlayAnimation(inst.textura, true)
quadro.textura = inst.textura
end

inst:Remove()
end

local function OnSave(inst, data)
	data.textura = inst.textura
end


local function OnLoad(inst, data)
if data == nil then return end
	if data.textura then 
	inst.textura = data.textura 
	
	if data.textura == "fish_front" or data.textura == "beefalo_front" then
	inst.AnimState:SetBank("wall_decals_antiquities")
	inst.AnimState:SetBuild("interior_wall_decals_antiquities")
	else
	inst.AnimState:SetBank("interior_wallornament")
	inst.AnimState:SetBuild("interior_wallornament")	
	end

	

    inst.AnimState:PlayAnimation(data.textura, true)

	end
end

local function wallfish(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("interior_wall_decals_antiquities")
    inst.AnimState:SetBuild("wall_decals_antiquities")
    inst.AnimState:PlayAnimation("fish_front")
	
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
    inst.AnimState:SetSortOrder(3)   
	
	inst:AddTag("quadro")	
	inst:AddTag("NOBLOCK")	
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
 
	
	inst.textura = "fish_front"	
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end
	
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad	
    return inst
end






local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_checkered_metal")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_checkered_metal")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_checkered_metal"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end
    return inst
end

local function fn1(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_circles")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_circles")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_circles"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end	
    return inst
end

local function fn2(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_marble")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_marble")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_marble"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end		
    return inst
end	

local function fn3(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_sunflower")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_sunflower")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_sunflower"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end		
    return inst
end	

local function fn4(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_woodwall")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_woodwall")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_woodwall"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end		
    return inst
end

local function fn5(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("wall_mayorsoffice_whispy")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("wall_mayorsoffice_whispy")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "wall_mayorsoffice_whispy"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end		
    return inst
end

local function fn5a(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("wall_mayorsoffice_whispy")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("wall_mayorsoffice_whispy")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_plain_rog"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end		
    return inst
end

local function fn5b(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("wall_mayorsoffice_whispy")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("wall_mayorsoffice_whispy")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_plain_rog"	
	inst.OnBuilt = function(inst,builder) paintwall(inst) end		
    return inst
end

local function fn6(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("harlequin_panel")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("harlequin_panel")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "harlequin_panel"	
	inst.OnBuilt = function(inst,builder) paintwall2(inst) end		
    return inst
end

local function fn7(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_fullwall_moulding")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_fullwall_moulding")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_fullwall_moulding"	
	inst.OnBuilt = function(inst,builder) paintwall2(inst) end		
    return inst
end

local function fn8(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_floraltrim2")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_floraltrim2")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_floraltrim2"	
	inst.OnBuilt = function(inst,builder) paintwall2(inst) end		
    return inst
end

local function fn9(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_wall_upholstered")
	
	inst:AddTag("hameletwallpaper")	
	inst:AddTag("shop_wall_upholstered")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_wall_upholstered"	
	inst.OnBuilt = function(inst,builder) paintwall2(inst) end	
    return inst
end

local function fn10(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("floor_cityhall")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("floor_cityhall")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"		
	
	inst.textura = "floor_cityhall"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end		
    return inst
end

local function fn11(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("noise_woodfloor")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("noise_woodfloor")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "noise_woodfloor"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end			
    return inst
end

local function fn12(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_checker")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_checker")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_checker"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end		
    return inst
end

local function fn13(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_herringbone")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_herringbone")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_herringbone"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end	
    return inst
end

local function fn14(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_hexagon")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_hexagon")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_hexagon"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end		
    return inst
end

local function fn15(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_octagon")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_octagon")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_octagon"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end	
    return inst
end

local function fn16(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_sheetmetal")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_sheetmetal")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_sheetmetal"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end		
    return inst
end

local function fn17(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_woodmetal")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_woodmetal")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_woodmetal"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end		
    return inst
end

local function fn18(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_hoof_curvy")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_hoof_curvy")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_hoof_curvy"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end		
    return inst
end

local function fn19(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
    MakeInventoryFloatable(inst)
 
    inst.AnimState:SetBank("permit_demolition")
    inst.AnimState:SetBuild("permit_demolition")
    inst.AnimState:PlayAnimation("shop_floor_woodpaneling2")
	
	inst:AddTag("hameletfloor")	
	inst:AddTag("shop_floor_woodpaneling2")		
 
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(1)
    inst.components.finiteuses:SetUses(1)
    inst.components.finiteuses:SetOnFinished( onfinished )	
 
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
	
	inst.textura = "shop_floor_woodpaneling2"	
	inst.OnBuilt = function(inst,builder) paintfloor(inst) end		
    return inst
end

local function fn20()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "photo"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end

local function fn21()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "embroidery_hoop"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end

local function fn22()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "mosaic"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end
local function fn23()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "wreath"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end
local function fn24()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "axe"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end
local function fn25()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "hunt"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end
local function fn26()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "periodic_table"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end
local function fn27()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "gears_art"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end

local function fn28()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "cape"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end

local function fn29()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "no_smoking"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end

local function fn30()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "black_cat"
	inst.OnBuilt = function(inst,builder) paintquadro(inst) end		
    return inst
end

local function fn31()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "fish_front"
	inst.OnBuilt = function(inst,builder) paintquadro2(inst) end		
    return inst
end

local function fn32()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "beefalo_front"
	inst.OnBuilt = function(inst,builder) paintquadro2(inst) end		
    return inst
end

local function fn33()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_small_peaked_curtain"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn34()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_round_burlap"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn35()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_small_peaked"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn36()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_large_square"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn37()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_tall"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn38()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_large_square_curtain"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn39()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_tall_curtain"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn40()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "window_greenhouse"
	inst.OnBuilt = function(inst,builder) paintwindow(inst) end		
    return inst
end

local function fn41()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_basic_bulb"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn42()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_basic_metal"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn43()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_chandalier_candles"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn44()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_rope_1"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn45()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_rope_2"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn46()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_floral_bulb"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn47()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_pendant_cherries"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn48()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_floral_scallop"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn49()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_floral_bloomer"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn50()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_tophat"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn51()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "swinging_light_derby"
	inst.OnBuilt = function(inst,builder) paintluz(inst) end		
    return inst
end

local function fn52()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "pillar_square_corner"
	inst.textura2 = "pillar_square_front"	
	inst.OnBuilt = function(inst,builder) paintposte(inst) end		
    return inst
end

local function fn53()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "pillar_corner"
	inst.textura2 = "pillar_front"
	inst.OnBuilt = function(inst,builder) paintposte2(inst) end		
    return inst
end

local function fn54()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "pillar_round_corner"
	inst.textura2 = "pillar_round_front"
	inst.OnBuilt = function(inst,builder) paintposte3(inst) end		
    return inst
end

local function fn55()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "pillar_corner2"
	inst.textura2 = "pillar"
	
	inst.OnBuilt = function(inst,builder) paintposte4(inst) end		
    return inst
end

local function fn56()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.porta = "playerhouse_room_pedra_cima"
	inst.porta2 = "playerhouse_city_door_pedra_cima"		
	inst.OnBuilt = function(inst,builder) paintporta(inst) end		
    return inst
end

local function fn57()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.porta = "playerhouse_room_metal_cima"
	inst.porta2 = "playerhouse_city_door_metal_cima"		
	inst.OnBuilt = function(inst,builder) paintporta(inst) end		
    return inst
end

local function fn58()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.porta = "playerhouse_room_peagank_cima"
	inst.porta2 = "playerhouse_city_door_peagank_cima"	
	
	inst.OnBuilt = function(inst,builder) paintporta(inst) end		
    return inst
end

local function fn59()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.porta = "playerhouse_room_pano_cima"
	inst.porta2 = "playerhouse_city_door_pano_cima"	
		
	inst.OnBuilt = function(inst,builder) paintporta(inst) end		
    return inst
end

local function fn60()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "wood"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn61()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "basic"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn62()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "cinderblocks"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn63()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "marble"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn64()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "glass"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn65()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "ladder"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn66()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "hutch"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn67()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "industrial"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn68()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "adjustable"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn69()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "midcentury"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn70()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "wallmount"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn71()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "aframe"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn72()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "crates"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn73()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "fridge"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn74()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "floating"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn75()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "pipe"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn76()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "hattree"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

local function fn77()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()	
    inst.entity:AddSoundEmitter()
	
	inst.textura = "pallet"
	inst.OnBuilt = function(inst,builder) paintshelf(inst) end		
    return inst
end

return 
Prefab( "common/inventory/deco_antiquities_wallfish", wallfish, assets),

Prefab( "common/inventory/interior_wall_checkered_metal", fn, assets),
Prefab( "common/inventory/interior_wall_circles", fn1, assets),
Prefab( "common/inventory/interior_wall_marble", fn2, assets),
Prefab( "common/inventory/interior_wall_sunflower", fn3, assets),
Prefab( "common/inventory/interior_wall_wood", fn4, assets),
Prefab( "common/inventory/interior_wall_mayorsoffice", fn5, assets),
--Prefab( "common/inventory/interior_wall_plain_ds", fn5a, assets),
--Prefab( "common/inventory/interior_wall_plain_rog", fn5b, assets),
Prefab( "common/inventory/interior_wall_harlequin", fn6, assets),
Prefab( "common/inventory/interior_wall_fullwall_moulding", fn7, assets),
Prefab( "common/inventory/interior_wall_floral", fn8, assets),
Prefab( "common/inventory/interior_wall_upholstered", fn9, assets),



Prefab( "common/inventory/interior_floor_plaid_tile", fn10, assets),
Prefab( "common/inventory/interior_floor_wood", fn11, assets),
Prefab( "common/inventory/interior_floor_check", fn12, assets),
Prefab( "common/inventory/interior_floor_herringbone", fn13, assets),
Prefab( "common/inventory/interior_floor_hexagon", fn14, assets),
Prefab( "common/inventory/interior_floor_octagon", fn15, assets),
Prefab( "common/inventory/interior_floor_sheet_metal", fn16, assets),
Prefab( "common/inventory/interior_floor_transitional", fn17, assets),
Prefab( "common/inventory/interior_floor_hoof_curvy", fn18, assets),
Prefab( "common/inventory/interior_floor_woodpanels", fn19, assets),


Prefab( "common/inventory/reno_wallornament_photo", fn20, assets),
Prefab( "common/inventory/reno_wallornament_embroidery_hoop", fn21, assets),
Prefab( "common/inventory/reno_wallornament_mosaic", fn22, assets),
Prefab( "common/inventory/reno_wallornament_wreath", fn23, assets),
Prefab( "common/inventory/reno_wallornament_axe", fn24, assets),	
Prefab( "common/inventory/reno_wallornament_hunt", fn25, assets), 			
Prefab( "common/inventory/reno_wallornament_periodic_table", fn26, assets),
Prefab( "common/inventory/reno_wallornament_gears_art", fn27, assets),
Prefab( "common/inventory/reno_wallornament_cape", fn28, assets),
Prefab( "common/inventory/reno_wallornament_no_smoking", fn29, assets),
Prefab( "common/inventory/reno_wallornament_black_cat", fn30, assets),
Prefab( "common/inventory/reno_antiquities_wallfish", fn31, assets),
Prefab( "common/inventory/reno_antiquities_beefalo", fn32, assets),


Prefab( "common/inventory/reno_window_small_peaked_curtain", fn33, assets),
Prefab( "common/inventory/reno_window_round_burlap", fn34, assets),
Prefab( "common/inventory/reno_window_small_peaked", fn35, assets),
Prefab( "common/inventory/reno_window_large_square", fn36, assets),	
Prefab( "common/inventory/reno_window_tall", fn37, assets),	
Prefab( "common/inventory/reno_window_large_square_curtain", fn38, assets),
Prefab( "common/inventory/reno_window_tall_curtain", fn39, assets),
Prefab( "common/inventory/reno_window_greenhouse", fn40, assets),


Prefab( "common/inventory/reno_light_basic_bulb", fn41, assets),	
Prefab( "common/inventory/reno_light_basic_metal", fn42, assets),	
Prefab( "common/inventory/reno_light_chandalier_candles", fn43, assets),
Prefab( "common/inventory/reno_light_rope_1", fn44, assets),		
Prefab( "common/inventory/reno_light_rope_2", fn45, assets),
Prefab( "common/inventory/reno_light_floral_bulb", fn46, assets),
Prefab( "common/inventory/reno_light_pendant_cherries", fn47, assets),
Prefab( "common/inventory/reno_light_floral_scallop", fn48, assets),
Prefab( "common/inventory/reno_light_floral_bloomer", fn49, assets),
Prefab( "common/inventory/reno_light_tophat", fn50, assets),
Prefab( "common/inventory/reno_light_derby", fn51, assets),

Prefab( "common/inventory/reno_cornerbeam_wood", fn52, assets),
Prefab( "common/inventory/reno_cornerbeam_millinery", fn53, assets),
Prefab( "common/inventory/reno_cornerbeam_round", fn54, assets),
Prefab( "common/inventory/reno_cornerbeam_marble", fn55, assets),


Prefab( "common/inventory/stone_door", 		fn56, assets),
Prefab( "common/inventory/plate_door", 		fn57, assets),
Prefab( "common/inventory/organic_door", 	fn58, assets),
Prefab( "common/inventory/round_door", 		fn59, assets),


Prefab( "common/inventory/reno_shelves_wood", 				fn60, assets),
Prefab( "common/inventory/reno_shelves_basic", 				fn61, assets),
Prefab( "common/inventory/reno_shelves_cinderblocks", 		fn62, assets),
Prefab( "common/inventory/reno_shelves_marble", 			fn63, assets),
Prefab( "common/inventory/reno_shelves_glass", 				fn64, assets),
Prefab( "common/inventory/reno_shelves_ladder", 			fn65, assets),
Prefab( "common/inventory/reno_shelves_hutch", 				fn66, assets),
Prefab( "common/inventory/reno_shelves_industrial", 		fn67, assets),
Prefab( "common/inventory/reno_shelves_adjustable", 		fn68, assets),
Prefab( "common/inventory/reno_shelves_midcentury", 		fn69, assets),
Prefab( "common/inventory/reno_shelves_wallmount", 			fn70, assets),
Prefab( "common/inventory/reno_shelves_aframe", 			fn71, assets),
Prefab( "common/inventory/reno_shelves_crates", 			fn72, assets),
Prefab( "common/inventory/reno_shelves_fridge", 			fn73, assets),
Prefab( "common/inventory/reno_shelves_floating", 			fn74, assets),
Prefab( "common/inventory/reno_shelves_pipe", 				fn75, assets),
Prefab( "common/inventory/reno_shelves_hattree", 			fn76, assets),
Prefab( "common/inventory/reno_shelves_pallet", 			fn77, assets)