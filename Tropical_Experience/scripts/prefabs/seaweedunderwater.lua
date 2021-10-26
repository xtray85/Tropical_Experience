local assets=
{
	Asset("ANIM", "anim/seaweedunderwater.zip"),
}

local function OnTimerDone(inst, data)
    if data.name == "inicio" then
    inst.AnimState:PlayAnimation("idle_pick")
    end

    if data.name == "fim" then
    inst.AnimState:PlayAnimation("idle")
    inst.components.workable:SetWorkLeft(6)
	inst.components.workable:SetWorkAction(ACTIONS.CHOP)
    end
end

local function chop_tree(inst)
inst.AnimState:PlayAnimation("hit")	
inst.SoundEmitter:PlaySound("dontstarve/wilson/harvest_berries")
end

local function chop_down_tree(inst, chopper)
    inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
    local pt = inst:GetPosition()

    local he_right = true

    if chopper then
        local hispos = chopper:GetPosition()
        he_right = (hispos - pt):Dot(TheCamera:GetRightVec()) > 0
    else
        if math.random() > 0.5 then
            he_right = false
        end
    end

    if he_right then
        inst.AnimState:PlayAnimation("cutesquerda")
        inst.components.lootdropper:DropLoot(pt - TheCamera:GetRightVec())
	if math.random() > 0.9 then
    local kelpy = SpawnPrefab("kelpy")
	if kelpy then
    kelpy.Transform:SetPosition(inst.Transform:GetWorldPosition())
    kelpy.sg:GoToState("spawn")	
	end end
        inst:DoTaskInTime(2, function() 
		inst.components.timer:StartTimer("inicio", 480)	
		inst.components.timer:StartTimer("fim", 960)		
		inst.AnimState:PlayAnimation("idle_empty")			
--		inst:Remove() 
		end)			
    else
        inst.AnimState:PlayAnimation("cutdireita")
        inst.components.lootdropper:DropLoot(pt + TheCamera:GetRightVec())
		
	if math.random() > 0.9 then
    local kelpy = SpawnPrefab("kelpy")
	if kelpy then
    kelpy.Transform:SetPosition(inst.Transform:GetWorldPosition())
    kelpy.sg:GoToState("spawn")	
	end end		
		
        inst:DoTaskInTime(2, function() 
		inst.components.timer:StartTimer("inicio", 480)	
		inst.components.timer:StartTimer("fim", 960)		
		inst.AnimState:PlayAnimation("idle_empty")		
--		inst:Remove() 
		end)		
    end

end


local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	local minimap = inst.entity:AddMiniMapEntity()

	MakeObstaclePhysics(inst, .25) 
	
	inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("kelp.tex")
	
	trans:SetScale(1, 1, 1)
	
	anim:SetBank("seaweedunderwater")
	anim:SetBuild("seaweedunderwater")
	anim:PlayAnimation("idle", true)
	
	local color = 0.75 + math.random() * 0.25
	anim:SetMultColour(color, color, color, 1)

	inst:AddTag("underwater")
	inst:AddTag("tree")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
	inst:AddComponent("inspectable")    
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.CHOP)
    inst.components.workable:SetOnWorkCallback(chop_tree)
    inst.components.workable:SetOnFinishCallback(chop_down_tree)
	inst.components.workable:SetWorkLeft(6)
	
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"seaweed"})	
	
	inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)	
	
	return inst
end


return Prefab("underwater/objects/seaweedunderwater", fn, assets)
