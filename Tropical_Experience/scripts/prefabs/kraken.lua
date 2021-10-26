local assets =
{
    Asset("ANIM", "anim/quacken.zip"),
    Asset("MINIMAP_IMAGE", "quacken"),
}

local prefabs =
{
    "kraken_tentacle",
    "kraken_projectile",
--    "kraken_inkpatch",
    "krakenchest",
}

SetSharedLootTable('kraken',
{
    {"piratepack", 1.00},
})

local MIN_HEALTH = 
{
	0.80,
	0.60,
	0.40,
	0.20,
	0.10,
	-1.0,
}

local tesouroescondido =
{
		[1] = "tfwp_healing_staff",		
		[2] = "purplegem",	
		[3] = "orangegem",	
		[4] = "yellowgem",	
		[5] = "greengem",	
		[6] = "redgem",	
		[7] = "bluegem",	
		[8] = "supertelescope",	
		[9] = "spear_poison",	
		[10] = "boat_lantern",	
		[11] = "papyrus",	
		[12] = "tunacan",	
		[13] = "goldnugget",	
		[14] = "gears",	
		[15] = "rope",	
		[16] = "minerhat",	
		[17] = "dubloon",	
		[18] = "axeobsidian",	
		[19] = "telescope",	
		[20] = "captainhat",	
		[21] = "peg_leg",	
		[22] = "volcanostaff",	
		[23] = "footballhat",	
		[24] = "spear",	
		[25] = "goldenaxe",	
		[26] = "goldenshovel",	
		[27] = "goldenpickaxe",	
		[28] = "seatrap",	
		[29] = "compass",	
		[30] = "boneshard",	
		[31] = "transistor",	
		[32] = "gunpowder",	
		[33] = "heatrock",	
		[34] = "antidote",	
		[35] = "healingsalve",	
		[36] = "blowdart_sleep",	
		[37] = "nightsword",	
		[38] = "amulet",	
		[39] = "clothsail",	
		[40] = "boatrepairkit",	
		[41] = "coconade",	
		[42] = "boatcannon",	
		[43] = "snakeskinhat",	
		[44] = "armor_snakeskin",	
		[45] = "spear_launcher",	
		[46] = "piratehat",	
		[47] = "boomerang",	
		[48] = "snakeskin",	
		[49] = "strawhat",	
		[50] = "blubbersuit",	
		[51] = "nightmarefuel",	
		[52] = "obsidianmachete",	
		[53] = "trap_teeth",	
		[54] = "spear_obsidian",	
		[55] = "armorobsidian",	
		[56] = "goldenmachete",	
		[57] = "obsidianbomb",	
		[58] = "fabric",	
		[59] = "harpoon",	
		[60] = "umbrella",	
		[61] = "birdtrap",	
		[62] = "featherhat",	
		[63] = "beehat",	
		[64] = "bandage",	
		[65] = "armorwood",	
		[66] = "armormarble",	
		[67] = "blowdart_pipe",	
		[68] = "armorgrass",	
		[69] = "armor_seashell",	
		[70] = "cane",	
		[71] = "icestaff",	
		[72] = "firestaff",	
		[73] = "blowdart_fire",	
		[74] = "yellowamulet",	
		[75] = "armorruins",	
		[76] = "ruins_bat",	
		[77] = "ruinshat",	
		[78] = "cutgrass",	
		[79] = "charcoal",	
		[80] = "axe",	
		[81] = "hammer",	
		[82] = "shovel",	
		[83] = "bugnet",	
		[84] = "fishingrod",	
		[85] = "spidergland",	
		[86] = "silk",	
		[87] = "flint",
		[88] = "coral",		
}

local vidamaxima = 6000

local function MoveToNewSpot(inst)
local pos = inst:GetPosition()
local x, y, z = inst.Transform:GetWorldPosition()


local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-40,40), y, z+math.random(-40,40))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.OCEAN_COASTAL then
--ground == GROUND.OCEAN_COASTAL_SHORE or
--ground == GROUND.OCEAN_SWELL then
--ground == GROUND.OCEAN_ROUGH or
--ground == GROUND.OCEAN_BRINEPOOL or
--ground == GROUND.OCEAN_BRINEPOOL_SHORE or
--ground == GROUND.OCEAN_HAZARDOUS then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-40,40), y, z+math.random(-40,40))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.OCEAN_COASTAL then
--ground == GROUND.OCEAN_COASTAL_SHORE or
--ground == GROUND.OCEAN_SWELL then
--ground == GROUND.OCEAN_ROUGH or
--ground == GROUND.OCEAN_BRINEPOOL or
--ground == GROUND.OCEAN_BRINEPOOL_SHORE or
--ground == GROUND.OCEAN_HAZARDOUS then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-40,40), y, z+math.random(-40,40))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.OCEAN_COASTAL then
--ground == GROUND.OCEAN_COASTAL_SHORE or
--ground == GROUND.OCEAN_SWELL then
--ground == GROUND.OCEAN_ROUGH or
--ground == GROUND.OCEAN_BRINEPOOL or
--ground == GROUND.OCEAN_BRINEPOOL_SHORE or
--ground == GROUND.OCEAN_HAZARDOUS then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-40,40), y, z+math.random(-40,40))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.OCEAN_COASTAL then
--ground == GROUND.OCEAN_COASTAL_SHORE or
--ground == GROUND.OCEAN_SWELL then
--ground == GROUND.OCEAN_ROUGH or
--ground == GROUND.OCEAN_BRINEPOOL or
--ground == GROUND.OCEAN_BRINEPOOL_SHORE or
--ground == GROUND.OCEAN_HAZARDOUS then
inst:PushEvent("move", {pos = new_pos})
return end

