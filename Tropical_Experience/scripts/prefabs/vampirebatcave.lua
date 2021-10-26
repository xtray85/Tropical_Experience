local assets =
{
    Asset("ANIM", "anim/vamp_bat_entrance.zip"),
}

local prefabs =
{
    "cave_fern",
}


local function onsave(inst, data)
    if inst:HasTag("spawned_cave") then
        data.spawned_cave = true
    end
end

local function onload(inst, data)
    if data and data.spawned_cave then
        inst:AddTag("spawned_cave")
    end
end


local function getlocationoutofcenter(dist,hole,random,invert)
    local pos =  (math.random()*((dist/2) - (hole/2))) + hole/2    
    if invert or (random and math.random()<0.5) then
        pos = pos *-1
    end
    return pos
end

--------------------------------------do teleporter------------------------
local function OnDoneTeleporting(inst, obj)
if obj and obj:HasTag("player") then
obj.mynetvarCameraMode:set(3)
end
end

local function StartTravelSound(inst, doer)
    inst.SoundEmitter:PlaySound("dontstarve/common/teleportworm/swallow")
    doer:PushEvent("wormholetravel", WORMHOLETYPE.WORM) --Event for playing local travel sound
end

local function OnActivateByOther(inst, source, doer)
--	if not inst.sg:HasStateTag("open") then
--		inst.sg:GoToState("opening")
--	end
	if doer ~= nil and doer.Physics ~= nil then
		doer.Physics:CollidesWith(COLLISION.WORLD)
	end
end

local function OnActivate(inst, doer)
    if doer:HasTag("player") then
        ProfileStatsSet("wormhole_used", true)
	doer.mynetvarCameraMode:set(1)
        local other = inst.components.teleporter.targetTeleporter
        if other ~= nil then
            DeleteCloseEntsWithTag("WORM_DANGER", other, 15)
        end

        --Sounds are triggered in player's stategraph
    elseif inst.SoundEmitter ~= nil then
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportworm/swallow")
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, .5)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "vamp_bat_cave.png" )

	anim:SetBank("vampbat_den")
	anim:SetBuild("vamp_bat_entrance")
	anim:PlayAnimation("idle")

    --inst:AddTag("structure")
    inst:AddTag("houndmound")
    inst:AddTag("batcave")
	inst:AddTag("hamletteleport")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("teleporter")
    inst.components.teleporter.onActivate = OnActivate
    inst.components.teleporter.onActivateByOther = OnActivateByOther
    inst.components.teleporter.offset = 0
	inst.components.teleporter.hamlet = true	
    inst:ListenForEvent("starttravelsound", StartTravelSound) -- triggered by player stategraph
    inst:ListenForEvent("doneteleporting", OnDoneTeleporting)	

    inst.OnSave = onsave 
    inst.OnLoad = onload

    ---------------------
    inst:AddComponent("inspectable")
	MakeSnowCovered(inst)
    
	return inst
end

return Prefab( "forest/monsters/vampirebatcave", fn, assets, prefabs ),
	   Prefab( "forest/monsters/vampirebatcave_entrance_roc", fn, assets, prefabs ) 