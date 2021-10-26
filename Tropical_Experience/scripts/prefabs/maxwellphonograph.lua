assets = 
{
	Asset("ANIM", "anim/phonograph.zip"),
	Asset("SOUND", "sound/maxwell.fsb"),
	Asset("SOUND", "sound/music.fsb"),
	Asset("SOUND", "sound/gramaphone.fsb")
}

local function play(inst)
	inst.components.machine.ison = true
	inst.AnimState:PlayAnimation("play_loop", true)
   	inst.SoundEmitter:PlaySound(inst.songToPlay, "ragtime")
   	if inst.components.playerprox then
   		inst:RemoveComponent("playerprox")
   	end	
end

local function stop(inst)
	inst.components.machine.ison = false	
	inst.AnimState:PlayAnimation("idle")
    inst.SoundEmitter:KillSound("ragtime")
    inst.SoundEmitter:PlaySound("dontstarve/music/gramaphone_end")
end

local function OnDropped(inst)
	inst.AnimState:PlayAnimation("idle")
    inst.SoundEmitter:KillSound("ragtime")
    inst.SoundEmitter:PlaySound("dontstarve/music/gramaphone_end")
    inst:PushEvent("turnedoff")
end

local function OnPutInInventory(inst)
	inst.AnimState:PlayAnimation("idle")
    inst.SoundEmitter:KillSound("ragtime")
    inst.SoundEmitter:PlaySound("dontstarve/music/gramaphone_end")
    inst:PushEvent("turnedoff")
end

local function fn()

		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
		local sound = inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()
	    MakeObstaclePhysics(inst, 0.1)
		anim:SetBank("phonograph")
		anim:SetBuild("phonograph")		
		anim:PlayAnimation("idle")
		MakeInventoryFloatable(inst)		

		inst.songToPlay = "dontstarve/maxwell/ragtime"

		inst:AddTag("maxwellphonograph")

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end		
		
		inst:AddComponent("inspectable")

		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
		inst.caminho = "images/inventoryimages/volcanoinventory.xml"	
		inst.components.inventoryitem.nobounce = true	
		inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
		inst.components.inventoryitem:SetOnDroppedFn(OnDropped)		
		
		inst:AddComponent("machine")
		inst.components.machine.turnonfn = play
		inst.components.machine.turnofffn = stop
		inst.components.machine.ison = false

		
		inst:AddComponent("playerprox")
		inst.components.playerprox:SetDist(55, 60)
		inst.components.playerprox:SetOnPlayerNear(function() inst.components.machine:TurnOn() end)
		inst.components.playerprox:SetOnPlayerFar(stop)

	return inst
end

return Prefab("common/objects/maxwellphonograph", fn, assets) 
