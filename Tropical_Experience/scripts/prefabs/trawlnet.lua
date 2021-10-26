local net_assets=
{
    Asset("ANIM", "anim/swap_trawlnet.zip"),
    Asset("ANIM", "anim/swap_trawlnet_half.zip"),
    Asset("ANIM", "anim/swap_trawlnet_full.zip"),
}


local net_prefabs =
{
    "trawlnetdropped"
}

local dropped_assets=
{
    Asset("ANIM", "anim/swap_trawlnet.zip"),
    Asset("ANIM", "anim/ui_chest_3x2.zip"),
}

local chance =
{
    verylow = 1,
    low = 2,
    medium = 4,
    high = 8,
}

local TRAWLNET_MAX_ITEMS = 9  --Don't make this larger than 9 without talking to Dave
local TRAWLNET_ITEM_DISTANCE = 100  --How far you have to travel to get another item
local TRAWLING_SPEED_MULT = -0.25
local TRAWL_SINK_TIME = 30 * 3

local loot =
{
    shallow =
    {
[1] = "seaweed",
[2] = "mussel",
[3] = "lobster_land",
[4] = "jellyfish",
[5] = "fish",
[6] = "coral",
[7] = "messagebottleempty",
[8] = "fish_med",
[9] = "rocks",
[10] = "roe",
    },


    medium =
    {
[1] = "seaweed",
[2] = "mussel",
[3] = "lobster_land",
[4] = "jellyfish",
[5] = "fish",
[6] = "coral",
[7] = "fish_med",
[8] = "messagebottleempty",
[9] = "boneshard",
[10] = "spoiled_fish",
[11] = "dubloon",
[12] = "goldnugget",
[13] = "firestaff",
[14] = "icestaff",
[15] = "panflute",
[16] = "trinket_12",
[17] = "antliontrinket",
[18] = "trinket_17",
[19] = "telescope",
[20] = "roe",
    },

    deep =
    {
[1] = "seaweed",
[2] = "mussel",
[3] = "lobster_land",
[4] = "jellyfish",
[5] = "fish",
[6] = "coral",
[7] = "fish_med",
[8] = "messagebottleempty",
[9] = "boneshard",
[10] = "spoiled_fish",
[11] = "dubloon",
[12] = "goldnugget",
[13] = "spear",
[14] = "firestaff",
[15] = "icestaff",
[16] = "panflute",
[17] = "redgem",
[18] = "bluegem",
[19] = "purplegem",
[20] = "goldenshovel",
[21] = "goldenaxe",
[22] = "razor",
[24] = "compass",
[25] = "amulet",
[26] = "trinket_12",
[27] = "antliontrinket",
[28] = "trinket_17",
[29] = "trident",
[30] = "roe",
[31] = "telescope",
    }
}

local hurricaneloot =
{
    shallow =
    {

--        {"roe", chance.medium},

        {"seaweed", chance.high},
        {"mussel", chance.medium},
        {"lobster_land", chance.medium},
        {"jellyfish", chance.medium},
        {"fish", chance.high},
        {"coral", chance.high},
        {"messagebottleempty", chance.high},
        {"fish_med", chance.medium},
        {"rocks", chance.high},
        {"dubloon", chance.low},
--        {"trinket_16", chance.low},
--        {"trinket_17", chance.low},
    },


    medium =
    {
--         {"roe", chance.medium},

        {"seaweed", chance.high},
        {"mussel", chance.high},
        {"lobster_land", chance.medium},
        {"jellyfish", chance.high},
        {"fish", chance.high},
        {"coral", chance.high},
        {"fish_med", chance.high},
        {"messagebottleempty", chance.high},
        {"boneshard", chance.high},
        {"spoiled_fish", chance.high},
        {"dubloon", chance.medium},
        {"goldnugget", chance.medium},
--        {"telescope", chance.low},
--        {"firestaff", chance.low},
--        {"icestaff", chance.low},
--        {"panflute", chance.low},
--        {"trinket_16", chance.low},
--        {"trinket_17", chance.low},
--        {"trinket_18", chance.verylow},
--        {"trident", chance.verylow},
    },


    deep =
    {
--        {"roe", chance.low},

        {"seaweed", chance.high},
        {"mussel", chance.high},
        {"lobster_land", chance.low},
        {"jellyfish", chance.high},
        {"fish", chance.high},
        {"coral", chance.high},
        {"fish_med", chance.high},
        {"messagebottleempty", chance.high},
        {"boneshard", chance.high},
        {"spoiled_fish", chance.high},
        {"dubloon", chance.medium},
        {"goldnugget", chance.medium},
--        {"telescope", chance.medium},
--        {"firestaff", chance.low},
--        {"icestaff", chance.medium},
--        {"panflute", chance.medium},
--        {"redgem", chance.medium},
--        {"bluegem", chance.medium},
--        {"purplegem", chance.medium},
--        {"goldenshovel", chance.medium},
--        {"goldenaxe", chance.medium},
--        {"razor", chance.medium},
--        {"spear", chance.medium},
--        {"compass", chance.medium},
--        {"amulet", chance.verylow},
--        {"trinket_16", chance.medium},
--        {"trinket_17", chance.medium},
--        {"trinket_18", chance.verylow},
 --       {"trident", chance.low},
    }
}

