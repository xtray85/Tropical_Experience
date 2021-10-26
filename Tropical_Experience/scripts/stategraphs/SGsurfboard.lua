local events =
{

}

local function SpawnFragment(lp, prefix, offset_x, offset_y, offset_z, ignite)
    local fragment = SpawnPrefab(prefix)
	fragment.Transform:SetScale(0.4, 0.4, 0.4)
    fragment.Transform:SetPosition(lp.x + offset_x, lp.y + offset_y, lp.z + offset_z)

    if offset_y > 0 then
        local physics = fragment.Physics
        if physics ~= nil then
            physics:SetVel(0, -0.25, 0)
        end
    end

	if ignite then
		fragment.components.burnable:Ignite()
	end

	return fragment
end

local states =
{
    State
    {
        name = "place",
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("turnoftides/common/together/boat/place")
            inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/large",nil,.3)
            inst.AnimState:PlayAnimation("run_loop")
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State
    {
        name = "idle",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("run_loop", true)
			
			local x, y, z = inst.Physics:GetVelocity()
			
			if x > 0 and z > 0 then
            if inst.barco then
			inst.barco.Transform:SetRotation(0)
--			inst.barco.Transform:SetPosition(0, -1, 0)				
--			inst.barco.AnimState:SetBank("wilson")
--			inst.barco.AnimState:AddOverrideBuild("player_actions_paddle")
--			inst.barco.AnimState:PlayAnimation("sail_loop", true)						
			
			end
			end			
			
			if x > 0 and z < 0 then
            if inst.barco then			
            inst.barco.Transform:SetRotation(90)	
--			inst.barco.Transform:SetPosition(0, 0, 0)
--			inst.barco.AnimState:SetBank("wilson")
--			inst.barco.AnimState:AddOverrideBuild("player_actions_paddle")
--			inst.barco.AnimState:PlayAnimation("sail_loop", true)					
			end
			end

			if x < 0 and z < 0 then
            if inst.barco then			
            inst.barco.Transform:SetRotation(180)	
--			inst.barco.Transform:SetPosition(0, -1, 0)				
--			inst.barco.AnimState:SetBank("wilson")
--			inst.barco.AnimState:AddOverrideBuild("player_actions_paddle")
--			inst.barco.AnimState:PlayAnimation("sail_loop", true)					
			end			
			end

			if x < 0 and z > 0 then
            if inst.barco then			
            inst.barco.Transform:SetRotation(270)	
--			inst.barco.Transform:SetPosition(0, 0, 0)				
--			inst.barco.AnimState:SetBank("wilson")
--			inst.barco.AnimState:AddOverrideBuild("player_actions_paddle")
--			inst.barco.AnimState:PlayAnimation("sail_loop", true)					
			end
			end			
			
--			if x == 0 and z == 0 then
--            if inst.barco then			
--			inst.AnimState:SetBank("rowboat")
--			inst.AnimState:PlayAnimation("run_loop", true)								
--			end
--			end				
		
        end,

        events =
        {
			EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("death", function(inst) inst.sg:GoToState("ready_to_snap") end),
        },
    },

    State
    {
        name = "ready_to_snap",
        onenter = function(inst)
            inst.sg:SetTimeout(0.75)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("snapping")
        end,
    },


    State
    {
        name = "snapping",
        onenter = function(inst)
            local fx_boat_crackle = SpawnPrefab("fx_boat_crackle")
            fx_boat_crackle.Transform:SetPosition(inst.Transform:GetWorldPosition())
			fx_boat_crackle.Transform:SetScale(0.4, 0.4, 0.4)
            inst.AnimState:PlayAnimation("run_loop") 
            inst.sg:SetTimeout(1)

            for k in pairs(inst.components.walkableplatform:GetPlayersOnPlatform()) do
                k:PushEvent("onpresink")
            end
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("popping") end),
        },

        timeline =
        {
            TimeEvent(0 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/creak")
            end),
            TimeEvent(2 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .1})
            end),
            TimeEvent(17 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .2})
            end),
            TimeEvent(32* FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .3})
            end),
            TimeEvent(39* FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .3})
            end),
            TimeEvent(39* FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/creak")
            end),
            TimeEvent(51 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .4})
            end),
            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .4})
            end),
            TimeEvent(60 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .5})
            end),
            TimeEvent(71 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage",{intensity= .5})
            end),
            TimeEvent(75 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage", {intensity= .6})
            end),
            TimeEvent(82 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage", {intensity= .6})
            end),
        },
    },

    State
    {
        name = "popping",
        onenter = function(inst)
            local fx_boat_crackle = SpawnPrefab("fx_boat_pop")
			fx_boat_crackle.Transform:SetScale(0.4, 0.4, 0.4)
            fx_boat_crackle.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/damage", {intensity= 1})
            inst.SoundEmitter:PlaySoundWithParams("turnoftides/common/together/boat/sink")

            local ignitefragments = inst.activefires > 0
            local locus_point = Vector3(inst.Transform:GetWorldPosition())

            inst:Remove()
            local radius=inst.components.walkableplatform.radius
            for i=1,radius^2/4 do
                SpawnFragment(locus_point, "boards",  math.random()*radius-radius/2,  0, math.random()*radius-radius/2, ignitefragments)
            end
        end,
    },
}

return StateGraph("Sgsurfboard", states, events, "idle")
