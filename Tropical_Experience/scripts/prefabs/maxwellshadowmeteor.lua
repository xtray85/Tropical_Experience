require "regrowthutil"

local assets =
{
    Asset("ANIM", "anim/meteor.zip"),
    Asset("ANIM", "anim/warning_shadow.zip"),
    Asset("ANIM", "anim/meteor_shadow.zip"),
}

local prefabs =
{
    "meteorwarning",
    "burntground",
    "splash_ocean",
    "ground_chunks_breaking",
    "rock_moon",
    "rocks",
    "flint",
    "moonrocknugget",
    "rock_flintless",
    "rock_flintless_med",
    "rock_flintless_low",
    "rock1",
}

local SMASHABLE_WORK_ACTIONS =
{
    CHOP = true,
    DIG = true,
    HAMMER = true,
    MINE = true,
}
local SMASHABLE_TAGS = { "_combat", "_inventoryitem", "campfire" }
for k, v in pairs(SMASHABLE_WORK_ACTIONS) do
    table.insert(SMASHABLE_TAGS, k.."_workable")
end
local NON_SMASHABLE_TAGS = { "INLIMBO", "playerghost" }

local DENSITY = 0.1 -- the approximate density of rock prefabs in the rocky biomes
local FIVERADIUS = CalculateFiveRadius(DENSITY)
local EXCLUDE_RADIUS = 3