local dryloot =
{
    shallow =
    {
        {"seaweed", chance.high},
        {"mussel", chance.high},
        {"lobster_land", chance.medium},
        {"jellyfish", chance.medium},
        {"fish", chance.high},
        {"coral", chance.high},
        {"messagebottleempty", chance.high},
        {"fish_med", chance.medium},
        {"rocks", chance.high},
        {"dubloon", chance.low},
        {"obsidian", chance.high},
    },


    medium =
    {
        {"seaweed", chance.high},
        {"mussel", chance.high},
        {"lobster_land", chance.medium},
        {"jellyfish", chance.high},
        {"fish", chance.high},
        {"coral", chance.high},
        {"fish_med", chance.high},
        {"messagebottleempty", chance.high},
        {"boneshard", chance.high},
        {"spoiled_fish", chance.high},
        {"dubloon", chance.medium},
        {"goldnugget", chance.medium},
        {"telescope", chance.low},
--        {"firestaff", chance.medium},
--        {"icestaff", chance.low},
--        {"panflute", chance.low},
--        {"obsidian", chance.medium},
--        {"trinket_16", chance.low},
--        {"trinket_17", chance.low},
--        {"trinket_18", chance.verylow},
--        {"trident", chance.verylow},
    },


    deep =
    {
        {"seaweed", chance.high},
        {"mussel", chance.high},
        {"lobster_land", chance.low},
        {"jellyfish", chance.high},
        {"fish", chance.high},
        {"coral", chance.high},
        {"fish_med", chance.high},
        {"messagebottleempty", chance.high},
        {"boneshard", chance.high},
        {"spoiled_fish", chance.high},
        {"dubloon", chance.medium},
        {"goldnugget", chance.medium},
--        {"telescope", chance.medium},
--        {"firestaff", chance.medium},
--        {"icestaff", chance.low},
--        {"panflute", chance.medium},
--        {"redgem", chance.medium},
--        {"bluegem", chance.medium},
--        {"purplegem", chance.medium},
--        {"goldenshovel", chance.medium},
--        {"goldenaxe", chance.medium},
--        {"razor", chance.medium},
--        {"spear", chance.medium},
--        {"compass", chance.medium},
--        {"amulet", chance.verylow},
--        {"obsidian", chance.medium},
--        {"trinket_16", chance.low},
--        {"trinket_17", chance.low},
--        {"trinket_18", chance.verylow},
--        {"trident", chance.low},
    }
}

local uniqueItems =
{
--    "trinket_16",
--    "trinket_17",
--    "trinket_18",
--    "trident",
}

local function getLootList(inst)
local loottable = loot
 if TheWorld.state.iswinter then
loottable = hurricaneloot
elseif TheWorld.state.issummer then
       loottable = dryloot
end


local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground == GROUND.OCEAN_SWELL then return loottable.medium
elseif ground == GROUND.OCEAN_ROUGH then return loottable.deep
else return loottable.shallow end

end












local function droploot(inst)
if not inst then return end
--if inst.navio then inst.navio.AnimState:ClearOverrideSymbol(inst.symboltooverride, inst.build, inst.symbol) end
--inst.navio = nil
if not inst:HasTag("usada") then return end
if not inst.navio then return end

local chest = SpawnPrefab("trawlnetdropped")
local owner = inst.navio
local x, y, z = owner.Transform:GetWorldPosition()
local pt = Vector3(x,y,z)

chest:DoDetach()
local num = inst.components.inventory:NumItems()

repeat
if inst.raso and inst.raso > 0 then
local item = SpawnPrefab(loot.shallow[math.random(1, 10)])
chest.components.container:GiveItem(item, num + 1)
inst.raso = inst.raso - 1
end
until
inst.raso <= 0 or nil

