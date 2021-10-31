if GLOBAL.KnownModIndex:IsModEnabled("workshop-1306918089") then
    AddRecipe("mod_cleaner", 
        { Ingredient("houndstooth", 10), Ingredient("glommerfuel", 1) }, 
        GLOBAL.RECIPETABS.MAGIC, 
        GLOBAL.TECH.MAGIC_TWO,
        nil,nil,nil,nil,nil,
        "images/magic_duct_tape.xml", 
        "magic_duct_tape.tex"
    )
end