require("stategraphs/commonstates")

local actionhandlers =
{

}

local events =
{
    EventHandler("attacked", function(inst) 
        if not inst.components.health:IsDead() 
            and not inst.sg:HasStateTag("hit") 
            and not inst.sg:HasStateTag("attack") 
            and not inst.sg:HasStateTag("casting") 
        then 
            inst.sg:GoToState("hit") 
        end 
    end),
    EventHandler("death", function(inst) inst.sg:GoToState("death", inst.sg.statemem.dead) end),
    EventHandler("doattack", function(inst, data) if not inst.components.health:IsDead() and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then 
if inst.components.health and inst.components.health.currenthealth > inst.components.health.maxhealth * 0.85 then	
inst.sg:GoToState("attack", data.target)
elseif inst.components.health and inst.components.health.currenthealth > inst.components.health.maxhealth * 0.70 then
local variador = math.random (1,8)
if variador < 8 then inst.sg:GoToState("attack", data.target) end
if variador == 8 then inst.sg:GoToState("cast", data.target) end	
elseif inst.components.health and inst.components.health.currenthealth > inst.components.health.maxhealth * 0.5 then
local variador = math.random (1,9)
if variador < 8 then inst.sg:GoToState("attack", data.target) end
if variador == 8 then inst.sg:GoToState("cast", data.target) end
if variador == 9 then inst.sg:GoToState("groundslam", data.target) end
elseif inst.components.health and inst.components.health.currenthealth > inst.components.health.maxhealth * 0.3 then
local variador = math.random (1,10)
if variador < 8 then inst.sg:GoToState("attack", data.target) end
if variador == 8 then inst.sg:GoToState("groundslam", data.target) end
if variador == 9 then inst.sg:GoToState("whirlwind", data.target) end
if variador == 10 then inst.sg:GoToState("combofirsthit", data.target) end
else
local variador = math.random (1,11)
if variador < 8 then inst.sg:GoToState("attack", data.target) end
if variador == 8 then inst.sg:GoToState("groundslam", data.target) end
if variador == 9 then inst.sg:GoToState("whirlwind", data.target) end
if variador == 10 then inst.sg:GoToState("combofirsthit", data.target) end
if variador == 11 then inst.sg:GoToState("dash", data.target) end
end


end end),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnLocomote(false, true),
    --CommonHandlers.OnFreeze(),
	--CommonHandlers.OnAttacked(),
}
--------------------------------------------------
local damage = 75
local knockStr = 4
local wlindrange = 5

local function DoWirlwlind(inst)
if not inst:IsValid() or inst.components.health:IsDead() then return end

local x1, y1, z1 = inst.Transform:GetWorldPosition()
for k, ent in pairs(TheSim:FindEntities(x1, y1, z1, wlindrange, nil, {"boar", "NOCLICK", "FX", "INLIMBO", "shadow"})) do
if ent ~= inst and ent:IsValid() 
and ent.entity:IsVisible() 
then
local x2, y2, z2 = ent.Transform:GetWorldPosition()
if ent.components.inventoryitem ~= nil then
local str = ent:HasTag("heavy") and 2.5 or 5
ent.Physics:Teleport(x2, 0.5, z2)
local vec = Vector3(x2 - x1, y2 - y1, z2 - z1):Normalize()
ent.Physics:SetVel(vec.x * str, str, vec.z * str)
end
if ent.components.combat ~= nil then
ent.components.combat:GetAttacked(inst, damage, nil)
if ent:HasTag("player") then
ent:PushEvent("knockback", { knocker = inst, radius = knockStr })
end 
end
end
end
end
------------------------------------------------
function IsEntityInside(polygon, ent)
	local pt = {}
	pt.x, pt.o, pt.y = ent.Transform:GetWorldPosition()
	local radius = ent:GetPhysicsRadius(0) or 0.5
	local intersections = 0
	local prev = #polygon
	local prevUnder = polygon[prev].y < pt.y
	for i = 1, #polygon do
		local currUnder = polygon[i].y < pt.y
		local p1, p2 = {}, {}
		p1.x = polygon[prev].x - pt.x
		p1.y = polygon[prev].y - pt.y
        p2.x = polygon[i].x - pt.x
		p2.y = polygon[i].y - pt.y
		local dx = (p2.x - p1.x)
		local dy = (p2.y - p1.y)
		local t = (p1.x * dy - p1.y * dx)
		
		local a = dx * dx + dy * dy;
        local b = 2 * ( p1.x * dx + p1.y * dy);
        local c = p1.x * p1.x + p1.y * p1.y - radius * radius;

        if -b < 0 and c < 0 then return true end
        if -b < 2 * a and 4 * a * c - b * b < 0  then return true end
        if (a + b + c < 0) then return true end
		
		if currUnder and not prevUnder then
            if (t > 0) then
                intersections = intersections + 1
			end
		end
        
        if not currUnder and prevUnder then
            if (t < 0) then
                intersections = intersections + 1
			end
		end
		
		prev = i
        prevUnder = currUnder
	end
	return not IsNumberEven(intersections)
