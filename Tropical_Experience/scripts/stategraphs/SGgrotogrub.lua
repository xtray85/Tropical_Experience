local WALK_SPEED = 2
local RUN_SPEED = 4

require("stategraphs/commonstates")

local function SetUnderPhysics(inst)
    if inst.isunder ~= true then
        inst.isunder = true
        inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.WORLD)
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    end
end

local function SetAbovePhysics(inst)
    if inst.isunder ~= false then
        inst.isunder = false
        ChangeToCharacterPhysics(inst)
    end
end

local actionhandlers =
{
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.GOHOME, "gohome"),
	ActionHandler(ACTIONS.HIDECRAB, "burrow"),
	ActionHandler(ACTIONS.SHOWCRAB, "emerge"),
}

local events=
{
    CommonHandlers.OnStep(),
	CommonHandlers.OnLocomote(true, true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() then inst.sg:GoToState("hit") end end),
    EventHandler("death", function(inst, data)
				inst.sg:GoToState("death", data)
			end),
    EventHandler("trapped", function(inst) inst.sg:GoToState("trapped") end),
}

local states=
{
    State{

        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst)
            inst.Physics:Stop()
			inst.AnimState:SetBank("grub")
            inst.AnimState:PlayAnimation("idle_loop", true)
        end,
        events=
        {
            EventHandler("animover", function (inst, data) inst.sg:GoToState("idle") end),
        }
    },
    State{

        name = "gohome",
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("burrow")
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/bury")
            inst:PerformBufferedAction()
        end,
        events=
        {
            EventHandler("animover", function (inst, data) inst.sg:GoToState("idle") end),
        }
    },
    State{
        name = "emerge",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            SetAbovePhysics(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/emerge")
			inst.AnimState:SetBank("grub_more")
            inst.AnimState:PlayAnimation("emerge")
        end,
        events=
        {
            EventHandler("animover", function (inst, data) inst.sg:GoToState("idle") end),
        }
    },
    State{
        name = "burrow",
        onenter = function(inst)
            inst.Physics:Stop()
			SetUnderPhysics(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/bury")
            inst.AnimState:PlayAnimation("burrow")
        end,
        events=
        {
            EventHandler("animover", function (inst, data) inst.sg:GoToState("hide") end),
        }		
    },
	
	
    State{
        name = "hide",
        onenter = function(inst)
            inst.Physics:Stop()
			SetUnderPhysics(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/bury")
			inst.AnimState:SetBank("grub_more")
            inst.AnimState:PlayAnimation("hide_idle")
        end,	
    },	
	
	
    State{
        name = "eat",
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat_loop", true)
            inst.sg:SetTimeout(2+math.random()*4)
        end,

        ontimeout= function(inst)
            inst:PerformBufferedAction()
            inst.sg:GoToState("idle")
        end,
    },
    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},

        onenter = function(inst)
            local play_scream = true
			
            if inst.components.inventoryitem then
				play_scream = inst.components.inventoryitem.owner == nil
            end
			
            if play_scream then
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/scream_short")
            end
			
            inst.AnimState:PlayAnimation("run_pre")
            inst.AnimState:PushAnimation("run_loop", true)
            inst.components.locomotor:RunForward()
        end,
    },
    State{
        name = "walk",
        tags = {"moving", "walking", "canrotate"},

        onenter = function(inst)	
            inst.AnimState:PlayAnimation("walk_pre")
            inst.AnimState:PushAnimation("walk_loop", true)
            inst.components.locomotor:WalkForward()
        end,
    },
    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst, data)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/scream_short")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            SetAbovePhysics(inst)
            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))
        end,

    },

     State{
        name = "fall",
        tags = {"busy", "stunned"},
        onenter = function(inst)
            inst.Physics:SetDamping(0)
            inst.Physics:SetMotorVel(0,-20+math.random()*10,0)
            inst.AnimState:PlayAnimation("landing_1", true)
        end,

        onupdate = function(inst)
            local pt = Point(inst.Transform:GetWorldPosition())
            if pt.y < 2 then
                inst.Physics:SetMotorVel(0,0,0)
            end

            if pt.y <= .1 then
                pt.y = 0

                inst.Physics:Stop()
                inst.Physics:SetDamping(5)
                inst.Physics:Teleport(pt.x,pt.y,pt.z)
                inst.DynamicShadow:Enable(true)
                inst.sg:GoToState("stunned")
            end
        end,

        onexit = function(inst)
            local pt = inst:GetPosition()
            pt.y = 0
            inst.Transform:SetPosition(pt:Get())
        end,
    },

    State{
        name = "stunned",
        tags = {"busy", "stunned"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop", true)
            inst.sg:SetTimeout(GetRandomWithVariance(6, 2) )
            if inst.components.inventoryitem then
                inst.components.inventoryitem.canbepickedup = true
            end
        end,

        onexit = function(inst)
            if inst.components.inventoryitem then
                inst.components.inventoryitem.canbepickedup = false
            end
        end,

        ontimeout = function(inst) inst.sg:GoToState("idle") end,
    },

    State{
        name = "trapped",
        tags = {"busy", "trapped"},

        onenter = function(inst)
            inst.Physics:Stop()
			inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("idle_loop", true)
            inst.sg:SetTimeout(1)
        end,

        ontimeout = function(inst) inst.sg:GoToState("idle") end,
    },
    State{
        name = "hit",
        tags = {"busy"},

        onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/crab/scream_short")
            inst.AnimState:PlayAnimation("idle_loop")
            inst.Physics:Stop()
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

}
CommonStates.AddWalkStates(states,
{
	walktimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(12*FRAMES, PlayFootstep ),
	},
},
{
	startwalk = "walk_pre",
	walk = "walk_loop",
	stopwalk = "walk_pst",
})

CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(10*FRAMES, PlayFootstep ),
	},
},
{
	startwalk = "run_pre",
	walk = "run_loop",
	stopwalk = "run_pst",
})
CommonStates.AddSleepStates(states)
CommonStates.AddFrozenStates(states)


return StateGraph("grotogrub", states, events, "idle", actionhandlers)