repeat
if inst.medio and inst.medio > 0 then
local item = SpawnPrefab(loot.medium[math.random(1, 20)])
chest.components.container:GiveItem(item, num + 1)
inst.medio = inst.medio - 1
end
until
inst.medio <= 0 or nil

repeat
if inst.fundo and inst.fundo > 0 then
local item = SpawnPrefab(loot.deep[math.random(1, 31)])
chest.components.container:GiveItem(item, num + 1)
inst.fundo = inst.fundo - 1
end
until
inst.fundo <= 0 or nil

repeat
if inst.seawed and inst.seawed > 0 then
local item = SpawnPrefab("seaweed_stalk")
chest.components.container:GiveItem(item, num + 1)
inst.seawed = inst.seawed - 1
end
until
inst.seawed <= 0 or nil


repeat
if inst.jellyfish and inst.jellyfish > 0 then
local item = SpawnPrefab("jellyfish")
chest.components.container:GiveItem(item, num + 1)
inst.jellyfish = inst.jellyfish - 1
end
until
inst.jellyfish <= 0 or nil


repeat
if inst.lobster and inst.lobster > 0 then
local item = SpawnPrefab("lobster_land")
chest.components.container:GiveItem(item, num + 1)
inst.lobster = inst.lobster - 1
end
until
inst.lobster <= 0 or nil

repeat
if inst.rainbowjellyfish and inst.rainbowjellyfish > 0 then
local item = SpawnPrefab("rainbowjellyfish")
chest.components.container:GiveItem(item, num + 1)
inst.rainbowjellyfish = inst.rainbowjellyfish - 1
end
until
inst.rainbowjellyfish <= 0 or nil


repeat
if inst.mussel and inst.mussel > 0 then
local item = SpawnPrefab("mussel")
chest.components.container:GiveItem(item, num + 1)
inst.mussel = inst.mussel - 1
end
until
inst.mussel <= 0 or nil

if owner then
local angle = owner:GetRotation()
local dist = -3
local offset = Vector3(dist * math.cos(angle*DEGREES), 0, -dist*math.sin(angle*DEGREES))
local chestpos = pt + offset        
chest.Transform:SetPosition(chestpos:Get())
chest:FacePoint(pt:Get())
end

inst.apaga = 1
end

local function gettrawlbuild(inst)
if inst and inst.apaga == 1 then inst:Remove() end
local fullness = (inst.raso + inst.medio + inst.fundo + inst.seawed + inst.jellyfish + inst.lobster + inst.rainbowjellyfish + inst.mussel)/9
if fullness <= 0.33 then inst.build = "swap_trawlnet"
elseif fullness <= 0.66 then inst.build = "swap_trawlnet_half"
else inst.build = "swap_trawlnet_full" end
if (inst.raso + inst.medio + inst.fundo + inst.seawed + inst.jellyfish + inst.lobster + inst.rainbowjellyfish + inst.mussel) > 9.9 then droploot(inst) end
end

local function OnSave(inst, data)
	data.raso = inst.raso
	data.medio = inst.medio
	data.fundo = inst.fundo
	data.seawed = inst.seawed
	data.jellyfish = inst.jellyfish
	data.lobster = inst.lobster
	data.rainbowjellyfish = inst.rainbowjellyfish
	data.mussel = inst.mussel
end

local function OnLoad(inst, data)
if data == nil then return end
if data.raso then inst.raso = data.raso end
if data.medio then inst.medio = data.medio end
if data.fundo then inst.fundo = data.fundo end
if data.seawed then inst.seawed = data.seawed end
if data.jellyfish then inst.jellyfish = data.jellyfish end
if data.lobster then inst.lobster = data.lobster end
if data.rainbowjellyfish then inst.rainbowjellyfish = data.rainbowjellyfish end
if data.mussel then inst.mussel = data.mussel end

end




