-- shop_interior
local assets =
{
    --Asset("ANIM", "anim/store_items.zip"),
    Asset("ANIM", "anim/pedestal_crate.zip"),
    Asset("ATLAS_BUILD", "images/inventoryimages1.xml", 256),
    Asset("ATLAS_BUILD", "images/inventoryimages2.xml", 256),
    Asset("ATLAS_BUILD", "images/inventoryimages/volcanoinventory.xml", 256),
    Asset("ATLAS_BUILD", "images/inventoryimages/hamletinventory.xml", 256),  
}


local DEFAULT =
{
[1] = { "log",      "oinc", 1 },
}


local pig_shop_deli = 
{
[1] = {"ratatouille","oinc",3  },
[2] = {"monsterlasagna","oinc",2  },
[3] = {"pumpkincookie","oinc",3  },
[4] = {"stuffedeggplant","oinc",4  },
[5] = {"frogglebunwich","oinc",5  },
[6] = {"honeynuggets","oinc",5  },
[7] = {"perogies","oinc",10 },
[8] = {"waffles","oinc",10 },
[9] = {"meatballs","oinc",10 },
[10] = {"honeyham","oinc",20 },
[11] = {"turkeydinner","oinc",10 },
[12] = {"dragonpie","oinc",30 },
}

local pig_shop_florist = {
[1] = { "carrot_seeds","oinc",1  },
[2] = { "pumpkin_seeds","oinc",1  },
[3] = { "pomegranate_seeds","oinc",1  },
[4] = { "eggplant_seeds","oinc",1  },
[5] = { "durian_seeds","oinc",1  },
[6] = { "corn_seeds","oinc",1  },
[7] = { "dragonfruit_seeds","oinc",10 },
[8] = { "radish_seeds","oinc",1  },
[9] = { "flowerhat","oinc",2  },
[10] = { "acorn","oinc",1  },
[11] = { "pinecone","oinc",1  },
[12] = { "dug_berrybush2","oinc",2  },
[13] = { "dug_berrybush","oinc",2  },
[14] = { "watermelon_seeds","oinc",1  },
[15] = { "dug_berrybush_juicy","oinc",5  },
}

local pig_shop_general = {
[1] = { "pitchfork","oinc",5  },
[2] = { "shovel","oinc",5  },
[3] = { "pickaxe","oinc",5  },
[4] = { "axe","oinc",5  },
[5] = { "flint","oinc",1  },
[6] = { "machete","oinc",5  },
[7] = { "minerhat","oinc",20 },
[8] = { "razor","oinc",3  },
[9] = { "backpack","oinc",5  },
[10] = { "hammer","oinc",10 },
[11] = { "fabric","oinc",5  },
[12] = { "bugnet","oinc",20 },
[13] = { "fishingrod","oinc",10 },   
[14] = { "city_hammer","oinc",50 },   
[15] = { "umbrella","oinc",10 },                   
}

local pig_shop_hoofspa = {
[1] = { "blue_cap","oinc",3 },
[2] = { "green_cap","oinc",2 },
[3] = { "bandage","oinc",5 },
[4] = { "healingsalve","oinc",4 },
[5] = { "antidote","oinc",5 },
[6] = { "coffeebeans","oinc",2 },
[7] = { "lifeinjector","oinc",20 },
}

local pig_shop_produce = {
[1] = { "berries","oinc",1 },
[2] = { "radish","oinc",1 },
[3] = { "sweet_potato","oinc",1 },
[4] = { "carrot","oinc",1 },
[5] = { "drumstick","oinc",2 },
[6] = { "eggplant","oinc",2 },
[7] = { "corn","oinc",2 },
[8] = { "pumpkin","oinc",3 },
[9] = { "meat","oinc",5 },
[10] = { "pomegranate","oinc",1 },
[11] = { "cave_banana","oinc",1 },
[12] = { "coconut","oinc",3 },
[13] = { "froglegs","oinc",2 },
[14] = { "watermelon","oinc",2 },
[15] = { "berries_juicy","oinc",1 },
[16] = { "berries_juicy_cooked","oinc",1 },
[17] = { "garlic","oinc",2 },
[18] = { "onion","oinc",2 },
[19] = { "pepper","oinc",2 },
[20] = { "potato","oinc",2 },
[21] = { "tomato","oinc",2 },

}

