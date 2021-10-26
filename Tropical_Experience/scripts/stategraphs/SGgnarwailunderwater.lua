require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.EAT, "eat"),
}

local BOAT_ATTACK_DISTANCESQ = (TUNING.GNARWAIL.TARGET_DISTANCE + TUNING.MAX_WALKABLE_PLATFORM_RADIUS) ^ 2
local RUNNING_DIVE_DISTANCESQ = 144

local events =
{
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnFreezeEx(),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnSleepEx(),
    CommonHandlers.OnWakeEx(),

    EventHandler("onfedbyplayer", function(inst, data)
        inst.sg:GoToState("eat")
    end),
	
    EventHandler("timetohide", function(inst)
	if not inst.sg:HasStateTag("hide") then inst.sg:GoToState("hide_pre") end
    end),	

    EventHandler("doattack", function(inst, data)
    if inst.components.health ~= nil and not inst.components.health:IsDead() and
                (not inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("hit")) and
                data.target and data.target:IsValid() then			
if inst:HornIsBroken() then
inst.sg:GoToState("attack") --morde	
elseif inst:GetPosition():Dist(data.target:GetPosition()) > 5 then
inst.sg:GoToState("boat_attack", data.target)  --chifre
elseif math.random(0,10) > 5 then
inst.sg:GoToState("boat_attack", data.target)  --chifre
else
inst.sg:GoToState("attack") --morde	
end
--                inst.sg:GoToState("body_slam_pre", data.target)  --pula
		end
    end),
}

local function return_to_idle(inst)
    inst.sg:GoToState("idle")
end

local function return_to_emerge(inst)
    inst.sg:GoToState("emerge")
end

local function body_slam_attack(inst)
    local combat = inst.components.combat
    if combat.target and combat.target:IsValid() then
        combat:DoAttack()
    end
end

local function spawn_body_slam_waves(inst)
--    SpawnAttackWaves(inst:GetPosition(), nil, 1, 6, nil, 3, nil, 1, true)
--    inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/large")
end

local states =
{
    State {
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst:PlayAnimation("idle_loop", true)
            inst.sg:SetTimeout(1 + math.random() * 1)
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)			
			
        end,

        ontimeout = function(inst)
--            inst.sg:GoToState((math.random() > 0.5 and "headbang_idle") or "idle")
        end,
    },
	
    State {
        name = "hide_pre",
        tags = {"busy", "canrotate", "hide"},

        onenter = function(inst, target_position)
            inst.components.locomotor:Stop()
            if target_position ~= nil then
                inst:ForceFacePoint(target_position)
            end
            inst:PlayAnimation("submerge")
        end,

        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("hide") end),
        },

        timeline =
        {
            TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run") end),
        },
    },	
	
	
    State {
        name = "hide",
        tags = {"busy", "canrotate", "hide"},

        onenter = function(inst)
            inst.Physics:Stop()
--			inst.Physics:SetActive(false)
			inst:PlayAnimation("hide")
			inst:AddTag("FX")
			
	    if inst.buraco2 then
		if math.random	(1,10) > 6 then
		if math.random	(1,10) > 5 then
		inst.buraco2.AnimState:PlayAnimation("blink")
		inst.buraco2.AnimState:PushAnimation("eyes_loop", true)	
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)		
		else
		inst.buraco2.AnimState:PlayAnimation("eyes_pre")
		inst.buraco2.AnimState:PushAnimation("eyes_post")
		inst.buraco2.AnimState:PushAnimation("eyes_loop", true)	
		end
		else
		inst.buraco2.AnimState:PlayAnimation("eyes_loop", true)
		end
		end
            inst.sg:SetTimeout(1 + math.random() * 1)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("hide")
        end,
		onexit = function(inst)
