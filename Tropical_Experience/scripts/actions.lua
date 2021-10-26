-- DEPLOY_AI Action [FIX FOR MOBS THAT PLANT TREES]
--print("fist check)
AddAction(
    "LAVASPIT",
    "spit",
    function(act)
        if act.doer and act.target and act.doer.prefab == "dragoon" then
            local spit = GLOBAL.SpawnPrefab("dragoonspit")
            local x, y, z = act.doer.Transform:GetWorldPosition()
            local downvec = GLOBAL.TheCamera:GetDownVec()
            local offsetangle = math.atan2(downvec.z, downvec.x) * (180 / math.pi)
            while offsetangle > 180 do
                offsetangle = offsetangle - 360
            end
            while offsetangle < -180 do
                offsetangle = offsetangle + 360
            end
            local offsetvec =
                GLOBAL.Vector3(math.cos(offsetangle * GLOBAL.DEGREES), -.3, math.sin(offsetangle * GLOBAL.DEGREES)) *
                1.7
            spit.Transform:SetPosition(x + offsetvec.x, y + offsetvec.y, z + offsetvec.z)
            spit.Transform:SetRotation(act.doer.Transform:GetRotation())
        end
    end
)

-- DEPLOY_AI Action [FIX FOR MOBS THAT PLANT TREES]
AddAction(
    "DEPLOY_AI",
    "Deploy AI",
    function(act)
        if act.invobject and act.invobject.components.deployable then
            local obj =
                (act.doer.components.inventory and act.doer.components.inventory:RemoveItem(act.invobject)) or
                (act.doer.replica.container and act.doer.replica.container:RemoveItem(act.invobject))
            if obj then
                if obj.components.deployable:ForceDeploy(act:GetActionPoint(), act.doer, act.rotation) then
                    return true
                else
                    act.doer.components.inventory:GiveItem(obj)
                end
            end
        end
    end
)

AddComponentPostInit(
    "deployable",
    function(self, inst)
        self.ForceDeploy = function(self, pt, deployer)
            -- if not self:CanDeploy(pt) then
            --  return
            -- end
            local prefab = self.inst.prefab
            if self.ondeploy ~= nil then
                self.ondeploy(self.inst, pt, deployer)
            end
            -- self.inst is removed during ondeploy
            deployer:PushEvent("deployitem", {prefab = prefab})
            return true
        end
    end
)

AddAction(
    "FLUP_HIDE",
    "Flup Hide",
    function(act)
        --Dummy action for flup hiding
    end
)

AddAction(
    "FISH1",
    "Fish1",
    function(act)
        local fishingrod =
            (act.invobject and act.invobject.components.fishingrod) or (act.doer and act.doer.components.fishingrod)

        if fishingrod then
            fishingrod:StartFishing(act.target, act.doer)
        end
        return true
    end
)

AddAction(
    "TIGERSHARK_FEED",
    "Tigershark Feed",
    function(act)
        local doer = act.doer
        if doer and doer.components.lootdropper then
            doer.components.lootdropper:SpawnLootPrefab("wetgoop")
        end
    end
)

AddAction(
    "MATE",
    "Mate",
    function(act)
        if act.target == act.doer then
            return false
        end

        if act.doer.components.mateable then
            act.doer.components.mateable:Mate()
            return true
        end
    end
)

AddAction(
    "CRAB_HIDE",
    "Crab Hide",
    function(act)
        --Dummy action for crab.
    end
)

AddAction(
	"HIDECRAB",
	"Hide",
	function(act)
		if act.doer then
			return true
		end
	end)
	
AddAction(
	"SHOWCRAB",
	"Emerge",
	function(act)
		if act.doer then
			return true
		end
	end)	

AddAction(
    "THROW",
    "Throw",
    function(act)
	local thrown = act.invobject or act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if act.target and not act.pos then
		act.pos = act.target:GetPosition()
	end
	if thrown and thrown.components.throwable then
		thrown.components.throwable:Throw(act.pos, act.doer)
		return true
	end
    end
)


-------------actions hamlet-------------------
AddAction(
    "PEAGAWK_TRANSFORM",
    "Peagank Transform",
    function(act)
        --Dummy action for flup hiding
    end
)

AddAction(
    "MANUALEXTINGUISH",
    "Manualextinguish",
    function(act)
	if act.doer:HasTag("extinguisher") then
		if act.target.components.burnable and act.target.components.burnable:IsBurning() then
			act.target.components.burnable:Extinguish()
			return true
		end
	elseif act.target.components.sentientball then
		act.target.components.burnable:Extinguish()
		-- damage player?
		return true
	elseif act.invobject:HasTag("frozen") and act.target.components.burnable and act.target.components.burnable:IsBurning() then
		act.target.components.burnable:Extinguish(true, TUNING.SMOTHERER_EXTINGUISH_HEAT_PERCENT, act.invobject)
		return true
	end
    end
)

AddAction(
    "SPECIAL_ACTION",
    "Special Actions",
    function(act)
	if act.doer.special_action then
		act.doer.special_action(act)
		return true
	end
    end
)

AddAction(
    "SPECIAL_ACTION2",
    "Special Actions2",
    function(act)
	if act.doer.special_action2 then
		act.doer.special_action2(act)
		return true
	end
    end
)


AddAction(
    "LAUNCH_THROWABLE",
    "Launch Throwable",
    function(act)
	if act.target and not act.pos then
		act.pos = act.target:GetPosition()
	end
	act.invobject.components.thrower:Throw(act.pos)
	return true
    end
)

AddAction(
    "INFEST",
    "Infest",
    function(act)
	if not act.doer.infesting then
		act.doer.components.infester:Infest(act.target)
	end
    end
)

AddAction(
    "DIGDUNG",
    "Digdung",
    function(act)
	act.target.components.workable:WorkedBy(act.doer, 1)
    end
)

AddAction(
    "MOUNTDUNG",
    "Mountdung",
    function(act)
	act.doer.dung_target:Remove()
    act.doer:AddTag("hasdung") 
    act.doer.dung_target = nil
    end
)

AddAction(
    "BARK",
    "Bark",
    function(act)
	return true
    end
)

AddAction(
    "RANSACK",
    "Ransack",
    function(act)
	return true
    end
)

AddAction(
    "CUREPOISON",
    "Curepoison",
    function(act)
	if act.invobject and act.invobject.components.poisonhealer then
		local target = act.target or act.doer
		return act.invobject.components.poisonhealer:Cure(target)
	end
    end
)

AddAction(
    "USEDOOR",
    "Usedoor",
    function(act)
	if act.target:HasTag("secret_room") then
		return false
	end

	if act.target.components.door and not act.target.components.door.disabled then
		act.target.components.door:Activate(act.doer)
		return true
	elseif act.target.components.door and act.target.components.door.disabled then
		return false, "LOCKED"
	end
    end
)

local SHOP = GLOBAL.Action({priority = 9, rmb = true, distance = 1, mount_valid = false})
SHOP.stroverridefn = function(act)
if act.target.imagename and act.target.cost then
    return "Buy "..act.target.imagename.." for "..act.target.cost.." oincs"
else
return "Shop"
end
end
SHOP.id = "SHOP"
SHOP.fn = function(act)
	if act.doer.components.inventory then
		if act.doer:HasTag("player") and act.doer.components.shopper then 

			if act.doer.components.shopper:IsWatching(act.target) then 

				local sell = true
				local reason = nil

				if act.target:HasTag("shopclosed") or GLOBAL.TheWorld.state.isnight then
					reason = "closed"
					sell = false
				elseif not act.doer.components.shopper:CanPayFor(act.target) then 
					local prefab_wanted = act.target.costprefab
					if prefab_wanted == "oinc" then
						reason = "money"
					else
						reason = "goods"
					end
					sell = false
				end
				
				if sell then
					act.doer.components.shopper:PayFor(act.target)
					act.target.components.shopdispenser:RemoveItem()
					act.target:SetImage(nil)

					if act.target and act.target.shopkeeper_speech then
						act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_SALE[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_SALE)])
					end

					return true 
				else 
					if reason == "money" then
						if act.target and act.target.shopkeeper_speech then
							act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_NOT_ENOUGH[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_NOT_ENOUGH)])
						end
					elseif reason == "goods" then
						if act.target and act.target.shopkeeper_speech then
							act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_DONT_HAVE[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_DONT_HAVE)])
						end						
					elseif reason == "closed" then
						if act.target and act.target.shopkeeper_speech then
							act.target.shopkeeper_speech(act.target,STRINGS.CITY_PIG_SHOPKEEPER_CLOSING[math.random(1,#STRINGS.CITY_PIG_SHOPKEEPER_CLOSING)])
						end						
					end
					return true
				end		
			else
				act.doer.components.shopper:Take(act.target)
				-- THIS IS WHAT HAPPENS IF ISWATCHING IS FALSE
				act.target.components.shopdispenser:RemoveItem()
				act.target:SetImage(nil)
				return true 
			end 
		end
	end
end
SHOP.encumbered_valid =true
AddAction(SHOP)

AddAction(
    "FIX",
    "Fix",
    function(act)
	if act.target then
		local target = act.target
		local numworks = 1
		target.components.workable:WorkedBy(act.doer, numworks)
	--	return target:fix(act.doer)		
	end
    end
)

AddAction(
    "STOCK",
    "Stock",
    function(act)
	if act.target then		
		act.target.restock(act.target,true)
		act.doer.changestock = nil
		return true
	end
    end
)
----------------------------------------------------------------- acoes do jogador----------------------------------------

local BOATMOUNT = GLOBAL.Action({priority = 10, rmb = true, distance = 8, mount_valid = false})
BOATMOUNT.str = (GLOBAL.STRINGS.ACTIONS.BOATMOUNT)
BOATMOUNT.id = "BOATMOUNT"
BOATMOUNT.fn = function(act)
    if
        act.doer ~= nil and act.target ~= nil and act.doer:HasTag("player") and act.target.components.interactions and
            act.target:HasTag("boat")
     then
 
act.doer:AddTag("pulando")
if act.doer:HasTag("aquatic") then
act.doer:RemoveComponent("rowboatwakespawner")
if act.doer.components.driver then
local barcoinv = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
if barcoinv and barcoinv.prefab == act.doer.components.driver.vehicle.prefab  then 
local consumo = SpawnPrefab(act.doer.components.driver.vehicle.prefab)
consumo.Transform:SetPosition(act.doer.components.driver.vehicle:GetPosition():Get())
consumo.components.finiteuses.current = barcoinv.components.finiteuses.current
-------------------------transfere o conteudo do barco inventario para o barco do criado---------------------------------
if barcoinv.components.container then
local sailslot = barcoinv.components.container:GetItemInSlot(1)
if sailslot then
consumo.components.container:GiveItem(sailslot, 1)
end

local luzslot = barcoinv.components.container:GetItemInSlot(2)
if luzslot and luzslot.prefab == "quackeringram" then luzslot.navio1 = nil end
if luzslot then
consumo.components.container:GiveItem(luzslot, 2)
end

local cargoslot1 = barcoinv.components.container:GetItemInSlot(3)
if cargoslot1 then
consumo.components.container:GiveItem(cargoslot1, 3)
end

local cargoslot2 = barcoinv.components.container:GetItemInSlot(4)
if cargoslot2 then
consumo.components.container:GiveItem(cargoslot2, 4)
end

local cargoslot3 = barcoinv.components.container:GetItemInSlot(5)
if cargoslot3 then
consumo.components.container:GiveItem(cargoslot3, 5)
end

local cargoslot4 = barcoinv.components.container:GetItemInSlot(6)
if cargoslot4 then
consumo.components.container:GiveItem(cargoslot4, 6)
end

local cargoslot5 = barcoinv.components.container:GetItemInSlot(7)
if cargoslot5 then
consumo.components.container:GiveItem(cargoslot5, 7)
end

local cargoslot6 = barcoinv.components.container:GetItemInSlot(8)
if cargoslot6 then
consumo.components.container:GiveItem(cargoslot6, 8)
end end
----------------------------------------------------------------------------------------------------------------------
barcoinv:Remove()
end
act.doer.components.driver.vehicle:Remove()
act.doer:RemoveComponent("driver")
act.doer:RemoveTag("sail")
act.doer:RemoveTag("surf")
act.doer:RemoveTag("aquatic")
end
end	 

        act.target.components.interactions:BoatJump(act.doer)
        return true
    else
        return false
    end
end
BOATMOUNT.encumbered_valid =true
AddAction(BOATMOUNT)



local BOATDISMOUNT = GLOBAL.Action({priority = 9, rmb = true, distance = 8, mount_valid = false})
BOATDISMOUNT.str = (GLOBAL.STRINGS.ACTIONS.BOATDISMOUNT)
BOATDISMOUNT.id = "BOATDISMOUNT"
BOATDISMOUNT.fn = function(act)
    if act.doer ~= nil and act.doer:HasTag("player") then
		act.doer:AddTag("pulando")
        act.doer:AddComponent("interactions")
        act.doer.components.interactions:BoatDismount(act.doer, act:GetActionPoint())
        return true
    end
end
BOATDISMOUNT.encumbered_valid =true
AddAction(BOATDISMOUNT)


local SURF = GLOBAL.Action({
priority = 4, 
--is_relative_to_platform=true,
--disable_platform_hopping=true, 
distance = 20
})
SURF.str = (GLOBAL.STRINGS.ACTIONS.SURF)
SURF.id = "SURF"
SURF.fn = function(act)

	local doer_x, doer_y, doer_z = act.doer.Transform:GetWorldPosition()
	local planchadesurf = GLOBAL.TheWorld.Map:GetPlatformAtPoint(doer_x, doer_z)
	if planchadesurf and planchadesurf:HasTag("planchadesurf") then
    local pos = act:GetActionPoint()
    if pos == nil then
        pos = act.target:GetPosition()
    end
    planchadesurf.components.oar:Row(act.doer, pos)
    planchadesurf.components.health:DoDelta(-0.5)
	
    return true
	end
end
SURF.encumbered_valid =true
AddAction(SURF)





local BOATCANNON = GLOBAL.Action({priority = 8, rmb = true, distance = 25, mount_valid = false})
BOATCANNON.str = (GLOBAL.STRINGS.ACTIONS.BOATCANNON)
BOATCANNON.id = "BOATCANNON"
BOATCANNON.fn = function(act)
if act.doer ~= nil and act.doer:HasTag("player") then

act.doer:AddTag("deleidotiro")
act.doer:DoTaskInTime(0.5, function(inst) act.doer:RemoveTag("deleidotiro") end)


local equipamento = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
local canhao = equipamento.replica.container:GetItemInSlot(2)
----------------posiciona pra sair no canhao-----------------------
local angle = act.doer:GetRotation()
local dist = 1.5
local offset = Vector3(dist * math.cos(angle*GLOBAL.DEGREES), 0, -dist*math.sin(angle*GLOBAL.DEGREES))
local x, y, z = act.doer.Transform:GetWorldPosition()
local x1, y1, z1
local pos
if act.target then
x1, y1, z1 = act.target:GetPosition():Get()
pos = act.target:GetPosition()					
else
x1, y1, z1 = act:GetActionPoint():Get()
pos = act:GetActionPoint()
end

local pt = Vector3(x,y,z)
local bombpos = pt + offset
local x, y, z = bombpos:Get()

-------------------------------------------------------

if canhao and canhao.prefab == "woodlegs_boatcannon" then
if equipamento and canhao then canhao.components.finiteuses:Use(1) end
local bomba = SpawnPrefab("cannonshotobsidian")
bomba.Transform:SetPosition(x, y+1.5, z)
bomba.components.complexprojectile:Launch(pos)
act.doer.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/knight_steamboat/cannon")
else
if equipamento and canhao and act.doer.prefab ~= "woodlegs" then 
canhao.components.finiteuses:Use(1)
local bomba = SpawnPrefab("cannonshot")
bomba.Transform:SetPosition(x, y+1.5, z)
bomba.components.complexprojectile:Launch(pos)
act.doer.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/knight_steamboat/cannon")
elseif equipamento and equipamento.prefab == "woodlegsboat" and canhao and act.doer.prefab == "woodlegs" then
local bomba = SpawnPrefab("cannonshot")
bomba.components.explosive.explosivedamage = 50
bomba.Transform:SetPosition(x, y+1.5, z)
bomba.components.complexprojectile:Launch(pos)
act.doer.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/knight_steamboat/cannon")
elseif equipamento and canhao then 
canhao.components.finiteuses:Use(1)
local bomba = SpawnPrefab("cannonshot")
bomba.Transform:SetPosition(x, y+1.5, z)
bomba.components.complexprojectile:Launch(pos)
act.doer.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/knight_steamboat/cannon")
end
end

        return true
    end
end
AddAction(BOATCANNON)


local RETRIEVE = GLOBAL.Action({priority = 11, rmb = true, distance = 10, mount_valid = false})
RETRIEVE.str = (GLOBAL.STRINGS.ACTIONS.RETRIEVE)
RETRIEVE.id = "RETRIEVE"
RETRIEVE.fn = function(act)


	if act.target.components.breeder and act.target.components.breeder.volume > 0 then
	return act.target.components.breeder:Harvest(act.doer) end
	
    if act.doer ~= nil and act.target ~= nil and act.doer:HasTag("player") and act.target.components.interactions and act.target.prefab == "surfboard" then
    if act.target and act.target.prefab == "surfboard" then
	local panela = SpawnPrefab("surfboarditem")
	if act.target.components.finiteuses then
	panela.components.finiteuses.current = act.target.components.finiteuses.current
	end
	act.doer.components.inventory:GiveItem(panela, 1)
	act.target:Remove()
    end 
	return true	
	end
	
    if act.doer ~= nil and act.target ~= nil and act.doer:HasTag("player") and act.target.components.interactions and act.target.prefab == "corkboat" then
    if act.target and act.target.prefab == "corkboat" then
	local panela = SpawnPrefab("corkboatitem")
	if act.target.components.finiteuses then
	panela.components.finiteuses.current = act.target.components.finiteuses.current
	end
	
	

-------------------------transfere o conteudo do barco inventario para o barco do criado---------------------------------
if act.target.components.container then
local sailslot = act.target.components.container:GetItemInSlot(1)
if sailslot then
act.doer.components.inventory:GiveItem(sailslot, 1)
end

local luzslot = act.target.components.container:GetItemInSlot(2)
if luzslot and luzslot.prefab == "quackeringram" then luzslot.navio1 = nil end
if luzslot then
act.doer.components.inventory:GiveItem(luzslot, 1)
end

end
----------------------------------------------------------------------------------------------------------------------
	
	act.doer.components.inventory:GiveItem(panela, 1)
	act.target:Remove()
    end 
	return true	
	end	
	
end	

AddAction(RETRIEVE)

--[[
local function ExtraDeployDist(doer, dest, bufferedaction)
	if dest ~= nil then
		local target_x, target_y, target_z = dest:GetPoint()

		local is_on_water = GLOBAL.TheWorld.Map:IsOceanTileAtPoint(target_x, 0, target_z) and not GLOBAL.TheWorld.Map:IsPassableAtPoint(target_x, 0, target_z)
		if is_on_water then
			return ((bufferedaction ~= nil and bufferedaction.invobject ~= nil and bufferedaction.invobject:HasTag("usedeployspacingasoffset") and bufferedaction.invobject.replica.inventoryitem ~= nil and bufferedaction.invobject.replica.inventoryitem:DeploySpacingRadius()) or 0) + 1.0
		end
	end
    return 0
end


GLOBAL.ACTIONS.DEPLOY.distance = 6
]]



local BOATREPAIR = GLOBAL.Action({priority = 10, rmb = true, distance = 1, mount_valid = false})
BOATREPAIR.str = (GLOBAL.STRINGS.ACTIONS.BOATREPAIR)
BOATREPAIR.id = "BOATREPAIR"
BOATREPAIR.fn = function(act)
if act.doer ~= nil and act.doer:HasTag("aquatic") and act.invobject ~= nil and act.invobject:HasTag("boatrepairkit") then
local boat = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
local boat2 = act.doer.components.driver.vehicle
if boat and boat2 then

if boat2.components.finiteuses and boat.components.armor.condition and boat2.components.finiteuses.current + 150 >= boat2.components.finiteuses.total then
boat2.components.finiteuses.current = boat2.components.finiteuses.total
boat.components.armor.condition = boat2.components.finiteuses.current
if boat2.components.finiteuses then
boat2.components.finiteuses:Use(1)
end
if act.invobject.prefab == "sewing_tape" then
local nut = act.invobject
if act.invobject.components.stackable and act.invobject.components.stackable.stacksize > 1 then 
nut = act.invobject.components.stackable:Get()
end
nut:Remove()
else
if act.invobject.components.finiteuses then
act.invobject.components.finiteuses:Use(1)
end
end
return true
end

boat2.components.finiteuses.current = boat2.components.finiteuses.current + 150
boat.components.armor.condition = boat.components.armor.condition + 150
if act.invobject.components.finiteuses then
act.invobject.components.finiteuses:Use(1)
end
end
return true
end



    if
        act.doer ~= nil and act.target ~= nil and act.doer:HasTag("player") and act.target.components.interactions and
            act.target:HasTag("boat")
     then
        local equipamento = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)

        if equipamento then
            if act.target.components.finiteuses.current + 150 >= act.target.components.finiteuses.total then
                act.target.components.finiteuses.current = act.target.components.finiteuses.total
				local gastabarco = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)-------armadura
				if gastabarco then gastabarco.components.armor.condition = act.target.components.finiteuses.current end   ---------armadura
				if equipamento.components.finiteuses then
                equipamento.components.finiteuses:Use(1)
				end
                return true
            end
            act.target.components.finiteuses.current = act.target.components.finiteuses.current + 150
			local gastabarco = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)---------armadura
			if gastabarco then gastabarco.components.armor.condition = act.target.components.finiteuses.current end---------armadura
			if equipamento.components.finiteuses then
            equipamento.components.finiteuses:Use(1)
			end
        end
        return true
    end
end

AddAction(BOATREPAIR)





local OPENTUNA = GLOBAL.Action({priority = 10, rmb = true, distance = 1, mount_valid = false})
OPENTUNA.str = (GLOBAL.STRINGS.ACTIONS.OPENTUNA)
OPENTUNA.id = "OPENTUNA"
OPENTUNA.fn = function(act)
if act.doer ~= nil and act.invobject ~= nil and act.invobject:HasTag("tunacan") then
local nut = act.invobject 
if act.invobject.replica.inventoryitem then 
if act.invobject.components.stackable and act.invobject.components.stackable.stacksize > 1 then 
nut = act.invobject.components.stackable:Get()
end 
if act.doer.components.inventory then 
local peixe = SpawnPrefab("fish_med_cooked")
act.doer.components.inventory:GiveItem(peixe, 1) end
end
nut:Remove()
return true
end

end
AddAction(OPENTUNA)

local DISLODGE = GLOBAL.Action({priority = 10, rmb = true, distance = 2, mount_valid = false})
DISLODGE.str = (GLOBAL.STRINGS.ACTIONS.DISLODGE)
DISLODGE.id = "DISLODGE"
DISLODGE.fn = function(act)
local equipamento = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if act.target.components.dislodgeable and act.target.components.dislodgeable.canbedislodged and act.target.components.dislodgeable.caninteractwith then


if act.doer ~= nil and equipamento then
if equipamento.components.finiteuses then
equipamento.components.finiteuses:Use(1)
end

if  equipamento and equipamento:HasTag("ballpein_hammer") then
if act.target.components.dislodgeable then
act.target.components.dislodgeable:Dislodge(act.doer)
end
return true
end

end

else
return false
end

end
AddAction(DISLODGE)


local PAINT = GLOBAL.Action({priority = 10, rmb = true, distance = 2, mount_valid = false})
PAINT.str = (GLOBAL.STRINGS.ACTIONS.PAINT)
PAINT.id = "PAINT"
PAINT.fn = function(act)
local equipamento = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if act.doer ~= nil and equipamento then
if equipamento.components.finiteuses then
equipamento.components.finiteuses:Use(1)
end

if equipamento and equipamento:HasTag("shop_wall_checkered_metal") then
act.target.AnimState:SetBank("wallhamletcity1")
act.target.AnimState:SetBuild("wallhamletcity1")
act.target.AnimState:PlayAnimation("shop_wall_checkered_metal", true)
act.target.wallpaper = "shop_wall_checkered_metal"
return true
end

if equipamento and equipamento:HasTag("shop_wall_circles") then
act.target.AnimState:SetBank("wallhamletcity1")
act.target.AnimState:SetBuild("wallhamletcity1")
act.target.AnimState:PlayAnimation("shop_wall_circles", true)
act.target.wallpaper = "shop_wall_circles"
return true
end