local function net(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	inst.raso = 0
	inst.medio = 0
	inst.fundo = 0
	inst.seawed = 0
	inst.jellyfish = 0
	inst.lobster = 0
	inst.rainbowjellyfish = 0
	inst.mussel = 0
	inst.apaga = nil
	
    inst.AnimState:SetBank("trawlnet")
    inst.AnimState:SetBuild("swap_trawlnet")
    inst.AnimState:PlayAnimation("idle")
    inst.navio = nil
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
    inst.build = "swap_trawlnet"
    inst.symbol = "swap_trawlnet"
    inst.symboltooverride = "swap_trawlnet" --swap_lantern_off

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    inst:AddTag("trawlnet")
	inst:AddTag("aquatic")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
	
	inst:AddComponent("inventory")
    inst.components.inventory.maxslots = TRAWLNET_MAX_ITEMS
    inst.components.inventory.show_invspace = true

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
	inst:ListenForEvent("onpickup", droploot)
    inst.rowsound = "dontstarve_DLC002/common/trawl_net/move_LP"
	inst:DoPeriodicTask(1, gettrawlbuild)
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
    return inst
end


local function sink(inst, instant)
    if not instant then
        inst.AnimState:PlayAnimation("sink_pst")
        inst:ListenForEvent("animover", function()
            inst.components.container:DropEverything()            
            inst:Remove()
        end)
    else
        -- this is to catch the nets that for some reason dont have the right timer save data. 
        inst.components.container:DropEverything()
        inst:Remove()
    end
end

local function getsinkstate(inst)
    if inst.components.timer:TimerExists("sink") then
        return "sink"
    elseif inst.components.timer:TimerExists("startsink") then
        return "full"
    end
    return "sink"
end

local function startsink(inst)
    inst.AnimState:PlayAnimation("full_to_sink")
    inst.components.timer:StartTimer("sink", TRAWL_SINK_TIME * 1/3)
    inst.AnimState:PushAnimation("idle_"..getsinkstate(inst), true)
end


local function dodetach(inst)
    inst.components.timer:StartTimer("startsink", TRAWL_SINK_TIME * 2/3)
    inst.AnimState:PlayAnimation("detach")
    inst.AnimState:PushAnimation("idle_"..getsinkstate(inst), true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/trawl_net/detach")
end

local function onopen(inst)
    inst.AnimState:PlayAnimation("interact_"..getsinkstate(inst)) --TODO: uncomment this when this anim exists
    inst.AnimState:PushAnimation("idle_"..getsinkstate(inst), true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/trawl_net/open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("interact_"..getsinkstate(inst)) --TODO: uncomment this when this anim exists
    inst.AnimState:PushAnimation("idle_"..getsinkstate(inst), true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/trawl_net/close")
end

local function ontimerdone(inst, data)
    if data.name == "startsink" then
        startsink(inst)
    end

    if data.name == "sink" then
        sink(inst)
    end
    -- These are sticking around some times.. maybe the timer name is being lost somehow? This will catch that?
    if data.name ~= "sink" and data.name ~= "startsink" then
        sink(inst)
    end
end


local function getstatusfn(inst, viewer)
    local sinkstate = getsinkstate(inst)
    local timeleft = (inst.components.timer and inst.components.timer:GetTimeLeft("sink")) or TRAWL_SINK_TIME
    if sinkstate == "sink" then
        return "SOON"
    elseif sinkstate == "full" and timeleft <= (TRAWL_SINK_TIME * 0.66) * 0.5 then
        return "SOONISH"
    else
        return "GENERIC"
    end
end

local function onloadtimer(inst)
    if not inst.components.timer:TimerExists("sink") and not inst.components.timer:TimerExists("startsink") then
        print("TRAWL NET HAD NO TIMERS AND WAS FORCE SUNK")
        sink(inst, true)
    end
end

local function onload(inst, data)
    inst.AnimState:PlayAnimation("idle_"..getsinkstate(inst), true)    
end

local function dropped_net()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
    inst.Transform:SetTwoFaced()

    inst:AddTag("structure")
    inst:AddTag("chest")
	inst:AddTag("aquatic")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.AnimState:SetBank("trawlnet")
    inst.AnimState:SetBuild("swap_trawlnet")
    inst.AnimState:PlayAnimation("idle_full", true)
    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )

    MakeInventoryPhysics(inst)

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatusfn

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("trawlnetdropped")
    inst.replica.container:WidgetSetup("trawlnetdropped")

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", ontimerdone)
    inst.onloadtimer = onloadtimer

    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst.DoDetach = dodetach

    -- this task is here because sometimes the savedata on the timer is empty.. so no timers are reloaded.
    -- when that happens, the nets sit around forever. 
    inst:DoTaskInTime(0,function() onloadtimer(inst) end)

    inst.OnLoad = onload

    return inst
end

return Prefab( "common/inventory/trawlnet", net, net_assets, net_prefabs),
Prefab( "common/inventory/trawlnetdropped", dropped_net, dropped_assets)