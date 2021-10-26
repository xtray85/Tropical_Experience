local assets =
{
    Asset("SOUND", "sound/forest.fsb"),
}

local prefabs = 
{
	"windtrail",
}

function SpawnWindSwirl(x, y, z, speed, angle)
	local swirl = SpawnPrefab("windswirl")
	swirl.Transform:SetPosition(x, y, z)
	swirl.Transform:SetRotation(angle + 180)
	swirl.AnimState:SetMultColour(1, 1, 1, math.clamp(speed, 0.0, 1.0))
	--swirl.Physics:SetMotorVel(speed, 0, 0)
end



local function dig_up_stump(inst, chopper)
	inst.components.lootdropper:SpawnLootPrefab("log")
	inst:Remove()
end

local function chop_down_tree(inst, chopper)
	inst:RemoveComponent("burnable")
	MakeSmallBurnable(inst)
	inst:RemoveComponent("propagator")
	MakeSmallPropagator(inst)
	inst:RemoveComponent("workable")
	inst:RemoveTag("shelter")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
	local pt = Vector3(inst.Transform:GetWorldPosition())
	local hispos = Vector3(chopper.Transform:GetWorldPosition())

	local he_right = (hispos - pt):Dot(TheCamera:GetRightVec()) > 0

	if he_right then
		inst.AnimState:PlayAnimation(inst.anims.fallleft)
		inst.components.lootdropper:DropLoot(pt - TheCamera:GetRightVec())
	else
		inst.AnimState:PlayAnimation(inst.anims.fallright)
		inst.components.lootdropper:DropLoot(pt + TheCamera:GetRightVec())
	end

	-- local fx = SpawnPrefab("pine_needles")
	-- local x, y, z= inst.Transform:GetWorldPosition()
	-- fx.Transform:SetPosition(x,y + 2 + math.random()*2,z)

	inst:DoTaskInTime(.4, function()
		local sz = (inst.components.growable and inst.components.growable.stage > 2) and .5 or .25
		-- GetPlayer().components.playercontroller:ShakeCamera(inst, "FULL", 0.25, 0.03, sz, 6)
		ShakeAllCameras(CAMERASHAKE.FULL, 0.25, 0.03, sz, inst, 6)
	end)

	RemovePhysicsColliders(inst)
	inst.AnimState:PushAnimation(inst.anims.stump)

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetOnFinishCallback(dig_up_stump)
	inst.components.workable:SetWorkLeft(1)

	inst:AddTag("stump")
	if inst.components.growable then
		inst.components.growable:StopGrowing()
	end

	inst:AddTag("NOCLICK")
	inst:DoTaskInTime(2, function() inst:RemoveTag("NOCLICK") end)
end

local function chop_down_burnt_tree(inst, chopper)
	inst:RemoveComponent("workable")
	inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
	inst.AnimState:PlayAnimation(inst.anims.chop_burnt)
	RemovePhysicsColliders(inst)
	inst:ListenForEvent("animover", function() inst:Remove() end)
	inst.components.lootdropper:SpawnLootPrefab("charcoal")
	inst.components.lootdropper:DropLoot()
	if inst.pineconetask then
		inst.pineconetask:Cancel()
		inst.pineconetask = nil
	end
end


local angle = 0


local function OnInit(inst)
local px, py, pz = inst.Transform:GetWorldPosition()
local dx, dz = 16 * UnitRand(), 16 * UnitRand()
local x, y, z = px + dx, py, pz + dz

if inst:HasTag("ventania") then
angle = math.random(1,8)
if angle ==1 then angle = 0 end
if angle ==2 then angle = 45 end
if angle ==3 then angle = 90 end
if angle ==4 then angle = 135 end
if angle ==5 then angle = 180 end
if angle ==6 then angle = 225 end
if angle ==7 then angle = 270 end
if angle ==8 then angle = 315 end


if TheWorld.state.isday then 
angle = 225
else
angle = 45
end


local player = GetClosestInstWithTag("player", inst, 25)
if player and player.components.inventory then
local mao = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if mao and mao.prefab == "sail_stick" then
angle = player.Transform:GetRotation() + 180 
end
end



