require("stategraphs/commonstates")

local function onattackedfn(inst, data)
    if inst.components.health and not inst.components.health:IsDead()
    and (not inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("frozen")) then
       inst.sg:GoToState("hit")
    end
end

local function onattackfn(inst)
    if inst.components.health and not inst.components.health:IsDead()
    and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then

        if not inst.CanCharge and not inst.components.timer:TimerExists("Charge") then
            inst.components.timer:StartTimer("Charge", 10)
        end

        inst.sg:GoToState("attack")
    end
end

local actionhandlers = {}

local events=
{
    CommonHandlers.OnLocomote(true, true),
    CommonHandlers.OnDeath(),
	CommonHandlers.OnAttack(),
    EventHandler("doattack", onattackfn),
    EventHandler("attacked", onattackedfn),
}

local states=
{

    State{
        name = "idle",
        tags = {"idle"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop")
            

                inst.AnimState:Hide("twister_water_fx")


        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

----------------------COMBAT------------------------

    State{
        name = "hit",
        tags = {"hit", "busy"},
        
        onenter = function(inst, cb)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("hit")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/hit")
        end,
        
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "attack",
        tags = {"attack", "busy", "canrotate"},
        
        onenter = function(inst)
            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 1)

            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end

 if math.random(1,2) == 1 then

inst.components.combat:StartAttack()
inst.AnimState:PlayAnimation("atk")

else
			

inst:DoTaskInTime(10*FRAMES, function(inst)			
	inst.AnimState:PlayAnimation("atk")			
	local target = inst.components.combat.target
    if target ~= nil then
        local tornado = SpawnPrefab("twister_tornadodefogo")
        tornado.WINDSTAFF_CASTER = inst
        tornado.WINDSTAFF_CASTER_ISPLAYER = false
        tornado.Transform:SetPosition(inst:GetPosition():Get())
        tornado.components.knownlocations:RememberLocation("target", target:GetPosition())
    end
end)
	
	
	
end	
	
	
	
        end,
        onexit = function(inst)
            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 0)
        end,

        timeline =
        {
            TimeEvent(4*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/attack_pre")
            end),

            TimeEvent(31*FRAMES, function(inst)
				local x, y, z = inst.Transform:GetWorldPosition()
			for i, v in ipairs(TheSim:FindEntities(x, 0, z, 12, nil, nil, { "_health" })) do
			 if v.components.temperature ~= nil then
                    local newtemp = v.components.temperature.current + 15
                    if newtemp < v.components.temperature:GetMax() + 14 then
                        v.components.temperature.current = v.components.temperature.current + 15
                    end
                end
			end
            end),

            TimeEvent(33*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/attack_hit")
                inst.components.combat:DoAttack()
            end),
        },

        events=
        {
            EventHandler("animover", function(inst) 
                if inst.CanVacuum then
                        inst.sg:GoToState("vacuum_antic_pre") 
                else 
                    inst.sg:GoToState("idle")  
                end 
            end),
        },
    },

    State{
        name = "vacuum_antic_pre",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            TheMixer:PushMix("twister")
            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 1)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_antic_pre")
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/angry")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("vacuum_antic_loop") end),
        },
    },

    State{
        name = "vacuum_antic_loop",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_antic_loop", true)
            
            inst.sg:SetTimeout(2)

            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_antic_LP", "vacuum_antic_loop")
        end,

        onexit = function(inst)
            inst.SoundEmitter:KillSound("vacuum_antic_loop")
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("vacuum_pre")
        end,
    },

    State{
        name = "vacuum_pre",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_pre")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("vacuum_loop") end),
        },
    },

    State{
        name = "vacuum_loop",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/wilson/use_gemstaff")
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end

            inst.CanVacuum = false
            inst.AnimState:PlayAnimation("vacuum_loop", true)
			local x, y, z = inst.Transform:GetWorldPosition()
			inst.lel1 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x+3.5,.01,z-3.5)
			inst.lel2 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x-3.5,.01,z-3.5)
			inst.lel3 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x-3.5,.01,z+3.5)
			inst.lel4 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x+3.5,.01,z+3.5)
			
			inst.lel5 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x+10,.01,z-5)
			inst.lel6 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x+5,.01,z-10)
			inst.lel7 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x-10,.01,z+5)
			inst.lel8 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x-5,.01,z+10)
			
			inst.lel19 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x-5,.01,z-10)
			inst.lel20 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x-10,.01,z-5)
			inst.lel21 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x+5,.01,z+10)
			inst.lel22 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x+10,.01,z+5)
			
			inst.lel23 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x,.01,z-7.5)
			inst.lel24 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x+7.5,.01,z)
			inst.lel25 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x,.01,z+7.5)
			inst.lel26 = SpawnPrefab("deer_fire_circle").Transform:SetPosition(x-7.5,.01,z)
			inst:DoTaskInTime(5, function(inst)
			for i, v in ipairs(TheSim:FindEntities(x, 0, z, 35, nil, {}, {"deer_fire_circle"})) do
			v:Remove()
			end
			end)
            inst.sg:SetTimeout(5)

            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_hit")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_LP", "vacuum_loop")
        end,

        onexit = function(inst)
            if not inst.components.timer:TimerExists("Vacuum") then
                inst.components.timer:StartTimer("Vacuum", 25)
            end


            inst.SoundEmitter:KillSound("vacuum_loop")
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("vacuum_pst")
        end,
    },

    State{
        name = "vacuum_pst",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            TheMixer:PopMix("twister")
        
            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 0)

            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "waves_antic_pre",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            TheMixer:PushMix("twister")
            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 1)

            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_antic_pre")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_antic_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("waves_antic_loop") end),
        },
    },

    State{
        name = "waves_antic_loop",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_antic_loop", true)
            inst.sg:SetTimeout(7)
            
            inst.sg.statemem.maxwaves = 4
            inst.sg.statemem.waves = 1
            inst.sg.statemem.wavetime = FRAMES*30
            inst.sg.statemem.wavetimer = FRAMES*30

            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_antic_LP", "vacuum_antic_loop")

        end,

        onupdate = function(inst, dt)
            inst.sg.statemem.wavetimer = inst.sg.statemem.wavetimer + dt
            if inst.sg.statemem.wavetimer >= inst.sg.statemem.wavetime and inst.sg.statemem.waves <= inst.sg.statemem.maxwaves then
                SpawnWavesSW(inst, math.random(10, 15), 360, 6, "wave_ripple", -25, 1.5)
                inst.sg.statemem.waves = inst.sg.statemem.waves + 1
                inst.sg.statemem.wavetimer = 0
            end
        end,

        onexit = function(inst)
            inst.SoundEmitter:KillSound("vacuum_antic_loop")
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("waves_pre")
        end,
    },

    State{
        name = "waves_pre",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_pre")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("waves_loop") end),
        },
    },

    State{
        name = "waves_loop",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end

            inst.AnimState:PlayAnimation("vacuum_loop", true)

            inst.CanVacuum = false

            inst.sg.statemem.wavetime = FRAMES*24
            inst.sg.statemem.wavetimer = FRAMES*24

            inst.sg:SetTimeout(5)


            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_hit")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/vacuum_LP", "vacuum_loop")

        end,

        onexit = function(inst)
            if not inst.components.timer:TimerExists("Vacuum") then
                inst.components.timer:StartTimer("Vacuum", 20)
            end

            inst.SoundEmitter:KillSound("vacuum_loop")
        end,

        onupdate = function(inst, dt)
            inst.sg.statemem.wavetimer = inst.sg.statemem.wavetimer + dt
            if inst.sg.statemem.wavetimer >= inst.sg.statemem.wavetime then
                SpawnWavesSW(inst, math.random(11, 12), 360, 12, nil, 3, nil, true)
                inst.sg.statemem.wavetimer = 0
            end
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("waves_pst")
        end,
    },

    State{
        name = "waves_pst",
        tags = {"attack", "busy"},
        
        onenter = function(inst)
            TheMixer:PopMix("twister")

            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 0)

            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("vacuum_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "death",  
        tags = {"busy"},
        
        onenter = function(inst)
            TheMixer:PopMix("twister")
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end


                inst.AnimState:PlayAnimation("death")

        end,

        timeline =
        {
            TimeEvent(4*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_fly")
				inst.flame1:Remove()
				inst.flame2:Remove()
				inst.flame3:Remove()
            end),

            TimeEvent(40*FRAMES, function(inst)
                inst.components.inventory:DropEverything(true, true)
                inst.components.lootdropper:DropLoot()
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/seal_groundhit")
            end),

            TimeEvent(25*FRAMES, function(inst)
            end),

            TimeEvent(49*FRAMES, function(inst)


			local x, y, z = inst.Transform:GetWorldPosition()
			for i, v in ipairs(TheSim:FindEntities(x, 0, z, 35, nil, {}, {"deer_fire_circle"})) do
			v:Remove()
			end
			
			     local seal = SpawnPrefab("firetwister_seal")
                seal.Transform:SetPosition(inst:GetPosition():Get())
                seal.sg:GoToState("dizzy")
				
				if inst.entrada == nil then 
				local fx = SpawnPrefab("woodlegs_key1")
				if fx then fx.Transform:SetPosition(x, y, z) end
				inst.entrada = 1
				end

                inst:Remove()
            end),
        },
    },

