require "behaviours/wildboreking"
require "behaviours/findclosest"
require "behaviours/follow"
require "behaviours/walkaway"

local SEE_PLAYER_DIST = 25
local CLOSE_DIST = 6
local MAX_DIST_TO_HOME = 15
local PIGS_CLOSE = 8


local function ShouldRunFn(inst, hunter)
    return inst.JanIke ~= nil
end

local WildboreKingBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)


--[[
0. If too far away from home, walk to Home

1. if Player is far away and not on the place then GoToThePlace
2. if Player is far away and on the place then SitDown

3. * If PlayerClose and CanJump and NoPigsAround then Jump
4. * If PlayerClose and CanCast then WalkAway
5. * if Player is not Close and CanCast then Cast
6. * panic    

]]

function WildboreKingBrain:GetTargets()
    --return FindEntities(self.inst, 10, nil, nil, { "notarget", "INLIMBO" }, { "player" })
    local x, y, z = self.inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, SEE_PLAYER_DIST, { "player" }, {"playerghost"})    
    return ents or {}
end

function WildboreKingBrain:GetPigs()
    --return FindEntities(self.inst, 10, nil, nil, { "notarget", "INLIMBO" }, { "player" })
    local x, y, z = self.inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, SEE_PLAYER_DIST, { "pigminion" })    
    return ents or {}
end

function WildboreKingBrain:GetAllPigs()
    --return FindEntities(self.inst, 10, nil, nil, { "notarget", "INLIMBO" }, { "player" })
    local x, y, z = self.inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, SEE_PLAYER_DIST, { "pig" })    
    return ents or {}
end


function WildboreKingBrain:ArePigsClose()
    return
        FindEntity(self.inst, PIGS_CLOSE, nil, { "pig" }, { "notarget", "INLIMBO", "playerghost" }) ~= nil
end

function WildboreKingBrain:IsPlayerNearby()
    return
        FindEntity(self.inst, SEE_PLAYER_DIST, nil, { "player" }, { "notarget", "INLIMBO", "playerghost" }) ~= nil
end

function WildboreKingBrain:IsPlayerClose()
    return
        FindEntity(self.inst, CLOSE_DIST, nil, { "player" }, { "notarget", "INLIMBO", "playerghost" }) ~=nil
end

function WildboreKingBrain:CanCast()
    return 
        not self.inst.sg:HasStateTag("busy") and 
        not self.inst.CannotCast 
end

function WildboreKingBrain:CanJump()
    return 
        not self.inst.sg:HasStateTag("busy") and
        not self.inst.CannotJump and
        (not self:ArePigsClose() or self:FarAwayFromHome())
end

-- If King is lying on the ground then his brain is turned off
function WildboreKingBrain:BrainIsOn()
    return
        not self.inst.sg:HasStateTag("mindless")
end

function WildboreKingBrain:IsOnThePlace()
    return
        self.inst:GetPosition():Dist(self.homepos) < 0.15
end

function WildboreKingBrain:TooFarAwayFromHome()
    return
        self.inst:GetPosition():Dist(self.homepos) > MAX_DIST_TO_HOME
end

function WildboreKingBrain:FarAwayFromHome()
    return
        self.inst:GetPosition():Dist(self.homepos) > MAX_DIST_TO_HOME - 1
end


function WildboreKingBrain:OnStart()
    self.inst.__brain = self
    local root = 
    PriorityNode({

        -- If Ping King is lying on the ground then his brain is turned off
        WhileNode(function() return not self:BrainIsOn() end, "BrainOff", 
            ActionNode(function () end)),

        --------------------------- GOING HOME PART ----------------------------------

        -- We have gone too far away from home. Running back
        WhileNode(function() return self:TooFarAwayFromHome() end, "",
            ChattyNode(self.inst, {""},
                ActionNode(function ( ... )
                    --print("Pig King is going home!")
                    self.inst.components.locomotor:GoToPoint(self.homepos, nil, true)
                end))),


        -- Sitting down (we just came home)
        WhileNode(function() return not self:IsPlayerNearby() and self:IsOnThePlace() end, "",
            ChattyNode(self.inst, {""},
                ActionNode(function ()
                    --print("Pig King is sitting down!")
                    self.inst.sg:GoToState("lying")
                end))),

        -- Going home
        WhileNode(function() return not self:IsPlayerNearby() and not self:IsOnThePlace() end, "",
            ChattyNode(self.inst, {""},
                ActionNode(function ( ... )
                    --print("Pig King is going home!")
                    --print(self.homepos)
                    self.inst.components.locomotor:GoToPoint(self.homepos, nil, false)
                end))),


        --------------------------- FIGHT PART STARTS HERE ---------------------------

        -- Jumping 
        --    if player is close 
        --       and it is possible to jump 
        --       and there are no pigs around
        WhileNode(function() return self:IsPlayerClose() and self:CanJump() end, "",
            ChattyNode(self.inst, {"Step back"},
                ActionNode(function ( ... )
                    self.inst.sg:GoToState("pound")
                    self.inst.CannotJump = true
                    self.inst:DoTaskInTime(10, function (inst)
                        inst.CannotJump = nil
                    end)                    
                end))),


        -- Walking away from player because 
        -- we don't want to cast it too close to player
        WhileNode(function() return self:IsPlayerClose() and self:CanCast() end, "",
            ChattyNode(self.inst, {"Step back"},
                WalkAway(self.inst, "player", CLOSE_DIST+1, CLOSE_DIST+1))),

        -- Casting spell
        --    if it is possible now
        --    and player is not too close
        WhileNode(function() return not self:IsPlayerClose() and self:CanCast() end, "",
            ChattyNode(self.inst, {"Cast"},
                ActionNode(function ( ... )
                    self.inst.sg:GoToState("cast")
                    self.inst.CannotCast = true
                    self.inst:DoTaskInTime(10, function (inst)
                        inst.CannotCast = nil
                    end)
                end))),

        -- If nothing else works, then at least we can panic 
        WildboreKingPanic(self.inst)

    },.25)
    self.bt = BT(self.inst, root)
end

function WildboreKingBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("spawnpoint", Point(self.inst.Transform:GetWorldPosition()), true)
    self.homepos = self.inst.components.knownlocations:GetLocation("spawnpoint")
end


return WildboreKingBrain