local assets =
{
    Asset("ANIM", "anim/python_fountain.zip"),      
}

local prefabs =
{
    "waterdrop",
    "lifeplant",
}

local function OnActivate(inst,player)
    inst.AnimState:PlayAnimation("flow_pst")
    inst.AnimState:PushAnimation("off", true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/pugalisk/resurrection")
    inst.SoundEmitter:KillSound("burble")
    inst.components.activatable.inactive = false
    inst.dry = true

    local drop = SpawnPrefab("waterdrop")
    drop.fountain = inst
    player.components.inventory:GiveItem(drop, nil,  Vector3(TheSim:GetScreenPos(inst.Transform:GetWorldPosition()) ) )

    local ent = TheSim:FindFirstEntityWithTag("pugalisk_trap_door")
    if ent then
        ent.activate(ent,inst)
    end    
end
--[[
local function makeactive(inst)
    inst.AnimState:PlayAnimation("off", true)
    inst.components.activatable.inactive = false
end

local function makeused(inst)
    inst.AnimState:PlayAnimation("flow_loop", true)
end
]]
local function reset(inst)
local drop = nil
local plant = nil

for k,v in pairs(Ents) do
if v:HasTag("lifeplant") then
plant = true                                    
end

if v:HasTag("waterdrop") then
drop = true
end
end
--print(plant)
--print(drop)

if plant == true or drop == true then return end

--print("RESET THE PUGALISK FOUNTAIN")
inst.dry = nil
inst.components.activatable.inactive = true
inst.AnimState:PlayAnimation("flow_pre")
inst.AnimState:PushAnimation("flow_loop", true) 
inst.SoundEmitter:KillSound("burble")
inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/pugalisk/fountain_LP", "burble")

end

local function onsave(inst,data)
    if inst.dry then
        data.dry = true
    end
end

local function onload(inst, data)
    if data then
        if data.dry then        
            inst.AnimState:PlayAnimation("off", true)
            inst.dry = true
            inst.components.activatable.inactive = false
        end         
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    anim:SetBuild("python_fountain")    
    anim:SetBank("fountain")
    anim:PlayAnimation("flow_loop", true)
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/pugalisk/fountain_LP", "burble")
    inst:AddTag("pugalisk_fountain")
    inst:AddTag("pugalisk_avoids")
    
    MakeObstaclePhysics(inst, 2)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("pig_ruins_well.png")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
	
    inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = OnActivate
    inst.components.activatable.inactive = true
    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    inst.OnSave = onsave 
    inst.OnLoad = onload

	inst:WatchWorldState("startday", reset)		


    return inst
end

return Prefab("pugalisk_fountain", fn, assets, prefabs)


