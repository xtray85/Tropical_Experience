local itemassets =
{
	Asset("ANIM", "anim/tar.zip"),
}

local assets =
{
    Asset("ANIM", "anim/tar_trap.zip"),
}
local TAR_TRAP_TIME = 30

local itemprefabs=
{
    "tar_trap",
}

local function findFloodGridNum(num)
    -- the flood grid is is the center of a 2x2 tile pattern. So 1,3,5,7..
    if math.mod(num, 2) == 0 then
        num = num +1
    end
    return num
end

local function quantizepos(pt)
    local x, y, z = pt:Get()
    y = 0    

    local nx = findFloodGridNum(math.floor(x))
    local ny = 0
    local nz = findFloodGridNum(math.floor(z))

    return Vector3(nx,ny,nz)
end

local function onRemove(inst)
    for i,slowedinst in pairs( inst.slowed_objects ) do
        i.slowing_objects[inst] = nil      
    end
end

local function updateAnim(inst)
local fuelAnim = 0
if inst.components.fueled.currentfuel <= 0 then inst:Remove() end
if inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.25 then fuelAnim = "idle_25"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.50 then fuelAnim = "idle_50"
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= 0.75 then fuelAnim = "idle_75" 
elseif inst and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel > 0.75 then fuelAnim = "idle_full" end 
if inst then inst.AnimState:PlayAnimation(fuelAnim) end
end


local function updateslowdowners(inst)
	local ground = TheWorld
	local x,y,z = inst.Transform:GetWorldPosition() 
	local ents = TheSim:FindEntities(x, y, z, 1, {"locomotor"}) 
	
	    for i=#ents,1,-1 do
        if not ents[i].sg or not ents[i].sg:HasStateTag("moving") then
            table.remove(ents,i)
        end            
    end
	
	for k,item in pairs(ents) do
		if item then
			if item and item.components.locomotor then
				inst.components.fueled.currentfuel = inst.components.fueled.currentfuel - 0.01
				if not item:HasTag("penalidade") then
					item:AddTag("penalidade")
					local speed = item.components.locomotor.runspeed
					item.components.locomotor.runspeed = item.components.locomotor.runspeed/4
					item:DoTaskInTime(1,function()
					item:RemoveTag("penalidade")	
					item.components.locomotor.runspeed = speed
				end)
			end 
		end
	end 
end

inst:DoTaskInTime(2/30,function(inst) updateslowdowners(inst) end)
updateAnim(inst)
end


local function ontakefuelfn(inst)
  --  inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/machine_fuel")
  updateAnim(inst,inst.components.fueled:GetCurrentSection())
end


local function onBuilt(inst)
    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/poop_splat")
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetLayer( LAYER_BACKGROUND )
    inst.AnimState:SetSortOrder( 3 )
   
    inst:AddTag("tar_trap")
    inst:AddTag("locomotor_slowdown")
	inst:AddTag("aquatic")
	
    
    --MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)

    inst.AnimState:SetBank("tar_trap")
    inst.AnimState:SetBuild("tar_trap")

    inst.AnimState:PlayAnimation("idle_full")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("inspectable")
	
	--inst:AddComponent("unevenground")
    --inst.components.unevenground.radius = TUNING.ANTLION_SINKHOLE.UNEVENGROUND_RADIUS*0.5

    MakeLargeBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeLargePropagator(inst)

    inst.slowdowners = {}

    inst:AddComponent("fueled")
    inst.components.fueled.accepting = true
    inst.components.fueled.ontakefuelfn = ontakefuelfn
    inst.components.fueled:SetSections(4)    
    inst.components.fueled:InitializeFuelLevel(TAR_TRAP_TIME/2)
    inst.components.fueled:SetDepletedFn(function(inst) inst:Remove() end)
    inst.components.fueled:SetSectionCallback(
        function(section)
            if section == 0 then
                --when we burn out
                if inst.components.burnable then 
                    inst.components.burnable:Extinguish() 
                end            
            else
                updateAnim(inst,section)
            end
        end)  
	inst.components.fueled.fueltype = "TAR"		

    onBuilt(inst)

    inst.slowed_objects = {}
    inst.OnRemoveEntity = onRemove
    inst:DoTaskInTime(1/30,function(inst) updateslowdowners(inst) end)

    return inst
end

local function ondeploy(inst, pt, deployer)
    local wall = SpawnPrefab("tar_trap") 
    wall.AnimState:PlayAnimation("place")
    wall.AnimState:PushAnimation("idle_full")
    
    if wall then
   --     pt = quantizepos(pt)
        wall.Transform:SetPosition(pt.x,0,pt.z) 
    end
    inst:Remove()
end

local function itemfn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	 inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)
--    MakeBlowInHurricane(inst, TUNING.WINDBLOWN_SCALE_MIN.LIGHT, TUNING.WINDBLOWN_SCALE_MAX.LIGHT)

	inst:AddTag("tar")
	inst:AddTag("TAR_fueled")
	
    inst.AnimState:SetBank("tar")
    inst.AnimState:SetBuild("tar")

    inst.AnimState:PlayAnimation("idle")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
--	inst.components.fuel.fueltype = "TAR"
--	inst.components.fuel.secondaryfueltype = "TAR"

	inst:AddComponent("fueltar")
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
        
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/volcanoinventory.xml"
	inst.caminho = "images/inventoryimages/volcanoinventory.xml"		

	inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
	inst.components.deployable:SetDeployMode(DEPLOYMODE.WALL)
    inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.LARGE)
    inst.components.deployable.placer = "tar_trap_placer" 

    return inst
end

return Prefab( "tar", itemfn, itemassets, itemprefabs),
		Prefab("tar_trap", fn, assets),
		MakePlacer("tar_placer",  "tar_trap", "tar_trap", "idle_full", false, false, true) 

