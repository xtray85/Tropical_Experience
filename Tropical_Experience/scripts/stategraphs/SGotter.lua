require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.EAT, "eat"),
	
	
	
    ActionHandler(ACTIONS.EAT,
        function(inst, action)
            if action.target:HasTag("oceanfish") and action.target:HasTag("oceanfishable") then
                return "eatfish"
            else
                return "eat"
            end
        end),	
		
}

local events =
{
    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") then inst.sg:GoToState("hit") end end),
    EventHandler("death", function(inst) inst.sg:GoToState("death", inst.sg.statemem.dead) end),
    EventHandler("doattack", function(inst, data) if not inst.components.health:IsDead() and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then inst.sg:GoToState("attack", data.target) end end),
    CommonHandlers.OnSleep(),
--    CommonHandlers.OnHop(),
    CommonHandlers.OnLocomote(true, false),
    CommonHandlers.OnFreeze(),

    EventHandler("startle", function(inst)
        if not (inst.sg:HasStateTag("startled") or
                inst.sg:HasStateTag("statue") or
                inst.components.health:IsDead() or
                (inst.components.freezable ~= nil and inst.components.freezable:IsFrozen())) then
            if inst.components.sleeper ~= nil and inst.components.sleeper:IsAsleep() then
                inst.components.sleeper:WakeUp()
            end
            inst.components.combat:SetTarget(nil)
            inst.sg:GoToState("startle")
        end
    end),

    EventHandler("heardwhistle", function(inst, data)
        if not (inst.sg:HasStateTag("statue") or
                inst.components.health:IsDead() or
                (inst.components.freezable ~= nil and inst.components.freezable:IsFrozen())) then
            if inst.components.sleeper ~= nil and inst.components.sleeper:IsAsleep() then
                inst.components.sleeper:WakeUp()
                inst.components.combat:SetTarget(nil)
            else
                if inst.components.combat:TargetIs(data.musician) then
                    inst.components.combat:SetTarget(nil)
                end
                if not inst.sg:HasStateTag("howling") then
                    inst.sg:GoToState("howl", 2)
                end
            end
        end
    end),
	
	EventHandler("onhop", function(inst)
            if (inst.components.health == nil or not inst.components.health:IsDead()) and (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("idle")) then
                if not inst.sg:HasStateTag("jumping") then
                        inst.sg:GoToState("hop_pre")
                end
            elseif inst.components.embarker then
                inst.components.embarker:Cancel()
            end
        end),

}

local function StartAura(inst)
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED
end

local function StopAura(inst)
    inst.components.sanityaura.aura = 0
end