end


local function GroundSlamTargets(inst, polygon)
    if not inst:IsValid() or inst.components.health:IsDead() then return end

	local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 16, nil, { "NOCLICK", "FX", "shadow", "playerghost", "INLIMBO" })
    local damage = 30
	for _, ent in pairs(ents) do
		if ent ~= inst and ent:IsValid() and ent.entity:IsVisible()  then
			local entPoint = {}
			entPoint[1], _, entPoint[2] = ent.Transform:GetWorldPosition()
			if IsEntityInside(polygon, ent) then
				if ent.components.workable 
					and ent.components.workable:CanBeWorked() 
					and not (ent.sg ~= nil and ent.sg:HasStateTag("busy")) 
				then
                    if ent.components.workable:GetWorkAction() == ACTIONS.DIG then
						ent.components.workable:WorkedBy(inst, 1)
                    end
				elseif ent.components.combat ~= nil then
					ent.components.combat:GetAttacked(inst, damage, nil)
				end
			end
		end
	end
end

local function IsValidTile(x, y, z)
    local tile = TheWorld.Map:GetTileAtPoint(x, y, z)
	return tile ~= GROUND.IMPASSABLE and tile ~= GROUND.INVALID
end

local function GroundSlamattack(inst)
    if inst == nil then return false end

    local points = {}
	local polygon = {}
    local x, y, z = inst.Transform:GetWorldPosition() 
    local angle = inst.Transform:GetRotation()
	local angle1 = (angle - 60) * DEGREES
	local angle2 = (angle + 60) * DEGREES
    angle = angle * DEGREES
    local x1 = x + math.cos(angle1) * 2 
	local z1 = z - math.sin(angle1) * 2 
	local x2 = x + math.cos(angle2) * 2 
	local z2 = z - math.sin(angle2) * 2 
	local maxDistance = 15
    local minDistance = 1

    local cos = math.cos(angle)
    local sin = math.sin(angle)

    for i = minDistance, maxDistance, 2 do
		local pt1 = {x + cos * i, y, z - sin * i}
		local pt2 = {x1 + cos * i, y, z1 - sin * i}
        local pt3 = {x2 + cos * i, y, z2 - sin * i}

		if IsValidTile(pt1[1], pt1[2], pt1[3]) then
			table.insert(points, pt1)
        end
        
		if IsValidTile(pt2[1], pt2[2], pt2[3]) then
			table.insert(points, pt2)
        end
        
		if IsValidTile(pt3[1], pt3[2], pt3[3]) then
			table.insert(points, pt3)
        end
        
		if i == minDistance then
			table.insert(polygon, { x = pt3[1], y = pt3[3] })
			table.insert(polygon, { x = pt2[1], y = pt2[3] })
		end
		if i == maxDistance then
			table.insert(polygon, { x = pt2[1], y = pt2[3] })
			table.insert(polygon, { x = pt3[1], y = pt3[3] })
		end
    end
    
    GroundSlamTargets(inst, polygon)

    local scale = 0.4
    for i, pt in pairs(points) do
		local obj = SpawnPrefab("groundpound_fx")
		if i == 2 or i == 8 or i == 20 then
			obj.entity:AddSoundEmitter()
			obj.SoundEmitter:PlaySound("dontstarve/common/lava_arena/boarrior/attack_5")
		end
		obj.Transform:SetPosition(pt[1], pt[2], pt[3])
		obj.Transform:SetScale(scale, scale, scale)
    end
    
        GroundSlamTargets(inst, polygon)
		for i, pt in pairs(points) do
			local obj = SpawnPrefab("groundfire")
			if i == 2 or i == 8 or i == 20 then
				obj.entity:AddSoundEmitter()
				obj.SoundEmitter:PlaySound("dontstarve/common/fireBurstSmall")
			end
			obj.Transform:SetPosition(pt[1], pt[2], pt[3])	
		end

    return true
end

