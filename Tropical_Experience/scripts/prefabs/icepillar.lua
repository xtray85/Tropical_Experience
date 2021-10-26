local function makeassetlist(name)
    return {
        Asset("ANIM", "anim/"..name..".zip")
    }
end

local function makefn(name, collide)
    return function()
    	local inst = CreateEntity()

    	inst.entity:AddTransform()
    	inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        if collide then
            MakeObstaclePhysics(inst, 2.35)
        end

        inst.AnimState:SetBank("pillar_cave_rock")
        inst.AnimState:SetBuild("frostpillar_rock")
        inst.AnimState:PlayAnimation("idle", true)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        return inst
    end
end

local function pillar(name, collide)
    return Prefab(name, makefn(name, collide), makeassetlist(name))
end

return pillar("frostpillar_rock", true)
