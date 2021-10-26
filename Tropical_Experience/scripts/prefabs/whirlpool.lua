local assets =
{
    Asset("ANIM", "anim/whirlpool.zip"),
}

local function onsave(inst, data)
	
end

local function onload(inst, data)

end

local function Dissipate(inst)
if TheWorld.state.isday or TheWorld.state.isdusk then
inst:Remove()
end
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddNetwork()		
	inst.entity:AddTransform()
	
	inst.entity:AddAnimState() 
	inst.AnimState:SetBank("whirlpool")
	inst.AnimState:SetBuild("whirlpool")
	inst.AnimState:PlayAnimation("idle_loop", true)

--	open_pre
--	open_loop
--	open_pst
	
	inst:AddTag("whirlpool")
	inst:AddTag("ignorewalkableplatforms")	
	inst.AnimState:SetLayer(LAYER_BACKGROUND)	
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	
	
    inst:AddComponent("whirlpool")
    inst.components.whirlpool:TurnOn()
    inst.components.whirlpool.playerwhirlpooldamage = 1
    inst.components.whirlpool.playerwhirlpoolsanityhit = 1
    inst.components.whirlpool.whirlpoolradius = 15
    inst.components.whirlpool.playerwhirlpoolradius = 15
	
    inst:AddComponent("inventory")	
	
	inst:WatchWorldState("stopday", Dissipate)
	inst:WatchWorldState("startday", Dissipate)	
	
	
    inst.OnSave = onsave 
    inst.OnLoad = onload 
    
    return inst
end

return Prefab( "underwater/objects/whirlpool", fn, assets) 
