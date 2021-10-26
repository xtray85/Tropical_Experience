local assets =
{
	Asset("ANIM", "anim/rugs.zip"),
	Asset("ANIM", "anim/interior_wall_decals_mayorsoffice.zip"),
	Asset("ANIM", "anim/interior_wall_decals_palace.zip"),
}

local prefabs =
{
}

local function smash(inst)
    if inst.components.lootdropper then
            inst.components.lootdropper:DropLoot()
    end
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    if inst.SoundEmitter then
        inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    end

    inst:Remove()	
end    

local function setPlayerUncraftable(inst)
	inst:RemoveTag("NOCLICK")
    inst.entity:AddSoundEmitter()

    inst:AddComponent("lootdropper")
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(
        function(inst, worker, workleft)
            if workleft <= 0 then
                smash(inst)
            end
        end)
end

local function onsave(inst, data)
	data.rotation = inst.Transform:GetRotation()
    if inst.onbuilt then
        data.onbuilt = inst.onbuilt
    end	
end	

local function onload(inst, data)
	if data.rotation then
		inst.Transform:SetRotation(data.rotation)
	end
    if data.onbuilt then
        setPlayerUncraftable(inst)
        inst.onbuilt = data.onbuilt
    end	
end

local function onBuilt(inst)
    setPlayerUncraftable(inst)
    inst.onbuilt = true         
end


local function commonfn(rugtype)
	local inst = CreateEntity()
	inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    anim:SetBuild("rugs")
    anim:SetBank("rugs")
    anim:PlayAnimation(rugtype, true)
	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
	anim:SetLayer( LAYER_BACKGROUND )
	anim:SetSortOrder( 3 )

	inst:AddTag("OnFloor")
	inst:AddTag("NOCLICK")
	inst:AddTag("NOBLOCK")

    inst:ListenForEvent( "onbuilt", function()
        onBuilt(inst)
    end)        

	inst.OnSave = onsave 
    inst.OnLoad = onload

	return inst
end

local function round()
	local inst = commonfn("rug_round")
	return inst
end	

local function oval()
	local inst = commonfn("rug_oval")
	return inst
end	

local function square()
	local inst = commonfn("rug_square")
	return inst
end	

local function rectangle()
	local inst = commonfn("rug_rectangle")
	return inst
end

local function leather()
	local inst = commonfn("rug_leather")
	return inst
end	

local function fur()
	local inst = commonfn("rug_fur")
	return inst
end	

local function circle()
	local inst = commonfn("half_circle")
	return inst
end

local function hedgehog()
	local inst = commonfn("rug_hedgehog")
	return inst
end	


local function twosided(name)
	local inst = CreateEntity()
	inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

	inst.Transform:SetTwoFaced()

    anim:SetBuild("rugs")
    anim:SetBank("rugs")
    anim:PlayAnimation(name)
	anim:SetLayer( LAYER_BACKGROUND )
	anim:SetSortOrder( 3 )

	inst:AddTag("OnFloor")
	inst:AddTag("NOCLICK")

	inst.OnSave = onsave 
    inst.OnLoad = onload

    
    inst:ListenForEvent( "onbuilt", function()
        onBuilt(inst)
    end)       

	return inst
end

local function porcupus()
	local inst = twosided("rug_porcupuss")
	return inst
end	

local function hoofprint()
	local inst = commonfn("rug_hoofprints")
	return inst
end

local function octagon()
	local inst = commonfn("rug_octagon")
	return inst
end

local function swirl()
	local inst = commonfn("rug_swirl")
	return inst
end

local function catcoon()
	local inst = commonfn("rug_catcoon")
	return inst
end

local function rubbermat()
	local inst = commonfn("rug_rubbermat")
	return inst
end

local function web()
	local inst = commonfn("rug_web")
	return inst
end

local function metal()
	local inst = commonfn("rug_metal")
	return inst
end

local function wormhole()
	local inst = commonfn("rug_wormhole")
	return inst
end

local function braid()
	local inst = commonfn("rug_braid")
	return inst
end

local function beard()
	local inst = commonfn("rug_beard")
	return inst
end

local function nailbed()
	local inst = twosided("rug_nailbed")
	return inst
end

local function crime()
	local inst = commonfn("rug_crime")
	return inst
end

local function tiles()
	local inst = commonfn("rug_tiles")
	return inst
end

local function palace_runner()
	local inst = commonfn("rug_throneroom")
	return inst
end	

local function cityhall_corners()
	local inst = CreateEntity()
	inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    anim:SetBuild("interior_wall_decals_mayorsoffice")
    anim:SetBank("wall_decals_mayorsoffice")
    anim:PlayAnimation("corner_back", true)
	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
	anim:SetLayer( LAYER_BACKGROUND )
	anim:SetSortOrder( 3 )

	inst:AddTag("NOCLICK")

	inst.OnSave = onsave 
    inst.OnLoad = onload

	return inst
