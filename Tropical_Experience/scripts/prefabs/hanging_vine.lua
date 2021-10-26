
local assets=
{
	Asset("ANIM", "anim/cave_exit_rope.zip"),
	Asset("ANIM", "anim/vine01_build.zip"),
	Asset("ANIM", "anim/vine02_build.zip"),	
	Asset("SOUND", "sound/frog.fsb"),
}

local prefabs =
{
	"grabbing_vine",
}

local function onnear(inst)
	inst.AnimState:PlayAnimation("down")
    inst.AnimState:PushAnimation("idle_loop", true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/grabbing_vine/drop")
    inst.shadow:SetSize( 1.5, .75 )
end

local function onfar(inst)
    inst.AnimState:PlayAnimation("up")
    inst.SoundEmitter:PlaySound("dontstarve/cave/rope_up")
    inst.shadow:SetSize( 0,0 )
end
--[[
local function round(x)
  x = x *10
  local num = x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
  return num/10
end
]]
local function placegoffgrids(inst, radiusMax, prefab,tags)
    local x,y,z = inst.Transform:GetWorldPosition()
    local offgrid = false
    local inc = 1
    while offgrid == false do

        if not radiusMax then 
        	radiusMax = 12
        end
        local rad = math.random()*radiusMax
        local xdiff = math.random()*rad
        local ydiff = math.sqrt( (rad*rad) - (xdiff*xdiff))

        if math.random() > 0.5 then
        	xdiff= -xdiff
        end

        if math.random() > 0.5 then
        	ydiff= -ydiff
        end
		if x then
        x = x+ xdiff
		end
		if z then
        z = z+ ydiff
		end
		
		if x and y and z then
        local ents = TheSim:FindEntities(x,y,z, 1, tags)
        local test = true
        for i,ent in ipairs(ents) do
        local entx,enty,entz = ent.Transform:GetWorldPosition()
        end
        
        offgrid = test
		end
        inc = inc +1 
    end

	if x and y and z then
    local tile = TheWorld.Map:GetTileAtPoint(x,y,z)
    if  tile == GROUND.DEEPRAINFOREST or tile == GROUND.RAINFOREST then
    	local plant = SpawnPrefab(prefab)
    	plant.Transform:SetPosition(x,y,z) 
    	plant.spawnpatch = inst
    	return true
	end
	end
	return false
end

local function spawnitem(inst,prefab)
	local rad = 14
	if prefab == "grabbing_vine" then
		rad = 12
	end
	placegoffgrids(inst, rad, prefab,{"hangingvine"}) 
end

local function spawnvines(inst)
	inst.spawnedchildren = true
    for i=1,math.random(3,6),1 do --    for i=1,math.random(8,16),1 do
        spawnitem(inst,"hanging_vine")
    end	

    for i=1,math.random(2,4),1 do --     for i=1,math.random(6,9),1 do
    	spawnitem(inst,"grabbing_vine")
    end	   
end

local function spawnvines2(inst)
	inst.spawnedchildren = true
    for i=1,math.random(3,6),1 do --    for i=1,math.random(8,16),1 do
        spawnitem(inst,"hanging_vinefixo")
    end	

    for i=1,math.random(2,4),1 do --     for i=1,math.random(6,9),1 do
    	spawnitem(inst,"grabbing_vinefixo")
    end	   
end

local function spawnNewVine(inst,prefab)
	if not inst.spawntasks then
		inst.spawntasks = {}
	end
	local spawntime = 480*2 + (480*math.random())
	local newtask = {}
    inst.spawntasks[newtask] = newtask
	newtask.prefab = prefab
    newtask.task, newtask.taskinfo = inst:ResumeTask(spawntime,
        function()
            spawnitem(inst,newtask.prefab)
            inst.spawntasks[newtask] = nil
        end)
    inst.spawntasks[newtask] = newtask
end

local function onsave(inst, data)
    data.spawnedchildren = inst.spawnedchildren
end

local function onload(inst, data)
    if data then
        if data.spawnedchildren then
        	inst.spawnedchildren = true
        end

    end
end

local function patchfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function() if not inst.spawnedchildren then spawnvines(inst) end end) 
    --inst:DoTaskInTime(0, function() inst:Remove() end)
    inst.OnSave = onsave
    inst.OnLoad = onload
    inst.spawnNewVine = spawnNewVine
	return inst
end

local function patchfn2(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst:DoTaskInTime(0,function() if not inst.spawnedchildren then spawnvines2(inst) end end) 
    --inst:DoTaskInTime(0, function() inst:Remove() end)
    inst.OnSave = onsave
    inst.OnLoad = onload
    inst.spawnNewVine = spawnNewVine
	return inst
end

local function canshear (inst)
    return true
end

local function onshear (inst)
inst.AnimState:PlayAnimation("hit",false)
inst.AnimState:PushAnimation("idle_loop",true)
end

local function finished (inst)
inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/grabbing_vine/drop")
inst.AnimState:PlayAnimation("death",false)
inst:DoTaskInTime(1.5, function() inst:Remove() end) 
end

local function commonfn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	inst.shadow = inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

	inst.shadow:SetSize( 1.5, .75 )
	inst:SetPrefabNameOverride("hanging_vine")
	inst.AnimState:SetBank("exitrope")
	inst:AddTag("hangingvine")

	if math.random() < 0.5 then
		inst.AnimState:SetBuild("vine01_build")
	else
		inst.AnimState:SetBuild("vine02_build")
	end
	
	inst.AnimState:PlayAnimation("idle_loop",true)

    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetOnPlayerNear(onnear)
    inst.components.playerprox:SetOnPlayerFar(onfar)
    inst.components.playerprox:SetDist(10,16)

	inst:AddComponent("inspectable")
  
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HACK)
    inst.components.workable:SetOnFinishCallback(finished)
    inst.components.workable:SetWorkLeft(2)
	inst.components.workable.onwork = onshear	
	
	
    inst.canshear = canshear
    inst.onshear = onshear

    inst.placegoffgrids = placegoffgrids
	
	return inst
end

return Prefab( "forest/animals/hanging_vine", commonfn, assets, prefabs),
	   Prefab("forest/objects/hanging_vine_patch", patchfn, assets, prefabs),
	   Prefab( "forest/animals/hanging_vinefixo", commonfn, assets, prefabs),
	   Prefab("forest/objects/hanging_vine_patchfixo", patchfn2, assets, prefabs)