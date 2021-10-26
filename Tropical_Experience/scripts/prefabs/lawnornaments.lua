local assets =
{
	Asset("ANIM", "anim/topiary.zip"),

    Asset("ANIM", "anim/topiary01_build.zip"),    
    Asset("ANIM", "anim/topiary02_build.zip"),    
    Asset("ANIM", "anim/topiary03_build.zip"),    
    Asset("ANIM", "anim/topiary04_build.zip"),    
    Asset("ANIM", "anim/topiary05_build.zip"),    
    Asset("ANIM", "anim/topiary06_build.zip"),    
    Asset("ANIM", "anim/topiary07_build.zip"),    

    Asset("MINIMAP_IMAGE", "lawnornaments_1"),  
    Asset("MINIMAP_IMAGE", "lawnornaments_2"),  
    Asset("MINIMAP_IMAGE", "lawnornaments_3"),  
    Asset("MINIMAP_IMAGE", "lawnornaments_4"),  
    Asset("MINIMAP_IMAGE", "lawnornaments_5"),  
    Asset("MINIMAP_IMAGE", "lawnornaments_6"),  
    Asset("MINIMAP_IMAGE", "lawnornaments_7"),  
}

local prefabs = 
{
    "ash",
    "collapse_small",
}

local function onhammered(inst, worker)
local pt = inst:GetPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
if tiletype == GROUND.SUBURB or tiletype == GROUND.FOUNDATION or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.LAWN or tiletype == GROUND.FIELDS  or tiletype == GROUND.CHECKEREDLAWN then
if worker and worker:HasTag("player") and not worker:HasTag("sneaky") then
local x, y, z = inst.Transform:GetWorldPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
local eles = TheSim:FindEntities(x,y,z, 40,{"guard"})
for k,guardas in pairs(eles) do 
if guardas.components.combat and guardas.components.combat.target == nil then guardas.components.combat:SetTarget(worker) end
end 
end
end
--	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst:Remove()
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
end
        
local function onhit(inst, worker)
    
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle", false)
    
end

local function OnSave(inst, data)

end

local function OnLoad(inst, data)

end

local function getstatus(inst)

end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
	inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/lawnornaments/repair")
end

local function makeitem(name, frame)
    local function fn(Sim)
        local inst = CreateEntity()
        local trans = inst.entity:AddTransform()
        local anim = inst.entity:AddAnimState() 
    inst.entity:AddNetwork()
	
        inst.entity:AddPhysics() 
        MakeObstaclePhysics(inst, .5) 

        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon( "lawnornament_"..frame..".png" )


        inst.entity:AddSoundEmitter()
        inst:AddTag("structure")

        anim:SetBank("topiary")
        anim:SetBuild("topiary0".. frame .."_build")

        anim:PlayAnimation("idle",true)
		
--		inst.AnimState:Hide("snow")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
		
--        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(2)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)
        
        inst:AddComponent("inspectable")
        inst.components.inspectable.getstatus = getstatus
        
--        MakeSnowCovered(inst, .01)
        --inst:ListenForEvent( "onbuilt", onbuilt)

        inst:SetPrefabNameOverride("lawnornament")

        inst:AddComponent("fixable")
        inst.components.fixable:AddRecinstructionStageData("burnt","topiary","topiary0".. frame .."_build")
        inst.components.fixable:SetPrefabName("lawnornament")

        MakeSmallBurnable(inst, nil, nil, true)
        MakeSmallPropagator(inst)

        inst:AddComponent("gridnudger")

        inst:ListenForEvent("burntup", function(inst)
            inst:Remove()
        end)        

        inst.OnSave = OnSave
        inst.OnLoad = OnLoad
        return inst
    end

    return Prefab( name, fn, assets, prefabs)
end

return makeitem( "lawnornament_1", "1" ),
       makeitem( "lawnornament_2", "2" ),
       makeitem( "lawnornament_3", "3" ),
       makeitem( "lawnornament_4", "4" ),
       makeitem( "lawnornament_5", "5" ),
       makeitem( "lawnornament_6", "6" ),
       makeitem( "lawnornament_7", "7" ),      
	MakePlacer("lawnornament_1_placer", "topiary", "topiary01_build", "idle"),
	MakePlacer("lawnornament_2_placer", "topiary", "topiary02_build", "idle"),
	MakePlacer("lawnornament_3_placer", "topiary", "topiary03_build", "idle"),
	MakePlacer("lawnornament_4_placer", "topiary", "topiary04_build", "idle"),
	MakePlacer("lawnornament_5_placer", "topiary", "topiary05_build", "idle"),
	MakePlacer("lawnornament_6_placer", "topiary", "topiary06_build", "idle"),
	MakePlacer("lawnornament_7_placer", "topiary", "topiary07_build", "idle")