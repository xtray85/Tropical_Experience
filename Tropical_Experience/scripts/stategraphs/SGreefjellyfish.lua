require("stategraphs/commonstates")

local events=
{
    CommonHandlers.OnLocomote(true,true),
    CommonHandlers.OnSleep(),
    CommonHandlers.OnAttacked(true),
    CommonHandlers.OnDeath(),
}

local states=
{
    State
    {
        name = "idle",
        tags = {"idle", "canrotate", "canslide"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
			inst:DoTaskInTime(math.random(0,1), function(inst)
			local x, y, z = inst.Transform:GetWorldPosition()			
			local bubble = SpawnPrefab("bubble_fx_small")
			bubble.Transform:SetPosition(x, y+2, z)	
			end)			
        end,
    },  
    
    State{
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)                
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()            
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
			inst.components.shockaura:Enable(false)
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst)            
            inst.components.lootdropper:DropLoot(Vector3(inst.Transform:GetWorldPosition()))     
if TheWorld:HasTag("cave") then
local tamanhodomapa = (TheWorld.Map:GetSize())*2 - 2
local map = TheWorld.Map
local x
local z
local numerodeitens = 1

repeat
x = math.random(-tamanhodomapa,tamanhodomapa)
z = math.random(-tamanhodomapa,tamanhodomapa)
local curr = map:GetTile(map:GetTileCoordsAtPoint(x,0,z))
local curr1 = map:GetTile(map:GetTileCoordsAtPoint(x-4,0,z))
local curr2 = map:GetTile(map:GetTileCoordsAtPoint(x+4,0,z))
local curr3 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z-4))
local curr4 = map:GetTile(map:GetTileCoordsAtPoint(x,0,z+4))
-------------------coloca os itens------------------------
if (curr == GROUND.UNDERWATER_SANDY and curr1 == GROUND.UNDERWATER_SANDY and curr2 == GROUND.UNDERWATER_SANDY and curr3 == GROUND.UNDERWATER_SANDY and curr4 == GROUND.UNDERWATER_SANDY)
or (curr == GROUND.UNDERWATER_ROCKY and curr1 == GROUND.UNDERWATER_ROCKY and curr2 == GROUND.UNDERWATER_ROCKY and curr3 == GROUND.UNDERWATER_ROCKY and curr4 == GROUND.UNDERWATER_ROCKY)
or (curr == GROUND.BEACH and curr1 == GROUND.BEACH and curr2 == GROUND.BEACH and curr3 == GROUND.BEACH and curr4 == GROUND.BEACH)
or (curr == GROUND.MAGMAFIELD and curr1 == GROUND.MAGMAFIELD and curr2 == GROUND.MAGMAFIELD and curr3 == GROUND.MAGMAFIELD and curr4 == GROUND.MAGMAFIELD)
or (curr == GROUND.PAINTED and curr1 == GROUND.PAINTED and curr2 == GROUND.PAINTED and curr3 == GROUND.PAINTED and curr4 == GROUND.PAINTED)
or (curr == GROUND.BATTLEGROUND and curr1 == GROUND.BATTLEGROUND and curr2 == GROUND.BATTLEGROUND and curr3 == GROUND.BATTLEGROUND and curr4 == GROUND.BATTLEGROUND)
or (curr == GROUND.PEBBLEBEACH and curr1 == GROUND.PEBBLEBEACH and curr2 == GROUND.PEBBLEBEACH and curr3 == GROUND.PEBBLEBEACH and curr4 == GROUND.PEBBLEBEACH)

then 
local colocaitem = SpawnPrefab(inst.prefab) 
colocaitem.Transform:SetPosition(x, 0, z)
numerodeitens = numerodeitens - 1 end
-----------------------------------------------------------
until
numerodeitens <= 0
end			
        end,
        
    },
}

CommonStates.AddSleepStates(states)
CommonStates.AddWalkStates(states)
CommonStates.AddRunStates(states)
    
return StateGraph("reefjellyfish", states, events, "idle")