local states =
{
    State{
        name = "idle",
        tags = { "idle", "canrotate" },
        onenter = function(inst, playanim)
            inst.SoundEmitter:PlaySound(inst.sounds.pant)
            inst.Physics:Stop()
--            if playanim then
--                inst.AnimState:PlayAnimation(playanim)
--                inst.AnimState:PushAnimation("idle", true)
--            else
                inst.AnimState:PlayAnimation("idle", true)
--            end
            inst.sg:SetTimeout(2*math.random()+.5)
        end,
    },

    State{
        name = "attack",
        tags = { "attack", "busy" },

        onenter = function(inst, target)
            inst.sg.statemem.target = target
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
			if math.random() < 0.5 then inst.AnimState:PlayAnimation("bite") else inst.AnimState:PlayAnimation("attack") end		
        end,

        timeline =
        {

            TimeEvent(14*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.attack) end),
            TimeEvent(16*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) if math.random() < .333 then inst.components.combat:SetTarget(nil) inst.sg:GoToState("taunt") else inst.sg:GoToState("idle", "atk_pst") end end),
        },
    },

    State{
        name = "eat",
        tags = { "busy" },

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("bite")
--            inst.AnimState:PlayAnimation("eat_pre")
--            inst.AnimState:PushAnimation("eat_pst", false)			
        end,

        timeline =
        {
            TimeEvent(14*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.bite) end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) if inst:PerformBufferedAction() then inst.components.combat:SetTarget(nil) inst.sg:GoToState("taunt") else inst.sg:GoToState("idle", "atk_pst") end end),
        },
    },


    State{
        name = "eatfish",
        tags = { "busy" },

        onenter = function(inst, cb)
            inst.Physics:Stop()
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("bite")
--            inst.AnimState:PlayAnimation("eat_pre")
--            inst.AnimState:PushAnimation("eat_pst", false)			
        end,

        timeline =
        {
            TimeEvent(14*FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.bite) end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) 
			
			
				local action = inst:GetBufferedAction()
                if action and action.target and action.target:IsValid() then
--                    if math.random() < inst.geteatchance(inst, action.target) then
                        if action.target.components.oceanfishable and action.target.components.oceanfishable:GetRod() then
                            local rod = action.target.components.oceanfishable:GetRod()
                            inst.components.oceanfishable:SetRod(rod)

                            inst:PushEvent("attacked",{attacker = rod.components.oceanfishingrod.fisher})
                        end
                        action.target:Remove()					
						inst.sg:GoToState("taunt")							
--                    else
--                        inst.sg:GoToState("idle")
--                    end
                else
						inst.sg:GoToState("idle")
				end

				
			end),
        },
    },


    State{
        name = "hit",
        tags = { "busy", "hit" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("hit")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "startle",
        tags = { "busy", "startled" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt", true)
            inst.SoundEmitter:PlaySound(inst.components.combat.hurtsound)
            inst.sg:SetTimeout(.8 + .3 * math.random())
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle", "scared_pst")
        end,
    },

    State{
        name = "taunt",
        tags = { "busy" },

        onenter = function(inst, norepeat)
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("taunt")
                inst.sg.statemem.norepeat = norepeat
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.bark) end),
            TimeEvent(24 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.bark) end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if not inst.sg.statemem.norepeat and math.random() < .333 then
                    inst.sg:GoToState("taunt", inst.components.follower.leader ~= nil and inst.components.follower.leader:HasTag("player"))
                else
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "howl",
        tags = { "busy", "howling" },

        onenter = function(inst, count)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
            inst.sg.statemem.count = count or 0
        end,

        timeline =
        {
            TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.howl) end),
        },

        events =
        {
            EventHandler("heardwhistle", function(inst)
                inst.sg.statemem.count = 2
            end),
            EventHandler("animover", function(inst)
                if inst.sg.statemem.count > 0 then
                    inst.sg:GoToState("howl", inst.sg.statemem.count > 1 and inst.sg.statemem.count - 1 or -1)
                elseif inst.sg.statemem.count == 0 and math.random() < .333 then
                    inst.sg:GoToState("howl", inst.components.follower.leader ~= nil and inst.components.follower.leader:HasTag("player") and -1 or 0)
                else
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "death",
        tags = { "busy" },

        onenter = function(inst, reanimating)
            if reanimating then
                inst.AnimState:Pause()
            else
                inst.AnimState:PlayAnimation("death")
--				if inst.components.amphibiouscreature ~= nil and inst.components.amphibiouscreature.in_water then
--		            inst.AnimState:PushAnimation("death_idle", true)
--				end
            end
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)
            inst.SoundEmitter:PlaySound(inst.sounds.death)
            inst.components.lootdropper:DropLoot(inst:GetPosition())
        end,

        timeline =
        {
            TimeEvent(TUNING.GARGOYLE_REANIMATE_DELAY, function(inst)
                if not inst:IsInLimbo() then
                    inst.AnimState:Resume()
                end
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
				if inst._CanMutateFromCorpse ~= nil and inst:_CanMutateFromCorpse() then
					SpawnPrefab("houndcorpse").Transform:SetPosition(inst.Transform:GetWorldPosition())
					inst:Remove()
				end
            end),
        },


        onexit = function(inst)
            if not inst:IsInLimbo() then
                inst.AnimState:Resume()
            end
        end,
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
        name = "hop_pre",
        tags = { "doing", "busy", "jumping", "canrotate" },

        onenter = function(inst)
			inst.sg.statemem.swimming = inst:HasTag("swimming")
			
			if inst.components.amphibiouscreature and inst.components.amphibiouscreature.in_water then
            inst.AnimState:PlayAnimation("jumpout")
			else
            inst.AnimState:PlayAnimation("jump")			
			end
			if not inst.sg.statemem.swimming then
				inst.Physics:ClearCollidesWith(COLLISION.LIMITS)
				inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)
			end
			if inst.components.embarker:HasDestination() then
	            inst.sg:SetTimeout(18 * FRAMES)
                inst.components.embarker:StartMoving()
			else
	            inst.sg:SetTimeout(18 * FRAMES)
                if inst.landspeed then
                    inst.components.locomotor.runspeed = inst.landspeed
                end
                inst.components.locomotor:RunForward()
			end
        end,

	    onupdate = function(inst,dt)
			if inst.components.embarker:HasDestination() then
				if inst.sg.statemem.embarked then
					inst.components.embarker:Embark()
					inst.components.locomotor:FinishHopping()
					inst.sg:GoToState("hop_pst", false)
				elseif inst.sg.statemem.timeout then
					inst.components.embarker:Cancel()
					inst.components.locomotor:FinishHopping()

					local x, y, z = inst.Transform:GetWorldPosition()
					inst.sg:GoToState("hop_pst", not TheWorld.Map:IsVisualGroundAtPoint(x, y, z) and inst:GetCurrentPlatform() == nil)
				end
            elseif inst.sg.statemem.timeout or
                   (inst.sg.statemem.tryexit and inst.sg.statemem.swimming == TheWorld.Map:IsVisualGroundAtPoint(inst.Transform:GetWorldPosition())) or
                   (not inst.components.locomotor.dest and not inst.components.locomotor.wantstomoveforward) then
				inst.components.embarker:Cancel()
				inst.components.locomotor:FinishHopping()
				local x, y, z = inst.Transform:GetWorldPosition()
				inst.sg:GoToState("hop_pst", not TheWorld.Map:IsVisualGroundAtPoint(x, y, z) and inst:GetCurrentPlatform() == nil)
			end
		end,

        timeline =
        {
		TimeEvent(0, function(inst)
			if inst:HasTag("swimming") then
				SpawnPrefab("splash_green").Transform:SetPosition(inst.Transform:GetWorldPosition())
			end
		end),
		
        TimeEvent(9 * FRAMES, function(inst)
			if inst.sg.statemem.swimming then
				inst.Physics:ClearCollidesWith(COLLISION.LIMITS)
				inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)
			end
		end),		
		
        },

		ontimeout = function(inst)
			inst.sg.statemem.timeout = true
		end,

        events =
        {
            EventHandler("done_embark_movement", function(inst)
				if not inst.AnimState:IsCurrentAnimation("jump_loop") then
					inst.AnimState:PlayAnimation("jump_loop", false)
				end
				inst.sg.statemem.embarked = true
            end),
            EventHandler("animover", function(inst)
				if not inst.AnimState:IsCurrentAnimation("jump_loop") then
					if inst.AnimState:AnimDone() then
						if not inst.components.embarker:HasDestination() then
							inst.sg.statemem.tryexit = true
						end
					end
					inst.AnimState:PlayAnimation("jump_loop", false)
				end
            end),
        },

		onexit = function(inst)
            inst.Physics:CollidesWith(COLLISION.LIMITS)
			inst.Physics:ClearCollidesWith(COLLISION.BOAT_LIMITS)
			if inst.components.embarker:HasDestination() then
				inst.components.embarker:Cancel()
				inst.components.locomotor:FinishHopping()
			end

		end,
    },

    State{
        name = "hop_pst",
        tags = { "busy", "jumping" },

        onenter = function(inst, land_in_water)
			if land_in_water then
				inst.components.amphibiouscreature:OnEnterOcean()
			else
				inst.components.amphibiouscreature:OnExitOcean()
			end
				
			if inst.components.amphibiouscreature and inst.components.amphibiouscreature.in_water then
            inst.AnimState:PlayAnimation("jumpin_pst")
			else
            inst.AnimState:PlayAnimation("jump_pst")					
			end			
			
        end,

        timeline =
        {
		TimeEvent(4 * FRAMES, function(inst)
			if inst:HasTag("swimming") then
				inst.components.locomotor:Stop()
				SpawnPrefab("splash_green").Transform:SetPosition(inst.Transform:GetWorldPosition())
			end
		end),
		TimeEvent(6 * FRAMES, function(inst)
			if not inst:HasTag("swimming") then
                inst.components.locomotor:StopMoving()
			end
		end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)

		end,
    },	
}


CommonStates.AddSleepStates(states,
{
    sleeptimeline =
    {
        TimeEvent(30 * FRAMES, function(inst) inst.SoundEmitter:PlaySound(inst.sounds.sleep) end),
    },
})

CommonStates.AddRunStates(states,
{
    runtimeline =
    {
        TimeEvent(0, function(inst)
            inst.SoundEmitter:PlaySound(inst.sounds.growl)
            if inst:HasTag("swimming") then
                inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/jump_small",nil,.25)
            else
                    PlayFootstep(inst)
            end
        end),
        TimeEvent(4 * FRAMES, function(inst)
            if inst:HasTag("swimming") then
                inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/jump_small",nil,.25)
            else
                    PlayFootstep(inst)
            end
        end),
    },
})
--CommonStates.AddFrozenStates(states, HideEyeFX, ShowEyeFX)

return StateGraph("otter", states, events, "taunt", actionhandlers)
