require("stategraphs/commonstates")

local function onattack(inst, data)
    if inst.components.health:GetPercent() > 0 and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then
        local dist = inst:GetDistanceSqToInst(data.target)
        if dist > 25 then
            inst.sg:GoToState("throw", data.target)
        end
    end
end

local function spawngaze(inst)
    local beam = SpawnPrefab("gaze_beamunderwater")
	local x, y, z = inst.Transform:GetWorldPosition()
    local radius = 4 
    beam.Transform:SetPosition(x,y+2,z)
end

local function dogaze(inst)
    inst:DoTaskInTime(0.5,function() spawngaze(inst) end) 
end

local events = 
{
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    EventHandler("doattack", onattack),
    EventHandler("move", function(inst, data)
        if not inst.sg:HasStateTag("move") then
            inst.sg:GoToState("move", data.pos)
        end
    end),
}

local function DoAOEAttack(inst, dist, radius)
    local hit = false
    inst.components.combat.ignorehitrange = true
    local x0, y0, z0 = inst.Transform:GetWorldPosition()
    local angle = (inst.Transform:GetRotation() + 90) * DEGREES
    local sinangle = math.sin(angle)
    local cosangle = math.cos(angle)
    local x = x0 + dist * sinangle
    local z = z0 + dist * cosangle
    for i, v in ipairs(TheSim:FindEntities(x, y0, z, radius + 3, { "_combat" }, { "flying", "shadow", "ghost", "FX", "NOCLICK", "DECOR", "INLIMBO", "playerghost" })) do
        if v:IsValid() and not v:IsInLimbo() and
            not (v.components.health ~= nil and v.components.health:IsDead()) then
            local range = radius + v:GetPhysicsRadius(.5)
            if v:GetDistanceSqToPoint(x, y0, z) < range * range and inst.components.combat:CanTarget(v) then
                --dummy redirected so that players don't get red blood flash
                v:PushEvent("attacked", { attacker = inst, damage = 0, redirected = v })
                v:PushEvent("knockback", { knocker = inst, radius = radius + dist, propsmashed = true })
                hit = true
            end
        end
    end
    inst.components.combat.ignorehitrange = false
    if hit then
--        local prop = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
--        if prop ~= nil then
--            dist = dist + radius - .5
--            return { prop = prop, pos = Vector3(x0 + dist * sinangle, y0, z0 + dist * cosangle) }
--        end
    end
end

local actionhandlers = {}

local states = 
{
    State{
        name = "throw",
        tags = {"attack", "busy"},

        onenter = function(inst)
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("spit")
        end,

        timeline=
        {

            TimeEvent(13*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/spit_puke")
            end),                
            TimeEvent(56*FRAMES, function(inst) 
                inst.components.combat:DoAttack() 
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/spit")
            end),
            TimeEvent(57*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
        },
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("taunt") end),
        },
    },

    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle_loop", true)
        end,
    },

    State{
        name = "hit",
        tags = {"busy", "hit"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/hit")
        end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "move",
        tags = {"busy", "move"},

        onenter = function(inst, pos)
            inst.components.health:SetInvincible(true)
            inst.AnimState:PlayAnimation("taunt")
            inst.AnimState:PushAnimation("exit", false)	
            inst.sg.statemem.pos = pos
            inst.components.minionspawner2:DespawnAll()
            inst.components.minionspawner2.minionpositions = nil
            inst.sg:SetTimeout(4)
        end,

        timeline =
        {
            TimeEvent(20*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/taunt")
            end),
            
            TimeEvent(62*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/exit")
            end),

            TimeEvent(83*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken_submerge")
                inst.SoundEmitter:KillSound("quacken_lp_1")
                inst.SoundEmitter:KillSound("quacken_lp_2")
            end),
        },

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
			local invader = GetClosestInstWithTag("player", inst, 30)
			if invader then
			local pos = invader:GetPosition()
			inst.Transform:SetPosition(pos:Get())
			else
            inst.Transform:SetPosition(inst.sg.statemem.pos:Get())
			end
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("spawn")
        end,
    },

    State{
        name = "spawn",
        tags = {"busy"},

        onenter = function(inst)
		    inst.components.health:SetInvincible(true)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/enter")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/quacken_emerge")
            
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/head_drone_rnd_LP", "quacken_lp_1")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/head_drone_LP", "quacken_lp_2")

            inst.AnimState:PlayAnimation("enter")
        end,

        timeline =
        {
            TimeEvent(50*FRAMES, function(inst) inst.components.minionspawner2:SpawnAll() end),
			TimeEvent(70*FRAMES, function(inst) inst.sg.statemem.smashed = DoAOEAttack(inst, .8, 4) end),			
            TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/enter") end)
        },

        events =
        {
            EventHandler("animover", function(inst) inst.components.health:SetInvincible(false) inst.sg:GoToState("idle") end)
        },
    },



    State{
        name = "death",  
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("death")
            inst.components.minionspawner2:DespawnAll()
            inst.components.minionspawner2.minionpositions = nil
        end,

        timeline =
        {
            TimeEvent(2*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/death")
            end),

            TimeEvent(38*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/quacken_submerge")
                inst.SoundEmitter:KillSound("quacken_lp_1")
                inst.SoundEmitter:KillSound("quacken_lp_2")
            end),

            TimeEvent(90*FRAMES, function(inst)
                inst.components.lootdropper:DropLoot()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst) inst:Remove() end),
        },
    },

    State{
        name = "taunt",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("taunt")
        end,
        
        timeline = 
        {
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/taunt") end)
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
	
    State{
        name = "taunt2",
        tags = {"busy"},
        
        onenter = function(inst)
			inst.components.health:SetInvincible(true)
            inst.AnimState:PlayAnimation("taunt")
        end,
        
        timeline = 
        {
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/quacken/taunt") dogaze(inst) end),
			TimeEvent(50*FRAMES, function(inst) inst.components.minionspawner2:SpawnAll() end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.components.health:SetInvincible(false) inst.sg:GoToState("idle") end),
        },
    },	
}

return StateGraph("krakenunderwater", states, events, "idle", actionhandlers)