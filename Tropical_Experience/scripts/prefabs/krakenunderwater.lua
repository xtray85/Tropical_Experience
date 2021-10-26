local assets =
{
    Asset("ANIM", "anim/quacken.zip"),
    Asset("MINIMAP_IMAGE", "quacken"),
    Asset("ANIM", "anim/quackenhole.zip"),
}

local prefabs =
{
    "krakenunderwater_tentacle",
    "kraken_projectile",
    "sunkenchest",
}

SetSharedLootTable('krakenunderwater',
{
    {"pearl_amulet", 1.00},
})

local MIN_HEALTH = 
{
	0.90,
	0.80,
	0.70,	
	0.60,
	0.50,	
	0.40,
	0.30,	
	0.20,
	0.10,
	-1.0,
}

local vidamaxima = 6000

local function MoveToNewSpot(inst)
local pos = inst:GetPosition()
local x, y, z = inst.Transform:GetWorldPosition()

local invader = GetClosestInstWithTag("player", inst, 30)
if invader then
local new_pos = invader:GetPosition()
inst:PushEvent("move", {pos = new_pos})
return end


local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-1,1), y, z+math.random(-1,1))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.UNDERWATER_SANDY then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-1,1), y, z+math.random(-1,1))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.UNDERWATER_SANDY then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-1,1), y, z+math.random(-1,1))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.UNDERWATER_SANDY then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-1,1), y, z+math.random(-1,1))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.UNDERWATER_SANDY then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-1,1), y, z+math.random(-1,1))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.UNDERWATER_SANDY then
inst:PushEvent("move", {pos = new_pos})
return end

local new_pos = pos
inst:PushEvent("move", {pos = new_pos})
end