local movimento = SpawnPrefab("log")
movimento.Transform:SetPosition(x+math.random(-40,40), y, z+math.random(-40,40))
local x1, y1, z1 = movimento.Transform:GetWorldPosition()
local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x1, y1, z1))
local new_pos = movimento:GetPosition()
movimento:Remove()
if ground == GROUND.OCEAN_COASTAL then
--ground == GROUND.OCEAN_COASTAL_SHORE or
--ground == GROUND.OCEAN_SWELL then
--ground == GROUND.OCEAN_ROUGH or
--ground == GROUND.OCEAN_BRINEPOOL or
--ground == GROUND.OCEAN_BRINEPOOL_SHORE or
--ground == GROUND.OCEAN_HAZARDOUS then
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
    	MoveToNewSpot(inst)
    end
end

local RND_OFFSET = 12

local function OnAttack(inst, data)
    local numshots = 20

    if data.target then
for i = 1, numshots/2 do
inst.components.thrower.throwable_prefab = "kraken_projectile"
local x, y, z = inst.Transform:GetWorldPosition()
local x1 = x + math.random(-24,24)
local y1 = y
local z1 = z + math.random(-24,24)
local new_pos = Vector3(x1,y1,z1)
inst.components.thrower:Throw(new_pos)
end

for i = 1, numshots do
inst.components.thrower.throwable_prefab = "kraken_projectile2"
local x, y, z = inst.Transform:GetWorldPosition()
local x1 = x + math.random(-24,24)
local y1 = y
local z1 = z + math.random(-24,24)
local new_pos = Vector3(x1,y1,z1)
inst.components.thrower:Throw(new_pos)
end
--[[
        for i = 1, numshots do
            local offset = Vector3(math.random(-RND_OFFSET, RND_OFFSET), math.random(-RND_OFFSET, RND_OFFSET), math.random(-RND_OFFSET, RND_OFFSET))
            inst.components.thrower:Throw(data.target:GetPosition() + offset)
        end
]]		
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
        
local chest = SpawnPrefab("krakenchest")
local kraken_s = SpawnPrefab("kraken_spawner")



-----pode vir até 9 moedas----------------------
for i = 1, 5 do
if math.random() > 0.5 then
local single = SpawnPrefab("dubloon")
chest.components.container:GiveItem(single)
end
end

for i = 1, 4 do
if math.random() > 0.5 then
local single = SpawnPrefab("coral")
chest.components.container:GiveItem(single)
end
end

-----pode vir até 8 tesouros----------------------
for i = 1, 6 do
if math.random() > 0.5 then
local single = SpawnPrefab(tesouroescondido[math.random(1, 88)])
chest.components.container:GiveItem(single)
end
end


local single4 = SpawnPrefab("quackenbeak")
chest.components.container:GiveItem(single4)

local single5 = SpawnPrefab("obsidian")
chest.components.container:GiveItem(single5)

		
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
	data.revelado = inst.revelado
end

local function OnLoad(inst, data)
	if data and data.health_stage then
	inst.health_stage = data.health_stage or inst.health_stage
		inst.components.health:SetMinHealth(vidamaxima * MIN_HEALTH[inst.health_stage])
	end
	
	if data and data.revelado then	
	inst.revelado = data.revelado
	end
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
--inst.AnimState:SetLayer(LAYER_WORLD)
--inst.AnimState:SetSortOrder(2)

    anim:SetBank("quacken")
    anim:SetBuild("quacken")
    anim:PlayAnimation("idle_loop", true)

    inst:AddTag("kraken")
    inst:AddTag("nowaves")
    inst:AddTag("epic")
    inst:AddTag("noteleport")
	inst:AddTag("mudacamada")

    MakeCharacterPhysics(inst, 1000, 1)

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
    inst.components.minionspawner2.validtiletypes = {GROUND.OCEAN_COASTAL, GROUND.OCEAN_WATERLOG, GROUND.OCEAN_COASTAL_SHORE, GROUND.OCEAN_SWELL, GROUND.OCEAN_ROUGH, GROUND.OCEAN_BRINEPOOL, GROUND.OCEAN_BRINEPOOL_SHORE, GROUND.OCEAN_HAZARDOUS}
    inst.components.minionspawner2.miniontype = "kraken_tentacle"
    inst.components.minionspawner2.distancemodifier = 35
    inst.components.minionspawner2.maxminions = 35
	inst.components.minionspawner2:RegenerateFreePositions()
	inst.components.minionspawner2.shouldspawn = false

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('kraken')

	inst:AddComponent("thrower")
	inst.components.thrower.throwable_prefab = "kraken_projectile"

    inst:SetStateGraph("SGkraken")
    local brain = require("brains/krakenbrain")
    inst:SetBrain(brain)
	
    inst.health_stage = 1

    inst:ListenForEvent("minhealth", OnMinHealth)
    inst.components.health:SetMinHealth(vidamaxima * MIN_HEALTH[inst.health_stage])
    inst:ListenForEvent("death", SpawnChest)
    inst:ListenForEvent("onattackother", OnAttack)
    inst:ListenForEvent("onremove", OnRemove)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

	return inst
end

return Prefab("kraken", fn, assets, prefabs)
