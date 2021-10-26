require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/quacken_drill.zip"),
	Asset("SOUND", "sound/common.fsb"),
}
 
local prefabs =
{

}

local function spawnoil(inst,pt)	
	local oil = SpawnPrefab("tar_pool") 
	if oil then 
		oil.Transform:SetPosition(pt.x, pt.y, pt.z) 
		oil.AnimState:PlayAnimation("place")
		oil.AnimState:PushAnimation("idle",true)
	end
	inst:Remove()
end

local function nextstage(inst,pt)
	if not inst.drillstage then
		inst.AnimState:PlayAnimation("idle",true)
		inst.drillstage = 1
		inst:DoTaskInTime(2,function(inst) nextstage(inst,pt)  end)

	elseif inst.drillstage == 1 then
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/quacken_drill/drill") 
		inst.AnimState:PlayAnimation("drill")	
		inst:ListenForEvent("animover", function(inst) nextstage(inst,pt)  end)
		inst.drillstage = 2
	else
		local SHAKE_DIST = 40
		local player = GetClosestInstWithTag("player", inst, SHAKE_DIST)			
		inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/quacken_drill/underwater_hit") 	
--		player.components.playercontroller:ShakeCamera(inst, "FULL", 0.7, 0.02, 3, SHAKE_DIST)		
		inst:Hide()
		inst:DoTaskInTime(2,function(inst) spawnoil(inst,pt)  end)
	end
end

local function ondeploy(inst, pt)	
	inst.Transform:SetPosition(pt.x, pt.y, pt.z) 
	inst.AnimState:PlayAnimation("place")
	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/quacken_drill/ramp") 
	inst:ListenForEvent("animover", nextstage(inst,pt) )	
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()

	inst.AnimState:SetBank("quacken_drill")
	inst.AnimState:SetBuild("quacken_drill")
	inst.AnimState:PlayAnimation("dropped")
	
    MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
    
	inst:AddTag("fire_proof")

	inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
	inst.components.deployable:SetDeployMode(DEPLOYMODE.WATER) 
	inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.NONE)	
    
--	MakeInventoryFloatable(inst, "dropped_water", "dropped")
	inst.useownripples = true
	---------------------  

	return inst      
end

return Prefab( "common/objects/quackendrill", fn, assets,prefabs),
	   MakePlacer( "common/quackendrill_placer", "quacken_drill", "quacken_drill", "placer" )