end

local function palace_corners()
	local inst = CreateEntity()
	inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()

    anim:SetBuild("interior_wall_decals_palace")
    anim:SetBank("wall_decals_palace")
    anim:PlayAnimation("floortrim_corner", true)
	anim:SetOrientation( ANIM_ORIENTATION.OnGround )
	anim:SetLayer( LAYER_BACKGROUND )
	anim:SetSortOrder( 3 )

	inst:AddTag("NOCLICK")

	inst.OnSave = onsave 
    inst.OnLoad = onload

	return inst
end

return Prefab("marsh/objects/rug_round", round, assets, prefabs),
	   Prefab("marsh/objects/rug_oval", oval, assets, prefabs),
	   Prefab("marsh/objects/rug_square", square, assets, prefabs),
	   Prefab("marsh/objects/rug_rectangle", rectangle, assets, prefabs),
	   Prefab("marsh/objects/rug_leather", leather, assets, prefabs),	   
	   Prefab("marsh/objects/rug_fur", fur, assets, prefabs),
	   Prefab("marsh/objects/rug_circle", circle, assets, prefabs),	   
	   Prefab("marsh/objects/rug_hedgehog", hedgehog, assets, prefabs),
	   Prefab("marsh/objects/rug_porcupuss", porcupus, assets, prefabs),
	   Prefab("marsh/objects/rug_hoofprint", hoofprint, assets, prefabs),
	   Prefab("marsh/objects/rug_octagon", octagon, assets, prefabs),
	   Prefab("marsh/objects/rug_swirl", swirl, assets, prefabs),
	   Prefab("marsh/objects/rug_catcoon", catcoon, assets, prefabs),
	   Prefab("marsh/objects/rug_rubbermat", rubbermat, assets, prefabs),
	   Prefab("marsh/objects/rug_web", web, assets, prefabs),
	   Prefab("marsh/objects/rug_metal", metal, assets, prefabs),
	   Prefab("marsh/objects/rug_wormhole", wormhole, assets, prefabs),
	   Prefab("marsh/objects/rug_braid", braid, assets, prefabs),
	   Prefab("marsh/objects/rug_beard", beard, assets, prefabs),
	   Prefab("marsh/objects/rug_nailbed", nailbed, assets, prefabs),
	   Prefab("marsh/objects/rug_crime", crime, assets, prefabs),
	   Prefab("marsh/objects/rug_tiles", tiles, assets, prefabs),
	   Prefab("marsh/objects/rug_cityhall_corners", cityhall_corners, assets, prefabs),
	   Prefab("marsh/objects/rug_palace_corners", palace_corners, assets, prefabs),
	   Prefab("marsh/objects/rug_palace_runner", palace_runner, assets, prefabs),

        MakePlacer("rug_round_placer",              "rugs", "rugs", "rug_round",        true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_square_placer",             "rugs", "rugs", "rug_square",       true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_oval_placer",               "rugs", "rugs", "rug_oval",         true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_rectangle_placer",          "rugs", "rugs", "rug_rectangle",    true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_leather_placer",            "rugs", "rugs", "rug_leather",      true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_fur_placer",                "rugs", "rugs", "rug_fur",          true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_circle_placer",             "rugs", "rugs", "half_circle",      true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_hedgehog_placer",           "rugs", "rugs", "rug_hedgehog",     true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_porcupuss_placer",          "rugs", "rugs", "rug_porcupuss",    nil, nil, nil, 1, nil, "two"),
        MakePlacer("rug_hoofprint_placer",          "rugs", "rugs", "rug_hoofprints",   true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_octagon_placer",            "rugs", "rugs", "rug_octagon",      true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_swirl_placer",              "rugs", "rugs", "rug_swirl",        true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_catcoon_placer",            "rugs", "rugs", "rug_catcoon",      true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_rubbermat_placer",          "rugs", "rugs", "rug_rubbermat",    true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_web_placer",                "rugs", "rugs", "rug_web",          true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_metal_placer",              "rugs", "rugs", "rug_metal",        true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_wormhole_placer",           "rugs", "rugs", "rug_wormhole",     true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_braid_placer",              "rugs", "rugs", "rug_braid",        true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_beard_placer",              "rugs", "rugs", "rug_beard",        true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_nailbed_placer",            "rugs", "rugs", "rug_nailbed",      nil, nil, nil, 1, nil, "two"),
        MakePlacer("rug_crime_placer",              "rugs", "rugs", "rug_crime",        true, nil, nil, 1, nil, "two"),
        MakePlacer("rug_tiles_placer",              "rugs", "rugs", "rug_tiles",        true, nil, nil, 1, nil, "two")
