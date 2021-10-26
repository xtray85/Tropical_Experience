local assets =
{
	Asset( "ANIM", "anim/mist_fx.zip" ),
}


function dodamageinplayer(inst)
local alvo = GetClosestInstWithTag("player", inst, 5) 
local alvo2 =  GetClosestInstWithTag("insect", inst, 5)

if alvo and alvo.components.health then



local gasmask = alvo.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
if gasmask and gasmask.prefab == "gasmaskhat" then return end
if gasmask and gasmask.prefab == "gashat" then return end

if alvo and alvo.components.poisonable == nil then
alvo:AddComponent("poisonable")
end
alvo.components.poisonable:SetPoison(-2, 1, 2)
--alvo.components.health:DoDelta(-2, nil, "poison")
end

if alvo2 and alvo2.components.health then
if not alvo2:HasTag("player") then
alvo2.components.health.invincible = false
alvo2.components.health:Kill()
end
end

end



local function OnEntityWake(inst)
if inst.updatetask then
inst.updatetask:Cancel()
inst.updatetask = nil
end
inst.updatetask = inst:DoPeriodicTask(1, function(inst) dodamageinplayer(inst) end)
end

local function OnEntitySleep(inst)
if inst.updatetask then
inst.updatetask:Cancel()
inst.updatetask = nil
end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    anim:SetBuild( "mist_fx" )
    anim:SetBank( "mist_fx" )
    anim:PlayAnimation( "idle", true )
	
    local cloudScale = (math.random() * 1.5) + 1.5
    inst.Transform:SetScale(cloudScale, cloudScale, cloudScale)
    inst.AnimState:SetMultColour(50/255, 205/255, 50/255, 1)
    inst:AddTag("NOCLICK")
    anim:SetTime(math.random() * anim:GetCurrentAnimationLength())
	
	inst.AnimState:SetSortOrder(3)	

	inst.OnEntitySleep = OnEntitySleep
	inst.OnEntityWake = OnEntityWake
	
    return inst
end

return Prefab( "common/fx/poisonmist", fn, assets) 
 