--if player and player.components.locomotor then
--	player.components.locomotor.driftangle=angle
--	player.components.locomotor:StartUpdatingInternal()
--	player:DoTaskInTime(5.5,function() 
--		player.components.locomotor.driftangle=nil
--		if not player.components.locomotor.dest then player.components.locomotor:Stop() end
--	end)
--end
inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/wind_tree_creak")
inst:RemoveTag("ventania")
end
local speed = math.random(0.05,0.8)
local swirl = SpawnPrefab("windswirl")
swirl.Transform:SetPosition(x, y, z)
swirl.Transform:SetRotation(angle)
swirl.AnimState:SetMultColour(1, 1, 1, math.clamp(speed, 0.0, 1.0))

local trail = SpawnPrefab("windtrail")
trail.Transform:SetPosition(x, y, z)
trail.Transform:SetRotation(angle)
trail.AnimState:SetMultColour(1, 1, 1, math.clamp(speed, 0.0, 1.0))


----------------movimenta as ondinhas do mar-------------------------------
local ondapequena = GetClosestInstWithTag("ondinha", inst, 40)
if ondapequena then
local map = TheWorld.Map
local x, y, z = ondapequena.Transform:GetWorldPosition()
local ondanova = SpawnPrefab("wave_shimmer_hurricane")
if ondapequena.prefab == "wave_shimmer" then ondanova.AnimState:PlayAnimation("idle_small", true) end
if ondapequena.prefab == "wave_shimmer_med" then ondanova.AnimState:PlayAnimation("idle_med", true) end
if ondapequena.prefab == "wave_shimmer_deep" then ondanova.AnimState:PlayAnimation("idle_deep", true) end
ondanova.Transform:SetPosition(x, y, z)
ondanova.Transform:SetRotation(angle+180)
ondapequena:Remove()
end

---------------------algumas ondinhas viram onda media----------------------------
if math.random() > 0.80 then
local ondapequena = GetClosestInstWithTag("ondinha", inst, 40)
if ondapequena then
local map = TheWorld.Map
local x, y, z = ondapequena.Transform:GetWorldPosition()
local plataforma = GetClosestInstWithTag("walkableplatform", ondapequena, 6)
if plataforma then
ondapequena:Remove()
else
local ondanova = SpawnPrefab("wave_ripple")
ondanova:AddTag("essanao")
ondanova.Transform:SetPosition(x, y, z)
ondanova.Transform:SetRotation(angle+225)
ondanova.Physics:SetMotorVel(4, 0, 4)
ondapequena:Remove()
end
end
end

----------------as ondas medias viram ondas grandes-------------------------------
local ondamedia = GetClosestInstWithTag("ondamedia", inst, 40)
if ondamedia and not ondamedia:HasTag("essanao") then
local map = TheWorld.Map
local x, y, z = ondamedia.Transform:GetWorldPosition()
local ondagrande = SpawnPrefab("rogue_wave")
ondagrande.Transform:SetPosition(x, y, z)
ondagrande.Transform:SetRotation(angle+255)
ondagrande.Physics:SetMotorVel(6, 0, 6)
ondamedia:Remove()
end


-----------------bye bye flor plantada------------------------------------------------
local florplantada = GetClosestInstWithTag("flower", inst, 40)
if florplantada and math.random() > 0.99 then
local map = TheWorld.Map
local x, y, z = florplantada.Transform:GetWorldPosition()
if florplantada.prefab == "flower_evil" then
local flornova = SpawnPrefab("petals_evil")
flornova.Transform:SetPosition(x, y, z)
else
local flornova = SpawnPrefab("petals")
flornova.Transform:SetPosition(x, y, z)
end
if florplantada.components.pickable then
florplantada.components.pickable:Pick(inst)
end
end


---------------empurra os itens na direcao do vento--------------------------------------
--local itensleve = GetClosestInstWithTag("voador", inst, 40)

