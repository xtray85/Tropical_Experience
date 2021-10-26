require "prefabutil"

local function onopen(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("open")
        inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
    end
end 

local function onclose(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("close")
        inst.AnimState:PushAnimation("closed", true)
        inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
    end
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("closed", true)
        if inst.components.container ~= nil then
            inst.components.container:DropEverything()
            inst.components.container:Close()
        end
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("closed", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/chest_craft")
end

local function onsave(inst, data)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() or inst:HasTag("burnt") then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt and inst.components.burnable ~= nil then
        inst.components.burnable.onburnt(inst)
    end
end

local function MakeChest(name, bank, build, indestructible, custom_postinit, prefabs, override_widget)
    local assets =
    {
        Asset("ANIM", "anim/water_chest.zip"),
        Asset("ANIM", "anim/ui_chest_3x2.zip"),
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        inst.MiniMapEntity:SetIcon("water_chest.png")

        inst:AddTag("structure")
        inst:AddTag("chest")
		inst:AddTag("aquatic")

        inst.AnimState:SetBank("water_chest")
        inst.AnimState:SetBuild("water_chest")
        inst.AnimState:PlayAnimation("closed", true)

        MakeSnowCoveredPristine(inst)

        inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			if inst.replica.container then inst.replica.container:WidgetSetup("treasurechest") end
		end
		return inst
	end

        inst:AddComponent("inspectable")
        inst:AddComponent("container")
        inst.components.container:WidgetSetup(override_widget or "treasurechest")
        inst.components.container.onopenfn = onopen
        inst.components.container.onclosefn = onclose

        if not indestructible then
            inst:AddComponent("lootdropper")
            inst:AddComponent("workable")
            inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
            inst.components.workable:SetWorkLeft(2)
            inst.components.workable:SetOnFinishCallback(onhammered)
            inst.components.workable:SetOnWorkCallback(onhit)

            MakeSmallBurnable(inst, nil, nil, true)
            MakeMediumPropagator(inst)
        end

        inst:ListenForEvent("onbuilt", onbuilt)
        MakeSnowCovered(inst)

        inst.OnSave = onsave 
        inst.OnLoad = onload

        if custom_postinit ~= nil then
            custom_postinit(inst)
        end

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return MakeChest("waterchest1", "water_chest", "water_chest", false, nil, { "collapse_small" }),
				MakePlacer("waterchest1_placer", "water_chest", "water_chest", "closed")
	
