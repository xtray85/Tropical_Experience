local prefabs = 
{
}

local assets =
{
    Asset("ANIM", "anim/grotto_bug_lamp.zip"),
}

	local HONEY_LANTERN_MINE = 6

local function fn(Sim)
	local inst  = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim  = inst.entity:AddAnimState()
    local light = inst.entity:AddLight()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 0.5)

    light:SetFalloff(0.4)
    light:SetIntensity(0.8)
    light:SetRadius(2.5)
    light:SetColour(180/255, 195/255, 150/255)

    light:Enable(true)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("anthill_cavelamp.png")

	anim:SetBank("grotto_bug_lamp")
	anim:SetBuild("grotto_bug_lamp")
	anim:PlayAnimation("idle", true)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
	
    inst:AddComponent("inspectable")

    ---------------------  
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"log", "log", "lightbulb", "honey"})

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.CHOP)
    inst.components.workable:SetWorkLeft(HONEY_LANTERN_MINE)

    inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)
            local pt = Point(inst.Transform:GetWorldPosition())
            if workleft <= 0 then
				SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
				inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
                inst.components.lootdropper:DropLoot(pt)
                inst:Remove()
				
			else
			inst.AnimState:PlayAnimation("idle", true)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
            end
        end)

	return inst
end

return Prefab("anthill/items/anthill_cavelamp", fn, assets, prefabs) 
