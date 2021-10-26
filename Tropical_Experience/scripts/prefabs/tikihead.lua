local assets =
{
	Asset("ANIM", "anim/tiki_head.zip"),
    Asset("SOUND", "sound/monkey.fsb"),
    Asset("MINIMAP_IMAGE", "monkey_barrel"),
}

local prefabs =
{
    "monkey",
    "poop",
    "cave_banana",
    "collapse_small",
}

local function shake2(inst)	
    inst.AnimState:PushAnimation("shake")	
    inst.AnimState:PushAnimation("idle")	
    inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey/barrel_rattle")
	
	local pt = inst:GetPosition()	
	local x, y, z = pt:Get()
	local y1 = y+3
	local ponto=Vector3(x,y1,z)	
	
	inst:DoTaskInTime(6, inst.components.lootdropper:DropLoot(ponto))
end

local function shake(inst)
    inst.AnimState:PlayAnimation("move2")
    inst.AnimState:PushAnimation("hit")	
    inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey/barrel_rattle")
	inst:DoTaskInTime(8, shake2)
end

local function ShouldAcceptItem(inst, item)
	if item.prefab == "goldnugget" or item.prefab == "redgem" or item.prefab == "bluegem" or item.prefab == "purplegem" or item.prefab == "orangegem" or item.prefab == "yellowgem" or item.prefab == "greengem" then
		return true
	else	
		return false
	end
end