--		inst.Physics:SetActive(true)
	    if inst.buraco2 then inst.buraco2.AnimState:PlayAnimation("fundo", true) end
		inst:RemoveTag("FX")
		end,		
		
    },	

    State {
        name = "emerge",
        tags = {"busy", "noattack"},

        onenter = function(inst)
            inst:PlayAnimation("emerge")
        end,

        events =
        {
            EventHandler("animover", return_to_idle),
        },

        timeline =
        {
 --           TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("turnoftides/common/together/water/emerge/medium") end),
            TimeEvent(6*FRAMES, function(inst)
                inst.sg:RemoveStateTag("noattack")
            end),
        },
    },
	
    State {
        name = "sugacomida",
        tags = {"idle", "canrotate"},

        onenter = function(inst, target)
            inst:PlayAnimation("sleep_pre")
			inst.AnimState:SetTime(0.30 * inst.AnimState:GetCurrentAnimationLength())
			if target then
			inst:ForceFacePoint(target.Transform:GetWorldPosition())
			end
        end,

        events =
        {
            EventHandler("animover", return_to_idle),
        },

        timeline =
        {
--            TimeEvent(3*FRAMES, function(inst) inst.SoundEmitter:PlaySound("turnoftides/common/together/water/emerge/medium") end),
            TimeEvent(12*FRAMES, function(inst)
				inst.sg:GoToState("sugacomida")
                inst.sg:RemoveStateTag("noattack")
            end),
        },
    },	  
	
	State{
		name = "attack",
		tags = {"attack", "busy"},

		onenter = function(inst, target)
			inst.sg.statemem.target = target
			inst.Physics:Stop()
			inst.components.combat:StartAttack()
			inst.AnimState:PlayAnimation("bite", false)
--			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/balphin/attack")
		end,

		onexit = function(inst)
		end,

		timeline=
		{
			TimeEvent(16*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
		},

		events=
		{
			EventHandler("animqueueover",  function(inst) inst.sg:GoToState("idle") end),
		},
	},	
	
    State {
        name = "headbang_idle",
        tags = {"idle", "busy", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:PlayAnimation("idle2_loop")
        end,

        events =
        {
            EventHandler("animover", return_to_idle),
        },

        timeline= 
        {
            TimeEvent(8*FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/water/splash/jump_small")
            end),
            TimeEvent(10*FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("hookline/creatures/gnarwail/idle", {timeoffset=math.random()})
            end),
            TimeEvent(20*FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/water/splash/jump_small")
            end),
        }
    },

    State {
        name = "headbang",
        tags = {},

        onenter = function(inst, timeout)
            inst.components.locomotor:Stop()
            inst:PlayAnimation("idle2_loop", true)

            if timeout then
                inst.sg:SetTimeout(timeout)
            end
        end,

        timeline= 
        {
            TimeEvent(8*FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/water/splash/jump_small")
            end),
            TimeEvent(10*FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("hookline/creatures/gnarwail/idle", {timeoffset=math.random()})
            end),
            TimeEvent(20*FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/water/splash/jump_small")
            end),
        },

        ontimeout = return_to_idle,
    },

    State {
        name = "death",
        tags = { "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()

            inst:PlayAnimation("dead", false)
            inst:PushAnimation("dead_loop", true)
            
            inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/death")

            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(inst:GetPosition())
        end,

        timeline=
        {
            TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("turnoftides/common/together/water/submerge/medium",nil,.5) end),
            TimeEvent(18*FRAMES, function(inst) inst.SoundEmitter:PlaySound("turnoftides/common/together/water/emerge/medium",nil,.5) end),
            TimeEvent(35*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("turnoftides/common/together/water/emerge/medium",nil,.5) 			
            local buraco = SpawnPrefab("gnarwailholefundofinal")
            buraco.Transform:SetPosition(inst.Transform:GetWorldPosition())	
			end),
        },
    },

    State {
        name = "boat_attack",
        tags = { "attack", "busy" },

        onenter = function(inst, target)
            inst.components.locomotor:Stop()
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)
            inst:PlayAnimation("submerge")
            inst.components.combat:StartAttack()

            inst.sg.statemem.target = target
            if target then
            local bx, by, bz = target.Transform:GetWorldPosition()
            inst.sg.statemem.target_position = Vector3(bx, by, bz)
            end

            inst.sg:SetTimeout(TUNING.GNARWAIL.BOAT_ATTACK_DELAY)
        end,

        ontimeout = function(inst)
            local target = inst.sg.statemem.target
            if target and target:IsValid() then
            local tx, ty, tz = inst.sg.statemem.target_position:Get()
            inst.sg:GoToState("finish_boat_attack", {inst.sg.statemem.target_position, target})
            else
            inst.components.combat:CancelAttack()
            inst.sg:GoToState("emerge")
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
--                inst.Physics:SetActive(false)
            end),
        },

        timeline =
        {
            TimeEvent(15*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run")
            end),
            TimeEvent(43*FRAMES, function(inst)
                inst.sg:AddStateTag("noattack")
            end),
        },

        onexit = function(inst)
