require "prefabutil"
require "recipes"

local PIGHOUSE_CITY_RESPAWNTIME = 480*3

local assets =
{
	Asset("ANIM", "anim/pig_townhouse1.zip"),
    Asset("ANIM", "anim/pig_townhouse5.zip"),
    Asset("ANIM", "anim/pig_townhouse6.zip"),    

    Asset("ANIM", "anim/pig_townhouse1_pink_build.zip"),
    Asset("ANIM", "anim/pig_townhouse1_green_build.zip"),

    Asset("ANIM", "anim/pig_townhouse1_brown_build.zip"),
    Asset("ANIM", "anim/pig_townhouse1_white_build.zip"),

    Asset("ANIM", "anim/pig_townhouse5_beige_build.zip"),
    Asset("ANIM", "anim/pig_townhouse6_red_build.zip"),
    
    Asset("ANIM", "anim/pig_farmhouse_build.zip"),

    Asset("SOUND", "sound/pig.fsb"),
    Asset("INV_IMAGE", "pighouse_city"),    
}

local prefabs = 
{
    "pigman_collector",
    "pigman_banker",
    "pigman_beautician",
    "pigman_florist",
    "pigman_erudite",
    "pigman_hunter",
    "pigman_hatmaker",
    "pigman_usher",
    "pigman_mechanic",
    "pigman_storeowner",
    "pigman_professor",
}

local city_1_citizens = {
    "pigman_banker",
    "pigman_beautician",
    "pigman_florist",
    "pigman_usher",
    "pigman_mechanic",
    "pigman_storeowner",
    "pigman_professor",
}

local city_2_citizens = {
    "pigman_collector",
    "pigman_erudite",
    "pigman_hatmaker",
    "pigman_hunter",
}

local city_citizens = {
    city_1_citizens,
    city_2_citizens,
}

local spawned_farm = {
    "pigman_farmer"
}

local spawned_mine = {
    "pigman_miner"
}

local SCALEBUILD ={}
SCALEBUILD["pig_townhouse1_pink_build"] = true
SCALEBUILD["pig_townhouse1_green_build"] = true
SCALEBUILD["pig_townhouse1_white_build"] = true
SCALEBUILD["pig_townhouse1_brown_build"] = true

local SETBANK ={}
SETBANK["pig_townhouse1_pink_build"] = "pig_townhouse"
SETBANK["pig_townhouse1_green_build"] = "pig_townhouse"
SETBANK["pig_townhouse1_white_build"] = "pig_townhouse"
SETBANK["pig_townhouse1_brown_build"] = "pig_townhouse"
SETBANK["pig_townhouse5_beige_build"] = "pig_townhouse5"
SETBANK["pig_townhouse6_red_build"] = "pig_townhouse6"

local house_builds = {
   "pig_townhouse1_pink_build",
   "pig_townhouse1_green_build",
   "pig_townhouse1_white_build",
   "pig_townhouse1_brown_build",
   "pig_townhouse5_beige_build",
   "pig_townhouse6_red_build",   
}

local function setScale(inst,build)
    if SCALEBUILD[build] then
        inst.AnimState:SetScale(0.75,0.75,0.75)
    else
        inst.AnimState:SetScale(1,1,1)
    end
end

local function getScale(inst,build)
    if SCALEBUILD[build] then
        return {0.75,0.75,0.75}
    else
        return {1,1,1}
    end
end

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
          --  if child.components.citypossession
    	end    
    end
end
           
local function onhammered(inst, worker)
--[[
if worker and worker:HasTag("player") then
local x, y, z = inst.Transform:GetWorldPosition()
local guarda = GetClosestInstWithTag("guard", inst, 30)
if guarda and worker and guarda.components.combat and guarda.components.combat.target == nil then guarda.components.combat:SetTarget(worker) end 
end
]]



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
	if inst.components.spawner and inst.components.spawner:IsOccupied() then inst.components.spawner:ReleaseChild() end
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

local function paytax(inst)
local jogador = GetClosestInstWithTag("player", inst, 30)
    if inst.components.spawner.child and jogador and inst:HasTag("paytax") then
        inst:DoTaskInTime(4, function()
            if inst.components.spawner.child then
                inst.components.spawner.child:AddTag("paytax")        
            end
            inst:RemoveTag("paytax")
        end)       
    end
end

local function checktax(inst)
    -- a player build pighouse doesn't have a city possesion component.. so that's how I'm checking for tax paying houses right now
    if inst.components.spawner.child and TheWorld.state.cycles%10 == 0 then        
        inst:AddTag("paytax")
        paytax(inst)
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
if inst:HasTag("feitapelojogador") then
    checktax(inst) 
end	
end

local function setcolor(inst,num)
    if not num then
        num = math.random()
    end
    local color = 0.5 + num * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)
    return num
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
    data.build = inst.build
    data.animset = inst.animset
    data.colornum = inst.colornum
    data.paytax = inst:HasTag("paytax")
    data.feitapelojogador = inst:HasTag("feitapelojogador")
--    if inst.components.spawner.childname then
--        data.childname = inst.components.spawner.childname
--    end
end

