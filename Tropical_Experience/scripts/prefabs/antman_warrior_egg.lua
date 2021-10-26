local assets =
{
	Asset("ANIM", "anim/antman_basic.zip"),
	Asset("ANIM", "anim/antman_attacks.zip"),
	Asset("ANIM", "anim/antman_actions.zip"),
    Asset("ANIM", "anim/antman_egghatch.zip"),
    Asset("ANIM", "anim/antman_guard_build.zip"),

    Asset("ANIM", "anim/antman_translucent_build.zip"),
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

--local queen = GetClosestInstWithTag("antqueen", inst, 30)
--						if queen and warrior.queen then						
--							warrior:ListenForEvent("death", function(warrior, data) 
--								warrior.queen:WarriorKilled()
--							end)
--						end
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

	inst.AnimState:SetBank("antman_egg")
	inst.AnimState:SetBuild("antman_guard_build")
	inst.AnimState:AddOverrideBuild("antman_egghatch")
	inst.Transform:SetScale(1.15, 1.15, 1.15)
	
	inst.AnimState:PlayAnimation("flying", true)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end		
	
	inst:AddComponent("inspectable")
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(200)
	
	inst:AddComponent("combat")
	inst.components.combat:SetOnHit(function()
		if inst.components.health:IsDead() then
			inst.AnimState:PlayAnimation("break")			
--		local queen = GetClosestInstWithTag("antqueen", inst, 30)			
--		if queen then inst.queen:WarriorKilled() end	
			onremove(inst)
		elseif not inst.components.health:IsInvincible() then
			inst.AnimState:PlayAnimation("hit", false)
		end
	end)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.nobounce = true
    inst.components.inventoryitem.canbepickedup = false	
	inst.components.inventoryitem:SetSinks(true)		
	
	inst.OnRemoveEntity = onremove


	inst:ListenForEvent("animover", function (inst) 
		if inst.AnimState:IsCurrentAnimation("hatch") then
			inst:Remove()
		end
	end)

	inst.start_grounddetection = start_grounddetection
	inst.eggify = function (inst)
		inst.AnimState:PlayAnimation("eggify", false)
		inst.AnimState:PushAnimation("idle", false)
		dohatch(inst, 1)
	end

    inst.persists = false	
	
	return inst
end

return Prefab("common/inventory/antman_warrior_egg", fn, assets, prefabs)