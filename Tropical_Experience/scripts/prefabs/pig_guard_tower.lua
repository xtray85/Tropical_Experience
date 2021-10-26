require "prefabutil"
require "recipes"

local assets =
{

    Asset("ANIM", "anim/pig_shop.zip"),
    
    Asset("ANIM", "anim/flag_post_duster_build.zip"),
    Asset("ANIM", "anim/flag_post_perdy_build.zip"),
    Asset("ANIM", "anim/flag_post_royal_build.zip"),
    Asset("ANIM", "anim/flag_post_wilson_build.zip"), 
    Asset("ANIM", "anim/pig_tower_build.zip"),
    Asset("SOUND", "sound/pig.fsb"),
    Asset("MINIMAP_IMAGE", "pig_guard_tower"),    
    Asset("MINIMAP_IMAGE", "pig_palace"),        
    Asset("ANIM", "anim/pig_tower_royal_build.zip"),
    Asset("INV_IMAGE", "pighouse_city"),       

}


local GUARDTOWER_CITY_RESPAWNTIME = 480*3

local prefabs = 
{
    "pigman_royalguard",
    "pigman_royalguard_2",
}

local function LightsOn(inst)
    if not inst:HasTag("burnt") then
        inst.Light:Enable(true)
        inst.AnimState:PlayAnimation("lit", true)
        inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lighton")
        inst.lightson = true
    end
end

local function LightsOff(inst)
    if not inst:HasTag("burnt") then
        inst.Light:Enable(false)
        inst.AnimState:PlayAnimation("idle", true)
        inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lightoff")
        inst.lightson = false
    end
end

local function onfar(inst) 
    if not inst:HasTag("burnt") then
        if inst.components.spawner and inst.components.spawner:IsOccupied() then
            LightsOn(inst)
        end
    end
end

local function getstatus(inst)
    if inst:HasTag("burnt") then
        return "BURNT"
    elseif inst.components.spawner and inst.components.spawner:IsOccupied() then
        if inst.lightson then
            return "FULL"
        else
            return "LIGHTSOUT"
        end
    end
end

local function onnear(inst) 
    if not inst:HasTag("burnt") then
        if inst.components.spawner and inst.components.spawner:IsOccupied() then
            LightsOff(inst)
        end
    end
end

local function onwere(child)
    if child.parent and not child.parent:HasTag("burnt") then
        child.parent.SoundEmitter:KillSound("pigsound")
        child.parent.SoundEmitter:PlaySound("dontstarve/pig/werepig_in_hut", "pigsound")
    end
end

local function onnormal(child)
    if child.parent and not child.parent:HasTag("burnt") then
        child.parent.SoundEmitter:KillSound("pigsound")
        child.parent.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/city_pig/pig_in_house_LP", "pigsound")
    end
end

local function onoccupied(inst, child)
    if not inst:HasTag("burnt") then
    	inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/city_pig/pig_in_house_LP", "pigsound")
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
    	
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
    	--inst.doortask = inst:DoTaskInTime(1, function() if not inst.components.playerprox:IsPlayerClose() then LightsOn(inst) end end)
        inst.doortask = inst:DoTaskInTime(1, function() LightsOn(inst) end)
    	if child then
    	    inst:ListenForEvent("transformwere", onwere, child)
    	    inst:ListenForEvent("transformnormal", onnormal, child)
    	end
    end
end

local function onvacate(inst, child)
    if not inst:HasTag("burnt") then
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
        inst.SoundEmitter:PlaySound("dontstarve/common/pighouse_door")
        inst.SoundEmitter:KillSound("pigsound")
    	
    	if child then
--    	    inst:RemoveEventCallback("transformwere", onwere, child)
--    	    inst:RemoveEventCallback("transformnormal", onnormal, child)
            if child.components.werebeast then
    		    child.components.werebeast:ResetTriggers()
    		end
    		if child.components.health then
    		    child.components.health:SetPercent(1)
    		end
    	end    
    end
end
        
