--      More behaviours in the game's data/scripts/behaviours folder.
require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/follow"


local AVOID_PLAYER_DIST = 3
local AVOID_PLAYER_STOP = 6
local START_FACE_DIST = 7
local KEEP_FACE_DIST = 10

local MAX_WANDER_DIST = 20
local MAX_CHASE_TIME = 8


local function GetFaceTargetFn(inst)
    local target = GetClosestInstWithTag("player", inst, START_FACE_DIST)
    if target and not target:HasTag("notarget") then
        return target
    end
end
local function KeepFaceTargetFn(inst, target)
    return inst:GetDistanceSqToInst(target) <= KEEP_FACE_DIST*KEEP_FACE_DIST and not target:HasTag("notarget")
end

local function HasValidHome(inst)
    return inst.components.homeseeker and 
       inst.components.homeseeker.home and 
       not inst.components.homeseeker.home:HasTag("fire") and
       not inst.components.homeseeker.home:HasTag("burnt") and
       inst.components.homeseeker.home:IsValid()
end
local function GoHomeAction(inst)
    if not inst.components.follower.leader and
        HasValidHome(inst) and
        not inst.components.combat.target then
            return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end
local function GetHomePos(inst)
    return HasValidHome(inst) and inst.components.homeseeker:GetHomePos()
end
local function GetNoLeaderHomePos(inst)
    return GetHomePos(inst)
end

local octobrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function octobrain:OnStart()
	--at night time return home
    local night = WhileNode( function() return clock and not clock:IsDay() end, "IsNight",
        PriorityNode{
				--at night time go home (if it has one)
                DoAction(self.inst, GoHomeAction, "go home", true ),
		},	1)

    local root = PriorityNode(
		{
			ChaseAndAttack(self.inst, MAX_CHASE_TIME),
			RunAway(self.inst, "scarytoprey", AVOID_PLAYER_DIST, AVOID_PLAYER_STOP),
			FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn),
			Wander(self.inst, GetNoLeaderHomePos, MAX_WANDER_DIST),
		}, .25)
    
	
    self.bt = BT(self.inst, root)
end
return octobrain









