local Badge = require "widgets/badge"

local IRON_LORD_DAMAGE = 16
local IRON_LORD_TIME = 180

local assets =
{
	Asset("ANIM", "anim/living_artifact.zip"),
	Asset("ANIM", "anim/living_suit_build.zip"),
	Asset("ANIM", "anim/player_living_suit_morph.zip"),
	Asset("ANIM", "anim/player_living_suit_punch.zip"),
	Asset("ANIM", "anim/player_living_suit_shoot.zip"),
	Asset("ANIM", "anim/player_living_suit_destruct.zip"),
}


local function BecomeIronLord(inst,instant)
    player.components.worker:SetAction(ACTIONS.CHOP, 4)
    player.components.worker:SetAction(ACTIONS.MINE, 3)
    player.components.worker:SetAction(ACTIONS.HAMMER, 3)
    player.components.worker:SetAction(ACTIONS.HACK, 2)    
end

local function Revert(inst)       
--    player:DoTaskInTime(0,function()player.sg:GoToState("bucked_post") end)
end



local function onequip(inst, owner) 
if owner:HasTag("aquatic") then

else

owner.AnimState:AddOverrideBuild("player_living_suit_morph")
owner:AddTag("ironlord")
owner:AddTag("laser_immune")
owner:AddTag("mech")
owner:SetStateGraph("SGironlord")
owner.components.combat:SetDefaultDamage(IRON_LORD_DAMAGE)
owner.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED*1.3
inst.nightlight = SpawnPrefab("living_artifact_light")
owner:AddChild(inst.nightlight)

owner.sg:GoToState("morph")

if inst.components.fueled ~= nil then
inst.components.fueled:StartConsuming()
end
--owner:DoTaskInTime(2, function()
--            player.components.talker:Say(GetString(player.prefab, "ANNOUNCE_SUITUP"))
--end) 


--end)
end
end

local function onunequip(inst, owner) 
if owner:HasTag("aquatic") then

else
owner.sg:GoToState("explode")
inst.nightlight:Remove()
if inst.components.fueled ~= nil then
inst.components.fueled:StopConsuming()
end

end
owner.components.health:SetInvincible(false)
end



local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
    inst.entity:AddNetwork()	

    inst.AnimState:SetBank("living_artifact")
    inst.AnimState:SetBuild("living_artifact")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    
    inst:AddComponent("inspectable")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
--    inst.components.equippable.walkspeedmult = ARMORMETAL_SLOW
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "LIVINGARTIFACT"
	inst.components.fueled:InitializeFuelLevel(300)
	inst.components.fueled:SetDepletedFn(inst.Remove)

--    inst.components.fueled.ontakefuelfn = ontakefuel
    inst.components.fueled.accepting = true	
	
	
	
	
    return inst
end

local function displaynamefn(inst)
	return ""
end

local function lightfn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()
	inst.displaynamefn = displaynamefn

    inst.entity:AddLight()
    inst.Light:Enable(true)
    inst.Light:SetRadius(5)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.6)
    inst.Light:SetColour(245/255,150/255,0/255)
    inst:DoTaskInTime(0,function()
        if inst:HasTag("lightsource") then       
            inst:RemoveTag("lightsource")    
        end
    end)   
    return inst
end

return Prefab( "common/inventory/living_artifact", fn, assets),
       Prefab( "common/inventory/living_artifact_light", lightfn, assets)
