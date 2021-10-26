local assets =
{
--    Asset("ANIM", "anim/backpack.zip"),
    Asset("ANIM", "anim/armor_my.zip"),
    -- Asset("ANIM", "anim/ui_backpack_2x4.zip"),
    Asset("ANIM", "anim/ui_krampusbag_2x8.zip"),	
	Asset("IMAGE", "images/inventoryimages/levelx_vest.tex"),
    Asset("ATLAS", "images/inventoryimages/levelx_vest.xml"),
	Asset("IMAGE", "images/levelx_vestbg.tex"),
	Asset("ATLAS", "images/levelx_vestbg.xml"),	
}

local prefabs =
{
	"levelx_vest",
}


local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onopen(inst)

end

local function onclose(inst)

end

local function onequip(inst, owner)
	inst:AddTag("levelx_vest01")
    inst.Light:Enable(true)
	inst.SoundEmitter:PlaySound("ranger_mod_sound/ranger/torch_sound")
	owner.AnimState:OverrideSymbol("swap_body", "armor_my", "armor_my_folder")

	if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
	
	-- local function LightOn(player)
        -- SendModRPCToServer(MOD_RPC["ranger"]["vest_lighton"])    

    -- end
    -- GLOBAL.TheInput:AddKeyDownHandler(TUNING.RANGER.LIGHT_SWITCH_KEY, LightOn)

    -- local function SendLightOn()   
        -- SendModRPCToServer(MOD_RPC["ranger"]["VestLightOn"])
		
		

	-- end
    -- TheInput:AddKeyDownHandler(TUNING.RANGER.LIGHT_SWITCH_KEY, SendLightOn)
	
	-- TheInput:AddKeyUpHandler(TUNING.RANGER.LIGHT_SWITCH_KEY, function()		
		-- inst.Light:Enable(true)			
	-- end
	-- );
	
	-- TheInput:AddKeyUpHandler(TUNING.RANGER.LIGHT_SWITCH_KEY, function()
	-- if TheInput:IsKeyDown(KEY_CTRL) then
	   -- inst.Light:Enable(false)
	   -- end
	-- end
	-- );

    inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function onunequip(inst, owner)

    inst:RemoveTag("levelx_vest02")

	if inst:HasTag("levelx_vest01") then
	inst:RemoveTag("levelx_vest01")
	inst.SoundEmitter:PlaySound("ranger_mod_sound/ranger/torch_sound")
    end	

    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
    
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
	
	if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
	
	inst.Light:Enable(false)
end

local function OnDropped(inst)
    inst.Light:Enable(false)
end



local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddLight()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

    inst.MiniMapEntity:SetIcon("levelx_vest.png")

    inst.AnimState:SetBank("armor_my")
    inst.AnimState:SetBuild("armor_my")
    inst.AnimState:PlayAnimation("anim")
	
	inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(.7)
    inst.Light:SetRadius(1)
    inst.Light:SetColour(243/255, 220/255, 099/255)
    inst.Light:Enable(true)

    inst.foleysound = "dontstarve/movement/foley/logarmour"

    inst:AddTag("wood")
	inst:AddTag("armor")
	inst:AddTag("bag")
	inst:AddTag("ranger_vest")

    --waterproofer (from waterproofer component) added to pristine state for optimization
--    inst:AddTag("waterproofer")

    inst.entity:SetPristine()
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("krampus_sack") 
		end
  
    -- if not TheWorld.ismastersim then
		-- inst:DoTaskInTime(0, function () 
			-- if  inst.replica.container ~= nil then
				-- inst.replica.container:WidgetSetup("krampus_sack")
			-- end
		-- end)
        -- return inst
    -- end

	-- inst:AddComponent("container")    
	-- inst.components.container:WidgetSetup("krampus_sack")
	-- inst.components.container.onopenfn = onopen
	-- inst.components.container.onclosefn = onclose
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("krampus_sack")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose	

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "levelx_vest"
	inst.components.inventoryitem.atlasname= "images/inventoryimages/levelx_vest.xml"
--    inst.components.inventoryitem.cangoincontainer = false

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.equippable.walkspeedmult = 0.8	
	
	inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.ARMOR_SANITY * 10, .75)
--    inst.components.armor:AddWeakness("beaver", TUNING.BEAVER_WOOD_DAMAGE)

--    inst:AddComponent("waterproofer")
--    inst.components.waterproofer:SetEffectiveness(0)

    -- inst:AddComponent("container")
    -- inst.components.container:WidgetSetup("levelx_vest")

	

	
	inst:AddComponent("insulator")
--	inst.components.insulator:SetWinter()
    inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
		
	inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TUNING.WALRUSHAT_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)
--        inst.components.insulator:SetSummer()

--    MakeHauntableLaunchAndDropFirstItem(inst)
    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("common/inventory/levelx_vest", fn, assets, prefabs)