------------------------------------------------------------------
local function burstattack(inst)
    if inst == nil then return false end
    local x, y, z = inst.Transform:GetWorldPosition()
    for k, v in pairs(FindPlayersInRangeSq(x, y, z, 400, true)) do
	local obj = SpawnPrefab("bossboarfireburst")
        obj.Transform:SetPosition(v.Transform:GetWorldPosition()) 
        obj:StartBurst(inst, 0.7)
    end
end


local states =
{

    State{
        name = "idle",
        tags = { "idle", "canrotate" },
        onenter = function(inst, playanim)
            --inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/pant")
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle_loop", true)
            else
                inst.AnimState:PlayAnimation("idle_loop", true)
            end
            inst.sg:SetTimeout(2 * math.random() + .5)
        end,
		
		events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "attack",
        tags = { "attack", "busy" },

        onenter = function(inst, target)
            inst.sg.statemem.target = target
            inst.Physics:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/grunt")
            inst.components.combat:StartAttack()
			if (math.random(1, 2) == 1) then
                inst.sg.statemem.attackAnim = 1
				inst.AnimState:PlayAnimation("attack1")
				inst.AnimState:PushAnimation("attack1_pst", false)
			else
                inst.sg.statemem.attackAnim = 2
				inst.AnimState:PlayAnimation("attack3")
			end
            --inst.AnimState:PushAnimation("attack", false)
        end,

        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)  
                if inst.sg.statemem.attackAnim == 1 then
                    inst.components.combat:DoAttack(inst.sg.statemem.target) 
                    inst.sg:RemoveStateTag("attack")
                    inst.sg:RemoveStateTag("busy")
                end
            end),
            TimeEvent(3 * FRAMES, function(inst) 
				if inst.sg.statemem.attackAnim == 2 then
                    inst.components.combat:DoAttack(inst.sg.statemem.target) 
                    inst.sg:RemoveStateTag("attack")
                    inst.sg:RemoveStateTag("busy")
                end
			end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) 
				inst.sg:GoToState("idle")
			end),
        },
    },
	
    State{
        name = "hit",
        tags = { "busy", "hit" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/hit")
            inst.AnimState:PlayAnimation("hit")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "taunt",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/taunt") end),
        },

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "death",
        tags = { "busy" },

        onenter = function(inst)

            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("death")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death") 
            RemovePhysicsColliders(inst)

            inst.components.lootdropper:DropLoot(inst:GetPosition())
        end,

        timeline =
        {
            TimeEvent(FRAMES * 7, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bone_drop_stick")
            end),
            TimeEvent(FRAMES * 8, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bone_drop_stick")
            end),
            TimeEvent(FRAMES * 16, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/death_bodyfall")
            end),
        },
    },

    State{
        name = "forcesleep",
        tags = { "busy", "sleeping" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("sleep_loop", true)
        end,
    },
	
	State{
        name = "cast",
        tags = { "busy", "casting" },
        onenter = function(inst)
			inst.components.locomotor:Stop()
                inst.AnimState:PlayAnimation("banner_pre", false)
                inst.AnimState:PushAnimation("banner_loop", false)
                inst.sg.statemem.loops = 0
--                inst.sg.statemem.gbdone = false
        end,

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:IsCurrentAnimation("banner_loop") and inst.sg.statemem.loops <= 3 then
                    print("need to play sound")
--                    if not inst.sg.statemem.gbdone then
                        inst:PerformBufferedAction()
						burstattack(inst)
--                        inst.sg.statemem.gbdone = true
--                    end
                    inst.AnimState:PlayAnimation("banner_loop", false)
                    inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bone_drop_stick")
                    inst.sg.statemem.loops = inst.sg.statemem.loops + 1
                else
                    inst.AnimState:PlayAnimation("banner_pst")
			        inst.sg:GoToState("idle")
                end
            end)
        },
    },
	
	State{
        name = "whirlwind",
        tags = { "busy", "casting" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("attack4") 
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/spin")
        end,
		
		timeline =
        {
            TimeEvent(13 * FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_lostrod") 
                inst:PerformBufferedAction()
				DoWirlwlind(inst)
            end),
            TimeEvent(24 * FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_lostrod") 
            end),
        },

		events =
        {
            EventHandler("animover", function(inst)
                inst:ReTarget(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },
	
	State{
        name = "groundslam",
        tags = { "casting", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
--                    inst:ForceFacePoint(act.pos.x, 0, act.pos.z)
                inst.AnimState:PlayAnimation("attack5", false) 

        end,

        timeline =
        {
			TimeEvent(10 * FRAMES, function(inst) 
				inst:PerformBufferedAction()
				GroundSlamattack(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/bonehit2")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) 
				if math.random() < 0.8 then 
					inst.sg:GoToState("taunt") 
				else 
					inst.sg:GoToState("idle")
				end
			end),
        },
    },

    State{
        name = "dash",
        tags = { "busy", "attack" },
        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

			inst.AnimState:PlayAnimation("dash") 
            inst.sg.statemem.dashspeed = 1
            inst.Physics:SetMotorVel(inst.sg.statemem.dashspeed, 0, 0)
			inst.sg.statemem.target = target
        end,

        onupdate = function(inst)
            inst.Physics:SetMotorVel(inst.sg.statemem.dashspeed, 0, 0)
        end,
		
		timeline =
        {
            TimeEvent(3 * FRAMES, function(inst) 
                inst.sg.statemem.dashspeed = 12
            end),
            TimeEvent(3 * FRAMES, function(inst) 
                inst.sg.statemem.dashspeed = 20
            end),
            TimeEvent(3 * FRAMES, function(inst) 
                inst.sg.statemem.dashspeed = 12
            end),
            TimeEvent(9 * FRAMES, function(inst)
                inst.sg.statemem.dashspeed = 0 
            end),
        },

		events =
        {
            EventHandler("animover", function(inst)
                inst.Physics:ClearMotorVelOverride()
                inst.sg:GoToState("combothirdhit", inst.sg.statemem.target)
            end),
        },

        onexit = function(inst)
            inst.components.locomotor:Stop()
            inst.Physics:ClearMotorVelOverride()
        end,
    },
	
	State{
        name = "combofirsthit",
        tags = { "busy", "attack" },
        onenter = function(inst, target)
            inst.components.locomotor:Stop()
--                inst:ForceFacePoint(act.target.Transform:GetWorldPosition())
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun")
                inst.AnimState:PlayAnimation("attack1") 
                inst.sg.statemem.target = target
        end,
		
		timeline =
        {
            TimeEvent(12 * FRAMES, function(inst) --20 frames total
                inst.components.combat:DoAttack(inst.sg.statemem.target) 
            end), 
        },

		events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("combosecondhit", inst.sg.statemem.target)
            end),
        },
    },
	
	State{
        name = "combosecondhit",
        tags = { "busy", "attack" },
        onenter = function(inst, target)
            if target and target:IsValid() 
                and not target.components.health:IsDead() 
            then
                inst.sg.statemem.target = target
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("attack2") 
            else
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle")
            end
        end,
		
		timeline =
        {
            TimeEvent(3 * FRAMES, function(inst) -- 9 frames total
                inst.components.combat:DoAttack(inst.sg.statemem.target) 
            end), 
        },

		events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("combothirdhit", inst.sg.statemem.target)
                --inst.sg:GoToState("dash")
            end),
        },
    },
	
	State{
        name = "combothirdhit",
        tags = { "busy", "attack" },
        onenter = function(inst, target)
            if target and target:IsValid()
                and not target.components.health:IsDead() 
            then
                inst.Physics:Stop()
                inst.sg.statemem.target = target
                inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/stun")
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
                inst.AnimState:PlayAnimation("attack3") 
            else
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle")
            end
        end,
		
		timeline =
        {
            TimeEvent(7 * FRAMES, function(inst) --25 frames total
                inst:PerformBufferedAction()
                inst:ReTarget(inst)
				inst.components.combat:DoAttack(inst.sg.statemem.target)
				
				if inst.components.combat:CanHitTarget(inst.sg.statemem.target) then			
				inst.sg.statemem.target:PushEvent("knockback", { knocker = inst, radius = 4 })
				end
 --               inst.components.combat.laststartattacktime = GetTime()
            end), 
        },

		events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

}

CommonStates.AddSleepStates(states,
{
    sleeptimeline = {
        TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/sleep_out") end),
    },
})

CommonStates.AddWalkStates(states,
{
    walktimeline =
    {
        TimeEvent(1 * FRAMES, function(inst) 
            ShakeAllCameras(CAMERASHAKE.VERTICAL, .5, .03, 0.5, inst, 15)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step") 
        end),
        TimeEvent(18 * FRAMES, function(inst) 
            ShakeAllCameras(CAMERASHAKE.VERTICAL, .5, .03, 0.5, inst, 15)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/lava_arena/boarrior/step") 
        end),
    },
})

CommonStates.AddFrozenStates(states)

return StateGraph("bossboarte", states, events, "taunt", actionhandlers)
