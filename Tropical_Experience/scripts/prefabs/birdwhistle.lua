local assets=
{
	Asset("ANIM", "anim/antler.zip"),
    Asset("ANIM", "anim/swap_antler.zip"),    
}

local function onfinished(inst)
    inst:Remove()    
end

local function OnPlayed(inst, musician)
if musician then
local a, b, c = musician.Transform:GetWorldPosition()
local casa = GetClosestInstWithTag("blows_air", musician, 30)
if not casa then
local vento = SpawnPrefab("roc")
vento.Transform:SetPosition(a, b, c)
end
end
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	
	inst:AddTag("horn3")
    
    inst.AnimState:SetBank("antler")
    inst.AnimState:SetBuild("antler")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
    
    inst:AddComponent("inspectable")
    inst:AddComponent("instrument")
    inst.components.instrument.range = 0
    inst.components.instrument.onplayed = OnPlayed
    inst.components.instrument.sound_noloop = "dontstarve_DLC003/common/crafted/roc_flute"
    
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.PLAY)
    
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(5)
    inst.components.finiteuses:SetUses(5)
    inst.components.finiteuses:SetOnFinished(onfinished)
    inst.components.finiteuses:SetConsumption(ACTIONS.PLAY, 1)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"		

    inst.hornbuild = "swap_antler"
    inst.hornsymbol = "swap_antler"    

    return inst
end

return Prefab( "common/inventory/antler", fn, assets) 
