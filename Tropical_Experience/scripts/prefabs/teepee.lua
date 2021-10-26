require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/teepee.zip"),
}

local prefabs =
{
    "tikiman",
	"goldnugget",
    "collapse_small",
}

local function ReturnChildren(inst)
	for k,child in pairs(inst.components.childspawner.childrenoutside) do
		if child.components.homeseeker then
			child.components.homeseeker:GoHome()
		end
		child:PushEvent("gohome")
	end
    if not inst.task then
        inst.task = inst:DoTaskInTime(math.random(60, 120), function() 
            inst.task = nil 
            inst:PushEvent("safetospawn")
        end)
    end
end
local function OnIgniteFn(inst)
    if inst.components.childspawner then
        inst.components.childspawner:ReleaseAllChildren()
        inst:RemoveComponent("childspawner")
    end
end
local function ongohome(inst, child)
    if child.components.inventory then
        child.components.inventory:DropEverything(false, true)
    end
end
local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    MakeObstaclePhysics(inst, 1)  

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "tent.png" )
	
    inst:AddTag("structure")
    anim:SetBank("tent")
    anim:SetBuild("teepee")
    anim:PlayAnimation("idle", true)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	inst:AddComponent( "childspawner" )
	inst.components.childspawner:SetRegenPeriod(120000000000000)
	inst.components.childspawner:SetSpawnPeriod(30)
	inst.components.childspawner:SetMaxChildren(5)
	--inst.components.childspawner:StartRegen()
	inst.components.childspawner.childname = "tikiman"
    inst.components.childspawner:StartSpawning()
    inst.components.childspawner.ongohome = ongohome
	
	MakeLargeBurnable(inst, nil, nil, true)
	MakeLargePropagator(inst)

    inst:AddComponent("inspectable")
	return inst
end

return Prefab( "common/objects/teepee", fn, assets, prefabs)