local function onload(inst, data)
    if data then

        if data.build then
            inst.build = data.build
            inst.AnimState:SetBuild(inst.build) 
            setScale(inst,inst.build)
        end

        if data.animset then
            inst.animset = data.animset
            inst.AnimState:SetBank( inst.animset )
        end    
        if data.colornum then
            inst.colornum = setcolor(inst, data.colornum)
        end
        if data.paytax then
            inst:AddTag("paytax")
        end
        if data.feitapelojogador then
            inst:AddTag("feitapelojogador")
        end	
--        if data.childname then
--            inst.components.spawner:Configure( data.childname, PIGHOUSE_CITY_RESPAWNTIME)
--        end
        if data.burnt then
            inst.components.burnable.onburnt(inst)
        end
    end
end

local function ConfigureSpawner( inst, selected_citizens )
    inst.spawnlist = selected_citizens
    inst.components.spawner:Configure( selected_citizens[math.random(1,#selected_citizens)], PIGHOUSE_CITY_RESPAWNTIME, 1)
    
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
	inst:WatchWorldState("isday",  OnDay)
end

local function citypossessionfn( inst )

    local selected_citizens = {}
--    if inst.components.citypossession and inst.components.citypossession.cityID then
--        for i=1, inst.components.citypossession.cityID do
--            selected_citizens = JoinArrays(selected_citizens, city_citizens[i])
--        end
--    else
--        for i=1, 2 do
--            selected_citizens = JoinArrays(selected_citizens, city_citizens[i])
--        end
--    end
    ConfigureSpawner(inst, selected_citizens)    
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle")
	inst:AddTag("feitapelojogador")
--    citypossessionfn( inst )
end

local function OnLoadPostPass(inst)
    --citypossessionfn( inst )
end

local function makefn(animset, setbuild, spawnList)

    local function fn(Sim)
    	local inst = CreateEntity()
    	local trans = inst.entity:AddTransform()
    	local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
	    inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()

    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon( "pighouse.png" )
        --{anim="level1", sound="dontstarve/common/campfire", radius=2, intensity=.75, falloff=.33, colour = {197/255,197/255,170/255}},
        light:SetFalloff(1)
        light:SetIntensity(.5)
        light:SetRadius(1)
        light:Enable(false)
        light:SetColour(180/255, 195/255, 50/255)
        
        MakeObstaclePhysics(inst, 1)    

        local build = house_builds[math.random(1,#house_builds)]        
        if setbuild then
            build = setbuild
        end

        inst.build = build
        anim:SetBuild(build) 
        
        inst.animset = nil

        if animset then
            anim:SetBank(animset)
            inst.animset = animset
        else            
            anim:SetBank(SETBANK[build])            
            inst.animset = SETBANK[build]
        end

        setScale(inst,build)

        anim:PlayAnimation("idle", true)
		anim:Hide("YOTP")		

        inst.colornum = setcolor(inst)
        local color = 0.5 + math.random() * 0.5
        anim:SetMultColour(color, color, color, 1)

        inst:AddTag("bandit_cover")
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
    	
		if not inst.components.spawner then
        inst:AddComponent( "spawner" )
		WorldSettings_Spawner_SpawnDelay(inst, TUNING.TOTAL_DAY_TIME*3, true)
		end
        if spawnList then
            ConfigureSpawner(inst, spawnList)           
        else
		
		
local lista =
{
[1] = "pigman_banker",
[2] = "pigman_beautician",
[3] = "pigman_florist",
[4] = "pigman_usher",
[5] = "pigman_mechanic",
[6] = "pigman_storeowner",
[7] = "pigman_professor",
} 
		
		
	inst.components.spawner:Configure(lista[math.random(1, 7)], PIGHOUSE_CITY_RESPAWNTIME,1) 
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
	inst:WatchWorldState("isday", OnDay)		

--            inst.citypossessionfn = citypossessionfn 
--            inst.OnLoadPostPass = OnLoadPostPass
        end

		inst:WatchWorldState("isday", OnDay)
		
		
        inst:AddComponent("inspectable")
        
        inst.components.inspectable.getstatus = getstatus
    	
    	MakeSnowCovered(inst, .01)

        MakeMediumBurnable(inst, nil, nil, true)
        MakeLargePropagator(inst)
        
        inst:AddComponent("fixable")        
        inst.components.fixable:AddRecinstructionStageData("rubble","pig_townhouse",build,nil,getScale(inst,build))
        inst.components.fixable:AddRecinstructionStageData("unbuilt","pig_townhouse",build,nil,getScale(inst,build)) 



        inst:ListenForEvent("burntup", function(inst)
            inst.components.fixable:AddRecinstructionStageData("burnt","pig_townhouse",build,1,getScale(inst,build))
            if inst.doortask then
                inst.doortask:Cancel()
                inst.doortask = nil
            end
            inst:Remove()
        end)

        inst:ListenForEvent("onignite", function(inst)
            if inst.components.spawner and inst.components.spawner:IsOccupied() then
                inst.components.spawner:ReleaseChild()
            end
        end)

        inst.OnSave = onsave 
        inst.OnLoad = onload

    	inst:ListenForEvent( "onbuilt", onbuilt)
		inst:WatchWorldState("isday", OnDay)		

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
    return fn
end

local function makefn2(animset, setbuild, spawnList)

    local function fn(Sim)
    	local inst = CreateEntity()
    	local trans = inst.entity:AddTransform()
    	local anim = inst.entity:AddAnimState()
        local light = inst.entity:AddLight()
	    inst.entity:AddNetwork()
        inst.entity:AddSoundEmitter()

    	local minimap = inst.entity:AddMiniMapEntity()
    	minimap:SetIcon( "pighouse.png" )
        --{anim="level1", sound="dontstarve/common/campfire", radius=2, intensity=.75, falloff=.33, colour = {197/255,197/255,170/255}},
        light:SetFalloff(1)
        light:SetIntensity(.5)
        light:SetRadius(1)
        light:Enable(false)
        light:SetColour(180/255, 195/255, 50/255)
        
        MakeObstaclePhysics(inst, 1)    

        local build = house_builds[math.random(1,#house_builds)]        
        if setbuild then
            build = setbuild
        end

        inst.build = build
        anim:SetBuild(build) 
        
        inst.animset = nil

        if animset then
            anim:SetBank(animset)
            inst.animset = animset
        else            
            anim:SetBank(SETBANK[build])            
            inst.animset = SETBANK[build]
        end

        setScale(inst,build)

        anim:PlayAnimation("idle", true)  
		anim:Hide("YOTP")		

        inst.colornum = setcolor(inst)
        local color = 0.5 + math.random() * 0.5
        anim:SetMultColour(color, color, color, 1)

        inst:AddTag("bandit_cover")
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
    	if not inst.components.spawner then
        inst:AddComponent( "spawner" )
		WorldSettings_Spawner_SpawnDelay(inst, TUNING.TOTAL_DAY_TIME*3, true)
		end
        if spawnList then
            ConfigureSpawner(inst, spawnList)           
        else
		
		
local lista =
{

[1] = "pigman_collector",
[2] = "pigman_erudite",
[3] = "pigman_hatmaker",
[4] = "pigman_hunter",
[5] = "pigman_banker",
[6] = "pigman_beautician",
[7] = "pigman_florist",
[8] = "pigman_usher",
[9] = "pigman_mechanic",
[10] = "pigman_storeowner",
[11] = "pigman_professor",
} 
		
		
	inst:AddComponent("spawner")
	WorldSettings_Spawner_SpawnDelay(inst, TUNING.TOTAL_DAY_TIME*3, true)	
	inst.components.spawner:Configure(lista[math.random(1, 11)], PIGHOUSE_CITY_RESPAWNTIME,1) 
    inst.components.spawner.onoccupied = onoccupied
    inst.components.spawner.onvacate = onvacate
	inst:WatchWorldState("isday", OnDay)		

--            inst.citypossessionfn = citypossessionfn 
--            inst.OnLoadPostPass = OnLoadPostPass
        end

		inst:WatchWorldState("isday", OnDay)
		
		
        inst:AddComponent("inspectable")
        
        inst.components.inspectable.getstatus = getstatus
    	
    	MakeSnowCovered(inst, .01)

        MakeMediumBurnable(inst, nil, nil, true)
        MakeLargePropagator(inst)
        
        inst:AddComponent("fixable")        
        inst.components.fixable:AddRecinstructionStageData("rubble","pig_townhouse",build,nil,getScale(inst,build))
        inst.components.fixable:AddRecinstructionStageData("unbuilt","pig_townhouse",build,nil,getScale(inst,build)) 



        inst:ListenForEvent("burntup", function(inst)
            inst.components.fixable:AddRecinstructionStageData("burnt","pig_townhouse",build,1,getScale(inst,build))
            if inst.doortask then
                inst.doortask:Cancel()
                inst.doortask = nil
            end
            inst:Remove()
        end)

        inst:ListenForEvent("onignite", function(inst)
            if inst.components.spawner and inst.components.spawner:IsOccupied() then
                inst.components.spawner:ReleaseChild()
            end
        end)

        inst.OnSave = onsave 
        inst.OnLoad = onload

    	inst:ListenForEvent( "onbuilt", onbuilt)
		inst:WatchWorldState("isday", OnDay)		 

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
    return fn
end

local function house(name, anim, build, spawnList)
    return Prefab( "common/objects/"..name, makefn(anim, build, spawnList ), assets, prefabs)
end

local function house2(name, anim, build, spawnList)
    return Prefab( "common/objects/"..name, makefn2(anim, build, spawnList ), assets, prefabs)
end

return house("pighouse_city",nil,nil),
	   house2("pighouse_city2",nil,nil),
       house("pighouse_farm","pig_shop","pig_farmhouse_build",spawned_farm),
       house("pighouse_mine","pig_shop","pig_farmhouse_build",spawned_mine),

       MakePlacer("common/pighouse_city_placer", "pig_shop", "pig_townhouse1_green_build", "idle", nil, nil, nil, 0.75)

	  -- MakePlacer("common/pighouse_placer", "pig_house", "pig_house", "idle")  
