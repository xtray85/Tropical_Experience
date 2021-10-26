local assets =
{
	Asset( "ANIM", "anim/splash_water.zip" ),
	Asset( "ANIM", "anim/splash_water_big.zip" ),
	Asset( "ANIM", "anim/splash_water_drop.zip" ),
	Asset( "ANIM", "anim/water_bombsplash.zip" ),
	Asset( "ANIM", "anim/ground_chunks_breaking.zip" ),
	Asset( "ANIM", "anim/boat_hit_debris.zip" ),
}

local function fnsplash_water(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()

    anim:SetBuild("splash_water")
   	anim:SetBank( "splash_water" )
--   	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
--	anim:SetLayer(LAYER_BACKGROUND )
--	anim:SetSortOrder( 3 )
	anim:PlayAnimation( "idle" ) 
	    inst.entity:AddNetwork()

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)

    return inst
end

local function fnsplash_water_drop(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()

    anim:SetBuild("splash_water_drop")
   	anim:SetBank( "splash_water_drop" )
--   	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
--	anim:SetLayer(LAYER_BACKGROUND )
--	anim:SetSortOrder( 3 )
	anim:PlayAnimation( "idle" ) 
	    inst.entity:AddNetwork()

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)

    return inst
end


local function fnsplash_water_sink(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()

    anim:SetBuild("splash_water_drop")
   	anim:SetBank( "splash_water_drop" )
--   	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
--	anim:SetLayer(LAYER_BACKGROUND )
--	anim:SetSortOrder( 3 )
	anim:PlayAnimation( "idle_sink" ) 
	    inst.entity:AddNetwork()

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)

    return inst
end

local function fnsplash_water_big(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()

    anim:SetBuild("splash_water_big")
   	anim:SetBank( "splash_water_big" )
--   	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
--	anim:SetLayer(LAYER_BACKGROUND )
--	anim:SetSortOrder( 3 )
	anim:PlayAnimation( "idle" ) 
	    inst.entity:AddNetwork()

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)

    return inst
end

local function fncoconut_chunks(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()

    anim:SetBuild("ground_chunks_breaking")
   	anim:SetBank( "ground_breaking" )
--   	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
--	anim:SetLayer(LAYER_BACKGROUND )
--	anim:SetSortOrder( 3 )
	anim:PlayAnimation( "idle" ) 
	    inst.entity:AddNetwork()

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)
	
--		sound = "dontstarve_DLC002/creatures/palm_tree_guard/coconut_explode",
--	    tint = Vector3(183/255,143/255,85/255),

    return inst
end

local function fnbombsplash(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()

    anim:SetBuild("water_bombsplash")
   	anim:SetBank( "bombsplash" )
--   	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
--	anim:SetLayer(LAYER_BACKGROUND )
--	anim:SetSortOrder( 3 )
	anim:PlayAnimation( "splash" ) 
	    inst.entity:AddNetwork()

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)
	
    return inst
end

local function fnboat_hit_fx(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	--trans:SetFourFaced()

    local anim = inst.entity:AddAnimState()

    anim:SetBuild("boat_hit_debris")
   	anim:SetBank( "boat_hit_debris" )
	anim:PlayAnimation( "hit_raft_quackeringram" ) 
	    inst.entity:AddNetwork()

	--inst:Hide()
	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:ListenForEvent( "animover", function(inst) inst:Remove() end )

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({0,0,0,0}, FRAMES*20)
	
    return inst
end

local function fnpenaagua(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()

    anim:SetBuild("ripple_build")
   	anim:SetBank( "bamboo" )
	anim:PlayAnimation( "idle_water", true)
	inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
--	inst.AnimState:SetLayer(LAYER_WORLD)
	
	inst.entity:AddNetwork()
	inst.persists = false

	inst:AddTag( "FX" )
	inst:AddTag( "NOCLICK" )
	inst:AddTag( "aguapraapagar")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    return inst
end

return Prefab( "splash_water", fnsplash_water, assets ),
Prefab( "splash_water_drop", fnsplash_water_drop, assets ),
Prefab( "splash_water_big", fnsplash_water_big, assets ),
Prefab( "splash_water_sink", fnsplash_water_sink, assets ),
Prefab( "coconut_chunks", fncoconut_chunks, assets ),
Prefab( "boat_hit_fx_quackeringram", fnboat_hit_fx, assets ),
Prefab( "bombsplash", fnbombsplash, assets ),
Prefab( "penaagua", fnpenaagua, assets )