local function onhammered(inst, worker)
local pt = inst:GetPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
if tiletype == GROUND.SUBURB or tiletype == GROUND.FOUNDATION or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.LAWN or tiletype == GROUND.FIELDS or tiletype == GROUND.CHECKEREDLAWN then
if worker and worker:HasTag("player") and not worker:HasTag("sneaky") then
local x, y, z = inst.Transform:GetWorldPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
local eles = TheSim:FindEntities(x,y,z, 40,{"guard"})
for k,guardas in pairs(eles) do 
if guardas.components.combat and guardas.components.combat.target == nil then guardas.components.combat:SetTarget(worker) end
end 
end
end

    if inst:HasTag("fire") and inst.components.burnable then
        inst.components.burnable:Extinguish()
    end

    inst.reconstruction_project_spawn_state = {
        bank = "pig_house",
        build = "pig_house",
        anim = "unbuilt",
    }

    if inst.doortask then
        inst.doortask:Cancel()
        inst.doortask = nil
    end
	if inst.components.spawner then inst.components.spawner:ReleaseChild() end
	--inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function ongusthammerfn(inst)
    onhammered(inst, nil)
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
    	inst.AnimState:PlayAnimation("hit")
    	inst.AnimState:PushAnimation("idle")
    end
end

local function OnDay(inst)
    --print(inst, "OnDay")
    if not inst:HasTag("burnt") then
        if inst.components.spawner:IsOccupied() and not (TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.aporkalypse_active == true) then
            LightsOff(inst)
            if inst.doortask then
                inst.doortask:Cancel()
                inst.doortask = nil
            end
            inst.doortask = inst:DoTaskInTime(1 + math.random()*2, function() inst.components.spawner:ReleaseChild() end)
        end
    end
end

local function citypossessionfn(inst)
        if inst:HasTag("palacetower") then
            inst.AnimState:AddOverrideBuild("flag_post_royal_build")
            local spawned = {"pig_royalguard_rich"}
            inst.components.spawner:Configure( "pig_royalguard_rich", GUARDTOWER_CITY_RESPAWNTIME,1)            
        else
            inst.AnimState:AddOverrideBuild("flag_post_duster_build")
            local spawned = {"pigman_royalguard"}
            inst.components.spawner:Configure( "pigman_royalguard", GUARDTOWER_CITY_RESPAWNTIME,1)            
        end    
end

local function citypossessionfn2(inst)    
    if inst.components.citypossession then    
            inst.AnimState:AddOverrideBuild("flag_post_royal_build")
            local spawned = {"pigman_royalguard_2"}
            inst.components.spawner:Configure( "pigman_royalguard_2", GUARDTOWER_CITY_RESPAWNTIME,1)                    
    end
end

local function reconstructed(inst)
    citypossessionfn(inst)    
end

local function reconstructed2(inst)
    citypossessionfn2(inst)    
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
    citypossessionfn( inst )
end

local function onbuilt2(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle")
    citypossessionfn2( inst )
end

local function onsave(inst, data)

end

local function onload(inst, data)

end

local function callguards(inst,threat)
    print("CALLING GUARD AT TOWER")
    if inst.components.spawner then
        if inst.components.spawner:IsOccupied() then
            print("RELEASING")
            inst.components.spawner:ReleaseChild()
        end
        if inst.components.spawner.child then
            local pig = inst.components.spawner.child            
            if pig.components.combat.target == nil then
                print("ALERTING PIG GUARD")
                pig:DoTaskInTime(math.random()*1,function()                 
                    pig:PushEvent("atacked", {attacker = threat, damage = 0, weapon = nil})
                end)
            end
        end
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local light = inst.entity:AddLight()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "pig_guard_tower.png" )

    light:SetFalloff(1)
    light:SetIntensity(.5)
    light:SetRadius(1)
    light:Enable(false)
    light:SetColour(180/255, 195/255, 50/255)
    
    MakeObstaclePhysics(inst, 1)

    anim:SetBank("pig_shop")
    anim:SetBuild("pig_tower_build")
    anim:PlayAnimation("idle", true)
    anim:Hide("YOTP")
	
    inst:AddTag("guard_tower")
    inst:AddTag("structure")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    --inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	

    inst.onvacate = onvacate

	inst:AddComponent("spawner")
	WorldSettings_Spawner_SpawnDelay(inst, TUNING.TOTAL_DAY_TIME*3, true)
	inst.components.spawner:Configure( "pigman_royalguard", GUARDTOWER_CITY_RESPAWNTIME,1) 
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
	inst:WatchWorldState("isday", OnDay)

    inst.citypossessionfn = citypossessionfn2
    inst.OnLoadPostPass = citypossessionfn2

    inst:AddComponent("inspectable")
    
    inst.components.inspectable.getstatus = getstatus
	
	MakeSnowCovered(inst, .01)

    inst:AddComponent("fixable")
    inst.components.fixable:AddRecinstructionStageData("rubble","pig_shop","pig_tower_build")
    inst.components.fixable:AddRecinstructionStageData("unbuilt","pig_shop","pig_tower_build") 

    inst:ListenForEvent("burntup", function(inst)
        inst.components.fixable:AddRecinstructionStageData("burnt","pig_shop","pig_tower_build",1)       
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
    end)
    inst:ListenForEvent("onignite", function(inst)
        if inst.components.spawner then
            inst.components.spawner:ReleaseChild()
        end
    end)

    inst.OnSave = onsave 
    inst.OnLoad = onload
    inst.callguards = callguards
    inst.reconstructed = reconstructed

	inst:ListenForEvent( "onbuilt", onbuilt)
    inst:DoTaskInTime(math.random(), function() 
        --print(inst, "spawn check day")
        if TheWorld.state.isday then 
            OnDay(inst)
        end 
    end)

    inst:AddComponent("gridnudger")
	
       inst.OnEntityWake = function (inst)
        if TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.fiesta_active == true then
            inst.AnimState:Show("YOTP")
        else
            inst.AnimState:Hide("YOTP")
        end	
		end
	

    return inst