if equipamento and equipamento:HasTag("shop_wall_marble") then
act.target.AnimState:SetBank("wallhamletcity1")
act.target.AnimState:SetBuild("wallhamletcity1")
act.target.AnimState:PlayAnimation("shop_wall_marble", true)
act.target.wallpaper = "shop_wall_marble"
return true
end

if equipamento and equipamento:HasTag("shop_wall_sunflower") then
act.target.AnimState:SetBank("wallhamletcity1")
act.target.AnimState:SetBuild("wallhamletcity1")
act.target.AnimState:PlayAnimation("shop_wall_sunflower", true)
act.target.wallpaper = "shop_wall_sunflower"
return true
end

if equipamento and equipamento:HasTag("shop_wall_woodwall") then
act.target.AnimState:SetBank("wallhamletcity1")
act.target.AnimState:SetBuild("wallhamletcity1")
act.target.AnimState:PlayAnimation("shop_wall_woodwall", true)
act.target.wallpaper = "shop_wall_woodwall"
return true
end

if equipamento and equipamento:HasTag("wall_mayorsoffice_whispy") then
act.target.AnimState:SetBank("wallhamletcity1")
act.target.AnimState:SetBuild("wallhamletcity1")
act.target.AnimState:PlayAnimation("wall_mayorsoffice_whispy", true)
act.target.wallpaper = "wall_mayorsoffice_whispy"
return true
end

if equipamento and equipamento:HasTag("harlequin_panel") then
act.target.AnimState:SetBank("wallhamletcity2")
act.target.AnimState:SetBuild("wallhamletcity2")
act.target.AnimState:PlayAnimation("harlequin_panel", true)
act.target.wallpaper = "harlequin_panel"
return true
end

if equipamento and equipamento:HasTag("shop_wall_fullwall_moulding") then
act.target.AnimState:SetBank("wallhamletcity2")
act.target.AnimState:SetBuild("wallhamletcity2")
act.target.AnimState:PlayAnimation("shop_wall_fullwall_moulding", true)
act.target.wallpaper = "shop_wall_fullwall_moulding"
return true
end

if equipamento and equipamento:HasTag("shop_wall_floraltrim2") then
act.target.AnimState:SetBank("wallhamletcity2")
act.target.AnimState:SetBuild("wallhamletcity2")
act.target.AnimState:PlayAnimation("shop_wall_floraltrim2", true)
act.target.wallpaper = "shop_wall_floraltrim2"
return true
end

if equipamento and equipamento:HasTag("shop_wall_upholstered") then
act.target.AnimState:SetBank("wallhamletcity2")
act.target.AnimState:SetBuild("wallhamletcity2")
act.target.AnimState:PlayAnimation("shop_wall_upholstered", true)
act.target.wallpaper = "shop_wall_upholstered"
return true
end



if equipamento and equipamento:HasTag("floor_cityhall") then
act.target.AnimState:PlayAnimation("floor_cityhall", true)
act.target.floorpaper = "floor_cityhall"
return true
end

if equipamento and equipamento:HasTag("noise_woodfloor") then
act.target.AnimState:PlayAnimation("noise_woodfloor", true)
act.target.floorpaper = "noise_woodfloor"
return true
end

if equipamento and equipamento:HasTag("shop_floor_checker") then
act.target.AnimState:PlayAnimation("shop_floor_checker", true)
act.target.floorpaper = "shop_floor_checker"
return true
end

if equipamento and equipamento:HasTag("shop_floor_herringbone") then
act.target.AnimState:PlayAnimation("shop_floor_herringbone", true)
act.target.floorpaper = "shop_floor_herringbone"
return true
end

if equipamento and equipamento:HasTag("shop_floor_hexagon") then
act.target.AnimState:PlayAnimation("shop_floor_hexagon", true)
act.target.floorpaper = "shop_floor_hexagon"
return true
end

if equipamento and equipamento:HasTag("shop_floor_octagon") then
act.target.AnimState:PlayAnimation("shop_floor_octagon", true)
act.target.floorpaper = "shop_floor_octagon"
return true
end

if equipamento and equipamento:HasTag("shop_floor_sheetmetal") then
act.target.AnimState:PlayAnimation("shop_floor_sheetmetal", true)
act.target.floorpaper = "shop_floor_sheetmetal"
return true
end

if equipamento and equipamento:HasTag("shop_floor_woodmetal") then
act.target.AnimState:PlayAnimation("shop_floor_woodmetal", true)
act.target.floorpaper = "shop_floor_woodmetal"
return true
end

if equipamento and equipamento:HasTag("shop_floor_hoof_curvy") then
act.target.AnimState:PlayAnimation("shop_floor_hoof_curvy", true)
act.target.floorpaper = "shop_floor_hoof_curvy"
return true
end

if equipamento and equipamento:HasTag("shop_floor_woodpaneling2") then
act.target.AnimState:PlayAnimation("shop_floor_woodpaneling2", true)
act.target.floorpaper = "shop_floor_woodpaneling2"
return true
end

end
end

AddAction(PAINT)

local SMELT = GLOBAL.Action({priority = 10, mount_valid = true})
SMELT.str = (GLOBAL.STRINGS.ACTIONS.SMELT)
SMELT.id = "SMELT"
SMELT.fn = function(act)
	if act.target.components.melter then
		act.target.components.melter:StartCooking()
		return true
	end
end
AddAction(SMELT)

local GIVE2 = GLOBAL.Action({priority = 10, distance = 1, mount_valid = true})
GIVE2.str = (GLOBAL.STRINGS.ACTIONS.GIVE2)
GIVE2.id = "GIVE2"
GIVE2.fn = function(act)
	if act.invobject.components.inventoryitem then
			act.target.components.shelfer:AcceptGift(act.doer, act.invobject)
			return true

	end 
end
AddAction(GIVE2)


AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions, right) 
    if not right then
    if target:HasTag("shelfcanaccept") then --target.components.shelfer and target.components.shelfer:CanAccept(inst, doer ) then        
        table.insert(actions, ACTIONS.GIVE2)        
    end 	
	end
end)

--[[
local FERTILIZE = GLOBAL.Action({priority = 1, distance = 2, mount_valid = true})
FERTILIZE.str = (GLOBAL.STRINGS.ACTIONS.FERTILIZE)
FERTILIZE.id = "FERTILIZE"
FERTILIZE.fn = function(act)
    if act.invobject ~= nil and act.invobject.components.fertilizer ~= nil and act.target ~= nil and not act.target:HasTag("cofeebush") then
	if act.invobject:HasTag("ashes") then return false end
        if act.target ~= nil and not (act.doer ~= nil and act.doer.components.rider ~= nil and act.doer.components.rider:IsRiding()) then            
            if act.target.components.crop ~= nil and not (act.target.components.crop:IsReadyForHarvest() or act.target:HasTag("withered")) then
			print("1")
                return act.target.components.crop:Fertilize(act.invobject, act.doer)
            elseif act.target.components.grower ~= nil and act.target.components.grower:IsEmpty() then                
                act.target.components.grower:Fertilize(act.invobject, act.doer)
				print("2")
                return true
            elseif act.target.components.pickable ~= nil and act.target.components.pickable:CanBeFertilized() then
                act.target.components.pickable:Fertilize(act.invobject, act.doer)
                TheWorld:PushEvent("CHEVO_fertilized",{target=act.target,doer=act.doer})
                return true
            elseif act.target.components.quagmire_fertilizable ~= nil then
                act.target.components.quagmire_fertilizable:Fertilize(act.invobject, act.doer)
                return true
            end
        end
        if act.doer ~= nil and (act.target == nil or act.doer == act.target or act.doer:HasTag("plantkin") and act.doer:HasTag("player")) then
		print("5")
            return act.invobject.components.fertilizer:Heal(act.doer)
        end
    end
	
    if act.invobject ~= nil and act.invobject:HasTag("ashes") and act.target ~= nil and act.target:HasTag("cofeebush") then
        if act.target ~= nil and not (act.doer ~= nil and act.doer.components.rider ~= nil and act.doer.components.rider:IsRiding()) then            
            if act.target.components.pickable ~= nil and act.target.components.pickable:CanBeFertilized() then
                act.target.components.pickable:Fertilize(act.invobject, act.doer)
                TheWorld:PushEvent("CHEVO_fertilized",{target=act.target,doer=act.doer})
                return true
            end
        end
    end	

end
AddAction(FERTILIZE)
]]






local FERTILIZECOFFEE = GLOBAL.Action({priority = 1, distance = 2, mount_valid = true})
FERTILIZECOFFEE.str = (GLOBAL.STRINGS.ACTIONS.FERTILIZE)
FERTILIZECOFFEE.id = "FERTILIZECOFFEE"
FERTILIZECOFFEE.fn = function(act)
    if act.invobject ~= nil and act.invobject.components.fertilizecoffee ~= nil and act.target ~= nil and act.target:HasTag("cofeebush") then
        if act.target ~= nil and not (act.doer ~= nil and act.doer.components.rider ~= nil and act.doer.components.rider:IsRiding()) then            
            if act.target.components.pickable ~= nil and act.target.components.pickable:CanBeFertilized() then
                act.target.components.pickable:Fertilize(act.invobject, act.doer)	 
if act.invobject.components.stackable and act.invobject.components.stackable.stacksize > 1 then 
nut = act.invobject.components.stackable:Get()
nut:Remove()
else
act.invobject:Remove()
end				 		 
                TheWorld:PushEvent("CHEVO_fertilized",{target=act.target,doer=act.doer})
                return true
            end
        end
    end

end
AddAction(FERTILIZECOFFEE)

AddComponentAction("USEITEM", "fertilizecoffee", function(inst, doer, target, actions, right) 
    if not right then
            if not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding()) and target:HasTag("barren") and target:HasTag("cofeebush") then
                table.insert(actions, ACTIONS.FERTILIZECOFFEE)
            end	
	end
end)

local PICKUP = GLOBAL.Action({priority = 1, distance = 2, mount_valid = true})
PICKUP.str = (GLOBAL.STRINGS.ACTIONS.PICKUP)
PICKUP.id = "PICKUP"
PICKUP.fn = function(act)
	if act.target and act.target.components.inventoryitem and act.target.components.shelfer then
		local item  = act.target.components.shelfer:GetGift()
		if item then
		item:AddTag("cost_one_oinc")
		if act.target.components.shelfer.shelf and not act.target.components.shelfer.shelf:HasTag("playercrafted") then
			if act.doer.components.shopper and act.doer.components.shopper:IsWatching(item) then 
				if act.doer.components.shopper:CanPayFor(item) then 
					act.doer.components.shopper:PayFor(item)
				else 			
					return false, "CANTPAY"
				end
			else
				if act.target.components.shelfer.shelf and act.target.components.shelfer.shelf.curse then
					act.target.components.shelfer.shelf.curse(act.target)
				end						
			end
		end
		item:RemoveTag("cost_one_oinc")
		if item.components.perishable then item.components.perishable:StartPerishing() end		
		act.target = act.target.components.shelfer:GiveGift()	
		end
	end

    if act.doer.components.inventory ~= nil and
        act.target ~= nil and
        act.target.components.inventoryitem ~= nil and
        (act.target.components.inventoryitem.canbepickedup or
        (act.target.components.inventoryitem.canbepickedupalive and not act.doer:HasTag("player"))) and
        not (act.target:IsInLimbo() or
            (act.target.components.burnable ~= nil and act.target.components.burnable:IsBurning()) or
            (act.target.components.projectile ~= nil and act.target.components.projectile:IsThrown())) then

        if act.doer.components.itemtyperestrictions ~= nil and not act.doer.components.itemtyperestrictions:IsAllowed(act.target) then
            return false, "restriction"
        elseif act.target.components.container ~= nil and act.target.components.container:IsOpen() and not act.target.components.container:IsOpenedBy(act.doer) then
            return false, "inuse"
        end

        act.doer:PushEvent("onpickupitem", { item = act.target })

        if act.target.components.equippable ~= nil and not act.target.components.equippable:IsRestricted(act.doer) then
            local equip = act.doer.components.inventory:GetEquippedItem(act.target.components.equippable.equipslot)
            if equip ~= nil and not act.target.components.inventoryitem.cangoincontainer then
                --special case for trying to carry two backpacks
                if equip.components.inventoryitem ~= nil and equip.components.inventoryitem.cangoincontainer then
                    --act.doer.components.inventory:SelectActiveItemFromEquipSlot(act.target.components.equippable.equipslot)
                    act.doer.components.inventory:GiveItem(act.doer.components.inventory:Unequip(act.target.components.equippable.equipslot))
                else
                    act.doer.components.inventory:DropItem(equip)
                end
                act.doer.components.inventory:Equip(act.target)
                return true
            elseif act.doer:HasTag("player") then
                if equip == nil or act.doer.components.inventory:GetNumSlots() <= 0 then
                    act.doer.components.inventory:Equip(act.target)
                    return true
                elseif GLOBAL.GetGameModeProperty("non_item_equips") then
                    act.doer.components.inventory:DropItem(equip)
                    act.doer.components.inventory:Equip(act.target)
                    return true
                end
            end
        end

        act.doer.components.inventory:GiveItem(act.target, nil, act.target:GetPosition())
        return true
    end
end
AddAction(PICKUP)


local HARVEST1 = GLOBAL.Action({priority = 10, mount_valid = true})
HARVEST1.str = (GLOBAL.STRINGS.ACTIONS.HARVEST1)
HARVEST1.id = "HARVEST1"
HARVEST1.fn = function(act)
	if act.target.components.melter then
        return act.target.components.melter:Harvest(act.doer)		
	end
end
AddAction(HARVEST1)

local PAN = GLOBAL.Action({priority = 10, mount_valid = true})
PAN.str = (GLOBAL.STRINGS.ACTIONS.PAN)
PAN.id = "PAN"
PAN.fn = function(act)
	if act.target.components.workable and act.target.components.workable.action == ACTIONS.PAN then
		local numworks = 1

		if act.invobject and act.invobject.components.tool then
			numworks = act.invobject.components.tool:GetEffectiveness(ACTIONS.PAN)
		elseif act.doer and act.doer.components.worker then
			numworks = act.doer.components.worker:GetEffectiveness(ACTIONS.PAN)
		end
		act.target.components.workable:WorkedBy(act.doer, numworks)
			
	end
	return true
end
AddAction(PAN)


local INVESTIGATEGLASS = GLOBAL.Action({priority = 10, mount_valid = true})
INVESTIGATEGLASS.str = (GLOBAL.STRINGS.ACTIONS.INVESTIGATEGLASS)
INVESTIGATEGLASS.id = "INVESTIGATEGLASS"
INVESTIGATEGLASS.fn = function(act)
	if act.target:HasTag("secret_room") then
		act.target.Investigate(act.doer)
		return true
	end

	if act.target and act.target.components.mystery then
		act.target.components.mystery:Investigate(act.doer)
		
	local equipamento = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if act.doer ~= nil and equipamento then
	equipamento.components.finiteuses:Use(1)
	end

	return true
	end
end
AddAction(INVESTIGATEGLASS)


local function DoToolWork(act, workaction)
    if
        act.target.components.workable ~= nil and act.target.components.workable:CanBeWorked() and
            act.target.components.workable.action == workaction
     then
	 
		if act.target:HasTag("grass_tall") then
		
		local equipamento = act.doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
        if equipamento and equipamento.prefab == "shears" then
		local x, y, z = act.target.Transform:GetWorldPosition()
		local gramaextra = SpawnPrefab("cutgrass")
		if gramaextra then gramaextra.Transform:SetPosition(x, y, z) end
		end
		end
		
		if act.target:HasTag("hedgetoshear") then
		local equipamento = act.doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
        if equipamento and equipamento.prefab == "shears" then		
		local x, y, z = act.target.Transform:GetWorldPosition()
		local gramaextra = SpawnPrefab("clippings")
		if gramaextra then	gramaextra.Transform:SetPosition(x, y, z) end
		end
		end	

		if act.target:HasTag("hangingvine") then
		local equipamento = act.doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
        if equipamento and equipamento.prefab == "shears" then			
		local x, y, z = act.target.Transform:GetWorldPosition()	
		act.target:DoTaskInTime(1, function()  
		local gramaextra = SpawnPrefab("rope")
		if gramaextra then gramaextra.Transform:SetPosition(x, y, z) end
                end)		
		end
		end			

        act.target.components.workable:WorkedBy(
            act.doer,
            (act.invobject ~= nil and act.invobject.components.tool ~= nil and
                act.invobject.components.tool:GetEffectiveness(workaction)) or
                (act.doer ~= nil and act.doer.components.worker ~= nil and
                    act.doer.components.worker:GetEffectiveness(workaction)) or
                1
        )
    end
    return true
end

local HACK = GLOBAL.Action({priority = 10, mount_valid = true})
HACK.str = (GLOBAL.STRINGS.ACTIONS.HACK)
HACK.id = "HACK"
HACK.fn = function(act, ...)
    return DoToolWork(act, GLOBAL.ACTIONS.HACK)
end
AddAction(HACK)

local HACK1 = GLOBAL.Action({priority = 10, mount_valid = true})
HACK1.str = (GLOBAL.STRINGS.ACTIONS.HACK)
HACK1.id = "HACK1"
HACK1.fn = function(act, ...)

local equipamento = act.doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if equipamento and equipamento.components.finiteuses then
equipamento.components.finiteuses:Use(1)
end
local numworks = 1
if equipamento and equipamento.components.tool then
numworks = equipamento.components.tool:GetEffectiveness(ACTIONS.HACK)
elseif act.doer and act.doer.components.worker then
numworks = act.doer.components.worker:GetEffectiveness(ACTIONS.HACK)
end
if equipamento and equipamento.components.obsidiantool then
equipamento.components.obsidiantool:Use(act.doer, act.target)
end
if act.target and act.target.components.hackable then
act.target.components.hackable:Hack(act.doer, numworks)
return true
end
if act.target and act.target.components.workable and act.target.components.workable.action == ACTIONS.HACK then
act.target.components.workable:WorkedBy(act.doer, numworks)
return true
end
--    return DoToolWork(act, GLOBAL.ACTIONS.HACK)
end
AddAction(HACK1)

AddComponentAction("SCENE", "hackable", function(inst, doer, actions, right)
local equipamento = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
    if not right then
        if equipamento and equipamento:HasTag("machete") and not (doer.replica.rider:IsRiding() or doer:HasTag("bonked")) then --and equipamento.components.hackable then --and inst.components.hackable.canbehacked then
            table.insert(actions, GLOBAL.ACTIONS.HACK1)
        end
			
   end
   
    if   right then   
         if   doer:HasTag("ironlord") then
            table.insert(actions, GLOBAL.ACTIONS.HACK1)
        end	
    end		
end)

local GAS = GLOBAL.Action({priority = 10, distance = 3, mount_valid = true})
GAS.str = (GLOBAL.STRINGS.ACTIONS.GAS)
GAS.id = "GAS"
GAS.fn = function(act)
	if act.invobject and act.invobject.components.gasser then
		act.invobject.components.gasser:Gas(act:GetActionPoint())
		return true
	end
end
AddAction(GAS)

AddComponentAction("SCENE", "melter", function(inst, doer, actions, right)
    if right then
	if not inst:HasTag("burnt") then
	
		if inst:HasTag("alloydone") then
	        table.insert(actions, ACTIONS.HARVEST1)
	    elseif inst.replica.container ~= nil and 
		inst.replica.container:IsFull() then
			table.insert(actions, ACTIONS.SMELT)
	    end
	end	
end	

end)

local TIRO = GLOBAL.Action({priority = 9, rmb = true, distance = 20, mount_valid = false})
TIRO.str = (GLOBAL.STRINGS.ACTIONS.TIRO)
TIRO.id = "TIRO"
TIRO.fn = function(act)
    if act.doer ~= nil and act.doer:HasTag("ironlord") then
--        act.doer:AddComponent("interactions")
--        act.doer.components.interactions:TIRO(act.doer, act.target:GetPosition())
        return true
    end
end
TIRO.encumbered_valid =true
AddAction(TIRO)

AddComponentAction("SCENE", "workable", function(inst, doer, actions, right)
            if right and doer:HasTag("ironlord") then
			if inst:HasTag("tree") then	
                table.insert(actions, ACTIONS.CHOP)
            end
			
			if inst:HasTag("bush_vine") or inst:HasTag("bambootree") then	
                table.insert(actions, ACTIONS.HACK)
            end	

			if inst:HasTag("boulder") then	
                table.insert(actions, ACTIONS.MINE)
            end				

			if inst:HasTag("structure") then	
                table.insert(actions, ACTIONS.HAMMER)
            end	

			end
end)

-------------------------------------------
AddComponentAction("SCENE", "dislodgeable", function(inst, doer, actions, right)
	local equipamento = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
    if not right then
	if equipamento and equipamento:HasTag("ballpein_hammer") and inst:HasTag("dislodgeable") and not (doer.replica.rider:IsRiding() or doer:HasTag("bonked")) then 
        table.insert(actions, ACTIONS.DISLODGE)
		return
    end
end	

end)


AddComponentAction("SCENE", "mystery", function(inst, doer, actions, right)
    if not right then
	local equipamento = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
	if equipamento and equipamento:HasTag("magnifying_glass") and not (doer.replica.rider:IsRiding() or doer:HasTag("bonked")) then
        table.insert(actions, ACTIONS.INVESTIGATEGLASS)
    end
end	

end)


AddComponentAction(
    "SCENE",
    "interactions",
    function(inst, doer, actions, right)
        local equipamento = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
        --local rightrect = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) 
        --  and doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).components.reticule ~= nil or nil
        if right then

            if equipamento and equipamento:HasTag("boatrepairkit") and doer:HasTag("aquatic") then
                table.insert(actions, GLOBAL.ACTIONS.BOATREPAIR)
                return
            end		
					
            if  inst:HasTag("boat") and not inst:HasTag("ocupado") and
                    not (doer.replica.rider:IsRiding() or
                        doer:HasTag("bonked"))
             then
                table.insert(actions, GLOBAL.ACTIONS.BOATMOUNT)
            end
        end
		
	if not right then
	
            if  inst.prefab == "surfboard" and not inst:HasTag("ocupado") and not doer.replica.inventory:IsFull() then
                table.insert(actions, GLOBAL.ACTIONS.RETRIEVE)
                return
            end			
			
            if  inst.prefab == "corkboat" and not inst:HasTag("ocupado") and not doer.replica.inventory:IsFull() then
                table.insert(actions, GLOBAL.ACTIONS.RETRIEVE)
                return
            end			

            if  inst.prefab == "fish_farm" then
                table.insert(actions, GLOBAL.ACTIONS.RETRIEVE)
                return
            end				
			
            if inst:HasTag("wallhousehamlet") and equipamento and equipamento:HasTag("hameletwallpaper") then
                table.insert(actions, GLOBAL.ACTIONS.PAINT)
                return
            end			
			
            if inst:HasTag("pisohousehamlet") and equipamento and equipamento:HasTag("hameletfloor") then
                table.insert(actions, GLOBAL.ACTIONS.PAINT)
                return
            end				
	end
    end
)

local ACTIVATESAIL = GLOBAL.Action({priority = 10, mount_valid = true})
ACTIVATESAIL.str = (GLOBAL.STRINGS.ACTIONS.LANTERNON)
ACTIVATESAIL.id = "ACTIVATESAIL"
ACTIVATESAIL.fn = function(act)
if act.doer ~= nil and act.invobject:HasTag("boatlight") then
act.invobject:AddTag("ligado") end
return true
end
AddAction(ACTIVATESAIL)

local COMPACTPOOP = GLOBAL.Action({priority = 10, mount_valid = true})
COMPACTPOOP.str = "Compact Poop"
COMPACTPOOP.id = "COMPACTPOOP"
COMPACTPOOP.fn = function(act)
if act.invobject.components.stackable and act.invobject.components.stackable.stacksize > 1 then 
nut = act.invobject.components.stackable:Get()
nut:Remove()
else
act.invobject:Remove()
end
act.doer.components.inventory:GiveItem(GLOBAL.SpawnPrefab("poop2"))
return true
end
AddAction(COMPACTPOOP)

local DESACTIVATESAIL = GLOBAL.Action({priority = 10, mount_valid = true})
DESACTIVATESAIL.str = (GLOBAL.STRINGS.ACTIONS.LANTERNOFF)
DESACTIVATESAIL.id = "DESACTIVATESAIL"
DESACTIVATESAIL.fn = function(act)
if act.doer ~= nil and act.invobject:HasTag("boatlight") then
act.invobject:RemoveTag("ligado") end
return true
end
AddAction(DESACTIVATESAIL)

