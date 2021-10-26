local basalt_assets =
{
	Asset("ANIM", "anim/rock_basalt.zip"),
	Asset("MINIMAP_IMAGE", "rock"),
}

local prefabs =
{

}    

SetSharedLootTable( 'basalt',
{
    {'rocks',  1.00},
    {'rocks',  1.00},
    {'rocks',  0.50},
    {'flint',  1.00},
    {'flint',  0.30},
})

local function basalt_fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	MakeObstaclePhysics(inst, 1)

	inst.AnimState:SetBank("rock_basalt")
	inst.AnimState:SetBuild("rock_basalt")
	inst.AnimState:PlayAnimation("full")
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "rock.png" )

    inst.entity:SetPristine()	
	
	if not TheWorld.ismastersim then
		return inst
	end			
	
	inst:AddComponent("lootdropper") 
	inst.components.lootdropper:SetChanceLootTable('basalt')	
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE)
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
	
	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)

			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				if inst:HasTag("trggerdarttraps") then
					triggerdarts(inst)
				end

				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
				inst.components.lootdropper:DropLoot(pt)

				inst:Remove()
			else
				if workleft < TUNING.ROCKS_MINE*(1/3) then
					inst.AnimState:PlayAnimation("low")
				elseif workleft < TUNING.ROCKS_MINE*(2/3) then
					inst.AnimState:PlayAnimation("med")
				else
					if not inst.components.dislodgeable or inst.components.dislodgeable:CanBeDislodged() then
						inst.AnimState:PlayAnimation("full")
					else
						inst.AnimState:PlayAnimation("extract_success")
					end
				end
			end
		end)

    local color = 0.5 + math.random() * 0.5
    anim:SetMultColour(color, color, color, 1)    

	inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "ROCK"

	MakeSnowCovered(inst, .01)
	return inst
end

return   Prefab("forest/objects/rocks/rock_basalt", basalt_fn, basalt_assets, prefabs)