local pig_shop_antiquities = {
[1] = { "silk", "oinc",5  },
[2] = { "gears","oinc",10 },
[3] = { "mandrake","oinc",50 },
[4] = { "wormlight","oinc",20 },
[5] = { "deerclops_eyeball","oinc",50 },
[6] = { "walrus_tusk","oinc",50 },
[7] = { "bearger_fur","oinc",40 },
[8] = { "goose_feather","oinc",40 },
[9] = { "dragon_scales","oinc",30 },
[10] = { "houndstooth","oinc",5  },
[11] = { "bamboo","oinc",3  },
[12] = { "horn","oinc",5  },
[13] = { "coontail","oinc",4  },
}

local pig_shop_cityhall = {                    
[1] = { "deed","oinc",50  },                  
[2] = { "securitycontract","oinc",10 },
}

local pig_shop_arcane = {                   
[1] = { "icestaff","oinc",50 },
[2] = { "firestaff","oinc",50 },
[3] = { "amulet","oinc",50 },
[4] = { "blueamulet","oinc",50 },
[5] = { "purpleamulet","oinc",50 },
[6] = { "livinglog","oinc",5  },
[7] = { "armorslurper","oinc",20 },
[8] = { "nightsword","oinc",50 },
[9] = { "armor_sanity","oinc",20 },
[10] = { "onemanband","oinc",40 },
} 
local pig_shop_weapons = {
[1] = { "spear","oinc",3  },
[2] = { "halberd","oinc",5  },
[3] = { "cutlass","oinc",50  },
[4] = { "trap_teeth","oinc",10 },
[5] = { "birdtrap","oinc",20 },
[6] = { "trap","oinc",2  },
[7] = { "coconade","oinc",20 },
[8] = { "blowdart_pipe","oinc",10 },
[9] = { "blowdart_sleep","oinc",10 },
[10] = { "boomerang","oinc",10 },
}  

local pig_shop_spears = {
[1] = { "dragon_scales","oinc",30  },
[2] = { "townportaltalisman","oinc",30  },
[3] = { "malbatross_feather","oinc",30  },
[4] = { "trunk_summer","oinc",20 },
[5] = { "goose_feather","oinc",20 },
[6] = { "bearger_fur","oinc",20  },
[7] = { "walrus_tusk","oinc",10 },
[8] = { "deerclops_eyeball","oinc",30 },
[9] = { "deer_antler","oinc",30 },
[10] = { "horn","oinc","oinc",30 },
[11] = { "shark_gills","oinc",30 },
[12] = { "gnarwail_horn","oinc",20 },
[13] = { "shark_fin","oinc",20 },
[14] = { "beaverskin","oinc",10 },
[15] = { "steelwool","oinc",30 },
}   

            
local pig_shop_hatshop = {                       
[1] = { "winterhat","oinc",10 },
[2] = { "tophat","oinc",10 },
[3] = { "earmuffshat","oinc",5  },
[4] = { "peagawkfeatherhat","oinc",10 },
[5] = { "molehat","oinc",20 },
[6] = { "catcoonhat","oinc",10 },
[7] = { "antmaskhat","oinc",20 },
[8] = { "featherhat","oinc",5  },
[9] = { "strawhat","oinc",3  },
[10] = { "beefalohat","oinc",10 },
[11] = { "thunderhat","oinc",10 },
[12] = { "metalplatehat","oinc",10 },
[13] = { "walrushat","oinc",50 },
[14] = { "captainhat","oinc",20 },
}

local pig_shop_bank = {                     
[1] = { "goldnugget","oinc",10 },
[2] = { "oinc10","oinc",10 },
[3] = { "oinc100","oinc",100 },
}        

