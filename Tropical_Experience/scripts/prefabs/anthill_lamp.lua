local prefabs = 
{
}

local assets =
{
    Asset("ANIM", "anim/ant_cave_lantern.zip"),
}

	local HONEY_LANTERN_MINE = 6
	local HONEY_LANTERN_MINE_MED = 4
	local HONEY_LANTERN_MINE_LOW = 2

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
	minimap:SetIcon("ant_cave_lantern.png")

	anim:SetBank("ant_cave_lantern")
	anim:SetBuild("ant_cave_lantern")
	anim:PlayAnimation("idle", true)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
	
    inst:AddComponent("inspectable")

    ---------------------  
    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({"honey", "honey", "honey"})

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(HONEY_LANTERN_MINE)

    inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)
            local pt = Point(inst.Transform:GetWorldPosition())
            if workleft <= 0 then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
                inst.components.lootdropper:DropLoot(pt)
                inst:Remove()
            else
                if workleft < HONEY_LANTERN_MINE*(1/3) then
                    inst.AnimState:PlayAnimation("break")
                elseif workleft < HONEY_LANTERN_MINE*(2/3) then
                    inst.AnimState:PlayAnimation("hit")
                else
                    inst.AnimState:PlayAnimation("idle")
                end
            end
        end)

    inst:ListenForEvent("beginaporkalypse", function() inst.Light:Enable(false) end, TheWorld)
    inst:ListenForEvent("endaporkalypse", function() inst.Light:Enable(true) end, TheWorld)
--    inst:ListenForEvent("exitlimbo", function(inst) inst.Light:Enable(not GetAporkalypse():IsActive()) end)

--    inst.Light:Enable(not GetAporkalypse():IsActive())

	return inst
end

return Prefab("anthill/items/ant_cave_lantern", fn, assets, prefabs) 
