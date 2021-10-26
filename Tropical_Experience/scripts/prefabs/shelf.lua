local assets =
{
    --Asset("ANIM", "anim/store_items.zip"),
    Asset("ANIM", "anim/room_shelves.zip"),
    Asset("ANIM", "anim/pedestal_key.zip"),
    Asset("ATLAS_BUILD", "images/inventoryimages1.xml", 256),
    Asset("ATLAS_BUILD", "images/inventoryimages2.xml", 256),
    Asset("ATLAS_BUILD", "images/inventoryimages/volcanoinventory.xml", 256),
    Asset("ATLAS_BUILD", "images/inventoryimages/hamletinventory.xml", 256),
	
}

local prefabs =
{
--    "minisign_item",
--    "minisign_drawn",
    "shelf_slot",
}

local function smash(inst)
--    if inst.components.lootdropper then
--        local interiorSpawner = GetWorld().components.interiorspawner 
--        if interiorSpawner.current_interior then
--            local originpt = interiorSpawner:getSpawnOrigin()
--            local x, y, z = inst.Transform:GetWorldPosition()
--            local dropdir = Vector3(originpt.x - x, 0.0, originpt.z - z):GetNormalized()
--            inst.components.lootdropper.dropdir = dropdir
--            inst.components.lootdropper:DropLoot()
--        end
--    end
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    if inst.SoundEmitter then
        inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    end

    if inst.shelves and #inst.shelves > 0 then
        for i, v in ipairs(inst.shelves)do           
            v.empty(v)
            v:Remove()
        end
    end

    inst:Remove()
end    

local function setPlayerUncraftable(inst)
    inst:AddTag("playercrafted") 

    inst:RemoveTag("NOCLICK")
    inst:AddComponent("lootdropper")
--    inst.components.lootdropper.lootdropangle = 180
--    inst.components.lootdropper.lootdroparc = 90
    
    inst.entity:AddSoundEmitter()
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)
            if workleft <= 0 then
                smash(inst)
            end
        end)
end

local function onBuilt(inst)
    setPlayerUncraftable(inst)
    inst.onbuilt = true         
end

local function SetImage(inst, ent, slot)
--print(ent.replica.inventoryitem:GetAtlas())
    local src = ent 
    local image = nil 

    if src ~= nil and src.components.inventoryitem ~= nil then
        image = #(ent.components.inventoryitem.imagename or "") > 0 and
            ent.components.inventoryitem.imagename or
            ent.prefab
    end 

    if image ~= nil then 	
        local texname = image..".tex"

	local atlas = src.replica.inventoryitem:GetAtlas()
	if not inst:HasTag("playercrafted") then
	if ent.components.perishable then ent.components.perishable:StopPerishing() end	
	end
--	print(inst.prefab)
--print(ent)
--fazer para o prefab minising
	if ent.caminho then atlas = ent.caminho
	elseif atlas and atlas == "images/inventoryimages1.xml" then atlas = "images/inventoryimages1.xml"
	elseif atlas and atlas == "images/inventoryimages2.xml" then atlas = "images/inventoryimages2.xml"
	else atlas = "images/inventoryimages/hamletinventory.xml" end

    inst.AnimState:OverrideSymbol(slot, resolvefilepath(atlas), texname)
	
--print(slot)
--print(texname)		
--print(atlas)	
        --inst.AnimState:OverrideSymbol("SWAP_SIGN", "store_items", image)
        inst.imagename = src ~=nil or ""
    else
        inst.imagename = ""
        inst.AnimState:ClearOverrideSymbol(slot)
    end
end 

local function SetImageFromName(inst, name, slot)
    local image = name

    if image ~= nil then 
        local texname = image..".tex"
		
--	print(name)	
		
		
        inst.AnimState:OverrideSymbol(slot, resolvefilepath("images/inventoryimages/hamletinventory.xml"), texname)
        --inst.AnimState:OverrideSymbol("SWAP_SIGN", "store_items", image)
        inst.imagename = image
    else
        inst.imagename = ""
        inst.AnimState:ClearOverrideSymbol(slot)
    end
end 

local function displaynamefn(inst)
    return "whatever"
end