----------------WALKING---------------

    State{
        name = "walk_start",
        tags = {"moving", "canrotate"},

        onenter = function(inst) 
            inst.AnimState:PlayAnimation("walk_pre")



                inst.AnimState:Hide("twister_water_fx")

        end,

        events =
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
        },
    },
        
    State{            
        name = "walk",
        tags = {"moving", "canrotate"},
        
        onenter = function(inst)
            inst.AnimState:PlayAnimation("walk_loop")
            inst.components.locomotor:WalkForward()


                inst.AnimState:Hide("twister_water_fx")
        end,

        timeline = 
        {
            TimeEvent(24*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/walk") end)
        },

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
        },
    },
    
    State{            
        name = "walk_stop",
        tags = {"canrotate"},

        onenter = function(inst) 
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("walk_pst")



                inst.AnimState:Hide("twister_water_fx")
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
    },

    State{
        name = "run_start",
        tags = {"moving", "running", "atk_pre", "canrotate"},

        onenter = function(inst)
            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 1)

            inst.CanCharge = false
            inst.components.locomotor:RunForward()
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/charge_roar")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/run_charge_up")


                inst.AnimState:Hide("twister_water_fx")


        end,

        events =
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("walk") end ),        
        },
    },

    State{
        name = "run",
        tags = {"moving", "running"},
        
        onenter = function(inst) 
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("charge_roar_loop")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/run_charge_up")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/twister/charge_roar")

                inst.AnimState:Hide("twister_water_fx")

        end,
       
        events=
        {   
            EventHandler("animover", function(inst) 
			inst.sg:GoToState("run") 
			end ),
        },
    },        
    
    State{
        name = "run_stop",
        tags = {"canrotate"},
        
        onenter = function(inst) 
            inst.SoundEmitter:SetParameter("wind_loop", "intensity", 0)

            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("charge_pst")

                inst.AnimState:Hide("twister_water_fx")


        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
    },
}

return StateGraph("twister", states, events, "idle", actionhandlers)