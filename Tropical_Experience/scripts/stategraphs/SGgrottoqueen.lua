require("stategraphs/commonstates")
--------------------------------------------------------------------------

local events =
{
    CommonHandlers.OnLocomote(false, true),
    CommonHandlers.OnDeath(),
    EventHandler("attacked", function(inst)
        if not inst.components.health:IsDead() and
            (not inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("caninterrupt")) then
            inst.sg:GoToState("hit")
        end
    end),
}

local states =
{
    State{
        name = "idle",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
                inst.Physics:Stop()
                inst.AnimState:PlayAnimation("idle_loop")
        end,

        timeline =
        {
            TimeEvent(0, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bee_queen/breath")
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
    },

    State{
        name = "walk_start",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst.AnimState:PlayAnimation("walk_pre")
        end,

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
            inst.AnimState:PlayAnimation("walk_loop")
        end,

        timeline =
        {
            TimeEvent(0, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bee_queen/breath")
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
        name = "walk_stop",
        tags = { "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("walk_pst")
        end,

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
        name = "hit",
        tags = { "hit", "busy" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("walk_pst")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bee_queen/hit")
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
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
    },

    State{
        name = "death",
        tags = { "busy" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("death")
            inst:AddTag("NOCLICK")
            inst.SoundEmitter:KillSound("flying")
        end,

        timeline =
        {
            TimeEvent(28 * FRAMES, function(inst)
                LandFlyingCreature(inst)
                inst.components.sanityaura.aura = 0
                inst.SoundEmitter:PlaySound("dontstarve/bee/beehive_hit")
                ShakeIfClose(inst)
                if inst.persists then
                    inst.persists = false
                    inst.components.lootdropper:DropLoot(inst:GetPosition())
                    if inst.hivebase ~= nil then
                        inst.hivebase.queenkilled = true
                    end
                end
            end),
            TimeEvent(3, function(inst)
                if inst.sg.mem.focuscount ~= nil then
                    inst.sg.mem.focuscount = nil
                    inst.sg.mem.focustargets = nil
                    for i, v in ipairs(inst.components.commander:GetAllSoldiers()) do
                        v:FocusTarget(nil)
                    end
                    inst:BoostCommanderRange(false)
                end
            end),
            TimeEvent(5, function(inst)
                ErodeAway(inst)
                RaiseFlyingCreature(inst)
            end),
        },

        onexit = function(inst)
            --Should NOT happen!
            if inst.sg.mem.focuscount ~= nil then
                inst.components.sanityaura.aura = -TUNING.SANITYAURA_HUGE
            end
            inst:RemoveTag("NOCLICK")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bee_queen/wings_LP", "flying")
            inst:StartHoney()
        end,
    },

    State{
        name = "spawnguards",
        tags = { "spawnguards", "busy", "nosleep", "nofreeze" },

        onenter = function(inst)
            FaceTarget(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("spawn")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/together/bee_queen/spawn")
        end,

        timeline =
        {
            TimeEvent(16 * FRAMES, function(inst)
                inst.sg.mem.wantstospawnguards = nil
                if inst.spawnguards_chain < inst.spawnguards_maxchain then
                    inst.spawnguards_chain = inst.spawnguards_chain + 1
                else
                    inst.spawnguards_chain = 0
                    inst.components.timer:StartTimer("spawnguards_cd", inst.spawnguards_cd)
                end

                local oldnum = inst.components.commander:GetNumSoldiers()
                local x, y, z = inst.Transform:GetWorldPosition()
                local rot = inst.Transform:GetRotation()
                local num = math.random(TUNING.BEEQUEEN_MIN_GUARDS_PER_SPAWN, TUNING.BEEQUEEN_MAX_GUARDS_PER_SPAWN)
                if num + oldnum > TUNING.BEEQUEEN_TOTAL_GUARDS then
                    num = math.max(TUNING.BEEQUEEN_MIN_GUARDS_PER_SPAWN, TUNING.BEEQUEEN_TOTAL_GUARDS - oldnum)
                end
                local drot = 360 / num
                for i = 1, num do
                    local minion = SpawnPrefab("beeguard")
                    local angle = rot + i * drot
                    local radius = minion:GetPhysicsRadius(0)
                    minion.Transform:SetRotation(angle)
                    angle = -angle * DEGREES
                    minion.Transform:SetPosition(x + radius * math.cos(angle), 0, z + radius * math.sin(angle))
                    minion:OnSpawnedGuard(inst)
                end

                if oldnum > 0 then
                    local soldiers = inst.components.commander:GetAllSoldiers()
                    num = #soldiers
                    drot = 360 / num
                    for i = 1, num do
                        local angle = -(rot + i * drot) * DEGREES
                        local xoffs = TUNING.BEEGUARD_GUARD_RANGE * math.cos(angle)
                        local zoffs = TUNING.BEEGUARD_GUARD_RANGE * math.sin(angle)
                        local mindistsq = math.huge
                        local closest = 1
                        for i2, v in ipairs(soldiers) do
                            local offset = v.components.knownlocations:GetLocation("queenoffset")
                            if offset ~= nil then
                                local distsq = distsq(xoffs, zoffs, offset.x, offset.z)
                                if distsq < mindistsq then
                                    mindistsq = distsq
                                    closest = i2
                                end
                            end
                        end
                        table.remove(soldiers, closest).components.knownlocations:RememberLocation("queenoffset", Vector3(xoffs, 0, zoffs), false)
                    end
                end
            end),
            CommonHandlers.OnNoSleepTimeEvent(32 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("nosleep")
                inst.sg:RemoveStateTag("nofreeze")
            end),
        },

        events =
        {
            CommonHandlers.OnNoSleepAnimOver("idle"),
        },
    },
}


return StateGraph("SGgrottoqueen", states, events, "idle")