--            inst.Physics:SetActive(true)
        end,
    },

    State {
        name = "finish_boat_attack",
        tags = { "attack", "busy" },

        onenter = function(inst, target_info)
		    inst.sg:SetTimeout(5)
		    local tx, ty, tz = target_info[2].Transform:GetWorldPosition()
			inst:DoTaskInTime(0.34, function(inst) 
            local horn_attack_prefab = SpawnPrefab("gnarwail_attack_hornunderwater")
			horn_attack_prefab.criatura = inst
            horn_attack_prefab.Transform:SetPosition(tx, ty, tz)
            local target = target_info[2]
            if target and target:IsValid() then
                if target:GetDistanceSqToPoint(tx, ty, tz) < TUNING.GNARWAIL.BOATATTACK_RADIUSSQ then
                target.components.combat:GetAttacked(horn_attack_prefab, TUNING.GNARWAIL.DAMAGE)
                end
            end
            horn_attack_prefab.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/thunk", {intensity=.8})
			end)
        end,
		
		ontimeout = function(inst)
            inst.sg:GoToState("emerge")
        end,
    },

    State {
        name = "body_slam_pre",
        tags = {"attack", "busy", "canrotate"},

        onenter = function(inst, target)
            inst.Physics:Stop()
            inst.components.locomotor:Stop()
--            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)
            inst:PlayAnimation("submerge")

            inst.sg.statemem.target = target
            if target ~= nil then
                inst.components.combat:StartAttack()
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end

            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 0.75)
        end,

        ontimeout = function(inst)
            local target = inst.sg.statemem.target
            if target and target:IsValid() then
                  local t_position = inst:GetPosition()			
--                local t_position = target:GetPosition()
--                local dive_offset = FindSwimmableOffset(
--                    t_position,
--                    target:GetAngleToPoint(inst.Transform:GetWorldPosition()),
--                    TUNING.GNARWAIL.DIVE_SPEED * 30 * FRAMES
--                )

--                if dive_offset then
--                    inst.Transform:SetPosition((t_position + dive_offset):Get())
--                end
                inst.sg:GoToState("body_slam", t_position)
            else
                inst.sg:GoToState("emerge")
            end
        end,

        timeline =
        {
            TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run") 
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)			
			
			end),
            TimeEvent(43*FRAMES, function(inst) inst.sg:AddStateTag("noattack") 
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)			
			
			end),
        },
    },

    State {
        name = "body_slam",
        tags = {"attack", "busy", "longattack", "moving", "running", "diving"},

        onenter = function(inst, target_position)
					inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)
            inst:ForceFacePoint(target_position)

            inst.Physics:Stop()
            inst.components.locomotor:Stop()
--            inst.components.locomotor:EnableGroundSpeedMultiplier(false)

            inst:PlayAnimation("attack_2")
--            inst.Physics:SetMotorVelOverride(TUNING.GNARWAIL.DIVE_SPEED, 0, 0)
--            inst.components.locomotor.walkspeed = TUNING.GNARWAIL.DIVE_SPEED

--            inst.sg.statemem.old_run_speed = inst.components.locomotor.runspeed
--            inst.components.locomotor.runspeed = TUNING.GNARWAIL.DIVE_SPEED

            inst:RemoveTag("scarytocookiecutters")
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst) 
			inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/taunt") 
					inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)			
end),
            TimeEvent(33*FRAMES, body_slam_attack),
            TimeEvent(36*FRAMES, function(inst)
			
					inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)			
                spawn_body_slam_waves(inst)
                inst.Physics:ClearMotorVelOverride()
            end),
        },

        events =
        {
            EventHandler("animover", return_to_emerge),
        },

        onexit = function(inst)
            inst.Physics:ClearMotorVelOverride()
--            inst.components.locomotor.walkspeed = TUNING.GNARWAIL.WALK_SPEED
--            inst.components.locomotor.runspeed = inst.sg.statemem.old_run_speed
            inst:AddTag("scarytocookiecutters")
        end,
    },
	
	
    State {
        name = "body_slam_hide",
        tags = {"attack", "busy", "longattack", "moving", "running", "diving"},

        onenter = function(inst, target)
		    inst.components.combat:SetDefaultDamage(100)
			inst.components.combat:SetTarget(target)
            inst:ForceFacePoint(target.Transform:GetWorldPosition())
            inst.Physics:Stop()
            inst.components.locomotor:Stop()
            inst:PlayAnimation("attack_2")
            inst:RemoveTag("scarytocookiecutters")
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/taunt") end),
            TimeEvent(12*FRAMES, body_slam_attack),
            TimeEvent(36*FRAMES, function(inst)
                spawn_body_slam_waves(inst)
                inst.Physics:ClearMotorVelOverride()
            end),
        },

        events =
        {
            EventHandler("animover", return_to_emerge),
        },

        onexit = function(inst)
            inst.Physics:ClearMotorVelOverride()
			inst.components.combat:SetDefaultDamage(TUNING.GNARWAIL.DAMAGE)
