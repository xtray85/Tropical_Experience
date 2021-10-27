local assets=
{
	Asset("ANIM", "anim/armor_vortex_cloak.zip"),
    Asset("ANIM", "anim/cloak_fx.zip"),
}

local ARMORVORTEX = 150*3
local ARMORVORTEX_ABSORPTION = 1

local function setsoundparam(inst)
    local param = Remap(inst.components.armor.condition, 0, inst.components.armor.maxcondition,0, 1 ) 
    inst.SoundEmitter:SetParameter( "vortex", "intensity", param )
end

local function spawnwisp(owner)
    local wisp = SpawnPrefab("armorvortexcloak_fx")
    local x,y,z = owner.Transform:GetWorldPosition()
    wisp.Transform:SetPosition(x+math.random()*0.25 -0.25/2,y,z+math.random()*0.25 -0.25/2) 

local armadura = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
if armadura and armadura:HasTag("vortex_cloak") and armadura.components.armor.condition <= 0 then armadura.components.armor:SetAbsorption(0) end
if armadura and armadura:HasTag("vortex_cloak") and armadura.components.armor.condition > 0 then armadura.components.armor:SetAbsorption(1) end
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_vortex_cloak", "swap_body")
    local function OnBlocked()
        if inst.components.armor.condition and inst.components.armor.condition > 0 then
            owner:AddChild(SpawnPrefab("vortex_cloak_fx"))                    
        end        
        setsoundparam(inst)
    end
    inst.OnBlocked = OnBlocked
	
    inst:ListenForEvent("armorhit", inst.OnBlocked)

    owner:AddTag("not_hit_stunned")
--    owner.components.inventory:SetOverflow(inst)
    inst.components.container:Open(owner)    
    inst.wisptask = inst:DoPeriodicTask(0.1,function() spawnwisp(owner) end)  
    setsoundparam(inst)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("armorhit", inst.OnBlocked)
    owner:RemoveTag("not_hit_stunned")
--    owner.components.inventory:SetOverflow(nil)
    inst.components.container:Close(owner)    
    if inst.wisptask then
        inst.wisptask:Cancel()
        inst.wisptask= nil
    end

--    inst.SoundEmitter:KillSound("vortex")
end

local function nofuel(inst)

end

local function ontakefuel(inst)
    if inst.components.armor.condition and inst.components.armor.condition < 0 then
        inst.components.armor:SetCondition(0)
    end
    inst.components.armor:SetCondition( math.min( inst.components.armor.condition + (inst.components.armor.maxcondition/10), inst.components.armor.maxcondition) )
	local player = inst.components.inventoryitem.owner
	if player then 
    player.components.sanity:DoDelta(-TUNING.SANITY_TINY)
	end	
end

local function fn()
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()	
    
    inst.AnimState:SetBank("armor_vortex_cloak")
    inst.AnimState:SetBuild("armor_vortex_cloak")
    inst.AnimState:PlayAnimation("anim")

    MakeInventoryFloatable(inst)  	
	
    inst:AddTag("vortex_cloak")	
	
    inst.entity:SetPristine()

    inst.entity:SetPristine()
	if not TheWorld.ismastersim then	
	inst.OnEntityReplicated = function(inst) inst.replica.container:WidgetSetup("backpack") end	
	return inst
	end
        
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")    
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"		
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem.cangoincontainer = false
    
    inst:AddComponent("container")
	inst.components.container:WidgetSetup("backpack")

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "NIGHTMARE"
    inst.components.fueled:InitializeFuelLevel(4 * TUNING.LARGE_FUEL)

    inst.components.fueled.ontakefuelfn = ontakefuel
    inst.components.fueled.accepting = true

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(ARMORVORTEX, ARMORVORTEX_ABSORPTION)
    inst.components.armor.dontremove = true
    inst.components.armor:SetImmuneTags({"shadow"})
--    inst.components.armor.bonussanitydamage = 0.3
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    --inst.components.equippable.dapperness = TUNING.CRAZINESS_MED
    
    return inst
end

local function fxfn()
    local inst = CreateEntity()
	inst.entity:AddNetwork()    
    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("cloakfx")
    inst.AnimState:SetBuild("cloak_fx")
    inst.AnimState:PlayAnimation("idle",true)    
	
    inst:AddTag("fx")
	
    for i=1,14 do
        inst.AnimState:Hide("fx"..i)
    end
    inst.AnimState:Show("fx"..math.random(1,14))

    inst:ListenForEvent("animover", function() inst:Remove() end) 

    return inst
end

return Prefab( "common/inventory/armorvortexcloak", fn, assets),
        Prefab( "common/inventory/armorvortexcloak_fx", fxfn, assets) 
