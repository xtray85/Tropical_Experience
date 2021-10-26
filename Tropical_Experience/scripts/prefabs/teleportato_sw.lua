local PopupDialogScreen = require "screens/popupdialog"

local assets = 
{
	Asset("ANIM", "anim/teleportato_shipwrecked.zip"),
	Asset("ANIM", "anim/teleportato_build.zip"),
	Asset("ANIM", "anim/teleportato_adventure_build.zip"),
}

local prefabs = {
	"ash",
}


local function TransitionToNextLevel(inst, wilson)

end

local function GetBodyText()
    return STRINGS.UI.TELEPORTBODY_SURVIVAL
end

local function OnActivate(inst, doer)

    if not inst.activatedonce then
        inst.activatedonce = true
        inst.AnimState:PlayAnimation("activate", false)
        inst.AnimState:PushAnimation("active_idle", true)
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activate", "teleportato_activate")
        inst.SoundEmitter:KillSound("teleportato_idle")
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activeidle_LP", "teleportato_active_idle")

        inst:DoTaskInTime(60*FRAMES, function()
            inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activate_mouth", "teleportato_activatemouth")

local portaentrada = SpawnPrefab("quagmire_goatkid")
local efeito = SpawnPrefab("lavaarena_creature_teleport_small_fx")
local a, b, c = inst.Transform:GetWorldPosition()
if efeito then
efeito.Transform:SetPosition(a, b, c)
end
if portaentrada then
portaentrada.Transform:SetPosition(a, b, c)
end

local pt = inst:GetPosition()
local procurainimigos = TheSim:FindEntities(pt.x, pt.y, pt.z, 100, {"recipientedosmobs"})
for k,achei in pairs(procurainimigos) do
if achei then
achei.max1 = nil
achei.max2 = nil
achei.max3 = nil
achei.max4 = nil
achei.max5 = nil 
end
end

--local outro = SpawnPrefab("teleportato_sw_base")
--if outro then
--outro.Transform:SetPosition(a, b, c)
--end

inst:Remove()
end)
end
end

local function GetStatus(inst)
    ProfileStatsSet("teleportato_inspected", true)
    local partsCount = 0
    for part,found in pairs(inst.collectedParts) do
        if found == true then
            partsCount = partsCount + 1
        end
    end

    if partsCount == 4 then
            return "ACTIVE"
    elseif partsCount > 0 then
        return "PARTIAL"
    end
end

local function ItemTradeTest(inst, item)
	if item:HasTag("teleportato_part") then
		return true
	end
	return false
end

local function PowerUp(inst)
    ProfileStatsSet("teleportato_powerup", true)
    inst.AnimState:PlayAnimation("power_on", false)
    inst.AnimState:PushAnimation("idle_on", true)

    inst.components.activatable.inactive = true

    inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_powerup", "teleportato_on")
    inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_idle_LP", "teleportato_idle")
 	
end

local partSymbols = {teleportato_sw_ring = "RING", teleportato_sw_crank = "CRANK", teleportato_sw_box = "BOX", teleportato_sw_potato = "POTATO" }

local function TestForPowerUp(inst)
    local allParts = true
    for part,found in pairs(inst.collectedParts) do
        if found == false then
            inst.AnimState:Hide(partSymbols[part])
            allParts = false
        else
            inst.AnimState:Show(partSymbols[part])
        end
    end
    if allParts == true then
        --this is a controller hack. It's... kinda gross
        inst.components.trader:Disable()
        local rodbase = TheSim:FindFirstEntityWithTag("rodbase")
        if rodbase and rodbase.components.lock and rodbase.components.lock:IsLocked() then
            rodbase:PushEvent("ready")
            inst:ListenForEvent("powerup", PowerUp)
        else
            inst:DoTaskInTime(0.5, PowerUp)
        end
    end
end

local function ItemGet(inst, giver, item)
	if inst.collectedParts[item.prefab] ~= nil then
		inst.collectedParts[item.prefab] = true
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_addpart", "teleportato_addpart")
		TestForPowerUp(inst)
	end
end

local function MakeComplete(inst)
--	print("Made Complete")
	inst.collectedParts = {teleportato_sw_ring = true, teleportato_sw_crank = true, teleportato_sw_box = true, teleportato_sw_potato = true }
end

local function OnLoad(inst, data)
	if data then
		if data.makecomplete == 1 then
--			print("has make complete data")
			MakeComplete(inst)
			TestForPowerUp(inst)
		end
	    if data.collectedParts then
		    inst.collectedParts = data.collectedParts
		    TestForPowerUp(inst)
		end
		inst.activatedonce = data.activatedonce
		
		inst.action = data.action
		inst.maxwell = data.maxwell
		if data.teleportposx and data.teleportposz then
		    inst.teleportpos = Vector3(data.teleportposx, 0, data.teleportposz)
		end
	end
end

local function OnPlayerFar(inst)
	if inst.activatedonce then
        inst.AnimState:PlayAnimation("activate", false)
        inst.AnimState:PushAnimation("active_idle", true)
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activate", "teleportato_activate")
        inst.SoundEmitter:KillSound("teleportato_idle")
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activeidle_LP", "teleportato_active_idle")

        inst:DoTaskInTime(40*FRAMES, function()
        inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_activate_mouth", "teleportato_activatemouth")
     end)
	 end
end

local function ItemTest(inst, item, slot)
	return not item:HasTag("nonpotatable")
end

local function OnSave(inst, data)
	data.collectedParts = inst.collectedParts
	data.action = inst.action
	data.maxwell = inst.maxwell
	data.activatedonce = inst.activatedonce
	if inst.teleportpos then
	    data.teleportposx = inst.teleportpos.x
	    data.teleportposz = inst.teleportpos.z
	end
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	anim:SetBank("teleporter")
	anim:SetBuild("teleportato_shipwrecked")
	
	inst:AddTag("teleportato")
	
	anim:PlayAnimation("idle_off", true)

	MakeObstaclePhysics(inst, 1.1)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetPriority( 5 )
	minimap:SetIcon("teleportato_sw_base.png")
	minimap:SetPriority( 1 )
	
	inst.entity:AddSoundEmitter()
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
--		inst.OnEntityReplicated = function(inst) 
--		inst.replica.container:WidgetSetup("teleportato_base") 
--		end	
        return inst
    end
	
	inst:AddComponent("inspectable")	
	inst.components.inspectable.getstatus = GetStatus
	inst.components.inspectable:RecordViews()
	
	inst:AddComponent("activatable")	
	inst.components.activatable.OnActivate = OnActivate
	inst.components.activatable.inactive = false
	inst.components.activatable.quickaction = true

--    inst:AddComponent("container")
--    inst.components.container:WidgetSetup("teleportato_base")
--    inst.components.container.canbeopened = false

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(6,8)
    inst.components.playerprox:SetOnPlayerNear(OnPlayerFar)

	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(ItemTradeTest)
	inst.components.trader.onaccept = ItemGet

	-- The "construction" requires a list of parts to have been added
	inst.collectedParts = {teleportato_sw_ring = false, teleportato_sw_crank = false, teleportato_sw_box = false, teleportato_sw_potato = false }
	for part,symbol in pairs(partSymbols) do
		inst.AnimState:Hide(symbol)
	end
	
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	
	return inst
end

return Prefab( "common/objects/teleportato_sw_base", fn, assets, prefabs ) 

