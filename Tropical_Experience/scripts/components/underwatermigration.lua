-- manages the migration event of the rainbowjellyfish


underwaterMigrationManager = Class(function(self, inst)
    self.inst = inst
	self.diad = 0
    -- number of jellyfish to be placed for effect during the migration
    self.isMigrationActive = false
	
	self.inst:WatchWorldState("stopcaveday", function(inst, data)
	if self.diad ~= TheWorld.state.cycles and TheWorld.state.cycles > 3 then
	self.diad = TheWorld.state.cycles	
	self:OnDayComplete() 
--	print("foi")
	end
	end)
	
	self.inst:WatchWorldState("startcaveday", function(inst, data) 
	if self.diad == TheWorld.state.cycles - 1 and TheWorld.state.cycles > 3 then
	self.diad = 0	
	self:OnDayComplete() 
--	print("veio")	
	end
	end)
end)

function underwaterMigrationManager:IsMigrationActive()
    -- if this becomes functional, then no need to save/load
    return self.isMigrationActive
end

function underwaterMigrationManager:OnDayComplete()
	if TheWorld.state.moonphase == "new" and TheWorld.state.cycles > 3 or TheWorld.state.moonphase == "full" and TheWorld.state.cycles > 3 then
        self:StartMigration()
    else
        self:EndMigration()
    end
end

function underwaterMigrationManager:OnSave()
    return { isMigrationActive = self.isMigrationActive }
end

function underwaterMigrationManager:OnLoad(data)
    self.isMigrationActive = data.isMigrationActive or self.isMigrationActive
end


local function setupHomeAndMigrationDestination(jelly, migrationPos, teleport)
    -- make sure they remember their actual home
    local home = jelly.components.knownlocations:GetLocation("home")
    if home == nil then
        -- find out why it didnt know its home yet..
        jelly.components.knownlocations:RememberLocation("home", Vector3(jelly.Transform:GetWorldPosition()))
    end

    local offset = FindWalkableOffset(migrationPos, math.random() * 2 * PI, math.random(2,25), 4)

    -- tell them about their new destination
	if offset then
    local jellyHome = Vector3(migrationPos.x + offset.x, migrationPos.y + offset.y, migrationPos.z + offset.z)
    jelly.components.knownlocations:RememberLocation("migration", jellyHome)

    if teleport then
--        jelly.Transform:SetPosition(jellyHome.x, jellyHome.y, jellyHome.z)
    end
	end
end

function underwaterMigrationManager:StartMigration()
    if self.isMigrationActive == true then
        return
    end
    local theVolcano = TheSim:FindFirstEntityWithTag("reidomar")

    if theVolcano then
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 40

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, 0, z))

if ground == GROUND.UNDERWATER_SANDY or ground == GROUND.UNDERWATER_ROCKY or (ground == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground == GROUND.PAINTED and TheWorld:HasTag("cave")) then
local colocaitem = SpawnPrefab("jellyfish_underwater")
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 40

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
-------------------coloca os itens------------------------
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, 0, z))

if ground == GROUND.UNDERWATER_SANDY or ground == GROUND.UNDERWATER_ROCKY or (ground == GROUND.BEACH and TheWorld:HasTag("cave")) or (ground == GROUND.BATTLEGROUND and TheWorld:HasTag("cave")) or (ground == GROUND.PEBBLEBEACH and TheWorld:HasTag("cave")) or (ground == GROUND.MAGMAFIELD and TheWorld:HasTag("cave")) or (ground == GROUND.PAINTED and TheWorld:HasTag("cave")) then
local colocaitem = SpawnPrefab("rainbowjellyfish_underwater")
if colocaitem then
colocaitem.Transform:SetPosition(x, 0, z)
end
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0

        print("starting rainbow jellyfish migration..")
        self.isMigrationActive = true
        local volcanoPos = Vector3(theVolcano.Transform:GetWorldPosition())

        -- migration home is towards the center of the map
        local dir = Vector3(0,0,0) - volcanoPos;
        dir:Normalize()
        local migrationHomePos = volcanoPos + (dir * 30.0);
        local jellies = TheSim:FindEntities(migrationHomePos.x, migrationHomePos.y, migrationHomePos.z, 9999, {"rainbowjellyfish", })

        local numJelliesToRelocate = math.floor(#jellies * 1.0)
        local numJelliesAtVolcano = math.floor(numJelliesToRelocate * 0.1)

        print("Migrating " .. tostring(numJelliesToRelocate) .. " rainbowjellyfish")


        local streetDestination = volcanoPos + (dir * 30.0)
        local mainAngle = -math.atan2(dir.z, dir.x)
        local streetAngles = { mainAngle - PI * 0.25, mainAngle, mainAngle + PI * 0.25 }

        local numJelliesPerStreet = math.floor((numJelliesToRelocate - numJelliesAtVolcano) / #streetAngles)

        -- setup crowd at volcano
        -- recalc at volcano so all jellies are used
        numJelliesAtVolcano = numJelliesToRelocate - (numJelliesPerStreet * #streetAngles)
        for i=1, numJelliesAtVolcano, 1 do
            setupHomeAndMigrationDestination(jellies[i], migrationHomePos, true)
        end


        -- setup the streets
        local i = numJelliesAtVolcano + 1

        for s=1, #streetAngles, 1 do
            local p = streetDestination
            local angle = streetAngles[s]

            for j=1, numJelliesPerStreet, 1 do   
                setupHomeAndMigrationDestination(jellies[i], migrationHomePos, false)

                -- hop through the water in increments to build a path towards the middle
                local angleVariation = math.random(-1, 1) * PI * 0.25		
				local offset = FindWalkableOffset(p, angle + angleVariation, 7 + (j * 0.2), 4)
				
--                local offset = FindWalkableOffset(p, angle + angleVariation, 7 + (j * 0.2), 4)
                if offset == nil then
                    print("Unable to build full jelly fish straight.. aborting")
                    break
                end

                -- place a jellyfish
                local jellyPos = p + offset
                jellies[i].Transform:SetPosition(jellyPos.x, jellyPos.y, jellyPos.z)

                -- continue on straight
                p = p + offset

                i = i + 1
            end

        end
    else
        print("THERE IS NO VOLCANO. IGNORE THE MIGRATION")
    end

end

function underwaterMigrationManager:EndMigration()

    if self.isMigrationActive == false then
        return
    end

    print("ending rainbow jellyfish migration..")
    self.isMigrationActive = false

    -- this part isn't needed, just let the jellies go back to their homes normally. 
    --[[
    local theVolcano = TheSim:FindFirstEntityWithTag("theVolcano")
    local volcanoPos = Vector3(theVolcano.Transform:GetWorldPosition())

    -- return all jellyfish to their spawn location
    local jellies = TheSim:FindEntities(volcanoPos.x, volcanoPos.y, volcanoPos.z, 9999, {"rainbowjellyfish"})
    local numJellyfish = #jellies

    for i=1, numJellyfish, 1 do
        local home = jellies[i].components.knownlocations:GetLocation("home")
        if home then
    		jellies[i].Transform:SetPosition(home.x, home.y, home.z)
    	else
    		print("!!ERROR: Could Not Find Jellyfish Home")
    	end
    end
    ]]
end

return underwaterMigrationManager