local function spawnchildren(inst)
    if not inst.childrenspawned then
        inst.shelves = {}
        for i = 1, inst.size do
            local object = SpawnPrefab("shelf_slot")   

            if inst.swp_img_list and object.components.inventoryitem and object.components.shelfer then
                object.components.inventoryitem:PutOnShelf(inst, inst.swp_img_list[i])
                object.components.shelfer:SetShelf(inst, inst.swp_img_list[i])            
            else 
				if object.components.inventoryitem and object.components.shelfer then
                object.components.inventoryitem:PutOnShelf(inst,"SWAP_img"..i)
                object.components.shelfer:SetShelf(inst, "SWAP_img"..i)  
				end
            end
            table.insert(inst.shelves, object)
            if inst.shelfitems then

                for index,set in pairs(inst.shelfitems)do
                    if set[1] == i then
                        local item = SpawnPrefab(set[2])
                        if item and object.components.shelfer then
                            object.components.shelfer:AcceptGift(nil, item)
                        end
                    end
                end
            end
        end
        inst.childrenspawned = true
    end
end

local function unlock(inst, key, doer)
    inst.AnimState:Hide("LOCK")
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/royal_gallery/unlock") 
    if inst.shelves then
        for i,object in ipairs(inst.shelves) do 
			local item  = object.components.shelfer:GetGift()
			if item ~= nil then
            object.components.shelfer:Enable()
			end
        end 
    end
    inst:AddTag("NOCLICK")
	inst.destrancado = true
end

local function lock(inst)
    inst.AnimState:Show("LOCK") 
    if inst.shelves then
        for i,object in ipairs(inst.shelves) do  
			if object.components.shelfer then
            object.components.shelfer:Disable()
			end
        end    
    end
end

local function onsave(inst, data)    
    if inst.childrenspawned then
        data.childrenspawned = inst.childrenspawned
    end
    data.rotation = inst.Transform:GetRotation()    
    if inst.onbuilt then
        data.onbuilt = inst.onbuilt
    end     
    if inst:HasTag("playercrafted") then
        data.playercrafted = true
    end    

    data.shelves = {}
    if inst.shelves then
        for i, v in ipairs(inst.shelves)do
            table.insert(data.shelves, v.GUID)
        end
    end	

    data.destrancado = inst.destrancado
	data.textura = inst.textura	
end

local function onload(inst, data)
	if data == nil then return end
    if data.rotation then
        inst.Transform:SetRotation(data.rotation)
    end    
    if data.childrenspawned then
        inst.childrenspawned = data.childrenspawned
    end
    if data.onbuilt then
        setPlayerUncraftable(inst)
        inst.onbuilt = data.onbuilt
    end     
    if data.playercrafted then
        inst:AddTag("playercrafted")
    end    
    if data.destrancado then
        inst.destrancado = data.destrancado
    end
    if not inst.destrancado then
        lock(inst)
    else
        unlock(inst,nil)
    end
	
	if data.textura then 
	inst.textura = data.textura 
	
    inst.AnimState:PlayAnimation(data.textura, true)
	end	

end

local function onloadpostpass(inst, ents, data)
--[[
    inst.shelves = {}
    if data and data.shelves and ents then
        for i, v in ipairs(data.shelves)do
		if ents and v and ents[v].entity then
            local shelfer = ents[v].entity
            if shelfer then
                table.insert(inst.shelves, shelfer)
            end
		end	
        end
    end
]]	
end  

local function docurse(inst)
    if math.random() < 0.3 then
        local ghost = SpawnPrefab("pigghost")
        local pt = Vector3(inst.Transform:GetWorldPosition())
        ghost.Transform:SetPosition(pt.x,pt.y,pt.z)
    end
end

local function common(setsize,swp_img_list, locked, physics_round)

    local size = setsize or 6
    local inst = CreateEntity()
	inst.entity:AddNetwork()
    inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()		

    if physics_round then
        MakeObstaclePhysics(inst, .5)
    else
--        MakeInteriorPhysics(inst, 1.6, 1, 0.2)
		MakeInventoryPhysics(inst, 1.6, 1, 0.2)
    end 

