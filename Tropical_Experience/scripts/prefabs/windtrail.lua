local assets =
{
	Asset( "ANIM", "anim/action_lines.zip" ),
}

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    inst.entity:AddNetwork()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()
    
    anim:SetBuild("action_lines")
   	anim:SetBank( "action_lines" )
   	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
	--anim:SetLayer(LAYER_BACKGROUND )
	anim:SetSortOrder( 3 )
	anim:PlayAnimation( "idle_loop", false ) 

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )
	inst:AddTag( "vento" )	
	
	inst.entity:SetPristine()

     if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

    return inst
end

return Prefab( "common/fx/windtrail", fn, assets ) 
 
