local assets =
{
    Asset("ANIM", "anim/oincpile.zip"),    
}

local prefabs =
{
	"oinc",
}

local loots =
{
    {'oinc', 1.00},
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

local function callGuards(inst, attacker)
    local x,y,z = inst.Transform:GetWorldPosition()
    local eles = TheSim:FindEntities(x,y,z, 30,{"piggolem"})
    if #eles > 5 then return end
	
    local ents = TheSim:FindEntities(x,y,z, 30,{"hamletteleport"})
    if #ents > 0 then
        local guardprefab = "piggolem"
        local spawnpt = Vector3(ents[math.random(#ents)].Transform:GetWorldPosition() )
        local guard = SpawnPrefab(guardprefab)
        guard.Transform:SetPosition(spawnpt.x,spawnpt.y,spawnpt.z)
        guard:PushEvent("attacked", {attacker = attacker, damage = 0, weapon = nil})
		
		guard:AddComponent("timer")
		guard:ListenForEvent("timerdone", OnTimerDone)
		guard.components.timer:StartTimer("vaiembora", 240)			
    end
end


local function update(inst)
	inst.AnimState:PlayAnimation(""..inst.components.pickable.cycles_left.."")
	MakeObstaclePhysics(inst, 0.03*inst.components.pickable.cycles_left)
	if inst.components.pickable and inst.components.pickable.cycles_left > 0 then
	inst.components.pickable.caninteractwith = true
	inst.components.pickable.canbepicked = true	
	print(inst.components.pickable.cycles_left)
	end	
end

local function onpickedfn(inst, picker)
if math.random(1,10) < 3 then
callGuards(inst,picker)
end
    inst.SoundEmitter:PlaySound("dontstarve/common/food_rot")
    local loots = inst.components.lootdropper:GenerateLoot()
    local pt = Point(inst.Transform:GetWorldPosition())
    inst.components.lootdropper:DropLoot(pt, loots)
	update(inst)
end

local function onpickedfnfree(inst, picker)
    inst.SoundEmitter:PlaySound("dontstarve/common/food_rot")
    local loots = inst.components.lootdropper:GenerateLoot()
    local pt = Point(inst.Transform:GetWorldPosition())
    inst.components.lootdropper:DropLoot(pt, loots)
	update(inst)
end

local function gaincoin52(inst)
	if inst.components.pickable and inst.components.pickable.cycles_left < 52 then
	inst.components.pickable.cycles_left = inst.components.pickable.cycles_left + 1
	update(inst)
	end
end

local function gaincoin49(inst)
	if inst.components.pickable and inst.components.pickable.cycles_left < 49 then
	inst.components.pickable.cycles_left = inst.components.pickable.cycles_left + 1
	update(inst)
	end
end

local function gaincoin46(inst)
	if inst.components.pickable and inst.components.pickable.cycles_left < 46 then
	inst.components.pickable.cycles_left = inst.components.pickable.cycles_left + 1
	update(inst)
	end
end

local function gaincoin42(inst)
	if inst.components.pickable and inst.components.pickable.cycles_left < 42 then
	inst.components.pickable.cycles_left = inst.components.pickable.cycles_left + 1
	update(inst)
	end
end

local function onload(inst, data)
	update(inst)
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, 1.5)

--	local minimap = inst.entity:AddMiniMapEntity()
--	minimap:SetIcon( "dung_pile.png" )

	anim:SetBank("oincpile")
	anim:SetBuild("oincpile")
	anim:PlayAnimation("52")
	
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )  	

     inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    ---------------------
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
    inst.components.pickable.getregentimefn = 0
    inst.components.pickable.onpickedfn = onpickedfn
--    inst.components.pickable.makebarrenfn = makebarrenfn
--    inst.components.pickable.makefullfn = makefullfn
    inst.components.pickable.max_cycles = 52
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
    inst.components.pickable:SetUp(nil,0)
    inst.components.pickable.transplanted = true	
    ---------------------
    inst:AddComponent("lootdropper")
    for i,v in pairs(loots) do
        inst.components.lootdropper:AddRandomLoot(v[1], v[2])
    end
    inst.components.lootdropper.numrandomloot = 1
    inst.components.lootdropper.speed = 2
    inst.components.lootdropper.alwaysinfront = true

    ---------------------
    inst:AddComponent("inspectable")
	
	inst:WatchWorldState("startday", gaincoin52)	

    inst.OnLoad = onload

	return inst
end

local function fn49(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, 1.5)

	anim:SetBank("oincpile")
	anim:SetBuild("oincpile")
	anim:PlayAnimation("49")
	
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )  	

     inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    ---------------------
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
    inst.components.pickable.getregentimefn = 0
    inst.components.pickable.onpickedfn = onpickedfn
--    inst.components.pickable.makebarrenfn = makebarrenfn
--    inst.components.pickable.makefullfn = makefullfn
    inst.components.pickable.max_cycles = 49
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
    inst.components.pickable:SetUp(nil,0)
    inst.components.pickable.transplanted = true	
    ---------------------
    inst:AddComponent("lootdropper")
    for i,v in pairs(loots) do
        inst.components.lootdropper:AddRandomLoot(v[1], v[2])
    end
    inst.components.lootdropper.numrandomloot = 1
    inst.components.lootdropper.speed = 2
    inst.components.lootdropper.alwaysinfront = true

    ---------------------
    inst:AddComponent("inspectable")
	
	inst:WatchWorldState("startday", gaincoin49)	

    inst.OnLoad = onload

	return inst
end

local function fn46(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, 1.5)
	
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )  	

	anim:SetBank("oincpile")
	anim:SetBuild("oincpile")
	anim:PlayAnimation("46")

     inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    ---------------------
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
    inst.components.pickable.getregentimefn = 0
    inst.components.pickable.onpickedfn = onpickedfn
