local assets=
{
	Asset("ANIM", "anim/bulb_plant_single.zip"),
	Asset("ANIM", "anim/bulb_plant_double.zip"),
	Asset("ANIM", "anim/bulb_plant_triple.zip"),
	Asset("ANIM", "anim/bulb_plant_springy.zip"),
	Asset("SOUND", "sound/common.fsb"),
}


local prefabs =
{
	"lightbulb"
}

local function onregenfn(inst)
	inst.AnimState:PlayAnimation("grow") 
	inst.AnimState:PushAnimation("idle", true)
	inst.Light:Enable(true)
end

local function makefullfn(inst)
	inst.AnimState:PlayAnimation("idle", true)
	inst.Light:Enable(true)
end

local function onpickedfn(inst)
	inst.Light:Enable(false)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_lightbulb") 
	inst.AnimState:PlayAnimation("picking") 
	
	if inst.components.pickable:IsBarren() then
		inst.AnimState:PushAnimation("idle_dead")
	else
		inst.AnimState:PushAnimation("picked")
	end

end

local function makeemptyfn(inst)
	inst.Light:Enable(false)
	inst.AnimState:PlayAnimation("picked")
end

local plantnames = {"_single", "_springy"}

local function onsave(inst, data)
	data.plantname = inst.plantname
end

local function onload(inst,data)
	if data then
		inst.plantname = data.plantname
	end
end

local function single()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
        
	inst.plantname = plantnames[math.random(1, #plantnames)]
	inst.AnimState:SetBank("bulb_plant"..inst.plantname)
	inst.AnimState:SetBuild("bulb_plant"..inst.plantname)

    inst.AnimState:PlayAnimation("idle",true)
	inst.AnimState:SetTime(math.random()*2)    	
	
    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("bulb_plant.png")


    anim:SetTime(math.random()*2)
    local color = 0.75 + math.random() * 0.25
    anim:SetMultColour(color, color, color, 1)

	local light = inst.entity:AddLight()
	light:SetFalloff(0.5)
	light:SetIntensity(.8)
	light:SetRadius(1.5)
	light:SetColour(237/255, 237/255, 209/255)
	light:Enable(true)	
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	
	inst:AddComponent("pickable")	
	inst.components.pickable:SetUp("lightbulb", TUNING.FLOWER_CAVE_REGROW_TIME)
	inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"	
	inst.components.pickable.onregenfn = onregenfn
	inst.components.pickable.onpickedfn = onpickedfn
	inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.makefullfn = makefullfn
	inst.components.pickable.max_cycles = 20
	inst.components.pickable.cycles_left = 20   

	inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")  

    inst.components.inspectable.nameoverride = "flower_cave"  
    
    ---------------------        
    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    ---------------------   

	inst.OnSave = onsave
	inst.OnLoad = onload

	return inst
end

local function double()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
        
	inst.AnimState:SetBank("bulb_plant_double")
	inst.AnimState:SetBuild("bulb_plant_double")
	
	inst.AnimState:PlayAnimation("idle",true)
	inst.AnimState:SetTime(math.random()*2)  

	local light = inst.entity:AddLight()
	light:SetFalloff(0.5)
	light:SetIntensity(.8)
	light:SetRadius(2.5)
	light:SetColour(237/255, 237/255, 209/255)
	light:Enable(true)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("bulb_plant.png")


    anim:SetTime(math.random()*2)
    local color = 0.75 + math.random() * 0.25
    anim:SetMultColour(color, color, color, 1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	
	inst:AddComponent("pickable")
	inst.components.pickable:SetUp("lightbulb", TUNING.FLOWER_CAVE_REGROW_TIME * 1.5, 2)
	inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"	
	inst.components.pickable.onregenfn = onregenfn
	inst.components.pickable.onpickedfn = onpickedfn
	inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.makefullfn = makefullfn
	inst.components.pickable.max_cycles = 20
	inst.components.pickable.cycles_left = 20   

	inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")  

    inst.components.inspectable.nameoverride = "flower_cave"  
    
    ---------------------        
    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    ---------------------
  
	return inst
end

local function triple()
	local inst = CreateEntity()
    inst.entity:AddNetwork()	
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
        
	--inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("bulb_plant.png")


    anim:SetTime(math.random()*2)
    local color = 0.75 + math.random() * 0.25
    anim:SetMultColour(color, color, color, 1)
	
	inst.AnimState:SetBank("bulb_plant_triple")
	inst.AnimState:SetBuild("bulb_plant_triple")
    inst.AnimState:PlayAnimation("idle",true)
	inst.AnimState:SetTime(math.random()*2)  	



	local light = inst.entity:AddLight()
	light:SetFalloff(0.5)
	light:SetIntensity(.8)
	light:SetRadius(2.5)
	light:SetColour(237/255, 237/255, 209/255)
	light:Enable(true)	

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end	

	
	inst:AddComponent("pickable")	
	inst.components.pickable:SetUp("lightbulb", TUNING.FLOWER_CAVE_REGROW_TIME * 2, 3)
	inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"	
	inst.components.pickable.onregenfn = onregenfn
	inst.components.pickable.onpickedfn = onpickedfn
	inst.components.pickable.makeemptyfn = makeemptyfn
	inst.components.pickable.makefullfn = makefullfn
	inst.components.pickable.max_cycles = 20
	inst.components.pickable.cycles_left = 20   

	inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")  

    inst.components.inspectable.nameoverride = "flower_cave"  
    
    ---------------------        
    MakeMediumBurnable(inst)
    MakeSmallPropagator(inst)
    ---------------------   
  
	return inst
end
   

return Prefab("underwater/objects/flower_sea", single, assets, prefabs),
Prefab("underwater/objects/flower_sea_double", double, assets, prefabs),
Prefab("underwater/objects/flower_sea_triple", triple, assets, prefabs) 