--if itensleve and itensleve.components.inventoryitem and itensleve.replica.inventoryitem:IsHeld() then
--itensleve:RemoveTag("voador")
---------------------------se itensleve ta cortada nao faz nada-------------------------------------------
--local pos = itensleve:GetPosition()
--itensleve.Transform:SetPosition(pos.x, 0, pos.z)
--local vx, vy, vz = itensleve.Physics:GetVelocity()
--local move = math.random(1,3)
--if angle == 0 then itensleve.Physics:SetVel(-move, vy, vz) end
--if angle == 45 then itensleve.Physics:SetVel(-move, vy, move) end
--if angle == 90 then itensleve.Physics:SetVel(vx, vy, move) end
--if angle == 135 then itensleve.Physics:SetVel(move, vy, move) end
--if angle == 180 then itensleve.Physics:SetVel(move, vy, vz) end
--if angle == 225 then itensleve.Physics:SetVel(move, vy, -move) end
--if angle == 270 then itensleve.Physics:SetVel(vx, vy, -move) end
--if angle == 315 then itensleve.Physics:SetVel(-move, vy, -move) end
--itensleve:DoTaskInTime(1, function(inst)
---------------permite movimentar--------------------------------
--itensleve:AddTag("voador") 
--end)
--end







----------------balanca arvore-----------jungletree-palmtree-treemangrove-------------------------------
local palmtree = GetClosestInstWithTag("palmtree", inst, 40)
if palmtree then
palmtree:RemoveTag("palmtree")
---------------------------se arvore ta cortada nao faz nada-------------------------------------------
if palmtree:HasTag("stump") then palmtree:DoTaskInTime(5.5, function(inst) palmtree:AddTag("palmtree") end) end
---------------------------se arvore ta queimada nao balanca mas pode derrubar-------------------------------------------
if palmtree:HasTag("burnt") then palmtree:DoTaskInTime(5.5, function(inst) palmtree:AddTag("palmtree") if math.random() > 0.98 then chop_down_burnt_tree(palmtree, inst) end end) end
---------------------------balanca arvore normal-------------------------------------------
if not palmtree:HasTag("burnt") and not palmtree:HasTag("stump") then

palmtree.AnimState:PlayAnimation(palmtree.anims.blown_pre, false)
 if math.random() > 0.5 then palmtree.AnimState:PushAnimation(palmtree.anims.blown1, true)
 else palmtree.AnimState:PushAnimation(palmtree.anims.blown2, true) end
-----------------para de balancar------------------------------------------
palmtree:DoTaskInTime(5.5, function(inst)
if not palmtree:HasTag("fire") and not palmtree:HasTag("burnt") and palmtree.components.workable.action == ACTIONS.CHOP then
palmtree.AnimState:PlayAnimation(palmtree.anims.blown_pst, false)
palmtree.AnimState:PushAnimation(palmtree.anims.idle, true)
------------------derruba arvore----------------------------
if math.random() > 0.99 then chop_down_tree(palmtree, inst) end
palmtree.SoundEmitter:PlaySound("dontstarve_DLC002/common/wind_tree_creak")
end	
---------------permite movimentar--------------------------------
palmtree:AddTag("palmtree") 
end)
end end






----------------balanca arvore-----------jungletree-twiggytreesw-treemangrove-------------------------------
local twiggytreesw = GetClosestInstWithTag("twiggytreesw", inst, 40)
if twiggytreesw then
twiggytreesw:RemoveTag("twiggytreesw")
---------------------------se arvore ta cortada nao faz nada-------------------------------------------
if twiggytreesw:HasTag("stump") then twiggytreesw:DoTaskInTime(5.5, function(inst) twiggytreesw:AddTag("twiggytreesw") end) end

---------------------------se arvore ta queimada nao balanca mas pode derrubar-------------------------------------------
if twiggytreesw:HasTag("burnt") then twiggytreesw:DoTaskInTime(5.5, function(inst) twiggytreesw:AddTag("twiggytreesw") if math.random() > 0.98 then chop_down_burnt_tree(twiggytreesw, inst) end end) end
---------------------------balanca arvore normal-------------------------------------------
if not twiggytreesw:HasTag("burnt") and not twiggytreesw:HasTag("stump") then

twiggytreesw.AnimState:PlayAnimation(twiggytreesw.anims.blown_pre, false)
 if math.random() > 0.5 then twiggytreesw.AnimState:PushAnimation(twiggytreesw.anims.blown1, true)
 else twiggytreesw.AnimState:PushAnimation(twiggytreesw.anims.blown2, true) end
