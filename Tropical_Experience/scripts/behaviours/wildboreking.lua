local function TryFindSpotForMinion(player, dist)
    local x1, y1, z1 = player.Transform:GetWorldPosition()
    local angle = math.random() * 2 * PI    
    local x2, y2, z2 = 
        x1 + math.cos(angle)*dist,
        y1,
        z1 + math.sin(angle)*dist   
    if TheWorld.Pathfinder:IsClear(x1, y1, z1, x2, y2, z2, { ignorewalls = false }) then
        return x2, y2, z2
    end
end

local function OnRestoreItemPhysics(item)
    item.Physics:CollidesWith(COLLISION.OBSTACLES)
end

local function LaunchItem(inst, item, angle, minorspeedvariance)
    local x, y, z = inst.Transform:GetWorldPosition()
    local spd = 3.5 + math.random() * (minorspeedvariance and 1 or 3.5)
    item.Physics:ClearCollisionMask()
    item.Physics:CollidesWith(COLLISION.WORLD)
    item.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    item.Physics:Teleport(x, 2.5, z)
    item.Physics:SetVel(math.cos(angle) * spd, 11.5, math.sin(angle) * spd)
    item:DoTaskInTime(.6, OnRestoreItemPhysics)
    item:PushEvent("knockbackdropped", { owner = inst, knocker = inst, delayinteraction = .75, delayplayerinteraction = .5 })
--    if item.components.burnable ~= nil then
--        inst:ListenForEvent("onignite", function()
--            for k, v in pairs(inst._minigame_elites) do
--                k:SetCheatFlag()
--            end
--        end, item)
--    end
end
 