local pig_shop_tinker = {    
[1] = { "player_house_cottage_craft","oinc",20}, 
[2] = { "player_house_villa_craft","oinc",30}, 
[3] = { "player_house_manor_craft","oinc",30}, 
[4] = { "player_house_tudor_craft","oinc",20}, 
[5] = { "player_house_gothic_craft","oinc",20}, 
[6] = { "player_house_brick_craft","oinc",20}, 
[7] = { "player_house_turret_craft","oinc",20}, 
}  

           
local pig_shop_academy = {

[1] = { "player_house_cottage_craft","oinc",20}, 
[2] = { "player_house_villa_craft","oinc",30}, 
[3] = { "player_house_manor_craft","oinc",30}, 
[4] = { "player_house_tudor_craft","oinc",20}, 
[5] = { "player_house_gothic_craft","oinc",20}, 
[6] = { "player_house_brick_craft","oinc",20}, 
[7] = { "player_house_turret_craft","oinc",20}, 

}

local pig_shop_fishing = {

[1] = { "spoiled_food","oinc",1}, 
[2] = { "berries","oinc",3}, 
[3] = { "seeds","oinc",2}, 
[4] = { "oceanfishinglure_spoon_red","oinc",5}, 
[5] = { "oceanfishinglure_spinner_red","oinc",5}, 
[6] = { "oceanfishinglure_spoon_green","oinc",5}, 
[7] = { "oceanfishinglure_spinner_green","oinc",5}, 
[8] = { "oceanfishinglure_spoon_blue","oinc",5}, 
[9] = { "oceanfishinglure_spinner_blue","oinc",5}, 
[10] = { "twigs","oinc",4}, 
[11] = { "oceanfishingbobber_ball","oinc",20}, 
[12] = { "oceanfishingbobber_oval","oinc",30}, 
[13] = { "oceanfishingbobber_crow","oinc",40}, 
[14] = { "oceanfishingbobber_robin","oinc",40}, 
[15] = { "oceanfishingbobber_robin_winter","oinc",40}, 
[16] = { "oceanfishingbobber_canary","oinc",40}, 
[17] = { "oceanfishingbobber_goose","oinc",100}, 
[18] = { "oceanfishingbobber_malbatross","oinc",100}, 
[19] = { "trinket_8","oinc",100}, 
}

local prefabs =
{

}

local function shopkeeper_speech(inst,speech)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, 20, {"shopkeep"}) 
    for i, ent in ipairs(ents)do
        ent.shopkeeper_speech(ent,speech)
        --ent.components.talker:Say(speech)                   
    end
end

local function SetImage(inst, ent)
    local src = ent 
    local image = nil 

    if src ~= nil and src.components.inventoryitem ~= nil then
        image = src.prefab
        if src.components.inventoryitem.imagename then
            image = src.components.inventoryitem.imagename
        end          
    end 

    if image ~= nil then 
        local texname = image..".tex"
		
	
	local atlas = src.replica.inventoryitem:GetAtlas()

	if ent.caminho then atlas = ent.caminho
	elseif atlas and atlas == "images/inventoryimages1.xml" then atlas = "images/inventoryimages1.xml"
	elseif atlas and atlas == "images/inventoryimages2.xml" then atlas = "images/inventoryimages2.xml"
	else atlas = "images/inventoryimages/hamletinventory.xml" end

    inst.AnimState:OverrideSymbol("SWAP_SIGN", resolvefilepath(atlas), texname)		
		
        --inst.AnimState:OverrideSymbol("SWAP_SIGN", "store_items", image)
        inst.imagename = image
    else
        inst.imagename = ""
        inst.AnimState:ClearOverrideSymbol("SWAP_SIGN")
    end
end 

local function SetImageFromName(inst, name)
    local image = name

    if image ~= nil then 
        local texname = image..".tex"
        inst.AnimState:OverrideSymbol("SWAP_SIGN", resolvefilepath("images/inventoryimages/hamletinventory.xml"), texname)
        --inst.AnimState:OverrideSymbol("SWAP_SIGN", "store_items", image)		
		
        inst.imagename = image
    else
        inst.imagename = ""
        inst.AnimState:ClearOverrideSymbol("SWAP_SIGN")
    end
