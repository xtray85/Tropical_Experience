
local assets =
{
	Asset("ANIM", "anim/volcano.zip"),
    Asset("MINIMAP_IMAGE", "volcano"),
    Asset("MINIMAP_IMAGE", "volcano_active"),
}

local prefabs =
{

}

local function SpawnFireRain(inst)
--if inst:IsValid() and ThePlayer then




local invader = GetClosestInstWithTag("player", inst, 100)
if invader and math.random() > 0.75 then

----local player = GetClosestInstWithTag("character", inst, 100)
--local distsq = inst:GetDistanceSqToInst(ThePlayer)/100
----if distsq < 100 and math.random() > 0.75 then
--ThePlayer.components.talker:Say(""..distsq.."")




inst.sg:GoToState("erupt")


end
end
--end

local function OnSeasonChange(inst)
    if not (TheWorld.state.iswinter) and not inst:HasTag("ativo") then
        inst.sg:GoToState("active")
		inst:AddTag("ativo")
	end
		
    if  (TheWorld.state.iswinter) and inst:HasTag("ativo")then
        inst.sg:GoToState("dormant") 
		inst:RemoveTag("ativo")
    end	
if inst:HasTag("ativo") and not inst.sg:HasStateTag("atacando") then
SpawnFireRain(inst)
end
end 

local function OnWake(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/volcano/volcano_external_amb", "volcano")
    local state = 1.0
    if inst.sg and inst.sg.currentstate == "dormant" then
        state = 0.0
    end
    inst.SoundEmitter:SetParameter("volcano", "volcano_state", state)
end

local function OnSleep(inst)
    inst.SoundEmitter:KillSound("volcano")
end


local function oninit(inst)
 
if inst.entrada == nil then 


local x, y, z = inst.Transform:GetLocalPosition()
local fx = SpawnPrefab("vulcano_entrance")
if fx then fx.Transform:SetPosition(x+1.5, y, z+1.5) end
inst.entrada = 1
end

end

local function OnSave(inst, data)
	data.entrada = inst.entrada
end


local function OnLoad(inst, data)
if data == nil then return end
	if data.entrada then inst.entrada = data.entrada end

end


local function WarnQuake(inst)
	local duration = 3.0
	local speed = 0.02
	local scale = 0.75
	
	inst.SoundEmitter:PlaySound("dontstarve/cave/earthquake", "earthquake")
	inst.SoundEmitter:SetParameter("earthquake", "intensity", 5.5)
	ShakeAllCameras(CAMERASHAKE.FULL, duration, speed, scale, inst, 12)


	inst:DoTaskInTime(duration, function() inst.SoundEmitter:KillSound("earthquake") end)
end







local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()
	inst.Transform:SetScale(0.5, 0.5, 0.5)


    inst.entity:AddLight()
    inst.Light:SetFalloff(0.4)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(10)
    inst.Light:SetColour(249/255, 130/255, 117/255)
    inst.Light:Enable(true)

	inst.AnimState:SetBank("volcano")
	inst.AnimState:SetBuild("volcano")
	inst.AnimState:PlayAnimation("dormant_idle", true)
	
	inst.MiniMapEntity:SetIcon("volcano.png")

	inst:AddTag("FX")
	inst:AddTag("vulcaomigrador")	

 	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:SetDeployExtraSpacing(12)

    inst:SetStateGraph("SGvolcano")

    inst.OnEntityWake = OnWake
    inst.OnEntitySleep = OnSleep

	inst.OnSave = OnSave
	inst.OnLoad = OnLoad


--	inst:DoPeriodicTask(15, OnSeasonChange)
--	inst:DoPeriodicTask(10, WarnQuake)	
	inst:DoTaskInTime(0, oninit)
	
	
	
	return inst	
end




return Prefab( "volcano", fn, assets, prefabs)
