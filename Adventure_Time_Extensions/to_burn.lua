local tiny = TUNING.TINY_FUEL
local small = TUNING.SMALL_FUEL
local med = TUNING.MED_FUEL
local large = TUNING.LARGE_FUEL

local tool_list = {
    {"houndstooth", tiny},
    {"stinger",tiny}
}

for k, info in pairs(tool_list) do
	AddPrefabPostInit(info[1], function(inst)
		if not inst.components.fuel then --just in case some of these are already fuels, or are changed in the future
			inst:AddComponent("fuel")
			inst.components.fuel.fuelvalue = info[2]
		end
	end)
end