-----------------para de balancar------------------------------------------
twiggytreesw:DoTaskInTime(5.5, function(inst)
if not twiggytreesw:HasTag("fire") and not twiggytreesw:HasTag("burnt") and twiggytreesw.components.workable.action == ACTIONS.CHOP then
twiggytreesw.AnimState:PlayAnimation(twiggytreesw.anims.blown_pst, false)
twiggytreesw.AnimState:PushAnimation(twiggytreesw.anims.sway1, true)
------------------derruba arvore----------------------------
if math.random() > 0.99 then chop_down_tree(twiggytreesw, inst) end
twiggytreesw.SoundEmitter:PlaySound("dontstarve_DLC002/common/wind_tree_creak")
end	
---------------permite movimentar--------------------------------
twiggytreesw:AddTag("twiggytreesw") 
end)
end end






----------------bambootree--------------------------------------------
local bambootree = GetClosestInstWithTag("bambootree", inst, 40)
if bambootree and bambootree:HasTag("machetecut") then
bambootree:RemoveTag("bambootree")
---------------------------se bambootree ta cortada nao faz nada-------------------------------------------
if bambootree.components.workable.action == ACTIONS.DIG then bambootree:DoTaskInTime(5.5, function(inst) bambootree:AddTag("bambootree") end) end
---------------------------balanca arvore normal-------------------------------------------
if  bambootree.components.workable.action == ACTIONS.HACK then
bambootree.AnimState:PlayAnimation("blown_pre", false)
 if math.random() > 0.5 then bambootree.AnimState:PushAnimation("blown_loop1", true)
 else bambootree.AnimState:PushAnimation("blown_loop2", true) end
-----------------para de balancar------------------------------------------
bambootree:DoTaskInTime(5.5, function(inst)
if  bambootree.components.workable.action == ACTIONS.HACK then
bambootree.AnimState:PlayAnimation("blown_pst", false)
bambootree.AnimState:PushAnimation("idle", true)
------------------derruba arvore----------------------------
if math.random() > 0.99 then 
--bambootree.components.lootdropper:SpawnLootPrefab("dug_bambootree")
inst.components.workable:WorkedBy(inst, 6)
inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
--bambootree:Remove()
end
end
---------------permite movimentar--------------------------------
bambootree:AddTag("bambootree") 
end)
end end





----------------bush_vine--------------------------------------------
local bush_vine = GetClosestInstWithTag("bush_vine", inst, 40)
if bush_vine and bush_vine:HasTag("machetecut") then
bush_vine:RemoveTag("bush_vine")
---------------------------se bush_vine ta cortada nao faz nada-------------------------------------------
if bush_vine.components.workable.action == ACTIONS.DIG then bush_vine:DoTaskInTime(5.5, function(inst) bush_vine:AddTag("bush_vine") end) end
---------------------------balanca arvore normal-------------------------------------------
if bush_vine.components.workable.action == ACTIONS.HACK then
bush_vine.AnimState:PlayAnimation("blown_pre", false)


 if math.random() > 0.5 then bush_vine.AnimState:PushAnimation("blown_loop1", true)
 else bush_vine.AnimState:PushAnimation("blown_loop2", true) end
-----------------para de balancar------------------------------------------
bush_vine:DoTaskInTime(5.5, function(inst)
if bush_vine.components.workable.action == ACTIONS.HACK then
bush_vine.AnimState:PlayAnimation("blown_pst", false)
bush_vine.AnimState:PushAnimation("idle", true)
------------------derruba arvore----------------------------
if math.random() > 0.99 then 
--bush_vine.components.lootdropper:SpawnLootPrefab("dug_bush_vine")
inst.components.workable:WorkedBy(inst, 6)
inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
--bush_vine:Remove()
end
end	
---------------permite movimentar--------------------------------
bush_vine:AddTag("bush_vine")
end)
end end



----------------grasss-grasswater-sapling------------------------------------------
local grasss = GetClosestInstWithTag("grasss", inst, 40)
if grasss then
grasss:RemoveTag("grasss")
---------------------------se grasss ta cortada nao faz nada-------------------------------------------
if not grasss.components.pickable:CanBePicked() then grasss:DoTaskInTime(5.5, function(inst) grasss:AddTag("grasss") end) end
---------------------------balanca arvore normal-------------------------------------------
if grasss.components.pickable:CanBePicked() then
grasss.AnimState:PlayAnimation("blown_pre", false)
 if math.random() > 0.5 then grasss.AnimState:PushAnimation("blown_loop1", true)
 else grasss.AnimState:PushAnimation("blown_loop2", true) end