end 

local function SetCost(inst, costprefab, cost)    

    local image = nil 
    
    if costprefab then
        image = costprefab
    end
    if costprefab == "oinc" and cost then
        image = "cost-"..cost
    end

    if costprefab == "goldenbar" or costprefab == "stonebar" or costprefab == "lucky_goldnugget" then

    if image ~= nil then 
        local texname = image..".tex"
        inst.AnimState:OverrideSymbol("SWAP_COST", resolvefilepath("images/inventoryimages/volcanoinventory.xml"), texname)
        --inst.AnimState:OverrideSymbol("SWAP_SIGN", "store_items", image)		
		
        inst.costimagename = image	
    else
        inst.costimagename = ""
        inst.AnimState:ClearOverrideSymbol("SWAP_COST")
    end	
	
    else
	
    if image ~= nil then 
        local texname = image..".tex"
        inst.AnimState:OverrideSymbol("SWAP_COST", resolvefilepath("images/inventoryimages/hamletinventory.xml"), texname)
        --inst.AnimState:OverrideSymbol("SWAP_SIGN", "store_items", image)		
		
        inst.costimagename = image	
    else
        inst.costimagename = ""
        inst.AnimState:ClearOverrideSymbol("SWAP_COST")
    end
	end
end 

local function SpawnInventory(inst, prefabtype, costprefab, cost)
    inst.costprefab = costprefab
    inst.cost = cost

    local item = nil
    if prefabtype ~= nil then
        item = SpawnPrefab(prefabtype)
    else
        item = SpawnPrefab(inst.prefabtype)
    end

    if item ~= nil then 
        inst:SetImage(item)
        inst:SetCost(costprefab,cost)
        inst.components.shopdispenser:SetItem(item)
        item:Remove()

    end
end 


local function TimedInventory(inst, prefabtype)
    inst.prefabtype = prefabtype 
    local time = 300 + math.random() * 300
    inst.components.shopdispenser:RemoveItem()
    inst:SetImage(nil)
    inst:DoTaskInTime(time, function() inst:SpawnInventory(nil) end)
end 

local function SoldItem(inst)
    inst.components.shopdispenser:RemoveItem()
    inst:SetImage(nil)
end

local function restock(inst,force)
    if inst:HasTag("nodailyrestock") then
--        print("NO DAILY RESTOCK")
        return
    elseif inst:HasTag("robbed") then
        inst.costprefab = "cost-nil"
        SetCost(inst, "cost-nil")    
        shopkeeper_speech(inst,STRINGS.CITY_PIG_SHOPKEEPER_ROBBED[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_ROBBED)])
    elseif not inst:HasTag("justsellonce") or force then
--        print("CHANGING ITEM")


local largura = 10
 
