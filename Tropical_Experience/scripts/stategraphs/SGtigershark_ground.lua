local FLIGHT_CD_MIN = 8
local FLIGHT_CD_MAX = 12
local JUMP_SPEED = 75
local JUMP_LAND_OFFSET = 3

local actionhandlers =
{
	ActionHandler(ACTIONS.EAT, "eat"),
	ActionHandler(ACTIONS.TIGERSHARK_FEED, "feed"),
}

local function DestroyStuff(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 3, nil, { "INLIMBO", "NET_workable" })
    for i, v in ipairs(ents) do
        if v:IsValid() and
        v.components.workable ~= nil and
        v.components.workable:CanBeWorked() and
        v.components.workable.action ~= ACTIONS.NET then
            SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
            v.components.workable:Destroy(inst)
        end
    end
end

-- ele pode atacar corpo a corpo ou pulando. Ele ataca pulando se o delay(Flight_CD) tiver passado 

local function onattackfn(inst)
    if inst.components.health ~= nil and not inst.components.health:IsDead() and
    (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then

        if not (inst.CanFly or inst.components.timer:TimerExists("GroundPound")) then
            inst.components.timer:StartTimer("GroundPound", math.random(FLIGHT_CD_MIN, FLIGHT_CD_MAX))
        end

        if inst.CanFly then
            inst.sg:GoToState("jump")
        else

local variador = math.random (1,3)
--inst.sg:GoToState("warrior_attack")
if variador == 1 then inst.sg:GoToState("attack") end
if variador == 2 and inst.podeTaunt then inst.sg:GoToState("taunt") end
if variador == 3 and inst.podeFeed then inst.sg:GoToState("feed") end
       end
    end
end

local events =
{
    CommonHandlers.OnSleep(),
	CommonHandlers.OnDeath(),
	CommonHandlers.OnLocomote(true, true),
	CommonHandlers.OnFreeze(),
	CommonHandlers.OnAttack(),
	CommonHandlers.OnAttacked(),
	EventHandler("doattack", onattackfn),
}


local states =
{
    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/idle")

            local pos = inst:GetPosition()
            if pos.y > 10 then
                pos.y = 0
                inst.Transform:SetPosition(pos:Get())
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end)
        },
    },

    State{
        name = "eat",
        tags = {"busy", "canrotate"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat_pre")
            inst.AnimState:PushAnimation("eat_loop")
            inst.AnimState:PushAnimation("eat_pst", false)
        end,

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/eat")
				inst.components.health:StartRegen(70, 1)
                inst:PerformBufferedAction()
            end)
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("idle")
				inst.components.health:StopRegen()
            end)
        },
    },

    State{
        name = "feed",
        tags = {"busy", "canrotate"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("hork")
			inst.podeFeed = false
        end,

        timeline =
        {
            TimeEvent(13*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/meat_hork")
            end),
            TimeEvent(19*FRAMES, function(inst)
                inst:PerformBufferedAction()
            end)
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end)
        },
    },

    -- jump > fallwarn > fall > fallpost
	
    State{
        name = "jump",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("ground_launch_up_pre")
            inst.AnimState:PushAnimation("ground_launch_up_loop", true)
        end,

        timeline =
        {
            TimeEvent(21*FRAMES, function(inst)
                inst.sg:GoToState("jump2")
            end),
        },
    },

	
    State{
        name = "jump2",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/jump_attack")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/roar")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/launch_land")
            inst.Physics:Stop()
            inst.Physics:SetMotorVelOverride(0,JUMP_SPEED,0)
        end,

        onupdate = function(inst)
            inst.Physics:SetMotorVelOverride(0,JUMP_SPEED,0)
            local pt = Point(inst.Transform:GetWorldPosition())
            if pt.y > 35 then
                    inst.sg:GoToState("fallwarn")
            end
        end,
    },	
	
	
    State{
        name = "fallwarn",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.sg:SetTimeout(34*FRAMES)

            inst.Physics:Stop()
			
			local alvo = inst.components.combat.target
			if alvo then
			local x, y, z = alvo.Transform:GetWorldPosition()
            inst.Transform:SetPosition(x, 45, z)
			end

            local shadow = SpawnPrefab("tigersharkshadow")
            shadow:Ground_Fall()
            local heading = TheCamera:GetHeading()
            local rotation = 180 - heading

            if inst.AnimState:GetCurrentFacing() == FACING_LEFT then
                rotation = rotation + 180
            end

            if rotation < 0 then
                rotation = rotation + 360
            end

            shadow.Transform:SetRotation(rotation)
            local x,y,z = inst:GetPosition():Get()
            shadow.Transform:SetPosition(x,0,z)
        end,

        ontimeout = function(inst)
            inst:Show()

 local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground == GROUND.OCEAN_SWELL or
ground == GROUND.OCEAN_COASTAL or
ground == GROUND.OCEAN_COASTAL_SHORE or
ground == GROUND.OCEAN_ROUGH or
ground == GROUND.OCEAN_BRINEPOOL or
ground == GROUND.OCEAN_BRINEPOOL_SHORE or
ground == GROUND.OCEAN_WATERLOG or
ground == GROUND.OCEAN_HAZARDOUS then
			
			
    inst:ClearStateGraph()
    inst:SetStateGraph("SGtigershark_water")
    inst.AnimState:SetBuild("tigershark_water_build")
    inst.AnimState:AddOverrideBuild("tigershark_water_ripples_build")
	inst.Physics:ClearCollidesWith(COLLISION.LIMITS)
    inst:AddTag("aquatic")
    inst.DynamicShadow:Enable(false)
			
                local pos = inst:GetPosition()
                pos.y = 45
                inst.Transform:SetPosition(pos:Get())
            end

            inst.sg:GoToState("fall")
        end,
    },

    State{
        name = "fall",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            ChangeToCharacterPhysics(inst)
	        inst.components.locomotor.disable = true
            inst.Physics:SetMotorVel(0,-JUMP_SPEED,0)
            inst.AnimState:PlayAnimation("ground_launch_down_loop", true)
            inst.Physics:SetCollides(false)
            inst.sg:SetTimeout(JUMP_SPEED/45 + 0.2)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/dive_attack")
        end,

        timeline =
        {
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/roar") end)
        },

        ontimeout = function(inst)
            local pt = Point(inst.Transform:GetWorldPosition())
            local vx, vy, vz = inst.Physics:GetMotorVel()
            if pt.y <= .1 then
                pt.y = 0
                inst.Physics:Stop()
                inst.Physics:Teleport(pt.x,pt.y,pt.z)
                inst.CanFly = false
                inst.Physics:SetCollides(true)
                inst.sg:GoToState("fallpost")
            end
        end,

        onupdate = function(inst)
            inst.Physics:SetMotorVel(0,-JUMP_SPEED,0)
            local pt = Point(inst.Transform:GetWorldPosition())
            if pt.y <= .1 then
                pt.y = 0
                inst.Physics:Stop()
                inst.Physics:Teleport(pt.x,pt.y,pt.z)
                inst.CanFly = false
                inst.Physics:SetCollides(true)
                inst.sg:GoToState("fallpost")
            end
        end,
    },

    State{
        name = "fallpost",
        tags = {"busy", "specialattack"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.components.locomotor.disable = false
            inst.AnimState:PlayAnimation("ground_launch_down_pst")
            inst.components.groundpounder:GroundPound()
--            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/land_explode")
        end,

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
            inst:Show()
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },


    State{
        name = "attack",
        tags = {"busy", "attack"},

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("atk")
			DestroyStuff(inst)
            inst.CanRun = false
            inst.components.rowboatwakespawner:StopSpawning()
            if not inst.components.timer:TimerExists("Run") then
                inst.components.timer:StartTimer("Run", 10)
            end
        end,

        timeline =
        {
            TimeEvent(4*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/land_attack")
            end),
            TimeEvent(23*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/land_attack")
                inst.components.combat:DoAttack()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.AttackCounter = inst.AttackCounter + 1
                if inst.AttackCounter >= 3 then
                    inst.AttackCounter = 0
                    inst.podepular = true
                end
				
				inst.TauntCounter = inst.TauntCounter + 1
                if inst.TauntCounter >= 5 then
                    inst.TauntCounter = 0
                    inst.podeTaunt = true
                end				
				
				inst.FeedCounter = inst.FeedCounter + 1
                if inst.FeedCounter >= 8 then
                    inst.FeedCounter = 0
                    inst.podeFeed = true
                end		
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "hit",
        tags = {"busy", "hit", "canrotate"},

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("hit")
            inst.components.rowboatwakespawner:StopSpawning()
        end,

        timeline =
        {
            TimeEvent(1*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/hit")
            end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("death")
            inst.components.rowboatwakespawner:StopSpawning()
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
        end,

        timeline =
        {
            TimeEvent(1*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/death_land")
            end),
            TimeEvent(33*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/death_land_body_fall")
            end),
        },

    },

    State{
    	name = "taunt",
    	tags = {"busy"},

    	onenter = function(inst)
    		inst.Physics:Stop()
    		inst.AnimState:PlayAnimation("taunt")
			inst.podeTaunt = false
    	end,

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/taunt_land")
            end),
        },

    	events =
    	{
    		EventHandler("animover", function(inst) inst.sg:GoToState("idle") end)
    	},
	},
}

CommonStates.AddFrozenStates(states)
CommonStates.AddSleepStates(states,
{
    sleeptimeline = {TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/sleep") end)},
})
CommonStates.AddWalkStates(states,
{
    starttimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
--            local target = inst:GetTarget()
--            if target then
--                inst.sg:GoToState("jump")
--            end
        end),
    },
    walktimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
			local target = inst:GetTarget()
            if target and not inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") and inst.CanFly then
                inst.sg:GoToState("jump")
            end
        end),
        TimeEvent(0*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/footstep")
        end),
        TimeEvent(20*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/footstep")
			DestroyStuff(inst)
        end),
    },
    endtimeline =
    {
        TimeEvent(0, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/footstep")
            inst.components.rowboatwakespawner:StopSpawning()
--            local target = inst:GetTarget()
--            if target then
--                inst.sg:GoToState("jump")
--            end
        end),
    },
})
CommonStates.AddRunStates(states,
{
    starttimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
--            local target = inst:GetTarget()
--            if target then
--                local dist = inst:GetPosition():Dist(target)
--                if (dist > 15 and inst.CanFly)then
--                    inst.sg:GoToState("jump")
--                end
--            end


			local target = inst:GetTarget()
            if target and not inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") and inst.CanFly then
                inst.sg:GoToState("jump")
            end






        end),
    },
    runtimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
            local target = inst:GetTarget()
            if target and not inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") then
--                local dist = inst:GetPosition():Dist(target)
--                 if (dist > 8 and inst.podepular) then
                 if (inst.podepular) then
                    inst.sg:GoToState("jump")
					inst.podepular = false
                end
            end
        end),
        TimeEvent(4*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/land_run")
        end),
        TimeEvent(12*FRAMES, function(inst)
		    DestroyStuff(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/tiger_shark/footstep_run")
        end),
    },
    endtimeline =
    {
        TimeEvent(0, function(inst)
            inst.components.rowboatwakespawner:StopSpawning()
			local target = inst:GetTarget()
            if target and not inst:HasTag("aquatic") and not inst.sg:HasStateTag("specialattack") and inst.CanFly then
                inst.sg:GoToState("jump")
            end
        end),
    },
},
{
    run = "run",
})

return StateGraph("tigershark_ground", states, events, "idle", actionhandlers)
