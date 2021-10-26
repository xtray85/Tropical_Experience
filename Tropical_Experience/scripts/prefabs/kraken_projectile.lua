local assets=
{
	Asset("ANIM", "anim/ink_projectile.zip"),
	Asset("ANIM", "anim/ink_puddle.zip"),
}

local prefabs = {}

local function onthrown(inst, thrower, pt, time_to_target)
    inst.Physics:SetFriction(.2)

    -- local shadow = SpawnPrefab("warningshadow")
    -- shadow.Transform:SetPosition(pt:Get())
    -- shadow:shrink(time_to_target, 1.75, 0.5)

	inst.TrackHeight = inst:DoPeriodicTask(FRAMES, function()
		local pos = inst:GetPosition()

		if pos.y <= 1 then
		    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 1.5, nil, {"FX", "NOCLICK", "DECOR", "INLIMBO"})

		    for k,v in pairs(ents) do
	            if v.components.combat and v ~= inst and v.prefab ~= "kraken_tentacle" then
	                v.components.combat:GetAttacked(thrower, 50)
	            end
		    end

				inst.SoundEmitter:PlaySound("dontstarve_DLC002/quacken/splash_large")

				local ink = SpawnPrefab("kraken_inkpatch")
				ink.Transform:SetPosition(pos.x, pos.y, pos.z)	
				local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos.x, pos.y, pos.z))
			inst:Remove()
		end
	end)
end

local function onthrown2(inst, thrower, pt, time_to_target)
    inst.Physics:SetFriction(.2)

    -- local shadow = SpawnPrefab("warningshadow")
    -- shadow.Transform:SetPosition(pt:Get())
    -- shadow:shrink(time_to_target, 1.75, 0.5)

	inst.TrackHeight = inst:DoPeriodicTask(FRAMES, function()
		local pos = inst:GetPosition()

		if pos.y <= 1 then
		    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 1.5, nil, {"FX", "NOCLICK", "DECOR", "INLIMBO"})

		    for k,v in pairs(ents) do
	            if v.components.combat and v ~= inst and v.prefab ~= "kraken_tentacle" then
	                v.components.combat:GetAttacked(thrower, 50)
	            end
		    end

				inst.SoundEmitter:PlaySound("dontstarve_DLC002/quacken/splash_large")
			
				local ink = SpawnPrefab("kraken_jellyfish")
				ink.Transform:SetPosition(pos.x, pos.y, pos.z)	
				local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos.x, pos.y, pos.z))
				if ground ~= GROUND.OCEAN_COASTAL and
				ground ~= GROUND.OCEAN_COASTAL_SHORE and
				ground ~= GROUND.OCEAN_SWELL and
				ground ~= GROUND.OCEAN_ROUGH and
				ground ~= GROUND.OCEAN_BRINEPOOL and
				ground ~= GROUND.OCEAN_BRINEPOOL_SHORE and
				ground ~= GROUND.OCEAN_WATERLOG and
				ground ~= GROUND.OCEAN_HAZARDOUS then
				ink.sg:GoToState("some")
				end

			inst:Remove()
		end
	end)
end

local function onremove(inst)
	if inst.TrackHeight then
		inst.TrackHeight:Cancel()
		inst.TrackHeight = nil
	end
end

local contador = 200

local function ink_update(inst, dt)
contador = contador - 1

--	inst.ink_timer = inst.ink_timer - dt
--	inst.ink_scale = 1 -- Lerp(0, 1, inst.ink_timer/lerp_time)
inst.Transform:SetScale(contador/200, contador/200, contador/200)
--
	if contador < 2 then
--		inst.slowing_player = false
--ThePlayer.components.locomotor:RemoveSpeedModifier_Mult("INK")
--ThePlayer.components.locomotor.groundspeedmultiplier = 1
--ThePlayer.components.locomotor.externalspeedmultiplier = 1
		inst:Remove()
		return
	end


--	local pos = inst:GetPosition()
--	local dist = pos:Dist(ThePlayer:GetPosition())
--	if not inst.slowing_player and dist <= inst.ink_scale * 3.66 then
--		inst.slowing_player = true

--	ThePlayer.components.locomotor.isrunning = true
--ThePlayer.components.locomotor.groundspeedmultiplier = 0.6
--ThePlayer.components.locomotor.externalspeedmultiplier = 0.6
		--		ThePlayer.components.locomotor:AddSpeedModifier_Mult("INK", -0.7)
--	elseif inst.slowing_player and dist > inst.ink_scale * 3.66 then
--		inst.slowing_player = false
--ThePlayer.components.locomotor.groundspeedmultiplier = 1
--ThePlayer.components.locomotor.externalspeedmultiplier = 1
--		ThePlayer.components.locomotor:RemoveSpeedModifier_Mult("INK")
--	end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("ink")
	inst.AnimState:SetBuild("ink_projectile")
	inst.AnimState:PlayAnimation("fly_loop", true)

	inst:AddTag("thrown")
	inst:AddTag("projectile")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	MakeInventoryPhysics(inst)
	
	inst:AddComponent("throwable")
	inst.components.throwable.onthrown = onthrown
	inst.components.throwable.random_angle = 0
	inst.components.throwable.max_y = 100
	inst.components.throwable.yOffset = 7

	inst.OnRemoveEntity = onremove
	inst:DoTaskInTime(4,function(inst) inst:Remove() end)	

	inst.persists = false

	return inst