AddComponentAction(
"INVENTORY", 
"interactions",
function(inst, doer, actions)
if inst:HasTag("boatlight") and inst:HasTag("nonavio") and not inst:HasTag("ligado") then     --and inst:HasTag("nonavio")
        table.insert(actions, ACTIONS.ACTIVATESAIL)
end
if inst:HasTag("boatlight") and inst:HasTag("ligado") then
        table.insert(actions, ACTIONS.DESACTIVATESAIL)
end

if inst:HasTag("boatrepairkit") then
        table.insert(actions, ACTIONS.BOATREPAIR)
end

if inst:HasTag("tunacan") then
        table.insert(actions, ACTIONS.OPENTUNA)
end

if inst:HasTag("pooptocompact") and doer:HasTag("wilbur") then
table.insert(actions, ACTIONS.COMPACTPOOP)
end

end)

AddComponentAction(
    "SCENE",
    "health",
    function(inst, doer, actions, right)
    local containedsail = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BARCO)             
    if  right and doer:HasTag("aquatic") and containedsail and containedsail.replica.container and containedsail.replica.container:GetItemInSlot(2) ~= nil and containedsail.replica.container:GetItemInSlot(2):HasTag("boatcannon") and    
        not (doer.replica.rider:IsRiding() or doer.replica.inventory:IsHeavyLifting() or doer:HasTag("bonked") or doer:HasTag("deleidotiro")) then
        table.insert(actions, GLOBAL.ACTIONS.BOATCANNON)
    end 
	


            if not right and doer:HasTag("ironlord") and
                inst.replica.health ~= nil and not inst.replica.health:IsDead() and
                inst.replica.combat ~= nil and inst.replica.combat:CanBeAttacked(doer) then
                table.insert(actions, ACTIONS.ATTACK)
            end
--            if right and doer:HasTag("ironlord") and
--                inst.replica.health ~= nil and not inst.replica.health:IsDead() and
--                inst.replica.combat ~= nil and inst.replica.combat:CanBeAttacked(doer) then
--                table.insert(actions, ACTIONS.TIRO)
--            end

    end)

AddComponentAction("SCENE", "shopped", function(inst, doer, actions, right)
    if not right then
	if doer.components.shopper then --and inst.components.shopdispenser and inst.components.shopdispenser.item_served then
	table.insert(actions, ACTIONS.SHOP)
    end
	end
end)

AddComponentAction("POINT", "gasser", function(inst, doer, pos, actions, right)
    if right and not (doer.replica.rider:IsRiding() or doer:HasTag("bonked")) then
	table.insert(actions, ACTIONS.GAS)
	end
end)

AddComponentAction("SCENE", "poisonable", function(inst, doer, actions, right)
    if right then
	local equipamento = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
	if equipamento and equipamento:HasTag("bugrepellent") and not (doer.replica.rider:IsRiding() or doer:HasTag("bonked")) then	
	table.insert(actions, ACTIONS.GAS)
	end
	end
end)
----------------------------------------permite pular do barco sem ter equipamento---------------------------------------------------------------------------
AddComponentPostInit(
    "playeractionpicker",
    function(self)
        local OldGetRightClickActions = self.GetRightClickActions
        function self:GetRightClickActions(position, target)
            local boat = self.inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BARCO)
            local acts = OldGetRightClickActions(self, position, target)
            if #acts <= 0 and boat then
                acts = self:GetPointActions(position, boat, true)
            end
            return acts
        end
    end
)

local function boatdismon(inst, doer, pos, actions, right)
    local xjp, yjp, zjp = pos:Get()
    local xs, ys, zs = doer.Transform:GetWorldPosition()
    local dist = math.sqrt((xjp - xs) * (xjp - xs) + (zjp - zs) * (zjp - zs))
    local rightrect =
        doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BARCO) and
        doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BARCO).components.reticule ~= nil or
        nil
    local terraformer =
        doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BARCO) and
        doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BARCO).components.terraformer ~= nil or
        nil 

--					inst.components.playercontroller ~= nil and
--                    inst.components.playercontroller:IsAnyOfControlsPressed(
--                        CONTROL_PRIMARY,
--                        CONTROL_ACTION,
--                        CONTROL_CONTROLLER_ACTION) and
--or doer.components.playercontroller ~= nil and doer.components.playercontroller:IsControlPressed(CONTROL_ACTION)
   
    if right and rightrect == nil and terraformer == nil and doer:HasTag("aquatic") and dist <= 10 and
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_COASTAL and
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_COASTAL_SHORE and
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_SWELL and
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_ROUGH and
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_BRINEPOOL and
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_BRINEPOOL_SHORE and
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_HAZARDOUS and	
            TheWorld.Map:GetTile(TheWorld.Map:GetTileCoordsAtPoint(pos:Get())) ~= GROUND.OCEAN_WATERLOG and				
            not (doer.replica.rider:IsRiding() or doer:HasTag("bonked"))
     then 
        table.insert(actions, GLOBAL.ACTIONS.BOATDISMOUNT)
    end


	local WALKABLE_PLATFORM_TAGS = {"walkableplatform"}
	local plataforma = false
    local entities = TheSim:FindEntities(xjp, yjp, zjp, TUNING.MAX_WALKABLE_PLATFORM_RADIUS/2.3 - 1, WALKABLE_PLATFORM_TAGS)
    for i, v in ipairs(entities) do
    local walkable_platform = v.components.walkableplatform            
    if walkable_platform ~= nil then  
	plataforma = true
    end
    end


    if right and rightrect == nil and terraformer == nil and doer:HasTag("aquatic") and dist <= 10 and
	plataforma and not (doer.replica.rider:IsRiding() or doer:HasTag("bonked")) then 
        table.insert(actions, GLOBAL.ACTIONS.BOATDISMOUNT)
    end	
	
    if right and rightrect == nil and terraformer == nil and dist <= 20 then 
	local doer_x, doer_y, doer_z = doer.Transform:GetWorldPosition()
	local planchadesurf = GLOBAL.TheWorld.Map:GetPlatformAtPoint(doer_x, doer_z)
	if planchadesurf and planchadesurf:HasTag("planchadesurf") then
        table.insert(actions, GLOBAL.ACTIONS.SURF)
	end
    end	
	
	
    local containedsail = doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.BARCO)             
    if right and doer:HasTag("aquatic") and containedsail and containedsail.replica.container and containedsail.replica.container:GetItemInSlot(2) ~= nil and containedsail.replica.container:GetItemInSlot(2):HasTag("boatcannon") and    
        not (doer.replica.rider:IsRiding() or doer.replica.inventory:IsHeavyLifting() or doer:HasTag("bonked") or doer:HasTag("deleidotiro")) then
		table.insert(actions, GLOBAL.ACTIONS.BOATCANNON)
    end 		
end
AddComponentAction("POINT", "equippable", boatdismon)

------------------------------------------------------------------- players stategraph
local player_overrides = {
	wathgrithr="wathgrithr_sail",
	waxwell="waxwell_sail",
	wendy="wendy_sail",
	wickerbottom="wickerbottom_sail",
	willow="willow_sail",
	wilson="wilson_sail",
	wes="wes_sail",
	webber="webber_sail",
	winona="winona_sail",
	wolfgang="wolfgang_sail",
	woodie="woodie_sail",
	wx78="wx78_sail",
}

local state_jumponboatstart_pre =
    GLOBAL.State {
    name = "jumponboatstart_pre",
    tags = {"doing", "busy", "nointerrupt"},
    onenter = function(inst)
        inst.components.locomotor:Stop()
        local heavy = inst.replica.inventory:IsHeavyLifting()
        inst.AnimState:PlayAnimation(heavy and "heavy_jump_pre" or "jump_pre")
        inst.sg:SetTimeout(GLOBAL.FRAMES * 18)
    end,
    events = {
        GLOBAL.EventHandler(
            "animover",
            function(inst)
                if GLOBAL.TheWorld.ismastersim then
                    inst:PerformBufferedAction()
                end
                if not GLOBAL.TheWorld.ismastersim then
                    inst:PerformPreviewBufferedAction()
                end
            end
        )
    },
    onupdate = function(inst)
        if not GLOBAL.TheWorld.ismastersim then
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle", true)
            end
        end
    end,
    ontimeout = function(inst)
        if not GLOBAL.TheWorld.ismastersim then -- client
            inst:ClearBufferedAction()
        end
        inst.sg:GoToState("idle")
    end,
    onexit = function(inst)
        if inst.bufferedaction == inst.sg.statemem.action then
            inst:ClearBufferedAction()
        end
        inst.sg.statemem.action = nil
    end
}
AddStategraphState("wilson", state_jumponboatstart_pre)

local state_jumponboatstart_preclient =
    GLOBAL.State {
    name = "jumponboatstart_pre",
    tags = {"doing", "busy", "nointerrupt"},
    onenter = function(inst)
        inst.components.locomotor:Stop()
        local heavy = inst.replica.inventory:IsHeavyLifting()
        inst.AnimState:PlayAnimation(heavy and "heavy_jump_pre" or "jump_pre")
        inst:PerformPreviewBufferedAction()
        inst.sg:SetTimeout(TIMEOUT)
    end,
	
        onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle")
        end,
}


AddStategraphState("wilson_client", state_jumponboatstart_preclient)


AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.LIGHT,
        function(inst)
			local equipped = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
            if equipped and equipped:HasTag("magnifying_glass") then
                return "investigate_start"
            else
                return "give"
            end
		end
    )
)

AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.LIGHT,
        function(inst)
			local equipped = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
            if equipped and equipped:HasTag("magnifying_glass") then
                return "investigate_start"
            else
                return "give"
            end
		end
    )
)

AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.PLAY,
        function(inst, action)
	           if action.invobject ~= nil then
                return (action.invobject:HasTag("flute") and "play_flute")
                    or (action.invobject:HasTag("horn") and "play_horn")
                    or (action.invobject:HasTag("horn2") and "play_horn2")
                    or (action.invobject:HasTag("horn3") and "play_horn3")					
                    or (action.invobject:HasTag("bell") and "play_bell")
                    or (action.invobject:HasTag("whistle") and "play_whistle")
                    or nil
            end
		end
    )
)

AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "play_horn2",
        tags = { "doing", "playing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("horn", false)
			inst.AnimState:OverrideSymbol("horn01", "swap_wind_conch", "swap_horn")
            --inst.AnimState:Hide("ARM_carry")
            inst.AnimState:Show("ARM_normal")
            inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil)
        end,

        timeline =
        {
            GLOBAL.TimeEvent(21 * FRAMES, function(inst)
                if inst:PerformBufferedAction() then
                    inst.SoundEmitter:PlaySound("dontstarve/common/horn_beefalo")
                else
                    inst.AnimState:SetTime(48 * FRAMES)
                end
            end),
        },

        events =
        {
            GLOBAL.EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
        end,
    })
	
AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "play_horn3",
        tags = { "doing", "playing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("horn", false)
			inst.AnimState:OverrideSymbol("horn01", "swap_antler", "swap_horn")
            --inst.AnimState:Hide("ARM_carry")
            inst.AnimState:Show("ARM_normal")
            inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil)
        end,

        timeline =
        {
            GLOBAL.TimeEvent(21 * FRAMES, function(inst)
                if inst:PerformBufferedAction() then
                    inst.SoundEmitter:PlaySound("dontstarve/common/horn_beefalo")
                else
                    inst.AnimState:SetTime(48 * FRAMES)
                end
            end),
        },

        events =
        {
            GLOBAL.EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
        end,
    })	

AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.BLINK,
        function(inst, action)	
		if inst:HasTag("aquatic") and inst:HasTag("soulstealer") then return false end
		local interior = GLOBAL.GetClosestInstWithTag("blows_air", inst, 30)
		if interior then return false end
        if  GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_COASTAL and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_COASTAL_SHORE and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_SWELL and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_ROUGH and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_BRINEPOOL and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_BRINEPOOL_SHORE and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_WATERLOG and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_HAZARDOUS then	
            return action.invobject == nil and inst:HasTag("soulstealer") and "portal_jumpin_pre" or "quicktele"			
		end
		end
    )
)

AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.BLINK,
        function(inst, action)	
		if inst:HasTag("aquatic") and inst:HasTag("soulstealer") then return false end
		local interior = GLOBAL.GetClosestInstWithTag("blows_air", inst, 30)
		if interior then return false end
        if  GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_COASTAL and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_COASTAL_SHORE and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_SWELL and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_ROUGH and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_BRINEPOOL and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_BRINEPOOL_SHORE and
			GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_WATERLOG and
            GLOBAL.TheWorld.Map:GetTile(GLOBAL.TheWorld.Map:GetTileCoordsAtPoint(action:GetActionPoint():Get())) ~= GROUND.OCEAN_HAZARDOUS then	
            return action.invobject == nil and inst:HasTag("soulstealer") and "portal_jumpin_pre" or "quicktele"			
		end
		end
    )
)

AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "jumponboatstart",
        tags = {"doing", "busy", "nointerrupt"},
        onenter = function(inst, target)
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(GLOBAL.COLLISION.GROUND)
        inst.Physics:CollidesWith(GLOBAL.COLLISION.GIANTS)

        inst.sg.statemem.heavy = inst.replica.inventory:IsHeavyLifting()
        inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_jumpout" or "jump")
--[[	
		local x1, y1, z1 = target.Transform:GetWorldPosition()	
		local x2, y2, z2 = inst.Transform:GetWorldPosition()		
        inst.sg.statemem.targetpos = Vector3(x1,y1,z1)
		inst.sg.statemem.startpos = Vector3(x2,y2,z2)
	
--		local x1, y1, z1 = target.Transform:GetWorldPosition()
--		local x2, y2, z2 = inst.Transform:GetWorldPosition()
--		local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
--		inst.Physics:SetMotorVel(dist * 1.67, 0, 0)			
]]			
        inst.sg.statemem.action = inst.bufferedaction
        inst.sg:SetTimeout(21 * GLOBAL.FRAMES)
        end,
        timeline = {
            GLOBAL.TimeEvent(
                15.2 * GLOBAL.FRAMES,
                function(inst)
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            ),
            GLOBAL.TimeEvent(
                18 * GLOBAL.FRAMES,
                function(inst)
                    inst.Physics:Stop()
                end
            )
        },
		
        events = {
            GLOBAL.EventHandler(
                "animqueueover",
                function(inst)
                    --          local x,y,z = inst.Transform:GetWorldPosition()
                    if inst.AnimState:AnimDone() then
                        GLOBAL.ChangeToCharacterPhysics(inst)
                        --              inst.Transform:SetPosition(inst.posx,0,inst.posz)
                        inst.sg:GoToState("idle")
                    end
                end
            )
        },

--        onupdate = function(inst)
--		local percent = inst.AnimState:GetCurrentAnimationTime ()*1.3 / inst.AnimState:GetCurrentAnimationLength()
--        local xdiff = inst.sg.statemem.targetpos.x - inst.sg.statemem.startpos.x
--        local zdiff = inst.sg.statemem.targetpos.z - inst.sg.statemem.startpos.z           
--		inst.Physics:TeleportRespectingInterpolation(inst.sg.statemem.startpos.x+(xdiff*percent), 0, inst.sg.statemem.startpos.z+(zdiff*percent))		
--        end,

        ontimeout = function(inst)
            if not GLOBAL.TheWorld.ismastersim then -- client
                inst:ClearBufferedAction()
            end
            GLOBAL.ChangeToCharacterPhysics(inst)
            inst.sg:GoToState("idle")
        end,
		
        onexit = function(inst)
            GLOBAL.ChangeToCharacterPhysics(inst)
            if inst.components.driver.mountdata then
                inst.components.driver:OnMount(inst.components.driver.mountdata)
            end
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
            inst.sg.statemem.action = nil
        end
    }
)

--[[

AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "jumponboatstart",
        tags = { "doing", "nointerrupt", "busy", "jumping", "autopredict", "nomorph", "nosleep" },

        onenter = function(inst, target)
		        inst.Physics:ClearCollisionMask()
				inst.Physics:CollidesWith(GLOBAL.COLLISION.GROUND)
				inst.Physics:CollidesWith(GLOBAL.COLLISION.GIANTS)
                inst.AnimState:PlayAnimation(inst.components.inventory:IsHeavyLifting() and "heavy_jump_pre" or "jump_pre", false)
				inst.sg.statemem.target = target
				end,

        events =
        {
            GLOBAL.EventHandler("animover", 
                function(inst) 
                        inst.sg:GoToState("jumponboatloop", target)
                end),
        },

		onexit = function(inst)
			local x1, y1, z1 = inst.sg.statemem.target.Transform:GetWorldPosition()
			local x2, y2, z2 = inst.Transform:GetWorldPosition()
			local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
			inst.Physics:SetMotorVel(dist * 1.67, 0, 0)	
		end,
    })
	
	

AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "jumponboatloop",
        tags = { "doing", "nointerrupt", "busy", "jumping", "autopredict", "nomorph", "nosleep" },

        onenter = function(inst)
			inst.sg:SetTimeout(18 * GLOBAL.FRAMES)
		    inst.Physics:ClearCollisionMask()
			inst.Physics:CollidesWith(GLOBAL.COLLISION.GROUND)
			inst.Physics:CollidesWith(GLOBAL.COLLISION.GIANTS)		
            inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_jump" or "jump")		
        end,
	
        ontimeout = function(inst)
            inst.sg:GoToState("jumponboatpst")
        end,		

		onexit = function(inst)
		end,
    })
	
	

AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "jumponboatpst",
        tags = { "doing", "nointerrupt", "jumping", "autopredict", "nomorph", "nosleep" },

        onenter = function(inst, data)
			inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation(inst.components.inventory:IsHeavyLifting() and "heavy_jump_pre" or "jump_pre", false)
			inst:RemoveTag("busy")
			inst.sg:SetTimeout(5 * GLOBAL.FRAMES)
        end,
		
        ontimeout = function(inst)	
            inst.sg:GoToState("idle")
        end,

		onexit = function(inst)
            GLOBAL.ChangeToCharacterPhysics(inst)
            if inst.components.driver.mountdata then
                inst.components.driver:OnMount(inst.components.driver.mountdata)
            end
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
            inst.sg.statemem.action = nil		
		end
    })  
]]


AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "jumponboatdismount",
        tags = {"doing", "busy"},
        onenter = function(inst)
            inst.Physics:ClearCollisionMask()
            inst.Physics:CollidesWith(GLOBAL.COLLISION.GROUND)
            inst.Physics:CollidesWith(GLOBAL.COLLISION.GIANTS)

            inst.sg.statemem.heavy = inst.replica.inventory:IsHeavyLifting()
            inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_jumpout" or "jumpout")

            inst.sg.statemem.action = inst.bufferedaction
            inst.sg:SetTimeout(30 * GLOBAL.FRAMES)
        end,
        timeline = {
            GLOBAL.TimeEvent(
                15.2 * GLOBAL.FRAMES,
                function(inst)
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            ),
            GLOBAL.TimeEvent(
                18 * GLOBAL.FRAMES,
                function(inst)
                    inst.Physics:Stop()
                end
            )
        },
        events = {
            GLOBAL.EventHandler(
                "animqueueover",
                function(inst)
                    --          local x,y,z = inst.Transform:GetWorldPosition()
                    if inst.AnimState:AnimDone() then
                        GLOBAL.ChangeToCharacterPhysics(inst)
                        --              inst.Transform:SetPosition(inst.posx,0,inst.posz)
                        inst.sg:GoToState("idle")
                    end

                    if inst.components.interactions then
                        inst:RemoveComponent("interactions")
                    end
                end
            )
        },
        ontimeout = function(inst)
            if not GLOBAL.TheWorld.ismastersim then -- client
                inst:ClearBufferedAction()
            end
            GLOBAL.ChangeToCharacterPhysics(inst)
            --      local x,y,z = inst.Transform:GetWorldPosition()
            --      inst.Transform:SetPosition(inst.posx,0,inst.posz)
            inst.sg:GoToState("idle")
        end,
        onexit = function(inst)
			inst:RemoveTag("pulando")
            GLOBAL.ChangeToCharacterPhysics(inst)
            --      local x,y,z = inst.Transform:GetWorldPosition()
            --      inst.Transform:SetPosition(inst.posx,0,inst.posz)
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
            inst.sg.statemem.action = nil
        end
    }
)

-- Movement prediction client fix to see bell playing animation

AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "play_bell",
        tags = {"doing", "playing"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("bell", false)
            inst.AnimState:OverrideSymbol("bell01", "bell", "bell01")
            inst.AnimState:Show("ARM_normal")
            inst.components.inventory:ReturnActiveActionItem(
                inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil
            )
        end,
        timeline = {
            GLOBAL.TimeEvent(
                15 * GLOBAL.FRAMES,
                function(inst)
                    inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/glommer_bell")
                end
            ),
            GLOBAL.TimeEvent(
                60 * GLOBAL.FRAMES,
                function(inst)
                    inst:PerformBufferedAction()
                end
            )
        },
        events = {
            GLOBAL.EventHandler(
                "animover",
                function(inst)
                    if inst.AnimState:AnimDone() then
                        inst.sg:GoToState("idle")
                    end
                end
            )
        },
        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
        end
    }
)

local crop_dust =
    GLOBAL.State
    {
        name = "crop_dust",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("cropdust_pre")
            inst.AnimState:PushAnimation("cropdust_loop")
            inst.AnimState:PushAnimation("cropdust_loop")
            inst.AnimState:PushAnimation("cropdust_loop")			
            inst.AnimState:PushAnimation("cropdust_pst")					
        end,

        timeline =
        {
            GLOBAL.TimeEvent(10 * GLOBAL.FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/bugrepellent")
            end),
			
            GLOBAL.TimeEvent(4 * GLOBAL.FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),			
			
            GLOBAL.TimeEvent(20 * GLOBAL.FRAMES, function(inst)			
            if GLOBAL.TheWorld.ismastersim then
                    inst:PerformBufferedAction()
            end
            if not GLOBAL.TheWorld.ismastersim then
                    inst:PerformPreviewBufferedAction()
            end				
            end),				
        },

        events = {
            GLOBAL.EventHandler(
                "animover",
                function(inst)
                    if inst.AnimState:AnimDone() then
                        inst.sg:GoToState("idle")
                    end
                end
            )
        },
    }

AddStategraphState("wilson_client", crop_dust)
AddStategraphState("wilson", crop_dust)	


local surfando =
    GLOBAL.State{ name = "surfando",
        tags = {"canrotate"},
        
        onenter = function(inst)
            local action = inst:GetBufferedAction()
            inst.components.locomotor:Stop()
			inst.AnimState:PlayAnimation("surf_loop")
        end,
        
        timeline=
        {
		
         GLOBAL.TimeEvent(2 * GLOBAL.FRAMES, function(inst)
                    inst:PerformBufferedAction()
            end),
		

			
        },
        
        events=
        {
            GLOBAL.EventHandler("animqueueover", function(inst) inst.sg:GoToState("surfando") end),
        },
    }

AddStategraphState("wilson_client", surfando)
AddStategraphState("wilson", surfando)

-------------------------------------------------player actionhandler
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ACTIVATESAIL, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ACTIVATESAIL, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.COMPACTPOOP, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.COMPACTPOOP, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DESACTIVATESAIL, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DESACTIVATESAIL, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATREPAIR, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATREPAIR, "dolongaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.OPENTUNA, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.OPENTUNA, "dolongaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATCANNON, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATCANNON, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.RETRIEVE, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.RETRIEVE, "dolongaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SHOP, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SHOP, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SMELT, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SMELT, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.HARVEST1, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.HARVEST1, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.GIVE2, "give"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.GIVE2, "give"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.PAINT, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.PAINT, "dolongaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DISLODGE, "tap"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DISLODGE, "tap"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.GAS, "crop_dust"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.GAS, "crop_dust"))

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SURF, "surfando"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SURF, "surfando"))

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.INVESTIGATEGLASS, "investigate_start"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.INVESTIGATEGLASS, "investigate_start"))

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.FERTILIZECOFFEE, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.FERTILIZECOFFEE, "doshortaction"))

AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.BOATDISMOUNT,
        function(inst, action)
            local xm, ym, zm = action:GetActionPoint():Get()
            local passable = GLOBAL.TheWorld.Map:IsPassableAtPoint(xm, ym, zm)
            if inst:HasTag("player") and passable == true then
                inst.posx = xm
                inst.posz = zm
                inst:ForceFacePoint(xm, ym, zm)
                return "jumponboatstart_pre"
            end
        end
    )
)

AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.BOATDISMOUNT,
        function(inst, action)
            local xm, ym, zm = action:GetActionPoint():Get()
            local passable = GLOBAL.TheWorld.Map:IsPassableAtPoint(xm, ym, zm)
            if inst:HasTag("player") and passable == true then
                inst.posx = xm
                inst.posz = zm
                inst:ForceFacePoint(xm, ym, zm)
                return "jumponboatstart_pre"
            end
        end
    )
)

AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.HACK,
        function(inst)
            if inst:HasTag("beaver") then
                return not inst.sg:HasStateTag("gnawing") and "gnaw" or nil
            end

		local equipamento = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
        if equipamento and equipamento.prefab == "shears" then
		
		if not inst.sg:HasStateTag("preshear") then
        if inst.sg:HasStateTag("shearing") then
        return "shear"
        else
        return "shear_start"
        end
        end		
		end
			
			
            return not inst.sg:HasStateTag("prechop") and (inst.sg:HasStateTag("chopping") and "chop" or "chop_start") or nil
        end
    )
)

AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.HACK,
        function(inst)
            if inst:HasTag("beaver") then
                return not inst.sg:HasStateTag("gnawing") and "gnaw" or nil
            end
			
		local equipamento = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
--        if equipamento and equipamento.prefab == "shears" then
		
--		if not inst.sg:HasStateTag("preshear") then
--        if inst.sg:HasStateTag("shearing") then
--        return "shear"
--        else
--        return "shear_start"
--        end
--        end	
--		end
			
            return not inst.sg:HasStateTag("prechop") and "chop_start" or nil
        end
    )
)

AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.HACK1,
        function(inst)
            if inst:HasTag("beaver") then
                return not inst.sg:HasStateTag("gnawing") and "gnaw" or nil
            end
            return not inst.sg:HasStateTag("prechop") and (inst.sg:HasStateTag("chopping") and "chop" or "chop_start") or nil
        end
    )
)

AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(
	GLOBAL.ACTIONS.PAN, 
        function(inst) 
            if not inst.sg:HasStateTag("panning") then
                return "pan_start"
            end
        end)
)

AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(
	GLOBAL.ACTIONS.PAN, 
        function(inst) 
            if not inst.sg:HasStateTag("panning") then
                return "pan_start"
            end
        end)
)

AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(
        GLOBAL.ACTIONS.HACK1,
        function(inst)
            if inst:HasTag("beaver") then
                return not inst.sg:HasStateTag("gnawing") and "gnaw" or nil
            end
            return not inst.sg:HasStateTag("prechop") and "chop_start" or nil
        end
    )
)

AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(GLOBAL.ACTIONS.ATTACK,
        function(inst, action)
            inst.sg.mem.localchainattack = not action.forced or nil
            if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.components.health:IsDead()) then
                local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
                return (weapon == nil and "attack")
                    or (weapon:HasTag("blowdart") and "blowdart")
					or (weapon:HasTag("slingshot") and "slingshot_shoot")					
                    or (weapon:HasTag("thrown") and "throw")
                    or (weapon:HasTag("propweapon") and "attack_prop_pre")
                    or (weapon:HasTag("multithruster") and "multithrust_pre")
                    or (weapon:HasTag("helmsplitter") and "helmsplitter_pre")
                    or (weapon:HasTag("speargun") and "speargun")		
                    or (weapon:HasTag("blunderbuss") and "speargun")					
                    or "attack"
            end
			
        end
	)
)



AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(GLOBAL.ACTIONS.ATTACK,
        function(inst, action)
            if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.replica.health:IsDead()) then
                local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if equip == nil then
                    return "attack"
                end
                local inventoryitem = equip.replica.inventoryitem
                return (not (inventoryitem ~= nil and inventoryitem:IsWeapon()) and "attack")
                    or (equip:HasTag("blowdart") and "blowdart")
					or (equip:HasTag("slingshot") and "slingshot_shoot")					
                    or (equip:HasTag("thrown") and "throw")	
                    or (equip:HasTag("propweapon") and "attack_prop_pre")
                    or (equip:HasTag("speargun") and "speargun")		
                    or (equip:HasTag("blunderbuss") and "speargun")						
                    or "attack"
            end
        end
	)
)



local pan_start =	
    GLOBAL.State{ name = "pan_start",
        tags = {"prepan", "panning", "working"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("pan_pre")
        end,
        
        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end ),
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("pan") end),
        },
    }

	
local pan =	
    GLOBAL.State{
        name = "pan",
        tags = {"prepan", "panning", "working"},
        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("pan_loop",true) 
            inst.sg:SetTimeout(1 + math.random())            
        end,
    
        timeline=
        {
            GLOBAL.TimeEvent(6*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 
            GLOBAL.TimeEvent(14*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 

            GLOBAL.TimeEvent((6+15)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 
            GLOBAL.TimeEvent((14+15)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 

            GLOBAL.TimeEvent((6+30)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 
            GLOBAL.TimeEvent((14+30)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 

            GLOBAL.TimeEvent((6+45)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 
            GLOBAL.TimeEvent((14+45)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end),             

            GLOBAL.TimeEvent((6+60)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end), 
            GLOBAL.TimeEvent((14+60)*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/pool/pan") end),                         
        },

  
        ontimeout = function(inst)
            inst:PerformBufferedAction() 
            inst.sg:GoToState("idle", "pan_pst")
        end,        

        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle","pan_pst") end ),
            --EventHandler("animover", function(inst) 
            --    inst.sg:GoToState("idle","pan_pst")
            --end ),            
        },        
    }

AddStategraphState("wilson_client", pan_start)
AddStategraphState("wilson", pan_start)
AddStategraphState("wilson_client", pan)
AddStategraphState("wilson", pan)


local investigate_start =
    GLOBAL.State{ name = "investigate_start",
        tags = {"preinvestigate", "investigating", "working"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.sg:GoToState("investigate")
            --inst.AnimState:PlayAnimation("chop_pre")
        end,
        
        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end ),
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("investigate") end),
        },
    }

local investigate =
    GLOBAL.State { name = "investigate",
        tags = {"preinvestigate", "investigating", "working"},
        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("lens")
        end,
        
        timeline=
        {
            GLOBAL.TimeEvent(9*GLOBAL.FRAMES, function(inst)
                inst.sg:RemoveStateTag("preinvestigate")
            end),


            GLOBAL.TimeEvent(16*GLOBAL.FRAMES, function(inst) 
                inst.sg:RemoveStateTag("investigating")
            end),

            GLOBAL.TimeEvent(45*GLOBAL.FRAMES, function(inst)
                -- this covers both mystery and lighting now
                inst:PerformBufferedAction()               
            end),
        },
        
        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end ),
            GLOBAL.EventHandler("animover", function(inst)
                inst.sg:GoToState("investigate_post")
            end ),
        },
    }

local investigate_post =
    GLOBAL.State{ name = "investigate_post",
        tags = {"investigating", "working"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("lens_pst")
        end,
        
        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end ),
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    }
	
AddStategraphState("wilson_client", investigate_start)
AddStategraphState("wilson", investigate_start)
AddStategraphState("wilson_client", investigate)
AddStategraphState("wilson", investigate)
AddStategraphState("wilson_client", investigate_post)
AddStategraphState("wilson", investigate_post)	


local shearstart =
    GLOBAL.State{ name = "shear_start",
        tags = {"preshear", "shearing", "working"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("cut_pre")
        end,
        
        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end ),
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("shear") end),
        },
    }

local shearshear =
    GLOBAL.State{
        name = "shear",
        tags = {"preshear", "shearing", "working"},
        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("cut_loop")
        end,
        
        timeline=
        {
            TimeEvent(4*GLOBAL.FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/grass_tall/shears")
                inst:PerformBufferedAction() 
            end),


            GLOBAL.TimeEvent(9*GLOBAL.FRAMES, function(inst)
                inst.sg:RemoveStateTag("preshear")
            end),
            
            GLOBAL.TimeEvent(14*GLOBAL.FRAMES, function(inst)
                    
                    
                    if
					inst.components.playercontroller ~= nil and
                    inst.components.playercontroller:IsAnyOfControlsPressed(
                        CONTROL_PRIMARY,
                        CONTROL_ACTION,
                        CONTROL_CONTROLLER_ACTION) and
                    inst.sg.statemem.action and 
                    inst.sg.statemem.action:IsValid() and 
                    inst.sg.statemem.action.target and 
                    inst.sg.statemem.action.target:IsActionValid(inst.sg.statemem.action.action) and 
                    inst.sg.statemem.action.target.components.shearable then
                        inst:ClearBufferedAction()
                        inst:PushBufferedAction(inst.sg.statemem.action)
                end
            end),

            GLOBAL.TimeEvent(16*GLOBAL.FRAMES, function(inst) 
                inst.sg:RemoveStateTag("shearing")
            end),
        },
        
        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end ),
            GLOBAL.EventHandler("animover", function(inst) 
                --inst.AnimState:PlayAnimation("chop_pst") 
                inst.sg:GoToState("shear_end")
            end ),
        },
    }