if inst.shoptype == "pig_shop_deli" or inst.shoptype == pig_shop_deli then largura = 12 inst.shoptype = pig_shop_deli end
if inst.shoptype == "pig_shop_florist" or inst.shoptype == pig_shop_florist then largura = 15 inst.shoptype = pig_shop_florist end
if inst.shoptype == "pig_shop_general" or inst.shoptype == pig_shop_general then largura = 15 inst.shoptype = pig_shop_general end
if inst.shoptype == "pig_shop_hoofspa" or inst.shoptype == pig_shop_hoofspa then largura = 7 inst.shoptype = pig_shop_hoofspa end
if inst.shoptype == "pig_shop_produce" or inst.shoptype == pig_shop_produce then largura = 21 inst.shoptype = pig_shop_produce end
if inst.shoptype == "pig_shop_antiquities" or inst.shoptype == pig_shop_antiquities then largura = 13 inst.shoptype = pig_shop_antiquities end
if inst.shoptype == "pig_shop_cityhall" or inst.shoptype == pig_shop_cityhall then largura = 2 inst.shoptype = pig_shop_cityhall end
if inst.shoptype == "pig_shop_arcane" or inst.shoptype == pig_shop_arcane then largura = 10 inst.shoptype = pig_shop_arcane end
if inst.shoptype == "pig_shop_weapons" or inst.shoptype == pig_shop_weapons then largura = 10 inst.shoptype = pig_shop_weapons end
if inst.shoptype == "pig_shop_spears" or inst.shoptype == pig_shop_spears then largura = 15 inst.shoptype = pig_shop_spears end
if inst.shoptype == "pig_shop_hatshop" or inst.shoptype == pig_shop_hatshop then largura = 14 inst.shoptype = pig_shop_hatshop end
if inst.shoptype == "pig_shop_bank" or inst.shoptype == pig_shop_bank then largura = 3 inst.shoptype = pig_shop_bank end
if inst.shoptype == "pig_shop_tinker" or inst.shoptype == pig_shop_tinker then largura = 7 inst.shoptype = pig_shop_tinker end
if inst.shoptype == "pig_shop_academy" or inst.shoptype == pig_shop_academy then largura = 7 inst.shoptype = pig_shop_academy end
if inst.shoptype == "pig_shop_fishing" or inst.shoptype == pig_shop_fishing then largura = 19 inst.shoptype = pig_shop_fishing end

        local newproduct = inst.shoptype[math.random(1, largura)]
        if inst.saleitem then
            newproduct = inst.saleitem
        end
local vendendor = GetClosestInstWithTag("shopkeep", inst, 20)
if vendendor then
		if newproduct == nil then return end
        SpawnInventory(inst, newproduct[1],newproduct[2],newproduct[3])     
end		
    end
end


local function displaynamefn(inst)
    return "whatever"
end

local function onsave(inst, data)    
    data.imagename = inst.imagename
    data.costprefab = inst.costprefab
    data.cost = inst.cost
    data.interiorID = inst.interiorID
    data.startAnim = inst.startAnim 
    data.saleitem = inst.saleitem
    data.justsellonce = inst:HasTag("justsellonce")
    data.nodailyrestock = inst:HasTag("nodailyrestock")
	data.shoptype = inst.shoptype
end

local function onload(inst, data)
    if data then
        if data.imagename then
            SetImageFromName(inst, data.imagename)
        end
        if data.cost then
            inst.cost = data.cost
        end             
        if data.costprefab then
           inst.costprefab = data.costprefab
           SetCost(inst, inst.costprefab, inst.cost)
        end     
        if data.interiorID then
            inst.interiorID  = data.interiorID
        end
        if data.startAnim then
            inst.startAnim = data.startAnim
            inst.AnimState:PlayAnimation(data.startAnim)
        end
        if data.saleitem then
            inst.saleitem = data.saleitem
        end
        if data.justsellonce then
            inst:AddTag("justsellonce")
        end     
        if data.nodailyrestock then
            inst:AddTag("nodailyrestock")   
        end
        if data.shoptype then
            inst.shoptype = data.shoptype  
        end
    end
end

local function setobstical(inst)
    local ground = TheWorld
    if ground then
        local pt = Point(inst.Transform:GetWorldPosition())
        ground.Pathfinder:AddWall(pt.x, pt.y, pt.z)
    end
end

local function common()
    local inst = CreateEntity()
    inst.entity:AddNetwork()
		
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    local minimap = inst.entity:AddMiniMapEntity()    
    inst.MiniMapEntity:SetIcon( "accomplishment_shrine.png" )
	inst.Transform:SetTwoFaced()
    MakeObstaclePhysics(inst, .25)   

    inst.AnimState:SetBank("pedestal")
    inst.AnimState:SetBuild("pedestal_crate")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetFinalOffset(1)

    inst:AddTag("shop_pedestal")

    inst.imagename = nil 
	inst.shoptype = DEFAULT