end

local function fn2()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("jellyfish")
	inst.AnimState:SetBuild("jellyfish")
	inst.AnimState:PlayAnimation("stunned_loop", true)

	inst:AddTag("thrown")
	inst:AddTag("projectile")

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	MakeInventoryPhysics(inst)
	
	inst:AddComponent("throwable")
	inst.components.throwable.onthrown = onthrown2
	inst.components.throwable.random_angle = 0
	inst.components.throwable.max_y = 100
	inst.components.throwable.yOffset = 7

	inst.OnRemoveEntity = onremove
	inst:DoTaskInTime(4,function(inst) inst:Remove() end)	

	inst.persists = false

	return inst
end


local function updateslowdowners(inst, range)
local ground = TheWorld
local x,y,z = inst.Transform:GetWorldPosition() 
local ents = TheSim:FindEntities(x, y, z, range, {"locomotor"}) 
for k,item in pairs(ents) do
if item then
if item and item.components.locomotor then
if not item:HasTag("penalidade") then
item:AddTag("penalidade")
local speed = item.components.locomotor.runspeed
item.components.locomotor.runspeed = item.components.locomotor.runspeed/4
item:DoTaskInTime(1,function()
item:RemoveTag("penalidade")	
item.components.locomotor.runspeed = speed
	end)
end 
end
end 
end

end




local inktime = 10

local function parte0(inst)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*1)
end

local function parte1(inst)
inst.Transform:SetScale(0.93, 0.93, 0.93)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.93)
end

local function parte2(inst)
inst.Transform:SetScale(0.86, 0.86, 0.86)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.86)
end

local function parte3(inst)
inst.Transform:SetScale(0.79, 0.79, 0.79)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.79)
end

local function parte4(inst)
inst.Transform:SetScale(0.72, 0.72, 0.72)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.72)
end

local function parte5(inst)
inst.Transform:SetScale(0.65, 0.65, 0.65)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.65)
end

local function parte6(inst)
inst.Transform:SetScale(0.58, 0.58, 0.58)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.58)
end

local function parte7(inst)
inst.Transform:SetScale(0.51, 0.51, 0.51)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.51)
end

local function parte8(inst)
inst.Transform:SetScale(0.44, 0.44, 0.44)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.44)
end

local function parte9(inst)
inst.Transform:SetScale(0.37, 0.37, 0.37)
updateslowdowners(inst, TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.37)
end

local function crackremove(inst)
	inst:Remove()
end



local function inkpatch_fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    inst.AnimState:SetBuild("ink_puddle")
    inst.AnimState:SetBank("ink_puddle")
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetSortOrder(ANIM_SORT_ORDER_BELOW_GROUND.UNDERWATER)
    inst.AnimState:SetLayer(LAYER_BELOW_GROUND)
	inst.AnimState:SetSortOrder(3)

	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end		
	
    inst:AddComponent("unevenground")
    inst.components.unevenground.radius = TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS
	inst.components.unevenground:Enable()

	inst:DoTaskInTime(0.02 * inktime, parte0)
	inst:DoTaskInTime(0.05 * inktime, parte0)
	inst:DoTaskInTime(0.08 * inktime, parte0)
	inst:DoTaskInTime(0.11 * inktime, parte0)
	inst:DoTaskInTime(0.14 * inktime, parte0)
	inst:DoTaskInTime(0.17 * inktime, parte0)
	inst:DoTaskInTime(0.20 * inktime, parte0)
	inst:DoTaskInTime(0.23 * inktime, parte0)
	inst:DoTaskInTime(0.26 * inktime, parte0)
	inst:DoTaskInTime(0.29 * inktime, parte0)
	inst:DoTaskInTime(0.32 * inktime, parte0)
	inst:DoTaskInTime(0.35 * inktime, parte1)
	inst:DoTaskInTime(0.38 * inktime, parte2)
	inst:DoTaskInTime(0.41 * inktime, parte3)
	inst:DoTaskInTime(0.44 * inktime, parte4)
	inst:DoTaskInTime(0.47 * inktime, parte5)
	inst:DoTaskInTime(0.51 * inktime, parte6)
	inst:DoTaskInTime(0.54 * inktime, parte7)
	inst:DoTaskInTime(0.57 * inktime, parte8)
	inst:DoTaskInTime(0.60 * inktime, parte9)
	inst:DoTaskInTime(0.65 * inktime, crackremove)
	
	return inst
end

return Prefab("kraken_projectile", fn, assets, prefabs),
	   Prefab("kraken_projectile2", fn2, assets, prefabs),
       Prefab("kraken_inkpatch", inkpatch_fn)