end

local function palacefn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local light = inst.entity:AddLight()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "pig_royal_tower.png" )

    light:SetFalloff(1)
    light:SetIntensity(.5)
    light:SetRadius(1)
    light:Enable(false)
    light:SetColour(180/255, 195/255, 50/255)
    
    MakeObstaclePhysics(inst, 1)

    anim:SetBank("pig_shop")
    inst.AnimState:SetBuild("pig_tower_royal_build")
    anim:PlayAnimation("idle", true)

    inst:AddTag("guard_tower")
    inst:AddTag("structure")
	inst:AddTag("palacetower")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    --inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	

    inst.onvacate = onvacate

	inst:AddComponent("spawner")
	WorldSettings_Spawner_SpawnDelay(inst, TUNING.TOTAL_DAY_TIME*3, true)	
	inst.components.spawner:Configure( "pig_royalguard_rich", GUARDTOWER_CITY_RESPAWNTIME,1) 
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
	inst:WatchWorldState("isday", OnDay)

    inst.citypossessionfn = citypossessionfn 
    inst.OnLoadPostPass = citypossessionfn

    inst:AddComponent("inspectable")
    
    inst.components.inspectable.getstatus = getstatus
	
	MakeSnowCovered(inst, .01)

    inst:AddComponent("fixable")
    inst.components.fixable:AddRecinstructionStageData("rubble","pig_shop","pig_tower_build")
    inst.components.fixable:AddRecinstructionStageData("unbuilt","pig_shop","pig_tower_build") 

    inst:ListenForEvent("burntup", function(inst)
        inst.components.fixable:AddRecinstructionStageData("burnt","pig_shop","pig_tower_build",1)       
        if inst.doortask then
            inst.doortask:Cancel()
            inst.doortask = nil
        end
    end)
    inst:ListenForEvent("onignite", function(inst)
        if inst.components.spawner then
            inst.components.spawner:ReleaseChild()
        end
    end)

    inst.OnSave = onsave 
    inst.OnLoad = onload
    inst.callguards = callguards
    inst.reconstructed = reconstructed2

	inst:ListenForEvent( "onbuilt", onbuilt2)
    inst:DoTaskInTime(math.random(), function() 
        --print(inst, "spawn check day")
        if TheWorld.state.isday then 
            OnDay(inst)
        end 
    end)

    inst:AddComponent("gridnudger")
	
       inst.OnEntityWake = function (inst)
        if TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.fiesta_active == true then
            inst.AnimState:Show("YOTP")
        else
            inst.AnimState:Hide("YOTP")
        end	
		end	

    return inst
end

return Prefab( "common/objects/pig_guard_tower", fn, assets, prefabs),
       Prefab( "common/objects/pig_guard_tower_palace", palacefn, assets, prefabs),
	   MakePlacer("common/pig_guard_tower_placer", "pig_shop", "pig_tower_build", "idle"),  
	   MakePlacer("common/pig_guard_tower_palace_placer", "pig_shop", "pig_tower_royal_build", "idle") 
	   