--    inst.components.pickable.makebarrenfn = makebarrenfn
--    inst.components.pickable.makefullfn = makefullfn
    inst.components.pickable.max_cycles = 46
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
    inst.components.pickable:SetUp(nil,0)
    inst.components.pickable.transplanted = true	
    ---------------------
    inst:AddComponent("lootdropper")
    for i,v in pairs(loots) do
        inst.components.lootdropper:AddRandomLoot(v[1], v[2])
    end
    inst.components.lootdropper.numrandomloot = 1
    inst.components.lootdropper.speed = 2
    inst.components.lootdropper.alwaysinfront = true

    ---------------------
    inst:AddComponent("inspectable")
	
	inst:WatchWorldState("startday", gaincoin46)	

    inst.OnLoad = onload

	return inst
end

local function fn42(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, 1.5)

	anim:SetBank("oincpile")
	anim:SetBuild("oincpile")
	anim:PlayAnimation("42")
	
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )  	

     inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    ---------------------
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
    inst.components.pickable.getregentimefn = 0
    inst.components.pickable.onpickedfn = onpickedfn
--    inst.components.pickable.makebarrenfn = makebarrenfn
--    inst.components.pickable.makefullfn = makefullfn
    inst.components.pickable.max_cycles = 42
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
    inst.components.pickable:SetUp(nil,0)
    inst.components.pickable.transplanted = true	
    ---------------------
    inst:AddComponent("lootdropper")
    for i,v in pairs(loots) do
        inst.components.lootdropper:AddRandomLoot(v[1], v[2])
    end
    inst.components.lootdropper.numrandomloot = 1
    inst.components.lootdropper.speed = 2
    inst.components.lootdropper.alwaysinfront = true

    ---------------------
    inst:AddComponent("inspectable")
	
	inst:WatchWorldState("startday", gaincoin42)	

    inst.OnLoad = onload

	return inst
end

local function fnfree(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, 1.5)
	
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )  	

	anim:SetBank("oincpile")
	anim:SetBuild("oincpile")
	anim:PlayAnimation("52")
	inst:SetPrefabNameOverride("oincpile52")	
     inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
    ---------------------
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_berries"
    inst.components.pickable.getregentimefn = 0
    inst.components.pickable.onpickedfn = onpickedfnfree
--    inst.components.pickable.makebarrenfn = makebarrenfn
--    inst.components.pickable.makefullfn = makefullfn
    inst.components.pickable.max_cycles = 52
    inst.components.pickable.cycles_left = inst.components.pickable.max_cycles
    inst.components.pickable:SetUp(nil,0)
    inst.components.pickable.transplanted = true	
    ---------------------
    inst:AddComponent("lootdropper")
    for i,v in pairs(loots) do
        inst.components.lootdropper:AddRandomLoot(v[1], v[2])
    end
    inst.components.lootdropper.numrandomloot = 1
    inst.components.lootdropper.speed = 2
    inst.components.lootdropper.alwaysinfront = true

    ---------------------
    inst:AddComponent("inspectable")
	
	inst:WatchWorldState("startday", gaincoin52)
	

    inst.OnLoad = onload

	return inst
end

return Prefab("forest/monsters/oincpile52", fn, assets, prefabs ),
	   Prefab("forest/monsters/oincpile46", fn46, assets, prefabs ),
	   Prefab("forest/monsters/oincpile49", fn49, assets, prefabs ),
	   Prefab("forest/monsters/oincpile42", fn42, assets, prefabs ),
	   Prefab("forest/monsters/oincpilefree", fnfree, assets, prefabs )	   

