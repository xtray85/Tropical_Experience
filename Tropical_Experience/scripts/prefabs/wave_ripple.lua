local waveassets =
{
	Asset( "ANIM", "anim/waverripple.zip" ),
}

local rogueassets = 
{
    Asset( "ANIM", "anim/wave_rogue.zip" ),
}

local	    WAVE_HIT_MOISTURE = 15
local	    WAVE_HIT_DAMAGE = 5

local	    ROGUEWAVE_HIT_MOISTURE = 25
local	    ROGUEWAVE_HIT_DAMAGE = 10
local	    ROGUEWAVE_SPEED_MULTIPLIER = 3
local	    WAVE_BOOST_ANGLE_THRESHOLD = 90
local 		BONUSDAONDA = 1.5
local		TEMPODOBONUS = 2


local SPLASH_WETNESS = 9

local function splash(inst)
    local wave_splash = SpawnPrefab("wave_splash")
    local pos = inst:GetPosition()
    TintByOceanTile(wave_splash)
    wave_splash.Transform:SetPosition(pos.x, pos.y, pos.z)

    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, 4)
    for _, v in pairs(ents) do
        local moisture = v.components.moisture
        if moisture ~= nil then
            local waterproofness = (v.components.inventory and math.min(v.components.inventory:GetWaterproofness(), 1)) or 0
            moisture:DoDelta(SPLASH_WETNESS * (1 - waterproofness))

            local entity_splash = SpawnPrefab("splash")
            entity_splash.Transform:SetPosition(v:GetPosition():Get())
        end
    end

    inst:Remove()
end 

local function splash2(inst)
    local wave_splash = SpawnPrefab("splash_water")
    local pos = inst:GetPosition()
    TintByOceanTile(wave_splash)
    wave_splash.Transform:SetPosition(pos.x, pos.y, pos.z)

    inst:Remove()
end 

local function oncollidewave(inst)
local jogador = GetClosestInstWithTag("player", inst, 2)
local barril = GetClosestInstWithTag("redbarrel", inst, 2) if barril then barril.components.workable:WorkedBy(barril, 1) splash(inst) end
local outros = GetClosestInstWithTag("quebraonda", inst, 2) if outros then splash(inst) end

local boostThreshold = WAVE_BOOST_ANGLE_THRESHOLD

if jogador then --------------------------------------------xxxxxxx

local moving = jogador.sg:HasStateTag("moving") 
local playerAngle =  jogador.Transform:GetRotation()
if playerAngle < 0 then playerAngle = playerAngle + 360 end 
local waveAngle = inst.Transform:GetRotation()
if waveAngle < 0 then waveAngle = waveAngle + 360 end 
local angleDiff = math.abs(waveAngle - playerAngle)
if angleDiff > 360 then angleDiff = angleDiff - 360 end 
 

----------------esta no mesmo sentido---------------------------------xxxxxx
if angleDiff < boostThreshold and moving then
-------determina a velocidade-------------------------
if jogador.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) and jogador.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) == "surfboard" then
BONUSDAONDA = 2
TEMPODOBONUS = 3
else
TEMPODOBONUS = 2
BONUSDAONDA = 1.5
end
------------------------------------------						
if jogador and jogador.components.locomotor and not jogador:HasTag("turbinado") then 
jogador:AddTag("turbinado")
if jogador.prefab == "walani" then  jogador.components.sanity:DoDelta(TUNING.SANITY_SUPERTINY) end

local speed = jogador.components.locomotor.runspeed
jogador.components.locomotor.runspeed = jogador.components.locomotor.runspeed * BONUSDAONDA
jogador:DoTaskInTime(TEMPODOBONUS,function()
jogador:RemoveTag("turbinado")	
jogador.components.locomotor.runspeed = speed
end)
end

inst.SoundEmitter:PlaySound( "dontstarve_DLC002/common/wave_boost")
splash2(inst)

else

if jogador then 
local gastabarco = jogador.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
if gastabarco then
jogador.components.driver.vehicle.components.finiteuses:Use(10)
end	
end		
inst.SoundEmitter:PlaySound( "dontstarve_DLC002/common/wave_break")
splash(inst)	
end 



end
end 


local function oncolliderogue(inst, other)
local jogador = GetClosestInstWithTag("player", inst, 2)
local barril = GetClosestInstWithTag("redbarrel", inst, 2) if barril then barril.components.workable:WorkedBy(barril, 1) splash(inst) end

local boostThreshold = WAVE_BOOST_ANGLE_THRESHOLD

if jogador then --------------------------------------------xxxxxxx

local moving = jogador.sg:HasStateTag("moving") 
local playerAngle =  jogador.Transform:GetRotation()
if playerAngle < 0 then playerAngle = playerAngle + 360 end 
local waveAngle = inst.Transform:GetRotation()
if waveAngle < 0 then waveAngle = waveAngle + 360 end 
local angleDiff = math.abs(waveAngle - playerAngle)
if angleDiff > 360 then angleDiff = angleDiff - 360 end 
 

----------------esta no mesmo sentido---------------------------------xxxxxx
if angleDiff < boostThreshold and moving and jogador and jogador.prefab == "walani" then
-------determina a velocidade-------------------------
if jogador.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) and jogador.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) == "surfboard" then
TEMPODOBONUS = 4.5
BONUSDAONDA = 3
else
TEMPODOBONUS = 3
BONUSDAONDA = 2.25
end
------------------------------------------						
if jogador and jogador.components.locomotor and not jogador:HasTag("turbinado") then 
jogador:AddTag("turbinado")
if jogador.prefab == "walani" then  jogador.components.sanity:DoDelta(TUNING.SANITY_SUPERTINY * 1.5) end

