--if GLOBAL.KnownModIndex:IsModEnabled("1306918089") then
    AddRecipe("mod_cleaner", 
        { Ingredient("houndstooth", 10), Ingredient("glommerfuel", 1) }, 
        GLOBAL.RECIPETABS.MAGIC, 
        GLOBAL.TECH.MAGIC_TWO,
        nil,nil,nil,nil,nil,
        "images/magic_duct_tape.xml", 
        "magic_duct_tape.tex"
    )
--end

AddRecipe("city_lamp",
    {Ingredient("alloy", 1, "images/inventoryimages/hamletinventory.xml"), Ingredient("transistor", 1),
     Ingredient("lantern", 1)}, GLOBAL.RECIPETABS.LIGHT, GLOBAL.TECH.SCIENCE_TWO, "city_lamp_placer", nil, true, nil, nil,
    "images/inventoryimages/hamletinventory.xml", "city_lamp.tex")
