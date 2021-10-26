local assets =
{
    Asset("ANIM", "anim/twister_seal.zip"),
}

local prefabs = {}

SetSharedLootTable('twister_seal',
{
	{'meat', 1.00},	
	{'meat', 1.00},	
	{'meat', 1.00},	
	{'meat', 1.00},
--	{'twister_spawner', 1.00},
	{'magic_seal', 1.00},
	{'turbine_blades', 1.00},
	--Drop an item here too?
})

local function OnEntitySleep(inst)
	--This means the player let the seal live.
	--Let the seal escape & leave a gift of some sort behind.
--	print("seal left")
	--local seal = SpawnPrefab("magic_seal")
	--seal.Transform:SetPosition(inst:GetPosition():Get())
--	inst:Remove()
end

local function SummonKrampus(inst, attacker)
--	TheWorld:PushEvent("ms_forcenaughtiness", { player = attacker, numspawns = 3})
end

local function fn()
    local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddNetwork()
	inst.DynamicShadow:SetSize(2.5, 1.5)

	MakeCharacterPhysics(inst, 1000, 1)

	inst.Transform:SetTwoFaced()

	inst.AnimState:SetBank('twister')
	inst.AnimState:SetBuild('twister_build')
	inst.AnimState:PlayAnimation('seal_idle', true)

	inst:AddTag("twister")
	inst:AddTag("prey")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('twister_seal')

	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(10)

	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 0
	inst.components.locomotor.runspeed = 0
	
	inst:AddComponent("combat")
	inst.components.combat:SetOnHit(SummonKrampus)

	inst:SetStateGraph("SGtwister_seal")
    local brain = require("brains/twistersealbrain")
    inst:SetBrain(brain)

    inst:DoTaskInTime(1*FRAMES, function()
    	inst:ListenForEvent("entitysleep", OnEntitySleep)
    end)

	return inst
end

return Prefab("twister_seal", fn, assets, prefabs)