--    inst.AnimState:SetOrientation(ANIM_ORIENTATION.RotatingBillboard)
	inst.Transform:SetTwoFaced()

    inst:AddTag("NOCLICK")
    inst:AddTag("wallsection")
    inst:AddTag("furniture")    

    anim:SetBuild("room_shelves")
    anim:SetBank("bookcase")
    anim:PlayAnimation("wood", false)

    inst.Transform:SetRotation(-90)

    inst.imagename = nil 

    inst.SetImage = SetImage
    inst.SetImageFromName = SetImageFromName

    inst.swp_img_list = swp_img_list
    inst.size = setsize or 6
    if swp_img_list then
        for i=1,size do
            SetImageFromName(inst, nil, swp_img_list[i])
        end
    else
        for i=1,size do
            SetImageFromName(inst, nil, "SWAP_img"..i)
        end
    end
   
    inst:ListenForEvent( "onbuilt", function()
        onBuilt(inst)
    end)          

    inst.OnSave = onsave 
    inst.OnLoad = onload
    inst.OnLoadPostPass = onloadpostpass

    inst:DoTaskInTime(0, function() 
        if inst:HasTag("playercrafted") then
            setPlayerUncraftable(inst)
        end

        spawnchildren(inst) 
        if locked and not inst.destrancado then
                lock(inst)
            else
                unlock(inst)
        end
    end)

    return inst
end

local function wood()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("wood", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{3,"cutgrass"},{4,"cutgrass"},{5,"cutgrass"},{6,"cutgrass"}}
    return inst
end

local function wood2()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("wood", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{3,"rocks"},{4,"rocks"},{5,"rocks"},{6,"rocks"}}
    return inst
end

local function wood3()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("wood", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{1,"trinket_giftshop_3"},{2,"trinket_giftshop_3"},{math.random(3, 4),"trinket_giftshop_3"},{5,"trinket_giftshop_3"},{6,"trinket_giftshop_3"}}
    return inst
end

