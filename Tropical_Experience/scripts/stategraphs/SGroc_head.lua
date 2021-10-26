require("stategraphs/commonstates")

local actionhandlers = 
{
   -- ActionHandler(ACTIONS.GOHOME, "action"),
}

SHAKE_DIST = 40

local events =
{
    EventHandler("enter", function(inst) inst.sg:GoToState("enter") end),
    EventHandler("exit", function(inst) inst.sg:GoToState("exit") end),    
    EventHandler("bash", function(inst) inst.sg:GoToState("bash") end),     
    EventHandler("gobble", function(inst) inst.sg:GoToState("grab") end), 
    EventHandler("taunt", function(inst) inst.sg:GoToState("taunt") end), 
}

local function DoStep(inst)
--local player = GetClosestInstWithTag("player", inst, SHAKE_DIST)
--if player then
--player:ShakeCamera(CAMERASHAKE.SIDE, 2, .06, .25)
--end
inst.components.groundpounder:GroundPound()
inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/glommer/foot_ground")
TheWorld:PushEvent("bigfootstep")
end

local function oncameraarrive(inst, doer)
    if doer:IsValid() then
        doer:SnapCamera()
        doer:ScreenFade(true, 2)
    end
	doer.sg:GoToState("wakeup")
end

local function DoGrab(inst)                                      
    local controller = inst.controller

    if controller.target and controller.target:HasTag("isinventoryitem") then
        controller:EatSomething(controller.target)   
    elseif controller.target:HasTag("player") then  
        local dist = inst:GetDistanceSqToInst(controller.target) 
        if dist < 2 then

		
controller.target.components.combat:GetAttacked(inst, 50, nil, nil)		
		
		
		
for k,v in pairs(Ents) do
if v.prefab == "roc_nest" then
local target_x, target_y, target_z = v.Transform:GetWorldPosition()


        if controller.target.Physics ~= nil then
            controller.target.Physics:Teleport(target_x, target_y, target_z)
        elseif controller.target.Transform ~= nil then
            controller.target.Transform:SetPosition(target_x, target_y, target_z)
        end		

		controller.target:ScreenFade(false)
		inst:DoTaskInTime(3, oncameraarrive, controller.target)
end
end

--            controller:playergrabbed()
--            inst.triggerliftoff = true
        end        
    end
    controller.target = nil
end

local states =
{
    State
    {
        name = "idle",
        tags = {"idle" },

        onenter = function(inst,pushanim)
            if pushanim then
                inst.AnimState:PlayAnimation(pushanim)           
                inst.AnimState:PushAnimation("idle_loop")           
            else
                inst.AnimState:PlayAnimation("idle_loop")           
            end
        end,
        
        events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("idle")
            end),
        }
    },

    State
    {
        name = "bash",
        tags = {"busy" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("bash_pre")           
            inst.AnimState:PushAnimation("bash_loop",false)           
            inst.AnimState:PushAnimation("bash_pst",false)           
        end,
        

        timeline =
        {
            TimeEvent(37*FRAMES, function(inst) 
                inst.components.groundpounder:GroundPound()

                local player = GetClosestInstWithTag("player", inst, SHAKE_DIST)
                if player then
--					player:ShakeCamera(CAMERASHAKE.SIDE, 2, .06, .25)
--player.components.playercontroller:ShakeCamera(inst, "VERTICAL", 0.5, 0.03, 2, SHAKE_DIST)
                end
            end)
        },

        events =
        {
            EventHandler("animqueueover", function(inst, data)
                inst.sg:GoToState("idle")
            end),
        }
    },


    State
    {
        name = "grab",
        tags = {"busy" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("grab_pre")           
            inst.AnimState:PushAnimation("grab_loop",false)           
            inst.AnimState:PushAnimation("grab_pst",false)           
        end,
        
        timeline =
        {
            TimeEvent(14*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/roc/attack_3") end),
            TimeEvent(25*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/roc/attack_2") end),
            TimeEvent(29*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/roc/attack_1") end),
            TimeEvent(31*FRAMES, function(inst) 
                DoGrab(inst)
            end)
        },

        onexit = function(inst)
            if inst.triggerliftoff then           
                inst.triggerliftoff = nil
                inst.body:PushEvent("liftoff")           
            end
--            if inst:HasTag("HasPlayer") then
--                inst.controller:UnchildPlayer(inst)
--            end
        end,

        events =
        {
            EventHandler("animqueueover", function(inst, data)
                inst.sg:GoToState("idle")
            end),
        }
    },

    State
    {
        name = "enter",
        tags = {"idle","canrotate","busy"},

        onenter = function(inst)    
            inst.AnimState:PlayAnimation("idle_pre")
        end,
    
        events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("taunt")
            end),
        }
    },

    State
    {
        name = "taunt",
        tags = {"idle","canrotate","busy"},

        onenter = function(inst)    
            inst.AnimState:PlayAnimation("taunt")
        end,
        
        timeline=
        {
            TimeEvent(14*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/roc/attack_3") end),
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/roc/attack_2") end),
            TimeEvent(24*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/boss/roc/attack_1") end),
        },
        
        events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("idle")
            end),
        }
    },    

    State
    {
        name = "exit",
        tags = {"idle","canrotate"},

        onenter = function(inst)    
            inst.AnimState:PlayAnimation("idle_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst, data)
                print("REMOVING ROCK HEAD")            
                inst:Remove()
            end),
        }
    },        
}

return StateGraph("roc_head", states, events, "idle", actionhandlers)

