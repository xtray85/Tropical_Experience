local assets=
{
	Asset("ANIM", "anim/deed.zip"),
	Asset("ANIM", "anim/pig_house_sale.zip"),	
}

local function OnRemoved(inst, owner)     
    --[[
    local target = nil
    target = owner.components.inventory:FindItem(function(item) return item:HasTag("ant_translator") end)
    if not target then 
        owner:RemoveTag("antlingual")
    end
    ]]
end

local function ondeploy (inst, pt)
    local casa = SpawnPrefab("playerhouse_city_entrance")
    casa.Transform:SetPosition(pt:Get())
    inst:Remove()
end

local function makefn(inst)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("deed")
    inst.AnimState:SetBuild("deed")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    MakeSmallBurnable(inst, TUNING.TINY_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)
	
	inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = ondeploy
	inst.components.deployable:SetDeployMode(DEPLOYMODE.WALL)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hamletinventory.xml"
	inst.caminho = "images/inventoryimages/hamletinventory.xml"	
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/jewlery"

    return inst
end

return Prefab( "common/inventory/deed", makefn, assets),
MakePlacer("common/deed_placer", "pig_house_sale", "pig_house_sale", "idle", nil, nil, nil, 0.75)