local function basic()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("basic", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
    return inst
end

local function marble()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("marble", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{3,"petals"},{4,"petals"},{5,"petals"},{6,"petals"}}
    return inst
end

local function marble2()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("marble", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{5,"trinket_20"},{6,"trinket_14"},{3,"trinket_4"},{4,"trinket_2"}}
    return inst
end

local function glass()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("glass", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{1,"trinket_1"},{5,"trinket_2"},{6,"trinket_3"}}
    return inst
end

local function ladder()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("ladder", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function hutch()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("hutch", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{3,"seeds"},{4,"seeds"},{5,"seeds"},{6,"seeds"}}
    return inst
end

local function industrial()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("industrial", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function adjustable()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("adjustable", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function fridge()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("fridge", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3) 
	inst.shelfitems = {{1,"fishmeat_small"},{2,"fishmeat_small"},{3,"bird_egg"},{4,"bird_egg"},{5,"froglegs"},{6,"froglegs"}}
    return inst
end

local function cinderblocks()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("cinderblocks", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
	inst.AnimState:SetSortOrder(3)
	inst:AddTag("playercrafted")
	inst:AddTag("estante")	
    return inst
end

local function midcentury2()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("midcentury", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)
	inst.shelfitems = {{5,"twigs"}, {6,"twigs"}, {3,"twigs"}, {4,"twigs"}}
    return inst
end

local function midcentury()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("midcentury", false)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)
	inst.shelfitems = {{1,"trinket_1"},{5,"trinket_2"},{6,"trinket_3"}}
    return inst
end

local function wallmount()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("wallmount", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function aframe()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("aframe", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function crates()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("crates", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function hooks()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("hooks", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function pipe()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("pipe", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
	inst.shelfitems = {{3,"strawhat"}, {5,"strawhat"}}
    return inst
end

local function hattree()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("hattree", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function pallet()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("pallet", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)  
    return inst
end

local function floating()
    local inst = common()
    local anim = inst.AnimState
    anim:PlayAnimation("floating", false) 
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
  inst.AnimState:SetSortOrder(3)
	inst.shelfitems = {{1,"petals"},{2,"petals"},{3,"petals"}, {4,"cutgrass"}, {5,"cutgrass"},{6,"petals"}}
    return inst
end

local function display()
local escolha =
{
[1] = {{1,"trinket_giftshop_1"},{2,"trinket_giftshop_1"},{3,"trinket_giftshop_1"}},                   
[2] = {{1,"trinket_giftshop_1"},{3,"trinket_giftshop_1"}},                   
[3] = {{2,"trinket_giftshop_1"},{3,"trinket_giftshop_1"}},                  
[4] = {{1,"trinket_giftshop_1"},{2,"trinket_giftshop_1"}},
}
    local inst = common(3,nil,nil,true)
    local anim = inst.AnimState
	inst.shelfitems = escolha[math.random(1, 4)]	
    anim:SetBuild("room_shelves")
    anim:SetBank("bookcase")    
    anim:PlayAnimation("displayshelf_wood", false) 
    return inst
end

local function display_metal()
local escolha =
{
[1] = {{1,"flint"},{2,"rocks"},{3,"flint"}},                   
[2] = {{1,"rocks"},{2,"rocks"},{3,"rocks"}},                   
[3] = {{1,"nitre"},{2,"nitre"},{3,"rocks"}},                  
[4] = {{1,"rocks"},{2,"charcoal"},{3,"charcoal"}},
}
    local inst = display()
    local anim = inst.AnimState
    anim:PlayAnimation("displayshelf_metal", false) 
	inst.shelfitems = escolha[math.random(1, 4)]
    return inst
end

local function OnTimerDone(inst, data)
    if data.name == "spawndelay" then
    local pote = SpawnPrefab("shelves_ruins")
    pote.Transform:SetPosition(inst.Transform:GetWorldPosition())
	
    if inst.shelves and #inst.shelves > 0 then
        for i, v in ipairs(inst.shelves)do           
            v.empty(v)
            v:Remove()
        end
    end	
	inst:Remove()
    end
end

local function ruins()

local escolha =
{
[1] = {1,"redgem"},                   
[2] = {1,"bluegem"},                   
[3] = {1,"relic_1"},                  
[4] = {1,"relic_2"},
[5] = {1,"relic_3"}, 
[6] = {1,"redgem"},                   
[7] = {1,"bluegem"},                   
[8] = {1,"relic_1"},                  
[9] = {1,"relic_2"},
[10] = {1,"relic_3"}, 
[11] = {1,"redgem"},                   
[12] = {1,"bluegem"},                   
[13] = {1,"relic_1"},                  
[14] = {1,"relic_2"},
[15] = {1,"relic_3"},              
[16] = {1,"nightsword"},                   
[17] = {1,"ruins_bat"},                  
[18] = {1,"ruinshat"},
[19] = {1,"orangestaff"},                   
[20] = {1,"armorruins"},                  
[21] = {1,"multitool_axe_pickaxe"},
}



	local size = 1
    local inst = CreateEntity()
	inst.entity:AddNetwork()
    inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local minimap = inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("shelf_ruins.png")	
    inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()		

    MakeObstaclePhysics(inst, .5)

--    inst.AnimState:SetOrientation(ANIM_ORIENTATION.RotatingBillboard)
	inst.Transform:SetTwoFaced()

    inst:AddTag("NOCLICK")
    inst:AddTag("wallsection")
    inst:AddTag("furniture")  
    inst:AddTag("pigcurse")	

    anim:SetBuild("room_shelves")
    anim:SetBank("bookcase")    
    anim:PlayAnimation("ruins", false) 
	inst.shelfitems = {escolha[math.random(1, 21)]} --escolha[math.random(1, 21)]
    inst.curse = docurse
	inst:AddTag("playercrafted")

    inst.Transform:SetRotation(-90)

    inst.imagename = nil 

    inst.SetImage = SetImage
    inst.SetImageFromName = SetImageFromName

    inst.swp_img_list = nil
    inst.size = 1

    for i=1,size do
    SetImageFromName(inst, nil, "SWAP_img"..i)
    end
   
    inst:ListenForEvent( "onbuilt", function()
        onBuilt(inst)
    end)          

    inst.OnSave = onsave 
    inst.OnLoad = onload
    inst.OnLoadPostPass = onloadpostpass

    inst:DoTaskInTime(0, function() 
        if inst:HasTag("playercrafted") then
            setPlayerUncraftable(inst)
        end

        spawnchildren(inst) 
        unlock(inst)

    end)
	
	inst.entity:SetPristine()

   	if not TheWorld.ismastersim then
       	return inst
    end
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)

    return inst
end

local function queen_display_common(size,list)
    local inst = common(size,list,true,true)
    local anim = inst.AnimState

    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "royal_gallery"
    inst.name = STRINGS.NAMES.ROYAL_GALLERY  
       
    inst:RemoveTag("NOCLICK")

    inst:AddComponent("klaussacklock")
    inst.components.klaussacklock:SetOnUseKey(unlock)
    inst.klaussackkeyid = "royal gallery"	  
	
    anim:SetBuild("pedestal_crate")
    anim:SetBank("pedestal")    
    return inst
end

local function queen_display1()
    local inst = queen_display_common(1,{"SWAP_SIGN"})
    local anim = inst.AnimState
    anim:PlayAnimation("lock19_east", false)
	inst.shelfitems = {{1,"key_to_city"}}
    return inst
end

local function queen_display2()
    local inst = queen_display_common(1,{"SWAP_SIGN"})
    local anim = inst.AnimState
  
    anim:PlayAnimation("lock17_east", false) 
	inst.shelfitems = {{1,"trinket_giftshop_4"}}
    return inst
end

local function queen_display3()
    local inst = queen_display_common(1,{"SWAP_SIGN"})
    local anim = inst.AnimState
  
    anim:PlayAnimation("lock12_west", false) 
	inst.shelfitems = {{1,"city_hammer"}}
    return inst
end

local function queen_display4()
    local inst = queen_display_common(1,{"SWAP_SIGN"})
    local anim = inst.AnimState
	inst.shelfitems = {{1,"trinket_giftshop_3"}}
    anim:PlayAnimation("lock12_west", false) 
    return inst
end


local function key()    
    local inst = CreateEntity()
    inst.entity:AddNetwork()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddPhysics()	
	
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("pedestal_key")
    inst.AnimState:SetBuild("pedestal_key")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
	inst:AddComponent("klaussackkey")
	inst.components.klaussackkey.keytype = "royal gallery"
    
    inst:AddComponent("inspectable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
    inst:AddComponent("tradable")

    return inst
end

return  Prefab("shelves_wood", wood, assets, prefabs),
		Prefab("shelves_wood2", wood2, assets, prefabs),
		Prefab("shelves_woodpalace", wood3, assets, prefabs),
        Prefab("shelves_basic", basic, assets, prefabs),
        Prefab("shelves_marble", marble, assets, prefabs),
        Prefab("shelves_marble", marble2, assets, prefabs),
        Prefab("shelves_glass", glass, assets, prefabs),
        Prefab("shelves_ladder", ladder, assets, prefabs),
        Prefab("shelves_hutch", hutch, assets, prefabs),
        Prefab("shelves_industrial", industrial, assets, prefabs),
        Prefab("shelves_adjustable", adjustable, assets, prefabs),
        Prefab("shelves_fridge", fridge, assets, prefabs), 
        Prefab("shelves_cinderblocks", cinderblocks, assets, prefabs),
        Prefab("shelves_midcentury", midcentury, assets, prefabs),
		Prefab("shelves_midcentury_weapon", midcentury2, assets, prefabs),
        Prefab("shelves_wallmount", wallmount, assets, prefabs),
        Prefab("shelves_aframe", aframe, assets, prefabs),
        Prefab("shelves_crates", crates, assets, prefabs),
        Prefab("shelves_hooks", hooks, assets, prefabs),
        Prefab("shelves_pipe", pipe, assets, prefabs),
        Prefab("shelves_hattree", hattree, assets, prefabs),
        Prefab("shelves_pallet", pallet, assets, prefabs),
        Prefab("shelves_floating", floating, assets, prefabs),
        Prefab("shelves_displaycase", display, assets, prefabs),
        Prefab("shelves_displaycase_metal", display_metal, assets, prefabs),
        Prefab("shelves_queen_display_1", queen_display1, assets, prefabs),
        Prefab("shelves_queen_display_2", queen_display2, assets, prefabs),
        Prefab("shelves_queen_display_3", queen_display3, assets, prefabs),
        Prefab("shelves_queen_display_4", queen_display4, assets, prefabs),

        Prefab("shelves_ruins", ruins, assets, prefabs),

        Prefab("pedestal_key",key,assets,prefabs)