local function OnMinHealth(inst, data)
    if not inst.components.health:IsDead() then
    	inst.health_stage = inst.health_stage + 1
    	inst.health_stage = math.min(inst.health_stage, #MIN_HEALTH)
    	inst.components.health:SetMinHealth(vidamaxima * MIN_HEALTH[inst.health_stage])


	 if math.fmod (inst.health_stage, 2) == 0 then			
		inst.sg:GoToState("taunt2")
	 else
    	MoveToNewSpot(inst)
	end
    end
end

local RND_OFFSET = 4

local function OnAttack(inst, data)
    local numshots = 10
    if data.target then
        for i = 1, numshots do
            local offset = Vector3(math.random(-RND_OFFSET, RND_OFFSET), math.random(-RND_OFFSET, RND_OFFSET), math.random(-RND_OFFSET, RND_OFFSET))
            inst.components.thrower:Throw(data.target:GetPosition() + offset)
        end
    end
end

local function Retarget(inst)
    return FindEntity(inst, 40, function(guy) 
        if guy.components.combat and guy.components.health and not guy.components.health:IsDead() then
            return not (guy.prefab == inst.prefab)
        end
    end, nil, {"prey"}, {"character", "monster", "animal"})
end

local function ShouldKeepTarget(inst, target)
    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
        local distsq = target:GetDistanceSqToInst(inst)
        return distsq < 1600
    else
        return false
    end
end

local function SpawnChest(inst)
    inst:DoTaskInTime(3, function()
        inst.SoundEmitter:PlaySound("dontstarve/common/ghost_spawn")
        
local chest = SpawnPrefab("sunkenchest")
local kraken_s = SpawnPrefab("krakenunderwater_spawner")


if math.random() > 0.5 then
local single = SpawnPrefab("coral_cluster")
chest.components.container:GiveItem(single)
else
local single = SpawnPrefab("flare")
chest.components.container:GiveItem(single)
end

if math.random() > 0.5 then
local single1 = SpawnPrefab("coral_cluster")
chest.components.container:GiveItem(single1)
else
local single1 = SpawnPrefab("flare")
chest.components.container:GiveItem(single1)
end

if math.random() > 0.5 then
local single2 = SpawnPrefab("iron_ore")
chest.components.container:GiveItem(single2)
else
local single2 = SpawnPrefab("sponge_piece")
chest.components.container:GiveItem(single2)
end


if math.random() > 0.5 then
local single3 = SpawnPrefab("snorkel")
chest.components.container:GiveItem(single3)
else
local single3 = SpawnPrefab("hat_submarine")
chest.components.container:GiveItem(single3)
end

if math.random() > 0.5 then
local single4 = SpawnPrefab("diving_suit_summer")
chest.components.container:GiveItem(single4)
else
local single4 = SpawnPrefab("diving_suit_winter")
chest.components.container:GiveItem(single4)
end

if math.random() > 0.5 then
local single5 = SpawnPrefab("coral_cluster")
chest.components.container:GiveItem(single5)
else
local single5 = SpawnPrefab("harpoon")
chest.components.container:GiveItem(single5)
end


if math.random() > 0.5 then
local single6 = SpawnPrefab("ruinshat")
chest.components.container:GiveItem(single6)
else
local single6 = SpawnPrefab("ruinshat")
chest.components.container:GiveItem(single6)
end

if math.random() > 0.5 then
local single7 = SpawnPrefab("flare")
chest.components.container:GiveItem(single7)
else
local single7 = SpawnPrefab("harpoon")
chest.components.container:GiveItem(single7)
end


if math.random() > 0.5 then
local single8 = SpawnPrefab("flare")
chest.components.container:GiveItem(single8)
else
local single8 = SpawnPrefab("harpoon")
chest.components.container:GiveItem(single8)
end

		
local pos = inst:GetPosition()
chest.Transform:SetPosition(pos.x, 0, pos.z)
kraken_s.Transform:SetPosition(pos.x, 0, pos.z)
local vx, vy, vz = chest.Physics:GetVelocity()
chest.Physics:SetVel(vx, 15+(math.random() * 5), vz)

end)
end

local function OnRemove(inst)
    inst.components.minionspawner2:DespawnAll()
end

local function OnSave(inst, data)
	data.health_stage = inst.health_stage
end

local function OnLoad(inst, data)
	if data and data.health_stage then
	inst.health_stage = data.health_stage or inst.health_stage
		inst.components.health:SetMinHealth(vidamaxima * MIN_HEALTH[inst.health_stage])
	end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

    anim:SetBank("quacken")
    anim:SetBuild("quacken")
    anim:PlayAnimation("idle_loop", true)
	
	inst.AnimState:OverrideSymbol("droplet", "quacken", "")
	inst.AnimState:OverrideSymbol("inner_bubble", "quacken", "")
	inst.AnimState:OverrideSymbol("ripple3_back", "quacken", "")
	inst.AnimState:OverrideSymbol("ripple3_cutout", "quacken", "")
	inst.AnimState:OverrideSymbol("splash", "quacken", "")
	inst.AnimState:OverrideSymbol("splash_cone", "quacken", "")
	inst.AnimState:OverrideSymbol("splash_radial", "quacken", "")
	inst.AnimState:OverrideSymbol("tentacle_fade", "quacken", "")
	inst.AnimState:OverrideSymbol("wabble", "quacken", "")
	inst.AnimState:OverrideSymbol("pop", "quacken", "")	

    inst:AddTag("kraken")
    inst:AddTag("nowaves")
    inst:AddTag("epic")
    inst:AddTag("noteleport")
	inst:AddTag("reidomar")
	

	MakeWaterObstaclePhysics(inst, 1, 2, 1.25)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("quacken.png")

	inst.entity:SetPristine()

        if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(vidamaxima)
    inst.components.health.nofadeout = true

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(0)
    inst.components.combat:SetAttackPeriod(7.5)
    inst.components.combat:SetRange(40,50)
    inst.components.combat:SetRetargetFunction(1, Retarget)
    inst.components.combat:SetKeepTargetFunction(ShouldKeepTarget)

    inst:AddComponent("sanityaura")    
    inst:AddComponent("locomotor")

	
    inst:AddComponent("minionspawner2")
    inst.components.minionspawner2.validtiletypes = {GROUND.UNDERWATER_SANDY, GROUND.UNDERWATER_ROCKY, GROUND.BEACH, GROUND.MAGMAFIELD, GROUND.PAINTED, GROUND.BATTLEGROUND, GROUND.PEBBLEBEACH}
	
    inst.components.minionspawner2.miniontype = "krakenunderwater_tentacle"
    inst.components.minionspawner2.distancemodifier = 9
    inst.components.minionspawner2.maxminions = 35
	inst.components.minionspawner2:RegenerateFreePositions()
	inst.components.minionspawner2.shouldspawn = false

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('krakenunderwater')

	inst:AddComponent("thrower")
	inst.components.thrower.throwable_prefab = "kraken_projectile_underwater"

    inst:SetStateGraph("SGkrakenunderwater")
    local brain = require("brains/krakenbrain")
    inst:SetBrain(brain)

    inst.health_stage = 1

    inst:ListenForEvent("minhealth", OnMinHealth)
    inst.components.health:SetMinHealth(vidamaxima * MIN_HEALTH[inst.health_stage])
    inst:ListenForEvent("death", SpawnChest)
    inst:ListenForEvent("onattackother", OnAttack)
    inst:ListenForEvent("onremove", OnRemove)
	
	inst.buraco2 = SpawnPrefab("krakenholefundo")
	inst.buraco2.entity:SetParent(inst.entity)
	inst.buraco2.Transform:SetPosition(0, -0.2, 0)	

	inst.buraco1 = SpawnPrefab("krakenholefrente")
	inst.buraco1.entity:SetParent(inst.entity)
	inst.buraco1.Transform:SetPosition(0, 0.2, 0)		

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

	return inst
end

local function fn1()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
--	inst.AnimState:SetLayer(4)	

    anim:SetBank("quackenhole")
    anim:SetBuild("quackenhole")
    anim:PlayAnimation("fente", true)
	
	inst:AddTag("FX")

	return inst
end

local function fn2()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	inst.AnimState:SetLayer(2)
--	inst.AnimState:SetSortOrder(2)

    anim:SetBank("quackenhole")
    anim:SetBuild("quackenhole")
    anim:PlayAnimation("fundo", true)
	
	inst:AddTag("FX")

	return inst
end

return Prefab("krakenunderwater", fn, assets, prefabs), Prefab("krakenholefrente", fn1, assets, prefabs), Prefab("krakenholefundo", fn2, assets, prefabs)
