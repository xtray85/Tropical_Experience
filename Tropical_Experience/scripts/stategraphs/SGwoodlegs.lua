require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.CHOP, "chop"),
    ActionHandler(ACTIONS.PICKUP, "pickup"),
    ActionHandler(ACTIONS.EQUIP, "pickup"),
    ActionHandler(ACTIONS.ADDFUEL, "pickup"),
    ActionHandler(ACTIONS.TAKEITEM, "pickup"),
    ActionHandler(ACTIONS.UNPIN, "pickup"),
    ActionHandler(ACTIONS.DROP, "dropitem"),
}

local events =
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnLocomote(true, true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(true),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnHop(),
    EventHandler("transformnormal", function(inst)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("transformNormal")
        end
    end),
    EventHandler("doaction", function(inst, data)
        if data.action == ACTIONS.CHOP and not (inst.sg:HasStateTag("busy") or inst.components.health:IsDead()) then
            inst.sg:GoToState("chop", data.target)
        end
    end),
}

local function get_loco_anim(inst, override, default)
    return (override == nil and default)
        or (type(override) ~= "function" and override)
        or override(inst)
end


local states =
{
    State{
        name = "funnyidle",
        tags = { "idle" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/pig/oink")

            if inst.components.follower:GetLeader() ~= nil and inst.components.follower:GetLoyaltyPercent() < .05 then
                inst.AnimState:PlayAnimation("hungry")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hungry")
            elseif inst:HasTag("guard") then
                inst.AnimState:PlayAnimation("idle_loop")
            elseif TheWorld.state.isnight then
                inst.AnimState:PlayAnimation("idle_loop")
            elseif inst.components.combat:HasTarget() then
                inst.AnimState:PlayAnimation("idle_loop")
            elseif inst.components.follower:GetLeader() ~= nil and inst.components.follower:GetLoyaltyPercent() > .3 then
                inst.AnimState:PlayAnimation("idle_loop")
            else
                inst.AnimState:PlayAnimation("idle_loop")
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "run_start",
        tags = {"moving", "running", "canrotate", "sailing"},
        
        onenter = function(inst)
			inst.components.locomotor:RunForward()
if inst:HasTag("aquatic") then inst.AnimState:PlayAnimation("sail_pre") else inst.AnimState:PlayAnimation("run_pre") end
            inst.sg.mem.foosteps = 0
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
        
        timeline=
        {        
            TimeEvent(4*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
            end),
        },        
        
    },

    State{
        name = "run",
        tags = {"moving", "running", "canrotate", "sailing"},
        
        onenter = function(inst) 
            inst.components.locomotor:RunForward()
if inst:HasTag("aquatic") then inst.AnimState:PlayAnimation("sail_loop") else inst.AnimState:PlayAnimation("run_loop") end
            
        end,
        
        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        timeline=
        {
            TimeEvent(7*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
            end),
            TimeEvent(15*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
            end),
        },
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
    },
    
    State{
    
        name = "run_stop",
        tags = {"canrotate", "idle", "sailing"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
if inst:HasTag("aquatic") then inst.AnimState:PlayAnimation("sail_pst") else inst.AnimState:PlayAnimation("run_pst") end
        end,
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
        
    },	
	




    State{
        name = "walk_start",
        tags = {"moving", "canrotate", "sailing"},
        
        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            if inst:HasTag("aquatic") then inst.AnimState:PlayAnimation("sail_pre") else inst.AnimState:PlayAnimation("run_pre") end
        end,

		timeline =	nil,
		
        events=
        {   
            EventHandler("animover", function(inst)     if inst.AnimState:AnimDone() then inst.sg:GoToState("walk") end end ),        
        },	   
        
    },

	
    State{
        name = "walk",
        tags = {"moving", "canrotate", "sailing"},
		
        onenter = function(inst)
            inst.components.locomotor:WalkForward()
			if inst:HasTag("aquatic") then inst.AnimState:PlayAnimation("sail_loop") else inst.AnimState:PlayAnimation("run_loop") end
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline = nil,

        events=
        {   
            EventHandler("animover", function(inst)     if inst.AnimState:AnimDone() then inst.sg:GoToState("walk") end end ),        
        },		
		
    },
		
    
    State{
    
        name = "walk_stop",
        tags = {"canrotate" , "sailing"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
if inst:HasTag("aquatic") then inst.AnimState:PlayAnimation("sail_pst") else inst.AnimState:PlayAnimation("run_pst") end
        end,
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
        
    },	



	
    State{
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:Hide("swap_arm_carry")
            inst.AnimState:PlayAnimation("death")
			
			
			
if inst:HasTag("aquatic") then
if inst.components.driver2 then
local barcoinv = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
if barcoinv then 
barcoinv:Remove()
end
inst.components.driver2.vehicle:Remove()
inst:RemoveComponent("rowboatwakespawner")
inst:RemoveComponent("driver2")
--inst.AnimState:SetLayer(LAYER_WORLD)
--inst.AnimState:SetSortOrder(0)
--inst:RemoveTag("aquatic")
 end end				
			
			
			
			
			
        end,

        events =
        {
            EventHandler("animover", function(inst)
			
								
			
                inst:DoTaskInTime(1, function() 
                    SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
                    SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
					SpawnPrefab("woodlegsghost").Transform:SetPosition(inst:GetPosition():Get())
					SpawnPrefab("skeleton").Transform:SetPosition(inst:GetPosition():Get())
                    inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_despawn")
                    inst:Remove()
                end)
            end ),
        },
    },  

    State{
        name = "abandon",
        tags = { "busy" },

        onenter = function(inst, leader)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("pickup")
            inst.AnimState:PushAnimation("pickup_pst", false)
            if leader ~= nil and leader:IsValid() then
                inst:FacePoint(leader:GetPosition())
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },
--[[
    State{
        name = "transformNormal",
        tags = { "transform", "busy", "sleeping" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/creatures/werepig/transformToPig")
            inst.AnimState:SetBuild("werepig_build")
            inst.AnimState:PlayAnimation("transform_were_pig")
            inst:RemoveTag("hostile")
            inst.AnimState:OverrideSymbol("pig_arm_trans", inst.build, "pig_arm")
            inst.AnimState:OverrideSymbol("pig_ear_trans", inst.build, "pig_ear")
            inst.AnimState:OverrideSymbol("pig_head_trans", inst.build, "pig_head")
            inst.AnimState:OverrideSymbol("pig_leg_trans", inst.build, "pig_leg")
            inst.AnimState:OverrideSymbol("pig_torso_trans", inst.build, "pig_torso")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.components.sleeper:GoToSleep(15 + math.random() * 4)
                inst.sg:GoToState("sleeping")
            end),
        },

        onexit = function(inst)
            inst.AnimState:SetBuild(inst.build)
            inst.AnimState:ClearOverrideSymbol("pig_arm_trans")
            inst.AnimState:ClearOverrideSymbol("pig_ear_trans")
            inst.AnimState:ClearOverrideSymbol("pig_head_trans")
            inst.AnimState:ClearOverrideSymbol("pig_leg_trans")
            inst.AnimState:ClearOverrideSymbol("pig_torso_trans")
        end,
    },
]]
    State{
        name = "attack",
        tags = { "attack", "busy" },

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/pig/attack")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst.components.combat:DoAttack()
                inst.sg:RemoveStateTag("attack")
                inst.sg:RemoveStateTag("busy")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "chop",
        tags = { "chopping" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "eat",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat")
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "hit",
        tags = { "busy" },

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/pig/oink")
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "dropitem",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("pig_pickup")
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
                inst:PerformBufferedAction()
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
--[[
CommonStates.AddWalkStates(states,
{
    walktimeline =
    {
        TimeEvent(0, PlayFootstep),
        TimeEvent(12 * FRAMES, PlayFootstep),
    },
})
]]
--[[
CommonStates.AddRunStates(states,
{
    runtimeline =
    {
        TimeEvent(0, PlayFootstep),
        TimeEvent(10 * FRAMES, PlayFootstep),
    },
})
]]

CommonStates.AddSleepStates(states,
{
    sleeptimeline =
    {
        TimeEvent(35 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/pig/sleep") end),
    },
})

CommonStates.AddIdle(states,"funnyidle")
CommonStates.AddSimpleState(states, "refuse", "pig_reject", { "busy" })
CommonStates.AddFrozenStates(states)
CommonStates.AddSimpleActionState(states, "pickup", "pig_pickup", 10 * FRAMES, { "busy" })
CommonStates.AddSimpleActionState(states, "gohome", "pig_pickup", 4 * FRAMES, { "busy" })
CommonStates.AddHopStates(states, true, { pre = "run_pre", loop = "run_loop", pst = "run_pst"})

return StateGraph("SGwoodlegs", states, events, "idle", actionhandlers)