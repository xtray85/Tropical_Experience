local assets =
{
    Asset("ANIM", "anim/whirlpool.zip"),
    Asset("ANIM", "anim/bubbles.zip"),	
}

local function onsave(inst, data)
	
end

local function onload(inst, data)

end

local angle = 0


local function OnInit(inst)
if inst.saibolha and inst.saibolha == false then return end
local px, py, pz = inst.Transform:GetWorldPosition()
local dx, dz = 5 * UnitRand(), 5 * UnitRand()
local x, y, z = px + dx, py, pz + dz

if inst:HasTag("ventania") then
angle = math.random(1,8)
if angle ==1 then angle = 0 end
if angle ==2 then angle = 45 end
if angle ==3 then angle = 90 end
if angle ==4 then angle = 135 end
if angle ==5 then angle = 180 end
if angle ==6 then angle = 225 end
if angle ==7 then angle = 270 end
if angle ==8 then angle = 315 end


if TheWorld.state.isday then 
angle = 225
else
angle = 45
end


--inst.SoundEmitter:PlaySound("dontstarve/AMB/waves")
inst:RemoveTag("ventania")
end


local speed = math.random(0.05,0.8)
local trail = SpawnPrefab("correntdebolhas")
local altura = math.random(0,15)/3
trail.Transform:SetPosition(x, altura, z)
trail.Transform:SetRotation(angle)
--trail.AnimState:SetMultColour(1, 1, 1, math.clamp(speed, 0.0, 1.0))

end

local function OnEntityWake(inst)
inst.saibolha = true	
end

local function OnEntitySleep(inst)
inst.saibolha = false
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()		
	inst.entity:AddTransform()
	
	inst.entity:AddAnimState() 
--	inst.AnimState:SetBank("whirlpool")
--	inst.AnimState:SetBuild("whirlpool")
--	inst.AnimState:PlayAnimation("idle_loop", true)
	inst.AnimState:SetSortOrder(10)	
	inst.saibolha = false
    
    inst:AddTag("tidal_node")
	inst:AddTag("underwater")
	
	inst:AddComponent("bubbleblower")
	inst.components.bubbleblower:SetYOffset(40)
	inst.components.bubbleblower:SetYOffset(30)
    inst.components.bubbleblower:SetBubbleRate(1)	
    inst.components.bubbleblower.tipo = "correntdebolhas"
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
	
	inst:DoPeriodicTask(0.5, OnInit)
--	inst.OnEntityWake = OnEntityWake
--	inst.OnEntitySleep = OnEntitySleep		
    
    return inst
end


local function fn1(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    --inst.entity:AddPhysics()
    anim:SetBuild("bubbles")
    anim:SetBank("bubbles")
    anim:SetOrientation(ANIM_ORIENTATION.OnGround)
	anim:PlayAnimation( "corentemarinha2", true )	
--	local animado math.random(1,3)
--	if animado == 2 then anim:PlayAnimation( "corentemarinha2", true ) end
--	if animado == 3 then anim:PlayAnimation( "corentemarinha3", true ) end	
	
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )
	inst:AddTag( "ondamarinha" )	
--[[
	inst:ListenForEvent( "animover", function(inst)
	local animado math.random(1,3)
	if animado == 2 then anim:PlayAnimation( "ccorentemarinha", true ) end	
	if animado == 2 then anim:PlayAnimation( "corentemarinha2", true ) end
	if animado == 3 then anim:PlayAnimation( "corentemarinha3", true ) end		
	end)
]]

	inst:WatchWorldState("startcaveday", function(inst)	inst.Transform:SetRotation(180)	end)
	inst:WatchWorldState("stopcaveday", function(inst)	inst.Transform:SetRotation(0)	end)	

    return inst
end

return Prefab( "underwater/objects/tidal_node", fn1, assets) 