--    MakeMediumBurnable(inst)
--    MakeSmallPropagator(inst)

    inst.SetImage = SetImage
    inst.SetCost = SetCost
    inst.SetImageFromName = SetImageFromName
    inst.SpawnInventory = SpawnInventory
    inst.TimedInventory = TimedInventory
    inst.shopkeeper_speech = shopkeeper_speech
    inst.SoldItem = SoldItem

    inst.OnSave = onsave 
    inst.OnLoad = onload

    inst.setobstical = setobstical
    inst.setobstical(inst)

    return inst
end


local function buyer()
    local inst = common()
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_deli()
    local inst = common()	
	inst.shoptype = "pig_shop_deli"
	inst.startAnim = "idle_cakestand_dome"
	inst.restock = restock
	

	inst.AnimState:PlayAnimation(inst.startAnim)

	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_florist()
    local inst = common()
inst.shoptype = "pig_shop_florist"
inst.startAnim = "idle_cart"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_general()
    local inst = common()
inst.shoptype = "pig_shop_general"
inst.startAnim = "idle_barrel"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_hoofspa()
    local inst = common()
inst.shoptype = "pig_shop_hoofspa"
inst.startAnim = "idle_cakestand"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_produce()
    local inst = common()
inst.shoptype = "pig_shop_produce"
inst.startAnim = "idle_ice_box"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_antiquities()
    local inst = common()
inst.shoptype = "pig_shop_antiquities"
inst.startAnim = "idle_barrel_dome"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_cityhall()
    local inst = common()
inst.shoptype = "pig_shop_cityhall"
inst.startAnim = "idle_globe_bar"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_arcane()
    local inst = common()
inst.shoptype = "pig_shop_arcane"
inst.startAnim = "idle_marble"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_weapons()
    local inst = common()
inst.shoptype = "pig_shop_weapons"
inst.startAnim = "idle_cablespool"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_spears()
    local inst = common()
inst.shoptype = "pig_shop_spears"
inst.startAnim = "idle_cablespool"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_hatshop()
    local inst = common()
inst.shoptype = "pig_shop_hatshop"
inst.startAnim = "idle_hatbox2" --idle_hatbox1 idle_hatbox3 idle_hatbox4

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
		
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_bank()
    local inst = common()
inst.shoptype = "pig_shop_bank"
inst.startAnim = "idle_marble_dome"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_tinker()
    local inst = common()
inst.shoptype = "pig_shop_tinker"
inst.startAnim = "idle_metal"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end

local function buyer_academy()
    local inst = common()
inst.shoptype = "pig_shop_academy"
inst.startAnim = "idle_stoneslab"

	inst.AnimState:PlayAnimation(inst.startAnim)
	inst.restock = restock	
	
	inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end 
	
    inst:AddComponent("shopdispenser")
    inst:AddComponent("shopped")

	inst:WatchWorldState("isday", restock)
	inst:DoTaskInTime(1, restock)
    return inst
end	




local function seller()
    local inst = common()
    return inst 
end 

return Prefab("shop_buyer", buyer, assets, prefabs),
       Prefab("shop_seller", seller, assets, prefabs),
	   
Prefab("shop_buyer_deli", buyer_deli, assets, prefabs),
Prefab("shop_buyer_florist", buyer_florist, assets, prefabs),
Prefab("shop_buyer_general", buyer_general, assets, prefabs),
Prefab("shop_buyer_hoofspa", buyer_hoofspa, assets, prefabs),
Prefab("shop_buyer_produce", buyer_produce, assets, prefabs),
Prefab("shop_buyer_antiquities", buyer_antiquities, assets, prefabs),
Prefab("shop_buyer_cityhall", buyer_cityhall, assets, prefabs),
Prefab("shop_buyer_arcane", buyer_arcane, assets, prefabs),
Prefab("shop_buyer_weapons", buyer_weapons, assets, prefabs),
Prefab("shop_buyer_spears", buyer_spears, assets, prefabs),
Prefab("shop_buyer_hatshop", buyer_hatshop, assets, prefabs),
Prefab("shop_buyer_bank", buyer_bank, assets, prefabs),
Prefab("shop_buyer_tinker", buyer_tinker, assets, prefabs),
Prefab("shop_buyer_academy", buyer_academy, assets, prefabs)
