require "stategraphs/SGsquidunderwater"
require "brains/squidunderwaterbrain"

local assets =
{
	Asset("ANIM", "anim/squidunderwater.zip"),
}
 
local prefabs =
{
	"fish_fillet",
    "trinket_12"
}

 local function OnTimerDone(inst, data)
    if data.name == "vaiembora" then
	local invader = GetClosestInstWithTag("player", inst, 25)
	if not invader then
	inst:Remove()
	else
	inst.components.timer:StartTimer("vaiembora", 10)	
	end
    end
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.Transform:SetTwoFaced()
    MakeGhostPhysics(inst, 1, .5)

	local shadow = inst.entity:AddDynamicShadow()
	shadow:SetSize( 1.5, .5 )
    
    anim:SetBank("squid")
    anim:SetBuild("squid")
    
    inst:AddTag("scarytoprey")
	inst:AddTag("monster")
	inst:AddTag("squid")
	inst:AddTag("underwater")
	inst:AddTag("tropicalspawner")	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED
   

    inst:AddComponent("inspectable")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(100)

	inst:AddComponent("combat")
    
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"fish_fillet","trinket_12"}) 
	inst.components.lootdropper:AddChanceLoot("trinket_12", 0.7)
    inst.components.lootdropper:AddChanceLoot("saltrock", 0.2)

	inst:AddComponent("knownlocations")   
    inst:DoTaskInTime(1*FRAMES, function() inst.components.knownlocations:RememberLocation("home", Vector3(inst.Transform:GetWorldPosition()), true) end)
	
	inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
	
	inst:AddComponent("sleeper")
	inst.components.sleeper:SetResistance(2)
	
    inst:SetStateGraph("SGsquidunderwater")	
    local brain = require "brains/squidunderwaterbrain"
    inst:SetBrain(brain)	
	
    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)
    inst.components.timer:StartTimer("vaiembora", 240)		

    return inst
end

return Prefab( "common/monsters/squidunderwater", fn, assets) 