local shearend =
    GLOBAL.State{ name = "shear_end",
        tags = {"working"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("cut_pst")
        end,

        events=
        {
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle")  end ),
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },        

    }

AddStategraphState("wilson_client", shearstart)
AddStategraphState("wilson", shearstart)
AddStategraphState("wilson_client", shearshear)
AddStategraphState("wilson", shearshear)
AddStategraphState("wilson_client", shearend)
AddStategraphState("wilson", shearend)
---------------------------------------------playable pets-------------------------------------
-----------------------------
if KnownModIndex:IsModEnabled("workshop-622471256") then


AddStategraphActionHandler("vargplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("treeplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("tentaclep", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("teenbirdp", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("tallbirdplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("smallbirdp", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("pigmanplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("moosegooseplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("mermplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("lavae", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("krampusp", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("hound", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("houndplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("hounddarkplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("houndplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("goatp", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("ghost", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("dragonplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("deerplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("clockwork3player", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("clockwork2player", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("clockwork1player", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("catplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("beefplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("bearplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("babydragonplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("babygooseplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("spider", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("spider_white", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("warriorp", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))
AddStategraphActionHandler("walrusplayer", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BOATMOUNT, "jumponboatstart_pre"))





local state_jumponboatstart_prepet =
    GLOBAL.State {
    name = "jumponboatstart_pre",
    tags = {"doing", "busy", "canrotate", "nomorph"},
    onenter = function(inst)
        inst.components.locomotor:Stop()
        local heavy = inst.replica.inventory:IsHeavyLifting()
	
			if inst.prefab == "moosegooseplayer" then
			inst.AnimState:PlayAnimation("glide")
			elseif inst.prefab == "blackspiderplayer" or inst.prefab == "whitespiderplayer" or inst.prefab == "warriorp" then	
            inst.AnimState:PlayAnimation("walk_pst")	
			elseif inst.prefab == "treeplayer" then	
            inst.AnimState:PlayAnimation("panic_pre")	
			elseif inst.prefab == "vargplayer" then	
            inst.AnimState:PlayAnimation("run_pre")		
			elseif inst.prefab == "babygooseplayer" then	
            inst.AnimState:PlayAnimation("takeoff_pre_vertical")	
			elseif inst.prefab == "houndplayer" or inst.prefab == "houndiceplayer" or inst.prefab == "houndredplayer" or inst.prefab == "hounddarkplayer" then    inst.AnimState:PlayAnimation("scared_pre")	
			elseif inst.prefab == "maggotplayer" then	
            inst.AnimState:PlayAnimation("atk_pre")	
			elseif inst.prefab == "bearplayer" then	
            inst.AnimState:PlayAnimation("walk_pre")
			elseif inst.prefab == "krampusp" then	
            inst.AnimState:PlayAnimation("run_pre")
			elseif inst.prefab == "smallbirdp" then	
            inst.AnimState:PlayAnimation("walk_pre")
			elseif inst.prefab == "tallbirdplayer" then	
            inst.AnimState:PlayAnimation("walk_pre")	
			elseif inst.prefab == "ghostplayer" then	
            inst.AnimState:PlayAnimation("hit")		
			
			
			else
            inst.AnimState:PlayAnimation("walk_pst")
			end
			
        inst.sg:SetTimeout(GLOBAL.FRAMES * 18)
    end,
    events = {
        GLOBAL.EventHandler(
            "animover",
            function(inst)
                if GLOBAL.TheWorld.ismastersim then
                    inst:PerformBufferedAction()
                end
                if not GLOBAL.TheWorld.ismastersim then
                    inst:PerformPreviewBufferedAction()
                end
            end
        )
    },
    onupdate = function(inst)
        if not GLOBAL.TheWorld.ismastersim then
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle", true)
            end
        end
    end,
    ontimeout = function(inst)
        if not GLOBAL.TheWorld.ismastersim then -- client
            inst:ClearBufferedAction()
        end
        inst.sg:GoToState("idle")
    end,
    onexit = function(inst)
        if inst.bufferedaction == inst.sg.statemem.action then
            inst:ClearBufferedAction()
        end
        inst.sg.statemem.action = nil
    end
}

local jumponboatstartpet =
    GLOBAL.State {
        name = "jumponboatstart",
        tags = {"doing", "busy"},
        onenter = function(inst)
            inst.Physics:ClearCollisionMask()
            inst.Physics:CollidesWith(GLOBAL.COLLISION.GROUND)
            inst.Physics:CollidesWith(GLOBAL.COLLISION.GIANTS)

            inst.sg.statemem.heavy = inst.replica.inventory:IsHeavyLifting()
			if inst.prefab == "moosegooseplayer" then
			inst.AnimState:PlayAnimation("glide")
			elseif inst.prefab == "blackspiderplayer" or inst.prefab == "whitespiderplayer" or inst.prefab == "warriorp" then	
            inst.AnimState:PlayAnimation("warrior_atk")	
			elseif inst.prefab == "whitespiderplayer" or inst.prefab == "wqueenspiderplayer" then	
            inst.AnimState:PlayAnimation("hit")		
			elseif inst.prefab == "babygooseplayer" then	
            inst.AnimState:PlayAnimation("action")	
			elseif inst.prefab == "treeplayer" then	
            inst.AnimState:PlayAnimation("panic_loop")	
			elseif inst.prefab == "vargplayer" then	
            inst.AnimState:PlayAnimation("run_loop")	
			elseif inst.prefab == "maggotplayer" then	
            inst.AnimState:PlayAnimation("atk")	
			elseif inst.prefab == "houndplayer" or inst.prefab == "houndiceplayer" or inst.prefab == "houndredplayer" or inst.prefab == "hounddarkplayer" then
			inst.AnimState:PlayAnimation("scared_loop")	 	
			elseif inst.prefab == "bearplayer" then	
            inst.AnimState:PlayAnimation("walk_pst")	
			elseif inst.prefab == "pigmanplayer" then	
            inst.AnimState:PlayAnimation("run_loop")			
			elseif inst.prefab == "mermplayer" then	
            inst.AnimState:PlayAnimation("run_loop")
			elseif inst.prefab == "mermplayer" then	
            inst.AnimState:PlayAnimation("walrusplayer")	
			elseif inst.prefab == "krampusp" then	
            inst.AnimState:PlayAnimation("run_loop")	
			elseif inst.prefab == "beefplayer" then	
            inst.AnimState:PlayAnimation("run_loop")
			elseif inst.prefab == "smallbirdp" then	
            inst.AnimState:PlayAnimation("walk_loop")
			elseif inst.prefab == "tallbirdplayer" then	
            inst.AnimState:PlayAnimation("walk_loop")	
			elseif inst.prefab == "clockwork1player" or inst.prefab == "clockwork2player" or inst.prefab == "clockwork3player" then	
            inst.AnimState:PlayAnimation("walk_loop")				
			elseif inst.prefab == "ghostplayer" then	
            inst.AnimState:PlayAnimation("appear")			
				
			else
            inst.AnimState:PlayAnimation("walk_pst")
			end

            inst.sg.statemem.action = inst.bufferedaction
            inst.sg:SetTimeout(30 * GLOBAL.FRAMES)
        end,
        timeline = {
            GLOBAL.TimeEvent(
                15.2 * GLOBAL.FRAMES,
                function(inst)
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            ),
            GLOBAL.TimeEvent(
                18 * GLOBAL.FRAMES,
                function(inst)
                    inst.Physics:Stop()
                end
            )
        },
        events = {
            GLOBAL.EventHandler(
                "animqueueover",
                function(inst)
                    --          local x,y,z = inst.Transform:GetWorldPosition()
                    if inst.AnimState:AnimDone() then
                        GLOBAL.ChangeToCharacterPhysics(inst)
                        --              inst.Transform:SetPosition(inst.posx,0,inst.posz)
                        inst.sg:GoToState("idle")
                    end

                    if inst.components.driver.mountdata then
                        inst.components.driver:OnMount(inst.components.driver.mountdata)
                    end
                end
            )
        },
        ontimeout = function(inst)
            if not GLOBAL.TheWorld.ismastersim then -- client
                inst:ClearBufferedAction()
            end
            GLOBAL.ChangeToCharacterPhysics(inst)
            --      local x,y,z = inst.Transform:GetWorldPosition()
            --      inst.Transform:SetPosition(inst.posx,0,inst.posz)
            inst.sg:GoToState("idle")
        end,
        onexit = function(inst)
            GLOBAL.ChangeToCharacterPhysics(inst)
            --      local x,y,z = inst.Transform:GetWorldPosition()
            --      inst.Transform:SetPosition(inst.posx,0,inst.posz)
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
            inst.sg.statemem.action = nil
        end
    }

	
AddStategraphState("vargplayer", jumponboatstartpet)
AddStategraphState("hound", jumponboatstartpet)
AddStategraphState("houndplayer", jumponboatstartpet)
AddStategraphState("hounddarkplayer", jumponboatstartpet)
AddStategraphState("treeplayer", jumponboatstartpet)
AddStategraphState("tentaclep", jumponboatstartpet)
AddStategraphState("teenbirdp", jumponboatstartpet)
AddStategraphState("tallbirdplayer", jumponboatstartpet)
AddStategraphState("smallbirdp", jumponboatstartpet)
AddStategraphState("pigmanplayer", jumponboatstartpet)
AddStategraphState("moosegooseplayer", jumponboatstartpet)
AddStategraphState("mermplayer", jumponboatstartpet)
AddStategraphState("lavae", jumponboatstartpet)
AddStategraphState("krampusp", jumponboatstartpet)
AddStategraphState("goatp", jumponboatstartpet)
AddStategraphState("ghost", jumponboatstartpet)
AddStategraphState("dragonplayer", jumponboatstartpet)
AddStategraphState("deerplayer", jumponboatstartpet)
AddStategraphState("clockwork3player", jumponboatstartpet)
AddStategraphState("clockwork2player", jumponboatstartpet)
AddStategraphState("clockwork1player", jumponboatstartpet)
AddStategraphState("catplayer", jumponboatstartpet)
AddStategraphState("beefplayer", jumponboatstartpet)
AddStategraphState("bearplayer", jumponboatstartpet)
AddStategraphState("babydragonplayer", jumponboatstartpet)
AddStategraphState("babygooseplayer", jumponboatstartpet)
AddStategraphState("spider", jumponboatstartpet)
AddStategraphState("spider_white", jumponboatstartpet)
AddStategraphState("warriorp", jumponboatstartpet)
AddStategraphState("walrusplayer", jumponboatstartpet)


AddStategraphState("vargplayer", state_jumponboatstart_prepet)
AddStategraphState("treeplayer", state_jumponboatstart_prepet)
AddStategraphState("tentaclep", state_jumponboatstart_prepet)
AddStategraphState("teenbirdp", state_jumponboatstart_prepet)
AddStategraphState("tallbirdplayer", state_jumponboatstart_prepet)
AddStategraphState("smallbirdp", state_jumponboatstart_prepet)
AddStategraphState("pigmanplayer", state_jumponboatstart_prepet)
AddStategraphState("moosegooseplayer", state_jumponboatstart_prepet)
AddStategraphState("mermplayer", state_jumponboatstart_prepet)
AddStategraphState("lavae", state_jumponboatstart_prepet)
AddStategraphState("krampusp", state_jumponboatstart_prepet)
AddStategraphState("hound", state_jumponboatstart_prepet)
AddStategraphState("houndplayer", state_jumponboatstart_prepet)
AddStategraphState("hounddarkplayer", state_jumponboatstart_prepet)
AddStategraphState("goatp", state_jumponboatstart_prepet)
AddStategraphState("ghost", state_jumponboatstart_prepet)
AddStategraphState("dragonplayer", state_jumponboatstart_prepet)
AddStategraphState("deerplayer", state_jumponboatstart_prepet)
AddStategraphState("clockwork3player", state_jumponboatstart_prepet)
AddStategraphState("clockwork2player", state_jumponboatstart_prepet)
AddStategraphState("clockwork1player", state_jumponboatstart_prepet)
AddStategraphState("catplayer", state_jumponboatstart_prepet)
AddStategraphState("beefplayer", state_jumponboatstart_prepet)
AddStategraphState("bearplayer", state_jumponboatstart_prepet)
AddStategraphState("babydragonplayer", state_jumponboatstart_prepet)
AddStategraphState("babygooseplayer", state_jumponboatstart_prepet)
AddStategraphState("spider", state_jumponboatstart_prepet)
AddStategraphState("spider_white", state_jumponboatstart_prepet)
AddStategraphState("warriorp", state_jumponboatstart_prepet)
AddStategraphState("walrusplayer", state_jumponboatstart_prepet)


-----------------------------------------------------------------------------------------------------
local function movimento(inst)
if inst:HasTag("aquatic") and inst.sg:HasStateTag("moving") then
if not inst.sg:HasStateTag("idle") then
inst.AnimState:PlayAnimation("idle_loop", true)
end
end
end

local function movimentobabygooseplayer(inst)
if inst:HasTag("aquatic") and inst.sg:HasStateTag("moving") then
if not inst.sg:HasStateTag("idle") then
inst.AnimState:PlayAnimation("idle", true)
end
end
end


AddPrefabPostInitAny(function(inst)

---------------------------------------------------------------------------------------------
if inst.prefab == "vargplayer" or inst.prefab == "dragonplayer" or inst.prefab == "bearplayer" or inst.prefab == "deerplayer" or inst.prefab == "pigmanplayer" or inst.prefab == "mermplayer" or inst.prefab == "walrusplayer" or inst.prefab == "tentaclep" or inst.prefab == "beefplayer" then


inst:ListenForEvent("locomote", movimento)
end

if inst.prefab == "smallbirdp" or inst.prefab == "ghostplayer" or inst.prefab == "tallbirdplayer" or inst.prefab == "krampusp" or inst.prefab == "maggotplayer" or inst.prefab == "moosegooseplayer" or inst.prefab == "houndplayer" or inst.prefab == "houndiceplayer" or inst.prefab == "houndredplayer" or inst.prefab == "hounddarkplayer" or inst.prefab == "babygooseplayer" or inst.prefab == "whitespiderplayer" or inst.prefab == "blackspiderplayer" or inst.prefab == "warriorp" 
or inst.prefab == "queenspiderplayer" or inst.prefab == "wqueenspiderplayer" then


inst:ListenForEvent("locomote", movimentobabygooseplayer)
end

end)


end

AddStategraphEvent("wilson", 
GLOBAL.EventHandler ("sanity_stun", 
        function (inst, data)
--            if not inst.components.inventory:IsItemNameEquipped("earmuffshat") then
                inst.sanity_stunned = true
                inst.sg:GoToState("sanity_stun")
                inst.components.sanity:DoDelta(-TUNING.SANITY_LARGE)

                inst:DoTaskInTime(data.duration, function()  
                    if inst.sg.currentstate.name == "sanity_stun" then
                        inst.sg:GoToState("idle")
                        inst.sanity_stunned = false
                        inst:PushEvent("sanity_stun_over")
                    end
                end)
  --          end
        end))

AddStategraphEvent("wilson_client", 
GLOBAL.EventHandler ("sanity_stun", 
        function (inst, data)
--            if not inst.components.inventory:IsItemNameEquipped("earmuffshat") then
                inst.sanity_stunned = true
                inst.sg:GoToState("sanity_stun")
                inst.components.sanity:DoDelta(-TUNING.SANITY_LARGE)

                inst:DoTaskInTime(data.duration, function()  
                    if inst.sg.currentstate.name == "sanity_stun" then
                        inst.sg:GoToState("idle")
                        inst.sanity_stunned = false
                        inst:PushEvent("sanity_stun_over")
                    end
                end)
  --          end
        end))

AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "sanity_stun",
        tags = { "busy" },
        
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("idle_sanity_pre", false)
            inst.AnimState:PushAnimation("idle_sanity_loop", true)
        end,

        events=
        {
            GLOBAL.EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end ),
        },
    })
	
	AddStategraphState(
    "wilson_client",
    GLOBAL.State {
        name = "sanity_stun",
        tags = { "busy" },
        
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("idle_sanity_pre", false)
            inst.AnimState:PushAnimation("idle_sanity_loop", true)
        end,

        events=
        {
            GLOBAL.EventHandler("animqueueover", function(inst) inst.sg:GoToState("idle") end ),
        },
    })
---------------------------------death boat-----------------------------------------
AddStategraphState(
    "wilson",
    GLOBAL.State {
        name = "death_boat",
        tags = {"busy", "nopredict", "nomorph", "drowning", "nointerrupt"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
         --   inst.AnimState:Hide("swap_arm_carry")
         --   inst.AnimState:PlayAnimation("sink")
			inst.AnimState:SetSortOrder(0)
			if inst.components.inventory ~= nil then
			inst.components.inventory:DropEverything(true)
			end
			
			
			
            if inst.components.driver then
			if inst.components.driver.vehicle then inst.components.driver.vehicle:Remove() end
			inst.AnimState:SetSortOrder(0)
            inst:RemoveTag("aquatic")
            inst:RemoveTag("sail")
            inst:RemoveTag("surf")
            inst:RemoveComponent("rowboatwakespawner")
            inst:RemoveComponent("driver")
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) then
            inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO):Remove()
            end
            end
----------------------------------------------------------------------------------------			
					
        end,
        timeline = {
            GLOBAL.TimeEvent(2 * GLOBAL.FRAMES, function(inst) inst.DynamicShadow:Enable(false)  end),
            GLOBAL.TimeEvent(3 * GLOBAL.FRAMES, function(inst) inst.sg:GoToState("idle")   end)	
        },
        events = {
            GLOBAL.EventHandler(
                "animover",
                function(inst)
                    if inst.AnimState:AnimDone() then
                        inst.sg:GoToState("idle")
                    end
                end
            )
        },
        onexit = function(inst)
            inst.DynamicShadow:Enable(true)
--			inst.components.health:SetVal(0, "drowning")
        end
    }
)

AddStategraphState(
    "wilson_client",
    GLOBAL.State {
        name = "death_boat",
        tags = {"busy", "nopredict", "nomorph", "drowning", "nointerrupt"},
        onenter = function(inst)
            inst.components.locomotor:Stop()
         --   inst.AnimState:Hide("swap_arm_carry")
         --   inst.AnimState:PlayAnimation("sink")
			inst.AnimState:SetSortOrder(0)
			if inst.components.inventory ~= nil then
			inst.components.inventory:DropEverything(true)
			end
			
			
			
            if inst.components.driver then
			if inst.components.driver.vehicle then inst.components.driver.vehicle:Remove() end
			inst.AnimState:SetSortOrder(0)
            inst:RemoveTag("aquatic")
            inst:RemoveTag("sail")
            inst:RemoveTag("surf")
            inst:RemoveComponent("rowboatwakespawner")
            inst:RemoveComponent("driver")
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) then
            inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO):Remove()
            end
            end
----------------------------------------------------------------------------------------			
					
        end,
        timeline = {
            GLOBAL.TimeEvent(2 * GLOBAL.FRAMES, function(inst) inst.DynamicShadow:Enable(false)  end),
            GLOBAL.TimeEvent(3 * GLOBAL.FRAMES, function(inst) inst.sg:GoToState("idle")   end)			
			
        },
        events = {
            GLOBAL.EventHandler(
                "animover",
                function(inst)
                    if inst.AnimState:AnimDone() then
                        inst.sg:GoToState("idle")
                    end
                end
            )
        },
        onexit = function(inst)
            inst.DynamicShadow:Enable(true)
--			inst.components.health:SetVal(0, "drowning")
        end
    }
)

--------------------------------------------------------------------------------------------------------------------

local tapserver =
 GLOBAL.State{
        name = "tap",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make_preview")
            inst.AnimState:PlayAnimation("tamp_pre")
            inst.AnimState:PushAnimation("tamp_loop", true)

            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(TIMEOUT)
        end,

        timeline =
        {
            GLOBAL.TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },

        onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.AnimState:PlayAnimation("tamp_pst")
                inst.sg:GoToState("idle", true)
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("tamp_pst")
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            inst.SoundEmitter:KillSound("make_preview")
        end,
    }


local tapstart =
    GLOBAL.State{
        name = "tap",
        tags = {"doing", "busy"},
        
        timeline=
        {
            GLOBAL.TimeEvent(4*GLOBAL.FRAMES, function( inst )
                inst.sg:RemoveStateTag("busy")
            end),
        },
        
        onenter = function(inst, timeout)

            inst.sg:SetTimeout(timeout or 1)
            inst.components.locomotor:Stop()    

            inst.AnimState:PlayAnimation("tamp_pre")    
        end,
        
        events=
        {
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("tap_loop") end ),
        },
    }

local taploop =	
    GLOBAL.State{
        name = "tap_loop",
        tags = {"doing"},

        onenter = function(inst, timeout)
            local targ = inst:GetBufferedAction() and inst:GetBufferedAction().target or nil
            inst.sg:SetTimeout(timeout or 1)
            inst.components.locomotor:Stop()         
            inst.AnimState:PushAnimation("tamp_loop",true)
        end,
        
        timeline=
        {
            GLOBAL.TimeEvent(1*GLOBAL.FRAMES, function( inst )
               inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/tamping_tool")
            end),
            GLOBAL.TimeEvent(8*GLOBAL.FRAMES, function( inst )
               inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/tamping_tool")
            end),            
            GLOBAL.TimeEvent(16*GLOBAL.FRAMES, function( inst )
               inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/tamping_tool")
            end),       
            GLOBAL.TimeEvent(24*GLOBAL.FRAMES, function( inst )
               inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/tamping_tool")
            end),       
            GLOBAL.TimeEvent(32*GLOBAL.FRAMES, function( inst )
               inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/harvested/tamping_tool")
            end),                   
        },
        
        ontimeout= function(inst)
            inst.AnimState:PlayAnimation("tamp_pst")
            inst.sg:GoToState("idle", false)
            inst:PerformBufferedAction()
        end,
    }
AddStategraphState("wilson_client", tapserver)
AddStategraphState("wilson", tapstart)
AddStategraphState("wilson", taploop)

-----------------------------------------------------------------------
local function ConfigureRunState(inst)
    if inst.components.rider:IsRiding() then
        inst.sg.statemem.riding = true
        inst.sg.statemem.groggy = inst:HasTag("groggy")
        inst.sg.statemem.hamfog = inst:HasTag("hamfogspeed")		
        inst.sg:AddStateTag("nodangle")
		
        local mount = inst.components.rider:GetMount()
        inst.sg.statemem.ridingwoby = mount and mount:HasTag("woby")		
		
    elseif inst.components.inventory:IsHeavyLifting() then
        inst.sg.statemem.heavy = true
    elseif inst:HasTag("wereplayer") then
        inst.sg.statemem.iswere = true
        if inst:HasTag("weremoose") then
            if inst:HasTag("groggy") or inst:HasTag("hamfogspeed") then
                inst.sg.statemem.moosegroggy = true
            else
                inst.sg.statemem.moose = true
            end
        elseif inst:HasTag("weregoose") then
            if inst:HasTag("groggy") or inst:HasTag("hamfogspeed") then
                inst.sg.statemem.goosegroggy = true
            else
                inst.sg.statemem.goose = true
            end
        elseif inst:HasTag("groggy") then
            inst.sg.statemem.groggy = true
        elseif inst:HasTag("hamfogspeed") then
            inst.sg.statemem.hamfog = true			
        else
            inst.sg.statemem.normal = true
        end
    elseif inst:GetStormLevel() >= TUNING.SANDSTORM_FULL_LEVEL and not inst.components.playervision:HasGoggleVision() then
        inst.sg.statemem.sandstorm = true
    elseif inst:HasTag("groggy") then
        inst.sg.statemem.groggy = true
    elseif inst:HasTag("hamfogspeed") then
        inst.sg.statemem.hamfog = true			
    elseif inst:IsCarefulWalking() then
        inst.sg.statemem.careful = true
    else
        inst.sg.statemem.normal = true
    end
end

local function GetRunStateAnim(inst)
    return (inst.sg.statemem.heavy and "heavy_walk")
        or (inst.sg.statemem.sandstorm and "sand_walk")
        or ((inst.sg.statemem.groggy or inst.sg.statemem.hamfog or inst.sg.statemem.moosegroggy or inst.sg.statemem.goosegroggy) and "idle_walk")
        or (inst.sg.statemem.careful and "careful_walk")
        or (inst.sg.statemem.ridingwoby and "run_woby")		
        or "run"
end

local function DoEquipmentFoleySounds(inst)
    for k, v in pairs(inst.components.inventory.equipslots) do
        if v.foleysound ~= nil then
            inst.SoundEmitter:PlaySound(v.foleysound, nil, nil, true)
        end
    end
end

local function DoFoleySounds(inst)
    DoEquipmentFoleySounds(inst)
    if inst.foleysound ~= nil then
        if not inst:HasTag("aquatic") then
            inst.SoundEmitter:PlaySound(inst.foleysound, nil, nil, true)
        end
    end
end

local function DoMountedFoleySounds(inst)
    DoEquipmentFoleySounds(inst)
    local saddle = inst.components.rider:GetSaddle()
    if saddle ~= nil and saddle.mounted_foleysound ~= nil then
        inst.SoundEmitter:PlaySound(saddle.mounted_foleysound, nil, nil, true)
    end
end

local DoRunSounds = function(inst)
    if inst:HasTag("aquatic") then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/boat/padle")
    end
    if inst.sg.mem.footsteps > 3 and not inst:HasTag("aquatic") then
        GLOBAL.PlayFootstep(inst, .6, true)
    else
        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
        if not inst:HasTag("aquatic") then
            GLOBAL.PlayFootstep(inst, 1, true)
        end
    end
end

local function PlayMooseFootstep(inst, volume, ispredicted)
    --moose footstep always full volume
    inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/moose/footstep", nil, nil, ispredicted)
    GLOBAL.PlayFootstep(inst, volume, ispredicted)
end

local function DoMooseRunSounds(inst)
    --moose footstep always full volume
    inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/moose/footstep", nil, nil, true)
    DoRunSounds(inst)
end

local function DoGooseStepFX(inst)
    if inst.components.drownable ~= nil and inst.components.drownable:IsOverWater() then
        SpawnPrefab("weregoose_splash_med"..tostring(math.random(2))).entity:SetParent(inst.entity)
    end
end

local function DoGooseWalkFX(inst)
    if inst.components.drownable ~= nil and inst.components.drownable:IsOverWater() then
        SpawnPrefab("weregoose_splash_less"..tostring(math.random(2))).entity:SetParent(inst.entity)
    end
end

local function DoGooseRunFX(inst)
    if inst.components.drownable ~= nil and inst.components.drownable:IsOverWater() then
        SpawnPrefab("weregoose_splash").entity:SetParent(inst.entity)
    else
        SpawnPrefab("weregoose_feathers"..tostring(math.random(3))).entity:SetParent(inst.entity)
    end
end

local boatrunstart =
    GLOBAL.State {
    name = "run_start",
    tags = {"moving", "running", "canrotate", "autopredict", "sailing"},
    onenter = function(inst)
        ConfigureRunState(inst)
        inst.components.locomotor:RunForward()
        if inst:HasTag("aquatic") then
			if inst.replica.inventory:IsHeavyLifting() then
				inst.AnimState:PlayAnimation("heavy_idle") 
			elseif inst:HasTag("surf") then 
				inst.AnimState:PlayAnimation("surf_pre") 
			elseif inst:HasTag("sail") then 
				inst.AnimState:PlayAnimation("sail_pre") 
			else 
				inst.AnimState:PlayAnimation("row_pre") 
			end
        else 
			inst.AnimState:PlayAnimation(GetRunStateAnim(inst) .. "_pre") 		
		end
        --goose footsteps should always be light			
		inst.sg.mem.footsteps = (inst.sg.statemem.goose or inst.sg.statemem.goosegroggy) and 4 or 0	
        if inst:HasTag("aquatic") then
            inst.AnimState:AddOverrideBuild("player_actions_paddle")
 --           if player_overrides[inst.prefab] then inst.AnimState:AddOverrideBuild(player_overrides[inst.prefab]) end
        end
    end,
    onupdate = function(inst)
        inst.components.locomotor:RunForward()
    end,
    timeline = {
        --mounted
        GLOBAL.TimeEvent(
            0,
            function(inst)
                if inst.sg.statemem.riding then
                    DoMountedFoleySounds(inst)
                end
            end
        ),
        --heavy lifting
        GLOBAL.TimeEvent(
            1 * GLOBAL.FRAMES,
            function(inst)
                if inst.sg.statemem.heavy then
                    GLOBAL.PlayFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end
        ),
		
            --moose
        GLOBAL.TimeEvent(2 * FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    PlayMooseFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end),		
		
        --unmounted
        GLOBAL.TimeEvent(
            4 * GLOBAL.FRAMES,
            function(inst)
                if inst.sg.statemem.normal then
                    GLOBAL.PlayFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end
        ),
        --mounted
        GLOBAL.TimeEvent(
            5 * GLOBAL.FRAMES,
            function(inst)
                if inst.sg.statemem.riding then
                    GLOBAL.PlayFootstep(inst, nil, true)
                end
            end
        ),
		
            --moose groggy
            TimeEvent(7 * FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    PlayMooseFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end),		
		
		
    },
    events = {
        GLOBAL.EventHandler(
            "animover",
            function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("run")
                end
            end
        )
    }
}
AddStategraphState("wilson", boatrunstart)

local boatrun =
    GLOBAL.State {
    name = "run",
    tags = {"moving", "running", "canrotate", "sailing"},
    onenter = function(inst)
        ConfigureRunState(inst)
        inst.components.locomotor:RunForward()

        if inst:HasTag("aquatic") and inst.components.rowboatwakespawner then
            inst.components.rowboatwakespawner:StartSpawning()
			
		local barco = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "ironwind" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/boatpropellor_lp", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "sail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_cloth", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "clothsail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_cloth", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "snakeskinsail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_snakeskin", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "feathersail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_feather", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "woodlegssail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_sealegs", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "malbatrossail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_sealegs", "sailmove" ) 
		end		
		
        end

        local anim = GetRunStateAnim(inst)
        
        if inst:HasTag("aquatic") then
			if inst.replica.inventory:IsHeavyLifting() then
				anim = "heavy_idle"
			elseif inst:HasTag("surf") then 
				anim = "surf_loop" 
			elseif inst:HasTag("sail") then 
				anim =  "sail_loop" 
			elseif inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "oar_driftwood" then
				anim = "row_medium"
			elseif inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "oar" then
				anim = "row_medium"
			else
				anim = "row_loop" 
			end
        elseif anim == "run" then
		
		
		if inst:HasTag("wilbur") and inst.timeinmotion and inst.timeinmotion > 75  and not inst.replica.rider:IsRiding() and not inst.replica.inventory:IsHeavyLifting() and not inst:IsCarefulWalking() and not inst.sg:HasStateTag("jumping") then
		inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED + 2.5
		if inst.components.hunger then inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.33) end
		inst.Transform:SetSixFaced()
		inst.AnimState:SetBank("wilbur_run")
		inst.AnimState:SetBuild("wilbur_run")
		if inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
		inst.AnimState:Show("TAIL_carry")
		inst.AnimState:Hide("TAIL_normal")
		end			
		end	
			
            anim = "run_loop"		
        elseif anim == "run_woby" then
            anim = "run_woby_loop"
        end
        

        if not inst.AnimState:IsCurrentAnimation(anim) then
            inst.AnimState:PlayAnimation(anim, true)
        end

        inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + .5 * GLOBAL.FRAMES)
    end,
    onupdate = function(inst)
        inst.components.locomotor:RunForward()
    end,
	
    timeline = {
        --unmounted
        GLOBAL.TimeEvent(
            7 * GLOBAL.FRAMES,
            function(inst)
                if inst.sg.statemem.normal then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end
        ),
        GLOBAL.TimeEvent(
            15 * GLOBAL.FRAMES,
            function(inst)
                if inst.sg.statemem.normal then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end
        ),
        --careful
        --Frame 11 shared with heavy lifting below
        --[[GLOBAL.TimeEvent(11 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
        GLOBAL.TimeEvent(
            26 * GLOBAL.FRAMES,
            function(inst)
                if inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end
        ),
        --sandstorm
        --Frame 12 shared with groggy below
        --[[GLOBAL.TimeEvent(12 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
        GLOBAL.TimeEvent(
            23 * GLOBAL.FRAMES,
            function(inst)
                if inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end
        ),
        --groggy	
        GLOBAL.TimeEvent(1 * FRAMES, function(inst)
                if inst.sg.statemem.groggy or inst.sg.statemem.hamfog then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                elseif inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseRunFX(inst)
                end
            end),
        GLOBAL.TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.groggy or inst.sg.statemem.hamfog or
                    inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),		
		
            --heavy lifting
            GLOBAL.TimeEvent(11 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    if inst.sg.mem.footsteps > 3 then
                        --normally stops at > 3, but heavy needs to keep count
                        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
                    end
                elseif inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                elseif inst.sg.statemem.sandstorm
                    or inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(36 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    if inst.sg.mem.footsteps > 12 then
                        inst.sg.mem.footsteps = math.random(4, 6)
                        inst:PushEvent("encumberedwalking")
                    elseif inst.sg.mem.footsteps > 3 then
                        --normally stops at > 3, but heavy needs to keep count
                        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
                    end
                end
            end),
            --mounted
            GLOBAL.TimeEvent(0 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    DoMountedFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(5 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    DoRunSounds(inst)
                end
            end),

            --moose
            --Frame 11 shared with heavy lifting above
            --[[TimeEvent(11 * FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            GLOBAL.TimeEvent(24 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --moose groggy
            GLOBAL.TimeEvent(14 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(30 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --goose
            --Frame 1 shared with groggy above
            --[[TimeEvent(1 * FRAMES, function(inst)
                if inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseRunFX(inst)
                end
            end),]]
            GLOBAL.TimeEvent(9 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseRunFX(inst)
                end
            end),

            --goose groggy
            GLOBAL.TimeEvent(4 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goosegroggy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseWalkFX(inst)
                end
            end),
            GLOBAL.TimeEvent(17 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goosegroggy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseWalkFX(inst)
                end
            end),
    },
    events = {
            GLOBAL.EventHandler("gogglevision", function(inst, data)
                if data.enabled then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.iswere or
                            inst.sg.statemem.sandstorm or
                            inst:GetStormLevel() < TUNING.SANDSTORM_FULL_LEVEL) then
                    inst.sg:GoToState("run")
                end
            end),
            GLOBAL.EventHandler("sandstormlevel", function(inst, data)
                if data.level < TUNING.SANDSTORM_FULL_LEVEL then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.iswere or
                            inst.sg.statemem.sandstorm or
                            inst.components.playervision:HasGoggleVision()) then
                    inst.sg:GoToState("run")
                end
            end),
            GLOBAL.EventHandler("carefulwalking", function(inst, data)
                if not data.careful then
                    if inst.sg.statemem.careful then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.sandstorm or
                            inst.sg.statemem.groggy or
                            inst.sg.statemem.hamfog or							
                            inst.sg.statemem.careful or
                            inst.sg.statemem.iswere) then
                    inst.sg:GoToState("run")
                end
            end),
    },
	
        onexit = function(inst)	
		if inst:HasTag("wilbur") and not inst.replica.rider:IsRiding() and not inst.replica.inventory:IsHeavyLifting() and not inst:IsCarefulWalking() then
		inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED-0.5
		if inst.components.hunger then inst.components.hunger:SetRate(1*TUNING.WILSON_HUNGER_RATE) end
		inst.AnimState:SetBank("wilson")
		inst.AnimState:SetBuild(inst.prefab)
		inst.Transform:SetFourFaced()
		inst.AnimState:Hide("TAIL_carry")
		inst.AnimState:Show("TAIL_normal")
		end				
        end,		
	
    ontimeout = function(inst)
        inst.sg:GoToState("run")
    end
	
}
AddStategraphState("wilson", boatrun)

local boatrunstop =
    GLOBAL.State {
    name = "run_stop",
    tags = {"canrotate", "idle", "sailing"},
    onenter = function(inst)
	

	
        ConfigureRunState(inst)

        if inst:HasTag("aquatic") and inst.components.rowboatwakespawner then
            inst.components.rowboatwakespawner:StopSpawning()
			
			inst.SoundEmitter:KillSound("sailmove")
			
        end

        inst.components.locomotor:Stop()
        if inst:HasTag("aquatic") then
			if inst.replica.inventory:IsHeavyLifting() then
				inst.AnimState:PlayAnimation("heavy_idle") 
			elseif inst:HasTag("surf") then 
				inst.AnimState:PlayAnimation("surf_pst") 
			elseif inst:HasTag("sail") then 
				inst.AnimState:PlayAnimation("sail_pst") 
			else 
				inst.AnimState:PlayAnimation("row_pst") 
			end
        else 
			inst.AnimState:PlayAnimation(GetRunStateAnim(inst) .. "_pst") 
			
            if inst.sg.statemem.moose or inst.sg.statemem.moosegroggy then
                PlayMooseFootstep(inst, .6, true)
                DoFoleySounds(inst)
            end			
		end
    end,
	
        timeline =
        {
            GLOBAL.TimeEvent(GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goose or inst.sg.statemem.goosegroggy then
                    GLOBAL.PlayFootstep(inst, .5, true)
                    DoFoleySounds(inst)
                    if inst.sg.statemem.goosegroggy then
                        DoGooseWalkFX(inst)
                    else
                        DoGooseStepFX(inst)
                    end
                end
            end),
        },		
	
    events = {
        GLOBAL.EventHandler(
            "animover",
            function(inst)
                if inst.AnimState:AnimDone() then
--              if inst:HasTag("aquatic") then 
--              inst.sg:GoToState("brake") 
--              else            
                    inst.sg:GoToState("idle") --end
                end
                
                if inst:HasTag("aquatic") then
                    inst.AnimState:ClearOverrideBuild("player_actions_paddle")
--					if player_overrides[inst.prefab] then inst.AnimState:ClearOverrideBuild(player_overrides[inst.prefab]) end
                end
            end
        )
    }
}
AddStategraphState("wilson", boatrunstop)



--------------------------
AddStategraphActionHandler(
    "wilson",
    GLOBAL.ActionHandler(GLOBAL.ACTIONS.SLEEPIN,
        function(inst, action)
            if action.invobject ~= nil then
                if action.invobject.onuse ~= nil then
                    action.invobject:onuse(inst)
                end
                return "bedroll"
            elseif action.target:HasTag("cama") then
			local x, y, z = action.target.Transform:GetWorldPosition()
			action.doer.Transform:SetPosition(x+0.02, y, z+0.02)
                return "bedroll1"
			else
                return "tent"			
            end
        end)
)

AddStategraphActionHandler(
    "wilson_client",
    GLOBAL.ActionHandler(GLOBAL.ACTIONS.SLEEPIN,
        function(inst, action)
			if action and action.target and action.target:HasTag("cama") then
			local x, y, z = action.target.Transform:GetWorldPosition()	
			action.doer.Transform:SetPosition(x+0.02, y, z+0.02)
			end
            return action.invobject ~= nil and "bedroll" or action.target:HasTag("cama") and "bedroll1" or "tent"
        end)
)	

local function SetSleeperSleepState(inst)
    if inst.components.grue ~= nil then
        inst.components.grue:AddImmunity("sleeping")
    end
    if inst.components.talker ~= nil then
        inst.components.talker:IgnoreAll("sleeping")
    end
    if inst.components.firebug ~= nil then
        inst.components.firebug:Disable()
    end
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:EnableMapControls(false)
        inst.components.playercontroller:Enable(false)
    end
    inst:OnSleepIn()
    inst.components.inventory:Hide()
    inst:PushEvent("ms_closepopups")
    inst:ShowActions(false)
end

local function SetSleeperAwakeState(inst)
    if inst.components.grue ~= nil then
        inst.components.grue:RemoveImmunity("sleeping")
    end
    if inst.components.talker ~= nil then
        inst.components.talker:StopIgnoringAll("sleeping")
    end
    if inst.components.firebug ~= nil then
        inst.components.firebug:Enable()
    end
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:EnableMapControls(true)
        inst.components.playercontroller:Enable(true)
    end
    inst:OnWakeUp()
    inst.components.inventory:Show()
    inst:ShowActions(true)
end

AddStategraphState(
    "wilson",
    GLOBAL.State{
        name = "bedroll1",
        tags = { "bedroll", "busy", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
			inst.Transform:SetRotation(180)

            local failreason =
                (GLOBAL.TheWorld.state.isday and
                    (GLOBAL.TheWorld:HasTag("cave") and "ANNOUNCE_NODAYSLEEP_CAVE" or "ANNOUNCE_NODAYSLEEP")
                )
                -- you can still sleep if your hunger will bottom out, but not absolutely
                or (inst.components.hunger.current < TUNING.CALORIES_MED and "ANNOUNCE_NOHUNGERSLEEP")
                or nil

            if failreason ~= nil then
                inst:PushEvent("performaction", { action = inst.bufferedaction })
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle")
                if inst.components.talker ~= nil then
                    inst.components.talker:Say(GLOBAL.GetString(inst, failreason))
                end
                return
            end
            inst.AnimState:PlayAnimation("bedroll_sleep_loop")

            SetSleeperSleepState(inst)
        end,

        timeline =
        {
            TimeEvent(20 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_bedroll")
            end),
        },

        events =
        {
            EventHandler("firedamage", function(inst)
                if inst.sg:HasStateTag("sleeping") then
                    inst.sg.statemem.iswaking = true
                    inst.sg:GoToState("wakeup")
                end
            end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    if GLOBAL.TheWorld.state.isday or
                        (inst.components.health ~= nil and inst.components.health.takingfiredamage) or
                        (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
                        inst:PushEvent("performaction", { action = inst.bufferedaction })
                        inst:ClearBufferedAction()
                        inst.sg.statemem.iswaking = true
                        inst.sg:GoToState("wakeup")
                    elseif inst:GetBufferedAction() then
                        inst:PerformBufferedAction()
                        if inst.components.playercontroller ~= nil then
                            inst.components.playercontroller:Enable(true)
                        end
                        inst.sg:AddStateTag("sleeping")
                        inst.sg:AddStateTag("silentmorph")
                        inst.sg:RemoveStateTag("nomorph")
                        inst.sg:RemoveStateTag("busy")
                        inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
                    else
                        inst.sg.statemem.iswaking = true
                        inst.sg:GoToState("wakeup")
                    end
                end
            end),
        },

        onexit = function(inst)
            if inst.sleepingbag ~= nil then
                --Interrupted while we are "sleeping"
                inst.sleepingbag.components.sleepingbag:DoWakeUp(true)
                inst.sleepingbag = nil
                SetSleeperAwakeState(inst)
            elseif not inst.sg.statemem.iswaking then
                --Interrupted before we are "sleeping"
                SetSleeperAwakeState(inst)
            end
        end,
    })
	
	
AddStategraphState(
    "wilson_client",
    GLOBAL.State
    {
        name = "bedroll1",
        tags = { "bedroll", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
			inst.Transform:SetRotation(180)
            inst.AnimState:PlayAnimation("bedroll_sleep_loop")

            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(TIMEOUT)
        end,

        onupdate = function(inst)
            if inst:HasTag("busy") or inst:HasTag("sleeping") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle")
        end,
    })
-----------------

local function ClearStatusAilments(inst)
    if inst.components.freezable ~= nil and inst.components.freezable:IsFrozen() then
        inst.components.freezable:Unfreeze()
    end
    if inst.components.pinnable ~= nil and inst.components.pinnable:IsStuck() then
        inst.components.pinnable:Unstick()
    end
end

local function ForceStopHeavyLifting(inst)
    if inst.components.inventory:IsHeavyLifting() then
        inst.components.inventory:DropItem(inst.components.inventory:Unequip(EQUIPSLOTS.BODY), true, true)
    end
end

local function DoMountSound(inst, mount, sound)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, true)
    end
end


AddStategraphState(
    "wilson",
    GLOBAL.State{
        name = "death",
        tags = { "busy", "dead", "pausepredict", "nomorph" },

        onenter = function(inst)
		
			if inst:HasTag("aquatic") then
			if inst.components.inventory ~= nil then
			inst.components.inventory:DropEverything(true)
			end
			
            if inst.components.driver then
			if inst.components.driver.vehicle then inst.components.driver.vehicle:Remove() end
			inst.AnimState:SetSortOrder(0)
            inst:RemoveTag("aquatic")
            inst:RemoveTag("sail")
            inst:RemoveTag("surf")
            inst:RemoveComponent("rowboatwakespawner")
            inst:RemoveComponent("driver")
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO) then
            inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO):Remove()
            end
            end
			end
		
--            GLOBAL.assert(inst.deathcause ~= nil, "Entered death state without cause.")

            ClearStatusAilments(inst)
            ForceStopHeavyLifting(inst)

            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()

            if inst.components.rider:IsRiding() then
                DoMountSound(inst, inst.components.rider:GetMount(), "yell")
                inst.AnimState:PlayAnimation("fall_off")
                inst.sg:AddStateTag("dismounting")
            else
                if not inst:HasTag("wereplayer") then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/death")
                elseif inst:HasTag("beaver") then
                    inst.sg.statemem.beaver = true
                elseif inst:HasTag("weremoose") then
                    inst.sg.statemem.moose = true
                else--if inst:HasTag("weregoose") then
                    inst.sg.statemem.goose = true
                end

                if inst.deathsoundoverride ~= nil then
                    inst.SoundEmitter:PlaySound(inst.deathsoundoverride)
                elseif not inst:HasTag("mime") then
                    inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/death_voice")
                end

                if GLOBAL.HUMAN_MEAT_ENABLED then
                    inst.components.inventory:GiveItem(SpawnPrefab("humanmeat")) -- Drop some player meat!
                end
                if inst.components.revivablecorpse ~= nil then
                    inst.AnimState:PlayAnimation("death2")
                else
                    inst.components.inventory:DropEverything(true)
                    inst.AnimState:PlayAnimation("death")
                end

                inst.AnimState:Hide("swap_arm_carry")
            end

            inst.components.burnable:Extinguish()

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
                inst.components.playercontroller:Enable(false)
            end

            --Don't process other queued events if we died this frame
            inst.sg:ClearBufferedEvents()
        end,

        timeline =
        {
            TimeEvent(15 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.beaver then
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                elseif inst.sg.statemem.goose then
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                    DoGooseRunFX(inst)
                end
            end),
            TimeEvent(20 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),
        },

        onexit = function(inst)
            --You should never leave this state once you enter it!
--            if inst.components.revivablecorpse == nil then
--                GLOBAL.assert(false, "Left death state.")
--            end
        end,

        events =
        {
            GLOBAL.EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg:HasStateTag("dismounting") then
                        inst.sg:RemoveStateTag("dismounting")
                        inst.components.rider:ActualDismount()

                        inst.SoundEmitter:PlaySound("dontstarve/wilson/death")

                        if not inst:HasTag("mime") then
                            inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/death_voice")
                        end

                        if GLOBAL.HUMAN_MEAT_ENABLED then
                            inst.components.inventory:GiveItem(SpawnPrefab("humanmeat")) -- Drop some player meat!
                        end
                        if inst.components.revivablecorpse ~= nil then
                            inst.AnimState:PlayAnimation("death2")
                        else
                            inst.components.inventory:DropEverything(true)
                            inst.AnimState:PlayAnimation("death")
                        end

                        inst.AnimState:Hide("swap_arm_carry")
                    elseif inst.components.revivablecorpse ~= nil then
                        inst.sg:GoToState("corpse")
                    else
                        inst:PushEvent(inst.ghostenabled and "makeplayerghost" or "playerdied", { skeleton = GLOBAL.TheWorld.Map:IsPassableAtPoint(inst.Transform:GetWorldPosition()) }) -- if we are not on valid ground then don't drop a skeleton
                    end
                end
            end),
        },
    })

------------------------
AddStategraphState(
    "wilson",
    GLOBAL.State{
        name = "reviver_rebirth",
        tags = { "busy", "reviver_rebirth", "pausepredict", "silentmorph", "ghostbuild" },

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()

            GLOBAL.SpawnPrefab("ghost_transform_overlay_fx").entity:SetParent(inst.entity)

            inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_get_bloodpump")
            if inst.CustomSetSkinMode ~= nil then
                inst:CustomSetSkinMode(inst.overrideghostskinmode or "ghost_skin")
            else
                inst.AnimState:SetBank("ghost")
                inst.components.skinner:SetSkinMode(inst.overrideghostskinmode or "ghost_skin")
            end
            inst.AnimState:PlayAnimation("shudder")
            inst.AnimState:PushAnimation("brace", false)
            inst.AnimState:PushAnimation("transform", false)
            inst.components.health:SetInvincible(true)
            inst:ShowHUD(false)
--            inst:SetCameraDistance(14)

            inst:PushEvent("startghostbuildinstate")
        end,

        timeline =
        {
            GLOBAL.TimeEvent(88 * GLOBAL.FRAMES, function(inst)
                inst.DynamicShadow:Enable(true)
                if inst.CustomSetSkinMode ~= nil then
                    inst:CustomSetSkinMode(inst.overrideskinmode or "normal_skin")
                else
                    inst.AnimState:SetBank("wilson")
                    inst.components.skinner:SetSkinMode(inst.overrideskinmode or "normal_skin")
                end
                inst.AnimState:PlayAnimation("transform_end")
                inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_use_bloodpump")
                inst.sg:RemoveStateTag("ghostbuild")
                inst:PushEvent("stopghostbuildinstate")
            end),
            GLOBAL.TimeEvent(89 * GLOBAL.FRAMES, function(inst)
                if inst:HasTag("weregoose") then
                    DoGooseRunFX(inst)
                end
            end),
            GLOBAL.TimeEvent(96 * GLOBAL.FRAMES, function(inst) 
                inst.components.bloomer:PopBloom("playerghostbloom")
                inst.AnimState:SetLightOverride(0)
            end),
        },

        events =
        {
            GLOBAL.EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            --In case of interruptions
            inst.DynamicShadow:Enable(true)
            if inst.CustomSetSkinMode ~= nil then
                inst:CustomSetSkinMode(inst.overrideskinmode or "normal_skin")
            else
                inst.AnimState:SetBank("wilson")
                inst.components.skinner:SetSkinMode(inst.overrideskinmode or "normal_skin")
            end
            inst.components.bloomer:PopBloom("playerghostbloom")
            inst.AnimState:SetLightOverride(0)
            if inst.sg:HasStateTag("ghostbuild") then
                inst.sg:RemoveStateTag("ghostbuild")
                inst:PushEvent("stopghostbuildinstate")
            end
            --
            inst.components.health:SetInvincible(false)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end

            inst:ShowHUD(true)
--            inst:SetCameraDistance()

            GLOBAL.SerializeUserSession(inst)
        end,
    })


AddStategraphState(
    "wilson",
    GLOBAL.State{
        name = "amulet_rebirth",
        tags = { "busy", "nopredict", "silentmorph" },

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.AnimState:PlayAnimation("amulet_rebirth")
            inst.AnimState:OverrideSymbol("FX", "player_amulet_resurrect", "FX")
            inst.components.health:SetInvincible(true)
            inst:ShowHUD(false)
--            inst:SetCameraDistance(14)

            local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if item ~= nil and item.prefab == "amulet" then
                item = inst.components.inventory:RemoveItem(item)
                if item ~= nil then
                    item:Remove()
                    inst.sg.statemem.usedamulet = true
                end
            end
        end,

        timeline =
        {
            GLOBAL.TimeEvent(0, function(inst)
                local stafflight = SpawnPrefab("staff_castinglight")
                stafflight.Transform:SetPosition(inst.Transform:GetWorldPosition())
                stafflight:SetUp({ 150 / 255, 46 / 255, 46 / 255 }, 1.7, 1)
                inst.SoundEmitter:PlaySound("dontstarve/common/rebirth_amulet_raise")
            end),
            GLOBAL.TimeEvent(60 * GLOBAL.FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/rebirth_amulet_poof")
            end),
            GLOBAL.TimeEvent(80 * GLOBAL.FRAMES, function(inst)
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x, y, z, 10)
                for k, v in pairs(ents) do
                    if v ~= inst and v.components.sleeper ~= nil then
                        v.components.sleeper:GoToSleep(20)
                    end
                end
            end),
        },

        events =
        {
            GLOBAL.EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.usedamulet and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) == nil then
                inst.AnimState:ClearOverrideSymbol("swap_body")
            end
            inst:ShowHUD(true)
--            inst:SetCameraDistance()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            inst.components.health:SetInvincible(false)
            inst.AnimState:ClearOverrideSymbol("FX")

            GLOBAL.SerializeUserSession(inst)
        end,
    })


AddStategraphState(
    "wilson",
    GLOBAL.State{
        name = "corpse_rebirth",
        tags = { "busy", "noattack", "nopredict", "nomorph" },

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
                inst.components.playercontroller:Enable(false)
            end
            inst.AnimState:PlayAnimation("death2_idle")

            inst.components.health:SetInvincible(true)
            inst:ShowActions(false)
--            inst:SetCameraDistance(14)
        end,

        timeline =
        {
            GLOBAL.TimeEvent(53 * GLOBAL.FRAMES, function(inst)
                inst.components.bloomer:PushBloom("corpse_rebirth", "shaders/anim.ksh", -2)
                inst.sg.statemem.fadeintime = (86 - 53) * GLOBAL.FRAMES
                inst.sg.statemem.fadetime = 0
            end),
            GLOBAL.TimeEvent(86 * GLOBAL.FRAMES, function(inst)
                inst.sg.statemem.physicsrestored = true
                inst.Physics:ClearCollisionMask()
                inst.Physics:CollidesWith(COLLISION.WORLD)
                inst.Physics:CollidesWith(COLLISION.OBSTACLES)
                inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)
                inst.Physics:CollidesWith(COLLISION.GIANTS)

                inst.AnimState:PlayAnimation("corpse_revive")
                if inst.sg.statemem.fade ~= nil then
                    inst.sg.statemem.fadeouttime = 20 * GLOBAL.FRAMES
                    inst.sg.statemem.fadetotal = inst.sg.statemem.fade
                end
                inst.sg.statemem.fadeintime = nil
            end),
            GLOBAL.TimeEvent((86 + 20) * GLOBAL.FRAMES, function(inst)
                inst.components.bloomer:PopBloom("corpse_rebirth")
            end),
        },

        onupdate = function(inst, dt)
            if inst.sg.statemem.fadeouttime ~= nil then
                inst.sg.statemem.fade = math.max(0, inst.sg.statemem.fade - inst.sg.statemem.fadetotal * dt / inst.sg.statemem.fadeouttime)
                if inst.sg.statemem.fade > 0 then
                    inst.components.colouradder:PushColour("corpse_rebirth", inst.sg.statemem.fade, inst.sg.statemem.fade, inst.sg.statemem.fade, 0)
                else
                    inst.components.colouradder:PopColour("corpse_rebirth")
                    inst.sg.statemem.fadeouttime = nil
                end
            elseif inst.sg.statemem.fadeintime ~= nil then
                local k = 1 - inst.sg.statemem.fadetime / inst.sg.statemem.fadeintime
                inst.sg.statemem.fade = .8 * (1 - k * k)
                inst.components.colouradder:PushColour("corpse_rebirth", inst.sg.statemem.fade, inst.sg.statemem.fade, inst.sg.statemem.fade, 0)
                inst.sg.statemem.fadetime = inst.sg.statemem.fadetime + dt
            end
        end,

        events =
        {
            GLOBAL.EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() and inst.AnimState:IsCurrentAnimation("corpse_revive") then
                    inst.components.talker:Say(GLOBAL.GetString(inst, "ANNOUNCE_REVIVED_FROM_CORPSE"))
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst:ShowActions(true)
            --inst:SetCameraDistance()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            inst.components.health:SetInvincible(false)

            inst.components.bloomer:PopBloom("corpse_rebirth")
            inst.components.colouradder:PopColour("corpse_rebirth")

            if not inst.sg.statemem.physicsrestored then
                inst.Physics:ClearCollisionMask()
                inst.Physics:CollidesWith(COLLISION.WORLD)
                inst.Physics:CollidesWith(COLLISION.OBSTACLES)
                inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)
                inst.Physics:CollidesWith(COLLISION.GIANTS)
            end

            GLOBAL.SerializeUserSession(inst)
        end,
    })
-------------------------------

local function DoEquipmentFoleySounds(inst)
    local inventory = inst.replica.inventory
    if inventory ~= nil then
        for k, v in pairs(inventory:GetEquips()) do
            if v.foleysound ~= nil then
                inst.SoundEmitter:PlaySound(v.foleysound, nil, nil, true)
            end
        end
    end
end

local function DoFoleySounds(inst)
    DoEquipmentFoleySounds(inst)
    if inst.foleysound ~= nil then
        inst.SoundEmitter:PlaySound(inst.foleysound, nil, nil, true)
    end
end

local function DoMountedFoleySounds(inst)
    DoEquipmentFoleySounds(inst)
    local rider = inst.replica.rider
    local saddle = rider ~= nil and rider:GetSaddle() or nil
    if saddle ~= nil and saddle.mounted_foleysound ~= nil then
        inst.SoundEmitter:PlaySound(saddle.mounted_foleysound, nil, nil, true)
    end
end

local function DoRunSounds(inst)
    if inst:HasTag("aquatic") then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/boat/padle")
    end
    if inst.sg.mem.footsteps > 3 and not inst:HasTag("aquatic") then
        GLOBAL.PlayFootstep(inst, .6, true)
    else
        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
        if not inst:HasTag("aquatic") then
            GLOBAL.PlayFootstep(inst, 1, true)
        end
    end	
end

local function PlayMooseFootstep(inst, volume, ispredicted)
    --moose footstep always full volume
    inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/moose/footstep", nil, nil, ispredicted)
    GLOBAL.PlayFootstep(inst, volume, ispredicted)
end

local function DoMooseRunSounds(inst)
    --moose footstep always full volume
    inst.SoundEmitter:PlaySound("dontstarve/characters/woodie/moose/footstep", nil, nil, true)
    DoRunSounds(inst)
end

local function DoMountSound(inst, mount, sound)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, true)
    end
end

local function ConfigureRunState(inst)
    if inst.replica.rider ~= nil and inst.replica.rider:IsRiding() then
        inst.sg.statemem.riding = true
        inst.sg.statemem.groggy = inst:HasTag("groggy")
        inst.sg.statemem.hamfog = inst:HasTag("hamfogspeed")		
    elseif inst.replica.inventory:IsHeavyLifting() then
        inst.sg.statemem.heavy = true
    elseif inst:HasTag("wereplayer") then
        inst.sg.statemem.iswere = true
        if inst:HasTag("weremoose") then
            if inst:HasTag("groggy") or inst:HasTag("hamfogspeed") then
                inst.sg.statemem.moosegroggy = true
            else
                inst.sg.statemem.moose = true
            end
        elseif inst:HasTag("weregoose") then
            if inst:HasTag("groggy")  or inst:HasTag("hamfogspeed") then
                inst.sg.statemem.goosegroggy = true
            else
                inst.sg.statemem.goose = true
            end
        elseif inst:HasTag("groggy") then
            inst.sg.statemem.groggy = true
        elseif inst:HasTag("hamfogspeed") then
            inst.sg.statemem.hamfog = true			
        else
            inst.sg.statemem.normal = true
        end
    elseif inst:GetStormLevel() >= TUNING.SANDSTORM_FULL_LEVEL and not inst.components.playervision:HasGoggleVision() then
        inst.sg.statemem.sandstorm = true
    elseif inst:HasTag("groggy") then
        inst.sg.statemem.groggy = true
    elseif inst:HasTag("hamfogspeed") then
        inst.sg.statemem.hamfog = true			
    elseif inst:IsCarefulWalking() then
        inst.sg.statemem.careful = true
    else
        inst.sg.statemem.normal = true
    end
end

local function GetRunStateAnim(inst)
    return (inst.sg.statemem.heavy and "heavy_walk")
        or (inst.sg.statemem.sandstorm and "sand_walk")
        or ((inst.sg.statemem.groggy or inst.sg.statemem.hamfog or inst.sg.statemem.moosegroggy or inst.sg.statemem.goosegroggy) and "idle_walk")
        or (inst.sg.statemem.careful and "careful_walk")
        or (inst.sg.statemem.ridingwoby and "run_woby")		
        or "run"
end

local boatrunstartcliente =
    GLOBAL.State {
    name = "run_start",
    tags = {"moving", "running", "canrotate", "autopredict", "sailing"},
    onenter = function(inst)
        ConfigureRunState(inst)
        inst.components.locomotor:RunForward()
        if inst:HasTag("aquatic") then
        if inst:HasTag("surf") then inst.AnimState:PlayAnimation("surf_pre") else if inst:HasTag("sail") then inst.AnimState:PlayAnimation("sail_pre") else inst.AnimState:PlayAnimation("row_pre") end end
        else inst.AnimState:PlayAnimation(GetRunStateAnim(inst) .. "_pre") end
        inst.sg.mem.footsteps = (inst.sg.statemem.goose or inst.sg.statemem.goosegroggy) and 4 or 0
        if inst:HasTag("aquatic") then
            inst.AnimState:AddOverrideBuild("player_actions_paddle")
--            if player_overrides[inst.prefab] then inst.AnimState:AddOverrideBuild(player_overrides[inst.prefab]) end
        end
    end,
    onupdate = function(inst)
        inst.components.locomotor:RunForward()
    end,
    timeline = {
            --mounted
            GLOBAL.TimeEvent(0, function(inst)
                if inst.sg.statemem.riding then
                    DoMountedFoleySounds(inst)
                end
            end),

            --heavy lifting
            GLOBAL.TimeEvent(1 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    GLOBAL.PlayFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end),

            --moose
            GLOBAL.TimeEvent(2 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    GLOBAL.PlayFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end),

            --unmounted
            GLOBAL.TimeEvent(4 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.normal then
                    GLOBAL.PlayFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end),

            --mounted
            GLOBAL.TimeEvent(5 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    GLOBAL.PlayFootstep(inst, nil, true)
                end
            end),

            --moose groggy
            GLOBAL.TimeEvent(7 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    PlayMooseFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end),
    },
    events = {
        GLOBAL.EventHandler(
            "animover",
            function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("run")
                end
            end
        )
    }
}
AddStategraphState("wilson_client", boatrunstartcliente)

local boatruncliente =
    GLOBAL.State {
    name = "run",
    tags = {"moving", "running", "canrotate", "sailing"},
    onenter = function(inst)
        ConfigureRunState(inst)
        inst.components.locomotor:RunForward()
		
--if inst:HasTag("wilbur") then 
--inst.AnimState:SetBank("wilbur_run") 
--inst.AnimState:SetBuild("wilbur_run")
--inst.Transform:SetSixFaced() 
--end

if inst:HasTag("aquatic") and inst.components.rowboatwakespawner then
inst.components.rowboatwakespawner:StartSpawning()

		local barco = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BARCO)
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "ironwind" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/boatpropellor_lp", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "sail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_cloth", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "clothsail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_cloth", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "snakeskinsail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_snakeskin", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "feathersail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_feather", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "woodlegssail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_sealegs", "sailmove" ) 
		end
        if barco and barco.replica.container and barco.replica.container:GetItemInSlot(1) and barco.replica.container:GetItemInSlot(1).prefab == "malbatrossail" then
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/sail_LP_sealegs", "sailmove" ) 
		end	

end

local anim = GetRunStateAnim(inst)
        if inst:HasTag("aquatic") then
			if inst.replica.inventory:IsHeavyLifting() then
				anim = "heavy_idle"
			elseif inst:HasTag("surf") then 
				anim = "surf_loop" 
			elseif inst:HasTag("sail") then 
				anim =  "sail_loop" 
			elseif inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "oar_driftwood" then
				anim = "row_medium"
			elseif inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "oar" then
				anim = "row_medium"
			else
				anim = "row_loop" 
			end
        elseif anim == "run" then
		if inst:HasTag("wilbur") and inst.timeinmotion and inst.timeinmotion > 75 and not inst.replica.rider:IsRiding() and not inst.replica.inventory:IsHeavyLifting() and not inst:IsCarefulWalking() then
		inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED + 2.5
		if inst.components.hunger then inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.33) end
		inst.Transform:SetSixFaced()
		inst.AnimState:SetBank("wilbur_run")
		inst.AnimState:SetBuild("wilbur_run")
		if inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
		inst.AnimState:Show("TAIL_carry")
		inst.AnimState:Hide("TAIL_normal")
		end			
		end			
		
            anim = "run_loop"
        elseif anim == "run_woby" then
            anim = "run_woby_loop"
        end
		
        if not inst.AnimState:IsCurrentAnimation(anim) then
            inst.AnimState:PlayAnimation(anim, true)
        end

        inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength() + .5 * GLOBAL.FRAMES)
    end,
    onupdate = function(inst)
        inst.components.locomotor:RunForward()
    end,
	
    timeline = {
            --unmounted
            GLOBAL.TimeEvent(7 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.normal then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(15 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.normal then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --careful
            --Frame 11 shared with heavy lifting below
            --[[TimeEvent(11 * FRAMES, function(inst)
                if inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            GLOBAL.TimeEvent(26 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --sandstorm
            --Frame 12 shared with groggy below
            --[[TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            GLOBAL.TimeEvent(23 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --groggy
            GLOBAL.TimeEvent(1 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.groggy or inst.sg.statemem.hamfog or
                    inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(12 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.groggy or inst.sg.statemem.hamfog or
                    inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --heavy lifting
            GLOBAL.TimeEvent(11 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy or
                    inst.sg.statemem.sandstorm or
                    inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                elseif inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(36 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy or
                    inst.sg.statemem.sandstorm or
                    inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --mounted
            GLOBAL.TimeEvent(0, function(inst)
                if inst.sg.statemem.riding then
                    DoMountedFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(5 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    DoRunSounds(inst)
                end
            end),

            --moose
            --Frame 11 shared with heavy lifting above
            --[[TimeEvent(11 * FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            GLOBAL.TimeEvent(24 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --moose groggy
            GLOBAL.TimeEvent(14 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(30 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --goose
            --Frame 1 shared with groggy above
            --[[TimeEvent(1 * FRAMES, function(inst)
                if inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            GLOBAL.TimeEvent(9 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --goose groggy
            GLOBAL.TimeEvent(4 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goosegroggy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            GLOBAL.TimeEvent(17 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goosegroggy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
    },
    events = {
            GLOBAL.EventHandler("gogglevision", function(inst, data)
                if data.enabled then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.iswere or
                            inst.sg.statemem.sandstorm or
                            inst:GetStormLevel() < TUNING.SANDSTORM_FULL_LEVEL) then
                    inst.sg:GoToState("run")
                end
            end),
            GLOBAL.EventHandler("sandstormlevel", function(inst, data)
                if data.level < TUNING.SANDSTORM_FULL_LEVEL then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.iswere or
                            inst.sg.statemem.sandstorm or
                            inst.components.playervision:HasGoggleVision()) then
                    inst.sg:GoToState("run")
                end
            end),
            GLOBAL.EventHandler("carefulwalking", function(inst, data)
                if not data.careful then
                    if inst.sg.statemem.careful then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.sandstorm or
                            inst.sg.statemem.groggy or
							inst.sg.statemem.hamfog or
                            inst.sg.statemem.careful or
                            inst.sg.statemem.iswere) then
                    inst.sg:GoToState("run")
                end
            end),
    },
	
        onexit = function(inst)	
		if inst:HasTag("wilbur") and not inst.replica.rider:IsRiding() and not inst.replica.inventory:IsHeavyLifting() and not inst:IsCarefulWalking() then
		inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED-0.5
		if inst.components.hunger then inst.components.hunger:SetRate(1*TUNING.WILSON_HUNGER_RATE) end
		inst.AnimState:SetBank("wilson")
		inst.AnimState:SetBuild(inst.prefab)
		inst.Transform:SetFourFaced()
		inst.AnimState:Hide("TAIL_carry")
		inst.AnimState:Show("TAIL_normal")
		end				
        end,	
	
    ontimeout = function(inst)
        inst.sg:GoToState("run")
    end
}
AddStategraphState("wilson_client", boatruncliente)

local boatrunstopcliente =
    GLOBAL.State {
    name = "run_stop",
    tags = {"canrotate", "idle", "sailing", "aparece"},
    onenter = function(inst)

        ConfigureRunState(inst)

        if inst:HasTag("aquatic") and inst.components.rowboatwakespawner then
            inst.components.rowboatwakespawner:StopSpawning()
			
			inst.SoundEmitter:KillSound("sailmove")
        end

        inst.components.locomotor:Stop()
        if inst:HasTag("aquatic") then
        if inst:HasTag("surf") then inst.AnimState:PlayAnimation("surf_pst") else if inst:HasTag("sail") then inst.AnimState:PlayAnimation("sail_pst") else inst.AnimState:PlayAnimation("row_pst") end end
        else inst.AnimState:PlayAnimation(GetRunStateAnim(inst) .. "_pst") 
		
		if inst.sg.statemem.moose or inst.sg.statemem.moosegroggy then
        PlayMooseFootstep(inst, .6, true)
        DoFoleySounds(inst)
        end
		
		end
    end,
	
        timeline =
        {
            GLOBAL.TimeEvent(GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.goose or inst.sg.statemem.goosegroggy then
                    GLOBAL.PlayFootstep(inst, .5, true)
                    DoFoleySounds(inst)
                end
            end),
        },	
	
    events = {
        GLOBAL.EventHandler(
            "animover",
            function(inst)
                if inst.AnimState:AnimDone() then
--              if inst:HasTag("aquatic") then
--                  inst.sg:GoToState("brake")
--               else
                    inst.sg:GoToState("idle") --end
                end
                
                if inst:HasTag("aquatic") then
                    inst.AnimState:ClearOverrideBuild("player_actions_paddle")
--					if player_overrides[inst.prefab] then inst.AnimState:ClearOverrideBuild(player_overrides[inst.prefab]) end
                end
            end
        )
    }
}
AddStategraphState("wilson_client", boatrunstopcliente)

local boatbrake =
    GLOBAL.State{
        name = "brake",
        tags = {"idle", "canrotate", "boating", "sailing", "aparece"},
        onenter = function(inst)
        end,
        
        onexit = function(inst)
            
        end,
        
    events = {
        GLOBAL.EventHandler(
            "animover",
            function(inst)
                if inst.AnimState:GetCurrentAnimationTime() > 3 then
                    inst.sg:GoToState("idle")
                end
            end
        )
    }       
    }

AddStategraphState("wilson_client", boatbrake)
AddStategraphState("wilson", boatbrake)

AddStategraphEvent("wilson", 
GLOBAL.EventHandler ("sneeze", 
        function (inst, data)
        if not inst.components.health:IsDead() and not inst.components.health.invincible then
            if inst.sg:HasStateTag("busy") and inst.sg.currentstate.name ~= "emote" then
                inst.wantstosneeze = true
            else
                inst.sg:GoToState("sneeze")
            end
        end
        end))

local sneeze =
    GLOBAL.State{
        name = "sneeze",
        tags = {"busy", "sneeze", "pausepredict" },
        
        onenter = function(inst)
            local usehit = inst.components.rider:IsRiding() or inst:HasTag("wereplayer")
            local stun_frames = usehit and 6 or 9
            inst.wantstosneeze = false
            inst:ClearBufferedAction()
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/wilson/hit",nil,.02)
			
			
			if inst.components.rider ~= nil and not inst.components.rider:IsRiding() then
				inst.AnimState:PlayAnimation("sneeze")
			end
			
			if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction(stun_frames <= 7 and stun_frames or nil)
            end
			
            
            if inst.prefab ~= "wes" then
				inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/sneeze")
				inst.components.talker:Say(STRINGS.CHARACTERS.GENERIC.ANNOUNCE_SNEEZE)  
            end        
        end,
        
        events=
        {
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        }, 
        
        timeline =
        {
            GLOBAL.TimeEvent(1*GLOBAL.FRAMES, function(inst)
local itemstodrop = 0 
if math.random() < 0.6 then itemstodrop = itemstodrop +1 end
if math.random() < 0.3 then itemstodrop = itemstodrop +1 end 
if math.random() < 0.2 then itemstodrop = itemstodrop +1 end 
if math.random() < 0.1 then itemstodrop = itemstodrop +1 end   

if itemstodrop > 0 then
for i=1, itemstodrop do	
if inst.components.inventory and inst.components.inventory.isopen then
local item = inst.components.inventory:FindItem(function(item) return not item:HasTag("nosteal") end)
if item then
local direction = Vector3(inst.Transform:GetWorldPosition()) - Vector3(inst.Transform:GetWorldPosition() )
inst.components.inventory:DropItem(item, false, direction:GetNormalized())
end
end				
end	
end						
            end),		
            GLOBAL.TimeEvent(10*GLOBAL.FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")		
				if inst.components.sanity then inst.components.sanity:DoDelta(-3) end
            end),
        },        
               
    }

AddStategraphState("wilson", sneeze)



local speargunstate =
    GLOBAL.State{
        name = "speargun",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("speargun")
            if inst.sg.prevstate == inst.sg.currentstate then
                inst.sg.statemem.chained = true
                inst.AnimState:SetTime(5 * GLOBAL.FRAMES)
            end

            inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * GLOBAL.FRAMES, inst.components.combat.min_attack_period + .5 * GLOBAL.FRAMES))

            if target ~= nil and target:IsValid() then
                inst:FacePoint(target.Transform:GetWorldPosition())
                inst.sg.statemem.attacktarget = target
            end

            if (equip ~= nil and equip.projectiledelay or 0) > 0 then
                --V2C: Projectiles don't show in the initial delayed GLOBAL.FRAMES so that
                --     when they do appear, they're already in front of the player.
                --     Start the attack early to keep animation in sync.
                inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * GLOBAL.FRAMES - equip.projectiledelay
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst.sg.statemem.projectiledelay = nil
                end
            end
        end,

        onupdate = function(inst, dt)
            if (inst.sg.statemem.projectiledelay or 0) > 0 then
                inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end
        end,

        timeline =
        {
            TimeEvent(8 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.chained then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
                end
            end),
            TimeEvent(9 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
			

			
            TimeEvent(15 * GLOBAL.FRAMES, function(inst)
                if not inst.sg.statemem.chained then
				
                if inst.components.combat:GetWeapon() and inst.components.combat:GetWeapon():HasTag("blunderbuss") then
                    inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/weapon/blunderbuss_shoot")
                    local cloud = SpawnPrefab("cloudpuff")
                    local pt = Vector3(inst.Transform:GetWorldPosition())
                    cloud.Transform:SetPosition(pt.x,2,pt.z)
                else
                    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/use_speargun")
                end					
				
                end
            end),
				
            TimeEvent(16 * GLOBAL.FRAMES, function(inst)
                if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            GLOBAL.EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            GLOBAL.EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            GLOBAL.EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
        end,
    }



local speargunstateclient =
    GLOBAL.    State
    {
        name = "speargun",
        tags = { "attack", "notalking", "abouttoattack" },

        onenter = function(inst)
            local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.locomotor:Stop()

            inst.AnimState:PlayAnimation("speargun")
            if inst.sg.prevstate == inst.sg.currentstate then
                inst.sg.statemem.chained = true
                inst.AnimState:SetTime(5 * FRAMES)
            end

            if inst.replica.combat ~= nil then
                inst.replica.combat:StartAttack()
                inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * FRAMES, inst.replica.combat:MinAttackPeriod() + .5 * FRAMES))
            end

            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil then
                inst:PerformPreviewBufferedAction()

                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:FacePoint(buffaction.target:GetPosition())
                    inst.sg.statemem.attacktarget = buffaction.target
                end
            end

            if (equip.projectiledelay or 0) > 0 then
                --V2C: Projectiles don't show in the initial delayed frames so that
                --     when they do appear, they're already in front of the player.
                --     Start the attack early to keep animation in sync.
                inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * FRAMES - equip.projectiledelay
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst.sg.statemem.projectiledelay = nil
                end
            end
        end,

        onupdate = function(inst, dt)
            if (inst.sg.statemem.projectiledelay or 0) > 0 then
                inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end
        end,

        timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
                if inst.sg.statemem.chained then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
                end
            end),
            TimeEvent(9 * FRAMES, function(inst)
                if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
			
			
			
            TimeEvent(15 * GLOBAL.FRAMES, function(inst)
                if not inst.sg.statemem.chained then
				
                if inst.replica.combat:GetWeapon() and inst.replica.combat:GetWeapon():HasTag("blunderbuss") then
                    inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/weapon/blunderbuss_shoot")
                    local cloud = SpawnPrefab("cloudpuff")
                    local pt = Vector3(inst.Transform:GetWorldPosition())
                    cloud.Transform:SetPosition(pt.x,2,pt.z)
                else
                    inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/use_speargun")
                end					
				
                end
            end),			
			
            TimeEvent(16 * FRAMES, function(inst)
                if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:ClearBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
            end
        end,
    }
	
AddStategraphState("wilson_client", speargunstateclient)
AddStategraphState("wilson", speargunstate)

local vagnerintro = GLOBAL.State({
    name = "sleep_dlc",
    
    onenter = function(inst)
if inst.prefab == "walani" or inst.prefab == "warly" or inst.prefab == "wilbur" or inst.prefab == "woodlegs" then
        inst.AnimState:PlayAnimation("sleep", true)
		else inst.AnimState:PlayAnimation("sleep_loop", true) end
        inst.components.playercontroller:Enable(false)
        inst.components.health:SetInvincible(true)
    end,

    onexit=function(inst)
        inst.components.health:SetInvincible(false)
        inst.components.playercontroller:Enable(true)
    end,



})

local vagnerintro2 = GLOBAL.State({
    name = "sleep_intro",
    onenter = function(inst) 
if inst.prefab == "walani" or inst.prefab == "warly" or inst.prefab == "wilbur" or inst.prefab == "woodlegs" then
        inst.AnimState:PlayAnimation("sleep", true)
		else inst.AnimState:PlayAnimation("sleep_loop", true) end
        inst.components.playercontroller:Enable(false)
        inst.components.health:SetInvincible(true)
    end,

    onexit=function(inst)
        inst.components.health:SetInvincible(false)
        inst.components.playercontroller:Enable(true)
    end,

})

AddStategraphState("wilson", vagnerintro)
AddStategraphState("wilson", vagnerintro2)
AddStategraphState("wilson_client", vagnerintro)
AddStategraphState("wilson_client", vagnerintro2)


local telescopio = GLOBAL.State{
        name = "peertelescope",
        tags = {"doing", "busy", "canrotate"},

        onenter = function(inst, data)
			local act
            inst.sg.statemem.action = inst:GetBufferedAction()	
            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil and buffaction.pos ~= nil then
			act = buffaction:GetActionPoint()
			end		
            inst:ForceFacePoint(act.x, act.y, act.z)
            inst.components.playercontroller:Enable(false)
            inst.AnimState:PlayAnimation("telescope", false)
            inst.AnimState:PushAnimation("telescope_pst", false)

            inst.components.locomotor:Stop()
        end,

        timeline = 
        {
            GLOBAL.TimeEvent(20*GLOBAL.FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/use_spyglass") end),
        },

        onexit = function(inst)
            inst.components.playercontroller:Enable(true)
        end,

        events = {
            GLOBAL.EventHandler("animover", function(inst)
                inst:PerformBufferedAction()
            end ),
            GLOBAL.EventHandler("animqueueover", function(inst)
                
--                local telescope = inst.sg.statemem.action.invobject or inst.sg.statemem.action.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
--                if telescope and telescope.components.finiteuses then
                    -- this is here because the telescope still needs to exist while playing the put away animation
                    --telescope.components.finiteuses:Use()
--                end

                inst.sg:GoToState("idle")

            end ),
        },
    }
	
AddStategraphState("wilson", telescopio)
AddStategraphState("wilson_client", telescopio)

local magica = GLOBAL.State{
        name = "quickcastspell",
        tags = { "doing", "busy", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            if inst.components.rider:IsRiding() then
                inst.AnimState:PlayAnimation("player_atk_pre")
                inst.AnimState:PushAnimation("player_atk", false)
            elseif inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS):HasTag("telescope") then
			inst.sg:GoToState("peertelescope")	
            else
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
            end
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
        end,

        timeline =
        {
            GLOBAL.TimeEvent(5 * GLOBAL.FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            GLOBAL.EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    }
	
local TIMEOUT = 2

local magica_client = GLOBAL.State
    {
        name = "quickcastspell",
        tags = { "doing", "busy", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            if inst.replica.rider ~= nil and inst.replica.rider:IsRiding() then
                inst.AnimState:PlayAnimation("player_atk_pre")
                inst.AnimState:PushAnimation("player_atk_lag", false)
            elseif inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) and inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS):HasTag("telescope") then
			inst.sg:GoToState("peertelescope")		
			else
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk_lag", false)
            end

            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(TIMEOUT)
        end,

        onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,

        ontimeout = function(inst)
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle")
        end,
    }

		
AddStategraphState("wilson", magica)
AddStategraphState("wilson_client", magica_client)

local macacorunstart = GLOBAL.State{
        name = "run_monkey_start",
        tags = {"moving", "running", "canrotate", "monkey", "sailing"},
        
        onenter = function(inst) 
            inst.Transform:SetSixFaced()
            inst.components.locomotor:RunForward()
            inst.AnimState:SetBank("wilbur_run")
            inst.AnimState:SetBuild("wilbur_run")
            inst.AnimState:PlayAnimation("run_pre")
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/characters/wilbur/walktorun", "walktorun")
        end,

        onexit = function(inst)
            inst.AnimState:SetBank("wilson")
            inst.AnimState:SetBuild(inst.prefab)
            inst.Transform:SetFourFaced()
        end,

        events=
        {   
            GLOBAL.EventHandler("animover", function(inst)
                inst.sg:GoToState("run_monkey")
            end ),
        },
    }	
	
local macacorun = GLOBAL.State{
        name = "run_monkey",
        tags = {"moving", "running", "canrotate", "monkey", "sailing"},
        
        onenter = function(inst) 
		    inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED + 2.5
if inst.components.hunger then inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.33) end

            inst.Transform:SetSixFaced()
            inst.components.locomotor:RunForward()
            inst.AnimState:SetBank("wilbur_run")
            inst.AnimState:SetBuild("wilbur_run")
            inst.AnimState:PlayAnimation("run_loop")
            
 if inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("TAIL_carry")
                inst.AnimState:Hide("TAIL_normal")
            end
        end,

        onexit = function(inst)
			inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED-0.5
if inst.components.hunger then inst.components.hunger:SetRate(1*TUNING.WILSON_HUNGER_RATE) end
            inst.AnimState:SetBank("wilson")
            inst.AnimState:SetBuild(inst.prefab)
            inst.Transform:SetFourFaced()
            inst.AnimState:Hide("TAIL_carry")
            inst.AnimState:Show("TAIL_normal")
        end,
        
        timeline = 
        {
            GLOBAL.TimeEvent(4*GLOBAL.FRAMES, function(inst) GLOBAL.PlayFootstep(inst, 0.5) end),
            GLOBAL.TimeEvent(5*GLOBAL.FRAMES, function(inst) GLOBAL.PlayFootstep(inst, 0.5) DoFoleySounds(inst) end),
            GLOBAL.TimeEvent(10*GLOBAL.FRAMES, function(inst) GLOBAL.PlayFootstep(inst, 0.5) end),
            GLOBAL.TimeEvent(11*GLOBAL.FRAMES, function(inst) GLOBAL.PlayFootstep(inst, 0.5) end),
        },

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,
       
        events=
        {
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("run_monkey") end),

            GLOBAL.EventHandler("equip", function(inst) 
                inst.AnimState:Show("TAIL_carry")
                inst.AnimState:Hide("TAIL_normal")
            end),

            GLOBAL.EventHandler("unequip", function(inst) 
                inst.AnimState:Hide("TAIL_carry")
                inst.AnimState:Show("TAIL_normal")
            end),
        },
    }

AddStategraphState("wilson", macacorunstart)
AddStategraphState("wilson", macacorun)
AddStategraphState("wilson_client", macacorunstart)
AddStategraphState("wilson_client", macacorun)

local JUMPIN = GLOBAL.Action({priority = 10, mount_valid = true})
JUMPIN.str = (GLOBAL.STRINGS.ACTIONS.JUMPIN)
JUMPIN.id = "JUMPIN"
JUMPIN.fn = function(act)
    if act.doer ~= nil and
        act.doer.sg ~= nil and
        act.doer.sg.currentstate.name == "jumpin_pre" then
        if act.target ~= nil and
            act.target.components.teleporter ~= nil and
            act.target.components.teleporter:IsActive() then
			if act.target:HasTag("hamletteleport") then
            act.doer.sg:GoToState("hamletteleport", { teleporter = act.target })
			else
            act.doer.sg:GoToState("jumpin", { teleporter = act.target })			
			end
            return true
        end
        act.doer.sg:GoToState("idle")
    end
end
AddAction(JUMPIN)

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local hamletteleport =
    GLOBAL.State{
        name = "hamletteleport",
        tags = { "doing", "busy", "canrotate", "nopredict", "nomorph" },

        onenter = function(inst, data)
            ToggleOffPhysics(inst)
            inst.components.locomotor:Stop()

            inst.sg.statemem.target = data.teleporter
            inst.sg.statemem.heavy = inst.components.inventory:IsHeavyLifting()

            if data.teleporter ~= nil and data.teleporter.components.teleporter ~= nil then
                data.teleporter.components.teleporter:RegisterTeleportee(inst)
            end

            inst.AnimState:PlayAnimation("idle")

            local pos = data ~= nil and data.teleporter and data.teleporter:GetPosition() or nil

            local MAX_JUMPIN_DIST = 0
            local MAX_JUMPIN_DIST_SQ = MAX_JUMPIN_DIST * MAX_JUMPIN_DIST
            local MAX_JUMPIN_SPEED = 0

            local dist
            if pos ~= nil then
                inst:ForceFacePoint(pos:Get())
                local distsq = inst:GetDistanceSqToPoint(pos:Get())
                if distsq <= .25 * .25 then
                    dist = 0
                    inst.sg.statemem.speed = 0
                elseif distsq >= MAX_JUMPIN_DIST_SQ then
                    dist = MAX_JUMPIN_DIST
                    inst.sg.statemem.speed = MAX_JUMPIN_SPEED
                else
                    dist = math.sqrt(distsq)
                    inst.sg.statemem.speed = MAX_JUMPIN_SPEED * dist / MAX_JUMPIN_DIST
                end
            else
                inst.sg.statemem.speed = 0
                dist = 0
            end

            inst.Physics:SetMotorVel(inst.sg.statemem.speed * .5, 0, 0)

            inst.sg.statemem.teleportarrivestate = "idle"
        end,

        timeline =
        {
            TimeEvent(.5 * GLOBAL.FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.speed * (inst.sg.statemem.heavy and .55 or .75), 0, 0)
            end),
            TimeEvent(1 * GLOBAL.FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.heavy and inst.sg.statemem.speed * .6 or inst.sg.statemem.speed, 0, 0)
            end),

            --Heavy lifting
            TimeEvent(12 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .5, 0, 0)
                end
            end),
            TimeEvent(13 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .4, 0, 0)
                end
            end),
            TimeEvent(14 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .3, 0, 0)
                end
            end),

            --Normal
            TimeEvent(15 * GLOBAL.FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:Stop()
                end

                -- this is just hacked in here to make the sound play BEFORE the player hits the wormhole
                if inst.sg.statemem.target ~= nil then
                    if inst.sg.statemem.target:IsValid() then
                        inst.sg.statemem.target:PushEvent("starttravelsound", inst)
                    else
                        inst.sg.statemem.target = nil
                    end
                end
            end),

            --Heavy lifting
            TimeEvent(20 * GLOBAL.FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:Stop()
                end
            end),
        },

        events =
        {
            GLOBAL.EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg.statemem.target ~= nil and
                        inst.sg.statemem.target:IsValid() and
                        inst.sg.statemem.target.components.teleporter ~= nil then
                        --Unregister first before actually teleporting
                        inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
                        if inst.sg.statemem.target.components.teleporter:Activate(inst) then
                            inst.sg.statemem.isteleporting = true
                            inst.components.health:SetInvincible(true)
                            if inst.components.playercontroller ~= nil then
                                inst.components.playercontroller:Enable(false)
                            end
                            inst:Hide()
                            inst.DynamicShadow:Enable(false)
                            return
                        end
                    end
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end

            if inst.sg.statemem.isteleporting then
                inst.components.health:SetInvincible(false)
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end
                inst:Show()
                inst.DynamicShadow:Enable(true)
            elseif inst.sg.statemem.target ~= nil
                and inst.sg.statemem.target:IsValid()
                and inst.sg.statemem.target.components.teleporter ~= nil then
                inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
            end
        end,
    }

AddStategraphState("wilson_client", hamletteleport)
AddStategraphState("wilson", hamletteleport)





AddStategraphState(
    "spider",
    GLOBAL.State {
        name = "jumper_attack",
        tags = {"attack", "canrotate", "busy", "spitting"},

        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	
			inst.sg.statemem.collisionmask = inst.Physics:GetCollisionMask()
			inst.Physics:SetCollisionMask(COLLISION.GROUND)
			if not GLOBAL.TheWorld.ismastersim then
			inst.Physics:SetLocalCollisionMask(COLLISION.GROUND)
			end	
	
            inst.AnimState:PlayAnimation("warrior_atk")
            inst.sg.statemem.target = target		
        end,

        onexit = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()
            inst.Physics:ClearLocalCollisionMask()
            if inst.sg.statemem.collisionmask ~= nil then
                inst.Physics:SetCollisionMask(inst.sg.statemem.collisionmask)
            end				
        end,

        timeline =
        {
            GLOBAL.TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spiderwarrior/attack_grunt") end),
            GLOBAL.TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spiderwarrior/Jump") end),
            GLOBAL.TimeEvent(8*FRAMES, function(inst)
local x1, y1, z1 = inst.sg.statemem.target.Transform:GetWorldPosition()	
local x2, y2, z2 = inst.Transform:GetWorldPosition()
inst:ForceFacePoint(x1, y1, z1)
local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
inst.Physics:SetMotorVel(dist * 2, 0, 0)	end),


            GLOBAL.TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/spiderwarrior/Attack") end),
            GLOBAL.TimeEvent(20*FRAMES,
                function(inst)
                    inst.Physics:ClearMotorVelOverride()
                    inst.components.locomotor:Stop()
                end),
        },

        events=
        {
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("taunt") end),
        }
}
)

AddStategraphState(
    "penguin",
    GLOBAL.State {
        name = "jumper_attack",
        tags = {"flight", "busy"},

        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	
			inst.sg.statemem.collisionmask = inst.Physics:GetCollisionMask()
			inst.Physics:SetCollisionMask(COLLISION.GROUND)
			if not GLOBAL.TheWorld.ismastersim then
			inst.Physics:SetLocalCollisionMask(COLLISION.GROUND)
			end	
	
            inst.AnimState:PlayAnimation("slide_loop", true)
            inst.sg.statemem.target = target		
        end,

        timeline =
        {
            GLOBAL.TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/pengull/jumpin") end),
            GLOBAL.TimeEvent(0*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/pengull/jumpin") end),
            GLOBAL.TimeEvent(8*FRAMES, function(inst)
local x1, y1, z1 = inst.sg.statemem.target.Transform:GetWorldPosition()	
local x2, y2, z2 = inst.Transform:GetWorldPosition()
inst:ForceFacePoint(x1, y1, z1)
local dist = math.sqrt((x1 - x2)*(x1 - x2) + (z1 - z2)*(z1 - z2))
inst.Physics:SetMotorVel(dist * 2, 0, 0)	end),


            GLOBAL.TimeEvent(9*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/pengull/jumpin") end),
            GLOBAL.TimeEvent(20*FRAMES,
                function(inst)
                    inst.Physics:ClearMotorVelOverride()
                    inst.components.locomotor:Stop()
                end),
            GLOBAL.TimeEvent(30*FRAMES, function(inst)

            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()
            inst.Physics:ClearLocalCollisionMask()
            if inst.sg.statemem.collisionmask ~= nil then
                inst.Physics:SetCollisionMask(inst.sg.statemem.collisionmask)
            end		


			
			inst.sg:GoToState("walk_start") 
			end),
				
        },
}
)

---------------------------------gorge zone-------------------------------------------
local _G = GLOBAL
_G.require("vector3")
local containers = _G.require("containers")
local cooking = _G.require("cooking")
local Vector3 = _G.Vector3

local function DefaultItemTestFn(container, item, slot)
    return (cooking.IsCookingIngredient(item.prefab) or item:HasTag("preparedfood") or item.prefab == "wetgoop") and not container.inst:HasTag("burnt")
end

local function SyrupItemTestFn(container, item, slot)
    return (item.prefab == "syrup" or item.prefab == "sap" or item.prefab == "wetgoop") and not container.inst:HasTag("burnt")
end

local cookertypes =
{
    large =
    {
        widget =
        {
            slotpos =
            {
                Vector3(0, 64 + 32 + 8 + 4, 0),
                Vector3(0, 32 + 4, 0),
                Vector3(0, -(32 + 4), 0),
                Vector3(0, -(64 + 32 + 8 + 4), 0),
            },
            animbank = "quagmire_ui_pot_1x4",
            animbuild = "quagmire_ui_pot_1x4",
            pos = Vector3(200, 0, 0),
            side_align_tip = 100,
        },
        acceptsstacks = false,
        type = "cooker",
        itemtestfn = DefaultItemTestFn,
    },
    small =
    {
        widget =
        {
            slotpos =
            {
                Vector3(0, 64 + 8, 0),
                Vector3(0, 0, 0),
                Vector3(0, -(64 + 8), 0),
            },
            animbank = "quagmire_ui_pot_1x3",
            animbuild = "quagmire_ui_pot_1x3",
            pos = Vector3(200, 0, 0),
            side_align_tip = 100,
        },
        acceptsstacks = false,
        type = "cooker",
        itemtestfn = DefaultItemTestFn,
    },
    pot_syrup =
    {
        widget =
        {
            slotpos =
            {
                Vector3(0, 64 + 8, 0),
                Vector3(0, 0, 0),
                Vector3(0, -(64 + 8), 0),
            },
            animbank = "quagmire_ui_pot_1x3",
            animbuild = "quagmire_ui_pot_1x3",
            pos = Vector3(200, 0, 0),
            side_align_tip = 100,
        },
        acceptsstacks = false,
        type = "cooker",
        itemtestfn = SyrupItemTestFn,
    },
}
cookertypes.casseroledish = cookertypes.large
cookertypes.casseroledish_small = cookertypes.small
cookertypes.pot = cookertypes.large
cookertypes.pot_small = cookertypes.small
cookertypes.grill = cookertypes.large
cookertypes.grill_small = cookertypes.small
cookertypes.firepit = cookertypes.large -- Hack

local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab, data)
    prefab = prefab or container.inst.prefab
    data = cookertypes[prefab] or data
    oldwidgetsetup(container, prefab, data)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- Meal

local MEAL = Action({priority=3, instant = false, mount_valid = true, rmb = true, distance = 1, canforce=true})
MEAL.id = "MEAL"
MEAL.str = "Meal"
MEAL.fn = function(act)
	if act.target ~= nil  and act.target.components.mealer ~= nil then
		act.target.components.mealer:StartMealing()
		return true
	end
end

AddAction(MEAL)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.MEAL, "doshortaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.MEAL, "doshortaction"))

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- Mealler

local function CreateMealerWidget()
	local params = {}
	
	
	params.mealingstone =
	{
    widget =
    {
        slotpos =
        {
            Vector3(0, 64 + 32 + 8 + 4, 0), 
            Vector3(0, 32 + 4, 0),
            Vector3(0, -(32 + 4), 0), 
            Vector3(0, -(64 + 32 + 8 + 4), 0),
        },
        animbank = "ui_cookpot_1x4",
        animbuild = "ui_cookpot_1x4",
        pos = Vector3(200, 0, 0),
        side_align_tip = 100,
        buttoninfo =
        {
            text = "Grind",
            position = Vector3(0, -165, 0),
        }
    },
    acceptsstacks = false,
    type = "cooker",
	}


	local containers = GLOBAL.require "containers"
	
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.mealingstone.widget.slotpos ~= nil and #params.mealingstone.widget.slotpos or 0)

	local old_widgetsetup = containers.widgetsetup
	
	function containers.widgetsetup(container, prefab, data)
		local pref = prefab or container.inst.prefab
		
		if pref == "mealingstone" then
			local t = params[pref]
			
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
			return old_widgetsetup(container, prefab, data)
		end
	end

	function params.mealingstone.widget.buttoninfo.fn(inst)
		if inst.components.container ~= nil then
			BufferedAction(inst.components.container.opener, inst, ACTIONS.MEAL):Do()
		elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
			SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.MEAL.code, inst, ACTIONS.MEAL.mod_name)
		end
	end
	
	function params.mealingstone.itemtestfn(container, item, slot)
		return (item:HasTag("mealable") and not container.inst:HasTag("pleasetakeitem")) or (container.inst:HasTag("pleasetakeitem") and (item:HasTag("mealproduct") or item.prefab == "ash" or item.prefab == "spice_salt" or item.prefab == "quagmire_spotspice_ground" or item.prefab == "quagmire_flour"))
	end
	
	function params.mealingstone.widget.buttoninfo.validfn(inst)
		return inst.replica.container ~= nil and not inst.replica.container:IsEmpty() and not inst:HasTag("pleasetakeitem")
	end
end

CreateMealerWidget()

-- Grill widget

local _G = GLOBAL
_G.require("vector3")
local containers = _G.require("containers")
local cooking = _G.require("cooking")
local Vector3 = _G.Vector3

local function DefaultItemTestFn(container, item, slot)
    return (cooking.IsCookingIngredient(item.prefab) or item:HasTag("preparedfood") or item.prefab == "wetgoop") and not container.inst:HasTag("burnt")
end

local function SyrupItemTestFn(container, item, slot)
    return (item.prefab == "syrup" or item.prefab == "sap" or item.prefab == "wetgoop") and not container.inst:HasTag("burnt")
end

local cookertypes =
{
    large =
    {
        widget =
        {
            slotpos =
            {
                Vector3(0, 64 + 32 + 8 + 4, 0),
                Vector3(0, 32 + 4, 0),
                Vector3(0, -(32 + 4), 0),
                Vector3(0, -(64 + 32 + 8 + 4), 0),
            },
            animbank = "quagmire_ui_pot_1x4",
            animbuild = "quagmire_ui_pot_1x4",
            pos = Vector3(200, 0, 0),
            side_align_tip = 100,
        },
        acceptsstacks = false,
        type = "cooker",
        itemtestfn = DefaultItemTestFn,
    },
    small =
    {
        widget =
        {
            slotpos =
            {
                Vector3(0, 64 + 8, 0),
                Vector3(0, 0, 0),
                Vector3(0, -(64 + 8), 0),
            },
            animbank = "quagmire_ui_pot_1x3",
            animbuild = "quagmire_ui_pot_1x3",
            pos = Vector3(200, 0, 0),
            side_align_tip = 100,
        },
        acceptsstacks = false,
        type = "cooker",
        itemtestfn = DefaultItemTestFn,
    },
    pot_syrup =
    {
        widget =
        {
            slotpos =
            {
                Vector3(0, 64 + 8, 0),
                Vector3(0, 0, 0),
                Vector3(0, -(64 + 8), 0),
            },
            animbank = "quagmire_ui_pot_1x3",
            animbuild = "quagmire_ui_pot_1x3",
            pos = Vector3(200, 0, 0),
            side_align_tip = 100,
        },
        acceptsstacks = false,
        type = "cooker",
        itemtestfn = SyrupItemTestFn,
    },
}
cookertypes.casseroledish = cookertypes.large
cookertypes.casseroledish_small = cookertypes.small
cookertypes.pot = cookertypes.large
cookertypes.pot_small = cookertypes.small
cookertypes.grill = cookertypes.large
cookertypes.grill_small = cookertypes.small
cookertypes.firepit = cookertypes.large -- Hack

local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab, data)
    prefab = prefab or container.inst.prefab
    data = cookertypes[prefab] or data
    oldwidgetsetup(container, prefab, data)
end

-------------------------------------------------------------------------------cook pot-----------------------------------------------------------------
local cookers =
{
	grill = {"grill", "grill_small"},
	oven = {"oven"},
	pot = {"pot"},
}

local function AddCookerRecipeForCookers(recipe, data, cookers)
	for _,cookerprefabs in pairs(cookers) do
		for _,cookerprefab in ipairs(cookerprefabs) do
			AddCookerRecipe(cookerprefab, data)
		end
	end
end

function UpdateCookingIngredientTags(names, newtags)
	for _, name in ipairs(names) do
		print(name)
		for tag, value in pairs(newtags) do
			cooking.ingredients[name].tags[tag] = value
			if cooking.ingredients[name .. "_cooked"] ~= nil then
				cooking.ingredients[name .. "_cooked"].tags[tag] = value
			end
		end
	end
end

AddIngredientValues({"quagmire_spotspice_ground"}, {spice=1}, true, false)
AddIngredientValues({"syrup"}, {sweetener=2}, true, false)
--AddIngredientValues({"crabmeat"}, {fish=0.5, crab=1}, true, false)
--AddIngredientValues({"tomato", "potato", "turnip", "garlic", "onion"}, {veggie=1}, true, false)
AddIngredientValues({"quagmire_flour"}, {flour=1}, true, false)
AddIngredientValues({"rocks"}, {rocks=1}, true, false)
AddIngredientValues({"sap"}, {}, true, false)
AddIngredientValues({"quagmire_goatmilk"}, {dairy=1}, true, false)
UpdateCookingIngredientTags({"red_cap", "green_cap", "blue_cap"}, {mushroom=1})
UpdateCookingIngredientTags({"smallmeat", "smallmeat_dried", "drumstick", "froglegs"}, {smallmeat=1})
UpdateCookingIngredientTags({"meat", "monstermeat"}, {bigmeat=1})

AddCookerRecipe(
	"pot",
	{
		name = "syrup",
		test = function(cooker, names, tags)
			return names.sap and names.sap >= 3
		end,
		priority = 1,
		weight = 1,
		foodtype = "GENERIC",
		health = 10,
		hunger = 5,
		sanity = 10,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 2,
		tags = {},
	}
)

local preparedFoods = GLOBAL.require("gorge_foods")

AddCookerRecipeForCookers(
	"wetgoop",
	{
		name = "wetgoop",
		test = function(cooker, names, tags)
			return true
		end,
		priority = -1,
		weight = 1,
		foodtype = "GENERIC",
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 2,
		health = 0,
		hunger = 0,
		sanity = 0,
		perishtime = TUNING.PERISH_SLOW,
		cookers = {"grill", "oven", "pot", "pot_syrup"},
		tags = {},
	},
	cookers
)

local GNAW_REWARDS = {}

for k,v in pairs(preparedFoods) do
	GNAW_REWARDS[k] = v.reward
	if v.cookers then
		for i,cookertype in ipairs(v.cookers) do
			for i, cookerprefab in ipairs(cookers[cookertype] or {}) do
				AddCookerRecipe(cookerprefab, v)
			end
		end
	else
		AddCookerRecipe("cookpot", v)
	end
end

_G.GNAW_REWARDS = GNAW_REWARDS

AddAction(
	"INSTALL",
	"Install",
	function(act)
	    if act.invobject ~= nil and act.target ~= nil then
			if act.invobject.components.installable ~= nil
				and act.target.components.installations ~= nil
                and act.target.components.installations:CanInstall(act.invobject.components.installable.prefab)
	            and act.invobject.components.installable:DoInstall(act.target) then
		            act.invobject:Remove()
		            return true
	        end
	    end
	end
)

AddAction(
	"GIVE_DISH",
	"Put",
	function(act)
		if act.target ~= nil and act.target.components.specialstewer then
			if act.target.dish == nil and act.invobject.components.specialstewer_dish then
				if act.invobject.components.specialstewer_dish:IsDishType(act.target.components.specialstewer.cookertype) then
					act.target:SetDish(act.doer, act.invobject)
					return true
				end
			end
		end
	end
)

AddAction(
	"SNACKRIFICE",
	"Snackrifice",
	function(act)
		local snackrificer = act.target.components.snackrificer
		if snackrificer then
			snackrificer:Snackrifice(act.doer, act.invobject)
			return true
		end
	end
)

AddAction(
	"REPLATE",
	"Replate",
	function(act)
		local replatable = act.target and act.target.components.replatable or nil
		if act.invobject and replatable and replatable:CanReplate(act.invobject) then
			replatable:Replate(act.invobject)
			act.invobject.components.stackable:Get(1):Remove()
			return true
		end
	end
)

local SETUPITEM = GLOBAL.Action({priority = 3, rmb = true, distance = 3, mount_valid = false})
SETUPITEM.str = (GLOBAL.STRINGS.ACTIONS.SETUPITEM)
SETUPITEM.id = "SETUPITEM"
SETUPITEM.fn = function(act)
		if act.target and act.target.components.setupable and act.invobject then
			if act.target.components.setupable:IsSetup() then
				return false
			else
				act.target.components.setupable:Setup(act.invobject)
			
				return true
			end
		end
end
SETUPITEM.encumbered_valid =true
AddAction(SETUPITEM)	
	
local TAPSUGARTREE = GLOBAL.Action({priority = 3, rmb = true, distance = 1, mount_valid = false})
TAPSUGARTREE.str = (GLOBAL.STRINGS.ACTIONS.TAPSUGARTREE)
TAPSUGARTREE.id = "TAPSUGARTREE"
TAPSUGARTREE.fn = function(act)
		if act.target and act.invobject and act.target.components.sappy then
			act.target.components.sappy:Tap(act.invobject)
			
			return true
		end
end
TAPSUGARTREE.encumbered_valid =true
AddAction(TAPSUGARTREE)	

local COLLECTSAP = GLOBAL.Action({priority = 3, rmb = true, distance = 1, mount_valid = false})
COLLECTSAP.str = (GLOBAL.STRINGS.ACTIONS.COLLECTSAP)
COLLECTSAP.id = "COLLECTSAP"
COLLECTSAP.fn = function(act)
		if act.target and act.target.components.sappy then
			act.target.components.sappy:CollectSap(act.doer)
			act.target:RemoveTag("sappy")
			return true
		end
end
COLLECTSAP.encumbered_valid =true
AddAction(COLLECTSAP)		

-- Slaughtertool

AddAction(
	"KILLSOFTLY",
	GLOBAL.STRINGS.ACTIONS.SLAUGHTER,
	function(act)
		if act.target and act.target.components.health and act.target.components.lootdropper then
			act.target.components.health.invincible = false
			if act.doer.prefab == "wigfrid" then
				act.target.components.lootdropper:DropLoot()
			end
			
			if act.invobject ~= nil and act.invobject.components.finiteuses then
			act.invobject.components.finiteuses:Use(1)
			end					
			if act.doer.prefab == "wigfrid" then
				act.target.components.lootdropper:DropLoot()
			end		
			act.target.components.health:Kill()
			
			return true
		end
	end)
	
ACTIONS.KILLSOFTLY.stroverridefn = function(act)
    return act.invobject ~= nil
        and act.invobject.GetSlaughterActionString ~= nil
        and act.invobject:GetSlaughterActionString(act.target)
        or nil
end

ACTIONS.KILLSOFTLY.distance = 2
ACTIONS.KILLSOFTLY.priority = 3


AddComponentAction("USEITEM", "sapbucket", function(inst, doer, target, actions, right)
	if target:HasTag("tappable") and not target:HasTag("tapped") and not target:HasTag("stump") then
		table.insert(actions, ACTIONS.TAPSUGARTREE)
	end
end)

AddComponentAction("SCENE", "sappy", function(inst, doer, actions, right)
	if inst:HasTag("sappy") and not inst:HasTag("stump") then
		table.insert(actions, ACTIONS.COLLECTSAP)
	end
end)







AddComponentPostInit("fueled", function(self)


function self:CanAcceptFuelItem(item)

if self.fueltype == "TAR" and item:HasTag("tar") then return true end
    return self.accepting and item and item.components.fuel and (item.components.fuel.fueltype == self.fueltype or item.components.fuel.fueltype == self.secondaryfueltype)
end


end)


AddComponentAction("USEITEM", "fueltar", function(inst, doer, target, actions)
if not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding())
                or (target.replica.inventoryitem ~= nil and target.replica.inventoryitem:IsGrandOwner(doer)) then

if target:HasTag("seayard") then
table.insert(actions, ACTIONS.ADDFUEL)
end

end
end)

AddComponentAction("USEITEM", "setupable", function(inst, doer, target, actions, right)
	if inst:HasTag("honeyed") and target:HasTag("honeyproducer") then
		table.insert(actions, ACTIONS.SETUPITEM)
	elseif inst:HasTag("salty") and target:HasTag("saltwater") then
		table.insert(actions, ACTIONS.SETUPITEM)
	end
end)

AddComponentAction("USEITEM", "slaughtertool", function(inst, doer, target, actions, right)
	if target:HasTag("canbeslaughtered") then
		table.insert(actions, ACTIONS.KILLSOFTLY)
	end
end)

AddComponentAction(
	"USEITEM",
	"snackrificable",
	function(inst, doer, target, actions)
		if target:HasTag("gorge_altar") then
			table.insert(actions, GLOBAL.ACTIONS.SNACKRIFICE)
		end
	end
)

AddComponentAction(
	"USEITEM",
	"replater",
	function(inst, doer, target, actions)
		if target:HasTag("replatable") then
			table.insert(actions, GLOBAL.ACTIONS.REPLATE)
		end
	end
)

AddComponentAction(
	"USEITEM",
	"installable",
	function(inst, doer, target, actions)
        if target:HasTag("installations") and not target:HasTag("installations_occupied") then
            table.insert(actions, GLOBAL.ACTIONS.INSTALL)
        end
    end
)

AddComponentAction(
	"USEITEM",
	"specialstewer_dish",
	function(inst, doer, target, actions)
        if inst:HasTag("quagmire_casseroledish") and target:HasTag("oven") and target:HasTag("specialstewer_dishtaker") then
            table.insert(actions, GLOBAL.ACTIONS.GIVE_DISH)
        end
		
		
        if inst:HasTag("quagmire_pot") and target:HasTag("pot_hanger") and target:HasTag("specialstewer_dishtaker")then
            table.insert(actions, GLOBAL.ACTIONS.GIVE_DISH)
        end		
		
    end	
)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TAPSUGARTREE,	
	function(inst, action)
		return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.TAPSUGARTREE,	
	function(inst, action)
		return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.COLLECTSAP,         
	function(inst, action)
		return inst:HasTag("fastpicker") and "doshortaction" or inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.COLLECTSAP,         
	function(inst, action)
		return inst:HasTag("fastpicker") and "doshortaction" or inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))
	
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.SETUPITEM,	
	function(inst, action)
		return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.SETUPITEM,	
	function(inst, action)
		return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))	
	
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.KILLSOFTLY,	
	function(inst, action)
		return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.KILLSOFTLY,	
	function(inst, action)
		return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
	end))
	
AddStategraphActionHandler(
    "wilson",
    ActionHandler(ACTIONS.GIVE_DISH, "give")
)

AddStategraphActionHandler(
    "wilson",
    ActionHandler(ACTIONS.SNACKRIFICE, "give")
)

AddStategraphActionHandler(
    "wilson_client",
    ActionHandler(ACTIONS.GIVE_DISH, "give")
)

AddStategraphActionHandler(
    "wilson_client",
    ActionHandler(ACTIONS.SNACKRIFICE, "give")
)

RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "bread.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "gorge_meatballs.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "meat_skewers.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "stone_soup.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "croquette.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "roasted_veggies.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "meatloaf.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "carrot_soup.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "fish_pie.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "fish_and_chips.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "meat_pie.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "chips.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "slider.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "gorge_jam.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "jelly_roll.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "carrot_cake.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "mashed_potatoes.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "garlic_bread.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "tomato_soup.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "sausage.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "candied_fish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "stuffed_mushroom.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "veggie_soup.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "gorge_ratatouille.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "bruschetta.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "meat_stew.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "hamburger.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "fish_burger.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "mushroom_burger.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "fish_steak.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "curry.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "spaghetti_and_meatballs.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "lasagna.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "jelly_sandwich.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "poached_fish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "shepherds_pie.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "candy.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "pudding.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "waffles.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "berry_tart.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "mac_n_cheese.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "bagel_n_fish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "grilled_cheese.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "cream_of_mushroom.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "fish_stew.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "pierogies.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "manicotti.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "cheeseburger.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "fettuccine.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "onion_soup.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "breaded_cutlet.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "creamy_fish.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "pizza.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "pot_roast.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "crab_cake.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "turnip_cake.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "steak_frites.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "shooter_sandwich.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "bacon_wrapped_meat.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "crab_roll.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "meat_wellington.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "crab_ravioli.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "caramel_cube.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "scone.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "trifle.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "cheesecake.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "potato_pancakes.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "potato_soup.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "fishball_skewers.tex")
	
	
	
	
	
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "quagmire_spotspice_ground.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "syrup.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "flour.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "sap.tex")
RegisterInventoryItemAtlas("images/inventoryimages/quagmirefoods.xml", "quagmire_goatmilk.tex")
	
	
	
	
	
	
	

AddPrefabPostInit("saltrock", function(inst)
	if GLOBAL.TheWorld.ismastersim then
	inst:AddComponent("mealable")
	inst.components.mealable:SetType("salt")	
	end
end)

AddPrefabPostInit("spice_salt", function(inst)
	inst:AddTag("salty")
end)



--[[ para personagens
inst:ListenForEvent("entity_death", function(wrld, data)
if data.cause == inst.prefab then
					
end
         
end, GetWorld())

]]

