local assets=
{
	Asset("ANIM", "anim/telescope.zip"),
	Asset("ANIM", "anim/telescope_long.zip"),
	Asset("ANIM", "anim/swap_telescope.zip"),
	Asset("ANIM", "anim/swap_telescope_long.zip"),
	Asset("INV_IMAGE", "supertelescope"),
	--Asset("INV_IMAGE", "telescope_long"),
}

local prefabs =
{
}

local TELESCOPE_USES = 5
local TELESCOPE_RANGE = 200
local TELESCOPE_ARC = 15
local SUPERTELESCOPE_RANGE = 400


local function onfinished(inst)
	local user = inst.components.inventoryitem:GetGrandOwner()
	if not user then
		inst:Remove()
	else
		user:ListenForEvent("animover", function() 
			inst:Remove()
		end)
	end
end

local function onequip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_object", "swap_telescope", "swap_object")
	owner.AnimState:Show("ARM_carry") 
	owner.AnimState:Hide("ARM_normal") 
end

local function onsuperequip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_object", "swap_telescope_long", "swap_object")
	owner.AnimState:Show("ARM_carry") 
	owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner)
	-- print("telescope onunequip")
	-- --print(debug.traceback())
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal") 
end

local function onunwrapped(inst)
if not inst then return end
local doer = inst.components.inventoryitem.owner
if not doer then return end
local x, y, z = doer.Transform:GetWorldPosition()
inst.components.finiteuses:Use(1)

	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/use_spyglass_reveal")
local numerodeitens
if inst:HasTag("supertelescope") then
numerodeitens = 450
else
numerodeitens = 200
end
local dist = 1

repeat
local angle = doer:GetRotation()
dist = dist + 1
local offset = Vector3(dist * math.cos(angle*DEGREES), 0, -dist*math.sin(angle*DEGREES))
local pt = Vector3(x,y,z)
local chestpos = pt + offset
local x, y, z = chestpos:Get()

-------------------coloca os itens------------------------
TheWorld.minimap.MiniMap:ShowArea(x, y, z, 30)
doer.player_classified.MapExplorer:RevealArea(x, 0, z)
numerodeitens = numerodeitens - 1
-----------------------------------------------------------
until
numerodeitens <= 0

end

local function normalfn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
	inst.AnimState:SetBank("telescope")
	inst.AnimState:SetBuild("telescope")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("nopunch")
	inst:AddTag("telescope")
	inst:AddTag("allow_action_on_impassable")	
    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TELESCOPE_USES)
	inst.components.finiteuses:SetUses(TELESCOPE_USES)
	inst.components.finiteuses:SetOnFinished(onfinished)
	-------
	
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable:SetOnEquip(onequip)	
	
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(onunwrapped)
    inst.components.spellcaster.canuseonpoint = true
	inst.components.spellcaster.quickcast = true
	inst.components.spellcaster.canuseonpoint_water = true
		
	return inst
end

local function superfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
	inst.AnimState:SetBank("telescope_long")
	inst.AnimState:SetBuild("telescope_long")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("nopunch")
	inst:AddTag("telescope")
	inst:AddTag("supertelescope")
	inst:AddTag("allow_action_on_impassable")
    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TELESCOPE_USES)
	inst.components.finiteuses:SetUses(TELESCOPE_USES)
	inst.components.finiteuses:SetOnFinished(onfinished)
	-------
	
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnUnequip(onunequip)
	
	inst.components.equippable:SetOnEquip(onsuperequip)

	inst:AddComponent("reticule")
	inst.components.reticule.targetfn = function() 
        return Vector3(ThePlayer.entity:LocalToWorldSpace(5,0,0))
    end
	inst.components.reticule.ease = true

    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(onunwrapped)
    inst.components.spellcaster.canuseonpoint = true
	inst.components.spellcaster.quickcast = true
	inst.components.spellcaster.canuseonpoint_water = true	
	return inst
end

return Prefab( "common/inventory/telescope", normalfn, assets, prefabs),
	   Prefab( "common/inventory/supertelescope", superfn, assets, prefabs)
