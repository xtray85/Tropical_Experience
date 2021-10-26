require "prefabutil"
require "recipes"

local assets =
{
	Asset("ANIM", "anim/pig_house_sale.zip"),
	
	
    Asset("ANIM", "anim/player_small_house1.zip"),
    Asset("ANIM", "anim/player_large_house1.zip"),
    Asset("ANIM", "anim/player_large_house1_manor_build.zip"),
    Asset("ANIM", "anim/player_large_house1_villa_build.zip"),
    Asset("ANIM", "anim/player_small_house1_cottage_build.zip"),
    Asset("ANIM", "anim/player_small_house1_tudor_build.zip"),
    Asset("ANIM", "anim/player_small_house1_gothic_build.zip"),
    Asset("ANIM", "anim/player_small_house1_brick_build.zip"),
    Asset("ANIM", "anim/player_small_house1_turret_build.zip"),	
}



local prefabs = 
{

}

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
    	inst.AnimState:PlayAnimation("hit")
    	inst.AnimState:PushAnimation("idle")
    end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
	
	data.build = inst.build	
	data.bank = inst.bank
end

local function onload(inst, data)
    if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
	
    if data and data.build then
        inst.build = data.build
        inst.AnimState:SetBuild(inst.build)
    end	
	
    if data and data.bank then
        inst.bank = data.bank
        inst.AnimState:SetBank(inst.bank)
    end		
end


--------------------------------------do teleporter------------------------
local function OnDoneTeleporting(inst, obj)
    if obj and obj:HasTag("player") then
	obj.mynetvarCameraMode:set(3)
	end
end
local function StartTravelSound(inst, doer)
    doer.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/store/door_open")
--    doer:PushEvent("wormholetravel", WORMHOLETYPE.WORM) --Event for playing local travel sound
end

local function OnActivateByOther(inst, source, doer)
--	if not inst.sg:HasStateTag("open") then
--		inst.sg:GoToState("opening")
--	end
	if doer ~= nil and doer.Physics ~= nil then
		doer.Physics:CollidesWith(COLLISION.WORLD)
	end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)
	doer.mynetvarCameraMode:set(1)

        local other = inst.components.teleporter.targetTeleporter
        if other ~= nil then
            DeleteCloseEntsWithTag("WORM_DANGER", other, 15)
        end
	
        --Sounds are triggered in player's stategraph
    elseif inst.SoundEmitter ~= nil then
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/store/door_close")
    end
end

local function ShouldAcceptItem(inst, item)
    if item:HasTag("decoradordecasa") then 
        return true
    else
	return false
	end
end

local function OnGetItemFromPlayer(inst, giver, item)
if item.prefab == "player_house_cottage_craft" then
	inst.build = "player_small_house1_cottage_build"
	inst.AnimState:SetBuild("player_small_house1_cottage_build")
	inst.bank = "playerhouse_small"		
	inst.AnimState:SetBank("playerhouse_small")		
end

if item.prefab == "player_house_villa_craft" then
	inst.build = "player_large_house1_villa_build"
	inst.AnimState:SetBuild("player_large_house1_villa_build")
	inst.bank = "playerhouse_large"		
	inst.AnimState:SetBank("playerhouse_large")		
end

if item.prefab == "player_house_manor_craft" then
	inst.build = "player_large_house1_manor_build"
	inst.AnimState:SetBuild("player_large_house1_manor_build")
	inst.bank = "playerhouse_large"		
	inst.AnimState:SetBank("playerhouse_large")		
end

if item.prefab == "player_house_tudor_craft" then
	inst.build = "player_small_house1_tudor_build"
	inst.AnimState:SetBuild("player_small_house1_tudor_build")
	inst.bank = "playerhouse_small"		
	inst.AnimState:SetBank("playerhouse_small")		
end

if item.prefab == "player_house_gothic_craft" then
	inst.build = "player_small_house1_gothic_build"
	inst.AnimState:SetBuild("player_small_house1_gothic_build")
	inst.bank = "playerhouse_small"		
	inst.AnimState:SetBank("playerhouse_small")		
end

if item.prefab == "player_house_brick_craft" then
	inst.build = "player_small_house1_brick_build"
	inst.AnimState:SetBuild("player_small_house1_brick_build")
	inst.bank = "playerhouse_small"		
	inst.AnimState:SetBank("playerhouse_small")		
end

if item.prefab == "player_house_turret_craft" then
	inst.build = "player_small_house1_turret_build"
	inst.AnimState:SetBuild("player_small_house1_turret_build")
	inst.bank = "playerhouse_small"	
	inst.AnimState:SetBank("playerhouse_small")	
end





end

local function onhammered(inst, worker)
local targetpos = inst:GetPosition()
local package = SpawnPrefab("bundled_structure")
if package and package.components.bundled_structure then
if inst.components.teleporter ~= nil and inst.components.teleporter:IsBusy() then
return false
end
package.components.bundled_structure:Pack(inst)
package.Transform:SetPosition(targetpos:Get())
SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
if worker and worker.SoundEmitter then
worker.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
end
end
end

local function makehousefn(name,build, bank, data)

    local function fn(Sim)
    	local inst = CreateEntity()
    	local trans = inst.entity:AddTransform()
    	local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
		inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()
		inst.build = build

    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon("pig_house_sale.png" )

        light:SetFalloff(1)
        light:SetIntensity(.5)
        light:SetRadius(1)
        light:Enable(false)
        light:SetColour(180/255, 195/255, 50/255)
		inst.Transform:SetScale(0.75, 0.75, 0.75)
        
        MakeObstaclePhysics(inst, 1.25)

        anim:SetBank("pig_house_sale")
        anim:SetBuild(build)
        anim:PlayAnimation("idle",true)
		inst.AnimState:Hide("boards")		

        inst:AddTag(name)
        inst:AddTag("structure")
		inst:AddTag("hamletteleport")
		inst:AddTag("casadejogador")		
		
		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end		
		
        inst:AddComponent("lootdropper")
        inst:AddComponent("interactions")

		inst:AddComponent("teleporter")
		inst.components.teleporter.onActivate = OnActivate
		inst.components.teleporter.onActivateByOther = OnActivateByOther
		inst.components.teleporter.offset = 0
		inst.components.teleporter.hamlet = true	
		inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
		inst:ListenForEvent("doneteleporting", OnDoneTeleporting)	
		
        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        inst.components.trader.onaccept = OnGetItemFromPlayer

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(8)
    	inst.components.workable:SetOnFinishCallback(onhammered)
    	inst.components.workable:SetOnWorkCallback(onhit)		
  
		
        inst:AddComponent("inspectable")    
    	
    	MakeSnowCovered(inst, .01)

        inst.OnSave = onsave 
        inst.OnLoad = onload

    	inst:ListenForEvent( "onbuilt", onbuilt)

        if data and data.sounds then
            inst.usesounds = data.sounds
        end

        return inst
    end
    return fn
end

local function makehouse(name, build, bank, data)   
    return Prefab("common/objects/" .. name, makehousefn(name, build, bank, data), assets, prefabs )
end

return makehouse("playerhouse_city",     "pig_house_sale",       nil,    {indestructable=true} ),	 	   
       MakePlacer("common/playerhouse_city_placer", "pig_house_sale", "pig_house_sale", "idle")