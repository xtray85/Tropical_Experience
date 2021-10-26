local assets =
{
	Asset("ANIM", "anim/lamp_post2.zip"),
    Asset("ANIM", "anim/lamp_post2_yotp_build.zip"),    
    Asset("INV_IMAGE", "city_lamp"),
}

local INTENSITY = 0.6

local LAMP_DIST = 16
local LAMP_DIST_SQ = LAMP_DIST * LAMP_DIST

local function UpdateAudio(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, 16, true)

    if TheWorld.state.isdusk and players and not inst.SoundEmitter:PlayingSound("onsound") then
        inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/city_lamp/on_LP", "onsound")
    elseif not players and inst.SoundEmitter:PlayingSound("onsound") then
        inst.SoundEmitter:KillSound("onsound")
    end
end

local function GetStatus(inst)
    return not inst.lighton and "ON" or nil
end

local function fadein(inst)
    inst.components.fader:StopAll()
    inst.AnimState:PlayAnimation("on")
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/city_lamp/fire_on")
    inst.AnimState:PushAnimation("idle", true)
    inst.Light:Enable(true)

	if inst:IsAsleep() then
		inst.Light:SetIntensity(INTENSITY)
	else
		inst.Light:SetIntensity(0)
		inst.components.fader:Fade(0, INTENSITY, 3+math.random()*2, function(v) inst.Light:SetIntensity(v) end)
	end
end

local function fadeout(inst)
    inst.components.fader:StopAll()
    inst.AnimState:PlayAnimation("off")    
    inst.AnimState:PushAnimation("idle", true)

	if inst:IsAsleep() then
		inst.Light:SetIntensity(0)
	else
		inst.components.fader:Fade(INTENSITY, 0, .75+math.random()*1, function(v) inst.Light:SetIntensity(v) end)
	end
end

local function updatelight(inst)
if TheWorld.state.isday and not (TheWorld.components.aporkalypse and TheWorld.components.aporkalypse.aporkalypse_active == true) then
if inst.lighton then
inst:DoTaskInTime(math.random()*2, function() 
fadeout(inst)
end)            
else
inst.Light:Enable(false)
inst.Light:SetIntensity(0)
end

inst.AnimState:Hide("FIRE")
inst.AnimState:Hide("GLOW")        
inst.lighton = false
else		
 if not inst.lighton then
inst:DoTaskInTime(math.random()*2, function() 
fadein(inst)
end)
else            
inst.Light:Enable(true)
inst.Light:SetIntensity(INTENSITY)
end
inst.AnimState:Show("FIRE")
inst.AnimState:Show("GLOW")        
inst.lighton = true

		
		
		
    end
end


local function setobstical(inst)
    local ground = TheWorld
    if ground then
        local pt = Point(inst.Transform:GetWorldPosition())
        ground.Pathfinder:AddWall(pt.x, pt.y, pt.z)
    end
end

local function clearobstacle(inst)
    local ground = TheWorld
    if ground then
        local pt = Point(inst.Transform:GetWorldPosition())
        ground.Pathfinder:RemoveWall(pt.x, pt.y, pt.z)
    end
end

local function onhammered(inst, worker)
local pt = inst:GetPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
if tiletype == GROUND.SUBURB or tiletype == GROUND.FOUNDATION or tiletype == GROUND.COBBLEROAD or tiletype == GROUND.LAWN or tiletype == GROUND.FIELDS then
if worker and worker:HasTag("player") and not worker:HasTag("sneaky") then
local x, y, z = inst.Transform:GetWorldPosition()
local tiletype = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pt:Get()))
local eles = TheSim:FindEntities(x,y,z, 40,{"guard"})
for k,guardas in pairs(eles) do 
if guardas.components.combat and guardas.components.combat.target == nil then guardas.components.combat:SetTarget(worker) end
end 
end
end

    inst.SoundEmitter:KillSound("onsound")
    if inst.components.lootdropper then
        inst.components.lootdropper:DropLoot()
    end
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")

    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", true)
    inst:DoTaskInTime(0.3, function() updatelight(inst) end)
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst:DoTaskInTime(0, function() updatelight(inst) end)
end

local function fn(Sim)
	local inst = CreateEntity()
    local sound = inst.entity:AddSoundEmitter()
	local inst = CreateEntity()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    inst:AddTag("CITY_LAMP")
	inst.entity:AddTransform()
	inst.entity:AddAnimState()

    inst.entity:AddPhysics()
 
    MakeObstaclePhysics(inst, 0.25)   

    local light = inst.entity:AddLight()
    inst.Light:SetIntensity(INTENSITY)
    inst.Light:SetColour(197/255, 197/255, 10/255)
    inst.Light:SetFalloff( 0.9 )
    inst.Light:SetRadius( 5 )
    inst.Light:Enable(false)
    
    --inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    
    inst.AnimState:SetBank("lamp_post")
    inst.AnimState:SetBuild("lamp_post2_yotp_build")
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:Hide("FIRE")
    inst.AnimState:Hide("GLOW")    

    inst.AnimState:SetRayTestOnBB(true);

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus


    --inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)    

    inst:AddComponent("fader")

	inst:WatchWorldState("isday", updatelight)
	inst:WatchWorldState("isdusk", updatelight)

    inst:ListenForEvent("onbuilt", onbuilt)

    inst.OnSave = function(inst, data)
        if inst.lighton then
            data.lighton = inst.lighton
        end
    end        

    inst.OnLoad = function(inst, data)    
        if data then
            if data.lighton then 
                fadein(inst)
                inst.Light:Enable(true)
                inst.Light:SetIntensity(INTENSITY)            
                inst.AnimState:Show("FIRE")
                inst.AnimState:Show("GLOW")        
                inst.lighton = true
            end
        end
    end

--    inst:DoPeriodicTask(1.0, function() UpdateAudio(inst) end)
    
    inst:AddComponent("fixable")
    inst.components.fixable:AddRecinstructionStageData("rubble","lamp_post","lamp_post2_yotp_build")
	
    inst.setobstical = setobstical
    inst:AddComponent("gridnudger")

    return inst
end

return Prefab( "common/objects/city_lamp2", fn, assets),
MakePlacer("common/city_lamp_placer", "lamp_post", "lamp_post2_yotp_build", "idle")

