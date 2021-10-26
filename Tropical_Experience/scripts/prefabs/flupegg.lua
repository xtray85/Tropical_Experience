local assets =
{
	Asset("ANIM", "anim/flup_build.zip"),
	Asset("ANIM", "anim/flup_basic.zip"),
}

local function dohatch(inst, hatch_time)
	inst.updatetask = inst:DoTaskInTime(hatch_time, function()
		
		if not inst.inlimbo then
			inst.AnimState:PlayAnimation("hatch")
			inst.components.health:SetInvincible(true)
			
			inst.updatetask = inst:DoTaskInTime(11 * FRAMES, 
				function()
					if not inst.inlimbo then
						ChangeToInventoryPhysics(inst)
						local warrior = SpawnPrefab("antman_warrior")
						warrior.Transform:SetPosition(  inst.Transform:GetWorldPosition() )
						warrior.sg:GoToState("hatch")

						if inst.queen then
							warrior.queen = inst.queen
						end
local invader = GetClosestInstWithTag("player", inst, 30)
if invader then warrior.components.combat:SetTarget(invader) end
					end
				end
			)
		end
	end)
end

local function ground_detection(inst)
	local pos = inst:GetPosition()

	if pos.y <= 0.2 then

		ChangeToObstaclePhysics(inst)
		inst.AnimState:PlayAnimation("land", false)
		inst.AnimState:PushAnimation("idle", true)

		if inst.updatetask then
			inst.updatetask:Cancel()
			inst.updatetask = nil
		end

		dohatch(inst, math.random(2, 6))
	end
end

local function start_grounddetection(inst)
	inst.updatetask = inst:DoPeriodicTask(FRAMES, ground_detection)
end

local function onremove(inst)
	if inst.updatetask then
		inst.updatetask:Cancel()
		inst.updatetask = nil
	end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst.AnimState:SetRayTestOnBB(true);
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("flup")
	inst.AnimState:SetBuild("flup_build")
	inst.AnimState:PlayAnimation("fall_idle", true)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false	
	inst.components.inventoryitem:SetSinks(true)		
	

	inst:DoTaskInTime(2, function()
	local warrior = SpawnPrefab("flup")
	warrior.persists = false
	warrior.Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst:Remove()
	end	)

    inst.persists = false	
	
	return inst
end

return Prefab("common/inventory/flupegg", fn, assets, prefabs)