local function OnTossItems(inst)
    local items = {}
    local x, y, z = inst.Transform:GetWorldPosition()
    local numplayers = 4
    local mingold = 0
    local numgold = 0
    local numprops = 5

    for i = 1, numprops do
            table.insert(items, "propsign")
    end

    for i = 1, numgold do
        table.insert(items, "lucky_goldnugget")
    end

    local angle = math.random() * 2 * PI
    local delta = 2 * PI / (numgold + numprops + 1) --purposely leave a random gap
    local variance = delta * .4
    while #items > 0 do

	local item = SpawnPrefab(table.remove(items, math.random(#items)))

    LaunchItem(inst, item, GetRandomWithVariance(angle, variance))
    angle = angle + delta
    end
    
	if numgold > 0 then
        inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
    end
end
 
local function FindSpotForMinion(player, dist)
    for i = 1, 100 do
        local x, y, z = TryFindSpotForMinion(player, dist)
        if x then
            return x, y, z
        end
    end

    for i = 1, 20 do

        local r = dist - i/2
        while r > 0 do
            r = r - 3
            local x, y, z = TryFindSpotForMinion(player, r)
            if x then
                return x, y, z
            end
        end

    end

    print("Did not find spot!!!!")
    return nil
end


local function SpawnMinion(players, prefab, hat, rei)
    print("Spawning Pig King's Minion")
    local player = GetRandomItem(players) or ThePlayer
    local minion = SpawnPrefab(prefab or "pigman_minion")
    local cloud = SpawnPrefab("poopcloud")
    --minion.components.combat.target = player
    minion.components.combat:EngageTarget(player)
    print("------")
    print(minion)
    print(minion.prefab)
    print(minion.Transform)
    print("------")

    local x, y, z = FindSpotForMinion(rei, 3)

    if x == nil then
        return
    end

    minion.Transform:SetPosition(x, y, z) 
	minion.sg:GoToState("appear_start")
    cloud.Transform:SetPosition(x, y, z) 
    if hat then
        minion.components.inventory:Equip(SpawnPrefab(hat))
    end    
    return minion
end

local function MakeWave(players, wave, rei)
    local leader = SpawnMinion(players, wave.leaderprefab, wave.leadershat, rei)

    if leader == nil then
        print("[NEW BOSS - PIG KING]")
        print("ERROR: CANNOT FIND SPOT FOR PIG KING'S MINION")
        print("SPAWNING MINION WAVE IS ABORTED")
        return
    end

    if wave.leaderwere then
        leader.components.werebeast:SetWere(10000000)
        leader.components.combat:EngageTarget(GetRandomItem(players))
    end

    for i = 1, wave.n do
        local minion = SpawnMinion(players, wave.prefab, wave.hat, rei)       
        if wave.allwere then
            minion.components.werebeast:SetWere(10000000)
            minion:DoTaskInTime(5,
                function ()
                    minion.components.combat:EngageTarget(GetRandomItem(players))                
                end)
            
        end            
    end 
end

local MinionsWaves = {
    [1] = {
        prefab = "pigman_minion",
        n = 5,      
    },
    
    [2] = {
        prefab = "pigman_minion",
        leaderprefab = "pigguard_minion",
        n = 10,     
    },

    [3] = {
        prefab = "pigman_minion",
        leaderprefab = "pigguard_minion",
        leadershat = "footballhat",
        n = 15,
    }, 

    [4] = {
        prefab = "pigman_minion",
        leaderprefab = "pigguard_minion",
        leadershat = "footballhat",
        n = 15,
    }, 

    [5] = {
        prefab = "pigman_minion",
        leaderprefab = "pigguard_minion",
        hat = "footballhat",
        leadershat = "footballhat",
        leaderwere = true,
        n = 5,
    },         

    [6] = {
        prefab = "pigman_minion",
        leaderprefab = "pigguard_minion",
        hat = "footballhat",
        leadershat = "ruinshat",
        leaderwere = true,
        n = 10,
    }, 

    [7] = {
        prefab = "pigman_minion",
        leaderprefab = "pigguard_minion",
        hat = "ruinshat",
        leadershat = "ruinshat",
        leaderwere = true,
        allwere = false,
        n = 5,
    },    

    [8] = {
        prefab = "pigman_minion",
        leaderprefab = "pigguard_minion",
        hat = "ruinshat",
        leadershat = "ruinshat",
        leaderwere = true,
        allwere = true,
        n = 15,
    },       
}

--if TUNING.PigKingBossConf.Waves then
--    print("=== Overriding Pig King minion waves ===")
--    MinionsWaves = TUNING.PigKingBossConf.Waves
--end


local function RunWave(players, n, rei)
    MakeWave(players, MinionsWaves[n], rei)
end

--RunWave(TheWorld.ws, 1)


WildboreKingPanic = Class(BehaviourNode, function(self, inst)
    BehaviourNode._ctor(self, "WildboreKingPanic")
    self.inst = inst
    self.waittime = 0
end)

function WildboreKingPanic:CanMakeWave()
    return not (self.CannotMakeWave == true) -- Can be nil
end

function WildboreKingPanic:MakeWave(players)
    local health = self.inst.components.health:GetPercent()
    local n = math.ceil( (1-health) * (#MinionsWaves+0.1))
    
    if n < 1 then
        n = 1
    end    

    if n > #MinionsWaves then 
        n = #MinionsWaves
    end

    self.CannotMakeWave = true
    self.inst:DoTaskInTime(30, 
        function ()
           self.CannotMakeWave = nil
        end)

local rei = self.inst		
		
    RunWave(players, n, rei)
	
	self.inst:DoTaskInTime(1,
        function ()
           OnTossItems(rei)
        end)	
		
	self.inst:DoTaskInTime(15,
        function ()
           OnTossItems(rei)
        end)			
	
end

function WildboreKingPanic:Visit()

    if self.status == READY then
        self:PickNewDirection()
        self.status = RUNNING
    else
        if GetTime() > self.waittime then
            self:PickNewDirection()

            if self:CanMakeWave() then
                local Targets = self.inst.__brain:GetTargets()
                local Pigs = self.inst.__brain:GetPigs()
                if #Targets > 0 and #Pigs < 10 then
                    self:MakeWave(Targets)
                end
            end
        end
        self:Sleep(self.waittime - GetTime())
    end
end

function WildboreKingPanic:PickNewDirection()
    self.inst.components.locomotor:RunInDirection(math.random()*360)
    self.waittime = GetTime() + 0.25 + math.random()*0.25
    if math.random() < 0.1 then
        self.inst.SoundEmitter:PlaySound("dontstarve/pig/PigKingHappy")
    end
end