--            inst.components.locomotor.walkspeed = TUNING.GNARWAIL.WALK_SPEED
--            inst.components.locomotor.runspeed = inst.sg.statemem.old_run_speed
            inst:AddTag("scarytocookiecutters")
        end,
    },	

    State {
        name = "eat",
        tags = { "busy", "eating" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            
            inst:PlayAnimation("bite")
        end,

        timeline =
        {
            TimeEvent(17*FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/chew")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("chewing", GetRandomMinMax(2, 4))
            end),
        },

        onexit = function(inst)
            inst:PerformBufferedAction()
        end,
    },

    State {
        name = "chewing",
        tags = {"busy", "eating"},

        onenter = function(inst, iterations)
            inst:PlayAnimation("chew")

            inst.sg.statemem.its_remaining = (iterations and iterations - 1) or 0
        end,

        timeline =
        {
            TimeEvent(16*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/chew")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.sg.statemem.its_remaining > 0 then
                    inst.sg:GoToState("chewing", inst.sg.statemem.its_remaining)
                else
				
				local leader = inst.components.follower.leader
				if leader and leader:IsValid() and leader:HasTag("player") then
				inst.components.follower:SetLeader(nil)
				inst.sg:GoToState("toss_pre")
				else
                inst.sg:GoToState("idle")
				end
                end
            end),
        },
    },

    State {
        name = "refuse",
        tags = {"busy"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:PlayAnimation("sleep_pst")
        end,

        timeline =
        {
            TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/refuse") end),
        },

        events =
        {
            EventHandler("animover", return_to_idle),
        },
    },

    State {
        name = "toss_pre",
        tags = {"busy"},

        onenter = function(inst, target_data)
            inst.sg.statemem.target_data = target_data
--			local invader = GetClosestInstWithTag("player", inst, 4)
--			if invader and inst.sg.statemem.target_data == nil then
--			inst.sg.statemem.target_data = invader
--			end

            if target_data then
                local target = target_data.target
                if target and target:IsValid() then
                    inst:ForceFacePoint(target.Transform:GetWorldPosition())
                end
            end

            inst.components.locomotor:Stop()

            inst:PlayAnimation("submerge")

            -- submerge anim length + some extra time
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + 1.3)
        end,

        events =
        {
            EventHandler("animover", function(inst)
--                inst.Physics:SetActive(false)
            end),
        },

        timeline =
        {
            TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run") end),
            TimeEvent(43*FRAMES, function(inst)
                inst.sg:AddStateTag("noattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("toss", inst.sg.statemem.target_data)
        end,

        onexit = function(inst)
--            inst.Physics:SetActive(true)
        end,
    },

    State {
        name = "toss",
        tags = {"busy", "noattack"},

        onenter = function(inst, target)
			inst.sg.statemem.target = target
            inst.components.locomotor:Stop()
            inst:PlayAnimation("toss" or "emerge")
        end,

        timeline =
        {
            TimeEvent(3*FRAMES, function(inst)
                -- The emerge anim has a sound at this frame.
--                if not inst.sg.statemem.do_toss then
--                    inst.SoundEmitter:PlaySound("turnoftides/common/together/water/emerge/medium")
--                end
            end),
            TimeEvent(6*FRAMES, function(inst)
                inst.sg:RemoveStateTag("noattack")
                if inst.sg.statemem.do_toss then
                    inst.SoundEmitter:PlaySound("turnoftides/common/together/water/emerge/medium")
                end
            end),
            TimeEvent(19*FRAMES, function(inst)
                    local target = inst.sg.statemem.target
					
local cuspida =
{
[1] = "seaweed",
[2] = "twigs",
[3] = "cutgrass",
[4] = "driftwood_log",
[5] = "seaweed",
[6] = "coral",
[7] = "seeds",
[8] = "rocks",
[9] = "kelp",
}		
					local item = SpawnPrefab(cuspida[math.random(1, 9)])
					if target and target:IsValid() and item then
                    LaunchAt(item, inst, target, 5, 2, nil, 0)
					else
					if item then
					Launch2(item, inst, 2, 1, 2, 1)
					end
                    end
            end),
            TimeEvent(20*FRAMES, function(inst)
--                if inst.sg.statemem.do_toss then
                    inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/toss")
--                end
            end),
        },

        events =
        {
            EventHandler("animover", return_to_idle),
        },
    },

    -- WALK
    State{
        name = "walk_start",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst:PlayAnimation("idle_loop")
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/jump_small",nil,.25)
                inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/hop")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("walk")
                end
            end),
        },
    },

    State{
        name = "walk",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst:PlayAnimation("idle_loop")
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline =
        {
            TimeEvent(6*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/jump_small",nil,.25)
                inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/hop")
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("walk")
        end,
    },

    State{
        name = "walk_stop",
        tags = { "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()

            local run_anim_time_remaining = inst.AnimState:GetCurrentAnimationTime() % inst.AnimState:GetCurrentAnimationLength()
            inst.sg:SetTimeout(run_anim_time_remaining + 1*FRAMES)

            inst:PushAnimation("idle_loop", false)
        end,

        ontimeout = function(inst)
            inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/jump_small",nil,.25)
            inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/hop")
        end,

        events =
        {
            EventHandler("animqueueover", return_to_idle),
        },
    },

    -- ROLLING RUN
    State {
        name = "run_start",
        tags = {"moving", "running", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst:PlayAnimation("submerge")
        end,

        timeline =
        {
            TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("run")
                end
            end),
        },
    },

    State {
        name = "run",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
            -- Not sure why this timeout version is used, but this is what the commonstate does.
            inst:PlayAnimation("run", true)
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run") end),
            TimeEvent(76*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run") end),
        },

        ontimeout = function(inst)
            local destination = inst.components.locomotor.dest
            if destination and inst:GetDistanceSqToPoint(destination:GetPoint()) > RUNNING_DIVE_DISTANCESQ then
                inst.sg:GoToState("body_slam", Vector3(destination:GetPoint()))
            else
                inst.sg:GoToState("run")
            end
        end,
    },

    State {
        name = "run_stop",
        tags = {"idle"},

        onenter = function(inst)
            inst.components.locomotor:StopMoving()

            -- We want to play the emerge sound 3 frames into the emerge animation, but we're softstopping, so we could be any number of frames
            -- into the run animation when we get here. So we calculate that and play the sound as a timeout trigger instead.
            local run_anim_time_remaining = inst.AnimState:GetCurrentAnimationTime() % inst.AnimState:GetCurrentAnimationLength()
            inst.sg:SetTimeout(run_anim_time_remaining + 3*FRAMES)

            inst:PushAnimation("emerge", false)
        end,

        ontimeout = function(inst)
            inst.SoundEmitter:PlaySound("turnoftides/common/together/water/emerge/medium")
        end,

        events =
        {
            EventHandler("animqueueover", return_to_idle),
        },
    },

    -- TAUNT
    State {
        name = "fin_taunt",
        tags = {"busy", "canrotate"},

        onenter = function(inst, target_position)
            inst.components.locomotor:Stop()

            if target_position ~= nil then
                inst:ForceFacePoint(target_position)
            end

            inst:PlayAnimation("submerge")
            inst:PushAnimation("taunt_2", false)
        end,

        events =
        {
            EventHandler("animqueueover", return_to_emerge),
        },

        timeline =
        {
            TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/run") end),
        },
    },

    -- HIT
    State{
        name = "hit",
        tags = { "hit", "busy" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()

            inst:PlayAnimation("hit")
        end,

        events =
        {
            EventHandler("animover", return_to_idle),
        },
    },
}

local function frozen_onoverridesymbols(inst)
    if inst._water_shadow then
        if inst.sg:HasStateTag("frozen") then
            inst._water_shadow.AnimState:PlayAnimation("frozen", true)
        else
            inst._water_shadow.AnimState:PlayAnimation("frozen_loop_pst", true)
        end
    end
end

CommonStates.AddFrozenStates(states, frozen_onoverridesymbols)
CommonStates.AddSleepExStates(states,
{ 
    starttimeline =
    {
        TimeEvent(0, function(inst)
            if inst._water_shadow ~= nil then
                inst._water_shadow.AnimState:PlayAnimation("sleep_pre")
            end
        end),
        TimeEvent(6*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/yawn")
        end),
    },
    sleeptimeline = 
    {
        TimeEvent(0, function(inst)
            if inst._water_shadow ~= nil then
                inst._water_shadow.AnimState:PlayAnimation("sleep_loop")
            end
        end),
        TimeEvent(6*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/sleep_out")
        end),
        TimeEvent(18*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/sleep_in")
        end),
    },
    waketimeline = 
    {
        TimeEvent(0, function(inst)
            if inst._water_shadow ~= nil then
                inst._water_shadow.AnimState:PlayAnimation("sleep_pst")
            end
        end),
        TimeEvent(4*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("hookline/creatures/gnarwail/hop")
        end),
    },
})

return StateGraph("gnarwailunderwater", states, events, "idle", actionhandlers)
