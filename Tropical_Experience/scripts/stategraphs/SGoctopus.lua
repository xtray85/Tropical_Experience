require("stategraphs/commonstates")
local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
}

local events=
{
    CommonHandlers.OnStep(),
    CommonHandlers.OnLocomote(true,true),
			EventHandler("locomote", 
				function(inst) 
					if inst.components.locomotor:WantsToMoveForward() then
						if not inst.sg:HasStateTag("run") and not inst.sg:HasStateTag("busy") then
							inst.sg:GoToState("run")
						end
					else
						if not inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("busy") then
							inst.sg:GoToState("idle")
						end
					end
				end),
    EventHandler("doattack", function(inst)
        if not (inst.sg:HasStateTag("busy") or inst.components.health:IsDead()) then
            inst.sg:GoToState("attack")
        end
    end),
	
    EventHandler("death", function(inst)
        inst.sg:GoToState("death")
    end),
    EventHandler("attacked", function(inst)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("hit")
        end
    end),						
}
local states=
{
    State{
        name = "idle",
		tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
			inst.sg:RemoveStateTag("run")
			inst.AnimState:PlayAnimation("run_loop", true)
        end,

		--events=
		--{

		--},
    },
    State{
        name = "run",
        tags = {"run", "canrotate"},
        onenter = function(inst, playanim)
			inst.AnimState:PlayAnimation("run_loop", true)
    		inst.components.locomotor:RunForward()            
        end,
    },
	
	
	
    State{
        name = "attack",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            if inst.components.combat.target and inst.components.combat.target:IsValid() then
                inst:FacePoint(inst.components.combat.target:GetPosition())
            end
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("run_loop")
        end,
        
        timeline =
        {
			TimeEvent(2*FRAMES, function(inst) inst.Transform:SetScale(1.4,1.5,1.5) end),
			TimeEvent(4*FRAMES, function(inst) inst.Transform:SetScale(1.3,1.5,1.5) end),
			TimeEvent(6*FRAMES, function(inst) inst.Transform:SetScale(1.2,1.5,1.5) end),
			TimeEvent(8*FRAMES, function(inst) inst.Transform:SetScale(1.1,1.5,1.5) end),
			TimeEvent(10*FRAMES, function(inst) inst.Transform:SetScale(1.75,1.5,1.5) end),		
            TimeEvent(17*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot") end),
            TimeEvent(20*FRAMES, function(inst) inst.components.combat:DoAttack() end),
			TimeEvent(20*FRAMES, function(inst) inst.Transform:SetScale(1.5,1.5,1.5) end),					
        },
        
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },	
	

	
    State{
        name = "hit",
        tags = { "busy" },
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/dogfish/hit")
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
        name = "death",
        tags = { "busy" },

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("volcan/Dogfish/death")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            if inst.components.lootdropper ~= nil then
                inst.components.lootdropper:DropLoot(inst:GetPosition())
            end
        end,

        timeline =
        {
        },
    },
}

return StateGraph("SGoctopus", states, events, "idle", actionhandlers)