-----------------para de balancar------------------------------------------
grasss:DoTaskInTime(5.5, function(inst)
if grasss.components.pickable:CanBePicked() then 
grasss.AnimState:PlayAnimation("blown_pst", false)
grasss.AnimState:PushAnimation("idle", true)
------------------derruba arvore----------------------------
if math.random() > 0.99 then 
grasss.components.lootdropper:SpawnLootPrefab("cutgrass")
grasss.components.pickable:Pick(inst)
--inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")
--grasss:Remove()
end
end	
---------------permite movimentar--------------------------------
grasss:AddTag("grasss") 
end)
end end



----------------saplingsw--------------------------------------------
local saplingsw = GetClosestInstWithTag("saplingsw", inst, 40)
if saplingsw then
saplingsw:RemoveTag("saplingsw")
---------------------------se saplingsw ta cortada nao faz nada-------------------------------------------
if not saplingsw.components.pickable:CanBePicked() then saplingsw:DoTaskInTime(5.5, function(inst) saplingsw:AddTag("saplingsw") end) end
---------------------------balanca arvore normal-------------------------------------------
if saplingsw.components.pickable:CanBePicked() then
saplingsw.AnimState:PlayAnimation("blown_pre", false)
 if math.random() > 0.5 then saplingsw.AnimState:PushAnimation("blown_loop1", true)
 else saplingsw.AnimState:PushAnimation("blown_loop2", true) end
-----------------para de balancar------------------------------------------
saplingsw:DoTaskInTime(5.5, function(inst)
if saplingsw.components.pickable:CanBePicked() then 
saplingsw.AnimState:PlayAnimation("blown_pst", false)
saplingsw.AnimState:PushAnimation("idle", true)
------------------derruba arvore----------------------------
if math.random() > 0.99 then 
saplingsw.components.lootdropper:SpawnLootPrefab("twigs")
saplingsw.components.pickable:Pick(inst)
inst.SoundEmitter:PlaySound("dontstarve/forest/treefall")     --nao se pq isso nao ta funcionando
--saplingsw:Remove()
end
end	
---------------permite movimentar--------------------------------
saplingsw:AddTag("saplingsw") 
end)
end end




----------------grasstall--------------------------------------------
local grasstall = GetClosestInstWithTag("grasstall", inst, 40)
if grasstall and grasstall:HasTag("machetecut") then
grasstall:RemoveTag("grasstall")
grasstall.AnimState:PlayAnimation("blown_pre", false)
if math.random() > 0.5 then grasstall.AnimState:PushAnimation("blown_loop1", true)
else grasstall.AnimState:PushAnimation("blown_loop2", true) end
-----------------para de balancar------------------------------------------
grasstall:DoTaskInTime(5.5, function(inst)
grasstall.AnimState:PlayAnimation("blown_pst", false)
grasstall.AnimState:PushAnimation("idle", true)


---------------permite movimentar--------------------------------
grasstall:AddTag("grasstall") 
end)
end




----------------tubertree--------------------------------------------
local tubertree = GetClosestInstWithTag("tubertree", inst, 40)
if tubertree then
tubertree:RemoveTag("tubertree")
tubertree.AnimState:PlayAnimation("blown_pre_tall", false)
if math.random() > 0.5 then tubertree.AnimState:PushAnimation("blown_loop_tall1", true)
else tubertree.AnimState:PushAnimation("blown_loop_tall2", true) end
-----------------para de balancar------------------------------------------
tubertree:DoTaskInTime(5.5, function(inst)
tubertree.AnimState:PlayAnimation("blown_pst_tall", false)
tubertree.AnimState:PushAnimation("sway2_loop_tall", true)


---------------permite movimentar--------------------------------
tubertree:AddTag("tubertree") 
end)
end




end

local function apaga(inst)
inst:Remove()
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst:AddTag("NOCLICK")
	inst:AddTag("ventania")

	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end

	inst:DoPeriodicTask(0.1, OnInit)
    inst:DoTaskInTime(6, apaga)

    return inst
end

return Prefab( "ventania", fn, assets, prefabs)