local function onexplode(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/meteor_impact")

    if inst.warnshadow ~= nil then
        inst.warnshadow:Remove()
        inst.warnshadow = nil
    end

    local shakeduration = .7 * inst.size
    local shakespeed = .02 * inst.size
    local shakescale = .5 * inst.size
    local shakemaxdist = 40 * inst.size
    ShakeAllCameras(CAMERASHAKE.FULL, shakeduration, shakespeed, shakescale, inst, shakemaxdist)

    local x, y, z = inst.Transform:GetWorldPosition()

    if not inst:IsOnValidGround() then
        local splash = SpawnPrefab("splash_ocean")
        if splash ~= nil then
            splash.Transform:SetPosition(x, y, z)
        end
    else
 --[[       local scorch = SpawnPrefab("burntground")
        if scorch ~= nil then
            scorch.Transform:SetPosition(x, y, z)
            local scale = inst.size * 1.3
            scorch.Transform:SetScale(scale, scale, scale)
        end

]]
        local launched = {}
        local ents = TheSim:FindEntities(x, y, z, inst.size * TUNING.METEOR_RADIUS, nil, NON_SMASHABLE_TAGS, SMASHABLE_TAGS)
        for i, v in ipairs(ents) do
            --V2C: things "could" go invalid if something earlier in the list
            --     removes something later in the list.
            --     another problem is containers, occupiables, traps, etc.
            --     inconsistent behaviour with what happens to their contents
            --     also, make sure stuff in backpacks won't just get removed
            --     also, don't dig up spawners
            if v:IsValid() and not v:IsInLimbo() then
                if v.components.workable ~= nil then
                    if v.components.workable:CanBeWorked() and not (v.sg ~= nil and v.sg:HasStateTag("busy")) then
                        local work_action = v.components.workable:GetWorkAction()
                        --V2C: nil action for campfires
                        if (work_action == nil or SMASHABLE_WORK_ACTIONS[work_action.id]) and
                            (work_action ~= ACTIONS.DIG
                            or (v.components.spawner == nil and
                                v.components.childspawner == nil)) then
                            v.components.workable:WorkedBy(inst, inst.workdone or 20)
                        end
                    end
                elseif v.components.combat ~= nil then
                    v.components.combat:GetAttacked(inst, inst.size * TUNING.METEOR_DAMAGE, nil)
                elseif v.components.inventoryitem ~= nil then
                    if v.components.container ~= nil then
                        -- Spill backpack contents, but don't destroy backpack
                        if math.random() <= TUNING.METEOR_SMASH_INVITEM_CHANCE then
                            v.components.container:DropEverything()
                        end
                        Launch(v, inst, TUNING.LAUNCH_SPEED_SMALL)
                        launched[v] = true
                    elseif v.components.mine ~= nil and not v.components.mine.inactive then
                        -- Always smash things on the periphery so that we don't end up with a ring of flung loot
                        v.components.mine:Deactivate()
                        Launch(v, inst, TUNING.LAUNCH_SPEED_SMALL)
                        launched[v] = true
                    elseif (inst.peripheral or math.random() <= TUNING.METEOR_SMASH_INVITEM_CHANCE)
                        and not v:HasTag("irreplaceable") then
                        -- Always smash things on the periphery so that we don't end up with a ring of flung loot
                        local vx, vy, vz = v.Transform:GetWorldPosition()
                        SpawnPrefab("ground_chunks_breaking").Transform:SetPosition(vx, 0, vz)
                        v:Remove()
                    else
                        Launch(v, inst, TUNING.LAUNCH_SPEED_SMALL)
                        launched[v] = true
                    end
                end
            end
        end

       
        end
    end

local function dostrike(inst)
    inst.striketask = nil
    inst.AnimState:PlayAnimation("crash")
    inst:DoTaskInTime(0.33, onexplode)
    inst:ListenForEvent("animover", inst.Remove)
    -- animover isn't triggered when the entity is asleep, so just in case
    inst:DoTaskInTime(3, inst.Remove)
end

local warntime = 1
local sizes = 
{ 
    small = .7,
    medium = 1,
    large = 1.3,
}
local work =
{
    small = 1,
    medium = 2,
    large = 20,
}

local function SetPeripheral(inst, peripheral)
    inst.peripheral = peripheral
end

local function SetSize(inst, sz, mod)
    if inst.autosizetask ~= nil then
        inst.autosizetask:Cancel()
        inst.autosizetask = nil
    end
    if inst.striketask ~= nil then
        return
    end

    if sizes[sz] == nil then
        sz = "small"
    end

    inst.size = sizes[sz]
    inst.workdone = work[sz]
    inst.warnshadow = SpawnPrefab("meteorwarning")

    if mod == nil then
        mod = 1
    end

    if sz == "medium" then
        inst.loot =
        {
            { prefab = "rocks", chance = TUNING.METEOR_CHANCE_INVITEM_OFTEN * mod },
            { prefab = "rocks", chance = TUNING.METEOR_CHANCE_INVITEM_RARE * mod },
            { prefab = "flint", chance = TUNING.METEOR_CHANCE_INVITEM_ALWAYS * mod },
            { prefab = "flint", chance = TUNING.METEOR_CHANCE_INVITEM_VERYRARE * mod },
            { prefab = "moonrocknugget", chance = TUNING.METEOR_CHANCE_INVITEM_SOMETIMES * mod },
        }
    elseif sz == "large" then
        local rand = math.random()
        if rand <= TUNING.METEOR_CHANCE_BOULDERMOON * mod then
            inst.loot =
            {
                {
                    prefab = "rock_moon",
                    chance = 1,
                },
            }
        elseif rand <= TUNING.METEOR_CHANCE_BOULDERFLINTLESS * mod then
            rand = math.random() -- Randomize which flintless rock we use
            inst.loot =
            {
                {
                    prefab =
                        (rand <= .33 and "rock_flintless") or
                        (rand <= .67 and "rock_flintless_med") or
                        "rock_flintless_low",
                    chance = 1,
                },
            }
        else -- Don't check for chance or mod this one: we need to pick a boulder
            inst.loot =
            {
	            { 
                    prefab = "moonrocknugget",
                    chance = TUNING.METEOR_CHANCE_INVITEM_SOMETIMES * mod
                },
                {
                    prefab = "rock1",
                    chance = 1,
                },
            }
        end
    else -- "small" or other undefined
        inst.loot = {}
    end

    inst.Transform:SetScale(inst.size, inst.size, inst.size)
    inst.warnshadow.Transform:SetScale(inst.size, inst.size, inst.size)

    -- Now that we've been set to the appropriate size, go for the gusto
    inst.striketask = inst:DoTaskInTime(warntime, dostrike)

    inst.warnshadow.entity:SetParent(inst.entity)
    inst.warnshadow.startfn(inst.warnshadow, warntime, .33, 1)
end

local function AutoSize(inst)
    inst.autosizetask = nil
    local rand = math.random()
    inst:SetSize(rand <= .33 and "large" or (rand <= .67 and "medium" or "small"))
end

local function fn() 
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    inst.Transform:SetTwoFaced()

    inst.AnimState:SetBank("meteor")
    inst.AnimState:SetBuild("meteor")

    inst:AddTag("NOCLICK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.Transform:SetRotation(math.random(360))
    inst.SetSize = SetSize
    inst.SetPeripheral = SetPeripheral
    inst.striketask = nil

    -- For spawning these things in ways other than from meteor showers (failsafe set a size after delay)
    inst.autosizetask = inst:DoTaskInTime(0, AutoSize)

    inst.persists = false

    return inst
end

return Prefab("maxwellshadowmeteor", fn, assets, prefabs)
