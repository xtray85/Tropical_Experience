local CANOPY_SHADOW_DATA = require("prefabs/canopyshadows")

local prefabs = 
{
    "glowfly",
}

local assets =
{
    Asset("ANIM", "anim/pillar_tree.zip"),
    Asset("SOUND", "sound/tentacle.fsb"),
    Asset("MINIMAP_IMAGE", "pillar_tree"),
}

local MIN = TUNING.SHADE_CANOPY_RANGE_SMALL
local MAX = MIN + TUNING.WATERTREE_PILLAR_CANOPY_BUFFER

local function spawncocoons(inst)
if TheWorld.state.iswinter then
    if math.random() < 0.2 then
	local jogador = GetClosestInstWithTag("player", inst, 20)
        local pt = inst:GetPosition()
        local range = 5 + math.random()*10
        local angle =  math.random() * 2 * PI
        local offset = FindWalkableOffset(pt,angle, range, 10)

        if offset then
            local newpoint = pt+offset
            if jogador then
                for i=1, math.random(6,10) do
                    range = math.random()*8
                    angle =  math.random() * 2 * PI
                    local suboffset = FindWalkableOffset(newpoint,angle, range, 10)
                    local cocoon = SpawnPrefab("glowfly_cocoon")
                    local spawnpt = newpoint + suboffset
                    cocoon.Physics:Teleport(spawnpt.x,spawnpt.y,spawnpt.z)                    
--                    cocoon:AddTag("cocoonspawn")
--                    cocoon.forceCocoon(cocoon)     
                end
            end
        end
    end
	end
end

local function OnFar(inst)
    if inst.players then
        local x, y, z = inst.Transform:GetWorldPosition()
        local testset = {}
        for player,i in pairs(inst.players)do
            testset[player] = true        
        end

        for i,player in ipairs(FindPlayersInRangeSq(x, y, z, MAX*MAX))do
            if testset[player] then
                testset[player] = false
            end
        end

        for player,i in pairs(testset)do
            if i == true then
                if player.treepillar then
                   player.treepillar = player.treepillar - 1
                   if player.treepillar == 0 then
--                       player:PushEvent("onchangecanopyzone", false)
					   player:RemoveTag("mostraselva") 
                   end
                end
                inst.players[player] = nil
            end
        end
    end
end

local function OnNear(inst,player)
    if not inst.players then
        inst.players = {}
    end

    inst.players[player] = true

    if not player.treepillar then
        player.treepillar = 0
    end
    player.treepillar = player.treepillar + 1
    if player.treepillar == 1 then
--        player:PushEvent("onchangecanopyzone", true)
		player:AddTag("mostraselva") 
    end
end

local function removecanopyshadow(inst)
    if inst.canopy_data ~= nil then
        for _, shadetile_key in ipairs(inst.canopy_data.shadetile_keys) do
            if TheWorld.shadetiles[shadetile_key] ~= nil then
                TheWorld.shadetiles[shadetile_key] = TheWorld.shadetiles[shadetile_key] - 1

                if TheWorld.shadetiles[shadetile_key] <= 0 then
                    if TheWorld.shadetile_key_to_leaf_canopy_id[shadetile_key] ~= nil then
                        DespawnLeafCanopy(TheWorld.shadetile_key_to_leaf_canopy_id[shadetile_key])
                        TheWorld.shadetile_key_to_leaf_canopy_id[shadetile_key] = nil
                    end
                end
            end
        end

        for _, ray in ipairs(inst.canopy_data.lightrays) do
            ray:Remove()
        end
    end
end

local function removecanopy(inst)
    print("REMOVING CANOPU")
    if inst.roots then
        inst.roots:Remove()
    end
    if inst._ripples then
        inst._ripples:Remove()
    end

    if inst.players ~= nil then
        for k, v in pairs(inst.players) do
            if k:IsValid() then
                if k.canopytrees ~= nil then
                    k.canopytrees = k.canopytrees - 1
                    if k.canopytrees <= 0 then
                        k:PushEvent("onchangecanopyzone", false)
                    end
                end
            end
        end
    end
    inst._hascanopy:set(false)    
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 3, 24)

    -- THIS WAS COMMENTED OUT BECAUSE THE ROC WAS BUMPING INTO IT. BUT I'M NOT SURE WHY IT WAS SET THAT WAY TO BEGIN WITH.
    --inst.Physics:SetCollisionGroup(COLLISION.GROUND)
    trans:SetScale(1,1,1)
    inst:AddTag("tree_pillar")    

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "pillar_tree.png" )

	anim:SetBank("pillar_tree")-- flash animation .fla 
	anim:SetBuild("pillar_tree")   -- art files

    anim:PlayAnimation("idle",true)
	
	
    if not TheNet:IsDedicated() then
        inst:AddComponent("distancefade")
        inst.components.distancefade:Setup(15,25)
    end
    
    inst._hascanopy = net_bool(inst.GUID, "oceantree_pillar._hascanopy", "hascanopydirty")
    inst._hascanopy:set(true)    
    inst:DoTaskInTime(0, function()    
        inst.canopy_data = CANOPY_SHADOW_DATA.spawnshadow(inst, math.floor(TUNING.SHADE_CANOPY_RANGE_SMALL/4), true)
    end)

    inst:ListenForEvent("hascanopydirty", function()
                if not inst._hascanopy:value() then 
                    removecanopyshadow(inst) 
                end
        end)	
	

	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
		return inst
	end 	
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(MIN, MAX)
    inst.components.playerprox:SetOnPlayerFar(OnFar)
    inst.components.playerprox:SetOnPlayerNear(OnNear)	
	
	inst:WatchWorldState("isday", spawncocoons)
	inst:WatchWorldState("isnight",spawncocoons)
	inst:WatchWorldState("isdusk", spawncocoons)
	
    
   return inst
end

return Prefab( "cave/monsters/tree_pillar", fn, assets, prefabs )