local function OnGetItemFromPlayer(inst, giver, item)
	-- print("Slot machine takes your dubloon.")
	giver.components.sanity:DoDelta(-TUNING.SANITY_TINY)
	
	if item.prefab == "goldnugget" then
	inst.components.lootdropper:AddRandomLoot("trinket_4",1)
	inst.components.lootdropper:AddRandomLoot("peg_leg", 3)
	inst.components.lootdropper:AddRandomLoot("tunacan", 4)
	inst.components.lootdropper:AddRandomLoot("fabric", 5)
	inst.components.lootdropper:AddRandomLoot("dubloon", 5)
	inst.components.lootdropper:AddRandomLoot("fish_raw",5)
	inst.components.lootdropper:AddRandomLoot("coconut",5)
	inst.components.lootdropper:AddRandomLoot("tikimask",3)
	inst.components.lootdropper:AddRandomLoot("shark_gills",1)
	inst.components.lootdropper:AddRandomLoot("gears",2)
	inst.components.lootdropper:AddRandomLoot("gunpowder",2)
	inst.components.lootdropper:AddRandomLoot("pigskin",4)
	inst.components.lootdropper:AddRandomLoot("antidote",4)
	inst.components.lootdropper:AddRandomLoot("poop",5)
	inst.components.lootdropper:AddRandomLoot("cave_banana",5)	
	inst.components.lootdropper:AddRandomLoot("trinket_4",3)		
    inst.components.lootdropper:AddRandomLoot("shark_fin",3)
    inst.components.lootdropper:AddRandomLoot("harpoon",1)
    inst.components.lootdropper:AddRandomLoot("needlespear",1)
    inst.components.lootdropper:AddRandomLoot("ox_horn",1)
	inst.components.lootdropper:AddRandomLoot("limestone",4)
	inst.components.lootdropper:AddRandomLoot("limestone",5)
	inst.components.lootdropper:AddRandomLoot("fish_med",4)
	end
	
	if item.prefab == "redgem" or item.prefab == "bluegem" or item.prefab == "purplegem" then
	inst.components.lootdropper.randomloot = {}
	inst.components.lootdropper.totalrandomweight = 0	
	inst.components.lootdropper:AddRandomLoot("pig_coin",2)
	inst.components.lootdropper:AddRandomLoot("tigereye",1)
	inst.components.lootdropper:AddRandomLoot("peg_leg",4)
	inst.components.lootdropper:AddRandomLoot("doydoyegg",3)
	inst.components.lootdropper:AddRandomLoot("doydoyfeather",2)
	inst.components.lootdropper:AddRandomLoot("obsidian",2)
	inst.components.lootdropper:AddRandomLoot("snakeskinsail",2)
	inst.components.lootdropper:AddRandomLoot("obsidiancoconade",3)
	inst.components.lootdropper:AddRandomLoot("obsidianaxe",1)
	inst.components.lootdropper:AddRandomLoot("goldenaxe",2)
	inst.components.lootdropper:AddRandomLoot("piratepack",1)
	inst.components.lootdropper:AddRandomLoot("gunpowder",3)
	inst.components.lootdropper:AddRandomLoot("tikimask",4)
	inst.components.lootdropper:AddRandomLoot("antidote",5)
	inst.components.lootdropper:AddRandomLoot("cave_banana",5)	
	inst.components.lootdropper:AddRandomLoot("tunacan",4)
	inst.components.lootdropper:AddRandomLoot("shark_gills",2)
	inst.components.lootdropper:AddRandomLoot("messagebottle",2)
	inst.components.lootdropper:AddRandomLoot("cutlass",1)
	inst.components.lootdropper:AddRandomLoot("harpoon",3)
	inst.components.lootdropper:AddRandomLoot("needlespear",3)
	inst.components.lootdropper:AddRandomLoot("ox_horn",3)
	inst.components.lootdropper:AddRandomLoot("dorsalfin",3)
	inst.components.lootdropper:AddRandomLoot("limestone",5)
	inst.components.lootdropper:AddRandomLoot("tar",4)
	inst.components.lootdropper:AddRandomLoot("corallarve",2)
	inst.components.lootdropper:AddRandomLoot("fish_med",4)
	inst.components.lootdropper:AddRandomLoot("lobster",2)

	end	
	
	if item.prefab == "yellowgem" or item.prefab == "greengem" or item.prefab == "orangegem" then
	inst.components.lootdropper.randomloot = {}
	inst.components.lootdropper.totalrandomweight = 0	
	inst.components.lootdropper:AddRandomLoot("pig_coin",3)
	inst.components.lootdropper:AddRandomLoot("tigereye",2)
	inst.components.lootdropper:AddRandomLoot("doydoyfeather",4)
	inst.components.lootdropper:AddRandomLoot("obsidianaxe",3)
	inst.components.lootdropper:AddRandomLoot("obsidiancoconade",3)
	inst.components.lootdropper:AddRandomLoot("dragoonheart",2)
	inst.components.lootdropper:AddRandomLoot("spear_obsidian",3)
	inst.components.lootdropper:AddRandomLoot("armorobsidian",3)
	inst.components.lootdropper:AddRandomLoot("feathersail",4)
	inst.components.lootdropper:AddRandomLoot("ironwind",1)
	inst.components.lootdropper:AddRandomLoot("quackenbeak",1)
	inst.components.lootdropper:AddRandomLoot("piratepack",2)
	inst.components.lootdropper:AddRandomLoot("tunacan",5)
	inst.components.lootdropper:AddRandomLoot("obsidian",4)
	inst.components.lootdropper:AddRandomLoot("shark_gills",4)
	inst.components.lootdropper:AddRandomLoot("messagebottle",3)
	inst.components.lootdropper:AddRandomLoot("woodlegshat",1)
	inst.components.lootdropper:AddRandomLoot("cutlass",3)
	inst.components.lootdropper:AddRandomLoot("harpoon",4)
	inst.components.lootdropper:AddRandomLoot("trident",1)
	inst.components.lootdropper:AddRandomLoot("needlespear",4)
	inst.components.lootdropper:AddRandomLoot("ox_horn",4)
	inst.components.lootdropper:AddRandomLoot("dorsalfin",4)
	inst.components.lootdropper:AddRandomLoot("tar",5)
	inst.components.lootdropper:AddRandomLoot("corallarve",4)
	inst.components.lootdropper:AddRandomLoot("lobster",4)
	end		
	
	if inst._activetask == nil and not inst:HasTag("burnt") then
	inst:DoTaskInTime(.1, shake)
    if not inst.SoundEmitter:PlayingSound("idlesound") then
    inst.SoundEmitter:KillSound("loop")
    inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl2_idle_LP", "idlesound")
    end
    end
end

local function OnRefuseItem(inst, item)
	-- print("Slot machine refuses "..tostring(item.prefab))
end

-------------------------------------------------------
local function fn()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeObstaclePhysics( inst, 1)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("tiki.tex")
	minimap:SetPriority( 5 )

    inst:AddTag("structure")

    anim:SetBank("barrel")
    anim:SetBuild("tiki_head")
    anim:PlayAnimation("idle", true)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
       return inst
    end	

    inst:AddComponent("inspectable")
	
	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem		
	
	inst:AddComponent("lootdropper")

	inst.components.lootdropper.numrandomloot = 1

	inst:AddComponent("combat")
	
	return inst
end

return Prefab( "cave/objects/tikihead", fn, assets, prefabs)







