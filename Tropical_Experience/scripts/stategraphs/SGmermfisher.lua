require("stategraphs/commonstates")

local pegou

local actionhandlers = 
{
    ActionHandler(ACTIONS.GOHOME, "gohome"),
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.CHOP, "chop"),
    ActionHandler(ACTIONS.MINE, "mine"),
    ActionHandler(ACTIONS.HAMMER, "hammer"),	
    ActionHandler(ACTIONS.FISH1, "fishing_pre"),
	ActionHandler(ACTIONS.TAKEITEM, "pickup"),
    ActionHandler(ACTIONS.PICKUP, "pickup"),
	
}


local events=
{
    CommonHandlers.OnLocomote(true,true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttack(),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnHop(),

    EventHandler("onarrivedatthrone", function(inst)

        if inst.components.health and inst.components.health:IsDead() then
            return
        end

        local player_close = FindClosestPlayerToInst(inst, 5, true)
        if player_close then
            local pos = Vector3(player_close.Transform:GetWorldPosition())
            inst:ForceFacePoint(pos.x, pos.y, pos.z)
        end

        if not inst.sg:HasStateTag("transforming") then
            if TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:ShouldTransform(inst) then 
                if inst.sg:HasStateTag("sitting") then
                    inst.sg:GoToState("getup")
                elseif not inst.sg:HasStateTag("gettingup") then
                    inst.sg:GoToState("transform_to_king")
                end
            elseif not inst.sg:HasStateTag("sitting") and player_close == nil then
                inst.sg:GoToState("sitdown")
            elseif player_close and inst.sg:HasStateTag("sitting") then
                inst.sg:GoToState("getup")
            end
        end
    end),

    EventHandler("getup", function(inst) 
        inst.sg:GoToState("getup")
    end),

    EventHandler("onmermkingcreated", function(inst) 
        inst.sg:GoToState("buff")
    end),
    EventHandler("onmermkingdestroyed", function(inst) 
        inst.sg:GoToState("debuff")
    end),   	
}

local states=
{
   State{
        name = "idle_sit",
        tags = { "idle", "sitting" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("sit_idle")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle_sit")
            end),
        },
    },

    State{
        name = "sitdown",
        tags = { "idle", "sitting" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("sit")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle_sit")
            end),
        },
        timeline=
        {
            TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/tentacle/tentacle_splat" ,nil,.5) end),
        },
    },

    State{
        name = "getup",
        tags = { "busy", "gettingup", "nospellcasting" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("getup")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:ShouldTransform(inst) then
                    inst.sg:GoToState("transform_to_king")
                else
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "transform_to_king",
        tags = { "busy", "transforming", "nospellcasting"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("transform_to_king_pre")
        end,

        timeline =
        {
            TimeEvent(9 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/attack")
            end),
            TimeEvent(30 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/characters/wurt/merm/transform_pre")
            end),
        },        

        events =
        {
            EventHandler("animover", function(inst)
                TheWorld:PushEvent("oncandidatekingarrived", {candidate = inst})
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
        name = "mine",
        tags = { "mining" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("atk")
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)

                if inst.bufferedaction ~= nil then
                    local target = inst.bufferedaction.target
                    
                    if target ~= nil and target:IsValid() then
                        local frozen = target:HasTag("frozen")
                        local moonglass = target:HasTag("moonglass")

                        if target.Transform ~= nil then
                            local mine_fx = (frozen and "mining_ice_fx") or (moonglass and "mining_moonglass_fx") or "mining_fx"
                            SpawnPrefab(mine_fx).Transform:SetPosition(target.Transform:GetWorldPosition())
                        end

                        inst.SoundEmitter:PlaySound((frozen and "dontstarve_DLC001/common/iceboulder_hit") or (moonglass and "turnoftides/common/together/moon_glass/mine") or "dontstarve/wilson/use_pick_rock")
                    end
                end

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
        name = "hammer",
        tags = { "hammering" },

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
        name = "buff",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            
            if inst:HasTag("guard") then
                inst.AnimState:PlayAnimation("transform_pre")
            else                
                inst.AnimState:PlayAnimation("buff")
            end
            local fx = SpawnPrefab("merm_splash")
            inst.SoundEmitter:PlaySound("dontstarve/characters/wurt/merm/buff")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end,

        timeline =
        {
            TimeEvent(9 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound(inst.sounds.buff)
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
        name = "debuff",
        tags = { "busy" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("debuff")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },	
	
    State{
        name = "eat",
        tags = {"busy"},

        onenter = function(inst)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("eat")
        end,

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst) inst:PerformBufferedAction() end),
            TimeEvent(2*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/eat") end),
            TimeEvent(11*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/beefalo/chew") end),
            TimeEvent(21*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/beefalo/chew") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },	

    State{

        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle", true)
            else
                inst.AnimState:PlayAnimation("idle", true)
            end
        end,

    },

    State{
        name = "fishing_pre",
        tags = {"canrotate", "prefish", "fishing"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("fish_pre")
        end,

        events =
        {
           EventHandler("animover", function(inst)
               inst:PerformBufferedAction()
               inst.sg:GoToState("fishing")
           end),
			
			
--			EventHandler("animover", function(inst)
--				inst.sg:GoToState("fishing")
--			end),				
        },
    },
	
    State{
        name = "fishing",
        tags = {"canrotate", "fishing"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("fish_loop")
            inst.components.fishingrod:WaitForFish()
        end,

        events =
        {
--            EventHandler("fishingnibble", function(inst) inst.sg:GoToState("fishing_nibble") end ),
--            EventHandler("fishingloserod", function(inst) inst.sg:GoToState("loserod") end),
			EventHandler("animover", function(inst) inst.sg:GoToState("fishing_nibble") end),
		},
    },

    State{
        name = "fishing_pst",
        tags = {"canrotate", "fishing"},
        onenter = function(inst)
            inst.AnimState:PushAnimation("fish_loop")
            inst.AnimState:PlayAnimation("fish_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "fishing_nibble",
        tags = {"canrotate", "fishing", "nibble"},
        onenter = function(inst)
            inst.AnimState:PushAnimation("fish_loop")
            inst.components.fishingrod:Hook()
        end,

        events = 
        {
 --           EventHandler("fishingstrain", function(inst) inst.sg:GoToState("fishing_strain") end),
			EventHandler("animover", function(inst) inst.sg:GoToState("fishing_strain") end),
        },
    },

    State{
        name = "fishing_strain",
        tags = {"canrotate", "fishing"},
        onenter = function(inst)
            inst.AnimState:PushAnimation("fish_loop")
			
        end,

        events = 
        {

 			EventHandler("animover", function(inst) inst.sg:GoToState("catchfish") end),

        },
    },

    State{
        name = "catchfish",
        tags = {"canrotate", "fishing", "catchfish"},
        onenter = function(inst, build)
pegou = math.random(1,3)
if pegou == 3 then inst.AnimState:PlayAnimation("fishcatch")
              else inst.AnimState:PlayAnimation("fishmiss") end		
        end,
        
        timeline = 
        {
            TimeEvent(10*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_cast")
            end), 
            TimeEvent(14*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishcaught")
            end), 
            TimeEvent(34*FRAMES, function(inst) 
if  pegou == 3 then
			local x, y, z = inst.Transform:GetWorldPosition()
			local fx = SpawnPrefab("pondfish")
			if fx then fx.Transform:SetPosition(x, y+3, z) end	
end

--			inst.SoundEmitter:KillSound("cathfish")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst) 
                inst.sg:RemoveStateTag("fishing")
                inst.sg:GoToState("idle")
            end),
        },

        onexit = function(inst)
            inst.AnimState:ClearOverrideSymbol("fish")
        end,
    }, 
	
	
	
    State{
        name = "attack",
        tags = { "attack", "busy" },

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/attack")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
			inst.AnimState:OverrideSymbol("FX_fishing", "merm_guard_build", "")
			inst.AnimState:OverrideSymbol("droplet", "merm_guard_build", "")			
	        inst.AnimState:PlayAnimation("fish_loop")
    	
			
			
			
        end,

        timeline =
        {
		
	            TimeEvent(1 * FRAMES, function(inst)
			    inst.AnimState:PlayAnimation("fishmiss")	
            end),	
		
		
		
            TimeEvent(13 * FRAMES, function(inst)
--			    inst.AnimState:PlayAnimation("fishmiss")	
                inst.components.combat:DoAttack()
                inst.sg:RemoveStateTag("attack")
                inst.sg:RemoveStateTag("busy")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
				inst.AnimState:OverrideSymbol("FX_fishing", "merm_guard_build", "FX_fishing")
				inst.AnimState:OverrideSymbol("droplet", "merm_guard_build", "droplet")				
                inst.sg:GoToState("idle")
            end),
        },
    },	
	
	
	
	
	
	
    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/death")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))            
        end,
    },	
	
	
    State{
        name = "hit",

        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
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
})
CommonStates.AddRunStates(states,
{
	runtimeline = {
		TimeEvent(0*FRAMES, PlayFootstep ),
		TimeEvent(10*FRAMES, PlayFootstep ),
	},
})

CommonStates.AddSleepStates(states,
{
	sleeptimeline = 
	{
		TimeEvent(35*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/sleep") end ),
	},
})

--CommonStates.AddCombatStates(states,
--{
--    attacktimeline = 
--    {
--        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/attack") end),
--        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh") end),
--        TimeEvent(16*FRAMES, function(inst) inst.components.combat:DoAttack() end),
--    },
--    hittimeline = 
--    {
--        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/hurt") end),
--    },
--    deathtimeline = 
--    {
--        TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/merm/death") end),
--    },
--})

CommonStates.AddIdle(states)
CommonStates.AddSimpleActionState(states, "pickup", "pig_pickup", 10 * FRAMES, { "busy" })
CommonStates.AddSimpleActionState(states, "gohome", "pig_pickup", 4*FRAMES, {"busy"})
CommonStates.AddSimpleState(states, "refuse", "pig_reject", { "busy" })
CommonStates.AddHopStates(states, true, { pre = "boat_jump_pre", loop = "boat_jump_loop", pst = "boat_jump_pst"})
--CommonStates.AddSimpleActionState(states, "eat", "eat", 10*FRAMES, {"busy"})
CommonStates.AddFrozenStates(states)

    
return StateGraph("mermfisher", states, events, "idle", actionhandlers)