local speed = jogador.components.locomotor.runspeed
jogador.components.locomotor.runspeed = jogador.components.locomotor.runspeed * BONUSDAONDA
jogador:DoTaskInTime(TEMPODOBONUS,function()
jogador:RemoveTag("turbinado")	
jogador.components.locomotor.runspeed = speed
end)
end

inst.SoundEmitter:PlaySound( "dontstarve_DLC002/common/wave_boost")
splash2(inst)

else

if jogador then 
local gastabarco = jogador.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
if gastabarco then
jogador.components.driver.vehicle.components.finiteuses:Use(20)
end	
end		
inst.SoundEmitter:PlaySound( "dontstarve_DLC002/common/wave_break")
splash(inst)	
end 

end
end 

local function CheckGround(inst, dt)
--Check if I'm about to hit land
local x, y, z = inst.Transform:GetWorldPosition()
local vx, vy, vz = inst.Physics:GetVelocity()

local plataforma = GetClosestInstWithTag("walkableplatform", inst, 6)
local ancora = GetClosestInstWithTag("anchor_lowered", inst, 9)


if plataforma then
if not ancora then
local speed_modifier = VecUtil_Length(vx, vz)
vx,vz = VecUtil_Normalize(vx,vz)
if plataforma.components.boatphysics then
local boat_physics = plataforma.components.boatphysics
boat_physics:ApplyForce(vx, vz, speed_modifier)
end
end
splash(inst)
end


local ground = TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(x, y, z))
if ground == GROUND.INVALID or ground == GROUND.IMPASSABLE then
splash(inst)
end

if TheWorld.Map:IsVisualGroundAtPoint(x + vx, y, z + vz) then
splash(inst)
end
end 

local function onsave(inst, data)
    if inst and data then
        data.speed = inst.Physics:GetMotorSpeed()
        data.angle = inst.Transform:GetRotation()
        if inst.sg and inst.sg.currentstate and inst.sg.currentstate.name then
            data.state = inst.sg.currentstate.name
        end
    end
end

local function onload(inst, data)
    if inst and data then
        inst.Transform:SetRotation(data.angle or 0)
        inst.Physics:SetMotorVel(data.speed or 0, 0, 0)
        if inst.sg and data.state then
            inst.sg:GoToState(data.state)
        end
    end
end

local function activate_collision(inst)
    inst.Physics:SetCollides(false) --Still will get collision callback, just not dynamic collisions.
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
end

local function onRemove(inst)
    if inst and inst.soundloop then
        inst.SoundEmitter:KillSound(inst.soundloop)
    end
end

local function onSleep(inst)
    inst:Remove()
end

local function ripple(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    trans:SetFourFaced()
    inst.entity:AddPhysics()
    inst.Physics:SetSphere(1)
    inst.Physics:ClearCollisionMask()
    inst.OnEntitySleep = onSleep    
    inst.done = false
    local anim = inst.entity:AddAnimState()
    inst.AnimState:SetBuild("waverripple")
    inst.AnimState:SetBank("wave_ripple_sw")

    inst:AddTag( "FX" )
	inst:AddTag("aquatic")
	inst:AddTag("ondamedia")
	
    inst.entity:SetPristine()
  
    if not TheWorld.ismastersim then
        return inst
    end	
	 
    inst.hitdamage = -WAVE_HIT_DAMAGE
    inst.hitmoisture = WAVE_HIT_MOISTURE
    inst:SetStateGraph("SGwavesw")
    inst.soundrise = "small"
    inst.activate_collision = activate_collision
	
	inst:DoPeriodicTask(0.5, CheckGround)
	inst:DoTaskInTime(1.5, function(inst) inst:DoPeriodicTask(0.1, oncollidewave) end)
	 
    inst.OnSave = onsave
    inst.OnLoad = onload
	
    return inst
end 

local function rogue(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    trans:SetFourFaced()
    inst.entity:AddPhysics()
    inst.Physics:SetSphere(1)
    inst.Physics:ClearCollisionMask() 
    inst.done = false
    local anim = inst.entity:AddAnimState()
    anim:SetBuild("wave_rogue" )
    anim:SetBank( "wave_rogue" )
	
	inst:AddTag("aquatic")
    inst:AddTag( "FX" )
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst.hitdamage = -ROGUEWAVE_HIT_DAMAGE
    inst.hitmoisture = ROGUEWAVE_HIT_MOISTURE

    inst:SetStateGraph("SGwavesw")

    inst.idle_time = 1
    
    inst.soundrise = "large"
    inst.soundloop = "large_LP"
    inst.soundtidal = "tidal_wave"

    inst.activate_collision = activate_collision
    inst:ListenForEvent("onremove", onRemove)
		
	inst:DoPeriodicTask(0.5, CheckGround)
	inst:DoPeriodicTask(0.1, oncolliderogue)	
	
    inst.OnEntitySleep = onSleep   

	inst.OnSave = onsave
    inst.OnLoad = onload
	
    return inst
end

return Prefab( "common/fx/wave_ripple", ripple, waveassets ), 
       Prefab( "common/fx/rogue_wave", rogue, rogueassets )
