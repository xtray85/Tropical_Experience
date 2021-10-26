local PopupDialogScreen = require "screens/popupdialog"

local function quest1(inst)
local portalinvoca1 = SpawnPrefab("log")
local a, b, c = inst.Transform:GetWorldPosition()
portalinvoca1.Transform:SetPosition(a+1, b, c-1)

TheFrontEnd:PopScreen()
SetPause(false)
inst:Remove()
end

local function quest2(inst)
TheFrontEnd:PopScreen()
SetPause(false)
inst:Remove()
end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()

TheFrontEnd:PushScreen(PopupDialogScreen("Decision", "Can you help me?",
{{text="yes", cb = function() if TheWorld.ismastersim then quest1(inst) else SendModRPCToServer(MOD_RPC["volcanomod"]["quest1"], inst) end end},
{text="no", cb = function() if TheWorld.ismastersim then quest2(inst) else SendModRPCToServer(MOD_RPC["volcanomod"]["quest2"], inst) end end }}))	
		
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
--	inst.persists = false

    return inst
end
return Prefab("quest", fn)
